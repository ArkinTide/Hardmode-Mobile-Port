"""Release 1.0.7: explicit b24/host contracts, immutable reference sources."""
from copy import deepcopy
import re
from gml_parser import Parser, Node


def ast_repair(path, definition, walk):
    if path == 'bosses/bossintros.mod.gml' and definition.name == 'boss_trigger':
        # The native one-shot freeze/restore owns projectile state. The old
        # NTT per-step snapshot is unused by customboss_step's replacement.
        nodes=[n for n in walk(definition.body) if n.kind=='with' and n.line==36]
        assert len(nodes)==1
        nodes[0].kind,nodes[0].args='block',[]
    # b24 disables native police outside snow. User-requested loop rules
    # restore the host's existing wave controllers, without a second spawner.
    if path == 'maincode.mod.gml' and definition.name == 'step':
        for line, source in {
            375: 'GameCont.novans=(GameCont.loops<=0);',
            378: 'if(GameCont.loops<=0) instance_destroy();',
            639: 'if(GameCont.loops<=0) instance_delete(id);',
            865: 'if(GameCont.loops<=0) instance_delete(id);',
            1490: 'if(GameCont.loops<3) freak=0;',
            1690: 'if(GameCont.loops<3) instance_destroy();',
            1691: 'if(GameCont.loops<3) instance_destroy();',
            1738: 'if(GameCont.loops<3) instance_destroy();',
            1739: 'if(GameCont.loops<3) instance_destroy();',
        }.items():
            # 1490 is a single-line with; replace its body, not the scope.
            nodes = [n for n in walk(definition.body) if n.kind == 'expr' and n.line == line]
            assert len(nodes) == 1, (line, nodes)
            new = Parser(source).statement()
            nodes[0].kind, nodes[0].args = new.kind, new.args
    portal_lines = ({1756, 1801} if path == 'maincode.mod.gml' and definition.name == 'step'
                    else {2317} if path == 'props.mod.gml' and definition.name == 'elevator_step' else set())
    for line in portal_lines:
        assignments = [n for n in walk(definition.body) if n.kind == 'binary' and n.line == line
                       and n.args[0] == '=' and n.args[1].kind == 'identifier'
                       and n.args[1].args == ['type']]
        assert len(assignments) == 1, (path, line)
        assert assignments[0].args[2].args == ['3']
        assignments[0].args[2].args = ['2']
    if path == 'props.mod.gml' and definition.name == 'joao_shockwave':
        # The common wave rebuilt EVERY wall before the cursed-cave branch.
        # Replacing a packed collider by a 16px tile also loses its extent.
        for line in (2412, 2434):
            nodes = [n for n in walk(definition.body) if n.kind == 'with' and n.line == line]
            assert len(nodes) == 1, (path, definition.name, line)
            replacement = Parser('scrHMWallThemeStart(_target);' if line == 2412 else ';').statement()
            nodes[0].kind, nodes[0].args = replacement.kind, replacement.args
    if path == 'maincode.mod.gml' and definition.name == 'step':
        nodes = [n for n in walk(definition.body) if n.kind == 'if' and n.line == 1052]
        assert len(nodes) == 1
        original = deepcopy(nodes[0])
        nodes[0].args = [Parser('!scrHMVariableExists(self,"hm_dog_intro107")').expression(),
            Node('block', [Parser('hm_dog_intro107=true;').statement(), original], 1052), Node('block', [], 1052)]


def emitted_repair(path, name, code):
    if path == 'enemies.mod.gml' and name == 'step':
        # This async module also has a local `name`; the vehicle's name must
        # belong to its instance, not that unrelated coroutine local.
        marker='_hm.vars.name = "3dvan";'
        assert code.count(marker)==1
        code=code.replace(marker,'name = "3dvan";hm_freak107=GameCont.loops>=3;')
    if path == 'enemies.mod.gml' and name == 'vanguide':
        marker='if ((land == 1))'
        assert code.count(marker)==1
        code=code.replace(marker,'if(scrHMVanStop107()) return;\n'+marker)
    if path == 'maincode.mod.gml' and name == 'step':
        marker='(!scrHMVariableExists(_hm.scope, "van"))'
        assert code.count(marker)==1
        code=code.replace(marker,'(!instance_is(id,Van) && '+marker+')')
        # A live Raven -> flying Raven is a state change, not a death.
        assert code.count('instance_change(RavenFly, true);') == 2
        code = code.replace('instance_change(RavenFly, true);',
            'instance_change(RavenFly,false);emergencylanding=0;z=0;')
        marker = 'sprite_angle += 15;'
        assert code.count(marker) == 1
        code = code.replace(marker, 'scrHMThroneFall107(true);\n'+marker)
        marker = 'sprite_angle = 0;'
        # Both the standing branch and the end of the fall restore the body.
        assert code.count(marker) == 2
        code = code.replace(marker, 'scrHMThroneFall107(false);\n'+marker)
    if path == 'areas/venuz.area.gml' and name == 'area_setup':
        marker = 'bwep = scrHMWeaponResolve(0);'
        assert code.count(marker) == 1
        code = code.replace(marker, marker+'\nscrHMVenusLoadout107();')
    if path == 'props.mod.gml' and name == 'step':
        # The host's weapon pickup is not a child of NTT's Pickup class.
        marker = 'scrHMInstances(Pickup)'
        assert code.count(marker) == 1
        code = code.replace(marker, 'scrHMInstances([Pickup,WepPickup])')
        assert code.count('if ((image_yscale > 0))') == 1
        code = code.replace('if ((image_yscale > 0))', 'if ((image_yscale > 0.01))')
        # Retry rebuilds this exact authored floor, including secret floors.
        marker = 'GameCont.lastarea = scrHMAreaResolve("venuz");'
        assert code.count(marker) == 1
        code = code.replace(marker, 'scrHMVenusRetryDestination107();\n'+marker)
    if path == 'props.mod.gml' and name == 'whitecrystal_step':
        code = 'function hm_props_mod_gml_whitecrystal_step() {scrHMIceCrystal107();}'
    if path in {'areas/junkyard.area.gml', 'areas/bigdog.area.gml'} and name == 'area_start':
        code = code[:-1]+'\nscrHMPrepareJunkyard107();\n}'
    if path == 'weapons/secretweapong2.wep.gml' and name == 'weapon_fire':
        # Preserve the original six individual pellet hits, not a single
        # 8-damage ally hit followed by five hits rejected by host iframes.
        marker = 'image_alpha = 0;'
        assert code.count(marker) == 1
        code = code.replace(marker, marker+'\nhm_venus_pellet107=true;')
    return code
