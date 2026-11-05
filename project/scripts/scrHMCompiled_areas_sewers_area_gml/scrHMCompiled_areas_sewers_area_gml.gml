// Source areas/sewers.area.gml:1; __load

function hm_areas_sewers_area_gml___load() {

global.hm_module_vars[$ "area:sewers"].sewersentrance = sprHM_areas_sewers_area_2;

global.hm_module_vars[$ "area:sewers"].sewagefloortop = sprHM_areas_sewers_area_3;

global.hm_module_vars[$ "area:sewers"].sewagefloor = sprHM_areas_sewers_area_4;

global.hm_module_vars[$ "area:sewers"].sewerfloorexplo = sprHM_areas_sewers_area_5;

global.hm_module_vars[$ "area:sewers"].crabdead = sprHM_areas_sewers_area_6;

}



// Source areas/sewers.area.gml:8; area_name

function hm_areas_sewers_area_gml_area_name() {

return ("2-" + string(GameCont.subarea));

;

}



// Source areas/sewers.area.gml:11; area_sprite

function hm_areas_sewers_area_gml_area_sprite(_hml_q) {

switch (_hml_q) {

case sprFloor1:

return sprFloor2;

;

case sprFloor1B:

return sprFloor2B;

;

case sprFloor1Explo:

return sprFloor2Explo;

;

case sprWall1Trans:

return sprWall2Trans;

;

case sprWall1Bot:

return sprWall2Bot;

;

case sprWall1Out:

return sprWall2Out;

;

case sprWall1Top:

return sprWall2Top;

;

case sprDebris1:

return sprDebris2;

;

case sprDetail1:

return sprDetail2;

;

}

}



// Source areas/sewers.area.gml:0; area_transit (native content 1.1.0)
function hm_areas_sewers_area_gml_area_transit() {
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
if (((lastarea != scrHMAreaResolve("sewers")) && (lastarea == scrHMAreaResolve("turtles")))) {
{
area = scrHMAreaResolve("sewers");
;
}
}
if (((lastarea != scrHMAreaResolve("sewers")) && (lastarea == scrHMAreaResolve("scorpionboss")))) {
{
area = scrHMAreaResolve("sewers");
;
}
}
}

// Source areas/sewers.area.gml:0; area_finish (native content 1.1.0)
function hm_areas_sewers_area_gml_area_finish() {
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
subarea += 1;
} else {
{
area = scrHMAreaResolve(3);
;
subarea = 1;
scrHMSoundRestore(sndOasisCrabAttack);
;
}
}
}

// Source areas/sewers.area.gml:0; area_setup (native content 1.1.0)
function hm_areas_sewers_area_gml_area_setup() {
GameCont.hm_destination = "";
;
goal = 110;
;
background_set_colour(make_color_rgb(76, 89, 70));
;
BackCont.shadow_color = c_black;
;
TopCont.fog = sprFog2;
;
TopCont.darkness = 1;
;
scrHMSoundMusic(mus2);
;
scrHMSoundAmbient(amb2);
;
scrHMSoundAssign(sndOasisCrabAttack, sndScorpionFireStart);
hm_arkintide_mod_gml_hm_map_budget();
;
}

