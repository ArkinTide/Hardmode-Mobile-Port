// Source props.mod.gml:1; __load

function hm_props_mod_gml___load() {

global.hm_module_vars[$ "mod:props"].VenuzStar = sprHM_props_mod_4;

global.hm_module_vars[$ "mod:props"].fancylid = sprHM_props_mod_6;

global.hm_module_vars[$ "mod:props"].lookout = sprHM_props_mod_7;

global.hm_module_vars[$ "mod:props"].hole = sprHM_props_mod_8;

global.hm_module_vars[$ "mod:props"].flower = sprHM_props_mod_9;

global.hm_module_vars[$ "mod:props"].iceblock = sprHM_props_mod_10;

global.hm_module_vars[$ "mod:props"].cactusbloom1 = sprHM_props_mod_11;

global.hm_module_vars[$ "mod:props"].cactusbloom2 = sprHM_props_mod_12;

global.hm_module_vars[$ "mod:props"].cactusbloom3 = sprHM_props_mod_13;

global.hm_module_vars[$ "mod:props"].ammo1 = sprHM_props_mod_14;

global.hm_module_vars[$ "mod:props"].venuz1 = sprHM_props_mod_15;

global.hm_module_vars[$ "mod:props"].VenuzBars1Side = sprHM_props_mod_16;

global.hm_module_vars[$ "mod:props"].VenuzBars1 = sprHM_props_mod_17;

global.hm_module_vars[$ "mod:props"].VenuzDoorSide = sprHM_props_mod_18;

global.hm_module_vars[$ "mod:props"].VenuzDoor = sprHM_props_mod_19;

global.hm_module_vars[$ "mod:props"].VenuzBars2Side = sprHM_props_mod_21;

global.hm_module_vars[$ "mod:props"].VenuzBars2 = sprHM_props_mod_22;

global.hm_module_vars[$ "mod:props"].VenuzDoor2Side = sprHM_props_mod_23;

global.hm_module_vars[$ "mod:props"].VenuzDoor2 = sprHM_props_mod_24;

global.hm_module_vars[$ "mod:props"].VenuzBars3 = sprHM_props_mod_25;

global.hm_module_vars[$ "mod:props"].VenuzDoor3Side = sprHM_props_mod_26;

global.hm_module_vars[$ "mod:props"].VenuzDoor3 = sprHM_props_mod_27;

global.hm_module_vars[$ "mod:props"].VenuzBars4Side = sprHM_props_mod_28;

global.hm_module_vars[$ "mod:props"].VenuzBars4 = sprHM_props_mod_29;

global.hm_module_vars[$ "mod:props"].VenuzDoor4Side = sprHM_props_mod_30;

global.hm_module_vars[$ "mod:props"].VenuzDoor4 = sprHM_props_mod_31;

global.hm_module_vars[$ "mod:props"].BigSkull = sprHM_props_mod_32;

global.hm_module_vars[$ "mod:props"].BigSkullHurt = sprHM_props_mod_33;

global.hm_module_vars[$ "mod:props"].BigSkullDead = sprHM_props_mod_34;

global.hm_module_vars[$ "mod:props"].whitecrystal = sprHM_props_mod_35;

global.hm_module_vars[$ "mod:props"].elevator = sprHM_props_mod_36;

global.hm_module_vars[$ "mod:props"].bigtube = sprHM_props_mod_37;

global.hm_module_vars[$ "mod:props"].bigtubehurt = sprHM_props_mod_38;

global.hm_module_vars[$ "mod:props"].bigtubedead = sprHM_props_mod_39;

global.hm_module_vars[$ "mod:props"].bigtube2 = sprHM_props_mod_40;

global.hm_module_vars[$ "mod:props"].bigtube2hurt = sprHM_props_mod_41;

global.hm_module_vars[$ "mod:props"].bigtube2dead = sprHM_props_mod_42;

global.hm_module_vars[$ "mod:props"].VenuzCar = sprHM_props_mod_43;

global.hm_module_vars[$ "mod:props"].VenuzCar2 = sprHM_props_mod_44;

global.hm_module_vars[$ "mod:props"].VenuzCaroutline = sprHM_props_mod_45;

global.hm_module_vars[$ "mod:props"].ClamMimicIdle = sprHM_props_mod_46;

global.hm_module_vars[$ "mod:props"].ClamMimicFire = sprHM_props_mod_47;

global.hm_module_vars[$ "mod:props"].ClamMimicTell = sprHM_props_mod_48;

global.hm_module_vars[$ "mod:props"].ClamMimicHurt = sprHM_props_mod_49;

global.hm_module_vars[$ "mod:props"].ClamMimicDead = sprHM_props_mod_50;

global.hm_module_vars[$ "mod:props"].flagdead = sprHM_props_mod_51;

global.hm_module_vars[$ "mod:props"].redflag = sprHM_props_mod_52;

global.hm_module_vars[$ "mod:props"].redflaghurt = sprHM_props_mod_53;

global.hm_module_vars[$ "mod:props"].redflagdead = sprHM_props_mod_54;

global.hm_module_vars[$ "mod:props"].blueflag = sprHM_props_mod_55;

global.hm_module_vars[$ "mod:props"].blueflaghurt = sprHM_props_mod_56;

global.hm_module_vars[$ "mod:props"].blueflagdead = sprHM_props_mod_57;

global.hm_module_vars[$ "mod:props"].yellowflag = sprHM_props_mod_58;

global.hm_module_vars[$ "mod:props"].yellowflaghurt = sprHM_props_mod_59;

global.hm_module_vars[$ "mod:props"].yellowflagdead = sprHM_props_mod_60;

}



// Source props.mod.gml:63; draw_dark

function hm_props_mod_gml_draw_dark() {

{ var __hm_with1 = scrHMMatching(enemy, "sprite_index", sprLaserCrystalFire), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

draw_set_alpha(1);

draw_set_color($808080);

draw_circle(x, y, (75 + random(3)), false);

}

}

if(__hm_break3) break;

}}

{ var __hm_with4 = scrHMMatching(CustomHitme, "name", "elevator"), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

{

draw_set_alpha(1);

draw_set_color($808080);

draw_circle(x, (y - 8), (125 + random(3)), false);

}

}

if(__hm_break6) break;

}}

{ var __hm_with7 = scrHMMatching(CustomEnemy, "light", 1), __hm_break9=false;

for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {

if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {

{

draw_set_alpha(1);

draw_set_color($808080);

draw_circle(x, y, (75 + random(3)), false);

}

}

if(__hm_break9) break;

}}

{ var __hm_with10 = scrHMMatching(CustomObject, "light", 1), __hm_break12=false;

for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {

if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {

{

draw_set_alpha(1);

draw_set_color($808080);

draw_circle(x, y, (75 + random(3)), false);

}

}

if(__hm_break12) break;

}}

}



// Source props.mod.gml:84; draw_dark_end

function hm_props_mod_gml_draw_dark_end() {

{ var __hm_with1 = scrHMMatching(enemy, "sprite_index", sprLaserCrystalFire), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

draw_set_alpha(1);

draw_set_color(0);

draw_circle(x, y, (25 + random(3)), false);

}

}

if(__hm_break3) break;

}}

{ var __hm_with4 = scrHMMatching(CustomHitme, "name", "elevator"), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

{

draw_set_alpha(1);

draw_set_color(0);

draw_circle(x, (y - 8), (50 + random(3)), false);

}

}

if(__hm_break6) break;

}}

{ var __hm_with7 = scrHMMatching(CustomEnemy, "light", 1), __hm_break9=false;

for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {

if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {

{

draw_set_alpha(1);

draw_set_color(0);

draw_circle(x, y, (25 + random(3)), false);

}

}

if(__hm_break9) break;

}}

{ var __hm_with10 = scrHMMatching(CustomObject, "light", 1), __hm_break12=false;

for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {

if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {

{

draw_set_alpha(1);

draw_set_color(0);

draw_circle(x, y, (25 + random(3)), false);

}

}

if(__hm_break12) break;

}}

{ var __hm_with13 = scrHMMatching(CustomObject, "name", "sewagefloor"), __hm_break15=false;

for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {

if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {

{

draw_set_alpha(1);

draw_set_color(0);

draw_circle((x + 16), (y + 16), (25 + random(3)), false);

}

}

if(__hm_break15) break;

}}

{ var __hm_with16 = scrHMInstances(BigTV), __hm_break18=false;

for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {

if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {

{

draw_set_alpha(1);

draw_set_color(0);

draw_circle(x, y, (100 + random(1)), false);

}

}

if(__hm_break18) break;

}}

}



// Source props.mod.gml:0; draw_shadows (native content 1.1.0)
function hm_props_mod_gml_draw_shadows() {
var _hml_shadow_objects = hm_arkintide_mod_gml_hm_shadow_objects();
;
{ var __hm_with1 = scrHMInstances(_hml_shadow_objects), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((shadow == 1)) {
scrHMDrawSpriteExt(sprite_index, image_index, x, (y + 6), image_xscale, (- 1), 0, c_black, 1);
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(_hml_shadow_objects), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if ((shadow == 2)) {
scrHMDrawSprite(shd24, 1, x, y);
}
}
if(__hm_break6) break;
}}
}

