// Source weapons/secretweapon1.wep.gml:1; __load
function hm_weapons_secretweapon1_wep_gml___load() {
global.hm_module_vars[$ "weapon:secretweapon1"].trident = sprHM_weapons_secretweapon1_wep_1;
}

// Source weapons/secretweapon1.wep.gml:2; weapon_name
function hm_weapons_secretweapon1_wep_gml_weapon_name() {
return "trident";
;
}

// Source weapons/secretweapon1.wep.gml:5; weapon_type
function hm_weapons_secretweapon1_wep_gml_weapon_type() {
return 0;
;
}

// Source weapons/secretweapon1.wep.gml:8; weapon_cost
function hm_weapons_secretweapon1_wep_gml_weapon_cost() {
return 0;
;
}

// Source weapons/secretweapon1.wep.gml:11; weapon_load
function hm_weapons_secretweapon1_wep_gml_weapon_load() {
return 25;
;
}

// Source weapons/secretweapon1.wep.gml:14; weapon_auto
function hm_weapons_secretweapon1_wep_gml_weapon_auto() {
return 0;
;
}

// Source weapons/secretweapon1.wep.gml:17; weapon_area
function hm_weapons_secretweapon1_wep_gml_weapon_area() {
return (- 1);
;
}

// Source weapons/secretweapon1.wep.gml:20; weapon_swap
function hm_weapons_secretweapon1_wep_gml_weapon_swap() {
return sndSwapHammer;
;
}

// Source weapons/secretweapon1.wep.gml:23; weapon_sprt
function hm_weapons_secretweapon1_wep_gml_weapon_sprt() {
return global.hm_module_vars[$ "weapon:secretweapon1"].trident;
;
}

// Source weapons/secretweapon1.wep.gml:26; weapon_text
function hm_weapons_secretweapon1_wep_gml_weapon_text() {
return "ppopoioinintntytyy";
;
}

// Source weapons/secretweapon1.wep.gml:29; weapon_melee
function hm_weapons_secretweapon1_wep_gml_weapon_melee() {
return 0;
;
}

// Source weapons/secretweapon1.wep.gml:32; weapon_fire
function hm_weapons_secretweapon1_wep_gml_weapon_fire() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_weapons_secretweapon1_wep_gml_weapon_fire_resume, id, scrHMOther(other), _args, 3, []);
}
function hm_weapons_secretweapon1_wep_gml_weapon_fire_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_weapons_secretweapon1_wep_gml_weapon_fire");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // weapons/secretweapon1.wep.gml:45
{
if (instance_exists(id)) {
{
scrHMSoundPlay(sndWrench);
_hm.vars.ang = (- 10);
repeat (3) {
{ var __hm_with1 = scrHMInstances(instance_create((x + lengthdir_x(((scrHMGetSkill(13) * 20) + 12), (gunangle + _hm.vars.ang))), (y + lengthdir_y(((scrHMGetSkill(13) * 20) + 12), (gunangle + _hm.vars.ang))), Shank)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var __hm_other4=scrHMOther(other);
scrHMMotionAdd((__hm_other4.gunangle + _hm.vars.ang), (6 + (scrHMGetSkill(13) * 3)));
damage = 6;
var __hm_other5=scrHMOther(other);
team = __hm_other5.team;
var __hm_other6=scrHMOther(other);
creator = __hm_other6;
canfix = 0;
image_speed *= 0.8;
image_angle = direction;
}
}
if(__hm_break3) break;
}}
_hm.vars.ang += 10;
}
scrHMMotionAdd(gunangle, 12);
wkick = (- 30);
if ((race != 7)) {
wkick = (- 30);
} else {
{
if ((wep == scrHMWeaponResolve("secretweapon1"))) {
wkick = (- 30);
}
if ((bwep == scrHMWeaponResolve("secretweapon1"))) {
bwkick = (- 30);
}
}
}
}
}
}
_hm.pc=0;
break;
case 2: // weapons/secretweapon1.wep.gml:44
_hm.wait_ticks=max(0,5); _hm.pc=1; return;
break;
case 3: // weapons/secretweapon1.wep.gml:33
{
repeat (5) {
if (instance_exists(id)) {
if ((race != 7)) {
wkick += 2;
} else {
{
if ((wep == scrHMWeaponResolve("secretweapon1"))) {
wkick += 2;
}
if ((bwep == scrHMWeaponResolve("secretweapon1"))) {
bwkick += 2;
}
}
}
}
}
}
_hm.pc=2;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

