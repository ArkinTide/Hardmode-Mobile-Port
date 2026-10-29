// Source areas/nightdesert.area.gml:1; __load
function hm_areas_nightdesert_area_gml___load() {

}

// Source areas/nightdesert.area.gml:1; area_name
function hm_areas_nightdesert_area_gml_area_name() {
return "1-4";
;
}

// Source areas/nightdesert.area.gml:4; area_sprite
function hm_areas_nightdesert_area_gml_area_sprite(_hml_q) {
switch (_hml_q) {
case sprFloor1:
return sprFloor0;
;
case sprFloor1B:
return sprFloor0;
;
case sprFloor1Explo:
return sprFloor0Explo;
;
case sprWall1Trans:
return sprWall0Trans;
;
case sprWall1Bot:
return sprWall0Bot;
;
case sprWall1Out:
return sprWall0Out;
;
case sprWall1Top:
return sprWall0Top;
;
case sprDebris1:
return sprDebris0;
;
case sprDetail1:
return sprDetail0;
;
}
}

// Source areas/nightdesert.area.gml:17; area_transit
function hm_areas_nightdesert_area_gml_area_transit() {
if ((((lastarea != scrHMAreaResolve("nightdesert")) && (lastarea == scrHMAreaResolve(1))) && (lastsubarea == 3))) {
{
area = scrHMAreaResolve("nightdesert");
;
}
}
}

// Source areas/nightdesert.area.gml:22; area_finish
function hm_areas_nightdesert_area_gml_area_finish() {
area = scrHMAreaResolve("scorpionboss");
;
subarea = 1;
;
}

// Source areas/nightdesert.area.gml:26; area_setup
function hm_areas_nightdesert_area_gml_area_setup() {
goal = 70;
;
background_set_colour(make_color_rgb(106, 122, 175));
;
BackCont.shadow_color = c_black;
;
TopCont.fog = sprFog2;
;
TopCont.darkness = 0;
;
scrHMSoundMusic(mus1b);
scrHMSoundAmbient(amb0b);
;
}

// Source areas/nightdesert.area.gml:35; area_start
function hm_areas_nightdesert_area_gml_area_start() {
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((random(7) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create(x, y, TopDecalNightDesert)), __hm_break6=false;
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
{ var __hm_with10 = scrHMInstances(instance_create((x + 16), y, Bones)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
sprite_index = sprNightBones;
image_xscale = 1;
}
}
if(__hm_break12) break;
}}
{ var __hm_with13 = scrHMInstances(instance_create((x + 48), y, Bones)), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
sprite_index = sprNightBones;
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
{ var __hm_with19 = scrHMInstances(instance_create((x + 16), (y + 16), Campfire)), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
{
depth = 0;
mask_index = mskNone;
spr_idle = sprCampfireOff;
spr_shadow = mskNone;
{ var __hm_with22 = scrHMMatchingNE(prop, "object_index", "Campfire"), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
if ((distance_to_object(Campfire) < 16)) {
scrHMDelete(id);
}
}
if(__hm_break24) break;
}}
}
}
if(__hm_break21) break;
}}
}
if(__hm_break18) break;
}}
}

// Source areas/nightdesert.area.gml:62; area_make_floor
function hm_areas_nightdesert_area_gml_area_make_floor() {
instance_create(x, y, Floor);
;
var _hml_turn = choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 90, (- 90), 90, (- 90), 180);
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
if ((random(10) < 1)) {
{
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
if ((random(2) < 1)) {
{
instance_create(x, y, FloorMaker);
;
}
}
}
}

// Source areas/nightdesert.area.gml:89; area_pop_enemies
function hm_areas_nightdesert_area_gml_area_pop_enemies() {
var _hml__a = (GameCont.loops + 1);
;
if ((random(2) < _hml__a)) {
scrHMModCall("mod", "enemies", "elitebanditsleep_create", (x + 16), (y + 16));
}
if ((random(8) < 1)) {
instance_create((x + 16), (y + 16), Scorpion);
}
if ((random(16) < 1)) {
instance_create((x + 16), (y + 16), GoldScorpion);
}
if ((random(2) < _hml__a)) {
instance_create((x + 16), (y + 16), Maggot);
}
if ((random(4) < _hml__a)) {
instance_create((x + 16), (y + 16), MaggotSpawn);
}
if ((random(8) < 1)) {
instance_create((x + 16), (y + 16), BigMaggot);
}
if ((random(12) < _hml__a)) {
instance_create((x + 16), (y + 16), JungleFly);
}
}

// Source areas/nightdesert.area.gml:99; area_pop_props
function hm_areas_nightdesert_area_gml_area_pop_props() {
if ((random(4) < 1)) {
instance_create((x + 16), (y + 16), NightCactus);
}
if ((random(16) < 1)) {
instance_create((x + 16), (y + 16), BonePile);
}
}

// Source areas/nightdesert.area.gml:103; area_mapdata
function hm_areas_nightdesert_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return [_hml_lx, 0];
;
}