// Source props.mod.gml:0; step (native content 1.1.0)
function hm_props_mod_gml_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_props_mod_gml_step_resume, id, scrHMOther(other), _args, 31, []);
}
function hm_props_mod_gml_step_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_props_mod_gml_step");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // props.mod.gml:444
scrHMTaskWithNext(_hm);
break;
case 2: // props.mod.gml:444
scrHMTaskWithAbort(_hm);
break;
case 3: // props.mod.gml:468
{
;
}
_hm.pc=1;
break;
case 4: // props.mod.gml:468
_hm.result=undefined; _hm.done=true; return;
break;
case 5: // props.mod.gml:458
{
if (instance_exists(id)) {
{
styleb = 0;
traction = 0.4;
if ((sprite_index == sprFloor4B)) {
sprite_index = sprFloor4;
}
if ((sprite_index == sprFloor104B)) {
sprite_index = sprFloor104;
}
repeat (random(8)) instance_create(((x + random_range((- 16), 16)) + 16), ((y + random_range((- 16), 16)) + 16), GroundFlame);
}
}
}
_hm.pc=4;
break;
case 7: // props.mod.gml:449
_hm.vars.__hm_repeat1--; _hm.pc=6;
break;
case 8: // props.mod.gml:456
_hm.wait_ticks=max(0,1); _hm.pc=7; return;
break;
case 9: // props.mod.gml:450
{
{ var __hm_with2 = scrHMInstances(instance_create(((x + random_range((- 16), 16)) + 16), ((y + random_range((- 16), 16)) + 16), Flame)), __hm_break4=false;
for (var __hm_index3=0; __hm_index3<array_length(__hm_with2); ++__hm_index3) {
if(instance_exists(__hm_with2[__hm_index3])) with (__hm_with2[__hm_index3]) {
{
scrHMMotionAdd(random(360), choose(0, 0, 1, 2));
team = 2;
damage = 3;
hitid = [sprTrapFire, "FIRE"];
}
}
if(__hm_break4) break;
}}
}
_hm.pc=8;
break;
case 6: // props.mod.gml:449
_hm.pc=(_hm.vars.__hm_repeat1>0)?9:5;
break;
case 10: // props.mod.gml:449
_hm.vars.__hm_repeat1=round(2); _hm.pc=6;
break;
case 11: // props.mod.gml:448
_hm.pc = (scrHMTaskFork(_hm, 10)) ? 10 : 4;
break;
case 12: // props.mod.gml:447
{
fire = 1;
}
_hm.pc=11;
break;
case 13: // props.mod.gml:445
_hm.pc = ((place_meeting(x, y, Flame) || (place_meeting(x, y, CustomProjectile) and (CustomProjectile.sprite_index == sprTrapFire)))) ? 12 : 1;
break;
case 14: // props.mod.gml:444
_hm.pc = (((!scrHMVariableExists(_hm.scope, "fire")) and (distance_to_object(projectile) < 40))) ? 13 : 1;
break;
case 15: // props.mod.gml:444
scrHMTaskWithEnter(_hm,scrHMMatching(Floor, "sprite_index", sprFloor4B, sprFloor104B),14,0);
break;
case 16: // props.mod.gml:436
{
{ var __hm_with5 = scrHMMatching(Effect, "name", "venuzpistoltrail"), __hm_break7=false;
for (var __hm_index6=0; __hm_index6<array_length(__hm_with5); ++__hm_index6) {
if(instance_exists(__hm_with5[__hm_index6])) with (__hm_with5[__hm_index6]) {
{
if ((image_yscale > 0.01)) {
image_yscale *= 0.7;
} else {
instance_destroy();
}
}
}
if(__hm_break7) break;
}}
}
_hm.pc=15;
break;
case 17: // props.mod.gml:197
scrHMTaskWithNext(_hm);
break;
case 18: // props.mod.gml:197
scrHMTaskWithAbort(_hm);
break;
case 19: // props.mod.gml:198
scrHMTaskWithNext(_hm);
break;
case 20: // props.mod.gml:198
scrHMTaskWithAbort(_hm);
break;
case 21: // props.mod.gml:432
{
var __hm_other8=scrHMOther(other);
scrHMDelete(__hm_other8);
}
_hm.pc=19;
break;
case 22: // props.mod.gml:430
{
;
}
_hm.pc=21;
break;
case 23: // props.mod.gml:430
_hm.result=undefined; _hm.done=true; return;
break;
case 24: // props.mod.gml:426
{
{ var __hm_with9 = scrHMMatching(CustomObject, "name", "door"), __hm_break11=false;
for (var __hm_index10=0; __hm_index10<array_length(__hm_with9); ++__hm_index10) {
if(instance_exists(__hm_with9[__hm_index10])) with (__hm_with9[__hm_index10]) {
if ((scrHMVariableExists(id, "side") and (side == 1))) {
{
instance_create((x - 16), ((y - 16) - 16), Wall);
instance_create(x, ((y - 16) - 16), Wall);
}
}
}
if(__hm_break11) break;
}}
}
_hm.pc=23;
break;
case 25: // props.mod.gml:425
_hm.wait_ticks=max(0,1); _hm.pc=24; return;
break;
case 26: // props.mod.gml:424
_hm.pc = (scrHMTaskFork(_hm, 25)) ? 25 : 21;
break;
case 27: // props.mod.gml:201
{
if (scrHMVariableExists((scrHMOther(other)), "hm_venus_retry_subarea")) {
{
var __hm_other12=scrHMOther(other);
GameCont.subarea = __hm_other12.hm_venus_retry_subarea;
;
}
} else {
{
if (((GameCont.subarea == 3) and (scrHMModGet("area", "venuz", "secrets") == 1))) {
{
GameCont.subarea = 100;
scrHMModSet("area", "venuz", "secrets", 0);
}
} else {
if (((GameCont.subarea == 6) and (scrHMModGet("area", "venuz", "secrets") == 1))) {
{
GameCont.subarea = 200;
scrHMModSet("area", "venuz", "secrets", 0);
}
} else {
if (((GameCont.subarea == 9) and (scrHMModGet("area", "venuz", "secrets") == 1))) {
{
GameCont.subarea = 300;
scrHMModSet("area", "venuz", "secrets", 0);
}
} else {
if (((GameCont.subarea == 11) and (scrHMModGet("area", "venuz", "secrets") == 1))) {
{
GameCont.subarea = 400;
scrHMModSet("area", "venuz", "secrets", 0);
}
} else {
if ((GameCont.subarea == 100)) {
GameCont.subarea = 4;
} else {
if ((GameCont.subarea == 200)) {
GameCont.subarea = 7;
} else {
if ((GameCont.subarea == 300)) {
GameCont.subarea = 10;
} else {
if ((GameCont.subarea == 401)) {
GameCont.subarea = 12;
} else {
GameCont.subarea += 1;
}
}
}
}
}
}
}
}
}
}
GameCont.lastarea = scrHMAreaResolve("venuz");
GameCont.area = scrHMAreaResolve("venuz");
{ var __hm_with13 = scrHMInstances(WantBoss), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
scrHMDelete(id);
}
if(__hm_break15) break;
}}
{ var __hm_with16 = scrHMMatchingNE(hitme, "object_index", Player, Ally), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
scrHMDelete(id);
}
if(__hm_break18) break;
}}
{ var __hm_with19 = scrHMInstances(projectile), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
scrHMDelete(id);
}
if(__hm_break21) break;
}}
{ var __hm_with22 = scrHMMatchingNE(CustomObject, "name", "VenuzElevator"), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
scrHMDelete(id);
}
if(__hm_break24) break;
}}
{ var __hm_with25 = scrHMInstances(Detail), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
scrHMDelete(id);
}
if(__hm_break27) break;
}}
{ var __hm_with28 = scrHMInstances(Debris), __hm_break30=false;
for (var __hm_index29=0; __hm_index29<array_length(__hm_with28); ++__hm_index29) {
if(instance_exists(__hm_with28[__hm_index29])) with (__hm_with28[__hm_index29]) {
scrHMDelete(id);
}
if(__hm_break30) break;
}}
{ var __hm_with31 = scrHMInstances(Scorch), __hm_break33=false;
for (var __hm_index32=0; __hm_index32<array_length(__hm_with31); ++__hm_index32) {
if(instance_exists(__hm_with31[__hm_index32])) with (__hm_with31[__hm_index32]) {
scrHMDelete(id);
}
if(__hm_break33) break;
}}
{ var __hm_with34 = scrHMInstances(Scorchmark), __hm_break36=false;
for (var __hm_index35=0; __hm_index35<array_length(__hm_with34); ++__hm_index35) {
if(instance_exists(__hm_with34[__hm_index35])) with (__hm_with34[__hm_index35]) {
scrHMDelete(id);
}
if(__hm_break36) break;
}}
{ var __hm_with37 = scrHMInstances(ScorchTop), __hm_break39=false;
for (var __hm_index38=0; __hm_index38<array_length(__hm_with37); ++__hm_index38) {
if(instance_exists(__hm_with37[__hm_index38])) with (__hm_with37[__hm_index38]) {
scrHMDelete(id);
}
if(__hm_break39) break;
}}
{ var __hm_with40 = scrHMInstances(CharredGround), __hm_break42=false;
for (var __hm_index41=0; __hm_index41<array_length(__hm_with40); ++__hm_index41) {
if(instance_exists(__hm_with40[__hm_index41])) with (__hm_with40[__hm_index41]) {
scrHMDelete(id);
}
if(__hm_break42) break;
}}
{ var __hm_with43 = scrHMInstances(Effect), __hm_break45=false;
for (var __hm_index44=0; __hm_index44<array_length(__hm_with43); ++__hm_index44) {
if(instance_exists(__hm_with43[__hm_index44])) with (__hm_with43[__hm_index44]) {
scrHMDelete(id);
}
if(__hm_break45) break;
}}
{ var __hm_with46 = scrHMInstances(Floor), __hm_break48=false;
for (var __hm_index47=0; __hm_index47<array_length(__hm_with46); ++__hm_index47) {
if(instance_exists(__hm_with46[__hm_index47])) with (__hm_with46[__hm_index47]) {
scrHMDelete(id);
}
if(__hm_break48) break;
}}
{ var __hm_with49 = scrHMInstances(Wall), __hm_break51=false;
for (var __hm_index50=0; __hm_index50<array_length(__hm_with49); ++__hm_index50) {
if(instance_exists(__hm_with49[__hm_index50])) with (__hm_with49[__hm_index50]) {
scrHMDelete(id);
}
if(__hm_break51) break;
}}
{ var __hm_with52 = scrHMInstances(InvisiWall), __hm_break54=false;
for (var __hm_index53=0; __hm_index53<array_length(__hm_with52); ++__hm_index53) {
if(instance_exists(__hm_with52[__hm_index53])) with (__hm_with52[__hm_index53]) {
scrHMDelete(id);
}
if(__hm_break54) break;
}}
{ var __hm_with55 = scrHMInstances(HMBinding), __hm_break57=false;
for (var __hm_index56=0; __hm_index56<array_length(__hm_with55); ++__hm_index56) {
if(instance_exists(__hm_with55[__hm_index56])) with (__hm_with55[__hm_index56]) {
scrHMDelete(id);
}
if(__hm_break57) break;
}}
{ var __hm_with58 = scrHMInstances(HMBinding), __hm_break60=false;
for (var __hm_index59=0; __hm_index59<array_length(__hm_with58); ++__hm_index59) {
if(instance_exists(__hm_with58[__hm_index59])) with (__hm_with58[__hm_index59]) {
scrHMDelete(id);
}
if(__hm_break60) break;
}}
{ var __hm_with61 = scrHMInstances(HMBinding), __hm_break63=false;
for (var __hm_index62=0; __hm_index62<array_length(__hm_with61); ++__hm_index62) {
if(instance_exists(__hm_with61[__hm_index62])) with (__hm_with61[__hm_index62]) {
scrHMDelete(id);
}
if(__hm_break63) break;
}}
{ var __hm_with64 = scrHMInstances(HMBinding), __hm_break66=false;
for (var __hm_index65=0; __hm_index65<array_length(__hm_with64); ++__hm_index65) {
if(instance_exists(__hm_with64[__hm_index65])) with (__hm_with64[__hm_index65]) {
scrHMDelete(id);
}
if(__hm_break66) break;
}}
{ var __hm_with67 = scrHMInstances(Top), __hm_break69=false;
for (var __hm_index68=0; __hm_index68<array_length(__hm_with67); ++__hm_index68) {
if(instance_exists(__hm_with67[__hm_index68])) with (__hm_with67[__hm_index68]) {
scrHMDelete(id);
}
if(__hm_break69) break;
}}
{ var __hm_with70 = scrHMInstances(TopSmall), __hm_break72=false;
for (var __hm_index71=0; __hm_index71<array_length(__hm_with70); ++__hm_index71) {
if(instance_exists(__hm_with70[__hm_index71])) with (__hm_with70[__hm_index71]) {
scrHMDelete(id);
}
if(__hm_break72) break;
}}
{ var __hm_with73 = scrHMInstances(prop), __hm_break75=false;
for (var __hm_index74=0; __hm_index74<array_length(__hm_with73); ++__hm_index74) {
if(instance_exists(__hm_with73[__hm_index74])) with (__hm_with73[__hm_index74]) {
scrHMDelete(id);
}
if(__hm_break75) break;
}}
{ var __hm_with76 = scrHMInstances(chestprop), __hm_break78=false;
for (var __hm_index77=0; __hm_index77<array_length(__hm_with76); ++__hm_index77) {
if(instance_exists(__hm_with76[__hm_index77])) with (__hm_with76[__hm_index77]) {
scrHMDelete(id);
}
if(__hm_break78) break;
}}
{ var __hm_with79 = scrHMInstances(Corpse), __hm_break81=false;
for (var __hm_index80=0; __hm_index80<array_length(__hm_with79); ++__hm_index80) {
if(instance_exists(__hm_with79[__hm_index80])) with (__hm_with79[__hm_index80]) {
scrHMDelete(id);
}
if(__hm_break81) break;
}}
{ var __hm_with82 = scrHMInstances(Pickup), __hm_break84=false;
for (var __hm_index83=0; __hm_index83<array_length(__hm_with82); ++__hm_index83) {
if(instance_exists(__hm_with82[__hm_index83])) with (__hm_with82[__hm_index83]) {
scrHMDelete(id);
}
if(__hm_break84) break;
}}
{ var __hm_with85 = scrHMInstances(WepPickup), __hm_break87=false;
for (var __hm_index86=0; __hm_index86<array_length(__hm_with85); ++__hm_index86) {
if(instance_exists(__hm_with85[__hm_index86])) with (__hm_with85[__hm_index86]) {
scrHMDelete(id);
}
if(__hm_break87) break;
}}
{ var __hm_with88 = scrHMInstances(DustOLD), __hm_break90=false;
for (var __hm_index89=0; __hm_index89<array_length(__hm_with88); ++__hm_index89) {
if(instance_exists(__hm_with88[__hm_index89])) with (__hm_with88[__hm_index89]) {
scrHMDelete(id);
}
if(__hm_break90) break;
}}
{ var __hm_with91 = scrHMInstances(YungVenuzCouch), __hm_break93=false;
for (var __hm_index92=0; __hm_index92<array_length(__hm_with91); ++__hm_index92) {
if(instance_exists(__hm_with91[__hm_index92])) with (__hm_with91[__hm_index92]) {
scrHMDelete(id);
}
if(__hm_break93) break;
}}
{ var __hm_with94 = scrHMInstances(YungCuz), __hm_break96=false;
for (var __hm_index95=0; __hm_index95<array_length(__hm_with94); ++__hm_index95) {
if(instance_exists(__hm_with94[__hm_index95])) with (__hm_with94[__hm_index95]) {
scrHMDelete(id);
}
if(__hm_break96) break;
}}
{ var __hm_with97 = scrHMInstances(VenuzCarpet), __hm_break99=false;
for (var __hm_index98=0; __hm_index98<array_length(__hm_with97); ++__hm_index98) {
if(instance_exists(__hm_with97[__hm_index98])) with (__hm_with97[__hm_index98]) {
scrHMDelete(id);
}
if(__hm_break99) break;
}}
scrHMVenusCleanup108();
scrHMModCall("area", "venuz", "area_setup");
scrHMModCall("area", "venuz", "area_make_floor");
scrHMModCall("area", "venuz", "area_start");
{ var __hm_with100 = scrHMInstances(Floor), __hm_break102=false;
for (var __hm_index101=0; __hm_index101<array_length(__hm_with100); ++__hm_index101) {
if(instance_exists(__hm_with100[__hm_index101])) with (__hm_with100[__hm_index101]) {
{
if (((! position_meeting((x - 16), (y - 16), Floor)) and (! position_meeting((x - 16), (y - 16), DustOLD)))) {
instance_create((x - 16), (y - 16), Wall);
}
if (((! position_meeting(x, (y - 16), Floor)) and (! position_meeting(x, (y - 16), DustOLD)))) {
instance_create(x, (y - 16), Wall);
}
if (((! position_meeting((x + 16), (y - 16), Floor)) and (! position_meeting((x + 16), (y - 16), DustOLD)))) {
instance_create((x + 16), (y - 16), Wall);
}
if (((! position_meeting((x + 32), (y - 16), Floor)) and (! position_meeting((x + 32), (y - 16), DustOLD)))) {
instance_create((x + 32), (y - 16), Wall);
}
if (((! position_meeting((x + 32), y, Floor)) and (! position_meeting((x + 32), y, DustOLD)))) {
instance_create((x + 32), y, Wall);
}
if (((! position_meeting((x + 32), (y + 16), Floor)) and (! position_meeting((x + 32), (y + 16), DustOLD)))) {
instance_create((x + 32), (y + 16), Wall);
}
if (((! position_meeting((x - 16), y, Floor)) and (! position_meeting((x - 16), y, DustOLD)))) {
instance_create((x - 16), y, Wall);
}
if (((! position_meeting((x - 16), (y + 16), Floor)) and (! position_meeting((x - 16), (y + 16), DustOLD)))) {
instance_create((x - 16), (y + 16), Wall);
}
if (((! position_meeting((x - 16), (y + 32), Floor)) and (! position_meeting((x - 16), (y + 32), DustOLD)))) {
instance_create((x - 16), (y + 32), Wall);
}
if (((! position_meeting(x, (y + 32), Floor)) and (! position_meeting(x, (y + 32), DustOLD)))) {
instance_create(x, (y + 32), Wall);
}
if (((! position_meeting((x + 16), (y + 32), Floor)) and (! position_meeting((x + 16), (y + 32), DustOLD)))) {
instance_create((x + 16), (y + 32), Wall);
}
if (((! position_meeting((x + 32), (y + 32), Floor)) and (! position_meeting((x + 32), (y + 32), DustOLD)))) {
instance_create((x + 32), (y + 32), Wall);
}
}
}
if(__hm_break102) break;
}}
_hm.vars.hm_venus_top_positions = ds_map_create();
;
{ var __hm_with103 = scrHMInstances(TopSmall), __hm_break105=false;
for (var __hm_index104=0; __hm_index104<array_length(__hm_with103); ++__hm_index104) {
if(instance_exists(__hm_with103[__hm_index104])) with (__hm_with103[__hm_index104]) {
{
_hm.vars.hm_top_key = ((string(x) + ",") + string(y));
;
if ((! ds_map_exists(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key))) {
ds_map_add(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key, 1);
}
}
}
if(__hm_break105) break;
}}
{ var __hm_with106 = scrHMInstances(Wall), __hm_break108=false;
for (var __hm_index107=0; __hm_index107<array_length(__hm_with106); ++__hm_index107) {
if(instance_exists(__hm_with106[__hm_index107])) with (__hm_with106[__hm_index107]) {
{
if ((((! position_meeting((x - 16), (y - 16), Floor)) and (! position_meeting((x - 16), (y - 16), Wall))) and (! position_meeting((x - 16), (y - 16), DustOLD)))) {
{
_hm.vars.hm_top_x = (x - 16);
_hm.vars.hm_top_y = (y - 16);
;
_hm.vars.hm_top_key = ((string(_hm.vars.hm_top_x) + ",") + string(_hm.vars.hm_top_y));
;
if ((! ds_map_exists(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key))) {
{
ds_map_add(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key, 1);
;
instance_create(_hm.vars.hm_top_x, _hm.vars.hm_top_y, TopSmall);
;
}
}
}
}
if ((((! position_meeting(x, (y - 16), Floor)) and (! position_meeting(x, (y - 16), Wall))) and (! position_meeting(x, (y - 16), DustOLD)))) {
{
_hm.vars.hm_top_x = x;
_hm.vars.hm_top_y = (y - 16);
;
_hm.vars.hm_top_key = ((string(_hm.vars.hm_top_x) + ",") + string(_hm.vars.hm_top_y));
;
if ((! ds_map_exists(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key))) {
{
ds_map_add(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key, 1);
;
instance_create(_hm.vars.hm_top_x, _hm.vars.hm_top_y, TopSmall);
;
}
}
}
}
if ((((! position_meeting((x + 16), (y - 16), Floor)) and (! position_meeting((x + 16), (y - 16), Floor))) and (! position_meeting((x + 16), (y - 16), DustOLD)))) {
{
_hm.vars.hm_top_x = (x + 16);
_hm.vars.hm_top_y = (y - 16);
;
_hm.vars.hm_top_key = ((string(_hm.vars.hm_top_x) + ",") + string(_hm.vars.hm_top_y));
;
if ((! ds_map_exists(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key))) {
{
ds_map_add(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key, 1);
;
instance_create(_hm.vars.hm_top_x, _hm.vars.hm_top_y, TopSmall);
;
}
}
}
}
if ((((! position_meeting((x + 16), (y + 16), Floor)) and (! position_meeting((x + 16), (y + 16), Floor))) and (! position_meeting((x + 16), (y + 16), DustOLD)))) {
{
_hm.vars.hm_top_x = (x + 16);
_hm.vars.hm_top_y = (y + 16);
;
_hm.vars.hm_top_key = ((string(_hm.vars.hm_top_x) + ",") + string(_hm.vars.hm_top_y));
;
if ((! ds_map_exists(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key))) {
{
ds_map_add(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key, 1);
;
instance_create(_hm.vars.hm_top_x, _hm.vars.hm_top_y, TopSmall);
;
}
}
}
}
if ((((! position_meeting((x - 16), (y + 16), Floor)) and (! position_meeting((x - 16), (y + 16), Floor))) and (! position_meeting((x - 16), (y + 16), DustOLD)))) {
{
_hm.vars.hm_top_x = (x - 16);
_hm.vars.hm_top_y = (y + 16);
;
_hm.vars.hm_top_key = ((string(_hm.vars.hm_top_x) + ",") + string(_hm.vars.hm_top_y));
;
if ((! ds_map_exists(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key))) {
{
ds_map_add(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key, 1);
;
instance_create(_hm.vars.hm_top_x, _hm.vars.hm_top_y, TopSmall);
;
}
}
}
}
if ((((! position_meeting(x, (y + 16), Floor)) and (! position_meeting(x, (y + 16), Floor))) and (! position_meeting(x, (y + 16), DustOLD)))) {
{
_hm.vars.hm_top_x = x;
_hm.vars.hm_top_y = (y + 16);
;
_hm.vars.hm_top_key = ((string(_hm.vars.hm_top_x) + ",") + string(_hm.vars.hm_top_y));
;
if ((! ds_map_exists(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key))) {
{
ds_map_add(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key, 1);
;
instance_create(_hm.vars.hm_top_x, _hm.vars.hm_top_y, TopSmall);
;
}
}
}
}
if ((((! position_meeting((x - 16), y, Floor)) and (! position_meeting((x - 16), y, Floor))) and (! position_meeting((x - 16), y, DustOLD)))) {
{
_hm.vars.hm_top_x = (x - 16);
_hm.vars.hm_top_y = y;
;
_hm.vars.hm_top_key = ((string(_hm.vars.hm_top_x) + ",") + string(_hm.vars.hm_top_y));
;
if ((! ds_map_exists(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key))) {
{
ds_map_add(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key, 1);
;
instance_create(_hm.vars.hm_top_x, _hm.vars.hm_top_y, TopSmall);
;
}
}
}
}
if ((((! position_meeting((x + 16), y, Floor)) and (! position_meeting((x + 16), y, Floor))) and (! position_meeting((x + 16), y, DustOLD)))) {
{
_hm.vars.hm_top_x = (x + 16);
_hm.vars.hm_top_y = y;
;
_hm.vars.hm_top_key = ((string(_hm.vars.hm_top_x) + ",") + string(_hm.vars.hm_top_y));
;
if ((! ds_map_exists(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key))) {
{
ds_map_add(_hm.vars.hm_venus_top_positions, _hm.vars.hm_top_key, 1);
;
instance_create(_hm.vars.hm_top_x, _hm.vars.hm_top_y, TopSmall);
;
}
}
}
}
}
}
if(__hm_break108) break;
}}
ds_map_destroy(_hm.vars.hm_venus_top_positions);
;
{ var __hm_with109 = scrHMMatching(CustomObject, "door", 0), __hm_break111=false;
for (var __hm_index110=0; __hm_index110<array_length(__hm_with109); ++__hm_index110) {
if(instance_exists(__hm_with109[__hm_index110])) with (__hm_with109[__hm_index110]) {
{
switch (name) {
case "floor":
{ var __hm_with112 = scrHMInstances(instance_create(x, y, Floor)), __hm_break114=false;
for (var __hm_index113=0; __hm_index113<array_length(__hm_with112); ++__hm_index113) {
if(instance_exists(__hm_with112[__hm_index113])) with (__hm_with112[__hm_index113]) {
{
repeat (4) {
{ var __hm_with115 = scrHMInstances(instance_nearest((x + 16), (y + 16), InvisiWall)), __hm_break117=false;
for (var __hm_index116=0; __hm_index116<array_length(__hm_with115); ++__hm_index116) {
if(instance_exists(__hm_with115[__hm_index116])) with (__hm_with115[__hm_index116]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
scrHMDelete(id);
}
}
if(__hm_break117) break;
}}
{ var __hm_with118 = scrHMInstances(instance_nearest((x + 16), (y + 16), FloorExplo)), __hm_break120=false;
for (var __hm_index119=0; __hm_index119<array_length(__hm_with118); ++__hm_index119) {
if(instance_exists(__hm_with118[__hm_index119])) with (__hm_with118[__hm_index119]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
scrHMDelete(id);
}
}
if(__hm_break120) break;
}}
{ var __hm_with121 = scrHMInstances(instance_nearest((x + 16), (y + 16), Wall)), __hm_break123=false;
for (var __hm_index122=0; __hm_index122<array_length(__hm_with121); ++__hm_index122) {
if(instance_exists(__hm_with121[__hm_index122])) with (__hm_with121[__hm_index122]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
scrHMDelete(id);
}
}
if(__hm_break123) break;
}}
}
}
}
if(__hm_break114) break;
}}
break;
;
case "prisoner":
scrHMModCall("mod", "enemies", "prisoner_create", x, y);
;
break;
;
case "Molefish":
scrHMModCall("mod", "enemies", "Molefish_create", x, y);
;
break;
;
case "Molesarge":
scrHMModCall("mod", "enemies", "Molesarge_create", x, y);
;
break;
;
case "Minigunner":
scrHMModCall("mod", "enemies", "Minigunner_create", x, y);
;
break;
;
case "Jock":
{ var __hm_with124 = scrHMInstances(instance_create(x, y, Jock)), __hm_break126=false;
for (var __hm_index125=0; __hm_index125<array_length(__hm_with124); ++__hm_index125) {
if(instance_exists(__hm_with124[__hm_index125])) with (__hm_with124[__hm_index125]) {
{
raddrop = 0;
;
hp *= 2;
;
wepseed = (- 4);
}
}
if(__hm_break126) break;
}}
break;
;
case "Charger":
scrHMModCall("mod", "enemies", "Monster_create", x, y);
;
break;
;
case "FireBaller":
{ var __hm_with127 = scrHMInstances(instance_create(x, y, FireBaller)), __hm_break129=false;
for (var __hm_index128=0; __hm_index128<array_length(__hm_with127); ++__hm_index128) {
if(instance_exists(__hm_with127[__hm_index128])) with (__hm_with127[__hm_index128]) {
{
raddrop = 0;
;
hp *= 1.5;
;
wepseed = (- 4);
}
}
if(__hm_break129) break;
}}
break;
;
case "SuperFireBaller":
{ var __hm_with130 = scrHMInstances(instance_create(x, y, SuperFireBaller)), __hm_break132=false;
for (var __hm_index131=0; __hm_index131<array_length(__hm_with130); ++__hm_index131) {
if(instance_exists(__hm_with130[__hm_index131])) with (__hm_with130[__hm_index131]) {
{
raddrop = 0;
;
hp *= 2;
;
wepseed = (- 4);
}
}
if(__hm_break132) break;
}}
break;
;
case "Turtle":
scrHMModCall("mod", "enemies", "Chick_create", x, y);
;
break;
;
case "HP":
instance_create(x, y, HealthChest);
break;
;
}
instance_destroy();
}
}
if(__hm_break111) break;
}}
scrHMModCall("mod", "maincode", "venus_place_players");
;
{ var __hm_with133 = scrHMInstances(Ally), __hm_break135=false;
for (var __hm_index134=0; __hm_index134<array_length(__hm_with133); ++__hm_index134) {
if(instance_exists(__hm_with133[__hm_index134])) with (__hm_with133[__hm_index134]) {
if ((creator != (- 4))) {
{
x = creator.x;
y = creator.y;
}
}
}
if(__hm_break135) break;
}}
{ var __hm_with136 = scrHMInstances(Revive), __hm_break138=false;
for (var __hm_index137=0; __hm_index137<array_length(__hm_with136); ++__hm_index137) {
if(instance_exists(__hm_with136[__hm_index137])) with (__hm_with136[__hm_index137]) {
{
_hm.vars.spawn_player = instance_nearest(x, y, Player);
;
if (instance_exists(_hm.vars.spawn_player)) {
{
x = _hm.vars.spawn_player.x;
;
y = _hm.vars.spawn_player.y;
;
}
}
canrevive = 1;
;
}
}
if(__hm_break138) break;
}}
}
_hm.pc=26;
break;
case 28: // props.mod.gml:198
scrHMTaskWithEnter(_hm,scrHMInstances(instance_nearest(x, y, Player)),27,17);
break;
case 29: // props.mod.gml:198
_hm.pc = ((instance_exists(Player) and (scrHMVariableExists(_hm.scope, "hm_venus_retry_subarea") || (point_distance(Player.x, Player.y, (x + 16), (y + 16)) < 12)))) ? 28 : 17;
break;
case 30: // props.mod.gml:197
scrHMTaskWithEnter(_hm,scrHMMatching(CustomObject, "name", "VenuzElevator"),29,16);
break;
case 31: // props.mod.gml:129
{
{ var __hm_with139 = scrHMInstances(BigSkull), __hm_break141=false;
for (var __hm_index140=0; __hm_index140<array_length(__hm_with139); ++__hm_index140) {
if(instance_exists(__hm_with139[__hm_index140])) with (__hm_with139[__hm_index140]) {
{
spr_idle = global.hm_module_vars[$ "mod:props"].BigSkull;
spr_hurt = global.hm_module_vars[$ "mod:props"].BigSkullHurt;
spr_dead = global.hm_module_vars[$ "mod:props"].BigSkullDead;
}
}
if(__hm_break141) break;
}}
{ var __hm_with142 = scrHMMatching(CustomObject, "name", "pizzaentrance"), __hm_break144=false;
for (var __hm_index143=0; __hm_index143<array_length(__hm_with142); ++__hm_index143) {
if(instance_exists(__hm_with142[__hm_index143])) with (__hm_with142[__hm_index143]) {
if (((!scrHMVariableExists(id, "activated")) || (activated != 1))) {
{
_hm.vars.can = 0;
;
{ var __hm_with145 = scrHMMatching(CustomEnemy, "name", "scorpionboss"), __hm_break147=false;
for (var __hm_index146=0; __hm_index146<array_length(__hm_with145); ++__hm_index146) {
if(instance_exists(__hm_with145[__hm_index146])) with (__hm_with145[__hm_index146]) {
_hm.vars.can = 1;
}
if(__hm_break147) break;
}}
if ((((_hm.vars.can == 0) and (image_index == 0)) and place_meeting(x, y, Explosion))) {
{
image_index = 1;
activated = 1;
hm_props_mod_gml_fancylid_create(x, y);
}
}
}
}
}
if(__hm_break144) break;
}}
{ var __hm_with148 = scrHMInstances(PizzaEntrance), __hm_break150=false;
for (var __hm_index149=0; __hm_index149<array_length(__hm_with148); ++__hm_index149) {
if(instance_exists(__hm_with148[__hm_index149])) with (__hm_with148[__hm_index149]) {
if (((image_index == 1) and (!scrHMVariableExists(id, "pinkyup")))) {
{
pinkyup = 1;
{ var __hm_with151 = scrHMInstances(Portal), __hm_break153=false;
for (var __hm_index152=0; __hm_index152<array_length(__hm_with151); ++__hm_index152) {
if(instance_exists(__hm_with151[__hm_index152])) with (__hm_with151[__hm_index152]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
instance_destroy();
}
}
if(__hm_break153) break;
}}
hm_props_mod_gml_fancylid_create((x + 16), (y + 16));
}
}
}
if(__hm_break150) break;
}}
{ var __hm_with154 = scrHMInstances(CarVenusFixed), __hm_break156=false;
for (var __hm_index155=0; __hm_index155<array_length(__hm_with154); ++__hm_index155) {
if(instance_exists(__hm_with154[__hm_index155])) with (__hm_with154[__hm_index155]) {
if ((GameCont.area == scrHMAreaResolve(3))) {
{
scrHMModCall("mod", "props", "VenuzCar_create", x, (y + 6), 0);
scrHMDelete(id);
}
}
}
if(__hm_break156) break;
}}
{ var __hm_with157 = scrHMMatchingGE(Crystal, "creator", 0), __hm_break159=false;
for (var __hm_index158=0; __hm_index158<array_length(__hm_with157); ++__hm_index158) {
if(instance_exists(__hm_with157[__hm_index158])) with (__hm_with157[__hm_index158]) {
{
if (instance_exists(creator)) {
{
x = creator.x;
y = (creator.y - 8);
}
} else {
instance_destroy();
}
}
}
if(__hm_break159) break;
}}
{ var __hm_with160 = scrHMInstances(ReviveCircle), __hm_break162=false;
for (var __hm_index161=0; __hm_index161<array_length(__hm_with160); ++__hm_index161) {
if(instance_exists(__hm_with160[__hm_index161])) with (__hm_with160[__hm_index161]) {
{
{ var __hm_with163 = scrHMMatching(Corpse, "specialrevive", "rogue"), __hm_break165=false;
for (var __hm_index164=0; __hm_index164<array_length(__hm_with163); ++__hm_index164) {
if(instance_exists(__hm_with163[__hm_index164])) with (__hm_with163[__hm_index164]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
{
if (((scrHMOther(other)).alarm[0] < 5)) {
{
scrHMModCall("mod", "enemies", "enemyrogue_create", x, y);
instance_destroy();
}
}
}
}
}
if(__hm_break165) break;
}}
{ var __hm_with166 = scrHMMatching(Corpse, "specialrevive", "melting"), __hm_break168=false;
for (var __hm_index167=0; __hm_index167<array_length(__hm_with166); ++__hm_index167) {
if(instance_exists(__hm_with166[__hm_index167])) with (__hm_with166[__hm_index167]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
{
if (((scrHMOther(other)).alarm[0] < 5)) {
{
scrHMModCall("mod", "enemies", "enemymelting_create", x, y);
instance_destroy();
}
}
}
}
}
if(__hm_break168) break;
}}
{ var __hm_with169 = scrHMMatching(Corpse, "specialrevive", "skeleton"), __hm_break171=false;
for (var __hm_index170=0; __hm_index170<array_length(__hm_with169); ++__hm_index170) {
if(instance_exists(__hm_with169[__hm_index170])) with (__hm_with169[__hm_index170]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
{
if (((scrHMOther(other)).alarm[0] < 5)) {
{
scrHMModCall("mod", "enemies", "enemyskeleton_create", x, y);
instance_destroy();
}
}
}
}
}
if(__hm_break171) break;
}}
{ var __hm_with172 = scrHMMatching(Corpse, "sprite_index", sprGruntDead, sprPopoFreakDead), __hm_break174=false;
for (var __hm_index173=0; __hm_index173<array_length(__hm_with172); ++__hm_index173) {
if(instance_exists(__hm_with172[__hm_index173])) with (__hm_with172[__hm_index173]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
{
if (((scrHMOther(other)).alarm[0] < 5)) {
{
instance_create(x, y, PopoFreak);
scrHMSoundPlay(sndFreakPopoRevive);
instance_destroy();
}
}
}
}
}
if(__hm_break174) break;
}}
}
}
if(__hm_break162) break;
}}
}
_hm.pc=30;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

// Source props.mod.gml:401; mpAmmoChest_create

function hm_props_mod_gml_mpAmmoChest_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "mpammochest";

spr_idle = sprAmmoChest;

image_speed = (0) * timescale;

shadow = 2;

on_step = scrHMScriptRef(hm_props_mod_gml_MpAmmoChest_step);

on_destroy = scrHMScriptRef(hm_props_mod_gml_MpAmmoChest_destroy);

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:411; MpAmmoChest_step

function hm_props_mod_gml_MpAmmoChest_step() {

sprite_index = spr_idle;

if ((((image_speed / timescale) > 0) and (image_index >= 6))) {

{

image_speed = (0) * timescale;

image_index = 0;

}

}

if ((((image_speed / timescale) == 0) and (random(50) < 1))) {

image_speed = (0.4) * timescale;

}

if ((distance_to_object(Player) < 16)) {

instance_destroy();

}

}



// Source props.mod.gml:421; MpAmmoChest_destroy

function hm_props_mod_gml_MpAmmoChest_destroy() {

var _hml_plin_ = 0;

repeat (instance_number(Player)) {

hm_props_mod_gml_MpAmmo_create(x, y, _hml_plin_);

hm_props_mod_gml_MpAmmo_create(x, y, _hml_plin_);

_hml_plin_ += 1;

}

scrHMSoundPlay(sndAmmoChest);

{ var __hm_with1 = scrHMInstances(instance_create(x, y, ChestOpen)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

sprite_index = sprAmmoChestOpen;

}

}

if(__hm_break3) break;

}}

instance_create(x, y, FXChestOpen);

}



// Source props.mod.gml:435; MpAmmo_create

function hm_props_mod_gml_MpAmmo_create(_hml__x, _hml__y, _hml__ind) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomProjectile)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "mpammo";

spr_idle = sprAmmo;

image_speed = (0) * timescale;

on_step = scrHMScriptRef(hm_props_mod_gml_MpAmmo_step);

on_wall = scrHMScriptRef(hm_props_mod_gml_MpAmmo_wall);

team = 2;

index = _hml__ind;

target = (- 1);

targetvisible = 0;

direction = choose(0, 180, 90, 270);

speed = (5) * timescale;

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:450; MpAmmo_step

function hm_props_mod_gml_MpAmmo_step() {

sprite_index = spr_idle;

if ((((image_speed / timescale) > 0) and (image_index >= 6))) {

{

image_speed = (0) * timescale;

image_index = 0;

}

}

if ((((image_speed / timescale) == 0) and (random(50) < 1))) {

image_speed = (0.4) * timescale;

}

{ var __hm_with1 = scrHMMatching(Player, "index", index), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

var __hm_other4=scrHMOther(other);

__hm_other4.target = id;

}

if(__hm_break3) break;

}}

if ((instance_exists(target) && (collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0))) {

targetvisible = 1;

} else {

targetvisible = 0;

}

;

if (targetvisible) {

scrHMMotionSet(point_direction(x, y, target.x, target.y), 5);

} else {

if (place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Wall)) {

direction += random_range(80, 100);

}

}

