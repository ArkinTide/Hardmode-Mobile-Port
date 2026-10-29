// Source areas/labs.area.gml:1; __load
function hm_areas_labs_area_gml___load() {

}

// Source areas/labs.area.gml:1; area_name
function hm_areas_labs_area_gml_area_name() {
return ("6-" + string(GameCont.subarea));
;
}

// Source areas/labs.area.gml:4; area_sprite
function hm_areas_labs_area_gml_area_sprite(_hml_q) {
switch (_hml_q) {
case sprFloor1:
return sprFloor6;
;
case sprFloor1B:
return sprFloor6B;
;
case sprFloor1Explo:
return sprFloor6Explo;
;
case sprWall1Trans:
return sprWall6Trans;
;
case sprWall1Bot:
return sprWall6Bot;
;
case sprWall1Out:
return sprWall6Out;
;
case sprWall1Top:
return sprWall6Top;
;
case sprDebris1:
return sprDebris6;
;
case sprDetail1:
return sprDetail6;
;
}
}

// Source areas/labs.area.gml:17; area_transit
function hm_areas_labs_area_gml_area_transit() {
if ((((lastarea != scrHMAreaResolve("labs")) && (lastarea == scrHMAreaResolve("city"))) && (lastsubarea == 5))) {
{
area = scrHMAreaResolve("labs");
;
subarea = 1;
;
}
}
}

// Source areas/labs.area.gml:23; area_finish
function hm_areas_labs_area_gml_area_finish() {
if ((subarea == 1)) {
{
area = scrHMAreaResolve("labs");
;
subarea += 1;
;
}
} else {
if ((subarea >= 2)) {
{
area = scrHMAreaResolve("elevator");
;
subarea = 3;
;
}
}
}
}

// Source areas/labs.area.gml:33; area_setup
function hm_areas_labs_area_gml_area_setup() {
scrHMSoundMusic(mus6);
scrHMSoundAmbient(amb6);
;
goal = 110;
;
background_set_colour(make_color_rgb(9, 28, 32));
;
BackCont.shadow_color = c_black;
;
TopCont.darkness = 1;
;
}

// Source areas/labs.area.gml:41; area_start
function hm_areas_labs_area_gml_area_start() {
var _hml__floor = instance_furthest(10016, 10016, Floor);
;
{ var __hm_with1 = scrHMInstances(instance_nearest(((((_hml__floor.x * 2) + 10016) / 3) + random_range((- 60), 60)), ((((_hml__floor.y * 2) + 10016) / 3) + random_range((- 60), 60)), Floor)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
instance_create((x + 16), (y + 16), TechnoMancer);
instance_create(x, y, PortalClear);
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(enemy), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if (((distance_to_point(10016, 10016) > 160) and (distance_to_object(TechnoMancer) > 160))) {
{
instance_create(x, y, TechnoMancer);
instance_create(x, y, PortalClear);
}
}
}
if(__hm_break6) break;
}}
{ var __hm_with7 = scrHMMatchingNE(chestprop, "object_index", IDPDChest), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
instance_create(x, y, IDPDChest);
instance_change(Wind, 0);
instance_destroy();
}
}
if(__hm_break9) break;
}}
{ var __hm_with10 = scrHMAuthoredWalls105(), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
if ((((distance_to_point(10016, 10016) > 64) and (distance_to_object(hitme) > 32)) and (distance_to_object(prop) > 32))) {
{
if ((random(100) < 1)) {
{
if ((random(2) < 1)) {
scrHMModCall("mod", "props", "bigtube1_create", (x + 8), (y + 8));
} else {
scrHMModCall("mod", "props", "bigtube2_create", (x + 8), (y + 8));
}
;
{ var __hm_with13 = scrHMInstances(instance_create((x + 8), (y + 8), PortalClear)), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
image_xscale = 0.5;
}
if(__hm_break15) break;
}}
image_yscale = 0.5;
}
}
}
}
}
if(__hm_break12) break;
}}
}

// Source areas/labs.area.gml:69; area_make_floor
function hm_areas_labs_area_gml_area_make_floor() {
var _hml_turn = choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 90, 90, 90, (- 90), 180);
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
if ((((abs(_hml_turn) == 90) and (GameCont.area == scrHMAreaResolve(6))) and (random(2) < 1))) {
{
instance_create((x + 32), y, Floor);
instance_create((x + 32), (y + 32), Floor);
instance_create(x, (y + 32), Floor);
instance_create(x, (y - 32), Floor);
instance_create((x - 32), y, Floor);
instance_create((x + 32), (y - 32), Floor);
instance_create((x - 32), (y - 32), Floor);
instance_create((x - 32), (y + 32), Floor);
if ((random(3) < 1)) {
{
if ((random(4) < 3)) {
instance_create((x - 16), (y - 16), Server);
}
if ((random(4) < 3)) {
instance_create(((x - 16) + 64), (y - 16), Server);
}
if ((random(4) < 3)) {
instance_create((x - 16), ((y - 16) + 64), Server);
}
if ((random(4) < 3)) {
instance_create(((x - 16) + 64), ((y - 16) + 64), Server);
}
}
}
}
} else {
instance_create(x, y, Floor);
}
if ((random(20) < 1)) {
instance_create(x, y, FloorMaker);
}
if ((random((21 + instance_number(FloorMaker))) > 22)) {
{
if ((point_distance(x, y, 10016, 10016) > 48)) {
{
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), AmmoChest)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
friction = (30) * (timescale * timescale);
}
if(__hm_break3) break;
}}
instance_create(x, y, Floor);
;
}
}
instance_destroy();
;
}
}
}

// Source areas/labs.area.gml:113; area_pop_enemies
function hm_areas_labs_area_gml_area_pop_enemies() {
if ((random(14) < 1)) {
repeat (10) instance_create((x + 16), (y + 16), Freak);
}
if ((random(14) < 1)) {
instance_create((x + 16), (y + 16), RhinoFreak);
}
if ((random(14) < 1)) {
instance_create((x + 16), (y + 16), Necromancer);
}
if ((random(14) < 1)) {
instance_create((x + 16), (y + 16), ExploFreak);
}
}

// Source areas/labs.area.gml:119; area_pop_props
function hm_areas_labs_area_gml_area_pop_props() {
if ((random(24) < 1)) {
instance_create((x + 16), (y + 16), Server);
} else {
if ((random(48) < 1)) {
{
if ((random(2) < 1)) {
scrHMModCall("mod", "props", "bigtube_create", (x + 16), (y + 16));
} else {
if ((random(2) < 1)) {
scrHMModCall("mod", "props", "bigtube2_create", (x + 16), (y + 16));
}
}
instance_create((x + 16), (y + 16), MutantTube);
;
}
} else {
if ((random(48) < 1)) {
instance_create((x + 16), (y + 16), Tube);
}
}
}
}

// Source areas/labs.area.gml:128; area_mapdata
function hm_areas_labs_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
if ((_hml_lp == "city")) {
return [(_hml_lx + 18), 0];
} else {
return [_hml_lx, 0];
}
;
}
