// Source bosses/gatorboss.mod.gml:1; __load
function hm_bosses_gatorboss_mod_gml___load() {
global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbossidle = sprHM_bosses_gatorboss_mod_2;
global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosswalk = sprHM_bosses_gatorboss_mod_3;
global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosshurt = sprHM_bosses_gatorboss_mod_4;
global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbossdead = sprHM_bosses_gatorboss_mod_5;
global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosscharge = sprHM_bosses_gatorboss_mod_6;
global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosschargehurt = sprHM_bosses_gatorboss_mod_7;
global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosspunch = sprHM_bosses_gatorboss_mod_8;
global.hm_module_vars[$ "mod:bosses/gatorboss"].punch = sprHM_bosses_gatorboss_mod_9;
global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorintro = sprHM_bosses_gatorboss_mod_11;
global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorintrofg = sprHM_bosses_gatorboss_mod_12;
global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorintrobg = sprHM_bosses_gatorboss_mod_13;
}

// Source bosses/gatorboss.mod.gml:15; draw
function hm_bosses_gatorboss_mod_gml_draw() {

}

// Source bosses/gatorboss.mod.gml:22; draw_dark
function hm_bosses_gatorboss_mod_gml_draw_dark() {
{ var __hm_with1 = scrHMMatching(CustomEnemy, "name", "gatorboss"), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
draw_set_color(0);
if ((random(5) < 1)) {
draw_circle(x, y, (25 + random(3)), false);
}
}
}
if(__hm_break3) break;
}}
}

// Source bosses/gatorboss.mod.gml:35; gatorboss_create
function hm_bosses_gatorboss_mod_gml_gatorboss_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomEnemy)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "gatorboss";
team = 1;
hitid = [global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbossidle, "super gator"];
spr_idle = global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbossidle;
spr_walk = global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosswalk;
spr_hurt = global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosshurt;
spr_chargehurt = global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosschargehurt;
spr_dead = global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbossdead;
spr_charge = global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosscharge;
spr_fire = global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosspunch;
snd_hurt = scrHMSoundPlay(sndBuffGatorHit);
snd_dead = scrHMSoundPlay(sndBuffGatorDie);
scrHMMaxHealthWrite(id, 200, "=");
scrHMMaxHealthWrite(id, ((max_hp / 2) * instance_number(Player)), "+=");
scrHMMaxHealthWrite(id, ((max_hp / 2) * GameCont.loops), "+=");
hp = max_hp;
direction = random(360);
spr_shadow = shd48;
size = 2;
right = 1;
mask_index = mskBanditBoss;
sprite_index = spr_idle;
image_speed = (0.4) * timescale;
gunangle = random(360);
raddrop = 30;
on_step = scrHMScriptRef(hm_bosses_gatorboss_mod_gml_gatorboss_step);
on_destroy = scrHMScriptRef(hm_bosses_gatorboss_mod_gml_gatorboss_death);
canmelee = 0;
startingx = _hml__x;
startingy = _hml__y;
intro = 0;
time = 120;
target = 0;
targetvisible = 0;
dodgedir = 0;
dodge = 0;
alrm0 = 0;
;
alrm1 = 100;
;
alrm2 = 0;
;
alrm3 = 0;
;
animating = 1;
return id;
;
}
}
if(__hm_break3) break;
}}
}