{ var __hm_with5 = scrHMMatching(Player, "index", index), __hm_break7=false;

for (var __hm_index6=0; __hm_index6<array_length(__hm_with5); ++__hm_index6) {

if(instance_exists(__hm_with5[__hm_index6])) with (__hm_with5[__hm_index6]) {

if ((distance_to_object((scrHMOther(other))) < 16)) {

{

scrHMSoundPitch(sndAmmoPickup, 0.8);

if ((ammo[scrHMWeaponType(wep)] == 0)) {

{

var _hml_melee_ = choose(1, 2, 3, 4, 5);

;

ammo[scrHMWeaponType(_hml_melee_)] += typ_ammo[scrHMWeaponType(_hml_melee_)];

if ((ammo[scrHMWeaponType(_hml_melee_)] > typ_amax[scrHMWeaponType(_hml_melee_)])) {

ammo[scrHMWeaponType(_hml_melee_)] = typ_amax[scrHMWeaponType(_hml_melee_)];

}

{ var __hm_with8 = scrHMInstances(instance_create(x, y, PopupText)), __hm_break10=false;

for (var __hm_index9=0; __hm_index9<array_length(__hm_with8); ++__hm_index9) {

if(instance_exists(__hm_with8[__hm_index9])) with (__hm_with8[__hm_index9]) {

{

{ var __hm_with11 = scrHMInstances((scrHMOther(other))), __hm_break13=false;

for (var __hm_index12=0; __hm_index12<array_length(__hm_with11); ++__hm_index12) {

if(instance_exists(__hm_with11[__hm_index12])) with (__hm_with11[__hm_index12]) {

{

if ((_hml_melee_ == 1)) {

var __hm_other14=scrHMOther(other);

__hm_other14.mytext = (("+" + string(typ_ammo[_hml_melee_])) + " BULLETS");

} else {

if ((_hml_melee_ == 2)) {

var __hm_other15=scrHMOther(other);

__hm_other15.mytext = (("+" + string(typ_ammo[_hml_melee_])) + " SHELLS");

} else {

if ((_hml_melee_ == 3)) {

var __hm_other16=scrHMOther(other);

__hm_other16.mytext = (("+" + string(typ_ammo[_hml_melee_])) + " BOLTS");

} else {

if ((_hml_melee_ == 4)) {

var __hm_other17=scrHMOther(other);

__hm_other17.mytext = (("+" + string(typ_ammo[_hml_melee_])) + " EXPLOSIVES");

} else {

if ((_hml_melee_ == 5)) {

var __hm_other18=scrHMOther(other);

__hm_other18.mytext = (("+" + string(typ_ammo[_hml_melee_])) + " ENERGY");

}

}

}

}

}

}

}

if(__hm_break13) break;

}}

}

}

if(__hm_break10) break;

}}

}

} else {

{

ammo[scrHMWeaponType(wep)] += typ_ammo[scrHMWeaponType(wep)];

if ((ammo[scrHMWeaponType(wep)] > typ_amax[scrHMWeaponType(wep)])) {

ammo[scrHMWeaponType(wep)] = typ_amax[scrHMWeaponType(wep)];

}

{ var __hm_with19 = scrHMInstances(instance_create(x, y, PopupText)), __hm_break21=false;

for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {

if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {

{

{ var __hm_with22 = scrHMInstances((scrHMOther(other))), __hm_break24=false;

for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {

if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {

{

if ((scrHMWeaponType(wep) == 1)) {

var __hm_other25=scrHMOther(other);

__hm_other25.mytext = (("+" + string(typ_ammo[scrHMWeaponType(wep)])) + " BULLETS");

} else {

if ((scrHMWeaponType(wep) == 2)) {

var __hm_other26=scrHMOther(other);

__hm_other26.mytext = (("+" + string(typ_ammo[scrHMWeaponType(wep)])) + " SHELLS");

} else {

if ((scrHMWeaponType(wep) == 3)) {

var __hm_other27=scrHMOther(other);

__hm_other27.mytext = (("+" + string(typ_ammo[scrHMWeaponType(wep)])) + " BOLTS");

} else {

if ((scrHMWeaponType(wep) == 4)) {

var __hm_other28=scrHMOther(other);

__hm_other28.mytext = (("+" + string(typ_ammo[scrHMWeaponType(wep)])) + " EXPLOSIVES");

} else {

if ((scrHMWeaponType(wep) == 5)) {

var __hm_other29=scrHMOther(other);

__hm_other29.mytext = (("+" + string(typ_ammo[scrHMWeaponType(wep)])) + " ENERGY");

}

}

}

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

{ var __hm_with30 = scrHMInstances((scrHMOther(other))), __hm_break32=false;

for (var __hm_index31=0; __hm_index31<array_length(__hm_with30); ++__hm_index31) {

if(instance_exists(__hm_with30[__hm_index31])) with (__hm_with30[__hm_index31]) {

instance_destroy();

}

if(__hm_break32) break;

}}

}

}

}

if(__hm_break7) break;

}}

}



// Source props.mod.gml:515; MpAmmo_wall

function hm_props_mod_gml_MpAmmo_wall() {

move_bounce_solid(1);

}



// Source props.mod.gml:520; flag_create

function hm_props_mod_gml_flag_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomHitme)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "flag";

on_step = scrHMScriptRef(hm_props_mod_gml_flag_step);

on_hurt = scrHMScriptRef(hm_props_mod_gml_flag_hurt);

image_index = irandom(29);

image_xscale = choose((- 1), 1);

image_speed = (0.4) * timescale;

friction = (30) * (timescale * timescale);

depth = 7;

hp = 3;

spr_shadow = shd24;

if ((GameCont.area == scrHMAreaResolve(1))) {

{

spr_idle = global.hm_module_vars[$ "mod:props"].redflag;

spr_hurt = global.hm_module_vars[$ "mod:props"].redflaghurt;

spr_dead = global.hm_module_vars[$ "mod:props"].redflagdead;

}

} else {

if ((GameCont.area == scrHMAreaResolve(3))) {

{

spr_idle = global.hm_module_vars[$ "mod:props"].blueflag;

spr_hurt = global.hm_module_vars[$ "mod:props"].blueflaghurt;

spr_dead = global.hm_module_vars[$ "mod:props"].blueflagdead;

}

} else {

if ((GameCont.area == scrHMAreaResolve(4))) {

{

spr_idle = global.hm_module_vars[$ "mod:props"].yellowflag;

spr_hurt = global.hm_module_vars[$ "mod:props"].yellowflaghurt;

spr_dead = global.hm_module_vars[$ "mod:props"].yellowflagdead;

}

}

}

}

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:549; flag_step

function hm_props_mod_gml_flag_step() {

if ((nexthurt > current_frame)) {

{

if ((sprite_index != spr_hurt)) {

{

image_index = 0;

;

sprite_index = spr_hurt;

;

}

}

}

} else {

{

if (((speed / timescale) > (friction / (timescale * timescale)))) {

sprite_index = spr_walk;

} else {

sprite_index = spr_idle;

}

;

}

}

if ((! place_meeting(x, y, Floor))) {

instance_destroy();

} else {

if (place_meeting(x, y, Wall)) {

instance_destroy();

}

}

}



// Source props.mod.gml:0; flag_hurt (native content 1.1.0)
function hm_props_mod_gml_flag_hurt(_hml_damage, _hml_kb_vel, _hml_kb_dir) {
hp -= _hml_damage;
;
if ((sprite_index != spr_hurt)) {
image_index = 0;
}
sprite_index = spr_hurt;
;
if ((hp <= 0)) {
{
repeat (6) { var __hm_with1 = scrHMInstances(instance_create(x, y, Feather)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var __hm_other4=scrHMOther(other);
sprite_index = __hm_other4.spr_dead;
image_index = (irandom(6) - 1);
image_speed = (0) * timescale;
}
}
if(__hm_break3) break;
}}
{ var __hm_with5 = scrHMInstances(instance_create(x, y, Corpse)), __hm_break7=false;
for (var __hm_index6=0; __hm_index6<array_length(__hm_with5); ++__hm_index6) {
if(instance_exists(__hm_with5[__hm_index6])) with (__hm_with5[__hm_index6]) {
{
do_portal = 0;
;
alarm[0] = (- 1);
;
sprite_index = global.hm_module_vars[$ "mod:props"].flagdead;
var __hm_other8=scrHMOther(other);
image_xscale = __hm_other8.image_xscale;
friction = (30) * (timescale * timescale);
}
}
if(__hm_break7) break;
}}
instance_destroy();
}
}
}

// Source props.mod.gml:0; fishskull_create (native content 1.1.0)
function hm_props_mod_gml_fishskull_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomHitme)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "fishskull";
spr_idle = sprBigSkullOpen;
spr_hurt = sprBigSkullOpenHurt;
spr_dead = sprBigSkullDead;
snd_hurt = 349;
snd_dead = (- 1);
team = 1;
image_xscale = choose(1, 1, (- 1));
friction = (30) * (timescale * timescale);
scrHMMaxHealthWrite(id, 50, "=");
;
hp = 50;
;
mask_index = sprBigSkullOpen;
;
hm_fish_clear_ticks = 0;
;
hm_arkintide_mod_gml_hm_fish_gate();
;
depth = 0;
on_step = scrHMScriptRef(hm_props_mod_gml_fishskull_step);
on_hurt = scrHMScriptRef(hm_props_mod_gml_fishskull_hurt);
on_destroy = scrHMScriptRef(hm_props_mod_gml_fishskull_dead);
}
}
if(__hm_break3) break;
}}
}

// Source props.mod.gml:0; fishskull_step (native content 1.1.0)
function hm_props_mod_gml_fishskull_step() {
hm_arkintide_mod_gml_hm_fish_gate();
;
sprite_index = spr_idle;
;
if (((! place_meeting(x, y, Floor)) || place_meeting(x, y, Wall))) {
{
var _hml_fl_ = instance_nearest(x, y, Floor);
;
x = (_hml_fl_.x + 16);
;
y = (_hml_fl_.y + 16);
}
}
if (instance_exists(Portal)) {
{
spr_idle = sprBigSkull;
spr_hurt = sprBigSkullHurt;
if ((random(32) < 1)) {
instance_create((x + random_range((- 10), 10)), (y + random_range((- 10), 10)), Bubble);
}
}
}
{ var __hm_with1 = scrHMInstances(hitme), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
{
var __hm_other4=scrHMOther(other);
scrHMMotionAdd(point_direction(__hm_other4.x, __hm_other4.y, x, y), 0.5);
}
}
}
if(__hm_break3) break;
}}
}

// Source props.mod.gml:0; fishskull_hurt (native content 1.1.0)
function hm_props_mod_gml_fishskull_hurt() {
if (hm_arkintide_mod_gml_hm_fish_protected()) {
exit;
}
if ((sprite_index != spr_hurt)) {
{
hp -= argument0;
;
image_index = 0;
;
sprite_index = spr_hurt;
;
}
}
if ((hp <= 0)) {
{
instance_destroy();
}
}
}

// Source props.mod.gml:0; fishskull_dead (native content 1.1.0)
function hm_props_mod_gml_fishskull_dead() {
if (instance_exists(Portal)) {
{
scrHMSoundStopAll();
GameCont.area = scrHMAreaResolve(101);
;
hm_props_mod_gml_joao_shockwave(1, instance_nearest(x, y, Floor));
;
}
} else {
{ var __hm_with1 = scrHMInstances(instance_create(x, y, WepPickup)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
wep = scrHMWeaponResolve(120);
}
if(__hm_break3) break;
}}
}
{ var __hm_with4 = scrHMInstances(instance_create(x, y, Corpse)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
do_portal = 0;
;
alarm[0] = (- 1);
;
var __hm_other7=scrHMOther(other);
sprite_index = __hm_other7.spr_dead;
var __hm_other8=scrHMOther(other);
image_xscale = __hm_other8.image_xscale;
speed = (0) * timescale;
}
}
if(__hm_break6) break;
}}
}

// Source props.mod.gml:644; ClamMimic_create

function hm_props_mod_gml_ClamMimic_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(x, y, CustomEnemy)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

alarm[1] = 100;

alarm[2] = 10;

friction = (300) * (timescale * timescale);

on_step = scrHMScriptRef(hm_props_mod_gml_ClamMimic_step);

on_destroy = scrHMScriptRef(hm_props_mod_gml_ClamMimic_dead);

spr_idle = global.hm_module_vars[$ "mod:props"].ClamMimicIdle;

spr_fire = global.hm_module_vars[$ "mod:props"].ClamMimicFire;

spr_tell = global.hm_module_vars[$ "mod:props"].ClamMimicTell;

spr_hurt = global.hm_module_vars[$ "mod:props"].ClamMimicHurt;

spr_dead = global.hm_module_vars[$ "mod:props"].ClamMimicDead;

hitid = [global.hm_module_vars[$ "mod:props"].ClamMimicFire, "MIMIC"];

hp = 12;

size = 1;

canmelee = 1;

meleedamage = 3;

team = 1;

sprite_index = spr_idle;

;

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:665; ClamMimic_step

function hm_props_mod_gml_ClamMimic_step() {

if ((nexthurt > current_frame)) {

{

if ((sprite_index != spr_hurt)) {

{

image_index = 0;

;

scrHMSoundPlay(sndMimicHurt);

;

sprite_index = spr_hurt;

;

}

}

}

} else {

if (((sprite_index != spr_fire) and (sprite_index != spr_tell))) {

{

sprite_index = spr_idle;

}

}

}

if (((sprite_index != spr_fire) and (alarm[1] <= 0))) {

{

alarm[1] = random_range(100, 300);

sprite_index = spr_tell;

;

scrHMSoundPlay(sndMimicSlurp);

instance_create(x, y, Bubble);

}

}

if (((sprite_index == spr_tell) and (image_index >= 14))) {

{

alarm[1] = random_range(300, 600);

sprite_index = spr_idle;

}

}

if (((sprite_index == spr_fire) and (image_index >= 3))) {

sprite_index = spr_idle;

}

if ((alarm[1] > 0)) {

alarm[1] -= 1;

}

if ((alarm[2] > 0)) {

alarm[2] -= 1;

}

if (((place_meeting(x, y, Player) and (alarm[2] <= 0)) and ((sprite_index == spr_idle) || (sprite_index == spr_tell)))) {

{

scrHMSoundPlay(sndMimicMelee);

sprite_index = spr_fire;

alarm[1] = 100;

alarm[2] = 30;

repeat (3) instance_create(x, y, Bubble);

}

}

}



// Source props.mod.gml:703; ClamMimic_dead

function hm_props_mod_gml_ClamMimic_dead() {

scrHMSoundPlay(sndMimicDead);

repeat (2) instance_create(x, y, AmmoPickup);

}



// Source props.mod.gml:710; fancylid_create

function hm_props_mod_gml_fancylid_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "fancylid";

on_step = scrHMScriptRef(hm_props_mod_gml_fancylid_step);

on_draw = scrHMScriptRef(hm_props_mod_gml_fancylid_draw);

friction = (0.1) * (timescale * timescale);

flip = 0;

starty = (y + 2);

shadow = (starty - 2);

right = choose((- 1), 1);

depth = (- 10);

image_speed = (0) * timescale;

turn = random_range(0, 25);

bounce = random(6);

sound = 0;

scrHMMotionAdd(random_range(60, 120), random_range(5, 10));

repeat (12) {

{ var __hm_with4 = scrHMInstances(instance_create(x, y, Dust)), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

scrHMMotionAdd(random(360), random(6));

}

if(__hm_break6) break;

}}

}

repeat (6) {

{ var __hm_with7 = scrHMInstances(instance_create(x, y, Dust)), __hm_break9=false;

for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {

if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {

var __hm_other10=scrHMOther(other);

scrHMMotionAdd(__hm_other10.direction, random(6));

}

if(__hm_break9) break;

}}

}

instance_create(x, y, Portal);

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:739; fancylid_step

function hm_props_mod_gml_fancylid_step() {

sprite_index = global.hm_module_vars[$ "mod:props"].fancylid;

if (((flip < 1) and (flip >= 0))) {

image_index = 0;

} else {

if (((flip > 1) and (flip < 2))) {

image_index = 1;

}

}

image_yscale = (flip - 1);

if (((speed / timescale) > (friction / (timescale * timescale)))) {

{

image_angle += turn;

flip += min(((speed / timescale) / 10), 0.4);

flip = (flip mod 2);

;

}

}

if ((y < starty)) {

{

depth = (- 10);

shadow = (starty - 2);

vspeed += (0.2) * timescale;

hspeed = (right) * timescale;

}

} else {

{

if (place_meeting(x, y, Floor)) {

depth = (- 1);

}

shadow = y;

if ((bounce > 0)) {

{

scrHMSoundPlay(sndFootMetRock2);

speed = (0) * timescale;

scrHMMotionAdd(random_range(75, 115), random(3));

bounce -= 1;

repeat (2) {

{ var __hm_with1 = scrHMInstances(instance_create(x, y, Dust)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

scrHMMotionAdd(random(360), random(2));

var __hm_other4=scrHMOther(other);

depth = (__hm_other4.depth + 0.1);

}

}

if(__hm_break3) break;

}}

}

}

} else {

if ((sound == 0)) {

{

scrHMSoundPlay(sndFootMetRock3);

sound = 1;

}

}

}

if (((flip < 1) and (flip >= 0))) {

flip -= 0.1;

} else {

if (((flip > 1) and (flip < 2))) {

flip += 0.1;

}

}

}

}

if ((y >= (starty - 12))) {

{

if (place_meeting(x, y, projectile)) {

{

right = random_range((- 1), 1);

scrHMMotionAdd(90, ((projectile.knockback_speed / timescale) / 3));

bounce = random(6);

sound = 0;

scrHMSoundPitch(sndGrenadeHitWall, random_range(0.8, 1.2));

repeat (2) {

{ var __hm_with5 = scrHMInstances(instance_create(x, y, Dust)), __hm_break7=false;

for (var __hm_index6=0; __hm_index6<array_length(__hm_with5); ++__hm_index6) {

if(instance_exists(__hm_with5[__hm_index6])) with (__hm_with5[__hm_index6]) {

{

var __hm_other8=scrHMOther(other);

scrHMMotionAdd(__hm_other8.direction, random(6));

var __hm_other9=scrHMOther(other);

depth = (__hm_other9.depth + 0.1);

}

}

if(__hm_break7) break;

}}

}

}

}

if (place_meeting(x, y, Explosion)) {

{

right = random_range((- 1), 1);

scrHMMotionAdd(90, random_range(5, 10));

bounce = random(6);

sound = 0;

scrHMSoundPitch(sndGrenadeHitWall, random_range(0.8, 1.2));

repeat (2) {

{ var __hm_with10 = scrHMInstances(instance_create(x, y, Dust)), __hm_break12=false;

for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {

if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {

{

var __hm_other13=scrHMOther(other);

scrHMMotionAdd(__hm_other13.direction, random(6));

var __hm_other14=scrHMOther(other);

depth = (__hm_other14.depth + 0.1);

}

}

if(__hm_break12) break;

}}

}

}

}

}

}

}



// Source props.mod.gml:813; fancylid_draw

function hm_props_mod_gml_fancylid_draw() {

draw_set_color(make_color_rgb(20, 20, 20));

;

scrHMDrawSpriteExt(shd24, 1, x, ystart, min(((ystart - y) / 100), 1), min(((ystart - y) / 100), 1), 1, c_white, 0.4);

;

scrHMDrawSpriteExt(sprite_index, image_index, x, y, 1, image_yscale, image_angle, c_white, 1);

;

scrHMDrawSpriteExt(sprite_index, image_index, x, (y - 1), 1, (image_yscale + 0.1), image_angle, c_white, 1);

;

}



// Source props.mod.gml:821; VenuzCar_create

function hm_props_mod_gml_VenuzCar_create(_hml__x, _hml__y, _hml__h) {

scrHMCarPrepare106();

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "VenuzCar";

if ((GameCont.area == scrHMAreaResolve(3))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzCar;

} else {

spr_idle = choose(global.hm_module_vars[$ "mod:props"].VenuzCar, global.hm_module_vars[$ "mod:props"].VenuzCar2);

}

direction = 180;

image_angle = 180;

mask_index = mskSnowTank;

hitid = [sprVenusCarFixed, "VENUZ CAR"];

spr_shadow = shd32;

shd_y = 0;

friction = (0.01) * (timescale * timescale);

size = 1;

canfly = 1;

team = 0;

driver = (- 1);

portal = 200;

z = _hml__h;

team = 2;

riders = 0;

bg_ = scrHMBackgroundColour105();

rot = 0;

if ((z > 0)) {

rot = choose(1, (- 1));

}

image_alpha = 0;

;

on_step = scrHMScriptRef(hm_props_mod_gml_VenuzCar_step);

pla_shd = shd24;

pla_msk = mskPlayer;

{ var __hm_with4 = scrHMInstances(scrHMBindDraw(hm_props_mod_gml_VenuzCar_draw, (- 8))), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

{

zscale = 1;

var __hm_other7=scrHMOther(other);

creator = __hm_other7;

var __hm_other8=scrHMOther(other);

image_angle = __hm_other8.image_angle;

var __hm_other9=scrHMOther(other);

image_xscale = __hm_other9.image_xscale;

var __hm_other10=scrHMOther(other);

image_yscale = __hm_other10.image_yscale;

var __hm_other11=scrHMOther(other);

image_speed = ((__hm_other11.image_speed / timescale)) * timescale;

sprite_index = global.hm_module_vars[$ "mod:props"].VenuzCar;

}

}

if(__hm_break6) break;

}}

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:868; VenuzCar_draw

function hm_props_mod_gml_VenuzCar_draw() {

if (instance_exists(creator)) {

{

if ((creator.portal < 175)) {

{

draw_set_alpha((1 - (creator.portal / 175)));

;

draw_set_color(0);

;

draw_rectangle((view_xview - (view_width / 2)), (view_yview - (view_height / 2)), (view_xview + (view_width * 2)), (view_yview + (view_height * 2)), 0);

draw_set_color(c_white);

;

draw_set_alpha(1);

;

}

}

image_angle = creator.image_angle;

var _hml_i = undefined;

;

var _hml_j = 0;

;

var _hml_g = 0;

;

gpu_set_fog(0, 0, 0, 0);

_hml_j = 0;

_hml_g = 0;

var _hml_shad_scale = undefined;

;

_hml_shad_scale = (1 - min((0.66 * (creator.z / 96)), 0.66));

draw_set_color(make_color_rgb(20, 20, 20));

;

draw_set_alpha(0.4);

;

draw_ellipse(((creator.x - 2) + (12 * _hml_shad_scale)), ((creator.y + (12 * _hml_shad_scale)) + creator.shd_y), ((creator.x - 2) - (12 * _hml_shad_scale)), ((creator.y - (4 * _hml_shad_scale)) + creator.shd_y), 0);

;

draw_set_color(c_white);

;

draw_set_alpha(1);

;

for (_hml_i = 0; (_hml_i <= 8); _hml_i++) {

repeat (zscale) {

scrHMDrawSpriteExt(global.hm_module_vars[$ "mod:props"].VenuzCaroutline, clamp(_hml_i, 0, 7), creator.x, ((creator.y - (.5 * (_hml_i + _hml_j))) - creator.z), image_xscale, image_yscale, image_angle, c_white, 1);

;

_hml_j += 1;

;

}

}

for (_hml_i = 0; (_hml_i <= 8); _hml_i++) {

repeat (zscale) {

scrHMDrawSpriteExt(creator.spr_idle, clamp(_hml_i, 0, 7), creator.x, ((creator.y - (.5 * (_hml_i + _hml_g))) - creator.z), image_xscale, image_yscale, image_angle, c_white, 1);

;

_hml_g += 1;

;

}

}

}

} else {

instance_destroy();

}

}



// Source props.mod.gml:909; outsider_draw

function hm_props_mod_gml_outsider_draw() {

{ var __hm_with1 = scrHMInstances(creator), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

if ((outside == 1)) {

{

draw_set_color(make_color_rgb(20, 20, 20));

;

scrHMDrawSpriteExt(pla_shd, 1, x, (y + spr_shadow_y), image_xscale, image_yscale, 1, c_white, 0.4);

}

}

if ((bwep != scrHMWeaponResolve(0))) {

{

if ((race != 7)) {

scrHMDrawSpriteExt(scrHMWeaponSprite(bwep), 0, (x - (right * 2)), (y + 4), 1, ((bwepflip * right) * (- 1)), (90 + (15 * right)), c_silver, 1);

} else {

scrHMDrawSpriteExt(scrHMWeaponSprite(bwep), 0, x, y, 1, (right * (- 1)), (gunangle + wepangle), c_white, 1);

}

;

}

}

if ((gunangle < 180)) {

scrHMDrawSpriteExt(scrHMWeaponSprite(wep), 0, x, (y - z), 1, right, (gunangle + wepangle), c_white, 1);

}

scrHMDrawSpriteExt(sprite_index, image_index, x, (y - z), right, image_yscale, angle, c_white, 1);

if ((gunangle >= 180)) {

scrHMDrawSpriteExt(scrHMWeaponSprite(wep), 0, x, (y - z), 1, right, (gunangle + wepangle), c_white, 1);

}

}

}

if(__hm_break3) break;

}}

scrHMMenuDrawComplete();

}



// Source props.mod.gml:928; E

