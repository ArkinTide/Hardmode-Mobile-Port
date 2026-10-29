// Source areas/noyetihere.area.gml:1; __load
function hm_areas_noyetihere_area_gml___load() {

}

// Source areas/noyetihere.area.gml:1; area_name
function hm_areas_noyetihere_area_gml_area_name() {
return "???";
;
}

// Source areas/noyetihere.area.gml:4; area_sprite
function hm_areas_noyetihere_area_gml_area_sprite(_hml_q) {
switch (_hml_q) {
case sprFloor1:
return sprFloor5;
;
case sprFloor1B:
return sprFloor5;
;
case sprFloor1Explo:
return sprFloor5Explo;
;
case sprWall1Trans:
return sprWall5Trans;
;
case sprWall1Bot:
return sprWall5Bot;
;
case sprWall1Out:
return sprWall5Out;
;
case sprWall1Top:
return sprWall5Top;
;
case sprDebris1:
return sprDebris5;
;
case sprDetail1:
return sprDetail5;
;
}
}

// Source areas/noyetihere.area.gml:17; area_transit
function hm_areas_noyetihere_area_gml_area_transit() {
if (((lastarea != scrHMAreaResolve("noyetihere")) && (lastarea == scrHMAreaResolve("yeti")))) {
{
area = scrHMAreaResolve("noyetihere");
;
}
}
}

// Source areas/noyetihere.area.gml:22; area_finish
function hm_areas_noyetihere_area_gml_area_finish() {
area = scrHMAreaResolve("city");
;
subarea = lastsubarea;
;
}

// Source areas/noyetihere.area.gml:26; area_setup
function hm_areas_noyetihere_area_gml_area_setup() {
scrHMSoundMusic((- 4));
scrHMSoundAmbient(amb100);
;
goal = 18;
;
background_set_colour(make_color_rgb(180, 189, 197));
;
BackCont.shadow_color = c_black;
;
TopCont.darkness = 1;
;
}

// Source areas/noyetihere.area.gml:34; area_start
function hm_areas_noyetihere_area_gml_area_start() {
repeat (7) instance_create(10016, 10016, LightBeam);
var _hml__floor = instance_furthest(10016, 10016, Floor);
;
{ var __hm_with1 = scrHMInstances(instance_nearest((((((_hml__floor.x * 2) + 10016) / 3) + random(128)) - 64), (((((_hml__floor.y * 2) + 10016) / 3) + random(128)) - 64), Floor)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMModCall("mod", "enemies", "yeti_create", (x + 16), (y + 16));
}
if(__hm_break3) break;
}}
scrHMModCall("mod", "props", "leave_create", 10016, 10016);
;
{ var __hm_with4 = scrHMInstances(instance_create(0, 0, CustomEnemy)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
name = "portalblocker";
canfly = 1;
}
}
if(__hm_break6) break;
}}
}

// Source areas/noyetihere.area.gml:49; area_make_floor
function hm_areas_noyetihere_area_gml_area_make_floor() {
{ var __hm_with1 = scrHMInstances(GenCont), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
safespawn = 2;
}
if(__hm_break3) break;
}}
direction = choose(90, 0, 180, 270);
instance_create(x, y, Floor);
;
instance_create((x + 32), y, Floor);
;
instance_create((x - 32), y, Floor);
;
}

// Source areas/noyetihere.area.gml:57; area_pop_enemies
function hm_areas_noyetihere_area_gml_area_pop_enemies() {

}

// Source areas/noyetihere.area.gml:58; area_pop_props
function hm_areas_noyetihere_area_gml_area_pop_props() {
if ((random(40) < 1)) {
instance_create((x + 16), (y + 16), SodaMachine);
} else {
if ((random(30) < 1)) {
instance_create((x + 16), (y + 16), TV);
} else {
if ((random(20) < 1)) {
instance_create((x + 16), (y + 16), Server);
} else {
if ((random(10) < 1)) {
instance_create((x + 16), (y + 16), Tires);
} else {
if ((random(10) < 1)) {
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), Table)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
spr_idle = sprFallenChair;
spr_hurt = sprFallenChairHurt;
spr_dead = sprFallenChairDead;
}
}
if(__hm_break3) break;
}}
}
}
}
}
}
if ((random(10) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create(x, y, WepPickup)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
var _hml_weplist = ds_list_create();
;
scrHMWeaponList(_hml_weplist, 6, (GameCont.hard + 3));
;
wep = scrHMWeaponResolve(ds_list_find_value(_hml_weplist, irandom((ds_list_size(_hml_weplist) - 1))));
;
ds_list_destroy(_hml_weplist);
;
ammo = 1;
}
}
if(__hm_break6) break;
}}
}
}

// Source areas/noyetihere.area.gml:75; area_mapdata
function hm_areas_noyetihere_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return [(_hml_lx - 9), 0];
;
}
