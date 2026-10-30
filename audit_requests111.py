"""Compare loop pools to the frozen stock source and audit focused patches."""
from pathlib import Path
import hashlib,json,re

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release111'

def main():
    original=(ROOT/'original-source/scripts/scrPopEnemies/scrPopEnemies.gml').read_text(encoding='utf8')
    repairs=(ROOT/'native/repairs111.gml').read_text(encoding='utf8')
    pools={}
    for area in ('desert','sewers','scrapyards','caves','city','labs','palace'):
        block=original.split('case area_'+area+':',1)[1].split('\n\t    case ',1)[0]
        block=block.split('\n\t\tcase ',1)[0]
        spawn=re.search(r'if \(random\(2\) < _loop_rand\)\s*\{\s*__spawn\((.*?)\)',block,re.S)
        assert spawn,area
        expected=re.findall(r'\b[A-Za-z]+\b',spawn[1])
        found=re.search(r'case area_'+area+r': return \[(.*?)\];',repairs)
        actual=found[1].split(',')
        assert actual==expected,(area,actual,expected)
        pools[area]=dict(weighted_pool=actual,original_branch=True)
    no_extra=('oasis','pizza_sewers','mansion','cursed_caves','jungle','hq')
    for area in no_extra:
        block=original.split('case area_'+area+':',1)[1].split('\n\t    case ',1)[0]
        assert 'random(2) < _loop_rand' not in block
    game=(ROOT/'project/scripts/scrPopEnemies/scrPopEnemies.gml').read_text(encoding='utf8')
    assert game.count('scrHMVanillaLoopPopulate111();')==1
    enemies=(ROOT/'project/scripts/scrHMCompiled_enemies_mod_gml/scrHMCompiled_enemies_mod_gml.gml').read_text(encoding='utf8')
    assert 'weapondrop != 0) && scrHMVenusDropAllowed111(weapondrop)' in enemies
    consumers=re.findall(r'on_destroy = scrHMScriptRef\(hm_enemies_mod_gml_DropWeapon\)',enemies)
    assert len(consumers)==4
    maincode=(ROOT/'project/scripts/scrHMCompiled_maincode_mod_gml/scrHMCompiled_maincode_mod_gml.gml').read_text(encoding='utf8')
    assert 'instance_nearest(x, y, enemy) == (scrHMOther(other))' not in maincode
    assert maincode.count('scrHMMissileShot111(creator,scrHMOther(other))')==1
    city=(ROOT/'project/scripts/scrHMCompiled_areas_city_area_gml/scrHMCompiled_areas_city_area_gml.gml').read_text(encoding='utf8')
    assert 'bigcrystal_create' not in city and 'scrHMLoopCrystal109(' not in city
    fire=(ROOT/'project/objects/ExploGuardian/Alarm_2.gml').read_text(encoding='utf8')
    death=(ROOT/'project/objects/ExploGuardian/Destroy_0.gml').read_text(encoding='utf8')
    assert 'repeat 26 {' in fire and 'ang += 360 / 26' in fire
    assert death==(ROOT/'original-source/objects/ExploGuardian/Destroy_0.gml').read_text(encoding='utf8')
    assert maincode.count('if(!(self[$ "hm_vanilla_loop111"]??false))')==3
    report=dict(status='PASS',original_source_sha256=hashlib.sha256(original.encode()).hexdigest(),
        exact_weighted_loop_pools=pools,stock_areas_without_loop_specific_pool=no_extra,
        custom_family_mappings=['nightdesert/scorpionboss:desert','sewers:sewers',
            'junkyard/ravenboss/bigdog:scrapyards','caves:caves','city:city','labs/elevator:labs','palace:palace'],
        stock_native_rooms_not_rolled_twice=True,drop_death_callbacks=4,
        missile_conversion_requires_same_scrap_boss_owner=True,big_crystal_excluded_from_city=True,
        city_stock_loop_types_exempt_from_hardmode_replacement=True,
        exploguardian_normal_shots=26,exploguardian_charged_death_shots=14)
    OUT.mkdir(exist_ok=True)
    (OUT/'request-source-audit.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf8')
    print('1.0.11 source contracts PASS: seven exact weighted stock loop pools, four Venus enemy drops, missile ownership, city exclusion')

if __name__=='__main__':main()
