// Source areas/junkyard.area.gml:1; __load
function hm_areas_junkyard_area_gml___load() {

}

// Source areas/junkyard.area.gml:1; area_name
function hm_areas_junkyard_area_gml_area_name() {
return ("3-" + string(GameCont.subarea));
;
}

// Source areas/junkyard.area.gml:4; area_sprite
function hm_areas_junkyard_area_gml_area_sprite(_hml_q) {
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

// Source areas/junkyard.area.gml:17; area_transit
function hm_areas_junkyard_area_gml_area_transit() {
if (((lastarea != scrHMAreaResolve("junkyard")) && (lastarea == scrHMAreaResolve("ravenboss")))) {
{
area = scrHMAreaResolve("junkyard");
;
}
}
}

// Source areas/junkyard.area.gml:22; area_finish
function hm_areas_junkyard_area_gml_area_finish() {
if ((subarea == 5)) {
{
if (((Player.curse == 0) and (Player.bcurse == 0))) {
area = scrHMAreaResolve("caves");
} else {
area = scrHMAreaResolve("cavesinv");
}
subarea = 1;
;
}
} else {
subarea += 1;
}
}

// Source areas/junkyard.area.gml:31; area_setup
function hm_areas_junkyard_area_gml_area_setup() {
scrHMSoundMusic(mus3b);
;
scrHMSoundAmbient(amb3);
;
goal = 110;
;
background_set_colour(make_color_rgb(138, 150, 158));
;
BackCont.shadow_color = c_black;
;
TopCont.darkness = 0;
;
}

// Source areas/junkyard.area.gml:39; area_start
function hm_areas_junkyard_area_gml_area_start() {
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((random(2) < 1)) {
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
if ((random(3) > 1)) {
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
if ((GameCont.subarea == 4)) {
{
{ var __hm_with16 = scrHMInstances(Floor), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
if (((((((! place_meeting(x, y, Player)) and (! place_meeting(x, y, enemy))) and (! place_meeting(x, y, RadChest))) and (! place_meeting(x, y, AmmoChest))) and (! place_meeting(x, y, WeaponChest))) and (! place_meeting(x, y, prop)))) {
{
if (((random(5) < 1) and (! place_meeting(x, y, NOWALLSHEREPLEASE)))) {
{
var _hml_myx = (x + choose(0, 16));
;
var _hml_myy = (y + choose(0, 16));
;
{ var __hm_with19 = scrHMInstances(instance_create(_hml_myx, _hml_myy, Wall)), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
instance_create(x, y, NOWALLSHEREPLEASE);
}
if(__hm_break21) break;
}}
if (((random(7) < 1) and (point_distance(_hml_myx, _hml_myy, Player.x, Player.y) > 90))) {
instance_create(_hml_myx, _hml_myy, Trap);
}
}
}
}
}
}
if(__hm_break18) break;
}}
}
} else {
if ((GameCont.subarea == 5)) {
{
var _hml__floor = instance_furthest(10016, 10016, Floor);
;
{ var __hm_with22 = scrHMInstances(instance_nearest((((((_hml__floor.x * 2) + 10016) / 3) + random(128)) - 64), (((((_hml__floor.y * 2) + 10016) / 3) + random(128)) - 64), Floor)), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
instance_create(x, y, BecomeScrapBoss);
}
if(__hm_break24) break;
}}
{ var __hm_with25 = scrHMInstances(Floor), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
if (((((((! place_meeting(x, y, Player)) and (! place_meeting(x, y, enemy))) and (! place_meeting(x, y, RadChest))) and (! place_meeting(x, y, AmmoChest))) and (! place_meeting(x, y, WeaponChest))) and (! place_meeting(x, y, prop)))) {
{
if (((random(20) < 1) and (! place_meeting(x, y, NOWALLSHEREPLEASE)))) {
{
var _hml_myx = (x + choose(0, 16));
;
var _hml_myy = (y + choose(0, 16));
;
{ var __hm_with28 = scrHMInstances(instance_create(_hml_myx, _hml_myy, Wall)), __hm_break30=false;
for (var __hm_index29=0; __hm_index29<array_length(__hm_with28); ++__hm_index29) {
if(instance_exists(__hm_with28[__hm_index29])) with (__hm_with28[__hm_index29]) {
instance_create(x, y, NOWALLSHEREPLEASE);
}
if(__hm_break30) break;
}}
if (((random(7) < 1) and (point_distance(_hml_myx, _hml_myy, Player.x, Player.y) > 64))) {
instance_create(_hml_myx, _hml_myy, Trap);
}
}
}
}
}
}
if(__hm_break27) break;
}}
}
}
}
{ var __hm_with31 = scrHMMatching(Floor, "sprite_index", sprFloor3B), __hm_break33=false;
for (var __hm_index32=0; __hm_index32<array_length(__hm_with31); ++__hm_index32) {
if(instance_exists(__hm_with31[__hm_index32])) with (__hm_with31[__hm_index32]) {
depth -= 1;
}
if(__hm_break33) break;
}}

scrHMPrepareJunkyard107();
}

// Source areas/junkyard.area.gml:91; area_make_floor
function hm_areas_junkyard_area_gml_area_make_floor() {
if ((GameCont.subarea == 4)) {
{
if ((random(8) < 1)) {
{
instance_create(x, y, Floor);
instance_create((x + 32), y, Floor);
instance_create((x + 32), (y + 32), Floor);
instance_create(x, (y + 32), Floor);
instance_create(x, (y - 32), Floor);
instance_create((x - 32), y, Floor);
instance_create((x + 32), (y - 32), Floor);
instance_create((x - 32), (y - 32), Floor);
instance_create((x - 32), (y + 32), Floor);
}
} else {
instance_create(x, y, Floor);
}
var _hml_turn = choose(0, 0, 0, 0, 90, (- 90));
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
if ((random(25) < 1)) {
{
instance_create(x, y, FloorMaker);
;
}
}
}
}
} else {
if ((GameCont.subarea == 5)) {
{
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
}
}
}

// Source areas/junkyard.area.gml:145; area_pop_enemies
function hm_areas_junkyard_area_gml_area_pop_enemies() {
if ((random(4) < 1)) {
instance_create((x + 16), (y + 16), SnowBot);
}
if ((random(20) < 1)) {
instance_create((x + 16), (y + 16), Jock);
}
if ((random(8) < 1)) {
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), Sniper)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((random(6) < 1)) {
instance_create(x, y, Salamander);
}
}
if(__hm_break3) break;
}}
}
if ((random(20) < 1)) {
instance_create((x + 16), (y + 16), Salamander);
}
if ((random(4) < 1)) {
instance_create((x + 16), (y + 16), Car);
}
if ((random(16) < 1)) {
instance_create((x + 16), (y + 16), Barrel);
}
}

// Source areas/junkyard.area.gml:154; area_pop_props
function hm_areas_junkyard_area_gml_area_pop_props() {
if ((random(4) < 1)) {
instance_create((x + 16), (y + 16), Tires);
}
}

// Source areas/junkyard.area.gml:158; area_mapdata
function hm_areas_junkyard_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return [_hml_lx, 0];
;
}
