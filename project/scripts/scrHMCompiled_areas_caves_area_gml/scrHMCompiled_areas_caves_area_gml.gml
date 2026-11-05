// Source areas/caves.area.gml:1; __load

function hm_areas_caves_area_gml___load() {

global.hm_module_vars[$ "area:caves"].sprCrystalPropBlueDead = sprHM_areas_caves_area_1;

global.hm_module_vars[$ "area:caves"].sprCrystalPropGreenDead = sprHM_areas_caves_area_2;

global.hm_module_vars[$ "area:caves"].skycrystal = sprHM_areas_caves_area_3;

}



// Source areas/caves.area.gml:4; area_name

function hm_areas_caves_area_gml_area_name() {

return ("4-" + string(GameCont.subarea));

;

}



// Source areas/caves.area.gml:7; area_sprite

function hm_areas_caves_area_gml_area_sprite(_hml_q) {

switch (_hml_q) {

case sprFloor1:

return sprFloor4;

;

case sprFloor1B:

return sprFloor4B;

;

case sprFloor1Explo:

return sprFloor4Explo;

;

case sprWall1Trans:

return sprWall4Trans;

;

case sprWall1Bot:

return sprWall4Bot;

;

case sprWall1Out:

return sprWall4Out;

;

case sprWall1Top:

return sprWall4Top;

;

case sprDebris1:

return sprDebris4;

;

case sprDetail1:

return sprDetail4;

;

}

}



// Source areas/caves.area.gml:0; area_transit (native content 1.1.0)
function hm_areas_caves_area_gml_area_transit() {
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
if (((lastarea != scrHMAreaResolve("caves")) && (lastarea == scrHMAreaResolve("bigdog")))) {
{
if (((Player.curse >= 1) || (Player.bcurse >= 1))) {
area = scrHMAreaResolve("cavesinv");
} else {
area = scrHMAreaResolve("caves");
}
;
}
}
}

// Source areas/caves.area.gml:0; area_finish (native content 1.1.0)
function hm_areas_caves_area_gml_area_finish() {
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
if ((subarea < 3)) {
{
area = scrHMAreaResolve("caves");
;
subarea += 1;
;
}
} else {
{
area = scrHMAreaResolve("city");
;
subarea = 1;
;
}
}
}

// Source areas/caves.area.gml:0; area_setup (native content 1.1.0)
function hm_areas_caves_area_gml_area_setup() {
GameCont.hm_cave_cleansed = 0;
;
GameCont.hm_destination = "";
;
scrHMSoundMusic(mus4);
scrHMSoundAmbient(amb4);
;
goal = 110;
;
background_set_colour(make_color_rgb(129, 82, 188));
;
BackCont.shadow_color = 786950;
;
TopCont.darkness = 1;
;
hm_arkintide_mod_gml_hm_map_budget();
;
}

// Source areas/caves.area.gml:46; area_make_floor

function hm_areas_caves_area_gml_area_make_floor() {

instance_create(x, y, Floor);

var _hml_turn = choose(0, 0, 0, 0, 90, (- 90), 180);

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

if ((random(4) < 1)) {

{

instance_create(x, y, FloorMaker);

;

}

}

}

}



