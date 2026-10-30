// Source areas/cavesinv.area.gml:1; __load
function hm_areas_cavesinv_area_gml___load() {
global.hm_module_vars[$ "area:cavesinv"].CrystalFreakIdle = sprHM_areas_cavesinv_area_2;
global.hm_module_vars[$ "area:cavesinv"].CrystalFreakWalk = sprHM_areas_cavesinv_area_3;
global.hm_module_vars[$ "area:cavesinv"].CrystalFreakHurt = sprHM_areas_cavesinv_area_4;
global.hm_module_vars[$ "area:cavesinv"].CrystalFreakDead = sprHM_areas_cavesinv_area_5;
global.hm_module_vars[$ "area:cavesinv"].sprCrystalPropBlueDead = sprHM_areas_cavesinv_area_6;
global.hm_module_vars[$ "area:cavesinv"].sprCrystalPropGreenDead = sprHM_areas_cavesinv_area_7;
}

// Source areas/cavesinv.area.gml:10; area_name
function hm_areas_cavesinv_area_gml_area_name() {
return ((string(choose("q", "4", "a", "4", "\\", "4", string(GameCont.subarea), ",", ">", "F", "-", "*", "!", "^")) + string(choose("q", "r", "a", "]", "\\", "+", string(GameCont.subarea), ",", ">", "F", "-", "*", "!", "^"))) + string(choose("q", "r", "a", "]", string(GameCont.subarea), string(GameCont.subarea), string(GameCont.subarea), ",", ">", "F", "-", "*", "!", "^")));
}

// Source areas/cavesinv.area.gml:13; area_sprite
function hm_areas_cavesinv_area_gml_area_sprite(_hml_q) {
switch (_hml_q) {
case sprFloor1:
return sprFloor104;
;
case sprFloor1B:
return sprFloor104B;
;
case sprFloor1Explo:
return sprFloor104Explo;
;
case sprWall1Trans:
return sprWall104Trans;
;
case sprWall1Bot:
return sprWall104Bot;
;
case sprWall1Out:
return sprWall104Out;
;
case sprWall1Top:
return sprWall104Top;
;
case sprDebris1:
return sprDebris104;
;
case sprDetail1:
return sprDetail104;
;
}
}

// Source areas/cavesinv.area.gml:25; area_transit
function hm_areas_cavesinv_area_gml_area_transit() {
if (((lastarea != scrHMAreaResolve("caves")) and (lastarea == scrHMAreaResolve("bigdog")))) {
{
if (((Player.curse == 0) and (Player.bcurse == 0))) {
area = scrHMAreaResolve("caves");
} else {
area = scrHMAreaResolve("cavesinv");
}
}
} else {
if (((lastarea != scrHMAreaResolve("cavesinv")) and (lastarea == scrHMAreaResolve("caves")))) {
{
if (((Player.curse >= 1) || (Player.bcurse >= 1))) {
area = scrHMAreaResolve("cavesinv");
}
}
}
}
}

// Source areas/cavesinv.area.gml:36; area_finish
function hm_areas_cavesinv_area_gml_area_finish() {
if ((subarea < 3)) {
{
area = scrHMAreaResolve("cavesinv");
;
subarea += 1;
;
if (((instance_exists(Player) and (Player.curse == 0)) and (Player.bcurse == 0))) {
{
area = scrHMAreaResolve("caves");
;
subarea += 1;
;
}
}
}
} else {
{
area = scrHMAreaResolve("city");
;
subarea = 1;
;
}
}
scrHMSpriteRestore(sprHyperCrystalIdle);
;
scrHMSpriteRestore(sprHyperCrystalHurt);
;
}

// Source areas/cavesinv.area.gml:52; area_setup
function hm_areas_cavesinv_area_gml_area_setup() {
scrHMSoundMusic(mus104);
scrHMSoundAmbient(amb104);
;
goal = 110;
;
background_set_colour(make_color_rgb(255, 156, 35));
;
{ var __hm_with1 = scrHMInstances(BackCont), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
shadow_color = 66;
}
if(__hm_break3) break;
}}
;
{ var __hm_with4 = scrHMInstances(TopCont), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
darkness = 1;
}
if(__hm_break6) break;
}}
;
scrHMSpriteReplace(sprHyperCrystalIdle, sprHM_areas_cavesinv_area_62);
scrHMSpriteReplace(sprHyperCrystalHurt, sprHM_areas_cavesinv_area_63);
}

