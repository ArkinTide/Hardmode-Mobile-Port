// Source bosses/scorpionboss.mod.gml:1; __load
function hm_bosses_scorpionboss_mod_gml___load() {
global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossidle = sprHM_bosses_scorpionboss_mod_2;
global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbosshurt = sprHM_bosses_scorpionboss_mod_3;
global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossdead = sprHM_bosses_scorpionboss_mod_4;
global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionintro = sprHM_bosses_scorpionboss_mod_5;
global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionExplode = scrHMSoundAdd("../music/scorpionexplode.ogg");
;
}

// Source bosses/scorpionboss.mod.gml:9; scorpionboss_create
function hm_bosses_scorpionboss_mod_gml_scorpionboss_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomEnemy)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "scorpionboss";
on_step = scrHMScriptRef(hm_bosses_scorpionboss_mod_gml_scorpionboss_step);
if ((GameCont.loops == 0)) {
on_destroy = scrHMScriptRef(hm_bosses_scorpionboss_mod_gml_scorpionboss_death);
} else {
on_destroy = scrHMScriptRef(hm_bosses_scorpionboss_mod_gml_fancyscorpionboss_death);
}
hitid = [global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossidle, "grand scorpion"];
spr_idle = global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossidle;
spr_walk = global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossidle;
spr_hurt = global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbosshurt;
spr_dead = global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossdead;
snd_hurt = sndGoldScorpionHurt;
snd_dead = sndGoldScorpionDead;
scrHMMaxHealthWrite(id, 250, "=");
scrHMMaxHealthWrite(id, ((max_hp / 2) * instance_number(Player)), "+=");
scrHMMaxHealthWrite(id, (GameCont.loops + 1), "*=");
hp = max_hp;
midpoint = ((max_hp / 4) * 3);
team = 1;
friction = (0.4) * (timescale * timescale);
direction = random(360);
direction2 = direction;
mask_index = mskShield;
spr_shadow = shd96;
size = 3;
canmelee = 1;
meleedamage = 6;
target = 0;
targetvisible = 0;
raddrop = 100;
intro = 0;
dashing = 0;
alrm0 = 0;
alrm1 = (- 1);
alrm2 = (- 1);
wakeup = 0;
repeat ((GameCont.loops + 2)) {
if ((random(10) < GameCont.loops)) {
instance_create((x + 16), (y + 16), GoldScorpion);
} else {
instance_create((x + 16), (y + 16), Scorpion);
}
;
}
return id;
;
}
}
if(__hm_break3) break;
}}
}

