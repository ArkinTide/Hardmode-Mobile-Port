// Source bosses/titank.mod.gml:1; __load
function hm_bosses_titank_mod_gml___load() {

}

// Source bosses/titank.mod.gml:3; init
function hm_bosses_titank_mod_gml_init() {
global.hm_module_vars[$ "mod:bosses/titank"].debug = 0;
;
global.hm_module_vars[$ "mod:bosses/titank"].sprTitankBody = sprHM_bosses_titank_mod_12;
;
global.hm_module_vars[$ "mod:bosses/titank"].sprTitankBodyHurt = sprHM_bosses_titank_mod_14;
;
global.hm_module_vars[$ "mod:bosses/titank"].sprTitankHead = sprHM_bosses_titank_mod_20;
;
global.hm_module_vars[$ "mod:bosses/titank"].sprTitankEye = sprHM_bosses_titank_mod_22;
;
global.hm_module_vars[$ "mod:bosses/titank"].sprTitankShadow = sprHM_bosses_titank_mod_24;
;
global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg = sprHM_bosses_titank_mod_26;
;
global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLegDark = sprHM_bosses_titank_mod_28;
;
global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLegDestroyed = sprHM_bosses_titank_mod_30;
;
global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLegDarkDestroyed = sprHM_bosses_titank_mod_32;
;
global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLegHurt = sprHM_bosses_titank_mod_34;
;
global.hm_module_vars[$ "mod:bosses/titank"].sprSnowFootstep = sprHM_bosses_titank_mod_36;
;
global.hm_module_vars[$ "mod:bosses/titank"].sprSnowClumpBig = sprHM_bosses_titank_mod_40;
;
global.hm_module_vars[$ "mod:bosses/titank"].titankportrait = sprHM_bosses_titank_mod_44;
global.hm_module_vars[$ "mod:bosses/titank"].titankportraitfg = sprHM_bosses_titank_mod_45;
global.hm_module_vars[$ "mod:bosses/titank"].titankportraitbg = sprHM_bosses_titank_mod_46;
}

// Source bosses/titank.mod.gml:48; step
function hm_bosses_titank_mod_gml_step() {
if (global.hm_module_vars[$ "mod:bosses/titank"].debug) {
{
GameCont.area = scrHMAreaResolve("city");
;
{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
hp = 500;
if (instance_exists(id)) {
{
if (scrHMButtonPressed(index, "horn")) {
{
for (var _hml_l = 0; (_hml_l < 999); _hml_l += 1) {
if ((scrHMWeaponName(("#" + string(_hml_l))) == "GUITAR")) {
{
wep = scrHMWeaponResolve(_hml_l);
;
}
}
}
hm_bosses_titank_mod_gml_titank_create(mouse_x[index], mouse_y[index]);
;
}
}
}
}
}
}
if(__hm_break3) break;
}}
}
}
}

// Source bosses/titank.mod.gml:130; wanttitank
function hm_bosses_titank_mod_gml_wanttitank() {
{ var __hm_with1 = scrHMInstances(instance_create(0, 0, CustomObject)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
enemies = instance_number(enemy);
name = "wanttitank";
on_step = scrHMScriptRef(hm_bosses_titank_mod_gml_wanttitank_step);
return id;
;
}
}
if(__hm_break3) break;
}}
}

