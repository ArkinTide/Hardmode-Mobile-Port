"""Incremental 1.1.7 acceptance for the nine current requests only.

Earlier release receipts describe their own bytes. They are provenance, not
current acceptance, and this plan does not re-run the old 233-case suite.
"""
from pathlib import Path
import json
import subprocess
import sys

ROOT=Path(__file__).resolve().parent
REQUIRED=[]
for loop in (0,1,3):
    for rate in (30,60):
        for health in ('full','half'):
            REQUIRED.append(f'1,1,{loop},{rate},1800,42,chief117{health}')
        REQUIRED.append(f'1,1,{loop},{rate},400,42,presentation117phase')
for rate in (30,60):
    REQUIRED.append(f'1,1,0,{rate},160,42,presentation117titles,Simplified Chinese')
for mode,ticks in [('clock117travel',360),('clock117cache',120),
                   ('clock117freeze',180),('clock117pause',180),
                   ('clock117phase',180),('clock117auto',900),
                   ('clock117option',120),('clock117powered',120)]:
    REQUIRED.append(f'1,1,1,60,{ticks},42,{mode}')

for rate in (30,60):
    for mode in ('presentation117timing','presentation117timing20'):
        REQUIRED.append(f'1,1,0,{rate},400,42,{mode}')
    for area in ('caves','cavesinv'):
        for mode in ('presentation117flowerplain','presentation117flowerwish'):
            REQUIRED.append(f'{area},3,0,{rate},400,42,{mode}')

PENDING_REQUIREMENTS=[]
REGRESSIONS=[]
for rate in (30,60):
    for area,sub,loop,ticks,mode in [
        ('palace',3,3,215,'guardian116fire'),
        ('sewers',1,10,45,'floors116'),('oasis',1,10,45,'floors116'),
        ('1',1,3,260,'policy116crystals'),('1',1,3,200,'policy116deaths'),
        ('1',1,0,4800,'route'),('1',1,0,180,'continue'),
        ('1',1,1,180,'policy116camera'),
    ]:
        REGRESSIONS.append(f'{area},{sub},{loop},{rate},{ticks},42,{mode}')
NATIVE=[]
ALL=REQUIRED+REGRESSIONS+NATIVE
assert len(ALL)==len(set(ALL))

if __name__=='__main__':
    out=ROOT/'release1107';out.mkdir(exist_ok=True)
    (out/'test-plan.json').write_text(json.dumps(dict(required=REQUIRED,
        regressions=REGRESSIONS,native=NATIVE,all=ALL,
        pending_requirements=PENDING_REQUIREMENTS),indent=2)+'\n','utf8')
    print('planned',len(ALL),'incremental cases; pending',len(PENDING_REQUIREMENTS))
    if '--run' in sys.argv:
        assert not PENDING_REQUIREMENTS,('Complete current fixture coverage before running',PENDING_REQUIREMENTS)
        subprocess.run([sys.executable,'-B','run_release1107_checks.py',
            '--jobs','2',*ALL],cwd=ROOT,check=True)
