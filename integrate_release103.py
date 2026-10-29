"""Register 1.0.3 repairs after world/legacy/1.0.2 registration."""
import json
from create_project import load
from register_native import ROOT, PROJECT, register_script, replace, write

project=load(PROJECT/'nuclearthronemobile.yyp')
register_script(project,'scrHMRepairs103',(ROOT/'native/repairs103.gml').read_text(encoding='utf8'))
replace('objects/HMWorld/Other_5.gml','global.hm_tasks=[];',
        'global.hm_tasks=[];\nhm_titank_entering=false;')
catalog=json.loads((ROOT/'localization/zh-CN.json').read_text(encoding='utf8'))
normalized={key.upper():value for key,value in catalog.items()}
assert len(normalized)==len(catalog),'Case-insensitive localization collision'
registry='function scrHMLocalizationCatalog() {\nstatic _catalog='+json.dumps(normalized,ensure_ascii=False,indent=2)+';\nreturn _catalog;\n}\n'
register_script(project,'scrHMLocalization',registry+(ROOT/'native/localization.gml').read_text(encoding='utf8'))

replace('objects/Flame/Create_0.gml','event_inherited()',
        'event_inherited()\n// Legacy flame conversion copies this NTT field.\ndeflected=false;')
replace('objects/AmmoPickup/Create_0.gml','image_speed = 0','image_speed = 0\ncursed=false;')
replace('objects/CursedPickup/Create_0.gml','image_speed = 0','image_speed = 0\ncursed=true;')
replace('objects/MusCont/Alarm_11.gml','if !instance_exists(GameCont) exit',
        'if !instance_exists(GameCont) exit\nif(scrHMMusicRoom()) exit;')
replace('objects/MusCont/Alarm_1.gml','snd_play_music(_snd, false)',
        'song=_snd;hm_music_desired=song;\nsnd_play_music(_snd, false)')
replace('objects/MusCont/Alarm_3.gml','song = custom_sound_check(musBossDead)',
        'song = custom_sound_check(musBossDead)\n    hm_music_desired=song;')

for event in ['Other_10.gml','Alarm_1.gml']:
    path=PROJECT/'objects/HostileHorror'/event
    code=path.read_text(encoding='utf8')
    marker='// Hardmode palace horror cannot fire radiation.'
    if marker not in code:
        path.write_text(marker+'\nif(scrHMEnabled() && (self[$ "hm_palace_horror"]??false)) {ammo=0;exit;}\n'+code,encoding='utf8')
replace('objects/enemy/Step_0.gml','if (hp <= 0) instance_destroy()',
        'if(scrHMEnabled() && (self[$ "hm_palace_horror"]??false) && hp<=0) {scrHMPalaceHorrorStep();exit;}\n'
        'if(scrHMEnabled() && (self[$ "frozen"]??false)) exit;\n'
        'if (hp <= 0) instance_destroy()')
replace('objects/enemy/Destroy_0.gml','if givekill && instance_exists(GameCont) {',
        'scrHMDeathExit(x,y);\nif givekill && instance_exists(GameCont) {')
replace('objects/enemy/Destroy_0.gml','if corpse {',
        'if corpse && (!scrHMEnabled() || (sprite_exists(spr_dead) && spr_dead!=mskNone)) {')
path=PROJECT/'objects/Corpse/Other_7.gml'
code=path.read_text(encoding='utf8')
marker='// Empty custom death sprites have no animation-end lifecycle.'
if marker not in code:
    path.write_text(marker+'\nif(scrHMEnabled() && (!sprite_exists(sprite_index)||sprite_index==mskNone)) {image_speed=0;exit;}\n'+code,encoding='utf8')
# Recheck at alarm time: the current dying actor may still count during Destroy.
replace('scripts/scr_check_enemies/scr_check_enemies.gml',
        '    return (instance_number(enemy)',
        '    if(scrHMPendingBoss()) return true;\n    return (instance_number(enemy)')
replace('objects/Corpse/Alarm_0.gml','\t|| instance_exists(SitDown)',
        '\t|| instance_exists(SitDown) || scrHMPendingBoss()')
# Destruction still sees the dying HyperCrystal, so defer to the end of tick
# on a stable binding rather than testing while it is still counted.
path=PROJECT/'objects/HyperCrystal/Destroy_0.gml'
code=path.read_text(encoding='utf8')
marker='// Hardmode cursed-caves post-death restoration'
if marker not in code:
    code+='\n'+marker+'\nif(scrHMEnabled() && GameCont.area==scrHMAreaResolve("cavesinv")) with(HMWorld) scrHMBindEndStep(hm_maincode_mod_gml_CHCoutro,1,other.x,other.y);\n'
    path.write_text(code,encoding='utf8')

# Release runner build_type may be "run" on iOS. A preference must not be
# overridden by the IDE shortcut, and turning it off must close both consoles.
replace('objects/UberCont/Draw_75.gml','(opt_console || !public)', '(opt_console || (!scrHMEnabled() && !public))')
replace('objects/UberCont/Step_0.gml','(opt_console || !public)', '(opt_console || (!scrHMEnabled() && !public))')
replace('scripts/scrKeyboardHandleKeyPress/scrKeyboardHandleKeyPress.gml',
        'if (public && !opt_console) break', 'if ((scrHMEnabled() || public) && !opt_console) break')