// Source bosses/titank.mod.gml:137; wanttitank_step
function hm_bosses_titank_mod_gml_wanttitank_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_titank_mod_gml_wanttitank_step_resume, id, scrHMOther(other), _args, 7, []);
}
function hm_bosses_titank_mod_gml_wanttitank_step_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_titank_mod_gml_wanttitank_step");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/titank.mod.gml:148
{
;
}
_hm.pc=0;
break;
case 2: // bosses/titank.mod.gml:148
_hm.result=undefined; _hm.done=true; return;
break;
case 3: // bosses/titank.mod.gml:144
{
if (instance_exists(id)) {
{
scrHMTitankEntrance(_hm.vars.wx, _hm.vars.wy);
instance_destroy();
}
}
}
_hm.pc=2;
break;
case 4: // bosses/titank.mod.gml:143
_hm.wait_ticks=max(0,60); _hm.pc=3; return;
break;
case 5: // bosses/titank.mod.gml:142
_hm.pc = (scrHMTaskFork(_hm, 4)) ? 4 : 0;
break;
case 6: // bosses/titank.mod.gml:139
{
_hm.vars.wall_ = scrHMNearestAuthoredWall105((Player.x + random(100)), (Player.y + random(100)));
_hm.vars.wx = _hm.vars.wall_.x;
;
_hm.vars.wy = _hm.vars.wall_.y;
;
}
_hm.pc=5;
break;
case 7: // bosses/titank.mod.gml:138
_hm.pc = (((instance_number(enemy) < ((enemies / 6) * 5)) && instance_exists(Player))) ? 6 : 0;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/titank.mod.gml:151; titank_create
function hm_bosses_titank_mod_gml_titank_create() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_titank_mod_gml_titank_create_resume, id, scrHMOther(other), _args, 330, ["tankx", "tanky"]);
}
function hm_bosses_titank_mod_gml_titank_create_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_titank_mod_gml_titank_create");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/titank.mod.gml:1355
{
;
}
_hm.pc=0;
break;
case 2: // bosses/titank.mod.gml:1355
_hm.result=undefined; _hm.done=true; return;
break;
case 3: // bosses/titank.mod.gml:204
scrHMTaskWithNext(_hm);
break;
case 4: // bosses/titank.mod.gml:204
scrHMTaskWithAbort(_hm);
break;
case 6: // bosses/titank.mod.gml:1352
{
;
}
_hm.pc=5;
break;
case 7: // bosses/titank.mod.gml:1352
_hm.wait_ticks=max(0,1); _hm.pc=6; return;
break;
case 9: // bosses/titank.mod.gml:1191
_hm.vars.i += 1; _hm.pc=8;
break;
case 10: // bosses/titank.mod.gml:1341
{
_hm.vars.i += 1;
;
}
_hm.pc=9;
break;
case 11: // bosses/titank.mod.gml:1339
{
;
}
_hm.pc=10;
break;
case 12: // bosses/titank.mod.gml:1339
_hm.result=undefined; _hm.done=true; return;
break;
case 13: // bosses/titank.mod.gml:1301
{
if (instance_exists(id)) {
{
foot_z[_hm.vars.i] = 0;
;
scrHMSoundPlay(sndImpWristHit);
;
{ var __hm_with1 = scrHMInstances(instance_create(foot_x[_hm.vars.i], foot_y[_hm.vars.i], Detail)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
sprite_index = global.hm_module_vars[$ "mod:bosses/titank"].sprSnowFootstep;
;
}
}
if(__hm_break3) break;
}}
repeat ((6 + irandom(3))) {
{ var __hm_with4 = scrHMInstances(instance_create(foot_x[_hm.vars.i], foot_y[_hm.vars.i], Dust)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
direction = random(360);
;
speed = ((2 + random(1))) * timescale;
;
}
}
if(__hm_break6) break;
}}
}
if ((((point_distance(foot_x[_hm.vars.i], foot_y[_hm.vars.i], ((instance_nearest(foot_x[_hm.vars.i], foot_y[_hm.vars.i], Wall)).x + 8), ((instance_nearest(foot_x[_hm.vars.i], foot_y[_hm.vars.i], Wall)).y + 8)) <= 16) || (point_distance(foot_x[_hm.vars.i], foot_y[_hm.vars.i], ((instance_nearest(foot_x[_hm.vars.i], foot_y[_hm.vars.i], TopSmall)).x + 8), ((instance_nearest(foot_x[_hm.vars.i], foot_y[_hm.vars.i], TopSmall)).y + 8)) <= 16)) || (point_distance(foot_x[_hm.vars.i], foot_y[_hm.vars.i], ((instance_nearest(foot_x[_hm.vars.i], foot_y[_hm.vars.i], Floor)).x + 8), ((instance_nearest(foot_x[_hm.vars.i], foot_y[_hm.vars.i], Floor)).y + 8)) <= 16))) {
{
scrHMSoundPlay(sndExplosionS);
;
{ var __hm_with7 = scrHMInstances(instance_create(foot_x[_hm.vars.i], foot_y[_hm.vars.i], SmallExplosion)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
var __hm_other10=scrHMOther(other);
team = __hm_other10.team;
;
var __hm_other11=scrHMOther(other);
hitid = __hm_other11.hitid;
var __hm_other12=scrHMOther(other);
creator = __hm_other12;
}
}
if(__hm_break9) break;
}}
}
}
{ var __hm_with13 = scrHMInstances(Wall), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
if ((point_distance((x + 8), (y + 8), (scrHMOther(other)).foot_x[_hm.vars.i], (scrHMOther(other)).foot_y[_hm.vars.i]) <= 24)) {
{
scrHMSoundPlay(sndWallBreak);
;
instance_create(x, y, FloorExplo);
;
instance_destroy();
;
}
}
}
}
if(__hm_break15) break;
}}
}
}
}
_hm.pc=12;
break;
case 15: // bosses/titank.mod.gml:1287
_hm.vars.__hm_repeat16--; _hm.pc=14;
break;
case 16: // bosses/titank.mod.gml:1297
{
;
}
_hm.pc=15;
break;
case 17: // bosses/titank.mod.gml:1297
_hm.wait_ticks=max(0,1); _hm.pc=16; return;
break;
case 18: // bosses/titank.mod.gml:1291
{
foot_x[_hm.vars.i] += lengthdir_x((_hm.vars.dist / (_hm.vars.times / (1 + ((speed / timescale) / 16)))), _hm.vars.dir);
;
foot_y[_hm.vars.i] += lengthdir_y((_hm.vars.dist / (_hm.vars.times / (1 + ((speed / timescale) / 16)))), _hm.vars.dir);
;
_hm.vars.zt += 1;
;
foot_z[_hm.vars.i] = max(1, abs((sin((_hm.vars.zt / (_hm.vars.times / 3))) * 16)));
;
}
_hm.pc=17;
break;
case 19: // bosses/titank.mod.gml:1289
_hm.pc = (instance_exists(_hm.scope)) ? 18 : 15;
break;
case 14: // bosses/titank.mod.gml:1287
_hm.pc=(_hm.vars.__hm_repeat16>0)?19:13;
break;
case 20: // bosses/titank.mod.gml:1287
_hm.vars.__hm_repeat16=round(_hm.vars.times); _hm.pc=14;
break;
case 21: // bosses/titank.mod.gml:1285
_hm.pc = (scrHMTaskFork(_hm, 20)) ? 20 : 10;
break;
case 22: // bosses/titank.mod.gml:1278
{
scrHMSoundPlay(sndSnowBotPickup);
;
_hm.vars.zt = 0;
;
_hm.vars.times = ((60 / legs) / ((foot_hp[_hm.vars.i] <= 0) ? 3 : 1));
;
foot_z[_hm.vars.i] = 1;
;
}
_hm.pc=21;
break;
case 23: // bosses/titank.mod.gml:1276
_hm.pc = (_hm.vars.doNormal) ? 22 : 9;
break;
case 24: // bosses/titank.mod.gml:1216
{
repeat ((6 + irandom(3))) {
if ((foot_hp[_hm.vars.i] > 0)) {
{ var __hm_with17 = scrHMInstances(instance_create((foot_x[_hm.vars.i] + lengthdir_x(4, random(360))), (foot_y[_hm.vars.i] + lengthdir_y(4, random(360))), Dust)), __hm_break19=false;
for (var __hm_index18=0; __hm_index18<array_length(__hm_with17); ++__hm_index18) {
if(instance_exists(__hm_with17[__hm_index18])) with (__hm_with17[__hm_index18]) {
{
var __hm_other20=scrHMOther(other);
direction = point_direction(x, y, __hm_other20.foot_x[_hm.vars.i], (__hm_other20.foot_y[_hm.vars.i] - 32));
;
speed = ((1 + random(3))) * timescale;
;
image_xscale /= (speed / timescale);
;
image_yscale = image_xscale;
;
}
}
if(__hm_break19) break;
}}
}
}
_hm.vars.dist = (point_distance(foot_x[_hm.vars.i], foot_y[_hm.vars.i], ((x + foot_target_x[_hm.vars.i]) + _hm.vars.lx), ((y + foot_target_y[_hm.vars.i]) + _hm.vars.ly)) * ((foot_hp[_hm.vars.i] <= 0) ? 1.2 : 1));
;
_hm.vars.dir = point_direction(foot_x[_hm.vars.i], foot_y[_hm.vars.i], ((x + foot_target_x[_hm.vars.i]) + _hm.vars.lx), ((y + foot_target_y[_hm.vars.i]) + _hm.vars.ly));
;
_hm.vars.doNormal = 1;
;
}
_hm.pc=23;
break;
case 25: // bosses/titank.mod.gml:1211
_hm.pc = ((_hm.vars.canLift > 0)) ? 24 : 9;
break;
case 26: // bosses/titank.mod.gml:1201
{
_hm.vars.canLift = 1;
;
for (_hm.vars.j = 0; (_hm.vars.j < array_length_1d(foot_x)); _hm.vars.j += 1) {
if (((_hm.vars.j != _hm.vars.i) && (foot_z[_hm.vars.j] != 0))) {
{
_hm.vars.canLift -= (1 / (legs / 2));
;
}
}
}
}
_hm.pc=25;
break;
case 27: // bosses/titank.mod.gml:1198
_hm.pc = (((foot_z[_hm.vars.i] == 0) && (point_distance(foot_x[_hm.vars.i], foot_y[_hm.vars.i], ((x + foot_home_x[_hm.vars.i]) + _hm.vars.lx), ((y + foot_home_y[_hm.vars.i]) + _hm.vars.ly)) > 32))) ? 26 : 9;
break;
case 28: // bosses/titank.mod.gml:1194
{
_hm.vars.randomFactor = random(1);
;
_hm.vars.lx = lengthdir_x((((speed / timescale) * _hm.vars.randomFactor) * (GameCont.loops + 1)), direction);
;
_hm.vars.ly = lengthdir_y((((speed / timescale) * _hm.vars.randomFactor) * (GameCont.loops + 1)), direction);
;
}
_hm.pc=27;
break;
case 29: // bosses/titank.mod.gml:1193
_hm.pc = ((foot_hp[_hm.vars.i] > 0)) ? 28 : 9;
break;
case 8: // bosses/titank.mod.gml:1191
_hm.pc=((_hm.vars.i < array_length_1d(foot_x)))?29:7;
break;
case 30: // bosses/titank.mod.gml:1191
_hm.vars.i = 0;
_hm.pc=8;
break;
case 31: // bosses/titank.mod.gml:1189
_hm.pc = (canmove) ? 30 : 7;
break;
case 32: // bosses/titank.mod.gml:1163
{
;
}
_hm.pc=31;
break;
case 33: // bosses/titank.mod.gml:1163
_hm.result=undefined; _hm.done=true; return;
break;
case 34: // bosses/titank.mod.gml:1161
{
;
}
_hm.pc=33;
break;
case 35: // bosses/titank.mod.gml:1161
_hm.result=undefined; _hm.done=true; return;
break;
case 36: // bosses/titank.mod.gml:1156
{
if (instance_exists(id)) {
{
z = zstart;
;
canmove = 1;
;
}
}
}
_hm.pc=35;
break;
case 38: // bosses/titank.mod.gml:1154
{
;
}
_hm.pc=37;
break;
case 39: // bosses/titank.mod.gml:1154
_hm.wait_ticks=max(0,1); _hm.pc=38; return;
break;
case 40: // bosses/titank.mod.gml:1151
{
z += min(_hm.vars._zspd, max(1, (point_distance(x, (y - z), x, (y - zstart)) / 4)));
;
_hm.vars._zspd *= 1.25;
;
if ((headZ > 0)) {
headZ -= 1;
}
}
_hm.pc=39;
break;
case 37: // bosses/titank.mod.gml:1146
_hm.pc=(((instance_exists(_hm.scope) && (z < zstart)) && (hp > 0)))?40:36;
break;
case 41: // bosses/titank.mod.gml:1143
{
;
_hm.vars._zspd = 1;
;
}
_hm.pc=37;
break;
case 42: // bosses/titank.mod.gml:1143
_hm.wait_ticks=max(0,10); _hm.pc=41; return;
break;
case 43: // bosses/titank.mod.gml:1129
{
if (instance_exists(id)) {
{
z = 16;
;
headZ = 16;
;
scrHMSoundPlay(sndGoldTankDead);
;
scrHMSoundPlay(sndExplosionL);
;
{ var __hm_with21 = scrHMInstances(instance_create(x, y, Explosion)), __hm_break23=false;
for (var __hm_index22=0; __hm_index22<array_length(__hm_with21); ++__hm_index22) {
if(instance_exists(__hm_with21[__hm_index22])) with (__hm_with21[__hm_index22]) {
var __hm_other24=scrHMOther(other);
team = __hm_other24.team;
}
if(__hm_break23) break;
}}
repeat (3) {
instance_create((x + lengthdir_x(8, random(360))), (y + lengthdir_y(8, random(360))), Explosion);
;
}
}
}
}
_hm.pc=42;
break;
case 45: // bosses/titank.mod.gml:1127
{
;
}
_hm.pc=44;
break;
case 46: // bosses/titank.mod.gml:1127
_hm.wait_ticks=max(0,1); _hm.pc=45; return;
break;
case 47: // bosses/titank.mod.gml:1125
{
z -= _hm.vars._zspd;
;
_hm.vars._zspd *= 1.5;
;
}
_hm.pc=46;
break;
case 44: // bosses/titank.mod.gml:1120
_hm.pc=(((instance_exists(_hm.scope) && (z > 16)) && (hp > 0)))?47:43;
break;
case 48: // bosses/titank.mod.gml:1117
{
if (instance_exists(id)) {
z = (zstart + 32);
}
_hm.vars._zspd = 1;
;
}
_hm.pc=44;
break;
case 50: // bosses/titank.mod.gml:1115
{
;
}
_hm.pc=49;
break;
case 51: // bosses/titank.mod.gml:1115
_hm.wait_ticks=max(0,1); _hm.pc=50; return;
break;
case 52: // bosses/titank.mod.gml:1113
{
z += min(_hm.vars._zspd, max(1, (point_distance(x, (y - z), x, ((y - zstart) + 32)) / 8)));
;
_hm.vars._zspd *= 1.1;
;
}
_hm.pc=51;
break;
case 49: // bosses/titank.mod.gml:1109
_hm.pc=(((instance_exists(_hm.scope) && (z < (zstart + 32))) && (hp > 0)))?52:48;
break;
case 53: // bosses/titank.mod.gml:1108
{
_hm.vars._zspd = 1;
;
}
_hm.pc=49;
break;
case 54: // bosses/titank.mod.gml:1106
_hm.pc = (scrHMTaskFork(_hm, 53)) ? 53 : 33;
break;
case 55: // bosses/titank.mod.gml:1103
{
canmove = 0;
;
scrHMSoundPlay(sndNothingBeamWarn);
;
}
_hm.pc=54;
break;
case 56: // bosses/titank.mod.gml:1101
_hm.pc = (scrHMTaskFork(_hm, 55)) ? 55 : 31;
break;
case 57: // bosses/titank.mod.gml:1099
{
attacking += (30 * 4);
;
}
_hm.pc=56;
break;
case 58: // bosses/titank.mod.gml:1095
_hm.pc = (((_hm.vars.atk == 2) && (distance_to_object(Player) < 32))) ? 57 : 31;
break;
case 59: // bosses/titank.mod.gml:829
{
;
}
_hm.pc=58;
break;
case 60: // bosses/titank.mod.gml:829
_hm.result=undefined; _hm.done=true; return;
break;
case 61: // bosses/titank.mod.gml:826
{
;
}
_hm.pc=60;
break;
case 62: // bosses/titank.mod.gml:826
_hm.result=undefined; _hm.done=true; return;
break;
case 63: // bosses/titank.mod.gml:825
{
if (instance_exists(id)) {
z = zstart;
}
}
_hm.pc=62;
break;
case 65: // bosses/titank.mod.gml:823
{
;
}
_hm.pc=64;
break;
case 66: // bosses/titank.mod.gml:823
_hm.wait_ticks=max(0,1); _hm.pc=65; return;
break;
case 67: // bosses/titank.mod.gml:821
{
z += min(_hm.vars._zspd, max(1, (point_distance(x, (y - z), x, (y - zstart)) / 4)));
;
_hm.vars._zspd *= 1.25;
;
}
_hm.pc=66;
break;
case 64: // bosses/titank.mod.gml:816
_hm.pc=(((instance_exists(_hm.scope) && (z < zstart)) && (hp > 0)))?67:63;
break;
case 68: // bosses/titank.mod.gml:815
{
_hm.vars._zspd = 1;
;
}
_hm.pc=64;
break;
case 69: // bosses/titank.mod.gml:812
{
;
}
_hm.pc=68;
break;
case 70: // bosses/titank.mod.gml:812
_hm.result=undefined; _hm.done=true; return;
break;
case 71: // bosses/titank.mod.gml:811
{
if (instance_exists(id)) {
image_index = 0;
}
}
_hm.pc=70;
break;
case 73: // bosses/titank.mod.gml:809
{
;
}
_hm.pc=72;
break;
case 74: // bosses/titank.mod.gml:809
_hm.wait_ticks=max(0,1); _hm.pc=73; return;
break;
case 75: // bosses/titank.mod.gml:807
{
image_index -= 0.4;
;
if ((image_index < 0)) {
image_index = 0;
}
}
_hm.pc=74;
break;
case 72: // bosses/titank.mod.gml:803
_hm.pc=(((instance_exists(_hm.scope) && (sprite_index != spr_hurt)) && (image_index > 0)))?75:71;
break;
case 76: // bosses/titank.mod.gml:801
_hm.pc = (scrHMTaskFork(_hm, 72)) ? 72 : 68;
break;
case 77: // bosses/titank.mod.gml:797
_hm.pc = ((instance_exists(_hm.scope) && scrHMTaskFork(_hm, 76))) ? 76 : 60;
break;
case 79: // bosses/titank.mod.gml:723
_hm.vars.__hm_repeat25--; _hm.pc=78;
break;
case 80: // bosses/titank.mod.gml:793
{
;
}
_hm.pc=79;
break;
case 81: // bosses/titank.mod.gml:793
_hm.wait_ticks=max(0,2); _hm.pc=80; return;
break;
case 82: // bosses/titank.mod.gml:792
{
_hm.vars.spread += 2;
;
}
_hm.pc=81;
break;
case 83: // bosses/titank.mod.gml:790
{
;
}
_hm.pc=82;
break;
case 84: // bosses/titank.mod.gml:790
_hm.result=undefined; _hm.done=true; return;
break;
case 85: // bosses/titank.mod.gml:731
scrHMTaskWithNext(_hm);
break;
case 86: // bosses/titank.mod.gml:731
scrHMTaskWithAbort(_hm);
break;
case 88: // bosses/titank.mod.gml:787
{
;
}
_hm.pc=87;
break;
case 89: // bosses/titank.mod.gml:787
_hm.wait_ticks=max(0,2); _hm.pc=88; return;
break;
case 90: // bosses/titank.mod.gml:763
{
image_index = 0;
speed = ((_hm.vars.bulletdist * 0.6)) * timescale;
;
zspeed += (16 / 30);
;
z += zspeed;
;
y += zspeed;
;
depth += zspeed;
;
image_angle = point_direction(x, y, (x + (hspeed / timescale)), ((y + (vspeed / timescale)) + zspeed));
;
mask_index = mskNone;
;
if (((zspeed >= 0) && (z >= (- 4)))) {
{
var __hm_other26=scrHMOther(other);
hm_bosses_titank_mod_gml_tinade_create(x, y, __hm_other26);
scrHMDelete(id);
}
}
if ((instance_exists(id) && (z > oz))) {
{
var __hm_other27=scrHMOther(other);
hm_bosses_titank_mod_gml_tinade_create(x, y, __hm_other27);
scrHMDelete(id);
}
}
}
_hm.pc=89;
break;
case 87: // bosses/titank.mod.gml:761
_hm.pc=(instance_exists(_hm.scope))?90:85;
break;
case 91: // bosses/titank.mod.gml:735
{
_hm.vars.bulletip = instance_nearest(x, y, Player);
;
_hm.vars.bullepdir = random(360);
;
_hm.vars.bulletdist = random(360);
;
_hm.vars.rdir = random(360);
;
_hm.vars.rdist = random(32);
;
if ((_hm.vars.bulletip != noone)) {
{
_hm.vars.rdist = random(((_hm.vars.bulletip.speed / timescale) * 10));
;
_hm.vars.bulletdir = point_direction(x, y, (_hm.vars.bulletip.x + lengthdir_x(_hm.vars.rdist, _hm.vars.rdir)), (_hm.vars.bulletip.y + lengthdir_y(_hm.vars.rdist, _hm.vars.rdir)));
;
_hm.vars.bulletdist = (point_distance(x, y, (_hm.vars.bulletip.x + lengthdir_x(_hm.vars.rdist, _hm.vars.rdir)), (_hm.vars.bulletip.y + lengthdir_y(_hm.vars.rdist, _hm.vars.rdir))) / 30);
;
}
}
alarm[0] = 800;
sprite_index = sprGrenade;
var __hm_other28=scrHMOther(other);
team = __hm_other28.team;
;
var __hm_other29=scrHMOther(other);
hitid = __hm_other29.hitid;
speed = (_hm.vars.bulletdist) * timescale;
;
direction = _hm.vars.bulletdir;
;
friction = (0) * (timescale * timescale);
;
image_angle = direction;
;
var __hm_other30=scrHMOther(other);
z = (__hm_other30.z - 4);
;
oz = z;
;
zspeed = (- 12);
;
_hm.vars.msk = mask_index;
;
mask_index = mskNone;
;
}
_hm.pc=87;
break;
case 92: // bosses/titank.mod.gml:731
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(x, ((y - 8) - z), CustomProjectile)),91,84);
break;
case 93: // bosses/titank.mod.gml:729
_hm.pc = (scrHMTaskFork(_hm, 92)) ? 92 : 82;
break;
case 94: // bosses/titank.mod.gml:728
{
scrHMSoundPlay(sndGoldTankShoot);
;
}
_hm.pc=93;
break;
case 95: // bosses/titank.mod.gml:725
_hm.pc = ((instance_exists(_hm.scope) && (hp > 0))) ? 94 : 79;
break;
case 78: // bosses/titank.mod.gml:723
_hm.pc=(_hm.vars.__hm_repeat25>0)?95:77;
break;
case 96: // bosses/titank.mod.gml:723
_hm.vars.__hm_repeat25=round(10); _hm.pc=78;
break;
case 97: // bosses/titank.mod.gml:717
{
_hm.vars.ip = instance_nearest(x, y, Player);
;
_hm.vars.pdir = random(360);
;
if ((_hm.vars.ip != noone)) {
_hm.vars.pdir = point_direction(x, y, _hm.vars.ip.x, _hm.vars.ip.y);
}
_hm.vars.spread = 0;
;
}
_hm.pc=96;
break;
case 98: // bosses/titank.mod.gml:715
_hm.pc = (instance_exists(_hm.scope)) ? 97 : 60;
break;
case 99: // bosses/titank.mod.gml:713
{
;
}
_hm.pc=98;
break;
case 100: // bosses/titank.mod.gml:713
_hm.wait_ticks=max(0,30); _hm.pc=99; return;
break;
case 101: // bosses/titank.mod.gml:710
{
;
}
_hm.pc=100;
break;
case 102: // bosses/titank.mod.gml:710
_hm.result=undefined; _hm.done=true; return;
break;
case 103: // bosses/titank.mod.gml:709
{
if (instance_exists(id)) {
z = 48;
}
}
_hm.pc=102;
break;
case 105: // bosses/titank.mod.gml:707
{
;
}
_hm.pc=104;
break;
case 106: // bosses/titank.mod.gml:707
_hm.wait_ticks=max(0,1); _hm.pc=105; return;
break;
case 107: // bosses/titank.mod.gml:705
{
z -= min(_hm.vars._zspd, max(1, (point_distance(x, (y - z), x, (y - 48)) / 4)));
;
_hm.vars._zspd *= 1.25;
;
}
_hm.pc=106;
break;
case 104: // bosses/titank.mod.gml:701
_hm.pc=(((z > 48) && (hp > 0)))?107:103;
break;
case 108: // bosses/titank.mod.gml:700
{
_hm.vars._zspd = 1;
;
}
_hm.pc=104;
break;
case 109: // bosses/titank.mod.gml:698
_hm.pc = (scrHMTaskFork(_hm, 108)) ? 108 : 100;
break;
case 110: // bosses/titank.mod.gml:696
{
scrHMSoundPlay(sndGoldTankAim);
;
}
_hm.pc=109;
break;
case 111: // bosses/titank.mod.gml:694
_hm.pc = (scrHMTaskFork(_hm, 110)) ? 110 : 58;
break;
case 112: // bosses/titank.mod.gml:691
{
;
}
_hm.pc=111;
break;
case 113: // bosses/titank.mod.gml:691
_hm.result=undefined; _hm.done=true; return;
break;
case 114: // bosses/titank.mod.gml:689
{
if (instance_exists(id)) {
image_index = (image_number - 0.4);
}
}
_hm.pc=113;
break;
case 116: // bosses/titank.mod.gml:687
{
;
}
_hm.pc=115;
break;
case 117: // bosses/titank.mod.gml:687
_hm.wait_ticks=max(0,1); _hm.pc=116; return;
break;
case 118: // bosses/titank.mod.gml:686
{
image_index += 0.4;
;
}
_hm.pc=117;
break;
case 115: // bosses/titank.mod.gml:681
_hm.pc=((((instance_exists(_hm.scope) && (hp > 0)) && (sprite_index != spr_hurt)) && (image_index < (image_number - 0.4))))?118:114;
break;
case 119: // bosses/titank.mod.gml:679
_hm.pc = (scrHMTaskFork(_hm, 115)) ? 115 : 111;
break;
case 120: // bosses/titank.mod.gml:676
{
attacking += (30 * 4);
;
}
_hm.pc=119;
break;
case 121: // bosses/titank.mod.gml:1092
{
;
}
_hm.pc=58;
break;
case 122: // bosses/titank.mod.gml:1092
_hm.result=undefined; _hm.done=true; return;
break;
case 123: // bosses/titank.mod.gml:1090
{
;
}
_hm.pc=122;
break;
case 124: // bosses/titank.mod.gml:1090
_hm.result=undefined; _hm.done=true; return;
break;
case 126: // bosses/titank.mod.gml:930
_hm.vars.i += 1; _hm.pc=125;
break;
case 127: // bosses/titank.mod.gml:1087
{
;
}
_hm.pc=126;
break;
case 128: // bosses/titank.mod.gml:1087
_hm.result=undefined; _hm.done=true; return;
break;
case 129: // bosses/titank.mod.gml:1084
{
;
if (((instance_exists(id) && (hp > 0)) || (hp < 4))) {
canmove = 1;
}
}
_hm.pc=128;
break;
case 130: // bosses/titank.mod.gml:1084
_hm.wait_ticks=max(0,15); _hm.pc=129; return;
break;
case 132: // bosses/titank.mod.gml:1052
_hm.vars.j += 2; _hm.pc=131;
break;
case 133: // bosses/titank.mod.gml:1054
scrHMTaskWithNext(_hm);
break;
case 134: // bosses/titank.mod.gml:1054
scrHMTaskWithAbort(_hm);
break;
case 135: // bosses/titank.mod.gml:1077
{
;
}
_hm.pc=133;
break;
case 136: // bosses/titank.mod.gml:1077
_hm.result=undefined; _hm.done=true; return;
break;
case 138: // bosses/titank.mod.gml:1075
{
;
}
_hm.pc=137;
break;
case 139: // bosses/titank.mod.gml:1075
_hm.wait_ticks=max(0,1); _hm.pc=138; return;
break;
case 140: // bosses/titank.mod.gml:1068
{
{ var __hm_with31 = scrHMInstances(instance_nearest(x, y, Detail)), __hm_break33=false;
for (var __hm_index32=0; __hm_index32<array_length(__hm_with31); ++__hm_index32) {
if(instance_exists(__hm_with31[__hm_index32])) with (__hm_with31[__hm_index32]) {
{
if (((speed / timescale) == 0)) {
{
instance_destroy();
;
}
}
}
}
if(__hm_break33) break;
}}
}
_hm.pc=139;
break;
case 137: // bosses/titank.mod.gml:1066
_hm.pc=(((speed / timescale) > 1))?140:136;
break;
case 141: // bosses/titank.mod.gml:1064
_hm.pc = (scrHMTaskFork(_hm, 137)) ? 137 : 133;
break;
case 142: // bosses/titank.mod.gml:1056
{
sprite_index = global.hm_module_vars[$ "mod:bosses/titank"].sprSnowClumpBig;
;
image_xscale = 1;
;
speed = (3) * timescale;
;
direction = (_hm.vars.j + choose(0, 1));
;
vspeed /= 1.25;
;
friction = (0.1) * (timescale * timescale);
;
depth -= ((vspeed / timescale) * 0.01);
;
}
_hm.pc=141;
break;
case 143: // bosses/titank.mod.gml:1054
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(x, y, Detail)),142,132);
break;
case 131: // bosses/titank.mod.gml:1052
_hm.pc=((_hm.vars.j < 90))?143:130;
break;
case 144: // bosses/titank.mod.gml:1052
_hm.vars.j = 0;
_hm.pc=131;
break;
case 145: // bosses/titank.mod.gml:1050
{
;
}
_hm.pc=144;
break;
case 146: // bosses/titank.mod.gml:1050
_hm.wait_ticks=max(0,10); _hm.pc=145; return;
break;
case 147: // bosses/titank.mod.gml:1048
_hm.pc = (scrHMTaskFork(_hm, 146)) ? 146 : 130;
break;
case 148: // bosses/titank.mod.gml:1012
{
{ var __hm_with34 = scrHMInstances(Player), __hm_break36=false;
for (var __hm_index35=0; __hm_index35<array_length(__hm_with34); ++__hm_index35) {
if(instance_exists(__hm_with34[__hm_index35])) with (__hm_with34[__hm_index35]) {
{
view_shake[index] += 8;
;
}
}
if(__hm_break36) break;
}}
scrHMSoundPlay(sndExplosionXL);
;
scrHMSoundPlay(sndNothingBeamEnd);
;
{ var __hm_with37 = scrHMInstances(instance_create(x, y, Explosion)), __hm_break39=false;
for (var __hm_index38=0; __hm_index38<array_length(__hm_with37); ++__hm_index38) {
if(instance_exists(__hm_with37[__hm_index38])) with (__hm_with37[__hm_index38]) {
{
var __hm_other40=scrHMOther(other);
team = __hm_other40.team;
;
image_xscale = 1.5;
;
image_yscale = image_xscale;
;
image_alpha = 0;
;
}
}
if(__hm_break39) break;
}}
}
_hm.pc=147;
break;
case 149: // bosses/titank.mod.gml:988
_hm.pc = (((_hm.vars.i == 0) && (hp > 0))) ? 148 : 130;
break;
case 150: // bosses/titank.mod.gml:977
{
foot_z[_hm.vars.i] = 0;
;
scrHMSoundPlay(sndImpWristHit);
;
for (_hm.vars.i = 0; (_hm.vars.i < legs); _hm.vars.i += 1) {
if ((foot_hp[_hm.vars.i] > 0)) {
{ var __hm_with41 = scrHMInstances(instance_create(foot_x[_hm.vars.i], foot_y[_hm.vars.i], SmallExplosion)), __hm_break43=false;
for (var __hm_index42=0; __hm_index42<array_length(__hm_with41); ++__hm_index42) {
if(instance_exists(__hm_with41[__hm_index42])) with (__hm_with41[__hm_index42]) {
{
var __hm_other44=scrHMOther(other);
team = __hm_other44.team;
var __hm_other45=scrHMOther(other);
hitid = __hm_other45.hitid;
creator = 1;
}
}
if(__hm_break43) break;
}}
}
}
}
_hm.pc=149;
break;
case 151: // bosses/titank.mod.gml:975
_hm.pc = (instance_exists(_hm.scope)) ? 150 : 128;
break;
case 153: // bosses/titank.mod.gml:973
{
;
}
_hm.pc=152;
break;
case 154: // bosses/titank.mod.gml:973
_hm.wait_ticks=max(0,1); _hm.pc=153; return;
break;
case 155: // bosses/titank.mod.gml:971
{
foot_z[_hm.vars.i] -= _hm.vars._zspd;
;
_hm.vars._zspd *= 1.25;
;
}
_hm.pc=154;
break;
case 152: // bosses/titank.mod.gml:965
_hm.pc=((((instance_exists(_hm.scope) && (foot_z[_hm.vars.i] > 0)) && (hp > 0)) && (foot_hp[_hm.vars.i] > 0)))?155:151;
break;
case 156: // bosses/titank.mod.gml:962
{
if (instance_exists(id)) {
foot_z[_hm.vars.i] = 512;
}
_hm.vars._zspd = 1;
;
}
_hm.pc=152;
break;
case 158: // bosses/titank.mod.gml:960
{
;
}
_hm.pc=157;
break;
case 159: // bosses/titank.mod.gml:960
_hm.wait_ticks=max(0,1); _hm.pc=158; return;
break;
case 160: // bosses/titank.mod.gml:953
{
foot_z[_hm.vars.i] += _hm.vars._zspd;
;
_hm.vars._zspd *= 1.25;
;
{ var __hm_with46 = scrHMInstances(instance_create(foot_x[_hm.vars.i], foot_y[_hm.vars.i], Dust)), __hm_break48=false;
for (var __hm_index47=0; __hm_index47<array_length(__hm_with46); ++__hm_index47) {
if(instance_exists(__hm_with46[__hm_index47])) with (__hm_with46[__hm_index47]) {
{
direction = 90;
;
speed = (((- 3) + random(6))) * timescale;
;
}
}
if(__hm_break48) break;
}}
}
_hm.pc=159;
break;
case 157: // bosses/titank.mod.gml:947
_hm.pc=((((instance_exists(_hm.scope) && (foot_z[_hm.vars.i] < 512)) && (hp > 0)) && (foot_hp[_hm.vars.i] > 0)))?160:156;
break;
case 161: // bosses/titank.mod.gml:934
{
if ((foot_hp[_hm.vars.i] > 0)) {
repeat ((6 + irandom(3))) {
{ var __hm_with49 = scrHMInstances(instance_create((foot_x[_hm.vars.i] + lengthdir_x(4, random(360))), (foot_y[_hm.vars.i] + lengthdir_y(4, random(360))), Dust)), __hm_break51=false;
for (var __hm_index50=0; __hm_index50<array_length(__hm_with49); ++__hm_index50) {
if(instance_exists(__hm_with49[__hm_index50])) with (__hm_with49[__hm_index50]) {
{
var __hm_other52=scrHMOther(other);
direction = point_direction(x, y, __hm_other52.foot_x[_hm.vars.i], (__hm_other52.foot_y[_hm.vars.i] - 32));
;
speed = (1) * timescale;
image_xscale /= (speed / timescale);
;
image_yscale = image_xscale;
;
}
}
if(__hm_break51) break;
}}
}
}
_hm.vars._zspd = 32;
;
}
_hm.pc=157;
break;
case 162: // bosses/titank.mod.gml:932
_hm.pc = (scrHMTaskFork(_hm, 161)) ? 161 : 126;
break;
case 125: // bosses/titank.mod.gml:930
_hm.pc=((_hm.vars.i < legs))?162:124;
break;
case 163: // bosses/titank.mod.gml:930
_hm.vars.i = 0;
_hm.pc=125;
break;
case 164: // bosses/titank.mod.gml:928
{
;
}
_hm.pc=163;
break;
case 165: // bosses/titank.mod.gml:928
_hm.wait_ticks=max(0,38); _hm.pc=164; return;
break;
case 166: // bosses/titank.mod.gml:926
_hm.pc = (scrHMTaskFork(_hm, 165)) ? 165 : 122;
break;
case 167: // bosses/titank.mod.gml:924
{
;
}
_hm.pc=166;
break;
case 168: // bosses/titank.mod.gml:924
_hm.result=undefined; _hm.done=true; return;
break;
case 170: // bosses/titank.mod.gml:922
{
;
}
_hm.pc=169;
break;
case 171: // bosses/titank.mod.gml:922
_hm.wait_ticks=max(0,1); _hm.pc=170; return;
break;
case 172: // bosses/titank.mod.gml:912
{
x += lengthdir_x((_hm.vars.pdist / 30), _hm.vars.pdir);
;
y += lengthdir_y((_hm.vars.pdist / 30), _hm.vars.pdir);
;
for (_hm.vars.i = 0; (_hm.vars.i < legs); _hm.vars.i += 1) {
foot_x[_hm.vars.i] = (x + (foot_home_x[_hm.vars.i] * 0.25));
;
foot_y[_hm.vars.i] = (y + (foot_home_y[_hm.vars.i] * 0.25));
;
}
}
_hm.pc=171;
break;
case 169: // bosses/titank.mod.gml:908
_hm.pc=(((instance_exists(_hm.scope) && (z > zstart)) && (hp > 0)))?172:168;
break;
case 173: // bosses/titank.mod.gml:896
{
;
scrHMSoundPlay(sndNothingBeamStart);
;
_hm.vars.p = instance_nearest(x, y, Player);
;
_hm.vars.pdir = random(360);
;
_hm.vars.pdist = random(128);
;
if ((_hm.vars.p != noone)) {
{
_hm.vars.pdir = point_direction(x, y, _hm.vars.p.x, _hm.vars.p.y);
;
_hm.vars.pdist = point_distance(x, y, _hm.vars.p.x, _hm.vars.p.y);
;
}
}
}
_hm.pc=169;
break;
case 174: // bosses/titank.mod.gml:896
_hm.wait_ticks=max(0,40); _hm.pc=173; return;
break;
case 175: // bosses/titank.mod.gml:894
_hm.pc = (scrHMTaskFork(_hm, 174)) ? 174 : 166;
break;
case 176: // bosses/titank.mod.gml:891
{
;
}
_hm.pc=175;
break;
case 177: // bosses/titank.mod.gml:891
_hm.result=undefined; _hm.done=true; return;
break;
case 178: // bosses/titank.mod.gml:890
{
if (instance_exists(id)) {
z = zstart;
}
}
_hm.pc=177;
break;
case 180: // bosses/titank.mod.gml:888
{
;
}
_hm.pc=179;
break;
case 181: // bosses/titank.mod.gml:888
_hm.wait_ticks=max(0,1); _hm.pc=180; return;
break;
case 182: // bosses/titank.mod.gml:885
{
z += min(_hm.vars._zspd, max(1, (point_distance(x, (y - z), x, (y - zstart)) / 4)));
;
_hm.vars._zspd *= 1.25;
;
if ((headZ > 0)) {
headZ -= 1;
}
}
_hm.pc=181;
break;
case 179: // bosses/titank.mod.gml:880
_hm.pc=(((instance_exists(_hm.scope) && (z < zstart)) && (hp > 0)))?182:178;
break;
case 183: // bosses/titank.mod.gml:877
{
if (instance_exists(id)) {
z = 32;
}
_hm.vars._zspd = 1;
;
}
_hm.pc=179;
break;
case 185: // bosses/titank.mod.gml:875
{
;
}
_hm.pc=184;
break;
case 186: // bosses/titank.mod.gml:875
_hm.wait_ticks=max(0,1); _hm.pc=185; return;
break;
case 187: // bosses/titank.mod.gml:873
{
z -= min(_hm.vars._zspd, max(1, (point_distance(x, (y - z), x, (y - 32)) / 3)));
;
_hm.vars._zspd *= 1.5;
;
}
_hm.pc=186;
break;
case 184: // bosses/titank.mod.gml:869
_hm.pc=(((instance_exists(_hm.scope) && (z > 32)) && (hp > 0)))?187:183;
break;
case 188: // bosses/titank.mod.gml:866
{
if (instance_exists(id)) {
z = 512;
}
_hm.vars._zspd = 1;
;
}
_hm.pc=184;
break;
case 190: // bosses/titank.mod.gml:864
{
;
}
_hm.pc=189;
break;
case 191: // bosses/titank.mod.gml:864
_hm.wait_ticks=max(0,1); _hm.pc=190; return;
break;
case 192: // bosses/titank.mod.gml:862
{
z += min(_hm.vars._zspd, max(1, (point_distance(x, (y - z), x, (y - 512)) / 4)));
;
_hm.vars._zspd *= 1.25;
;
}
_hm.pc=191;
break;
case 189: // bosses/titank.mod.gml:858
_hm.pc=(((instance_exists(_hm.scope) && (z < 512)) && (hp > 0)))?192:188;
break;
case 193: // bosses/titank.mod.gml:855
{
if (instance_exists(id)) {
z = 16;
}
_hm.vars._zspd = 1;
;
}
_hm.pc=189;
break;
case 195: // bosses/titank.mod.gml:853
{
;
}
_hm.pc=194;
break;
case 196: // bosses/titank.mod.gml:853
_hm.wait_ticks=max(0,1); _hm.pc=195; return;
break;
case 197: // bosses/titank.mod.gml:850
{
z -= min(_hm.vars._zspd, max(1, (point_distance(x, (y - z), x, (y - 16)) / 3)));
;
_hm.vars._zspd *= 1.25;
;
if ((headZ < 32)) {
headZ += 1;
}
}
_hm.pc=196;
break;
case 194: // bosses/titank.mod.gml:846
_hm.pc=(((instance_exists(_hm.scope) && (z > 16)) && (hp > 0)))?197:193;
break;
case 198: // bosses/titank.mod.gml:845
{
_hm.vars._zspd = 1;
;
}
_hm.pc=194;
break;
case 199: // bosses/titank.mod.gml:843
_hm.pc = (scrHMTaskFork(_hm, 198)) ? 198 : 175;
break;
case 200: // bosses/titank.mod.gml:840
{
;
scrHMSoundPlay(sndNothingBeamWarn);
;
}
_hm.pc=199;
break;
case 201: // bosses/titank.mod.gml:840
_hm.wait_ticks=max(0,10); _hm.pc=200; return;
break;
case 202: // bosses/titank.mod.gml:839
{
canmove = 0;
;
}
_hm.pc=201;
break;
case 203: // bosses/titank.mod.gml:837
_hm.pc = (scrHMTaskFork(_hm, 202)) ? 202 : 58;
break;
case 204: // bosses/titank.mod.gml:835
{
attacking += (30 * 4);
;
}
_hm.pc=203;
break;
case 205: // bosses/titank.mod.gml:832
_hm.pc = ((_hm.vars.atk == 1)) ? 204 : 58;
break;
case 206: // bosses/titank.mod.gml:673
_hm.pc = ((_hm.vars.atk == 0)) ? 120 : 205;
break;
case 207: // bosses/titank.mod.gml:661
{
_hm.vars.atk = (- 1);
;
if ((random(1) <= min(1, (0.05 + (0.15 * GameCont.loops))))) {
{
do {
_hm.vars.atk = irandom(2);
;
} until (!((_hm.vars.atk == lastatk)));
lastatk = _hm.vars.atk;
;
}
}
}
_hm.pc=206;
break;
case 208: // bosses/titank.mod.gml:1184
{
;
}
_hm.pc=31;
break;
case 209: // bosses/titank.mod.gml:1184
_hm.result=undefined; _hm.done=true; return;
break;
case 211: // bosses/titank.mod.gml:1182
{
;
}
_hm.pc=210;
break;
case 212: // bosses/titank.mod.gml:1182
_hm.wait_ticks=max(0,1); _hm.pc=211; return;
break;
case 213: // bosses/titank.mod.gml:1181
{
scrHMMotionAdd(point_direction(x, y, _hm.vars.targetX, _hm.vars.targetY), min((point_distance(x, y, _hm.vars.targetX, _hm.vars.targetY) / 8), 0.1));
;
}
_hm.pc=212;
break;
case 210: // bosses/titank.mod.gml:1178
_hm.pc=((instance_exists(_hm.scope) && (point_distance(x, y, _hm.vars.targetX, _hm.vars.targetY) > 16)))?213:209;
break;
case 214: // bosses/titank.mod.gml:1176
{
_hm.vars.targetX = (x + lengthdir_x(random(256), random(360)));
;
_hm.vars.targetY = (y + lengthdir_y(random(256), random(360)));
;
}
_hm.pc=210;
break;
case 215: // bosses/titank.mod.gml:1173
_hm.pc = (scrHMTaskFork(_hm, 214)) ? 214 : 31;
break;
case 216: // bosses/titank.mod.gml:1170
_hm.pc = (((random(1) < 0.01) && ((speed / timescale) < 1))) ? 215 : 31;
break;
case 217: // bosses/titank.mod.gml:1167
_hm.pc = (((! attacking) && (! instance_exists(Player)))) ? 216 : 31;
break;
case 218: // bosses/titank.mod.gml:657
_hm.pc = ((((! attacking) && instance_exists(Player)) && (hp > 0))) ? 207 : 217;
break;
case 219: // bosses/titank.mod.gml:627
{
if (canmove) {
{
_hm.vars.ip = instance_nearest(x, y, Player);
;
if ((_hm.vars.ip != noone)) {
{
scrHMMotionAdd(point_direction(x, y, _hm.vars.ip.x, _hm.vars.ip.y), min((point_distance(x, y, _hm.vars.ip.x, _hm.vars.ip.y) / 8), 0.1));
;
}
}
}
}
speed = (min((speed / timescale), ((1 + (1 * GameCont.loops)) + ((max_hp - hp) * 0.5)))) * timescale;
;
for (_hm.vars.i = 0; (_hm.vars.i < legs); _hm.vars.i += 1) {
if (((foot_hp[_hm.vars.i] > 0) and (random(foot_hp[_hm.vars.i]) <= 1))) {
{
_hm.vars.legang_ = point_direction(foot_x[_hm.vars.i], foot_y[_hm.vars.i], (x + ((leg_x[_hm.vars.i] + (foot_x[_hm.vars.i] - x)) / 1.25)), (((y + ((leg_y[_hm.vars.i] + (foot_y[_hm.vars.i] - y)) / 1.25)) - zstart) - foot_z[_hm.vars.i]));
_hm.vars.r_ = random(100);
;
{ var __hm_with53 = scrHMInstances(instance_create((foot_x[_hm.vars.i] + lengthdir_x(_hm.vars.r_, _hm.vars.legang_)), ((foot_y[_hm.vars.i] - foot_z[_hm.vars.i]) + lengthdir_y(_hm.vars.r_, _hm.vars.legang_)), Smoke)), __hm_break55=false;
for (var __hm_index54=0; __hm_index54<array_length(__hm_with53); ++__hm_index54) {
if(instance_exists(__hm_with53[__hm_index54])) with (__hm_with53[__hm_index54]) {
{
var __hm_other56=scrHMOther(other);
depth = (__hm_other56.depth + choose((- 1), 1));
;
vspeed -= ((1 + random(3))) * timescale;
;
hspeed = ((1 * random_range((- 1), 1))) * timescale;
;
}
}
if(__hm_break55) break;
}}
}
}
}
attacking -= 1;
;
attacking = max(0, attacking);
;
}
_hm.pc=218;
break;
case 220: // bosses/titank.mod.gml:624
_hm.pc = ((instance_exists(_hm.scope) && (hp > 0))) ? 219 : 7;
break;
case 221: // bosses/titank.mod.gml:519
{
_x = x;
;
_y = y;
;
}
_hm.pc=220;
break;
case 222: // bosses/titank.mod.gml:620
{
;
}
_hm.pc=220;
break;
case 223: // bosses/titank.mod.gml:620
_hm.result=undefined; _hm.done=true; return;
break;
case 224: // bosses/titank.mod.gml:615
{
hm_bosses_titank_mod_gml_scrNuke(z, 1.5);
;
repeat (5) scrHMModCall("mod", "enemies", "scrPickups", 50);
scrHMSoundPlay(sndExplosionXL);
;
instance_destroy();
;
}
_hm.pc=223;
break;
case 226: // bosses/titank.mod.gml:564
_hm.vars.__hm_repeat57--; _hm.pc=225;
break;
case 227: // bosses/titank.mod.gml:612
{
;
}
_hm.pc=226;
break;
case 228: // bosses/titank.mod.gml:612
_hm.wait_ticks=max(0,2); _hm.pc=227; return;
break;
case 229: // bosses/titank.mod.gml:583
{
z = zstart;
;
z = (z + random_range((- 2), 2));
;
{ var __hm_with58 = scrHMInstances(instance_create((x + lengthdir_x(random(48), random(360))), ((y + lengthdir_y(random(96), random(360))) - z), Explosion)), __hm_break60=false;
for (var __hm_index59=0; __hm_index59<array_length(__hm_with58); ++__hm_index59) {
if(instance_exists(__hm_with58[__hm_index59])) with (__hm_with58[__hm_index59]) {
{
var __hm_other61=scrHMOther(other);
team = __hm_other61.team;
;
scrHMSoundPlay(sndExplosion);
;
if (((scrHMOther(other)).z > 16)) {
mask_index = mskNone;
}
if ((! place_meeting(x, y, Floor))) {
{
x = ((instance_nearest(x, y, Floor)).x + 16);
;
y = ((instance_nearest(x, y, Floor)).y + 16);
;
}
}
}
}
if(__hm_break60) break;
}}
{ var __hm_with62 = scrHMInstances(instance_create((x + lengthdir_x(random(48), random(360))), ((y + lengthdir_y(random(96), random(360))) - z), SmallExplosion)), __hm_break64=false;
for (var __hm_index63=0; __hm_index63<array_length(__hm_with62); ++__hm_index63) {
if(instance_exists(__hm_with62[__hm_index63])) with (__hm_with62[__hm_index63]) {
{
var __hm_other65=scrHMOther(other);
team = __hm_other65.team;
;
if (((scrHMOther(other)).z > 16)) {
mask_index = mskNone;
}
if ((! place_meeting(x, y, Floor))) {
{
x = (((instance_nearest(x, y, Floor)).x + 8) + random(16));
;
y = (((instance_nearest(x, y, Floor)).y + 8) + random(16));
;
}
}
}
}
if(__hm_break64) break;
}}
}
_hm.pc=228;
break;
case 230: // bosses/titank.mod.gml:579
{
;
}
_hm.pc=229;
break;
case 231: // bosses/titank.mod.gml:579
_hm.result=undefined; _hm.done=true; return;
break;
case 232: // bosses/titank.mod.gml:577
{
;
hurtTimer = 0;
;
}
_hm.pc=231;
break;
case 233: // bosses/titank.mod.gml:577
_hm.wait_ticks=max(0,1); _hm.pc=232; return;
break;
case 234: // bosses/titank.mod.gml:575
_hm.pc = (scrHMTaskFork(_hm, 233)) ? 233 : 229;
break;
case 235: // bosses/titank.mod.gml:573
{
hurtTimer = 1;
;
}
_hm.pc=234;
break;
case 236: // bosses/titank.mod.gml:571
_hm.pc = ((hurtTimer <= 0)) ? 235 : 229;
break;
case 237: // bosses/titank.mod.gml:565
_hm.pc = (instance_exists(_hm.scope)) ? 236 : 226;
break;
case 225: // bosses/titank.mod.gml:564
_hm.pc=(_hm.vars.__hm_repeat57>0)?237:224;
break;
case 238: // bosses/titank.mod.gml:564
_hm.vars.__hm_repeat57=round(35); _hm.pc=225;
break;
case 239: // bosses/titank.mod.gml:561
{
;
_hm.vars.zz = z;
;
}
_hm.pc=238;
break;
case 240: // bosses/titank.mod.gml:561
_hm.wait_ticks=max(0,10); _hm.pc=239; return;
break;
case 241: // bosses/titank.mod.gml:559
_hm.pc = (scrHMTaskFork(_hm, 240)) ? 240 : 220;
break;
case 242: // bosses/titank.mod.gml:552
{
sprite_index = spr_hurt;
;
image_index = 0;
;
hp = (- 10);
;
canmove = 0;
;
attacking = 999;
;
}
_hm.pc=241;
break;
case 243: // bosses/titank.mod.gml:550
_hm.result=undefined; _hm.done=true; return;
break;
case 244: // bosses/titank.mod.gml:546
{
if (instance_exists(Player)) {
{ var __hm_with66 = scrHMInstances(_hm.vars.fl_), __hm_break68=false;
for (var __hm_index67=0; __hm_index67<array_length(__hm_with66); ++__hm_index67) {
if(instance_exists(__hm_with66[__hm_index67])) with (__hm_with66[__hm_index67]) {
if ((scrHMModExists("mod", "options", "bossoutros") and (scrHMModGet("mod", "options", "bossoutros") == "1"))) {
scrHMModCall("mod", "bossintros", "boss_trigger", "", mskNone, mskNone, mskNone, id, 0);
}
}
if(__hm_break68) break;
}}
}
}
_hm.pc=243;
break;
case 245: // bosses/titank.mod.gml:545
_hm.wait_ticks=max(0,5); _hm.pc=244; return;
break;
case 246: // bosses/titank.mod.gml:542
{
_hm.vars.xd_ = x;
;
_hm.vars.yd_ = y;
;
_hm.vars.fl_ = instance_nearest(_hm.vars.xd_, _hm.vars.yd_, Floor);
;
}
_hm.pc=245;
break;
case 247: // bosses/titank.mod.gml:541
_hm.pc = (scrHMTaskFork(_hm, 246)) ? 246 : 242;
break;
case 248: // bosses/titank.mod.gml:539
{
scrHMSoundPlay(sndBossWin);
;
scrHMSoundMusic(musBossDead);
}
_hm.pc=247;
break;
case 249: // bosses/titank.mod.gml:537
{
;
}
_hm.pc=248;
break;
case 250: // bosses/titank.mod.gml:537
_hm.result=undefined; _hm.done=true; return;
break;
case 252: // bosses/titank.mod.gml:535
{
;
}
_hm.pc=251;
break;
case 253: // bosses/titank.mod.gml:535
_hm.wait_ticks=max(0,1); _hm.pc=252; return;
break;
case 254: // bosses/titank.mod.gml:532
{
z -= choose(0, 1, 1, (- 1));
x = (_x + random_range((- 1), 1));
;
y = _y;
;
}
_hm.pc=253;
break;
case 251: // bosses/titank.mod.gml:530
_hm.pc=(instance_exists(_hm.scope))?254:250;
break;
case 255: // bosses/titank.mod.gml:528
_hm.pc = (scrHMTaskFork(_hm, 251)) ? 251 : 248;
break;
case 256: // bosses/titank.mod.gml:525
{
scrHMSoundMusic((- 1));
;
speed = (0) * timescale;
;
z = zstart;
;
}
_hm.pc=255;
break;
case 257: // bosses/titank.mod.gml:523
_hm.pc = (((hp <= 0) and (hp != (- 10)))) ? 256 : 220;
break;
case 258: // bosses/titank.mod.gml:518
_hm.pc = ((hp > 0)) ? 221 : 257;
break;
case 259: // bosses/titank.mod.gml:510
{
if ((hurtTimer > 0)) {
hurtTimer -= 0.4;
}
if ((hp <= 1)) {
canmove = 0;
}
}
_hm.pc=258;
break;
case 5: // bosses/titank.mod.gml:509
_hm.pc=(instance_exists(_hm.scope))?259:3;
break;
case 260: // bosses/titank.mod.gml:506
{
z = zstart;
;
attacking = (30 + irandom(30));
;
}
_hm.pc=5;
break;
case 262: // bosses/titank.mod.gml:504
{
;
}
_hm.pc=261;
break;
case 263: // bosses/titank.mod.gml:504
_hm.wait_ticks=max(0,1); _hm.pc=262; return;
break;
case 264: // bosses/titank.mod.gml:503
{
z += ((current_frame - _hm.vars.cf) / 24);
;
}
_hm.pc=263;
break;
case 261: // bosses/titank.mod.gml:501
_hm.pc=((z < zstart))?264:260;
break;
case 265: // bosses/titank.mod.gml:499
{
_hm.vars.cf = current_frame;
;
}
_hm.pc=261;
break;
case 266: // bosses/titank.mod.gml:497
{
;
}
_hm.pc=265;
break;
case 267: // bosses/titank.mod.gml:497
_hm.result=undefined; _hm.done=true; return;
break;
case 268: // bosses/titank.mod.gml:496
{
kneeRelativePos = 1.25;
;
}
_hm.pc=267;
break;
case 270: // bosses/titank.mod.gml:494
{
;
}
_hm.pc=269;
break;
case 271: // bosses/titank.mod.gml:494
_hm.wait_ticks=max(0,1); _hm.pc=270; return;
break;
case 272: // bosses/titank.mod.gml:493
{
kneeRelativePos -= 0.02;
;
}
_hm.pc=271;
break;
case 269: // bosses/titank.mod.gml:491
_hm.pc=((kneeRelativePos > 1.25))?272:268;
break;
case 273: // bosses/titank.mod.gml:490
{
;
}
_hm.pc=269;
break;
case 274: // bosses/titank.mod.gml:490
_hm.wait_ticks=max(0,15); _hm.pc=273; return;
break;
case 275: // bosses/titank.mod.gml:489
_hm.pc = (scrHMTaskFork(_hm, 274)) ? 274 : 265;
break;
case 276: // bosses/titank.mod.gml:487
{
;
}
_hm.pc=275;
break;
case 277: // bosses/titank.mod.gml:487
_hm.result=undefined; _hm.done=true; return;
break;
case 279: // bosses/titank.mod.gml:485
{
;
}
_hm.pc=278;
break;
case 280: // bosses/titank.mod.gml:485
_hm.wait_ticks=max(0,1); _hm.pc=279; return;
break;
case 281: // bosses/titank.mod.gml:484
{
headZ -= 1;
;
}
_hm.pc=280;
break;
case 278: // bosses/titank.mod.gml:482
_hm.pc=((headZ > 0))?281:277;
break;
case 282: // bosses/titank.mod.gml:481
{
;
}
_hm.pc=278;
break;
case 283: // bosses/titank.mod.gml:481
_hm.wait_ticks=max(0,15); _hm.pc=282; return;
break;
case 284: // bosses/titank.mod.gml:480
_hm.pc = (scrHMTaskFork(_hm, 283)) ? 283 : 275;
break;
case 285: // bosses/titank.mod.gml:476
{
z = 0;
;
hm_feet_ready=true;
headZ = 32;
;
attacking = 999;
;
kneeRelativePos = 2;
;
}
_hm.pc=284;
break;
case 287: // bosses/titank.mod.gml:328
_hm.vars.i += 1; _hm.pc=286;
break;
case 288: // bosses/titank.mod.gml:472
{
;
}
_hm.pc=287;
break;
case 289: // bosses/titank.mod.gml:472
_hm.result=undefined; _hm.done=true; return;
break;
case 290: // bosses/titank.mod.gml:344
scrHMTaskWithNext(_hm);
break;
case 291: // bosses/titank.mod.gml:344
scrHMTaskWithAbort(_hm);
break;
case 293: // bosses/titank.mod.gml:358
instance_destroy();
_hm.pc=292;
break;
case 294: // bosses/titank.mod.gml:468
{
;
}
_hm.pc=292;
break;
case 295: // bosses/titank.mod.gml:468
_hm.wait_ticks=max(0,1); _hm.pc=294; return;
break;
case 296: // bosses/titank.mod.gml:444
{
{ var __hm_with69 = scrHMInstances((scrHMOther(other))), __hm_break71=false;
for (var __hm_index70=0; __hm_index70<array_length(__hm_with69); ++__hm_index70) {
if(instance_exists(__hm_with69[__hm_index70])) with (__hm_with69[__hm_index70]) {
{
if ((hp > 0)) {
hp -= 1;
}
_hm.vars.livelegs = hp;
;
for (_hm.vars.i = 0; (_hm.vars.i < legs); _hm.vars.i += 1) {
if ((foot_hp[_hm.vars.i] > 0)) {
{
leg_x[_hm.vars.i] = lengthdir_x(58, ((_hm.vars.i * (360 / max(1,_hm.vars.livelegs))) + 45));
;
leg_y[_hm.vars.i] = lengthdir_y(28, ((_hm.vars.i * (360 / max(1,_hm.vars.livelegs))) + 45));
;
foot_home_x[_hm.vars.i] = lengthdir_x((96 - 16), ((_hm.vars.i * (360 / max(1,_hm.vars.livelegs))) + 45));
;
foot_home_y[_hm.vars.i] = lengthdir_y((48 - 12), ((_hm.vars.i * (360 / max(1,_hm.vars.livelegs))) + 45));
;
foot_target_x[_hm.vars.i] = lengthdir_x(96, ((_hm.vars.i * (360 / max(1,_hm.vars.livelegs))) + 45));
;
foot_target_y[_hm.vars.i] = lengthdir_y(48, ((_hm.vars.i * (360 / max(1,_hm.vars.livelegs))) + 45));
;
_hm.vars.livelegs += 1;
}
}
}
}
}
if(__hm_break71) break;
}}
instance_destroy();
;
}
_hm.pc=295;
break;
case 297: // bosses/titank.mod.gml:442
{
;
}
_hm.pc=296;
break;
case 298: // bosses/titank.mod.gml:442
_hm.result=undefined; _hm.done=true; return;
break;
case 300: // bosses/titank.mod.gml:429
_hm.vars.legdie -= 1; _hm.pc=299;
break;
case 301: // bosses/titank.mod.gml:440
{
;
}
_hm.pc=300;
break;
case 302: // bosses/titank.mod.gml:440
_hm.wait_ticks=max(0,3); _hm.pc=301; return;
break;
case 303: // bosses/titank.mod.gml:431
{
{ var __hm_with72 = scrHMInstances((scrHMOther(other))), __hm_break74=false;
for (var __hm_index73=0; __hm_index73<array_length(__hm_with72); ++__hm_index73) {
if(instance_exists(__hm_with72[__hm_index73])) with (__hm_with72[__hm_index73]) {
{
_hm.vars.legang_ = point_direction(foot_x[_hm.vars.i], foot_y[_hm.vars.i], (x + ((leg_x[_hm.vars.i] + (foot_x[_hm.vars.i] - x)) / 1.25)), (((y + ((leg_y[_hm.vars.i] + (foot_y[_hm.vars.i] - y)) / 1.25)) - zstart) - foot_z[_hm.vars.i]));
{ var __hm_with75 = scrHMInstances(instance_create((foot_x[_hm.vars.i] + lengthdir_x((10 * _hm.vars.legdie), _hm.vars.legang_)), (foot_y[_hm.vars.i] + lengthdir_y((10 * _hm.vars.legdie), _hm.vars.legang_)), SmallExplosion)), __hm_break77=false;
for (var __hm_index76=0; __hm_index76<array_length(__hm_with75); ++__hm_index76) {
if(instance_exists(__hm_with75[__hm_index76])) with (__hm_with75[__hm_index76]) {
{
var __hm_other78=scrHMOther(other);
team = __hm_other78.team;
;
if ((_hm.vars.legdie > 2)) {
mask_index = mskNone;
}
var __hm_other79=scrHMOther(other);
depth = (__hm_other79.depth - 1);
var __hm_other80=scrHMOther(other);
hitid = __hm_other80.hitid;
}
}
if(__hm_break77) break;
}}
}
}
if(__hm_break74) break;
}}
}
_hm.pc=302;
break;
case 299: // bosses/titank.mod.gml:429
_hm.pc=((_hm.vars.legdie > 0))?303:298;
break;
case 304: // bosses/titank.mod.gml:429
_hm.vars.legdie = 8;
_hm.pc=299;
break;
case 305: // bosses/titank.mod.gml:417
{
for (_hm.vars.legdie = 0; (_hm.vars.legdie < 16); _hm.vars.legdie += 1) {
{ var __hm_with81 = scrHMInstances((scrHMOther(other))), __hm_break83=false;
for (var __hm_index82=0; __hm_index82<array_length(__hm_with81); ++__hm_index82) {
if(instance_exists(__hm_with81[__hm_index82])) with (__hm_with81[__hm_index82]) {
{
_hm.vars.legang_ = point_direction(foot_x[_hm.vars.i], foot_y[_hm.vars.i], (x + ((leg_x[_hm.vars.i] + (foot_x[_hm.vars.i] - x)) / 1.25)), (((y + ((leg_y[_hm.vars.i] + (foot_y[_hm.vars.i] - y)) / 1.25)) - zstart) - foot_z[_hm.vars.i]));
{ var __hm_with84 = scrHMInstances(instance_create((foot_x[_hm.vars.i] + lengthdir_x((5 * _hm.vars.legdie), _hm.vars.legang_)), (foot_y[_hm.vars.i] + lengthdir_y((5 * _hm.vars.legdie), _hm.vars.legang_)), Dust)), __hm_break86=false;
for (var __hm_index85=0; __hm_index85<array_length(__hm_with84); ++__hm_index85) {
if(instance_exists(__hm_with84[__hm_index85])) with (__hm_with84[__hm_index85]) {
{
sprite_index = sprSmokeOLD;
image_speed = (0.1) * timescale;
}
}
if(__hm_break86) break;
}}
{ var __hm_with87 = scrHMInstances(instance_create((foot_x[_hm.vars.i] + lengthdir_x((5 * _hm.vars.legdie), _hm.vars.legang_)), (foot_y[_hm.vars.i] + lengthdir_y((5 * _hm.vars.legdie), _hm.vars.legang_)), LaserBrain)), __hm_break89=false;
for (var __hm_index88=0; __hm_index88<array_length(__hm_with87); ++__hm_index88) {
if(instance_exists(__hm_with87[__hm_index88])) with (__hm_with87[__hm_index88]) {
{
sprite_index = choose(sprPortalL1, sprPortalL2, sprPortalL3, sprPortalL4, sprPortalL5);
}
}
if(__hm_break89) break;
}}
}
}
if(__hm_break83) break;
}}
}
}
_hm.pc=304;
break;
case 306: // bosses/titank.mod.gml:416
_hm.pc = (scrHMTaskFork(_hm, 305)) ? 305 : 296;
break;
case 307: // bosses/titank.mod.gml:414
{
_hm.vars.titank.hurtTimer = 10;
;
scrHMSoundPlay(sndGoldTankDead);
;
}
_hm.pc=306;
break;
case 308: // bosses/titank.mod.gml:410
_hm.pc = ((hp <= 0)) ? 307 : 295;
break;
case 309: // bosses/titank.mod.gml:361
{
if (((speed / timescale) > 0)) {
{
var __hm_other90=scrHMOther(other);
__hm_other90.foot_x[_hm.vars.i] += (hspeed / timescale);
;
var __hm_other91=scrHMOther(other);
__hm_other91.foot_y[_hm.vars.i] += (vspeed / timescale);
;
}
}
if (((scrHMOther(other)).foot_z[_hm.vars.i] <= 0)) {
{
speed /= 2;
;
}
}
var __hm_other92=scrHMOther(other);
x = __hm_other92.foot_x[_hm.vars.i];
;
var __hm_other93=scrHMOther(other);
y = (__hm_other93.foot_y[_hm.vars.i] - 4);
;
var __hm_other94=scrHMOther(other);
team = __hm_other94.team;
;
if (((scrHMOther(other)).foot_z[_hm.vars.i] < 4)) {
{
mask_index = mskLaserCrystal;
;
}
} else {
{
mask_index = mskNone;
;
}
}
var __hm_other95=scrHMOther(other);
__hm_other95.foot_hp[_hm.vars.i] = hp;
;
if ((lsthealth != hp)) {
{
_hm.vars.titank.hurtTimer = 1;
;
lsthealth = hp;
;
}
}
}
_hm.pc=308;
break;
case 310: // bosses/titank.mod.gml:358
_hm.pc = ((! instance_exists(_hm.other_scope))) ? 293 : 309;
break;
case 292: // bosses/titank.mod.gml:356
_hm.pc=(instance_exists(_hm.scope))?310:290;
break;
case 311: // bosses/titank.mod.gml:346
{
sprite_index = mskLaserCrystal;
;
visible = 0;
;
var __hm_other96=scrHMOther(other);
team = __hm_other96.team;
;
var __hm_other97=scrHMOther(other);
hp = __hm_other97.foot_hp[_hm.vars.i];
hm_titank_parent=__hm_other97;hm_titank_leg=_hm.vars.i;
__hm_other97.hm_feet[_hm.vars.i]=id;
;
lsthealth = hp;
;
can_die = 0;
;
canfly = 1;
;
snd_hurt = sndHitMetal;
;
friction = (10) * (timescale * timescale);
}
_hm.pc=292;
break;
case 312: // bosses/titank.mod.gml:344
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(x, (y - z), CustomEnemy)),311,289);
break;
case 313: // bosses/titank.mod.gml:343
{
_hm.vars.titank = id;
;
}
_hm.pc=312;
break;
case 314: // bosses/titank.mod.gml:341
_hm.pc = (scrHMTaskFork(_hm, 313)) ? 313 : 287;
break;
case 315: // bosses/titank.mod.gml:330
{
foot_x[_hm.vars.i] = (x + lengthdir_x(96, ((_hm.vars.i * (360 / legs)) + 45)));
;
foot_y[_hm.vars.i] = (y + lengthdir_y(48, ((_hm.vars.i * (360 / legs)) + 45)));
;
foot_z[_hm.vars.i] = 0;
;
foot_hp[_hm.vars.i] = 150;
;
foot_home_x[_hm.vars.i] = lengthdir_x((96 - 16), ((_hm.vars.i * (360 / legs)) + 45));
;
foot_home_y[_hm.vars.i] = lengthdir_y((48 - 12), ((_hm.vars.i * (360 / legs)) + 45));
;
foot_target_x[_hm.vars.i] = lengthdir_x(96, ((_hm.vars.i * (360 / legs)) + 45));
;
foot_target_y[_hm.vars.i] = lengthdir_y(48, ((_hm.vars.i * (360 / legs)) + 45));
;
}
_hm.pc=314;
break;
case 286: // bosses/titank.mod.gml:328
_hm.pc=((_hm.vars.i < legs))?315:285;
break;
case 316: // bosses/titank.mod.gml:328
_hm.vars.i = 0;
_hm.pc=286;
break;
case 317: // bosses/titank.mod.gml:317
{
for (_hm.vars.i = 0; (_hm.vars.i < legs); _hm.vars.i += 1) {
leg_x[_hm.vars.i] = lengthdir_x(58, ((_hm.vars.i * (360 / legs)) + 45));
;
leg_y[_hm.vars.i] = lengthdir_y(28, ((_hm.vars.i * (360 / legs)) + 45));
;
}
}
_hm.pc=316;
break;
case 318: // bosses/titank.mod.gml:254
{
;
}
_hm.pc=317;
break;
case 319: // bosses/titank.mod.gml:254
_hm.result=undefined; _hm.done=true; return;
break;
case 320: // bosses/titank.mod.gml:240
{
if ((instance_exists(id) and instance_exists(Player))) {
{
scrHMTitankHealth();
scrHMSoundMusic(musBoss2);
if ((scrHMModExists("mod", "options", "intropan") and (scrHMModGet("mod", "options", "intropan") == "1"))) {
{
if ((UberCont.opt_bossintro == 1)) {
{
scrHMModCall("mod", "bossintros", "boss_trigger", "", global.hm_module_vars[$ "mod:bosses/titank"].titankportraitbg, global.hm_module_vars[$ "mod:bosses/titank"].titankportrait, global.hm_module_vars[$ "mod:bosses/titank"].titankportraitfg, id, 60);
}
} else {
scrHMModCall("mod", "bossintros", "boss_trigger", "", mskNone, mskNone, mskNone, id, 60);
}
}
} else {
if ((UberCont.opt_bossintro == 1)) {
{
scrHMModCall("mod", "bossintros", "boss_trigger", "", global.hm_module_vars[$ "mod:bosses/titank"].titankportraitbg, global.hm_module_vars[$ "mod:bosses/titank"].titankportrait, global.hm_module_vars[$ "mod:bosses/titank"].titankportraitfg, instance_nearest(x, y, Player), 0);
}
}
}
}
}
}
_hm.pc=319;
break;
case 321: // bosses/titank.mod.gml:239
_hm.wait_ticks=max(0,20); _hm.pc=320; return;
break;
case 322: // bosses/titank.mod.gml:238
_hm.pc = (scrHMTaskFork(_hm, 321)) ? 321 : 317;
break;
case 323: // bosses/titank.mod.gml:205
{
name = "titank";
HMWorld.hm_titank_entering=false;
team = 1;
;
legs = (4 + (GameCont.loops * 2));
hm_feet=array_create(legs,noone);_x=x;_y=y;
;
scrHMMaxHealthWrite(id, legs, "=");
;
hp = max_hp;
can_die = 0;
;
canmove = 1;
;
canfly = 1;
;
spr_idle = global.hm_module_vars[$ "mod:bosses/titank"].sprTitankBody;
;
spr_walk = global.hm_module_vars[$ "mod:bosses/titank"].sprTitankBody;
;
spr_hurt = global.hm_module_vars[$ "mod:bosses/titank"].sprTitankBodyHurt;
;
spr_dead = mskNone;
;
spr_shadow = mskNone;
;
hitid = [global.hm_module_vars[$ "mod:bosses/titank"].sprTitankBody, "Titank"];
mask_index = mskNone;
;
sprite_index = spr_idle;
;
image_alpha = 0;
;
image_speed = (0.4) * timescale;
;
z = 96;
;
zstart = z;
;
friction = (0.05) * (timescale * timescale);
;
attacking = 0;
;
headZ = 0;
;
lastatk = (- 1);
;
kneeRelativePos = 1.25;
;
image_speed = (0) * timescale;
;
hurtTimer = 0;
;
depth = (- 8);
scrHMBindDraw(hm_bosses_titank_mod_gml_draw_tank, depth);
;
}
_hm.pc=322;
break;
case 324: // bosses/titank.mod.gml:204
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(_hm.vars.tankx, _hm.vars.tanky, CustomEnemy)),323,2);
break;
case 325: // bosses/titank.mod.gml:185
{
;
scrHMSoundPlay(sndExplosionXL);
;
for (_hm.vars.i = 0; (_hm.vars.i < 360); _hm.vars.i += (2 + irandom(2))) {
{ var __hm_with98 = scrHMInstances(instance_create((_hm.vars.tankx + lengthdir_x(70, _hm.vars.i)), ((_hm.vars.tanky + 20) + lengthdir_y(36, _hm.vars.i)), Dust)), __hm_break100=false;
for (var __hm_index99=0; __hm_index99<array_length(__hm_with98); ++__hm_index99) {
if(instance_exists(__hm_with98[__hm_index99])) with (__hm_with98[__hm_index99]) {
{
speed = (random(12)) * timescale;
;
direction = 90;
;
image_xscale *= 3;
;
image_yscale = image_xscale;
;
depth = ((- 8) - ((y > _hm.vars.tanky) ? 1 : (- 1)));
;
}
}
if(__hm_break100) break;
}}
}
{ var __hm_with101 = scrHMInstances(Wall), __hm_break103=false;
for (var __hm_index102=0; __hm_index102<array_length(__hm_with101); ++__hm_index102) {
if(instance_exists(__hm_with101[__hm_index102])) with (__hm_with101[__hm_index102]) {
{
if ((point_distance((x + 8), (y + 8), _hm.vars.tankx, _hm.vars.tanky) <= 64)) {
{
instance_create(x, y, FloorExplo);
;
instance_destroy();
;
}
}
}
}
if(__hm_break103) break;
}}
scrHMSoundMusic(musBoss3);
;
}
_hm.pc=324;
break;
case 326: // bosses/titank.mod.gml:185
_hm.wait_ticks=max(0,35); _hm.pc=325; return;
break;
case 327: // bosses/titank.mod.gml:169
{
;
scrHMSoundPlay(sndExplosionXL);
;
for (_hm.vars.i = 0; (_hm.vars.i < 360); _hm.vars.i += (3 + irandom(3))) {
{ var __hm_with104 = scrHMInstances(instance_create((_hm.vars.tankx + lengthdir_x(70, _hm.vars.i)), ((_hm.vars.tanky + 20) + lengthdir_y(36, _hm.vars.i)), Dust)), __hm_break106=false;
for (var __hm_index105=0; __hm_index105<array_length(__hm_with104); ++__hm_index105) {
if(instance_exists(__hm_with104[__hm_index105])) with (__hm_with104[__hm_index105]) {
{
speed = (random(8)) * timescale;
;
direction = 90;
;
}
}
if(__hm_break106) break;
}}
}
{ var __hm_with107 = scrHMInstances(Wall), __hm_break109=false;
for (var __hm_index108=0; __hm_index108<array_length(__hm_with107); ++__hm_index108) {
if(instance_exists(__hm_with107[__hm_index108])) with (__hm_with107[__hm_index108]) {
{
if ((point_distance((x + 8), (y + 8), _hm.vars.tankx, _hm.vars.tanky) <= 64)) {
{
instance_create(x, y, FloorExplo);
;
instance_destroy();
;
}
}
}
}
if(__hm_break109) break;
}}
}
_hm.pc=326;
break;
case 328: // bosses/titank.mod.gml:169
_hm.wait_ticks=max(0,45); _hm.pc=327; return;
break;
case 329: // bosses/titank.mod.gml:153
{
scrHMSoundPlay(sndExplosionL);
;
scrHMSoundMusic((- 1));
;
for (_hm.vars.i = 0; (_hm.vars.i < 360); _hm.vars.i += (4 + irandom(4))) {
{ var __hm_with110 = scrHMInstances(instance_create((_hm.vars.tankx + lengthdir_x(70, _hm.vars.i)), ((_hm.vars.tanky + 20) + lengthdir_y(36, _hm.vars.i)), Dust)), __hm_break112=false;
for (var __hm_index111=0; __hm_index111<array_length(__hm_with110); ++__hm_index111) {
if(instance_exists(__hm_with110[__hm_index111])) with (__hm_with110[__hm_index111]) {
{
speed = (random(4)) * timescale;
;
direction = 90;
;
}
}
if(__hm_break112) break;
}}
}
{ var __hm_with113 = scrHMInstances(Wall), __hm_break115=false;
for (var __hm_index114=0; __hm_index114<array_length(__hm_with113); ++__hm_index114) {
if(instance_exists(__hm_with113[__hm_index114])) with (__hm_with113[__hm_index114]) {
{
if ((point_distance((x + 8), (y + 8), _hm.vars.tankx, _hm.vars.tanky) <= 64)) {
{
instance_create(x, y, FloorExplo);
;
instance_destroy();
;
}
}
}
}
if(__hm_break115) break;
}}
}
_hm.pc=328;
break;
case 330: // bosses/titank.mod.gml:152
_hm.pc = (scrHMTaskFork(_hm, 329)) ? 329 : 0;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/titank.mod.gml:1358; draw
function hm_bosses_titank_mod_gml_draw() {
if (global.hm_module_vars[$ "mod:bosses/titank"].debug) {
{
{ var __hm_with1 = scrHMInstances(CustomEnemy), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
scrHMDrawTextShadow(x, (y + 32), string(hp));
;
}
}
if(__hm_break3) break;
}}
}
}
}

