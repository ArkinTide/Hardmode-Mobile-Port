// Source areas/icecave.area.gml:1; __load
function hm_areas_icecave_area_gml___load() {
global.hm_module_vars[$ "area:icecave"].trans = sprHM_areas_icecave_area_1;
global.hm_module_vars[$ "area:icecave"].bot = sprHM_areas_icecave_area_2;
global.hm_module_vars[$ "area:icecave"].decal = sprHM_areas_icecave_area_3;
global.hm_module_vars[$ "area:icecave"].sprCrystalPropBlueDead = sprHM_areas_icecave_area_4;
global.hm_module_vars[$ "area:icecave"].sprCrystalPropGreenDead = sprHM_areas_icecave_area_5;
}

// Source areas/icecave.area.gml:7; area_name
function hm_areas_icecave_area_gml_area_name() {
return "4-?";
;
}

// Source areas/icecave.area.gml:10; area_sprite
function hm_areas_icecave_area_gml_area_sprite(_hml_q) {
switch (_hml_q) {
case sprFloor1:
return sprFloor5B;
;
case sprFloor1B:
return sprFloor5B;
;
case sprFloor1Explo:
return sprFloor5Explo;
;
case sprWall1Trans:
return sprWall5Trans;
;
case sprWall1Bot:
return global.hm_module_vars[$ "area:icecave"].bot;
;
case sprWall1Out:
return sprWall5Out;
;
case sprWall1Top:
return sprWall5Top;
;
case sprDebris1:
return sprDebris5;
;
case sprDetail1:
return sprDetail5;
;
}
}

// Source areas/icecave.area.gml:23; area_transit
function hm_areas_icecave_area_gml_area_transit() {
if (((lastarea != scrHMAreaResolve("icecave")) && (area == scrHMAreaResolve("cavesecret")))) {
{
area = scrHMAreaResolve("icecave");
;
}
}
}

// Source areas/icecave.area.gml:28; area_finish
function hm_areas_icecave_area_gml_area_finish() {
area = scrHMAreaResolve("city");
;
subarea = 1;
;
scrHMSpriteRestore(sprSpiderIdle);
;
scrHMSpriteRestore(sprSpiderWalk);
;
scrHMSpriteRestore(sprSpiderHurt);
;
scrHMSpriteRestore(sprSpiderDead);
;
}

// Source areas/icecave.area.gml:35; area_setup
function hm_areas_icecave_area_gml_area_setup() {
scrHMSoundStopAll();
scrHMSoundMusic(mus100);
goal = 110;
;
background_set_colour(make_color_rgb(180, 189, 197));
;
BackCont.shadow_color = 786950;
;
TopCont.darkness = 1;
;
}

// Source areas/icecave.area.gml:44; area_make_floor
function hm_areas_icecave_area_gml_area_make_floor() {
instance_create(x, y, Floor);
var _hml_turn = choose(0, 0, 0, 0, 90, 90, 90, (- 90), (- 90), (- 90), 180);
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
if ((random(16) < 1)) {
{
instance_create(x, y, FloorMaker);
;
}
}
}
}

