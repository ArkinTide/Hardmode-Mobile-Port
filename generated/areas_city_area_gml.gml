// Source areas/city.area.gml:1; __load
function hm_areas_city_area_gml___load() {
global.hm_module_vars[$ "area:city"].snowsniperidle = sprHM_areas_city_area_2;
global.hm_module_vars[$ "area:city"].snowsniperwalk = sprHM_areas_city_area_3;
global.hm_module_vars[$ "area:city"].snowsniperhurt = sprHM_areas_city_area_4;
global.hm_module_vars[$ "area:city"].snowsniperdead = sprHM_areas_city_area_5;
}

// Source areas/city.area.gml:7; area_name
function hm_areas_city_area_gml_area_name() {
return ("5-" + string(GameCont.subarea));
;
}

// Source areas/city.area.gml:10; area_sprite
function hm_areas_city_area_gml_area_sprite(_hml_q) {
switch (_hml_q) {
case sprFloor1:
return sprFloor5;
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
return sprWall5Bot;
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

// Source areas/city.area.gml:23; area_transit
function hm_areas_city_area_gml_area_transit() {
if ((((lastarea != scrHMAreaResolve("city")) && (lastarea == scrHMAreaResolve("caves"))) && (lastsubarea >= 5))) {
{
area = scrHMAreaResolve("city");
;
subarea = 1;
;
}
}
}

// Source areas/city.area.gml:29; area_finish
function hm_areas_city_area_gml_area_finish() {
if ((subarea < 5)) {
{
area = scrHMAreaResolve("city");
;
subarea += 1;
;
}
} else {
{
area = scrHMAreaResolve("labs");
;
subarea = 1;
;
}
}
}

// Source areas/city.area.gml:39; area_setup
function hm_areas_city_area_gml_area_setup() {
{ var __hm_with1 = scrHMInstances(GenCont), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
safespawn = 3;
}
if(__hm_break3) break;
}}
scrHMSoundMusic(mus5);
scrHMSoundAmbient(amb5);
;
goal = 110;
;
background_set_colour(make_color_rgb(180, 189, 197));
;
BackCont.shadow_color = 4461326;
;
scrHMSpriteReplace(sprLilHunterGun, sprHM_areas_city_area_48);
scrHMSpriteReplace(sprGoldTankIdle, sprHM_areas_city_area_49);
scrHMSpriteReplace(sprGoldTankWalk, sprHM_areas_city_area_50);
scrHMSpriteReplace(sprGoldTankDead, sprHM_areas_city_area_51);
scrHMSpriteReplace(sprGoldTankHurt, sprHM_areas_city_area_52);
scrHMSpriteReplace(sprGoldTankExplode, sprHM_areas_city_area_53);
}

