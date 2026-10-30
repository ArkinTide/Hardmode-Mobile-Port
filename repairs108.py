"""Audited 1.0.8 adaptations; never edit the original b24 inputs."""
from gml_parser import Parser


def ast_repair(path, definition, walk):
    if path == 'enemies.mod.gml' and definition.name == 'step':
        # Restore the rider's hit mask immediately, before its ten-tick fall.
        nodes = [n for n in walk(definition.body) if n.kind == 'expr' and n.line == 469]
        assert len(nodes) == 1, [(n.line, n.kind) for n in walk(definition.body) if 467 <= n.line <= 470]
        # Parser.statement reads a single statement; use an explicit block.
        stmt = Parser('{mask_index=mskBandit;canfly=0;}').statement()
        nodes[0].kind, nodes[0].args = stmt.kind, stmt.args
    if path == 'props.mod.gml' and definition.name == 'draw_shadows':
        # Only these two host families receive b24's optional shadow field.
        # Static terrain and every bullet need not be scanned twice per draw.
        for n in walk(definition.body):
            if (n.kind == 'call' and n.args[0].kind == 'identifier'
                    and n.args[0].args == ['instances_matching']
                    and n.args[1][0].kind == 'identifier' and n.args[1][0].args == ['GameObject']):
                n.args[1][0] = Parser('[CustomObject,Effect]').expression()


def emitted_repair(path, name, code):
    if path == 'bosses/bossintros.mod.gml' and name == 'boss_trigger':
        marker = 'function hm_bosses_bossintros_mod_gml_boss_trigger() {'
        assert marker in code
        # Blank-name calls are camera pans; retain them for ordinary bosses.
        code = code.replace(marker, marker+'\nif(scrHMSkipBossPresentation108(argument0,argument4)) return;', 1)
    if path == 'enemies.mod.gml':
        if name == 'IDPDTank_create':
            code = code.replace('spawnanimation = 150;', 'spawnanimation = 0;')
            code = code.replace('spr_idle = global.hm_module_vars[$ "mod:enemies"].IDPDTankintro;',
                                'spr_idle = global.hm_module_vars[$ "mod:enemies"].IDPDTankidle;')
            code = code.replace('alrm1 = 1000;', 'alrm1 = 30;')
            marker = 'hurttimer = 50;'
            assert marker in code
            code = code.replace(marker, marker+'\nsprite_index=spr_idle;friction=.4;\nscrHMTankRadiation108();')
            assert 'scrHMMotionAdd(_hml__d, 16);' in code
            code=code.replace('scrHMMotionAdd(_hml__d, 16);','scrHMMotionAdd(_hml__d, 2);')
        if name == 'IDPDTank_dead':
            marker = 'function hm_enemies_mod_gml_IDPDTank_dead() {'
            assert marker in code
            code = code.replace(marker, marker+'\nscrHMTankRadiation108();')
        if name == 'IDPDLaserCannon_step':
            marker = 'aim = creator.gunangle;'
            assert code.count(marker) == 1
            code = code.replace(marker, 'scrHMTankAim108();')
        if name == 'vanguide':
            marker='scrHMModCall("mod", "enemies", "IDPDTank_create", '
            assert code.count(marker)==1
            code=code.replace(marker,'scrHMTankPortal108(',1)
        if name == 'vanexplo':
            marker = 'image_xscale = 3;\nimage_yscale = 3;'
            assert code.count(marker) == 1
            # The original has only this large persistent scorch effect.
            code = code.replace(marker, 'scrHMVanCrater108();')
            code = code.replace('instance_create((x + random_range((- 30), 30)), (x + random_range((- 30), 30)), BlueFlame);',
                                'instance_create((x + random_range((- 30), 30)), (y + random_range((- 30), 30)), BlueFlame);')
        if name in {'EliteSpiderShield_step', 'bigshield_step', 'customshield_step'}:
            # Keep player plasma's damage attribution through deflection.
            marker = 'team = (scrHMOther(other)).team;'
            # The exact emitted other spelling is audited after compilation.
            if marker not in code:
                import re
                match = re.search(r'team = (__hm_other\d+)\.team;', code)
                assert match, (name, code[:1600])
                marker = match.group(0)
            code = code.replace(marker, 'var _keep_plasma108=scrHMShieldKeepPlasma107();\nif(!_keep_plasma108) '+marker, 1)
            import re
            code, count = re.subn(r'(hitid = \[[^\n]+;)', r'if(!_keep_plasma108) \1', code, count=1)
            assert count == 1, name
    if path == 'props.mod.gml' and name == 'step':
        # The supplied elevator already removes Floor/Wall. Its explicit
        # list misses host pickups, DustOLD door blockers and dead bindings.
        marker = 'hm_areas_venuz_area_gml_area_setup();'
        # Module calls compile through the native registry.
        marker = 'scrHMModCall("area", "venuz", "area_setup");'
        assert code.count(marker) == 1
        code = code.replace(marker, 'scrHMVenusCleanup108();\n'+marker, 1)
    if path == 'props.mod.gml' and name == 'VenuzCar_step':
        marker = 'function hm_props_mod_gml_VenuzCar_step() {'
        assert marker in code
        code = code.replace(marker, marker+'\nscrHMCarSteer108();', 1)
        assert code.count('scrHMButtonCheck(driver,') == 8
        code = code.replace('scrHMButtonCheck(driver,', 'scrHMCarButton108(driver,')
    if path == 'maincode.mod.gml' and name == 'step':
        # Sprite ID was assigned to a frame number in the original elevator.
        marker = 'outindex = sprWall103Out;'
        assert code.count(marker) == 1
        code = code.replace(marker, 'outindex = 0;')
    return code
