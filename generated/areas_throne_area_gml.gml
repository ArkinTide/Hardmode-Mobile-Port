// Source areas/throne.area.gml:1; __load
function hm_areas_throne_area_gml___load() {

}

// Source areas/throne.area.gml:1; area_name
function hm_areas_throne_area_gml_area_name() {
return "throne";
;
}

// Source areas/throne.area.gml:4; area_sprite
function hm_areas_throne_area_gml_area_sprite(_hml_q) {
switch (_hml_q) {
case sprFloor1:
return sprFloor7;
;
case sprFloor1B:
return sprFloor7;
;
case sprFloor1Explo:
return sprFloor7Explo;
;
case sprWall1Trans:
return sprWall7Trans;
;
case sprWall1Bot:
return sprWall7Bot;
;
case sprWall1Out:
return sprWall7Out;
;
case sprWall1Top:
return sprWall7Top;
;
case sprDebris1:
return sprDebris7;
;
}
}

// Source areas/throne.area.gml:16; area_transit
function hm_areas_throne_area_gml_area_transit() {
if (((lastarea == scrHMAreaResolve("palace")) and (lastsubarea == 4))) {
{
area = scrHMAreaResolve("throne");
;
}
}
}

// Source areas/throne.area.gml:21; area_finish
function hm_areas_throne_area_gml_area_finish() {
area = scrHMAreaResolve("end");
;
subarea = 0;
;
loops += 1;
;
hard += 10;
}

// Source areas/throne.area.gml:28; area_setup
function hm_areas_throne_area_gml_area_setup() {
scrHMSoundMusic(mus7);
goal = (480 + (64 * min((GameCont.loops * 2), 4)));
background_set_colour(make_color_rgb(97, 29, 36));
;
{ var __hm_with1 = scrHMInstances(BackCont), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
shadow_color = 786950;
}
if(__hm_break3) break;
}}
;
scrHMSpriteReplace(sprBackFloor, sprHM_areas_throne_area_35);
scrHMSpriteReplace(sprBackFloor2, sprHM_areas_throne_area_36);
scrHMSpriteReplace(sprBackFloorSmall, sprHM_areas_throne_area_37);
}

// Source areas/throne.area.gml:38; area_start
function hm_areas_throne_area_gml_area_start() {
scrHMThroneSeed106();
Player.x = 10016;
Player.y = 10516;
{ var __hm_with1 = scrHMMatching(Floor, "nokill", 1), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
Player.x = x;
Player.y = y;
instance_create((x + 16), ((y - 1568) - (64 * min((GameCont.loops * 2), 4))), NothingInactive);
instance_create((x + 16), (y - 1100), Carpet);
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(instance_create(10016, 0, CustomEnemy)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
name = "portalblocker";
canfly = 1;
}
}
if(__hm_break6) break;
}}
{ var __hm_with7 = scrHMInstances(RadChest), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
depth = 2;
}
if(__hm_break9) break;
}}
{ var __hm_with10 = scrHMInstances(Player), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
image_alpha = 1;
can_shoot = 1;
if ((race == scrHMRaceResolve("steroids"))) {
bcan_shoot = 1;
}
can_walk = 1;
reload = 0;
}
}
if(__hm_break12) break;
}}
}

// Source areas/throne.area.gml:60; area_make_floor
function hm_areas_throne_area_gml_area_make_floor() {
if ((instance_number(Floor) <= 1)) {
{ var __hm_with1 = scrHMInstances(instance_create(x, y, Floor)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
nokill = 1;
}
}
if(__hm_break3) break;
}}
}
instance_create(x, (y - 96), Floor);
;
instance_create(x, (y - 64), Floor);
;
instance_create((x + 32), (y - 64), Floor);
;
instance_create((x - 32), (y - 64), Floor);
;
instance_create((x + 32), (y - 32), Floor);
;
instance_create((x - 32), (y - 32), Floor);
;
instance_create((x + 64), (y - 32), Floor);
;
instance_create((x - 64), (y - 32), Floor);
;
instance_create(x, y, Floor);
;
instance_create((x + 32), y, Floor);
;
instance_create((x - 32), y, Floor);
;
instance_create((x + 64), y, Floor);
;
instance_create((x - 64), y, Floor);
;
instance_create((x + 96), y, Floor);
;
instance_create((x - 96), y, Floor);
;
if ((((distance_to_object(BigGenerator) > 160) and (distance_to_point(10016, 10016) > 240)) and (instance_number(BigGenerator) < (12 + min((GameCont.loops * 2), 4))))) {
{
instance_create(((x - 96) - 32), y, Floor);
;
instance_create(((x - 128) - 32), y, Floor);
;
instance_create(((x - 160) - 32), y, Floor);
;
instance_create(((x - 96) - 32), (y - 32), Floor);
;
instance_create(((x - 128) - 32), (y - 32), Floor);
;
instance_create(((x - 160) - 32), (y - 32), Floor);
;
instance_create(((x - 96) - 32), (y + 32), Floor);
;
instance_create(((x - 128) - 32), (y + 32), Floor);
;
instance_create(((x - 160) - 32), (y + 32), Floor);
;
{ var __hm_with4 = scrHMInstances(instance_create(((x - 128) - 32), y, BigGenerator)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
image_xscale = 1;
hp = 60;
}
}
if(__hm_break6) break;
}}
instance_create(((x - 128) + 64), (y - 64), ThroneStatue);
instance_create(((x + 96) + 32), y, Floor);
;
instance_create(((x + 128) + 32), y, Floor);
;
instance_create(((x + 160) + 32), y, Floor);
;
instance_create(((x + 96) + 32), (y - 32), Floor);
;
instance_create(((x + 128) + 32), (y - 32), Floor);
;
instance_create(((x + 160) + 32), (y - 32), Floor);
;
instance_create(((x + 96) + 32), (y + 32), Floor);
;
instance_create(((x + 128) + 32), (y + 32), Floor);
;
instance_create(((x + 160) + 32), (y + 32), Floor);
;
{ var __hm_with7 = scrHMInstances(instance_create(((x + 128) + 64), y, BigGenerator)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
image_xscale = (- 1);
hp = 60;
}
}
if(__hm_break9) break;
}}
instance_create(((x + 128) - 32), (y - 64), ThroneStatue);
}
}
direction = 90;
}

// Source areas/throne.area.gml:113; area_pop_enemies
function hm_areas_throne_area_gml_area_pop_enemies() {

}

// Source areas/throne.area.gml:116; area_pop_props
function hm_areas_throne_area_gml_area_pop_props() {

}

// Source areas/throne.area.gml:119; area_mapdata
function hm_areas_throne_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return [(_hml_lx + 9), 0];
;
}
