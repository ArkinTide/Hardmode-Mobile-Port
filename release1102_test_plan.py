"""Targeted final-VM acceptance matrix for the incremental 1.1.2 mobile sync."""
from pathlib import Path
import argparse,subprocess,sys

ROOT=Path(__file__).resolve().parent
REQUIRED=[
 *[f'sewers,2,3,{rate},40,42,sync112water' for rate in (30,60)],
 *[f'scorpionboss,1,{loop},{rate},50,42,sync112roll' for loop in (0,1,3) for rate in (30,60)],
 *[f'scorpionboss,1,3,{rate},50,42,sync112ball' for rate in (30,60)],
 *[f'scorpionboss,1,3,{rate},50,42,sync112rocket' for rate in (30,60)],
 *[f'scorpionboss,1,{loop},{rate},650,42,sync112chief' for loop in (1,3) for rate in (30,60)],
 *[f'scorpionboss,1,3,{rate},60,42,sync112portrait' for rate in (30,60)],
 *[f'elevator,3,{loop},{rate},900,42,sync112exit' for loop in (1,3) for rate in (30,60)],
 *[f'1,1,0,{rate},90,42,sync111boot' for rate in (30,60)],
 *[f'sewers,2,3,{rate},400,81,sync111vanmap' for rate in (30,60)],
 '1,1,1,60,400,43,sync111van',
 *[f'1,1,{loop},60,650,42,sync111phase' for loop in (1,3)],
 '1,1,3,60,450,42,sync111camera','1,1,3,60,80,42,sync111disabled',
 '1,1,1,60,150,42,sync111title','1,1,1,60,150,42,sync111titleenglish',
 'throne,1,3,60,90,43,syncthrone','palace,4,0,60,400,42,vault110',
 'cavesinv,3,0,60,180,42,cave112',
]
NATIVE=['compiler','runtime','actors','modules','world','artwork']
ALL=REQUIRED+[f'native:{kind}' for kind in NATIVE]+['menu:30','menu:60']

if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--run',action='store_true');args=parser.parse_args()
    if args.run:subprocess.run([sys.executable,'-B',str(ROOT/'run_release1102_checks.py'),*ALL,'--keep-going'],check=True)
    else:print('\n'.join(ALL))
