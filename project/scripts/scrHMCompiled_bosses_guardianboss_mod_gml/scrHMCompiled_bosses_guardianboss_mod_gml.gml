// Source bosses/guardianboss.mod.gml:1; __load
function hm_bosses_guardianboss_mod_gml___load() {
global.hm_module_vars[$ "mod:bosses/guardianboss"].Statue1 = sprHM_bosses_guardianboss_mod_2;
global.hm_module_vars[$ "mod:bosses/guardianboss"].Statue2 = sprHM_bosses_guardianboss_mod_3;
global.hm_module_vars[$ "mod:bosses/guardianboss"].Statue3 = sprHM_bosses_guardianboss_mod_4;
global.hm_module_vars[$ "mod:bosses/guardianboss"].GuardianStatueoutline1 = sprHM_bosses_guardianboss_mod_5;
global.hm_module_vars[$ "mod:bosses/guardianboss"].GuardianStatueoutline2 = sprHM_bosses_guardianboss_mod_6;
global.hm_module_vars[$ "mod:bosses/guardianboss"].guardianintro = sprHM_bosses_guardianboss_mod_7;
global.hm_module_vars[$ "mod:bosses/guardianboss"].guardianintrofg = sprHM_bosses_guardianboss_mod_8;
global.hm_module_vars[$ "mod:bosses/guardianboss"].guardianintrobg = sprHM_bosses_guardianboss_mod_9;
}

// Source bosses/guardianboss.mod.gml:11; draw_dark
function hm_bosses_guardianboss_mod_gml_draw_dark() {
{ var __hm_with1 = scrHMMatching(CustomEnemy, "name", "guardianboss"), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
draw_set_alpha(1);
draw_set_color($808080);
draw_circle(x, y, ((50 + random(6)) * spritealpha), false);
draw_set_color(0);
;
draw_circle(x, y, ((25 + random(6)) * spritealpha), false);
}
}
if(__hm_break3) break;
}}
}

