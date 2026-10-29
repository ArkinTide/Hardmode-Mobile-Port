"""Collect 1.0.4 evidence against one unchanged desktop VM."""
from pathlib import Path
import argparse, hashlib, json, shutil, subprocess, sys
from run_release103_checks import KINDS, SCENARIOS as PREVIOUS

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'release104'
SCENARIOS = []
for rate in (30, 60):
    for area, sub, ticks, mode in [
        ('1',1,45,'errors104'), ('1',1,40,'raven104'),
        ('sewers',2,60,'water104'), ('oasis',1,30,'oasis104'),
        ('1',1,90,'intro104'), ('1',1,25,'unlocks104'),
        ('1',1,25,'storage104'), ('1',1,260,'walls104'),
        ('city',3,720,'earlytank104'),
    ]:
        scenario = f'{area},{sub},0,{rate},{ticks},42,{mode}'
        if mode == 'unlocks104': scenario += ',Simplified Chinese'
        SCENARIOS.append(scenario)
SCENARIOS += list(PREVIOUS)


def run(args, name):
    with (OUT/name).open('wb') as stream:
        result = subprocess.run([sys.executable, '-B', *args], cwd=ROOT,
                                stdout=stream, stderr=subprocess.STDOUT)
    assert result.returncode == 0, (OUT/name).read_text(encoding='utf8', errors='replace')[-5500:]


def current(scenario, digest):
    prefix = 'gameplay-' + scenario.replace(',', '-')
    path = ROOT / (prefix+'-receipt.json')
    log = ROOT / (prefix+'.log')
    if not path.exists() or not log.exists(): return False
    receipt = json.loads(path.read_text())
    text = log.read_text(encoding='utf8', errors='replace')
    return (receipt['scenario'] == scenario and receipt['status'] == 'PASS'
            and receipt['vm_sha256'] == digest and 'HARDMODE GAMEPLAY RESULT' in text
            and 'HARDMODE GAMEPLAY FAILED' not in text)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('part', choices=['native-menu', 'gameplay', 'collect'])
    args = parser.parse_args(); OUT.mkdir(exist_ok=True)
    digest = hashlib.sha256((ROOT/'build-windows/nuclearthronemobile.win').read_bytes()).hexdigest()
    if args.part == 'native-menu':
        for kind in KINDS:
            run(['run_radiation_tests.py'] if kind == 'radiation' else ['run_native_checks.py',kind], kind+'-checks.log')
            receipt = json.loads((ROOT/f'{kind}-native-receipt.json').read_text())
            assert receipt.get('vm_sha256',receipt.get('compiled_vm_sha256')) == digest
            assert kind == 'artwork' or receipt['status'] == 'PASS'
            for suffix in ('receipt.json', 'run.log'):
                shutil.copyfile(ROOT/f'{kind}-native-{suffix}', OUT/f'{kind}-native-{suffix}')
            print('Native PASS', kind, flush=True)
        run(['run_menu_checks.py','--output','release104'], 'menu-checks.log')
        run(['audit_localization.py','--output','release104/localization-audit.json'], 'localization-checks.log')
        print('Menu and localization PASS', flush=True)
    elif args.part == 'gameplay':
        pending = [s for s in SCENARIOS if not current(s, digest)]
        print('Current VM passes retained:', len(SCENARIOS)-len(pending), 'pending:', len(pending), flush=True)
        if pending:
            result = subprocess.run([sys.executable,'-B','run_gameplay_checks.py','--keep-going',*pending], cwd=ROOT)
            assert result.returncode == 0, 'Inspect gameplay-failures.json'
    else:
        receipts = []
        for scenario in SCENARIOS:
            assert current(scenario, digest), scenario
            prefix = 'gameplay-' + scenario.replace(',', '-')
            for suffix in ('-receipt.json', '.log'):
                shutil.copyfile(ROOT/(prefix+suffix), OUT/(prefix+suffix))
            receipts.append(json.loads((ROOT/(prefix+'-receipt.json')).read_text()))
        (OUT/'gameplay-regression.json').write_text(json.dumps(receipts,indent=2)+'\n')
        print('Current VM gameplay PASS', len(receipts))


if __name__ == '__main__': main()
