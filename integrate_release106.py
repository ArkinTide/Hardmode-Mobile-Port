"""Maintain the 1.0.6 adapters; never modify frozen MOD or base input."""
import json
import re
from collections import Counter
from PIL import Image
from create_project import load
from register_native import ROOT, PROJECT, register_script, replace, write

project=load(PROJECT/'nuclearthronemobile.yyp')
register_script(project,'scrHMRepairs106',(ROOT/'native/repairs106.gml').read_text(encoding='utf8'))
replace('objects/HMWorld/Step_0.gml','scrHMWorldStep();',
    'scrHMWorldStep();\nif(logic_tick && !lockstep_stop && !UberCont.paused) scrHMVenusTerrain106();')
replace('scripts/scrHMRepairs103/scrHMRepairs103.gml','function scrHMSewerBank(_wall) {',
    'function scrHMSewerBank(_wall) {scrHMSewerBank106(_wall);}\nfunction scrHMSewerBank103Legacy(_wall) {')
path='objects/FloorExplo/Create_0.gml';text=(PROJECT/path).read_text(encoding='utf8')
if '// Intact sewer bank cells, including split exterior blocks.' not in text:
    text+='\n// Intact sewer bank cells, including split exterior blocks.\nif(scrHMEnabled() && variable_global_exists("hm_sewer_bank106") && global.hm_sewer_bank106) {sprite_index=sprFloor2;image_index=0;}\n'
write(path,text)

# Silent NTT hit sounds use the same noone sentinel as optional shadows.
for script in ('snd_play_hit','snd_play_hit_big'):
    path=f'scripts/{script}/{script}.gml';text=(PROJECT/path).read_text(encoding='utf8')
    marker='_sound_index = custom_sound_check(_sound_index)'
    if 'if(!audio_exists(_sound_index)) return -1;' not in text:
        assert marker in text
        text=text.replace(marker,marker+'\n    if(!audio_exists(_sound_index)) return -1;',1)
    write(path,text)

# NTT accepts noone/-4 for actors with no shadow. The host shadow pass
# must not send that sentinel to a sprite builtin (e.g. Venus Mutant Rat).
path='scripts/scrShadows/scrShadows.gml';text=(PROJECT/path).read_text(encoding='utf8')
text=text.replace('if (visible) draw_sprite(spr_shadow,',
                  'if (visible && sprite_exists(spr_shadow)) draw_sprite(spr_shadow,')
text=re.sub(r'(?m)^(\s*)draw_sprite\(spr_shadow,',
            r'\1if(sprite_exists(spr_shadow)) draw_sprite(spr_shadow,',text)
write(path,text)

# CPU-side palette from unchanged source PNGs; no GPU texture readbacks.
colors={}
for folder in (PROJECT/'sprites').iterdir():
    if not (folder.name.startswith('sprHM_') or re.fullmatch(r'sprWall\d+Top',folder.name)):
        continue
    meta=load(folder/(folder.name+'.yy'))
    if not meta.get('frames'):continue
    image=Image.open(folder/(meta['frames'][0]['name']+'.png')).convert('RGBA')
    opaque=[p[:3] for p in image.getdata() if p[3]==255]
    if opaque:colors[folder.name]=Counter(opaque).most_common(1)[0][0]
lines=['function scrHMWallPalette106(_spr) {switch(_spr) {']
for name,(r,g,b) in colors.items():lines.append(f'case {name}:return make_color_rgb({r},{g},{b});')
lines+=['}return scrHMBackgroundColour105();}',
    'function scrHMWallColour106(_spr) {',
    'var _over=variable_global_exists("hm_wall_palette106")?global.hm_wall_palette106[$ string(_spr)]:undefined;',
    'return is_undefined(_over)?scrHMWallPalette106(_spr):_over;}',
    'function scrHMWallPaletteReplace106(_target,_replacement) {',
    'if(!variable_global_exists("hm_wall_palette106")) global.hm_wall_palette106={};',
    'global.hm_wall_palette106[$ string(_target)]=scrHMWallPalette106(_replacement);}',
    'function scrHMWallPaletteRestore106(_target) {',
    'if(variable_global_exists("hm_wall_palette106")) global.hm_wall_palette106[$ string(_target)]=undefined;}']
register_script(project,'scrHMWallPalette106','\n'.join(lines))

replace('scripts/scrHMApi/scrHMApi.gml','sprite_assign(_target,_replacement);',
    'sprite_assign(_target,_replacement);scrHMWallPaletteReplace106(_target,_replacement);')
replace('scripts/scrHMApi/scrHMApi.gml','function scrHMSpriteRestore(_target) {',
    'function scrHMSpriteRestore(_target) {\n    scrHMWallPaletteRestore106(_target);')
