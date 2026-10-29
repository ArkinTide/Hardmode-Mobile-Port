"""Collect current-VM 1.0.3 evidence, without reusing historical passes."""
from pathlib import Path
import argparse, hashlib, json, shutil, subprocess, sys
from run_release102_checks import KINDS, SCENARIOS as PREVIOUS

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release103'
SCENARIOS=list(PREVIOUS)
for rate in (30,60):
    SCENARIOS += [
        f'sewers,1,0,{rate},80,42,contracts103',
        f'sewers,2,0,{rate},130,42,sewer103',
        f'palace,1,0,{rate},110,42,horror103',
        f'cavesinv,3,0,{rate},260,42,caves103',
        f'1,1,0,{rate},60,42,fist103',
        f'city,1,1,{rate},270,42,laser103',
        f'1,2,0,{rate},60,42,skull103',
        f'1,2,1,{rate},60,42,skull103',
        f'1,1,0,{rate},100,42,bounds103',
        f'scorpionboss,5,1,{rate},170,42,scorpion103',
        f'city,3,0,{rate},2100,42,titank',
        f'1,1,0,{rate},130,42,goto103',
        f'3,1,0,{rate},361,42,route103',
        f'sewers,2,0,{rate},180,42,continue',
        f'city,2,0,{rate},180,42,continue',
        f'1,1,0,{rate},35,42,performance103',
    ]
    SCENARIOS += [f'city,{sub},0,{rate},170,42,exit103' for sub in (1,2,4,5)]

def run(args, name):
    with (OUT/name).open('wb') as stream:
        result=subprocess.run([sys.executable,'-B',*args],cwd=ROOT,stdout=stream,stderr=subprocess.STDOUT)
    assert result.returncode==0,(OUT/name).read_text(encoding='utf8',errors='replace')[-5500:]

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('part',choices=['native-menu','gameplay','collect'])
    args=parser.parse_args();OUT.mkdir(exist_ok=True)
    digest=hashlib.sha256((ROOT/'build-windows/nuclearthronemobile.win').read_bytes()).hexdigest()
    if args.part=='native-menu':
        for kind in KINDS:
            run(['run_radiation_tests.py'] if kind=='radiation' else ['run_native_checks.py',kind],kind+'-checks.log')
            receipt=json.loads((ROOT/f'{kind}-native-receipt.json').read_text())
            assert receipt.get('vm_sha256',receipt.get('compiled_vm_sha256'))==digest
            assert kind=='artwork' or receipt['status']=='PASS'
            for suffix in ('receipt.json','run.log'):
                shutil.copyfile(ROOT/f'{kind}-native-{suffix}',OUT/f'{kind}-native-{suffix}')
            print('Native PASS',kind,flush=True)
        run(['run_menu_checks.py','--output','release103'],'menu-checks.log')
        run(['audit_localization.py','--output','release103/localization-audit.json'],'localization-checks.log')
        print('Menu and localization PASS',flush=True)
    elif args.part=='gameplay':
        # The runner executes scenarios serially and sets its process to 1%.
        result=subprocess.run([sys.executable,'-B','run_gameplay_checks.py','--keep-going',*SCENARIOS],cwd=ROOT)
        assert result.returncode==0,'Inspect gameplay-failures.json'
    else:
        receipts=[]
        for scenario in SCENARIOS:
            prefix='gameplay-'+scenario.replace(',','-')
            receipt=json.loads((ROOT/(prefix+'-receipt.json')).read_text())
            assert receipt['scenario']==scenario and receipt['status']=='PASS'
            assert receipt['vm_sha256']==digest,scenario
            log=ROOT/(prefix+'.log');content=log.read_text(encoding='utf8',errors='replace')
            assert 'HARDMODE GAMEPLAY RESULT' in content and 'HARDMODE GAMEPLAY FAILED' not in content
            shutil.copyfile(log,OUT/log.name)
            path=ROOT/(prefix+'-receipt.json');shutil.copyfile(path,OUT/path.name)
            receipts.append(receipt)
        (OUT/'gameplay-regression.json').write_text(json.dumps(receipts,indent=2)+'\n')
        print('Current VM gameplay PASS',len(receipts))

if __name__=='__main__':main()
