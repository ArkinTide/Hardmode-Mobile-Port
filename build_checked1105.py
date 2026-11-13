"""Compile the host VM with an unchanged, explicitly recorded project map.

This does not freeze source, run a test or build a mobile installer. The final
source/package gate compares this map to its frozen project, so an old VM
cannot be paired with newer uncompiled project edits.
"""
from datetime import datetime, timezone
from pathlib import Path
import hashlib
import json
import subprocess

from release_config import VERSION, BUILD

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'release1105'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def project_map():
    return {path.relative_to(ROOT).as_posix(): sha(path)
            for path in sorted((ROOT / 'project').rglob('*')) if path.is_file()}


def main():
    assert (VERSION, BUILD) == ('1.1.5', 19)
    assert not (ROOT / 'build-windows/.vm-test-in-use.json').exists(), 'Host VM test is active'
    OUT.mkdir(exist_ok=True)
    before = project_map()
    started = datetime.now(timezone.utc).isoformat()
    compiler_script = sha(ROOT / 'build_local.ps1')
    # Run one known script, with fixed arguments and no shell interpolation.
    result = subprocess.run(['pwsh', '-NoProfile', '-File', str(ROOT / 'build_local.ps1'),
                             '-Target', 'windows'], cwd=ROOT, check=False)
    after = project_map()
    ended = datetime.now(timezone.utc).isoformat()
    assert result.returncode == 0, 'Windows compile failed; no new source binding recorded'
    assert before == after, 'Project changed during compilation; rebuild after edits stop'
    assert sha(ROOT / 'build_local.ps1') == compiler_script, 'Compiler script changed during build'
    vm = ROOT / 'build-windows/nuclearthronemobile.win'
    log = ROOT / 'build-windows.log'
    assert vm.is_file() and log.is_file()
    report = dict(status='PASS', version=VERSION, build=BUILD, target='windows-host-VM',
                  started_utc=started, finished_utc=ended, project_files=after,
                  unchanged_project_during_build=True, desktop_vm_sha256=sha(vm),
                  build_script_sha256=compiler_script, build_log_sha256=sha(log),
                  exit=result.returncode, physical_device_tested=False)
    (OUT / 'desktop-build-source.json').write_text(
        json.dumps(report, indent=2) + '\n', encoding='utf-8')
    print('Source-bound host compile PASS', report['desktop_vm_sha256'], len(after), 'project files')


if __name__ == '__main__':
    main()
