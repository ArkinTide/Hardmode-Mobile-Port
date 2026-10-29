"""Collect 1.0.6 evidence against one unchanged desktop VM."""
from pathlib import Path
import argparse, hashlib, json, shutil, subprocess, sys
from run_release103_checks import KINDS, SCENARIOS as PREVIOUS

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'release106'
from run_release105_checks import SCENARIOS as PREVIOUS106
SCENARIOS=list(PREVIOUS106)
for rate in (30,60):
    for area,sub,ticks,mode in [
        ('venuz',1,1200,'attack106'),('venuz',4,100,'contracts106'),
        ('city',2,90,'hunter106'),('city',3,910,'natural106'),
        ('1',1,25,'packed106'),('noyetihere',2,100,'goto106'),
        ('1',1,170,'profile106'),('venuz',4,170,'profile106'),
        ('throne',1,170,'profile106')]:
        SCENARIOS.append(f'{area},{sub},0,{rate},{ticks},42,{mode}')
    for seed in (42,83,99):
        SCENARIOS.append(f'throne,1,0,{rate},120,{seed},throne106')
    for mode in ('venus106','venussecrets106'):
        SCENARIOS.append(f'venuz,1,0,{rate},18000,42,{mode}')


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
            and 'HARDMODE GAMEPLAY FAILED' not in text
            and (scenario.split(',')[6] not in ('venus106','venussecrets106')
                 or 'HARDMODE VENUS106 COMPLETE ' in text))


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
        run(['run_menu_checks.py','--output','release106'], 'menu-checks.log')
        run(['audit_localization.py','--output','release106/localization-audit.json'], 'localization-checks.log')
        print('Menu and localization PASS', flush=True)
    elif args.part == 'gameplay':
        pending = [s for s in SCENARIOS if not current(s, digest)]
        print('Current VM passes retained:', len(SCENARIOS)-len(pending), 'pending:', len(pending), flush=True)
        if pending:
            result = subprocess.run([sys.executable,'-B','run_gameplay_parallel106.py','--workers','2',*pending], cwd=ROOT)
            assert result.returncode == 0, 'Inspect gameplay-failures106.json'
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
