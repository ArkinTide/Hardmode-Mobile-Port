"""Focused current-VM verification for 1.0.8; keep frozen 1.0.7 evidence."""
from pathlib import Path
import argparse,hashlib,json,shutil,subprocess,sys
from run_release102_checks import KINDS
from run_release107_checks import current

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release108'
SCENARIOS=[]
for fps in (30,60):
    for area,sub,loop,ticks,mode in [
        ('1',1,0,45,'wall108'),('1',1,0,35,'car108'),('1',1,0,35,'filter108'),
        ('1',1,0,35,'beam108'),('1',1,3,35,'tank108'),('1',1,0,95,'tankportal108'),
        ('1',1,3,35,'police108'),('1',1,0,35,'reflect108'),('1',1,0,35,'sniper108'),
        ('1',1,0,35,'portal108'),('1',1,0,35,'crater108'),
        ('venuz',10,0,45,'venuswall108'),('venuz',400,0,45,'venuswall108'),
        ('1',1,0,50,'pickup108'),('1',1,0,30,'text108'),
        ('1',1,0,40,'contracts107'),('venuz',1,0,50,'prompt107'),
        ('venuz',1,0,220,'retry107'),('venuz',400,0,220,'retry107'),
        ('venuz',1,0,40,'pellet107'),('venuz',1,0,190,'trail107'),
        ('cavesinv',3,0,270,'cavewalls107'),('1',1,0,30,'reflect107'),
        ('1',1,3,900,'revive107'),('venuz',1,0,45,'car107'),
        ('throne',1,0,50,'fall107'),('1',1,1,195,'waves107'),
        ('junkyard',4,0,340,'junk107'),('junkyard',5,0,340,'junk107'),
        ('palace',1,0,200,'horror107'),('sewers',2,0,60,'water104'),
        ('1',1,0,260,'walls104'),('1',1,0,25,'packed106'),
        ('throne',1,0,120,'throne106'),
        ('throne',1,0,2400,'throne'),
        ('throne',1,0,180,'profile106'),('venuz',10,0,180,'profile106'),
        ('venuz',1,0,18000,'venus106'),('venuz',1,0,18000,'venussecrets106'),
    ]:
        value=f'{area},{sub},{loop},{fps},{ticks},42,{mode}'
        if mode in ('retry107','text108'):value+=',Simplified Chinese'
        SCENARIOS.append(value)

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
        run(['run_menu_checks.py','--output','release108'],'menu-checks.log')
        run(['audit_localization.py','--output','release108/localization-audit.json'],'localization-checks.log')
    elif args.part in ('focused','regression'):
        selected=[s for s in SCENARIOS if (s.split(',')[6].endswith('108'))==(args.part=='focused')]
        pending=[s for s in selected if not current(s,digest)]
        print('Selected',len(selected),'current passes',len(selected)-len(pending),'pending',len(pending),flush=True)
        if pending:subprocess.run([sys.executable,'-B','run_gameplay_checks.py','--keep-going',*pending],cwd=ROOT,check=True)
    else:
        rows=[]
        for scenario in SCENARIOS:
            assert current(scenario,digest),scenario
            stem='gameplay-'+scenario.replace(',','-')
            row=json.loads((ROOT/(stem+'-receipt.json')).read_text())
            rows.append(row)
            for ext in ('.log','-receipt.json'):shutil.copyfile(ROOT/(stem+ext),OUT/(stem+ext))
        (OUT/'gameplay-regression.json').write_text(json.dumps(rows,indent=2)+'\n')
        print('Collected',len(rows),'PASS scenarios for',digest)

if __name__=='__main__':main()
