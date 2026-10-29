"""Maintain release 1.0.7 host changes after previous registrations."""
import json
from create_project import load
from register_native import ROOT, PROJECT, register_script, replace, write

project=load(PROJECT/'nuclearthronemobile.yyp')
register_script(project,'scrHMRepairs107',(ROOT/'native/repairs107.gml').read_text(encoding='utf8'))
register_script(project,'scrHMRadiation',(ROOT/'native/radiation.gml').read_text(encoding='utf8'))

def change(path, old, new):
    text=(PROJECT/path).read_text(encoding='utf8')
    if new not in text:
        assert old in text, (path,old)
        write(path,text.replace(old,new,1))

change('scripts/scrHMWorld/scrHMWorld.gml',
       '||_code==scrHMScriptRef(hm_enemies_mod_gml_bigcrystaltopdraw));',
       '||_code==scrHMScriptRef(hm_enemies_mod_gml_bigcrystaltopdraw)\n'
       '        ||_code==scrHMScriptRef(hm_props_mod_gml_E)\n'
       '        ||_code==scrHMScriptRef(hm_props_mod_gml_outsider_draw));')
# Honour the source's hidden player, for vehicles and the portal shrink.
change('objects/Player/Draw_0.gml','// NTT swimming owns the cropped body renderer.',
       'if(scrHMPlayerNativeHidden107()) exit;\n// NTT swimming owns the cropped body renderer.')
change('objects/SubTopCont/Draw_0.gml','with Player if (visible) {',
       'with Player if (visible && !scrHMPlayerNativeHidden107()) {')
change('scripts/scrShadows/scrShadows.gml','if (visible && sprite_exists(spr_shadow))',
       'if (visible && image_alpha>0 && sprite_exists(spr_shadow))')

# Plain deep fill is the background; transitions must draw on top of it.
path='objects/SubTopCont/Draw_0.gml';text=(PROJECT/path).read_text(encoding='utf8')
text=text.replace('if(scrHMEnabled() && scrHMPlainWall106()) {scrHMDrawPlainWall106();continue;}',
                  'if(scrHMEnabled() && scrHMPlainWall106()) continue;')
marker='// Plain fill precedes the original wall transition layer (1.0.7).'
if marker not in text:
    at='with TopSmall {'
    assert at in text
    text=text.replace(at,marker+'''
for(var _wall=0;_wall<ds_list_size(_list);++_wall) with(_list[| _wall]) {
    if(scrHMEnabled() && scrHMPlainWall106()) scrHMPlainWallDraw107();
}
'''+at,1)
write(path,text)

# Cleanup is not a combat death. Never detonate removed top decorations.
for path in ['scripts/scrMoveTopPots/scrMoveTopPots.gml',
             'objects/SubTopCont/Alarm_0.gml','objects/TopPot/Collision_TopPot.gml']:
    text=(PROJECT/path).read_text(encoding='utf8')
    text=text.replace('instance_destroy()', 'instance_destroy(id,!scrHMEnabled())')
    write(path,text)
change('objects/ScrapBoss/Alarm_2.gml','scrBossIntro(1)',
       'if(!(scrHMEnabled() && GameCont.area==scrHMAreaResolve("junkyard"))) scrBossIntro(1)')
change('objects/FloorExplo/Create_0.gml','scrHMCarveFill105(16);',
       'hm_quiet_wall107=scrHMEnabled() && variable_global_exists("hm_quiet_wall107") && global.hm_quiet_wall107;\nscrHMCarveFill105(16);')
change('objects/PortalClear/Collision_Wall.gml',
       'if(scrHMEnabled() && (self[$ "hm_water_clear"]??false)) scrHMSewerBank(other.id);\nelse scrWallDestroy(other.id)',
       'if(scrHMEnabled()) scrHMPortalClearWall107(other.id);\nelse scrWallDestroy(other.id)')
change('objects/BecomeScrapBoss/Collision_Wall.gml','scrWallDestroy(other.id)',
       'if(scrHMEnabled()) scrHMPortalClearWall107(other.id);\nelse scrWallDestroy(other.id)')
change('objects/TopPot/Collision_FloorExplo.gml','with Wall {',
       'if(scrHMTopPotFloor107(other.id)) exit;\n\nwith Wall {')

# Only tagged Venus pellets bypass damage iframes, as separate shotgun hits.
change('objects/AllyBullet/Collision_hitme.gml','scr_projectile_generic_hit()',
       'scr_projectile_generic_hit(true,!(self[$ "hm_venus_pellet107"]??false))')
change('objects/Portal/Alarm_1.gml','GameCont.is_level_ended = true',
       'scrHMPortalDestination107();\nGameCont.is_level_ended = true')

# Previous shoot suppression returned before the native movement code too.
path='objects/HostileHorror/Other_10.gml';text=(PROJECT/path).read_text(encoding='utf8')
text=text.replace('{ammo=0;exit;}','{ammo=0;}')
write(path,text)
change('objects/HostileHorror/Alarm_1.gml','{ammo=0;exit;}',
       '{scrHMPalaceHorrorMove107();exit;}')
