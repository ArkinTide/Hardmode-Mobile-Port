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

// Source areas/sewers.area.gml:24; area_transit
function hm_areas_sewers_area_gml_area_transit() {
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

// Source areas/sewers.area.gml:32; area_finish
function hm_areas_sewers_area_gml_area_finish() {
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

// Source areas/sewers.area.gml:44; area_setup
function hm_areas_sewers_area_gml_area_setup() {
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
}

// Source areas/sewers.area.gml:54; area_start
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
case 1: // areas/sewers.area.gml:193
{
{ var __hm_with1 = scrHMInstances(Dust), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMDelete(id);
}
if(__hm_break3) break;
}}
}
_hm.pc=0;
break;
case 2: // areas/sewers.area.gml:192
_hm.wait_ticks=max(0,1); _hm.pc=1; return;
break;
case 3: // areas/sewers.area.gml:154
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
while ((_hm.vars.fll.sprite_index != sprFloor2)) _hm.vars.fll = instance_nearest((((((_hm.vars._floor.x * 2) + 10016) / 3) + random(400)) - 200), (((((_hm.vars._floor.y * 2) + 10016) / 3) + random(400)) - 200), Floor);
;
{ var __hm_with19 = scrHMInstances(_hm.vars.fll), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
{
{ var __hm_with22 = scrHMInstances(scrHMManholeCreate(x,y)), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
{
if ((GameCont.lastarea == scrHMAreaResolve("turtles"))) {
{
{ var __hm_with25 = scrHMInstances(instance_create(10016, 10016, CustomObject)), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
{
name = "pizzaexit";
sprite_index = global.hm_module_vars[$ "area:sewers"].sewersentrance;
image_index = 1;
image_speed = (0) * timescale;
var __hm_other28=scrHMOther(other);
depth = __hm_other28.depth;
}
}
if(__hm_break27) break;
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
_hm.pc=2;
break;
case 4: // areas/sewers.area.gml:153
_hm.wait_ticks=max(0,10); _hm.pc=3; return;
break;
case 5: // areas/sewers.area.gml:55
{
{ var __hm_with29 = scrHMInstances(Floor), __hm_break31=false;
for (var __hm_index30=0; __hm_index30<array_length(__hm_with29); ++__hm_index30) {
if(instance_exists(__hm_with29[__hm_index30])) with (__hm_with29[__hm_index30]) {
if ((random(7) < 1)) {
{ var __hm_with32 = scrHMInstances(instance_create(x, y, TopDecalSewers)), __hm_break34=false;
for (var __hm_index33=0; __hm_index33<array_length(__hm_with32); ++__hm_index33) {
if(instance_exists(__hm_with32[__hm_index33])) with (__hm_with32[__hm_index33]) {
dir = choose((- 1), 1);
}
if(__hm_break34) break;
}}
}
}
if(__hm_break31) break;
}}
{ var __hm_with35 = scrHMAuthoredWalls105(), __hm_break37=false;
for (var __hm_index36=0; __hm_index36<array_length(__hm_with35); ++__hm_index36) {
if(instance_exists(__hm_with35[__hm_index36])) with (__hm_with35[__hm_index36]) {
if (((place_meeting((x + 16), y, Floor) and place_meeting((x + 48), y, Wall)) and (random(3) < 1))) {
{
{ var __hm_with38 = scrHMInstances(instance_create((x + 16), (y + 2), Bones)), __hm_break40=false;
for (var __hm_index39=0; __hm_index39<array_length(__hm_with38); ++__hm_index39) {
if(instance_exists(__hm_with38[__hm_index39])) with (__hm_with38[__hm_index39]) {
{
sprite_index = sprSewerDecal;
image_xscale = 1;
}
}
if(__hm_break40) break;
}}
{ var __hm_with41 = scrHMInstances(instance_create((x + 48), (y + 2), Bones)), __hm_break43=false;
for (var __hm_index42=0; __hm_index42<array_length(__hm_with41); ++__hm_index42) {
if(instance_exists(__hm_with41[__hm_index42])) with (__hm_with41[__hm_index42]) {
{
sprite_index = sprSewerDecal;
image_xscale = (- 1);
}
}
if(__hm_break43) break;
}}
}
}
}
if(__hm_break37) break;
}}
if ((! scrHMModExists("mod", "platformer", "gce"))) {
{
if ((GameCont.lastarea == scrHMAreaResolve("oasis"))) {
{
{ var __hm_with44 = scrHMMatchingNE(Floor, "object_index", FloorExplo), __hm_break46=false;
for (var __hm_index45=0; __hm_index45<array_length(__hm_with44); ++__hm_index45) {
if(instance_exists(__hm_with44[__hm_index45])) with (__hm_with44[__hm_index45]) {
if ((distance_to_point(10000, 10000) < 64)) {
if (((place_meeting(((x + 16) + 24), (y + 16), Wall) && place_meeting(((x + 16) - 32), (y + 16), Floor)) || place_meeting(x, (y - 32), CustomObject))) {
{
scrHMSewerClear((x + 16), (y + 16));
{ var __hm_with47 = scrHMInstances(instance_create(x, y, CustomObject)), __hm_break49=false;
for (var __hm_index48=0; __hm_index48<array_length(__hm_with47); ++__hm_index48) {
if(instance_exists(__hm_with47[__hm_index48])) with (__hm_with47[__hm_index48]) {
{
sprite_index = global.hm_module_vars[$ "area:sewers"].sewagefloor;
name = "sewagefloor";
image_xscale = 0.8;
image_yscale = 0.8;
scrHMWaterSurface111();
image_speed = (0) * timescale;
var __hm_other50=scrHMOther(other);
depth = (__hm_other50.depth + 1);
}
}
if(__hm_break49) break;
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
if(__hm_break46) break;
}}
}
}
{ var __hm_with51 = scrHMMatchingNE(Floor, "object_index", FloorExplo), __hm_break53=false;
for (var __hm_index52=0; __hm_index52<array_length(__hm_with51); ++__hm_index52) {
if(instance_exists(__hm_with51[__hm_index52])) with (__hm_with51[__hm_index52]) {
if (((distance_to_point(10000, 10000) > 64) and (random((100 / GameCont.subarea)) < 1))) {
if (((place_meeting(((x + 16) + 24), (y + 16), Wall) && place_meeting(((x + 16) - 32), (y + 16), Floor)) || place_meeting(x, (y - 32), CustomObject))) {
{
scrHMSewerClear((x + 16), (y + 16));
{ var __hm_with54 = scrHMInstances(instance_create(x, y, CustomObject)), __hm_break56=false;
for (var __hm_index55=0; __hm_index55<array_length(__hm_with54); ++__hm_index55) {
if(instance_exists(__hm_with54[__hm_index55])) with (__hm_with54[__hm_index55]) {
{
sprite_index = global.hm_module_vars[$ "area:sewers"].sewagefloor;
name = "sewagefloor";
image_xscale = 0.8;
image_yscale = 0.8;
scrHMWaterSurface111();
image_speed = (0) * timescale;
var __hm_other57=scrHMOther(other);
depth = (__hm_other57.depth + 1);
}
}
if(__hm_break56) break;
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
if(__hm_break53) break;
}}
{ var __hm_with58 = scrHMMatchingNE(Floor, "object_index", FloorExplo), __hm_break60=false;
for (var __hm_index59=0; __hm_index59<array_length(__hm_with58); ++__hm_index59) {
if(instance_exists(__hm_with58[__hm_index59])) with (__hm_with58[__hm_index59]) {
if (((distance_to_point(10000, 10000) > 64) and (distance_to_object(CustomObject) < 64))) {
if (((place_meeting(((x + 16) + 24), (y + 16), Wall) && place_meeting(((x + 16) - 32), (y + 16), Floor)) || place_meeting(x, (y - 32), CustomObject))) {
{
scrHMSewerClear((x + 16), (y + 16));
{ var __hm_with61 = scrHMInstances(instance_create(x, y, CustomObject)), __hm_break63=false;
for (var __hm_index62=0; __hm_index62<array_length(__hm_with61); ++__hm_index62) {
if(instance_exists(__hm_with61[__hm_index62])) with (__hm_with61[__hm_index62]) {
{
sprite_index = global.hm_module_vars[$ "area:sewers"].sewagefloor;
name = "sewagefloor";
image_xscale = 0.8;
image_yscale = 0.8;
scrHMWaterSurface111();
image_speed = (0) * timescale;
var __hm_other64=scrHMOther(other);
depth = (__hm_other64.depth + 1);
}
}
if(__hm_break63) break;
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
if(__hm_break60) break;
}}
}
}
if (((GameCont.lastarea != scrHMAreaResolve("oasis")) and (GameCont.lastsubarea == 5))) {
instance_create(10000, 10000, Floor);
}
if ((GameCont.subarea == 3)) {
{ var __hm_with65 = scrHMInstances(instance_furthest(10016, 10016, Floor)), __hm_break67=false;
for (var __hm_index66=0; __hm_index66<array_length(__hm_with65); ++__hm_index66) {
if(instance_exists(__hm_with65[__hm_index66])) with (__hm_with65[__hm_index66]) {
{
scrHMSewerClear((x + 16), (y + 16));
;
scrHMGatorGroup109((x + 16), (y + 16));
;
repeat ((5 * (GameCont.loops + 1))) instance_create((x + 16), (y + 16), Gator);
}
}
if(__hm_break67) break;
}}
}
{ var __hm_with68 = scrHMInstances(Rat), __hm_break70=false;
for (var __hm_index69=0; __hm_index69<array_length(__hm_with68); ++__hm_index69) {
if(instance_exists(__hm_with68[__hm_index69])) with (__hm_with68[__hm_index69]) {
if (((instance_nearest(x, y, Floor)).traction == 2)) {
{
if ((random(10) < 1)) {
{ var __hm_with71 = scrHMInstances(instance_create((x + 16), (y + 16), Crab)), __hm_break73=false;
for (var __hm_index72=0; __hm_index72<array_length(__hm_with71); ++__hm_index72) {
if(instance_exists(__hm_with71[__hm_index72])) with (__hm_with71[__hm_index72]) {
{
spr_dead = global.hm_module_vars[$ "area:sewers"].crabdead;
friction = (0.6) * (timescale * timescale);
}
}
if(__hm_break73) break;
}}
} else {
instance_create(x, y, Exploder);
}
instance_destroy();
}
}
}
if(__hm_break70) break;
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

// Source areas/sewers.area.gml:226; area_pop_enemies
function hm_areas_sewers_area_gml_area_pop_enemies() {
if ((((instance_nearest(x, y, Floor)).styleb == 1) and (random(3) < 1))) {
{
if ((random(((24 / GameCont.loops) - GameCont.subarea)) < 1)) {
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

scrHMLoopBuffGator109(x+16,y+16);
}

// Source areas/sewers.area.gml:241; area_pop_props
function hm_areas_sewers_area_gml_area_pop_props() {
if ((((instance_nearest(x, y, Floor)).styleb == 0) and (random(18) < 1))) {
instance_create((x + 16), (y + 16), Pipe);
}
}

// Source areas/sewers.area.gml:244; area_mapdata
function hm_areas_sewers_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
if ((_hml_lp == "scorpionboss")) {
return [(_hml_lx + 9), 0];
} else {
if ((_hml_lp == "oasis")) {
return [(_hml_lx + 9), 0];
} else {
return [_hml_lx, 0];
}
}
;
}
