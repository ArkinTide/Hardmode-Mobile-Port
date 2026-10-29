// Source bosses/ratboss.mod.gml:1; __load
function hm_bosses_ratboss_mod_gml___load() {
global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossidle = sprHM_bosses_ratboss_mod_2;
global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossinvulnidle = sprHM_bosses_ratboss_mod_3;
global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossfire = sprHM_bosses_ratboss_mod_4;
global.hm_module_vars[$ "mod:bosses/ratboss"].ratbosshurt = sprHM_bosses_ratboss_mod_5;
global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossdead = sprHM_bosses_ratboss_mod_6;
global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossappear = sprHM_bosses_ratboss_mod_7;
global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossdisappear = sprHM_bosses_ratboss_mod_8;
global.hm_module_vars[$ "mod:bosses/ratboss"].tenticleappear = sprHM_bosses_ratboss_mod_10;
global.hm_module_vars[$ "mod:bosses/ratboss"].tenticleidle = sprHM_bosses_ratboss_mod_11;
global.hm_module_vars[$ "mod:bosses/ratboss"].tenticlehurt = sprHM_bosses_ratboss_mod_12;
global.hm_module_vars[$ "mod:bosses/ratboss"].tenticledead = sprHM_bosses_ratboss_mod_13;
}

// Source bosses/ratboss.mod.gml:16; ratbosssleep_create
function hm_bosses_ratboss_mod_gml_ratbosssleep_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomEnemy)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "ratbosssleep";
on_step = scrHMScriptRef(hm_bosses_ratboss_mod_gml_ratbosssleep_step);
on_destroy = scrHMScriptRef(hm_bosses_ratboss_mod_gml_ratbosssleep_dead);
team = 1;
scrHMMaxHealthWrite(id, 50, "=");
sleeping = 1;
;
mask_index = mskBandit;
return id;
;
}
}
if(__hm_break3) break;
}}
}

// Source bosses/ratboss.mod.gml:27; ratbosssleep_dead
function hm_bosses_ratboss_mod_gml_ratbosssleep_dead() {
hm_bosses_ratboss_mod_gml_ratboss_create(x, y);
}

// Source bosses/ratboss.mod.gml:29; ratboss_create
function hm_bosses_ratboss_mod_gml_ratboss_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomEnemy)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "ratboss";
boss = 1;
team = 2;
hitid = [global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossidle, "Mutant Rat"];
spr_idle = global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossappear;
spr_dead = global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossdead;
snd_hurt = sndOasisBossHurt;
scrHMMaxHealthWrite(id, (600 + ((300 * instance_number(Player)) * (0.5 * GameCont.loops))), "=");
hp = max_hp;
storehp = max_hp;
midhealth = (max_hp / 2);
direction = random(360);
spr_shadow = (- 4);
size = 3;
mask_index = mskVan;
friction = (32) * (timescale * timescale);
raddrop = 75;
canmelee = 0;
meleedamage = 3;
target = 0;
targetvisible = 0;
alrm1 = 100;
walk = 0;
alrm2 = 0;
ax = x;
ay = y;
tenticles = 0;
underwater = 0;
sleeping = 1;
;
on_step = scrHMScriptRef(hm_bosses_ratboss_mod_gml_ratboss_step);
on_death = hm_bosses_ratboss_mod_gml_ratboss_dead;
return id;
;
}
}
if(__hm_break3) break;
}}
}

