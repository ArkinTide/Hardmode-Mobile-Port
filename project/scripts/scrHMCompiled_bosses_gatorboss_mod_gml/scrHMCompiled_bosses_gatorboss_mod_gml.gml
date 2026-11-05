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



// Source bosses/gatorboss.mod.gml:0; gatorboss_create (native content 1.1.0)
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
snd_hurt = sndBuffGatorHit;
snd_dead = sndBuffGatorDie;
if ((scrHMVariableExists(GameCont, "hm_extra_pending") && GameCont.hm_extra_pending)) {
hm_maxhealth_init = false;
}
scrHMMaxHealthWrite(id, 120, "=");
hp = max_hp;
scrHMBossHealth1103();
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

// Source bosses/gatorboss.mod.gml:0; gatorboss_step (native content 1.1.0)
function hm_bosses_gatorboss_mod_gml_gatorboss_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_gatorboss_mod_gml_gatorboss_step_resume, id, scrHMOther(other), _args, 29, []);
}
function hm_bosses_gatorboss_mod_gml_gatorboss_step_resume(_hm) {
if(instance_exists(_hm.scope)) with(_hm.scope) {if(!instance_exists(target)) targetvisible=0;}
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_gatorboss_mod_gml_gatorboss_step");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/gatorboss.mod.gml:309
{
;
if (instance_exists(_hm.vars.hm_gator_owner)) {
{ var __hm_with1 = scrHMInstances(_hm.vars.hm_gator_owner), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
scrHMSoundPlay(sndSuperFlakCannon);
_hm.vars.hm_fist_team = team;
_hm.vars.hm_fist_hitid = hitid;
_hm.vars.hm_fist_angle = gunangle;
;
_hm.vars.hm_fist_loops = hm_arkintide_mod_gml_hm_attack_loops();
;
{ var __hm_with4 = scrHMInstances(instance_create((_hm.vars._xp + lengthdir_x(10, _hm.vars._ang)), (_hm.vars._yp + lengthdir_y(10, _hm.vars._ang)), CustomProjectile)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
instance_create(x, y, PortalClear);
hitid = _hm.vars.hm_fist_hitid;
damage = 3;
speed = (16) * timescale;
if ((_hm.vars.hm_fist_loops > 0)) {
speed += ((_hm.vars.hm_fist_loops * 2)) * timescale;
}
wallbounce = 1;
friction = (0.6) * (timescale * timescale);
sprite_index = global.hm_module_vars[$ "mod:bosses/gatorboss"].punch;
mask_index = mskFlakBullet;
team = _hm.vars.hm_fist_team;
direction = _hm.vars.hm_fist_angle;
creator = _hm.vars.hm_gator_owner;
image_angle = direction;
image_speed = (0) * timescale;
image_index = 1;
typ = 1;
if (((direction > 90) and (direction < 270))) {
image_yscale = (- 1);
}
alarm[0] = 0;
on_step = scrHMScriptRef(hm_bosses_gatorboss_mod_gml_Gatorfist);
on_wall = scrHMScriptRef(hm_bosses_gatorboss_mod_gml_Gatorfist_wall);
on_destroy = scrHMScriptRef(hm_bosses_gatorboss_mod_gml_Gatorfist_destroy);
}
}
if(__hm_break6) break;
}}
}
}
if(__hm_break3) break;
}}
}
repeat (16) {
if (instance_exists(_hm.vars.hm_gator_owner)) {
{ var __hm_with7 = scrHMInstances(_hm.vars.hm_gator_owner), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
{ var __hm_with10 = scrHMInstances(instance_create((x + lengthdir_x(14, gunangle)), (y + lengthdir_y(14, gunangle)), Smoke)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
scrHMMotionAdd((_hm.vars.hm_fist_angle - 180), random(10));
}
}
if(__hm_break12) break;
}}
{ var __hm_with13 = scrHMInstances(instance_create((x + lengthdir_x(14, gunangle)), (y + lengthdir_y(14, gunangle)), Shell)), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
scrHMMotionAdd((_hm.vars.hm_fist_angle + random_range((- 45), 45)), random(8));
}
}
if(__hm_break15) break;
}}
}
}
if(__hm_break9) break;
}}
}
}
}
_hm.pc=0;
break;
case 2: // bosses/gatorboss.mod.gml:309
_hm.wait_ticks=max(0,2); _hm.pc=1; return;
break;
case 3: // bosses/gatorboss.mod.gml:308
_hm.pc = (scrHMTaskFork(_hm, 2)) ? 2 : 0;
break;
case 4: // bosses/gatorboss.mod.gml:293
{
spr_hurt = global.hm_module_vars[$ "mod:bosses/gatorboss"].gatorbosshurt;
alrm3 = 0;
if ((hm_arkintide_mod_gml_hm_attack_loops() > 0)) {
{
alrm3 = choose(min((15 * hm_arkintide_mod_gml_hm_attack_loops()), 45), min((15 * hm_arkintide_mod_gml_hm_attack_loops()), 45), 0);
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
case 5: // bosses/gatorboss.mod.gml:292
_hm.pc = ((alrm3 >= 50)) ? 4 : 0;
break;
case 6: // bosses/gatorboss.mod.gml:224
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
alrm3 += (1 + (hm_arkintide_mod_gml_hm_attack_loops() / 3));
if ((sprite_index != (spr_charge || spr_chargehurt))) {
sprite_index = spr_charge;
}
if ((random(50) < alrm3)) {
{
_hm.vars.r = random(360);
_hm.vars.a = (16 + (50 / alrm3));
_hm.vars.hm_gator_x = x;
_hm.vars.hm_gator_y = y;
_hm.vars.hm_gator_depth = depth;
_hm.vars.hm_gator_charge = alrm3;
;
{ var __hm_with16 = scrHMInstances(instance_create((_hm.vars.hm_gator_x + lengthdir_x(_hm.vars.a, _hm.vars.r)), (_hm.vars.hm_gator_y + lengthdir_y(_hm.vars.a, _hm.vars.r)), CaveSparkle)), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
{
scrHMSoundPitchVolume(sndIncinerator, (0.5 + (_hm.vars.hm_gator_charge / 50)), min(1, ((view_width / 4) / max(1, distance_to_object(Player)))));
scrHMMotionAdd(point_direction(x, y, _hm.vars.hm_gator_x, _hm.vars.hm_gator_y), 1);
image_angle = direction;
sprite_index = choose(sprPortalL1, sprPortalL2, sprPortalL3);
depth = (_hm.vars.hm_gator_depth + choose((- 0.1), 0.1));
}
}
if(__hm_break18) break;
}}
}
}
if (((alrm3 mod 2) == 1)) {
{
_hm.vars.hm_gator_x = x;
_hm.vars.hm_gator_y = y;
_hm.vars.hm_gator_charge = alrm3;
;
_hm.vars.hm_gator_angle = gunangle;
_hm.vars.hm_gator_team = team;
_hm.vars.hm_gator_hitid = hitid;
;
repeat (round((_hm.vars.hm_gator_charge / 20))) { var __hm_with19 = scrHMInstances(instance_create((_hm.vars.hm_gator_x + lengthdir_x(15, (_hm.vars.hm_gator_angle + 180))), (_hm.vars.hm_gator_y + lengthdir_y(15, (_hm.vars.hm_gator_angle + 180))), EnemyBullet3)), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
{
team = _hm.vars.hm_gator_team;
creator = _hm.vars.hm_gator_owner;
hitid = _hm.vars.hm_gator_hitid;
scrHMMotionAdd((((_hm.vars.hm_gator_angle + 180) + random_range((- 4), 4)) + (_hm.vars.hm_gator_charge * ((360 / 50) * 2))), (10 - (_hm.vars.hm_gator_charge / 10)));
}
}
if(__hm_break21) break;
}}
instance_create(x, y, Shell);
}
}
if ((instance_exists(target) && (distance_to_object(target) > 320))) {
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
case 8: // bosses/gatorboss.mod.gml:208
_hm.vars.__hm_repeat22--; _hm.pc=7;
break;
case 9: // bosses/gatorboss.mod.gml:215
{
;
}
_hm.pc=8;
break;
case 10: // bosses/gatorboss.mod.gml:215
_hm.wait_ticks=max(0,8); _hm.pc=9; return;
break;
case 11: // bosses/gatorboss.mod.gml:210
{
{ var __hm_with23 = scrHMInstances(instance_create(_hm.vars.hm_gator_owner.x, _hm.vars.hm_gator_owner.y, PortalClear)), __hm_break25=false;
for (var __hm_index24=0; __hm_index24<array_length(__hm_with23); ++__hm_index24) {
if(instance_exists(__hm_with23[__hm_index24])) with (__hm_with23[__hm_index24]) {
{
image_xscale = _hm.vars.big_;
image_yscale = _hm.vars.big_;
}
}
if(__hm_break25) break;
}}
_hm.vars.big_ += 0.5;
;
}
_hm.pc=10;
break;
case 12: // bosses/gatorboss.mod.gml:209
_hm.pc=6;
break;
case 13: // bosses/gatorboss.mod.gml:209
_hm.pc = ((! instance_exists(_hm.vars.hm_gator_owner))) ? 12 : 11;
break;
case 7: // bosses/gatorboss.mod.gml:208
_hm.pc=(_hm.vars.__hm_repeat22>0)?13:6;
break;
case 14: // bosses/gatorboss.mod.gml:208
_hm.vars.__hm_repeat22=round((4 + (hm_arkintide_mod_gml_hm_attack_loops() * 2))); _hm.pc=7;
break;
case 15: // bosses/gatorboss.mod.gml:207
{
_hm.vars.big_ = 1;
;
}
_hm.pc=14;
break;
case 16: // bosses/gatorboss.mod.gml:205
{
;
}
_hm.pc=15;
break;
case 17: // bosses/gatorboss.mod.gml:205
_hm.wait_ticks=max(0,20); _hm.pc=16; return;
break;
case 18: // bosses/gatorboss.mod.gml:203
_hm.pc = (((scrHMModExists("mod", "options", "intropan") and (scrHMModGet("mod", "options", "intropan") == "1")) || (UberCont.opt_bossintro == 1))) ? 17 : 15;
break;
case 19: // bosses/gatorboss.mod.gml:202
_hm.pc = (scrHMTaskFork(_hm, 18)) ? 18 : 6;
break;
case 20: // bosses/gatorboss.mod.gml:200
{
instance_create(x, y, HitWarning);
;
}
_hm.pc=19;
break;
case 21: // bosses/gatorboss.mod.gml:199
_hm.pc = (instance_exists(_hm.scope)) ? 20 : 6;
break;
case 22: // bosses/gatorboss.mod.gml:188
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
_hm.pc=21;
break;
case 23: // bosses/gatorboss.mod.gml:187
_hm.pc = (((((! (scrHMVariableExists(_hm.scope, "hm_extra") && hm_extra)) && (time <= 0)) && (alrm2 == 0)) && (((distance_to_object(HitWarning) < 200) || ((targetvisible == 1) and (distance_to_object(target) < 150))) || (distance_to_object(projectile) < 75)))) ? 22 : 6;
break;
case 24: // bosses/gatorboss.mod.gml:90
{
if ((((instance_exists(target) && (alrm2 == 2)) and (alrm0 != (- 1))) and targetvisible)) {
{
{ var __hm_with26 = scrHMInstances(Gator), __hm_break28=false;
for (var __hm_index27=0; __hm_index27<array_length(__hm_with26); ++__hm_index27) {
if(instance_exists(__hm_with26[__hm_index27])) with (__hm_with26[__hm_index27]) {
if ((random(5) < 1)) {
var __hm_other29=scrHMOther(other);
scrHMMotionAdd(point_direction(x, y, __hm_other29.target.x, __hm_other29.target.y), 2);
}
}
if(__hm_break28) break;
}}
{ var __hm_with30 = scrHMInstances(BuffGator), __hm_break32=false;
for (var __hm_index31=0; __hm_index31<array_length(__hm_with30); ++__hm_index31) {
if(instance_exists(__hm_with30[__hm_index31])) with (__hm_with30[__hm_index31]) {
if ((random(5) < 1)) {
var __hm_other33=scrHMOther(other);
scrHMMotionAdd(point_direction(x, y, __hm_other33.target.x, __hm_other33.target.y), 2);
}
}
if(__hm_break32) break;
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
_hm.vars.hm_gator_floor = instance_nearest((x - 16), (y - 16), Floor);
;
if ((instance_exists(_hm.vars.hm_gator_floor) && (_hm.vars.hm_gator_floor.traction == 0.45))) {
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
{ var __hm_with34 = scrHMMatchingNE(projectile, "team", team), __hm_break36=false;
for (var __hm_index35=0; __hm_index35<array_length(__hm_with34); ++__hm_index35) {
if(instance_exists(__hm_with34[__hm_index35])) with (__hm_with34[__hm_index35]) {
if ((place_meeting((x + lengthdir_x(64, direction)), (y + lengthdir_y(64, direction)), (scrHMOther(other))) and (random(3) < 1))) {
{
{ var __hm_with37 = scrHMInstances((scrHMOther(other))), __hm_break39=false;
for (var __hm_index38=0; __hm_index38<array_length(__hm_with37); ++__hm_index38) {
if(instance_exists(__hm_with37[__hm_index38])) with (__hm_with37[__hm_index38]) {
{
var __hm_other40=scrHMOther(other);
dodgedir = (__hm_other40.direction + choose(90, (- 90)));
if ((dodge < 5)) {
dodge = 8;
} else {
dodge += 4;
}
var __hm_other41=scrHMOther(other);
scrHMMotionAdd(dodgedir, ((__hm_other41.speed / timescale) / 2));
}
}
if(__hm_break39) break;
}}
}
}
}
if(__hm_break36) break;
}}
}
if ((time > 0)) {
time--;
}
}
_hm.pc=23;
break;
case 25: // bosses/gatorboss.mod.gml:87
{
;
}
_hm.pc=24;
break;
case 26: // bosses/gatorboss.mod.gml:87
_hm.result=undefined; _hm.done=true; return;
break;
case 27: // bosses/gatorboss.mod.gml:87
{
speed = (0) * timescale;
;
}
_hm.pc=26;
break;
case 28: // bosses/gatorboss.mod.gml:87
_hm.pc = (((scrHMVariableExists(_hm.scope, "hm_extra") && hm_extra) && (! hm_arkintide_mod_gml_hm_extra_ready()))) ? 27 : 24;
break;
case 29: // bosses/gatorboss.mod.gml:86
{
_hm.vars.hm_gator_owner = id;
;
}
_hm.pc=28;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

// Source bosses/gatorboss.mod.gml:0; Gatorfist (native content 1.1.0)
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
if ((!scrHMVariableExists(id, "hm_fist_time"))) {
{
hm_fist_time = 0;
;
hm_fist_blast = 0;
;
}
}
hm_fist_time += 1;
;
hm_fist_blast += 1;
;
if ((hm_fist_blast >= 2)) {
{
hm_fist_blast -= 2;
;
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
if ((hm_fist_time > 300)) {
instance_destroy();
}
}
}

// Source bosses/gatorboss.mod.gml:0; Gatorfist_wall (native content 1.1.0)
function hm_bosses_gatorboss_mod_gml_Gatorfist_wall() {
instance_create((x + (hspeed / timescale)), (y + (vspeed / timescale)), PortalClear);
;
}

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





// Source bosses/gatorboss.mod.gml:0; gatorboss_death (native content 1.1.0)
function hm_bosses_gatorboss_mod_gml_gatorboss_death() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_gatorboss_mod_gml_gatorboss_death_resume, id, scrHMOther(other), _args, 7, []);
}
function hm_bosses_gatorboss_mod_gml_gatorboss_death_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_gatorboss_mod_gml_gatorboss_death");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/gatorboss.mod.gml:422
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
case 2: // bosses/gatorboss.mod.gml:421
_hm.wait_ticks=max(0,14); _hm.pc=1; return;
break;
case 3: // bosses/gatorboss.mod.gml:420
_hm.result=undefined; _hm.done=true; return;
break;
case 4: // bosses/gatorboss.mod.gml:420
_hm.pc = (hm_arkintide_mod_gml_hm_stage_boss_alive()) ? 3 : 2;
break;
case 5: // bosses/gatorboss.mod.gml:414
{
scrHMSoundPitchVolume(sndBuffGatorDie, 0.5, 4);
if ((! hm_arkintide_mod_gml_hm_stage_boss_alive())) {
scrHMSoundPlay(sndBossWin);
}
if ((! hm_arkintide_mod_gml_hm_stage_boss_alive())) {
scrHMSoundMusic(musBossDead);
}
_hm.vars.xd_ = x;
;
_hm.vars.yd_ = y;
;
_hm.vars.fl_ = instance_nearest(_hm.vars.xd_, _hm.vars.yd_, Floor);
;
}
_hm.pc=4;
break;
case 6: // bosses/gatorboss.mod.gml:413
_hm.result=undefined; _hm.done=true; return;
break;
case 7: // bosses/gatorboss.mod.gml:413
_hm.pc = ((scrHMVariableExists(_hm.scope, "hm_extra") && hm_extra)) ? 6 : 5;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