function hm_props_mod_gml_E() {

{ var __hm_with1 = scrHMInstances(creator), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

scrHMDrawSprite(sprEPickup, 0, x, ((y - 7) - z));

draw_set_color(c_black);

scrHMDrawTextPlain((x - 31), ((y - 30) - z), string(name));

scrHMDrawTextPlain(((x + 1) - 31), ((y - 30) - z), string(name));

scrHMDrawTextPlain(((x + 1) - 31), ((y - 31) - z), string(name));

draw_set_color(c_white);

scrHMDrawTextPlain((x - 31), ((y - 31) - z), string(name));

}

}

if(__hm_break3) break;

}}

scrHMMenuDrawComplete();

}



// Source props.mod.gml:0; VenuzCar_step (native content 1.1.0)
function hm_props_mod_gml_VenuzCar_step() {
scrHMCarSteer108();
sprite_index = spr_idle;
if (position_meeting(x, (y + 8), Wall)) {
shd_y = (- 8);
} else {
if (position_meeting(x, (y + 8), Floor)) {
shd_y = 0;
}
}
if ((riders < instance_number(Player))) {
{ var __hm_with1 = scrHMMatching(Player, "rider", undefined, (- 1)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((((scrHMOther(other)).driver != index) and (distance_to_object((scrHMOther(other))) < 16))) {
{
{ var __hm_with4 = scrHMInstances((scrHMOther(other))), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{ var __hm_with7 = scrHMInstances(scrHMBindDraw(hm_props_mod_gml_E, (- 11))), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
var __hm_other10=scrHMOther(other);
creator = __hm_other10;
}
if(__hm_break9) break;
}}
}
if(__hm_break6) break;
}}
}
}
}
if(__hm_break3) break;
}}
}
if ((driver == (- 1))) {
{
{ var __hm_with11 = scrHMInstances(Player), __hm_break13=false;
for (var __hm_index12=0; __hm_index12<array_length(__hm_with11); ++__hm_index12) {
if(instance_exists(__hm_with11[__hm_index12])) with (__hm_with11[__hm_index12]) {
if ((((scrHMButtonPressed(index, "pick") and (distance_to_object((scrHMOther(other))) < 16)) and ((scrHMOther(other)).driver == (- 1))) and ((scrHMOther(other)).z < 17))) {
{
outside = 0;
z = (- 1);
image_alpha = 0;
;
var __hm_other14=scrHMOther(other);
__hm_other14.depth = (- 10);
can_walk = 0;
;
canfly = 1;
;
var __hm_other15=scrHMOther(other);
__hm_other15.friction = (0.04) * (timescale * timescale);
var __hm_other16=scrHMOther(other);
__hm_other16.team = team;
if ((spr_shadow != mskNone)) {
{
var __hm_other17=scrHMOther(other);
__hm_other17.pla_msk = mask_index;
var __hm_other18=scrHMOther(other);
__hm_other18.pla_shd = spr_shadow;
}
}
mask_index = mskNone;
;
spr_shadow = mskNone;
var __hm_other19=scrHMOther(other);
__hm_other19.driver = index;
var __hm_other20=scrHMOther(other);
__hm_other20.riders += 1;
}
}
}
if(__hm_break13) break;
}}
}
} else {
{ var __hm_with21 = scrHMInstances(Player), __hm_break23=false;
for (var __hm_index22=0; __hm_index22<array_length(__hm_with21); ++__hm_index22) {
if(instance_exists(__hm_with21[__hm_index22])) with (__hm_with21[__hm_index22]) {
if (scrHMButtonPressed(index, "pick")) {
{
if (((scrHMOther(other)).driver == index)) {
{
var __hm_other24=scrHMOther(other);
y = ((__hm_other24.y + __hm_other24.z) - 8);
var __hm_other25=scrHMOther(other);
__hm_other25.driver = (- 1);
var __hm_other26=scrHMOther(other);
__hm_other26.riders -= 1;
roll = 10;
can_walk = 1;
;
can_spec = 1;
;
var __hm_other27=scrHMOther(other);
scrHMMotionAdd((__hm_other27.image_angle + choose((- 90), 90)), 3);
if (((scrHMOther(other)).image_angle < (scrHMOther(other)).direction)) {
var __hm_other28=scrHMOther(other);
__hm_other28.rot = 1;
} else {
if (((scrHMOther(other)).image_angle > (scrHMOther(other)).direction)) {
var __hm_other29=scrHMOther(other);
__hm_other29.rot = (- 1);
}
}
if ((! position_meeting(x, y, Floor))) {
{
z = 16;
outside = 1;
image_alpha = (- 1);
var __hm_other30=scrHMOther(other);
pla_msk = __hm_other30.pla_msk;
var __hm_other31=scrHMOther(other);
pla_shd = __hm_other31.pla_shd;
mask_index = mskNone;
spr_shadow = mskNone;
spr_shadow_y -= 16;
}
} else {
{
var __hm_other32=scrHMOther(other);
mask_index = __hm_other32.pla_msk;
;
var __hm_other33=scrHMOther(other);
spr_shadow = __hm_other33.pla_shd;
image_alpha = 1;
;
var __hm_other34=scrHMOther(other);
__hm_other34.friction = (0.04) * (timescale * timescale);
canfly = 0;
;
}
}
}
} else {
if (((!scrHMVariableExists(id, "rider")) || (rider == (- 1)))) {
{
if ((distance_to_object((scrHMOther(other))) < 16)) {
{
outside = 0;
z = (- 1);
image_alpha = 0;
;
can_walk = 0;
;
canfly = 1;
;
mask_index = mskNone;
;
spr_shadow = mskNone;
;
if ((!scrHMVariableExists(id, "rider"))) {
var __hm_other35=scrHMOther(other);
rider = __hm_other35;
}
var __hm_other36=scrHMOther(other);
__hm_other36.riders += 1;
}
}
}
} else {
if ((rider == (scrHMOther(other)))) {
{
var __hm_other37=scrHMOther(other);
y = ((__hm_other37.y + __hm_other37.z) - 8);
var __hm_other38=scrHMOther(other);
__hm_other38.riders -= 1;
roll = 10;
can_walk = 1;
;
can_spec = 1;
;
var __hm_other39=scrHMOther(other);
scrHMMotionAdd((__hm_other39.image_angle + choose((- 90), 90)), 3);
if ((! position_meeting(x, y, Floor))) {
{
z = 16;
outside = 1;
image_alpha = (- 1);
var __hm_other40=scrHMOther(other);
pla_msk = __hm_other40.pla_msk;
var __hm_other41=scrHMOther(other);
pla_shd = __hm_other41.pla_shd;
mask_index = mskNone;
spr_shadow = mskNone;
spr_shadow_y -= 16;
}
} else {
{
var __hm_other42=scrHMOther(other);
mask_index = __hm_other42.pla_msk;
;
var __hm_other43=scrHMOther(other);
spr_shadow = __hm_other43.pla_shd;
image_alpha = 1;
;
canfly = 0;
;
}
}
}
}
}
}
}
}
}
if(__hm_break23) break;
}}
}
{ var __hm_with44 = scrHMMatching(Player, "rider", id), __hm_break46=false;
for (var __hm_index45=0; __hm_index45<array_length(__hm_with44); ++__hm_index45) {
if(instance_exists(__hm_with44[__hm_index45])) with (__hm_with44[__hm_index45]) {
{
var __hm_other47=scrHMOther(other);
x = (__hm_other47.x + (__hm_other47.hspeed / timescale));
var __hm_other48=scrHMOther(other);
y = ((__hm_other48.y + (__hm_other48.vspeed / timescale)) - z);
}
}
if(__hm_break46) break;
}}
{ var __hm_with49 = scrHMMatching(Player, "outside", 1), __hm_break51=false;
for (var __hm_index50=0; __hm_index50<array_length(__hm_with49); ++__hm_index50) {
if(instance_exists(__hm_with49[__hm_index50])) with (__hm_with49[__hm_index50]) {
{
{ var __hm_with52 = scrHMInstances(scrHMBindDraw(hm_props_mod_gml_outsider_draw, (- 10))), __hm_break54=false;
for (var __hm_index53=0; __hm_index53<array_length(__hm_with52); ++__hm_index53) {
if(instance_exists(__hm_with52[__hm_index53])) with (__hm_with52[__hm_index53]) {
{
var __hm_other55=scrHMOther(other);
creator = __hm_other55;
}
}
if(__hm_break54) break;
}}
if ((position_meeting(x, y, Floor) and (! position_meeting(x, y, Wall)))) {
{
outside = 0;
can_walk = 0;
spr_shadow_y += 16;
}
}
}
}
if(__hm_break51) break;
}}
{ var __hm_with56 = scrHMMatchingGE(Player, "z", 1), __hm_break58=false;
for (var __hm_index57=0; __hm_index57<array_length(__hm_with56); ++__hm_index57) {
if(instance_exists(__hm_with56[__hm_index57])) with (__hm_with56[__hm_index57]) {
if ((outside == 0)) {
{
z -= 2;
if ((z < 10)) {
{
mask_index = pla_msk;
}
}
scrHMMotionSet(direction, 2);
{ var __hm_with59 = scrHMInstances(scrHMBindDraw(hm_props_mod_gml_outsider_draw, (- 2))), __hm_break61=false;
for (var __hm_index60=0; __hm_index60<array_length(__hm_with59); ++__hm_index60) {
if(instance_exists(__hm_with59[__hm_index60])) with (__hm_with59[__hm_index60]) {
{
var __hm_other62=scrHMOther(other);
creator = __hm_other62;
}
}
if(__hm_break61) break;
}}
}
}
}
if(__hm_break58) break;
}}
{ var __hm_with63 = scrHMMatching(Player, "z", 0), __hm_break65=false;
for (var __hm_index64=0; __hm_index64<array_length(__hm_with63); ++__hm_index64) {
if(instance_exists(__hm_with63[__hm_index64])) with (__hm_with63[__hm_index64]) {
{
z = (- 1);
image_alpha = 1;
mask_index = pla_msk;
spr_shadow = pla_shd;
can_walk = 1;
{ var __hm_with66 = scrHMInstances(instance_create(x, y, PortalClear)), __hm_break68=false;
for (var __hm_index67=0; __hm_index67<array_length(__hm_with66); ++__hm_index67) {
if(instance_exists(__hm_with66[__hm_index67])) with (__hm_with66[__hm_index67]) {
{
image_yscale = 0.1;
image_xscale = 0.1;
}
}
if(__hm_break68) break;
}}
}
}
if(__hm_break65) break;
}}
if ((driver == (- 1))) {
{
if ((z > 0)) {
{
if ((place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Floor) and (! place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Wall)))) {
{
z -= 0.3;
if (((speed / timescale) > 0.3)) {
speed -= (0.3) * timescale;
}
image_angle += (((z - 16) / 16) * rot);
}
} else {
if (((! place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Floor)) || place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Wall))) {
if ((z > 16)) {
{
z -= 0.3;
if (((speed / timescale) > 0.3)) {
speed -= (0.3) * timescale;
}
image_angle += (((z - 16) / 16) * rot);
}
}
}
}
}
} else {
if ((((speed / timescale) > 1) and (z > 16))) {
image_angle += ((speed / timescale) / 2);
}
}
}
}
if ((random(16) < 1)) {
{ var __hm_with69 = scrHMInstances(instance_create((x + random_range((- 16), 16)), ((y + random_range((- 16), 16)) - z), CaveSparkle)), __hm_break71=false;
for (var __hm_index70=0; __hm_index70<array_length(__hm_with69); ++__hm_index70) {
if(instance_exists(__hm_with69[__hm_index70])) with (__hm_with69[__hm_index70]) {
depth = (- 11);
}
if(__hm_break71) break;
}}
}
if (((! place_meeting(x, y, Floor)) and ((speed / timescale) > 10))) {
{
portal -= 1;
{ var __hm_with72 = scrHMInstances(instance_create((x + random_range((- 16), 16)), ((y + random_range((- 16), 16)) - z), CaveSparkle)), __hm_break74=false;
for (var __hm_index73=0; __hm_index73<array_length(__hm_with72); ++__hm_index73) {
if(instance_exists(__hm_with72[__hm_index73])) with (__hm_with72[__hm_index73]) {
depth = (- 11);
}
if(__hm_break74) break;
}}
}
} else {
if ((portal < 200)) {
{
portal += 1;
z += 0.4;
}
}
}
if (((place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), enemy) and ((speed / timescale) > 2)) and (z < 16))) {
{
var _hml_car = (scrHMOther(other));
;
{ var __hm_with75 = scrHMInstances(instance_create((x + (hspeed / timescale)), (y + (vspeed / timescale)), Bullet2)), __hm_break77=false;
for (var __hm_index76=0; __hm_index76<array_length(__hm_with75); ++__hm_index76) {
if(instance_exists(__hm_with75[__hm_index76])) with (__hm_with75[__hm_index76]) {
{
image_alpha = 0;
if ((((scrHMOther(other)).speed / timescale) > 5)) {
damage = 10;
} else {
damage = 0;
}
knockback_speed = (_hml_car.direction) * timescale;
direction = _hml_car.direction;
speed = (0.1) * timescale;
team = scrHMPlayerFind(_hml_car.driver).team;
}
}
if(__hm_break77) break;
}}
}
}
if (((place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), prop) and ((speed / timescale) > 2)) and (z < 16))) {
{
var _hml_car = (scrHMOther(other));
;
{ var __hm_with78 = scrHMInstances(instance_create((x + (hspeed / timescale)), (y + (vspeed / timescale)), Bullet2)), __hm_break80=false;
for (var __hm_index79=0; __hm_index79<array_length(__hm_with78); ++__hm_index79) {
if(instance_exists(__hm_with78[__hm_index79])) with (__hm_with78[__hm_index79]) {
{
image_alpha = 0;
if ((((scrHMOther(other)).speed / timescale) > 5)) {
damage = 10;
} else {
damage = 0;
}
knockback_speed = (_hml_car.direction) * timescale;
direction = _hml_car.direction;
speed = (0.1) * timescale;
team = scrHMPlayerFind(_hml_car.driver).team;
}
}
if(__hm_break80) break;
}}
}
}
if (((place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Wall) and place_meeting(x, y, Floor)) and (z < 16))) {
{
instance_create(x, y, PortalClear);
if (((speed / timescale) > 1)) {
speed -= (0.1) * timescale;
}
}
}
if ((driver != (- 1))) {
{ var __hm_with81 = scrHMMatching(Player, "index", driver), __hm_break83=false;
for (var __hm_index82=0; __hm_index82<array_length(__hm_with81); ++__hm_index82) {
if(instance_exists(__hm_with81[__hm_index82])) with (__hm_with81[__hm_index82]) {
{
var __hm_other84=scrHMOther(other);
x = (__hm_other84.x + (__hm_other84.hspeed / timescale));
var __hm_other85=scrHMOther(other);
y = ((__hm_other85.y + (__hm_other85.vspeed / timescale)) - z);
{ var __hm_with86 = scrHMInstances(Portal), __hm_break88=false;
for (var __hm_index87=0; __hm_index87<array_length(__hm_with86); ++__hm_index87) {
if(instance_exists(__hm_with86[__hm_index87])) with (__hm_with86[__hm_index87]) {
if ((((scrHMOther(other)).speed / timescale) >= 5)) {
{
var __hm_other89=scrHMOther(other);
x = (__hm_other89.x + (__hm_other89.hspeed / timescale));
var __hm_other90=scrHMOther(other);
y = (__hm_other90.y + (__hm_other90.vspeed / timescale));
}
}
}
if(__hm_break88) break;
}}
{ var __hm_with91 = scrHMInstances((scrHMOther(other))), __hm_break93=false;
for (var __hm_index92=0; __hm_index92<array_length(__hm_with91); ++__hm_index92) {
if(instance_exists(__hm_with91[__hm_index92])) with (__hm_with91[__hm_index92]) {
if (scrHMCarButton108(driver, "nort")) {
{
direction = image_angle;
;
speed += (0.2) * timescale;
if ((riders >= instance_number(Player))) {
z += 0.2;
}
if (scrHMCarButton108(driver, "west")) {
image_angle += (((speed / timescale) / 5) * 4);
}
if (scrHMCarButton108(driver, "east")) {
image_angle -= (((speed / timescale) / 5) * 4);
}
}
} else {
{
if (((z > 0) and ((speed / timescale) < 5))) {
{
if ((place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Floor) and (! place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Wall)))) {
z -= 0.3;
} else {
if (((! place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Floor)) || place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Wall))) {
if ((z > 16)) {
z -= 0.3;
}
}
}
}
}
if (scrHMCarButton108(driver, "west")) {
image_angle += (2 + ((speed / timescale) / 2));
}
if (scrHMCarButton108(driver, "east")) {
image_angle -= (2 + ((speed / timescale) / 2));
}
if ((((! scrHMCarButton108(driver, "west")) and (! scrHMCarButton108(driver, "east"))) and ((speed / timescale) < 0.1))) {
{
direction = image_angle;
}
}
}
}
}
if(__hm_break93) break;
}}
{ var __hm_with94 = scrHMInstances((scrHMOther(other))), __hm_break96=false;
for (var __hm_index95=0; __hm_index95<array_length(__hm_with94); ++__hm_index95) {
if(instance_exists(__hm_with94[__hm_index95])) with (__hm_with94[__hm_index95]) {
{
if (scrHMCarButton108(driver, "sout")) {
{
direction = image_angle;
speed -= (0.1) * timescale;
if ((z > 0.4)) {
{
if ((place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Floor) and (! place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Wall)))) {
z -= 0.4;
} else {
if (((! place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Floor)) || place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Wall))) {
if ((z > 16)) {
z -= 0.4;
}
}
}
}
}
}
}
}
}
if(__hm_break96) break;
}}
}
}
if(__hm_break83) break;
}}
}
{ var __hm_with97 = scrHMMatchingNE(projectile, "team", (scrHMOther(other)).team), __hm_break99=false;
for (var __hm_index98=0; __hm_index98<array_length(__hm_with97); ++__hm_index98) {
if(instance_exists(__hm_with97[__hm_index98])) with (__hm_with97[__hm_index98]) {
if (((scrHMOther(other)).z < 16)) {
if (place_meeting(x, y, (scrHMOther(other)))) {
{
if ((typ == 1)) {
{
scrHMSoundPlay(sndCrystalRicochet);
var __hm_other100=scrHMOther(other);
team = __hm_other100.team;
var __hm_other101=scrHMOther(other);
hitid = __hm_other101.hitid;
var __hm_other102=scrHMOther(other);
direction = point_direction(__hm_other102.x, __hm_other102.y, x, y);
image_angle = direction;
{ var __hm_with103 = scrHMInstances(instance_create(x, y, Deflect)), __hm_break105=false;
for (var __hm_index104=0; __hm_index104<array_length(__hm_with103); ++__hm_index104) {
if(instance_exists(__hm_with103[__hm_index104])) with (__hm_with103[__hm_index104]) {
var __hm_other106=scrHMOther(other);
image_angle = __hm_other106.direction;
}
if(__hm_break105) break;
}}
}
} else {
if ((typ == 2)) {
{
scrHMSoundPlay(sndCrystalRicochet);
;
instance_destroy();
}
}
}
}
}
}
}
if(__hm_break99) break;
}}
if ((driver == (- 1))) {
{ var __hm_with107 = scrHMInstances(instance_nearest(x, y, Player)), __hm_break109=false;
for (var __hm_index108=0; __hm_index108<array_length(__hm_with107); ++__hm_index108) {
if(instance_exists(__hm_with107[__hm_index108])) with (__hm_with107[__hm_index108]) {
if (place_meeting(x, y, Floor)) {
{ var __hm_with110 = scrHMInstances((scrHMOther(other))), __hm_break112=false;
for (var __hm_index111=0; __hm_index111<array_length(__hm_with110); ++__hm_index111) {
if(instance_exists(__hm_with110[__hm_index111])) with (__hm_with110[__hm_index111]) {
if ((! place_meeting(x, y, Floor))) {
{
var _hml__flo = instance_nearest((x + 16), (y + 16), Floor);
;
scrHMMotionAdd(point_direction(x, y, _hml__flo.x, _hml__flo.y), 0.2);
}
}
}
if(__hm_break112) break;
}}
}
}
if(__hm_break109) break;
}}
}
if ((((portal <= 0) and (driver > (- 1))) and (!scrHMVariableExists(id, "go")))) {
{
go = 1;
{ var __hm_with113 = scrHMMatching(Player, "rider", id), __hm_break115=false;
for (var __hm_index114=0; __hm_index114<array_length(__hm_with113); ++__hm_index114) {
if(instance_exists(__hm_with113[__hm_index114])) with (__hm_with113[__hm_index114]) {
{
var __hm_other116=scrHMOther(other);
mask_index = __hm_other116.pla_msk;
;
var __hm_other117=scrHMOther(other);
spr_shadow = __hm_other117.pla_shd;
;
spr_shadow_y = 0;
visible = 0;
outside = (- 1);
rider = (- 1);
}
}
if(__hm_break115) break;
}}
{ var __hm_with118 = scrHMMatching(Player, "index", driver), __hm_break120=false;
for (var __hm_index119=0; __hm_index119<array_length(__hm_with118); ++__hm_index119) {
if(instance_exists(__hm_with118[__hm_index119])) with (__hm_with118[__hm_index119]) {
{
var __hm_other121=scrHMOther(other);
mask_index = __hm_other121.pla_msk;
;
var __hm_other122=scrHMOther(other);
spr_shadow = __hm_other122.pla_shd;
;
spr_shadow_y = 0;
visible = 0;
outside = (- 1);
background_set_colour(c_black);
if ((GameCont.area != scrHMAreaResolve("venuz"))) {
{ var __hm_with123 = scrHMInstances(instance_create((x - 8), (y - 8), CustomObject)), __hm_break125=false;
for (var __hm_index124=0; __hm_index124<array_length(__hm_with123); ++__hm_index124) {
if(instance_exists(__hm_with123[__hm_index124])) with (__hm_with123[__hm_index124]) {
{
scrHMSoundStop(sndCarLoop);
name = "VenuzElevator";
image_speed = (0) * timescale;
sprite_index = sprFloor103;
image_alpha = 0;
image_index = 1;
depth = 7;
activated = 1;
GameCont.area = scrHMAreaResolve("venuz");
GameCont.subarea = 0;
{ var __hm_with126 = scrHMInstances(Portal), __hm_break128=false;
for (var __hm_index127=0; __hm_index127<array_length(__hm_with126); ++__hm_index127) {
if(instance_exists(__hm_with126[__hm_index127])) with (__hm_with126[__hm_index127]) {
scrHMDelete(id);
}
if(__hm_break128) break;
}}
}
}
if(__hm_break125) break;
}}
} else {
{ var __hm_with129 = scrHMInstances(instance_create(x, y, BigPortal)), __hm_break131=false;
for (var __hm_index130=0; __hm_index130<array_length(__hm_with129); ++__hm_index130) {
if(instance_exists(__hm_with129[__hm_index130])) with (__hm_with129[__hm_index130]) {
{
endgame = 0;
scrHMSoundStopAll();
image_alpha = 0;
GameCont.area = scrHMAreaResolve("junkyard");
GameCont.subarea = 4;
}
}
if(__hm_break131) break;
}}
}
can_die = 1;
var __hm_other132=scrHMOther(other);
__hm_other132.driver = (- 1);
speed = (0) * timescale;
}
}
if(__hm_break120) break;
}}
}
}
}

// Source props.mod.gml:1289; VenuzDoor_create

function hm_props_mod_gml_VenuzDoor_create(_hml__x, _hml__y, _hml__door) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "door";

team = 0;

side = 0;

ox = _hml__x;

oy = _hml__y;

if (((GameCont.subarea <= 3) || (GameCont.subarea == 100))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzDoor;

} else {

if ((((GameCont.subarea <= 6) and (GameCont.subarea > 3)) || (GameCont.subarea == 200))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzDoor2;

} else {

if ((((GameCont.subarea <= 9) and (GameCont.subarea > 6)) || (GameCont.subarea == 300))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzDoor3;

} else {

if ((((GameCont.subarea >= 10) and (GameCont.subarea < 100)) || (GameCont.subarea >= 400))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzDoor4;

}

}

}

}

open = 0;

if ((_hml__door == "A")) {

number = 1;

} else {

if ((_hml__door == "B")) {

number = 2;

} else {

if ((_hml__door == "C")) {

number = 3;

} else {

if ((_hml__door == "D")) {

number = 4;

} else {

if ((_hml__door == "E")) {

number = 5;

} else {

if ((_hml__door == "F")) {

number = 6;

} else {

if ((_hml__door == "G")) {

number = 7;

} else {

if ((_hml__door == "H")) {

number = 8;

} else {

if ((_hml__door == "I")) {

number = 9;

} else {

if ((_hml__door == "J")) {

number = 10;

} else {

if ((_hml__door == "K")) {

number = 11;

} else {

number = 0;

}

}

}

}

}

}

}

}

}

}

}

shadow = 1;

