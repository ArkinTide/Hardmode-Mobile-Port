"""Current-round Windows checks; never change frozen earlier releases."""
from pathlib import Path
import argparse,hashlib,json,re,shutil,subprocess,sys
from run_release102_checks import KINDS
from run_release107_checks import current

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release111'
SCENARIOS=[]
def case(area,sub,loop,rate,ticks,mode,seed=42):
    SCENARIOS.append(f'{area},{sub},{loop},{rate},{ticks},{seed},{mode}')
for rate in (30,60):
    # wheel111 advances real physical frames; windows110 injected multiple
    # impossible notches into a single frame and predates frame consumption.
    case('1',1,0,rate,65,'wheel111')
    case('1',1,0,rate,180,'perf111')
    case('sewers',2,0,rate,65,'water111',81)
    case('sewers',1,0,rate,65,'water111',221)
    for loop in (0,3):
        case('palace',4,loop,rate,65,'altar111')
        case('palace',4,loop,rate,360,'vault110')
        case('1',1,loop,rate,65,'exploguardian111')
    for area in ('city','palace'):
        case(area,1,1,rate,65,'altar111')
    case('cavesinv',3,0,rate,330,'cave111')
    case('caves',3,0,rate,65,'music111')
    case('1',1,0,rate,65,'shield111')
    for area in ('caves','cavesinv','city'):case(area,1,1,rate,65,'spider111')
    for area,sub in (('nightdesert',4),('sewers',1),('junkyard',4),('caves',1),('city',1),('labs',1),('palace',1)):
        case(area,sub,1,rate,65,'loop111')
    case('1',1,1,rate,65,'venusdrop111')
    case('junkyard',5,1,rate,65,'dog111')
    case('junkyard',5,1,rate,65,'dog105')
    for loop in (0,1,3):case('throne',1,loop,rate,100,'throne111')
    case('throne',1,0,rate,2400,'throne')
case('throne',1,3,30,100,'throne111',81)
case('throne',1,3,60,100,'throne111',221)

def run(arguments,name):
    with (OUT/name).open('wb') as stream:
        r=subprocess.run([sys.executable,'-B',*arguments],cwd=ROOT,stdout=stream,stderr=subprocess.STDOUT)
    assert r.returncode==0,(OUT/name).read_text(encoding='utf8',errors='replace')[-4500:]

def main():
    p=argparse.ArgumentParser();p.add_argument('part',choices=['gameplay','native-menu','collect'])
    part=p.parse_args().part;OUT.mkdir(exist_ok=True)
    digest=hashlib.sha256((ROOT/'build-windows/nuclearthronemobile.win').read_bytes()).hexdigest()
    if part=='gameplay':
        pending=[s for s in SCENARIOS if not current(s,digest)]
        print('Selected',len(SCENARIOS),'current',len(SCENARIOS)-len(pending),'pending',len(pending),flush=True)
        if pending:subprocess.run([sys.executable,'-B','run_gameplay_checks.py','--keep-going',*pending],cwd=ROOT,check=True)
    elif part=='native-menu':
        for kind in KINDS:
            run(['run_radiation_tests.py'] if kind=='radiation' else ['run_native_checks.py',kind],kind+'-checks.log')
            receipt=json.loads((ROOT/f'{kind}-native-receipt.json').read_text())
            assert receipt.get('vm_sha256',receipt.get('compiled_vm_sha256'))==digest
            assert kind=='artwork' or receipt['status']=='PASS'
            for suffix in ('receipt.json','run.log'):shutil.copyfile(ROOT/f'{kind}-native-{suffix}',OUT/f'{kind}-native-{suffix}')
            print('Native PASS',kind,flush=True)
        run(['run_menu_checks.py','--output','release111'],'menu-checks.log')
        run(['audit_localization.py','--output','release111/localization-audit.json'],'localization-checks.log')
    else:
        rows=[]
        for scenario in SCENARIOS:
            assert current(scenario,digest),scenario
            stem='gameplay-'+scenario.replace(',','-')
            receipt=json.loads((ROOT/(stem+'-receipt.json')).read_text());rows.append(receipt)
            for ext in ('.log','-receipt.json'):shutil.copyfile(ROOT/(stem+ext),OUT/(stem+ext))
        report=dict(status='PASS',vm_sha256=digest,version='1.0.11',cases=rows,
            count=len(rows),assertions=sum(r['checks'] for r in rows),physical_device_tested=False)
        (OUT/'windows-regression.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf8')
        print('Collected',len(rows),'PASS cases,',report['assertions'],'assertions for',digest)

if __name__=='__main__':main()