// Source areas/sewers.area.gml:0; area_start (native content 1.1.0)
function hm_areas_sewers_area_gml_area_start() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_areas_sewers_area_gml_area_start_resume, id, scrHMOther(other), _args, 5, []);
}
function hm_areas_sewers_area_gml_area_start_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_areas_sewers_area_gml_area_start");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // areas/sewers.area.gml:220
{
{ var __hm_with1 = scrHMInstances(Dust), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMDelete(id);
}
if(__hm_break3) break;
}}
hm_arkintide_mod_gml_hm_water_invalidate();
;
}
_hm.pc=0;
break;
case 2: // areas/sewers.area.gml:219
_hm.wait_ticks=max(0,1); _hm.pc=1; return;
break;
case 3: // areas/sewers.area.gml:181
{
{ var __hm_with4 = scrHMMatching(FloorExplo, "sprite_index", sprFloor2Explo), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if ((distance_to_point(10000, 10000) > 48)) {
sprite_index = global.hm_module_vars[$ "area:sewers"].sewerfloorexplo;
}
}
if(__hm_break6) break;
}}
{ var __hm_with7 = scrHMMatching(CustomObject, "name", "sewagefloor"), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
if ((! position_meeting((x + 16), ((y + 16) - 32), CustomObject))) {
sprite_index = global.hm_module_vars[$ "area:sewers"].sewagefloortop;
}
}
if(__hm_break9) break;
}}
{ var __hm_with10 = scrHMMatchingNE(Floor, "name", "sewagefloor"), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
depth = (10 - (y / 10000));
}
if(__hm_break12) break;
}}
{ var __hm_with13 = scrHMMatching(Floor, "styleb", 1), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
depth -= 0.1;
}
if(__hm_break15) break;
}}
{ var __hm_with16 = scrHMInstances(Debris), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
scrHMDelete(id);
}
if(__hm_break18) break;
}}
_hm.vars._floor = instance_furthest(10016, 10016, Floor);
;
if (((GameCont.subarea == 2) || (GameCont.lastarea == scrHMAreaResolve("turtles")))) {
{
_hm.vars.fll = instance_nearest((((((_hm.vars._floor.x * 2) + 10016) / 3) + random(128)) - 64), (((((_hm.vars._floor.y * 2) + 10016) / 3) + random(128)) - 64), Floor);
;
_hm.vars.fll = hm_arkintide_mod_gml_hm_manhole_floor(_hm.vars.fll);
;
if (instance_exists(_hm.vars.fll)) {
{ var __hm_with19 = scrHMInstances(_hm.vars.fll), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
{
{ var __hm_with22 = scrHMInstances(instance_create((x + 16), (y + 16), PizzaEntrance)), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
{
var __hm_other25=scrHMOther(other);
depth = (__hm_other25.depth - 0.01);
;
if ((GameCont.lastarea == scrHMAreaResolve("turtles"))) {
{
{ var __hm_with26 = scrHMInstances(instance_create(10016, 10016, CustomObject)), __hm_break28=false;
for (var __hm_index27=0; __hm_index27<array_length(__hm_with26); ++__hm_index27) {
if(instance_exists(__hm_with26[__hm_index27])) with (__hm_with26[__hm_index27]) {
{
name = "pizzaexit";
sprite_index = global.hm_module_vars[$ "area:sewers"].sewersentrance;
image_index = 1;
image_speed = (0) * timescale;
var __hm_other29=scrHMOther(other);
depth = __hm_other29.depth;
}
}
if(__hm_break28) break;
}}
instance_destroy();
}
}
}
}
if(__hm_break24) break;
}}
}
}
if(__hm_break21) break;
}}
}
}
}
}
_hm.pc=2;
break;
case 4: // areas/sewers.area.gml:180
_hm.wait_ticks=max(0,10); _hm.pc=3; return;
break;
case 5: // areas/sewers.area.gml:78
{
hm_arkintide_mod_gml_hm_native_unlock_area();
;
{ var __hm_with30 = scrHMInstances(Floor), __hm_break32=false;
for (var __hm_index31=0; __hm_index31<array_length(__hm_with30); ++__hm_index31) {
if(instance_exists(__hm_with30[__hm_index31])) with (__hm_with30[__hm_index31]) {
if ((random(7) < 1)) {
{ var __hm_with33 = scrHMInstances(instance_create(x, y, TopDecalSewers)), __hm_break35=false;
for (var __hm_index34=0; __hm_index34<array_length(__hm_with33); ++__hm_index34) {
if(instance_exists(__hm_with33[__hm_index34])) with (__hm_with33[__hm_index34]) {
dir = choose((- 1), 1);
}
if(__hm_break35) break;
}}
}
}
if(__hm_break32) break;
}}
{ var __hm_with36 = scrHMAuthoredWalls105(), __hm_break38=false;
for (var __hm_index37=0; __hm_index37<array_length(__hm_with36); ++__hm_index37) {
if(instance_exists(__hm_with36[__hm_index37])) with (__hm_with36[__hm_index37]) {
if (((place_meeting((x + 16), y, Floor) and place_meeting((x + 48), y, Wall)) and (random(3) < 1))) {
{
{ var __hm_with39 = scrHMInstances(instance_create((x + 16), (y + 2), Bones)), __hm_break41=false;
for (var __hm_index40=0; __hm_index40<array_length(__hm_with39); ++__hm_index40) {
if(instance_exists(__hm_with39[__hm_index40])) with (__hm_with39[__hm_index40]) {
{
sprite_index = sprSewerDecal;
image_xscale = 1;
}
}
if(__hm_break41) break;
}}
{ var __hm_with42 = scrHMInstances(instance_create((x + 48), (y + 2), Bones)), __hm_break44=false;
for (var __hm_index43=0; __hm_index43<array_length(__hm_with42); ++__hm_index43) {
if(instance_exists(__hm_with42[__hm_index43])) with (__hm_with42[__hm_index43]) {
{
sprite_index = sprSewerDecal;
image_xscale = (- 1);
}
}
if(__hm_break44) break;
}}
}
}
}
if(__hm_break38) break;
}}
if ((! scrHMModExists("mod", "platformer", "gce"))) {
{
if ((GameCont.lastarea == scrHMAreaResolve("oasis"))) {
{
{ var __hm_with45 = scrHMMatchingNE(Floor, "object_index", FloorExplo), __hm_break47=false;
for (var __hm_index46=0; __hm_index46<array_length(__hm_with45); ++__hm_index46) {
if(instance_exists(__hm_with45[__hm_index46])) with (__hm_with45[__hm_index46]) {
if ((distance_to_point(10000, 10000) < 64)) {
if (((place_meeting(((x + 16) + 24), (y + 16), Wall) && place_meeting(((x + 16) - 32), (y + 16), Floor)) || place_meeting(x, (y - 32), CustomObject))) {
{
instance_create((x + 16), (y + 16), PortalClear);
{ var __hm_with48 = scrHMInstances(instance_create(x, y, CustomObject)), __hm_break50=false;
for (var __hm_index49=0; __hm_index49<array_length(__hm_with48); ++__hm_index49) {
if(instance_exists(__hm_with48[__hm_index49])) with (__hm_with48[__hm_index49]) {
{
sprite_index = global.hm_module_vars[$ "area:sewers"].sewagefloor;
name = "sewagefloor";
image_xscale = 0.8;
image_yscale = 0.8;
image_speed = (0) * timescale;
var __hm_other51=scrHMOther(other);
depth = (__hm_other51.depth + 1);
var __hm_other52=scrHMOther(other);
hm_arkintide_mod_gml_hm_water_link(__hm_other52);
;
}
}
if(__hm_break50) break;
}}
name = "sewagefloor";
styleb = 1;
sprite_index = mskNone;
traction = 2;
depth += 10;
image_alpha = 0;
}
}
}
}
if(__hm_break47) break;
}}
}
}
{ var __hm_with53 = scrHMMatchingNE(Floor, "object_index", FloorExplo), __hm_break55=false;
for (var __hm_index54=0; __hm_index54<array_length(__hm_with53); ++__hm_index54) {
if(instance_exists(__hm_with53[__hm_index54])) with (__hm_with53[__hm_index54]) {
if (((distance_to_point(10000, 10000) > 64) and (random((100 / GameCont.subarea)) < 1))) {
if (((place_meeting(((x + 16) + 24), (y + 16), Wall) && place_meeting(((x + 16) - 32), (y + 16), Floor)) || place_meeting(x, (y - 32), CustomObject))) {
{
instance_create((x + 16), (y + 16), PortalClear);
{ var __hm_with56 = scrHMInstances(instance_create(x, y, CustomObject)), __hm_break58=false;
for (var __hm_index57=0; __hm_index57<array_length(__hm_with56); ++__hm_index57) {
if(instance_exists(__hm_with56[__hm_index57])) with (__hm_with56[__hm_index57]) {
{
sprite_index = global.hm_module_vars[$ "area:sewers"].sewagefloor;
name = "sewagefloor";
image_xscale = 0.8;
image_yscale = 0.8;
image_speed = (0) * timescale;
var __hm_other59=scrHMOther(other);
depth = (__hm_other59.depth + 1);
var __hm_other60=scrHMOther(other);
hm_arkintide_mod_gml_hm_water_link(__hm_other60);
;
}
}
if(__hm_break58) break;
}}
name = "sewagefloor";
styleb = 1;
sprite_index = mskNone;
traction = 2;
depth += 10;
image_alpha = 0;
}
}
}
}
if(__hm_break55) break;
}}
{ var __hm_with61 = scrHMMatchingNE(Floor, "object_index", FloorExplo), __hm_break63=false;
for (var __hm_index62=0; __hm_index62<array_length(__hm_with61); ++__hm_index62) {
if(instance_exists(__hm_with61[__hm_index62])) with (__hm_with61[__hm_index62]) {
if (((distance_to_point(10000, 10000) > 64) and (distance_to_object(CustomObject) < 64))) {
if (((place_meeting(((x + 16) + 24), (y + 16), Wall) && place_meeting(((x + 16) - 32), (y + 16), Floor)) || place_meeting(x, (y - 32), CustomObject))) {
{
instance_create((x + 16), (y + 16), PortalClear);
{ var __hm_with64 = scrHMInstances(instance_create(x, y, CustomObject)), __hm_break66=false;
for (var __hm_index65=0; __hm_index65<array_length(__hm_with64); ++__hm_index65) {
if(instance_exists(__hm_with64[__hm_index65])) with (__hm_with64[__hm_index65]) {
{
sprite_index = global.hm_module_vars[$ "area:sewers"].sewagefloor;
name = "sewagefloor";
image_xscale = 0.8;
image_yscale = 0.8;
image_speed = (0) * timescale;
var __hm_other67=scrHMOther(other);
depth = (__hm_other67.depth + 1);
var __hm_other68=scrHMOther(other);
hm_arkintide_mod_gml_hm_water_link(__hm_other68);
;
}
}
if(__hm_break66) break;
}}
name = "sewagefloor";
styleb = 1;
sprite_index = mskNone;
traction = 2;
depth += 10;
image_alpha = 0;
}
}
}
}
if(__hm_break63) break;
}}
}
}
if (((GameCont.lastarea != scrHMAreaResolve("oasis")) and (GameCont.lastsubarea == 5))) {
instance_create(10000, 10000, Floor);
}
if ((GameCont.subarea == 3)) {
{ var __hm_with69 = scrHMInstances(instance_furthest(10016, 10016, Floor)), __hm_break71=false;
for (var __hm_index70=0; __hm_index70<array_length(__hm_with69); ++__hm_index70) {
if(instance_exists(__hm_with69[__hm_index70])) with (__hm_with69[__hm_index70]) {
{
instance_create((x + 16), (y + 16), PortalClear);
;
repeat (hm_arkintide_mod_gml_hm_boss_count()) scrHMModCall("mod", "gatorboss", "gatorboss_create", (x + 16), (y + 16));
;
repeat ((5 * (GameCont.loops + 1))) instance_create((x + 16), (y + 16), Gator);
}
}
if(__hm_break71) break;
}}
}
{ var __hm_with72 = scrHMInstances(Rat), __hm_break74=false;
for (var __hm_index73=0; __hm_index73<array_length(__hm_with72); ++__hm_index73) {
if(instance_exists(__hm_with72[__hm_index73])) with (__hm_with72[__hm_index73]) {
if (hm_arkintide_mod_gml_hm_water_at(x, y)) {
{
if ((random(10) < 1)) {
{ var __hm_with75 = scrHMInstances(instance_create((x + 16), (y + 16), Crab)), __hm_break77=false;
for (var __hm_index76=0; __hm_index76<array_length(__hm_with75); ++__hm_index76) {
if(instance_exists(__hm_with75[__hm_index76])) with (__hm_with75[__hm_index76]) {
{
spr_dead = global.hm_module_vars[$ "area:sewers"].crabdead;
friction = (0.6) * (timescale * timescale);
}
}
if(__hm_break77) break;
}}
} else {
instance_create(x, y, Exploder);
}
instance_destroy();
}
}
}
if(__hm_break74) break;
}}
}
_hm.pc=4;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