// Source bosses/guardianboss.mod.gml:20; GuardianStatue_create
function hm_bosses_guardianboss_mod_gml_GuardianStatue_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, (_hml__y - 4), CustomObject)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "guardianstatue";
spr_idle1 = global.hm_module_vars[$ "mod:bosses/guardianboss"].Statue1;
spr_idle2 = global.hm_module_vars[$ "mod:bosses/guardianboss"].Statue2;
spr_idle3 = global.hm_module_vars[$ "mod:bosses/guardianboss"].Statue3;
image_angle = 45;
image_angle1 = image_angle;
image_angle2 = image_angle;
image_angle3 = image_angle;
image_angle4 = image_angle;
mask_index = mskLaserCrystal;
hitid = [sprThroneStatue, "HOW DID THIS KILL YOU?"];
spr_shadow = shd32;
size = 2;
canfly = 1;
team = 1;
z = 0;
rot = 0;
rdir = 1;
image_alpha = 0;
;
on_step = scrHMScriptRef(hm_bosses_guardianboss_mod_gml_GuardianStatue_step);
{ var __hm_with4 = scrHMInstances(scrHMBindDraw(hm_bosses_guardianboss_mod_gml_GuardianStatue_draw, (- 10))), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
zscale = 1;
var __hm_other7=scrHMOther(other);
creator = __hm_other7;
var __hm_other8=scrHMOther(other);
image_angle = __hm_other8.image_angle;
var __hm_other9=scrHMOther(other);
image_angle1 = __hm_other9.image_angle;
var __hm_other10=scrHMOther(other);
image_angle2 = __hm_other10.image_angle;
var __hm_other11=scrHMOther(other);
image_angle3 = __hm_other11.image_angle;
var __hm_other12=scrHMOther(other);
image_angle4 = __hm_other12.image_angle;
var __hm_other13=scrHMOther(other);
image_xscale = __hm_other13.image_xscale;
var __hm_other14=scrHMOther(other);
image_yscale = __hm_other14.image_yscale;
var __hm_other15=scrHMOther(other);
image_speed = ((__hm_other15.image_speed / timescale)) * timescale;
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

// Source bosses/guardianboss.mod.gml:61; GuardianStatue_draw
function hm_bosses_guardianboss_mod_gml_GuardianStatue_draw() {
if (instance_exists(creator)) {
{
image_angle = creator.image_angle;
image_angle1 = creator.image_angle1;
image_angle2 = creator.image_angle2;
image_angle3 = creator.image_angle3;
image_angle4 = creator.image_angle4;
spr_idle1 = global.hm_module_vars[$ "mod:bosses/guardianboss"].Statue1;
spr_idle2 = global.hm_module_vars[$ "mod:bosses/guardianboss"].Statue2;
spr_idle3 = global.hm_module_vars[$ "mod:bosses/guardianboss"].Statue3;
var _hml_i = undefined;
;
var _hml_j1 = 0;
;
var _hml_g1 = 0;
;
var _hml_j2 = 0;
;
var _hml_g2 = 0;
;
var _hml_j3 = 0;
;
var _hml_g3 = 0;
;
var _hml_j4 = 0;
;
var _hml_g4 = 0;
;
gpu_set_fog(0, 0, 0, 0);
_hml_j1 = 0;
_hml_g1 = 0;
_hml_j2 = 0;
_hml_g2 = 0;
_hml_j3 = 0;
_hml_g3 = 0;
_hml_j3 = 0;
_hml_g3 = 0;
_hml_j4 = 0;
_hml_g4 = 0;
draw_set_color(c_white);
;
draw_set_alpha(1);
;
for (_hml_i = 0; (_hml_i <= 6); _hml_i++) {
repeat (zscale) {
scrHMDrawSpriteExt(global.hm_module_vars[$ "mod:bosses/guardianboss"].GuardianStatueoutline1, clamp(_hml_i, 0, 5), creator.x, ((creator.y - (0.5 * (_hml_i + _hml_j1))) - creator.z), image_xscale, image_yscale, image_angle1, c_white, 1);
;
_hml_j1 += 1;
;
}
}
for (_hml_i = 0; (_hml_i <= 6); _hml_i++) {
repeat (zscale) {
scrHMDrawSpriteExt(global.hm_module_vars[$ "mod:bosses/guardianboss"].GuardianStatueoutline2, clamp(_hml_i, 0, 5), creator.x, (((creator.y - (0.5 * (_hml_i + _hml_j2))) - creator.z) - 6), image_xscale, image_yscale, image_angle2, c_white, 1);
;
_hml_j2 += 1;
;
}
}
for (_hml_i = 0; (_hml_i <= 6); _hml_i++) {
repeat (zscale) {
scrHMDrawSpriteExt(global.hm_module_vars[$ "mod:bosses/guardianboss"].GuardianStatueoutline2, clamp(_hml_i, 0, 5), creator.x, (((creator.y - (0.5 * (_hml_i + _hml_j3))) - creator.z) - 12), image_xscale, image_yscale, image_angle3, c_white, 1);
;
_hml_j3 += 1;
;
}
}
for (_hml_i = 0; (_hml_i <= 6); _hml_i++) {
repeat (zscale) {
scrHMDrawSpriteExt(global.hm_module_vars[$ "mod:bosses/guardianboss"].GuardianStatueoutline2, clamp(_hml_i, 0, 5), creator.x, (((creator.y - (0.5 * (_hml_i + _hml_j4))) - creator.z) - 18), image_xscale, image_yscale, image_angle4, c_white, 1);
;
_hml_j4 += 1;
;
}
}
for (_hml_i = 0; (_hml_i <= 6); _hml_i++) {
repeat (zscale) {
scrHMDrawSpriteExt(spr_idle1, clamp(_hml_i, 0, 5), creator.x, ((creator.y - (0.5 * (_hml_i + _hml_g1))) - creator.z), image_xscale, image_yscale, image_angle1, c_white, 1);
;
_hml_g1 += 1;
;
}
}
for (_hml_i = 0; (_hml_i <= 6); _hml_i++) {
repeat (zscale) {
scrHMDrawSpriteExt(spr_idle2, clamp(_hml_i, 0, 5), creator.x, (((creator.y - (0.5 * (_hml_i + _hml_g2))) - creator.z) - 6), image_xscale, image_yscale, image_angle2, c_white, 1);
;
_hml_g2 += 1;
;
}
}
for (_hml_i = 0; (_hml_i <= 6); _hml_i++) {
repeat (zscale) {
scrHMDrawSpriteExt(spr_idle2, clamp(_hml_i, 0, 5), creator.x, (((creator.y - (0.5 * (_hml_i + _hml_g3))) - creator.z) - 12), image_xscale, image_yscale, image_angle3, c_white, 1);
;
_hml_g3 += 1;
;
}
}
for (_hml_i = 0; (_hml_i <= 6); _hml_i++) {
repeat (zscale) {
scrHMDrawSpriteExt(spr_idle3, clamp(_hml_i, 0, 5), creator.x, (((creator.y - (0.5 * (_hml_i + _hml_g4))) - creator.z) - 18), image_xscale, image_yscale, image_angle4, c_white, 1);
;
_hml_g4 += 1;
;
}
}
}
} else {
instance_destroy();
}
}

// Source bosses/guardianboss.mod.gml:141; GuardianStatue_step
function hm_bosses_guardianboss_mod_gml_GuardianStatue_step() {
if ((distance_to_object(Player) < 100)) {
rot += rdir;
} else {
if ((rot > 0)) {
rot -= 1;
}
}
if ((rot < 0)) {
rot = 0;
}
image_angle1 += (rot / (10 - choose(0, 0, 0, 1)));
image_angle2 += (rot / (10 - choose(0, 0, 1)));
image_angle3 += (rot / (10 - choose(0, 1)));
image_angle4 += (rot / (10 - choose(1)));
if (((abs(random(rot)) > 30) and (random((10 - (rot / 50))) < 1))) {
{ var __hm_with1 = scrHMInstances(instance_create((x + random_range((- 6), 6)), (y - random(32)), LaserBrain)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
sprite_index = choose(sprPortalL1, sprPortalL2, sprPortalL3, sprPortalL4, sprPortalL5, sprPortalL1, sprPortalL2, sprPortalL3, sprPortalL4, sprPortalL5);
scrHMSoundPlay(asset_get_index(("sndPortalLightning" + string(irandom(8)))));
if ((random(3) < 1)) {
{
depth = (- 11);
scrHMSoundPlay(sndLightningHit);
}
}
}
}
if(__hm_break3) break;
}}
}
if (((rot > 200) and instance_exists(Player))) {
{
hm_bosses_guardianboss_mod_gml_guardianboss_create(x, y);
scrHMSoundPlay(sndExplosionL);
instance_destroy();
}
}
}

