"""Register the five Windows field-report fixes without replaying old passes."""
from pathlib import Path
import json,re
from register_native import ROOT,PROJECT,register_script,write
from create_project import load

def replace(p,old,new):
    t=(PROJECT/p).read_text(encoding='utf8')
    if new in t:return
    assert t.count(old)==1,(p,old,t.count(old))
    write(p,t.replace(old,new,1))

def main():
    project=load(PROJECT/'nuclearthronemobile.yyp')
    register_script(project,'scrHMRepairs112',(ROOT/'native/repairs112.gml').read_text(encoding='utf8'))
    obj=load(PROJECT/'objects/UberCont/UberCont.yy')
    for number,up in [(60,'true'),(61,'false')]:
        if not any(e['eventType']==6 and e['eventNum']==number for e in obj['eventList']):
            obj['eventList'].append({'$GMEvent':'v1','%Name':'','collisionObjectId':None,'eventNum':number,
                'eventType':6,'isDnD':False,'name':'','resourceType':'GMEvent','resourceVersion':'2.0'})
        write(f'objects/UberCont/Mouse_{number}.gml',f'scrHMWheelEvent112({up});\n')
    write('objects/UberCont/UberCont.yy',json.dumps(obj,indent=2)+'\n')
    replace('objects/UberCont/Step_0.gml','input_tick()','input_tick()\nscrHMWheelPoll112();')
    # Begin Step owns the frame counter; normal Step owns the polling sample.
    replace('scripts/scrHMRepairs111/scrHMRepairs111.gml',
        'scrDesktopWheelSwap(_index,mouse_wheel_up(),mouse_wheel_down());','// Wheel events and the post-input normal Step poll own sampling (1.0.12).')
    replace('scripts/scrHMRepairs103/scrHMRepairs103.gml','scrHMCaveWallWave111(_floor);','scrHMCaveWalls112(_floor);')
    replace('scripts/scrHMRepairs103/scrHMRepairs103.gml','function scrHMMusicRoom() {','function scrHMMusicRoom() {return scrHMMusicRoom112();}\nfunction scrHMMusicRoom103Legacy() {')
    replace('scripts/scrHMAPI/scrHMAPI.gml','hm_music_desired=_next;','hm_music_desired=_next;\n        hm_music_area112=instance_exists(GameCont)?GameCont.area:area_campfire;')
    replace('scripts/scrHMRepairs105/scrHMRepairs105.gml','var _water=scrHMWaterAt(x,y)', 'var _water=scrHMSwimSupported112(x,y)')
    replace('scripts/scrHMRepairs104/scrHMRepairs104.gml','var _water=scrHMWaterExact109(x,y)', 'var _water=scrHMSwimSupported112(x,y)')
    # A wet logical floor without a live visual water surface is dry onscreen.
    replace('scripts/scrHMRepairs109/scrHMRepairs109.gml','if(_f.traction!=2 || scrHMWaterBank111(_f,_x,_y)) return false;',
        'if(_f.traction!=2 || !instance_exists(_f[$ "hm_water_surface111"]??noone) || scrHMWaterBank111(_f,_x,_y)) return false;')
    # Startup runs before HMWorld enables the MOD. This standalone build
    # must apply its Windows clock even on the first launch.
    p='scripts/scrInit/scrInit.gml'
    init=(PROJECT/p).read_text(encoding='utf8')
    init=re.sub(r'display_reset\(0, opt_vsync\)(?:\s*(?:if\(scrHMEnabled\(\)\) )?scrHMDesktopTiming112\(\);)*',
        'display_reset(0, opt_vsync)\n            scrHMDesktopTiming112();',init)
    write(p,init)
    replace('objects/UberCont/Step_0.gml','display_reset(display_aa, opt_vsync)',
        'display_reset(display_aa, opt_vsync)\n            scrHMDesktopTiming112();')
    replace('scripts/scrHMStorage/scrHMStorage.gml','var _prefix="--hardmode-test-root=";',
        'var _probe=filename_path(parameter_string(0));\n        if(file_exists(_probe+"live112.marker")) {game_directory=_probe+"state/";return;}\n        var _prefix="--hardmode-test-root=";')
    options=load(PROJECT/'options/windows/options_windows.yy')
    options['option_windows_version']='1.0.12.0';options['option_windows_sleep_margin']=1
    options['option_windows_description_info']='Nuclear Throne: Hardmode 1.0.12'
    write('options/windows/options_windows.yy',json.dumps(options,indent=2)+'\n')
    p='objects/UberCont/Create_0.gml';t=(PROJECT/p).read_text(encoding='utf8')
    write(p,re.sub(r'#macro GAME_VERSION "Hardmode [^"]+"','#macro GAME_VERSION "Hardmode 1.0.12"',t))
    # Dedicated UI probe has its own copied EXE/data and isolated save marker.
    p=ROOT/'tests/gameplay.gml';t=p.read_text(encoding='utf8')
    for old,new in [
        ('if(!_enabled) return;','if(file_exists(game_directory+"live112.marker")) _enabled=true;\n    if(!_enabled) return;'),
        ('if(!_enabled) return false;','if(file_exists(game_directory+"live112.marker")) {_enabled=true;_scenario="1,1,0,60,18000,42,live112";}\n    if(!_enabled) return false;'),
        ('if(mode=="windows110") scrHMGameplayWindows110();','if(mode=="live112" || string_pos("112",mode)>0) scrHMGameplayRepairs112();\n        if(mode=="windows110") scrHMGameplayWindows110();')]:
        if new not in t:
            assert t.count(old)==1,(p,old)
            t=t.replace(old,new,1)
    p.write_text(t,encoding='utf8')
    # Keep the automatic test-root override independent of the user's save.
    p=ROOT/'register_gameplay_tests.py';t=p.read_text(encoding='utf8')
    if "'tests/repairs112.gml'" not in t:
        t=t.replace("'tests/repairs111.gml']","'tests/repairs111.gml','tests/repairs112.gml']")
        p.write_text(t,encoding='utf8')
    write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
    (ROOT/'release_config.py').write_text('"""Standalone Hardmode application identity."""\nVERSION = \'1.0.12\'\nBUILD = 13\nDIRECTORY = \'release112\'\nPACKAGE = \'com.arkintide.nuclearthronehardmode\'\n',encoding='utf8')
    print('1.0.12 follow-up fixes registered')

if __name__=='__main__':main()
