// Source areas/palace.area.gml:1; __load
function hm_areas_palace_area_gml___load() {

}

// Source areas/palace.area.gml:1; area_name
function hm_areas_palace_area_gml_area_name() {
return ("7-" + string(GameCont.subarea));
;
}

// Source areas/palace.area.gml:4; area_sprite
function hm_areas_palace_area_gml_area_sprite(_hml_q) {
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

// Source areas/palace.area.gml:16; area_transit
function hm_areas_palace_area_gml_area_transit() {
if (((lastarea != scrHMAreaResolve("palace")) and (lastarea == scrHMAreaResolve(106)))) {
{
area = scrHMAreaResolve("palace");
;
loops -= 1;
;
subarea = 4;
;
}
}
}

// Source areas/palace.area.gml:23; area_finish
function hm_areas_palace_area_gml_area_finish() {
area = scrHMAreaResolve("palace");
;
subarea += 1;
;
}

// Source areas/palace.area.gml:29; area_setup
function hm_areas_palace_area_gml_area_setup() {
scrHMSoundMusic(mus7);
scrHMSoundAmbient(amb7);
;
if ((GameCont.subarea == 3)) {
goal = 60;
} else {
goal = 120;
}
;
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
}

// Source areas/palace.area.gml:40; area_make_floor
function hm_areas_palace_area_gml_area_make_floor() {
if (((GameCont.subarea == 3) and (instance_number(Floor) <= 1))) {
{
{ var __hm_with1 = scrHMInstances(instance_create(x, y, Floor)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "statue";
}
}
if(__hm_break3) break;
}}
direction = 0;
{ var __hm_with4 = scrHMInstances(instance_create(x, y, FloorMaker)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
direction = 90;
}
if(__hm_break6) break;
}}
{ var __hm_with7 = scrHMInstances(instance_create(x, y, FloorMaker)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
direction = 180;
}
if(__hm_break9) break;
}}
{ var __hm_with10 = scrHMInstances(instance_create(x, y, FloorMaker)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
direction = 270;
}
if(__hm_break12) break;
}}
}
}
if ((random(3) < 1)) {
{
if ((! place_meeting(x, y, Floor))) {
instance_create(x, y, Floor);
}
if ((! place_meeting((x + 32), y, Floor))) {
instance_create((x + 32), y, Floor);
}
if ((! place_meeting((x - 32), y, Floor))) {
instance_create((x - 32), y, Floor);
}
if ((! place_meeting(x, (y + 32), Floor))) {
instance_create(x, (y + 32), Floor);
}
if ((! place_meeting(x, (y - 32), Floor))) {
instance_create(x, (y - 32), Floor);
}
}
} else {
{
if ((! place_meeting(x, y, Floor))) {
instance_create(x, y, Floor);
}
if ((! place_meeting((x - 32), y, Floor))) {
instance_create((x - 32), y, Floor);
}
if ((! place_meeting(x, (y + 32), Floor))) {
instance_create(x, (y + 32), Floor);
}
}
}
if ((GameCont.subarea == 3)) {
var _hml_turn = 0;
} else {
var _hml_turn = choose(0, 0, 0, 0, 0, 0, 90, (- 90), 180);
}
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
if (((random((19 + instance_number(FloorMaker))) > 22) and (GameCont.subarea != 3))) {
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
if ((random(12) < 1)) {
{
instance_create(x, y, FloorMaker);
;
}
}
}
}

// Source areas/palace.area.gml:87; area_start
function hm_areas_palace_area_gml_area_start() {
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((random(7) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create(x, y, TopDecalPalace)), __hm_break6=false;
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
if (!(self[$ "hm_interior_wall"]??false) && distance_to_point(10016,10016)>160 && random(16)<1) {
{
var _hml_fl_ = instance_nearest(x, y, Floor);
scrHMPalaceGenerator105(_hml_fl_.x+16,_hml_fl_.y+16);
}
}
}
if(__hm_break9) break;
}}
if ((GameCont.subarea == 3)) {
{
{ var __hm_with10 = scrHMInstances(instance_create(0, 0, CustomEnemy)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
name = "portalblocker";
canfly = 1;
}
}
if(__hm_break12) break;
}}
}
}
{ var __hm_with13 = scrHMMatching(Floor, "name", "statue"), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
scrHMModCall("mod", "guardianboss", "GuardianStatue_create", (x + 16), (y + 16));
}
}
if(__hm_break15) break;
}}
}

// Source areas/palace.area.gml:108; area_pop_enemies
function hm_areas_palace_area_gml_area_pop_enemies() {
if ((GameCont.subarea <= 3)) {
{
if ((random(30) < 1)) {
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), HostileHorror)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMPalaceHorrorInit();
}
if(__hm_break3) break;
}}
}
if ((random(40) < 1)) {
instance_create((x + 16), (y + 16), ExploGuardian);
}
}
}
if ((random(40) < 1)) {
instance_create((x + 16), (y + 16), DogGuardian);
}
if ((random(20) < 1)) {
instance_create((x + 16), (y + 16), Guardian);
}
}

// Source areas/palace.area.gml:118; area_pop_props
function hm_areas_palace_area_gml_area_pop_props() {
if ((random(64) < 1)) {
instance_create((x + 16), (y + 16), Table);
}
if ((random(14) < 1)) {
instance_create((x + 16), (y + 16), Pillar);
}
}

// Source areas/palace.area.gml:122; area_mapdata
function hm_areas_palace_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
if ((_hml_lp == ("elevator" || 106))) {
return [(_hml_lx + 18), 0];
} else {
return [_hml_lx, 0];
}
;
}
