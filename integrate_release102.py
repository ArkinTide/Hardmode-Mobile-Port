"""Narrow native-host compatibility repair; preserve frozen MOD and base."""
from register_native import PROJECT,replace

# The host's weapon-fired maggot intentionally persists while making contact.
# Hardmode reuses it for a jumping enemy: that landing must consume its source
# once, just as its existing wall-contact handler already does.
replace('objects/FiredMaggot/Collision_Player.gml',
    '''if team != other.team && other.hp > 0 {
    with instance_create(x, y, Maggot) {''',
    '''if team != other.team && other.hp > 0 {
    var _hm_jump=scrHMEnabled()&&(self[$ "jumper"]??false);
    if(_hm_jump) {
        if(self[$ "hm_jump_landed"]??false) exit;
        hm_jump_landed=true;
    }
    with instance_create(x, y, Maggot) {''')
replace('objects/FiredMaggot/Collision_Player.gml',
    '''        givekill = 0
    }
}''',
    '''        givekill = 0
    }
    if(_hm_jump) instance_destroy(id,false);
}''')
print('Hardmode jumping-maggot landing repaired; no packaging or version change')

replace('scripts/scr_hit/scr_hit.gml',
    '''\t\tsprite_index = spr_hurt
\t\timage_index = 0''',
    '''\t\t// NTT Custom* actors own their animation state. Its default Draw
\t\t// displays spr_hurt without changing sprite_index before on_step.
\t\tif(!(self[$ "hm_custom_actor"]??false)) {
\t\t\tsprite_index = spr_hurt
\t\t\timage_index = 0
\t\t}''')

replace('objects/WepPickup/Create_0.gml', 'wep = wep_screwdriver', 'wep = wep_screwdriver\nhm_pickup_weapon=wep;')
for event in ['Step_0.gml','Draw_0.gml']:
    replace('objects/WepPickup/'+event, 'if lockstep_stop', 'scrHMPickupRefresh();\n\nif lockstep_stop')

_fog_path=PROJECT/'objects/TopCont/Draw_0.gml'
_fog_code=_fog_path.read_text(encoding='utf8')
if 'scrHMDrawFog();' not in _fog_code:
    _start=_fog_code.index('var spr = self[$ "fog"] ?? -1')
    _end=_fog_code.index('with Player {',_start)
    _fog_path.write_text(_fog_code[:_start]+'scrHMDrawFog();\n\n'+_fog_code[_end:],encoding='utf8')
