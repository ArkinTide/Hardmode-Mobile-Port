"""Focused 1.0.11 integration; never replay historical integration passes."""
import json,re
from pathlib import Path
from register_native import ROOT,PROJECT,register_script,write

def change(relative,old,new):
    path=PROJECT/relative
    text=path.read_text(encoding='utf8')
    if new in text:return
    assert text.count(old)==1,(relative,old,text.count(old))
    write(relative,text.replace(old,new,1))

def main():
    from create_project import load
    from release_config import VERSION,BUILD
    project=load(PROJECT/'nuclearthronemobile.yyp')
    register_script(project,'scrHMRepairs111',(ROOT/'native/repairs111.gml').read_text(encoding='utf8'))
    change('scripts/InputHandling/InputHandling.gml','players: 1',
        'wheel_pending111: [false,false,false,false],\n    wheel_until111: [0,0,0,0],\n    wheel_consumed111: [-1,-1,-1,-1],\n    wheel_frame111: 0,\n    players: 1')
    change('scripts/InputHandling/InputHandling.gml',
        'scrDesktopWheelSwap(_index, mouse_wheel_up(), mouse_wheel_down())','scrDesktopWheelMerge111(_index)')
    path='scripts/InputHandling/InputHandling.gml'
    text=(PROJECT/path).read_text(encoding='utf8')
    a=text.index('function scrDesktopWheelSwap(');b=text.index('\nfunction scrSetCardinalDirectionInputs',a)
    text=text[:a]+'''function scrDesktopWheelSwap(_index, _up, _down) {
    if(!_up && !_down) return;
    if(!scrDesktopWheelAllowed111()) {KeyCont.wheel_pending111[_index]=false;return;}
    if(KeyCont.wheel_consumed111[_index]==KeyCont.wheel_frame111) return;
    KeyCont.wheel_pending111[_index]=true;
    KeyCont.wheel_until111[_index]=get_timer()+150000;
    scrDesktopWheelMerge111(_index);
}
'''+text[b:]
    write(path,text)
    path='objects/UberCont/Create_0.gml'
    text=(PROJECT/path).read_text(encoding='utf8')
    text=re.sub(r'#macro GAME_VERSION "Hardmode [^"]+"',f'#macro GAME_VERSION "Hardmode {VERSION}"',text)
    write(path,text)
    change('objects/UberCont/Step_1.gml','/// @description Control pause states',
        '/// @description Control pause states\nscrDesktopWheelFrame111();')
    change('objects/Player/Step_0.gml','if can_swap && KeyCont.press_swap[index] && bwep != 0 {',
        'if can_swap && (KeyCont.press_swap[index] || scrDesktopWheelPending111(index)) && bwep != 0 {')
    change('objects/Player/Step_0.gml','\tscrSwapWeps()\n\tswapanim = 1','\tscrDesktopWheelConsume111(index);\n\tscrSwapWeps()\n\tswapanim = 1')
    change('objects/GenCont/Alarm_2.gml','else if (GameCont.crownvisits < 3',
        'else if (!scrHMEnabled() && GameCont.crownvisits < 3')
    change('scripts/scrHMRepairs109/scrHMRepairs109.gml',
        'if(_f.traction!=2) return false;','if(_f.traction!=2 || scrHMWaterBank111(_f,_x,_y)) return false;')
    path='scripts/scrHMCompiled_areas_sewers_area_gml/scrHMCompiled_areas_sewers_area_gml.gml'
    text=(PROJECT/path).read_text(encoding='utf8')
    if 'scrHMWaterSurface111();' not in text:
        assert text.count('image_yscale = 0.8;')==3
        write(path,text.replace('image_yscale = 0.8;','image_yscale = 0.8;\nscrHMWaterSurface111();'))
    change('scripts/scrHMRepairs103/scrHMRepairs103.gml',
        '// The wave outlives the dead boss and uses a stable floor as its origin.',
        '// Capture walls before floor fade callbacks can replace the origin.\n    scrHMCaveWallWave111(_floor);\n    // The wave outlives the dead boss and uses a stable floor as its origin.')
    path='scripts/scrHMRepairs104/scrHMRepairs104.gml'
    text=(PROJECT/path).read_text(encoding='utf8')
    a=text.index('function scrHMWallThemeStart(');b=text.index('\nfunction scrHMWallThemeTick',a)
    write(path,text[:a]+'function scrHMWallThemeStart(_origin) {scrHMCaveWallWave111(_origin);}\n'+text[b:])
    path='objects/HMWorld/Other_5.gml'
    text=(PROJECT/path).read_text(encoding='utf8')
    if 'hm_theme_started111=-999;' not in text:write(path,text+'\nhm_theme_started111=-999;\n')
    change('scripts/scrHMCompiled_enemies_mod_gml/scrHMCompiled_enemies_mod_gml.gml',
        'scrHMSoundMusic(musBoss6);','scrHMSoundMusic(GameCont.area==scrHMAreaResolve("cavesinv")?musBoss6B:musBoss6);')
    change('objects/MusCont/Alarm_2.gml','switch GameCont.area {','switch scrHMUnlockArea(GameCont.area) {')
    change('objects/MusCont/Alarm_2.gml','song = custom_sound_check(song)',
        'song = custom_sound_check(song)\nif(scrHMEnabled()) hm_music_desired=song;')
    change('scripts/scrHMRepairs104/scrHMRepairs104.gml',
        'spr_shadow=self[$ "shd_"]??shd12;', 'spr_shadow=self[$ "shd_"]??spr_shadow;')
    change('scripts/scrHMCompiled_areas_city_area_gml/scrHMCompiled_areas_city_area_gml.gml',
        'scrHMLoopCrystal109(x+16,y+16);','scrHMLoopSpider111(x+16,y+16);')
    for area in ('caves','cavesinv'):
        change(f'scripts/scrHMCompiled_areas_{area}_area_gml/scrHMCompiled_areas_{area}_area_gml.gml',
            'scrHMLoopCrystal109(x+16,y+16);',
            'scrHMLoopCrystal109(x+16,y+16);\nscrHMLoopSpider111(x+16,y+16);')
    change('scripts/scrHMRepairs109/scrHMRepairs109.gml',
        'if(GameCont.loops<=0 || random(32)>=1) return noone;',
        'if(GameCont.loops<=0 || GameCont.area==scrHMAreaResolve("city") || random(32)>=1) return noone;')
    change('scripts/scrPopEnemies/scrPopEnemies.gml',
        '{scrHMAreaCall(GameCont.area,"area_pop_enemies");return;}',
        '{scrHMAreaCall(GameCont.area,"area_pop_enemies");scrHMVanillaLoopPopulate111();return;}')
    change('scripts/scrHMCompiled_enemies_mod_gml/scrHMCompiled_enemies_mod_gml.gml',
        'if ((weapondrop != 0)) {',
        'if ((weapondrop != 0) && scrHMVenusDropAllowed111(weapondrop)) {')
    # Missile speed enhancement used to turn any nearby EnemyBullet1 into
    # EnemyBullet3. Distance is not ownership: retain only the missile's boss.
    change('scripts/scrHMCompiled_maincode_mod_gml/scrHMCompiled_maincode_mod_gml.gml',
        'if ((instance_nearest(x, y, enemy) == (scrHMOther(other)))) {',
        'if (scrHMMissileShot111(creator,scrHMOther(other))) {')
    path='scripts/scrHMCompiled_maincode_mod_gml/scrHMCompiled_maincode_mod_gml.gml'
    text=(PROJECT/path).read_text(encoding='utf8')
    for index in (646,649,652):
        old=f'if(instance_exists(__hm_with{index}[__hm_index{index+1}])) with (__hm_with{index}[__hm_index{index+1}]) {{'
        new=old+'\nif(!(self[$ "hm_vanilla_loop111"]??false))'
        if new not in text:
            assert text.count(old)==1
            text=text.replace(old,new,1)
    write(path,text)
    change('objects/GenCont/Step_0.gml','with (Floor) {\n\tx += _mx',
        'scrHMThroneShift111(_mx,_my);\nwith (Floor) {\n\tx += _mx')
    change('objects/FloorMaker/Create_0.gml','direction = rng_choose(0, 0, 90, 180, 270)',
        'direction = rng_choose(0, 0, 90, 180, 270)\nif(scrHMEnabled() && GameCont.area==scrHMAreaResolve("throne")) direction=90;')
    # Original desktop NTT Alarm 2 loops i=0..25 at 360*i/26.
    # Its charged Destroy event remains a separate fourteen-shot attack.
    change('objects/ExploGuardian/Alarm_2.gml','repeat 14 {',
        '// Desktop NTT: 26 evenly spaced attack projectiles.\nrepeat 26 {')
    change('objects/ExploGuardian/Alarm_2.gml','ang += 24','ang += 360 / 26')
    change('scripts/scrHMCompiled_areas_throne_area_gml/scrHMCompiled_areas_throne_area_gml.gml',
        'nokill = 1;', 'nokill = 1;\nHMWorld.hm_throne_anchor111=[x,y];')
    path='scripts/scrHMRepairs110/scrHMRepairs110.gml'
    text=(PROJECT/path).read_text(encoding='utf8')
    a=text.index('function scrHMThroneSeed110()');b=text.index('\nfunction ',a+9)
    text=text[:a]+'function scrHMThroneSeed110() {scrHMThroneSeed111();}\n'+text[b:]
    a=text.index('function scrHMThroneEntrance110()');
    write(path,text[:a]+'function scrHMThroneEntrance110() {scrHMThroneEntrance111();}\n')
    path='objects/HMWorld/Other_5.gml'
    text=(PROJECT/path).read_text(encoding='utf8')
    if 'hm_throne_anchor111=undefined;' not in text:write(path,text+'\nhm_throne_anchor111=undefined;\n')
    change('scripts/scrHMActors/scrHMActors.gml','function scrHMActorDraw() {',
        'function scrHMActorDraw() {scrHMActorDraw111();}\nfunction scrHMActorDrawRaw111() {')
    # Stable attribution survives subsequent shield contacts as well.
    path='scripts/scrHMRepairs107/scrHMRepairs107.gml'
    text=(PROJECT/path).read_text(encoding='utf8')
    a=text.index('function scrHMShieldKeepPlasma107()');b=text.index('\nfunction ',a+9)
    write(path,text[:a]+'''function scrHMShieldKeepPlasma107() {
    if(!scrHMEnabled() || !(instance_is(id,PlasmaBig)||instance_is(id,PlasmaHuge))) return false;
    if(team!=team_player && !(self[$ "hm_friendly_plasma111"]??false)) return false;
    hm_friendly_plasma111=true;team=team_player;return true;
}
'''+text[b:])
    register=ROOT/'register_gameplay_tests.py'
    text=register.read_text(encoding='utf8')
    if "'tests/windows111.gml'" not in text:
        assert "'tests/repairs110.gml']" in text
        text=text.replace("'tests/repairs110.gml']","'tests/repairs110.gml','tests/windows111.gml']")
        register.write_text(text,encoding='utf8')
    # End Step samples actual frame cadence; Draw GUI End proves presentation.
    for relative,old,new in [
        ('objects/HMGameplayTest/Step_2.gml','scrHMGameplayTestStep();','scrHMPerf111Frame();scrHMGameplayTestStep();'),
        ('objects/HMGameplayTest/Draw_73.gml','scrHMGameplayRender102();','scrHMPerf111Draw();scrHMGameplayRender102();')]:
        change(relative,old,new)
    for target in ('android','ios','windows'):
        path=f'options/{target}/options_{target}.yy';data=load(PROJECT/path)
        if target=='android':data['option_android_version']=VERSION;data.pop('option_android_version_code',None)
        elif target=='ios':data['option_ios_version']=VERSION;data['option_ios_build_number']=BUILD
        else:data['option_windows_version']=VERSION+'.0'
        write(path,json.dumps(data,ensure_ascii=False,indent=2)+'\n')
    manifest=ROOT/'platforms/android/gradle-project/com.arkintide.nuclearthronehardmode/src/main/AndroidManifest.xml'
    text=manifest.read_text(encoding='utf8')
    text=re.sub(r'android:versionCode="\d+"',f'android:versionCode="{BUILD}"',text)
    text=re.sub(r'android:versionName="[^"]+"',f'android:versionName="{VERSION}"',text)
    manifest.write_text(text,encoding='utf8')
    write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
    print('1.0.11 input, presentation, shoreline, altar and cursed cave repairs registered')

if __name__=='__main__':main()
