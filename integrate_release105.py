"""Apply 1.0.5 to the maintained project after previous integrations."""
import json
from create_project import load
from register_native import ROOT,PROJECT,register_script,replace,write

project=load(PROJECT/'nuclearthronemobile.yyp')
register_script(project,'scrHMRepairs105',(ROOT/'native/repairs105.gml').read_text(encoding='utf8'))

def append(path, marker, code):
    text=(PROJECT/path).read_text(encoding='utf8')
    if marker not in text: write(path,text+'\n'+marker+'\n'+code+'\n')

# Preserve the world across both menu cancellation and victory cleanup.
replace('objects/BackButton/Other_10.gml',
    'if object_index != MusCont && object_index != UberCont && object_index != Console',
    'if object_index != HMWorld && object_index != MusCont && object_index != UberCont && object_index != Console')
replace('objects/SitDown/Alarm_0.gml',
    'if (object_index == UberCont || object_index == GameCont',
    'if (object_index == HMWorld || object_index == UberCont || object_index == GameCont')

replace('scripts/scrHMWorld/scrHMWorld.gml',
    '||_code==scrHMScriptRef(hm_maincode_mod_gml_spacesewerboi));',
    '||_code==scrHMScriptRef(hm_maincode_mod_gml_spacesewerboi)\n        ||_code==scrHMScriptRef(hm_enemies_mod_gml_bigcrystaltopdraw));')

replace('scripts/scrHMRepairs104/scrHMRepairs104.gml',
    'else if(object_index!=CustomEnemy && speed>timescale) speed=timescale;',
    'else if(object_index!=Player && object_index!=CustomEnemy && speed>timescale) speed=timescale;')
replace('objects/Player/Step_0.gml','if (!visible || scrGameIsLockState()) exit',
    'if (!visible || scrGameIsLockState()) exit\nscrHMSwimPlayer105();')
replace('objects/Player/Step_0.gml','scrHMSwimPlayer105();',
    'scrHMSwimPlayer105();\nif(instance_exists(HMGameplayTest)) scrHMGameplayInput105();')
append('objects/Player/Step_0.gml','// Consistent water speed after input and ground friction.', 'scrHMSwimSpeed105();')
# Foot position has already advanced by EndStep. Restore the full renderer
# on this frame, including the intervening 60 FPS render frame.
p='objects/Player/Player.yy';obj=load(PROJECT/p)
if not any(e['eventType']==3 and e['eventNum']==2 for e in obj['eventList']):
    obj['eventList'].append({'$GMEvent':'v1','%Name':'','collisionObjectId':None,'eventNum':2,'eventType':3,'isDnD':False,'name':'','resourceType':'GMEvent','resourceVersion':'2.0'})
    write(p,json.dumps(obj,indent=2)+'\n')
append('objects/Player/Step_2.gml' if (PROJECT/'objects/Player/Step_2.gml').exists() else 'objects/Player/Step_2.gml', '// Water membership follows this frame movement.', 'if(!lockstep_stop && !UberCont.paused) scrHMSwimPlayer105();') if (PROJECT/'objects/Player/Step_2.gml').exists() else write('objects/Player/Step_2.gml','// Water membership follows this frame movement.\nif(!lockstep_stop && !UberCont.paused) scrHMSwimPlayer105();\n')

# Keep fill collision; its background color already comes from the area.
p='objects/SubTopCont/Draw_0.gml';text=(PROJECT/p).read_text(encoding='utf8')
text=text.replace('with _list[| i] {\n\t\tdraw_sprite_part_ext', 'with _list[| i] {\n        if(scrHMEnabled() && scrHMInteriorEdge105()) continue;\n\t\tdraw_sprite_part_ext')
text=text.replace('with(_list[| _wall]) {\n\tdraw_sprite_ext', 'with(_list[| _wall]) {\n    if(scrHMEnabled() && scrHMInteriorEdge105()) continue;\n\tdraw_sprite_ext')
write(p,text)

# Newly authored rooms/open doors may create floor after static collision
# fill. Remove just the synthetic cells covered by that floor, leaving real
# boundary walls and the MOD's own explicit destruction rules untouched.
p='objects/Floor/Create_0.gml';text=(PROJECT/p).read_text(encoding='utf8')
if 'scrHMCarveFill105(32);' not in text:
    write(p,text.replace('image_speed = 0','scrHMCarveFill105(32);\nimage_speed = 0',1))
p='objects/FloorExplo/Create_0.gml';text=(PROJECT/p).read_text(encoding='utf8')
if not text.startswith('scrHMCarveFill105(16);'):
    write(p,'scrHMCarveFill105(16);\n'+text)