replace('scripts/scrOptionsUpdate/scrOptionsUpdate.gml','if (opt_orig_console) opt_console = true',
        'if (opt_orig_console) opt_console = true\n'
        '        if(scrHMEnabled() && !opt_console) {\n'
        '            global.console_active=false;with(Console) {open=false;event_user(0);}\n'
        '            if(is_debug_overlay_open()) {show_debug_overlay(false);show_debug_log(false);}\n'
        '        }')

path=PROJECT/'scripts/scr_create_debug_overlay_views/scr_create_debug_overlay_views.gml'
code=path.read_text(encoding='utf8')
code=code.replace('var _area = area,\n\t\t\t\t\t_subarea = subarea',
    'var _area = area,\n\t\t\t\t\t_subarea = subarea\n'
    '\t\t\t\tif(scrHMEnabled()) {scrHMConsoleGoto(_area,_subarea,global.__debug_transit_loop);return;}')
start=code.index('\t\tvar _default_max_subareas = 3,')
end=code.index('\n\t#endregion',start)
old=code[start:end]
if 'Hardmode destinations' not in old:
    code=code[:start]+'''        // Hardmode destinations: actual extended areas, no stock secret aliases.
        if(scrHMEnabled()) {
            var _routes=[[1,3],[2,3],[3,5],[4,3],[5,5],[6,2],[7,4]];
            for(var _i=0;_i<array_length(_routes);++_i) {
                var _route=_routes[_i];
                for(var _s=1;_s<=_route[1];++_s) {
                    if(_s>1) dbg_same_line();
                    dbg_button(string(_route[0])+"-"+string(_s),__area_transit_button(_route[0],_s),70);
                }
            }
            var _extra=["nightdesert","scorpionboss","ravenboss","oasis","jungle","turtles","cavesinv","icecave","noyetihere","elevator","HQ","venuz","throne","end"];
            for(var _i=0;_i<array_length(_extra);++_i) {
                var _key=_extra[_i],_area=scrHMAreaResolve(_key);
                for(var _s=1;_s<=scrAreaGetMaxSubarea(_area);++_s) {
                    if(_s>1) dbg_same_line();
                    dbg_button(_key+"-"+string(_s),__area_transit_button(_area,_s),100);
                }
            }
        } else {
'''+old+'\n        }\n'+code[end:]
path.write_text(code,encoding='utf8')
path=PROJECT/'scripts/handle_console_command/handle_console_command.gml'
code=path.read_text(encoding='utf8')
marker='// Hardmode goto uses exact destinations without advancing again.'
if marker not in code:
    needle='            case "goto":\n            case "area":\n'
    assert needle in code
    code=code.replace(needle,needle+'                '+marker+'\n'
        '                if(scrHMEnabled()) {\n'
        '                    if(array_length(cmd)<2 || !scrHMConsoleCommand(cmd[1],array_length(cmd)>2?real(string_replace(cmd[2],"l","")):-1)) print("Use goto 1-1 .. 7-4 or area-name-subarea");\n'
        '                    break;\n                }\n',1)
path.write_text(code,encoding='utf8')
write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
print('Registered Hardmode 1.0.3 host contracts')

replace('objects/GenCont/Destroy_0.gml','with GameCont {\n    enemies = instance_number(enemy)',
        'scrHMFishSkullSpawn();\nwith GameCont {\n    enemies = instance_number(enemy)')
replace('objects/PortalClear/Collision_Wall.gml','scrWallDestroy(other.id)',
        'if(scrHMEnabled() && (self[$ "hm_water_clear"]??false)) scrHMSewerBank(other.id);\nelse scrWallDestroy(other.id)')
replace('objects/HyperCrystal/Other_10.gml','if (sprite_index != spr_fire) motion_add(',
        'if (sprite_index != spr_fire || scrHMEnabled()) motion_add(')
replace('objects/enemy/Step_0.gml','event_user(0)',
        'event_user(0)\nif(instance_exists(id)) scrHMGroundBounds();')

# The modern Draw events often pass literal alpha=1, while NTT used the
# instance alpha to hide the full body beneath its cropped swimming renderer.
objects={p.parent.name:load(p) for p in (PROJECT/'objects').glob('*/*.yy')}
def hitme_child(name):
    while name in objects:
        if name=='hitme':return True
        parent=objects[name].get('parentObjectId')
        if not parent:return False
        name=parent['name']
    return False
for name in objects:
    if not hitme_child(name):continue
    path=PROJECT/'objects'/name/'Draw_0.gml'
    if not path.exists():continue
    code=path.read_text(encoding='utf8')
    marker='// NTT swimming owns the cropped body renderer.'
    if marker not in code:
        path.write_text(marker+'\nif(scrHMEnabled() && (self[$ "swimming"]??false)) exit;\n'+code,encoding='utf8')
replace('objects/Menu/Draw_74.gml','string_hash_to_newline(loc(string_upper(unlock_hint)))',
        'string_hash_to_newline(scrHMLocalize(loc(string_upper(unlock_hint))))')
print('Registered sewer rendering, movement and stable generation hooks')
