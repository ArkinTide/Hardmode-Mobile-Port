"""Audit the separation of synthetic collision from authored MOD placement."""
from pathlib import Path
import hashlib,json

ROOT=Path(__file__).resolve().parent


def main():
    def read(path):return (ROOT/path).read_text(encoding='utf8')
    checks={}
    enemies=read('generated/enemies_mod_gml.gml')
    tank=read('generated/bosses_titank_mod_gml.gml')
    main=read('generated/maincode_mod_gml.gml')
    checks['jungle_boss_uses_original_boundary_twice']=enemies.count('scrHMNearestAuthoredWall105(')==2
    checks['titank_uses_original_boundary']=tank.count('scrHMNearestAuthoredWall105(')==1
    palace=read('generated/areas_palace_area_gml.gml')
    import re
    checks['generator_dedup_uses_coordinates_not_sprite_mask']=bool(re.search(r'scrHMPalaceGenerator105\(\w+\.x\+16,\w+\.y\+16\);',palace))
    checks['invisible_collision_does_not_duplicate_fill']='scrHMMatchingNE(Wall, "thing", 1)' not in main and 'scrHMMatching(Wall, "thing", undefined)' not in main
    placement=[]
    for path in sorted((ROOT/'generated').glob('areas_*_gml.gml')):
        text=path.read_text(encoding='utf8')
        start=text.find('function '+path.stem.replace('areas_','hm_areas_',1)+'_area_start(')
        # Generated function names are deterministic; locate the hook by its suffix.
        import re
        match=re.search(r'function \w+_area_start\(',text)
        if not match:continue
        block=text[match.start():].split('\n// Source ',1)[0]
        assert 'scrHMInstances(Wall)' not in block,path.name
        if 'scrHMAuthoredWalls105()' in block:placement.append(path.name)
    checks['all_area_start_wall_placement_isolated']=len(placement)>=12
    checks['new_32px_floor_removes_only_fill']='scrHMCarveFill105(32);' in read('project/objects/Floor/Create_0.gml')
    checks['new_16px_floor_removes_only_fill']='scrHMCarveFill105(16);' in read('project/objects/FloorExplo/Create_0.gml')
    checks['physical_wall_instance_queries_preserved']='if(_target == Wall)' not in read('native/coroutines.gml')
    checks['deep_collision_skips_empty_alarm_scan']='hm_interior_wall' in read('project/objects/UberCont/Step_1.gml')
    checks['placement_helper_does_not_kill_enemies']='instance_destroy' not in read('native/repairs105.gml').split('function scrHMFindGround105',1)[1].split('function scrHMAuthoredWalls105',1)[0]
    registered=read('project/objects/GenCont/Create_0.gml')
    checks['one_area_setup_hook']=registered.count('scrHMAreaCall(GameCont.area,"area_setup");')==1
    checks['no_stale_generator_background_field']='background_set_colour(background_color)' not in registered
    checks['native_hunter_shots_have_creator']=read('project/objects/LilHunter/Alarm_1.gml').count('creator = other.id')==2
    checks['half_frame_modulo_is_integer']='(floor(current_frame) mod 10)' in enemies
    checks['plain_exterior_drawn_after_shadow']='scrHMPlainWallDraw107();' in read('project/objects/SubTopCont/Draw_0.gml') and read('project/objects/SubTopCont/Draw_0.gml').index('scrHMPlainWallDraw107();') < read('project/objects/SubTopCont/Draw_0.gml').index('with TopSmall {')
    checks['wall_collision_pairs_removed']='"eventType": 4' not in read('project/objects/Wall/Wall.yy')
    checks['new_wall_does_not_collide_with_self']='collision_point(x+8,y+8,Wall,false,true)' in read('project/objects/Wall/Create_0.gml')
    checks['no_frame_floor_scan_for_wall_style']='return scrHMPlainWall106();' in read('project/scripts/scrHMRepairs105/scrHMRepairs105.gml')
    checks['deep_fill_preserves_authored_placement']='scrHMAuthoredWalls105()' in main
    checks['same_room_venus_elevator_runs_terrain_maintenance']='scrHMVenusTerrain106();' in read('project/objects/HMWorld/Step_0.gml')
    runtime108=read('native/repairs108.gml')
    checks['venus_has_no_added_exterior_fill']='if(GameCont.area==scrHMAreaResolve("venuz")) {hm_fill_active=false;hm_fill_taken106=undefined;return true;}' in read('project/scripts/scrHMRepairs106/scrHMRepairs106.gml')
    checks['old_venus_host_objects_removed_before_new_map']=read('generated/props_mod_gml.gml').index('scrHMVenusCleanup108();') < read('generated/props_mod_gml.gml').index('scrHMModCall("area", "venuz", "area_setup");')
    checks['transition_layer_can_cover_collision_fill']='scrHMTopAllowed108()' in read('project/objects/TopSmall/Create_0.gml') and 'scrHMWallTransitions108();' in read('project/scripts/scrHMRepairs106/scrHMRepairs106.gml')
    checks['filled_wall_does_not_cast_block_origin_shadow']='!(scrHMEnabled() && scrHMPlainWall106())' in read('project/scripts/scrShadows/scrShadows.gml')
    checks['large_tank_portal_has_real_native_spawn']='scrHMTankPortal108(' in enemies and 'scrHMVanPortalSpawn108()' in read('project/objects/VanSpawn/Alarm_1.gml')
    checks['native_boss_portraits_also_skip_loop_runs']='if(scrHMEnabled() && instance_exists(GameCont) && GameCont.loops>0) return;' in read('project/scripts/scrBossIntro/scrBossIntro.gml')
    checks['both_portal_warning_assets_are_registered']='sprHMVanWarning108' in runtime108 and 'sprHMIDPDTankWarning108' in runtime108
    portal_spawn=runtime108.split('function scrHMVanPortalSpawn108()',1)[1].split('function scrHMVanWarning108',1)[0]
    checks['tank_portal_reuses_one_alarm_clear_and_sound']='PortalClear' not in portal_spawn and 'snd_play' not in portal_spawn
    checks['tank_portal_initializes_before_random_van_placement']=read('project/objects/VanSpawn/Create_0.gml').startswith('if(scrHMVanPortalCreate108()) exit;')
    checks['venus_pickup_collision_uses_safe_current_floor']='scrHMVenusPickup108();' in read('project/objects/WepPickup/Step_0.gml') and 'scrHMVenusPickup108();' in read('project/objects/WepPickup/Collision_InvisiWall.gml')
    checks['venus_analog_adaptor_preserves_keyboard_fallback']='return scrHMButtonCheck(_index,_action);' in runtime108 and 'scrHMCarSteer108();' in read('generated/props_mod_gml.gml')
    checks['single_target_filter_avoids_instance_snapshot']='if(!is_array(_target)) return scrHMFilterOne108(' in read('project/scripts/scrHMApi/scrHMApi.gml')
    checks['throne_beam_uses_native_monotonic_mask_search']='scrHMThroneBeam108();' in read('project/objects/NothingBeam/Step_0.gml')
    checks['venus_auto_exit_checks_generation_and_existing_exit']='scrHMVenusAutoExit106()' in main and 'if(instance_exists(GenCont)) return false;' in read('native/repairs106.gml')
    checks['venus_auto_exit_waits_for_deferred_enemy_spawners']='self[$ "Spawner"]??false' in read('native/repairs106.gml').split('function scrHMVenusAutoExit106()',1)[1].split('function scrHMFillSplit106',1)[0]
    checks['crashing_aircraft_can_leave_solid_exterior']='\nmask_index=mskNone;' in read('generated/bosses_gungod_mod_gml.gml')
    checks['gun_god_pilot_reacquires_replaced_landing_floor']='if(!instance_exists(target)) target=instance_nearest(x,y,Floor);' in read('generated/bosses_gungod_mod_gml.gml')
    checks['venus_car_driver_uses_player_index_lookup']=read('generated/props_mod_gml.gml').count('scrHMPlayerFind(_hml_car.driver).team')==2
    loadout=read('project/scripts/scrLoadoutMenuInit/scrLoadoutMenuInit.gml')
    checks['all_crown_loadout_writes_and_queries_guard_both_dimensions']=loadout.count('if(!scrHMCrownLoadoutValid106(_race_id,_crown_id)) return false;')==3
    checks['unsupported_saved_crown_falls_back_to_no_crown']='scrHMCrownLoadoutValid106(_race_id,_crown)?_crown:crwn_none' in loadout
    runtime109=read('native/repairs109.gml')
    checks['raw_custom_enemy_clones_skipped']='(scrHMEnabled() && object_index==CustomEnemy)' in read('project/scripts/scrPopulate/scrPopulate.gml')
    checks['no_temporary_callstack_trace']='debug_get_callstack' not in read('project/objects/CustomEnemy/Create_0.gml')
    checks['initial_throne_finalized_after_area_start']='scrHMThroneEntrance109();' in read('project/objects/GenCont/Alarm_1.gml')
    throne=runtime109.split('function scrHMThroneEntrance109()',1)[1].split('function scrHMReviveAllowed109',1)[0]
    checks['throne_finalizer_does_not_resurrect_active_battle']=all('instance_exists('+s+')' in throne for s in ['BecomeNothing','Nothing','NothingDeath','Nothing2','Nothing2Death'])
    checks['transition_deferred_create_respects_plain_fill']='scrHMTransitionPlain109()' in read('project/objects/TopSmall/Create_0.gml')
    checks['mod_crystal_and_gator_populations_registered']=all('scrHMLoopCrystal109(x+16,y+16);' in read('generated/areas_'+s+'_area_gml.gml') for s in ['city','caves','cavesinv']) and all('scrHMLoopBuffGator109(x+16,y+16);' in read('generated/areas_'+s+'_area_gml.gml') for s in ['sewers','junkyard'])
    checks['tank_real_death_callback_supplies']='scrHMTankSupplies109();' in enemies
    checks['guardian_uses_single_native_draw_pass']='function hm_bosses_guardianboss_mod_gml_guardiandark_draw() {scrHMGuardianDark109();}' in read('generated/bosses_guardianboss_mod_gml.gml')
    checks['water_queries_use_exact_rectangles']='return scrHMWaterExact109(_x,_y);' in read('project/scripts/scrHMRepairs104/scrHMRepairs104.gml')
    checks['one_crown_and_throne_finalize_hook']=read('project/objects/GenCont/Alarm_1.gml').count('scrHMCrownAltar109();')==1 and read('project/objects/GenCont/Alarm_1.gml').count('scrHMThroneEntrance109();')==1
    checks['touch_owns_interaction_hud']='scrDrawPlayerHUD(_player,!_draw_controls)' in read('project/objects/TopCont/Draw_64.gml') and 'if (_draw_interaction && !scrGameIsPaused()) scrDrawInteractionHUD(_player)' in read('project/scripts/scrDrawPlayerHUD/scrDrawPlayerHUD.gml')
    checks['interaction_alignment_restored']='finally {draw_align(_ha,_va);}' in read('project/scripts/scrDrawPlayerHUD/scrDrawPlayerHUD.gml')
    cleanup=read('project/scripts/scrHMRepairs108/scrHMRepairs108.gml').split('function scrHMVenusCleanup108()',1)[1].split('function scrHMCarAnalog108',1)[0]
    checks['venus_removes_couch_actor_and_open_chests']='instance_destroy(YungVenuzCouch,false);instance_destroy(ChestOpen,false);' in cleanup
    roof=read('generated/areas_venuz_area_gml.gml').split('_area_make_floor()',1)[1].split('// Source ',1)[0]
    checks['venus_roof_no_repeated_golden_border']='global.hm_module_vars[$ "area:venuz"].wall103out' not in roof and roof.count('sprite_index = sprWall103Trans;\ny -= 8;')==4
    checks['native_and_custom_parking_minigunner_population']='if(scrHMEnabled()) scrHMLoopMinigunner109(bbox_center_x,bbox_center_y);' in read('project/scripts/scrPopEnemies/scrPopEnemies.gml') and all('scrHMLoopMinigunner109(x+16,y+16);' in read('generated/areas_'+s+'_area_gml.gml') for s in ['junkyard','ravenboss'])
    checks['venus_keeps_original_hitscan']='if(GameCont.area!=scrHMAreaResolve("venuz")) {scrHMMinigunnerShot109();} else {' in enemies
    checks['rat_three_revival_paths_gated']=enemies.count('if (scrHMRatRevive109())')==3
    settings=read('generated/options_mod_gml.gml')
    checks['rat_setting_legacy_default_and_ninth_field']='ratrevive="1";' in settings and 'array_length(_hm.vars._settings)>8?' in settings and '_hml__str+="*"+string(global.hm_module_vars[$ "mod:options"].ratrevive);' in settings
    checks['rat_menu_registered_from_maintained_source']=read('project/scripts/scrHMMobile/scrHMMobile.gml')==read('native/mobile.gml') and '"ratrevive"' in read('project/scripts/scrHMMobile/scrHMMobile.gml')
    checks['rogue_preserves_strike_canister']='scrHMRogueCanisters109();' in main and 'instance_change(Wind, 1);\ninstance_create(x, y, RadChest);' not in main
    checks['special_radiation_runs_on_repeated_sync']='if (hm_rad_reduced) {scrHMRadiationRequests109(_below_maximum);return;}' in read('native/radiation.gml')
    checks['hardmode_roadmap_uses_real_stage_mapping']='if(scrHMEnabled()) {scrHMRoadmap109(_drawx,_drawy,_pos);return;}' in read('project/scripts/scrDrawRoadmap/scrDrawRoadmap.gml') and '["palace",24,4]' in read('native/roadmap109.gml')
    assert all(checks.values()),checks
    report={'status':'PASS','checks':checks,'area_placement_modules':placement,
            'retained_physical_operations':['Wall/native projectile collision','MOD wall destruction and room replacement',
                'Guardian temporary wall masks','Throne wall conversion','local door wall removal','wall-spawn enemies'],
            'dynamic_verification':'Current-VM wall109, water109, night109, empty109, throneseed109, throneroute109, buffgator109, walls104, cavewalls107, throne and both continuous Venus routes in gameplay-regression.json; other area placement modules receive static contract checks only',
            'desktop_vm_sha256':hashlib.sha256((ROOT/'build-windows/nuclearthronemobile.win').read_bytes()).hexdigest()}
    (ROOT/'release109/structure-audit.json').write_text(json.dumps(report,indent=2)+'\n')
    print('Structure audit PASS:',len(checks),'contracts,',len(placement),'area placement modules')


if __name__=='__main__':main()