// Source areas/caves.area.gml:0; area_start (native content 1.1.0)
function hm_areas_caves_area_gml_area_start() {
hm_arkintide_mod_gml_hm_native_unlock_area();
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((random(12) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create(x, y, TopDecalCave)), __hm_break6=false;
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
if ((random(16) < 1)) {
{
if (place_meeting((x + 16), y, Floor)) {
{ var __hm_with10 = scrHMInstances(instance_create((x + 16), y, Bones)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
sprite_index = sprCaveDecal;
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
sprite_index = sprCaveDecal;
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
}
}
if(__hm_break18) break;
}}
}
} else {
{
var _hml_fla = 0;
{ var __hm_with19 = scrHMInstances(Player), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
if (((((((((string_count("FLAME", scrHMWeaponName(wep)) > 0) || (string_count("FLAME", scrHMWeaponName(bwep)) > 0)) || (string_count("FLARE", scrHMWeaponName(wep)) > 0)) || (string_count("FLARE", scrHMWeaponName(bwep)) > 0)) || (string_count("DRAGON", scrHMWeaponName(wep)) > 0)) || (string_count("DRAGON", scrHMWeaponName(bwep)) > 0)) || (string_count("INCIN", scrHMWeaponName(wep)) > 0)) || (string_count("INCIN", scrHMWeaponName(bwep)) > 0))) {
_hml_fla += 1;
}
}
if(__hm_break21) break;
}}
if ((random(7) < 1)) {
_hml_fla += 1;
}
if (((_hml_fla > 0) and instance_exists(Bones))) {
{ var __hm_with22 = scrHMInstances(instance_furthest(Player.x, Player.y, Bones)), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
{
scrHMModCall("mod", "props", "cave_create", x, y);
instance_destroy();
}
}
if(__hm_break24) break;
}}
}
}
}
{ var __hm_with25 = scrHMInstances(Floor), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
if ((styleb == 1)) {
{
traction = 2;
}
}
}
if(__hm_break27) break;
}}
{ var __hm_with28 = scrHMInstances(Floor), __hm_break30=false;
for (var __hm_index29=0; __hm_index29<array_length(__hm_with28); ++__hm_index29) {
if(instance_exists(__hm_with28[__hm_index29])) with (__hm_with28[__hm_index29]) {
if ((random(100) < 1)) {
{ var __hm_with31 = scrHMInstances(instance_create(x, (y - (view_height / 2)), Effect)), __hm_break33=false;
for (var __hm_index32=0; __hm_index32<array_length(__hm_with31); ++__hm_index32) {
if(instance_exists(__hm_with31[__hm_index32])) with (__hm_with31[__hm_index32]) {
{
sprite_index = global.hm_module_vars[$ "area:caves"].skycrystal;
name = "skycrystal";
depth = (- 12);
image_alpha = 0;
}
}
if(__hm_break33) break;
}}
}
}
if(__hm_break30) break;
}}
if ((GameCont.subarea == 3)) {
hm_arkintide_mod_gml_hm_jungle_entrance();
}
}

// Source areas/caves.area.gml:0; area_pop_enemies (native content 1.1.0)
function hm_areas_caves_area_gml_area_pop_enemies() {
if ((random((2 * GameCont.subarea)) < 1)) {
instance_create((x + 16), (y + 16), Spider);
}
if ((random(2) < 1.5)) {
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), LaserCrystal)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
id.sleep = 1;
}
if(__hm_break3) break;
}}
}
if ((random(45) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create((x + 16), (y + 16), LightningCrystal)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
id.sleep = 1;
}
if(__hm_break6) break;
}}
}
if ((random(50) < 1)) {
scrHMModCall("mod", "enemies", "plasmacrystal_create", (x + 16), (y + 16));
}
if ((random((12 * GameCont.subarea)) < 1)) {
scrHMModCall("mod", "enemies", "bigcrystal_create", (x + 16), (y + 16));
}
if ((GameCont.subarea > 1)) {
{
if ((random(24) < 1)) {
{ var __hm_with7 = scrHMInstances(instance_create((x + 16), (y + 16), LightningCrystal)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
id.sleep = 1;
}
if(__hm_break9) break;
}}
}
if ((random(32) < 1)) {
scrHMModCall("mod", "enemies", "bigcrystal_create", (x + 16), (y + 16));
}
}
} else {
{
if ((random(3) < 1)) {
instance_create((x + random_range(10, 20)), (y + random_range(10, 20)), Cocoon);
}
if ((random(32) < 1)) {
scrHMModCall("mod", "enemies", "SpiderPit_create", (x + 16), (y + 16));
}
}
}
hm_arkintide_mod_gml_hm_loop_population(4);
;
}

// Source areas/caves.area.gml:134; area_pop_props

function hm_areas_caves_area_gml_area_pop_props() {

if ((random(4) < 1)) {

{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), Crystal)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

if ((random(2) < 1)) {

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

spr_dead = global.hm_module_vars[$ "area:caves"].sprCrystalPropBlueDead;

}

} else {

{

spr_idle = sprCrystalPropGreen;

spr_hurt = sprCrystalPropGreenHurt;

spr_dead = global.hm_module_vars[$ "area:caves"].sprCrystalPropGreenDead;

}

}

}

}

}

if(__hm_break3) break;

}}

}

if ((GameCont.subarea == 1)) {

if ((random(16) < 1)) {

instance_create((x + 16), (y + 16), BonePile);

}

}

}



// Source areas/caves.area.gml:0; area_mapdata (native content 1.1.0)
function hm_areas_caves_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return hm_arkintide_mod_gml_hm_mapdata("caves", _hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll);
;
}