// Source bosses/gatorboss.mod.gml:83; gatorboss_step
function hm_bosses_gatorboss_mod_gml_gatorboss_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_gatorboss_mod_gml_gatorboss_step_resume, id, scrHMOther(other), _args, 22, []);
}
function hm_bosses_gatorboss_mod_gml_gatorboss_step_resume(_hm) {
if(instance_exists(_hm.scope)) with(_hm.scope) {if(!instance_exists(target)) targetvisible=0;}
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_gatorboss_mod_gml_gatorboss_step");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/gatorboss.mod.gml:298
{
;
scrHMSoundPlay(sndSuperFlakCannon);
if (instance_exists(id)) {
{
{ var __hm_with1 = scrHMInstances(instance_create((_hm.vars._xp + lengthdir_x(10, _hm.vars._ang)), (_hm.vars._yp + lengthdir_y(10, _hm.vars._ang)), CustomProjectile)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
instance_create(x, y, PortalClear);
var __hm_other4=scrHMOther(other);
hitid = __hm_other4.hitid;
damage = 3;
speed = (16) * timescale;
if ((GameCont.loops > 0)) {
speed += ((GameCont.loops * 2)) * timescale;
}
wallbounce = 1;
friction = (0.6) * (timescale * timescale);
sprite_index = global.hm_module_vars[$ "mod:bosses/gatorboss"].punch;
mask_index = mskFlakBullet;
var __hm_other5=scrHMOther(other);
team = __hm_other5.team;
var __hm_other6=scrHMOther(other);
direction = __hm_other6.gunangle;
var __hm_other7=scrHMOther(other);
creator = __hm_other7;
image_angle = direction;
image_speed = (0) * timescale;
image_index = 1;
typ = 1;
if (((direction > 90) and (direction < 270))) {
image_yscale = (- 1);
}
alarm[0] = 0;
hm_fist_timer0=0;hm_fist_timer1=0;
on_step = scrHMScriptRef(hm_bosses_gatorboss_mod_gml_Gatorfist);
on_wall = scrHMScriptRef(hm_bosses_gatorboss_mod_gml_Gatorfist_wall);
on_destroy = scrHMScriptRef(hm_bosses_gatorboss_mod_gml_Gatorfist_destroy);
}
}
if(__hm_break3) break;
}}
}
}
repeat (16) {
if (instance_exists(id)) {
{
{ var __hm_with8 = scrHMInstances(instance_create((x + lengthdir_x(14, gunangle)), (y + lengthdir_y(14, gunangle)), Smoke)), __hm_break10=false;
for (var __hm_index9=0; __hm_index9<array_length(__hm_with8); ++__hm_index9) {
if(instance_exists(__hm_with8[__hm_index9])) with (__hm_with8[__hm_index9]) {
{
var __hm_other11=scrHMOther(other);
scrHMMotionAdd((__hm_other11.gunangle - 180), random(10));
}
}
if(__hm_break10) break;
}}
{ var __hm_with12 = scrHMInstances(instance_create((x + lengthdir_x(14, gunangle)), (y + lengthdir_y(14, gunangle)), Shell)), __hm_break14=false;
for (var __hm_index13=0; __hm_index13<array_length(__hm_with12); ++__hm_index13) {
if(instance_exists(__hm_with12[__hm_index13])) with (__hm_with12[__hm_index13]) {
{
var __hm_other15=scrHMOther(other);
scrHMMotionAdd((__hm_other15.gunangle + random_range((- 45), 45)), random(8));
}
}
if(__hm_break14) break;
}}
}
}
}
}
_hm.pc=0;
break;
case 2: // bosses/gatorboss.mod.gml:298
_hm.wait_ticks=max(0,2); _hm.pc=1; return;
break;
case 3: // bosses/gatorboss.mod.gml:297
_hm.pc = (scrHMTaskFork(_hm, 2)) ? 2 : 0;
break;
case 4: // bosses/gatorboss.mod.gml:282
{
spr_hurt = global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosshurt;
alrm3 = 0;
if ((GameCont.loops > 0)) {
{
alrm3 = choose(min((15 * GameCont.loops), 45), min((15 * GameCont.loops), 45), 0);
scrHMMotionAdd((gunangle + random_range((- 20), 20)), 5);
}
}
alrm1 = choose(50, 100, 100, 120, 120);
;
scrHMSoundPlay(sndSlugger);
;
_hm.vars._dis = 0;
;
_hm.vars._ang = (gunangle + random_range((- 45), 45));
_hm.vars._xp = x;
;
_hm.vars._yp = y;
;
direction = random(360);
;
sprite_index = spr_fire;
;
}
_hm.pc=3;
break;
case 5: // bosses/gatorboss.mod.gml:281
_hm.pc = ((alrm3 >= 50)) ? 4 : 0;
break;
case 6: // bosses/gatorboss.mod.gml:217
{
if (((alrm2 == 2) and (dodge <= 0))) {
{
if (((targetvisible == 1) && (random(6) < 1))) {
{
direction = gunangle;
alrm0 = 100;
}
}
if ((alrm0 > 0)) {
{
alrm0 -= 1;
scrHMMotionAdd(direction, 0.8);
}
}
if ((targetvisible == 0)) {
if ((random(50) < 1)) {
{
direction = random(360);
alrm0 = (25 + random(10));
}
}
}
if ((alrm1 > 0)) {
alrm1--;
}
}
}
if (((((alrm1 == 0) and instance_exists(target)) and (dodge <= 0)) and (alrm3 == 0))) {
{
spr_hurt = global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosschargehurt;
if (targetvisible) {
alrm3 += 1;
} else {
alrm3 += 3;
}
}
}
if ((alrm3 > 0)) {
{
alrm0 = 0;
;
speed = (0) * timescale;
;
alrm3 += (1 + (GameCont.loops / 3));
if ((sprite_index != (spr_charge || spr_chargehurt))) {
sprite_index = spr_charge;
}
if ((random(50) < alrm3)) {
{
_hm.vars.r = random(360);
_hm.vars.a = (16 + (50 / alrm3));
{ var __hm_with16 = scrHMInstances(instance_create((x + lengthdir_x(_hm.vars.a, _hm.vars.r)), (y + lengthdir_y(_hm.vars.a, _hm.vars.r)), CaveSparkle)), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
{
var __hm_other19=scrHMOther(other);
scrHMSoundPitchVolume(sndIncinerator, (0.5 + (__hm_other19.alrm3 / 50)), ((view_width / 4) / distance_to_object(Player)));
var __hm_other20=scrHMOther(other);
scrHMMotionAdd(point_direction(x, y, __hm_other20.x, __hm_other20.y), 1);
image_angle = direction;
sprite_index = choose(sprPortalL1, sprPortalL2, sprPortalL3);
var __hm_other21=scrHMOther(other);
depth = (__hm_other21.depth + choose((- 0.1), 0.1));
}
}
if(__hm_break18) break;
}}
}
}
if (((alrm3 mod 2) == 1)) {
{
repeat (round((alrm3 / 20))) { var __hm_with22 = scrHMInstances(instance_create((x + lengthdir_x(15, (gunangle + 180))), (y + lengthdir_y(15, (gunangle + 180))), EnemyBullet3)), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
{
var __hm_other25=scrHMOther(other);
team = __hm_other25.team;
var __hm_other26=scrHMOther(other);
creator = __hm_other26;
var __hm_other27=scrHMOther(other);
hitid = __hm_other27.hitid;
var __hm_other28=scrHMOther(other);
scrHMMotionAdd((((__hm_other28.gunangle + 180) + random_range((- 4), 4)) + (__hm_other28.alrm3 * ((360 / 50) * 2))), (10 - (__hm_other28.alrm3 / 10)));
}
}
if(__hm_break24) break;
}}
instance_create(x, y, Shell);
}
}
if ((instance_exists(target) and (distance_to_object(target) > 320))) {
{
alrm0 += 160;
instance_create(x, y, PortalClear);
alrm3 = 0;
dodge = 0;
direction = point_direction(x, y, target.x, target.y);
speed += (2) * timescale;
sprite_index = spr_idle;
spr_hurt = global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosshurt;
}
}
}
}
}
_hm.pc=5;
break;
case 8: // bosses/gatorboss.mod.gml:202
_hm.vars.__hm_repeat29--; _hm.pc=7;
break;
case 9: // bosses/gatorboss.mod.gml:208
{
;
}
_hm.pc=8;
break;
case 10: // bosses/gatorboss.mod.gml:208
_hm.wait_ticks=max(0,8); _hm.pc=9; return;
break;
case 11: // bosses/gatorboss.mod.gml:203
{
{ var __hm_with30 = scrHMInstances(instance_create(x, y, PortalClear)), __hm_break32=false;
for (var __hm_index31=0; __hm_index31<array_length(__hm_with30); ++__hm_index31) {
if(instance_exists(__hm_with30[__hm_index31])) with (__hm_with30[__hm_index31]) {
{
image_xscale = _hm.vars.big_;
image_yscale = _hm.vars.big_;
}
}
if(__hm_break32) break;
}}
_hm.vars.big_ += 0.5;
;
}
_hm.pc=10;
break;
case 7: // bosses/gatorboss.mod.gml:202
_hm.pc=(_hm.vars.__hm_repeat29>0)?11:6;
break;
case 12: // bosses/gatorboss.mod.gml:202
_hm.vars.__hm_repeat29=round((4 + (GameCont.loops * 2))); _hm.pc=7;
break;
case 13: // bosses/gatorboss.mod.gml:201
{
_hm.vars.big_ = 1;
;
}
_hm.pc=12;
break;
case 14: // bosses/gatorboss.mod.gml:199
{
;
}
_hm.pc=13;
break;
case 15: // bosses/gatorboss.mod.gml:199
_hm.wait_ticks=max(0,20); _hm.pc=14; return;
break;
case 16: // bosses/gatorboss.mod.gml:197
_hm.pc = (((scrHMModExists("mod", "options", "intropan") and (scrHMModGet("mod", "options", "intropan") == "1")) || (UberCont.opt_bossintro == 1))) ? 15 : 13;
break;
case 17: // bosses/gatorboss.mod.gml:196
_hm.pc = (scrHMTaskFork(_hm, 16)) ? 16 : 6;
break;
case 18: // bosses/gatorboss.mod.gml:194
{
instance_create(x, y, HitWarning);
;
}
_hm.pc=17;
break;
case 19: // bosses/gatorboss.mod.gml:193
_hm.pc = (instance_exists(_hm.scope)) ? 18 : 6;
break;
case 20: // bosses/gatorboss.mod.gml:182
{
alrm2 = 2;
;
scrHMSoundMusic(musBoss1);
if ((scrHMModExists("mod", "options", "intropan") and (scrHMModGet("mod", "options", "intropan") == "1"))) {
{
if ((UberCont.opt_bossintro == 1)) {
{
scrHMModCall("mod", "bossintros", "boss_trigger", "SUPER GATOR", mskNone, global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorintro, global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorintrofg, id, 0);
}
} else {
scrHMModCall("mod", "bossintros", "boss_trigger", "", mskNone, mskNone, mskNone, id, 0);
}
}
} else {
if ((UberCont.opt_bossintro == 1)) {
{
scrHMModCall("mod", "bossintros", "boss_trigger", "SUPER GATOR", mskNone, global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorintro, global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorintrofg, instance_nearest(x, y, Player), 60);
}
}
}
}
_hm.pc=19;
break;
case 21: // bosses/gatorboss.mod.gml:181
_hm.pc = ((((time <= 0) && (alrm2 == 0)) && (((distance_to_object(HitWarning) < 200) || ((targetvisible == 1) and (distance_to_object(target) < 150))) || (distance_to_object(projectile) < 75)))) ? 20 : 6;
break;
case 22: // bosses/gatorboss.mod.gml:85
{
if ((instance_exists(target) && (((alrm2 == 2) and (alrm0 != (- 1))) and targetvisible))) {
{
{ var __hm_with33 = scrHMInstances(Gator), __hm_break35=false;
for (var __hm_index34=0; __hm_index34<array_length(__hm_with33); ++__hm_index34) {
if(instance_exists(__hm_with33[__hm_index34])) with (__hm_with33[__hm_index34]) {
if ((random(5) < 1)) {
var __hm_other36=scrHMOther(other);
scrHMMotionAdd(point_direction(x, y, __hm_other36.target.x, __hm_other36.target.y), 2);
}
}
if(__hm_break35) break;
}}
{ var __hm_with37 = scrHMInstances(BuffGator), __hm_break39=false;
for (var __hm_index38=0; __hm_index38<array_length(__hm_with37); ++__hm_index38) {
if(instance_exists(__hm_with37[__hm_index38])) with (__hm_with37[__hm_index38]) {
if ((random(5) < 1)) {
var __hm_other40=scrHMOther(other);
scrHMMotionAdd(point_direction(x, y, __hm_other40.target.x, __hm_other40.target.y), 2);
}
}
if(__hm_break39) break;
}}
}
}
if ((random(15) < 1)) {
instance_create((x + random_range((- 8), 8)), (y + random_range((- 8), 8)), LaserBrain);
}
if ((nexthurt > current_frame)) {
{
if ((sprite_index != ((spr_hurt || spr_charge) || spr_chargehurt))) {
{
image_index = 0;
;
sprite_index = spr_hurt;
;
scrHMSoundPlay(snd_hurt);
}
} else {
if ((sprite_index == spr_charge)) {
{
image_index = 0;
;
sprite_index = spr_chargehurt;
;
scrHMSoundPlay(snd_hurt);
}
}
}
}
} else {
{
if ((((speed / timescale) > (friction / (timescale * timescale))) and (sprite_index == spr_idle))) {
sprite_index = spr_walk;
}
}
}
if (((image_index + (image_speed / timescale)) >= image_number)) {
{
if ((sprite_index != (spr_charge || spr_chargehurt))) {
{
if (((speed / timescale) > (friction / (timescale * timescale)))) {
sprite_index = spr_walk;
} else {
sprite_index = spr_idle;
}
;
image_index = 0;
;
}
} else {
if ((sprite_index == spr_charge)) {
{
image_index = 4;
;
}
}
}
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
if (instance_exists(target)) {
{
if (targetvisible) {
{
_hm.vars.p = instance_nearest(x, y, Player);
;
gunangle = point_direction(x, y, _hm.vars.p.x, _hm.vars.p.y);
if ((target.x > x)) {
right = 1;
} else {
right = (- 1);
}
}
}
image_xscale = right;
}
}
if ((sprite_index == spr_fire)) {
speed = (0) * timescale;
}
if ((dodge <= 5)) {
{
if (((instance_nearest((x - 16), (y - 16), Floor)).traction == 0.45)) {
{
if (((speed / timescale) > 2)) {
speed = (2) * timescale;
}
}
} else {
{
if (((speed / timescale) > 4)) {
speed = (4) * timescale;
}
if (((direction < 45) || (direction >= 315))) {
direction = 0;
} else {
if (((direction >= 45) and (direction < 135))) {
direction = 90;
} else {
if (((direction >= 135) and (direction < 225))) {
direction = 180;
} else {
if (((direction >= 225) and (direction < 315))) {
direction = 270;
}
}
}
}
}
}
}
} else {
{
direction = dodgedir;
if (((speed / timescale) > 6)) {
speed = (6) * timescale;
}
instance_create(x, y, Dust);
;
}
}
if ((dodge > 0)) {
dodge--;
} else {
{ var __hm_with41 = scrHMMatchingNE(projectile, "team", team), __hm_break43=false;
for (var __hm_index42=0; __hm_index42<array_length(__hm_with41); ++__hm_index42) {
if(instance_exists(__hm_with41[__hm_index42])) with (__hm_with41[__hm_index42]) {
if ((place_meeting((x + lengthdir_x(64, direction)), (y + lengthdir_y(64, direction)), (scrHMOther(other))) and (random(3) < 1))) {
{
{ var __hm_with44 = scrHMInstances((scrHMOther(other))), __hm_break46=false;
for (var __hm_index45=0; __hm_index45<array_length(__hm_with44); ++__hm_index45) {
if(instance_exists(__hm_with44[__hm_index45])) with (__hm_with44[__hm_index45]) {
{
var __hm_other47=scrHMOther(other);
dodgedir = (__hm_other47.direction + choose(90, (- 90)));
if ((dodge < 5)) {
dodge = 8;
} else {
dodge += 4;
}
var __hm_other48=scrHMOther(other);
scrHMMotionAdd(dodgedir, ((__hm_other48.speed / timescale) / 2));
}
}
if(__hm_break46) break;
}}
}
}
}
if(__hm_break43) break;
}}
}
if ((time > 0)) {
time--;
}
}
_hm.pc=21;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/gatorboss.mod.gml:345; Gatorfist
function hm_bosses_gatorboss_mod_gml_Gatorfist() {
if ((random(2) < 1)) {
{
x += lengthdir_x(2, (direction + 90));
y += lengthdir_y(2, (direction + 90));
}
}
if ((random(2) < 1)) {
{
x += lengthdir_x(2, (direction - 90));
y += lengthdir_y(2, (direction - 90));
}
}
image_angle = direction;
hm_fist_timer0 += 1;
hm_fist_timer1 += 1;
if (((hm_fist_timer0 mod 2) < 1)) {
{
hm_bosses_gatorboss_mod_gml_gatorexplosion(x, y, team);
{ var __hm_with1 = scrHMInstances(instance_create((x + (hspeed / timescale)), (y + (vspeed / timescale)), PortalClear)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
image_xscale *= 0.5;
image_yscale = image_xscale;
}
}
if(__hm_break3) break;
}}
}
}
if (((speed / timescale) <= 0)) {
instance_destroy();
} else {
if ((hm_fist_timer1 > 300)) {
instance_destroy();
}
}
}

