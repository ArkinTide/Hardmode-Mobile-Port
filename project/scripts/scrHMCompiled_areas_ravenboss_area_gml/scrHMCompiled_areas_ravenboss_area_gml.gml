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



// Source areas/ravenboss.area.gml:0; area_transit (native content 1.1.0)
function hm_areas_ravenboss_area_gml_area_transit() {
if ((scrHMVariableExists(GameCont, "hm_debug_pending") && GameCont.hm_debug_pending)) {
{
area = scrHMAreaResolve(GameCont.hm_debug_area);
;
subarea = GameCont.hm_debug_sub;
;
return;
;
}
}
scrHMCrownWatch1103();
if (((scrHMVariableExists(GameCont, "hm_crown_exit_ready") && GameCont.hm_crown_exit_ready) && (area != scrHMAreaResolve(100)))) {
{
area = scrHMAreaResolve("throne");
;
subarea = 1;
;
GameCont.hm_destination = "throne";
;
return;
;
}
}
if ((area == scrHMAreaResolve(100))) {
return;
}
if ((scrHMVariableExists(GameCont, "hm_destination") && (GameCont.hm_destination != ""))) {
{
area = scrHMAreaResolve(GameCont.hm_destination);
;
return;
;
}
}
if ((((lastarea != scrHMAreaResolve("ravenboss")) && ((lastarea == scrHMAreaResolve(3)) || (lastarea == scrHMAreaResolve("junkyard")))) && (lastsubarea == 2))) {
{
area = scrHMAreaResolve("ravenboss");
;
}
}
}

// Source areas/ravenboss.area.gml:0; area_finish (native content 1.1.0)
function hm_areas_ravenboss_area_gml_area_finish() {
if ((scrHMVariableExists(GameCont, "hm_debug_pending") && GameCont.hm_debug_pending)) {
{
area = scrHMAreaResolve(GameCont.hm_debug_area);
;
subarea = GameCont.hm_debug_sub;
;
return;
;
}
}
area = scrHMAreaResolve("junkyard");
;
subarea = 4;
;
}

// Source areas/ravenboss.area.gml:0; area_setup (native content 1.1.0)
function hm_areas_ravenboss_area_gml_area_setup() {
GameCont.hm_destination = "";
;
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
hm_arkintide_mod_gml_hm_map_budget();
;
}

// Source areas/ravenboss.area.gml:0; area_start (native content 1.1.0)
function hm_areas_ravenboss_area_gml_area_start() {
hm_arkintide_mod_gml_hm_native_unlock_area();
;
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



// Source areas/ravenboss.area.gml:0; area_pop_enemies (native content 1.1.0)
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
hm_arkintide_mod_gml_hm_loop_population(3);
;
}

// Source areas/ravenboss.area.gml:87; area_pop_props

function hm_areas_ravenboss_area_gml_area_pop_props() {

if ((random(4) < 1)) {

instance_create((x + 16), (y + 16), Tires);

}

}



// Source areas/ravenboss.area.gml:0; area_mapdata (native content 1.1.0)
function hm_areas_ravenboss_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return hm_arkintide_mod_gml_hm_mapdata("ravenboss", _hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll);
;
}

