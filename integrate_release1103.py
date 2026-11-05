"""Incremental mobile synchronization from the November 3 17:36 boundary."""
import json,re
from sync1103_tools import *
from create_project import load
from register_native import register_script
import sync1103_bosses_integrate
import import_assets1103

HELPER='scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml'
CONTENT='scripts/scrHMContent1100/scrHMContent1100.gml'
WORLD='scripts/scrHMWorld/scrHMWorld.gml'
MAIN='scripts/scrHMCompiled_maincode_mod_gml/scrHMCompiled_maincode_mod_gml.gml'

def register(project,name,source):
    # Preserve old resources independently of the first integration backup.
    for suffix in ('.yy','.gml'):
        relative=f'scripts/{name}/{name}{suffix}'
        path=PROJECT/relative
        if path.exists():save(relative,path.read_text('utf8'))
    register_script(project,name,source)

def main():
    assert (OUT/'baseline-source.json').exists(),'Freeze the published mobile baseline first'
    project=load(PROJECT/'nuclearthronemobile.yyp')
    # instance_change(false) deliberately preserves the native object's HP and
    # rendering. Supply only the common actor schema when Create was skipped.
    replace_function(CONTENT,'scrHMContentChange1100',
        'instance_change(_object,_events);\n'
        'if(array_contains([CustomObject,CustomEnemy,CustomHitme,CustomProjectile],_object)\n'
        '   && !(self[$ "hm_custom_actor"]??false)) scrHMActorInit();')
    replace_function('scripts/scrHMActors/scrHMActors.gml','scrHMActorCleanup',
        body((ROOT/'native/actors.gml').read_text('utf8'),'scrHMActorCleanup'))
    register(project,'scrHMActorTests',(ROOT/'tests/actors-native.gml').read_text('utf8'))
    # Repairs112 and its Jungle helper are upserted as complete definitions
    # by the incremental test bridge at the end of this integration.
    for name,file in [('scrHMSync1103Routes','routes'),('scrHMSync1103Chest','chest'),
                      ('scrHMSync1103Ultra','ultra'),('scrHMSync1103Spawn','spawn'),
                      ('scrHMSync1103Performance','performance')]:
        register(project,name,(ROOT/'native'/f'sync1103_{file}.gml').read_text('utf8'))
    sync1103_bosses_integrate.apply(project,save,edit,replace_function,register)
    import_assets1103.apply(project)
    # Keep the established real-entry regression in the final VM. Its tube
    # check excludes maskless devices, which are not physical obstructions.
    register(project,'scrHMGameplay1102',(ROOT/'tests/repairs1102.gml').read_text('utf8'))

    # One complete Chief burst owns all ten-plus-Loop directions. Keep the
    # untouched native burst as the disabled-Hardmode fallback, with the real
    # Destroy event still owning its drop, sound and PortalClear effects.
    chief='scripts/scrHMRepairs1102/scrHMRepairs1102.gml'
    replace_function(chief,'scrHMChiefBallBurst1102',body(
        (ROOT/'native/repairs1102.gml').read_text('utf8'),'scrHMChiefBallBurst1102'))
    relative='objects/LastBall/Destroy_0.gml'
    text=(PROJECT/relative).read_text('utf8')
    if 'if (!scrHMChiefBallBurst1102()) {' not in text:
        assert text.count('scrHMChiefBallBurst1102();')==1
        text=text.replace('\nscrHMChiefBallBurst1102();','')
        start=text.index('var _ang = random_angle, _spd = 4')
        save(relative,text[:start]+'if (!scrHMChiefBallBurst1102()) {\n'+text[start:].rstrip()+'\n}\n')
    assert 'scrHMChiefBallBurst1102();' not in (PROJECT/relative).read_text('utf8')
    register(project,'scrHMGameplay1103ChiefSpacing',
             (ROOT/'tests/sync1103_chief_spacing.gml').read_text('utf8'))
    relative='scripts/scrHMGameplayTests/scrHMGameplayTests.gml'
    call='if(mode=="sync113chiefspacing") scrHMGameplayChiefSpacing1103();'
    if call not in (PROJECT/relative).read_text('utf8'):
        anchor='if(string_pos("sync112",mode)==1) scrHMGameplay1102();'
        edit(relative,anchor,anchor+'\n        '+call)

    # Venus elevators replace floors inside one room. Preserve the mobile
    # cleanup before constructing the next map: ChestOpen inherits GameObject
    # and survives the MOD's prop/chestprop cleanup after the Y.C lounge.
    venus_setup='scrHMModCall("area", "venuz", "area_setup");\n'
    venus_setup+='scrHMModCall("area", "venuz", "area_make_floor");\n'
    venus_setup+='scrHMModCall("area", "venuz", "area_start");'
    edit('scripts/scrHMCompiled_props_mod_gml/scrHMCompiled_props_mod_gml.gml',
         venus_setup,'scrHMVenusCleanup108();\n'+venus_setup)

    # Only these three definitions are restored from the final native build.
    # Older mobile repairs and all other compiled modules remain in place.
    throne='scripts/scrHMCompiled_areas_throne_area_gml/scrHMCompiled_areas_throne_area_gml.gml'
    for name,source in emit_functions('areas/throne.area.gml',['area_setup','area_start','area_make_floor']).items():
        replace_function(throne,name,body(source,name))
    replace_function('scripts/scrHMRepairs110/scrHMRepairs110.gml','scrHMThroneEntrance110',
                     '// Original b24 area_start owns placement; no later adaptive repositioning.')
    for name,source in emit_functions('bosses/throne.mod.gml',['Throne2Destroy']).items():
        replace_function('scripts/scrHMCompiled_bosses_throne_mod_gml/scrHMCompiled_bosses_throne_mod_gml.gml',name,body(source,name))
    transform(MAIN,'hm_maincode_mod_gml_step_resume',lambda text:
              text.replace('hm_arkintide_mod_gml_hm_throne_fall(false);','').replace('hm_arkintide_mod_gml_hm_throne_fall(true);',''))
    edit('objects/Nothing2Death/Alarm_0.gml',
         'dir = instance_nearest((x - 16), (y - 16), Floor)\nwith(instance_create((dir.x + 16), (dir.y + 16), BigPortal))\ntype = 1',
         '// Preserve every native death effect/drop. The authored Hardmode fall owns its exit.\n'
         'if(!(scrHMEnabled() && GameCont.area==scrHMAreaResolve("throne"))) {\n'
         'dir = instance_nearest((x - 16), (y - 16), Floor)\n'
         'if(instance_exists(dir)) with(instance_create((dir.x + 16), (dir.y + 16), BigPortal)) type = 1\n}')
    edit('objects/NothingInactive/Step_0.gml',
         'audio_sound_set_track_position(amb, irandom(audio_sound_length(amb)))',
         'var _hm_amb_length1103=audio_sound_length(amb);\n'
         '\t    if(_hm_amb_length1103>0) audio_sound_set_track_position(amb, random(_hm_amb_length1103));')
    edit(HELPER,'((alarm[1] >= 0) && hm_arkintide_mod_gml_hm_stage_boss_alive())',
         '((alarm[1] >= 0) && (hm_arkintide_mod_gml_hm_stage_boss_alive() || scrHMThroneWinHeld1103()))')

    # Crown type is 3 on the mobile host; native NTT uses 2.
    replace_function(CONTENT,'scrHMCrownWatch1100','scrHMCrownWatch1103();')
    edit('objects/ProtoStatue/Destroy_0.gml','if rad > 24 {',
         'if rad > 24 {\n    if(scrHMEnabled()) scrHMCrownEntry1103();')
    transform('scripts/scrHMRepairs107/scrHMRepairs107.gml','scrHMAdvanceDestination107',
              lambda text:text if 'scrHMCrownDestination1103' in text else text.replace(
                  'lastarea=area;lastsubarea=subarea;area=_destination;',
                  'scrHMCrownDestination1103(_destination);\n    lastarea=area;lastsubarea=subarea;area=_destination;'))
    edit('objects/GameCont/Other_5.gml',
         'if(scrHMEnabled() && !_went_crib && scrHMAdvanceDestination107()) exit;',
         'if(scrHMEnabled() && !_went_crib) scrHMCrownExit1103();\n'
         'if(scrHMEnabled() && !_went_crib && scrHMAdvanceDestination107()) exit;')
    # Each transit observes the exact route before applying its own detour.
    old='if ((scrHMVariableExists(GameCont, "hm_crown_return") && GameCont.hm_crown_return)) {\nhm_arkintide_mod_gml_hm_crown_watch();\n}'
    for path in (PROJECT/'scripts').glob('scrHMCompiled_areas_*/*.gml'):
        text=path.read_text('utf8')
        if old in text:save(path.relative_to(PROJECT),text.replace(old,'scrHMCrownWatch1103();'))
    transform(MAIN,'hm_maincode_mod_gml_game_start',lambda text:
              text if 'scrHML2UltraReset1103();' in text else text+'\nscrHMCrownReset1103();scrHML2UltraReset1103();')
    # Apply only after destination validation, so a rejected goto is inert.
    edit('scripts/scrHMRepairs103/scrHMRepairs103.gml','    with(GameCont) {\n        area=_dest[0];',
         '    scrHMCrownReset1103();GameCont.hm_destination107=-1;GameCont.hm_destination_sub107=-1;\n    with(GameCont) {\n        area=_dest[0];')
    transform(HELPER,'hm_arkintide_mod_gml_hm_debug_goto',lambda text:
              text if 'scrHMCrownReset1103();' in text else text.replace('GameCont.hm_crown_return = 0;',
                  'scrHMCrownReset1103();GameCont.hm_destination107=-1;GameCont.hm_destination_sub107=-1;\nGameCont.hm_crown_return = 0;',1))

    # Device-owned exit and exact fifteen-pixel follow-up offset.
    replace_function('scripts/scrHMRepairs1102/scrHMRepairs1102.gml','scrHMElevatorStep1102','scrHMElevatorStep1103();')
    edit('scripts/scrHMCompiled_areas_elevator_area_gml/scrHMCompiled_areas_elevator_area_gml.gml',
         'scrHMMaxHealthWrite(id, 99999, "=");','scrHMMaxHealthWrite(id, 9999, "=");')
    edit('scripts/scrHMRepairs1102/scrHMRepairs1102.gml',
         '[scrHMAreaResolve("throne"),scrHMAreaResolve("venuz"),area_crib]',
         '[scrHMAreaResolve("throne"),scrHMAreaResolve("venuz"),scrHMAreaResolve("HQ"),area_hq,area_crib]')
    edit('objects/IDPDSpawn/Create_0.gml','GameCont.popolevel++',
         'if(scrHMThroneGateDefer1103()) exit;\nGameCont.popolevel++')
    edit('objects/IDPDSpawn/Step_0.gml','if lockstep_stop',
         'if(self[$ "hm_throne_gate_deferred1103"]??false) exit;\nif lockstep_stop')
    transform(HELPER,'hm_arkintide_mod_gml_hm_infantry_capture',lambda text:
              text if 'scrHMThroneArrivalWaiting1103' in text else 'if(scrHMThroneArrivalWaiting1103()) return;\n'+text)
    transform(HELPER,'hm_arkintide_mod_gml_hm_infantry_capture',lambda text:
              text if 'if(object_index!=IDPDSpawn) continue;' in text else text.replace(
                  'var _hml_sprite = sprite_index;',
                  'if(object_index!=IDPDSpawn) continue;\nvar _hml_sprite = sprite_index;',1))
    edit(WORLD,'    scrHMTasksTick(1);','    scrHMRouteTick1103();scrHML2UltraTick1103();\n    scrHMTasksTick(1);')

    # Native mobile chest identity/open events, with just one newest tool.
    replace_function(CONTENT,'scrHMToolChest1100','scrHMToolChest1103();')
    for object_name in ('WeaponChest','BigWeaponChest'):
        relative=f'objects/{object_name}/Collision_Player.gml'
        text=(PROJECT/relative).read_text('utf8')
        if 'scrHMToolChestBegin1103' not in text:
            text=text.replace('if scrChestOpened() exit','if scrChestOpened() exit\nvar _hm_tool_open1103=scrHMToolChestBegin1103();',1)
            # Remove only this wrapper, preserving its nested native decision.
            token='scrHMToolWeapon1100('
            while token in text:
                a=text.index(token);b=a+len(token);depth=1
                for i in range(b,len(text)):
                    if text[i]=='(':depth+=1
                    elif text[i]==')':
                        depth-=1
                        if depth==0:break
                text=text[:a]+text[b:i]+text[i+1:]
            at=text.rindex('instance_destroy()')
            text=text[:at]+'scrHMToolChestFinish1103(_hm_tool_open1103);\n'+text[at:]
            save(relative,text)

    # The mobile host keeps its own Ultra icons and touch interaction.
    end='scripts/scrHMCompiled_areas_end_area_gml/scrHMCompiled_areas_end_area_gml.gml'
    transform(end,'hm_areas_end_area_gml_area_finish',lambda text:
              text if 'scrHML2UltraGrant1103' in text else text+'\nscrHML2UltraGrant1103();')
    relative='objects/LevCont/Create_0.gml';text=(PROJECT/relative).read_text('utf8')
    if 'scrHML2UltraMenu1103();' not in text:save(relative,text+'\nscrHML2UltraMenu1103();\n')
    edit('objects/UltraIcon/Other_10.gml','if (!scrNeedMorePlayerUltras()) GameCont.ultrapoints --',
         'if (scrHML2UltraConfirm1103(_race,_num) || !scrNeedMorePlayerUltras()) GameCont.ultrapoints --')
    replace_function(HELPER,'hm_arkintide_mod_gml_hm_extra_population','scrHMExtraPopulation1103();')

    # Additional conservative water/Rad hooks live in their own audited adapter.
    import sync1103_performance_integrate
    sync1103_performance_integrate.apply(project,save,edit,replace_function,register)
    import followup1103_frog_integrate
    followup1103_frog_integrate.apply(project,save,edit,replace_function,register)
    register(project,'scrHMFollowup1103Walls',(ROOT/'native/followup1103_walls.gml').read_text('utf8'))
    register(project,'scrHMGameplay1103Walls',(ROOT/'tests/followup1103_walls.gml').read_text('utf8'))
    register(project,'scrHMGameplayFollowup1103AllAreas',(ROOT/'tests/followup1103_allareas.gml').read_text('utf8'))
    edit('objects/GenCont/Alarm_1.gml','scrHMCrownAltar109();',
         'scrHMCrownAltar109();\nif(scrHMEnabled()) scrHMStructureWallsFinalize1103();')
    register(project,'scrHMGameplay1103WaterIndex',(ROOT/'tests/followup1103_performance.gml').read_text('utf8'))
    relative='scripts/scrHMGameplayTests/scrHMGameplayTests.gml'
    call='if(mode=="profile106") scrHMGameplayWaterIndex113();'
    edit(relative,'if(string_pos("sync113",mode)==1) scrHMGameplayWaterIndex113();',call)
    edit(relative,'if(string_pos("sync113",mode)==1 || mode=="profile106") scrHMGameplayWaterIndex113();',call)
    if call not in (PROJECT/relative).read_text('utf8'):
        anchor='if(string_pos("sync112",mode)==1) scrHMGameplay1102();'
        edit(relative,anchor,anchor+'\n        '+call)
    call='scrHMGameplayFollowupWalls1103();'
    if call not in (PROJECT/relative).read_text('utf8'):
        anchor='if(string_pos("sync112",mode)==1) scrHMGameplay1102();'
        edit(relative,anchor,anchor+'\n        '+call)
    call='if(mode=="followup113allareas") scrHMGameplayFollowupAllAreas1103();'
    if call not in (PROJECT/relative).read_text('utf8'):
        anchor='scrHMGameplayFollowupWalls1103();'
        edit(relative,anchor,anchor+'\n        '+call)
    relative='scripts/scrHMGameplayTests/scrHMGameplayTests.gml'
    text=(PROJECT/relative).read_text('utf8')
    call='if(string_pos("sync113",mode)==1) scrHMGameplay1103Bosses();'
    if text.count(call)>1:
        first=text.index(call)+len(call)
        save(relative,text[:first]+text[first:].replace(call,''))
    for file,function in [('chest','scrHMGameplayChest1103'),('ultra','scrHMGameplayUltra1103'),
                          ('spawn','scrHMGameplaySpawn1103'),('routes','scrHMGameplayRoutes1103')]:
        source=ROOT/'tests'/f'sync1103_{file}.gml'
        if not source.exists():continue
        register(project,'scrHMGameplay1103'+file.title(),source.read_text('utf8'))
        relative='scripts/scrHMGameplayTests/scrHMGameplayTests.gml';text=(PROJECT/relative).read_text('utf8')
        call=f'if(string_pos("sync113",mode)==1) {function}();'
        if call not in text:
            old='if(string_pos("sync113",mode)==1) scrHMGameplay1103Bosses();'
            save(relative,text.replace(old,old+'\n        '+call,1))
    edit('scripts/scrHMGameplayTests/scrHMGameplayTests.gml',
         '"vault110","music112","sync112exit"],self[$ "mode"])',
         '"vault110","music112","sync112exit","sync113vault"],self[$ "mode"])')
    save('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
    import followup1103_cave_integrate
    followup1103_cave_integrate.apply()
    import followup1103_jungle_integrate
    # Keep the no-reward entrance, complete Jungle regression definition and
    # RoomStart mode together through the incremental combined-test bridge.
    followup1103_jungle_integrate.apply()
    mirrors=dict(sync1103_bosses_integrate.MIRRORS)
    mirrors.update(sync1103_performance_integrate.MIRRORS)
    mirrors.update({CONTENT:'native/content1100.gml',WORLD:'native/world.gml',
                    'scripts/scrHMRepairs109/scrHMRepairs109.gml':'native/repairs109.gml',
                    'scripts/scrHMRepairs103/scrHMRepairs103.gml':'native/repairs103.gml',
                    'scripts/scrHMRepairs107/scrHMRepairs107.gml':'native/repairs107.gml',
                    'scripts/scrHMRepairs110/scrHMRepairs110.gml':'native/repairs110.gml'})
    for relative,target in mirrors.items():(ROOT/target).write_text((PROJECT/relative).read_text('utf8'),'utf8')
    previous=OUT/'changed-project.json'
    changed=set(json.loads(previous.read_text('utf8'))) if previous.exists() else set()
    previous.write_text(json.dumps(sorted(changed|CHANGED),indent=2)+'\n','utf8')
    print('Incrementally synchronized',len(CHANGED),'project sources; pending builds and runtime validation')

if __name__=='__main__':main()
