// Source bosses/ravenboss.mod.gml:1; __load

function hm_bosses_ravenboss_mod_gml___load() {

global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbossidle = sprHM_bosses_ravenboss_mod_2;

global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbosswalk = sprHM_bosses_ravenboss_mod_3;

global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbosshurt = sprHM_bosses_ravenboss_mod_4;

global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbossdead = sprHM_bosses_ravenboss_mod_5;

global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbossdash = sprHM_bosses_ravenboss_mod_6;

global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbosslift = sprHM_bosses_ravenboss_mod_7;

global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbossfly = sprHM_bosses_ravenboss_mod_8;

global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbossland = sprHM_bosses_ravenboss_mod_9;

global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbosstell = sprHM_bosses_ravenboss_mod_10;

;

global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenintro = sprHM_bosses_ravenboss_mod_11;

global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenintrofg = sprHM_bosses_ravenboss_mod_12;

global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenintrobg = sprHM_bosses_ravenboss_mod_13;

}



// Source bosses/ravenboss.mod.gml:17; wantravenboss_create

function hm_bosses_ravenboss_mod_gml_wantravenboss_create(_hml__x, _hml__y) {

{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomObject)), __hm_break3=false;

for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {

if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {

{

enemies = instance_number(enemy);

name = "wantRavenboss";

on_step = hm_bosses_ravenboss_mod_gml_wantravenboss_step;

return id;

;

}

}

if(__hm_break3) break;

}}

}



// Source bosses/ravenboss.mod.gml:0; wantravenboss_step (native content 1.1.0)
function hm_bosses_ravenboss_mod_gml_wantravenboss_step() {
if (((instance_number(enemy) >= (enemies / 2)) || (! instance_exists(Player)))) {
exit;
}
var _hml_p = instance_nearest(x, y, Player);
var _hml_f = noone;
;
repeat (64) {
var _hml_r = random_range(64, 140);
var _hml_r2 = random(360);
;
var _hml_candidate = instance_nearest((_hml_p.x + lengthdir_x(_hml_r2, _hml_r)), (_hml_p.y + lengthdir_y(_hml_r2, _hml_r)), Floor);
;
if (((instance_exists(_hml_candidate) && (_hml_candidate.object_index != FloorExplo)) && (point_distance((_hml_candidate.x + 16), (_hml_candidate.y + 16), _hml_p.x, _hml_p.y) >= 60))) {
{
_hml_f = _hml_candidate;
;
break;
;
}
}
}
if ((! instance_exists(_hml_f))) {
{
var _hml_score = 1000000000;
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((object_index != FloorExplo)) {
{
var _hml_dist = point_distance((x + 16), (y + 16), _hml_p.x, _hml_p.y);
;
var _hml_value = (abs((_hml_dist - 100)) + ((_hml_dist < 60) ? 10000 : 0));
;
if ((_hml_value < _hml_score)) {
{
_hml_score = _hml_value;
;
_hml_f = id;
;
}
}
}
}
}
if(__hm_break3) break;
}}
}
}
if ((! instance_exists(_hml_f))) {
exit;
}
repeat (hm_arkintide_mod_gml_hm_boss_count()) hm_bosses_ravenboss_mod_gml_ravenboss_create((_hml_f.x + 16), (_hml_f.y + 16));
;
scrHMSoundPitchVolume(sndRavenDie, 0.6, 4);
;
instance_destroy();
;
}

