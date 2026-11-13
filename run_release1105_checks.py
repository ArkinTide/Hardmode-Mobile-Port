"""Run real VM tests silently, with one immutable VM and private desktops.

The default is sequential. --jobs 2 runs ordinary cases on two independent
private desktops after CPU measurements finish alone. No desktop is activated.
"""
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime, timezone
from pathlib import Path
import argparse
import ctypes
import hashlib
import json
import os
import queue
import re
import stat
import struct
import subprocess
import threading
import time

from vm_test_lock import lock_vm
import test_volume

ROOT = Path(__file__).resolve().parent
RUNNER = Path('C:/ProgramData/GameMakerStudio2-LTS2026/Cache/runtimes/runtime-2026.0.0.23/windows/x64/Runner.exe')
ERROR_MARKERS = ('HARDMODE GAMEPLAY FAILED', 'ERROR!!!', 'FATAL ERROR', 'Stack Overflow detected!!!')
# These modes emit paired CPU measurements and must not overlap another VM.
PROFILE_MODES = {'profile106', 'sync115water', 'sync115waterprofile', 'sync115shield', 'sync114gator'}
PRINT_LOCK = threading.Lock()


def emit(result):
    with PRINT_LOCK:
        print(json.dumps(result), flush=True)


def scenario_name(scenario):
    name = scenario.replace(',', '-').replace(':', '-')
    if not name or name in ('.', '..') or not re.fullmatch(r'[A-Za-z0-9_. -]+', name):
        raise ValueError('Unsafe scenario folder: ' + repr(scenario))
    return name


def measured(scenario):
    fields = scenario.split(',')
    return len(fields) >= 7 and fields[6] in PROFILE_MODES


def prepare_state(out, scenario, run_id):
    name = scenario_name(scenario)
    state = out / name
    assert state.resolve().is_relative_to(out.resolve())
    if state.exists():
        # Scenarios/folder names are unique before any workers start.
        previous = ROOT / 'release1105/previous-attempts'
        prior = previous / run_id / name
        assert prior.resolve().is_relative_to(previous.resolve())
        prior.parent.mkdir(parents=True, exist_ok=True)
        state.rename(prior)
    state.mkdir()
    return state


def make_silent_vm(vm, silent):
    original = vm.read_bytes()
    digest = hashlib.sha256(original).hexdigest()
    data = bytearray(original)
    at, muted = 8, 0
    while at < len(data):
        tag, size = struct.unpack_from('<4sI', data, at)
        if tag == b'SOND':
            count = struct.unpack_from('<I', data, at + 8)[0]
            for index in range(count):
                entry = struct.unpack_from('<I', data, at + 12 + index * 4)[0]
                struct.pack_into('<f', data, entry + 20, 0.0)
                muted += 1
        at += 8 + size
    assert muted > 100
    if silent.exists():
        silent.chmod(stat.S_IREAD | stat.S_IWRITE)
    silent.write_bytes(data)
    silent_digest = hashlib.sha256(data).hexdigest()
    assert hashlib.sha256(silent.read_bytes()).hexdigest() == silent_digest
    # Workers only read this single copy; the Windows read-only attribute
    # prevents a test process from rewriting it while the batch is active.
    silent.chmod(stat.S_IREAD)
    return digest, silent_digest, muted


def create_desktop(user, name):
    handle = user.CreateDesktopW(name, None, None, 0, 0x1ff, None)
    if not handle:
        raise RuntimeError('Private desktop unavailable: ' + name)
    return handle


def lower_test_priority(process):
    """Change only this child, after Runner's startup priority adjustment."""
    if process.poll() is not None:
        return False
    kernel = ctypes.windll.kernel32
    kernel.SetPriorityClass.argtypes = [ctypes.c_void_p, ctypes.c_ulong]
    kernel.SetPriorityClass.restype = ctypes.c_int
    kernel.GetPriorityClass.argtypes = [ctypes.c_void_p]
    kernel.GetPriorityClass.restype = ctypes.c_ulong
    if not kernel.SetPriorityClass(process._handle, subprocess.BELOW_NORMAL_PRIORITY_CLASS):
        if process.poll() is not None:
            return False
        raise RuntimeError('Could not lower this test Runner priority')
    assert kernel.GetPriorityClass(process._handle) == subprocess.BELOW_NORMAL_PRIORITY_CLASS
    return True