// Source bosses/ratboss.mod.gml:64; ratboss_step
function hm_bosses_ratboss_mod_gml_ratboss_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_ratboss_mod_gml_ratboss_step_resume, id, scrHMOther(other), _args, 13, []);
}
function hm_bosses_ratboss_mod_gml_ratboss_step_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_ratboss_mod_gml_ratboss_step");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 2: // bosses/ratboss.mod.gml:176
_hm.vars.__hm_repeat1--; _hm.pc=1;
break;
case 3: // bosses/ratboss.mod.gml:191
_hm.wait_ticks=max(0,4); _hm.pc=2; return;
break;
case 4: // bosses/ratboss.mod.gml:177
{
repeat (_hm.vars.n) {
if (((instance_exists(id) && (alrm2 <= 0)) && (((spr_idle != global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossappear) and (spr_idle != global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossdisappear)) and (spr_idle != (- 4))))) {
{ var __hm_with2 = scrHMInstances(instance_create(x, y, EnemyBullet1)), __hm_break4=false;
for (var __hm_index3=0; __hm_index3<array_length(__hm_with2); ++__hm_index3) {
if(instance_exists(__hm_with2[__hm_index3])) with (__hm_with2[__hm_index3]) {
{
sprite_index = sprFireBall;
hitid = [global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossidle, "Mutant Rat"];
speed = (4.5) * timescale;
team = 1;
direction = (_hm.vars.a + _hm.vars.b);
var __hm_other5=scrHMOther(other);
creator = __hm_other5;
image_angle = direction;
_hm.vars.a += (360 / _hm.vars.n);
}
}
if(__hm_break4) break;
}}
}
}
_hm.vars.b += ((12 * _hm.vars.c) + ((_hm.vars.b / _hm.vars.n) * 2));
}
_hm.pc=3;
break;
case 1: // bosses/ratboss.mod.gml:176
_hm.pc=(_hm.vars.__hm_repeat1>0)?4:0;
break;
case 5: // bosses/ratboss.mod.gml:176
_hm.vars.__hm_repeat1=round(24); _hm.pc=1;
break;
case 6: // bosses/ratboss.mod.gml:171
{
alrm1 = 300;
_hm.vars.a = 0;
;
_hm.vars.b = 0;
;
_hm.vars.c = choose((- 1), 1);
;
_hm.vars.n = choose(3, 4, 5, 6);
;
}
_hm.pc=5;
break;
case 7: // bosses/ratboss.mod.gml:194
{
if ((instance_exists(id) && (team == 1))) {
{
alrm1 = 10;
_hm.vars.a = point_direction(x, y, target.x, target.y);
{ var __hm_with6 = scrHMInstances(instance_create(x, y, EnemyBullet1)), __hm_break8=false;
for (var __hm_index7=0; __hm_index7<array_length(__hm_with6); ++__hm_index7) {
if(instance_exists(__hm_with6[__hm_index7])) with (__hm_with6[__hm_index7]) {
{
sprite_index = sprFireBall;
hitid = [global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossidle, "Mutant Rat"];
speed = (5) * timescale;
team = 1;
direction = (_hm.vars.a + random_range((- 50), 50));
var __hm_other9=scrHMOther(other);
creator = __hm_other9;
image_angle = direction;
}
}
if(__hm_break8) break;
}}
}
}
}
_hm.pc=0;
break;
case 8: // bosses/ratboss.mod.gml:170
_hm.pc = (((alrm2 <= 0) && (team == 1))) ? 6 : 7;
break;
case 9: // bosses/ratboss.mod.gml:169
_hm.pc = (((alrm1 <= 0) && targetvisible)) ? 8 : 0;
break;
case 10: // bosses/ratboss.mod.gml:151
{
if ((alrm2 > 0)) {
{
alrm2 -= 1;
storehp = hp;
spr_hurt = global.hm_module_vars[$ "mod:bosses/ratboss"].ratbosshurt;
snd_hurt = sndOasisBossHurt;
x = (ax + random_range((- 2), 2));
y = (ay + random_range((- 2), 2));
}
}
if ((alrm2 <= 0)) {
{
hp = storehp;
spr_hurt = global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossinvulnidle;
snd_hurt = (- 4);
x = ax;
y = ay;
}
}
if ((alrm1 > 0)) {
{
alrm1 -= 1;
}
}
}
_hm.pc=9;
break;
case 11: // bosses/ratboss.mod.gml:211
{
x = ax;
y = ay;
hp = storehp;
sprite_index = spr_idle;
}
_hm.pc=0;
break;
case 12: // bosses/ratboss.mod.gml:150
_hm.pc = (((spr_idle != global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossappear) && (underwater <= 0))) ? 10 : 11;
break;
case 13: // bosses/ratboss.mod.gml:65
{
if (((spr_idle == global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossappear) && (image_index >= 15))) {
{
spr_idle = global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossinvulnidle;
canmelee = 1;
team = 1;
scrHMSoundPitch(sndOasisBossFire, 2);
}
}
if (((nexthurt > current_frame) && (spr_idle == global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossidle))) {
{
if ((sprite_index != spr_hurt)) {
{
image_index = 0;
;
sprite_index = spr_hurt;
;
}
}
if ((hp < midhealth)) {
{
midhealth = (- 1);
canmelee = 0;
spr_idle = global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossdisappear;
underwater = random_range(25, 100);
team = 2;
}
}
}
} else {
{
sprite_index = spr_idle;
;
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
if (targetvisible) {
{
_hm.vars.p = instance_nearest(x, y, Player);
alrm1 -= 1;
gunangle = point_direction(x, y, _hm.vars.p.x, _hm.vars.p.y);
if ((target.x > x)) {
image_xscale = 1;
} else {
image_xscale = (- 1);
}
}
}
}
}
if ((team == 2)) {
{ var __hm_with10 = scrHMMatchingNE(projectile, "team", 0), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
{
scrHMSoundPlay(sndCrystalRicochet);
;
{ var __hm_with13 = scrHMInstances(instance_create(x, y, Deflect)), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
var __hm_other16=scrHMOther(other);
image_angle = __hm_other16.direction;
}
if(__hm_break15) break;
}}
instance_destroy();
}
}
}
if(__hm_break12) break;
}}
}
if ((tenticles == 0)) {
{
if ((spr_idle == global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossappear)) {
{
repeat (2) {
_hm.vars.r = random_range(40, 80);
;
_hm.vars.r2 = random(360);
;
hm_bosses_ratboss_mod_gml_tenticle_create((x + lengthdir_x(_hm.vars.r, _hm.vars.r2)), (y + lengthdir_y(_hm.vars.r, _hm.vars.r2)), id);
tenticles += 1;
}
}
}
if (((spr_idle == global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossinvulnidle) && (alrm2 <= 0))) {
{
alrm2 = 200;
spr_idle = global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossidle;
}
}
}
}
{ var __hm_with17 = scrHMMatching(CustomEnemy, "name", "tenticle"), __hm_break19=false;
for (var __hm_index18=0; __hm_index18<array_length(__hm_with17); ++__hm_index18) {
if(instance_exists(__hm_with17[__hm_index18])) with (__hm_with17[__hm_index18]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
{
var __hm_other20=scrHMOther(other);
scrHMMotionAdd(point_direction(__hm_other20.x, __hm_other20.y, x, y), 14);
}
}
}
if(__hm_break19) break;
}}
if (((spr_idle == global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossidle) && (alrm2 <= 0))) {
{
canmelee = 0;
spr_idle = global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossdisappear;
underwater = random_range(25, 100);
team = 2;
}
}
if ((underwater > 0)) {
underwater -= 1;
}
if (((spr_idle == global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossdisappear) && (image_index >= 11))) {
spr_idle = (- 4);
}
if (((underwater <= 0) && (spr_idle == (- 4)))) {
spr_idle = global.hm_module_vars[$ "mod:bosses/ratboss"].ratbossappear;
}
}
_hm.pc=12;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/ratboss.mod.gml:217; ratboss_dead
function hm_bosses_ratboss_mod_gml_ratboss_dead() {
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), Effect)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
sprite_index = sprFloor103;
image_speed = (0) * timescale;
image_index = 1;
depth = (- 1);
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(instance_create((x + 16), (y + 16), CustomObject)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
name = "VenuzElevator";
image_speed = (0) * timescale;
sprite_index = sprFloor103;
image_alpha = 0;
image_index = 1;
depth = 7;
activated = 1;
}
}
if(__hm_break6) break;
}}
}

