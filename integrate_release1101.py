"""Apply the 1.1.1 mobile delta without replaying the native MOD importer."""
from pathlib import Path
import json
from create_project import load
from register_native import register_script

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT/'project'
OUT=ROOT/'release1101'

def edit(relative, old, new):
    p=PROJECT/relative
    text=p.read_text(encoding='utf8')
    if new in text:return
    assert text.count(old)==1,(relative,old,text.count(old))
    backup=OUT/'baseline'/relative
    if not backup.exists():
        backup.parent.mkdir(parents=True,exist_ok=True)
        backup.write_bytes(p.read_bytes())
    p.write_text(text.replace(old,new,1),encoding='utf8')

def main():
    OUT.mkdir(exist_ok=True)
    project=load(PROJECT/'nuclearthronemobile.yyp')
    register_script(project,'scrHMRepairs1101',(ROOT/'native/repairs1101.gml').read_text(encoding='utf8'))
    edit('scripts/scrHMContent1100/scrHMContent1100.gml',
         'return variable_instance_get(GameCont,"hm_maxlevel1100")??_base;',
         'return scrHMLevelCap1101();')
    edit('scripts/scrHMContent1100/scrHMContent1100.gml',
         'if(!variable_instance_exists(GameCont,"hm_maxlevel1100")) GameCont.hm_maxlevel1100=scrCustomParam("maxlevel",10);',
         'if(!variable_instance_exists(GameCont,"hm_maxlevel1100")) {\n'
         '        GameCont.hm_maxlevel1100=variable_instance_exists(GameCont,"hm_level_cap")?GameCont.hm_level_cap:scrCustomParam("maxlevel",10);\n'
         '    }')
    edit('scripts/scrHMWorld/scrHMWorld.gml',
         'logic_accumulator=0;logic_tick=true;logic_serial=0;',
         'logic_accumulator=0;logic_tick=true;logic_serial=0;hm_portrait_active=noone;')
    edit('scripts/scrHMWorld/scrHMWorld.gml',
         '    scrHMTasksTick(1);',
         '    // HMWorld can step before the first GameCont Step or a continued run.\n'
         '    scrHMContentInit1100();\n    scrHMTasksTick(1);')
    maincode='scripts/scrHMCompiled_maincode_mod_gml/scrHMCompiled_maincode_mod_gml.gml'
    edit(maincode,'(GameCont.level < GameCont.hm_maxlevel1100)','(GameCont.level < scrHMLevelCap1101())')
    helper='scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml'
    edit(helper,'function hm_arkintide_mod_gml_hm_progression_start() {',
         'function hm_arkintide_mod_gml_hm_progression_start() {\nscrHMContentInit1100();')
    edit(helper,'(GameCont.loops < 3)) || (! hm_arkintide_mod_gml_hm_gungod_area_allowed())',
         '(GameCont.loops < 1)) || (! hm_arkintide_mod_gml_hm_gungod_area_allowed())')
    edit(helper,'''var _hml_body_sprite = sprite_index;
var _hml_body_mask = mask_index;
;
hm_arkintide_mod_gml_hm_extra_change(Van);
;
scr_projectile_hit(id, _hml__damage, _hml__knockback, _hml__direction);
;
hm_arkintide_mod_gml_hm_extra_change(CustomHitme);
;
sprite_index = _hml_body_sprite;
;
mask_index = _hml_body_mask;
;''','''return scrHMVanBodyHurt1101(_hml__damage, _hml__knockback, _hml__direction);''')
    # Keep the separate Loop3 Y.V phase-two rule intact.
    edit('scripts/scrHMActors/scrHMActors.gml',
         '    if(name=="titank") scrHMTitankHealth();',
         '    if(name=="titank") scrHMTitankHealth();\n'
         '    scrHMBossCameraTick1101();\n'
         '    if(hp>0 && (self[$ "hm_portrait_frozen"]??false)) return;')
    edit('objects/YVBoss/Create_0.gml','intro = false','intro = false\nhm_entry_camera1101=false\nhm_exit_camera1101=false')
    # Native Y.V does not use the CustomEnemy step dispatcher.
    edit('scripts/scrHMWorld/scrHMWorld.gml',
         '    if(instance_exists(GameCont)) scrHMHook("step");',
         '    if(instance_exists(GameCont)) scrHMHook("step");\n'
         '    if(!instance_exists(HMWorld.hm_portrait_active)) with(YVBoss) if(hp>0 && image_alpha>0) scrHMBossCamera1101(id,false);')
    edit('objects/YVBoss/Destroy_0.gml','repeat (3) {','scrHMBossCamera1101(id,true);\nrepeat (3) {')
    bar='scripts/scrHMCompiled_hm_bossbar_mod_gml/scrHMCompiled_hm_bossbar_mod_gml.gml'
    edit(bar,'scrHMDrawText((_hml_left + (_hml__width / 2)), (_hml_top - 10), _hml__text);',
         'scrHMBossTitle1101((_hml_left + (_hml__width / 2)), _hml_top, _hml__width, _hml__text);')
    gameplay='scripts/scrHMGameplayTests/scrHMGameplayTests.gml'
    edit(gameplay,'if(string_pos("sync",mode)==1) scrHMGameplaySync1100();',
         'if(string_pos("sync",mode)==1) scrHMGameplaySync1100();\n'
         '        if(string_pos("sync111",mode)==1) scrHMGameplay1101();')
    register_script(project,'scrHMGameplay1101',(ROOT/'tests/repairs1101.gml').read_text(encoding='utf8'))
    (PROJECT/'nuclearthronemobile.yyp').write_text(json.dumps(project,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    # Durable host source must retain the same initialization repair.
    p=ROOT/'native/content1100.gml'
    source=p.read_text(encoding='utf8')
    source=source.replace('return variable_instance_get(GameCont,"hm_maxlevel1100")??_base;','return scrHMLevelCap1101();')
    source=source.replace('if(!variable_instance_exists(GameCont,"hm_maxlevel1100")) GameCont.hm_maxlevel1100=scrCustomParam("maxlevel",10);',
        'if(!variable_instance_exists(GameCont,"hm_maxlevel1100")) {\n        GameCont.hm_maxlevel1100=variable_instance_exists(GameCont,"hm_level_cap")?GameCont.hm_level_cap:scrCustomParam("maxlevel",10);\n    }')
    p.write_text(source,encoding='utf8')
    print('Applied targeted Hardmode mobile 1.1.1 delta')

if __name__=='__main__':main()