// Source areas/cavesinv.area.gml:65; area_start
function hm_areas_cavesinv_area_gml_area_start() {
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((random(7) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create(x, y, TopDecalInvCave)), __hm_break6=false;
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
if ((random(12) < 1)) {
{
if (place_meeting((x + 16), y, Floor)) {
{ var __hm_with10 = scrHMInstances(instance_create((x + 16), y, Bones)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
sprite_index = sprInvCaveDecal;
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
sprite_index = sprInvCaveDecal;
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
if ((GameCont.subarea == 3)) {
{
{ var __hm_with16 = scrHMInstances(instance_furthest(10016, 10016, Floor)), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
{
instance_create((x + 16), (y + 16), HyperCrystal);
if (scrHMGetSkill(18)) {
{ var __hm_with19 = scrHMInstances(instance_nearest(x, y, Floor)), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
{
scrHMModCall("mod", "props", "cave_create", ((x + 16) + lengthdir_x(64, point_direction(Player.x, Player.y, x, y))), ((y + 16) + lengthdir_y(64, point_direction(Player.x, Player.y, x, y))));
}
}
if(__hm_break21) break;
}}
}
}
}
if(__hm_break18) break;
}}
}
} else {
{
var _hml_fla = 0;
{ var __hm_with22 = scrHMInstances(Player), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
if (((((((((string_count("FLAME", scrHMWeaponName(wep)) > 0) || (string_count("FLAME", scrHMWeaponName(bwep)) > 0)) || (string_count("FLARE", scrHMWeaponName(wep)) > 0)) || (string_count("FLARE", scrHMWeaponName(bwep)) > 0)) || (string_count("DRAGON", scrHMWeaponName(wep)) > 0)) || (string_count("DRAGON", scrHMWeaponName(bwep)) > 0)) || (string_count("INCIN", scrHMWeaponName(wep)) > 0)) || (string_count("INCIN", scrHMWeaponName(bwep)) > 0))) {
_hml_fla += 1;
}
}
if(__hm_break24) break;
}}
if ((random(7) < 1)) {
_hml_fla += 1;
}
if (((_hml_fla > 0) and instance_exists(Bones))) {
{ var __hm_with25 = scrHMInstances(instance_furthest(Player.x, Player.y, Bones)), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
{
scrHMModCall("mod", "props", "cave_create", x, y);
instance_destroy();
}
}
if(__hm_break27) break;
}}
}
}
}
if ((random(5) < 1)) {
{ var __hm_with28 = scrHMInstances(Floor), __hm_break30=false;
for (var __hm_index29=0; __hm_index29<array_length(__hm_with28); ++__hm_index29) {
if(instance_exists(__hm_with28[__hm_index29])) with (__hm_with28[__hm_index29]) {
{
styleb = 1;
sprite_index = sprFloor104B;
}
}
if(__hm_break30) break;
}}
} else {
{ var __hm_with31 = scrHMInstances(Floor), __hm_break33=false;
for (var __hm_index32=0; __hm_index32<array_length(__hm_with31); ++__hm_index32) {
if(instance_exists(__hm_with31[__hm_index32])) with (__hm_with31[__hm_index32]) {
{
styleb = 0;
sprite_index = sprFloor104;
}
}
if(__hm_break33) break;
}}
}
{ var __hm_with34 = scrHMInstances(Floor), __hm_break36=false;
for (var __hm_index35=0; __hm_index35<array_length(__hm_with34); ++__hm_index35) {
if(instance_exists(__hm_with34[__hm_index35])) with (__hm_with34[__hm_index35]) {
if ((styleb == 1)) {
{
traction = 2;
}
}
}
if(__hm_break36) break;
}}
repeat (random_range(16, 40)) { var __hm_with37 = scrHMAuthoredWalls105(), __hm_break39=false;
for (var __hm_index38=0; __hm_index38<array_length(__hm_with37); ++__hm_index38) {
if(instance_exists(__hm_with37[__hm_index38])) with (__hm_with37[__hm_index38]) {
if ((random(2) < 1)) {
if (((((((((((((((! place_meeting(x, (y + 16), Wall)) and (! place_meeting(x, (y + 32), Wall))) and (! place_meeting((x - 16), (y + 32), Wall))) and (! place_meeting((x + 16), (y + 32), Wall))) and (! place_meeting(x, (y + 16), hitme))) and (! place_meeting(x, (y + 32), hitme))) and (! place_meeting((x - 16), (y + 32), hitme))) and (! place_meeting((x + 16), (y + 32), hitme))) and (! place_meeting(x, (y + 16), chestprop))) and (! place_meeting(x, (y + 32), chestprop))) and (! place_meeting((x - 16), (y + 32), chestprop))) and (! place_meeting((x + 16), (y + 32), chestprop))) and place_meeting(x, (y + 16), Floor)) and (random(3) < 1))) {
instance_create(x, (y + 16), Wall);
}
}
}
if(__hm_break39) break;
}}
{ var __hm_with40 = scrHMAuthoredWalls105(), __hm_break42=false;
for (var __hm_index41=0; __hm_index41<array_length(__hm_with40); ++__hm_index41) {
if(instance_exists(__hm_with40[__hm_index41])) with (__hm_with40[__hm_index41]) {
if ((random(2) < 1)) {
if ((((((((((((((((((! place_meeting(x, (y - 16), Wall)) and (! place_meeting(x, (y - 48), Wall))) and (! place_meeting((x - 16), (y - 48), Wall))) and (! place_meeting((x + 16), (y - 48), Wall))) and (! place_meeting(x, (y - 32), Wall))) and (! place_meeting((x - 16), (y - 32), Wall))) and (! place_meeting((x + 16), (y - 32), Wall))) and (! place_meeting(x, (y - 16), hitme))) and (! place_meeting(x, (y - 32), hitme))) and (! place_meeting((x - 16), (y - 32), hitme))) and (! place_meeting((x + 16), (y - 32), hitme))) and (! place_meeting(x, (y - 16), chestprop))) and (! place_meeting(x, (y - 32), chestprop))) and (! place_meeting((x - 16), (y - 32), chestprop))) and (! place_meeting((x + 16), (y + 32), chestprop))) and place_meeting(x, (y - 16), Floor)) and (random(2) < 1))) {
instance_create(x, (y - 16), Wall);
}
}
}
if(__hm_break42) break;
}}
{ var __hm_with43 = scrHMAuthoredWalls105(), __hm_break45=false;
for (var __hm_index44=0; __hm_index44<array_length(__hm_with43); ++__hm_index44) {
if(instance_exists(__hm_with43[__hm_index44])) with (__hm_with43[__hm_index44]) {
if ((random(2) < 1)) {
if (((((! place_meeting((x + 16), y, Wall)) and (! place_meeting((x + 32), y, Wall))) and (! place_meeting((x + 32), (y - 16), Wall))) and (! place_meeting((x + 32), (y + 16), Wall)))) {
if (((((((((((! place_meeting((x + 16), y, hitme)) and (! place_meeting((x + 32), y, hitme))) and (! place_meeting((x + 32), (y - 16), hitme))) and (! place_meeting((x + 32), (y + 16), Wall))) and (! place_meeting((x + 16), y, chestprop))) and (! place_meeting((x + 32), y, chestprop))) and (! place_meeting((x + 32), (y - 16), chestprop))) and (! place_meeting((x + 32), (y + 16), chestprop))) and place_meeting((x + 16), y, Floor)) and (random(3) < 1))) {
instance_create((x + 16), y, Wall);
}
}
}
}
if(__hm_break45) break;
}}
{ var __hm_with46 = scrHMAuthoredWalls105(), __hm_break48=false;
for (var __hm_index47=0; __hm_index47<array_length(__hm_with46); ++__hm_index47) {
if(instance_exists(__hm_with46[__hm_index47])) with (__hm_with46[__hm_index47]) {
if ((random(2) < 1)) {
if ((((((((! place_meeting((x - 16), y, Wall)) and (! place_meeting((x - 48), y, Wall))) and (! place_meeting((x - 48), (y - 16), Wall))) and (! place_meeting((x - 48), (y + 16), Wall))) and (! place_meeting((x - 32), y, Wall))) and (! place_meeting((x - 32), (y - 16), Wall))) and (! place_meeting((x - 32), (y + 16), Wall)))) {
if (((((((((((! place_meeting((x - 16), y, hitme)) and (! place_meeting((x - 32), y, hitme))) and (! place_meeting((x - 32), (y - 16), hitme))) and (! place_meeting((x - 32), (y + 16), hitme))) and (! place_meeting((x - 16), y, chestprop))) and (! place_meeting((x - 32), y, chestprop))) and (! place_meeting((x - 32), (y - 16), chestprop))) and (! place_meeting((x - 32), (y + 16), chestprop))) and place_meeting((x - 16), y, Floor)) and (random(2) < 1))) {
instance_create((x - 16), y, Wall);
}
}
}
}
if(__hm_break48) break;
}}
}

