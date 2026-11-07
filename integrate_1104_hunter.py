"""Narrow mobile 1.1.4 Hunter and menu-crash repairs; never replay importers."""
from pathlib import Path
import hashlib, json, re

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT/'project'
OUT=ROOT/'release1104'
CHANGED=[]

def save(relative,text):
    path=PROJECT/relative
    before=path.read_text('utf8')
    if before==text:return
    backup=OUT/'baseline'/relative
    if not backup.exists():
        backup.parent.mkdir(parents=True,exist_ok=True);backup.write_bytes(path.read_bytes())
    path.write_text(text,'utf8');CHANGED.append(relative)

def edit(relative,old,new):
    text=(PROJECT/relative).read_text('utf8')
    if new in text:return
    assert text.count(old)==1,(relative,old,text.count(old))
    save(relative,text.replace(old,new,1))

def main():
    assert (OUT/'baseline-source.json').exists()
    # Set the complete Loop0 MOD budget before the ordinary native constructor
    # applies its one five-percent/Loop, mode and Scarier Face creation effects.
    hunter='objects/LilHunter/Create_0.gml'
    final='max_hp = scrHMEnabled() ? (140 + ((variable_instance_get(GameCont,"hm_extra_pending")??false) ? 0 : 50 * instance_number(Player))) : (140 * (1 + (GameCont.loops / 3)))'
    text=(PROJECT/hunter).read_text('utf8')
    if final not in text:
        ordinary='max_hp = scrHMEnabled() ? (140 + 50 * instance_number(Player)) : (140 * (1 + (GameCont.loops / 3)))'
        if ordinary in text:save(hunter,text.replace(ordinary,final,1))
        else:edit(hunter,'max_hp = 140 * (1 + (GameCont.loops / 3))',
             '// One ordinary boss budget. The inherited enemy applies common Loop scaling.\n'+final)
    edit('scripts/scrHMCompiled_enemies_mod_gml/scrHMCompiled_enemies_mod_gml.gml',
         'scrHMMaxHealthWrite(id, ((50 * instance_number(Player)) * (GameCont.loops + 1)), "+=");\nhp += ((50 * instance_number(Player)) * (GameCont.loops + 1));',
         '// Hardmode health was initialized before inherited native creation effects.\n'
         'if(!scrHMEnabled()) {\n'
         'scrHMMaxHealthWrite(id, ((50 * instance_number(Player)) * (GameCont.loops + 1)), "+=");\n'
         'hp += ((50 * instance_number(Player)) * (GameCont.loops + 1));\n}')
    # Two retained entry paths formerly waited 500 MOD ticks before creating a
    # further 210-tick native timer. Their combined maximum is now 240 ticks.
    helper='scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml'
    edit(helper,'GameCont.loops = 0;\n;\n_hml_actor = instance_create(_hml__x, _hml__y, _hml_native);\n;\nGameCont.loops = _hml_actual_loop;',
         'GameCont.loops = 0;\n;\n'
         '// Native extra constructors must see their extra context before Create.\n'
         'var _hml_pending_before1104=variable_instance_get(GameCont,"hm_extra_pending")??false;\n'
         'GameCont.hm_extra_pending=true;\n'
         '_hml_actor = instance_create(_hml__x, _hml__y, _hml_native);\n;\n'
         'GameCont.hm_extra_pending=_hml_pending_before1104;\n'
         'GameCont.loops = _hml_actual_loop;')
    edit(helper,'hm_wait = 500;','hm_wait = 30;')
    edit(helper,'function hm_arkintide_mod_gml_hm_hunter_wait() {\nhm_wait -= 1;',
         'function hm_arkintide_mod_gml_hm_hunter_wait() {\n'
         'if(instance_exists(GenCont) || !instance_exists(Player)) return;\n'
         'hm_wait -= 1;')
    repair='scripts/scrHMRepairs109/scrHMRepairs109.gml'
    edit(repair,'name="hm_hunter_arrival109";hm_wait109=500;',
         'name="hm_hunter_arrival109";hm_wait109=30;')
    edit(repair,'    if(--hm_wait109>0) return;',
         '    if(instance_exists(GenCont) || !instance_exists(Player)) return;\n'
         '    if(--hm_wait109>0) return;')
    edit('objects/LilHunterDie/Create_0.gml','typ = 0',
         '// The MOD also creates this final wreck directly after its flying last wish.\n'
         'hitid = HitId.LilHunterDie\n'
         'typ = 0')
    edit('scripts/scrHMCompiled_weapons_secretweapon2_wep_gml/scrHMCompiled_weapons_secretweapon2_wep_gml.gml',
         'if (((GameCont.area == scrHMAreaResolve("oasis")) || (GameCont.area == scrHMAreaResolve(101)))) {',
         'var _area=scrHMWeaponArea109();\n'
         'if (((_area == scrHMAreaResolve("oasis")) || (_area == scrHMAreaResolve(101)))) {')
    # Every supplied weapon metadata definition is audited, not just Harpoon.
    audit=[]
    for path in sorted((PROJECT/'scripts').glob('scrHMCompiled_weapons*/*.gml')):
        text=path.read_text('utf8')
        for match in re.finditer(r'^function ([^(]+)\([^\n]*\)\s*\{',text,re.M):
            name=match[1]
            if not any(name.endswith('_weapon_'+prop) for prop in
                       ['name','type','cost','load','auto','area','sprt','text','swap','melee','gold','laser_sight']):continue
            end=text.find('\n}',match.end());body=text[match.end():end]
            assert 'GameCont.' not in body and 'Player.' not in body,(path,name)
            audit.append(dict(file=path.relative_to(PROJECT).as_posix(),function=name,
                              sha256=hashlib.sha256(body.encode()).hexdigest()))
    OUT.mkdir(exist_ok=True)
    (OUT/'hunter-metadata-audit.json').write_text(json.dumps(dict(status='PASS',definitions=len(audit),
        callbacks=audit),indent=2),'utf8')
    print(json.dumps(dict(changed=CHANGED,metadata_definitions=len(audit))))

if __name__=='__main__':main()