// Source bosses/scorpionboss.mod.gml:55; scorpionboss_step
function hm_bosses_scorpionboss_mod_gml_scorpionboss_step() {
var _target=instance_nearest(x,y,Player);
var _a=instance_exists(_target)?point_direction(x,y,_target.x,_target.y):direction;
var _d=instance_exists(_target)?point_distance(x,y,_target.x,_target.y):128;
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_scorpionboss_mod_gml_scorpionboss_step_resume, id, scrHMOther(other), [_a,_d], 109, ["a","d"]);
}
function hm_bosses_scorpionboss_mod_gml_scorpionboss_step_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_scorpionboss_mod_gml_scorpionboss_step");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 2: // bosses/scorpionboss.mod.gml:408
_hm.vars.__hm_repeat1--; _hm.pc=1;
break;
case 3: // bosses/scorpionboss.mod.gml:428
{
_hm.vars.ang += 1;
}
_hm.pc=2;
break;
case 4: // bosses/scorpionboss.mod.gml:412
scrHMTaskWithNext(_hm);
break;
case 5: // bosses/scorpionboss.mod.gml:412
scrHMTaskWithAbort(_hm);
break;
case 6: // bosses/scorpionboss.mod.gml:425
_hm.wait_ticks=max(0,random_range(0, 1)); _hm.pc=4; return;
break;
case 7: // bosses/scorpionboss.mod.gml:413
{
scrHMSoundPitchVolume(sndScorpionFireStart, 1, ((view_width / 4) / distance_to_object(Player)));
damage = 1;
maggot = 1;
creator = _hm.vars.c;
hitid = [global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossidle, "grand scorpion"];
team = 1;
if ((GameCont.loops == 0)) {
speed = (random_range(5, 8)) * timescale;
} else {
speed = (random_range((3 + GameCont.loops), (8 + GameCont.loops))) * timescale;
}
direction = _hm.vars.d;
image_angle = direction;
}
_hm.pc=6;
break;
case 8: // bosses/scorpionboss.mod.gml:412
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create((x + lengthdir_x(32, _hm.vars.d)), (y + lengthdir_y(32, _hm.vars.d)), EnemyBullet2)),7,3);
break;
case 9: // bosses/scorpionboss.mod.gml:410
{
_hm.vars.wide_ = ((60 - (20 * GameCont.loops)) - 0);
_hm.vars.d = ((_hm.vars.a + random_range((- 5), 5)) + choose((_hm.vars.wide_ * (- 1)), _hm.vars.wide_));
;
}
_hm.pc=8;
break;
case 10: // bosses/scorpionboss.mod.gml:409
_hm.pc = (instance_exists(_hm.scope)) ? 9 : 3;
break;
case 1: // bosses/scorpionboss.mod.gml:408
_hm.pc=(_hm.vars.__hm_repeat1>0)?10:0;
break;
case 11: // bosses/scorpionboss.mod.gml:408
_hm.vars.__hm_repeat1=round(30); _hm.pc=1;
break;
case 12: // bosses/scorpionboss.mod.gml:407
{
_hm.vars.ang = 0;
}
_hm.pc=11;
break;
case 14: // bosses/scorpionboss.mod.gml:386
_hm.vars.__hm_repeat2--; _hm.pc=13;
break;
case 15: // bosses/scorpionboss.mod.gml:390
scrHMTaskWithNext(_hm);
break;
case 16: // bosses/scorpionboss.mod.gml:390
scrHMTaskWithAbort(_hm);
break;
case 17: // bosses/scorpionboss.mod.gml:402
_hm.wait_ticks=max(0,random_range(0, 2)); _hm.pc=15; return;
break;
case 18: // bosses/scorpionboss.mod.gml:391
{
damage = 2;
maggot = 1;
creator = _hm.vars.c;
hitid = [global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossidle, "grand scorpion"];
team = 1;
if ((GameCont.loops == 0)) {
speed = (random_range(2, 8)) * timescale;
} else {
speed = (random_range(1, 9)) * timescale;
}
direction = _hm.vars.d;
image_angle = direction;
}
_hm.pc=17;
break;
case 19: // bosses/scorpionboss.mod.gml:390
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create((x + lengthdir_x(32, _hm.vars.d)), (y + lengthdir_y(32, _hm.vars.d)), EnemyBullet2)),18,14);
break;
case 20: // bosses/scorpionboss.mod.gml:388
{
scrHMSoundPitchVolume(sndScorpionFireStart, 1, ((view_width / 4) / distance_to_object(Player)));
_hm.vars.d = (_hm.vars.a + random_range((- 50), 50));
;
}
_hm.pc=19;
break;
case 21: // bosses/scorpionboss.mod.gml:387
_hm.pc = (instance_exists(_hm.scope)) ? 20 : 14;
break;
case 13: // bosses/scorpionboss.mod.gml:386
_hm.pc=(_hm.vars.__hm_repeat2>0)?21:12;
break;
case 22: // bosses/scorpionboss.mod.gml:386
_hm.vars.__hm_repeat2=round(40); _hm.pc=13;
break;
case 23: // bosses/scorpionboss.mod.gml:385
_hm.pc = (scrHMTaskFork(_hm, 22)) ? 22 : 12;
break;
case 24: // bosses/scorpionboss.mod.gml:381
{
scrHMSoundPlay(sndGoldScorpionFire);
alrm1 = 1000;
_hm.vars.a = point_direction(x, y, target.x, target.y);
_hm.vars.c = id;
}
_hm.pc=23;
break;
case 25: // bosses/scorpionboss.mod.gml:380
_hm.pc = (((instance_exists(_hm.scope) and (alrm1 == 0)) && (target > 0))) ? 24 : 0;
break;
case 26: // bosses/scorpionboss.mod.gml:255
{
if (instance_exists(id)) {
for (_hm.vars.i = (- 70); (_hm.vars.i < 70); _hm.vars.i++) {
{ var __hm_with3 = scrHMInstances(instance_create((x + lengthdir_x((32 + random_range((- 30), 30)), (_hm.vars.i + _hm.vars.a))), (y + lengthdir_y((32 + random_range((- 30), 30)), (_hm.vars.i + _hm.vars.a))), DustOLD)), __hm_break5=false;
for (var __hm_index4=0; __hm_index4<array_length(__hm_with3); ++__hm_index4) {
if(instance_exists(__hm_with3[__hm_index4])) with (__hm_with3[__hm_index4]) {
{
scrHMMotionAdd((_hm.vars.i + _hm.vars.a), 20);
set = 0;
time = 0;
image_xscale = random_range(1, 3);
image_yscale = image_xscale;
image_speed = (0) * timescale;
friction = (0.4) * (timescale * timescale);
var __hm_other6=scrHMOther(other);
creator = __hm_other6;
}
}
if(__hm_break5) break;
}}
{ var __hm_with7 = scrHMInstances(instance_create((x + lengthdir_x((32 + random_range((- 30), 30)), (_hm.vars.i + _hm.vars.a))), (y + lengthdir_y((32 + random_range((- 30), 30)), (_hm.vars.i + _hm.vars.a))), Dust)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
scrHMMotionAdd((_hm.vars.i + _hm.vars.a), 20);
set = 0;
image_xscale = random_range(1, 3);
image_yscale = image_xscale;
image_speed = (0) * timescale;
friction = (0.4) * (timescale * timescale);
var __hm_other10=scrHMOther(other);
creator = __hm_other10;
}
}
if(__hm_break9) break;
}}
}
}
}
_hm.pc=25;
break;
case 27: // bosses/scorpionboss.mod.gml:254
_hm.wait_ticks=max(0,10); _hm.pc=26; return;
break;
case 28: // bosses/scorpionboss.mod.gml:253
{
alrm2 = max(round((_hm.vars.d / 8)), 16);
}
_hm.pc=27;
break;
case 29: // bosses/scorpionboss.mod.gml:251
_hm.result=undefined; _hm.done=true; return;
break;
case 31: // bosses/scorpionboss.mod.gml:245
_hm.vars.q++; _hm.pc=30;
break;
case 32: // bosses/scorpionboss.mod.gml:249
_hm.wait_ticks=max(0,1); _hm.pc=31; return;
break;
case 33: // bosses/scorpionboss.mod.gml:246
{
if (((_hm.vars.q mod 2) == 1)) {
{
scrHMSoundPitchVolume(sndEliteInspectorStart, 0.8, 0.5);
}
}
}
_hm.pc=32;
break;
case 30: // bosses/scorpionboss.mod.gml:245
_hm.pc=((_hm.vars.q < 10))?33:29;
break;
case 34: // bosses/scorpionboss.mod.gml:245
_hm.vars.q = 0;
_hm.pc=30;
break;
case 35: // bosses/scorpionboss.mod.gml:244
_hm.pc = (scrHMTaskFork(_hm, 34)) ? 34 : 28;
break;
case 36: // bosses/scorpionboss.mod.gml:297
{
if (instance_exists(id)) {
alrm0 += 1;
}
}
_hm.pc=25;
break;
case 37: // bosses/scorpionboss.mod.gml:296
_hm.wait_ticks=max(0,20); _hm.pc=36; return;
break;
case 38: // bosses/scorpionboss.mod.gml:292
{
dashing = 0;
friction = (0.4) * (timescale * timescale);
alrm1 = 0;
}
_hm.pc=37;
break;
case 39: // bosses/scorpionboss.mod.gml:291
_hm.pc = (instance_exists(_hm.scope)) ? 38 : 25;
break;
case 40: // bosses/scorpionboss.mod.gml:290
_hm.wait_ticks=max(0,(12 + (5 * GameCont.loops))); _hm.pc=39; return;
break;
case 41: // bosses/scorpionboss.mod.gml:281
{
scrHMSoundPitch(sndEliteInspectorAlarmed, 0.8);
_hm.vars._inc = (distance_to_object(target) / 12);
;
_hm.vars._dis = 0;
;
_hm.vars._ang = direction;
;
direction = (point_direction(x, y, target.x, target.y) + random_range((- 70), 70));
speed += (3) * timescale;
dashing = 1;
direction2 = direction;
friction = (0.4) * (timescale * timescale);
}
_hm.pc=40;
break;
case 42: // bosses/scorpionboss.mod.gml:243
_hm.pc = ((((_hm.vars.d < 160) || (random(4) < 1)) || (_hm.vars.d > 320))) ? 35 : 41;
break;
case 43: // bosses/scorpionboss.mod.gml:237
{
if ((wakeup == 1)) {
wakeup = (- 1);
}
alrm2 = 100;
_hm.vars.a = point_direction(x, y, target.x, target.y);
;
_hm.vars.d = point_distance(x, y, target.x, target.y);
;
}
_hm.pc=42;
break;
case 45: // bosses/scorpionboss.mod.gml:361
_hm.vars.__hm_repeat11--; _hm.pc=44;
break;
case 46: // bosses/scorpionboss.mod.gml:373
{
;
}
_hm.pc=45;
break;
case 47: // bosses/scorpionboss.mod.gml:373
_hm.wait_ticks=max(0,1); _hm.pc=46; return;
break;
case 48: // bosses/scorpionboss.mod.gml:362
{
if (instance_exists(id)) {
{ var __hm_with12 = scrHMInstances(instance_create((x + lengthdir_x((50 + _hm.vars._dis), _hm.vars._ang)), (y + lengthdir_y((50 + _hm.vars._dis), _hm.vars._ang)), PortalClear)), __hm_break14=false;
for (var __hm_index13=0; __hm_index13<array_length(__hm_with12); ++__hm_index13) {
if(instance_exists(__hm_with12[__hm_index13])) with (__hm_with12[__hm_index13]) {
{
image_xscale = 2;
image_yscale = (1 - ((_hm.vars._dis / _hm.vars._inc) / 10));
image_angle = _hm.vars._ang;
{ var __hm_with15 = scrHMInstances(instance_create((x + random(120)), (y + random(120)), Dust)), __hm_break17=false;
for (var __hm_index16=0; __hm_index16<array_length(__hm_with15); ++__hm_index16) {
if(instance_exists(__hm_with15[__hm_index16])) with (__hm_with15[__hm_index16]) {
{
image_angle = random(360);
scrHMMotionAdd(_hm.vars._ang, 6);
}
}
if(__hm_break17) break;
}}
}
}
if(__hm_break14) break;
}}
}
_hm.vars._dis += _hm.vars._inc;
}
_hm.pc=47;
break;
case 44: // bosses/scorpionboss.mod.gml:361
_hm.pc=(_hm.vars.__hm_repeat11>0)?48:25;
break;
case 49: // bosses/scorpionboss.mod.gml:361
_hm.vars.__hm_repeat11=round(12); _hm.pc=44;
break;
case 50: // bosses/scorpionboss.mod.gml:358
{
_hm.vars._inc = (distance_to_object(target) / 8);
;
_hm.vars._dis = 0;
;
_hm.vars._ang = point_direction(x, y, target.x, target.y);
;
}
_hm.pc=49;
break;
case 51: // bosses/scorpionboss.mod.gml:356
_hm.pc = ((instance_exists(_hm.scope) and (target > 0))) ? 50 : 25;
break;
case 52: // bosses/scorpionboss.mod.gml:354
{
;
}
_hm.pc=51;
break;
case 53: // bosses/scorpionboss.mod.gml:354
_hm.result=undefined; _hm.done=true; return;
break;
case 55: // bosses/scorpionboss.mod.gml:336
_hm.vars.__hm_repeat18--; _hm.pc=54;
break;
case 56: // bosses/scorpionboss.mod.gml:340
scrHMTaskWithNext(_hm);
break;
case 57: // bosses/scorpionboss.mod.gml:340
scrHMTaskWithAbort(_hm);
break;
case 58: // bosses/scorpionboss.mod.gml:350
_hm.wait_ticks=max(0,1); _hm.pc=56; return;
break;
case 59: // bosses/scorpionboss.mod.gml:349
_hm.pc = ((random(2) < 1)) ? 58 : 56;
break;
case 60: // bosses/scorpionboss.mod.gml:341
{
damage = 1;
maggot = 1;
creator = _hm.vars.c;
hitid = [global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossidle, "grand scorpion"];
team = 1;
speed = (random_range(5, (12 + (GameCont.loops * 2)))) * timescale;
direction = _hm.vars.d;
image_angle = direction;
}
_hm.pc=59;
break;
case 61: // bosses/scorpionboss.mod.gml:340
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create((x + lengthdir_x(32, _hm.vars.d)), (y + lengthdir_y(32, _hm.vars.d)), EnemyBullet2)),60,55);
break;
case 62: // bosses/scorpionboss.mod.gml:338
{
scrHMSoundPitchVolume(sndScorpionFireStart, 1, ((view_width / 4) / distance_to_object(Player)));
_hm.vars.d = (_hm.vars.a + random_range((- 5), 5));
;
}
_hm.pc=61;
break;
case 63: // bosses/scorpionboss.mod.gml:337
_hm.pc = (instance_exists(_hm.scope)) ? 62 : 55;
break;
case 54: // bosses/scorpionboss.mod.gml:336
_hm.pc=(_hm.vars.__hm_repeat18>0)?63:53;
break;
case 64: // bosses/scorpionboss.mod.gml:336
_hm.vars.__hm_repeat18=round(40); _hm.pc=54;
break;
case 65: // bosses/scorpionboss.mod.gml:335
_hm.pc = (scrHMTaskFork(_hm, 64)) ? 64 : 51;
break;
case 66: // bosses/scorpionboss.mod.gml:318
{
direction = point_direction(x, y, target.x, target.y);
repeat (300) { var __hm_with19 = scrHMInstances(instance_create((x + random_range((- 16), 16)), ((y + 32) + random_range((- 16), 16)), Dust)), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
{
image_speed = (0.1) * timescale;
var __hm_other22=scrHMOther(other);
depth = (__hm_other22.depth + 0.1);
var __hm_other23=scrHMOther(other);
scrHMMotionAdd(__hm_other23.direction, 30);
}
}
if(__hm_break21) break;
}}
scrHMSoundPitch(sndEliteInspectorAlarmed, 0.4);
scrHMSoundPlay(sndGoldScorpionFire);
alrm1 = 1000;
_hm.vars.a = point_direction(x, y, target.x, target.y);
_hm.vars.c = id;
}
_hm.pc=65;
break;
case 67: // bosses/scorpionboss.mod.gml:317
_hm.pc = (instance_exists(_hm.scope)) ? 66 : 25;
break;
case 68: // bosses/scorpionboss.mod.gml:315
_hm.wait_ticks=max(0,30); _hm.pc=67; return;
break;
case 69: // bosses/scorpionboss.mod.gml:313
{
;
}
_hm.pc=68;
break;
case 70: // bosses/scorpionboss.mod.gml:313
_hm.result=undefined; _hm.done=true; return;
break;
case 72: // bosses/scorpionboss.mod.gml:306
_hm.vars.t++; _hm.pc=71;
break;
case 73: // bosses/scorpionboss.mod.gml:311
_hm.wait_ticks=max(0,1); _hm.pc=72; return;
break;
case 74: // bosses/scorpionboss.mod.gml:307
{
repeat (round((1 + (_hm.vars.t / 2.5)))) if (instance_exists(id)) {
{ var __hm_with24 = scrHMInstances(instance_create((x + lengthdir_x((64 - (_hm.vars.t * 2)), random(360))), (y + lengthdir_y((64 - (_hm.vars.t * 2)), random(360))), Dust)), __hm_break26=false;
for (var __hm_index25=0; __hm_index25<array_length(__hm_with24); ++__hm_index25) {
if(instance_exists(__hm_with24[__hm_index25])) with (__hm_with24[__hm_index25]) {
var __hm_other27=scrHMOther(other);
scrHMMotionAdd(point_direction(x, y, __hm_other27.x, __hm_other27.y), (4 + (_hm.vars.t / 5)));
}
if(__hm_break26) break;
}}
}
}
_hm.pc=73;
break;
case 71: // bosses/scorpionboss.mod.gml:306
_hm.pc=((_hm.vars.t < 30))?74:70;
break;
case 75: // bosses/scorpionboss.mod.gml:306
_hm.vars.t = 0;
_hm.pc=71;
break;
case 76: // bosses/scorpionboss.mod.gml:305
_hm.pc = (scrHMTaskFork(_hm, 75)) ? 75 : 68;
break;
case 77: // bosses/scorpionboss.mod.gml:303
{
alrm2 = 140;
scrHMSoundPitch(sndExploGuardianCharge, 1.3);
}
_hm.pc=76;
break;
case 78: // bosses/scorpionboss.mod.gml:236
_hm.pc = (targetvisible) ? 43 : 77;
break;
case 79: // bosses/scorpionboss.mod.gml:235
_hm.pc = (((alrm2 == 0) and (target > (- 1)))) ? 78 : 25;
break;
case 80: // bosses/scorpionboss.mod.gml:174
{
if (((alrm2 > 0) && (target > 0))) {
{
alrm2 -= 1;
}
}
if (instance_exists(Player)) {
target = instance_nearest(x, y, Player);
} else {
target = 0;
}
;
if ((instance_exists(target) && (collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0))) {
targetvisible = 1;
} else {
targetvisible = 0;
}
;
if ((target > 0)) {
{
if (((alrm2 <= 0) || (alrm1 <= 0))) {
{
if ((target.x > x)) {
{
image_xscale = 1;
}
} else {
{
image_xscale = (- 1);
}
}
}
}
}
}
if ((alrm1 > 0)) {
alrm1--;
}
if (((alrm0 > 0) and (dashing == 0))) {
{
alrm0 -= 1;
scrHMMotionAdd(direction, 3);
}
}
if ((dashing <= 0)) {
{
if (((speed / timescale) > 2)) {
speed = (2) * timescale;
}
}
} else {
{
direction = direction2;
if (((target > 0) and (distance_to_object(target) > (50 - (10 * GameCont.loops))))) {
{
if ((distance_to_object(target) > (120 - (30 * GameCont.loops)))) {
scrHMMotionAdd(direction, 0.6);
} else {
scrHMMotionAdd(direction, 0.4);
}
}
}
repeat (4) {
{ var __hm_with28 = scrHMInstances(instance_create((x + random_range((- 16), 16)), ((y + 32) + random_range((- 16), 16)), Dust)), __hm_break30=false;
for (var __hm_index29=0; __hm_index29<array_length(__hm_with28); ++__hm_index29) {
if(instance_exists(__hm_with28[__hm_index29])) with (__hm_with28[__hm_index29]) {
var __hm_other31=scrHMOther(other);
depth = (__hm_other31.depth + 0.1);
}
if(__hm_break30) break;
}}
}
}
}
if ((distance_to_object(Wall) < 46)) {
instance_create(x, y, PortalClear);
}
if ((alrm0 == 0)) {
{
if ((target > 0)) {
direction = ((point_direction(x, y, target.x, target.y) + 180) + random_range((- 60), 60));
} else {
direction = random(360);
}
alrm0 += 25;
}
}
}
_hm.pc=79;
break;
case 82: // bosses/scorpionboss.mod.gml:156
_hm.vars.__hm_repeat32--; _hm.pc=81;
break;
case 83: // bosses/scorpionboss.mod.gml:171
{
;
}
_hm.pc=82;
break;
case 84: // bosses/scorpionboss.mod.gml:171
_hm.wait_ticks=max(0,1); _hm.pc=83; return;
break;
case 85: // bosses/scorpionboss.mod.gml:157
{
if (instance_exists(id)) {
{ var __hm_with33 = scrHMInstances(instance_create((x + lengthdir_x((50 + _hm.vars._dis), _hm.vars._ang)), (y + lengthdir_y((50 + _hm.vars._dis), _hm.vars._ang)), PortalClear)), __hm_break35=false;
for (var __hm_index34=0; __hm_index34<array_length(__hm_with33); ++__hm_index34) {
if(instance_exists(__hm_with33[__hm_index34])) with (__hm_with33[__hm_index34]) {
{
image_xscale = 2;
image_yscale = 2;
{ var __hm_with36 = scrHMInstances(instance_create((x + random(120)), (y + random(120)), Dust)), __hm_break38=false;
for (var __hm_index37=0; __hm_index37<array_length(__hm_with36); ++__hm_index37) {
if(instance_exists(__hm_with36[__hm_index37])) with (__hm_with36[__hm_index37]) {
{
image_angle = random(360);
scrHMMotionAdd(_hm.vars._ang, 6);
}
}
if(__hm_break38) break;
}}
repeat (16) { var __hm_with39 = scrHMInstances(instance_create((x + random_range((- 32), 32)), (y + random_range((- 32), 32)), Dust)), __hm_break41=false;
for (var __hm_index40=0; __hm_index40<array_length(__hm_with39); ++__hm_index40) {
if(instance_exists(__hm_with39[__hm_index40])) with (__hm_with39[__hm_index40]) {
{
var __hm_other42=scrHMOther(other);
depth = (__hm_other42.depth + 0.1);
}
}
if(__hm_break41) break;
}}
}
}
if(__hm_break35) break;
}}
}
_hm.vars._dis += _hm.vars._inc;
}
_hm.pc=84;
break;
case 81: // bosses/scorpionboss.mod.gml:156
_hm.pc=(_hm.vars.__hm_repeat32>0)?85:80;
break;
case 86: // bosses/scorpionboss.mod.gml:156
_hm.vars.__hm_repeat32=round(12); _hm.pc=81;
break;
case 87: // bosses/scorpionboss.mod.gml:138
{
scrHMSoundMusic(musBoss1);
if (scrHMModExists("mod", "options", "intropan")) {
{
if ((scrHMModGet("mod", "options", "intropan") == "1")) {
{
if ((UberCont.opt_bossintro == 1)) {
{
scrHMModCall("mod", "bossintros", "boss_trigger", "GRAND SCORPION", global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionintro, mskNone, mskNone, id, 60);
}
} else {
scrHMModCall("mod", "bossintros", "boss_trigger", "", mskNone, mskNone, mskNone, id, 0);
}
}
} else {
if ((UberCont.opt_bossintro == 1)) {
{
scrHMModCall("mod", "bossintros", "boss_trigger", "GRAND SCORPION", global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionintro, mskNone, mskNone, instance_nearest(x, y, Player), 0);
}
}
}
}
}
intro = 1;
alrm2 += 60;
target = instance_nearest(x, y, Player);
_hm.vars._inc = (distance_to_object(target) / 12);
;
_hm.vars._dis = 0;
;
_hm.vars._ang = point_direction(x, y, target.x, target.y);
}
_hm.pc=86;
break;
case 88: // bosses/scorpionboss.mod.gml:137
_hm.pc = (((intro == 0) and (alrm2 > 0))) ? 87 : 80;
break;
case 89: // bosses/scorpionboss.mod.gml:121
{
if ((intro == 0)) {
{
{ var __hm_with43 = scrHMInstances(Player), __hm_break45=false;
for (var __hm_index44=0; __hm_index44<array_length(__hm_with43); ++__hm_index44) {
if(instance_exists(__hm_with43[__hm_index44])) with (__hm_with43[__hm_index44]) {
if ((distance_to_object(Wall) > 32)) {
{
var __hm_other46=scrHMOther(other);
__hm_other46.alrm2 = 1;
var __hm_other47=scrHMOther(other);
__hm_other47.wakeup = 1;
}
}
}
if(__hm_break45) break;
}}
{ var __hm_with48 = scrHMInstances(projectile), __hm_break50=false;
for (var __hm_index49=0; __hm_index49<array_length(__hm_with48); ++__hm_index49) {
if(instance_exists(__hm_with48[__hm_index49])) with (__hm_with48[__hm_index49]) {
if ((distance_to_object((scrHMOther(other))) < 164)) {
{
var __hm_other51=scrHMOther(other);
__hm_other51.alrm2 = 1;
var __hm_other52=scrHMOther(other);
__hm_other52.wakeup = 1;
}
}
}
if(__hm_break50) break;
}}
}
}
}
_hm.pc=88;
break;
case 90: // bosses/scorpionboss.mod.gml:112
{
midpoint -= (max_hp / 4);
}
_hm.pc=89;
break;
case 91: // bosses/scorpionboss.mod.gml:110
{
;
}
_hm.pc=90;
break;
case 92: // bosses/scorpionboss.mod.gml:110
_hm.result=undefined; _hm.done=true; return;
break;
case 93: // bosses/scorpionboss.mod.gml:89
{
for (_hm.vars.i = (- 70); (_hm.vars.i < 70); _hm.vars.i++) {
{ var __hm_with53 = scrHMInstances(instance_create((x + lengthdir_x((32 + random_range((- 30), 30)), (_hm.vars.i + _hm.vars.a))), (y + lengthdir_y((32 + random_range((- 30), 30)), (_hm.vars.i + _hm.vars.a))), DustOLD)), __hm_break55=false;
for (var __hm_index54=0; __hm_index54<array_length(__hm_with53); ++__hm_index54) {
if(instance_exists(__hm_with53[__hm_index54])) with (__hm_with53[__hm_index54]) {
{
scrHMMotionAdd((_hm.vars.i + _hm.vars.a), 20);
set = 0;
time = 0;
image_xscale = random_range(1, 3);
image_yscale = image_xscale;
image_speed = (0) * timescale;
friction = (0.4) * (timescale * timescale);
var __hm_other56=scrHMOther(other);
creator = __hm_other56;
}
}
if(__hm_break55) break;
}}
{ var __hm_with57 = scrHMInstances(instance_create((x + lengthdir_x((32 + random_range((- 30), 30)), (_hm.vars.i + _hm.vars.a))), (y + lengthdir_y((32 + random_range((- 30), 30)), (_hm.vars.i + _hm.vars.a))), Dust)), __hm_break59=false;
for (var __hm_index58=0; __hm_index58<array_length(__hm_with57); ++__hm_index58) {
if(instance_exists(__hm_with57[__hm_index58])) with (__hm_with57[__hm_index58]) {
{
scrHMMotionAdd((_hm.vars.i + _hm.vars.a), 20);
set = 0;
image_xscale = random_range(1, 3);
image_yscale = image_xscale;
image_speed = (0) * timescale;
friction = (0.4) * (timescale * timescale);
var __hm_other60=scrHMOther(other);
creator = __hm_other60;
}
}
if(__hm_break59) break;
}}
}
}
_hm.pc=92;
break;
case 94: // bosses/scorpionboss.mod.gml:88
_hm.wait_ticks=max(0,10); _hm.pc=93; return;
break;
case 95: // bosses/scorpionboss.mod.gml:87
{
alrm2 = max(round((_hm.vars.d / 8)), 16);
}
_hm.pc=94;
break;
case 96: // bosses/scorpionboss.mod.gml:85
_hm.result=undefined; _hm.done=true; return;
break;
case 98: // bosses/scorpionboss.mod.gml:79
_hm.vars.q++; _hm.pc=97;
break;
case 99: // bosses/scorpionboss.mod.gml:83
_hm.wait_ticks=max(0,1); _hm.pc=98; return;
break;
case 100: // bosses/scorpionboss.mod.gml:80
{
if (((_hm.vars.q mod 2) == 1)) {
{
scrHMSoundPitchVolume(sndEliteInspectorStart, 0.8, 0.5);
}
}
}
_hm.pc=99;
break;
case 97: // bosses/scorpionboss.mod.gml:79
_hm.pc=((_hm.vars.q < 10))?100:96;
break;
case 101: // bosses/scorpionboss.mod.gml:79
_hm.vars.q = 0;
_hm.pc=97;
break;
case 102: // bosses/scorpionboss.mod.gml:78
_hm.pc = (scrHMTaskFork(_hm, 101)) ? 101 : 95;
break;
case 103: // bosses/scorpionboss.mod.gml:77
_hm.pc = (scrHMTaskFork(_hm, 102)) ? 102 : 90;
break;
case 104: // bosses/scorpionboss.mod.gml:76
{
scrHMSoundPitchVolume(sndScorpionDie, 1.4, 2);
}
_hm.pc=103;
break;
case 105: // bosses/scorpionboss.mod.gml:75
_hm.pc = ((hp < midpoint)) ? 104 : 89;
break;
case 106: // bosses/scorpionboss.mod.gml:71
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
_hm.pc=105;
break;
case 107: // bosses/scorpionboss.mod.gml:115
{
if (((speed / timescale) > (friction / (timescale * timescale)))) {
sprite_index = spr_walk;
} else {
sprite_index = spr_idle;
}
;
}
_hm.pc=89;
break;
case 108: // bosses/scorpionboss.mod.gml:70
_hm.pc = ((nexthurt > current_frame)) ? 106 : 107;
break;
case 109: // bosses/scorpionboss.mod.gml:56
{
{ var __hm_with61 = scrHMInstances(Player), __hm_break63=false;
for (var __hm_index62=0; __hm_index62<array_length(__hm_with61); ++__hm_index62) {
if(instance_exists(__hm_with61[__hm_index62])) with (__hm_with61[__hm_index62]) {
if (((scrHMWeaponType(wep) == 3) and (!scrHMVariableExists((scrHMOther(other)), "boltsticks")))) {
{ var __hm_with64 = scrHMInstances((scrHMOther(other))), __hm_break66=false;
for (var __hm_index65=0; __hm_index65<array_length(__hm_with64); ++__hm_index65) {
if(instance_exists(__hm_with64[__hm_index65])) with (__hm_with64[__hm_index65]) {
{
{ var __hm_with67 = scrHMInstances(instance_create(x, (y + 16), CustomObject)), __hm_break69=false;
for (var __hm_index68=0; __hm_index68<array_length(__hm_with67); ++__hm_index68) {
if(instance_exists(__hm_with67[__hm_index68])) with (__hm_with67[__hm_index68]) {
{
name = "boltsticksfly";
var __hm_other70=scrHMOther(other);
creator = __hm_other70;
on_step = scrHMScriptRef(hm_bosses_scorpionboss_mod_gml_boltstickfly);
}
}
if(__hm_break69) break;
}}
boltsticks = 1;
}
}
if(__hm_break66) break;
}}
}
}
if(__hm_break63) break;
}}
spr_idle = global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossidle;
spr_walk = global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossidle;
spr_hurt = global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbosshurt;
spr_dead = global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossdead;
}
_hm.pc=108;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/scorpionboss.mod.gml:431; step
function hm_bosses_scorpionboss_mod_gml_step() {
{ var __hm_with1 = scrHMMatching(DustOLD, "set", 0), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if (((current_time mod 30) == 1)) {
time += 1;
}
{ var __hm_with4 = scrHMInstances(Player), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
{
var __hm_other7=scrHMOther(other);
x += lengthdir_x(1, __hm_other7.direction);
;
var __hm_other8=scrHMOther(other);
y += lengthdir_y(1, __hm_other8.direction);
;
view_shake[index] = choose(100, (- 100));
}
}
}
if(__hm_break6) break;
}}
if ((random((200 - (time * 3))) < 1)) {
if ((place_meeting(x, y, Floor) and (distance_to_object(Player) > 32))) {
{
{ var __hm_with9 = scrHMInstances(instance_nearest(x, y, Floor)), __hm_break11=false;
for (var __hm_index10=0; __hm_index10<array_length(__hm_with9); ++__hm_index10) {
if(instance_exists(__hm_with9[__hm_index10])) with (__hm_with9[__hm_index10]) {
{
var _hml__x = x;
var _hml__y = y;
if ((object_index != FloorExplo)) {
{
if ((random(2) < 1)) {
_hml__x = (x + 16);
}
if ((random(2) < 1)) {
_hml__y = (y + 16);
}
}
}
repeat (12) { var __hm_with12 = scrHMInstances(instance_create(_hml__x, _hml__y, Dust)), __hm_break14=false;
for (var __hm_index13=0; __hm_index13<array_length(__hm_with12); ++__hm_index13) {
if(instance_exists(__hm_with12[__hm_index13])) with (__hm_with12[__hm_index13]) {
{
scrHMMotionAdd(random_range(80, 100), random(4));
depth = (- 11);
}
}
if(__hm_break14) break;
}}
instance_create(_hml__x, _hml__y, Wall);
scrHMSoundPlay(sndWallBreak);
}
}
if(__hm_break11) break;
}}
}
}
}
if (place_meeting(x, y, Wall)) {
instance_destroy();
}
}
}
if(__hm_break3) break;
}}
{ var __hm_with15 = scrHMMatching(DustOLD, "set", 1), __hm_break17=false;
for (var __hm_index16=0; __hm_index16<array_length(__hm_with15); ++__hm_index16) {
if(instance_exists(__hm_with15[__hm_index16])) with (__hm_with15[__hm_index16]) {
{
image_xscale *= 0.9;
image_yscale = image_xscale;
image_alpha = min((image_xscale + 0.5), 1);
if ((image_xscale <= 0)) {
instance_destroy();
} else {
if (place_meeting(x, y, Wall)) {
instance_destroy();
}
}
}
}
if(__hm_break17) break;
}}
{ var __hm_with18 = scrHMInstances(DustOLD), __hm_break20=false;
for (var __hm_index19=0; __hm_index19<array_length(__hm_with18); ++__hm_index19) {
if(instance_exists(__hm_with18[__hm_index19])) with (__hm_with18[__hm_index19]) {
if (((speed / timescale) <= 0)) {
{
scrHMMotionAdd((direction + 180), 20);
if ((scrHMVariableExists(id, "set") and (set == 0))) {
set = 1;
} else {
instance_destroy();
}
}
}
}
if(__hm_break20) break;
}}
}