// Source areas/cavesinv.area.gml:144; area_make_floor
function hm_areas_cavesinv_area_gml_area_make_floor() {
if ((scrHMVariableExists(id, "big") and (big == 1))) {
{
instance_create((x + 32), y, Floor);
;
instance_create((x + 32), (y + 32), Floor);
;
instance_create(x, (y + 32), Floor);
;
}
}
instance_create(x, y, Floor);
;
var _hml_turn = choose(0, 0, 0, 0, 0, 0, 0, 90, (- 90), 90, (- 90), 180);
;
direction += _hml_turn;
;
if (((_hml_turn == 180) && (point_distance(x, y, 10016, 10016) > 48))) {
{
instance_create(x, y, Floor);
;
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), WeaponChest)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
curse = 1;
sprite_index = sprCursedChest;
}
}
if(__hm_break3) break;
}}
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
if ((random(6) < (1 + GameCont.loops))) {
{
{ var __hm_with4 = scrHMInstances(instance_create(x, y, FloorMaker)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
big = choose(0, 0, 0, 0, 1);
}
}
if(__hm_break6) break;
}}
}
}
}
}

// Source areas/cavesinv.area.gml:175; area_pop_enemies
function hm_areas_cavesinv_area_gml_area_pop_enemies() {
instance_create((x + 16), (y + 16), InvSpider);
;
if ((random(8) < 1)) {
{
if ((random(4) < 1)) {
instance_create((x + 16), (y + 16), LightningCrystal);
} else {
instance_create((x + 16), (y + 16), InvLaserCrystal);
}
;
}
}
if ((random(100) < 1)) {
scrHMModCall("mod", "enemies", "bigcrystal_create", (x + 16), (y + 16));
}

scrHMLoopCrystal109(x+16,y+16);
}