// Source bosses/ravenboss.mod.gml:0; ravenboss_create (native content 1.1.0)
function hm_bosses_ravenboss_mod_gml_ravenboss_create() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_ravenboss_mod_gml_ravenboss_create_resume, id, scrHMOther(other), _args, 17, ["_x", "_y"]);
}
function hm_bosses_ravenboss_mod_gml_ravenboss_create_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_ravenboss_mod_gml_ravenboss_create");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/ravenboss.mod.gml:50
scrHMTaskWithNext(_hm);
break;
case 2: // bosses/ravenboss.mod.gml:50
scrHMTaskWithAbort(_hm);
break;
case 3: // bosses/ravenboss.mod.gml:138
{
;
}
_hm.pc=1;
break;
case 4: // bosses/ravenboss.mod.gml:138
_hm.result=id; _hm.done=true; return;
break;
case 5: // bosses/ravenboss.mod.gml:136
{
;
}
_hm.pc=4;
break;
case 6: // bosses/ravenboss.mod.gml:136
_hm.result=undefined; _hm.done=true; return;
break;
case 7: // bosses/ravenboss.mod.gml:135
{
if (instance_exists(id)) {
{
alrm1 = 1;
;
alrm0 = 1;
}
}
}
_hm.pc=6;
break;
case 8: // bosses/ravenboss.mod.gml:134
_hm.wait_ticks=max(0,180); _hm.pc=7; return;
break;
case 9: // bosses/ravenboss.mod.gml:120
{
if (((instance_exists(id) && (! (scrHMVariableExists(id, "hm_extra") && hm_extra))) and instance_exists(Player))) {
{
scrHMSoundMusic(musBoss1);
if ((scrHMModExists("mod", "options", "intropan") and (scrHMModGet("mod", "options", "intropan") == "1"))) {
{
if ((UberCont.opt_bossintro == 1)) {
{
scrHMModCall("mod", "bossintros", "boss_trigger", name, global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenintrobg, global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenintro, global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenintrofg, id, 60);
}
} else {
scrHMModCall("mod", "bossintros", "boss_trigger", "", mskNone, mskNone, mskNone, id, 60);
}
}
} else {
if ((UberCont.opt_bossintro == 1)) {
{
scrHMModCall("mod", "bossintros", "boss_trigger", name, global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenintrobg, global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenintro, global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenintrofg, instance_nearest(x, y, Player), 0);
}
}
}
}
}
}
_hm.pc=8;
break;
case 10: // bosses/ravenboss.mod.gml:119
_hm.result=undefined; _hm.done=true; return;
break;
case 11: // bosses/ravenboss.mod.gml:119
_hm.pc = ((scrHMVariableExists(_hm.scope, "hm_extra") && hm_extra)) ? 10 : 9;
break;
case 12: // bosses/ravenboss.mod.gml:118
_hm.result=undefined; _hm.done=true; return;
break;
case 13: // bosses/ravenboss.mod.gml:118
_hm.pc = ((! instance_exists(_hm.scope))) ? 12 : 11;
break;
case 14: // bosses/ravenboss.mod.gml:117
_hm.wait_ticks=max(0,45); _hm.pc=13; return;
break;
case 15: // bosses/ravenboss.mod.gml:116
_hm.pc = (((! (scrHMVariableExists(GameCont, "hm_extra_pending") && GameCont.hm_extra_pending)) && scrHMTaskFork(_hm, 14))) ? 14 : 4;
break;
case 16: // bosses/ravenboss.mod.gml:51
{
name = "BIG BIRD";
if ((scrHMVariableExists(GameCont, "hm_extra_pending") && GameCont.hm_extra_pending)) {
hm_maxhealth_init = false;
}
scrHMMaxHealthWrite(id, 150, "=");
;
friction = (0.4) * (timescale * timescale);
hp = max_hp;
scrHMBossHealth1103();
;
canfly = true;
;
spr_idle = global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbossidle;
;
spr_walk = global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbosswalk;
;
spr_hurt = global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbosshurt;
;
spr_dead = global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbossdead;
;
spr_tell = global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbosstell;
;
spr_chrg = global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbossdash;
;
spr_lift = global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbosslift;
;
spr_fly = global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbossfly;
;
spr_land = global.hm_module_vars[$ "mod:bosses/ravenboss"].ravenbossland;
;
sprite_index = spr_fly;
;
mask_index = mskNone;
;
size = 2;
;
meleedamage = 10;
;
hitid = [spr_fly, name];
;
snd_hurt = sndBuffGatorHit;
snd_lowh = sndBigBanditHalfHP;
;
snd_lift = sndBigBanditMeleeStart;
;
snd_land = sndBigBanditMelee;
;
snd_dash1 = sndBigBanditMeleeStart;
;
snd_dash2 = sndBigBanditMelee;
;
snd_dead = scrHMSoundPitch(sndRavenDie, 0.5);
lowh = 0;
;
scrHMSoundPitch(sndRavenDie, 0.6);
alrm0 = 0;
;
alrm1 = 0;
;
alrm2 = 0;
;
alrm3 = 0;
;
alrm4 = 100;
;
ammo = 0;
;
range_min = 32;
;
range_max = 100;
;
charge_time = 0;
;
charge_dir = 0;
;
intro = 0;
;
angry = 0;
;
gunangle = random(360);
;
walk = 0;
;
raddrop = 60;
;
evade_aux = 0;
;
evade_timer = 0;
;
z = 512;
;
zspd = 0;
;
flying = false;
;
sleeping = 1;
;
flight_x = x;
;
flight_y = y;
;
wantfly = 0;
;
on_hurt = scrHMScriptRef(hm_bosses_ravenboss_mod_gml_ravenboss_hurt);
;
on_step = scrHMScriptRef(hm_bosses_ravenboss_mod_gml_ravenboss_step);
;
on_draw = scrHMScriptRef(hm_bosses_ravenboss_mod_gml_ravenboss_draw);
;
on_destroy = scrHMScriptRef(hm_bosses_ravenboss_mod_gml_ravenboss_death);
;
animating = 1;
}
_hm.pc=15;
break;
case 17: // bosses/ravenboss.mod.gml:50
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(_hm.vars._x, _hm.vars._y, CustomEnemy)),16,0);
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

