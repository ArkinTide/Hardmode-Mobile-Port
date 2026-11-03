"""Mobile lifecycle integration after register_sync1100; safe to repeat."""
import json,re
from pathlib import Path
from create_project import load
from register_native import ROOT,PROJECT,register_script,write

def edit(path,old,new):
    text=(PROJECT/path).read_text('utf8')
    if new in text:return
    assert text.count(old)==1,(path,old,text.count(old))
    write(path,text.replace(old,new,1))

def main():
    project=load(PROJECT/'nuclearthronemobile.yyp')
    content=(ROOT/'native/content1100.gml').read_text('utf8')
    # Only draw-event introspection is used; include inherited draw events.
    objects={p.stem:load(p) for p in (PROJECT/'objects').glob('*/*.yy')}
    def draws(name):
        obj=objects[name]
        if any(e['eventType']==8 and e['eventNum']==0 for e in obj['eventList']):return True
        parent=obj.get('parentObjectId')
        return draws(parent['name']) if parent else False
    content+='\nfunction scrHMObjectHasEvent1100(_object,_event,_number) {\nif(_event!=ev_draw||_number!=0) return false;\nreturn array_contains(['+','.join(n for n in objects if draws(n))+'],_object);\n}\n'
    register_script(project,'scrHMContent1100',content)
    register_script(project,'scrHMRepairs107',(ROOT/'native/repairs107.gml').read_text('utf8'))
    edit('scripts/macros_gameplay/macros_gameplay.gml','#macro PLAYER_LEVEL_MAX scrCustomParam("maxlevel", 10)','#macro PLAYER_LEVEL_MAX scrHMLevelCap1100()')
    edit('objects/GameCont/Step_0.gml','if lockstep_stop','scrHMContentInit1100();scrHMContentBegin1100();\nif lockstep_stop')
    edit('objects/GameCont/Step_0.gml','scrHMRadiationSyncWorld();','// Native 1.1.0 policy runs once in the main module before absorption.')
    edit('scripts/scrHMRadiation/scrHMRadiation.gml','function scrHMRadiationSync(_below_maximum) {','function scrHMRadiationSync(_below_maximum) {hm_arkintide_mod_gml_hm_radiation(_below_maximum);}\nfunction scrHMRadiationSyncLegacy1100(_below_maximum) {')
    # Earlier positional repairs must not relocate the new double length hall.
    for path,call in [('objects/GenCont/Alarm_1.gml','scrHMThroneEntrance109();'),('objects/GenCont/Destroy_0.gml','scrHMThroneEntrance110();')]:
        edit(path,call,'// 1.1.0: generated floor bounds own throne placement.')
    # Keep all weapons from a chest valid while forcing its access tool.
    edit('objects/WeaponChest/Collision_Player.gml','_wep = scrDecideWep(_extra, curse)','_wep = scrHMToolWeapon1100(scrDecideWep(_extra, curse))')
    edit('objects/BigWeaponChest/Collision_Player.gml','_wep = scrDecideWep(1, false)','_wep = scrHMToolWeapon1100(scrDecideWep(1, false))')
    edit('scripts/scrPopEnemies/scrPopEnemies.gml','scrHMAreaCall(GameCont.area,"area_pop_enemies");scrHMVanillaLoopPopulate111();return;',
         'scrHMAreaCall(GameCont.area,"area_pop_enemies");scrHMLoopPopulationFallback1100();return;')
    edit('objects/Portal/Collision_Player.gml','if lockstep_stop','scrHMPortalStyle1100(id);\nif lockstep_stop')
    edit('objects/Portal/Collision_Player.gml','close = true','close = true\n\tscrHMPortalStyle1100(id);')
    # Choose the transition before SpiralCont creates its prewarmed rings.
    edit('objects/SpiralCont/Create_0.gml','// [60帧适配] 预热循环','if(scrHMEnabled() && (variable_instance_get(GameCont,"hm_transition_idpd")??false)) type=SpiralType.IDPD;\n\n// [60帧适配] 预热循环')
    edit('objects/VanSpawn/Draw_0.gml','scrHMVanWarning108();','// The native 1.1.0 overlay supplies the single animated warning.')
    edit('scripts/scrHMWorld/scrHMWorld.gml','var _menu=(_code==scrHMScriptRef(hm_maincode_mod_gml_shilling)',
         'var _menu=(_code==scrHMScriptRef(hm_arkintide_mod_gml_hm_van_warning)\n        ||_code==scrHMScriptRef(hm_arkintide_mod_gml_hm_throne_fall_draw)\n        ||_code==scrHMScriptRef(hm_maincode_mod_gml_shilling)')
    edit('objects/enemy/Destroy_0.gml','hm_no_revive109=other.object_index==TechnoMancer;','hm_no_revive109=other.object_index==TechnoMancer || (other[$ "hm_extra_kind"]??"")=="tech";')
    edit('scripts/scrHMWorld/scrHMWorld.gml','if(scrHMAdvanceDestination107()) return;','if(scrHMAdvanceDestination107()) return;\n    // Native explicit destinations share the existing mobile transition path.\n    var _destination=self[$ "hm_destination"]??"";\n    if(_destination!="") {hm_destination107=scrHMAreaResolve(_destination);hm_destination_sub107=1;hm_destination="";if(scrHMAdvanceDestination107()) return;}')
    edit('scripts/scrHMWorld/scrHMWorld.gml','global.hm_tasks=[];\n    with(HMWorld) scrHMHook("game_start");','global.hm_tasks=[];\n    scrHMContentInit1100();hm_arkintide_mod_gml_hm_progression_start();\n    with(HMWorld) scrHMHook("game_start");')
    # Mobile options retain their own touch layout and mutation selector.
    edit('scripts/scrHMMobile/scrHMMobile.gml','"flames","ratrevive"]','"flames","ratrevive","bossbars","throneballs","playerboost"]')
    edit('scripts/scrHMMobile/scrHMMobile.gml','"MOD FLAME EFFECTS","RATS REVIVE AS GREEN RATS"]','"MOD FLAME EFFECTS","RATS REVIVE AS GREEN RATS","BOSS HEALTH BARS","DEFLECT THRONE BALLS","PLAYER BOOST (+2 HP, +1 LEVEL)"]')
    tests=(PROJECT/'scripts/scrHMGameplayTests/scrHMGameplayTests.gml').read_text('utf8')
    tests=tests.replace('"flames","ratrevive"];','"flames","ratrevive","bossbars","throneballs","playerboost"];')
    tests=tests.replace('array_length(_settings)==9,"settings file has all fields"','array_length(_settings)==13,"settings file has all fields"')
    if 'scrHMGameplaySync1100();' not in tests:
        tests=tests.replace('ticks++;','ticks++;\n        if(string_pos("sync",mode)==1) scrHMGameplaySync1100();',1)
    tests=tests.split('// Synchronization tests 1.1.0')[0]+'\n// Synchronization tests 1.1.0\n'+(ROOT/'tests/sync1100.gml').read_text('utf8')
    register_script(project,'scrHMGameplayTests',tests)
    edit('scripts/scrHMMenuTests/scrHMMenuTests.gml','_menu.item_count==8,"eight single-player MOD options including persisted rat revival"',
         '_menu.item_count==11,"eleven touch-accessible MOD settings without duplicate Grillskills"')
    # The helper and Bossbar modules extend the 45-module mobile baseline.
    for name in ('scrHMRuntimeTests','scrHMWorldTests','scrHMModulesTests','scrHMMenuTests'):
        path=PROJECT/'scripts'/name/(name+'.gml')
        text=path.read_text('utf8').replace('global.hm_module_order)==45','global.hm_module_order)==47').replace('global.hm_module_order)!=45','global.hm_module_order)!=47').replace('modules:45','modules:array_length(global.hm_module_order)')
        path.write_text(text,'utf8')
    for name in ('runtime-native.gml','world-native.gml','modules-native.gml','menu-native.gml'):
        path=ROOT/'tests'/name
        text=path.read_text('utf8').replace('global.hm_module_order)==45','global.hm_module_order)==47').replace('global.hm_module_order)!=45','global.hm_module_order)!=47').replace('modules:45','modules:array_length(global.hm_module_order)')
        path.write_text(text,'utf8')
    write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
    print('Mobile synchronization host integration registered')

if __name__=='__main__':main()
