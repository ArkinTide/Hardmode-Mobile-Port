// Source areas/turtles.area.gml:1; __load
function hm_areas_turtles_area_gml___load() {
global.hm_module_vars[$ "area:turtles"].pizzasewersentrance = sprHM_areas_turtles_area_2;
global.hm_module_vars[$ "area:turtles"].pizzaHPchest = sprHM_areas_turtles_area_3;
}

// Source areas/turtles.area.gml:5; area_name
function hm_areas_turtles_area_gml_area_name() {
return "2-?";
;
}

// Source areas/turtles.area.gml:8; area_sprite
function hm_areas_turtles_area_gml_area_sprite(_hml_q) {
switch (_hml_q) {
case sprFloor1:
return sprFloor102;
;
case sprFloor1B:
return sprFloor102B;
;
case sprFloor1Explo:
return sprFloor102Explo;
;
case sprWall1Trans:
return sprWall102Trans;
;
case sprWall1Bot:
return sprWall102Bot;
;
case sprWall1Out:
return sprWall102Out;
;
case sprWall1Top:
return sprWall102Top;
;
case sprDebris1:
return sprDebris102;
;
case sprDetail1:
return sprDetail102;
;
}
}

// Source areas/turtles.area.gml:21; area_transit
function hm_areas_turtles_area_gml_area_transit() {
if (((lastarea != scrHMAreaResolve("turtles")) && (area == scrHMAreaResolve(102)))) {
{
area = scrHMAreaResolve("turtles");
;
}
}
}

// Source areas/turtles.area.gml:25; area_finish
function hm_areas_turtles_area_gml_area_finish() {
area = scrHMAreaResolve("sewers");
;
subarea = 3;
;
lastarea = scrHMAreaResolve("turtles");
scrHMSoundStop(sndFishTB);
}

// Source areas/turtles.area.gml:32; area_setup
function hm_areas_turtles_area_gml_area_setup() {
goal = 50;
;
background_set_colour(make_color_rgb(160, 75, 90));
;
BackCont.shadow_color = 1179657;
;
TopCont.fog = sprFog102;
;
TopCont.darkness = 1;
;
scrHMSoundMusic(mus102);
;
scrHMSoundAmbient(amb102);
;
}

// Source areas/turtles.area.gml:41; area_start
function hm_areas_turtles_area_gml_area_start() {
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((random(7) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create(x, y, TopDecalPizzaSewers)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
dir = choose((- 1), 1);
}
if(__hm_break6) break;
}}
}
}
if(__hm_break3) break;
}}
{ var __hm_with7 = scrHMAuthoredWalls105(), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
if ((place_meeting((x + 16), y, Floor) and place_meeting((x + 48), y, Wall))) {
{
{ var __hm_with10 = scrHMInstances(instance_create((x + 16), (y + 2), Bones)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
sprite_index = sprPizzaSewerDecal;
image_xscale = 1;
}
}
if(__hm_break12) break;
}}
{ var __hm_with13 = scrHMInstances(instance_create((x + 48), (y + 2), Bones)), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
sprite_index = sprPizzaSewerDecal;
image_xscale = (- 1);
}
}
if(__hm_break15) break;
}}
}
}
}
if(__hm_break9) break;
}}
var _hml__floor = instance_furthest(10016, 10016, Floor);
;
{ var __hm_with16 = scrHMInstances(instance_nearest((((((_hml__floor.x * 2) + 10016) / 3) + random(128)) - 64), (((((_hml__floor.y * 2) + 10016) / 3) + random(128)) - 64), Floor)), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
{
scrHMModCall("mod", "turtles", "turtle1_create", (x + 16), (y + 16));
;
scrHMModCall("mod", "turtles", "turtle2_create", (x + 16), (y + 16));
;
scrHMModCall("mod", "turtles", "turtle3_create", (x + 16), (y + 16));
;
scrHMModCall("mod", "turtles", "turtle4_create", (x + 16), (y + 16));
;
instance_create((x + 16), (y + 16), Rat);
;
}
}
if(__hm_break18) break;
}}
{ var __hm_with19 = scrHMInstances(_hml__floor), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
{ var __hm_with22 = scrHMInstances(instance_create((x + 16), (y + 16), TV)), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
{
hp += 40;
{ var __hm_with25 = scrHMInstances(instance_create(x, y, HealthChest)), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
{
sprite_index = global.hm_module_vars[$ "area:turtles"].pizzaHPchest;
spr_dead = sprPizzaBoxDead;
}
}
if(__hm_break27) break;
}}
instance_create(x, y, AmmoChest);
}
}
if(__hm_break24) break;
}}
}
if(__hm_break21) break;
}}
}

// Source areas/turtles.area.gml:74; area_make_floor
function hm_areas_turtles_area_gml_area_make_floor() {
instance_create(x, y, Floor);
;
var _hml_turn = choose(180, 0, 0, 0, 0, 0, 0, 90, 90, 90, (- 90), (- 90), (- 90), 180);
;
direction += _hml_turn;
;
if (((_hml_turn == 180) && (point_distance(x, y, 10016, 10016) > 48))) {
{
instance_create(x, y, Floor);
;
instance_create((x + 16), (y + 16), WeaponChest);
;
}
}
if ((random((19 + instance_number(FloorMaker))) > 22)) {
{
if ((point_distance(x, y, 10016, 10016) > 48)) {
{
instance_create((x + 16), (y + 16), AmmoChest);
;
instance_create(x, y, Floor);
;
}
}
instance_destroy();
;
}
} else {
if ((random(6) < 1)) {
{
instance_create(x, y, FloorMaker);
;
}
}
}
}

// Source areas/turtles.area.gml:95; area_pop_props
function hm_areas_turtles_area_gml_area_pop_props() {
if ((random(12) < 1)) {
instance_create((x + 16), (y + 16), PizzaBox);
}
}

// Source areas/turtles.area.gml:98; area_mapdata
function hm_areas_turtles_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return [_hml_lx, (- 9), 1, 1, 1];
;
}
