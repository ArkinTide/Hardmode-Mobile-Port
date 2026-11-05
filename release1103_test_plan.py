"""Final same-VM acceptance matrix for the November 3 17:36 mobile sync."""
from pathlib import Path
import argparse, subprocess, sys
from release1103_allareas_plan import ALLAREAS

ROOT=Path(__file__).resolve().parent
REQUIRED=[
    *[f'caves,3,{loop},{rate},400,7103,{mode}'
      for loop in (0,3) for rate in (30,60)
      for mode in ('jungleentry112','junglepending112')],
    *[f'1,1,0,{rate},60,42,sync113chiefspacing' for rate in (30,60)],
    *[f'{area},1,10,{rate},170,42,profile106' for area in ('sewers','palace') for rate in (30,60)],
    *[f'1,1,0,{rate},60,42,sync113bosshealth' for rate in (30,60)],
    *[f'3,1,{loop},{rate},100,7103,sync113chest' for loop in (0,1) for rate in (30,60)],
    *[f'1,1,0,{rate},60,42,{mode}' for mode in (
        'sync113ultra','sync113horror','sync113ultradefer','sync113ultrasave',
        'sync113ultraoff','sync113ultrapending') for rate in (30,60)],
    *[f'sewers,1,3,{rate},80,7103,{mode}' for mode in ('sync113waterpass','sync113radpass') for rate in (30,60)],
    *[f'sewers,1,0,{rate},100,731103,sync113frog' for rate in (30,60)],
    *[f'palace,4,0,{rate},80,7103,followup113altarwalls' for rate in (30,60)],
    *[f'throne,1,1,{rate},80,7103,followup113generatorwalls' for rate in (30,60)],
    *[f'1,1,0,{rate},60,7103,sync113spawn' for rate in (30,60)],
    *[f'1,1,0,{rate},130,42,{mode}' for mode in (
        'sync113messenger','sync113minigun','sync113guardian') for rate in (30,60)],
    *[f'1,1,0,{rate},180,42,sync113messengerportrait' for rate in (30,60)],
    *[f'1,1,{loop},{rate},60,42,sync113bosspolicy' for loop in (1,3) for rate in (30,60)],
    *[f'palace,4,0,{rate},150,7103,sync113vault' for rate in (30,60)],
    *[f'elevator,3,0,{rate},140,7103,sync113lift' for rate in (30,60)],
    *[f'elevator,3,3,{rate},140,42,sync113lift' for rate in (30,60)],
    *[f'throne,1,1,{rate},500,7103,sync113throne' for rate in (30,60)],
    *[f'throne,1,{loop},{rate},60,7103,sync113thronehealth' for loop in (0,1) for rate in (30,60)],
]
# Keep the established camera, projectile, van, timing, and cave behavior gates.
REGRESSION=[
    *[f'cavesinv,1,3,{rate},400,7103,caveextra112' for rate in (30,60)],
    *[f'venuz,1,0,{rate},60000,42,venus106' for rate in (30,60)],
    *[f'venuz,1,0,{rate},90000,42,venussecrets106' for rate in (30,60)],
    *[f'venuz,401,0,{rate},18000,42,venusyc109' for rate in (30,60)],
    *[f'1,1,0,{rate},100,42,motion112' for rate in (30,60)],
    *[f'cavesinv,3,0,{rate},180,42,cave112' for rate in (30,60)],
    *[f'1,1,1,{rate},400,43,sync111van' for rate in (30,60)],
    *[f'elevator,3,3,{rate},900,42,sync112exit' for rate in (30,60)],
    *[f'scorpionboss,1,3,{rate},650,42,sync112chief' for rate in (30,60)],
    *[f'scorpionboss,1,3,{rate},50,42,sync112rocket' for rate in (30,60)],
]
NATIVE=['compiler','runtime','actors','modules','world','artwork']
ALL=REQUIRED+REGRESSION+ALLAREAS+[f'native:{kind}' for kind in NATIVE]+['menu:30','menu:60']
assert len(set(ALL))==len(ALL)

if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--run',action='store_true');args=parser.parse_args()
    if args.run:subprocess.run([sys.executable,'-B',str(ROOT/'run_release1103_checks.py'),*ALL,'--keep-going'],check=True)
    else:print('\n'.join(ALL))