// Source areas/icecave.area.gml:64; area_start
function hm_areas_icecave_area_gml_area_start() {
{ var __hm_with1 = scrHMInstances(enemy), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
friction = (0.1) * (timescale * timescale);
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMAuthoredWalls105(), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if ((random(6) < 1)) {
{
if (place_meeting((x + 16), y, Floor)) {
{ var __hm_with7 = scrHMInstances(instance_create((x + 16), y, Bones)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
sprite_index = global.hm_module_vars[$ "area:icecave"].decal;
image_xscale = 1;
{ var __hm_with10 = scrHMInstances(instance_create(x, y, Crystal)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
image_alpha = 0;
mask_index = mskNone;
spr_shadow = mskNone;
var __hm_other13=scrHMOther(other);
creator = __hm_other13;
}
}
if(__hm_break12) break;
}}
}
}
if(__hm_break9) break;
}}
} else {
if (place_meeting((x - 16), y, Floor)) {
{ var __hm_with14 = scrHMInstances(instance_create(x, y, Bones)), __hm_break16=false;
for (var __hm_index15=0; __hm_index15<array_length(__hm_with14); ++__hm_index15) {
if(instance_exists(__hm_with14[__hm_index15])) with (__hm_with14[__hm_index15]) {
{
sprite_index = global.hm_module_vars[$ "area:icecave"].decal;
image_xscale = (- 1);
{ var __hm_with17 = scrHMInstances(instance_create(x, y, Crystal)), __hm_break19=false;
for (var __hm_index18=0; __hm_index18<array_length(__hm_with17); ++__hm_index18) {
if(instance_exists(__hm_with17[__hm_index18])) with (__hm_with17[__hm_index18]) {
{
image_alpha = 0;
mask_index = mskNone;
spr_shadow = mskNone;
var __hm_other20=scrHMOther(other);
creator = __hm_other20;
}
}
if(__hm_break19) break;
}}
}
}
if(__hm_break16) break;
}}
}
}
}
}
}
if(__hm_break6) break;
}}
{ var __hm_with21 = scrHMInstances(Floor), __hm_break23=false;
for (var __hm_index22=0; __hm_index22<array_length(__hm_with21); ++__hm_index22) {
if(instance_exists(__hm_with21[__hm_index22])) with (__hm_with21[__hm_index22]) {
{
traction = 0.1;
}
}
if(__hm_break23) break;
}}
scrHMSpriteReplace(sprSpiderIdle, sprHM_areas_icecave_area_94);
scrHMSpriteReplace(sprSpiderWalk, sprHM_areas_icecave_area_95);
scrHMSpriteReplace(sprSpiderHurt, sprHM_areas_icecave_area_96);
scrHMSpriteReplace(sprSpiderDead, sprHM_areas_icecave_area_97);
}

// Source areas/icecave.area.gml:98; area_pop_enemies
function hm_areas_icecave_area_gml_area_pop_enemies() {
if ((random(4) < 1)) {
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), Spider)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
raddrop += 50;
}
if(__hm_break3) break;
}}
}
if ((random(32) < 1)) {
instance_create((x + 16), (y + 16), LaserCrystal);
}
if ((random(14) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create((x + 16), (y + 16), LightningCrystal)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
spr_fire = sprLaserCrystalFire;
}
if(__hm_break6) break;
}}
}
if ((random(14) < 1)) {
scrHMModCall("mod", "enemies", "plasmacrystal_create", (x + 16), (y + 16));
}
if ((random(64) < 1)) {
repeat (10) instance_create((x + 16), (y + 16), Wolf);
}
if ((random(8) < 1)) {
scrHMModCall("mod", "enemies", "bigcrystal_create", (x + 16), (y + 16));
}
if ((random(32) < 1)) {
scrHMModCall("mod", "enemies", "EliteSpider_create", (x + 16), (y + 16));
}
}

// Source areas/icecave.area.gml:108; area_pop_props
function hm_areas_icecave_area_gml_area_pop_props() {
if ((random(4) < 1)) {
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), Crystal)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if ((random(2) < 1)) {
{
spr_idle = sprCrystalPropBlue;
spr_hurt = sprCrystalPropBlueHurt;
spr_dead = global.hm_module_vars[$ "area:icecave"].sprCrystalPropBlueDead;
}
} else {
{
spr_idle = sprCrystalPropGreen;
spr_hurt = sprCrystalPropGreenHurt;
spr_dead = global.hm_module_vars[$ "area:icecave"].sprCrystalPropGreenDead;
}
}
}
}
if(__hm_break3) break;
}}
}
if ((random(12) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create((x + 16), (y + 16), Hydrant)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
spr_idle = sprIcicle;
spr_hurt = sprIcicleHurt;
spr_dead = sprIcicleDead;
}
}
if(__hm_break6) break;
}}
}
}

// Source areas/icecave.area.gml:127; area_mapdata
function hm_areas_icecave_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return [_hml_lx, 0];
;
}