// Source bosses/titank.mod.gml:1367; draw_tank
function hm_bosses_titank_mod_gml_draw_tank() {
{ var __hm_with1 = scrHMMatching(CustomEnemy, "name", "titank"), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
for (var _hml_i = 0; (_hml_i < array_length_1d(leg_x)); _hml_i += 1) {
if ((((y + leg_y[_hml_i]) < y) and (foot_hp[_hml_i] > 0))) {
hm_bosses_titank_mod_gml_draw_leg(_hml_i);
}
}
scrHMDrawSpriteExt(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankHead, (- 1), x, ((y - z) - headZ), image_xscale, image_yscale, image_angle, image_blend, 1);
;
var _hml_ip = instance_nearest(x, y, Player);
;
if ((_hml_ip != noone)) {
{
var _hml_pdir = (round((point_direction(x, (y - z), _hml_ip.x, _hml_ip.y) / 5)) * 5);
;
scrHMDrawSpriteExt(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankEye, (- 1), (x + lengthdir_x(28, _hml_pdir)), ((((y + 22) + lengthdir_y(22, _hml_pdir)) - z) - headZ), image_xscale, image_yscale, image_angle, image_blend, 1);
;
gpu_set_blendmode(bm_add);
;
for (var _hml_i = 0; (_hml_i < 360); _hml_i += 36) {
scrHMDrawSpriteExt(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankEye, (- 1), ((x + lengthdir_x(28, _hml_pdir)) + lengthdir_x(16, _hml_i)), (((((y + 22) + lengthdir_y(22, _hml_pdir)) - z) + lengthdir_y(2, _hml_i)) - headZ), image_xscale, image_yscale, image_angle, image_blend, 0.1);
;
}
gpu_set_blendmode(bm_normal);
;
}
}
scrHMDrawSpriteExt(((hurtTimer > 0) ? spr_hurt : sprite_index), (- 1), x, (y - z), image_xscale, image_yscale, image_angle, image_blend, 1);
;
for (var _hml_i = 0; (_hml_i < array_length_1d(leg_x)); _hml_i += 1) {
if ((((y + leg_y[_hml_i]) >= y) and (foot_hp[_hml_i] > 0))) {
hm_bosses_titank_mod_gml_draw_leg(_hml_i);
}
}
if (global.hm_module_vars[$ "mod:bosses/titank"].debug) {
{
for (var _hml_i = 0; (_hml_i < array_length_1d(leg_x)); _hml_i += 1) {
draw_set_color(c_red);
;
draw_circle((x + leg_x[_hml_i]), ((y + leg_y[_hml_i]) - z), 3, 1);
;
draw_set_color(c_green);
;
draw_circle((x + ((leg_x[_hml_i] + (foot_x[_hml_i] - x)) / 1.25)), (((y + ((leg_y[_hml_i] + (foot_y[_hml_i] - y)) / 1.25)) - zstart) - foot_z[_hml_i]), 3, 1);
;
draw_set_color(c_blue);
;
draw_circle(foot_x[_hml_i], (foot_y[_hml_i] - foot_z[_hml_i]), 3, 1);
;
draw_set_color(c_blue);
;
draw_circle(foot_x[_hml_i], foot_y[_hml_i], 3, 0);
;
}
}
}
}
}
if(__hm_break3) break;
}}
}