// Source bosses/scorpionboss.mod.gml:480; scorpionboss_death
function hm_bosses_scorpionboss_mod_gml_scorpionboss_death() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_scorpionboss_mod_gml_scorpionboss_death_resume, id, scrHMOther(other), _args, 3, []);
}
function hm_bosses_scorpionboss_mod_gml_scorpionboss_death_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_scorpionboss_mod_gml_scorpionboss_death");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/scorpionboss.mod.gml:497
{
if (instance_exists(Player)) {
{ var __hm_with1 = scrHMInstances(_hm.vars.fl_), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((scrHMModExists("mod", "options", "bossoutros") and (scrHMModGet("mod", "options", "bossoutros") == "1"))) {
scrHMModCall("mod", "bossintros", "boss_trigger", "", mskNone, mskNone, mskNone, id, 0);
}
}
if(__hm_break3) break;
}}
}
}
_hm.pc=0;
break;
case 2: // bosses/scorpionboss.mod.gml:496
_hm.wait_ticks=max(0,6); _hm.pc=1; return;
break;
case 3: // bosses/scorpionboss.mod.gml:481
{
scrHMSoundPlay(sndBossWin);
scrHMSoundMusic(musBossDead);
scrHMSoundPitchVolume(sndGoldScorpionDead, 0.8, 4);
_hm.vars.xd_ = x;
;
_hm.vars.yd_ = y;
;
_hm.vars.fl_ = instance_nearest(_hm.vars.xd_, _hm.vars.yd_, Floor);
;
repeat (75) {
{ var __hm_with4 = scrHMInstances(instance_create(_hm.vars.xd_, _hm.vars.yd_, EnemyBullet2)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
hitid = [global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossidle, "grand scorpion"];
team = 1;
scrHMMotionAdd(random(360), random_range(2, 6));
image_angle = direction;
}
}
if(__hm_break6) break;
}}
}
}
_hm.pc=2;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/scorpionboss.mod.gml:503; fancyscorpionboss_death
function hm_bosses_scorpionboss_mod_gml_fancyscorpionboss_death() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_scorpionboss_mod_gml_fancyscorpionboss_death_resume, id, scrHMOther(other), _args, 50, []);
}
function hm_bosses_scorpionboss_mod_gml_fancyscorpionboss_death_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_scorpionboss_mod_gml_fancyscorpionboss_death");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/scorpionboss.mod.gml:735
{
;
}
_hm.pc=0;
break;
case 2: // bosses/scorpionboss.mod.gml:735
_hm.result=undefined; _hm.done=true; return;
break;
case 3: // bosses/scorpionboss.mod.gml:683
{
{ var __hm_with1 = scrHMInstances(projectile), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if (scrHMVariableExists(id, "fakeEnemyBullet")) {
{
instance_destroy();
;
}
}
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(CaveSparkle), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
instance_destroy();
}
if(__hm_break6) break;
}}
;
repeat (75) {
{ var __hm_with7 = scrHMInstances(instance_create(_hm.vars.xd_, _hm.vars.yd_, EnemyBullet2)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
hitid = [global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossidle, "grand scorpion"];
fancy = 1;
team = 1;
scrHMMotionAdd(random(360), random_range(2, 6));
;
image_angle = direction;
;
friction = ((- 0.25)) * (timescale * timescale);
;
for (_hm.vars.i = 0; (_hm.vars.i < 4); _hm.vars.i += 1) {
{ var __hm_with10 = scrHMInstances(instance_copy(0)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
speed -= (_hm.vars.i) * timescale;
;
}
}
if(__hm_break12) break;
}}
}
}
}
if(__hm_break9) break;
}}
}
repeat (100) {
{ var __hm_with13 = scrHMInstances(instance_create(_hm.vars.xd_, _hm.vars.yd_, Dust)), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
sprite_index = sprDust;
;
image_index = random(image_number);
;
image_xscale = (2 + random(2));
;
_hm.vars.ixs = image_xscale;
;
image_yscale = image_xscale;
;
image_speed = (0) * timescale;
;
scrHMMotionAdd(random(360), random_range(2, 16));
;
image_angle = direction;
;
friction = (((speed / timescale) * 0.02)) * (timescale * timescale);
;
}
}
if(__hm_break15) break;
}}
}
scrHMSoundPlay(sndBossWin);
_hm.vars.a = GameCont.area;
;
_hm.vars.sa = GameCont.subarea;
;
}
_hm.pc=2;
break;
case 4: // bosses/scorpionboss.mod.gml:680
{
;
}
_hm.pc=3;
break;
case 5: // bosses/scorpionboss.mod.gml:680
_hm.result=undefined; _hm.done=true; return;
break;
case 7: // bosses/scorpionboss.mod.gml:678
{
;
}
_hm.pc=6;
break;
case 8: // bosses/scorpionboss.mod.gml:678
_hm.wait_ticks=max(0,1); _hm.pc=7; return;
break;
case 9: // bosses/scorpionboss.mod.gml:674
{
for (_hm.vars.i = 0; (_hm.vars.i < INPUT_MAX_PLAYERS); _hm.vars.i += 1) view_shake[_hm.vars.i] = _hm.vars.s;
;
_hm.vars.s /= 1.2;
;
}
_hm.pc=8;
break;
case 6: // bosses/scorpionboss.mod.gml:672
_hm.pc=((_hm.vars.s > 1))?9:5;
break;
case 10: // bosses/scorpionboss.mod.gml:670
{
_hm.vars.s = 128;
;
}
_hm.pc=6;
break;
case 11: // bosses/scorpionboss.mod.gml:668
_hm.pc = (scrHMTaskFork(_hm, 10)) ? 10 : 3;
break;
case 13: // bosses/scorpionboss.mod.gml:628
_hm.vars.__hm_repeat16--; _hm.pc=12;
break;
case 14: // bosses/scorpionboss.mod.gml:664
{
;
}
_hm.pc=13;
break;
case 15: // bosses/scorpionboss.mod.gml:664
_hm.wait_ticks=max(0,1); _hm.pc=14; return;
break;
case 16: // bosses/scorpionboss.mod.gml:630
{
_hm.vars.warpspeed += 1;
;
for (_hm.vars.i = 0; (_hm.vars.i < INPUT_MAX_PLAYERS); _hm.vars.i += 1) view_shake[_hm.vars.i] = (3 + _hm.vars.warpspeed);
;
{ var __hm_with17 = scrHMInstances(projectile), __hm_break19=false;
for (var __hm_index18=0; __hm_index18<array_length(__hm_with17); ++__hm_index18) {
if(instance_exists(__hm_with17[__hm_index18])) with (__hm_with17[__hm_index18]) {
{
if (scrHMVariableExists(id, "fakeEnemyBullet")) {
{
speed -= (2) * timescale;
;
if (((- (speed / timescale)) >= point_distance(x, y, xstart, ystart))) {
instance_destroy();
}
}
}
}
}
if(__hm_break19) break;
}}
{ var __hm_with20 = scrHMInstances(CaveSparkle), __hm_break22=false;
for (var __hm_index21=0; __hm_index21<array_length(__hm_with20); ++__hm_index21) {
if(instance_exists(__hm_with20[__hm_index21])) with (__hm_with20[__hm_index21]) {
{
_hm.vars.pdir = point_direction(x, y, xstart, ystart);
;
_hm.vars.pdist = point_distance(x, y, xstart, ystart);
;
x += lengthdir_x(_hm.vars.warpspeed, (direction + 90));
;
y += lengthdir_y(_hm.vars.warpspeed, (direction + 90));
;
scrHMMoveTowardsPoint(xstart, ystart, (1 ^ (_hm.vars.warpspeed * 2)));
;
image_angle = (direction + (_hm.vars.warpspeed * 1.5));
;
image_xscale += (0.1 * (_hm.vars.ixs / 4));
;
image_yscale -= (0.1 * (_hm.vars.ixs / 4));
;
if ((image_xscale <= 0)) {
instance_destroy();
}
}
}
if(__hm_break22) break;
}}
}
_hm.pc=15;
break;
case 12: // bosses/scorpionboss.mod.gml:628
_hm.pc=(_hm.vars.__hm_repeat16>0)?16:11;
break;
case 17: // bosses/scorpionboss.mod.gml:628
_hm.vars.__hm_repeat16=round((0.75 * 30)); _hm.pc=12;
break;
case 18: // bosses/scorpionboss.mod.gml:617
{
;
{ var __hm_with23 = scrHMInstances(CaveSparkle), __hm_break25=false;
for (var __hm_index24=0; __hm_index24<array_length(__hm_with23); ++__hm_index24) {
if(instance_exists(__hm_with23[__hm_index24])) with (__hm_with23[__hm_index24]) {
{
direction += 10;
;
friction = (0) * (timescale * timescale);
;
}
}
if(__hm_break25) break;
}}
_hm.vars.warpspeed = 0;
;
}
_hm.pc=17;
break;
case 19: // bosses/scorpionboss.mod.gml:617
_hm.wait_ticks=max(0,(1.13 * 30)); _hm.pc=18; return;
break;
case 21: // bosses/scorpionboss.mod.gml:591
_hm.vars.__hm_repeat26--; _hm.pc=20;
break;
case 22: // bosses/scorpionboss.mod.gml:593
scrHMTaskWithNext(_hm);
break;
case 23: // bosses/scorpionboss.mod.gml:593
scrHMTaskWithAbort(_hm);
break;
case 24: // bosses/scorpionboss.mod.gml:612
{
;
}
_hm.pc=22;
break;
case 25: // bosses/scorpionboss.mod.gml:612
_hm.result=undefined; _hm.done=true; return;
break;
case 27: // bosses/scorpionboss.mod.gml:610
{
;
}
_hm.pc=26;
break;
case 28: // bosses/scorpionboss.mod.gml:610
_hm.wait_ticks=max(0,1); _hm.pc=27; return;
break;
case 29: // bosses/scorpionboss.mod.gml:609
{
visible = place_meeting(x, y, Floor);
;
}
_hm.pc=28;
break;
case 26: // bosses/scorpionboss.mod.gml:607
_hm.pc=(instance_exists(_hm.scope))?29:25;
break;
case 30: // bosses/scorpionboss.mod.gml:605
_hm.pc = (scrHMTaskFork(_hm, 26)) ? 26 : 22;
break;
case 31: // bosses/scorpionboss.mod.gml:595
{
sprite_index = sprDust;
;
image_index = random(image_number);
;
image_xscale = (2 + random(2));
;
_hm.vars.ixs = image_xscale;
;
image_yscale = image_xscale;
;
image_speed = (0) * timescale;
;
scrHMMotionAdd(random(360), random_range(12, 32));
;
image_angle = direction;
;
friction = (((speed / timescale) * 0.02)) * (timescale * timescale);
;
}
_hm.pc=30;
break;
case 32: // bosses/scorpionboss.mod.gml:593
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(_hm.vars.xd_, _hm.vars.yd_, CaveSparkle)),31,21);
break;
case 20: // bosses/scorpionboss.mod.gml:591
_hm.pc=(_hm.vars.__hm_repeat26>0)?32:19;
break;
case 33: // bosses/scorpionboss.mod.gml:591
_hm.vars.__hm_repeat26=round(100); _hm.pc=20;
break;
case 34: // bosses/scorpionboss.mod.gml:560
{
{ var __hm_with27 = scrHMInstances(Wall), __hm_break29=false;
for (var __hm_index28=0; __hm_index28<array_length(__hm_with27); ++__hm_index28) {
if(instance_exists(__hm_with27[__hm_index28])) with (__hm_with27[__hm_index28]) {
{
if (scrHMPointSeen((x + 8), (y + 8), 0)) {
{
instance_create(x, y, FloorExplo);
;
instance_destroy();
;
}
}
}
}
if(__hm_break29) break;
}}
{ var __hm_with30 = scrHMInstances(projectile), __hm_break32=false;
for (var __hm_index31=0; __hm_index31<array_length(__hm_with30); ++__hm_index31) {
if(instance_exists(__hm_with30[__hm_index31])) with (__hm_with30[__hm_index31]) {
{
if (scrHMVariableExists(id, "fakeEnemyBullet")) {
{
speed = (8) * timescale;
;
}
}
}
}
if(__hm_break32) break;
}}
repeat (500) {
{ var __hm_with33 = scrHMInstances(instance_create(_hm.vars.xd_, _hm.vars.yd_, EnemyBullet2)), __hm_break35=false;
for (var __hm_index34=0; __hm_index34<array_length(__hm_with33); ++__hm_index34) {
if(instance_exists(__hm_with33[__hm_index34])) with (__hm_with33[__hm_index34]) {
{
hitid = [global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionbossidle, "grand scorpion"];
team = 1;
if (instance_exists(Player)) {
team = Player.team;
}
fakeEnemyBullet = 1;
;
scrHMMotionAdd(random(360), random_range(2, 24));
;
image_angle = direction;
;
friction = (((speed / timescale) * 0.01)) * (timescale * timescale);
;
}
}
if(__hm_break35) break;
}}
}
}
_hm.pc=33;
break;
case 35: // bosses/scorpionboss.mod.gml:557
{
;
}
_hm.pc=34;
break;
case 36: // bosses/scorpionboss.mod.gml:557
_hm.result=undefined; _hm.done=true; return;
break;
case 38: // bosses/scorpionboss.mod.gml:555
{
;
}
_hm.pc=37;
break;
case 39: // bosses/scorpionboss.mod.gml:555
_hm.wait_ticks=max(0,1); _hm.pc=38; return;
break;
case 40: // bosses/scorpionboss.mod.gml:551
{
for (_hm.vars.i = 0; (_hm.vars.i < INPUT_MAX_PLAYERS); _hm.vars.i += 1) view_shake[_hm.vars.i] = _hm.vars.s;
;
_hm.vars.s /= 1.1;
;
}
_hm.pc=39;
break;
case 37: // bosses/scorpionboss.mod.gml:549
_hm.pc=((_hm.vars.s > 1))?40:36;
break;
case 41: // bosses/scorpionboss.mod.gml:547
{
_hm.vars.s = 128;
;
}
_hm.pc=37;
break;
case 42: // bosses/scorpionboss.mod.gml:545
_hm.pc = (scrHMTaskFork(_hm, 41)) ? 41 : 34;
break;
case 43: // bosses/scorpionboss.mod.gml:542
{
;
}
_hm.pc=42;
break;
case 44: // bosses/scorpionboss.mod.gml:542
_hm.wait_ticks=max(0,(0.65 * 30)); _hm.pc=43; return;
break;
case 45: // bosses/scorpionboss.mod.gml:522
{
scrHMSoundMusic(musBoss4Silence);
;
scrHMSoundPlay(global.hm_module_vars[$ "mod:bosses/scorpionboss"].scorpionExplode);
;
{ var __hm_with36 = scrHMInstances(instance_create(_hm.vars.xd_, _hm.vars.yd_, CaveSparkle)), __hm_break38=false;
for (var __hm_index37=0; __hm_index37<array_length(__hm_with36); ++__hm_index37) {
if(instance_exists(__hm_with36[__hm_index37])) with (__hm_with36[__hm_index37]) {
{
image_xscale = 32;
;
image_yscale = 4;
;
}
}
if(__hm_break38) break;
}}
{ var __hm_with39 = scrHMInstances(projectile), __hm_break41=false;
for (var __hm_index40=0; __hm_index40<array_length(__hm_with39); ++__hm_index40) {
if(instance_exists(__hm_with39[__hm_index40])) with (__hm_with39[__hm_index40]) {
{
if ((team == 1)) {
{
speed = (0) * timescale;
;
if (instance_exists(Player)) {
team = Player.team;
}
fakeEnemyBullet = 1;
;
}
}
}
}
if(__hm_break41) break;
}}
}
_hm.pc=44;
break;
case 46: // bosses/scorpionboss.mod.gml:520
_hm.pc = ((! instance_exists(Spiral))) ? 45 : 2;
break;
case 47: // bosses/scorpionboss.mod.gml:511
{
;
if (instance_exists(Player)) {
{ var __hm_with42 = scrHMInstances(_hm.vars.fl_), __hm_break44=false;
for (var __hm_index43=0; __hm_index43<array_length(__hm_with42); ++__hm_index43) {
if(instance_exists(__hm_with42[__hm_index43])) with (__hm_with42[__hm_index43]) {
if ((scrHMModExists("mod", "options", "bossoutros") and (scrHMModGet("mod", "options", "bossoutros") == "1"))) {
scrHMModCall("mod", "bossintros", "boss_trigger", "", mskNone, mskNone, mskNone, id, 0);
}
}
if(__hm_break44) break;
}}
}
}
_hm.pc=46;
break;
case 48: // bosses/scorpionboss.mod.gml:511
_hm.wait_ticks=max(0,1); _hm.pc=47; return;
break;
case 49: // bosses/scorpionboss.mod.gml:507
{
_hm.vars.xd_ = x;
;
_hm.vars.yd_ = y;
;
_hm.vars.fl_ = instance_nearest(_hm.vars.xd_, _hm.vars.yd_, Floor);
;
}
_hm.pc=48;
break;
case 50: // bosses/scorpionboss.mod.gml:505
_hm.pc = (scrHMTaskFork(_hm, 49)) ? 49 : 0;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/scorpionboss.mod.gml:747; boltstickfly
function hm_bosses_scorpionboss_mod_gml_boltstickfly() {
if (instance_exists(creator)) {
{
x = creator.x;
y = (creator.y + 16);
{ var __hm_with1 = scrHMInstances(BoltStick), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((target == (scrHMOther(other)).creator)) {
var __hm_other4=scrHMOther(other);
target = __hm_other4;
}
}
if(__hm_break3) break;
}}
}
} else {
instance_destroy();
}
}