// Source bosses/guardianboss.mod.gml:175; guardianboss_create
function hm_bosses_guardianboss_mod_gml_guardianboss_create() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_guardianboss_mod_gml_guardianboss_create_resume, id, scrHMOther(other), _args, 8, []);
}
function hm_bosses_guardianboss_mod_gml_guardianboss_create_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_guardianboss_mod_gml_guardianboss_create");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/guardianboss.mod.gml:186
scrHMTaskWithNext(_hm);
break;
case 2: // bosses/guardianboss.mod.gml:186
scrHMTaskWithAbort(_hm);
break;
case 3: // bosses/guardianboss.mod.gml:251
{
if (instance_exists(id)) {
{
scrHMSoundMusic(mus100b);
if ((scrHMModExists("mod", "options", "intropan") and (scrHMModGet("mod", "options", "intropan") == "1"))) {
{
if ((UberCont.opt_bossintro == 1)) {
{
scrHMModCall("mod", "bossintros", "boss_trigger", "GREATER GUARDIAN", global.hm_module_vars[$ "mod:bosses/guardianboss"].guardianintrobg, global.hm_module_vars[$ "mod:bosses/guardianboss"].guardianintro, global.hm_module_vars[$ "mod:bosses/guardianboss"].guardianintrofg, id, 60);
;
}
}
}
}
}
}
}
_hm.pc=1;
break;
case 4: // bosses/guardianboss.mod.gml:250
_hm.wait_ticks=max(0,30); _hm.pc=3; return;
break;
case 5: // bosses/guardianboss.mod.gml:249
_hm.pc = (scrHMTaskFork(_hm, 4)) ? 4 : 1;
break;
case 6: // bosses/guardianboss.mod.gml:187
{
name = "guardianboss";
;
scrHMMaxHealthWrite(id, 420, "=");
scrHMMaxHealthWrite(id, ((max_hp / 2) * instance_number(Player)), "+=");
scrHMMaxHealthWrite(id, ((max_hp / 2) * GameCont.loops), "+=");
canfly = true;
;
spritealpha = 0;
;
size = 3;
;
friction = (0.40) * (timescale * timescale);
;
right = 1;
;
spr_idle = sprCrownGuardianIdle;
;
spr_walk = sprCrownGuardianIdle;
;
spr_hurt = sprCrownGuardianHurt;
;
spr_dead = sprCrownGuardianDead;
;
spr_fire = sprCrownGuardianFire;
;
sprite_index = spr_idle;
;
mask_index = mskNone;
;
{ var __hm_with1 = scrHMInstances(Wall), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
mask_index = mskNone;
;
}
}
if(__hm_break3) break;
}}
snd_hurt = sndCrownGuardianHurt;
;
snd_spc1 = sndCrownGuardianDisappear;
;
snd_spc2 = sndGuardianAppear;
;
snd_dead = sndCrownGuardianDead;
;
on_step = scrHMScriptRef(hm_bosses_guardianboss_mod_gml_guardianboss_step);
;
on_draw = scrHMScriptRef(hm_bosses_guardianboss_mod_gml_guardianboss_draw);
;
on_hurt = scrHMScriptRef(hm_bosses_guardianboss_mod_gml_guardianboss_hurt);
;
on_destroy = scrHMScriptRef(hm_bosses_guardianboss_mod_gml_guardianboss_dead);
;
_x = x;
;
_y = y;
;
x = (_x + lengthdir_x(128, random(360)));
;
y = (_y + lengthdir_y(128, random(360)));
;
burst = 0;
;
dir = point_direction(x, y, _x, _y);
;
spd = 7;
;
alrm0 = 0;
;
alrm1 = (30 * 5);
;
alrm2 = (30 * 8);
;
alrm3 = 0;
;
deathseq = (- 1);
;
fade = true;
;
{ var __hm_with4 = scrHMInstances(scrHMBindDraw(hm_bosses_guardianboss_mod_gml_guardianwall_draw, (- 10))), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
_rot = 0;
;
var __hm_other7=scrHMOther(other);
_x = __hm_other7._x;
;
var __hm_other8=scrHMOther(other);
_y = __hm_other8._y;
;
var __hm_other9=scrHMOther(other);
owner = __hm_other9.id;
;
alpha = 0;
;
spr_ind = sprGuardianIdle;
;
name = "guardianwall";
;
image_speed = (0.40) * timescale;
;
{ var __hm_with10 = scrHMInstances(scrHMBindDraw(hm_bosses_guardianboss_mod_gml_guardiandark_draw, (- 8))), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
var __hm_other13=scrHMOther(other);
owner = __hm_other13.id;
;
alpha = 0;
;
var __hm_other14=scrHMOther(other);
x = __hm_other14._x;
;
var __hm_other15=scrHMOther(other);
y = __hm_other15._y;
;
}
}
if(__hm_break12) break;
}}
}
}
if(__hm_break6) break;
}}
}
_hm.pc=5;
break;
case 7: // bosses/guardianboss.mod.gml:186
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create((_hm.vars.nearestfloor.x + 16), (_hm.vars.nearestfloor.y + 16), CustomEnemy)),6,0);
break;
case 8: // bosses/guardianboss.mod.gml:176
{
_hm.vars.nearestfloor = instance_nearest(_hm.args[0], _hm.args[1], Floor);
;
{ var __hm_with16 = scrHMInstances(enemy), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
hp = 0;
}
if(__hm_break18) break;
}}
;
{ var __hm_with19 = scrHMInstances(Debris), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
instance_destroy();
}
if(__hm_break21) break;
}}
;
{ var __hm_with22 = scrHMInstances(ChestOpen), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
instance_destroy();
}
if(__hm_break24) break;
}}
;
{ var __hm_with25 = scrHMInstances(SmallGenerator), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
{
x = 0;
;
y = 0;
;
instance_destroy();
;
}
}
if(__hm_break27) break;
}}
scrHMSoundPlay(sndCrownCurses);
;
}
_hm.pc=7;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/guardianboss.mod.gml:264; guardianboss_dead
function hm_bosses_guardianboss_mod_gml_guardianboss_dead() {
{ var __hm_with1 = scrHMInstances(Wall), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
mask_index = mskWall;
;
if (place_meeting(x, y, Player)) {
{
instance_create(x, y, PortalClear);
;
}
}
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(projectile), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
if ((team != 2)) {
{
{ var __hm_with7 = scrHMInstances(instance_create(x, y, ScorpionBulletHit)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
sprite_index = sprGuardianBulletHit;
;
}
}
if(__hm_break9) break;
}}
instance_destroy();
;
}
}
}
}
if(__hm_break6) break;
}}
hp = 0;
;
{ var __hm_with10 = scrHMInstances(instance_create(x, y, Portal)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
nompportal = 1;
}
if(__hm_break12) break;
}}
}

