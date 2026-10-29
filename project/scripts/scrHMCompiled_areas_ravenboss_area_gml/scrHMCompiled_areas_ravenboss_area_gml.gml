// Source areas/ravenboss.area.gml:1; __load
function hm_areas_ravenboss_area_gml___load() {
global.hm_module_vars[$ "area:ravenboss"].Fog4 = sprHM_areas_ravenboss_area_2;
}

// Source areas/ravenboss.area.gml:4; area_name
function hm_areas_ravenboss_area_gml_area_name() {
return "3-3";
;
}

// Source areas/ravenboss.area.gml:7; area_sprite
function hm_areas_ravenboss_area_gml_area_sprite(_hml_q) {
switch (_hml_q) {
case sprFloor1:
return sprFloor3;
;
case sprFloor1B:
return sprFloor3B;
;
case sprFloor1Explo:
return sprFloor3Explo;
;
case sprWall1Trans:
return sprWall3Trans;
;
case sprWall1Bot:
return sprWall3Bot;
;
case sprWall1Out:
return sprWall3Out;
;
case sprWall1Top:
return sprWall3Top;
;
case sprDebris1:
return sprDebris3;
;
case sprDetail1:
return sprDetail3;
;
}
}

// Source areas/ravenboss.area.gml:20; area_transit
function hm_areas_ravenboss_area_gml_area_transit() {
if ((((lastarea != scrHMAreaResolve("ravenboss")) && (lastarea == scrHMAreaResolve(3))) && (lastsubarea == 2))) {
{
area = scrHMAreaResolve("ravenboss");
;
}
}
}

// Source areas/ravenboss.area.gml:25; area_finish
function hm_areas_ravenboss_area_gml_area_finish() {
area = scrHMAreaResolve("junkyard");
;
subarea = 4;
;
}

// Source areas/ravenboss.area.gml:29; area_setup
function hm_areas_ravenboss_area_gml_area_setup() {
goal = 110;
;
background_set_colour(make_color_rgb(138, 150, 158));
;
BackCont.shadow_color = c_black;
;
TopCont.fog = global.hm_module_vars[$ "area:ravenboss"].Fog4;
TopCont.darkness = 0;
;
scrHMSoundAmbient(amb3);
;
}

// Source areas/ravenboss.area.gml:37; area_start
function hm_areas_ravenboss_area_gml_area_start() {
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((random(7) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create(x, y, TopDecalScrapyard)), __hm_break6=false;
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
if ((random(3) < 1)) {
{
if (place_meeting((x + 16), y, Floor)) {
{ var __hm_with10 = scrHMInstances(instance_create((x + 16), y, Bones)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
sprite_index = sprScrapDecal;
image_xscale = 1;
}
}
if(__hm_break12) break;
}}
} else {
if (place_meeting((x - 16), y, Floor)) {
{ var __hm_with13 = scrHMInstances(instance_create(x, y, Bones)), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
sprite_index = sprScrapDecal;
image_xscale = (- 1);
}
}
if(__hm_break15) break;
}}
}
}
}
}
}
if(__hm_break9) break;
}}
{ var __hm_with16 = scrHMInstances(instance_furthest(10016, 10016, Floor)), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
{
scrHMModCall("mod", "ravenboss", "wantravenboss_create", (x + 16), (y + 16));
;
}
}
if(__hm_break18) break;
}}
}

// Source areas/ravenboss.area.gml:58; area_make_floor
function hm_areas_ravenboss_area_gml_area_make_floor() {
styleb = 0;
if ((! place_meeting(x, y, Floor))) {
instance_create(x, y, Floor);
}
var _hml_turn = choose(0, 0, 0, 0, 0, 0, 90, (- 90), 180, 180, 180, 90, (- 90), 180);
;
direction += _hml_turn;
;
if (((_hml_turn == 180) && (point_distance(x, y, 10016, 10016) > 48))) {
{
if ((! place_meeting(x, y, Floor))) {
instance_create(x, y, Floor);
}
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
if ((! place_meeting(x, y, Floor))) {
instance_create(x, y, Floor);
}
}
}
instance_destroy();
;
}
} else {
if ((random(2) < 1)) {
{
instance_create(x, y, FloorMaker);
;
}
}
}
}

// Source areas/ravenboss.area.gml:80; area_pop_enemies
function hm_areas_ravenboss_area_gml_area_pop_enemies() {
instance_create((x + 16), (y + 16), Raven);
;
if ((random(8) < 1)) {
instance_create((x + 16), (y + 16), Sniper);
}
if ((random(20) < 1)) {
instance_create((x + 16), (y + 16), SnowBot);
}
if ((random(20) < 1)) {
instance_create((x + 16), (y + 16), Salamander);
}
if ((random(4) < 1)) {
instance_create((x + 16), (y + 16), Car);
}
}

// Source areas/ravenboss.area.gml:87; area_pop_props
function hm_areas_ravenboss_area_gml_area_pop_props() {
if ((random(4) < 1)) {
instance_create((x + 16), (y + 16), Tires);
}
}

// Source areas/ravenboss.area.gml:91; area_mapdata
function hm_areas_ravenboss_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return [_hml_lx, 0];
;
}