// Source areas/sewers.area.gml:197; area_make_floor

function hm_areas_sewers_area_gml_area_make_floor() {

instance_create(x, y, Floor);

;

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

var _hml_turn = choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, (- 90), 180);

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

if ((random(6) < 1)) {

{

{ var __hm_with1 = scrHMInstances(instance_create(x, y, FloorMaker)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

big = choose(0, 0, 0, 0, 1);

}

}

if(__hm_break3) break;

}}

}

}

}

}



// Source areas/sewers.area.gml:0; area_pop_enemies (native content 1.1.0)
function hm_areas_sewers_area_gml_area_pop_enemies() {
if ((((instance_nearest(x, y, Floor)).styleb == 1) and (random(3) < 1))) {
{
if ((random(((24 / max(1, GameCont.loops)) - GameCont.subarea)) < 1)) {
instance_create((x + 16), (y + 16), BuffGator);
} else {
instance_create((x + 16), (y + 16), Gator);
}
;
}
}
if ((random(32) < 1)) {
instance_create((x + 16), (y + 16), Ratking);
}
instance_create((x + 16), (y + 16), Rat);
;
if ((random(32) < 1)) {
instance_create((x + 16), (y + 16), ToxicBarrel);
}
if ((random(24) < 1)) {
{
if ((GameCont.loops > 0)) {
instance_create((x + 16), (y + 16), SuperFireBaller);
} else {
instance_create((x + 16), (y + 16), FireBaller);
}
;
}
}
hm_arkintide_mod_gml_hm_loop_population(2);
;
}

// Source areas/sewers.area.gml:241; area_pop_props

function hm_areas_sewers_area_gml_area_pop_props() {

if ((((instance_nearest(x, y, Floor)).styleb == 0) and (random(18) < 1))) {

instance_create((x + 16), (y + 16), Pipe);

}

}



// Source areas/sewers.area.gml:0; area_mapdata (native content 1.1.0)
function hm_areas_sewers_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return hm_arkintide_mod_gml_hm_mapdata("sewers", _hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll);
;
}