# Repair landings before the native RavenFly->Raven conversion, retaining
# HP/AI/animation and never killing a legitimate wall enemy.
replace('objects/RavenFly/Other_10.gml','/// @description Perform landing',
    '/// @description Perform landing\nscrHMRavenLand105();')
replace('scripts/scrHMRepairs103/scrHMRepairs103.gml',
    'Grunt,Inspector,Shielder];', 'Grunt,Inspector,Shielder,EliteGrunt,EliteInspector,EliteShielder,PopoFreak,Raven];')
append('objects/HostileHorror/Create_0.gml','// Every palace spawn uses the b24 small Horror contract.',
    'if(scrHMEnabled() && instance_exists(GameCont) && GameCont.area==scrHMAreaResolve("palace")) scrHMPalaceHorrorInit();')

# Freeze tasks/world hooks too. Actor guards alone left the whole MOD's
# scene scans and particle emitters running underneath a static portrait.
replace('scripts/scrHMWorld/scrHMWorld.gml',
    '// Resume only the tasks retained by this room.',
    'if(instance_exists(self[$ "hm_portrait_active"]??noone)) return;\n    // Resume only the tasks retained by this room.')
replace('scripts/scrHMWorld/scrHMWorld.gml',
    'function scrHMHook(_hook) {\n    if(!scrHMEnabled()) return;',
    '''function scrHMHook(_hook) {
    if(!scrHMEnabled()) return;
    if(instance_exists(HMWorld) && instance_exists(variable_instance_get(HMWorld,"hm_portrait_active")??noone)) {
        if(_hook=="draw_gui") scrHMInvokeHere(scrHMScriptRef(hm_bosses_bossintros_mod_gml_draw_gui),[]);
        return;
    }''')
replace('scripts/scrHMWorld/scrHMWorld.gml',
    'if(hm_menu_overlay && (!instance_exists(creator)||hm_refresh_tick!=HMWorld.logic_serial))',
    'if(hm_menu_overlay && (!instance_exists(creator)||(hm_refresh_tick!=HMWorld.logic_serial && !instance_exists(variable_instance_get(HMWorld,"hm_portrait_active")??noone))))')
replace('scripts/scrHMRepairs104/scrHMRepairs104.gml',
    '_intro.hm_portrait_records=_records;',
    '_intro.hm_portrait_records=_records;HMWorld.hm_portrait_active=_intro;')
replace('scripts/scrHMRepairs104/scrHMRepairs104.gml',
    'hm_portrait_records=[];',
    'hm_portrait_records=[];HMWorld.hm_portrait_active=noone;')
append('objects/HMWorld/Other_5.gml','// Portrait ownership never survives a room.', 'hm_portrait_active=noone;')
write('objects/HMWorld/Draw_0.gml','if(!lockstep_stop) scrHMDrawHooks105(false);\n')
write('objects/HMWorld/Draw_64.gml','if(!lockstep_stop) scrHMDrawHooks105(true);\n')

# Synthetic static collision has no Alarm events. At 60 FPS, visiting its
# twelve permanently disabled timers multiplied the base compensation scan.
replace('objects/UberCont/Step_1.gml','with (all) {\n\t\t\tfor (var _i',
    'with (all) {\n            if(scrHMEnabled() && object_index==Wall && (self[$ "hm_interior_wall"]??false)) continue;\n\t\t\tfor (var _i')

# Application identity only; GAME_BUILD remains the save schema 3004.
from release_config import VERSION,BUILD
import re
for platform in ('windows','android','ios'):
    p=f'options/{platform}/options_{platform}.yy';data=load(PROJECT/p)
    data[f'option_{platform}_version']=VERSION+('.0' if platform=='windows' else '')
    if platform=='ios':data['option_ios_build_number']=BUILD
    write(p,json.dumps(data,indent=2)+'\n')
p='objects/UberCont/Create_0.gml'
text=(PROJECT/p).read_text(encoding='utf8')
write(p,re.sub(r'#macro GAME_VERSION "[^\"]+"',f'#macro GAME_VERSION "Hardmode {VERSION}"',text))
manifest=ROOT/'platforms/android/gradle-project/com.arkintide.nuclearthronehardmode/src/main/AndroidManifest.xml'
text=manifest.read_text(encoding='utf8')
text=re.sub(r'android:versionCode="\d+"',f'android:versionCode="{BUILD}"',text)
text=re.sub(r'android:versionName="[^\"]+"',f'android:versionName="{VERSION}"',text)
manifest.write_text(text,encoding='utf8')

write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
print('Registered Hardmode 1.0.5')
