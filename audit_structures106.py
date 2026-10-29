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
    checks['plain_exterior_drawn_after_shadow']='scrHMDrawPlainWall106();continue;' in read('project/objects/SubTopCont/Draw_0.gml')
    checks['wall_collision_pairs_removed']='"eventType": 4' not in read('project/objects/Wall/Wall.yy')
    checks['new_wall_does_not_collide_with_self']='collision_point(x+8,y+8,Wall,false,true)' in read('project/objects/Wall/Create_0.gml')
    checks['no_frame_floor_scan_for_wall_style']='return scrHMPlainWall106();' in read('project/scripts/scrHMRepairs105/scrHMRepairs105.gml')
    checks['deep_fill_preserves_authored_placement']='scrHMAuthoredWalls105()' in main
    checks['same_room_venus_elevator_rebuilds_compact_collision']='scrHMVenusTerrain106();' in read('project/objects/HMWorld/Step_0.gml')
    checks['venus_auto_exit_checks_generation_and_existing_exit']='scrHMVenusAutoExit106()' in main and 'if(instance_exists(GenCont)) return false;' in read('native/repairs106.gml')
    checks['venus_auto_exit_waits_for_deferred_enemy_spawners']='self[$ "Spawner"]??false' in read('native/repairs106.gml').split('function scrHMVenusAutoExit106()',1)[1].split('function scrHMFillSplit106',1)[0]
    checks['crashing_aircraft_can_leave_solid_exterior']='\nmask_index=mskNone;' in read('generated/bosses_gungod_mod_gml.gml')
    checks['gun_god_pilot_reacquires_replaced_landing_floor']='if(!instance_exists(target)) target=instance_nearest(x,y,Floor);' in read('generated/bosses_gungod_mod_gml.gml')
    checks['venus_car_driver_uses_player_index_lookup']=read('generated/props_mod_gml.gml').count('scrHMPlayerFind(_hml_car.driver).team')==2
    loadout=read('project/scripts/scrLoadoutMenuInit/scrLoadoutMenuInit.gml')
    checks['all_crown_loadout_writes_and_queries_guard_both_dimensions']=loadout.count('if(!scrHMCrownLoadoutValid106(_race_id,_crown_id)) return false;')==3
    checks['unsupported_saved_crown_falls_back_to_no_crown']='scrHMCrownLoadoutValid106(_race_id,_crown)?_crown:crwn_none' in loadout
    assert all(checks.values()),checks
    report={'status':'PASS','checks':checks,'area_placement_modules':placement,
            'retained_physical_operations':['Wall/native projectile collision','MOD wall destruction and room replacement',
                'Guardian temporary wall masks','Throne wall conversion','local door wall removal','wall-spawn enemies'],
            'dynamic_verification':'Current-VM walls105, palace105, caves103, route103, outside105, Venuz/elevator/jungle scenarios in gameplay-regression.json',
            'desktop_vm_sha256':hashlib.sha256((ROOT/'build-windows/nuclearthronemobile.win').read_bytes()).hexdigest()}
    (ROOT/'release106/structure-audit.json').write_text(json.dumps(report,indent=2)+'\n')
    print('Structure audit PASS:',len(checks),'contracts,',len(placement),'area placement modules')


if __name__=='__main__':main()
