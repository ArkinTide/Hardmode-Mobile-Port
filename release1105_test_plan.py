"""Hardmode 1.1.5 followup acceptance on one exact compiled VM.

Private-desktop host tests exercise the same gameplay CODE as mobile packages.
They are not physical Android/iPhone frame-rate or input acceptance.
"""
from pathlib import Path
import json,subprocess,sys
ROOT=Path(__file__).resolve().parent
REQUIRED=[]
REGRESSIONS=[]
for rate in (30,60):
    for mode,ticks,loop in [
        ('sync115phasehealth',60,3),('sync115idpdgate',80,1),('sync115policy',60,1),('sync115stagebandit',60,1),
        ('sync115replacementchief',60,1),('sync115replacementgungod',60,1),
        ('chief1115first',280,3),('chief1115repeat',280,3),('yv1115minigun',130,3),
        ('sync115water',60,0),('sync115bubbles',60,0),('sync115shield',60,0),('sync115environment',60,0),
        ('sync113bosshealth',60,1),('sync113bosspolicy',60,1),('sync113chiefspacing',80,3),
        ('rocket1115gungod',60,3),('rocket1115bird',60,3),
        ('extra1115bandit',160,3),('extra1115jungle',160,3),('extra1115crystal',160,3),
        ('extra1115cursed',160,3),('extra1115hunter',160,3),
        ('group115hunter',300,1),('group115bubbler',300,1),('group115crystal',300,1),
        ('group115replace',40,1),('messenger115short',450,3),('messenger115natural',1900,3),
        ('messenger115short',60,2),
    ]:
        REQUIRED.append(f'1,1,{loop},{rate},{ticks},7105,{mode}')
    for loop in (0,1,3):
        REQUIRED.append(f'1,1,{loop},{rate},60,7105,sync115supplies')
    for loop in (0,1,2,10,20):
        REQUIRED.append(f'city,5,{loop},{rate},400,7105,hunter115count')
    for loop in (0,3):
        REQUIRED.append(f'1,1,{loop},{rate},100,7105,hunter114health')
    for suffix in ('','save','pending','horror','yv','coop'):
        REQUIRED.append(f'1,1,0,{rate},100,7105,sync113ultracancel{suffix}')
    for language in ('English','Simplified Chinese'):
        REQUIRED.append(f'1,1,0,{rate},40,7105,hunter114menu,{language}')
    for loop in (1,3):
        REQUIRED.append(f'throne,1,{loop},{rate},200,7105,sync115throne')
    for loop in (1,3,10):
        REQUIRED.append(f'sewers,1,{loop},{rate},65,715005,sync115waterprofile')
    for mode,ticks in [('fix114bars',60),('fix114guardian',60),('sync114gator',60),
                       ('sync113messenger',60),('sync113messengerportrait',165),('sync113ultrasave',100)]:
        REGRESSIONS.append(f'1,1,0,{rate},{ticks},7105,{mode}')
    REGRESSIONS.extend([
        f'palace,4,0,{rate},60,7105,fix114music',
        f'throne,1,1,{rate},220,7105,fix114throne',
        f'elevator,1,3,{rate},600,7105,sync112exit',
        f'palace,4,0,{rate},150,7105,sync113vault',
        f'sewers,1,0,{rate},60,7105,sync113frog',
    ])
    for area,sub,loop in [('sewers',1,1),('sewers',3,3),('oasis',1,3),('junkyard',4,1),
                          ('caves',1,1),('city',4,3),('palace',5,1),('HQ',3,3),('throne',1,3)]:
        REGRESSIONS.append(f'{area},{sub},{loop},{rate},70,7105,followup113allareas')
NATIVE=['native:'+name for name in ('actors','runtime','world','artwork','modules','radiation','radiation-custom')]+['menu:30','menu:60']
ALL=REQUIRED+REGRESSIONS+NATIVE
assert len(ALL)==len(set(ALL))
if __name__=='__main__':
    out=ROOT/'release1105';out.mkdir(exist_ok=True)
    (out/'test-plan.json').write_text(json.dumps(dict(required=REQUIRED,regressions=REGRESSIONS,native=NATIVE,all=ALL),indent=2)+'\n','utf8')
    print('planned',len(ALL),'cases')
    if '--run' in sys.argv:
        subprocess.run([sys.executable,'-B','run_release1105_checks.py','--keep-going',*ALL],cwd=ROOT,check=True)