// Source bosses/ravenboss.mod.gml:0; ravenboss_callbackup (native content 1.1.0)
function hm_bosses_ravenboss_mod_gml_ravenboss_callbackup() {
if ((! hm_arkintide_mod_gml_hm_raven_leader())) {
exit;
}
if ((! instance_exists(Floor))) {
exit;
}
var _hml_slots = hm_arkintide_mod_gml_hm_raven_slots();
;
repeat (min(_hml_slots, max(0, floor((argument0 * (hm_arkintide_mod_gml_hm_attack_loops() + 1)))))) {
if ((instance_exists(target) and (target > 0))) {
{ var __hm_with1 = scrHMInstances(instance_create((x + random_range(200, (- 200))), (target.y - random_range(250, 300)), Raven)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
transform = 1;
image_alpha = 0;
scrHMContentChange1100(RavenFly,false);emergencylanding=0;z=0;
;
hm_bird_summon = 1;
;
image_index = 0;
;
var _hml_f = instance_nearest(((scrHMOther(other)).x + random_range((- 80), 80)), ((scrHMOther(other)).y + random_range((- 80), 80)), Floor);
;
if ((_hml_f.object_index == FloorExplo)) {
{
if (place_meeting(_hml_f.x, _hml_f.y, Wall)) {
{
var __hm_other4=scrHMOther(other);
targetx = __hm_other4.x;
var __hm_other5=scrHMOther(other);
targety = __hm_other5.y;
}
} else {
{
targetx = _hml_f.x;
targety = _hml_f.y;
}
}
}
} else {
{
if (place_meeting(_hml_f.x, _hml_f.y, Wall)) {
{
var __hm_other6=scrHMOther(other);
targetx = __hm_other6.x;
var __hm_other7=scrHMOther(other);
targety = __hm_other7.y;
}
} else {
{
targetx = (_hml_f.x + 16);
targety = (_hml_f.y + 16);
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

// Source bosses/ravenboss.mod.gml:0; ravenboss_hurt (native content 1.1.0)
function hm_bosses_ravenboss_mod_gml_ravenboss_hurt() {
if ((instance_exists((scrHMOther(other))) && scrHMVariableExists((scrHMOther(other)), "hitid"))) {
{
var _hml_hm_bird_source = (scrHMOther(other)).hitid;
;
if (is_array(_hml_hm_bird_source)) {
{
if (((array_length(_hml_hm_bird_source) > 2) && (_hml_hm_bird_source[2] == id))) {
exit;
}
}
}
}
}
evade_aux += argument0;
;
nexthurt = (current_frame + 5);
;
if ((evade_aux > (max_hp * 0.5))) {
{
alrm2 = 1;
;
angry = 0;
;
scrHMMotionAdd((argument1 + choose(90, (- 90))), 10);
evade_aux = 0;
;
mask_index = mskNone;
;
sleeping = 1;
}
} else {
{
var _hml__dmg = argument0;
;
if ((sprite_index == spr_chrg)) {
_hml__dmg *= 0.50;
}
if (((hp - _hml__dmg) <= 0)) {
{
scrHMSoundPlay(snd_dead);
;
}
}
evade_timer = 0;
;
hp -= _hml__dmg;
;
if ((((sprite_index == spr_idle) || (sprite_index == spr_walk)) || (sprite_index == spr_land))) {
{
sprite_index = spr_hurt;
;
image_index = 0;
;
}
}
scrHMMotionAdd(argument2, (argument1 * 0.33));
;
scrHMSoundPlay(snd_hurt);
;
if ((random(6) < 1)) {
alrm2 = 1;
}
}
}
}

// Source bosses/ravenboss.mod.gml:0; ravenboss_step (native content 1.1.0)
function hm_bosses_ravenboss_mod_gml_ravenboss_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_ravenboss_mod_gml_ravenboss_step_resume, id, scrHMOther(other), _args, 19, []);
}
function hm_bosses_ravenboss_mod_gml_ravenboss_step_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_ravenboss_mod_gml_ravenboss_step");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/ravenboss.mod.gml:347
{
if (instance_exists(id)) {
{
{ var __hm_with1 = scrHMInstances(Feather), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (((! place_meeting(x, y, Floor)) and (random(50) < 1))) {
instance_destroy();
}
}
if(__hm_break3) break;
}}
if ((alrm2 && (! (-- alrm2)))) {
{
image_index = 0;
;
sprite_index = spr_lift;
;
walk = 0;
;
alrm0 = 0;
;
alrm1 = 0;
;
alrm3 = 0;
;
ammo = 4;
;
}
}
if ((alrm3 && (! (-- alrm3)))) {
{
sprite_index = spr_tell;
;
image_index = 0;
;
scrHMSoundPlay(snd_dash1);
alrm0 = 0;
;
alrm1 = 0;
;
alrm2 = 0;
;
}
}
if ((sprite_index == spr_chrg)) {
{
hitid = [spr_chrg, name];
;
direction = charge_dir;
;
if (((-- charge_time) > 0)) {
{
speed = (8) * timescale;
;
}
}
instance_create(x, y, PortalClear);
;
if (((speed / timescale) < 2)) {
{
sprite_index = spr_idle;
;
meleedamage = 0;
;
alrm0 = 45;
;
angry = (3 + irandom(3));
;
scrHMSoundPlay(snd_dash2);
hm_bosses_ravenboss_mod_gml_ravenboss_callbackup(3);
;
}
}
}
}
if ((! flying)) {
{
if (((z + zspd) > 0)) {
zspd -= 0.4;
}
}
} else {
{
if ((z < 48)) {
{
zspd += 1;
}
} else {
{
if ((zspd > 0)) {
zspd -= 1;
}
}
}
}
}
if ((z > 16)) {
{
depth = (- 10);
mask_index = mskNone;
;
sleeping = 1;
}
} else {
{
depth = (- 2);
;
mask_index = mskBanditBoss;
;
sleeping = 0;
}
}
if (((z + zspd) <= 0)) {
{
if ((z > 0)) {
{
hm_arkintide_mod_gml_hm_safe_land();
;
sprite_index = spr_land;
;
image_index = 0;
;
alrm0 = (30 + irandom(20));
;
instance_create(x, y, PortalClear);
;
hm_bosses_ravenboss_mod_gml_ravenboss_callbackup(2);
repeat (32) {
{ var __hm_with4 = scrHMInstances(instance_create(x, y, Dust)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
direction = random(360);
;
speed = ((3 + random(3))) * timescale;
;
vspeed *= 0.66;
;
}
}
if(__hm_break6) break;
}}
}
if ((angry == 0)) {
angry = (3 + irandom(3));
}
scrHMSoundPlay(sndWallBreakBrick);
;
if ((intro == 1)) {
{
hm_bosses_ravenboss_mod_gml_ravenboss_callbackup(6);
;
scrHMSoundPlay(sndBigBanditIntro);
;
alrm1 += 60;
intro++;
;
}
} else {
if ((intro < 1)) {
{
intro++;
;
alrm2 = 0;
;
mask_index = mskBanditBoss;
sleeping = 0;
}
}
}
}
}
zspd = 0;
;
z = 0;
;
}
}
zspd = clamp(zspd, (- 16), 16);
;
z += zspd;
;
if ((instance_exists(target) && (target > 0))) {
{
if ((angry == 0)) {
{
hm_arkintide_mod_gml_hm_bird_aim();
;
}
}
}
}
if ((((sprite_index == spr_lift) && (floor(image_index) == 5)) && (flying == 0))) {
{
if (instance_exists(Player)) {
_hm.vars.targetplayer = instance_furthest(x, y, Player);
} else {
_hm.vars.targetplayer = id;
}
;
scrHMSoundPlay(snd_lift);
if ((angry > 0)) {
{
_hm.vars.randfloor = instance_nearest((_hm.vars.targetplayer.x + (choose(64, (- 64)) * irandom_range(1, 2))), (_hm.vars.targetplayer.y + (choose(64, (- 64)) * irandom_range(1, 2))), Floor);
;
flight_x = (_hm.vars.randfloor.x + 16);
;
flight_y = (_hm.vars.randfloor.y + 16);
;
}
} else {
{
if ((instance_exists(target) && (target > 0))) {
{
hm_arkintide_mod_gml_hm_bird_aim();
;
}
}
}
}
alrm0 = (- 1);
;
if ((point_distance(x, y, flight_x, flight_y) < 32)) {
{
_hm.vars.randfloor = instance_nearest((x + choose(32, (- 32))), (y + choose(32, (- 32))), Floor);
;
flight_x = (_hm.vars.randfloor.x + 16);
;
flight_y = (_hm.vars.randfloor.y + 16);
;
}
}
repeat (32) {
{ var __hm_with7 = scrHMInstances(instance_create(x, y, Feather)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
sprite_index = sprRavenFeather;
direction = random(360);
;
speed = ((3 + random(3))) * timescale;
;
vspeed *= 0.66;
;
}
}
if(__hm_break9) break;
}}
}
flying = 1;
;
hm_flight_age = 0;
;
hm_flight_locked = 0;
;
}
}
if (flying) {
{
hm_flight_age++;
;
_hm.vars._dir = point_direction(x, y, flight_x, flight_y);
;
if ((z >= 48)) {
{
_hm.vars._maxspd = undefined;
;
if ((angry == 0)) {
_hm.vars._maxspd = 7;
} else {
_hm.vars._maxspd = 5;
}
;
x += lengthdir_x(min((point_distance(x, y, flight_x, flight_y) * 0.10), _hm.vars._maxspd), _hm.vars._dir);
;
y += lengthdir_y(min((point_distance(x, y, flight_x, flight_y) * 0.10), _hm.vars._maxspd), _hm.vars._dir);
;
if ((intro > 0)) {
meleedamage = 10;
}
hitid = [spr_fly, name];
;
}
}
if (((point_distance(x, y, flight_x, flight_y) < 8) || (hm_flight_age > 180))) {
{
flying = 0;
;
angry = (3 + irandom(3));
;
}
}
}
}
if ((abs((speed / timescale)) > 0.20)) {
{
if ((sprite_index != spr_chrg)) {
speed *= 0.90;
}
}
} else {
speed = (0) * timescale;
}
;
if (walk) {
{
walk--;
;
if (((speed / timescale) < 3.5)) {
speed += (0.5) * timescale;
}
if (place_meeting(x, y, Wall)) {
{
direction += (90 * right);
;
walk--;
;
}
}
}
}
if ((((gunangle + 270) mod 360) < 180)) {
right = (- 1);
} else {
right = 1;
}
;
if (((sprite_index == spr_land) && (z > 0))) {
{
image_index = (image_index mod 1);
;
}
}
if (((abs((speed / timescale)) > 0.50) && (sprite_index == spr_idle))) {
{
sprite_index = spr_walk;
;
}
}
if (((image_index + (image_speed / timescale)) >= image_number)) {
{
if (((((sprite_index == spr_idle) || (sprite_index == spr_walk)) || (sprite_index == spr_hurt)) || (sprite_index == spr_land))) {
{
if (((speed / timescale) > (friction / (timescale * timescale)))) {
sprite_index = spr_walk;
} else {
sprite_index = spr_idle;
}
;
hitid = [spr_idle, name];
;
meleedamage = 0;
;
}
} else {
if ((sprite_index == spr_lift)) {
{
sprite_index = spr_fly;
;
}
} else {
if ((sprite_index == spr_fly)) {
{
if (flying) {
sprite_index = spr_fly;
} else {
sprite_index = spr_land;
}
;
}
} else {
if ((sprite_index == spr_tell)) {
{
charge_time = 15;
;
sprite_index = spr_chrg;
;
direction = point_direction(x, y, target.x, target.y);
;
charge_dir = point_direction(x, y, target.x, target.y);
;
meleedamage = 10;
;
}
}
}
}
}
image_index = 0;
;
}
}
if (((instance_exists(target) && (target > 0)) && (angry == 0))) {
{
hm_arkintide_mod_gml_hm_bird_aim();
;
}
}
{ var __hm_with10 = scrHMInstances(Player), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
if (((scrHMWeaponType(wep) == 3) and (!scrHMVariableExists((scrHMOther(other)), "boltsticks")))) {
{ var __hm_with13 = scrHMInstances((scrHMOther(other))), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
{ var __hm_with16 = scrHMInstances(instance_create(x, (y - z), CustomObject)), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
{
name = "boltsticksfly";
var __hm_other19=scrHMOther(other);
creator = __hm_other19;
on_step = scrHMScriptRef(hm_bosses_ravenboss_mod_gml_boltstickfly);
}
}
if(__hm_break18) break;
}}
boltsticks = 1;
}
}
if(__hm_break15) break;
}}
}
}
if(__hm_break12) break;
}}
if ((((((sprite_index == spr_idle) and (alrm0 == 0)) and instance_exists(target)) && (target > 0)) and (alrm4 <= 0))) {
{
if (collision_line(x, y, target.x, target.y, Wall, 0, 1)) {
alrm3 = 1;
} else {
alrm2 = 1;
}
}
}
}
}
}
_hm.pc=0;
break;
case 2: // bosses/ravenboss.mod.gml:294
{
if ((instance_exists(target) && (target > 0))) {
{
alrm1 += 15;
ammo -= 1;
scrHMSoundPlay(sndRocket);
gunangle = point_direction(x, y, target.x, target.y);
;
{ var __hm_with20 = scrHMInstances(instance_create((x + lengthdir_x(12, gunangle)), (y + lengthdir_y(12, gunangle)), JockRocket)), __hm_break22=false;
for (var __hm_index21=0; __hm_index21<array_length(__hm_with20); ++__hm_index21) {
if(instance_exists(__hm_with20[__hm_index21])) with (__hm_with20[__hm_index21]) {
{
var __hm_other23=scrHMOther(other);
creator = __hm_other23;
var __hm_other24=scrHMOther(other);
hitid = [__hm_other24.spr_idle, __hm_other24.name, __hm_other24.id];
var __hm_other25=scrHMOther(other);
team = __hm_other25.team;
var __hm_other26=scrHMOther(other);
direction = __hm_other26.gunangle;
sprite_index = sprJockRocket;
image_angle = direction;
speed += (4) * timescale;
}
}
if(__hm_break22) break;
}}
alrm0 += 30;
wkick += 8;
scrHMMotionAdd((gunangle + 180), 6);
repeat (8) { var __hm_with27 = scrHMInstances(instance_create((x + lengthdir_x(12, (gunangle + 180))), (y + lengthdir_y(12, (gunangle + 180))), Smoke)), __hm_break29=false;
for (var __hm_index28=0; __hm_index28<array_length(__hm_with27); ++__hm_index28) {
if(instance_exists(__hm_with27[__hm_index28])) with (__hm_with27[__hm_index28]) {
var __hm_other30=scrHMOther(other);
scrHMMotionAdd(((__hm_other30.gunangle + 180) + random_range((- 60), 60)), random(2));
}
if(__hm_break29) break;
}}
if (((random(5) < 1) and (flying == false))) {
{
alrm2 = 1;
}
}
}
}
alrm3 = 0;
;
}
_hm.pc=1;
break;
case 3: // bosses/ravenboss.mod.gml:339
{
if (instance_exists(id)) {
{
ammo += 4;
if ((random(3) < 1)) {
alrm2 = 1;
}
}
}
}
_hm.pc=1;
break;
case 5: // bosses/ravenboss.mod.gml:334
_hm.vars.__hm_repeat31--; _hm.pc=4;
break;
case 6: // bosses/ravenboss.mod.gml:337
{
;
}
_hm.pc=5;
break;
case 7: // bosses/ravenboss.mod.gml:337
_hm.wait_ticks=max(0,20); _hm.pc=6; return;
break;
case 8: // bosses/ravenboss.mod.gml:336
{
scrHMSoundPitch(sndNadeReload, 0.8);
}
_hm.pc=7;
break;
case 9: // bosses/ravenboss.mod.gml:335
_hm.pc = (instance_exists(_hm.scope)) ? 8 : 5;
break;
case 4: // bosses/ravenboss.mod.gml:334
_hm.pc=(_hm.vars.__hm_repeat31>0)?9:3;
break;
case 10: // bosses/ravenboss.mod.gml:334
_hm.vars.__hm_repeat31=round(4); _hm.pc=4;
break;
case 11: // bosses/ravenboss.mod.gml:333
_hm.pc = (scrHMTaskFork(_hm, 10)) ? 10 : 1;
break;
case 12: // bosses/ravenboss.mod.gml:332
{
alrm1 += 70;
}
_hm.pc=11;
break;
case 13: // bosses/ravenboss.mod.gml:294
_hm.pc = ((ammo > 0)) ? 2 : 12;
break;
case 14: // bosses/ravenboss.mod.gml:293
_hm.pc = ((((alrm1 == 0) and (flying == false)) and (((sprite_index == spr_idle) || (sprite_index == spr_hurt)) || (sprite_index == spr_walk)))) ? 13 : 1;
break;
case 15: // bosses/ravenboss.mod.gml:219
{
if ((((++ evade_timer) > (30 * 6)) && (evade_timer < (30 * 6)))) {
{
evade_aux = 0;
;
}
}
if ((alrm1 > 0)) {
alrm1--;
}
if ((alrm4 > 0)) {
alrm4--;
}
if (instance_exists(Player)) {
{
target = instance_nearest(x, y, Player);
;
if ((collision_line(x, y, target.x, target.y, Wall, 0, 1) == noone)) {
{
if ((ammo > 0)) {
gunangle = point_direction(x, y, target.x, target.y);
} else {
gunangle = (90 + (16 * image_xscale));
}
targetvisible = 1;
;
}
} else {
targetvisible = 0;
}
;
}
} else {
{
target = (- 1);
;
targetvisible = 0;
;
}
}
if ((alrm0 && (! (-- alrm0)))) {
{
firing = 0;
;
if ((instance_exists(target) && (target > 0))) {
{
if (((((distance_to_object(target) > (range_max * 1.25)) && angry) && (! (-- angry))) || (random(12) < 1))) {
{
alrm2 = 1;
;
angry = 0;
;
}
} else {
{
if ((collision_line(x, y, target.x, target.y, Wall, 0, 1) == noone)) {
{
if (((distance_to_object(target) <= range_max) && (distance_to_object(target) > range_min))) {
{
if ((random(5) < 3)) {
{
walk = 20;
direction = (((point_direction(x, y, target.x, target.y) + choose(60, (- 60))) + random_range((- 10), 10)) * (- 1));
;
alrm1 += 1;
;
ammo += irandom(3);
;
}
} else {
{
walk = (20 + irandom(30));
;
direction = ((point_direction(x, y, target.x, target.y) + choose(60, (- 60))) + random_range((- 10), 10));
;
alrm0 = (walk + irandom(10));
;
}
}
}
} else {
{
alrm3 = 0;
;
}
}
}
} else {
{
if ((angry && (! (-- angry)))) {
{
if ((distance_to_object(target) < range_max)) {
{
if ((random(3) < 2)) {
alrm3 = 1;
} else {
alrm2 = 1;
}
;
}
} else {
{
alrm2 = 1;
;
}
}
}
} else {
{
walk = (20 + irandom(30));
;
direction = ((point_direction(x, y, target.x, target.y) + choose(60, (- 60))) + random_range((- 10), 10));
;
alrm0 = (walk + irandom(10));
;
}
}
}
}
}
}
}
} else {
{
walk = (20 + irandom(30));
;
direction = random(360);
;
alrm0 = (walk + irandom(10));
;
}
}
}
}
}
_hm.pc=14;
break;
case 16: // bosses/ravenboss.mod.gml:215
{
;
}
_hm.pc=15;
break;
case 17: // bosses/ravenboss.mod.gml:215
_hm.result=undefined; _hm.done=true; return;
break;
case 18: // bosses/ravenboss.mod.gml:215
{
speed = (0) * timescale;
;
}
_hm.pc=17;
break;
case 19: // bosses/ravenboss.mod.gml:215
_hm.pc = (((scrHMVariableExists(_hm.scope, "hm_extra") && hm_extra) && (! hm_arkintide_mod_gml_hm_extra_ready()))) ? 18 : 15;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

