"""Focused16-item acceptance plus affected-map and retained-feature regressions."""
from pathlib import Path
import json,subprocess,sys
ROOT=Path(__file__).resolve().parent
REQUIRED=[]
for rate in (30,60):
    for mode,ticks in [('fix114names',60),('fix114bars',60),('fix114guardian',60),
                       ('fix114extra',60),('sync114poison',60),('sync114poisonspawn',60),
                       ('sync114arrow',70),('sync114gator',60),
                       ('hunter114death',40),('hunter114menu',40)]:
        REQUIRED.append(f'1,1,0,{rate},{ticks},7104,{mode}')
    REQUIRED.extend([f'palace,4,0,{rate},60,7104,fix114music',
                     f'throne,1,1,{rate},220,7104,fix114throne'])
    for loop in (0,1,3,10):
        REQUIRED.extend([f'1,1,{loop},{rate},100,7104,hunter114health',
                         f'city,5,{loop},{rate},305,7104,hunter114arrival'])
REGRESSIONS=[]
for rate in (30,60):
    REGRESSIONS.extend([f'sewers,1,0,{rate},60,7104,sync113frog',
                       f'caves,3,0,{rate},400,7104,jungleentry112',
                       f'palace,4,0,{rate},150,7104,sync113vault',
                       f'1,1,1,{rate},60,7104,sync113bosspolicy',
                       f'1,1,3,{rate},60,7104,sync113bosspolicy',
                       f'elevator,1,3,{rate},600,7104,sync112exit',
                       f'1,1,3,{rate},80,7104,sync113chiefspacing',
                       f'city,4,3,{rate},70,7104,followup113allareas',
                       f'palace,3,0,{rate},80,7104,fix114arena',
                       f'ravenboss,1,3,{rate},80,7104,fix114arena'])
    for area,sub in [('sewers',1),('sewers',3),('oasis',1),('junkyard',4),('junkyard',5),('palace',5),('throne',1)]:
        REGRESSIONS.append(f'{area},{sub},3,{rate},70,7104,followup113allareas')
NATIVE=['native:'+x for x in ('actors','runtime','world','artwork','modules','radiation','radiation-custom')]+['menu:30','menu:60']
ALL=REQUIRED+REGRESSIONS+NATIVE

if __name__=='__main__':
    (ROOT/'release1104/test-plan.json').write_text(json.dumps(dict(required=REQUIRED,regressions=REGRESSIONS,native=NATIVE,all=ALL),indent=2)+'\n','utf8')
    print('planned',len(ALL),'cases')
    if '--run' in sys.argv:
        subprocess.run([sys.executable,'-B','run_release1104_checks.py','--keep-going',*ALL],cwd=ROOT,check=True)
