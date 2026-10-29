// Source weapons/secretweaponi3.wep.gml:1; __load
function hm_weapons_secretweaponi3_wep_gml___load() {
scrHMWeaponSetArea(26, (- 1));
scrHMWeaponSetName(26, "old hyper rifle");
}

// Source weapons/secretweaponi3.wep.gml:4; weapon_name
function hm_weapons_secretweaponi3_wep_gml_weapon_name() {
return "HYPER RIFLE";
;
}

// Source weapons/secretweaponi3.wep.gml:7; weapon_type
function hm_weapons_secretweaponi3_wep_gml_weapon_type() {
return 1;
;
}

// Source weapons/secretweaponi3.wep.gml:10; weapon_cost
function hm_weapons_secretweaponi3_wep_gml_weapon_cost() {
return 5;
;
}

// Source weapons/secretweaponi3.wep.gml:13; weapon_load
function hm_weapons_secretweaponi3_wep_gml_weapon_load() {
return 3;
;
}

// Source weapons/secretweaponi3.wep.gml:16; weapon_auto
function hm_weapons_secretweaponi3_wep_gml_weapon_auto() {
return 0;
;
}

// Source weapons/secretweaponi3.wep.gml:19; weapon_area
function hm_weapons_secretweaponi3_wep_gml_weapon_area() {
return 8;
;
}

// Source weapons/secretweaponi3.wep.gml:22; weapon_swap
function hm_weapons_secretweaponi3_wep_gml_weapon_swap() {
return sndSwapMachinegun;
;
}

// Source weapons/secretweaponi3.wep.gml:25; weapon_sprt
function hm_weapons_secretweaponi3_wep_gml_weapon_sprt() {
return sprHyperRifle;
;
}

// Source weapons/secretweaponi3.wep.gml:28; weapon_text
function hm_weapons_secretweaponi3_wep_gml_weapon_text() {
return "hyper time";
;
}

// Source weapons/secretweaponi3.wep.gml:31; weapon_fire
function hm_weapons_secretweaponi3_wep_gml_weapon_fire() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_weapons_secretweaponi3_wep_gml_weapon_fire_resume, id, scrHMOther(other), _args, 6, []);
}
function hm_weapons_secretweaponi3_wep_gml_weapon_fire_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_weapons_secretweaponi3_wep_gml_weapon_fire");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 2: // weapons/secretweaponi3.wep.gml:33
_hm.vars.__hm_repeat1--; _hm.pc=1;
break;
case 3: // weapons/secretweaponi3.wep.gml:48
_hm.wait_ticks=max(0,1); _hm.pc=2; return;
break;
case 4: // weapons/secretweaponi3.wep.gml:35
{
if (instance_exists(id)) {
{ var __hm_with2 = scrHMInstances(instance_create(x, y, Bullet1)), __hm_break4=false;
for (var __hm_index3=0; __hm_index3<array_length(__hm_with2); ++__hm_index3) {
if(instance_exists(__hm_with2[__hm_index3])) with (__hm_with2[__hm_index3]) {
{
scrHMSoundPlay(sndHyperRifle);
var __hm_other5=scrHMOther(other);
scrHMMotionAdd(((__hm_other5.gunangle + random(4)) - 2), 16);
image_angle = direction;
var __hm_other6=scrHMOther(other);
team = __hm_other6.team;
var __hm_other7=scrHMOther(other);
creator = __hm_other7;
sprite_index = sprIDPDBullet;
spr_dead = sprIDPDBulletHit;
{ var __hm_with8 = scrHMInstances(instance_create(x, y, Shell)), __hm_break10=false;
for (var __hm_index9=0; __hm_index9<array_length(__hm_with8); ++__hm_index9) {
if(instance_exists(__hm_with8[__hm_index9])) with (__hm_with8[__hm_index9]) {
var __hm_other11=scrHMOther(other);
scrHMMotionAdd((((__hm_other11.direction + 180) + random(50)) - 25), (2 + random(2)));
}
if(__hm_break10) break;
}}
}
}
if(__hm_break4) break;
}}
}
scrHMWeaponPost(4, (- 6), 3);
;
}
_hm.pc=3;
break;
case 5: // weapons/secretweaponi3.wep.gml:34
_hm.pc = (instance_exists(_hm.scope)) ? 4 : 2;
break;
case 1: // weapons/secretweaponi3.wep.gml:33
_hm.pc=(_hm.vars.__hm_repeat1>0)?5:0;
break;
case 6: // weapons/secretweaponi3.wep.gml:33
_hm.vars.__hm_repeat1=round(6); _hm.pc=1;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