// Source bosses/titank.mod.gml:1426; draw_leg
function hm_bosses_titank_mod_gml_draw_leg(_hml_i) {
var _hml_ldir = (((x + leg_x[_hml_i]) >= x) ? 1 : (- 1));
;
if (((y + leg_y[_hml_i]) >= y)) {
{
var _hml_kneex = (x + ((leg_x[_hml_i] + (foot_x[_hml_i] - x)) / kneeRelativePos));
;
var _hml_kneey = (y + ((leg_y[_hml_i] + (foot_y[_hml_i] - y)) / kneeRelativePos));
;
var _hml_pdir = point_direction(_hml_kneex, (_hml_kneey - z), x, (y - z));
;
draw_sprite_pos(((hurtTimer > 0) ? spr_hurt : global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg), 1, ((x + leg_x[_hml_i]) + lengthdir_x((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir - (90 * _hml_ldir)))), (((y + leg_y[_hml_i]) + lengthdir_y((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir - (90 * _hml_ldir)))) - z), ((x + leg_x[_hml_i]) + lengthdir_x((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir + (90 * _hml_ldir)))), (((y + leg_y[_hml_i]) + lengthdir_y((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir + (90 * _hml_ldir)))) - z), (_hml_kneex + lengthdir_x((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir + (90 * _hml_ldir)))), (((_hml_kneey + lengthdir_y((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir + (90 * _hml_ldir)))) - zstart) - foot_z[_hml_i]), (_hml_kneex + lengthdir_x((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir - (90 * _hml_ldir)))), (((_hml_kneey + lengthdir_y((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir - (90 * _hml_ldir)))) - zstart) - foot_z[_hml_i]), 1);
;
}
}
var _hml_kneex = (x + ((leg_x[_hml_i] + (foot_x[_hml_i] - x)) / kneeRelativePos));
;
var _hml_kneey = (y + ((leg_y[_hml_i] + (foot_y[_hml_i] - y)) / kneeRelativePos));
;
var _hml_pdir = point_direction(_hml_kneex, ((_hml_kneey - zstart) - foot_z[_hml_i]), foot_x[_hml_i], (foot_y[_hml_i] - foot_z[_hml_i]));
;
draw_sprite_pos(((hurtTimer > 0) ? global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLegHurt : (((y + leg_y[_hml_i]) >= y) ? ((foot_hp[_hml_i] <= 0) ? global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLegDestroyed : global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) : ((foot_hp[_hml_i] <= 0) ? global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLegDarkDestroyed : global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLegDark))), 0, (_hml_kneex + lengthdir_x((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir + (90 * _hml_ldir)))), (((_hml_kneey + lengthdir_y((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir + (90 * _hml_ldir)))) - zstart) - foot_z[_hml_i]), (_hml_kneex + lengthdir_x((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir - (90 * _hml_ldir)))), (((_hml_kneey + lengthdir_y((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir - (90 * _hml_ldir)))) - zstart) - foot_z[_hml_i]), (foot_x[_hml_i] + lengthdir_x((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir - (90 * _hml_ldir)))), ((foot_y[_hml_i] + lengthdir_y((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir - (90 * _hml_ldir)))) - foot_z[_hml_i]), (foot_x[_hml_i] + lengthdir_x((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir + (90 * _hml_ldir)))), ((foot_y[_hml_i] + lengthdir_y((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir + (90 * _hml_ldir)))) - foot_z[_hml_i]), 1);
;
if (((y + leg_y[_hml_i]) < y)) {
{
var _hml_kneex = (x + ((leg_x[_hml_i] + (foot_x[_hml_i] - x)) / kneeRelativePos));
;
var _hml_kneey = (y + ((leg_y[_hml_i] + (foot_y[_hml_i] - y)) / kneeRelativePos));
;
var _hml_pdir = point_direction(_hml_kneex, (_hml_kneey - z), x, (y - z));
;
draw_sprite_pos(((hurtTimer > 0) ? spr_hurt : global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg), 1, ((x + leg_x[_hml_i]) + lengthdir_x((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir - (90 * _hml_ldir)))), (((y + leg_y[_hml_i]) + lengthdir_y((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir - (90 * _hml_ldir)))) - z), ((x + leg_x[_hml_i]) + lengthdir_x((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir + (90 * _hml_ldir)))), (((y + leg_y[_hml_i]) + lengthdir_y((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir + (90 * _hml_ldir)))) - z), (_hml_kneex + lengthdir_x((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir + (90 * _hml_ldir)))), (((_hml_kneey + lengthdir_y((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir + (90 * _hml_ldir)))) - zstart) - foot_z[_hml_i]), (_hml_kneex + lengthdir_x((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir - (90 * _hml_ldir)))), (((_hml_kneey + lengthdir_y((sprite_get_width(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankLeg) / 2), (_hml_pdir - (90 * _hml_ldir)))) - zstart) - foot_z[_hml_i]), 1);
;
}
}
if (global.hm_module_vars[$ "mod:bosses/titank"].debug) {
draw_line(_hml_kneex, ((_hml_kneey - zstart) - foot_z[_hml_i]), foot_x[_hml_i], (foot_y[_hml_i] - foot_z[_hml_i]));
}
}

