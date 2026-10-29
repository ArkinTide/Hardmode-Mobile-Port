"""Legacy global/boolean/draw contracts, keeping b24 input immutable."""
import re


def emitted_repair(path, name, code):
    # NTT's current_frame was integral. The mobile host advances it by .5
    # at 60 FPS; a menu/rate change can leave every logic tick on a half
    # frame, so exact modulo visibility checks never run. Quantize only
    # these tick gates, retaining fractional native damage timestamps.
    code = re.sub(r'\(current_frame mod (\d+)\)', r'(floor(current_frame) mod \1)', code)
    if path == 'maincode.mod.gml' and name == 'step':
        marker='(GameCont.subarea == 300) and (instance_number(enemy) <= 1)'
        assert marker in code
        code=code.replace(marker,marker+' and scrHMVenusAutoExit106()')
    if path == 'bosses/gungod.mod.gml' and name == 'helicopterdown':
        # The crashing aircraft must leave the arena; collision-only exterior
        # walls added by the port must not bounce it back into the fight.
        opening=code.index('{')+1
        code=code[:opening]+'\nmask_index=mskNone;'+code[opening:]
    if path == 'bosses/gungod.mod.gml' and name == 'yungbullet':
        # Explosions may replace the landing Floor after the pilot launches.
        # Reacquire the live terrain rather than dereferencing its old ID.
        opening=code.index('{')+1
        code=code[:opening]+'\nif(!instance_exists(target)) target=instance_nearest(x,y,Floor);\nif(!instance_exists(target)) return;'+code[opening:]
    if path == 'props.mod.gml' and name == 'VenuzCar_step':
        # driver is a local player index, not a native object/instance ID.
        assert code.count('_hml_car.driver.team')==2
        code=code.replace('_hml_car.driver.team','scrHMPlayerFind(_hml_car.driver).team')
    if path == 'maincode.mod.gml' and name in {'spacesewerboi', 'sewerboi'}:
        # Some logical hit receivers intentionally have sprite -1. Do not
        # call sprite dimension builtins on them or manufacture default art.
        code, count = re.subn(r'(if\(instance_exists\(__hm_with\d+\[__hm_index\d+\]\)\) with \(__hm_with\d+\[__hm_index\d+\]\) \{)',
            r'\1\nif(!scrHMSwimSprite106()) continue;', code)
        assert count == 1
    if path == 'areas/throne.area.gml' and name == 'area_start':
        # The FloorMaker already creates a seed before area_make_floor.
        # Select that actual seed if no duplicate tile could retain nokill.
        prefix = 'function hm_areas_throne_area_gml_area_start() {'
        assert prefix in code
        code = code.replace(prefix, prefix+'\nscrHMThroneSeed106();')
    if path == 'enemies.mod.gml' and name == 'elitebandit_create':
        marker = 'on_step = scrHMScriptRef(hm_enemies_mod_gml_elitebandit_step);'
        assert marker in code
        code = code.replace(marker, 'scrHMSnowBandit106();\n'+marker)
    if path == 'props.mod.gml' and name == 'VenuzCar_create':
        # This function is synchronous; initialize the legacy optional
        # player vehicle fields once, before its first active callback.
        opening = code.index('{')+1
        code = code[:opening]+'\nscrHMCarPrepare106();'+code[opening:]
    return code
