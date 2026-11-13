"""Maintain 1.1.7 boss presentation and final-cave entrance fixes in place.

This does not run a historical content bootstrap or compile the project.
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent
P = ROOT / 'project/scripts'


def replace_once(path, old, new):
    text = path.read_text('utf8')
    if new in text:
        return
    assert text.count(old) == 1, (path, old[:100], text.count(old))
    path.write_text(text.replace(old, new, 1), 'utf8')


def mirror(source, name):
    (P / name / (name + '.gml')).write_text((ROOT / source).read_text('utf8'), 'utf8')


def main():
    # Match the maintained source dictionary; the generated catalog had
    # retained an older, inconsistent BIG DOG label.
    replace_once(P/'scrHMLocalization/scrHMLocalization.gml',
        '  "BIG DOG": "巨犬",\n', '  "BIG DOG": "大狗",\n')
    groups = ROOT / 'native/repairs109.gml'
    replace_once(groups,
        '    var _tag=_actor[$ "hm_boss_kind115"]??"";\n',
        '    // A helicopter hull and its falling actor are a live phase handoff,\n'
        '    // never an empty encounter eligible for a victory presentation.\n'
        '    var _name=_actor[$ "name"]??"";\n'
        '    if(_name=="hm_gungod_landing" || (_name=="GunGod" && (_actor[$ "hm_gungod_departed"]??false))) return "";\n'
        '    var _tag=_actor[$ "hm_boss_kind115"]??"";\n')
    replace_once(groups,
        '        _intro.hm_camera_start1116=HMWorld.logic_serial;\n',
        '        _intro.hm_camera_start1116=HMWorld.logic_serial;\n'
        '        _intro.hm_camera_wall_start1117=get_timer();\n')
    mirror('native/repairs109.gml', 'scrHMRepairs109')

    root = ROOT / 'native/repairs1115_root.gml'
    text = root.read_text('utf8')
    if 'function scrHMGunGodHandoff1117' not in text:
        text += '''
// The helicopter has not died: retire its presentation ledger before its
// harmless departure actor is created. Loop0 phase two reuses "gungod", so
// remove the finished phase ledger and let the real combat actor register anew.
function scrHMGunGodHandoff1117(_actor) {
    if(!instance_exists(_actor) || (_actor[$ "hm_extra"]??false)
        || !instance_exists(HMWorld)) return;
    var _kind=scrHMBossGroupKind115(_actor);
    if(_kind=="") return;
    var _groups=scrHMBossGroups115(),_group=_groups[$ _kind];
    scrHMBossGroupRetire115(_actor);
    if(!is_undefined(_group)) _group.phase_transition1117=true;
    if(variable_struct_exists(_groups,_kind)) variable_struct_remove(_groups,_kind);
}
'''
        root.write_text(text, 'utf8')
    mirror('native/repairs1115_root.gml', 'scrHMRepairs1115Root')
    for path in [P/'scrHMCompiled_bosses_gungod_mod_gml/scrHMCompiled_bosses_gungod_mod_gml.gml',
                 P/'scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml',
                 ROOT/'native/compiled_arkintide1103.gml']:
        replace_once(path,
            'hm_gungod_departed = 1;\n;\nhp = 14250;',
            'scrHMGunGodHandoff1117(id);\nhm_gungod_departed = 1;\n;\nhp = 14250;')

    policy=ROOT/'native/repairs1116_policy.gml'
    text=policy.read_text('utf8')
    if 'function scrHMBossPortraitLabel1117' not in text:
        text += '''
// Presentation strings are translated here, after boss identity and AI lookup.
// The large portrait sprites retain their original artwork in every language.
function scrHMBossPortraitLabel1117(_title) {
    var _key=string_upper(string_replace_all(string(_title),"#"," "));
    if(_key=="THE THRONE") _key="THE NUCLEAR THRONE";
    if(array_contains(["YV","Y.V","Y.V."],_key)) return "Y.V";
    return scrHMChinese()?scrHMLocalize(_key):_title;
}
function scrHMBossNativeTitle1117(_index,_kind) {
    var _titles=["BIG BANDIT","BIG DOG","LIL' HUNTER","THE NUCLEAR THRONE","THRONE II",
        "MOM","HYPER CRYSTAL","TECHNOMANCER","CAPTAIN","CURSED HYPER CRYSTAL","Y.V"];
    if(_index<0 || _index>=array_length(_titles)) return "";
    if(_index==10 && _kind=="gungod") return scrHMBossPortraitLabel1117("DA GUN GOD");
    return scrHMBossPortraitLabel1117(_titles[_index]);
}
function scrHMBossPortraitLayout1117(_title,_width=170) {
    var _previous=draw_get_font();draw_set_font(fntCJK);
    var _label=scrHMBossPortraitLabel1117(_title);
    var _w=max(1,font_get_string_width(_label)),_h=max(1,font_get_string_height(_label));
    var _scale=min(1.5,_width/_w,20/_h),_offset=font_get_height_diff()*_scale;
    draw_set_font(_previous);
    return {label:_label,font:fntCJK,scale:_scale,offset:_offset,width:_w*_scale,height:_h*_scale};
}
function scrHMBossPortraitTitleDraw1117(_x,_top,_title) {
    var _font=draw_get_font(),_color=draw_get_color(),_alpha=draw_get_alpha();
    var _ha=draw_get_halign(),_va=draw_get_valign();
    draw_set_halign(fa_center);draw_set_valign(fa_top);
    var _layout=scrHMBossPortraitLayout1117(_title),_y=floor(_top-_layout.offset);
    draw_set_font(_layout.font);draw_set_alpha(1);draw_set_color(c_black);
    draw_text_transformed(round(_x)+1,_y+1,_layout.label,_layout.scale,_layout.scale,0);
    draw_set_color(c_white);
    draw_text_transformed(round(_x),_y,_layout.label,_layout.scale,_layout.scale,0);
    draw_set_font(_font);draw_set_color(_color);draw_set_alpha(_alpha);
    draw_set_halign(_ha);draw_set_valign(_va);
    return _layout.label;
}

// The original Last Wish excavation and the guaranteed final-cave entrance
// share one usable flower. Removing duplicates never changes any Floor or
// FloorExplo created by the original excavation's jungle-floor painting.
function scrHMJungleFlowerRoom1117() {
    return scrHMEnabled() && instance_exists(GameCont) && GameCont.subarea==3
        && array_contains([scrHMAreaResolve("caves"),scrHMAreaResolve("cavesinv")],GameCont.area);
}
function scrHMJungleFlowerSingleton1117() {
    if(!scrHMJungleFlowerRoom1117()) return noone;
    var _keep=noone,_progress=-1,_actors=[];
    with(CustomHitme) if(name=="   feed") {
        array_push(_actors,id);
        var _p=fed+((driver!=-1)?100:0);
        if(_p>_progress || (_p==_progress && id<_keep)) {_keep=id;_progress=_p;}
    }
    for(var _i=0;_i<array_length(_actors);++_i)
        if(_actors[_i]!=_keep) instance_destroy(_actors[_i],false);
    if(instance_exists(_keep)) scrHMJungleFlowerFloor1117(_keep);
    return _keep;
}
function scrHMJungleFlowerFloor1117(_actor) {
    if(!instance_exists(_actor) || !scrHMJungleFlowerRoom1117()
        || (_actor[$ "hm_flower_floor1117"]??false)) return;
    _actor.hm_flower_floor1117=true;
    var _cx=_actor.x,_cy=_actor.y;
    // Paint existing geometry only. The original excavator may still create
    // its FloorExplo cells and paint its full jungle patch independently.
    with(Floor) if(point_distance(x+16,y+16,_cx,_cy)<52) sprite_index=sprFloor105;
    with(FloorExplo) if(point_distance(x+8,y+8,_cx,_cy)<52) sprite_index=sprFloor105;
}
function scrHMJungleFlowerPending1117() {
    if(!scrHMJungleFlowerRoom1117()) return false;
    var _pending=false;
    with(CustomObject) if(on_step==scrHMScriptRef(hm_props_mod_gml_cave_step)) {_pending=true;break;}
    return _pending;
}
'''
    policy.write_text(text, 'utf8')
    replace_once(policy,
        '        if(_actors[_i]!=_keep) instance_destroy(_actors[_i],false);\n    return _keep;',
        '        if(_actors[_i]!=_keep) instance_destroy(_actors[_i],false);\n'
        '    if(instance_exists(_keep)) scrHMJungleFlowerFloor1117(_keep);\n    return _keep;')
    text=policy.read_text('utf8')
    if 'function scrHMJungleFlowerFloor1117' not in text:
        text += '''
function scrHMJungleFlowerFloor1117(_actor) {
    if(!instance_exists(_actor) || !scrHMJungleFlowerRoom1117()
        || (_actor[$ "hm_flower_floor1117"]??false)) return;
    _actor.hm_flower_floor1117=true;
    var _cx=_actor.x,_cy=_actor.y;
    // Paint existing geometry only, including the unconditional entrance.
    with(Floor) if(point_distance(x+16,y+16,_cx,_cy)<52) sprite_index=sprFloor105;
    with(FloorExplo) if(point_distance(x+8,y+8,_cx,_cy)<52) sprite_index=sprFloor105;
}
'''
        policy.write_text(text,'utf8')
    replace_once(policy,
        '        // Use the original native sprite title; no new font or atlas is needed.\n'
        '        draw_sprite_ext(sprBossName,_boss,_center+1+hm_native_name_x1116,view_height*.5+1,1,1,0,c_black,1);\n'
        '        draw_sprite(sprBossName,_boss,_center+hm_native_name_x1116,view_height*.5);',
        '        if(scrHMChinese()) {\n'
        '            hm_native_title1117=scrHMBossNativeTitle1117(_boss,self[$ "hm_boss_kind115"]??"");\n'
        '            scrHMBossPortraitTitleDraw1117(_center+hm_native_name_x1116,view_height*.5-10,hm_native_title1117);\n'
        '        } else {\n'
        '            draw_sprite_ext(sprBossName,_boss,_center+1+hm_native_name_x1116,view_height*.5+1,1,1,0,c_black,1);\n'
        '            draw_sprite(sprBossName,_boss,_center+hm_native_name_x1116,view_height*.5);\n'
        '        }')
    mirror('native/repairs1116_policy.gml','scrHMRepairs1116Policy')

    sync=ROOT/'native/sync1103_bosses.gml'
    replace_once(sync,
        '    var _font=draw_get_font();\n    if(_title=="The#Messenger" || _title=="THE#MESSENGER") {',
        '    var _font=draw_get_font();\n'
        '    if(scrHMChinese()) {\n'
        '        hm_custom_title1117=scrHMBossPortraitTitleDraw1117(_x,_y,_title);\n'
        '    } else if(_title=="The#Messenger" || _title=="THE#MESSENGER") {')
    mirror('native/sync1103_bosses.gml','scrHMSync1103Bosses')

    props=P/'scrHMCompiled_props_mod_gml/scrHMCompiled_props_mod_gml.gml'
    replace_once(props,
        'function hm_props_mod_gml_Flower_create(_hml__x, _hml__y) {\n',
        'function hm_props_mod_gml_Flower_create(_hml__x, _hml__y) {\n'
        'var _existing1117=scrHMJungleFlowerSingleton1117();\n'
        'if(instance_exists(_existing1117)) return _existing1117;\n')
    replace_once(props,
        'on_step = scrHMScriptRef(hm_props_mod_gml_Flower_step);\n',
        'on_step = scrHMScriptRef(hm_props_mod_gml_Flower_step);\n'
        'scrHMJungleFlowerFloor1117(id);\n')
    for path in [P/'scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml',
                 ROOT/'native/compiled_arkintide1103.gml']:
        replace_once(path,
            'function hm_arkintide_mod_gml_hm_jungle_entrance() {\n',
            'function hm_arkintide_mod_gml_hm_jungle_entrance() {\n'
            'if(instance_exists(scrHMJungleFlowerSingleton1117()) || scrHMJungleFlowerPending1117()) exit;\n')

    replace_once(ROOT/'project/objects/BackCont/Step_0.gml',
        '        var _smooth=1-power(.9,timescale);',
        '        var _clock=timescale;\n'
        '        if(instance_exists(HMWorld) && HMWorld.hm_portrait_active==_target)\n'
        '            _clock=scrHMClockSafe1117()?clamp(delta_time/1000000,0,.25)*30:0;\n'
        '        var _smooth=1-power(.9,_clock);')

    # The guaranteed entrance already supplies the ordinary cave. Do not
    # restore its obsolete wall excavation merely to paint the floor.
    cave=P/'scrHMCompiled_areas_caves_area_gml/scrHMCompiled_areas_caves_area_gml.gml'
    anchor='instance_create((x + 16), (y + 16), HyperCrystal);\n'
    lastwish='''if (scrHMGetSkill(18)) {
var _wish_floor1117=instance_nearest(x,y,Floor);
if(instance_exists(_wish_floor1117))
    scrHMModCall("mod","props","cave_create",_wish_floor1117.x+16+lengthdir_x(64,point_direction(Player.x,Player.y,x,y)),
        _wish_floor1117.y+16+lengthdir_y(64,point_direction(Player.x,Player.y,x,y)));
}
'''
    text=cave.read_text('utf8')
    if lastwish in text:
        cave.write_text(text.replace(lastwish,''),'utf8')
    print('1.1.7 presentation and single final-cave flower edits maintained; no compilation performed')


if __name__=='__main__':
    main()