depth = (- 1);

friction = (300) * (timescale * timescale);

hp = 100;

on_step = scrHMScriptRef(hm_props_mod_gml_VenuzDoor_step);

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:1335; VenuzDoorSide_create

function hm_props_mod_gml_VenuzDoorSide_create() {

var _args = [];

for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);

return scrHMTaskStart(hm_props_mod_gml_VenuzDoorSide_create_resume, id, scrHMOther(other), _args, 11, ["_x", "_y", "_door"]);

}

function hm_props_mod_gml_VenuzDoorSide_create_resume(_hm) {

var _budget=0;

while(!_hm.done) {

assert(++_budget<100000,"Hardmode runaway continuation: hm_props_mod_gml_VenuzDoorSide_create");

if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }

with (_hm.scope) { switch (_hm.pc) {

case 0: _hm.done=true; return;

case 1: // props.mod.gml:1336

scrHMTaskWithNext(_hm);

break;

case 2: // props.mod.gml:1336

scrHMTaskWithAbort(_hm);

break;

case 3: // props.mod.gml:1391

{

;

}

_hm.pc=1;

break;

case 4: // props.mod.gml:1391

_hm.result=id; _hm.done=true; return;

break;

case 5: // props.mod.gml:1389

{

;

}

_hm.pc=4;

break;

case 6: // props.mod.gml:1389

_hm.result=undefined; _hm.done=true; return;

break;

case 7: // props.mod.gml:1381

{

if (instance_exists(Wall)) {

{

{ var __hm_with1 = scrHMInstances(instance_create((x - 16), ((y - 16) - 16), Effect)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

sprite_index = (instance_nearest(x, y, Wall)).sprite_index;

image_speed = (0) * timescale;

}

}

if(__hm_break3) break;

}}

{ var __hm_with4 = scrHMInstances(instance_create(x, ((y - 16) - 16), Effect)), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

{

sprite_index = (instance_nearest(x, y, Wall)).sprite_index;

image_speed = (0) * timescale;

}

}

if(__hm_break6) break;

}}

}

}

}

_hm.pc=6;

break;

case 8: // props.mod.gml:1380

_hm.wait_ticks=max(0,2); _hm.pc=7; return;

break;

case 9: // props.mod.gml:1379

_hm.pc = (scrHMTaskFork(_hm, 8)) ? 8 : 4;

break;

case 10: // props.mod.gml:1337

{

name = "door";

side = 1;

team = 0;

ox = _hm.vars._x;

oy = _hm.vars._y;

if (((GameCont.subarea <= 3) || (GameCont.subarea == 100))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzDoorSide;

} else {

if ((((GameCont.subarea <= 6) and (GameCont.subarea > 3)) || (GameCont.subarea == 200))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzDoor2Side;

} else {

if ((((GameCont.subarea <= 9) and (GameCont.subarea > 6)) || (GameCont.subarea == 300))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzDoor3Side;

} else {

if ((((GameCont.subarea >= 10) and (GameCont.subarea < 100)) || (GameCont.subarea >= 400))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzDoor4Side;

}

}

}

}

open = 0;

if ((_hm.vars._door == "A")) {

number = 1;

} else {

if ((_hm.vars._door == "B")) {

number = 2;

} else {

if ((_hm.vars._door == "C")) {

number = 3;

} else {

if ((_hm.vars._door == "D")) {

number = 4;

} else {

if ((_hm.vars._door == "E")) {

number = 5;

} else {

if ((_hm.vars._door == "F")) {

number = 6;

} else {

if ((_hm.vars._door == "G")) {

number = 7;

} else {

if ((_hm.vars._door == "H")) {

number = 8;

} else {

if ((_hm.vars._door == "I")) {

number = 9;

} else {

if ((_hm.vars._door == "J")) {

number = 10;

} else {

if ((_hm.vars._door == "K")) {

number = 11;

} else {

number = 0;

}

}

}

}

}

}

}

}

}

}

}

shadow = 1;

depth = (- 1);

friction = (300) * (timescale * timescale);

hp = 100;

on_step = scrHMScriptRef(hm_props_mod_gml_VenuzDoor_step);

}

_hm.pc=9;

break;

case 11: // props.mod.gml:1336

scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(_hm.vars._x, _hm.vars._y, CustomObject)),10,0);

break;

default: throw "Hardmode invalid continuation PC";

}}

}

}





// Source props.mod.gml:1393; VenuzDoor_step

function hm_props_mod_gml_VenuzDoor_step() {

if ((open == 0)) {

{

{ var __hm_with1 = scrHMInstances(instance_nearest(x, y, DustOLD)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

if ((distance_to_object((scrHMOther(other))) < 63)) {

{

var __hm_other4=scrHMOther(other);

x = (__hm_other4.x - 16);

var __hm_other5=scrHMOther(other);

y = (__hm_other5.y - 16);

}

}

}

if(__hm_break3) break;

}}

if ((! place_meeting(x, y, Floor))) {

instance_create((x - 16), (y - 16), Floor);

}

{ var __hm_with6 = scrHMInstances(instance_nearest(x, y, InvisiWall)), __hm_break8=false;

for (var __hm_index7=0; __hm_index7<array_length(__hm_with6); ++__hm_index7) {

if(instance_exists(__hm_with6[__hm_index7])) with (__hm_with6[__hm_index7]) {

if (place_meeting(x, y, (scrHMOther(other)))) {

scrHMDelete(id);

}

}

if(__hm_break8) break;

}}

}

}

sprite_index = spr_idle;

;

{ var __hm_with9 = scrHMMatchingGT(hitme, "speed", 0), __hm_break11=false;

for (var __hm_index10=0; __hm_index10<array_length(__hm_with9); ++__hm_index10) {

if(instance_exists(__hm_with9[__hm_index10])) with (__hm_with9[__hm_index10]) {

if (place_meeting(x, y, (scrHMOther(other)))) {

{

if (((scrHMOther(other)).side == 0)) {

{

if ((y > (scrHMOther(other)).y)) {

direction = 270;

} else {

if ((y < (scrHMOther(other)).y)) {

direction = 90;

}

}

}

} else {

{

if ((x > (scrHMOther(other)).x)) {

direction = 0;

} else {

if ((x < (scrHMOther(other)).x)) {

direction = 180;

}

}

}

}

}

}

}

if(__hm_break11) break;

}}

{ var __hm_with12 = scrHMInstances(Rocket), __hm_break14=false;

for (var __hm_index13=0; __hm_index13<array_length(__hm_with12); ++__hm_index13) {

if(instance_exists(__hm_with12[__hm_index13])) with (__hm_with12[__hm_index13]) {

if (place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), (scrHMOther(other)))) {

{

{ var __hm_with15 = scrHMInstances(instance_create(x, y, Explosion)), __hm_break17=false;

for (var __hm_index16=0; __hm_index16<array_length(__hm_with15); ++__hm_index16) {

if(instance_exists(__hm_with15[__hm_index16])) with (__hm_with15[__hm_index16]) {

mask_index = mskNone;

}

if(__hm_break17) break;

}}

scrHMDelete(id);

}

}

}

if(__hm_break14) break;

}}

{ var __hm_with18 = scrHMInstances(projectile), __hm_break20=false;

for (var __hm_index19=0; __hm_index19<array_length(__hm_with18); ++__hm_index19) {

if(instance_exists(__hm_with18[__hm_index19])) with (__hm_with18[__hm_index19]) {

if (place_meeting(x, y, (scrHMOther(other)))) {

instance_destroy();

}

}

if(__hm_break20) break;

}}

if (((distance_to_object(Player) <= 16) and (open == 0))) {

{

open = choose((- 1), 1);

{ var __hm_with21 = scrHMMatching(Effect, "name", "secret"), __hm_break23=false;

for (var __hm_index22=0; __hm_index22<array_length(__hm_with21); ++__hm_index22) {

if(instance_exists(__hm_with21[__hm_index22])) with (__hm_with21[__hm_index22]) {

{

if ((distance_to_object((scrHMOther(other))) < 32)) {

{

scrHMTrace("my_dreams");

scrHMDelete(id);

}

}

}

}

if(__hm_break23) break;

}}

{ var __hm_with24 = scrHMMatching(CustomObject, "door", number), __hm_break26=false;

for (var __hm_index25=0; __hm_index25<array_length(__hm_with24); ++__hm_index25) {

if(instance_exists(__hm_with24[__hm_index25])) with (__hm_with24[__hm_index25]) {

{

switch (name) {

case "floor":

{ var __hm_with27 = scrHMInstances(instance_create(x, y, Floor)), __hm_break29=false;

for (var __hm_index28=0; __hm_index28<array_length(__hm_with27); ++__hm_index28) {

if(instance_exists(__hm_with27[__hm_index28])) with (__hm_with27[__hm_index28]) {

{

repeat (4) {

{ var __hm_with30 = scrHMInstances(instance_nearest((x + 16), (y + 16), InvisiWall)), __hm_break32=false;

for (var __hm_index31=0; __hm_index31<array_length(__hm_with30); ++__hm_index31) {

if(instance_exists(__hm_with30[__hm_index31])) with (__hm_with30[__hm_index31]) {

if (place_meeting(x, y, (scrHMOther(other)))) {

scrHMDelete(id);

}

}

if(__hm_break32) break;

}}

{ var __hm_with33 = scrHMInstances(instance_nearest((x + 16), (y + 16), FloorExplo)), __hm_break35=false;

for (var __hm_index34=0; __hm_index34<array_length(__hm_with33); ++__hm_index34) {

if(instance_exists(__hm_with33[__hm_index34])) with (__hm_with33[__hm_index34]) {

if (place_meeting(x, y, (scrHMOther(other)))) {

scrHMDelete(id);

}

}

if(__hm_break35) break;

}}

{ var __hm_with36 = scrHMInstances(instance_nearest((x + 16), (y + 16), Wall)), __hm_break38=false;

for (var __hm_index37=0; __hm_index37<array_length(__hm_with36); ++__hm_index37) {

if(instance_exists(__hm_with36[__hm_index37])) with (__hm_with36[__hm_index37]) {

if (place_meeting(x, y, (scrHMOther(other)))) {

scrHMDelete(id);

}

}

if(__hm_break38) break;

}}

}

}

}

if(__hm_break29) break;

}}

break;

;

case "prisoner":

scrHMModCall("mod", "enemies", "prisoner_create", x, y);

;

break;

;

case "Molefish":

scrHMModCall("mod", "enemies", "Molefish_create", x, y);

;

break;

;

case "Molesarge":

scrHMModCall("mod", "enemies", "Molesarge_create", x, y);

;

break;

;

case "Minigunner":

scrHMModCall("mod", "enemies", "Minigunner_create", x, y);

;

break;

;

case "Jock":

{ var __hm_with39 = scrHMInstances(instance_create(x, y, Jock)), __hm_break41=false;

for (var __hm_index40=0; __hm_index40<array_length(__hm_with39); ++__hm_index40) {

if(instance_exists(__hm_with39[__hm_index40])) with (__hm_with39[__hm_index40]) {

{

raddrop = 0;

;

hp *= 2;

;

wepseed = (- 4);

}

}

if(__hm_break41) break;

}}

break;

;

case "Charger":

scrHMModCall("mod", "enemies", "Monster_create", x, y);

;

break;

;

case "FireBaller":

{ var __hm_with42 = scrHMInstances(instance_create(x, y, FireBaller)), __hm_break44=false;

for (var __hm_index43=0; __hm_index43<array_length(__hm_with42); ++__hm_index43) {

if(instance_exists(__hm_with42[__hm_index43])) with (__hm_with42[__hm_index43]) {

{

raddrop = 0;

;

hp *= 1.5;

;

wepseed = (- 4);

}

}

if(__hm_break44) break;

}}

break;

;

case "SuperFireBaller":

{ var __hm_with45 = scrHMInstances(instance_create(x, y, SuperFireBaller)), __hm_break47=false;

for (var __hm_index46=0; __hm_index46<array_length(__hm_with45); ++__hm_index46) {

if(instance_exists(__hm_with45[__hm_index46])) with (__hm_with45[__hm_index46]) {

{

raddrop = 0;

;

hp *= 2;

;

wepseed = (- 4);

}

}

if(__hm_break47) break;

}}

break;

;

case "Turtle":

scrHMModCall("mod", "enemies", "Chick_create", x, y);

;

break;

;

case "HP":

instance_create(x, y, HealthChest);

break;

;

}

instance_destroy();

}

}

if(__hm_break26) break;

}}

{ var __hm_with48 = scrHMInstances(instance_create((ox - 16), (oy - 16), Floor)), __hm_break50=false;

for (var __hm_index49=0; __hm_index49<array_length(__hm_with48); ++__hm_index49) {

if(instance_exists(__hm_with48[__hm_index49])) with (__hm_with48[__hm_index49]) {

{

door = 0;

hm_field_new = 1;

{ var __hm_with51 = scrHMInstances(Wall), __hm_break53=false;

for (var __hm_index52=0; __hm_index52<array_length(__hm_with51); ++__hm_index52) {

if(instance_exists(__hm_with51[__hm_index52])) with (__hm_with51[__hm_index52]) {

if (place_meeting(x, y, (scrHMOther(other)))) {

scrHMDelete(id);

}

}

if(__hm_break53) break;

}}

{ var __hm_with54 = scrHMInstances(InvisiWall), __hm_break56=false;

for (var __hm_index55=0; __hm_index55<array_length(__hm_with54); ++__hm_index55) {

if(instance_exists(__hm_with54[__hm_index55])) with (__hm_with54[__hm_index55]) {

if (place_meeting(x, y, (scrHMOther(other)))) {

scrHMDelete(id);

}

}

if(__hm_break56) break;

}}

{ var __hm_with57 = scrHMInstances(FloorExplo), __hm_break59=false;

for (var __hm_index58=0; __hm_index58<array_length(__hm_with57); ++__hm_index58) {

if(instance_exists(__hm_with57[__hm_index58])) with (__hm_with57[__hm_index58]) {

if (place_meeting(x, y, (scrHMOther(other)))) {

scrHMDelete(id);

}

}

if(__hm_break59) break;

}}

{ var __hm_with60 = scrHMInstances(DustOLD), __hm_break62=false;

for (var __hm_index61=0; __hm_index61<array_length(__hm_with60); ++__hm_index61) {

if(instance_exists(__hm_with60[__hm_index61])) with (__hm_with60[__hm_index61]) {

if (place_meeting(x, y, (scrHMOther(other)))) {

scrHMDelete(id);

}

}

if(__hm_break62) break;

}}

}

}

if(__hm_break50) break;

}}

}

}

var _hml_spe_ = 3;

;

if (((open > 0) and (open < 30))) {

{

open += _hml_spe_;

scrHMSoundPitchVolume(sndWallBreakLabs, 1.3, 0.5);

if ((side == 0)) {

x += _hml_spe_;

} else {

y -= _hml_spe_;

}

}

} else {

if (((open < 0) and (open > (- 30)))) {

{

open -= _hml_spe_;

scrHMSoundPitchVolume(sndWallBreakLabs, 1.3, 0.5);

if ((side == 0)) {

x -= _hml_spe_;

} else {

y -= _hml_spe_;

}

}

}

}

if ((((open > 16) || (open < (- 16))) and (! instance_exists(SpiralCont)))) {

{

mask_index = mskNone;

}

}

if ((abs(open) >= 30)) {

{

scrHMSoundPitch(sndWallBreakLabs, 1.1);

{ var __hm_with63 = scrHMInstances(instance_create(x, y, Effect)), __hm_break65=false;

for (var __hm_index64=0; __hm_index64<array_length(__hm_with63); ++__hm_index64) {

if(instance_exists(__hm_with63[__hm_index64])) with (__hm_with63[__hm_index64]) {

{

var __hm_other66=scrHMOther(other);

sprite_index = __hm_other66.spr_idle;

image_speed = (0) * timescale;

var __hm_other67=scrHMOther(other);

depth = __hm_other67.depth;

shadow = 1;

}

}

if(__hm_break65) break;

}}

instance_destroy();

}

}

}



// Source props.mod.gml:1536; VenuzFloor_draw

function hm_props_mod_gml_VenuzFloor_draw(_hml_color_) {



}



// Source props.mod.gml:1540; VenuzAmmo1_create

function hm_props_mod_gml_VenuzAmmo1_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "ammo1";

spr_idle = global.hm_module_vars[$ "mod:props"].ammo1;

image_speed = (0) * timescale;

on_step = scrHMScriptRef(hm_props_mod_gml_VenuzAmmo1_step);

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:1548; VenuzAmmo1_step

function hm_props_mod_gml_VenuzAmmo1_step() {

sprite_index = spr_idle;

if ((((image_speed / timescale) > 0) and (image_index >= 6))) {

{

image_speed = (0) * timescale;

image_index = 0;

}

}

if ((((image_speed / timescale) == 0) and (random(50) < 1))) {

image_speed = (0.4) * timescale;

}

{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

if ((distance_to_object((scrHMOther(other))) < 16)) {

{

ammo[1] += 25;

scrHMSoundPitch(sndAmmoPickup, 0.8);

{ var __hm_with4 = scrHMInstances(instance_create(x, y, PopupText)), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

mytext = "+25 BULLETS";

}

if(__hm_break6) break;

}}

instance_create(x, y, ChestOpen);

{ var __hm_with7 = scrHMInstances((scrHMOther(other))), __hm_break9=false;

for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {

if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {

instance_destroy();

}

if(__hm_break9) break;

}}

}

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:1567; VenuzAmmo2_create

function hm_props_mod_gml_VenuzAmmo2_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "ammo2";

spr_idle = sprAmmo;

image_speed = (0) * timescale;

on_step = scrHMScriptRef(hm_props_mod_gml_VenuzAmmo2_step);

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:1575; VenuzAmmo2_step

function hm_props_mod_gml_VenuzAmmo2_step() {

sprite_index = spr_idle;

if ((((image_speed / timescale) > 0) and (image_index >= 6))) {

{

image_speed = (0) * timescale;

image_index = 0;

}

}

if ((((image_speed / timescale) == 0) and (random(50) < 1))) {

image_speed = (0.4) * timescale;

}

{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

if ((distance_to_object((scrHMOther(other))) < 16)) {

{

ammo[2] += 10;

scrHMSoundPitch(sndAmmoPickup, 0.8);

{ var __hm_with4 = scrHMInstances(instance_create(x, y, PopupText)), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

mytext = "+10 SHELLS";

}

if(__hm_break6) break;

}}

instance_create(x, y, ChestOpen);

{ var __hm_with7 = scrHMInstances((scrHMOther(other))), __hm_break9=false;

for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {

if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {

instance_destroy();

}

if(__hm_break9) break;

}}

}

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:1594; VenuzAmmo3_create

function hm_props_mod_gml_VenuzAmmo3_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "ammo3";

spr_idle = sprAmmoChest;

image_speed = (0) * timescale;

on_step = scrHMScriptRef(hm_props_mod_gml_VenuzAmmo3_step);

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:1602; VenuzAmmo3_step

function hm_props_mod_gml_VenuzAmmo3_step() {

sprite_index = spr_idle;

if ((((image_speed / timescale) > 0) and (image_index >= 6))) {

{

image_speed = (0) * timescale;

image_index = 0;

}

}

if ((((image_speed / timescale) == 0) and (random(50) < 1))) {

image_speed = (0.4) * timescale;

}

{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

if ((distance_to_object((scrHMOther(other))) < 16)) {

{

ammo[4] += 6;

scrHMSoundPitch(sndAmmoPickup, 0.8);

{ var __hm_with4 = scrHMInstances(instance_create(x, y, PopupText)), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

mytext = "+6 ROCKETS";

}

if(__hm_break6) break;

}}

instance_create(x, y, ChestOpen);

{ var __hm_with7 = scrHMInstances((scrHMOther(other))), __hm_break9=false;

for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {

if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {

instance_destroy();

}

if(__hm_break9) break;

}}

}

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:1621; VenuzBars_create

function hm_props_mod_gml_VenuzBars_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "bar";

side = 0;

if (((GameCont.subarea <= 3) || (GameCont.subarea == 100))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzBars1;

} else {

if ((((GameCont.subarea <= 6) and (GameCont.subarea > 3)) || (GameCont.subarea == 200))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzBars2;

} else {

if ((((GameCont.subarea <= 9) and (GameCont.subarea > 6)) || (GameCont.subarea == 300))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzBars3;

} else {

if ((((GameCont.subarea >= 10) and (GameCont.subarea < 100)) || (GameCont.subarea >= 400))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzBars4;

}

}

}

}

spr_shadow = mskNone;

shadow = 1;

depth = (- 1);

friction = (300) * (timescale * timescale);

on_step = scrHMScriptRef(hm_props_mod_gml_VenuzBars_step);

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:1640; VenuzBarsSide_create

function hm_props_mod_gml_VenuzBarsSide_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, (_hml__y - 8), CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "bar";

side = 1;

if (((GameCont.subarea <= 3) || (GameCont.subarea == 100))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzBars1Side;

} else {

if ((((GameCont.subarea <= 6) and (GameCont.subarea > 3)) || (GameCont.subarea == 200))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzBars2Side;

} else {

if ((((GameCont.subarea <= 9) and (GameCont.subarea > 6)) || (GameCont.subarea == 300))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzBars1Side;

} else {

if ((((GameCont.subarea >= 10) and (GameCont.subarea < 100)) || (GameCont.subarea >= 400))) {

spr_idle = global.hm_module_vars[$ "mod:props"].VenuzBars4Side;

}

}

}

}

spr_shadow = mskNone;

shadow = 1;

depth = (- 1);

friction = (300) * (timescale * timescale);

on_step = scrHMScriptRef(hm_props_mod_gml_VenuzBars_step);

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:1659; VenuzBars_step

function hm_props_mod_gml_VenuzBars_step() {

sprite_index = spr_idle;

{ var __hm_with1 = scrHMMatchingGT(hitme, "speed", 0), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

if (place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), (scrHMOther(other)))) {

{

if (((scrHMOther(other)).side == 0)) {

{

if ((y > (scrHMOther(other)).y)) {

direction = 270;

} else {

if ((y < (scrHMOther(other)).y)) {

direction = 90;

}

}

}

} else {

{

if ((x > (scrHMOther(other)).x)) {

direction = 0;

} else {

if ((x < (scrHMOther(other)).x)) {

direction = 180;

}

}

}

}

speed *= 0.5;

}

}

}

if(__hm_break3) break;

}}

{ var __hm_with4 = scrHMInstances(Corpse), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

if (place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), (scrHMOther(other)))) {

{

if (((scrHMOther(other)).side == 0)) {

{

if ((y > (scrHMOther(other)).y)) {

direction = 270;

} else {

if ((y < (scrHMOther(other)).y)) {

direction = 90;

}

}

}

} else {

{

if ((x > (scrHMOther(other)).x)) {

direction = 0;

} else {

if ((x < (scrHMOther(other)).x)) {

direction = 180;

}

}

}

}

speed *= 0.5;

}

}

}

if(__hm_break6) break;

}}

}



// Source props.mod.gml:1697; VenuzStar_create

function hm_props_mod_gml_VenuzStar_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "star";

sprite_index = global.hm_module_vars[$ "mod:props"].VenuzStar;

image_speed = (0) * timescale;

spr_shadow = mskNone;

depth = (- 1);

friction = (300) * (timescale * timescale);

on_step = scrHMScriptRef(hm_props_mod_gml_VenuzStar_step);

on_destroy = scrHMScriptRef(hm_props_mod_gml_VenuzStar_destroy);

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:1709; VenuzStar_step

function hm_props_mod_gml_VenuzStar_step() {

if (place_meeting(x, y, Player)) {

instance_destroy();

}

}



// Source props.mod.gml:1712; VenuzStar_destroy

function hm_props_mod_gml_VenuzStar_destroy() {

scrHMModSet("area", "venuz", "secrets", 1);

instance_create(x, y, FXChestOpen);

for (var _hml_s = 0; (_hml_s < 3); _hml_s++) { var __hm_with1 = scrHMInstances(instance_create(x, y, CaveSparkle)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

scrHMMotionAdd((90 + (_hml_s * 120)), 4);

}

if(__hm_break3) break;

}}

scrHMSoundPlay(sndGoldPickup);

}



// Source props.mod.gml:1726; CaveDecal

function hm_props_mod_gml_CaveDecal() {

if ((! instance_exists(argument2))) {

{

scrHMModCall("mod", "enemies", "crystalshielder_create", argument0, argument1);

}

}

instance_destroy();

}



// Source props.mod.gml:1733; iceblock_create

function hm_props_mod_gml_iceblock_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

spr_idle = global.hm_module_vars[$ "mod:props"].iceblock;

image_speed = (0) * timescale;

image_alpha = 0.7;

image_index = choose(0, 0, 0, 1, 2);

open = 100;

depth = (0 - (y / 10016));

