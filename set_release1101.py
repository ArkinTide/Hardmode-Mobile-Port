"""Set the mobile content release identity without replaying earlier repairs."""
from pathlib import Path
import json,re
from create_project import load
ROOT=Path(__file__).resolve().parent
def main():
    (ROOT/'release_config.py').write_text('"""Standalone Hardmode application identity."""\nVERSION = \'1.1.1\'\nBUILD = 15\nDIRECTORY = \'release1101\'\nPACKAGE = \'com.arkintide.nuclearthronehardmode\'\n','utf8')
    for platform in ('windows','android','ios'):
        p=ROOT/f'project/options/{platform}/options_{platform}.yy';data=load(p)
        for key in list(data):
            if key==f'option_{platform}_version':data[key]='1.1.1.0' if platform=='windows' else '1.1.1'
            elif key==f'option_{platform}_version_code':data[key]=15
            elif key==f'option_{platform}_build_number':data[key]=15
            elif isinstance(data[key],str) and 'Hardmode 1.0.12' in data[key]:data[key]=data[key].replace('Hardmode 1.0.12','Hardmode 1.1.1')
        p.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n','utf8')
    p=ROOT/'project/objects/UberCont/Create_0.gml';s=p.read_text('utf8')
    s,n=re.subn(r'#macro GAME_VERSION "Hardmode [^"]+"','#macro GAME_VERSION "Hardmode 1.1.1"',s);assert n==1
    p.write_text(s,'utf8')
    print('Hardmode 1.1.1 / build 15 identity set')
if __name__=='__main__':main()
