"""Incremental, repeat-safe 1.1.4 water/Gator/arrow fixes; no YYP writes."""
from pathlib import Path
import json
from sync1103_tools import span

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT/'project'
OUT=ROOT/'release1104'
CHANGED=[]

def save(relative,text):
    path=PROJECT/relative
    if path.read_text('utf8')==text:return
    backup=OUT/'baseline-world'/relative
    if not backup.exists():
        backup.parent.mkdir(parents=True,exist_ok=True);backup.write_bytes(path.read_bytes())
    path.write_text(text,'utf8');CHANGED.append(relative)

def edit(relative,old,new):
    text=(PROJECT/relative).read_text('utf8')
    if new in text:return
    assert text.count(old)==1,(relative,old,text.count(old))
    save(relative,text.replace(old,new,1))

def function_edit(relative,name,old,new,count=1):
    text=(PROJECT/relative).read_text('utf8');_,a,b,_=span(text,name)
    body=text[a:b]
    if new in body:return
    assert body.count(old)==count,(name,old,body.count(old),count)
    save(relative,text[:a]+body.replace(old,new,count)+text[b:])

def main():
    assert (OUT/'baseline-source.json').exists(),'Freeze current published source first'
    gator='scripts/scrHMCompiled_bosses_gatorboss_mod_gml/scrHMCompiled_bosses_gatorboss_mod_gml.gml'
    name='hm_bosses_gatorboss_mod_gml_gatorboss_step_resume'
    function_edit(gator,name,'scrHMMatchingNE(projectile, "team", team)','scrHMGatorDodgeCandidates1104()')
    function_edit(gator,name,'instance_nearest((x - 16), (y - 16), Floor)','scrHMGatorFloor1104()')
    function_edit(gator,name,'(sprite_index != ((spr_hurt || spr_charge) || spr_chargehurt))',
                  '(sprite_index != spr_hurt && sprite_index != spr_charge && sprite_index != spr_chargehurt)')
    function_edit(gator,name,'(sprite_index != (spr_charge || spr_chargehurt))',
                  '(sprite_index != spr_charge && sprite_index != spr_chargehurt)',2)
    common='scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml'
    function_edit(common,'hm_arkintide_mod_gml_hm_loop_population',
                  '[Ratking, Ratking, BuffGator, LaserCrystal, Rat, Exploder, Exploder, SuperFireBaller]',
                  '[Ratking, Ratking, BuffGator, LaserCrystal, Rat, Exploder, Exploder, SuperFireBaller, SuperFrog]')
    function_edit(common,'hm_arkintide_mod_gml_hm_loop_population',
                  '[Sniper, Sniper, MeleeFake, MeleeFake, Salamander, SnowBot, Raven, BuffGator, Raven]',
                  '[Sniper, Sniper, MeleeFake, MeleeFake, Salamander, SnowBot, Raven, BuffGator, Raven, SuperFrog]')
    text=(PROJECT/common).read_text('utf8');_,a,b,_=span(text,'hm_arkintide_mod_gml_hm_bullet_maggot_allowed')
    marker='if(self[$ "hm_poison_no_maggot1104"]??false) return false;'
    if marker not in text[a:b]:save(common,text[:a]+'\n'+marker+text[a:])
    edit('objects/SuperFrog/Alarm_2.gml',
         'scr_projectile_create(x, y, EnemyBullet2, random_angle, 2)',
         'scrHMPoisonShot1104(scr_projectile_create(x, y, EnemyBullet2, random_angle, 2))')
    edit('objects/SuperFrog/Destroy_0.gml',
         'scr_projectile_create(x, y, EnemyBullet2, _dir, 4)',
         'scrHMPoisonShot1104(scr_projectile_create(x, y, EnemyBullet2, _dir, 4))')
    oasis='scripts/scrHMCompiled_areas_oasis_area_gml/scrHMCompiled_areas_oasis_area_gml.gml'
    text=(PROJECT/oasis).read_text('utf8');_,a,b,_=span(text,'hm_areas_oasis_area_gml_area_pop_enemies')
    marker='scrHMOasisPoisonSpawn1104();'
    if marker not in text[a:b]:save(oasis,text[:b]+'\n'+marker+'\n'+text[b:])
    edit('objects/Bolt/Collision_Wall.gml','speed = 0','speed = 0\nscrHMBoltPin1104();')
    for rel in ('objects/Bolt/Step_0.gml','objects/Bolt/Step_2.gml',
                'objects/HeavyBolt/Step_2.gml','objects/UltraBolt/Step_2.gml'):
        text=(PROJECT/rel).read_text('utf8');marker='if(scrHMBoltPinned1104()) exit;'
        if marker not in text:save(rel,marker+'\n'+text)
    edit('scripts/scrEyesTelekinesis/scrEyesTelekinesis.gml',
         'with projectile {','with projectile {\n        if(scrHMEnabled() && (self[$ "hm_bolt_wall1104"]??false)) continue;')
    changed_total=sorted(p.relative_to(OUT/'baseline-world').as_posix() for p in (OUT/'baseline-world').rglob('*') if p.is_file())
    receipt={'changed_this_run':CHANGED,'changed_total':changed_total,'register':{
        'scrHMRepairs1104World':'native/repairs1104_world.gml',
        'scrHMGameplay1104World':'tests/repairs1104_world.gml'},
        'test_dispatch':'if(string_pos("sync114",mode)==1) scrHMGameplay1104World();'}
    (OUT/'world-integration.json').write_text(json.dumps(receipt,indent=2),'utf8')
    print(json.dumps(receipt,indent=2))

if __name__=='__main__':main()
