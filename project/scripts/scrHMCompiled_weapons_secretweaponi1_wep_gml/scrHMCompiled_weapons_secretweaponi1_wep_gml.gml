// Source weapons/secretweaponi1.wep.gml:1; __load
function hm_weapons_secretweaponi1_wep_gml___load() {

}

// Source weapons/secretweaponi1.wep.gml:1; weapon_name
function hm_weapons_secretweaponi1_wep_gml_weapon_name() {
return "Heavy IDPD rifle";
;
}

// Source weapons/secretweaponi1.wep.gml:4; weapon_type
function hm_weapons_secretweaponi1_wep_gml_weapon_type() {
return 1;
;
}

// Source weapons/secretweaponi1.wep.gml:7; weapon_cost
function hm_weapons_secretweaponi1_wep_gml_weapon_cost() {
return 2;
;
}

// Source weapons/secretweaponi1.wep.gml:10; weapon_load
function hm_weapons_secretweaponi1_wep_gml_weapon_load() {
return 4;
;
}

// Source weapons/secretweaponi1.wep.gml:13; weapon_auto
function hm_weapons_secretweaponi1_wep_gml_weapon_auto() {
return 1;
;
}

// Source weapons/secretweaponi1.wep.gml:16; weapon_area
function hm_weapons_secretweaponi1_wep_gml_weapon_area() {
return (- 1);
;
}

// Source weapons/secretweaponi1.wep.gml:19; weapon_swap
function hm_weapons_secretweaponi1_wep_gml_weapon_swap() {
return sndSwapMachinegun;
;
}

// Source weapons/secretweaponi1.wep.gml:22; weapon_sprt
function hm_weapons_secretweaponi1_wep_gml_weapon_sprt() {
return sprPopoHeavyGun;
;
}

// Source weapons/secretweaponi1.wep.gml:25; weapon_text
function hm_weapons_secretweaponi1_wep_gml_weapon_text() {
return "more gun";
;
}

// Source weapons/secretweaponi1.wep.gml:28; weapon_fire
function hm_weapons_secretweaponi1_wep_gml_weapon_fire() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_weapons_secretweaponi1_wep_gml_weapon_fire_resume, id, scrHMOther(other), _args, 6, []);
}
function hm_weapons_secretweaponi1_wep_gml_weapon_fire_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_weapons_secretweaponi1_wep_gml_weapon_fire");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 2: // weapons/secretweaponi1.wep.gml:30
_hm.vars.__hm_repeat1--; _hm.pc=1;
break;
case 3: // weapons/secretweaponi1.wep.gml:46
_hm.wait_ticks=max(0,2); _hm.pc=2; return;
break;
case 4: // weapons/secretweaponi1.wep.gml:32
{
scrHMSoundPlay(sndRogueRifle);
{ var __hm_with2 = scrHMInstances(instance_create(x, y, Shell)), __hm_break4=false;
for (var __hm_index3=0; __hm_index3<array_length(__hm_with2); ++__hm_index3) {
if(instance_exists(__hm_with2[__hm_index3])) with (__hm_with2[__hm_index3]) {
var __hm_other5=scrHMOther(other);
scrHMMotionAdd((((__hm_other5.gunangle + 180) + random(80)) - 40), (3 + random(2)));
}
if(__hm_break4) break;
}}
{ var __hm_with6 = scrHMInstances(instance_create(x, y, Bullet1)), __hm_break8=false;
for (var __hm_index7=0; __hm_index7<array_length(__hm_with6); ++__hm_index7) {
if(instance_exists(__hm_with6[__hm_index7])) with (__hm_with6[__hm_index7]) {
{
var __hm_other9=scrHMOther(other);
scrHMMotionAdd((__hm_other9.gunangle + (random_range((- 8), 8) * __hm_other9.accuracy)), 16);
image_angle = direction;
var __hm_other10=scrHMOther(other);
team = __hm_other10.team;
sprite_index = sprIDPDBullet;
spr_dead = sprIDPDBulletHit;
}
}
if(__hm_break8) break;
}}
var __hm_other11=scrHMOther(other);
scrHMMotionAdd((__hm_other11.gunangle + 180), 0.6);
scrHMWeaponPost(4, (- 6), 3);
;
}
_hm.pc=3;
break;
case 5: // weapons/secretweaponi1.wep.gml:31
_hm.pc = (instance_exists(_hm.scope)) ? 4 : 2;
break;
case 1: // weapons/secretweaponi1.wep.gml:30
_hm.pc=(_hm.vars.__hm_repeat1>0)?5:0;
break;
case 6: // weapons/secretweaponi1.wep.gml:30
_hm.vars.__hm_repeat1=round(2); _hm.pc=1;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