{ var __hm_with4 = scrHMInstances(instance_create((x + 8), (y + 8), PlasmaImpact)), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

{

team = 1;

damage = 3000;

}

}

if(__hm_break6) break;

}}

on_step = scrHMScriptRef(hm_props_mod_gml_iceblock_step);

if ((random(30) < 1)) {

{

{ var __hm_with7 = scrHMInstances(instance_create((x + 8), (y + 8), WepPickup)), __hm_break9=false;

for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {

if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {

{

var _hml_weplist = ds_list_create();

;

scrHMWeaponList(_hml_weplist, 0, GameCont.hard);

;

wep = scrHMWeaponResolve(ds_list_find_value(_hml_weplist, irandom((ds_list_size(_hml_weplist) - 1))));

;

ds_list_destroy(_hml_weplist);

;

ammo = 1;

rotation = random(360);

}

}

if(__hm_break9) break;

}}

}

}

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:1760; iceblock_step

function hm_props_mod_gml_iceblock_step() {

sprite_index = spr_idle;

if ((open > 0)) {

if (((distance_to_object(projectile) < 32) and (place_meeting(x, y, CustomProjectile) and (CustomProjectile.sprite_index == sprTrapFire)))) {

{

open -= 2;

var __hm_other1=scrHMOther(other);

instance_create((__hm_other1.x + random_range((- 12), 12)), (__hm_other1.y + random_range((- 12), 12)), Sweat);

}

}

}

var _hml_h = instance_nearest(x, y, hitme);

;

if ((distance_to_object(_hml_h) < 64)) {

{ var __hm_with2 = scrHMMatchingGT(hitme, "speed", 0), __hm_break4=false;

for (var __hm_index3=0; __hm_index3<array_length(__hm_with2); ++__hm_index3) {

if(instance_exists(__hm_with2[__hm_index3])) with (__hm_with2[__hm_index3]) {

if (place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), (scrHMOther(other)))) {

{

speed = (0) * timescale;

direction += 180;

}

}

}

if(__hm_break4) break;

}}

}

var _hml_n = instance_nearest(x, y, projectile);

;

if ((place_meeting(x, y, _hml_n) and (_hml_n.object_index != ((Flame || Laser) || EnemyLaser)))) {

{ var __hm_with5 = scrHMInstances(_hml_n), __hm_break7=false;

for (var __hm_index6=0; __hm_index6<array_length(__hm_with5); ++__hm_index6) {

if(instance_exists(__hm_with5[__hm_index6])) with (__hm_with5[__hm_index6]) {

if ((sprite_index != sprTrapFire)) {

instance_destroy();

} else {

speed *= 0.9;

}

}

if(__hm_break7) break;

}}

}

if (((instance_exists(id) and (open <= 0)) and (open != (- 100)))) {

{

instance_destroy();

}

}

}



// Source props.mod.gml:1789; cave_create

function hm_props_mod_gml_cave_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

time = 125;

mask_index = mskPlayer;

var _hml_n = instance_nearest(x, y, Floor);

;

direction = point_direction((_hml_n.x + 16), (_hml_n.y + 16), x, y);

friction = (0.4) * (timescale * timescale);

on_step = scrHMScriptRef(hm_props_mod_gml_cave_step);

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:1798; cave_step

function hm_props_mod_gml_cave_step() {

if ((GameCont.subarea == 3)) {

direction = point_direction(HyperCrystal.x, HyperCrystal.y, x, y);

}

if (((time > 0) and instance_exists(Wall))) {

{

if ((time >= 125)) {

scrHMMotionAdd(direction, 10);

}

time -= 1;

{ var __hm_with1 = scrHMInstances(instance_create(x, y, PortalClear)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

image_xscale = 0.4;

image_yscale = 0.4;

}

}

if(__hm_break3) break;

}}

}

} else {

{

if ((GameCont.subarea < 3)) {

{

var _hml_n = instance_nearest(x, y, Floor);

;

hm_props_mod_gml_whitecrystal_create(_hml_n.x, _hml_n.y);

{ var __hm_with4 = scrHMInstances(FloorExplo), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

{

if ((distance_to_object((scrHMOther(other))) < 72)) {

{

sprite_index = sprFloor5B;

traction = 0.5;

}

}

if ((distance_to_object((scrHMOther(other))) < 52)) {

{

hm_props_mod_gml_iceblock_create((x + 8), (y + 8));

}

}

}

}

if(__hm_break6) break;

}}

}

} else {

{

{ var __hm_with7 = scrHMInstances(FloorExplo), __hm_break9=false;

for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {

if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {

{

if ((distance_to_object((scrHMOther(other))) < 52)) {

{

sprite_index = sprFloor105;

}

}

}

}

if(__hm_break9) break;

}}

var _hml_n = instance_nearest(x, y, Floor);

;

hm_props_mod_gml_Flower_create(x, y);

instance_create((_hml_n.x + 16), (_hml_n.y + 16), PortalClear);

repeat (32) instance_create((x + random_range((- 150), 150)), (y + random_range((- 150), 150)), LightBeam);

}

}

instance_destroy();

}

}

}



// Source props.mod.gml:0; whitecrystal_create (native content 1.1.0)
function hm_props_mod_gml_whitecrystal_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "hm_ice_entrance";
;
spr_idle = sprIcicle;
spr_hurt = sprIcicleHurt;
spr_dead = sprIcicleDead;
snd_dead = sndCrystalShield;
sprite_index = spr_idle;
spr_shadow = shd32;
hp = 4000;
raddrop = 0;
depth = 0;
open = 50;
mask_index = mskPlayer;
on_step = scrHMScriptRef(hm_props_mod_gml_whitecrystal_step);
hm_arkintide_mod_gml_hm_ice_entrance_clear();
;
}
}
if(__hm_break3) break;
}}
}

// Source props.mod.gml:0; whitecrystal_step (native content 1.1.0)
function hm_props_mod_gml_whitecrystal_step() {scrHMIceCrystal107();}

// Source props.mod.gml:0; Flower_create (native content 1.1.0)
function hm_props_mod_gml_Flower_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomHitme)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "   feed";
spr_idle = global.hm_module_vars[$ "mod:props"].flower;
sprite_index = spr_idle;
;
visible = true;
;
image_alpha = 1;
;
image_speed = (0) * timescale;
;
spr_hurt = sprIceFlowerHurt;
spr_dead = sprIceFlowerDead;
team = 1;
mask_index = mskNone;
;
on_hurt = scrHMContentRef1100("mod", "arkintide", "hm_entrance_hurt");
;
_z = y;
z = 0;
zmax = (y - 1000);
driver = (- 1);
friction = (30) * (timescale * timescale);
scrHMMaxHealthWrite(id, 1500, "=");
hp = 1500;
depth = 0;
fed = 0;
pla_msk = 0;
on_step = scrHMScriptRef(hm_props_mod_gml_Flower_step);
}
}
if(__hm_break3) break;
}}
}

// Source props.mod.gml:0; Flower_step (native content 1.1.0)
function hm_props_mod_gml_Flower_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_props_mod_gml_Flower_step_resume, id, scrHMOther(other), _args, 33, []);
}
function hm_props_mod_gml_Flower_step_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_props_mod_gml_Flower_step");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // props.mod.gml:2000
{
if ((sprite_index == spr_idle)) {
image_speed = (0) * timescale;
} else {
image_speed = (0.4) * timescale;
}
{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((point_distance(x, y, (scrHMOther(other)).x, (scrHMOther(other)).y) < 24)) {
{
{ var __hm_with4 = scrHMInstances((scrHMOther(other))), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{ var __hm_with7 = scrHMInstances(scrHMBindDraw(hm_props_mod_gml_E, (- 11))), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
var __hm_other10=scrHMOther(other);
creator = __hm_other10;
}
if(__hm_break9) break;
}}
}
if(__hm_break6) break;
}}
if (scrHMButtonPressed(index, "pick")) {
{
var __hm_other11=scrHMOther(other);
__hm_other11.fed += 1;
hp -= 1;
instance_create(x, y, BloodStreak);
scrHMSoundPlay(snd_hurt);
if (((scrHMOther(other)).fed >= 4)) {
{
var __hm_other12=scrHMOther(other);
__hm_other12.depth = (- 11);
depth = (- 12);
{ var __hm_with13 = scrHMInstances(Portal), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
instance_destroy();
}
if(__hm_break15) break;
}}
}
}
}
}
}
}
}
if(__hm_break3) break;
}}
}
_hm.pc=0;
break;
case 2: // props.mod.gml:2180
scrHMTaskWithNext(_hm);
break;
case 3: // props.mod.gml:2180
scrHMTaskWithAbort(_hm);
break;
case 4: // props.mod.gml:2183
{
image_alpha = 1;
;
can_walk = 1;
;
can_spec = 1;
;
canfly = 0;
;
depth = (- 2);
;
}
_hm.pc=2;
break;
case 5: // props.mod.gml:2182
_hm.wait_ticks=max(0,60); _hm.pc=4; return;
break;
case 6: // props.mod.gml:2181
{
var __hm_other16=scrHMOther(other);
mask_index = __hm_other16.pla_msk;
;
}
_hm.pc=5;
break;
case 7: // props.mod.gml:2180
scrHMTaskWithEnter(_hm,scrHMInstances(driver),6,0);
break;
case 8: // props.mod.gml:2178
{
;
}
_hm.pc=7;
break;
case 9: // props.mod.gml:2178
_hm.result=undefined; _hm.done=true; return;
break;
case 11: // props.mod.gml:2169
_hm.vars.j += 0.01; _hm.pc=10;
break;
case 12: // props.mod.gml:2176
{
;
}
_hm.pc=11;
break;
case 13: // props.mod.gml:2176
_hm.wait_ticks=max(0,4); _hm.pc=12; return;
break;
case 14: // props.mod.gml:2170
{
_hm.vars.oldbg = scrHMBackgroundColour105();
;
if ((GameCont.area == scrHMAreaResolve("jungleboogie"))) {
{
{ var __hm_with17 = scrHMMatchingGT(GameObject, "image_alpha", 0), __hm_break19=false;
for (var __hm_index18=0; __hm_index18<array_length(__hm_with17); ++__hm_index18) {
if(instance_exists(__hm_with17[__hm_index18])) with (__hm_with17[__hm_index18]) {
image_alpha -= 0.1;
}
if(__hm_break19) break;
}}
background_set_colour(merge_color(_hm.vars.oldbg, c_white, _hm.vars.j));
;
}
}
}
_hm.pc=13;
break;
case 10: // props.mod.gml:2169
_hm.pc=((_hm.vars.j <= 1))?14:9;
break;
case 15: // props.mod.gml:2169
_hm.vars.j = 0;
_hm.pc=10;
break;
case 16: // props.mod.gml:2168
_hm.pc = (scrHMTaskFork(_hm, 15)) ? 15 : 7;
break;
case 17: // props.mod.gml:2159
{
{ var __hm_with20 = scrHMInstances(instance_create(x, y, Portal)), __hm_break22=false;
for (var __hm_index21=0; __hm_index21<array_length(__hm_with20); ++__hm_index21) {
if(instance_exists(__hm_with20[__hm_index21])) with (__hm_with20[__hm_index21]) {
{
nompportal = 1;
image_alpha = 0;
GameCont.area = scrHMAreaResolve("jungleboogie");
}
}
if(__hm_break22) break;
}}
zmax = (y - 100000);
scrHMSetSkill(18, 0);
// Entering the Jungle does not award an extra mutation.
TopCont.darkness = 0;
}
_hm.pc=16;
break;
case 18: // props.mod.gml:2158
_hm.pc = ((y <= zmax)) ? 17 : 0;
break;
case 19: // props.mod.gml:2057
{
{ var __hm_with23 = scrHMMatching(CustomObject, "name", "FlowerScarf"), __hm_break25=false;
for (var __hm_index24=0; __hm_index24<array_length(__hm_with23); ++__hm_index24) {
if(instance_exists(__hm_with23[__hm_index24])) with (__hm_with23[__hm_index24]) {
{
if (((length >= 0) && instance_exists(last_scarf))) {
{
if ((last_scarf == creator)) {
{
targetx = (creator.x - lengthdir_x((12 / image_xscale), ((90 - (creator.right * 90)) + (sin((current_frame / length)) * random_range(8, 12)))));
;
targety = (creator.y - lengthdir_y((12 / image_yscale), ((90 - (creator.right * 90)) + (sin((current_frame / length)) * random_range(8, 12)))));
;
}
} else {
if (instance_exists(creator)) {
{
targetx = (last_scarf.x + lengthdir_x(((creator.speed / timescale) - 2), last_scarf.image_angle));
;
targety = (last_scarf.y + lengthdir_y(((creator.speed / timescale) - 2), last_scarf.image_angle));
;
}
}
}
image_angle = point_direction(x, y, last_scarf.x, last_scarf.y);
;
image_xscale = (1 + point_distance(x, y, last_scarf.x, last_scarf.y));
;
image_yscale = 0.5;
;
if ((last_scarf == creator)) {
{
x = (targetx + offsetx);
;
y = targety;
;
scrHMMotionSet(creator.direction, (creator.speed / timescale));
;
}
} else {
{
if (scrHMVariableExists(id, "targetx")) {
scrHMMotionSet(point_direction(x, y, targetx, targety), (point_distance(x, y, targetx, targety) / 2));
}
}
}
{ var __hm_with26 = scrHMInstances(creator), __hm_break28=false;
for (var __hm_index27=0; __hm_index27<array_length(__hm_with26); ++__hm_index27) {
if(instance_exists(__hm_with26[__hm_index27])) with (__hm_with26[__hm_index27]) {
{
var __hm_other29=scrHMOther(other);
__hm_other29.image_blend = make_color_rgb(64, 37, 28);
;
if ((distance_to_object(Portal) <= 0)) {
{ var __hm_with30 = scrHMInstances((scrHMOther(other))), __hm_break32=false;
for (var __hm_index31=0; __hm_index31<array_length(__hm_with30); ++__hm_index31) {
if(instance_exists(__hm_with30[__hm_index31])) with (__hm_with30[__hm_index31]) {
if (visible) {
{
if ((instance_exists(last_scarf) && (! last_scarf.visible))) {
var __hm_other33=scrHMOther(other);
scrHMMotionSet(point_direction(x, y, __hm_other33.x, __hm_other33.y), 4);
}
if ((distance_to_object(Portal) <= 0)) {
visible = 0;
}
}
}
}
if(__hm_break32) break;
}}
}
}
}
if(__hm_break28) break;
}}
sprite_index = sprBoltTrail;
;
depth = (- 11);
;
image_yscale = 3;
if (((length > 0) && ((!scrHMVariableExists(id, "next_scarf")) || (! instance_exists(next_scarf))))) {
{
next_scarf = instance_create((x - lengthdir_x(1, last_scarf.image_angle)), (y - lengthdir_y(1, last_scarf.image_angle)), CustomObject);
;
{ var __hm_with34 = scrHMInstances(next_scarf), __hm_break36=false;
for (var __hm_index35=0; __hm_index35<array_length(__hm_with34); ++__hm_index35) {
if(instance_exists(__hm_with34[__hm_index35])) with (__hm_with34[__hm_index35]) {
{
name = "FlowerScarf";
;
var __hm_other37=scrHMOther(other);
last_scarf = __hm_other37;
;
var __hm_other38=scrHMOther(other);
creator = __hm_other38.creator;
;
var __hm_other39=scrHMOther(other);
length = (__hm_other39.length - 1);
;
}
}
if(__hm_break36) break;
}}
}
}
}
}
if (((length < 0) || (! instance_exists(last_scarf)))) {
{
repeat (2) { var __hm_with40 = scrHMInstances(instance_create(x, y, Feather)), __hm_break42=false;
for (var __hm_index41=0; __hm_index41<array_length(__hm_with40); ++__hm_index41) {
if(instance_exists(__hm_with40[__hm_index41])) with (__hm_with40[__hm_index41]) {
{
var __hm_other43=scrHMOther(other);
sprite_index = __hm_other43.sprite_index;
;
var __hm_other44=scrHMOther(other);
image_angle = __hm_other44.image_angle;
;
var __hm_other45=scrHMOther(other);
image_blend = __hm_other45.image_blend;
;
var __hm_other46=scrHMOther(other);
creator = __hm_other46.creator;
;
}
}
if(__hm_break42) break;
}}
instance_destroy();
;
}
}
}
}
if(__hm_break25) break;
}}
if ((random(7) < 1)) {
instance_create((x + random_range((- 200), 200)), (y - 64), LightBeam);
}
if ((random(6) < 1)) {
{ var __hm_with47 = scrHMInstances(instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), SnowFlake)), __hm_break49=false;
for (var __hm_index48=0; __hm_index48<array_length(__hm_with47); ++__hm_index48) {
if(instance_exists(__hm_with47[__hm_index48])) with (__hm_with47[__hm_index48]) {
{
sprite_index = sprLeaf;
scrHMMotionAdd(270, 6);
}
}
if(__hm_break49) break;
}}
}
if ((random(4) < 1)) {
{ var __hm_with50 = scrHMInstances(instance_create((x + random_range((- 32), 32)), y, Feather)), __hm_break52=false;
for (var __hm_index51=0; __hm_index51<array_length(__hm_with50); ++__hm_index51) {
if(instance_exists(__hm_with50[__hm_index51])) with (__hm_with50[__hm_index51]) {
{
sprite_index = sprLeaf;
}
}
if(__hm_break52) break;
}}
}
{ var __hm_with53 = scrHMInstances(Portal), __hm_break55=false;
for (var __hm_index54=0; __hm_index54<array_length(__hm_with53); ++__hm_index54) {
if(instance_exists(__hm_with53[__hm_index54])) with (__hm_with53[__hm_index54]) {
{
var __hm_other56=scrHMOther(other);
x = __hm_other56.x;
var __hm_other57=scrHMOther(other);
y = (__hm_other57.y + (__hm_other57.vspeed / timescale));
}
}
if(__hm_break55) break;
}}
image_speed = (0.4) * timescale;
if ((driver == (- 1))) {
{ var __hm_with58 = scrHMInstances(instance_nearest(x, y, Player)), __hm_break60=false;
for (var __hm_index59=0; __hm_index59<array_length(__hm_with58); ++__hm_index59) {
if(instance_exists(__hm_with58[__hm_index59])) with (__hm_with58[__hm_index59]) {
{
outside = 0;
_z = (- 1);
depth = (- 12);
var __hm_other61=scrHMOther(other);
__hm_other61.depth = (- 11);
can_walk = 0;
;
canfly = 1;
;
var __hm_other62=scrHMOther(other);
__hm_other62.team = team;
if ((mask_index != mskNone)) {
var __hm_other63=scrHMOther(other);
__hm_other63.pla_msk = mask_index;
}
mask_index = mskNone;
;
var __hm_other64=scrHMOther(other);
__hm_other64.driver = id;
}
}
if(__hm_break60) break;
}}
}
{ var __hm_with65 = scrHMInstances(driver), __hm_break67=false;
for (var __hm_index66=0; __hm_index66<array_length(__hm_with65); ++__hm_index66) {
if(instance_exists(__hm_with65[__hm_index66])) with (__hm_with65[__hm_index66]) {
{
var __hm_other68=scrHMOther(other);
x = (__hm_other68.x + (__hm_other68.hspeed / timescale));
var __hm_other69=scrHMOther(other);
y = ((__hm_other69.y + (__hm_other69.vspeed / timescale)) - 4);
if (scrHMButtonPressed(index, "west")) {
scrHMMotionAdd(180, 0.5);
}
if (scrHMButtonPressed(index, "west")) {
scrHMMotionAdd(0, 0.5);
}
}
}
if(__hm_break67) break;
}}
friction = (0) * (timescale * timescale);
scrHMMotionAdd(90, 0.05);
}
_hm.pc=18;
break;
case 20: // props.mod.gml:2045
{
scarf3 = instance_create(x, y, CustomObject);
;
{ var __hm_with70 = scrHMInstances(scarf3), __hm_break72=false;
for (var __hm_index71=0; __hm_index71<array_length(__hm_with70); ++__hm_index71) {
if(instance_exists(__hm_with70[__hm_index71])) with (__hm_with70[__hm_index71]) {
{
name = "FlowerScarf";
;
var __hm_other73=scrHMOther(other);
creator = __hm_other73;
;
var __hm_other74=scrHMOther(other);
last_scarf = __hm_other74;
;
length = 15;
;
offsetx = 5;
}
}
if(__hm_break72) break;
}}
}
_hm.pc=19;
break;
case 21: // props.mod.gml:2044
_hm.wait_ticks=max(0,4); _hm.pc=20; return;
break;
case 22: // props.mod.gml:2036
{
scarf2 = instance_create(x, y, CustomObject);
;
{ var __hm_with75 = scrHMInstances(scarf2), __hm_break77=false;
for (var __hm_index76=0; __hm_index76<array_length(__hm_with75); ++__hm_index76) {
if(instance_exists(__hm_with75[__hm_index76])) with (__hm_with75[__hm_index76]) {
{
name = "FlowerScarf";
;
var __hm_other78=scrHMOther(other);
creator = __hm_other78;
;
var __hm_other79=scrHMOther(other);
last_scarf = __hm_other79;
;
length = 15;
;
offsetx = (- 5);
;
}
}
if(__hm_break77) break;
}}
}
_hm.pc=21;
break;
case 23: // props.mod.gml:2035
_hm.wait_ticks=max(0,2); _hm.pc=22; return;
break;
case 24: // props.mod.gml:2026
{
scarf = instance_create(x, y, CustomObject);
;
right = image_xscale;
{ var __hm_with80 = scrHMInstances(scarf), __hm_break82=false;
for (var __hm_index81=0; __hm_index81<array_length(__hm_with80); ++__hm_index81) {
if(instance_exists(__hm_with80[__hm_index81])) with (__hm_with80[__hm_index81]) {
{
name = "FlowerScarf";
;
var __hm_other83=scrHMOther(other);
creator = __hm_other83;
;
var __hm_other84=scrHMOther(other);
last_scarf = __hm_other84;
;
length = 20;
;
offsetx = 0;
;
}
}
if(__hm_break82) break;
}}
}
_hm.pc=23;
break;
case 25: // props.mod.gml:2025
_hm.pc = (((!scrHMVariableExists(_hm.scope, "scarf")) || (! instance_exists(scarf)))) ? 24 : 19;
break;
case 26: // props.mod.gml:2000
_hm.pc = ((fed < 4)) ? 1 : 25;
break;
case 27: // props.mod.gml:1991
{
if ((nexthurt > current_frame)) {
{
if ((sprite_index != spr_hurt)) {
{
image_index = 0;
;
sprite_index = spr_hurt;
;
}
}
}
} else {
sprite_index = spr_idle;
}
;
}
_hm.pc=26;
break;
case 28: // props.mod.gml:1989
{
hm_flower_unlocked = 1;
;
}
_hm.pc=27;
break;
case 29: // props.mod.gml:1988
{
;
}
_hm.pc=28;
break;
case 30: // props.mod.gml:1988
_hm.result=undefined; _hm.done=true; return;
break;
case 31: // props.mod.gml:1988
{
sprite_index = spr_idle;
;
image_speed = (0) * timescale;
;
}
_hm.pc=30;
break;
case 32: // props.mod.gml:1988
_hm.pc = ((! hm_arkintide_mod_gml_hm_combat_clear())) ? 31 : 28;
break;
case 33: // props.mod.gml:1987
_hm.pc = (((fed < 4) && (! (scrHMVariableExists(_hm.scope, "hm_flower_unlocked") && hm_flower_unlocked)))) ? 32 : 27;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

// Source props.mod.gml:2106; lookout_create

function hm_props_mod_gml_lookout_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "lookout";

depth = 0;

image_speed = (0.4) * timescale;

on_step = scrHMScriptRef(hm_props_mod_gml_lookout_step);

{ var __hm_with4 = scrHMInstances(instance_create(x, (y + 8), CustomObject)), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

{

name = " ENTER";

depth = 0;

z = 0;

image_speed = (0.2) * timescale;

on_step = scrHMScriptRef(hm_props_mod_gml_hole_step);

}

}

if(__hm_break6) break;

}}

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:2120; lookout_step

function hm_props_mod_gml_lookout_step() {

sprite_index = global.hm_module_vars[$ "mod:props"].lookout;

if ((image_index > 27)) {

instance_destroy();

}

}



// Source props.mod.gml:2124; hole_step

function hm_props_mod_gml_hole_step() {

var _args = [];

for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);

return scrHMTaskStart(hm_props_mod_gml_hole_step_resume, id, scrHMOther(other), _args, 10, []);

}

