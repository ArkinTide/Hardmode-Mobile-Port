// Source areas/elevator.area.gml:1; __load
function hm_areas_elevator_area_gml___load() {
global.hm_module_vars[$ "area:elevator"].nextarea = 1;
global.hm_module_vars[$ "area:elevator"].spawnthing = 0;
global.hm_module_vars[$ "area:elevator"].tvhurt = sprHM_areas_elevator_area_4;
global.hm_module_vars[$ "area:elevator"].tv1 = sprHM_areas_elevator_area_5;
global.hm_module_vars[$ "area:elevator"].tv2 = sprHM_areas_elevator_area_6;
}

// Source areas/elevator.area.gml:8; area_name
function hm_areas_elevator_area_gml_area_name() {
return "6-3";
;
}

// Source areas/elevator.area.gml:11; area_sprite
function hm_areas_elevator_area_gml_area_sprite(_hml_q) {
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

// Source areas/elevator.area.gml:24; area_transit
function hm_areas_elevator_area_gml_area_transit() {
if ((((lastarea != scrHMAreaResolve("elevator")) && (lastarea == scrHMAreaResolve("labs"))) && (lastsubarea >= 2))) {
{
area = scrHMAreaResolve("elevator");
;
}
}
}

// Source areas/elevator.area.gml:29; area_finish
function hm_areas_elevator_area_gml_area_finish() {
if ((global.hm_module_vars[$ "area:elevator"].nextarea == 0)) {
{
area = scrHMAreaResolve("HQ");
;
subarea = 1;
;
}
} else {
if ((global.hm_module_vars[$ "area:elevator"].nextarea == 1)) {
{
area = scrHMAreaResolve("palace");
;
subarea = 1;
;
}
}
}
}

// Source areas/elevator.area.gml:39; area_setup
function hm_areas_elevator_area_gml_area_setup() {
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
global.hm_module_vars[$ "area:elevator"].spawnthing = 0;
}

// Source areas/elevator.area.gml:47; area_start
function hm_areas_elevator_area_gml_area_start() {
global.hm_module_vars[$ "area:elevator"].nextarea = 1;
{ var __hm_with1 = scrHMInstances(instance_create(0, 0, CustomEnemy)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "portalblocker";
canfly = 1;
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(Floor), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if ((global.hm_module_vars[$ "area:elevator"].spawnthing == 0)) {
if ((! collision_rectangle(((x + 16) - 96), ((y + 16) - 96), ((x + 16) + 96), ((y + 16) + 128), Wall, 1, 1))) {
{
{ var __hm_with7 = scrHMInstances(instance_create((x + 16), (y + 32), Effect)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
sprite_index = sprPopoPortal;
image_speed = (0.4) * timescale;
image_yscale = (- 1);
depth = 1;
{ var __hm_with10 = scrHMInstances(instance_create(x, (y - 140), BigTV)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
hp += 4000;
spr_tv1 = global.hm_module_vars[$ "area:elevator"].tv1;
spr_tv2 = global.hm_module_vars[$ "area:elevator"].tv2;
spr_idle = spr_tv1;
spr_hurt = global.hm_module_vars[$ "area:elevator"].tvhurt;
}
}
if(__hm_break12) break;
}}
scrHMModCall("mod", "props", "elevator_create", x, (y + 1));
;
scrHMModCall("mod", "props", "terminal_create", x, (y - 96));
;
instance_create((x - 32), (y - 96), Server);
instance_create((x + 32), (y - 96), Server);
scrHMModCall("mod", "enemies", "enemyrogue_create", x, (y - 78));
;
instance_create((x - 64), (y + 16), Server);
instance_create((x - 64), (y - 16), Server);
instance_create((x + 64), (y + 16), Server);
instance_create((x + 64), (y - 16), Server);
if ((random(2) < 1)) {
scrHMModCall("mod", "props", "bigtube1_create", (x + 96), (y + 32));
} else {
scrHMModCall("mod", "props", "bigtube2_create", (x + 96), (y + 32));
}
;
if ((random(2) < 1)) {
scrHMModCall("mod", "props", "bigtube1_create", (x - 96), (y + 32));
} else {
scrHMModCall("mod", "props", "bigtube2_create", (x - 96), (y + 32));
}
;
scrHMModCall("mod", "props", "bigtube1_create", (x + 96), y);
;
if ((random(2) < 1)) {
scrHMModCall("mod", "props", "bigtube1_create", (x - 96), y);
} else {
scrHMModCall("mod", "props", "bigtube2_create", (x - 96), y);
}
;
if ((random(2) < 1)) {
scrHMModCall("mod", "props", "bigtube1_create", (x + 96), (y - 32));
} else {
scrHMModCall("mod", "props", "bigtube2_create", (x + 96), (y - 32));
}
;
if ((random(2) < 1)) {
scrHMModCall("mod", "props", "bigtube1_create", (x - 96), (y - 32));
} else {
scrHMModCall("mod", "props", "bigtube2_create", (x - 96), (y - 32));
}
;
}
}
if(__hm_break9) break;
}}
global.hm_module_vars[$ "area:elevator"].spawnthing = 1;
}
}
}
}
if(__hm_break6) break;
}}
{ var __hm_with13 = scrHMInstances(Floor), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
if ((((distance_to_object(Effect) > 96) and (distance_to_object(hitme) > 32)) and (distance_to_object(prop) > 32))) {
{
if ((random(24) < 1)) {
instance_create((x + 16), (y + 16), Terminal);
}
if ((random(48) < 1)) {
instance_create((x + 16), (y + 16), MutantTube);
}
if ((random(48) < 11)) {
{
if ((random(2) < 1)) {
scrHMModCall("mod", "props", "bigtube1_create", (x + 16), (y + 16));
} else {
scrHMModCall("mod", "props", "bigtube2_create", (x + 16), (y + 16));
}
;
}
}
if ((random(48) < 1)) {
instance_create((x + 16), (y + 16), Tube);
}
}
}
}
if(__hm_break15) break;
}}
{ var __hm_with16 = scrHMAuthoredWalls105(), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
if (((((distance_to_object(Effect) > 96) and (distance_to_point(10016, 10016) > 64)) and (distance_to_object(hitme) > 32)) and (distance_to_object(prop) > 32))) {
{
if ((random(100) < 1)) {
{
if ((random(2) < 1)) {
scrHMModCall("mod", "props", "bigtube1_create", (x + 8), (y + 8));
} else {
scrHMModCall("mod", "props", "bigtube2_create", (x + 8), (y + 8));
}
;
{ var __hm_with19 = scrHMInstances(instance_create((x + 8), (y + 8), PortalClear)), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
image_xscale = 0.5;
}
if(__hm_break21) break;
}}
image_yscale = 0.5;
}
}
}
}
}
if(__hm_break18) break;
}}
{ var __hm_with22 = scrHMAuthoredWalls105(), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
depth = (0 - (y / 10016));
}
if(__hm_break24) break;
}}
{ var __hm_with25 = scrHMMatching(CustomHitme, "name", "bigtube1", "bigtube2"), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
depth = (0 - (y / 10016));
}
if(__hm_break27) break;
}}
{ var __hm_with28 = scrHMInstances(prop), __hm_break30=false;
for (var __hm_index29=0; __hm_index29<array_length(__hm_with28); ++__hm_index29) {
if(instance_exists(__hm_with28[__hm_index29])) with (__hm_with28[__hm_index29]) {
depth = (0 - (y / 10016));
}
if(__hm_break30) break;
}}
}

