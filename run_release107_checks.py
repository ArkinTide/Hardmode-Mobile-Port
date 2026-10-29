"""Collect 1.0.7 evidence against one unchanged desktop VM, sequentially."""
from pathlib import Path
import argparse, hashlib, json, shutil, subprocess, sys
from run_release103_checks import KINDS, SCENARIOS as PREVIOUS

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'release107'
from run_release106_checks import SCENARIOS as PREVIOUS107
SCENARIOS=list(PREVIOUS107)
for rate in (30,60):
    for area,sub,loop,ticks,mode in [
        ('1',1,0,40,'contracts107'),('venuz',1,0,50,'prompt107'),
        ('venuz',1,0,220,'retry107'),('venuz',400,0,220,'retry107'),
        ('venuz',1,0,40,'pellet107'),('venuz',1,0,190,'trail107'),
        ('ravenboss',3,0,260,'raven107'),('junkyard',4,0,340,'junk107'),
        ('junkyard',5,0,340,'junk107'),('HQ',1,0,55,'police107'),
        ('elevator',3,0,55,'police107'),('palace',1,0,200,'horror107'),
        ('caves',1,0,235,'ice107'),('cavesinv',3,0,270,'cavewalls107'),
        ('1',1,0,30,'reflect107'),('1',1,2,900,'revive107'),
        ('1',1,3,900,'revive107'),('city',1,2,165,'van107'),
        ('city',1,3,165,'van107'),('venuz',1,0,45,'car107'),
        ('throne',1,0,50,'fall107'),('1',1,1,195,'waves107'),
        ('venuz',10,0,160,'portraitprofile107'),('throne',1,0,160,'portraitprofile107')]:
        scenario=f'{area},{sub},{loop},{rate},{ticks},42,{mode}'
        if mode=='retry107': scenario+=',Simplified Chinese'
        SCENARIOS.append(scenario)


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
        run(['run_menu_checks.py','--output','release107'], 'menu-checks.log')
        run(['audit_localization.py','--output','release107/localization-audit.json'], 'localization-checks.log')
        print('Menu and localization PASS', flush=True)
    elif args.part == 'gameplay':
        pending = [s for s in SCENARIOS if not current(s, digest)]
        # Check this release's changed paths first; retain the declared
        # scenario order when collecting the final complete evidence set.
        pending.sort(key=lambda s:not s.split(',')[6].endswith('107'))
        print('Current VM passes retained:', len(SCENARIOS)-len(pending), 'pending:', len(pending), flush=True)
        batches=[[s for s in pending if s.split(',')[6].endswith('107')],
                 [s for s in pending if not s.split(',')[6].endswith('107')]]
        for batch in batches:
            if not batch:continue
            result = subprocess.run([sys.executable,'-B','run_gameplay_checks.py','--keep-going',*batch], cwd=ROOT)
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