// Source bosses/ravenboss.mod.gml:575; ravenboss_draw

function hm_bosses_ravenboss_mod_gml_ravenboss_draw() {

var _hml_shad_scale = undefined;

;

_hml_shad_scale = (1 - min((0.66 * (z / 96)), 0.66));

draw_set_color(make_color_rgb(20, 20, 20));

;

draw_set_alpha(0.4);

;

draw_ellipse((x + (16 * _hml_shad_scale)), ((y + 10) + (8 * _hml_shad_scale)), (x - (16 * _hml_shad_scale)), ((y + 10) - (8 * _hml_shad_scale)), 0);

;

draw_set_color(c_white);

;

draw_set_alpha(1);

;

if (((gunangle < 180) && (z == 0))) {

scrHMDrawSpriteExt(sprGatlingBazooka, 0, (x - lengthdir_x(wkick, gunangle)), ((y - z) - lengthdir_y(wkick, gunangle)), 1, right, gunangle, c_white, 1);

}

scrHMDrawSpriteExt(sprite_index, image_index, x, (y - z), right, 1, 0, image_blend, 1);

;

if (((gunangle >= 180) && (z == 0))) {

scrHMDrawSpriteExt(sprGatlingBazooka, 0, (x - lengthdir_x(wkick, gunangle)), ((y - z) - lengthdir_y(wkick, gunangle)), 1, right, gunangle, c_white, 1);

}

}