path='scripts/scrHMRepairs103/scrHMRepairs103.gml';text=(PROJECT/path).read_text(encoding='utf8')
text=text.replace('alarm[1]=-1;alarm[3]=-1;', 'alarm[1]=1;alarm[3]=-1;')
write(path,text)

# A separate pause action restarts the current Venus stage, not the run.
path='scripts/scrMakePauseButtons/scrMakePauseButtons.gml';text=(PROJECT/path).read_text(encoding='utf8')
if '// Venus current-stage retry (1.0.7).' not in text:
    marker='\t\t// Menu'
    assert marker in text
    text=text.replace(marker,'''        // Venus current-stage retry (1.0.7).
        if(scrHMEnabled() && instance_exists(GameCont) && GameCont.area==scrHMAreaResolve("venuz")) {
            with(instance_create(_left+view_width/2,_bottom-96,PauseButton)) {
                image_index=3;hm_retry_level107=true;image_speed=0;appear=1;
            }
        }
'''+marker,1)
write(path,text)
change('scripts/scrMenuButtonName/scrMenuButtonName.gml',
       'function scrMenuButtonName(_sprite_index = sprite_index, _image_index = image_index) {',
       '''function scrMenuButtonName(_sprite_index = sprite_index, _image_index = image_index) {
    if(self[$ "hm_retry_level107"]??false)
        return UberCont.opt_language=="Simplified Chinese"?"重新开始本关":"RESTART LEVEL";''')
change('objects/PauseButton/Other_10.gml','image_index = floor(image_index)', '''// Venus current-stage retry (1.0.7).
if(self[$ "hm_retry_level107"]??false) {
    scrGameUnpause();
    if(scrHMVenusRetry107()) {
        instance_destroy(PauseButton);instance_destroy(BackButton);
        UberCont.block_input_frames=1;
    }
    exit;
}

image_index = floor(image_index)''')
change('objects/PauseButton/Draw_0.gml',
       'if ((_subimage >= 0 && _subimage <= 1)',
       'if(self[$ "hm_retry_level107"]??false) _halign=fa_center;\n\t\telse if ((_subimage >= 0 && _subimage <= 1)')
# Back/B must still select Continue, not the additional restart action.
change('objects/PauseButton/Step_0.gml',
       'if gamepad_button_check(0, gp_face2) && image_index == 3 {',
       'if gamepad_button_check(0, gp_face2) && image_index == 3 && !(self[$ "hm_retry_level107"]??false) {')
change('objects/Portal/Create_0.gml',
       'GameCont.area==scrHMAreaResolve("HQ")) type=2;',
       'array_contains([scrHMAreaResolve("HQ"),scrHMAreaResolve("elevator"),106],GameCont.area)) type=2;')

# The host's numeric HQ exclusion does not recognize the MOD's named HQ.
change('scripts/scrPopulate/scrPopulate.gml',
       'if ((_area < area_city || _area > area_vault) && _area != area_mansion && _area != area_hq) {',
       'if ((_area < area_city || _area > area_vault) && _area != area_mansion && _area != area_hq\n'
       '        && !(scrHMEnabled() && scrHMPoliceArea107(_area))) {')
change('scripts/scrArea/scrArea.gml','function scrAreaCanHavePopo() {',
       'function scrAreaCanHavePopo() {\n    if(scrHMEnabled() && !scrHMCanHavePolice107()) return false;')
change('scripts/scrOnPopoKill/scrOnPopoKill.gml','function scrOnPopoKill() {',
       'function scrOnPopoKill() {\n    scrHMPoliceDeath107();')
change('objects/enemy/Destroy_0.gml','with instance_create(x, y, CorpseActive) {',
       'with instance_create(x, y, CorpseActive) {\n        if(scrHMEnabled()) other.hm_death_corpse107=id;')
change('objects/WantRevivePopoFreak/Alarm_0.gml','if instance_exists(Portal)',
       'if(scrHMEnabled() && scrHMPoliceRevive107()) exit;\nif instance_exists(Portal)')
change('objects/RevivePopoFreak/Alarm_0.gml','with(instance_nearest(x, y, Corpse)) {',
       'with(self[$ "hm_corpse107"]??instance_nearest(x, y, Corpse)) {')
for path in ['objects/PopoShield/Collision_projectile.gml','objects/EliteShield/Collision_projectile.gml']:
    text=(PROJECT/path).read_text(encoding='utf8')
    if '_keep_plasma107' not in text:
        text=text.replace('team = other.team',
            'var _keep_plasma107=scrHMShieldKeepPlasma107();\n        if(!_keep_plasma107) team = other.team',1)
        text=text.replace('hitid = other.hitid','if(!_keep_plasma107) hitid = other.hitid',1)
    write(path,text)
write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
print('Release 1.0.7 host adapters registered')