// Source bosses/titank.mod.gml:1500; draw_shadows
function hm_bosses_titank_mod_gml_draw_shadows() {
{ var __hm_with1 = scrHMMatching(CustomEnemy, "name", "titank"), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
for (var _hml_i = 0; (_hml_i < legs); _hml_i += 1) {
if (((foot_hp[_hml_i] > 0) and position_meeting(foot_x[_hml_i], (foot_y[_hml_i] - 6), Floor))) {
scrHMDrawSpriteExt(shd24, 1, foot_x[_hml_i], (foot_y[_hml_i] - 6), 0.5, 0.5, 0, c_white, 1);
}
}
var _hml_shad_scale = undefined;
;
_hml_shad_scale = (1 - min((0.66 * (z / 96)), 0.66));
scrHMDrawSpriteExt(global.hm_module_vars[$ "mod:bosses/titank"].sprTitankShadow, 1, x, y, _hml_shad_scale, _hml_shad_scale, 0, c_white, 1);
}
}
if(__hm_break3) break;
}}
}

// Source bosses/titank.mod.gml:1510; scrNuke
function hm_bosses_titank_mod_gml_scrNuke() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_titank_mod_gml_scrNuke_resume, id, scrHMOther(other), _args, 29, ["z", "size"]);
}
function hm_bosses_titank_mod_gml_scrNuke_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_titank_mod_gml_scrNuke");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 2: // bosses/titank.mod.gml:1576
_hm.vars.i += (24 / _hm.vars.size); _hm.pc=1;
break;
case 3: // bosses/titank.mod.gml:1578
scrHMTaskWithNext(_hm);
break;
case 4: // bosses/titank.mod.gml:1578
scrHMTaskWithAbort(_hm);
break;
case 5: // bosses/titank.mod.gml:1597
{
;
}
_hm.pc=3;
break;
case 6: // bosses/titank.mod.gml:1597
_hm.result=undefined; _hm.done=true; return;
break;
case 8: // bosses/titank.mod.gml:1595
{
;
}
_hm.pc=7;
break;
case 9: // bosses/titank.mod.gml:1595
_hm.wait_ticks=max(0,1); _hm.pc=8; return;
break;
case 10: // bosses/titank.mod.gml:1594
{
depth = (_hm.vars.d - (y + ystart));
;
}
_hm.pc=9;
break;
case 7: // bosses/titank.mod.gml:1592
_hm.pc=(instance_exists(_hm.scope))?10:6;
break;
case 11: // bosses/titank.mod.gml:1590
_hm.pc = (scrHMTaskFork(_hm, 7)) ? 7 : 3;
break;
case 12: // bosses/titank.mod.gml:1580
{
var __hm_other1=scrHMOther(other);
team = __hm_other1.team;
;
mask_index = mskNone;
;
direction = _hm.vars.i;
;
speed = ((6 * _hm.vars.size)) * timescale;
;
vspeed *= 0.5;
;
vspeed -= ((6 * _hm.vars.size)) * timescale;
;
image_xscale = 1.5;
;
image_yscale = image_xscale;
;
_hm.vars.d = depth;
;
}
_hm.pc=11;
break;
case 13: // bosses/titank.mod.gml:1578
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(x, (y - _hm.vars.z), Explosion)),12,2);
break;
case 1: // bosses/titank.mod.gml:1576
_hm.pc=((_hm.vars.i < 360))?13:0;
break;
case 14: // bosses/titank.mod.gml:1576
_hm.vars.i = 0;
_hm.pc=1;
break;
case 16: // bosses/titank.mod.gml:1555
_hm.vars.__hm_repeat2--; _hm.pc=15;
break;
case 17: // bosses/titank.mod.gml:1557
scrHMTaskWithNext(_hm);
break;
case 18: // bosses/titank.mod.gml:1557
scrHMTaskWithAbort(_hm);
break;
case 19: // bosses/titank.mod.gml:1571
{
;
}
_hm.pc=17;
break;
case 20: // bosses/titank.mod.gml:1571
_hm.result=undefined; _hm.done=true; return;
break;
case 22: // bosses/titank.mod.gml:1569
{
;
}
_hm.pc=21;
break;
case 23: // bosses/titank.mod.gml:1569
_hm.wait_ticks=max(0,1); _hm.pc=22; return;
break;
case 24: // bosses/titank.mod.gml:1568
{
depth = (_hm.vars.d - ((y + ystart) / 2));
;
}
_hm.pc=23;
break;
case 21: // bosses/titank.mod.gml:1566
_hm.pc=(instance_exists(_hm.scope))?24:20;
break;
case 25: // bosses/titank.mod.gml:1564
_hm.pc = (scrHMTaskFork(_hm, 21)) ? 21 : 17;
break;
case 26: // bosses/titank.mod.gml:1559
{
var __hm_other3=scrHMOther(other);
team = __hm_other3.team;
;
mask_index = mskNone;
;
vspeed = (((- random(4)) * _hm.vars.size)) * timescale;
;
_hm.vars.d = depth;
;
}
_hm.pc=25;
break;
case 27: // bosses/titank.mod.gml:1557
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create((x + lengthdir_x((random(8) * _hm.vars.size), random(360))), ((y + lengthdir_y((random(8) * _hm.vars.size), random(360))) - _hm.vars.z), SmallExplosion)),26,16);
break;
case 15: // bosses/titank.mod.gml:1555
_hm.pc=(_hm.vars.__hm_repeat2>0)?27:14;
break;
case 28: // bosses/titank.mod.gml:1555
_hm.vars.__hm_repeat2=round((32 * _hm.vars.size)); _hm.pc=15;
break;
case 29: // bosses/titank.mod.gml:1513
{
{ var __hm_with4 = scrHMInstances(instance_create(x, (y - _hm.vars.z), Explosion)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
team = 2;
;
visible = 0;
;
image_xscale *= (2.5 * _hm.vars.size);
;
image_yscale = image_xscale;
;
{ var __hm_with7 = scrHMInstances(hitme), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
if (((scrHMVariableExists(id, "team") && (team != (scrHMOther(other)).team)) && (distance_to_object((scrHMOther(other))) <= 0))) {
{
hp -= (20 + (10 * GameCont.level));
;
}
}
}
}
if(__hm_break9) break;
}}
}
}
if(__hm_break6) break;
}}
for (_hm.vars.i = 0; (_hm.vars.i < 360); _hm.vars.i += (60 / _hm.vars.size)) {
{ var __hm_with10 = scrHMInstances(instance_create(x, (y - _hm.vars.z), Explosion)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
var __hm_other13=scrHMOther(other);
team = __hm_other13.team;
;
mask_index = mskNone;
;
direction = _hm.vars.i;
;
speed = (((8 * _hm.vars.size) / 1.5)) * timescale;
;
vspeed *= 0.75;
;
}
}
if(__hm_break12) break;
}}
}
for (_hm.vars.i = 15; (_hm.vars.i < 360); _hm.vars.i += (60 / _hm.vars.size)) {
{ var __hm_with14 = scrHMInstances(instance_create(x, (y - _hm.vars.z), SmallExplosion)), __hm_break16=false;
for (var __hm_index15=0; __hm_index15<array_length(__hm_with14); ++__hm_index15) {
if(instance_exists(__hm_with14[__hm_index15])) with (__hm_with14[__hm_index15]) {
{
var __hm_other17=scrHMOther(other);
team = __hm_other17.team;
;
mask_index = mskNone;
;
direction = _hm.vars.i;
;
speed = (((10 * _hm.vars.size) / 1.5)) * timescale;
;
vspeed *= 0.75;
;
}
}
if(__hm_break16) break;
}}
}
}
_hm.pc=28;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/titank.mod.gml:1601; tinade_create
function hm_bosses_titank_mod_gml_tinade_create(_hml__x, _hml__y, _hml__creator) {
{ var __hm_with1 = scrHMInstances(instance_create(x, y, CustomProjectile)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
hm_grenade_fuse = 40;
creator=_hml__creator;
var __hm_other4=scrHMOther(other);
team = __hm_other4.team;
var __hm_other5=scrHMOther(other);
hitid = __hm_other5.hitid;
scrHMMotionAdd(random(180), 2);
bounce = irandom(2);
sprite_index = sprGrenade;
friction = (0.2) * (timescale * timescale);
z = 0;
typ = 1;
on_step = scrHMScriptRef(hm_bosses_titank_mod_gml_tinade);
on_destroy = scrHMScriptRef(hm_bosses_titank_mod_gml_tinade_explo);
on_wall = scrHMScriptRef(hm_bosses_titank_mod_gml_tinade_wall);
on_hit = hm_bosses_titank_mod_gml_tinade_hit;
scrHMSoundPlay(sndHitMetal);
return id;
;
}
}
if(__hm_break3) break;
}}
}

