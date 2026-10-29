"""Connect the compiled MOD to explicit native lifecycle and area contracts."""
import json,re

from create_project import load
from register_native import ROOT, PROJECT, write, replace, register_script
from register_actors import register_object


def append(path, marker, code):
    text=(PROJECT/path).read_text(encoding="utf8")
    if marker not in text: write(path,text+"\n"+marker+"\n"+code+"\n")


def main():
    project=load(PROJECT/"nuclearthronemobile.yyp")
    modules=load(ROOT/"native-compilation-map.json")["modules"]
    # Includes alternate branches which retain their source subarea numbers.
    lengths={"HQ":4,"oasis":5,"jungle":5,"cavesinv":3,"palace":4,
             "labs":2,"city":5,"caves":3,"junkyard":5,"sewers":3,
             "venuz":12,"elevator":3,"nightdesert":4,"scorpionboss":5,
             "ravenboss":3}
    identities=["function scrHMRegisterIdentities() {"]
    number=200
    for row in modules:
        path=row["source"]
        if not path.startswith("areas/"): continue
        name=path.split("/")[-1].removesuffix(".area.gml")
        identities += [f'global.hm_area_ids[$ {json.dumps(name)}]={number};',
                       f'global.hm_area_keys[$ "{number}"]={json.dumps("area:"+name)};',
                       f'global.hm_area_lengths[$ "{number}"]={lengths.get(name,1)};']
        number+=1
    # These legacy portal markers are immediately redirected by the area's
    # transit hooks in NTT. Store their destination in the native host.
    identities += ['global.hm_area_ids[$ "bigdog"]=-1003;',
                   'global.hm_area_ids[$ "cavesecret"]=global.hm_area_ids.icecave;',
                   'global.hm_area_ids[$ "yeti"]=global.hm_area_ids.noyetihere;',
                   'global.hm_area_ids[$ "idpd"]=global.hm_area_ids.HQ;',
                   'global.hm_area_ids[$ "jungleboogie"]=global.hm_area_ids.jungle;',
                   'global.hm_area_ids[$ "sewersentrance"]=global.hm_area_ids.sewers;',
                   'global.hm_area_ids[$ "space"]=global.hm_area_ids.venuz;',
                   'global.hm_area_ids[$ "mansion"]=103;',
                   'global.hm_area_ids[$ "gatorcave"]=-1001;',
                   'global.hm_area_ids[$ "gatorboss"]=-1002;',"}"]
    register_script(project,"scrHMIdentities","\n".join(identities)+"\n")
    register_script(project,"scrHMWorld",(ROOT/"native/world.gml").read_text(encoding="utf8"))
    register_script(project,"scrHMAPI",(ROOT/"native/api.gml").read_text(encoding="utf8"))
    replace("objects/Player/Step_0.gml", "var _is_local = scr_player_is_local(index)",
            "scrHMWeaponStep();\nvar _is_local = scr_player_is_local(index)")
    write("scripts/custom_sound_check/custom_sound_check.gml", '''function custom_sound_check(_sound) {
    if(variable_global_exists("hm_sound_replacements"))
        _sound=global.hm_sound_replacements[$ string(_sound)] ?? _sound;
    return global.custom_sounds[$ string(_sound)] ?? _sound;
}
''')
    register_script(project,"scrHMWorldTests",(ROOT/"tests/world-native.gml").read_text(encoding="utf8"))
    register_object(project,"HMWorld",None,{
        (0,0,None):"scrHMWorldInit();",
        (3,1,None):"scrHMWorldBegin();",
        (3,0,None):"scrHMWorldStep();",
        (8,0,None):'if(!lockstep_stop) {scrHMHook("draw"); if(UberCont.paused) scrHMHook("draw_pause");}',
        (8,64,None):'if(!lockstep_stop) scrHMHook("draw_gui");',
        (7,5,None):'global.hm_tasks=[];',
    })
    obj=load(PROJECT/"objects/HMWorld/HMWorld.yy");obj["persistent"]=True
    write("objects/HMWorld/HMWorld.yy",json.dumps(obj,indent=2)+"\n")
    register_object(project,"HMBinding",None,{
        (0,0,None):"hm_code=undefined;hm_args=[];hm_draw=false;hm_delay=0;creator=noone;hm_menu_overlay=false;hm_refresh_tick=-1;",
        (3,2,None):"scrHMBindingEndStep();",(8,0,None):"scrHMBindingDraw();",
    })
    replace("objects/MakeGame/Alarm_0.gml","if (scrHMActorsTests()) exit;",
            "if (scrHMWorldTests()) exit;\nif (scrHMActorsTests()) exit;")
    replace("objects/MakeGame/Alarm_0.gml","//\nvar info = os_get_info(), udid;",
            "// Hardmode lifecycle starts after isolated regression entrypoints.\n"
            "if(!instance_exists(HMWorld)) instance_create(0,0,HMWorld);\n\n//\nvar info = os_get_info(), udid;")
    replace("scripts/scrCleanupSessionInstances/scrCleanupSessionInstances.gml","if (object_index == UberCont",
            "if (object_index == HMWorld || object_index == UberCont")
    replace("scripts/scrRunStart/scrRunStart.gml","    room_restart()",
            "    scrHMRunStart();\n    room_restart()")
    replace("scripts/scrFire/scrFire.gml","\t\tdefault: print(\"Unkown weapon:\", _wep)",
            '\t\tdefault: if(!scrHMWeaponFire(_wep)) print("Unkown weapon:", _wep)')
    for getter,prop,default in [("name","weapon_name",'""'),("area","weapon_area","-1")]:
        if getter=='name' and 'return scrHMLocalize(scrHMWeaponProperty(_key,"weapon_name",""));' in (PROJECT/'scripts/scr_weapon_get_type/scr_weapon_get_type.gml').read_text(encoding='utf8'):
            continue
        replace("scripts/scr_weapon_get_type/scr_weapon_get_type.gml",
                f'function scr_weapon_get_{getter}(_weapon) {{',
                f'function scr_weapon_get_{getter}(_weapon) {{\n'
                '    if(scrHMEnabled()) {var _key=global.hm_weapon_keys[$ string(_weapon)];\n'
                f'        if(!is_undefined(_key)) return scrHMWeaponProperty(_key,"{prop}",{default});\n'
                '    }')
    replace("scripts/scrArea/scrArea.gml","function scrAreaGetMaxSubarea(_area) {",
            'function scrAreaGetMaxSubarea(_area) {\n'
            '    if(scrHMEnabled() && scrHMAreaHas(_area)) return global.hm_area_lengths[$ string(_area)];')
    replace("scripts/scrAreaGetMapName/scrAreaGetMapName.gml",
            '    var _area_string = "",',
            '    if(scrHMEnabled() && scrHMAreaHas(_area)) {\n'
            '        var _label; with(GameCont) {var _old=subarea;subarea=_subarea;_label=scrHMAreaCall(_area,"area_name");subarea=_old;}\n'
            '        return string(_label)+(_loop>0?" L"+string(_loop):"");\n'
            '    }\n    var _area_string = "",')
    replace("objects/GameCont/Other_5.gml","var _is_secret = (area >= 100)",
            'if(scrHMEnabled() && scrHMAreaHas(area) && !_went_crib) {scrHMAreaAdvance();exit;}\n'
            'var _is_secret = (area >= 100)')
    append("objects/GameCont/Other_5.gml","// Hardmode area transit hooks",'if(scrHMEnabled()) scrHMAreaTransit();')
    # Keep sprite mapping at the host's tile/resource boundary, so floors,
    # wall tops, rubble and explosion tiles all resolve the same active theme.
    for folder in ["Floor","Wall","TopSmall","Detail","FloorExplo","Debris","Top"]:
        for path in (PROJECT/"objects"/folder).glob("*.gml"):
            text=path.read_text(encoding="utf8")
            if "asset_get_index(" in text:
                write(path.relative_to(PROJECT),text.replace("asset_get_index(","scrHMAssetIndex("))
    # Source area_setup can select safespawn; do not overwrite that choice.
    # Normalize both maintained forms before inserting exactly one hook.
    gen_create=(PROJECT/"objects/GenCont/Create_0.gml").read_text(encoding="utf8")
    setup=('if(scrHMEnabled() && scrHMAreaHas(GameCont.area)) {\n'
           '    scrHMAreaCall(GameCont.area,"area_setup");\n'
           '    // area_setup writes the actual room background through the legacy adapter.\n'
           '    with(BackCont) if(variable_instance_exists(id,"shadcol")) shadow_color=shadcol;\n'
           '}')
    gen_create=re.sub(r'if\(scrHMEnabled\(\) && scrHMAreaHas\(GameCont.area\)\) \{\n'
        r'    scrHMAreaCall\(GameCont.area,"area_setup"\);\n'
        r'    (?:background_set_colour\(background_color\);|// area_setup writes[^\n]*)\n'
        r'    with\(BackCont\) if\(variable_instance_exists\(id,"shadcol"\)\) shadow_color=shadcol;\n\}', '', gen_create)
    needle='safedir = choose(0, 90, 180, 270)'
    write("objects/GenCont/Create_0.gml",gen_create.replace(needle,needle+'\n'+setup))
    replace("scripts/scrMakeFloor/scrMakeFloor.gml","    // create actual floors:",
            '    if(scrHMEnabled() && scrHMAreaHas(_area)) {scrHMAreaCall(_area,"area_make_floor");return;}\n'
            '    // create actual floors:')
    replace("scripts/scrPopEnemies/scrPopEnemies.gml","\tvar _loops = GameCont.loops,",
            '    if(scrHMEnabled() && scrHMAreaHas(GameCont.area)) {scrHMAreaCall(GameCont.area,"area_pop_enemies");return;}\n'
            '\tvar _loops = GameCont.loops,')
    replace("scripts/scrPopProps/scrPopProps.gml","\tvar _area = spawnarea,",
            '    if(scrHMEnabled() && scrHMAreaHas(GameCont.area)) {scrHMAreaCall(GameCont.area,"area_pop_props");return;}\n'
            '\tvar _area = spawnarea,')
    replace("objects/GenCont/Alarm_1.gml","// console 的 debugclear：",
            'if(scrHMEnabled() && scrHMAreaHas(GameCont.area)) scrHMAreaCall(GameCont.area,"area_start");\n\n'
            '// console 的 debugclear：')
    # Suppress vanilla boss creation inside a MOD area; area_start creates
    # the source-specified boss and intro at its actual location.
    replace("scripts/scrPopulate/scrPopulate.gml","\t\t_has_boss = (_subarea == _max_subarea),",
            '\t\t_has_boss = (_subarea == _max_subarea) && !(scrHMEnabled() && scrHMAreaHas(_area)),')
    # The source reads vertical offsets during intros on any damageable object.
    append("objects/hitme/Create_0.gml","// Hardmode NTT vertical offset",'z=0;')
    replace("objects/GenCont/Destroy_0.gml",'with enemy {\n\tif place_meeting(x, y, Floor) continue',
            'with enemy {\n\t// Scripted MOD actors may intentionally occupy walls or invisible arena markers.\n'
            '\tif(variable_instance_exists(id,"hm_custom_actor")) continue;\n'
            '\tif place_meeting(x, y, Floor) continue')
    # Legacy callbacks and timers advance at 30 Hz; native velocity and
    # animation are dimensionally converted by the compiler.
    for folder in ["CustomObject","CustomHitme","CustomProjectile","CustomEnemy"]:
        for name in ["Step_0.gml","Step_1.gml","Step_2.gml"]:
            path=PROJECT/"objects"/folder/name
            text=path.read_text(encoding="utf8")
            if "scrHMReadyTick()" not in text:
                write(path.relative_to(PROJECT),'if(!scrHMReadyTick()) exit;\n'+text)
    # World-space light callbacks must be drawn with the same camera offset
    # as the original NTT surface contract.
    for script,hook in [("scrDarkness","draw_dark"),("scrShadows","draw_shadows")]:
        path=f"scripts/{script}/{script}.gml"
        text=(PROJECT/path).read_text(encoding="utf8")
        marker="// Hardmode world-space surface hook"
        if marker not in text:
            pos=text.rindex("\tsurface_reset_target()")
            code=(f'\t{marker}\n\tif(scrHMEnabled()) {{\n'
                  '\t\tvar _matrix=matrix_get(matrix_world);\n'
                  '\t\tmatrix_set(matrix_world,matrix_build(-view_xview,-view_yview,0,0,0,0,1,1,1));\n'
                  f'\t\tscrHMHook("{hook}");\n'
                  + ('\t\tscrHMHook("draw_dark_end");\n' if hook=="draw_dark" else '')
                  +'\t\tmatrix_set(matrix_world,_matrix);\n\t}\n')
            write(path,text[:pos]+code+text[pos:])
    # Legacy fog is selected by area_setup, independently of numeric base IDs.
    if 'scrHMDrawFog();' not in (PROJECT/'objects/TopCont/Draw_0.gml').read_text(encoding='utf8'):
        replace("objects/TopCont/Draw_0.gml","var spr = -1",
                'var spr = self[$ "fog"] ?? -1')
        replace("objects/TopCont/Draw_0.gml", "if spr != -1 {", "if sprite_exists(spr) {")
    write("nuclearthronemobile.yyp",json.dumps(project,ensure_ascii=False,indent=2)+"\n")
    print("Registered full source lifecycle and area/weapon boundaries; native gameplay verification required")


if __name__=="__main__":main()
