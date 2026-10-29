// Source areas/scorpionboss.area.gml:1; __load
function hm_areas_scorpionboss_area_gml___load() {
global.hm_module_vars[$ "area:scorpionboss"].sewersentrance = sprHM_areas_scorpionboss_area_2;
}

// Source areas/scorpionboss.area.gml:4; area_name
function hm_areas_scorpionboss_area_gml_area_name() {
return "1-5";
;
}

// Source areas/scorpionboss.area.gml:7; area_sprite
function hm_areas_scorpionboss_area_gml_area_sprite(_hml_q) {
switch (_hml_q) {
case sprFloor1:
return sprFloor1;
;
case sprFloor1B:
return sprFloor1B;
;
case sprFloor1Explo:
return sprFloor1Explo;
;
case sprWall1Trans:
return sprWall1Trans;
;
case sprWall1Bot:
return sprWall1Bot;
;
case sprWall1Out:
return sprWall1Out;
;
case sprWall1Top:
return sprWall1Top;
;
case sprDebris1:
return sprDebris1;
;
case sprDetail1:
return sprDetail1;
;
}
}

// Source areas/scorpionboss.area.gml:20; area_transit
function hm_areas_scorpionboss_area_gml_area_transit() {
if (((lastarea != scrHMAreaResolve("scorpionboss")) && (lastarea == scrHMAreaResolve("nightdesert")))) {
{
area = scrHMAreaResolve("scorpionboss");
;
}
}
}

// Source areas/scorpionboss.area.gml:25; area_finish
function hm_areas_scorpionboss_area_gml_area_finish() {
area = scrHMAreaResolve("sewersentrance");
;
subarea = 1;
;
}

// Source areas/scorpionboss.area.gml:29; area_setup
function hm_areas_scorpionboss_area_gml_area_setup() {
goal = 80;
;
background_set_colour(make_color_rgb(175, 143, 106));
;
BackCont.shadow_color = c_black;
;
TopCont.darkness = 0;
;
scrHMSpriteRestore(sprFloor1);
;
scrHMSpriteRestore(sprFloor1B);
;
scrHMSpriteRestore(sprFloor1Explo);
;
scrHMSpriteRestore(sprWall1Trans);
;
scrHMSpriteRestore(sprWall1Bot);
;
scrHMSpriteRestore(sprWall1Out);
;
scrHMSpriteRestore(sprWall1Top);
;
scrHMSpriteRestore(sprDebris1);
;
scrHMSpriteRestore(sprDetail1);
;
scrHMSpriteRestore(sprBones);
;
scrHMSpriteRestore(sprDesertTopDecal);
;
scrHMSoundAmbient(amb1);
;
}

// Source areas/scorpionboss.area.gml:47; area_start
function hm_areas_scorpionboss_area_gml_area_start() {
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
{ var __hm_with4 = scrHMInstances(RadChest), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
instance_change(Wind, 1);
}
}
if(__hm_break6) break;
}}
{ var __hm_with7 = scrHMInstances(Floor), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
if ((random(7) < 1)) {
{ var __hm_with10 = scrHMInstances(instance_create(x, y, TopDecalDesert)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
dir = choose((- 1), 1);
}
if(__hm_break12) break;
}}
}
}
if(__hm_break9) break;
}}
{ var __hm_with13 = scrHMAuthoredWalls105(), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
if (place_meeting((x + 16), y, Floor)) {
{ var __hm_with16 = scrHMInstances(instance_create((x + 16), y, Bones)), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
{
sprite_index = sprBones;
image_xscale = 1;
}
}
if(__hm_break18) break;
}}
} else {
if (place_meeting((x - 16), y, Floor)) {
{ var __hm_with19 = scrHMInstances(instance_create(x, y, Bones)), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
{
sprite_index = sprBones;
image_xscale = (- 1);
}
}
if(__hm_break21) break;
}}
}
}
}
}
if(__hm_break15) break;
}}
{ var __hm_with22 = scrHMInstances(instance_furthest(Player.x, Player.y, Floor)), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
{
{ var __hm_with25 = scrHMInstances(instance_create(x, y, CustomObject)), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
{
name = "sewersentrance";
sprite_index = global.hm_module_vars[$ "area:scorpionboss"].sewersentrance;
image_index = 0;
image_speed = (0) * timescale;
depth = 6;
}
}
if(__hm_break27) break;
}}
instance_create((x + 16), (y + 16), PortalClear);
scrHMModCall("mod", "scorpionboss", "scorpionboss_create", (x + 16), (y + 16));
;
}
}
if(__hm_break24) break;
}}
{ var __hm_with28 = scrHMInstances(Floor), __hm_break30=false;
for (var __hm_index29=0; __hm_index29<array_length(__hm_with28); ++__hm_index29) {
if(instance_exists(__hm_with28[__hm_index29])) with (__hm_with28[__hm_index29]) {
if (((((((! place_meeting(x, y, Player)) and (! place_meeting(x, y, enemy))) and (! place_meeting(x, y, RadChest))) and (! place_meeting(x, y, AmmoChest))) and (! place_meeting(x, y, WeaponChest))) and (! place_meeting(x, y, prop)))) {
{
if (((random(5) < 1) and (! place_meeting(x, y, NOWALLSHEREPLEASE)))) {
{
var _hml_myx = (x + choose(0, 16));
;
var _hml_myy = (y + choose(0, 16));
;
{ var __hm_with31 = scrHMInstances(instance_create(_hml_myx, _hml_myy, Wall)), __hm_break33=false;
for (var __hm_index32=0; __hm_index32<array_length(__hm_with31); ++__hm_index32) {
if(instance_exists(__hm_with31[__hm_index32])) with (__hm_with31[__hm_index32]) {
instance_create(x, y, NOWALLSHEREPLEASE);
}
if(__hm_break33) break;
}}
}
}
}
}
}
if(__hm_break30) break;
}}
}