function hm_props_mod_gml_hole_step_resume(_hm) {

var _budget=0;

while(!_hm.done) {

assert(++_budget<100000,"Hardmode runaway continuation: hm_props_mod_gml_hole_step");

if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }

with (_hm.scope) { switch (_hm.pc) {

case 0: _hm.done=true; return;

case 1: // props.mod.gml:2138

{

if (((image_index > 31) and instance_exists(id))) {

instance_destroy();

}

}

_hm.pc=0;

break;

case 2: // props.mod.gml:2131

scrHMTaskWithNext(_hm);

break;

case 3: // props.mod.gml:2131

scrHMTaskWithAbort(_hm);

break;

case 4: // props.mod.gml:2135

{

GameCont.area = scrHMAreaResolve("yeti");

}

_hm.pc=2;

break;

case 5: // props.mod.gml:2134

_hm.wait_ticks=max(0,3); _hm.pc=4; return;

break;

case 6: // props.mod.gml:2133

{

instance_create(x, y, Portal);

}

_hm.pc=5;

break;

case 7: // props.mod.gml:2132

_hm.pc = (scrHMButtonPressed(index, "pick")) ? 6 : 2;

break;

case 8: // props.mod.gml:2131

_hm.pc = ((distance_to_object(_hm.other_scope) < 16)) ? 7 : 2;

break;

case 9: // props.mod.gml:2131

scrHMTaskWithEnter(_hm,scrHMInstances(Player),8,1);

break;

case 10: // props.mod.gml:2125

{

sprite_index = global.hm_module_vars[$ "mod:props"].hole;

if ((distance_to_object(Player) < 16)) {

{

{ var __hm_with1 = scrHMInstances(scrHMBindDraw(hm_props_mod_gml_E, (- 11))), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

var __hm_other4=scrHMOther(other);

creator = __hm_other4;

}

if(__hm_break3) break;

}}

}

}

}

_hm.pc=9;

break;

default: throw "Hardmode invalid continuation PC";

}}

}

}





// Source props.mod.gml:2142; leave_create

function hm_props_mod_gml_leave_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = " leave";

if ((GameCont.area == scrHMAreaResolve("end"))) {

name = " light";

}

mask_index = mskPlayer;

z = 0;

on_step = scrHMScriptRef(hm_props_mod_gml_leave_step);

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:2151; leave_step

function hm_props_mod_gml_leave_step() {

{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

if ((distance_to_object((scrHMOther(other))) < 16)) {

{

var _hml_me = (scrHMOther(other));

;

{ var __hm_with4 = scrHMInstances((scrHMOther(other))), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

{ var __hm_with7 = scrHMInstances(scrHMBindDraw(hm_props_mod_gml_E, (- 11))), __hm_break9=false;

for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {

if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {

var __hm_other10=scrHMOther(other);

creator = __hm_other10;

}

if(__hm_break9) break;

}}

}

if(__hm_break6) break;

}}

if (scrHMButtonPressed(index, "pick")) {

{

{ var __hm_with11 = scrHMInstances(instance_create(x, y, Portal)), __hm_break13=false;

for (var __hm_index12=0; __hm_index12<array_length(__hm_with11); ++__hm_index12) {

if(instance_exists(__hm_with11[__hm_index12])) with (__hm_with11[__hm_index12]) {

{

if ((GameCont.area == scrHMAreaResolve("end"))) {

{

image_alpha = 0;

{ var __hm_with14 = scrHMInstances(Campfire), __hm_break16=false;

for (var __hm_index15=0; __hm_index15<array_length(__hm_with14); ++__hm_index15) {

if(instance_exists(__hm_with14[__hm_index15])) with (__hm_with14[__hm_index15]) {

spr_idle = sprCampfire;

}

if(__hm_break16) break;

}}

{ var __hm_with17 = scrHMInstances(instance_create(_hml_me.x, _hml_me.y, GroundFlame)), __hm_break19=false;

for (var __hm_index18=0; __hm_index18<array_length(__hm_with17); ++__hm_index18) {

if(instance_exists(__hm_with17[__hm_index18])) with (__hm_with17[__hm_index18]) {

sprite_index = sprGroundFlameBig;

}

if(__hm_break19) break;

}}

}

}

}

}

if(__hm_break13) break;

}}

{ var __hm_with20 = scrHMInstances((scrHMOther(other))), __hm_break22=false;

for (var __hm_index21=0; __hm_index21<array_length(__hm_with20); ++__hm_index21) {

if(instance_exists(__hm_with20[__hm_index21])) with (__hm_with20[__hm_index21]) {

instance_destroy();

}

if(__hm_break22) break;

}}

}

}

}

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:2172; bigtube1_create

function hm_props_mod_gml_bigtube1_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomHitme)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "bigtube1";

spr_idle = global.hm_module_vars[$ "mod:props"].bigtube;

spr_hurt = global.hm_module_vars[$ "mod:props"].bigtubehurt;

spr_dead = global.hm_module_vars[$ "mod:props"].bigtubedead;

snd_hurt = sndLabsTubeBreak;

snd_dead = sndLabsMutantTubeBreak;

team = (- 1);

image_xscale = choose(1, 1, (- 1));

friction = (30) * (timescale * timescale);

hp = 20;

depth = (- 10);

on_step = scrHMScriptRef(hm_props_mod_gml_bigtube1_step);

on_hurt = scrHMScriptRef(hm_props_mod_gml_bigtube_hurt);

on_destroy = scrHMScriptRef(hm_props_mod_gml_bigtube1_dead);

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:2189; bigtube1_step

function hm_props_mod_gml_bigtube1_step() {

if ((nexthurt > current_frame)) {

{

if ((sprite_index != spr_hurt)) {

{

image_index = 0;

;

sprite_index = spr_hurt;

;

}

}

}

} else {

{

sprite_index = spr_idle;

;

}

}

{ var __hm_with1 = scrHMInstances(instance_nearest(x, y, hitme)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

if (place_meeting(x, (y + 8), (scrHMOther(other)))) {

{

var __hm_other4=scrHMOther(other);

scrHMMotionAdd(point_direction(__hm_other4.x, (__hm_other4.y + 8), x, y), 0.5);

}

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:2201; bigtube_hurt

function hm_props_mod_gml_bigtube_hurt() {

if ((sprite_index != spr_hurt)) {

{

hp -= argument0;

;

image_index = 0;

;

sprite_index = spr_hurt;

;

}

}

if ((hp <= 0)) {

{

instance_destroy();

}

}

}



// Source props.mod.gml:0; bigtube1_dead (native content 1.1.0)
function hm_props_mod_gml_bigtube1_dead() {
scrHMModCall("mod", "enemies", "enemysteroids_create", x, y);
repeat (30) { var __hm_with1 = scrHMInstances(instance_create(x, y, Rad)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMMotionAdd(random(360), random(5));
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(instance_create(x, y, Corpse)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
do_portal = 0;
;
alarm[0] = (- 1);
;
var __hm_other7=scrHMOther(other);
sprite_index = __hm_other7.spr_dead;
speed = (0) * timescale;
}
}
if(__hm_break6) break;
}}
}

// Source props.mod.gml:2221; bigtube2_create

function hm_props_mod_gml_bigtube2_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomHitme)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = "bigtube2";

spr_idle = global.hm_module_vars[$ "mod:props"].bigtube2;

spr_hurt = global.hm_module_vars[$ "mod:props"].bigtube2hurt;

spr_dead = global.hm_module_vars[$ "mod:props"].bigtube2dead;

snd_hurt = sndLabsTubeBreak;

snd_dead = sndLabsMutantTubeBreak;

team = (- 1);

image_xscale = choose(1, 1, (- 1));

friction = (30) * (timescale * timescale);

hp = 20;

depth = (- 10);

on_step = scrHMScriptRef(hm_props_mod_gml_bigtube1_step);

on_hurt = scrHMScriptRef(hm_props_mod_gml_bigtube_hurt);

on_destroy = scrHMScriptRef(hm_props_mod_gml_bigtube2_dead);

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:0; bigtube2_dead (native content 1.1.0)
function hm_props_mod_gml_bigtube2_dead() {
instance_create(x, y, PopoFreak);
repeat (30) { var __hm_with1 = scrHMInstances(instance_create(x, y, Rad)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMMotionAdd(random(360), random(5));
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(instance_create(x, y, Corpse)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
do_portal = 0;
;
alarm[0] = (- 1);
;
var __hm_other7=scrHMOther(other);
sprite_index = __hm_other7.spr_dead;
speed = (0) * timescale;
}
}
if(__hm_break6) break;
}}
}

// Source props.mod.gml:2251; terminal_create

function hm_props_mod_gml_terminal_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

name = " Palace";

spr_idle = sprTerminal;

spr_hurt = sprTerminalHurt;

snd_hurt = sndHitWall;

mask_index = mskNone;

z = 0;

friction = (30) * (timescale * timescale);

hp = 4000;

depth = 0;

on_step = scrHMScriptRef(hm_props_mod_gml_terminal_step);

}

}

if(__hm_break3) break;

}}

}



// Source props.mod.gml:2264; terminal_step

function hm_props_mod_gml_terminal_step() {

sprite_index = spr_idle;

{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

if ((distance_to_object((scrHMOther(other))) < 16)) {

{

var _hml_cpu = (scrHMOther(other));

;

{ var __hm_with4 = scrHMInstances((scrHMOther(other))), __hm_break6=false;

for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {

if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {

{ var __hm_with7 = scrHMInstances(scrHMBindDraw(hm_props_mod_gml_E, (- 11))), __hm_break9=false;

for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {

if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {

var __hm_other10=scrHMOther(other);

creator = __hm_other10;

}

if(__hm_break9) break;

}}

}

if(__hm_break6) break;

}}

if (scrHMButtonPressed(index, "pick")) {

{

if (instance_exists(BigTV)) {

{

scrHMSoundPlay(sndClick);

{ var __hm_with11 = scrHMInstances(BigTV), __hm_break13=false;

for (var __hm_index12=0; __hm_index12<array_length(__hm_with11); ++__hm_index12) {

if(instance_exists(__hm_with11[__hm_index12])) with (__hm_with11[__hm_index12]) {

{

if ((spr_idle == spr_tv1)) {

{

spr_idle = spr_tv2;

;

_hml_cpu.name = "   HQ";

if ((scrHMModExists("area", "elevator", "nextarea") and (scrHMModGet("area", "elevator", "nextarea") == 1))) {

scrHMModSet("area", "elevator", "nextarea", 0);

}

}

} else {

if ((spr_idle == spr_tv2)) {

{

spr_idle = spr_tv1;

;

_hml_cpu.name = " Palace";

if ((scrHMModExists("area", "elevator", "nextarea") and (scrHMModGet("area", "elevator", "nextarea") == 0))) {

scrHMModSet("area", "elevator", "nextarea", 1);

}

}

}

}

}

}

if(__hm_break13) break;

}}

}

} else {

scrHMSoundPlay(sndComputerBreak);

}

}

}

}

}

}

if(__hm_break3) break;

}}

if ((! instance_exists(BigTV))) {

instance_destroy();

}

}



// Source props.mod.gml:0; elevator_create (native content 1.1.0)
function hm_props_mod_gml_elevator_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomHitme)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "elevator";
;
hm_elevator_wait = 40;
;
hm_elevator_exit = noone;
mask_index=mskNone;
;
spr_idle = global.hm_module_vars[$ "mod:props"].elevator;
spr_hurt = global.hm_module_vars[$ "mod:props"].elevator;
snd_hurt = sndHitWall;
friction = (30) * (timescale * timescale);
hp = 4000;
depth = 0;
on_step = scrHMScriptRef(hm_props_mod_gml_elevator_step);
on_hurt = scrHMScriptRef(hm_props_mod_gml_elevator_hurt);
}
}
if(__hm_break3) break;
}}
}

// Source props.mod.gml:0; elevator_step (native content 1.1.0)
function hm_props_mod_gml_elevator_step() {
scrHMElevatorStep1102();
}

// Source props.mod.gml:2323; elevator_hurt

function hm_props_mod_gml_elevator_hurt() {

if ((sprite_index != spr_hurt)) {

{

image_index = 0;

;

sprite_index = spr_hurt;

;

}

}

}



