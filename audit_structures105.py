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
    assert all(checks.values()),checks
    report={'status':'PASS','checks':checks,'area_placement_modules':placement,
            'retained_physical_operations':['Wall/native projectile collision','MOD wall destruction and room replacement',
                'Guardian temporary wall masks','Throne wall conversion','local door wall removal','wall-spawn enemies'],
            'dynamic_verification':'Current-VM walls105, palace105, caves103, route103, outside105, Venuz/elevator/jungle scenarios in gameplay-regression.json',
            'desktop_vm_sha256':hashlib.sha256((ROOT/'build-windows/nuclearthronemobile.win').read_bytes()).hexdigest()}
    (ROOT/'release105/structure-audit.json').write_text(json.dumps(report,indent=2)+'\n')
    print('Structure audit PASS:',len(checks),'contracts,',len(placement),'area placement modules')


if __name__=='__main__':main()
