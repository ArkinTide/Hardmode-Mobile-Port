// Source weapons/secretweapong4.wep.gml:1; __load
function hm_weapons_secretweapong4_wep_gml___load() {
global.hm_module_vars[$ "weapon:secretweapong4"].rocket = sprHM_weapons_secretweapong4_wep_1;
}

// Source weapons/secretweapong4.wep.gml:3; weapon_name
function hm_weapons_secretweapong4_wep_gml_weapon_name() {
if ((((scrHMWeaponArea109() == scrHMAreaResolve("venuz")) || (scrHMWeaponArea109() == scrHMAreaResolve(103))) || (scrHMWeaponArea109() == scrHMAreaResolve(107)))) {
return "Rocket Launcher";
} else {
return "Venuz Rocket Launcher";
}
;
}

// Source weapons/secretweapong4.wep.gml:8; weapon_type
function hm_weapons_secretweapong4_wep_gml_weapon_type() {
return 4;
;
}

// Source weapons/secretweapong4.wep.gml:11; weapon_cost
function hm_weapons_secretweapong4_wep_gml_weapon_cost() {
return 1;
;
}

// Source weapons/secretweapong4.wep.gml:14; weapon_load
function hm_weapons_secretweapong4_wep_gml_weapon_load() {
return 16;
;
}

// Source weapons/secretweapong4.wep.gml:17; weapon_auto
function hm_weapons_secretweapong4_wep_gml_weapon_auto() {
return 0;
;
}

// Source weapons/secretweapong4.wep.gml:20; weapon_area
function hm_weapons_secretweapong4_wep_gml_weapon_area() {
return (- 1);
;
}

// Source weapons/secretweapong4.wep.gml:23; weapon_swap
function hm_weapons_secretweapong4_wep_gml_weapon_swap() {
return sndSwapExplosive;
;
}

// Source weapons/secretweapong4.wep.gml:26; weapon_sprt
function hm_weapons_secretweapong4_wep_gml_weapon_sprt() {
return global.hm_module_vars[$ "weapon:secretweapong4"].rocket;
;
}

// Source weapons/secretweapong4.wep.gml:29; weapon_text
function hm_weapons_secretweapong4_wep_gml_weapon_text() {
return "sturdy architecture";
;
}

// Source weapons/secretweapong4.wep.gml:32; weapon_fire
function hm_weapons_secretweapong4_wep_gml_weapon_fire() {
scrHMMotionAdd((gunangle + 180), 5);
scrHMSoundPlay(sndRocket);
;
scrHMWeaponPost(5, 20, 20);
repeat (3) { var __hm_with1 = scrHMInstances(instance_create((x + lengthdir_x(4, gunangle)), (y + lengthdir_y(4, gunangle)), Rocket)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var __hm_other4=scrHMOther(other);
direction = __hm_other4.gunangle;
image_angle = direction;
;
var __hm_other5=scrHMOther(other);
hitid = [__hm_other5.spr_idle, __hm_other5.race];
;
sprite_index = sprRocket;
var __hm_other6=scrHMOther(other);
team = __hm_other6.team;
;
var __hm_other7=scrHMOther(other);
creator = __hm_other7;
;
}
}
if(__hm_break3) break;
}}
repeat (12) { var __hm_with8 = scrHMInstances(instance_create((x + lengthdir_x(16, (gunangle + 180))), (y + lengthdir_y(4, (gunangle + 180))), Smoke)), __hm_break10=false;
for (var __hm_index9=0; __hm_index9<array_length(__hm_with8); ++__hm_index9) {
if(instance_exists(__hm_with8[__hm_index9])) with (__hm_with8[__hm_index9]) {
var __hm_other11=scrHMOther(other);
scrHMMotionAdd((__hm_other11.gunangle + 180), random(5));
}
if(__hm_break10) break;
}}
}
