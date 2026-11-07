"""Advance mobile release identity while retaining save/package continuity."""
import json,re
from sync1104_tools import *
from create_project import load

def main():
    (ROOT/'release_config.py').write_text('"""Standalone Hardmode application identity."""\nVERSION = \'1.1.4\'\nBUILD = 18\nDIRECTORY = \'release1104\'\nPACKAGE = \'com.arkintide.nuclearthronehardmode\'\n','utf8')
    for platform in ('windows','android','ios'):
        relative=f'options/{platform}/options_{platform}.yy';data=load(PROJECT/relative)
        for key in data:
            if key==f'option_{platform}_version':data[key]='1.1.4.0' if platform=='windows' else '1.1.4'
            elif key in (f'option_{platform}_version_code',f'option_{platform}_build_number'):data[key]=18
            elif isinstance(data[key],str) and 'Hardmode 1.1.3' in data[key]:data[key]=data[key].replace('Hardmode 1.1.3','Hardmode 1.1.4')
        save(relative,json.dumps(data,ensure_ascii=False,indent=2)+'\n')
    relative='objects/UberCont/Create_0.gml';text=(PROJECT/relative).read_text('utf8')
    text,n=re.subn(r'#macro GAME_VERSION "Hardmode [^"]+"','#macro GAME_VERSION "Hardmode 1.1.4"',text);assert n==1
    save(relative,text)

if __name__=='__main__':main()