// Source areas/scorpionboss.area.gml:92; area_make_floor
function hm_areas_scorpionboss_area_gml_area_make_floor() {
{ var __hm_with1 = scrHMInstances(GenCont), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
safespawn = 5;
}
if(__hm_break3) break;
}}
styleb = 0;
if ((! place_meeting(x, y, Floor))) {
instance_create(x, y, Floor);
}
if ((! place_meeting((x + 32), y, Floor))) {
instance_create((x + 32), y, Floor);
}
var _hml_turn = choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 90, 90, 90, (- 90), (- 90), (- 90), 180);
;
direction += _hml_turn;
;
if (((_hml_turn == 180) && (point_distance(x, y, 10016, 10016) > 48))) {
{
instance_create(x, y, Floor);
;
instance_create((x + 16), (y + 16), AmmoChest);
;
}
}
if ((random((19 + instance_number(FloorMaker))) > 22)) {
{
if ((point_distance(x, y, 10016, 10016) > 48)) {
{
instance_create(x, y, Floor);
;
instance_create((x + 32), y, Floor);
;
instance_create((x - 32), y, Floor);
;
instance_create(x, (y + 32), Floor);
;
instance_create(x, (y - 32), Floor);
;
}
}
instance_destroy();
;
}
} else {
if ((random(4) < 1)) {
{
{ var __hm_with4 = scrHMInstances(instance_create(x, y, FloorMaker)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
var __hm_other7=scrHMOther(other);
direction = (__hm_other7.direction + choose(90, (- 90)));
}
}
if(__hm_break6) break;
}}
}
}
}
}

// Source areas/scorpionboss.area.gml:127; area_pop_enemies
function hm_areas_scorpionboss_area_gml_area_pop_enemies() {

}

// Source areas/scorpionboss.area.gml:135; area_pop_props
function hm_areas_scorpionboss_area_gml_area_pop_props() {
if ((random(16) < 1)) {
instance_create((x + 16), (y + 16), Cactus);
}
if ((random(16) < 1)) {
instance_create((x + 16), (y + 16), BonePile);
}
if ((random(10) < 1)) {
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), Corpse)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if ((random(4) < 1)) {
{
sprite_index = sprBigMaggotDead;
;
image_xscale = choose((- 1), 1);
}
} else {
{
sprite_index = sprBanditDead;
;
image_xscale = choose((- 1), 1);
{ var __hm_with4 = scrHMInstances(instance_create(x, y, WepPickup)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
var _hml_weplist = ds_list_create();
;
scrHMWeaponList(_hml_weplist, 0, 2);
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
}
}
if(__hm_break3) break;
}}
}
}

// Source areas/scorpionboss.area.gml:156; area_mapdata
function hm_areas_scorpionboss_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return [_hml_lx, 0];
;
}