// Source bosses/ravenboss.mod.gml:0; ravenboss_death (native content 1.1.0)
function hm_bosses_ravenboss_mod_gml_ravenboss_death() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_ravenboss_mod_gml_ravenboss_death_resume, id, scrHMOther(other), _args, 7, []);
}
function hm_bosses_ravenboss_mod_gml_ravenboss_death_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_ravenboss_mod_gml_ravenboss_death");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/ravenboss.mod.gml:624
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
case 2: // bosses/ravenboss.mod.gml:623
_hm.wait_ticks=max(0,14); _hm.pc=1; return;
break;
case 3: // bosses/ravenboss.mod.gml:622
_hm.result=undefined; _hm.done=true; return;
break;
case 4: // bosses/ravenboss.mod.gml:622
_hm.pc = (hm_arkintide_mod_gml_hm_stage_boss_alive()) ? 3 : 2;
break;
case 5: // bosses/ravenboss.mod.gml:610
{
repeat (32) {
{ var __hm_with4 = scrHMInstances(instance_create(x, y, Feather)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
sprite_index = sprRavenFeather;
direction = random(360);
;
speed = ((3 + random(6))) * timescale;
;
}
}
if(__hm_break6) break;
}}
}
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
case 6: // bosses/ravenboss.mod.gml:609
_hm.result=undefined; _hm.done=true; return;
break;
case 7: // bosses/ravenboss.mod.gml:609
_hm.pc = ((scrHMVariableExists(_hm.scope, "hm_extra") && hm_extra)) ? 6 : 5;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

// Source bosses/ravenboss.mod.gml:604; boltstickfly

function hm_bosses_ravenboss_mod_gml_boltstickfly() {

if (instance_exists(creator)) {

{

x = (creator.x + (creator.hspeed / timescale));

y = ((creator.y + (creator.vspeed / timescale)) - creator.z);

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

