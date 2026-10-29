"""Restore original NTT base contracts referenced by Hardmode, not NTTE code."""
import json
from create_project import load
from register_native import ROOT,PROJECT,write,register_script,replace
from register_actors import register_object

def sprite(name,resource,depth=None):
    path=PROJECT/f'objects/{name}/{name}.yy'
    obj=load(path)
    obj['spriteId']={'name':resource,'path':f'sprites/{resource}/{resource}.yy'}
    write(path.relative_to(PROJECT),json.dumps(obj,indent=2)+'\n')

def main():
    project=load(PROJECT/'nuclearthronemobile.yyp')
    register_script(project,'scrHMBaseCompat',(ROOT/'native/base_compat.gml').read_text(encoding='utf8'))
    register_object(project,'GameObject',None,{})
    register_object(project,'Effect','GameObject',{})
    register_object(project,'Pickup','GameObject',{})
    register_object(project,'DustOLD','Effect',{
        (0,0,None):'image_angle=random(360); motion_add(random(360),random(1)*timescale);friction=.4*timescale*timescale;image_speed=(.3+random(.4))*timescale;',
        (7,7,None):'instance_destroy();'})
    sprite('DustOLD','sprDustOLD')
    register_object(project,'FireFly','Effect',{
        (0,0,None):'image_speed=.4*timescale;image_xscale=choose(-1,1);',
        (7,7,None):'instance_destroy();'})
    sprite('FireFly','sprFireFly')
    register_object(project,'Sweat','Effect',{
        (0,0,None):'motion_add(random(360),(1.5+random(.5))*timescale);gravity=.04*timescale*timescale;alarm[0]=11+random(4);image_speed=0;image_index=random(image_number);image_angle=random(360);',
        (2,0,None):'instance_destroy();'})
    sprite('Sweat','sprSweat')
    register_object(project,'CustomDraw','GameObject',{})
    # Original NTT object 100 has no events; the mansion cleanup queries it.
    register_object(project,'ScorchTop','GameObject',{})
    register_object(project,'TopDecalPizzaSewers','TopDecalSewers',{
        (0,0,None):'event_inherited();sprite_index=sprTopDecalPizzaSewers;image_speed=0;image_index=random(image_number);'})
    register_object(project,'TopDecalInvCave','TopDecalCave',{
        (0,0,None):'event_inherited();sprite_index=sprTopDecalInvCave;image_speed=0;image_index=random(image_number);'})
    register_object(project,'Table','prop',{
        (0,0,None):'''max_hp=1;size=1;dir=choose(1,2,3);
switch(dir) {
case 1:spr_idle=sprTable1;spr_hurt=sprTable1Hurt;spr_dead=sprTable1Dead;break;
case 2:spr_idle=sprTable2;spr_hurt=sprTable2Hurt;spr_dead=sprTable2Dead;break;
case 3:spr_idle=sprFallenChair;spr_hurt=sprFallenChairHurt;spr_dead=sprFallenChairDead;break;
}
event_inherited();sprite_index=spr_idle;mask_index=-1;'''})
    register_script(project,'scrHMOasisBoss',(ROOT/'native/oasis_boss.gml').read_text(encoding='utf8'))
    register_object(project,'OasisBoss','enemy',{
        (0,0,None):'scrHMOasisBossCreate();event_inherited();scrHMOasisBossAfterCreate();',
        (1,0,None):'scrDrop(15,60);event_inherited();scrHMOasisBossDeath();',
        (2,1,None):'scrHMOasisBossThink();',
        (2,2,None):'scrHMOasisBossFire();',
        (3,0,None):'event_inherited();scrHMOasisBossStep();',
        (8,0,None):'if(!lockstep_stop) draw_sprite_ext(sprite_index,-1,x,y,right,1,0,c_white,1);'})
    sprite('OasisBoss','sprOasisBossIdle')
    path=PROJECT/'objects/OasisBoss/OasisBoss.yy';obj=load(path)
    obj['spriteMaskId']={'name':'mskScorpion','path':'sprites/mskScorpion/mskScorpion.yy'}
    write(path.relative_to(PROJECT),json.dumps(obj,indent=2)+'\n')
    register_object(project,'CrystalShieldDisappear','Effect',{
        (0,0,None):'image_speed=.4*timescale;', (7,7,None):'instance_destroy();'})
    sprite('CrystalShieldDisappear','sprShieldDisappear')
    # Make source GameObject-wide queries include the original game's actor
    # hierarchies. Existing event implementations and non-root parents stay.
    hierarchy=load(ROOT.parent/'ntte-complete/ntt-gameobject-hierarchy.json')
    original={row['name'] for row in hierarchy['objects']}
    original.update(['CustomEnemy','CustomProjectile','CustomHitme','CustomObject'])
    for name in original:
        path=PROJECT/f'objects/{name}/{name}.yy'
        if not path.is_file() or name in {'GameObject','Effect','Pickup','CustomDraw'}:continue
        obj=load(path)
        if obj.get('parentObjectId') is not None:continue
        obj['parentObjectId']={'name':'GameObject','path':'objects/GameObject/GameObject.yy'}
        write(path.relative_to(PROJECT),json.dumps(obj,indent=2)+'\n')
    for name in ['HPPickup','AmmoPickup','RogueAmmo']:
        path=PROJECT/f'objects/{name}/{name}.yy';obj=load(path)
        obj['parentObjectId']={'name':'Pickup','path':'objects/Pickup/Pickup.yy'}
        write(path.relative_to(PROJECT),json.dumps(obj,indent=2)+'\n')
    path=PROJECT/'objects/HMBinding/HMBinding.yy';obj=load(path)
    obj['parentObjectId']={'name':'CustomDraw','path':'objects/CustomDraw/CustomDraw.yy'}
    write(path.relative_to(PROJECT),json.dumps(obj,indent=2)+'\n')
    replace('objects/Player/Create_0.gml','can_pick = true','can_swap = true\ncan_pick = true')
    replace('objects/Player/Alarm_10.gml',
            'if instance_exists(Floor) && id == instance_find(Player, 0) {',
            '// Hardmode has authored floating actors and off-map portal blockers.\n'
            'if !scrHMEnabled() && instance_exists(Floor) && id == instance_find(Player, 0) {')
    replace('scripts/scrEnemyApplyCreationEffects/scrEnemyApplyCreationEffects.gml',
            'function scrEnemyApplyCreationEffects() {',
            'function scrEnemyApplyCreationEffects() {\n'
            '\t// CustomEnemy health is initialized by the first legacy maxhealth setter.\n'
            '\tif(instance_is(id,CustomEnemy)) return;')
    replace('objects/Player/Other_4.gml','visible = true',
            '// A room change cancels the old MOD cinematic and its callbacks.\n'
            '// Reset its per-room input locks before the new area_start hook.\n'
            'if(scrHMEnabled()) {\n'
            '    can_walk=true;can_pick=(race!=Race.BigDog);can_spec=true;can_swap=true;can_aim=true;\n'
            '    global.hm_camera_targets[index]=id;\n'
            '}\nvisible = true')
    replace('objects/Floor/Create_0.gml','\nmaterial = 1\n','\ntraction = 1;\nmaterial = 1\n')
    replace('objects/FloorExplo/Create_0.gml','styleb = 0','traction = 1;\nstyleb = 0')
    replace('objects/Player/Step_0.gml','if KeyCont.press_swap[index] && bwep != 0 {',
            'if can_swap && KeyCont.press_swap[index] && bwep != 0 {')
    replace('objects/Raven/Create_0.gml','emergencylanding = 0','lifespan = 0;\nemergencylanding = 0')
    replace('scripts/scrBoltTrail/scrBoltTrail.gml','image_angle = point_direction(_x1, _y1, _x2, _y2)',
            'creator = other.creator;\n\t\timage_angle = point_direction(_x1, _y1, _x2, _y2)')
    replace('objects/TV/Alarm_0.gml','if Menu.race != Race.Chicken {',
            'if (!instance_exists(Menu) || Menu.race != Race.Chicken) {')
    camera='''// Hardmode NTT per-player cinematic target.
if(scrHMEnabled()) {
    var _target=global.hm_camera_targets[global.index];
    if(instance_exists(_target) && !instance_is(_target,Player)) {
        var _smooth=1-power(.9,timescale);
        view_xview=round(lerp(view_xview,_target.x-view_width/2,_smooth));
        view_yview=round(lerp(view_yview,_target.y-view_height/2,_smooth));
        viewxf=view_xview;viewyf=view_yview;
        camera_set_view_pos(view_camera,view_xview,view_yview);
        exit;
    }
}
'''
    replace('objects/BackCont/Step_0.gml','var _force_snap = false',camera+'\nvar _force_snap = false')
    write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
    print('Registered original base contracts and reconstructed OasisBoss; gameplay verification required')

if __name__=='__main__':main()
