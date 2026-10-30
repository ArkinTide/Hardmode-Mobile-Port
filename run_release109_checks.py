"""Run current-VM 1.0.9 regression; prior releases remain frozen."""
from pathlib import Path
import argparse,hashlib,json,shutil,subprocess,sys
from run_release102_checks import KINDS
from run_release107_checks import current

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release109'
SCENARIOS=[]
for fps in (30,60):
    for area,sub,loop,ticks,mode in [
        ('nightdesert',1,0,30,'contracts109'),('oasis',1,0,30,'drops109'),
        ('palace',4,0,40,'altar109'),('sewers',2,0,150,'water109'),
        ('city',5,1,740,'hunter109'),('sewers',3,1,40,'gators109'),
        ('ravenboss',1,2,430,'birds109'),('city',3,0,1150,'titank109'),
        ('1',1,0,330,'guardian109'),('1',1,0,60,'rats109'),('1',1,0,35,'requests109'),('junkyard',4,1,130,'minigunner109'),('3',1,1,130,'minigunner109'),('3',2,1,130,'minigunner109'),('ravenboss',3,1,130,'minigunner109'),('junkyard',5,1,130,'minigunner109'),('venuz',401,0,6500,'venusyc109'),('labs',1,0,150,'wall109'),
        ('palace',1,0,150,'wall109'),('city',1,1,150,'crystals109'),
        ('caves',1,1,150,'crystals109'),('cavesinv',1,1,150,'crystals109'),
        ('nightdesert',1,0,150,'empty109'),('nightdesert',1,0,300,'night109'),
        ('throne',1,0,100,'throneseed109'),('throne',1,3,100,'throneseed109'),
        ('palace',4,0,100,'throneroute109'),('palace',4,3,100,'throneroute109'),
        ('sewers',1,1,40,'buffgator109'),('sewers',2,1,40,'buffgator109'),
        ('sewers',3,1,40,'buffgator109'),('junkyard',4,1,40,'buffgator109'),
        ('junkyard',5,1,40,'buffgator109'),
        ('1',1,0,35,'portal108'),('1',1,0,35,'reflect108'),
        ('1',1,0,95,'tankportal108'),('1',1,3,35,'tank108'),
        ('1',1,3,900,'revive107'),('1',1,0,260,'walls104'),
        ('cavesinv',3,0,270,'cavewalls107'),('throne',1,0,2400,'throne'),
        ('venuz',1,0,18000,'venus106'),('venuz',1,0,18000,'venussecrets106'),
        ('1',1,0,40,'contracts107'),('1',1,0,25,'packed106'),
        ('sewers',2,0,150,'water105'),('1',1,0,180,'profile109'),
    ]:
        SCENARIOS.append(f'{area},{sub},{loop},{fps},{ticks},42,{mode}')
for seed in (27,81,221):
    for fps in (30,60):SCENARIOS.append(f'nightdesert,1,1,{fps},300,{seed},night109')

def run(args,name):
    with (OUT/name).open('wb') as stream:
        result=subprocess.run([sys.executable,'-B',*args],cwd=ROOT,stdout=stream,stderr=subprocess.STDOUT)
    assert result.returncode==0,(OUT/name).read_text(encoding='utf8',errors='replace')[-5500:]

def main():
    parser=argparse.ArgumentParser();parser.add_argument('part',choices=['focused','regression','native-menu','collect'])
    args=parser.parse_args();OUT.mkdir(exist_ok=True)
    digest=hashlib.sha256((ROOT/'build-windows/nuclearthronemobile.win').read_bytes()).hexdigest()
    if args.part=='native-menu':
        for kind in KINDS:
            run(['run_radiation_tests.py'] if kind=='radiation' else ['run_native_checks.py',kind],kind+'-checks.log')
            for suffix in ('receipt.json','run.log'):
                shutil.copyfile(ROOT/f'{kind}-native-{suffix}',OUT/f'{kind}-native-{suffix}')
            print('Native PASS',kind,flush=True)
        run(['run_menu_checks.py','--output','release109'],'menu-checks.log')
        run(['audit_localization.py','--output','release109/localization-audit.json'],'localization-checks.log')
    elif args.part in ('focused','regression'):
        selected=[s for s in SCENARIOS if (s.split(',')[6].endswith('109'))==(args.part=='focused')]
        pending=[s for s in selected if not current(s,digest)]
        print('Selected',len(selected),'current passes',len(selected)-len(pending),'pending',len(pending),flush=True)
        if pending:subprocess.run([sys.executable,'-B','run_gameplay_checks.py','--keep-going',*pending],cwd=ROOT,check=True)
    else:
        rows=[]
        for scenario in SCENARIOS:
            assert current(scenario,digest),scenario
            stem='gameplay-'+scenario.replace(',','-')
            rows.append(json.loads((ROOT/(stem+'-receipt.json')).read_text()))
            for ext in ('.log','-receipt.json'):shutil.copyfile(ROOT/(stem+ext),OUT/(stem+ext))
        (OUT/'gameplay-regression.json').write_text(json.dumps(rows,indent=2)+'\n')
        print('Collected',len(rows),'PASS scenarios for',digest)

if __name__=='__main__':main()
