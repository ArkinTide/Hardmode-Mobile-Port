"""Focused 1.0.10 checks; all receipts must identify the same final VM."""
from pathlib import Path
import argparse,hashlib,json,re,shutil,subprocess,sys
from run_release102_checks import KINDS
from run_release107_checks import current

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release110'
SCENARIOS=[]
def case(area,sub,loop,rate,ticks,mode,seed=42):
    SCENARIOS.append(f'{area},{sub},{loop},{rate},{ticks},{seed},{mode}')
for rate in (30,60):
    case('1',1,0,rate,90,'windows110')
    for area in ('1','labs','palace'):case(area,1,0,rate,150,'walls110')
    for loop in (0,1,2,3,4,5):
        # Every boundary at 30 FPS, plus even/odd multi-boss cases at 60.
        if rate==30 or loop in (2,3):
            case('city',5,loop,rate,740,'hunter109')
            case('sewers',3,loop,rate,40,'gators109')
            case('ravenboss',1,loop,rate,430,'birds109')
    for area in ('1','sewers'):
        for loop in (0,1,5):case(area,1,loop,rate,150,'maps110')
    case('palace',1,2,rate,150,'maps110')
    case('labs',1,3,rate,150,'maps110')
    for loop in (0,3):
        case('throne',1,loop,rate,150,'throne110')
        case('palace',4,loop,rate,360,'vault110')
    case('palace',4,0,rate,40,'altar109')
    case('caves',1,0,rate,235,'ice107')
    case('cavesinv',3,0,rate,270,'cavewalls107')
    case('throne',1,0,rate,2400,'throne')
    case('venuz',1,0,rate,220,'retry107')
for seed in (81,221):
    case('throne',1,0,30,150,'throne110',seed)
    case('throne',1,3,60,150,'throne110',seed)
    case('1',1,5,30,150,'maps110',seed)
case('1',1,8,60,150,'maps110')

def run(arguments,name):
    with (OUT/name).open('wb') as stream:
        result=subprocess.run([sys.executable,'-B',*arguments],cwd=ROOT,stdout=stream,stderr=subprocess.STDOUT)
    assert result.returncode==0,(OUT/name).read_text(encoding='utf8',errors='replace')[-4500:]

def main():
    parser=argparse.ArgumentParser();parser.add_argument('part',choices=['gameplay','native-menu','collect'])
    part=parser.parse_args().part;OUT.mkdir(exist_ok=True)
    digest=hashlib.sha256((ROOT/'build-windows/nuclearthronemobile.win').read_bytes()).hexdigest()
    if part=='gameplay':
        pending=[s for s in SCENARIOS if not current(s,digest)]
        print('Selected',len(SCENARIOS),'current passes',len(SCENARIOS)-len(pending),'pending',len(pending),flush=True)
        if pending:subprocess.run([sys.executable,'-B','run_gameplay_checks.py','--keep-going',*pending],cwd=ROOT,check=True)
    elif part=='native-menu':
        for kind in KINDS:
            run(['run_radiation_tests.py'] if kind=='radiation' else ['run_native_checks.py',kind],kind+'-checks.log')
            receipt=json.loads((ROOT/f'{kind}-native-receipt.json').read_text())
            assert receipt.get('vm_sha256',receipt.get('compiled_vm_sha256'))==digest
            assert kind=='artwork' or receipt['status']=='PASS'
            for suffix in ('receipt.json','run.log'):shutil.copyfile(ROOT/f'{kind}-native-{suffix}',OUT/f'{kind}-native-{suffix}')
            print('Native PASS',kind,flush=True)
        run(['run_menu_checks.py','--output','release110'],'menu-checks.log')
        run(['audit_localization.py','--output','release110/localization-audit.json'],'localization-checks.log')
    else:
        rows=[];maps=[]
        for scenario in SCENARIOS:
            assert current(scenario,digest),scenario
            stem='gameplay-'+scenario.replace(',','-')
            receipt=json.loads((ROOT/(stem+'-receipt.json')).read_text());rows.append(receipt)
            log=(ROOT/(stem+'.log')).read_text(encoding='utf8')
            if scenario.endswith('maps110'):
                match=re.search(r'HARDMODE MAP110 (\{[^\r\n]+\})',log);assert match
                maps.append(dict(scenario=scenario,**json.loads(match[1])))
            if scenario.endswith('vault110'):assert receipt['checks']==12 and receipt['rooms']==3
            for ext in ('.log','-receipt.json'):shutil.copyfile(ROOT/(stem+ext),OUT/(stem+ext))
        (OUT/'gameplay-regression.json').write_text(json.dumps(rows,indent=2)+'\n')
        (OUT/'map-expansion.json').write_text(json.dumps(dict(status='PASS',vm_sha256=digest,cases=maps),indent=2)+'\n')
        print('Collected',len(rows),'PASS cases,',sum(r['checks'] for r in rows),'assertions for',digest)

if __name__=='__main__':main()
