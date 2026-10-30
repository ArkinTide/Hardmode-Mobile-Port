"""Focused Windows follow-up regression; never overwrite prior release evidence."""
from pathlib import Path
import argparse,hashlib,json,re,shutil,subprocess,sys
from run_release102_checks import KINDS
from run_release107_checks import current

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release112'
SCENARIOS=[]
def case(area,sub,loop,rate,ticks,mode,seed=42):
    SCENARIOS.append(f'{area},{sub},{loop},{rate},{ticks},{seed},{mode}')
for rate in (30,60):
    case('1',1,0,rate,65,'wheel111')
    for area,sub in [('1',1),('sewers',2),('junkyard',4),('venuz',5)]:
        case(area,sub,0,rate,180,'perf111')
    for seed in (81,221):
        case('sewers',2,0,rate,70,'water112',seed)
        case('sewers',2,0,rate,65,'waterbank112',seed)
    case('junkyard',4,0,rate,160,'music112')
    case('cavesinv',3,0,rate,100,'cave112')
# The pre-clock candidate's 46-case inherited regression is retained separately.
# The final VM changes only the Windows startup clock/sleep margin; exercise
# every new field report and the four measured regions on this exact VM.

def run(args,name):
    with (OUT/name).open('wb') as stream:
        result=subprocess.run([sys.executable,'-B',*args],cwd=ROOT,stdout=stream,stderr=subprocess.STDOUT)
    assert result.returncode==0,(OUT/name).read_text(encoding='utf8',errors='replace')[-4000:]

def main():
    parser=argparse.ArgumentParser();parser.add_argument('part',choices=['gameplay','native-menu','collect'])
    part=parser.parse_args().part;OUT.mkdir(exist_ok=True)
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
        run(['run_menu_checks.py','--output','release112'],'menu-checks.log')
        run(['audit_localization.py','--output','release112/localization-audit.json'],'localization-checks.log')
    else:
        rows=[];performance=[]
        for scenario in SCENARIOS:
            assert current(scenario,digest),scenario
            stem='gameplay-'+scenario.replace(',','-')
            receipt=json.loads((ROOT/(stem+'-receipt.json')).read_text());rows.append(receipt)
            for ext in ('.log','-receipt.json'):shutil.copyfile(ROOT/(stem+ext),OUT/(stem+ext))
            if scenario.endswith(',perf111'):
                match=re.search(r'HARDMODE PERF111 (\{[^\r\n]+\})',(ROOT/(stem+'.log')).read_text(encoding='utf8',errors='replace'))
                performance.append(dict(scenario=scenario,**json.loads(match[1])))
        report=dict(status='PASS',vm_sha256=digest,version='1.0.12',cases=rows,
            count=len(rows),assertions=sum(r['checks'] for r in rows),physical_device_tested=False)
        (OUT/'windows-regression.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf8')
        (OUT/'performance.json').write_text(json.dumps(dict(vm_sha256=digest,cases=performance),indent=2)+'\n',encoding='utf8')
        print('Collected',len(rows),'PASS cases,',report['assertions'],'assertions for',digest)
if __name__=='__main__':main()