// Source props.mod.gml:0; joao_shockwave (native content 1.1.0)
function hm_props_mod_gml_joao_shockwave() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_props_mod_gml_joao_shockwave_resume, id, scrHMOther(other), _args, 260, []);
}
function hm_props_mod_gml_joao_shockwave_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_props_mod_gml_joao_shockwave");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // props.mod.gml:2787
{
;
}
_hm.pc=0;
break;
case 2: // props.mod.gml:2787
_hm.result=undefined; _hm.done=true; return;
break;
case 3: // props.mod.gml:2775
scrHMTaskWithNext(_hm);
break;
case 4: // props.mod.gml:2775
scrHMTaskWithAbort(_hm);
break;
case 5: // props.mod.gml:2781
{
;
}
_hm.pc=3;
break;
case 6: // props.mod.gml:2781
_hm.result=undefined; _hm.done=true; return;
break;
case 7: // props.mod.gml:2778
{
;
if (instance_exists(id)) {
sprite_index = sprTopDecalCave;
}
}
_hm.pc=6;
break;
case 8: // props.mod.gml:2778
_hm.wait_ticks=max(0,(distance_to_object(_hm.vars._target) / 8)); _hm.pc=7; return;
break;
case 9: // props.mod.gml:2777
_hm.pc = (scrHMTaskFork(_hm, 8)) ? 8 : 3;
break;
case 10: // props.mod.gml:2785
sprite_index = sprTopDecalCave;
_hm.pc=3;
break;
case 11: // props.mod.gml:2776
_hm.pc = (point_in_rectangle(x, y, (view_xview - 32), (view_yview - 32), ((view_xview + view_width) + 32), ((view_yview + view_height) + 32))) ? 9 : 10;
break;
case 12: // props.mod.gml:2775
_hm.pc = (instance_exists(_hm.other_scope)) ? 11 : 3;
break;
case 13: // props.mod.gml:2775
scrHMTaskWithEnter(_hm,scrHMInstances(TopDecalInvCave),12,2);
break;
case 14: // props.mod.gml:2764
scrHMTaskWithNext(_hm);
break;
case 15: // props.mod.gml:2764
scrHMTaskWithAbort(_hm);
break;
case 16: // props.mod.gml:2770
{
;
}
_hm.pc=14;
break;
case 17: // props.mod.gml:2770
_hm.result=undefined; _hm.done=true; return;
break;
case 18: // props.mod.gml:2767
{
;
if (instance_exists(id)) {
sprite_index = sprCaveDecal;
}
}
_hm.pc=17;
break;
case 19: // props.mod.gml:2767
_hm.wait_ticks=max(0,(distance_to_object(_hm.vars._target) / 8)); _hm.pc=18; return;
break;
case 20: // props.mod.gml:2766
_hm.pc = (scrHMTaskFork(_hm, 19)) ? 19 : 14;
break;
case 21: // props.mod.gml:2774
sprite_index = sprCaveDecal;
_hm.pc=14;
break;
case 22: // props.mod.gml:2765
_hm.pc = (point_in_rectangle(x, y, (view_xview - 32), (view_yview - 32), ((view_xview + view_width) + 32), ((view_yview + view_height) + 32))) ? 20 : 21;
break;
case 23: // props.mod.gml:2764
_hm.pc = (instance_exists(_hm.other_scope)) ? 22 : 14;
break;
case 24: // props.mod.gml:2764
scrHMTaskWithEnter(_hm,scrHMInstances(Bones),23,13);
break;
case 25: // props.mod.gml:2753
scrHMTaskWithNext(_hm);
break;
case 26: // props.mod.gml:2753
scrHMTaskWithAbort(_hm);
break;
case 27: // props.mod.gml:2759
{
;
}
_hm.pc=25;
break;
case 28: // props.mod.gml:2759
_hm.result=undefined; _hm.done=true; return;
break;
case 29: // props.mod.gml:2756
{
;
if (instance_exists(id)) {
sprite_index = sprCaveSparkle;
}
}
_hm.pc=28;
break;
case 30: // props.mod.gml:2756
_hm.wait_ticks=max(0,(distance_to_object(_hm.vars._target) / 8)); _hm.pc=29; return;
break;
case 31: // props.mod.gml:2755
_hm.pc = (scrHMTaskFork(_hm, 30)) ? 30 : 25;
break;
case 32: // props.mod.gml:2763
sprite_index = sprCaveSparkle;
_hm.pc=25;
break;
case 33: // props.mod.gml:2754
_hm.pc = (point_in_rectangle(x, y, (view_xview - 32), (view_yview - 32), ((view_xview + view_width) + 32), ((view_yview + view_height) + 32))) ? 31 : 32;
break;
case 34: // props.mod.gml:2753
_hm.pc = (instance_exists(_hm.other_scope)) ? 33 : 25;
break;
case 35: // props.mod.gml:2753
scrHMTaskWithEnter(_hm,scrHMInstances(Curse),34,24);
break;
case 36: // props.mod.gml:2737
scrHMTaskWithNext(_hm);
break;
case 37: // props.mod.gml:2737
scrHMTaskWithAbort(_hm);
break;
case 38: // props.mod.gml:2746
{
;
}
_hm.pc=36;
break;
case 39: // props.mod.gml:2746
_hm.result=undefined; _hm.done=true; return;
break;
case 40: // props.mod.gml:2741
{
;
if (instance_exists(id)) {
{
scrHMClearCursedAmmo();
;
sprite_index = sprAmmo;
;
}
}
}
_hm.pc=39;
break;
case 41: // props.mod.gml:2741
_hm.wait_ticks=max(0,(distance_to_object(_hm.vars._target) / 8)); _hm.pc=40; return;
break;
case 42: // props.mod.gml:2740
_hm.pc = (scrHMTaskFork(_hm, 41)) ? 41 : 36;
break;
case 43: // props.mod.gml:2739
_hm.pc = ((cursed != 0)) ? 42 : 36;
break;
case 44: // props.mod.gml:2749
{
cursed = 0;
;
scrHMClearCursedAmmo();
;
}
_hm.pc=36;
break;
case 45: // props.mod.gml:2738
_hm.pc = (point_in_rectangle(x, y, (view_xview - 32), (view_yview - 32), ((view_xview + view_width) + 32), ((view_yview + view_height) + 32))) ? 43 : 44;
break;
case 46: // props.mod.gml:2737
_hm.pc = (instance_exists(_hm.other_scope)) ? 45 : 36;
break;
case 47: // props.mod.gml:2737
scrHMTaskWithEnter(_hm,scrHMInstances(AmmoPickup),46,35);
break;
case 48: // props.mod.gml:2726
scrHMTaskWithNext(_hm);
break;
case 49: // props.mod.gml:2726
scrHMTaskWithAbort(_hm);
break;
case 50: // props.mod.gml:2731
{
;
}
_hm.pc=48;
break;
case 51: // props.mod.gml:2731
_hm.result=undefined; _hm.done=true; return;
break;
case 52: // props.mod.gml:2729
{
;
if (instance_exists(id)) {
sprite_index = sprSpiderDead;
}
}
_hm.pc=51;
break;
case 53: // props.mod.gml:2729
_hm.wait_ticks=max(0,(distance_to_object(_hm.vars._target) / 8)); _hm.pc=52; return;
break;
case 54: // props.mod.gml:2728
_hm.pc = (scrHMTaskFork(_hm, 53)) ? 53 : 48;
break;
case 55: // props.mod.gml:2734
{
sprite_index = sprSpiderDead;
}
_hm.pc=48;
break;
case 56: // props.mod.gml:2727
_hm.pc = (point_in_rectangle(x, y, (view_xview - 32), (view_yview - 32), ((view_xview + view_width) + 32), ((view_yview + view_height) + 32))) ? 54 : 55;
break;
case 57: // props.mod.gml:2726
_hm.pc = (instance_exists(_hm.other_scope)) ? 56 : 48;
break;
case 58: // props.mod.gml:2726
scrHMTaskWithEnter(_hm,scrHMMatching(Corpse, "sprite_index", sprInvSpiderDead),57,47);
break;
case 59: // props.mod.gml:2714
scrHMTaskWithNext(_hm);
break;
case 60: // props.mod.gml:2714
scrHMTaskWithAbort(_hm);
break;
case 61: // props.mod.gml:2719
{
;
}
_hm.pc=59;
break;
case 62: // props.mod.gml:2719
_hm.result=undefined; _hm.done=true; return;
break;
case 63: // props.mod.gml:2717
{
;
if (instance_exists(id)) {
hm_arkintide_mod_gml_hm_convert_enemy(Spider);
}
}
_hm.pc=62;
break;
case 64: // props.mod.gml:2717
_hm.wait_ticks=max(0,(distance_to_object(_hm.vars._target) / 8)); _hm.pc=63; return;
break;
case 65: // props.mod.gml:2716
_hm.pc = (scrHMTaskFork(_hm, 64)) ? 64 : 59;
break;
case 66: // props.mod.gml:2722
{
hm_arkintide_mod_gml_hm_convert_enemy(Spider);
}
_hm.pc=59;
break;
case 67: // props.mod.gml:2715
_hm.pc = (point_in_rectangle(x, y, (view_xview - 32), (view_yview - 32), ((view_xview + view_width) + 32), ((view_yview + view_height) + 32))) ? 65 : 66;
break;
case 68: // props.mod.gml:2714
_hm.pc = (instance_exists(_hm.other_scope)) ? 67 : 59;
break;
case 69: // props.mod.gml:2714
scrHMTaskWithEnter(_hm,scrHMInstances(InvSpider),68,58);
break;
case 70: // props.mod.gml:2713
{
{ var __hm_with1 = scrHMInstances(InvLaserCrystal), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
hm_arkintide_mod_gml_hm_convert_enemy(LaserCrystal);
}
if(__hm_break3) break;
}}
;
}
_hm.pc=69;
break;
case 71: // props.mod.gml:2701
scrHMTaskWithNext(_hm);
break;
case 72: // props.mod.gml:2701
scrHMTaskWithAbort(_hm);
break;
case 73: // props.mod.gml:2707
{
;
}
_hm.pc=71;
break;
case 74: // props.mod.gml:2707
_hm.result=undefined; _hm.done=true; return;
break;
case 75: // props.mod.gml:2705
{
;
if (instance_exists(id)) {
curse = 0;
}
}
_hm.pc=74;
break;
case 76: // props.mod.gml:2705
_hm.wait_ticks=max(0,(distance_to_object(_hm.vars._target) / 8)); _hm.pc=75; return;
break;
case 77: // props.mod.gml:2704
_hm.pc = (scrHMTaskFork(_hm, 76)) ? 76 : 71;
break;
case 78: // props.mod.gml:2703
_hm.pc = ((curse != 0)) ? 77 : 71;
break;
case 79: // props.mod.gml:2710
{
curse = 0;
;
}
_hm.pc=71;
break;
case 80: // props.mod.gml:2702
_hm.pc = (point_in_rectangle(x, y, (view_xview - 32), (view_yview - 32), ((view_xview + view_width) + 32), ((view_yview + view_height) + 32))) ? 78 : 79;
break;
case 81: // props.mod.gml:2701
_hm.pc = (instance_exists(_hm.other_scope)) ? 80 : 71;
break;
case 82: // props.mod.gml:2701
scrHMTaskWithEnter(_hm,scrHMInstances(WepPickup),81,70);
break;
case 83: // props.mod.gml:2690
scrHMTaskWithNext(_hm);
break;
case 84: // props.mod.gml:2690
scrHMTaskWithAbort(_hm);
break;
case 85: // props.mod.gml:2695
{
;
}
_hm.pc=83;
break;
case 86: // props.mod.gml:2695
_hm.result=undefined; _hm.done=true; return;
break;
case 87: // props.mod.gml:2693
{
;
if (instance_exists(id)) {
sprite_index = sprMutant2BDead;
}
}
_hm.pc=86;
break;
case 88: // props.mod.gml:2693
_hm.wait_ticks=max(0,(distance_to_object(_hm.vars._target) / 8)); _hm.pc=87; return;
break;
case 89: // props.mod.gml:2692
_hm.pc = (scrHMTaskFork(_hm, 88)) ? 88 : 83;
break;
case 90: // props.mod.gml:2698
{
sprite_index = sprMutant2BDead;
}
_hm.pc=83;
break;
case 91: // props.mod.gml:2691
_hm.pc = (point_in_rectangle(x, y, (view_xview - 32), (view_yview - 32), ((view_xview + view_width) + 32), ((view_yview + view_height) + 32))) ? 89 : 90;
break;
case 92: // props.mod.gml:2690
_hm.pc = (instance_exists(_hm.other_scope)) ? 91 : 83;
break;
case 93: // props.mod.gml:2690
scrHMTaskWithEnter(_hm,scrHMMatching(Corpse, "sprite_index", sprMutant2Dead),92,82);
break;
case 94: // props.mod.gml:2679
scrHMTaskWithNext(_hm);
break;
case 95: // props.mod.gml:2679
scrHMTaskWithAbort(_hm);
break;
case 96: // props.mod.gml:2681
{
;
if (instance_exists(id)) {
{
curse = 0;
;
bcurse = 0;
;
if (((race == scrHMRaceResolve("crystal")) and (bskin == 0))) {
bskin = 1;
}
}
}
}
_hm.pc=94;
break;
case 97: // props.mod.gml:2681
_hm.wait_ticks=max(0,(distance_to_object(_hm.vars._target) / 8)); _hm.pc=96; return;
break;
case 98: // props.mod.gml:2680
_hm.pc = (scrHMTaskFork(_hm, 97)) ? 97 : 94;
break;
case 99: // props.mod.gml:2679
_hm.pc = (instance_exists(_hm.other_scope)) ? 98 : 94;
break;
case 100: // props.mod.gml:2679
scrHMTaskWithEnter(_hm,scrHMInstances(Player),99,93);
break;
case 101: // props.mod.gml:2661
scrHMTaskWithNext(_hm);
break;
case 102: // props.mod.gml:2661
scrHMTaskWithAbort(_hm);
break;
case 103: // props.mod.gml:2671
{
;
}
_hm.pc=101;
break;
case 104: // props.mod.gml:2671
_hm.result=undefined; _hm.done=true; return;
break;
case 105: // props.mod.gml:2665
{
;
if (instance_exists(id)) {
{
instance_create(x, y, BigWeaponChest);
instance_destroy();
;
}
}
}
_hm.pc=104;
break;
case 106: // props.mod.gml:2665
_hm.wait_ticks=max(0,(distance_to_object(_hm.vars._target) / 8)); _hm.pc=105; return;
break;
case 107: // props.mod.gml:2664
_hm.pc = (scrHMTaskFork(_hm, 106)) ? 106 : 101;
break;
case 108: // props.mod.gml:2663
_hm.pc = ((curse != 0)) ? 107 : 101;
break;
case 109: // props.mod.gml:2674
{
instance_create(x, y, BigWeaponChest);
instance_destroy();
;
}
_hm.pc=101;
break;
case 110: // props.mod.gml:2662
_hm.pc = (point_in_rectangle(x, y, (view_xview - 32), (view_yview - 32), ((view_xview + view_width) + 32), ((view_yview + view_height) + 32))) ? 108 : 109;
break;
case 111: // props.mod.gml:2661
_hm.pc = (instance_exists(_hm.other_scope)) ? 110 : 101;
break;
case 112: // props.mod.gml:2661
scrHMTaskWithEnter(_hm,scrHMInstances(CursedBigChest),111,100);
break;
case 113: // props.mod.gml:2645
scrHMTaskWithNext(_hm);
break;
case 114: // props.mod.gml:2645
scrHMTaskWithAbort(_hm);
break;
case 115: // props.mod.gml:2654
{
;
}
_hm.pc=113;
break;
case 116: // props.mod.gml:2654
_hm.result=undefined; _hm.done=true; return;
break;
case 117: // props.mod.gml:2649
{
;
if (instance_exists(id)) {
{
curse = 0;
;
sprite_index = sprWeaponChest;
;
}
}
}
_hm.pc=116;
break;
case 118: // props.mod.gml:2649
_hm.wait_ticks=max(0,(distance_to_object(_hm.vars._target) / 8)); _hm.pc=117; return;
break;
case 119: // props.mod.gml:2648
_hm.pc = (scrHMTaskFork(_hm, 118)) ? 118 : 113;
break;
case 120: // props.mod.gml:2647
_hm.pc = ((curse != 0)) ? 119 : 113;
break;
case 121: // props.mod.gml:2657
{
curse = 0;
;
sprite_index = sprWeaponChest;
;
}
_hm.pc=113;
break;
case 122: // props.mod.gml:2646
_hm.pc = (point_in_rectangle(x, y, (view_xview - 32), (view_yview - 32), ((view_xview + view_width) + 32), ((view_yview + view_height) + 32))) ? 120 : 121;
break;
case 123: // props.mod.gml:2645
_hm.pc = (instance_exists(_hm.other_scope)) ? 122 : 113;
break;
case 124: // props.mod.gml:2645
scrHMTaskWithEnter(_hm,scrHMInstances(WeaponChest),123,112);
break;
case 125: // props.mod.gml:2644
{
GameCont.area = scrHMAreaResolve("caves");
}
_hm.pc=124;
break;
case 126: // props.mod.gml:2643
_hm.pc = ((_hm.vars.garea == 104)) ? 125 : 2;
break;
case 127: // props.mod.gml:2626
scrHMTaskWithNext(_hm);
break;
case 128: // props.mod.gml:2626
scrHMTaskWithAbort(_hm);
break;
case 129: // props.mod.gml:2634
{
;
}
_hm.pc=127;
break;
case 130: // props.mod.gml:2634
_hm.result=undefined; _hm.done=true; return;
break;
case 131: // props.mod.gml:2629
{
;
if (instance_exists(id)) {
{
instance_create(x, y, BonePile);
scrHMDelete(id);
}
}
}
_hm.pc=130;
break;
case 132: // props.mod.gml:2629
_hm.wait_ticks=max(0,((distance_to_object(_hm.vars._target) / 8) + 6)); _hm.pc=131; return;
break;
case 133: // props.mod.gml:2628
_hm.pc = (scrHMTaskFork(_hm, 132)) ? 132 : 127;
break;
case 134: // props.mod.gml:2637
{
instance_create(x, y, BonePile);
scrHMDelete(id);
}
_hm.pc=127;
break;
case 135: // props.mod.gml:2627
_hm.pc = (point_in_rectangle(x, y, (view_xview - 32), (view_yview - 32), ((view_xview + view_width) + 32), ((view_yview + view_height) + 32))) ? 133 : 134;
break;
case 136: // props.mod.gml:2626
_hm.pc = (instance_exists(_hm.other_scope)) ? 135 : 127;
break;
case 137: // props.mod.gml:2626
scrHMTaskWithEnter(_hm,scrHMMatching(Corpse, "sprite_index", sprBanditDead),136,126);
break;
case 138: // props.mod.gml:2615
scrHMTaskWithNext(_hm);
break;
case 139: // props.mod.gml:2615
scrHMTaskWithAbort(_hm);
break;
case 140: // props.mod.gml:2621
{
;
}
_hm.pc=138;
break;
case 141: // props.mod.gml:2621
_hm.result=undefined; _hm.done=true; return;
break;
case 142: // props.mod.gml:2619
{
;
if (instance_exists(id)) {
sprite_index = _hm.vars.newD;
}
}
_hm.pc=141;
break;
case 143: // props.mod.gml:2619
_hm.wait_ticks=max(0,(distance_to_object(_hm.vars._target) / 8)); _hm.pc=142; return;
break;
case 144: // props.mod.gml:2618
_hm.pc = (scrHMTaskFork(_hm, 143)) ? 143 : 138;
break;
case 145: // props.mod.gml:2617
_hm.pc = ((sprite_index != _hm.vars.newD)) ? 144 : 138;
break;
case 146: // props.mod.gml:2625
sprite_index = _hm.vars.newD;
_hm.pc=138;
break;
case 147: // props.mod.gml:2616
_hm.pc = (point_in_rectangle(x, y, (view_xview - 32), (view_yview - 32), ((view_xview + view_width) + 32), ((view_yview + view_height) + 32))) ? 145 : 146;
break;
case 148: // props.mod.gml:2615
_hm.pc = (instance_exists(_hm.other_scope)) ? 147 : 138;
break;
case 149: // props.mod.gml:2615
scrHMTaskWithEnter(_hm,scrHMInstances(Detail),148,137);
break;
case 150: // props.mod.gml:2592
scrHMTaskWithNext(_hm);
break;
case 151: // props.mod.gml:2592
scrHMTaskWithAbort(_hm);
break;
case 152: // props.mod.gml:2612
{
;
}
_hm.pc=150;
break;
case 153: // props.mod.gml:2612
_hm.result=undefined; _hm.done=true; return;
break;
case 154: // props.mod.gml:2603
{
if (instance_exists(id)) {
{
if ((sprite_index == sprCactus)) {
spr_idle = global.hm_module_vars[$ "mod:props"].cactusbloom1;
}
if ((sprite_index == sprCactus2)) {
spr_idle = global.hm_module_vars[$ "mod:props"].cactusbloom2;
}
if ((sprite_index == sprCactus3)) {
spr_idle = global.hm_module_vars[$ "mod:props"].cactusbloom3;
}
}
}
}
_hm.pc=153;
break;
case 156: // props.mod.gml:2601
{
;
}
_hm.pc=155;
break;
case 157: // props.mod.gml:2601
_hm.wait_ticks=max(0,1); _hm.pc=156; return;
break;
case 158: // props.mod.gml:2600
{
_dist -= 8;
;
}
_hm.pc=157;
break;
case 155: // props.mod.gml:2598
_hm.pc=((instance_exists(_hm.scope) && (_dist > 0)))?158:154;
break;
case 159: // props.mod.gml:2597
{
_dist = distance_to_object(_hm.vars._target);
;
}
_hm.pc=155;
break;
case 160: // props.mod.gml:2596
_hm.pc = (instance_exists(_hm.scope)) ? 159 : 153;
break;
case 161: // props.mod.gml:2595
{
;
}
_hm.pc=160;
break;
case 163: // props.mod.gml:2595
_hm.wait_ticks=max(0,1); _hm.pc=162; return;
break;
case 162: // props.mod.gml:2594
_hm.pc=((! instance_exists(_hm.vars._target)))?163:161;
break;
case 164: // props.mod.gml:2593
_hm.pc = (scrHMTaskFork(_hm, 162)) ? 162 : 150;
break;
case 165: // props.mod.gml:2592
_hm.pc = (instance_exists(_hm.other_scope)) ? 164 : 150;
break;
case 166: // props.mod.gml:2592
scrHMTaskWithEnter(_hm,scrHMInstances(Cactus),165,149);
break;
case 167: // props.mod.gml:2576
scrHMTaskWithNext(_hm);
break;
case 168: // props.mod.gml:2576
scrHMTaskWithAbort(_hm);
break;
case 169: // props.mod.gml:2589
{
;
}
_hm.pc=167;
break;
case 170: // props.mod.gml:2589
_hm.result=undefined; _hm.done=true; return;
break;
case 171: // props.mod.gml:2587
{
if (instance_exists(id)) {
instance_destroy();
}
}
_hm.pc=170;
break;
case 173: // props.mod.gml:2585
{
;
}
_hm.pc=172;
break;
case 174: // props.mod.gml:2585
_hm.wait_ticks=max(0,1); _hm.pc=173; return;
break;
case 175: // props.mod.gml:2584
{
_dist -= 8;
;
}
_hm.pc=174;
break;
case 172: // props.mod.gml:2582
_hm.pc=((instance_exists(_hm.scope) && (_dist > 0)))?175:171;
break;
case 176: // props.mod.gml:2581
{
_dist = distance_to_object(_hm.vars._target);
;
}
_hm.pc=172;
break;
case 177: // props.mod.gml:2580
_hm.pc = (instance_exists(_hm.scope)) ? 176 : 170;
break;
case 178: // props.mod.gml:2579
{
;
}
_hm.pc=177;
break;
case 180: // props.mod.gml:2579
_hm.wait_ticks=max(0,1); _hm.pc=179; return;
break;
case 179: // props.mod.gml:2578
_hm.pc=((! instance_exists(_hm.vars._target)))?180:178;
break;
case 181: // props.mod.gml:2577
_hm.pc = (scrHMTaskFork(_hm, 179)) ? 179 : 167;
break;
case 182: // props.mod.gml:2576
_hm.pc = (instance_exists(_hm.other_scope)) ? 181 : 167;
break;
case 183: // props.mod.gml:2576
scrHMTaskWithEnter(_hm,scrHMInstances(TopDecalDesert),182,166);
break;
case 184: // props.mod.gml:2560
scrHMTaskWithNext(_hm);
break;
case 185: // props.mod.gml:2560
scrHMTaskWithAbort(_hm);
break;
case 186: // props.mod.gml:2573
{
;
}
_hm.pc=184;
break;
case 187: // props.mod.gml:2573
_hm.result=undefined; _hm.done=true; return;
break;
case 188: // props.mod.gml:2571
{
if (instance_exists(id)) {
instance_destroy();
}
}
_hm.pc=187;
break;
case 190: // props.mod.gml:2569
{
;
}
_hm.pc=189;
break;
case 191: // props.mod.gml:2569
_hm.wait_ticks=max(0,1); _hm.pc=190; return;
break;
case 192: // props.mod.gml:2568
{
_dist -= 8;
;
}
_hm.pc=191;
break;
case 189: // props.mod.gml:2566
_hm.pc=((instance_exists(_hm.scope) && (_dist > 0)))?192:188;
break;
case 193: // props.mod.gml:2565
{
_dist = distance_to_object(_hm.vars._target);
;
}
_hm.pc=189;
break;
case 194: // props.mod.gml:2564
_hm.pc = (instance_exists(_hm.scope)) ? 193 : 187;
break;
case 195: // props.mod.gml:2563
{
;
}
_hm.pc=194;
break;
case 197: // props.mod.gml:2563
_hm.wait_ticks=max(0,1); _hm.pc=196; return;
break;
case 196: // props.mod.gml:2562
_hm.pc=((! instance_exists(_hm.vars._target)))?197:195;
break;
case 198: // props.mod.gml:2561
_hm.pc = (scrHMTaskFork(_hm, 196)) ? 196 : 184;
break;
case 199: // props.mod.gml:2560
_hm.pc = (instance_exists(_hm.other_scope)) ? 198 : 184;
break;
case 200: // props.mod.gml:2560
scrHMTaskWithEnter(_hm,scrHMMatching(Bones, "sprite_index", sprBones),199,183);
break;
case 201: // props.mod.gml:2536
scrHMTaskWithNext(_hm);
break;
case 202: // props.mod.gml:2536
scrHMTaskWithAbort(_hm);
break;
case 203: // props.mod.gml:2557
{
;
}
_hm.pc=201;
break;
case 204: // props.mod.gml:2557
_hm.result=undefined; _hm.done=true; return;
break;
case 205: // props.mod.gml:2551
{
if (((scrHMAreaResolve(_hm.vars.area) == GameCont.area) && (_hm.vars.subarea == GameCont.subarea))) {
instance_create(_hm.vars._x, _hm.vars._y, TopSmall);
}
if (instance_exists(id)) {
instance_destroy();
}
}
_hm.pc=204;
break;
case 207: // props.mod.gml:2549
{
;
}
_hm.pc=206;
break;
case 208: // props.mod.gml:2549
_hm.wait_ticks=max(0,1); _hm.pc=207; return;
break;
case 209: // props.mod.gml:2548
{
_dist -= 8;
;
}
_hm.pc=208;
break;
case 206: // props.mod.gml:2546
_hm.pc=((instance_exists(_hm.scope) && (_dist > 0)))?209:205;
break;
case 210: // props.mod.gml:2541
{
_hm.vars._x = x;
;
_hm.vars._y = y;
;
_hm.vars.area = GameCont.area;
;
_hm.vars.subarea = GameCont.subarea;
;
_dist = distance_to_object(_hm.vars._target);
;
}
_hm.pc=206;
break;
case 211: // props.mod.gml:2540
_hm.pc = (instance_exists(_hm.scope)) ? 210 : 204;
break;
case 212: // props.mod.gml:2539
{
;
}
_hm.pc=211;
break;
case 214: // props.mod.gml:2539
_hm.wait_ticks=max(0,1); _hm.pc=213; return;
break;
case 213: // props.mod.gml:2538
_hm.pc=((! instance_exists(_hm.vars._target)))?214:212;
break;
case 215: // props.mod.gml:2537
_hm.pc = (scrHMTaskFork(_hm, 213)) ? 213 : 201;
break;
case 216: // props.mod.gml:2536
_hm.pc = (((_hm.vars.garea != 104) && instance_exists(_hm.other_scope))) ? 215 : 201;
break;
case 217: // props.mod.gml:2536
scrHMTaskWithEnter(_hm,scrHMInstances(TopSmall),216,200);
break;
case 218: // props.mod.gml:2514
scrHMTaskWithNext(_hm);
break;
case 219: // props.mod.gml:2514
scrHMTaskWithAbort(_hm);
break;
case 220: // props.mod.gml:2533
{
;
}
_hm.pc=218;
break;
case 221: // props.mod.gml:2533
_hm.result=undefined; _hm.done=true; return;
break;
case 222: // props.mod.gml:2528
{
if (instance_exists(id)) {
instance_destroy();
}
if (((scrHMAreaResolve(_hm.vars.area) == GameCont.area) && (_hm.vars.subarea == GameCont.subarea))) {
instance_create(_hm.vars._x, _hm.vars._y, Wall);
}
}
_hm.pc=221;
break;
case 224: // props.mod.gml:2526
{
;
}
_hm.pc=223;
break;
case 225: // props.mod.gml:2526
_hm.wait_ticks=max(0,1); _hm.pc=224; return;
break;
case 226: // props.mod.gml:2525
{
_dist -= 8;
;
}
_hm.pc=225;
break;
case 223: // props.mod.gml:2524
_hm.pc=((instance_exists(_hm.scope) && (_dist > 0)))?226:222;
break;
case 227: // props.mod.gml:2519
{
_hm.vars._x = x;
;
_hm.vars._y = y;
;
_hm.vars.area = GameCont.area;
;
_hm.vars.subarea = GameCont.subarea;
;
_dist = distance_to_object(_hm.vars._target);
;
}
_hm.pc=223;
break;
case 228: // props.mod.gml:2518
_hm.pc = (instance_exists(_hm.scope)) ? 227 : 221;
break;
case 229: // props.mod.gml:2517
{
;
}
_hm.pc=228;
break;
case 231: // props.mod.gml:2517
_hm.wait_ticks=max(0,1); _hm.pc=230; return;
break;
case 230: // props.mod.gml:2516
_hm.pc=((! instance_exists(_hm.vars._target)))?231:229;
break;
case 232: // props.mod.gml:2515
_hm.pc = (scrHMTaskFork(_hm, 230)) ? 230 : 218;
break;
case 233: // props.mod.gml:2514
_hm.pc = (((_hm.vars.garea != 104) && instance_exists(_hm.other_scope))) ? 232 : 218;
break;
case 234: // props.mod.gml:2514
scrHMTaskWithEnter(_hm,scrHMInstances(Wall),233,217);
break;
case 235: // props.mod.gml:2480
scrHMTaskWithNext(_hm);
break;
case 236: // props.mod.gml:2480
scrHMTaskWithAbort(_hm);
break;
case 237: // props.mod.gml:2501
{
;
}
_hm.pc=235;
break;
case 238: // props.mod.gml:2501
_hm.result=undefined; _hm.done=true; return;
break;
case 239: // props.mod.gml:2484
{
;
if (instance_exists(id)) {
{
{ var __hm_with4 = scrHMInstances(instance_create(x, y, CustomObject)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
if (((scrHMOther(other)).sprite_index == _hm.vars.oldA)) {
sprite_index = _hm.vars.newA;
} else {
if (((scrHMOther(other)).sprite_index == _hm.vars.oldB)) {
sprite_index = _hm.vars.newB;
} else {
if (((scrHMOther(other)).sprite_index == _hm.vars.oldE)) {
sprite_index = _hm.vars.newE;
}
}
}
var __hm_other7=scrHMOther(other);
realboy = __hm_other7;
var __hm_other8=scrHMOther(other);
image_index = __hm_other8.image_index;
;
image_speed = (0) * timescale;
;
image_alpha = 0;
;
var __hm_other9=scrHMOther(other);
depth = (__hm_other9.depth - 1);
;
on_step = scrHMScriptRef(hm_props_mod_gml_fadefloor);
}
}
if(__hm_break6) break;
}}
}
}
}
_hm.pc=238;
break;
case 240: // props.mod.gml:2484
_hm.wait_ticks=max(0,(distance_to_object(_hm.vars._target) / 8)); _hm.pc=239; return;
break;
case 241: // props.mod.gml:2483
_hm.pc = (scrHMTaskFork(_hm, 240)) ? 240 : 235;
break;
case 242: // props.mod.gml:2482
_hm.pc = ((((sprite_index == _hm.vars.oldA) || (sprite_index == _hm.vars.oldB)) || (sprite_index == _hm.vars.oldE))) ? 241 : 235;
break;
case 243: // props.mod.gml:2504
{
if ((sprite_index == _hm.vars.oldA)) {
sprite_index = _hm.vars.newA;
} else {
if ((sprite_index == _hm.vars.oldB)) {
sprite_index = _hm.vars.newB;
} else {
if ((sprite_index == _hm.vars.oldE)) {
sprite_index = _hm.vars.newE;
} else {
if ((((sprite_index != _hm.vars.newA) || (sprite_index != _hm.vars.newB)) || (sprite_index != _hm.vars.newE))) {
sprite_index = _hm.vars.newA;
}
}
}
}
}
_hm.pc=235;
break;
case 244: // props.mod.gml:2481
_hm.pc = (point_in_rectangle(x, y, (view_xview - 32), (view_yview - 32), ((view_xview + view_width) + 32), ((view_yview + view_height) + 32))) ? 242 : 243;
break;
case 245: // props.mod.gml:2480
_hm.pc = (instance_exists(_hm.other_scope)) ? 244 : 235;
break;
case 246: // props.mod.gml:2480
scrHMTaskWithEnter(_hm,scrHMInstances(Floor),245,234);
break;
case 247: // props.mod.gml:2479
{
{ var __hm_with10 = scrHMInstances(instance_nearest(x, y, Floor)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
sprite_index = _hm.vars.newA;
}
if(__hm_break12) break;
}}
}
_hm.pc=246;
break;
case 248: // props.mod.gml:2478
_hm.result=undefined; _hm.done=true; return;
break;
case 249: // props.mod.gml:2478
_hm.pc = (instance_exists(GenCont)) ? 248 : 247;
break;
case 250: // props.mod.gml:2475
{
;
}
_hm.pc=249;
break;
case 251: // props.mod.gml:2475
_hm.result=undefined; _hm.done=true; return;
break;
case 253: // props.mod.gml:2471
_hm.vars.j += 0.03; _hm.pc=252;
break;
case 254: // props.mod.gml:2473
{
;
}
_hm.pc=253;
break;
case 255: // props.mod.gml:2473
_hm.wait_ticks=max(0,1); _hm.pc=254; return;
break;
case 256: // props.mod.gml:2472
{
background_set_colour(merge_color(global.hm_module_vars[$ "mod:props"].oldbg, global.hm_module_vars[$ "mod:props"].newbg, _hm.vars.j));
;
}
_hm.pc=255;
break;
case 252: // props.mod.gml:2471
_hm.pc=((_hm.vars.j <= 1))?256:251;
break;
case 257: // props.mod.gml:2471
_hm.vars.j = 0;
_hm.pc=252;
break;
case 258: // props.mod.gml:2470
_hm.pc = (scrHMTaskFork(_hm, 257)) ? 257 : 249;
break;
case 259: // props.mod.gml:2437
{
_hm.vars.garea = _hm.args[0];
;
switch (_hm.vars.garea) {
case 1:
global.hm_module_vars[$ "mod:props"].oldbg = $6A8FAF;
;
global.hm_module_vars[$ "mod:props"].newbg = $C8D151;
;
_hm.vars.oldA = sprFloor1;
;
_hm.vars.oldB = sprFloor1B;
;
_hm.vars.oldE = sprFloor1Explo;
;
_hm.vars.oldWB = sprWall1Bot;
;
_hm.vars.newA = sprFloor101;
;
_hm.vars.newB = sprFloor101B;
;
_hm.vars.newE = sprFloor101Explo;
;
_hm.vars.newWB = sprWall101Bot;
;
_hm.vars.newD = sprDetail101;
;
break;
;
case 104:
global.hm_module_vars[$ "mod:props"].oldbg = $239CFF;
;
global.hm_module_vars[$ "mod:props"].newbg = $BC5281;
;
_hm.vars.oldA = sprFloor104;
;
_hm.vars.oldB = sprFloor104B;
;
_hm.vars.oldE = sprFloor104Explo;
;
_hm.vars.oldWB = sprWall104Bot;
;
_hm.vars.newA = sprFloor4;
;
_hm.vars.newB = sprFloor4B;
;
_hm.vars.newE = sprFloor4Explo;
;
_hm.vars.newWB = sprWall4Bot;
;
_hm.vars.newD = sprDetail4;
;
break;
;
}
_hm.vars._target = _hm.args[1];
}
_hm.pc=258;
break;
case 260: // props.mod.gml:2436
_hm.pc = (scrHMTaskFork(_hm, 259)) ? 259 : 0;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

// Source props.mod.gml:2724; fadefloor

function hm_props_mod_gml_fadefloor() {

if ((image_alpha < 1)) {

image_alpha += 0.1;

} else {

{

{ var __hm_with1 = scrHMInstances(realboy), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

image_alpha = 1;

;

var __hm_other4=scrHMOther(other);

sprite_index = __hm_other4.sprite_index;

;

}

}

if(__hm_break3) break;

}}

instance_destroy();

;

}

}

}

