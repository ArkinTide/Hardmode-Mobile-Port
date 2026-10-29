"""Explicit compatibility corrections; frozen b24 source stays unchanged."""
from gml_parser import Parser, Node


def ast_repair(path, definition, walk):
    if path=='props.mod.gml' and definition.name=='joao_shockwave':
        nodes=[n for n in walk(definition.body) if n.kind=='with' and n.line==2576]
        assert len(nodes)==1
        replacement=Parser('scrHMWallThemeStart(_target);').statement()
        nodes[0].kind,nodes[0].args=replacement.kind,replacement.args
    if path=='bosses/gatorboss.mod.gml' and definition.name=='gatorboss_step':
        nodes=[n for n in walk(definition.body) if n.kind=='if' and n.line==85]
        assert len(nodes)==1
        nodes[0].args[0]=Node('binary',['&&',Parser('instance_exists(target)').expression(),nodes[0].args[0]],85)
    if path=='maincode.mod.gml' and definition.name=='step':
        for switch in [n for n in walk(definition.body) if n.kind=='switch']:
            for label, body in switch.args[1]:
                if label and label.args[0] in {'"sewers"','102'}:
                    body.args=Parser('{scrHMSewerTick();break;}').statement().args
    if path=='bosses/titank.mod.gml' and definition.name=='titank_create':
        # The delayed portrait formerly healed the body back to four legs,
        # even if a leg had already died during its first twenty ticks.
        nodes=[n for n in walk(definition.body) if n.kind=='expr' and n.line==241]
        assert len(nodes)==1
        nodes[0].args=Parser('scrHMTitankHealth();').statement().args


def emitted_repair(path,name,code):
    if path=='bosses/bossintros.mod.gml':
        if name=='boss_trigger':
            code=code[:-1]+'\nscrHMBossFreeze104();\n}'
        if name=='customboss_step':
            code='function hm_bosses_bossintros_mod_gml_customboss_step() {scrHMBossStep104();}'
    if path=='bosses/gatorboss.mod.gml' and name=='gatorboss_step':
        code=code.replace('(target > 0)','instance_exists(target)')
        code=code.replace('if (((alrm2 == 2) and (alrm0 != (- 1)) and targetvisible))',
                          'if (instance_exists(target) && ((alrm2 == 2) and (alrm0 != (- 1)) and targetvisible))')
        # Guard friends before scrTarget/targetvisible is refreshed after death.
        marker='function hm_bosses_gatorboss_mod_gml_gatorboss_step_resume(_hm) {'
        if marker in code:
            code=code.replace(marker,marker+'\nif(instance_exists(_hm.scope)) with(_hm.scope) {if(!instance_exists(target)) targetvisible=0;}')
    if path=='bosses/ravenboss.mod.gml' and name=='ravenboss_step':
        import re
        code=re.sub(r'\(! collision_line\(([^\n]+)\)\)',r'(collision_line(\1)==noone)',code)
        # GMS does not interpret sprite1||sprite2 as a list of sprites.
        code=code.replace('(sprite_index == ((spr_idle || spr_hurt) || spr_walk))',
            '((sprite_index==spr_idle)||(sprite_index==spr_hurt)||(sprite_index==spr_walk))')
    if path=='areas/oasis.area.gml' and name=='area_setup':
        code=code[:-1]+'\nwith(TopCont) darkness=0;\n}'
    if path=='areas/sewers.area.gml' and name=='area_start':
        code=code.replace('instance_create(x, y, PizzaEntrance)','scrHMManholeCreate(x,y)')
    if path=='bosses/titank.mod.gml' and name=='titank_create':
        code=code.replace('(360 / _hm.vars.livelegs)','(360 / max(1,_hm.vars.livelegs))')
        code=code.replace('hp = _hm.vars.legs;', 'hp = _hm.vars.legs;')
        # Record each damage receiver independently from transient task locals.
        import re
        pattern=r'hp = (__hm_other\d+)\.foot_hp\[_hm.vars.i\];'
        assert len(re.findall(pattern,code))==1
        code=re.sub(pattern,lambda m:m[0]+'\nhm_titank_parent='+m[1]+';hm_titank_leg=_hm.vars.i;\n'+m[1]+'.hm_feet[_hm.vars.i]=id;',code)
        marker='legs = (4 + (GameCont.loops * 2));'
        assert marker in code
        code=code.replace(marker,marker+'\nhm_feet=array_create(legs,noone);_x=x;_y=y;')
        marker='headZ = 32;'
        assert marker in code
        code=code.replace(marker,'hm_feet_ready=true;\n'+marker)
    return code