// Source bosses/ratboss.mod.gml:233; ratbosssleep_step
function hm_bosses_ratboss_mod_gml_ratbosssleep_step() {
if ((distance_to_object(Player) < 120)) {
instance_destroy();
}
}

// Source bosses/ratboss.mod.gml:236; tenticle_create
function hm_bosses_ratboss_mod_gml_tenticle_create(_hml__x, _hml__y, _hml_cre) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomEnemy)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
team = 1;
name = "tenticle";
scrHMMaxHealthWrite(id, 50, "=");
speed = (0) * timescale;
friction = (0.4) * (timescale * timescale);
canmelee = 0;
creator = _hml_cre;
gunangle = random(360);
mask_index = mskBandit;
hitid = [global.hm_module_vars[$ "mod:bosses/ratboss"].tenticleidle, "Rat Tenticle"];
alrm1 = random_range(60, 100);
spr_idle = global.hm_module_vars[$ "mod:bosses/ratboss"].tenticleappear;
spr_walk = global.hm_module_vars[$ "mod:bosses/ratboss"].tenticleidle;
spr_hurt = global.hm_module_vars[$ "mod:bosses/ratboss"].tenticlehurt;
spr_dead = global.hm_module_vars[$ "mod:bosses/ratboss"].tenticledead;
sleeping = 1;
;
on_step = scrHMScriptRef(hm_bosses_ratboss_mod_gml_tenticle_step);
on_destroy = scrHMScriptRef(hm_bosses_ratboss_mod_gml_tenticle_dead);
return id;
;
}
}
if(__hm_break3) break;
}}
}

