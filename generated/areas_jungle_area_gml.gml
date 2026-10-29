// Source areas/jungle.area.gml:1; __load
function hm_areas_jungle_area_gml___load() {
global.hm_module_vars[$ "area:jungle"].jw_set_bigbandit_to_set_the_subarea_to_3_when_they_spawn = 0;
}

// Source areas/jungle.area.gml:2; area_name
function hm_areas_jungle_area_gml_area_name() {
return ("?-" + string(GameCont.subarea));
;
}

// Source areas/jungle.area.gml:5; area_sprite
function hm_areas_jungle_area_gml_area_sprite(_hml_q) {
switch (_hml_q) {
case sprFloor1:
return sprFloor105;
;
case sprFloor1B:
return sprFloor105;
;
case sprFloor1Explo:
return sprFloor105Explo;
;
case sprWall1Trans:
return sprWall105Trans;
;
case sprWall1Bot:
return sprWall105Bot;
;
case sprWall1Out:
return sprWall105Out;
;
case sprWall1Top:
return sprWall105Top;
;
case sprDebris1:
return sprDebris105;
;
}
}

// Source areas/jungle.area.gml:17; area_transit
function hm_areas_jungle_area_gml_area_transit() {
if (((lastarea != scrHMAreaResolve("jungle")) and (lastarea == scrHMAreaResolve("jungleboogie")))) {
{
area = scrHMAreaResolve("jungle");
;
subarea = 1;
}
}
}

// Source areas/jungle.area.gml:23; area_finish
function hm_areas_jungle_area_gml_area_finish() {
if ((global.hm_module_vars[$ "area:jungle"].jw_set_bigbandit_to_set_the_subarea_to_3_when_they_spawn < 5)) {
{
area = scrHMAreaResolve("jungle");
;
subarea = global.hm_module_vars[$ "area:jungle"].jw_set_bigbandit_to_set_the_subarea_to_3_when_they_spawn;
subarea += 1;
;
}
} else {
{
area = scrHMAreaResolve("labs");
subarea = 1;
}
}
scrHMSpriteRestore(sprBanditBossIdle);
;
scrHMSpriteRestore(sprBanditBossWalk);
;
scrHMSpriteRestore(sprBanditBossFire);
;
scrHMSpriteRestore(sprBanditBossTell);
;
scrHMSpriteRestore(sprBanditBossDash);
;
scrHMSpriteRestore(sprBanditBossStop);
;
scrHMSpriteRestore(sprBanditBossHurt);
;
scrHMSpriteRestore(sprBanditBossDead);
;
}

// Source areas/jungle.area.gml:41; area_setup
function hm_areas_jungle_area_gml_area_setup() {
scrHMSoundMusic(mus105);
scrHMSoundAmbient(amb105);
;
goal = 110;
;
background_set_colour(make_color_rgb(42, 144, 12));
;
{ var __hm_with1 = scrHMInstances(BackCont), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
shadow_color = c_black;
}
if(__hm_break3) break;
}}
TopCont.fog = sprFog2;
TopCont.darkness = 1;
}

// Source areas/jungle.area.gml:51; area_start
function hm_areas_jungle_area_gml_area_start() {
global.hm_module_vars[$ "area:jungle"].jw_set_bigbandit_to_set_the_subarea_to_3_when_they_spawn = GameCont.subarea;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((random(7) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create(x, y, TopDecalJungle)), __hm_break6=false;
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
sprite_index = sprJungleDecal;
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
sprite_index = sprJungleDecal;
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
if ((GameCont.subarea > 1)) {
{
repeat ((GameCont.subarea - 1)) { var __hm_with16 = scrHMInstances(instance_furthest(10016, 10016, Floor)), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
scrHMModCall("mod", "enemies", "wantjungleboss_create", (x + 16), (y + 16));
}
if(__hm_break18) break;
}}
;
}
} else {
instance_create(10016, 10016, BigFlower);
}
scrHMSpriteReplace(sprBanditBossIdle, sprHM_areas_jungle_area_75);
scrHMSpriteReplace(sprBanditBossWalk, sprHM_areas_jungle_area_76);
scrHMSpriteReplace(sprBanditBossFire, sprHM_areas_jungle_area_77);
scrHMSpriteReplace(sprBanditBossTell, sprHM_areas_jungle_area_78);
scrHMSpriteReplace(sprBanditBossDash, sprHM_areas_jungle_area_79);
scrHMSpriteReplace(sprBanditBossStop, sprHM_areas_jungle_area_80);
scrHMSpriteReplace(sprBanditBossHurt, sprHM_areas_jungle_area_81);
scrHMSpriteReplace(sprBanditBossDead, sprHM_areas_jungle_area_82);
{ var __hm_with19 = scrHMInstances(Floor), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
if (((((((! place_meeting(x, y, Player)) and (! place_meeting(x, y, enemy))) and (! place_meeting(x, y, RadChest))) and (! place_meeting(x, y, AmmoChest))) and (! place_meeting(x, y, WeaponChest))) and (! place_meeting(x, y, prop)))) {
{
if (((random(3) < 1) and (! place_meeting(x, y, NOWALLSHEREPLEASE)))) {
{
var _hml_myx = (x + choose(0, 16));
;
var _hml_myy = (y + choose(0, 16));
;
{ var __hm_with22 = scrHMInstances(instance_create(_hml_myx, _hml_myy, Wall)), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
instance_create(x, y, NOWALLSHEREPLEASE);
}
if(__hm_break24) break;
}}
}
}
}
}
}
if(__hm_break21) break;
}}
}

// Source areas/jungle.area.gml:95; area_make_floor
function hm_areas_jungle_area_gml_area_make_floor() {
instance_create(x, y, Floor);
;
var _hml_turn = choose(0, 0, 0, 0, 0, 0, 0, 90, 90, 90, (- 90), (- 90), (- 90), 180);
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
if ((random(7) < 1)) {
{
instance_create(x, y, FloorMaker);
;
}
}
}
}

// Source areas/jungle.area.gml:122; area_pop_enemies
function hm_areas_jungle_area_gml_area_pop_enemies() {
if ((random(20) < 1)) {
instance_create((x + 16), (y + 16), JungleAssassinHide);
}
if ((random(20) < 1)) {
instance_create((x + 16), (y + 16), JungleBandit);
}
if ((random(20) < 1)) {
instance_create((x + 16), (y + 16), JungleFly);
}
if ((random(20) < 1)) {
instance_create((x + 16), (y + 16), Raven);
}
if ((random(100) < 1)) {
repeat (5) scrHMModCall("mod", "enemies", "enemychicken_create", (x + 16), (y + 16));
}
}

// Source areas/jungle.area.gml:129; area_pop_props
function hm_areas_jungle_area_gml_area_pop_props() {
if ((random(2) < 1)) {
instance_create((x + 16), (y + 16), Bush);
}
if ((random(14) < 1)) {
instance_create((x + 16), (y + 16), LightBeam);
}
}

// Source areas/jungle.area.gml:133; area_mapdata
function hm_areas_jungle_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
if ((_hml_lp == "junkyard")) {
return [(_hml_lx + 18), 9, 1, 1, 1];
} else {
return [_hml_lx, 9, 1, 1, 1];
}
;
}
