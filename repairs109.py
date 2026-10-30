"""1.0.9 source adapters. Frozen b24 inputs remain unchanged."""
from gml_parser import Parser, Node


def statement_at(definition, walk, line, kind, replacement):
    nodes = [n for n in walk(definition.body) if n.line == line and n.kind == kind]
    assert len(nodes) == 1, (definition.name, line, kind, len(nodes))
    new = Parser(replacement).statement()
    nodes[0].kind, nodes[0].args = new.kind, new.args


def ast_repair(path, definition, walk):
    if path == 'enemies.mod.gml' and definition.name == 'step':
        statement_at(definition,walk,176,'if','if (!("infected" in self) || infected==0) {infected=1;my_health+=6;}')
        for line in (176,180,211):
            nodes=[n for n in walk(definition.body) if n.line==line and n.kind=='with']
            assert len(nodes)==1,(line,len(nodes))
            node=nodes[0];saved=Node(node.kind,node.args,node.line)
            node.kind='if';node.args=[Parser('scrHMRatRevive109()').expression(),saved,Node('empty',[],node.line)]
    if path == 'bosses/titank.mod.gml' and definition.name == 'titank_create':
        # The body owns jump completion, independently of any damage receiver.
        statement_at(definition, walk, 839, 'expr', '{canmove=0;hm_jump_landed109=false;}')
        statement_at(definition, walk, 890, 'if',
                     '{if(instance_exists(self)&&my_health>0){z=zstart;wait(15);canmove=1;}}')
        # Source reuses i inside the per-foot fork, corrupting its leg index.
        inner = [n for n in walk(definition.body) if n.kind == 'for' and n.line == 979]
        assert len(inner) == 1
        for n in walk(inner[0]):
            if n.kind == 'identifier' and n.args == ['i']:
                n.args = ['blast_leg109']
            if n.kind == 'var':
                n.args = [('blast_leg109' if key == 'i' else key, value) for key, value in n.args]
        once = [n for n in walk(definition.body) if n.kind == 'if' and n.line == 988]
        assert len(once) == 1
        once[0].args[0] = Parser('!hm_jump_landed109 && my_health>0').expression()
        once[0].args[1].args.insert(0, Parser('hm_jump_landed109=true;').statement())
        statement_at(definition, walk, 1085, 'if',
                     'if(instance_exists(self)&&my_health>0) canmove=1;')
    if path == 'areas/city.area.gml' and definition.name == 'area_start':
        # An explicit room-owned pending controller counts during the delay.
        statement_at(definition, walk, 79, 'if', 'if(GameCont.subarea==5) scrHMLilHunterPending109();')


def emitted_repair(path, name, code):
    if path=='maincode.mod.gml' and name=='step':
        # Preserve the strike canister and add one accessible rad canister.
        # Replace the exact chest body, never unrelated Wind effects.
        import re
        pattern=r'instance_change\(Wind, (?:true|1)\);\s*instance_create\(x, y, RadChest\);\s*instance_destroy\(\);'
        code,n=re.subn(pattern,'scrHMRogueCanisters109();',code)
        assert n==1,('Rogue chest body',n)
    if path=='options.mod.gml':
        if name=='__load':
            code=code.replace('hm_options_mod_gml_basicload();','global.hm_module_vars[$ "mod:options"].ratrevive="1";\nhm_options_mod_gml_basicload();',1)
        elif name=='basicload':
            marker='global.hm_module_vars[$ "mod:options"].flames = _hm.vars._settings[7];'
            assert marker in code
            code=code.replace(marker,marker+'\nglobal.hm_module_vars[$ "mod:options"].ratrevive=array_length(_hm.vars._settings)>8?_hm.vars._settings[8]:"1";',1)
        elif name=='basicsave':
            code=code.replace('scrHMStringSave(_hml__str, savefile);','_hml__str+="*"+string(global.hm_module_vars[$ "mod:options"].ratrevive);\nscrHMStringSave(_hml__str, savefile);',1)
        elif name=='chat_command':
            at=code.index('{')+1
            code=code[:at]+'\nif(argument0=="ratrevive") {scrHMRatToggle109();return true;}\n'+code[at:]
    if path=='enemies.mod.gml' and name=='Minigunner_step':
        start=code.index('case 5: // enemies.mod.gml:1956')
        end=code.index('_hm.pc=4;',start)
        a=code.index('_hm.vars.dist =',start);b=code.rfind('}',start,end)
        code=code[:a]+'\nif(GameCont.area!=scrHMAreaResolve("venuz")) {scrHMMinigunnerShot109();} else {\n'+code[a:b]+'\n}\n'+code[b:]
    if path=='areas/venuz.area.gml' and name=='area_make_floor':
        old='sprite_index = global.hm_module_vars[$ "area:venuz"].wall103out;'
        assert code.count(old)==4
        code=code.replace(old,'sprite_index = sprWall103Trans;\ny -= 8;')
    if path == 'maincode.mod.gml' and name == 'game_start':
        # NTT disables vaults in favour of its /ccrown console. The mobile
        # campaign uses the original native visit counter and real entrances.
        assert 'GameCont.crownvisits = 5;' in code
        code = code.replace('GameCont.crownvisits = 5;', '', 1)
    if path == 'bosses/titank.mod.gml' and name == 'titank_create':
        code = code.replace('view_shake[index] += 8;', 'scr_screenshake(8);')
    if path.startswith('weapons/') and name.startswith('weapon_'):
        code = code.replace('GameCont.area', 'scrHMWeaponArea109()')
    if path == 'weapons/secretweapon2.wep.gml' and name == 'weapon_area':
        # No controller exists in the title/custom weapon selector. Keep it
        # excluded from ordinary random drops; custom mode may still choose it.
        return 'function hm_weapons_secretweapon2_wep_gml_weapon_area() {return instance_exists(GameCont)&&GameCont.area==scrHMAreaResolve("oasis")?1:-1;}'
    if path == 'bosses/guardianboss.mod.gml' and name == 'guardiandark_draw':
        return 'function hm_bosses_guardianboss_mod_gml_guardiandark_draw() {scrHMGuardianDark109();}'
    if path == 'areas/sewers.area.gml' and name == 'area_start':
        old = 'scrHMModCall("mod", "gatorboss", "gatorboss_create", '
        assert code.count(old) == 1
        code = code.replace(old, 'scrHMGatorGroup109(', 1)
    if path == 'enemies.mod.gml' and name == 'IDPDTank_dead':
        marker = 'scrHMTankRadiation108();'
        assert marker in code
        code = code.replace(marker, marker+'\nscrHMTankSupplies109();', 1)
    if path in {'areas/city.area.gml','areas/caves.area.gml','areas/cavesinv.area.gml'} and name == 'area_pop_enemies':
        code = code[:-1]+'\nscrHMLoopCrystal109(x+16,y+16);\n}'
    if path in {'areas/sewers.area.gml','areas/junkyard.area.gml','areas/bigdog.area.gml'} and name == 'area_pop_enemies':
        code = code[:-1]+'\nscrHMLoopBuffGator109(x+16,y+16);\n}'
    if path in {'areas/junkyard.area.gml','areas/ravenboss.area.gml'} and name=='area_pop_enemies':
        code=code[:-1]+'\nscrHMLoopMinigunner109(x+16,y+16);\n}'
    if path == 'bosses/ravenboss.mod.gml' and name == 'ravenboss_callbackup':
        marker = 'function hm_bosses_ravenboss_mod_gml_ravenboss_callbackup() {'
        assert marker in code
        code = code.replace(marker, marker+'\nif(!scrHMRavenBackup109()) return;', 1)
    return code
