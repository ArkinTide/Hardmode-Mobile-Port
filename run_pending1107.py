"""Run unverified cases for the current, source-bound host VM only.

The final delivery gate still checks every case and its complete log. This
selector merely avoids running an unchanged already-passing case twice.
"""
from pathlib import Path
import hashlib
import json
import subprocess
import sys

import release1107_test_plan as plan
from build_checked1107 import project_map

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'release1107'


def main():
    bound = json.loads((OUT / 'desktop-build-source.json').read_text('utf8'))
    digest = hashlib.sha256((ROOT / 'build-windows/nuclearthronemobile.win').read_bytes()).hexdigest()
    assert bound['status'] == 'PASS' and bound['desktop_vm_sha256'] == digest
    assert bound['project_files'] == project_map(), 'Project changed since host compilation'
    pending = []
    for scenario in plan.ALL:
        folder = OUT / 'tests' / scenario.replace(',', '-').replace(':', '-')
        try:
            row = json.loads((folder / 'receipt.json').read_text('utf8'))
            log = (folder / 'runner.log').read_text('utf8', errors='replace')
        except (OSError, ValueError):
            pending.append(scenario)
            continue
        passed = (row.get('status') == 'PASS' and row.get('exit') == 0
                  and row.get('scenario') == scenario and row.get('vm_sha256') == digest
                  and row.get('checks', 0) > 0 and 'HARDMODE GAMEPLAY RESULT ' in log
                  and not any(marker in log for marker in (
                      'HARDMODE GAMEPLAY FAILED', 'ERROR!!!', 'FATAL ERROR', 'Stack Overflow detected!!!')))
        if not passed:
            pending.append(scenario)
    print('Current VM', digest, '; pending', len(pending), 'of', len(plan.ALL), flush=True)
    if pending:
        # Emit the visual evidence early so it can be reviewed while the
        # longer natural-AI and route cases continue on their private desktops.
        def visual_priority(scenario):
            mode = scenario.split(',')[6]
            if mode == 'presentation117titles':
                return 0
            if mode.startswith('presentation117flower'):
                return 1
            return 2
        pending.sort(key=visual_priority)
        subprocess.run([sys.executable, '-B', 'run_release1107_checks.py',
                        '--jobs', '2', '--keep-going', *pending], cwd=ROOT, check=True)


if __name__ == '__main__':
    main()