// Source areas/city.area.gml:55; area_start
function hm_areas_city_area_gml_area_start() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_areas_city_area_gml_area_start_resume, id, scrHMOther(other), _args, 9, []);
}
function hm_areas_city_area_gml_area_start_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_areas_city_area_gml_area_start");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // areas/city.area.gml:64
{
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((random(7) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create(x, y, TopDecalCity)), __hm_break6=false;
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
sprite_index = sprIceDecal;
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
sprite_index = sprIceDecal;
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
if ((GameCont.subarea == 5)) {
scrHMLilHunterPending109();
}
{ var __hm_with16 = scrHMInstances(Floor), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
if ((styleb == 1)) {
traction = 0.1;
}
}
if(__hm_break18) break;
}}
if ((GameCont.subarea == 3)) {
scrHMModCall("mod", "titank", "wanttitank");
}
{ var __hm_with19 = scrHMMatching(Floor, "styleb", 1), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
{
depth -= 0.1;
{ var __hm_with22 = scrHMInstances(instance_create(x, y, SnowFloor)), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
{
var __hm_other25=scrHMOther(other);
depth = (__hm_other25.depth + 0.05);
image_speed = (0) * timescale;
var __hm_other26=scrHMOther(other);
image_index = __hm_other26.image_index;
}
}
if(__hm_break24) break;
}}
}
}
if(__hm_break21) break;
}}
}
_hm.pc=0;
break;
case 2: // areas/city.area.gml:62
{
;
}
_hm.pc=1;
break;
case 3: // areas/city.area.gml:62
_hm.result=undefined; _hm.done=true; return;
break;
case 4: // areas/city.area.gml:61
{
instance_create(10016, 10016, IDPDSpawn);
}
_hm.pc=3;
break;
case 5: // areas/city.area.gml:60
_hm.wait_ticks=max(0,100); _hm.pc=4; return;
break;
case 6: // areas/city.area.gml:59
{
instance_create(10016, 10016, IDPDSpawn);
}
_hm.pc=5;
break;
case 7: // areas/city.area.gml:58
_hm.wait_ticks=max(0,200); _hm.pc=6; return;
break;
case 8: // areas/city.area.gml:57
_hm.pc = (scrHMTaskFork(_hm, 7)) ? 7 : 1;
break;
case 9: // areas/city.area.gml:56
_hm.pc = (((GameCont.loops == 0) and (GameCont.subarea != 3))) ? 8 : 1;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source areas/city.area.gml:108; area_make_floor
function hm_areas_city_area_gml_area_make_floor() {
var _hml_turn = choose(0, 0, 0, 0, 90, 180);
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
if (((_hml_turn == 180) && (point_distance(x, y, 10016, 10016) > 48))) {
{
instance_create(x, y, Floor);
;
instance_create((x + 16), (y + 16), WeaponChest);
;
}
}
if ((random(11) < 1)) {
{
if ((random(2) < 1)) {
{
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
{
instance_create((x + 64), (y - 64), Floor);
instance_create((x + 64), (y - 32), Floor);
instance_create((x + 64), y, Floor);
instance_create((x + 64), (y + 32), Floor);
instance_create((x + 64), (y + 64), Floor);
instance_create((x - 64), (y - 64), Floor);
instance_create((x - 64), (y - 32), Floor);
instance_create((x - 64), y, Floor);
instance_create((x - 64), (y + 32), Floor);
instance_create((x - 64), (y + 64), Floor);
instance_create(x, (y - 64), Floor);
instance_create((x - 32), (y - 64), Floor);
instance_create((x + 32), (y - 64), Floor);
instance_create(x, (y + 64), Floor);
instance_create((x - 32), (y + 64), Floor);
instance_create((x + 32), (y + 64), Floor);
}
}
}
} else {
instance_create(x, y, Floor);
}
if ((random((20 + instance_number(FloorMaker))) > ((20 / GameCont.loops) + 1))) {
{
if ((point_distance(x, y, 10016, 10016) > 48)) {
{
instance_create((x + 16), (y + 16), AmmoChest);
;
instance_create(x, y, Floor);
;
}
}
instance_create(x, y, FloorMaker);
instance_destroy();
;
}
}
}

// Source areas/city.area.gml:172; area_pop_enemies
function hm_areas_city_area_gml_area_pop_enemies() {
if ((random(4) < 1)) {
instance_create((x + 16), (y + 16), SnowTank);
}
if ((random(12) < 1)) {
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), Sniper)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
spr_idle = global.hm_module_vars[$ "area:city"].snowsniperidle;
;
spr_walk = global.hm_module_vars[$ "area:city"].snowsniperwalk;
;
spr_hurt = global.hm_module_vars[$ "area:city"].snowsniperhurt;
;
spr_dead = global.hm_module_vars[$ "area:city"].snowsniperdead;
;
hitid = [global.hm_module_vars[$ "area:city"].snowsniperidle, "SNIPER"];
}
}
if(__hm_break3) break;
}}
}
if ((random(10) < 1)) {
repeat (4) instance_create((x + 16), (y + 16), Wolf);
}
if ((random(5) < 1)) {
instance_create((x + 16), (y + 16), SnowBot);
}
if ((GameCont.subarea != 3)) {
{
if ((random(67) < GameCont.subarea)) {
repeat (5) {
if ((random(10) < 1)) {
instance_create((x + 16), (y + 16), Inspector);
} else {
if ((random(20) < 1)) {
instance_create((x + 16), (y + 16), Shielder);
} else {
if ((random(120) < GameCont.subarea)) {
instance_create((x + 16), (y + 16), EliteGrunt);
} else {
if ((random(120) < GameCont.subarea)) {
instance_create((x + 16), (y + 16), EliteInspector);
} else {
if ((random(120) < GameCont.subarea)) {
instance_create((x + 16), (y + 16), EliteShielder);
} else {
instance_create((x + 16), (y + 16), Grunt);
}
}
}
}
}
}
}
}
}

scrHMLoopCrystal109(x+16,y+16);
}

// Source areas/city.area.gml:195; area_pop_props
function hm_areas_city_area_gml_area_pop_props() {
if ((random(12) < 1)) {
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), Hydrant)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((random(3) < 1)) {
{
spr_idle = sprIcicle;
spr_hurt = sprIcicleHurt;
spr_dead = sprIcicleDead;
}
}
}
if(__hm_break3) break;
}}
}
if ((random(24) < 1)) {
instance_create((x + 16), (y + 16), StreetLight);
}
if ((random(64) < 1)) {
instance_create((x + 16), (y + 16), SodaMachine);
}
}

// Source areas/city.area.gml:205; area_mapdata
function hm_areas_city_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
if ((_hml_lp == (("caves" || "invcaves") || "icecave"))) {
return [(_hml_lx + 9), 0];
} else {
return [_hml_lx, 0];
}
;
}