// Source bosses/guardianboss.mod.gml:283; guardianboss_hurt
function hm_bosses_guardianboss_mod_gml_guardianboss_hurt() {
if ((deathseq == (- 1))) {
{
if ((alrm0 > 5)) {
{
alrm0 -= argument0;
if ((alrm0 < 5)) {
alrm0 = 5;
}
}
}
if ((alrm2 > 10)) {
alrm2 -= min(argument0, (alrm2 - 1));
}
sprite_index = spr_hurt;
;
image_index = 0;
;
scrHMSoundPlay(snd_hurt);
;
hp -= argument0;
;
if ((hp <= 0)) {
{
hp = 9999;
;
deathseq = 30;
;
alrm3 = 60;
;
{ var __hm_with1 = scrHMMatching(CustomDraw, "name", "guardianwall"), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
spr_ind = sprGuardianHurt;
;
image_index = 0;
;
}
}
if(__hm_break3) break;
}}
}
}
{ var __hm_with4 = scrHMInstances((scrHMOther(other))), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
if (scrHMVariableExists(id, "typ")) {
{
if ((typ == 0)) {
var __hm_other7=scrHMOther(other);
__hm_other7.nexthurt = (current_frame + 5);
}
}
}
}
}
if(__hm_break6) break;
}}
}
}
}

