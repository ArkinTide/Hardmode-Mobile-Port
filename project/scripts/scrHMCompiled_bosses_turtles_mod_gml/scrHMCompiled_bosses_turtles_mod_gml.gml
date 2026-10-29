// Source bosses/turtles.mod.gml:1; __load
function hm_bosses_turtles_mod_gml___load() {
global.hm_module_vars[$ "mod:bosses/turtles"].turtlewalk = sprHM_bosses_turtles_mod_2;
global.hm_module_vars[$ "mod:bosses/turtles"].turtlesintrobg = sprHM_bosses_turtles_mod_3;
global.hm_module_vars[$ "mod:bosses/turtles"].turtlesintro = sprHM_bosses_turtles_mod_5;
global.hm_module_vars[$ "mod:bosses/turtles"].turtlesintrofg = sprHM_bosses_turtles_mod_7;
global.hm_module_vars[$ "mod:bosses/turtles"].seenturtles = 0;
}

// Source bosses/turtles.mod.gml:10; game_start
function hm_bosses_turtles_mod_gml_game_start() {
global.hm_module_vars[$ "mod:bosses/turtles"].seenturtles = 0;
}

// Source bosses/turtles.mod.gml:13; turtle1_create
function hm_bosses_turtles_mod_gml_turtle1_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomEnemy)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
on_step = scrHMScriptRef(hm_bosses_turtles_mod_gml_turtle_step);
on_destroy = scrHMScriptRef(hm_bosses_turtles_mod_gml_turtle_dead);
name = "turtle1";
team = 1;
hitid = [sprTurtleIdle, "leonardo"];
spr_idle = sprTurtleIdle;
spr_walk = global.hm_module_vars[$ "mod:bosses/turtles"].turtlewalk;
spr_hurt = sprTurtleHurt;
spr_dead = sprTurtleDead;
snd_hurt = sndTurtleHurt;
snd_dead = sndTurtleDead2;
scrHMMaxHealthWrite(id, 30, "=");
scrHMMaxHealthWrite(id, ((max_hp / 2) * instance_number(Player)), "+=");
scrHMMaxHealthWrite(id, (GameCont.loops + 1), "*=");
hp = max_hp;
direction = random(360);
spr_shadow = shd24;
size = 1;
mask_index = mskRat;
canmelee = 1;
gunangle1 = 45;
gunangle2 = (gunangle1 + 90);
meleedamage = 1;
target = 0;
targetvisible = 0;
alrm3 = 0;
alrm1 = 0;
alrm2 = 0;
alrm0 = 0;
raddrop = 20;
return id;
;
}
}
if(__hm_break3) break;
}}
}

// Source bosses/turtles.mod.gml:47; turtle2_create
function hm_bosses_turtles_mod_gml_turtle2_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomEnemy)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
on_step = scrHMScriptRef(hm_bosses_turtles_mod_gml_turtle_step);
on_destroy = scrHMScriptRef(hm_bosses_turtles_mod_gml_turtle_dead);
name = "turtle2";
team = 1;
hitid = [sprTurtleIdle, "Raphael"];
spr_idle = sprTurtleIdle;
spr_walk = global.hm_module_vars[$ "mod:bosses/turtles"].turtlewalk;
spr_hurt = sprTurtleHurt;
spr_dead = sprTurtleDead;
snd_hurt = sndTurtleHurt;
snd_dead = sndTurtleDead1;
scrHMMaxHealthWrite(id, 30, "=");
scrHMMaxHealthWrite(id, ((max_hp / 2) * instance_number(Player)), "+=");
scrHMMaxHealthWrite(id, (GameCont.loops + 1), "*=");
hp = max_hp;
direction = random(360);
spr_shadow = shd24;
size = 1;
mask_index = mskRat;
canmelee = 1;
gunangle1 = 45;
gunangle2 = (gunangle1 + 90);
meleedamage = 1;
target = 0;
targetvisible = 0;
alrm3 = 0;
alrm1 = 0;
alrm2 = 0;
alrm0 = 0;
raddrop = 20;
return id;
;
}
}
if(__hm_break3) break;
}}
}

