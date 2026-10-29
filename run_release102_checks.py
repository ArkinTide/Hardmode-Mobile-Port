"""Collect current-VM regressions, with no reuse of older release receipts."""
from pathlib import Path
import argparse, hashlib, json, shutil, subprocess, sys

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'release102'
KINDS = ['compiler', 'artwork', 'runtime', 'actors', 'modules', 'world', 'radiation']
SCENARIOS = []
for rate in (30, 60):
    SCENARIOS += [f'nightdesert,1,0,{rate},155,42,{mode}' for mode in ('bandit', 'banditmelee')]
    SCENARIOS += [f'1,1,0,{rate},{ticks},42,{mode}' for mode, ticks in
                  [('maggot',180),('portal',45),('stale',40),('frog',40),
                   ('scorpion',45),('crowd',45),('visual',65)]]
    SCENARIOS += [f'1,3,0,{rate},30,42,fog',
                  f'1,1,0,{rate},1050,42,weapons,Simplified Chinese',
                  f'scorpionboss,1,0,{rate},1500,42,boss']


def run(args, log):
    with log.open('wb') as stream:
        result = subprocess.run([sys.executable, '-B', *args], cwd=ROOT,
                                stdout=stream, stderr=subprocess.STDOUT)
    assert result.returncode == 0, log.read_text(encoding='utf8', errors='replace')[-5000:]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('part', choices=['native-menu', 'collect-gameplay'])
    args = parser.parse_args()
    digest = hashlib.sha256((ROOT/'build-windows/nuclearthronemobile.win').read_bytes()).hexdigest()
    if args.part == 'native-menu':
        for kind in KINDS:
            run(['run_radiation_tests.py'] if kind == 'radiation' else ['run_native_checks.py', kind],
                OUT/f'{kind}-checks.log')
            receipt = json.loads((ROOT/f'{kind}-native-receipt.json').read_text())
            assert receipt.get('vm_sha256', receipt.get('compiled_vm_sha256')) == digest
            assert kind == 'artwork' or receipt['status'] == 'PASS'
            shutil.copyfile(ROOT/f'{kind}-native-receipt.json', OUT/f'{kind}-native-receipt.json')
            shutil.copyfile(ROOT/f'{kind}-native-run.log', OUT/f'{kind}-native-run.log')
            print('Native PASS', kind, flush=True)
        run(['run_menu_checks.py', '--output', 'release102'], OUT/'menu-checks.log')
        print('Menu PASS 30/60', flush=True)
        run(['audit_localization.py', '--output', 'release102/localization-audit.json'],
            OUT/'localization-checks.log')
    else:
        receipts = []
        for scenario in SCENARIOS:
            prefix = 'gameplay-' + scenario.replace(',', '-')
            path = ROOT/(prefix+'-receipt.json')
            receipt = json.loads(path.read_text())
            assert receipt['scenario'] == scenario and receipt['status'] == 'PASS'
            assert receipt['vm_sha256'] == digest, scenario
            log = ROOT/(prefix+'.log')
            text = log.read_text(encoding='utf8', errors='replace')
            assert 'HARDMODE GAMEPLAY RESULT' in text and 'HARDMODE GAMEPLAY FAILED' not in text
            shutil.copyfile(path, OUT/path.name)
            shutil.copyfile(log, OUT/log.name)
            receipts.append(receipt)
        (OUT/'gameplay-regression.json').write_text(json.dumps(receipts, indent=2)+'\n')
        print('Gameplay PASS', len(receipts))


if __name__ == '__main__': main()
