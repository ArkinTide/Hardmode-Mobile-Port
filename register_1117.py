"""Register only this release's maintained helpers and regression hooks."""
from pathlib import Path
import json,re
from create_project import load

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT/'project'
RESOURCES={
 'scrHMClock1117':'native/clock1117.gml',
 'scrHMChief1117':'native/chief1117.gml',
 'scrHMGameplayClock1117':'tests/clock1117.gml',
 'scrHMGameplayChief1117':'tests/chief1117.gml',
 'scrHMGameplayPresentation1117':'tests/presentation1117.gml',
}

def replace(path,old,new):
    path=PROJECT/path;text=path.read_text('utf8')
    if new in text:return
    assert text.count(old)==1,(path,old)
    path.write_text(text.replace(old,new),'utf8')

def main():
    for source in RESOURCES.values():assert (ROOT/source).is_file(),source
    project=load(PROJECT/'nuclearthronemobile.yyp')
    template=load(PROJECT/'scripts/scrHMRepairs1116Runtime/scrHMRepairs1116Runtime.yy')
    for name,source in RESOURCES.items():
        folder=PROJECT/'scripts'/name;folder.mkdir(exist_ok=True)
        data=dict(template);data['name']=data['%Name']=name
        (folder/f'{name}.yy').write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n','utf8')
        (folder/f'{name}.gml').write_text((ROOT/source).read_text('utf8'),'utf8')
        relative=f'scripts/{name}/{name}.yy'
        if not any(x['id']['path']==relative for x in project['resources']):
            project['resources'].append({'id':{'name':name,'path':relative}})
    (PROJECT/'nuclearthronemobile.yyp').write_text(json.dumps(project,ensure_ascii=False,indent=2)+'\n','utf8')
    replace('objects/UberCont/Step_1.gml','scrHMClockBegin1117();',
        'scrHMClockTestGlobalBegin1117();\nscrHMClockBegin1117();')
    replace('objects/HMGameplayTest/Step_1.gml','hm_frame_start106=get_timer();',
        'hm_frame_start106=get_timer();scrHMClockTestBegin1117();')
    replace('objects/Player/Step_0.gml','if(instance_exists(HMGameplayTest)) scrHMGameplayInput105();',
        'if(instance_exists(HMGameplayTest)) {scrHMGameplayInput105();scrHMClockTestPlayerInput1117();}')
    replace('objects/HMGameplayTest/Step_2.gml','scrHMGameplayTestStep();',
        'scrHMGameplayTestStep();scrHMClockTestEnd1117();scrHMGameplayChief1117();scrHMGameplayPresentation1117();')
    replace('objects/HMGameplayTest/Draw_73.gml','scrHMPerf111Draw();',
        'scrHMPerf111Draw();scrHMGameplayPresentationDraw1117();')
    for platform in ('windows','android','ios'):
        path=PROJECT/f'options/{platform}/options_{platform}.yy';data=load(path)
        for key in data:
            if key==f'option_{platform}_version':data[key]='1.1.7.0' if platform=='windows' else '1.1.7'
            elif key in (f'option_{platform}_version_code',f'option_{platform}_build_number'):data[key]=21
            elif isinstance(data[key],str):data[key]=data[key].replace('Hardmode 1.1.6','Hardmode 1.1.7')
        path.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n','utf8')
    path=PROJECT/'objects/UberCont/Create_0.gml';text=path.read_text('utf8')
    text,n=re.subn(r'#macro GAME_VERSION "Hardmode [^"]+"','#macro GAME_VERSION "Hardmode 1.1.7"',text);assert n==1
    path.write_text(text,'utf8')
    (ROOT/'release_config.py').write_text('"""Standalone Hardmode application identity."""\nVERSION = \'1.1.7\'\nBUILD = 21\nDIRECTORY = \'release1107\'\nPACKAGE = \'com.arkintide.nuclearthronehardmode\'\n','utf8')
    print('Registered 1.1.7 helpers, native test hooks and identity')

if __name__=='__main__':main()
