"""Run isolated gameplay processes under one immutable-VM lock.

Each process has its own test/save root. CPU profile106 cases run alone.
"""
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime, timezone
from pathlib import Path
import argparse, hashlib, json, re, subprocess, time
import test_volume
from vm_test_lock import lock_vm

ROOT = Path(__file__).resolve().parent
VM = ROOT / 'build-windows/nuclearthronemobile.win'


def run_case(scenario, digest, workers):
    assert hashlib.sha256(VM.read_bytes()).hexdigest() == digest
    name = scenario.replace(',', '-')
    state = ROOT / 'build-windows' / ('test-gameplay-' + name)
    state.mkdir(exist_ok=True)
    log = ROOT / ('gameplay-' + name + '.log')
    with log.open('wb') as output:
        process = subprocess.Popen([
            'C:/ProgramData/GameMakerStudio2-LTS2026/Cache/runtimes/runtime-2026.0.0.23/windows/x64/Runner.exe',
            '-game', str(VM), '--hardmode-gameplay-tests',
            '--hardmode-scenario=' + scenario, '--hardmode-test-root=' + state.as_posix()],
            cwd=ROOT/'build-windows', stdout=output, stderr=subprocess.STDOUT,
            creationflags=subprocess.CREATE_NO_WINDOW)
        helper = test_volume.configure(process)
        print('RUN '+json.dumps({'scenario':scenario,'pid':process.pid}),flush=True)
        seconds = float(scenario.split(',')[4]) / 30
        generation = 5 * (float(scenario.split(',')[4]) / 120) if scenario.endswith(',route') else 0
        deadline=time.monotonic()+60+seconds*3+generation
        while True:
            try:
                code=process.wait(timeout=1)
                break
            except subprocess.TimeoutExpired:
                failed='HARDMODE GAMEPLAY FAILED' in log.read_text(encoding='utf8',errors='replace')
                if failed or time.monotonic()>=deadline:
                    process.terminate();process.wait(timeout=5);code=-998 if failed else -999
                    break
        test_volume.verify(helper)
    assert hashlib.sha256(VM.read_bytes()).hexdigest() == digest
    text = log.read_text(encoding='utf8', errors='replace')
    match = re.search(r'HARDMODE GAMEPLAY RESULT (\{[^\r\n]+\})', text)
    venus = scenario.split(',')[6] in ('venus106', 'venussecrets106')
    incomplete_venus = venus and 'HARDMODE VENUS106 COMPLETE ' not in text
    if code or not match or 'HARDMODE GAMEPLAY FAILED' in text or incomplete_venus:
        failure = re.search(r'HARDMODE GAMEPLAY FAILED ([\s\S]+?)(?:###game_end###|\Z)', text)
        result = {'scenario': scenario, 'exit': code,
                  'message': failure[1].strip() if failure else ('Venus route did not finish.\n' if incomplete_venus else '')+text[-1500:]}
        print('FAIL ' + json.dumps(result), flush=True)
        return result
    result = json.loads(match[1])
    result.update(verified_utc=datetime.now(timezone.utc).isoformat(), vm_sha256=digest,
                  concurrent_test_runners=workers, physical_device_tested=False, full_mod_verified=False)
    (ROOT/('gameplay-'+name+'-receipt.json')).write_text(json.dumps(result, indent=2)+'\n')
    print('PASS ' + scenario, flush=True)
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--workers', type=int, choices=(1, 2), default=2)
    parser.add_argument('scenarios', nargs='+')
    args = parser.parse_args()
    assert len(args.scenarios) == len(set(args.scenarios))
    lock_vm()
    digest = hashlib.sha256(VM.read_bytes()).hexdigest()
    serial = [s for s in args.scenarios if s.split(',')[6] == 'profile106']
    parallel = [s for s in args.scenarios if s not in serial]
    with ThreadPoolExecutor(max_workers=args.workers) as pool:
        results = list(pool.map(lambda s: run_case(s, digest, args.workers), parallel))
    results += [run_case(s, digest, 1) for s in serial]
    failures = [r for r in results if r.get('status') != 'PASS']
    if failures:
        (ROOT/'gameplay-failures106.json').write_text(json.dumps(failures, indent=2)+'\n')
        raise SystemExit(1)


if __name__ == '__main__':
    main()
