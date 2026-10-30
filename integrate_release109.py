"""Register 1.0.9 hooks after the retained adapters, idempotently."""
import json
from create_project import load
from register_native import ROOT, PROJECT, register_script, write

project=load(PROJECT/'nuclearthronemobile.yyp')
register_script(project,'scrHMRepairs109',(ROOT/'native/repairs109.gml').read_text(encoding='utf8'))
register_script(project,'scrHMRoadmap109',(ROOT/'native/roadmap109.gml').read_text(encoding='utf8'))
register_script(project,'scrHMRadiationTests',(ROOT/'tests/radiation.gml').read_text(encoding='utf8'))
register_script(project,'scrHMMobile',(ROOT/'native/mobile.gml').read_text(encoding='utf8'))

def change(path, old, new):
    text=(PROJECT/path).read_text(encoding='utf8')
    if new not in text:
        assert old in text,(path,old)
        write(path,text.replace(old,new,1))

change('scripts/scrHMBaseCompat/scrHMBaseCompat.gml',
       'hm_bosses_ravenboss_mod_gml_ravenboss_create(_floor.x+16,_floor.y+16);',
       'scrHMRavenGroup109(_floor.x+16,_floor.y+16);')
change('scripts/scrHMRepairs103/scrHMRepairs103.gml',
       'if(!scrHMEnabled()) return false;\n    if(instance_exists(HMWorld)',
       'if(!scrHMEnabled()) return false;\n    if(instance_exists(WantLH)) return true;\n    var _hunter=false;with(CustomObject) if(name=="hm_hunter_arrival109") {_hunter=true;break;}\n    if(_hunter) return true;\n    if(instance_exists(HMWorld)')
change('scripts/scrHMRepairs103/scrHMRepairs103.gml','name=="wantravenboss"','name=="wantRavenboss"')
change('objects/WantLH/Alarm_0.gml','instance_create(bbox_center_x, bbox_center_y, LilHunter)',
       'if(scrHMEnabled()) scrHMLilHunterGroup109(bbox_center_x,bbox_center_y);\n        else instance_create(bbox_center_x, bbox_center_y, LilHunter)')
path='objects/GenCont/Alarm_2.gml'
write(path,(PROJECT/path).read_text(encoding='utf8').replace('\nscrHMCrownAltar109();',''))
path='objects/GenCont/Alarm_1.gml'
text=(PROJECT/path).read_text(encoding='utf8')
text=text.replace('scrHMCrownAltar109();\n','').replace('scrHMThroneEntrance109();\n','')
assert text.count('scr_console_debugclear_restore()')==1
write(path,text.replace('scr_console_debugclear_restore()',
      'scrHMCrownAltar109();\nscrHMThroneEntrance109();\nscr_console_debugclear_restore()'))
change('objects/enemy/Destroy_0.gml','if(scrHMEnabled()) other.hm_death_corpse107=id;',
       'if(scrHMEnabled()) {other.hm_death_corpse107=id;hm_no_revive109=other.object_index==TechnoMancer;}')
path='objects/Necromancer/Alarm_1.gml'
text=(PROJECT/path).read_text(encoding='utf8')
text=text.replace('crp = instance_nearest(x, y, Corpse)','crp = scrHMReviveNearest109(x, y)')
text=text.replace('if !collision_line(x, y, crp.x, crp.y, Wall, 0, 0)',
                  'if instance_exists(crp) && !collision_line(x, y, crp.x, crp.y, Wall, 0, 0)')
write(path,text)
change('objects/ReviveCircle/Alarm_0.gml','if distance_to_object(other) <= 2 {',
       'if distance_to_object(other) <= 2 && (!scrHMEnabled() || scrHMReviveAllowed109()) {')
change('scripts/scrHMRadiation/scrHMRadiation.gml','function scrHMRadiationSync(_below_maximum) {',
       'function scrHMRadiationSync(_below_maximum) {\n    scrHMBoneFishRadiation109(_below_maximum);')
# A distinct depth guarantees player entry art is above the portal even when
# the two bindings are created/refreshed in a different instance order.
change('scripts/scrHMWorld/scrHMWorld.gml','_binding.depth=_depth;_binding.hm_code=_code;',
       'if(_code==scrHMScriptRef(hm_maincode_mod_gml_PortalShrink)) _depth=-12;\n    _binding.depth=_depth;_binding.hm_code=_code;')
change('scripts/scrHMWorld/scrHMWorld.gml','if(hm_menu_overlay) {\n        if(!instance_exists(creator))',
       'if(hm_menu_overlay) {\n        if(instance_exists(creator) && hm_code==scrHMScriptRef(hm_maincode_mod_gml_sewerboi) && !(creator[$ "swimming"]??false)) {instance_destroy();return;}\n        if(!instance_exists(creator))')
change('scripts/scrHMRepairs104/scrHMRepairs104.gml','HMWorld.hm_water_map=_map;',
       'HMWorld.hm_water_map=_map;\n    scrHMWaterRects109();')
change('scripts/scrHMRepairs104/scrHMRepairs104.gml',
       'return HMWorld.hm_water_map[$ scrHMWaterKey(_x,_y)]??false;',
       'return scrHMWaterExact109(_x,_y);')
change('scripts/scrHMRepairs104/scrHMRepairs104.gml',
       'var _water=(_map[$ scrHMWaterKey(x,y)]??false) && !instance_exists(SpiralCont);',
       'var _water=scrHMWaterExact109(x,y) && !instance_exists(SpiralCont);')
