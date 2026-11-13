"""Narrow 1.1.7 call sites; do not run a historical importer."""
from pathlib import Path
import json

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT/'project'

def replace(relative,old,new):
    path=PROJECT/relative
    text=path.read_text('utf-8-sig')
    if new in text:return
    assert text.count(old)==1,(relative,old)
    path.write_text(text.replace(old,new),'utf8')

def main():
    replace('objects/UberCont/Step_0.gml','scrHMFrameBudget1116();','// Cap transactions run in Begin Step, before alarms and movement.')
    replace('objects/UberCont/Step_1.gml','scrDesktopWheelFrame111();','scrHMClockBegin1117();\nscrDesktopWheelFrame111();')
    replace('scripts/scrHMWorld/scrHMWorld.gml','function scrHMWorldBegin() {','function scrHMWorldBegin() {\n    scrHMClockBegin1117();')
    replace('scripts/scrOptionsUpdate/scrOptionsUpdate.gml','opt_framerate = save_get_option("options", "framerate", 60)',
        'opt_framerate = save_get_option("options", "framerate", 60)\n        opt_hm_autoframerate = save_get_option("visual", "hm_autoframerate", true)')
    replace('scripts/scrOptionsUpdate/scrOptionsUpdate.gml','game_set_speed(opt_framerate, gamespeed_fps)',
        'if(!scrHMEnabled()) game_set_speed(opt_framerate, gamespeed_fps)\n            // Hardmode applies the request at a safe Begin Step after unpause.')
    replace('objects/MenuOptions/Other_20.gml','\t/// @loc:token [VideoOptions] Framerate "FRAMERATE"',
        '\t{ type: "switch", name: L("AutoFramerate", "AUTO FRAMERATE"), key: "visual_hm_autoframerate" },\n\t\n\t/// @loc:token [VideoOptions] Framerate "FRAMERATE"')
    replace('scripts/scrHMRepairs104/scrHMRepairs104.gml',
        'anim:image_speed,was_frozen:self[$ "frozen"]??false',
        'anim:image_speed,clock_scale:timescale,anim_sprite:sprite_index,was_frozen:self[$ "frozen"]??false')
    replace('scripts/scrHMRepairs104/scrHMRepairs104.gml',
        'speed=_record.speed;direction=_record.direction;image_speed=_record.anim;',
        'speed=_record.speed*timescale/(_record[$ "clock_scale"]??timescale);direction=_record.direction;\n            image_speed=_record.anim*scrHMClockAnimationRatio1117(_record[$ "anim_sprite"]??sprite_index,_record[$ "clock_scale"]??timescale,timescale);')
    replace('scripts/scrHMRepairs104/scrHMRepairs104.gml',
        'function scrHMBossStep104() {\n    scrHMBossNativeStep1116();',
        'function scrHMBossStep104() {\n    var _advance=scrHMClockPresentationTicks1117();\n    repeat(_advance) {\n    scrHMBossNativeStep1116();')
    replace('scripts/scrHMRepairs104/scrHMRepairs104.gml',
        '        instance_destroy();\n    }\n}',
        '        instance_destroy();return;\n    }\n    }\n}')
    replace('scripts/scrSave/scrSave.gml','"visual_particles",','"visual_particles", "visual_hm_autoframerate",')
    replace('objects/Rocket/Step_0.gml','motion_add_m(direction, accel, maxspeed)',
        'motion_add_m(direction, accel * timescale, maxspeed)')
    # Native vertical motion uses one integration per callback, unlike HM's
    # logical zspeed. Correct only these two native families.
    replace('objects/DogGuardian/Alarm_2.gml','zspeed = leap / 4','zspeed = leap / 4 * timescale')
    replace('objects/DogGuardian/Other_10.gml','zspeed -= (0.5) * timescale','zspeed -= (0.5) * timescale * timescale')
    replace('objects/SodaCan/Create_0.gml','zspeed = random_range(0.5, 2)','zspeed = random_range(0.5, 2) * timescale')
    replace('objects/SodaCan/Step_0.gml','zspeed -= (0.2) * timescale','zspeed -= (0.2) * timescale * timescale')
    rel='scripts/scrHMCompiled_bosses_guardianboss_mod_gml/scrHMCompiled_bosses_guardianboss_mod_gml.gml'
    replace(rel,'_hm.vars._maxspd = maxspeed;','_hm.vars._maxspd = maxspeed / timescale;')
    replace(rel,'maxspeed = _hm.vars._maxspd;','maxspeed = _hm.vars._maxspd * timescale;')
    replace(rel,'maxspeed = 6;','maxspeed = 6 * timescale;')
    # Mirror only the maintained files touched here, never rerun codegen.
    for source,dest in [('scrHMWorld','world'),('scrHMRepairs104','repairs104')]:
        text=(PROJECT/f'scripts/{source}/{source}.gml').read_text('utf8')
        (ROOT/f'native/{dest}.gml').write_text(text,'utf8')
    generated=ROOT/'generated/bosses/guardianboss.mod.gml.gml'
    # generated file location is found by exact basename below if present.
    candidates=list((ROOT/'generated').rglob('bosses_guardianboss_mod_gml.gml'))
    for file in candidates:file.write_text((PROJECT/rel).read_text('utf8'),'utf8')
    language=PROJECT/'datafiles/lang/lang.csv'
    lines=language.read_text('utf8').splitlines()
    if not any(x.startswith('VideoOptions,AutoFramerate,') for x in lines):
        import csv,io
        row=['VideoOptions','AutoFramerate']+['auto framerate']*15
        # Match the language columns from the existing Framerate entry.
        base=next(csv.reader([x]) for x in lines if x.startswith('VideoOptions,Framerate,'))
        old=next(base)
        row=['VideoOptions','AutoFramerate']+['auto framerate']*(len(old)-2)
        row[11]='自动降帧';row[12]='自動降幀'
        out=io.StringIO();csv.writer(out,lineterminator='\n').writerow(row)
        lines.append(out.getvalue().rstrip('\n'))
        language.write_text('\n'.join(lines)+'\n','utf8')
    print('1.1.7 clock call sites integrated')

if __name__=='__main__':main()