// Source areas/cavesinv.area.gml:190; area_pop_props
function hm_areas_cavesinv_area_gml_area_pop_props() {
if ((random(4) < 1)) {
instance_create((x + 16), (y + 16), LightBeam);
}
if ((random(4) < 1)) {
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), Crystal)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if ((random(3) < 1)) {
{
spr_idle = sprCrystalProp;
spr_hurt = sprCrystalPropHurt;
spr_dead = sprCrystalPropDead;
}
} else {
if ((random(2) < 1)) {
{
spr_idle = sprCrystalPropBlue;
spr_hurt = sprCrystalPropBlueHurt;
spr_dead = global.hm_module_vars[$ "area:cavesinv"].sprCrystalPropBlueDead;
}
} else {
{
spr_idle = sprCrystalPropGreen;
spr_hurt = sprCrystalPropGreenHurt;
spr_dead = global.hm_module_vars[$ "area:cavesinv"].sprCrystalPropGreenDead;
}
}
}
}
}
if(__hm_break3) break;
}}
}
}

// Source areas/cavesinv.area.gml:210; area_mapdata
function hm_areas_cavesinv_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
if ((_hml_lp == "junkyard")) {
return [(_hml_lx + 18), 9, 1, 1, 1];
} else {
return [_hml_lx, 9, 1, 1, 1];
}
;
}
