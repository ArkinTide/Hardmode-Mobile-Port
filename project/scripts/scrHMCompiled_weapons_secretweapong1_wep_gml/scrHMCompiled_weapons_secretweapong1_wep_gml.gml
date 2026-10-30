// Source weapons/secretweapong1.wep.gml:1; __load
function hm_weapons_secretweapong1_wep_gml___load() {

}

// Source weapons/secretweapong1.wep.gml:2; weapon_name
function hm_weapons_secretweapong1_wep_gml_weapon_name() {
if ((((scrHMWeaponArea109() == scrHMAreaResolve("venuz")) || (scrHMWeaponArea109() == scrHMAreaResolve(103))) || (scrHMWeaponArea109() == scrHMAreaResolve(107)))) {
return "Pistol";
} else {
return "Venuz Pistol";
}
;
}

// Source weapons/secretweapong1.wep.gml:7; weapon_type
function hm_weapons_secretweapong1_wep_gml_weapon_type() {
return 1;
;
}

// Source weapons/secretweapong1.wep.gml:10; weapon_cost
function hm_weapons_secretweapong1_wep_gml_weapon_cost() {
return 1;
;
}

// Source weapons/secretweapong1.wep.gml:13; weapon_load
function hm_weapons_secretweapong1_wep_gml_weapon_load() {
return 6;
;
}

// Source weapons/secretweapong1.wep.gml:16; weapon_auto
function hm_weapons_secretweapong1_wep_gml_weapon_auto() {
return 0;
;
}

// Source weapons/secretweapong1.wep.gml:19; weapon_area
function hm_weapons_secretweapong1_wep_gml_weapon_area() {
return (- 1);
;
}

// Source weapons/secretweapong1.wep.gml:22; weapon_swap
function hm_weapons_secretweapong1_wep_gml_weapon_swap() {
return sndSwapPistol;
;
}

// Source weapons/secretweapong1.wep.gml:25; weapon_sprt
function hm_weapons_secretweapong1_wep_gml_weapon_sprt() {
return sprMolefishGun;
;
}

// Source weapons/secretweapong1.wep.gml:28; weapon_text
function hm_weapons_secretweapong1_wep_gml_weapon_text() {
return "where am I";
;
}

// Source weapons/secretweapong1.wep.gml:31; weapon_fire
function hm_weapons_secretweapong1_wep_gml_weapon_fire() {
var _hml_dist = 4;
;
scrHMSoundPlay(sndPistol);
;
scrHMWeaponPost(5, 10, 10);
while ((((((place_free((x + lengthdir_x(_hml_dist, gunangle)), (y + lengthdir_y(_hml_dist, gunangle))) and (! place_meeting((x + lengthdir_x(_hml_dist, gunangle)), (y + lengthdir_y(_hml_dist, gunangle)), enemy))) and (! place_meeting((x + lengthdir_x(_hml_dist, gunangle)), (y + lengthdir_y(_hml_dist, gunangle)), CustomHitme))) and (! place_meeting((x + lengthdir_x(_hml_dist, gunangle)), (y + lengthdir_y(_hml_dist, gunangle)), CustomObject))) and (! place_meeting((x + lengthdir_x(_hml_dist, gunangle)), (y + lengthdir_y(_hml_dist, gunangle)), prop))) and (_hml_dist < (view_width * 3)))) {
_hml_dist += 4;
;
}
{ var __hm_with1 = scrHMInstances(instance_create((x + lengthdir_x(_hml_dist, gunangle)), (y + lengthdir_y(_hml_dist, gunangle)), Bullet1)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var __hm_other4=scrHMOther(other);
scrHMMotionAdd(__hm_other4.gunangle, 10);
;
image_angle = direction;
;
image_alpha = 0;
var __hm_other5=scrHMOther(other);
hitid = [__hm_other5.spr_idle, __hm_other5.race];
;
damage = (5 - round((_hml_dist / 100)));
knockback_speed = (1) * timescale;
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
{ var __hm_with8 = scrHMInstances(instance_create((x + lengthdir_x((_hml_dist / 2), gunangle)), (y + lengthdir_y((_hml_dist / 2), gunangle)), Effect)), __hm_break10=false;
for (var __hm_index9=0; __hm_index9<array_length(__hm_with8); ++__hm_index9) {
if(instance_exists(__hm_with8[__hm_index9])) with (__hm_with8[__hm_index9]) {
{
name = "venuzpistoltrail";
sprite_index = sprBoltTrail;
var __hm_other11=scrHMOther(other);
direction = __hm_other11.gunangle;
image_angle = (direction + 90);
;
var __hm_other12=scrHMOther(other);
creator = __hm_other12;
;
image_yscale *= (_hml_dist / 2);
image_xscale = random_range(0.5, 1.5);
image_alpha = random_range(0, 1);
scrHMMotionAdd(direction, random_range(0, 6));
}
}
if(__hm_break10) break;
}}
{ var __hm_with13 = scrHMInstances(instance_create((x + lengthdir_x(4, gunangle)), (y + lengthdir_y(4, gunangle)), EBulletHit)), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
sprite_index = sprScrapBossMissileTrail;
var __hm_other16=scrHMOther(other);
image_angle = (__hm_other16.gunangle + 180);
image_speed = (1) * timescale;
}
}
if(__hm_break15) break;
}}
}