// Source bosses/titank.mod.gml:1620; tinade
function hm_bosses_titank_mod_gml_tinade() {
hm_grenade_fuse--;
if (((hm_grenade_fuse < 20) and ((hm_grenade_fuse mod 3) == 3))) {
{
sprite_index = sprGrenadeBlink;
image_index = 0;
}
}
if ((hm_grenade_fuse <= 0)) {
instance_destroy();
}
}

// Source bosses/titank.mod.gml:1649; tinade_explo
function hm_bosses_titank_mod_gml_tinade_explo() {
{ var __hm_with1 = scrHMInstances(instance_create(x, y, Explosion)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var __hm_other4=scrHMOther(other);
hitid = __hm_other4.hitid;
if ((instance_exists((scrHMOther(other)).creator) and ((scrHMOther(other)).team == (scrHMOther(other)).creator.team))) {
var __hm_other5=scrHMOther(other);
team = __hm_other5.creator.team;
} else {
team = 0;
}
}
}
if(__hm_break3) break;
}}
}

// Source bosses/titank.mod.gml:1656; tinade_wall
function hm_bosses_titank_mod_gml_tinade_wall() {scrHMTinadeWall();}

// Source bosses/titank.mod.gml:1659; tinade_hit
function hm_bosses_titank_mod_gml_tinade_hit() {

}

// Source bosses/titank.mod.gml:1660; tinade_draw
function hm_bosses_titank_mod_gml_tinade_draw() {

}
