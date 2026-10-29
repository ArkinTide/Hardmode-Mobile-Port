// Source areas/HQ.area.gml:1; __load
function hm_areas_HQ_area_gml___load() {

}

// Source areas/HQ.area.gml:1; area_name
function hm_areas_HQ_area_gml_area_name() {
return ("HQ" + string(GameCont.subarea));
;
}

// Source areas/HQ.area.gml:4; area_sprite
function hm_areas_HQ_area_gml_area_sprite(_hml_q) {
switch (_hml_q) {
case sprFloor1:
return sprFloor106;
;
case sprFloor1B:
return sprFloor106B;
;
case sprFloor1Explo:
return sprFloor106Explo;
;
case sprWall1Trans:
return sprWall106Trans;
;
case sprWall1Bot:
return sprWall106Bot;
;
case sprWall1Out:
return sprWall106Out;
;
case sprWall1Top:
return sprWall106Top;
;
case sprDebris1:
return sprDebris106;
;
}
}

// Source areas/HQ.area.gml:16; area_transit
function hm_areas_HQ_area_gml_area_transit() {
if (((lastarea != scrHMAreaResolve("HQ")) && (lastarea == scrHMAreaResolve("idpd")))) {
{
area = scrHMAreaResolve("HQ");
;
hard = 22;
subarea = 1;
;
}
}
}

// Source areas/HQ.area.gml:23; area_finish
function hm_areas_HQ_area_gml_area_finish() {
if ((subarea < 4)) {
{
area = scrHMAreaResolve("HQ");
;
subarea += 1;
;
}
} else {
{
area = scrHMAreaResolve(106);
;
subarea = 3;
;
}
}
}

// Source areas/HQ.area.gml:33; area_setup
function hm_areas_HQ_area_gml_area_setup() {
scrHMSoundMusic(mus106);
;
scrHMSoundAmbient(amb106);
;
{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((race == scrHMRaceResolve("rogue"))) {
scrHMSoundMusic(mus106b);
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(GenCont), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
safespawn = 2;
}
if(__hm_break6) break;
}}
goal = (30 + (GameCont.subarea * 3));
;
background_set_colour(make_color_rgb(245, 250, 251));
;
BackCont.shadow_color = 9184256;
;
}

// Source areas/HQ.area.gml:43; area_start
function hm_areas_HQ_area_gml_area_start() {
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((random(7) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create(x, y, TopPot)), __hm_break6=false;
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
{ var __hm_with7 = scrHMInstances(Floor), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
if (((((((! place_meeting(x, y, Player)) and (! place_meeting(x, y, enemy))) and (! place_meeting(x, y, RadChest))) and (! place_meeting(x, y, AmmoChest))) and (! place_meeting(x, y, WeaponChest))) and (! place_meeting(x, y, prop)))) {
{
if (((random(12) < 1) and (! place_meeting(x, y, NOWALLSHEREPLEASE)))) {
{
var _hml_myx = (x + choose(0, 16));
;
var _hml_myy = (y + choose(0, 16));
;
{ var __hm_with10 = scrHMInstances(instance_create(_hml_myx, _hml_myy, Wall)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
instance_create(x, y, NOWALLSHEREPLEASE);
}
if(__hm_break12) break;
}}
}
}
}
}
}
if(__hm_break9) break;
}}
}

// Source areas/HQ.area.gml:59; area_make_floor
function hm_areas_HQ_area_gml_area_make_floor() {
var _hml_turn = choose(0, 0, 0, 0, 0, 90);
;
var _hml_styb = choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 1);
if ((_hml_styb == 1)) {
{
if ((styleb == 0)) {
styleb = 1;
} else {
styleb = 0;
}
}
}
direction += _hml_turn;
;
if (((abs(_hml_turn) == 90) && (point_distance(x, y, 10016, 10016) > 48))) {
{
instance_create(x, y, Floor);
;
instance_create((x - 32), y, Floor);
;
instance_create((x - 32), (y - 32), Floor);
;
instance_create(x, (y - 32), Floor);
;
instance_create((x + 32), y, Floor);
;
instance_create((x + 32), (y - 32), Floor);
;
instance_create((x + 32), (y + 32), Floor);
;
instance_create(x, (y + 32), Floor);
;
instance_create((x - 32), (y + 32), Floor);
;
instance_create((x + 16), (y + 16), WeaponChest);
;
}
} else {
instance_create(x, y, Floor);
}
if ((random(6) < 1)) {
{ var __hm_with1 = scrHMInstances(instance_create(x, y, FloorMaker)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
var __hm_other4=scrHMOther(other);
direction = (__hm_other4.direction + choose((- 90), 90));
}
if(__hm_break3) break;
}}
}
if ((random((12 + instance_number(FloorMaker))) > 14)) {
{
if ((point_distance(x, y, 10016, 10016) > 48)) {
{
instance_create((x + 16), (y + 16), AmmoChest);
;
instance_create(x, y, Floor);
;
instance_create((x - 32), y, Floor);
;
instance_create((x - 32), (y - 32), Floor);
;
instance_create(x, (y - 32), Floor);
;
instance_create((x + 32), y, Floor);
;
instance_create((x + 32), (y - 32), Floor);
;
instance_create((x + 32), (y + 32), Floor);
;
instance_create(x, (y + 32), Floor);
;
instance_create((x - 32), (y + 32), Floor);
;
}
}
instance_destroy();
;
}
}
}

// Source areas/HQ.area.gml:108; area_pop_enemies
function hm_areas_HQ_area_gml_area_pop_enemies() {
if ((random(4) < 1)) {
instance_create((x + 16), (y + 16), Grunt);
}
if ((random(48) < 1)) {
instance_create((x + 16), (y + 16), Inspector);
}
if ((random(48) < 1)) {
instance_create((x + 16), (y + 16), Shielder);
}
if ((random((500 / GameCont.subarea)) < 1)) {
instance_create((x + 16), (y + 16), EliteGrunt);
}
if ((random((500 / GameCont.subarea)) < 1)) {
instance_create((x + 16), (y + 16), EliteInspector);
}
if ((random((500 / GameCont.subarea)) < 1)) {
instance_create((x + 16), (y + 16), EliteShielder);
}
}

// Source areas/HQ.area.gml:115; area_pop_props
function hm_areas_HQ_area_gml_area_pop_props() {
if ((random(24) < 1)) {
instance_create((x + 16), (y + 16), PlantPot);
}
}

// Source areas/HQ.area.gml:119; area_mapdata
function hm_areas_HQ_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
if ((_hml_lp == "elevator")) {
return [(_hml_lx + 9), 0];
} else {
return [_hml_lx, 0];
}
;
}