def run_case(scenario, context, desktop_name, worker, concurrency):
    started = time.monotonic()
    state = log = process = helper = None
    code, reason, infrastructure = None, 'native_exit', None
    result = dict(scenario=scenario, vm_sha256=context['digest'],
        silent_vm_sha256=context['silent_digest'], muted_resources=context['muted'],
        desktop='private, never activated', private_desktop_name=desktop_name,
        worker=worker, concurrent_test_runners=concurrency,
        shared_silent_vm_read_only=True, cpu_profile_serial=measured(scenario),
        physical_device_tested=False)
    kind = 'gameplay'
    try:
        assert hashlib.sha256(context['vm'].read_bytes()).hexdigest() == context['digest'], 'VM changed during batch'
        state = prepare_state(context['out'], scenario, context['run_id'])
        log = state / 'runner.log'
        info = subprocess.STARTUPINFO()
        info.dwFlags |= subprocess.STARTF_USESHOWWINDOW
        info.wShowWindow = 1
        info.lpDesktop = desktop_name
        timeout = 90 + float(scenario.split(',')[4]) * .12 if ',' in scenario else 75
        flags = ['--hardmode-gameplay-tests', '--hardmode-scenario=' + scenario]
        if scenario.startswith('native:'):
            kind = scenario.split(':')[1]
            flags = ['--hardmode-' + kind + '-tests']
        elif scenario.startswith('menu:'):
            kind = 'menu'
            flags = ['--hardmode-menu-tests', '--hardmode-menu-rate=' + scenario.split(':')[1]]
        with log.open('wb') as output:
            spawned = time.monotonic()
            process = subprocess.Popen([str(RUNNER), '-game', str(context['silent']), *flags,
                '--hardmode-test-root=' + state.as_posix()], cwd=ROOT/'build-windows',
                stdout=output, stderr=subprocess.STDOUT, startupinfo=info,
                creationflags=subprocess.CREATE_NO_WINDOW | subprocess.BELOW_NORMAL_PRIORITY_CLASS)
            result['process_pid'] = result['volume_target_pid'] = process.pid
            result['process_priority'] = 'below_normal_at_launch'
            helper = test_volume.configure(process)
            deadline = started + timeout
            lowered = False
            while process.poll() is None:
                if not lowered and time.monotonic() - spawned >= .5:
                    lowered = lower_test_priority(process)
                    if lowered:
                        result['process_priority'] = 'below_normal_reapplied_after_startup'
                timed_out = time.monotonic() > deadline
                text = log.read_text('utf8', errors='replace')
                if timed_out or any(marker in text for marker in ERROR_MARKERS):
                    reason = 'timeout' if timed_out else 'assertion_marker'
                    process.terminate()
                    process.wait(timeout=5)
                    break
                time.sleep(.25)
            code = process.returncode
    except Exception as error:
        infrastructure = type(error).__name__ + ': ' + str(error)
        reason = 'runner_infrastructure'
    finally:
        if process is not None and process.poll() is None:
            process.terminate()
            try:
                process.wait(timeout=5)
            except subprocess.TimeoutExpired:
                process.kill()
                process.wait(timeout=5)
            code = process.returncode
        if helper is not None:
            try:
                test_volume.verify(helper)
            except Exception as error:
                infrastructure = (infrastructure + '; ' if infrastructure else '') + type(error).__name__ + ': ' + str(error)
                reason = 'runner_infrastructure'
    text = log.read_text('utf8', errors='replace') if log is not None and log.exists() else ''
    match = re.search('HARDMODE ' + kind.upper() + r' RESULT (\{[^\r\n]+\})', text)
    payload = None
    if match:
        try:
            payload = json.loads(match[1])
        except (ValueError, TypeError) as error:
            infrastructure = 'Invalid runner result: ' + str(error)
    if hashlib.sha256(context['vm'].read_bytes()).hexdigest() != context['digest']:
        infrastructure = 'VM changed during batch'
    failed = (infrastructure is not None or code != 0 or payload is None
              or any(marker in text for marker in ERROR_MARKERS)
              or (payload is not None and payload.get('status', 'PASS') != 'PASS')
              or (payload is not None and payload.get('scenario', scenario) != scenario))
    if not failed:
        result.update(payload)
        result['status'] = 'PASS'
    else:
        result.update(status='FAIL', details=text[-4500:])
        if infrastructure:
            result['infrastructure_error'] = infrastructure
    result.update(exit=code, utc=datetime.now(timezone.utc).isoformat(),
        elapsed_seconds=round(time.monotonic() - started, 3), termination_reason=reason)
    if state is not None:
        (state/'receipt.json').write_text(json.dumps(result, indent=2), 'utf8')
    emit(result)
    return result