// Source bosses/guardianboss.mod.gml:314; guardianboss_step
function hm_bosses_guardianboss_mod_gml_guardianboss_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_guardianboss_mod_gml_guardianboss_step_resume, id, scrHMOther(other), _args, 13, []);
}
function hm_bosses_guardianboss_mod_gml_guardianboss_step_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_guardianboss_mod_gml_guardianboss_step");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/guardianboss.mod.gml:480
scrHMTaskWithNext(_hm);
break;
case 2: // bosses/guardianboss.mod.gml:480
scrHMTaskWithAbort(_hm);
break;
case 3: // bosses/guardianboss.mod.gml:492
{
;
can_walk = 1;
;
maxspeed = _hm.vars._maxspd;
;
}
_hm.pc=1;
break;
case 4: // bosses/guardianboss.mod.gml:492
_hm.wait_ticks=max(0,5); _hm.pc=3; return;
break;
case 5: // bosses/guardianboss.mod.gml:491
{
can_walk = 0;
;
}
_hm.pc=4;
break;
case 6: // bosses/guardianboss.mod.gml:490
_hm.pc = (scrHMTaskFork(_hm, 5)) ? 5 : 1;
break;
case 7: // bosses/guardianboss.mod.gml:483
{
_hm.vars._maxspd = maxspeed;
;
sprite_index = spr_hurt;
;
image_index = 0;
;
scrHMSoundPlay(snd_hurt);
;
nexthurt = (current_frame + 10);
;
maxspeed = 6;
;
var __hm_other1=scrHMOther(other);
scrHMMotionAdd(point_direction(x, y, __hm_other1._x, __hm_other1._y), 12);
;
}
_hm.pc=6;
break;
case 8: // bosses/guardianboss.mod.gml:482
_hm.pc = (((point_distance(x, y, _hm.other_scope._x, _hm.other_scope._y) > 132) && (nexthurt <= current_frame))) ? 7 : 1;
break;
case 9: // bosses/guardianboss.mod.gml:497
{
if (can_walk) {
{
can_walk = false;
;
{ var __hm_with2 = scrHMInstances(scrHMBindDraw(hm_bosses_guardianboss_mod_gml_correctcoords, (- 10))), __hm_break4=false;
for (var __hm_index3=0; __hm_index3<array_length(__hm_with2); ++__hm_index3) {
if(instance_exists(__hm_with2[__hm_index3])) with (__hm_with2[__hm_index3]) {
{
sprite_index = sprGuardianDead;
;
image_index = image_number;
;
image_speed = ((- 0.40)) * timescale;
;
queuedestroy = 0;
;
alrm0 = 60;
;
var __hm_other5=scrHMOther(other);
slave = __hm_other5.id;
;
x = slave.x;
;
y = slave.y;
;
}
}
if(__hm_break4) break;
}}
}
}
}
_hm.pc=1;
break;
case 10: // bosses/guardianboss.mod.gml:481
_hm.pc = ((point_distance(x, y, _hm.other_scope._x, _hm.other_scope._y) < 256)) ? 8 : 9;
break;
case 11: // bosses/guardianboss.mod.gml:480
scrHMTaskWithEnter(_hm,scrHMInstances(Player),10,0);
break;
case 12: // bosses/guardianboss.mod.gml:479
_hm.pc = (instance_exists(_hm.scope)) ? 11 : 0;
break;
case 13: // bosses/guardianboss.mod.gml:315
{
speed = (0) * timescale;
;
if ((((floor(current_frame) mod 5) == 0) && (random(3) < 1))) {
{
scrHMSoundPlay(choose(sndGuardianAppear, sndGuardianDisappear));
}
}
{ var __hm_with6 = scrHMInstances(projectile), __hm_break8=false;
for (var __hm_index7=0; __hm_index7<array_length(__hm_with6); ++__hm_index7) {
if(instance_exists(__hm_with6[__hm_index7])) with (__hm_with6[__hm_index7]) {
{
if ((team != 2)) {
{
if ((point_distance(x, y, (scrHMOther(other))._x, (scrHMOther(other))._y) > (32 * 8))) {
{
instance_destroy();
;
}
}
}
} else {
{
if ((point_distance(x, y, (scrHMOther(other))._x, (scrHMOther(other))._y) > 132)) {
{
instance_destroy();
;
}
}
}
}
}
}
if(__hm_break8) break;
}}
{ var __hm_with9 = scrHMInstances(BigGuardianBullet), __hm_break11=false;
for (var __hm_index10=0; __hm_index10<array_length(__hm_with9); ++__hm_index10) {
if(instance_exists(__hm_with9[__hm_index10])) with (__hm_with9[__hm_index10]) {
{
if ((point_distance(x, y, (scrHMOther(other))._x, (scrHMOther(other))._y) > 128)) {
{
instance_destroy();
;
}
}
}
}
if(__hm_break11) break;
}}
if (((image_index + (image_speed / timescale)) >= image_number)) {
{
if ((deathseq == (- 1))) {
{
if ((sprite_index != spr_idle)) {
sprite_index = spr_idle;
}
image_index = 0;
;
}
} else {
{
image_index = (image_number - 1);
;
}
}
}
}
if (((spritealpha > 0) && fade)) {
{
spritealpha -= 0.10;
;
if (burst) {
spritealpha -= 0.20;
}
if ((((spritealpha <= 0) && (burst == (- 1))) && (hp < (max_hp * 0.33)))) {
{
burst = 2;
;
}
}
mask_index = mskNone;
;
}
}
if ((spritealpha < (1 & (! fade)))) {
{
spritealpha += 0.10;
;
if (burst) {
spritealpha += 0.20;
}
if (((spritealpha >= 1) && (burst > 0))) {
{
burst--;
;
alrm0 = 1;
;
}
}
mask_index = mskGuardianIdle;
;
}
}
if ((deathseq == (- 1))) {
{
if ((spd > 0)) {
{
x += lengthdir_x(spd, dir);
;
y += lengthdir_y(spd, dir);
;
spd *= 0.90;
;
if ((spd < 0.05)) {
spd = 0;
}
}
}
if ((spritealpha == 1)) {
{
x += lengthdir_x(sin((current_frame / 15)), (dir + (90 * right)));
;
y += lengthdir_y(cos((current_frame / 20)), (dir + (90 * right)));
;
}
}
if ((alrm0 && (! (-- alrm0)))) {
{
fade = true;
;
dir = point_direction(_x, _y, x, y);
;
spd = 4;
;
scrHMSoundPlay(snd_spc1);
;
alrm1 = 30;
;
}
}
if ((alrm1 && (! (-- alrm1)))) {
{
_hm.vars.rando = random(360);
;
x = (_x + lengthdir_x(128, _hm.vars.rando));
;
y = (_y + lengthdir_y(128, _hm.vars.rando));
;
dir = point_direction(x, y, _x, _y);
;
if ((x > _x)) {
right = (- 1);
} else {
right = 1;
}
;
spd = 4;
;
alrm0 = (30 * 4);
;
scrHMSoundPlay(snd_spc2);
;
alrm2 = round((30 * random_range(1, 3)));
;
if ((hp < (max_hp * 0.33))) {
{
alrm0 *= 0.75;
;
alrm2 *= 0.50;
;
}
}
if ((burst == 0)) {
burst--;
}
fade = false;
;
}
}
if (((alrm2 && (! (-- alrm2))) && (! fade))) {
{
if (instance_exists(Player)) {
{
sprite_index = spr_fire;
;
image_index = 0;
;
_hm.vars.nearest = instance_nearest(x, y, Player);
;
{ var __hm_with12 = scrHMInstances(instance_create(x, y, BigGuardianBullet)), __hm_break14=false;
for (var __hm_index13=0; __hm_index13<array_length(__hm_with12); ++__hm_index13) {
if(instance_exists(__hm_with12[__hm_index13])) with (__hm_with12[__hm_index13]) {
{
var __hm_other15=scrHMOther(other);
team = __hm_other15.team;
;
speed = (8) * timescale;
;
direction = point_direction(x, y, _hm.vars.nearest.x, _hm.vars.nearest.y);
;
hitid = [sprCrownGuardianIdle, "GREATER GUARDIAN"];
;
if (((hspeed / timescale) < 0)) {
var __hm_other16=scrHMOther(other);
__hm_other16.right = (- 1);
} else {
var __hm_other17=scrHMOther(other);
__hm_other17.right = 1;
}
;
}
}
if(__hm_break14) break;
}}
alrm0 += 30;
;
alrm2 = max(30, round(((30 * random_range(0.5, 4)) * max((1 - (GameCont.loops * 0.10)), 0.33))));
;
if ((hp < (max_hp * 0.33))) {
{
alrm2 = max((alrm2 * 0.80), 10);
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
if ((alrm3 && (! (-- alrm3)))) {
{
_hm.vars.wid = (sprite_get_width(spr_idle) / 3);
;
image_index = 0;
;
scrHMSoundPlay(snd_hurt);
;
{ var __hm_with18 = scrHMInstances(instance_create((x + random_range((- _hm.vars.wid), _hm.vars.wid)), (y + random_range((- _hm.vars.wid), _hm.vars.wid)), SmallExplosion)), __hm_break20=false;
for (var __hm_index19=0; __hm_index19<array_length(__hm_with18); ++__hm_index19) {
if(instance_exists(__hm_with18[__hm_index19])) with (__hm_with18[__hm_index19]) {
{
hitid = [sprCrownGuardianHurt, "GREATER GUARDIAN"];
;
_hm.vars._dir = point_direction((scrHMOther(other)).x, (scrHMOther(other)).y, x, y);
;
{ var __hm_with21 = scrHMInstances(instance_create((scrHMOther(other)).x, (scrHMOther(other)).y, Rad)), __hm_break23=false;
for (var __hm_index22=0; __hm_index22<array_length(__hm_with21); ++__hm_index22) {
if(instance_exists(__hm_with21[__hm_index22])) with (__hm_with21[__hm_index22]) {
{
direction = _hm.vars._dir;
;
speed = ((3 + random(3))) * timescale;
;
}
}
if(__hm_break23) break;
}}
}
}
if(__hm_break20) break;
}}
{ var __hm_with24 = scrHMMatching(CustomDraw, "name", "guardianwall"), __hm_break26=false;
for (var __hm_index25=0; __hm_index25<array_length(__hm_with24); ++__hm_index25) {
if(instance_exists(__hm_with24[__hm_index25])) with (__hm_with24[__hm_index25]) {
{
spr_ind = sprGuardianHurt;
;
image_index = 0;
;
}
}
if(__hm_break26) break;
}}
if ((deathseq == 1)) {
{
{ var __hm_with27 = scrHMInstances(instance_create(x, y, SmallExplosion)), __hm_break29=false;
for (var __hm_index28=0; __hm_index28<array_length(__hm_with27); ++__hm_index28) {
if(instance_exists(__hm_with27[__hm_index28])) with (__hm_with27[__hm_index28]) {
{
hitid = [sprCrownGuardianHurt, "GREATER GUARDIAN"];
;
}
}
if(__hm_break29) break;
}}
alrm3 = 60;
;
deathseq -= 1;
;
}
} else {
if ((deathseq == 0)) {
{
{ var __hm_with30 = scrHMMatching(CustomDraw, "name", "guardianwall"), __hm_break32=false;
for (var __hm_index31=0; __hm_index31<array_length(__hm_with30); ++__hm_index31) {
if(instance_exists(__hm_with30[__hm_index31])) with (__hm_with30[__hm_index31]) {
{
spr_ind = sprGuardianDead;
;
image_index = 0;
;
}
}
if(__hm_break32) break;
}}
repeat (8) {
{ var __hm_with33 = scrHMInstances(instance_create((x + random_range((- 16), 16)), (y + random_range((- 16), 16)), GreenExplosion)), __hm_break35=false;
for (var __hm_index34=0; __hm_index34<array_length(__hm_with33); ++__hm_index34) {
if(instance_exists(__hm_with33[__hm_index34])) with (__hm_with33[__hm_index34]) {
{
hitid = [sprCrownGuardianHurt, "GREATER GUARDIAN"];
;
image_index = 1;
;
}
}
if(__hm_break35) break;
}}
{ var __hm_with36 = scrHMInstances(instance_create(x, y, BigRad)), __hm_break38=false;
for (var __hm_index37=0; __hm_index37<array_length(__hm_with36); ++__hm_index37) {
if(instance_exists(__hm_with36[__hm_index37])) with (__hm_with36[__hm_index37]) {
{
speed = ((5 + random(3))) * timescale;
;
direction = random(360);
;
}
}
if(__hm_break38) break;
}}
}
repeat (32) {
{ var __hm_with39 = scrHMInstances(instance_create(x, y, Rad)), __hm_break41=false;
for (var __hm_index40=0; __hm_index40<array_length(__hm_with39); ++__hm_index40) {
if(instance_exists(__hm_with39[__hm_index40])) with (__hm_with39[__hm_index40]) {
{
speed = ((7 + random(3))) * timescale;
;
direction = random(360);
;
}
}
if(__hm_break41) break;
}}
}
{ var __hm_with42 = scrHMInstances(instance_create(x, y, Corpse)), __hm_break44=false;
for (var __hm_index43=0; __hm_index43<array_length(__hm_with42); ++__hm_index43) {
if(instance_exists(__hm_with42[__hm_index43])) with (__hm_with42[__hm_index43]) {
{
var __hm_other45=scrHMOther(other);
sprite_index = __hm_other45.spr_dead;
;
}
}
if(__hm_break44) break;
}}
scrHMSoundPlay(snd_dead);
;
instance_destroy();
;
}
} else {
{
alrm3 = ceil((deathseq / 2));
;
deathseq -= 1;
;
}
}
}
}
}
}
}
}
_hm.pc=12;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/guardianboss.mod.gml:515; correctcoords
function hm_bosses_guardianboss_mod_gml_correctcoords() {
if ((! instance_exists(slave))) {
{
if ((alrm0 > 1)) {
alrm0 = 1;
}
}
} else {
{
slave.x = x;
;
slave.y = y;
;
}
}
if (((image_index + (image_speed / timescale)) < 0)) {
{
image_speed = (0.40) * timescale;
;
image_index = 0;
;
sprite_index = sprGuardianIdle;
;
}
}
if ((((image_index + (image_speed / timescale)) >= image_number) && (sprite_index == sprGuardianDead))) {
queuedestroy = 1;
}
if ((alrm0 && (! (-- alrm0)))) {
{
image_speed = (0.40) * timescale;
;
image_index = 0;
;
sprite_index = sprGuardianDead;
;
{ var __hm_with1 = scrHMMatching(CustomDraw, "name", "guardianwall"), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var __hm_other4=scrHMOther(other);
__hm_other4.x = _x;
;
var __hm_other5=scrHMOther(other);
__hm_other5.y = _y;
;
}
}
if(__hm_break3) break;
}}
}
}
scrHMDrawSprite(sprite_index, image_index, x, y);
;
if (queuedestroy) {
{
if (instance_exists(slave)) {
{
slave.can_walk = true;
;
}
}
instance_destroy();
;
}
}
}

// Source bosses/guardianboss.mod.gml:544; guardiandark_draw
function hm_bosses_guardianboss_mod_gml_guardiandark_draw() {
{ var __hm_with1 = scrHMInstances(projectile), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((depth > (- 10))) {
if(scrHMReadyTick()) { depth = (- 10); }
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(Explosion), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if ((depth > (- 10))) {
if(scrHMReadyTick()) { depth = (- 11); }
}
}
if(__hm_break6) break;
}}
{ var __hm_with7 = scrHMInstances(Pickup), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
if ((depth > (- 10))) {
if(scrHMReadyTick()) { depth = (- 10); }
}
}
if(__hm_break9) break;
}}
{ var __hm_with10 = scrHMInstances(Effect), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
if ((depth > (- 10))) {
if(scrHMReadyTick()) { depth = (- 10); }
}
}
if(__hm_break12) break;
}}
{ var __hm_with13 = scrHMInstances(CrystalShield), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
if ((depth > (- 10))) {
if(scrHMReadyTick()) { depth = (- 10); }
}
}
if(__hm_break15) break;
}}
{ var __hm_with16 = scrHMInstances(CrystalShieldDisappear), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
if ((depth > (- 10))) {
if(scrHMReadyTick()) { depth = (- 10); }
}
}
if(__hm_break18) break;
}}
{ var __hm_with19 = scrHMInstances(PortalStrike), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
if ((depth > (- 9))) {
if(scrHMReadyTick()) { depth = (- 9); }
}
}
if(__hm_break21) break;
}}
draw_set_alpha(alpha);
;
draw_set_color(c_black);
;
draw_rectangle(view_xview, view_yview, (view_xview + view_width), (view_yview + view_height), 0);
;
draw_set_alpha(1);
;
draw_set_color(c_white);
;
{ var __hm_with22 = scrHMInstances(hitme), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
{
event_perform(ev_draw, 0);
;
}
}
if(__hm_break24) break;
}}
if (instance_exists(owner)) {
{
if ((alpha < 1)) {
if(scrHMReadyTick()) { alpha += 0.05; }
}
if (((alpha > 0.5) && (TopCont.darkness == 0))) {
if(scrHMReadyTick()) { TopCont.darkness = 1; }
}
}
} else {
{
if(scrHMReadyTick()) { alpha -= 0.05; }
;
if ((alpha <= 0.5)) {
{
if(scrHMReadyTick()) { TopCont.darkness = 0; }
;
{ var __hm_with25 = scrHMInstances(Player), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
{
if ((! place_meeting(x, y, Floor))) {
{
var _hml_nearest = instance_nearest(x, y, Floor);
;
if(scrHMReadyTick()) { x = (_hml_nearest.x + 16); }
;
if(scrHMReadyTick()) { y = (_hml_nearest.y + 16); }
;
instance_create(x, y, PortalClear);
;
}
}
if (place_meeting(x, y, Wall)) {
{
instance_create(x, y, PortalClear);
;
}
}
}
}
if(__hm_break27) break;
}}
}
}
if ((alpha <= 0)) {
instance_destroy();
}
}
}
}