// Source areas/elevator.area.gml:116; area_make_floor
function hm_areas_elevator_area_gml_area_make_floor() {
{ var __hm_with1 = scrHMInstances(GenCont), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
safespawn = 4;
}
if(__hm_break3) break;
}}
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
if (((instance_number(Floor) > 60) and (!scrHMVariableExists(id, "build")))) {
{
var _hml_f_ = 0;
;
instance_create(x, y, Floor);
;
repeat (8) {
instance_create(x, (y + _hml_f_), Floor);
;
instance_create((x + 32), (y + _hml_f_), Floor);
;
instance_create((x + 64), (y + _hml_f_), Floor);
;
instance_create((x + 96), (y + _hml_f_), Floor);
;
instance_create((x - 32), (y + _hml_f_), Floor);
;
instance_create((x - 64), (y + _hml_f_), Floor);
;
instance_create((x - 96), (y + _hml_f_), Floor);
;
_hml_f_ -= 32;
;
}
build = 1;
}
}
if ((random((21 + instance_number(FloorMaker))) > 22)) {
{
if ((point_distance(x, y, 10016, 10016) > 48)) {
{
{ var __hm_with4 = scrHMInstances(instance_create((x + 16), (y + 16), AmmoChest)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
friction = (30) * (timescale * timescale);
}
if(__hm_break6) break;
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

// Source areas/elevator.area.gml:178; area_pop_enemies
function hm_areas_elevator_area_gml_area_pop_enemies() {
if ((random(32) < 1)) {
instance_create((x + 16), (y + 16), Necromancer);
}
if ((random(32) < 1)) {
instance_create((x + 16), (y + 16), Grunt);
}
}

// Source areas/elevator.area.gml:183; area_mapdata
function hm_areas_elevator_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return [_hml_lx, 0];
;
}
