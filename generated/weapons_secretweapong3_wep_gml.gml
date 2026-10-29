// Source weapons/secretweapong3.wep.gml:1; __load
function hm_weapons_secretweapong3_wep_gml___load() {
global.hm_module_vars[$ "weapon:secretweapong3"].minigun = sprHM_weapons_secretweapong3_wep_1;
}

// Source weapons/secretweapong3.wep.gml:3; weapon_name
function hm_weapons_secretweapong3_wep_gml_weapon_name() {
if ((((GameCont.area == scrHMAreaResolve("venuz")) || (GameCont.area == scrHMAreaResolve(103))) || (GameCont.area == scrHMAreaResolve(107)))) {
return "Minigun";
} else {
return "Venuz Minigun";
}
;
}

// Source weapons/secretweapong3.wep.gml:8; weapon_type
function hm_weapons_secretweapong3_wep_gml_weapon_type() {
return 1;
;
}

// Source weapons/secretweapong3.wep.gml:11; weapon_cost
function hm_weapons_secretweapong3_wep_gml_weapon_cost() {
return 1;
;
}

// Source weapons/secretweapong3.wep.gml:14; weapon_load
function hm_weapons_secretweapong3_wep_gml_weapon_load() {
return 1;
;
}

// Source weapons/secretweapong3.wep.gml:17; weapon_auto
function hm_weapons_secretweapong3_wep_gml_weapon_auto() {
return 1;
;
}

// Source weapons/secretweapong3.wep.gml:20; weapon_area
function hm_weapons_secretweapong3_wep_gml_weapon_area() {
return (- 1);
;
}

// Source weapons/secretweapong3.wep.gml:23; weapon_swap
function hm_weapons_secretweapong3_wep_gml_weapon_swap() {
return sndSwapMachinegun;
;
}

// Source weapons/secretweapong3.wep.gml:26; weapon_sprt
function hm_weapons_secretweapong3_wep_gml_weapon_sprt() {
return global.hm_module_vars[$ "weapon:secretweapong3"].minigun;
;
}

// Source weapons/secretweapong3.wep.gml:29; weapon_text
function hm_weapons_secretweapong3_wep_gml_weapon_text() {
return "MORE GUN";
;
}

// Source weapons/secretweapong3.wep.gml:32; weapon_fire
function hm_weapons_secretweapong3_wep_gml_weapon_fire() {
var _hml_g_ = (gunangle + random_range(((- 10) * accuracy), (10 * accuracy)));
;
var _hml_dist = 4;
;
scrHMSoundPlay(sndMinigun);
;
scrHMWeaponPost(5, 10, 10);
while ((((((place_free((x + lengthdir_x(_hml_dist, _hml_g_)), (y + lengthdir_y(_hml_dist, _hml_g_))) and (! place_meeting((x + lengthdir_x(_hml_dist, _hml_g_)), (y + lengthdir_y(_hml_dist, _hml_g_)), enemy))) and (! place_meeting((x + lengthdir_x(_hml_dist, _hml_g_)), (y + lengthdir_y(_hml_dist, _hml_g_)), CustomHitme))) and (! place_meeting((x + lengthdir_x(_hml_dist, gunangle)), (y + lengthdir_y(_hml_dist, gunangle)), CustomObject))) and (! place_meeting((x + lengthdir_x(_hml_dist, _hml_g_)), (y + lengthdir_y(_hml_dist, _hml_g_)), prop))) and (_hml_dist < (view_width * 3)))) {
_hml_dist += 4;
;
}
{ var __hm_with1 = scrHMInstances(instance_create((x + lengthdir_x(_hml_dist, _hml_g_)), (y + lengthdir_y(_hml_dist, _hml_g_)), Bullet1)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
scrHMMotionAdd(_hml_g_, 10);
;
image_angle = direction;
;
image_alpha = 0;
var __hm_other4=scrHMOther(other);
hitid = [__hm_other4.spr_idle, __hm_other4.race];
;
damage = (5 - round((_hml_dist / 100)));
knockback_speed = (1) * timescale;
var __hm_other5=scrHMOther(other);
team = __hm_other5.team;
;
var __hm_other6=scrHMOther(other);
creator = __hm_other6;
;
}
}
if(__hm_break3) break;
}}
{ var __hm_with7 = scrHMInstances(instance_create((x + lengthdir_x((_hml_dist / 2), _hml_g_)), (y + lengthdir_y((_hml_dist / 2), _hml_g_)), Effect)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
name = "venuzpistoltrail";
sprite_index = sprBoltTrail;
direction = _hml_g_;
image_angle = (direction + 90);
;
var __hm_other10=scrHMOther(other);
creator = __hm_other10;
;
image_yscale = (_hml_dist / 2);
image_xscale = random_range(0.5, 1.5);
image_alpha = random_range(0, 1);
scrHMMotionAdd(direction, random_range(0, 6));
}
}
if(__hm_break9) break;
}}
{ var __hm_with11 = scrHMInstances(instance_create((x + lengthdir_x(4, _hml_g_)), (y + lengthdir_y(4, _hml_g_)), EBulletHit)), __hm_break13=false;
for (var __hm_index12=0; __hm_index12<array_length(__hm_with11); ++__hm_index12) {
if(instance_exists(__hm_with11[__hm_index12])) with (__hm_with11[__hm_index12]) {
{
sprite_index = sprScrapBossMissileTrail;
image_angle = (_hml_g_ + 180);
image_speed = (1) * timescale;
}
}
if(__hm_break13) break;
}}
}
