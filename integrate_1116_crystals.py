"""Crystal variants retain native mechanics across the CustomEnemy bridge."""
import re
from pathlib import Path

ROOT=Path(__file__).resolve().parent

def edit(path,old,new):
    path=ROOT/path
    text=path.read_text('utf8')
    if new in text:return
    assert text.count(old)==1,(path,old[:100],text.count(old))
    path.write_text(text.replace(old,new),'utf8')

def replace_function(path,name,new):
    path=ROOT/path;text=path.read_text('utf8')
    match=re.search(r'^function '+re.escape(name)+r'\(',text,re.M)
    assert match,(path,name)
    end=re.search(r'^function ',text[match.end():],re.M)
    end=match.end()+end.start() if end else len(text)
    # Imported modules carry a source comment immediately before the next fn.
    stop=text.rfind('// Source ',match.end(),end)
    if stop>=0:end=stop
    path.write_text(text[:match.start()]+new.rstrip()+'\n\n'+text[end:],'utf8')

def main():
    ark='project/scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml'
    edit(ark,'// Keep the native pre-loop combat state; extra crystals do not receive',
         'hm_extra_cursed1116 = _hml__kind == "cursedcrystal";\n// Keep the native pre-loop combat state; extra crystals do not receive')
    edit(ark,'function hm_arkintide_mod_gml_hm_extra_bind() {\nhm_extra = 1;',
         'function hm_arkintide_mod_gml_hm_extra_bind() {\nscrHMExtraCrystalIdentity1116();\nhm_extra = 1;')
    edit(ark,'function hm_arkintide_mod_gml_hm_extra_draw() {\nvar _hml_sprite = sprite_index;',
         'function hm_arkintide_mod_gml_hm_extra_draw() {\nscrHMExtraCrystalIdentity1116();\nvar _hml_sprite = sprite_index;')
    edit(ark,'function hm_arkintide_mod_gml_hm_extra_event(_hml__type, _hml__number) {\nvar _hml_loop',
         'function hm_arkintide_mod_gml_hm_extra_event(_hml__type, _hml__number) {\nscrHMExtraCrystalIdentity1116();\nvar _hml_loop')
    for route in ['native/repairs1104_routes.gml','project/scripts/scrHMRepairs1104Routes/scrHMRepairs1104Routes.gml']:
        text=(ROOT/route).read_text('utf8')
        start=text.index('    // Use the original lateral 64-pixel blink, with collision validation.')
        stop=text.index('\n}\n',start)
        text=text[:start]+'    scrHMExtraCrystalBlink1116();'+text[stop:]
        (ROOT/route).write_text(text,'utf8')
    alarm='project/objects/HyperCrystal/Alarm_1.gml'
    edit(alarm,'            type = LaserCrystal\n            if (GameCont.area == 104 || (scrHMEnabled() && (self[$ "hm_extra_kind"]??"")=="cursedcrystal")) {\n                type = choose(InvLaserCrystal, InvLaserCrystal, InvLaserCrystal, LightningCrystal)\n            }',
         '            type = scrHMExtraCrystalChild1116()')
    bar='project/scripts/scrHMCompiled_hm_bossbar_mod_gml/scrHMCompiled_hm_bossbar_mod_gml.gml'
    edit(bar,'if (((GameCont.area == scrHMAreaResolve(104)) || (GameCont.area == scrHMAreaResolve("cavesinv")))) {',
         'if (((GameCont.area == scrHMAreaResolve(104)) || (GameCont.area == scrHMAreaResolve("cavesinv"))) || (self[$ "hm_extra_cursed1116"]??false)) {')
    edit(bar,'scrHMBossWorldBar1104(x, _hml_py, 80, _hml_title, c_red, hp, max_hp);',
         'var _hml_color=(self[$ "hm_extra_cursed1116"]??false)?c_purple:((self[$ "hm_extra_native"]??noone)==HyperCrystal?c_orange:c_red);\nscrHMBossWorldBar1104(x, _hml_py, 80, _hml_title, _hml_color, hp, max_hp);')
    # Match the native HoverCrystal sprite anchor; its shadow remains y+16.
    for name in ['sprHMContent1100_12','sprHMContent1100_13']:
        edit(f'project/sprites/{name}/{name}.yy','"yorigin": 48','"yorigin": 64')
    for name in ['hm_extra_bind','hm_extra_draw','hm_extra_event','hm_extra_combat']:
        text=(ROOT/ark).read_text('utf8')
        match=re.search(r'^function hm_arkintide_mod_gml_'+name+r'\(',text,re.M)
        end=re.search(r'^// Source ',text[match.end():],re.M)
        end=match.end()+end.start() if end else len(text)
        replace_function('native/compiled_arkintide1103.gml','hm_arkintide_mod_gml_'+name,text[match.start():end])
    (ROOT/'project/scripts/scrHMRepairs1116Policy/scrHMRepairs1116Policy.gml').write_text((ROOT/'native/repairs1116_policy.gml').read_text('utf8'),'utf8')

if __name__=='__main__':main()
