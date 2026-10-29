"""Audited host adaptations for 1.0.5; b24 inputs remain read-only."""
import re


def emitted_repair(path, name, code):
    if path == 'enemies.mod.gml' and name == 'enemyrogue_step':
        # These dead locals are never read by the source strike. The argument
        # is a SOUND, not a sprite; the explosions already use strike_x/y.
        code, count = re.subn(r'_hm\.vars\.start[xy] = [^\n]*sprite_get_(?:width|height)\(sndPortalStrikeFireButt\)[^\n]*\n', '', code)
        assert count == 2
    if path == 'enemies.mod.gml' and name == 'VenuzSpawn_create':
        assert 'image_blend = scrHMBackgroundColour105();' in code
    if path == 'enemies.mod.gml' and name == 'wantjungleboss_step':
        code, count = re.subn(r'instance_nearest\(([^\n]+?), Wall\)', r'scrHMNearestAuthoredWall105(\1)', code)
        assert count == 2
    if path == 'enemies.mod.gml' and name == 'bigcrystaltopdraw':
        code = code.replace('instance_destroy();', 'scrHMMenuDrawComplete();')
    if path == 'areas/palace.area.gml' and name == 'area_start':
        marker='if (((distance_to_point(10016, 10016) > 160) and (random(16) < 1)))'
        assert marker in code
        code = code.replace(marker, 'if (!(self[$ "hm_interior_wall"]??false) && distance_to_point(10016,10016)>160 && random(16)<1)')
        code, count = re.subn(
            r'instance_create\(\((?P<floor>\w+)\.x \+ 16\), \((?P=floor)\.y \+ 16\), SmallGenerator\);',
            r'scrHMPalaceGenerator105(\g<floor>.x+16,\g<floor>.y+16);', code)
        assert count == 1, 'Palace generator placement must use coordinate deduplication'
    if path == 'areas/palace.area.gml' and name == 'area_pop_enemies':
        assert 'hp = 10016;' in code
        code = code.replace('hp = 10016;', 'scrHMPalaceHorrorInit();')
    if path == 'maincode.mod.gml' and name == 'sewerboi':
        code = code.replace('function hm_maincode_mod_gml_sewerboi() {',
            'function hm_maincode_mod_gml_sewerboi() {\nif(!instance_exists(creator) || !(creator[$ "swimming"]??false)) return;')
    if path == 'maincode.mod.gml' and name == 'step':
        code = code.replace('scrHMMatchingNE(Wall, "thing", 1)', 'scrHMMatchingNE(scrHMAuthoredWalls105(), "thing", 1)')
        code = code.replace('scrHMMatching(Wall, "thing", undefined)', 'scrHMMatching(scrHMAuthoredWalls105(), "thing", undefined)')
        # Preserve the creator explicitly across the coroutine/with boundary.
        # The host's native bouncer also needs its one ricochet enabled.
        code, count = re.subn(r'(case \d+: // maincode.mod.gml:1074\n).*?(\n_hm.pc=\d+;)',
            r'\1scrHMBigDogShots105();\2',code,flags=re.S)
        assert count == 1
    if path == 'bosses/titank.mod.gml' and name == 'wanttitank_step':
        code, count = re.subn(r'instance_nearest\(([^\n]+?), Wall\)', r'scrHMNearestAuthoredWall105(\1)', code)
        assert count == 1
    if path == 'bosses/ravenboss.mod.gml' and name == 'ravenboss_step':
        # alrm2 is consumed once in the Flight block; the source header
        # decremented it twice (and never decremented alrm4).
        code, count = re.subn(r'if \(\(alrm2 > 0\)\) \{\nalrm2--;\n\}', '', code)
        assert count == 1
        code, count = re.subn(r'(if \(\(alrm4 > 0\)\) \{\n)alrm2--;', r'\1alrm4--;', code)
        assert count == 1
        code, count = re.subn(r'flight_x = target\.x;\n(?:;\n)?flight_y = target\.y;', 'scrHMRavenAim105();', code)
        assert count == 3
        code = code.replace('flying = 1;', 'flying = 1;hm_flight_age=0;hm_flight_locked=false;')
        # The flight uses mskNone. distance_to_point is mask-relative and
        # cannot determine arrival for an empty mask on this host runner.
        code, count = re.subn(r'distance_to_point\(flight_x, flight_y\)', 'point_distance(x,y,flight_x,flight_y)', code)
        assert count == 2
        marker='_hm.vars._dir = point_direction(x, y, flight_x, flight_y);'
        assert marker in code
        code = code.replace(marker, 'hm_flight_age=(self[$ "hm_flight_age"]??0)+1;\n'+marker)
        # A single radial speed avoids squaring each directional component.
        code = code.replace('min((abs((flight_x - x)) * 0.10), _hm.vars._maxspd)', 'min(point_distance(x,y,flight_x,flight_y)*.10,_hm.vars._maxspd)')
        code = code.replace('min((abs((flight_y - y)) * 0.10), _hm.vars._maxspd)', 'min(point_distance(x,y,flight_x,flight_y)*.10,_hm.vars._maxspd)')
    return code
