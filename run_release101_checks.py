"""Focused regression for the single-player menus and Chinese presentation."""
from pathlib import Path
import json,subprocess,sys,shutil,hashlib

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release101'
KINDS=['compiler','artwork','runtime','actors','modules','world','radiation']
SCENARIOS=[
    '1,1,0,30,150,42,ui,Simplified Chinese',
    '1,1,0,60,150,42,ui,Simplified Chinese',
    '1,1,0,30,1050,42,weapons,Simplified Chinese',
    '1,1,0,60,1050,42,weapons,Simplified Chinese',
    'venuz,12,0,30,1500,42,boss,Simplified Chinese',
    'palace,3,0,60,2100,42,guardian,Simplified Chinese',
]


def run(arguments,log):
    with log.open('wb') as stream:
        result=subprocess.run([sys.executable,'-B',*arguments],cwd=ROOT,stdout=stream,stderr=subprocess.STDOUT)
    if result.returncode:
        print(log.read_text(encoding='utf8',errors='replace')[-5000:],flush=True)
        raise RuntimeError(f'Regression failed: {arguments}; inspect {log}')


def main():
    for kind in KINDS:
        args=['run_radiation_tests.py'] if kind=='radiation' else ['run_native_checks.py',kind]
        run(args,OUT/(kind+'-checks.log'))
        shutil.copyfile(ROOT/(kind+'-native-receipt.json'),OUT/(kind+'-native-receipt.json'))
        print('Native PASS',kind,flush=True)
    run(['run_gameplay_checks.py',*SCENARIOS],OUT/'targeted-gameplay.log')
    receipts=[]
    for scenario in SCENARIOS:
        receipt=json.loads((ROOT/('gameplay-'+scenario.replace(',','-')+'-receipt.json')).read_text())
        assert receipt['status']=='PASS' and receipt['scenario']==scenario
        receipts.append(receipt)
    (OUT/'gameplay-regression.json').write_text(json.dumps(receipts,indent=2)+'\n')
    print('Targeted gameplay PASS',len(receipts),flush=True)


if __name__=='__main__':main()
