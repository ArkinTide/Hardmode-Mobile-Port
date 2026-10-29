// Source weapons/secretweaponi2.wep.gml:1; __load
function hm_weapons_secretweaponi2_wep_gml___load() {

}

// Source weapons/secretweaponi2.wep.gml:1; weapon_name
function hm_weapons_secretweaponi2_wep_gml_weapon_name() {
return "IDPD SLUGGER";
;
}

// Source weapons/secretweaponi2.wep.gml:4; weapon_type
function hm_weapons_secretweaponi2_wep_gml_weapon_type() {
return 2;
;
}

// Source weapons/secretweaponi2.wep.gml:7; weapon_cost
function hm_weapons_secretweaponi2_wep_gml_weapon_cost() {
return 1;
;
}

// Source weapons/secretweaponi2.wep.gml:10; weapon_load
function hm_weapons_secretweaponi2_wep_gml_weapon_load() {
return 7;
;
}

// Source weapons/secretweaponi2.wep.gml:13; weapon_auto
function hm_weapons_secretweaponi2_wep_gml_weapon_auto() {
return 1;
;
}

// Source weapons/secretweaponi2.wep.gml:16; weapon_area
function hm_weapons_secretweaponi2_wep_gml_weapon_area() {
return (- 1);
;
}

// Source weapons/secretweaponi2.wep.gml:19; weapon_sprt
function hm_weapons_secretweaponi2_wep_gml_weapon_sprt() {
return sprPopoSlugger;
;
}

// Source weapons/secretweaponi2.wep.gml:22; weapon_text
function hm_weapons_secretweaponi2_wep_gml_weapon_text() {
return "blue gun";
;
}

// Source weapons/secretweaponi2.wep.gml:25; weapon_fire
function hm_weapons_secretweaponi2_wep_gml_weapon_fire() {
scrHMSoundPlay(sndSlugger);
;
scrHMWeaponPost(3, (- 10), 6);
;
{ var __hm_with1 = scrHMInstances(instance_create(x, y, PopoSlug)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var __hm_other4=scrHMOther(other);
scrHMMotionAdd((__hm_other4.gunangle + (random_range((- 8), 8) * __hm_other4.accuracy)), 18.5);
;
image_angle = direction;
;
sprite_index = sprPopoSlug;
hitid = [sprite_index, "SLUG"];
;
var __hm_other5=scrHMOther(other);
team = __hm_other5.team;
;
var __hm_other6=scrHMOther(other);
creator = __hm_other6;
;
damage = 22;
}
}
if(__hm_break3) break;
}}
}
