"""Final 30/60 Hz desktop campaign checks against one unchanged VM."""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from datetime import datetime, timezone
import hashlib
import json
import subprocess
import sys

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'release100'


def scenarios(rate):
    result = []
    for area, stage, loops in [
        ('1', 1, 0), ('nightdesert', 4, 0), ('sewers', 1, 0),
        ('junkyard', 4, 0), ('city', 1, 0), ('labs', 1, 0),
        ('palace', 1, 0), ('end', 0, 1), ('caves', 1, 0),
        ('cavesinv', 1, 0), ('icecave', 1, 0), ('noyetihere', 1, 0),
        ('HQ', 1, 0), ('HQ', 4, 0), ('elevator', 3, 0),
        ('oasis', 1, 0), ('jungle', 1, 0),
        *[('venuz', s, 0) for s in (1, 4, 7, 10, 100, 200, 300, 400, 401)],
    ]:
        result.append(f'{area},{stage},{loops},{rate},180,42,idle')
    for area, stage in [('oasis', 3), ('oasis', 5), ('caves', 3),
                        ('junkyard', 5), ('scorpionboss', 1), ('ravenboss', 3),
                        ('sewers', 3), ('turtles', 1), ('venuz', 12)]:
        result.append(f'{area},{stage},0,{rate},1500,42,boss')
    result.extend([
        f'city,3,0,{rate},2100,42,titank',
        f'palace,3,0,{rate},2100,42,guardian',
        f'throne,1,0,{rate},2400,42,throne',
        f'1,1,0,{rate},1050,42,weapons',
        f'caves,1,0,{rate},180,42,continue',
        f'venuz,4,0,{rate},180,42,continue',
        f'1,1,0,{rate},150,42,ui',
        f'1,1,0,{rate},4800,42,route',
    ])
    return result


def run(rate):
    items = scenarios(rate)
    with (OUT / f'rate-{rate}.log').open('wb') as log:
        p = subprocess.run([sys.executable, '-B', str(ROOT/'run_gameplay_checks.py'),
                            *items, '--keep-going'], cwd=ROOT,
                           stdout=log, stderr=subprocess.STDOUT)
    return {'rate': rate, 'exit': p.returncode, 'scenarios': items}


def main():
    OUT.mkdir(exist_ok=True)
    vm = ROOT/'build-windows/nuclearthronemobile.win'
    digest = hashlib.sha256(vm.read_bytes()).hexdigest()
    (OUT/'scenario-manifest.json').write_text(json.dumps({
        'vm_sha256': digest, 'rates': {str(r): scenarios(r) for r in (30,60)}
    }, indent=2)+'\n')
    with ThreadPoolExecutor(max_workers=2) as pool:
        runs = list(pool.map(run, (30, 60)))
    assert hashlib.sha256(vm.read_bytes()).hexdigest() == digest
    receipts, missing = [], []
    for batch in runs:
        for scenario in batch['scenarios']:
            path = ROOT/('gameplay-'+scenario.replace(',', '-')+'-receipt.json')
            if not path.exists():
                missing.append(scenario)
                continue
            receipt = json.loads(path.read_text())
            if receipt.get('vm_sha256') != digest:
                missing.append(scenario)
                continue
            receipts.append(receipt)
    report = {'status': 'PASS' if not missing and all(r['exit']==0 for r in runs) else 'FAIL',
              'verified_utc': datetime.now(timezone.utc).isoformat(),
              'vm_sha256': digest, 'cases': len(receipts), 'missing_or_stale': missing,
              'assertions': sum(r.get('checks',0) for r in receipts),
              'actual_room_transitions': sum(r.get('rooms',0) for r in receipts),
              'physical_device_tested': False,
              'scope': 'Bounded desktop scenarios; not a manual full playthrough or device certification',
              'runs': runs, 'receipts': receipts}
    (OUT/'gameplay-regression.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({k:v for k,v in report.items() if k not in ('runs','receipts')}))
    if report['status'] != 'PASS':
        raise SystemExit(1)


if __name__ == '__main__':
    main()
