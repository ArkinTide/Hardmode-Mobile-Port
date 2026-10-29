"""Collect 1.0.5 evidence against one unchanged desktop VM."""
from pathlib import Path
import argparse, hashlib, json, shutil, subprocess, sys
from run_release103_checks import KINDS, SCENARIOS as PREVIOUS

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'release105'
from run_release104_checks import SCENARIOS as PREVIOUS105
SCENARIOS = list(PREVIOUS105)
for rate in (30,60):
    for area, sub, ticks, mode in [
        ('sewers',2,110,'water105'),('1',1,40,'rogue105'),
        ('1',1,45,'crystal105'),('ravenboss',3,1120,'raven105'),
        ('1',1,25,'walls105'),('1',1,55,'outside105'),
        ('palace',1,130,'palace105'),('venuz',1,40,'venuz105'),
        ('junkyard',5,50,'dog105'),('1',1,90,'font105')]:
        s=f'{area},{sub},0,{rate},{ticks},42,{mode}'
        if mode=='font105': s+=',Simplified Chinese'
        SCENARIOS.append(s)
    SCENARIOS.append(f'scorpionboss,5,1,{rate},240,42,scorpion105')
    for area,sub in [('elevator',3),('jungle',1),('venuz',10),('venuz',12)]:
        SCENARIOS.append(f'{area},{sub},0,{rate},100,82,idle')



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
        run(['run_menu_checks.py','--output','release105'], 'menu-checks.log')
        run(['audit_localization.py','--output','release105/localization-audit.json'], 'localization-checks.log')
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