// Source bosses/gatorboss.mod.gml:369; Gatorfist_wall
function hm_bosses_gatorboss_mod_gml_Gatorfist_wall() {scrHMGatorFistWall();}

// Source bosses/gatorboss.mod.gml:374; Gatorfist_destroy
function hm_bosses_gatorboss_mod_gml_Gatorfist_destroy() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_gatorboss_mod_gml_Gatorfist_destroy_resume, id, scrHMOther(other), _args, 3, []);
}
function hm_bosses_gatorboss_mod_gml_Gatorfist_destroy_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_gatorboss_mod_gml_Gatorfist_destroy");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/gatorboss.mod.gml:377
{
repeat (14) { var __hm_with1 = scrHMInstances(instance_create(x, y, EnemyBullet3)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
hitid = [global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbossidle, "super gator"];
scrHMMotionAdd(random(360), random_range(6, 10));
typ = 1;
var __hm_other4=scrHMOther(other);
team = __hm_other4.team;
damage = 1;
wallbounce = 3;
}
}
if(__hm_break3) break;
}}
}
_hm.pc=0;
break;
case 2: // bosses/gatorboss.mod.gml:377
_hm.pc = (scrHMTaskFork(_hm, 1)) ? 1 : 0;
break;
case 3: // bosses/gatorboss.mod.gml:375
{
scrHMSoundPlay(sndFlakExplode);
scrHMModCall("mod", "enemies", "scrPickups", 50);
}
_hm.pc=2;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/gatorboss.mod.gml:388; gatorexplosion
function hm_bosses_gatorboss_mod_gml_gatorexplosion() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_gatorboss_mod_gml_gatorexplosion_resume, id, scrHMOther(other), _args, 3, ["_x", "_y", "_t"]);
}
function hm_bosses_gatorboss_mod_gml_gatorexplosion_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_gatorboss_mod_gml_gatorexplosion");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/gatorboss.mod.gml:390
{
;
{ var __hm_with1 = scrHMInstances(instance_create(_hm.vars._x, _hm.vars._y, SmallExplosion)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
team = _hm.vars._t;
hitid = [global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbossidle, "super gator"];
image_angle = random(360);
}
}
if(__hm_break3) break;
}}
scrHMSoundPlay(sndExplosionS);
}
_hm.pc=0;
break;
case 2: // bosses/gatorboss.mod.gml:390
_hm.wait_ticks=max(0,10); _hm.pc=1; return;
break;
case 3: // bosses/gatorboss.mod.gml:389
_hm.pc = (scrHMTaskFork(_hm, 2)) ? 2 : 0;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/gatorboss.mod.gml:398; gatorboss_death
function hm_bosses_gatorboss_mod_gml_gatorboss_death() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_gatorboss_mod_gml_gatorboss_death_resume, id, scrHMOther(other), _args, 3, []);
}
function hm_bosses_gatorboss_mod_gml_gatorboss_death_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_gatorboss_mod_gml_gatorboss_death");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/gatorboss.mod.gml:406
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
case 2: // bosses/gatorboss.mod.gml:405
_hm.wait_ticks=max(0,14); _hm.pc=1; return;
break;
case 3: // bosses/gatorboss.mod.gml:399
{
scrHMSoundPitchVolume(sndBuffGatorDie, 0.5, 4);
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
default: throw "Hardmode invalid continuation PC";
}}
}
}