// Source bosses/ratboss.mod.gml:258; tenticle_step
function hm_bosses_ratboss_mod_gml_tenticle_step() {
if (((spr_idle == global.hm_module_vars[$ "mod:bosses/ratboss"].tenticleappear) && (image_index >= 20))) {
{
spr_idle = global.hm_module_vars[$ "mod:bosses/ratboss"].tenticleidle;
scrHMSoundPitch(sndTurtleHurt, 1.3);
}
}
if ((spr_idle == global.hm_module_vars[$ "mod:bosses/ratboss"].tenticleidle)) {
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
{
if (((speed / timescale) > (friction / (timescale * timescale)))) {
sprite_index = spr_walk;
} else {
sprite_index = spr_idle;
}
;
}
}
}
} else {
sprite_index = spr_idle;
}
if ((instance_exists(Player) and (sprite_index == spr_idle))) {
{
target = instance_nearest(x, y, Player);
gunangle = point_direction(x, y, target.x, target.y);
}
} else {
target = (- 1);
}
if ((target != (- 1))) {
{
scrHMMotionAdd(gunangle, 0.5);
if ((alrm1 > 0)) {
alrm1--;
} else {
if ((alrm1 != (- 1))) {
{
alrm1 += 100;
scrHMSoundPitch(sndJockFire, 1.3);
scrHMMotionSet((gunangle - 180), 5);
{ var __hm_with1 = scrHMInstances(instance_create(x, y, JockRocket)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var __hm_other4=scrHMOther(other);
hitid = __hm_other4.hitid;
var __hm_other5=scrHMOther(other);
team = __hm_other5.team;
var __hm_other6=scrHMOther(other);
creator = __hm_other6;
damage = 1;
image_xscale *= 0.5;
var __hm_other7=scrHMOther(other);
direction = __hm_other7.gunangle;
image_angle = direction;
}
}
if(__hm_break3) break;
}}
}
}
}
}
}
if (((speed / timescale) > 2)) {
speed = (1) * timescale;
}
}

// Source bosses/ratboss.mod.gml:307; tenticle_dead
function hm_bosses_ratboss_mod_gml_tenticle_dead() {
{ var __hm_with1 = scrHMMatching(CustomEnemy, "name", "ratboss"), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
tenticles -= 1;
}
if(__hm_break3) break;
}}
}