// Source bosses/guardianboss.mod.gml:583; guardianboss_draw
function hm_bosses_guardianboss_mod_gml_guardianboss_draw() {
scrHMDrawSpriteExt(sprite_index, image_index, x, y, right, 1, 0, c_white, spritealpha);
;
}

// Source bosses/guardianboss.mod.gml:587; guardianwall_draw
function hm_bosses_guardianboss_mod_gml_guardianwall_draw() {
var _hml__amount = undefined;
var _hml__len = undefined;
var _hml__dir = undefined;
;
_hml__amount = 24;
;
_hml__len = 96;
;
_hml__dir = (360 / _hml__amount);
;
if ((spr_ind == sprGuardianIdle)) {
if(scrHMReadyTick()) { _rot += 0.75; }
}
for (var _hml_i = 0; (_hml_i < _hml__amount); _hml_i++) {
var _hml__xsc = 1;
;
for (var _hml_o = 3; (_hml_o >= 1); _hml_o--) {
var _hml__X = (_x - lengthdir_x((_hml__len * (1 + (0.50 * _hml_o))), ((_hml__dir * _hml_i) + (_rot * (1 / _hml_o)))));
;
var _hml__Y = (_y + lengthdir_y((_hml__len * (1 + (0.50 * _hml_o))), ((_hml__dir * _hml_i) + (_rot * (1 / _hml_o)))));
;
if ((_hml__X > _x)) {
_hml__xsc = (- 1);
} else {
_hml__xsc = 1;
}
;
var _hml_img_ind = undefined;
;
if ((spr_ind != sprGuardianIdle)) {
{
_hml_img_ind = median(0, image_index, (sprite_get_number(spr_ind) - 1));
;
}
} else {
{
_hml_img_ind = (((_hml_i * _hml__amount) + (current_frame * 0.40)) mod sprite_get_number(spr_ind));
;
}
}
scrHMDrawSpriteExt(spr_ind, _hml_img_ind, _hml__X, _hml__Y, _hml__xsc, 1, 0, c_white, alpha);
;
if ((spr_ind == sprGuardianIdle)) {
{
if (scrHMReadyTick() && ((((floor(current_frame) mod 10) == 0) && (random((250 - (5 * GameCont.loops))) < 1)))) {
{
for (var _hml_i = (- 1); (_hml_i <= 1); _hml_i++) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__X, _hml__Y, GuardianBullet)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if(scrHMReadyTick()) { team = 1; }
;
if(scrHMReadyTick()) { speed = (1.5) * timescale; }
;
if(scrHMReadyTick()) { damage = 3; }
;
if(scrHMReadyTick()) { hitid = [sprGuardianIdle, "LESSER GUARDIAN"]; }
;
scrHMSoundPlay(sndGuardianFire);
if ((! instance_exists(Player))) {
{
if(scrHMReadyTick()) { var __hm_other4=scrHMOther(other);
direction = (point_direction(x, y, __hm_other4._x, __hm_other4._y) + (15 * _hml_i)); }
;
}
} else {
{
var _hml_nearest = instance_nearest(x, y, Player);
;
if(scrHMReadyTick()) { direction = (point_direction(x, y, _hml_nearest.x, _hml_nearest.y) + (15 * _hml_i)); }
;
}
}
}
}
if(__hm_break3) break;
}}
}
}
}
}
}
}
}
if (instance_exists(owner)) {
{
if ((alpha < 1)) {
if(scrHMReadyTick()) { alpha += 0.125; }
}
}
} else {
{
if(scrHMReadyTick()) { alpha -= 0.05; }
;
if ((alpha <= 0)) {
instance_destroy();
}
}
}
}