change('scripts/scrHMRepairs108/scrHMRepairs108.gml',
       'if(!scrHMEnabled()) return;\n    var _edges=[];',
       'if(!scrHMEnabled()) return;\n    if(scrHMWallTransitions109(_left,_top,_right,_bottom)) return;\n    var _edges=[];')
change('objects/SubTopCont/Draw_0.gml',
       'draw_sprite_ext(topspr, image_index, x, y - 8, 1, 1, 0, image_blend, 1)',
       'if(!scrHMTransitionRoof109()) draw_sprite_ext(topspr, image_index, x, y - 8, 1, 1, 0, image_blend, 1)')
change('objects/TopSmall/Create_0.gml','if (scrHMEnabled() ?',
       'if(scrHMEnabled() && scrHMTransitionPlain109()) {instance_destroy();exit;}\nif (scrHMEnabled() ?')
# End step runs after source/native movement, before all ordinary Draw events.
obj=load(PROJECT/'objects/HMWorld/HMWorld.yy')
if not any(e['eventType']==3 and e['eventNum']==2 for e in obj['eventList']):
    obj['eventList'].append({'$GMEvent':'v1','%Name':'','collisionObjectId':None,'eventNum':2,'eventType':3,'isDnD':False,'name':'','resourceType':'GMEvent','resourceVersion':'2.0'})
write('objects/HMWorld/HMWorld.yy',json.dumps(obj,indent=2)+'\n')
write('objects/HMWorld/Step_2.gml','if(!lockstep_stop && !UberCont.paused) scrHMGuardianLayers109();\n')
change('objects/HMWorld/Step_0.gml','scrHMWorldStep();',
       'scrHMWorldStep();\nif(logic_tick && !lockstep_stop && !UberCont.paused) scrHMEmptyExit109();')
path='objects/CustomEnemy/Create_0.gml'
write(path,(PROJECT/path).read_text(encoding='utf8').replace('if(instance_exists(HMGameplayTest)) hm_trace109=debug_get_callstack(10);\n',''))
change('scripts/scrPopulate/scrPopulate.gml','if (random(60) > _loops || object_index == Mimic',
       'if ((scrHMEnabled() && object_index==CustomEnemy) || random(60) > _loops || object_index == Mimic')
change('scripts/scrPopEnemies/scrPopEnemies.gml','\t    case area_scrapyards:',
       '\t    case area_scrapyards:\n            if(scrHMEnabled()) scrHMLoopMinigunner109(bbox_center_x,bbox_center_y);')
change('scripts/scrHMRepairs108/scrHMRepairs108.gml','instance_destroy(DustOLD,false);instance_destroy(WepPickup,false);',
       'instance_destroy(YungVenuzCouch,false);instance_destroy(ChestOpen,false);\n    instance_destroy(DustOLD,false);instance_destroy(WepPickup,false);')
change('scripts/scrDrawPlayerHUD/scrDrawPlayerHUD.gml','function scrDrawPlayerHUD(_player = noone) {',
       'function scrDrawPlayerHUD(_player = noone, _draw_interaction = true) {')
change('scripts/scrDrawPlayerHUD/scrDrawPlayerHUD.gml','if (!scrGameIsPaused()) scrDrawInteractionHUD(_player)',
       'if (_draw_interaction && !scrGameIsPaused()) scrDrawInteractionHUD(_player)')
change('scripts/scrDrawPlayerHUD/scrDrawPlayerHUD.gml','function scrDrawInteractionHUD(_player) {\n',
       'function scrDrawInteractionHUD(_player) {\n    var _ha=draw_get_halign(),_va=draw_get_valign();\n    try {\n    draw_align(fa_center,fa_top);\n')
path='scripts/scrDrawPlayerHUD/scrDrawPlayerHUD.gml'
text=(PROJECT/path).read_text(encoding='utf8')
if 'finally {draw_align(_ha,_va);}' not in text:
    assert text.rstrip().endswith('})\n}')
    write(path,text.rstrip()[:-1]+'    } finally {draw_align(_ha,_va);}\n}\n')
change('objects/TopCont/Draw_64.gml',
       'if instance_exists(_player) && !instance_exists(Credits) && !instance_exists(Cinematic) {\n    scrDrawPlayerHUD(_player)\n}',
       '''var _draw_controls=drawcontrols && instance_exists(_player)
    && !(instance_exists(MenuOptions) && MenuOptions.editing_mode)
    && !UberCont.opt_keyboard && !UberCont.opt_gamepad;
if instance_exists(_player) && !instance_exists(Credits) && !instance_exists(Cinematic) {
    scrDrawPlayerHUD(_player,!_draw_controls)
}''')
change('objects/TopCont/Draw_64.gml',
       'if drawcontrols && instance_exists(_player) && !(instance_exists(MenuOptions) && MenuOptions.editing_mode) && !UberCont.opt_keyboard && !UberCont.opt_gamepad {',
       'if _draw_controls {')
change('scripts/scrDrawRoadmap/scrDrawRoadmap.gml','function scrDrawRoadmap(_drawx, _drawy, _pos) {',
       'function scrDrawRoadmap(_drawx, _drawy, _pos) {\n    if(scrHMEnabled()) {scrHMRoadmap109(_drawx,_drawy,_pos);return;}')
write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
print('Release 1.0.9 host hooks registered')
