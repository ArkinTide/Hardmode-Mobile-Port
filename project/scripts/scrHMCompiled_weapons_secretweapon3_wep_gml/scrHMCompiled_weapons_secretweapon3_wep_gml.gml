// Source weapons/secretweapon3.wep.gml:1; __load
function hm_weapons_secretweapon3_wep_gml___load() {

}

// Source weapons/secretweapon3.wep.gml:1; init
function hm_weapons_secretweapon3_wep_gml_init() {
global.hm_module_vars[$ "weapon:secretweapon3"].crystalrifle = sprHM_weapons_secretweapon3_wep_2;
;
}

// Source weapons/secretweapon3.wep.gml:4; weapon_name
function hm_weapons_secretweapon3_wep_gml_weapon_name() {
return "CRYSTAL RIFLE";
;
}

// Source weapons/secretweapon3.wep.gml:7; weapon_type
function hm_weapons_secretweapon3_wep_gml_weapon_type() {
return 5;
;
}

// Source weapons/secretweapon3.wep.gml:10; weapon_cost
function hm_weapons_secretweapon3_wep_gml_weapon_cost() {
return 2;
;
}

// Source weapons/secretweapon3.wep.gml:13; weapon_load
function hm_weapons_secretweapon3_wep_gml_weapon_load() {
return 15;
;
}

// Source weapons/secretweapon3.wep.gml:16; weapon_area
function hm_weapons_secretweapon3_wep_gml_weapon_area() {
if ((((scrHMWeaponArea109() == scrHMAreaResolve(104)) || (scrHMWeaponArea109() == scrHMAreaResolve("icecave"))) || (scrHMWeaponArea109() == scrHMAreaResolve("cavesinv")))) {
return 1;
} else {
return (- 1);
}
;
}

// Source weapons/secretweapon3.wep.gml:21; weapon_gold
function hm_weapons_secretweapon3_wep_gml_weapon_gold() {
return 1;
}

// Source weapons/secretweapon3.wep.gml:24; weapon_swap
function hm_weapons_secretweapon3_wep_gml_weapon_swap() {
return sndSwapEnergy;
;
}

// Source weapons/secretweapon3.wep.gml:27; weapon_fire
function hm_weapons_secretweapon3_wep_gml_weapon_fire() {
scrHMSoundPlay(sndLaserCannonCharge);
;
{ var __hm_with1 = scrHMInstances(instance_create(x, y, CustomObject)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var __hm_other4=scrHMOther(other);
image_angle = __hm_other4.gunangle;
;
ammo = 3;
image_speed = (0) * timescale;
image_index = 2;
image_xscale = 1;
sprite_index = sprLaserCharge;
hitid = [sprite_index, "LASER CHARGE"];
;
var __hm_other5=scrHMOther(other);
team = __hm_other5.team;
;
var __hm_other6=scrHMOther(other);
creator = __hm_other6;
;
on_step = scrHMScriptRef(hm_weapons_secretweapon3_wep_gml_crystallaser_step);
}
}
if(__hm_break3) break;
}}
}

// Source weapons/secretweapon3.wep.gml:44; weapon_sprt
function hm_weapons_secretweapon3_wep_gml_weapon_sprt() {
return global.hm_module_vars[$ "weapon:secretweapon3"].crystalrifle;
;
}

// Source weapons/secretweapon3.wep.gml:47; weapon_text
function hm_weapons_secretweapon3_wep_gml_weapon_text() {
return "PEW PEW PEW";
;
}

// Source weapons/secretweapon3.wep.gml:50; step
function hm_weapons_secretweapon3_wep_gml_step() {
if ((random(10) < 1)) {
instance_create(x, y, CaveSparkle);
}
}

// Source weapons/secretweapon3.wep.gml:54; crystallaser_step
function hm_weapons_secretweapon3_wep_gml_crystallaser_step() {
if (instance_exists(creator)) {
{
x = (creator.x + lengthdir_x(16, creator.gunangle));
y = ((creator.y + lengthdir_y(16, creator.gunangle)) - 2);
image_xscale += 0.6;
image_yscale = image_xscale;
if ((image_xscale >= 3)) {
{
{ var __hm_with1 = scrHMInstances(creator), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if (scrHMGetSkill(17)) {
scrHMSoundPlay(sndLaserUpg);
} else {
scrHMSoundPlay(sndLaser);
}
;
{ var __hm_with4 = scrHMInstances(instance_create(x, y, EnemyLaser)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
alarm[0] = 1;
;
var __hm_other7=scrHMOther(other);
image_angle = __hm_other7.gunangle;
;
hitid = [sprite_index, "LASER"];
;
var __hm_other8=scrHMOther(other);
team = __hm_other8.team;
;
var __hm_other9=scrHMOther(other);
creator = __hm_other9;
;
damage = 2;
if (scrHMGetSkill(17)) {
image_yscale = 2.2;
}
direction = image_angle;
}
}
if(__hm_break6) break;
}}
}
}
if(__hm_break3) break;
}}
if ((ammo > 1)) {
{
ammo -= 1;
image_xscale = 0;
}
} else {
instance_destroy();
}
}
}
}
} else {
instance_destroy();
}
}