replace('scripts/scrHMApi/scrHMApi.gml','function scrHMWeaponList(_list,_minimum,_maximum) {',
    'function scrHMWeaponList(_list,_minimum,_maximum) {\n    _maximum=max(_minimum,_maximum);')

replace('scripts/scrHMRepairs104/scrHMRepairs104.gml','function scrHMWallFillStep() {',
    'function scrHMWallFillStep() {return scrHMFillStep106();}\nfunction scrHMWallFillStep104Legacy() {')
path='scripts/scrHMRepairs104/scrHMRepairs104.gml';text=(PROJECT/path).read_text(encoding='utf8')
if '// Include disconnected Venus rooms behind unopened doors.' not in text:
    marker='    // Static cells have no Step/Draw work.'
    assert marker in text
    text=text.replace(marker,'''    // Include disconnected Venus rooms behind unopened doors.
    if(GameCont.area==scrHMAreaResolve("venuz")) {
        with(Floor) {_left=min(_left,x);_right=max(_right,x+32);_top=min(_top,y);_bottom=max(_bottom,y+32);}
        with(CustomObject) if(name=="floor") {_left=min(_left,x);_right=max(_right,x+32);_top=min(_top,y);_bottom=max(_bottom,y+32);}
    }
'''+marker,1)
write(path,text)
old='''    if(GameCont.area==scrHMAreaResolve("venuz")) {
        with(Floor) {_left=min(_left,x);_right=max(_right,x+32);_top=min(_top,y);_bottom=max(_bottom,y+32);}
        with(CustomObject) if(name=="floor") {_left=min(_left,x);_right=max(_right,x+32);_top=min(_top,y);_bottom=max(_bottom,y+32);}
    }'''
new='''    if(GameCont.area==scrHMAreaResolve("venuz")) {
        // Authored Venus maps use coordinates near zero, separate from the
        // host's temporary generation seed at (10000,10000).
        _seed=instance_nearest(0,0,Floor);
        _left=_seed.x;_right=_seed.x+32;_top=_seed.y;_bottom=_seed.y+32;
        with(Floor) if(point_distance(x,y,_seed.x,_seed.y)<4096) {_left=min(_left,x);_right=max(_right,x+32);_top=min(_top,y);_bottom=max(_bottom,y+32);}
        with(CustomObject) if(name=="floor" && point_distance(x,y,_seed.x,_seed.y)<4096) {_left=min(_left,x);_right=max(_right,x+32);_top=min(_top,y);_bottom=max(_bottom,y+32);}
    }'''
assert old in text or new in text
write(path,text.replace(old,new))
replace('scripts/scrHMRepairs104/scrHMRepairs104.gml','function scrHMWallThemeStart(_origin) {',
    'function scrHMWallThemeStart(_origin) {\n    HMWorld.hm_wall_theme_area106=GameCont.area;')
replace('scripts/scrHMRepairs105/scrHMRepairs105.gml','function scrHMCarveFill105(_size) {',
    'function scrHMCarveFill105(_size) {scrHMCarveFill106(_size);}\nfunction scrHMCarveFill105Legacy(_size) {')
replace('scripts/scrHMRepairs105/scrHMRepairs105.gml','function scrHMInteriorEdge105() {',
    'function scrHMInteriorEdge105() {return scrHMPlainWall106();}\nfunction scrHMInteriorEdge105Legacy() {')
replace('scripts/scrWallDestroy/scrWallDestroy.gml','if (!instance_exists(_instance)) exit',
    'if (!instance_exists(_instance)) exit\n    if(scrHMDestroyFill106(_instance)) exit')

# Static walls never need an all-pairs Wall/Wall collision event during play.
# Cull duplicates once when authored walls are created instead.
path='objects/Wall/Wall.yy';obj=load(PROJECT/path)
obj['eventList']=[e for e in obj['eventList'] if e['eventType']!=4]
write(path,json.dumps(obj,indent=2)+'\n')
path='objects/Wall/Create_0.gml';text=(PROJECT/path).read_text(encoding='utf8')
marker='// Static duplicates are removed at creation.'
if marker not in text:
    text=marker+'\nif(scrHMEnabled() && collision_point(x+8,y+8,Wall,false,true)!=noone) {instance_destroy(id,false);exit;}\n'+text
text=text.replace('scrHMEnabled() && position_meeting(x+8,y+8,Wall)', 'scrHMEnabled() && collision_point(x+8,y+8,Wall,false,true)!=noone')
write(path,text)