// Source bosses/turtles.mod.gml:81; turtle3_create
function hm_bosses_turtles_mod_gml_turtle3_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomEnemy)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
on_step = scrHMScriptRef(hm_bosses_turtles_mod_gml_turtle_step);
on_destroy = scrHMScriptRef(hm_bosses_turtles_mod_gml_turtle_dead);
name = "turtle3";
team = 1;
hitid = [sprTurtleIdle, "Michelangelo"];
spr_idle = sprTurtleIdle;
spr_walk = global.hm_module_vars[$ "mod:bosses/turtles"].turtlewalk;
spr_hurt = sprTurtleHurt;
spr_dead = sprTurtleDead;
snd_hurt = sndTurtleHurt;
snd_dead = sndTurtleDead3;
scrHMMaxHealthWrite(id, 30, "=");
scrHMMaxHealthWrite(id, ((max_hp / 2) * instance_number(Player)), "+=");
scrHMMaxHealthWrite(id, (GameCont.loops + 1), "*=");
hp = max_hp;
direction = random(360);
spr_shadow = shd24;
size = 1;
mask_index = mskRat;
canmelee = 1;
gunangle1 = 45;
gunangle2 = (gunangle1 + 90);
meleedamage = 1;
target = 0;
targetvisible = 0;
alrm3 = 0;
alrm1 = 0;
alrm2 = 0;
alrm0 = 0;
raddrop = 20;
return id;
;
}
}
if(__hm_break3) break;
}}
}

// Source bosses/turtles.mod.gml:115; turtle4_create
function hm_bosses_turtles_mod_gml_turtle4_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomEnemy)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
on_step = scrHMScriptRef(hm_bosses_turtles_mod_gml_turtle_step);
on_destroy = scrHMScriptRef(hm_bosses_turtles_mod_gml_turtle_dead);
name = "turtle4";
team = 1;
hitid = [sprTurtleIdle, "Donatello"];
spr_idle = sprTurtleIdle;
spr_walk = global.hm_module_vars[$ "mod:bosses/turtles"].turtlewalk;
spr_hurt = sprTurtleHurt;
spr_dead = sprTurtleDead;
snd_hurt = sndTurtleHurt;
snd_dead = sndTurtleDead4;
scrHMMaxHealthWrite(id, 30, "=");
scrHMMaxHealthWrite(id, ((max_hp / 2) * instance_number(Player)), "+=");
scrHMMaxHealthWrite(id, (GameCont.loops + 1), "*=");
hp = max_hp;
direction = random(360);
spr_shadow = shd24;
size = 1;
mask_index = mskRat;
canmelee = 1;
gunangle1 = 45;
meleedamage = 1;
target = 0;
targetvisible = 0;
alrm3 = 0;
alrm1 = 0;
alrm2 = 0;
alrm0 = 0;
raddrop = 20;
return id;
;
}
}
if(__hm_break3) break;
}}
}

// Source bosses/turtles.mod.gml:148; draw_wep_katana
function hm_bosses_turtles_mod_gml_draw_wep_katana() {
if ((alrm1 != (- 1))) {
{
if ((alrm2 <= 0)) {
{
scrHMDrawSpriteExt(sprSword, 0, (x + lengthdir_x(14, gunangle1)), (y + lengthdir_y(14, gunangle1)), 1, 1, (gunangle1 + 180), c_white, 1);
scrHMDrawSpriteExt(sprSword, 0, (x + lengthdir_x(14, gunangle2)), (y + lengthdir_y(14, gunangle2)), 1, 1, (gunangle2 + 180), c_white, 1);
}
}
draw_self();
}
}
if ((alrm1 == (- 1))) {
{
draw_self();
if ((alrm2 <= 0)) {
{
scrHMDrawSpriteExt(sprSword, 0, x, y, 1, 1, gunangle1, c_white, 1);
scrHMDrawSpriteExt(sprSword, 0, x, y, 1, (- 1), gunangle2, c_white, 1);
}
}
}
}
}

