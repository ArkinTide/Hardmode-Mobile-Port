"""Identify the complete Tuesday-onward mobile synchronization."""
import json,re
from sync1103_tools import ROOT,PROJECT,save
from create_project import load

def main():
    (ROOT/'release_config.py').write_text('"""Standalone Hardmode application identity."""\nVERSION = \'1.1.3\'\nBUILD = 17\nDIRECTORY = \'release1103\'\nPACKAGE = \'com.arkintide.nuclearthronehardmode\'\n','utf8')
    for platform in ('windows','android','ios'):
        relative=f'options/{platform}/options_{platform}.yy';data=load(PROJECT/relative)
        for key in list(data):
            if key==f'option_{platform}_version':data[key]='1.1.3.0' if platform=='windows' else '1.1.3'
            elif key in (f'option_{platform}_version_code',f'option_{platform}_build_number'):data[key]=17
            elif isinstance(data[key],str) and 'Hardmode 1.1.2' in data[key]:data[key]=data[key].replace('Hardmode 1.1.2','Hardmode 1.1.3')
        save(relative,json.dumps(data,ensure_ascii=False,indent=2)+'\n')
    relative='objects/UberCont/Create_0.gml';text=(PROJECT/relative).read_text('utf8')
    text,count=re.subn(r'#macro GAME_VERSION "Hardmode [^"]+"','#macro GAME_VERSION "Hardmode 1.1.3"',text);assert count==1
    save(relative,text);print('Hardmode 1.1.3 / build17 identity set')

if __name__=='__main__':main()