path='objects/SubTopCont/Draw_0.gml';text=(PROJECT/path).read_text(encoding='utf8')
text=text.replace('if(scrHMEnabled() && scrHMInteriorEdge105()) continue;',
    'if(scrHMEnabled() && scrHMPlainWall106()) continue;',1)
text=text.replace('if(scrHMEnabled() && scrHMInteriorEdge105()) continue;',
    'if(scrHMEnabled() && scrHMPlainWall106()) {scrHMDrawPlainWall106();continue;}',1)
write(path,text)
replace('objects/GenCont/Create_0.gml','background_set_colour(background_color);',
    '// area_setup writes the actual room background through the legacy adapter.')
replace('objects/TopCont/Create_0.gml','if GameCont.area && GameCont.area != 106 && round(GameCont.area / 2) == GameCont.area / 2 {',
    'if !(scrHMEnabled() && scrHMAreaHas(GameCont.area)) && GameCont.area && GameCont.area != 106 && round(GameCont.area / 2) == GameCont.area / 2 {')
replace('objects/GenCont/Alarm_1.gml','with (Wall) {\n\tmcr_wall_update_lrwh;',
    'with (Wall) {\n    if(self[$ "hm_interior_wall"]??false) continue;\n\tmcr_wall_update_lrwh;')
path='objects/Portal/Create_0.gml';text=(PROJECT/path).read_text(encoding='utf8')
if '// Hardmode police exits use blue portal art.' not in text:
    text+='\n// Hardmode police exits use blue portal art.\nif(scrHMEnabled() && GameCont.area==scrHMAreaResolve("HQ")) type=2;\n'
write(path,text)
replace('objects/Bandit/Create_0.gml','if GameCont.area == area_city {',
    'if scrHMUnlockArea(GameCont.area) == area_city {')

# NTT's LilHunter projectiles expose creator; the host's native Alarm did
# not, so the MOD's creator-filtered replacements never found those shots.
path='objects/LilHunter/Alarm_1.gml';text=(PROJECT/path).read_text(encoding='utf8')
text=text.replace('hitid = other.hitid','creator = other.id\n                            hitid = other.hitid') if 'creator = other.id' not in text else text
write(path,text)

from release_config import VERSION, BUILD
# Reject unsupported crown selections before touching either array dimension.
# Keep the stored unlock progress and all valid selections intact.
path='scripts/scrLoadoutMenuInit/scrLoadoutMenuInit.gml'
text=(PROJECT/path).read_text(encoding='utf8')
old='''function scr_loadout_race_get_start_crown(_race_id) {
	if UberCont.cgot[_race_id] {
		return save_get_value("ccrown", _race_id, crwn_none)
	}
	
	return crwn_none
}'''
new='''function scr_loadout_race_get_start_crown(_race_id) {
    if(!scrHMCrownLoadoutValid106(_race_id,crwn_none)) return crwn_none;
    if(!UberCont.cgot[_race_id]) return crwn_none;
    var _crown=save_get_value("ccrown",_race_id,crwn_none);
    return scrHMCrownLoadoutValid106(_race_id,_crown)?_crown:crwn_none;
}'''
assert old in text or new in text
text=text.replace(old,new)
for function in ('scr_loadout_race_set_start_crown','scr_loadout_race_is_crown_unlocked','scr_loadout_race_unlock_crown'):
    prefix=f'function {function}(_race_id, _crown_id) {{'
    guarded=prefix+'\n    if(!scrHMCrownLoadoutValid106(_race_id,_crown_id)) return false;'
    assert prefix in text
    if guarded not in text:text=text.replace(prefix,guarded,1)
write(path,text)

for platform in ('windows','android','ios'):
    path=f'options/{platform}/options_{platform}.yy';obj=load(PROJECT/path)
    obj[f'option_{platform}_version']=VERSION+('.0' if platform=='windows' else '')
    if platform=='ios':obj['option_ios_build_number']=BUILD
    write(path,json.dumps(obj,indent=2)+'\n')
path='objects/UberCont/Create_0.gml';text=(PROJECT/path).read_text(encoding='utf8')
write(path,re.sub(r'#macro GAME_VERSION "[^\"]+"',f'#macro GAME_VERSION "Hardmode {VERSION}"',text))
manifest=ROOT/'platforms/android/gradle-project/com.arkintide.nuclearthronehardmode/src/main/AndroidManifest.xml'
text=manifest.read_text(encoding='utf8')
text=re.sub(r'android:versionCode="\d+"',f'android:versionCode="{BUILD}"',text)
text=re.sub(r'android:versionName="[^\"]+"',f'android:versionName="{VERSION}"',text)
manifest.write_text(text,encoding='utf8')
write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
print('Registered Hardmode 1.0.6, palette entries',len(colors))