// Source bosses/turtles.mod.gml:164; turtle_step
function hm_bosses_turtles_mod_gml_turtle_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_turtles_mod_gml_turtle_step_resume, id, scrHMOther(other), _args, 65, []);
}
function hm_bosses_turtles_mod_gml_turtle_step_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_turtles_mod_gml_turtle_step");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/turtles.mod.gml:386
{
if (instance_exists(id)) {
{
scrHMSoundPlay(sndMeleeFlip);
alrm1 = 0;
gunangle1 = 45;
gunangle2 = (gunangle1 + 90);
}
}
}
_hm.pc=0;
break;
case 2: // bosses/turtles.mod.gml:293
scrHMTaskWithNext(_hm);
break;
case 3: // bosses/turtles.mod.gml:293
scrHMTaskWithAbort(_hm);
break;
case 4: // bosses/turtles.mod.gml:300
_hm.wait_ticks=max(0,10); _hm.pc=2; return;
break;
case 5: // bosses/turtles.mod.gml:294
{
hitid = [sprTurtleIdle, "leonardo"];
damage = 5;
team = 1;
image_angle = _hm.vars.d;
scrHMMotionAdd(_hm.vars.d, 2);
var __hm_other1=scrHMOther(other);
__hm_other1.alrm0 = (25 + random(10));
}
_hm.pc=4;
break;
case 6: // bosses/turtles.mod.gml:293
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(x, y, EnemySlash)),5,1);
break;
case 7: // bosses/turtles.mod.gml:290
{
scrHMMotionAdd(_hm.vars.d, 3);
gunangle2 = (gunangle2 - 225);
scrHMSoundPlay(sndBlackSword);
}
_hm.pc=6;
break;
case 8: // bosses/turtles.mod.gml:289
_hm.pc = (instance_exists(_hm.scope)) ? 7 : 1;
break;
case 9: // bosses/turtles.mod.gml:279
scrHMTaskWithNext(_hm);
break;
case 10: // bosses/turtles.mod.gml:279
scrHMTaskWithAbort(_hm);
break;
case 11: // bosses/turtles.mod.gml:286
_hm.wait_ticks=max(0,10); _hm.pc=9; return;
break;
case 12: // bosses/turtles.mod.gml:280
{
hitid = [sprTurtleIdle, "leonardo"];
damage = 5;
team = 1;
image_angle = _hm.vars.d;
scrHMMotionAdd(_hm.vars.d, 2);
var __hm_other2=scrHMOther(other);
__hm_other2.alrm0 = (25 + random(10));
}
_hm.pc=11;
break;
case 13: // bosses/turtles.mod.gml:279
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(x, y, EnemySlash)),12,8);
break;
case 14: // bosses/turtles.mod.gml:276
{
scrHMMotionAdd(_hm.vars.d, 3);
gunangle1 = (gunangle1 - 255);
scrHMSoundPlay(sndBlackSword);
}
_hm.pc=13;
break;
case 15: // bosses/turtles.mod.gml:275
_hm.pc = (instance_exists(_hm.scope)) ? 14 : 8;
break;
case 16: // bosses/turtles.mod.gml:274
_hm.wait_ticks=max(0,10); _hm.pc=15; return;
break;
case 17: // bosses/turtles.mod.gml:273
{
scrHMSoundPlay(sndSwapSword);
}
_hm.pc=16;
break;
case 18: // bosses/turtles.mod.gml:325
scrHMTaskWithNext(_hm);
break;
case 19: // bosses/turtles.mod.gml:325
scrHMTaskWithAbort(_hm);
break;
case 20: // bosses/turtles.mod.gml:332
_hm.wait_ticks=max(0,10); _hm.pc=18; return;
break;
case 21: // bosses/turtles.mod.gml:326
{
hitid = [sprTurtleIdle, "Raphael"];
damage = 4;
team = 1;
image_angle = _hm.vars.d;
scrHMMotionAdd(_hm.vars.d, 2);
var __hm_other3=scrHMOther(other);
__hm_other3.alrm0 = (25 + random(10));
}
_hm.pc=20;
break;
case 22: // bosses/turtles.mod.gml:325
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(x, y, Shank)),21,1);
break;
case 23: // bosses/turtles.mod.gml:322
{
scrHMMotionAdd(_hm.vars.d, 3);
gunangle2 = (gunangle2 - 225);
scrHMSoundPlay(sndScrewdriver);
}
_hm.pc=22;
break;
case 24: // bosses/turtles.mod.gml:321
_hm.pc = (instance_exists(_hm.scope)) ? 23 : 1;
break;
case 25: // bosses/turtles.mod.gml:311
scrHMTaskWithNext(_hm);
break;
case 26: // bosses/turtles.mod.gml:311
scrHMTaskWithAbort(_hm);
break;
case 27: // bosses/turtles.mod.gml:318
_hm.wait_ticks=max(0,10); _hm.pc=25; return;
break;
case 28: // bosses/turtles.mod.gml:312
{
hitid = [sprTurtleIdle, "Raphael"];
damage = 4;
team = 1;
image_angle = _hm.vars.d;
scrHMMotionAdd(_hm.vars.d, 2);
var __hm_other4=scrHMOther(other);
__hm_other4.alrm0 = (25 + random(10));
}
_hm.pc=27;
break;
case 29: // bosses/turtles.mod.gml:311
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(x, y, Shank)),28,24);
break;
case 30: // bosses/turtles.mod.gml:308
{
scrHMMotionAdd(_hm.vars.d, 3);
gunangle1 = (gunangle1 - 255);
scrHMSoundPlay(sndScrewdriver);
}
_hm.pc=29;
break;
case 31: // bosses/turtles.mod.gml:307
_hm.pc = (instance_exists(_hm.scope)) ? 30 : 24;
break;
case 32: // bosses/turtles.mod.gml:306
_hm.wait_ticks=max(0,10); _hm.pc=31; return;
break;
case 33: // bosses/turtles.mod.gml:305
{
scrHMSoundPlay(sndSwapSword);
}
_hm.pc=32;
break;
case 34: // bosses/turtles.mod.gml:357
scrHMTaskWithNext(_hm);
break;
case 35: // bosses/turtles.mod.gml:357
scrHMTaskWithAbort(_hm);
break;
case 36: // bosses/turtles.mod.gml:364
_hm.wait_ticks=max(0,10); _hm.pc=34; return;
break;
case 37: // bosses/turtles.mod.gml:358
{
hitid = [sprTurtleIdle, "Michelangelo"];
damage = 5;
team = 1;
image_angle = _hm.vars.d;
scrHMMotionAdd(_hm.vars.d, 2);
var __hm_other5=scrHMOther(other);
__hm_other5.alrm0 = (25 + random(10));
}
_hm.pc=36;
break;
case 38: // bosses/turtles.mod.gml:357
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(x, y, EnemySlash)),37,1);
break;
case 39: // bosses/turtles.mod.gml:354
{
scrHMMotionAdd(_hm.vars.d, 3);
gunangle2 = (gunangle2 - 225);
scrHMSoundPlay(sndWrench);
}
_hm.pc=38;
break;
case 40: // bosses/turtles.mod.gml:353
_hm.pc = (instance_exists(_hm.scope)) ? 39 : 1;
break;
case 41: // bosses/turtles.mod.gml:343
scrHMTaskWithNext(_hm);
break;
case 42: // bosses/turtles.mod.gml:343
scrHMTaskWithAbort(_hm);
break;
case 43: // bosses/turtles.mod.gml:350
_hm.wait_ticks=max(0,10); _hm.pc=41; return;
break;
case 44: // bosses/turtles.mod.gml:344
{
hitid = [sprTurtleIdle, "Michelangelo"];
damage = 5;
team = 1;
image_angle = _hm.vars.d;
scrHMMotionAdd(_hm.vars.d, 2);
var __hm_other6=scrHMOther(other);
__hm_other6.alrm0 = (25 + random(10));
}
_hm.pc=43;
break;
case 45: // bosses/turtles.mod.gml:343
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(x, y, EnemySlash)),44,40);
break;
case 46: // bosses/turtles.mod.gml:340
{
scrHMMotionAdd(_hm.vars.d, 3);
gunangle1 = (gunangle1 - 255);
scrHMSoundPlay(sndWrench);
}
_hm.pc=45;
break;
case 47: // bosses/turtles.mod.gml:339
_hm.pc = (instance_exists(_hm.scope)) ? 46 : 40;
break;
case 48: // bosses/turtles.mod.gml:338
_hm.wait_ticks=max(0,10); _hm.pc=47; return;
break;
case 49: // bosses/turtles.mod.gml:337
{
scrHMSoundPlay(sndSwapHammer);
}
_hm.pc=48;
break;
case 50: // bosses/turtles.mod.gml:375
scrHMTaskWithNext(_hm);
break;
case 51: // bosses/turtles.mod.gml:375
scrHMTaskWithAbort(_hm);
break;
case 52: // bosses/turtles.mod.gml:382
_hm.wait_ticks=max(0,15); _hm.pc=50; return;
break;
case 53: // bosses/turtles.mod.gml:376
{
hitid = [sprTurtleIdle, "Donatello"];
damage = 6;
team = 1;
image_angle = _hm.vars.d;
scrHMMotionAdd(_hm.vars.d, 2);
var __hm_other7=scrHMOther(other);
__hm_other7.alrm0 = (25 + random(10));
}
_hm.pc=52;
break;
case 54: // bosses/turtles.mod.gml:375
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(x, y, EnemySlash)),53,1);
break;
case 55: // bosses/turtles.mod.gml:372
{
scrHMMotionAdd(_hm.vars.d, 3);
gunangle1 = (gunangle1 - 255);
scrHMSoundPlay(sndHammer);
}
_hm.pc=54;
break;
case 56: // bosses/turtles.mod.gml:371
_hm.pc = (instance_exists(_hm.scope)) ? 55 : 1;
break;
case 57: // bosses/turtles.mod.gml:370
_hm.wait_ticks=max(0,15); _hm.pc=56; return;
break;
case 58: // bosses/turtles.mod.gml:369
{
scrHMSoundPlay(sndSwapHammer);
}
_hm.pc=57;
break;
case 59: // bosses/turtles.mod.gml:368
_hm.pc = ((name == "turtle4")) ? 58 : 1;
break;
case 60: // bosses/turtles.mod.gml:336
_hm.pc = ((name == "turtle3")) ? 49 : 59;
break;
case 61: // bosses/turtles.mod.gml:304
_hm.pc = ((name == "turtle2")) ? 33 : 60;
break;
case 62: // bosses/turtles.mod.gml:272
_hm.pc = ((name == "turtle1")) ? 17 : 61;
break;
case 63: // bosses/turtles.mod.gml:263
{
alrm1 = (- 1);
alrm3 = 30;
alrm2 = 0;
alrm0 = 0;
if (instance_exists(target)) {
direction = point_direction(x, y, target.x, target.y);
}
_hm.vars.d = direction;
_hm.vars.tx = x;
_hm.vars.ty = y;
}
_hm.pc=62;
break;
case 64: // bosses/turtles.mod.gml:262
_hm.pc = ((alrm1 == 1)) ? 63 : 0;
break;
case 65: // bosses/turtles.mod.gml:165
{
if ((name == "turtle1")) {
on_draw = scrHMScriptRef(hm_bosses_turtles_mod_gml_draw_wep_katana);
} else {
if ((name == "turtle2")) {
on_draw = scrHMScriptRef(hm_bosses_turtles_mod_gml_draw_wep_dagger);
} else {
if ((name == "turtle3")) {
on_draw = scrHMScriptRef(hm_bosses_turtles_mod_gml_draw_wep_chuck);
} else {
if ((name == "turtle4")) {
on_draw = scrHMScriptRef(hm_bosses_turtles_mod_gml_draw_wep_stick);
}
}
}
}
if ((nexthurt > current_frame)) {
{
if ((sprite_index != spr_hurt)) {
image_index = 0;
}
sprite_index = spr_hurt;
if ((alrm3 <= 0)) {
{
alrm1 = 1;
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
}
}
if (instance_exists(Player)) {
target = instance_nearest(x, y, Player);
} else {
target = 0;
}
if ((instance_exists(target) && (! collision_line(x, y, target.x, target.y, Wall, 0, 0)))) {
targetvisible = 1;
} else {
targetvisible = 0;
}
if ((((global.hm_module_vars[$ "mod:bosses/turtles"].seenturtles == 0) and (targetvisible == 1)) and (! instance_exists(Spiral)))) {
{
alrm2 = 100;
direction = point_direction(x, y, target.x, target.y);
if ((scrHMModExists("mod", "options", "intropan") and (scrHMModGet("mod", "options", "intropan") == "1"))) {
{
if ((UberCont.opt_bossintro == 1)) {
{
scrHMModCall("mod", "bossintros", "boss_trigger", "TURTLES", global.hm_module_vars[$ "mod:bosses/turtles"].turtlesintrobg, global.hm_module_vars[$ "mod:bosses/turtles"].turtlesintro, global.hm_module_vars[$ "mod:bosses/turtles"].turtlesintrofg, id, 60);
}
} else {
scrHMModCall("mod", "bossintros", "boss_trigger", "", mskNone, mskNone, mskNone, id, 0);
}
}
} else {
if ((UberCont.opt_bossintro == 1)) {
{
scrHMModCall("mod", "bossintros", "boss_trigger", "TURTLES", global.hm_module_vars[$ "mod:bosses/turtles"].turtlesintrobg, global.hm_module_vars[$ "mod:bosses/turtles"].turtlesintro, global.hm_module_vars[$ "mod:bosses/turtles"].turtlesintrofg, instance_nearest(x, y, Player), 0);
}
}
}
global.hm_module_vars[$ "mod:bosses/turtles"].seenturtles = 1;
scrHMSoundPlay(sndTurtleMelee);
}
}
if ((target > 0)) {
{
if ((targetvisible == 1)) {
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
if ((alrm0 > 0)) {
if ((alrm2 == 0)) {
{
alrm0 -= 1;
scrHMMotionAdd(direction, 0.8);
}
}
}
if (((speed / timescale) > 3)) {
{
speed = (3) * timescale;
}
}
if ((((targetvisible == 0) && (alrm2 == 0)) && (random(10) < 1))) {
{
direction = random(360);
alrm0 = (25 + random(10));
}
}
if ((alrm2 <= 0)) {
if ((random(300) < 1)) {
{
alrm2 = 50;
scrHMSoundPitch(sndFishRollUpg, 1.3);
;
scrHMSoundLoop(sndFishTB);
;
}
}
}
if ((alrm2 > 0)) {
{
alrm2 -= 1;
scrHMMotionSet(direction, 5);
sprite_index = sprTurtleFire;
if (collision_circle(x, y, 12, Wall, false, false)) {
{
direction += 45;
}
}
{ var __hm_with8 = scrHMInstances(instance_create(x, y, FishBoost)), __hm_break10=false;
for (var __hm_index9=0; __hm_index9<array_length(__hm_with8); ++__hm_index9) {
if(instance_exists(__hm_with8[__hm_index9])) with (__hm_with8[__hm_index9]) {
{
depth = 4;
evil = 1;
}
}
if(__hm_break10) break;
}}
}
}
if ((alrm2 == 1)) {
scrHMSoundStop(sndFishTB);
}
if ((alrm3 > 0)) {
alrm3 -= 1;
}
if ((((alrm3 <= 0) && (targetvisible == 1)) && collision_circle(x, y, 50, target, false, false))) {
alrm1 = 1;
}
}
_hm.pc=64;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/turtles.mod.gml:393; draw_wep_dagger
function hm_bosses_turtles_mod_gml_draw_wep_dagger() {
if ((alrm1 != (- 1))) {
{
if ((alrm2 <= 0)) {
{
scrHMDrawSpriteExt(sprScrewDriver, 0, (x + lengthdir_x(14, gunangle1)), (y + lengthdir_y(14, gunangle1)), 1, 1, (gunangle1 + 180), c_white, 1);
scrHMDrawSpriteExt(sprScrewDriver, 0, (x + lengthdir_x(14, gunangle2)), (y + lengthdir_y(14, gunangle2)), 1, 1, (gunangle2 + 180), c_white, 1);
}
}
draw_self();
}
}
if ((alrm1 == (- 1))) {
{
draw_self();
if ((alrm2 <= 0)) {
{
scrHMDrawSpriteExt(sprScrewDriver, 0, x, y, 1, 1, gunangle1, c_white, 1);
scrHMDrawSpriteExt(sprScrewDriver, 0, x, y, 1, (- 1), gunangle2, c_white, 1);
}
}
}
}
}

// Source bosses/turtles.mod.gml:410; draw_wep_chuck
function hm_bosses_turtles_mod_gml_draw_wep_chuck() {
if ((alrm1 != (- 1))) {
{
if ((alrm2 <= 0)) {
{
scrHMDrawSpriteExt(sprWrench, 0, (x + lengthdir_x(14, gunangle1)), (y + lengthdir_y(14, gunangle1)), 1, 1, (gunangle1 + 180), c_white, 1);
scrHMDrawSpriteExt(sprWrench, 0, (x + lengthdir_x(14, gunangle2)), (y + lengthdir_y(14, gunangle2)), 1, 1, (gunangle2 + 180), c_white, 1);
}
}
draw_self();
}
}
if ((alrm1 == (- 1))) {
{
draw_self();
if ((alrm2 <= 0)) {
{
scrHMDrawSpriteExt(sprWrench, 0, x, y, 1, 1, gunangle1, c_white, 1);
scrHMDrawSpriteExt(sprWrench, 0, x, y, 1, (- 1), gunangle2, c_white, 1);
}
}
}
}
}

// Source bosses/turtles.mod.gml:427; draw_wep_stick
function hm_bosses_turtles_mod_gml_draw_wep_stick() {
if ((alrm1 != (- 1))) {
{
if ((alrm2 <= 0)) {
{
scrHMDrawSpriteExt(sprHammer, 0, (x + lengthdir_x(14, gunangle1)), (y + lengthdir_y(14, gunangle1)), 1, 1, (gunangle1 + 180), c_white, 1);
}
}
draw_self();
}
}
if ((alrm1 == (- 1))) {
{
draw_self();
if ((alrm2 <= 0)) {
{
scrHMDrawSpriteExt(sprHammer, 0, x, y, 1, 1, gunangle1, c_white, 1);
}
}
}
}
}

// Source bosses/turtles.mod.gml:440; turtle_dead
function hm_bosses_turtles_mod_gml_turtle_dead() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_turtles_mod_gml_turtle_dead_resume, id, scrHMOther(other), _args, 5, []);
}
function hm_bosses_turtles_mod_gml_turtle_dead_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_turtles_mod_gml_turtle_dead");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/turtles.mod.gml:449
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
scrHMSoundStop(sndFishTB);
}
_hm.pc=0;
break;
case 2: // bosses/turtles.mod.gml:448
_hm.wait_ticks=max(0,14); _hm.pc=1; return;
break;
case 3: // bosses/turtles.mod.gml:443
{
scrHMSoundPlay(sndBossWin);
scrHMSoundMusic(musBossDead);
_hm.vars.xd_ = x;
;
_hm.vars.yd_ = y;
;
_hm.vars.fl_ = instance_nearest(_hm.vars.xd_, _hm.vars.yd_, Floor);
;
}
_hm.pc=2;
break;
case 4: // bosses/turtles.mod.gml:442
_hm.pc = (((instance_number(CustomEnemy) <= 1) and instance_exists(Player))) ? 3 : 0;
break;
case 5: // bosses/turtles.mod.gml:441
{
scrHMSoundStop(sndFishTB);
}
_hm.pc=4;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