def run_batch(scenarios, context, desktops, keep_going):
    pending = queue.Queue()
    for scenario in scenarios:
        pending.put(scenario)
    stop = threading.Event()

    def worker(index):
        results = []
        while not stop.is_set():
            try:
                scenario = pending.get_nowait()
            except queue.Empty:
                break
            try:
                result = run_case(scenario, context, desktops[index], index + 1, len(desktops))
                results.append(result)
                if result['status'] != 'PASS' and not keep_going:
                    stop.set()
            finally:
                pending.task_done()
        return results

    if len(desktops) == 1:
        return worker(0)
    with ThreadPoolExecutor(max_workers=len(desktops), thread_name_prefix='hardmode-audit') as pool:
        tasks = [pool.submit(worker, index) for index in range(len(desktops))]
        return [result for task in tasks for result in task.result()]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('scenarios', nargs='+')
    parser.add_argument('--keep-going', action='store_true')
    parser.add_argument('--jobs', type=int, choices=(1, 2), default=1)
    args = parser.parse_args()
    names = [scenario_name(scenario) for scenario in args.scenarios]
    if len(args.scenarios) != len(set(args.scenarios)) or len(names) != len(set(names)):
        parser.error('Scenarios must be unique and use distinct output folders')
    lock_vm()
    vm = ROOT/'build-windows/nuclearthronemobile.win'
    silent = ROOT/'build-windows/release1105-silent.win'
    digest, silent_digest, muted = make_silent_vm(vm, silent)
    out = ROOT/'release1105/tests'
    out.mkdir(parents=True, exist_ok=True)
    run_id = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%fZ') + '-' + str(os.getpid())
    context = dict(vm=vm, silent=silent, digest=digest, silent_digest=silent_digest,
                   muted=muted, out=out, run_id=run_id)
    user = ctypes.windll.user32
    user.CreateDesktopW.restype = ctypes.c_void_p
    user.CreateDesktopW.argtypes = [ctypes.c_wchar_p, ctypes.c_wchar_p, ctypes.c_void_p,
                                  ctypes.c_ulong, ctypes.c_ulong, ctypes.c_void_p]
    user.CloseDesktop.argtypes = [ctypes.c_void_p]
    prefix = 'HardmodeMobile1105Audit-' + str(os.getpid())
    handles, results = [], []
    try:
        if args.jobs == 1:
            name = prefix + '-worker1'
            handles.append(create_desktop(user, name))
            results = run_batch(args.scenarios, context, [name], args.keep_going)
        else:
            profiles = [scenario for scenario in args.scenarios if measured(scenario)]
            ordinary = [scenario for scenario in args.scenarios if not measured(scenario)]
            if profiles:
                name = prefix + '-serial'
                handles.append(create_desktop(user, name))
                results += run_batch(profiles, context, [name], args.keep_going)
            if ordinary and (args.keep_going or not any(row['status'] != 'PASS' for row in results)):
                names = [prefix + '-worker' + str(index + 1) for index in range(args.jobs)]
                for name in names:
                    handles.append(create_desktop(user, name))
                results += run_batch(ordinary, context, names, args.keep_going)
    finally:
        for handle in reversed(handles):
            user.CloseDesktop(handle)
        silent.chmod(stat.S_IREAD | stat.S_IWRITE)
    failures = [row['scenario'] for row in results if row['status'] != 'PASS']
    if failures:
        raise SystemExit('Failed scenarios: ' + ', '.join(failures))


if __name__ == '__main__':
    main()
