"""Current 1.1.6 acceptance: isolated final host VM, not mobile hardware."""
from pathlib import Path
import json
import subprocess
import sys
import release1105_test_plan as retained

ROOT=Path(__file__).resolve().parent
REQUIRED=[]
for rate in (30,60):
    for area,sub,loop,ticks,seed,mode in [
        ('1',1,1,85,7116,'budget116'),
        ('sewers',1,10,45,7116,'floors116'),
        ('1',1,3,45,7116,'guardian116'),
        ('1',1,3,215,7116,'guardian116fire'),
        ('1',1,0,45,7116,'music116'),
        ('1',1,1,40,7116,'policy116gates'),
        ('1',3,1,360,42,'policy116stage'),
        ('1',3,1,360,81,'policy116stage'),
        ('1',1,1,110,7116,'policy116portrait'),
        ('1',1,0,100,7116,'policy116native'),
        ('1',1,1,180,7116,'policy116camera'),
        ('1',1,0,45,7116,'policy116guardian'),
        ('1',1,1,45,7116,'policy116guardian'),
        ('1',1,3,260,42,'policy116crystals'),
        ('1',1,3,200,42,'policy116deaths'),
        ('throne',1,0,205,7116,'throne116'),
        ('cavesinv',3,0,600,7116,'cave116stage'),
        ('cavesinv',1,3,600,7116,'cave116extra'),
        ('1',1,0,130,42,'policy116lateart'),
        ('sewers',1,3,100,42,'policy116deathsrest'),
        ('1',1,3,100,42,'policy116turtledeaths'),
        ('1',1,0,100,7116,'boss1116'),
        ('1',1,0,80,7116,'corpse116'),
    ]:
        REQUIRED.append(f'{area},{sub},{loop},{rate},{ticks},{seed},{mode}')
    for area,loop in [('1',0),('1',1),('1',2),('1',3),('jungle',1),('jungle',2)]:
        REQUIRED.append(f'{area},1,{loop},{rate},45,7116,policy116population')
    for loop in (2,3):
        REQUIRED.extend([
            f'city,1,{loop},{rate},165,7116,van107',
            f'1,1,{loop},{rate},{1720 if loop>=3 else 900},7116,revive107',
            f'1,1,{loop},{rate},80,7116,sync115idpdgate',
        ])
    REQUIRED.append(f'1,1,0,{rate},60,7116,custom116,'+
                    ('Simplified Chinese' if rate==30 else 'English'))
    for loop in (0,1,2):
        REQUIRED.append(f'1,1,{loop},{rate},130,7116,yv1115minigun')

# Retain the released encounter, damage, menu, terrain and water regressions.
# Their fixtures are updated only where the current user request changes the
# expected behavior (e.g. constructor-time stage Bandit classification).
REGRESSIONS=list(retained.REQUIRED)+list(retained.REGRESSIONS)
NATIVE=list(retained.NATIVE)
ALL=REQUIRED+REGRESSIONS+NATIVE
assert len(ALL)==len(set(ALL))

if __name__=='__main__':
    out=ROOT/'release1106';out.mkdir(exist_ok=True)
    (out/'test-plan.json').write_text(json.dumps(dict(required=REQUIRED,
        regressions=REGRESSIONS,native=NATIVE,all=ALL),indent=2)+'\n','utf8')
    print('planned',len(ALL),'cases')
    if '--run' in sys.argv:
        subprocess.run([sys.executable,'-B','run_release1106_checks.py',
            '--jobs','2',*ALL],cwd=ROOT,check=True)
