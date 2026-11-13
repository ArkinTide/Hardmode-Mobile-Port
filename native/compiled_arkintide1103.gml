// Source arkintide.mod.gml:0; __load (native content 1.1.0)
function hm_arkintide_mod_gml___load() {
global.hm_module_vars[$ "mod:arkintide"].tank_warning = sprHMContent1100_1;
;
global.hm_module_vars[$ "mod:arkintide"].van_warning = sprHMContent1100_2;
;
global.hm_module_vars[$ "mod:arkintide"].hm_extra_dead_sources = [];
;
global.hm_module_vars[$ "mod:arkintide"].hm_extra_dead_copies = [];
;
global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_idle = sprHMContent1100_4;
;
global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_walk = sprHMContent1100_5;
;
global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_fire = sprHMContent1100_6;
;
global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_tell = sprHMContent1100_7;
;
global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_dash = sprHMContent1100_8;
;
global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_stop = sprHMContent1100_9;
;
global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_hurt = sprHMContent1100_10;
;
global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_dead = sprHMContent1100_11;
;
global.hm_module_vars[$ "mod:arkintide"].hm_extra_cursed_idle = sprHMContent1100_12;
;
global.hm_module_vars[$ "mod:arkintide"].hm_extra_cursed_hurt = sprHMContent1100_13;
;
global.hm_module_vars[$ "mod:arkintide"].hm_ice_spider_idle = sprHMContent1100_14;
global.hm_module_vars[$ "mod:arkintide"].hm_ice_spider_walk = sprHMContent1100_15;
global.hm_module_vars[$ "mod:arkintide"].hm_ice_spider_hurt = sprHMContent1100_16;
global.hm_module_vars[$ "mod:arkintide"].hm_ice_spider_dead = sprHMContent1100_17;
global.hm_module_vars[$ "mod:arkintide"].hm_revision = "ntt100034";
;
}

// Source arkintide.mod.gml:0; hm_boss_count (native content 1.1.0)
function hm_arkintide_mod_gml_hm_boss_count() {
return (1 + floor((max(0, GameCont.loops) / 2)));
;
}

// Source arkintide.mod.gml:0; hm_radiation (native content 1.1.0)
function hm_arkintide_mod_gml_hm_radiation(_hml__below) {
if ((((scrHMVariableExists(id, "hm_rad_policy_kind") && (hm_rad_policy_kind == object_index)) && (scrHMAreaResolve(hm_rad_policy_area) == GameCont.area)) && (hm_rad_policy_below == _hml__below))) {
exit;
}
hm_rad_policy_kind = object_index;
;
hm_rad_policy_area = GameCont.area;
;
hm_rad_policy_below = _hml__below;
;
if ((scrHMVariableExists(id, "hm_rad_fixed") && hm_rad_fixed)) {
exit;
}
if (((object_index == HostileHorror) && ((GameCont.area == scrHMAreaResolve("palace")) || scrHMVariableExists(id, "hm_horror")))) {
exit;
}
if ((object_index == DogGuardian)) {
{
if ((!scrHMVariableExists(id, "hm_dog_delta"))) {
hm_dog_delta = 0;
}
var _hml_dog_delta = 0;
;
if (_hml__below) {
_hml_dog_delta = (- 10);
}
raddrop += (_hml_dog_delta - hm_dog_delta);
;
hm_dog_delta = _hml_dog_delta;
;
exit;
;
}
}
if (((object_index == Raven) || (object_index == SnowBot))) {
{
if ((!scrHMVariableExists(id, "hm_one_rad_base"))) {
hm_one_rad_base = raddrop;
}
if ((!scrHMVariableExists(id, "hm_one_rad_delta"))) {
hm_one_rad_delta = 0;
}
var _hml_one_rad_delta = 0;
;
if (_hml__below) {
_hml_one_rad_delta = (1 - hm_one_rad_base);
}
raddrop += (_hml_one_rad_delta - hm_one_rad_delta);
;
hm_one_rad_delta = _hml_one_rad_delta;
;
exit;
;
}
}
if ((!scrHMVariableExists(id, "hm_rad_delta"))) {
hm_rad_delta = 0;
}
if ((!scrHMVariableExists(id, "hm_rad_request"))) {
hm_rad_request = 0;
}
if ((!scrHMVariableExists(id, "hm_rad_green"))) {
hm_rad_green = 0;
}
if ((!scrHMVariableExists(id, "hm_rad_bone"))) {
hm_rad_bone = 0;
}
if ((!scrHMVariableExists(id, "hm_rad_initialized"))) {
hm_rad_initialized = 0;
}
var _hml_green = 0;
var _hml_bone = 0;
;
if (((! _hml__below) && (object_index == FastRat))) {
_hml_green = 4;
}
if ((((! _hml__below) && (object_index == BoneFish)) && (GameCont.area == scrHMAreaResolve("oasis")))) {
_hml_bone = 8;
}
raddrop += (((_hml_green - hm_rad_green) + _hml_bone) - hm_rad_bone);
;
hm_rad_green = _hml_green;
;
hm_rad_bone = _hml_bone;
;
if (_hml__below) {
{
if ((! hm_rad_initialized)) {
{
var _hml_original = raddrop;
;
if ((object_index == RadMaggot)) {
raddrop = 1;
} else {
if ((raddrop <= 4)) {
raddrop = 0;
} else {
raddrop -= 4;
}
}
;
hm_rad_delta = (_hml_original - raddrop);
;
hm_rad_initialized = 1;
;
}
}
}
} else {
if (hm_rad_initialized) {
{
raddrop += hm_rad_delta;
;
hm_rad_delta = 0;
;
hm_rad_initialized = 0;
;
}
}
}
var _hml_request = 0;
;
if (_hml__below) {
{
if ((((object_index == LaserCrystal) || (object_index == LightningCrystal)) || (object_index == InvLaserCrystal))) {
_hml_request = (- 10);
}
}
}
raddrop += (_hml_request - hm_rad_request);
;
hm_rad_request = _hml_request;
;
}

// Source arkintide.mod.gml:0; hm_rat_enabled (native content 1.1.0)
function hm_arkintide_mod_gml_hm_rat_enabled() {
return ((! scrHMModExists("mod", "options", "ratrevive")) || (scrHMModGet("mod", "options", "ratrevive") == "1"));
;
}

// Source arkintide.mod.gml:0; hm_keep_plasma (native content 1.1.0)
function hm_arkintide_mod_gml_hm_keep_plasma() {
if (((object_index != PlasmaBig) && (object_index != PlasmaHuge))) {
return false;
}
if (scrHMVariableExists(id, "team")) {
return (team == 2);
}
return (((scrHMVariableExists(id, "creator") && instance_exists(creator)) && scrHMVariableExists(creator, "team")) && (creator.team == 2));
;
}

// Source arkintide.mod.gml:0; hm_beam_distance (native content 1.1.0)
function hm_arkintide_mod_gml_hm_beam_distance(_hml__x, _hml__y, _hml__angle) {
var _hml_dx = lengthdir_x(4096, _hml__angle);
var _hml_dy = lengthdir_y(4096, _hml__angle);
;
var _hml_hit = collision_line(_hml__x, _hml__y, (_hml__x + _hml_dx), (_hml__y + _hml_dy), Wall, false, true);
;
if ((! instance_exists(_hml_hit))) {
return 4096;
}
var _hml_low = 0;
var _hml_high = 1024;
;
while (((_hml_high - _hml_low) > 1)) {
var _hml_mid = ((_hml_low + _hml_high) div 2);
;
if ((collision_line(_hml__x, _hml__y, (_hml__x + lengthdir_x((_hml_mid * 4), _hml__angle)), (_hml__y + lengthdir_y((_hml_mid * 4), _hml__angle)), Wall, false, true) != noone)) {
_hml_high = _hml_mid;
} else {
_hml_low = _hml_mid;
}
;
}
return max(4, (_hml_high * 4));
;
}

// Source arkintide.mod.gml:0; hm_tank_base (native content 1.1.0)
function hm_arkintide_mod_gml_hm_tank_base() {
if ((!scrHMVariableExists(id, "hm_tank_rads"))) {
hm_tank_rads = 0;
}
var _hml_amount = 0;
;
if ((GameCont.loops >= 3)) {
_hml_amount = 70;
}
raddrop += (_hml_amount - hm_tank_rads);
;
hm_tank_rads = _hml_amount;
;
}

// Source arkintide.mod.gml:0; hm_tank_supplies (native content 1.1.0)
function hm_arkintide_mod_gml_hm_tank_supplies() {
if (((GameCont.loops < 3) || (scrHMVariableExists(id, "hm_supplied") && hm_supplied))) {
exit;
}
hm_supplied = 1;
;
repeat (2) { var __hm_with1 = scrHMInstances(instance_create(x, y, choose(AmmoPickup, HPPickup))), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMMotionAdd(random(360), 2);
}
if(__hm_break3) break;
}}
;
}

// Source arkintide.mod.gml:0; hm_tank_aim (native content 1.1.0)
function hm_arkintide_mod_gml_hm_tank_aim() {
if (((charge < 0.8) && instance_exists(creator))) {
aim -= clamp(angle_difference(aim, creator.gunangle), ((- 0.5) * 1), (0.5 * 1));
}
}

// Source arkintide.mod.gml:0; hm_police_spawn (native content 1.1.0)
function hm_arkintide_mod_gml_hm_police_spawn(_hml__x, _hml__y) {
if ((! hm_arkintide_mod_gml_hm_police_allowed())) {
return noone;
}
var _hml_kind = scrHMPoliceKind1116();
return instance_create(_hml__x, _hml__y, _hml_kind);
;
}

// Source arkintide.mod.gml:0; hm_van_crater (native content 1.1.0)
function hm_arkintide_mod_gml_hm_van_crater() {
depth = 4;
;
image_xscale = 1;
;
image_yscale = 1;
;
repeat (2) { var __hm_with1 = scrHMInstances(instance_create((x + choose((- 16), 16)), (y + choose((- 6), 6)), Effect)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
sprite_index = sprScorch;
;
depth = 4;
;
image_xscale = 1;
;
image_yscale = 1;
;
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_spawn_warning (native content 1.1.0)
function hm_arkintide_mod_gml_hm_spawn_warning(_hml__x, _hml__y, _hml__kind, _hml__angle) {
if ((((! hm_arkintide_mod_gml_hm_police_allowed()) || (GameCont.area == scrHMAreaResolve("throne"))) || (_hml__kind != 1))) {
return noone;
}
var _hml_gate = instance_create(_hml__x, _hml__y, CustomObject);
;
{ var __hm_with1 = scrHMInstances(_hml_gate), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "hm_robot_gate";
;
hm_warning_kind = 1;
;
hm_angle = _hml__angle;
;
hm_phase = 0;
;
hm_wait = max(1, (sprite_get_number(sprVanPortalStart) * 2.5));
;
hm_spawned = 0;
;
hm_fx_wait = 0;
;
hm_gate_area = GameCont.area;
;
hm_gate_sub = GameCont.subarea;
;
hm_gate_loop = GameCont.loops;
;
sprite_visible = false;
;
image_speed = (0) * timescale;
;
depth = (- 7);
;
on_step = scrHMContentRef1100("mod", "arkintide", "hm_warning_step");
;
on_draw = scrHMContentRef1100("mod", "arkintide", "hm_warning_draw");
;
scrHMSoundPlay(sndVanWarning);
;
}
}
if(__hm_break3) break;
}}
return _hml_gate;
;
}

// Source arkintide.mod.gml:0; hm_warning_icon (native content 1.1.0)
function hm_arkintide_mod_gml_hm_warning_icon(_hml__x, _hml__y, _hml__kind) {
var _hml_icon = global.hm_module_vars[$ "mod:arkintide"].tank_warning;
;
if ((_hml__kind == 0)) {
_hml_icon = global.hm_module_vars[$ "mod:arkintide"].van_warning;
}
if (sprite_exists(_hml_icon)) {
scrHMDrawSpriteExt(_hml_icon, 0, (_hml__x - 6), (_hml__y - 48), 1, 1, 0, c_white, 1);
}
var _hml_col = draw_get_color();
var _hml_alpha = draw_get_alpha();
;
draw_set_color(c_red);
;
draw_set_alpha(1);
;
draw_rectangle((_hml__x + 9), (_hml__y - 54), (_hml__x + 11), (_hml__y - 46), false);
;
draw_rectangle((_hml__x + 9), (_hml__y - 43), (_hml__x + 11), (_hml__y - 41), false);
;
draw_set_color(_hml_col);
;
draw_set_alpha(_hml_alpha);
;
}

// Source arkintide.mod.gml:0; hm_raven_leader (native content 1.1.0)
function hm_arkintide_mod_gml_hm_raven_leader() {
if ((scrHMVariableExists(id, "hm_extra") && hm_extra)) {
return false;
}
var _hml_leader = id;
;
{ var __hm_with1 = scrHMMatching(CustomEnemy, "name", "BIG BIRD"), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((((hp > 0) && (! (scrHMVariableExists(id, "hm_extra") && hm_extra))) && (id < _hml_leader))) {
_hml_leader = id;
}
}
if(__hm_break3) break;
}}
return (_hml_leader == id);
;
}

// Source arkintide.mod.gml:0; hm_map_budget (native content 1.1.0)
function hm_arkintide_mod_gml_hm_map_budget() {
scrHMLoopMapSetup110();
}


// Source arkintide.mod.gml:0; hm_loop_population (native content 1.1.0)
function hm_arkintide_mod_gml_hm_loop_population(_hml__region) {
if (((GameCont.loops <= 0) || position_meeting((x + 16), (y + 16), Wall))) {
exit;
}
var _hml_pool = [];
;
switch (_hml__region) {
case 1:
_hml_pool = [Scorpion, Scorpion, Bandit, Bandit, Maggot, JungleFly, JungleFly, MeleeBandit, Sniper];
;
break;
;
case 2:
_hml_pool = [Ratking, Ratking, BuffGator, LaserCrystal, Rat, Exploder, Exploder, SuperFireBaller];
;
break;
;
case 3:
_hml_pool = [Sniper, Sniper, MeleeFake, MeleeFake, Salamander, SnowBot, Raven, BuffGator, Raven];
;
break;
;
case 4:
_hml_pool = [LaserCrystal, LaserCrystal, LaserCrystal, RhinoFreak, LightningCrystal, BuffGator, ExploFreak, Spider, Spider];
;
break;
;
case 5:
_hml_pool = [SnowTank, SnowTank, DogGuardian, ExploGuardian, SnowBot, SnowBot, SnowBot, Wolf, Necromancer, Bandit, JungleBandit];
;
break;
;
case 6:
_hml_pool = [Ratking, RhinoFreak, ExploFreak, Necromancer, RhinoFreak, LaserCrystal, BecomeTurret];
;
break;
;
case 7:
_hml_pool = [ExploGuardian, DogGuardian, Sniper, DogGuardian, ExploGuardian, ExploFreak, JungleBandit, JungleBandit];
;
break;
;
}
if(_hml__region==7 && GameCont.loops>=3) array_push(_hml_pool,CrownGuardian);
if ((((array_length(_hml_pool) > 0) && (random(2) < random(GameCont.loops))) && (collision_circle((x + 16), (y + 16), 12, Wall, false, true) == noone))) {
{
var _hml_allow = 1;
;
if (((_hml__region == 3) && (random(5) >= 4))) {
_hml_allow = 0;
}
if ((((_hml__region == 3) && (GameCont.subarea == 5)) && (random(2) >= 1))) {
_hml_allow = 0;
}
if (((_hml__region == 7) && (random(2) >= 1))) {
_hml_allow = 0;
}
if (_hml_allow) {
{
var _hml_kind = _hml_pool[irandom((array_length(_hml_pool) - 1))];
var _hml_actor = noone;
;
if (((_hml__region == 5) && (_hml_kind == Bandit))) {
_hml_actor = scrHMModCall("mod", "enemies", "elitebandit_create", (x + 16), (y + 16), 0);
} else {
_hml_actor = _hml_kind==CrownGuardian?scrHMPalaceGuardianCreate1103(x+16,y+16):instance_create((x + 16), (y + 16), _hml_kind);
}
;
if (instance_exists(_hml_actor)) {
_hml_actor.hm_native_loop = 1;
}
}
}
}
}
if (((((_hml__region == 4) || (_hml__region == 5)) && (random(32) < 1)) && (collision_circle((x + 16), (y + 16), 12, Wall, false, true) == noone))) {
{
var _hml_count = 0;
;
{ var __hm_with1 = scrHMInstances(CustomEnemy), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((spr_idle == scrHMModGet("mod", "enemies", "EliteSpiderIdle"))) {
_hml_count++;
}
}
if(__hm_break3) break;
}}
if ((_hml_count < 4)) {
scrHMModCall("mod", "enemies", "EliteSpider_create", (x + 16), (y + 16));
}
}
}
if (((_hml__region == 4) && (random(32) < 1))) {
scrHMModCall("mod", "enemies", "bigcrystal_create", (x + 16), (y + 16));
}
if (((_hml__region == 3) && (random(32) < 1))) {
scrHMModCall("mod", "enemies", "Minigunner_create", (x + 16), (y + 16));
}
if ((((_hml__region == 2) || ((_hml__region == 3) && (GameCont.subarea >= 4))) && (random(16) < 1))) {
instance_create((x + 16), (y + 16), BuffGator);
}
if (((((_hml__region == 4) && (GameCont.area == scrHMAreaResolve("caves"))) && (GameCont.loops >= 3)) && (random(48) < 1))) {
instance_create((x + 16), (y + 16), InvLaserCrystal);
}
if (((((_hml__region == 1) || ((_hml__region == 4) && (GameCont.area == scrHMAreaResolve("caves")))) && (GameCont.loops >= 3)) && (random(32) < 1))) {
instance_create((x + 16), (y + 16), JungleBandit);
}
if ((((_hml__region == 2) || (_hml__region == 3)) && (random(48) < 1))) {
scrHMModCall("mod", "enemies", "Monster_create", (x + 16), (y + 16));
}
}

// Source arkintide.mod.gml:0; hm_minigun_shot (native content 1.1.0)
function hm_arkintide_mod_gml_hm_minigun_shot() {
scrHMSoundPitchVolume(sndMinigun, 0.9, min(1, ((view_width / 4) / max(1, distance_to_object(Player)))));
;
{ var __hm_with1 = scrHMInstances(instance_create((x + lengthdir_x(4, gunangle)), (y + lengthdir_y(4, gunangle)), EnemyBullet4)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var __hm_other4=scrHMOther(other);
scrHMMotionAdd(__hm_other4.gunangle, 16);
;
image_angle = direction;
;
var __hm_other5=scrHMOther(other);
hitid = __hm_other5.hitid;
;
var __hm_other6=scrHMOther(other);
team = __hm_other6.team;
;
var __hm_other7=scrHMOther(other);
creator = __hm_other7;
;
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_dual_canister (native content 1.1.0)
function hm_arkintide_mod_gml_hm_dual_canister() {
if (scrHMVariableExists(id, "hm_extra_canister")) {
exit;
}
hm_extra_canister = 1;
;
for (var _hml_r = 24; (_hml_r <= 72); _hml_r += 16) for (var _hml_a = 0; (_hml_a < 360); _hml_a += 45) {
var _hml_xx = (x + lengthdir_x(_hml_r, _hml_a));
var _hml_yy = (y + lengthdir_y(_hml_r, _hml_a));
;
if ((((! position_meeting(_hml_xx, _hml_yy, Floor)) || (collision_circle(_hml_xx, _hml_yy, 12, Wall, false, true) != noone)) || (collision_circle(_hml_xx, _hml_yy, 12, chestprop, false, true) != noone))) {
continue;
}
instance_create(_hml_xx, _hml_yy, RadChest);
;
exit;
;
}
instance_create(x, y, RadChest);
;
}

// Source arkintide.mod.gml:0; hm_water_link (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_link(_hml__floor) {
if(instance_exists(_hml__floor)) {_hml__floor.hm_water_surface=id;_hml__floor.hm_water_surface111=id;} if(instance_exists(HMWorld)) HMWorld.hm_water_map=undefined;
}


// Source arkintide.mod.gml:0; hm_water_point (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_point(_hml__x, _hml__y) {
return scrHMWaterAt(_hml__x,_hml__y);
}

// Source arkintide.mod.gml:0; hm_water_point_list (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_point_list(_hml__x, _hml__y, _hml_candidates) {
return scrHMWaterAt(_hml__x,_hml__y);
}

// Source arkintide.mod.gml:0; hm_water_at (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_at(_hml__x, _hml__y) {
return scrHMSwimSupported112(_hml__x,_hml__y);
}

// Source arkintide.mod.gml:0; hm_water_at_list (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_at_list(_hml__x, _hml__y, _hml_candidates) {
return scrHMSwimSupported112(_hml__x,_hml__y);
}

// Source arkintide.mod.gml:0; hm_water_tick (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_tick() {
scrHMSewerTick();
}


// Source arkintide.mod.gml:0; hm_water_draw (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_draw() {
scrHMModCall("mod", "maincode", "hm_swim_actor_draw");
;
}

// Source arkintide.mod.gml:0; hm_throne_clear (native content 1.1.0)
function hm_arkintide_mod_gml_hm_throne_clear(_hml__x, _hml__y, _hml__mask) {
if ((! sprite_exists(_hml__mask))) {
return false;
}
var _hml_left = ((_hml__x + sprite_get_bbox_left(_hml__mask)) - sprite_get_xoffset(_hml__mask));
;
var _hml_right = ((_hml__x + sprite_get_bbox_right(_hml__mask)) - sprite_get_xoffset(_hml__mask));
;
var _hml_top = ((_hml__y + sprite_get_bbox_top(_hml__mask)) - sprite_get_yoffset(_hml__mask));
;
var _hml_bottom = ((_hml__y + sprite_get_bbox_bottom(_hml__mask)) - sprite_get_yoffset(_hml__mask));
;
if ((collision_rectangle(_hml_left, _hml_top, _hml_right, _hml_bottom, [Wall, InvisiWall], false, true) != noone)) {
return false;
}
for (var _hml_py = _hml_top; (_hml_py < (_hml_bottom + 32)); _hml_py += 32) for (var _hml_px = _hml_left; (_hml_px < (_hml_right + 32)); _hml_px += 32) {
if ((collision_point(min(_hml_px, _hml_right), min(_hml_py, _hml_bottom), Floor, false, false) == noone)) {
return false;
}
}
return true;
;
}

// Source arkintide.mod.gml:0; hm_throne_start (native content 1.1.0)
function hm_arkintide_mod_gml_hm_throne_start() {
if ((! instance_exists(Floor))) {
exit;
}
var _hml_hall_left = 1000000000;
var _hml_hall_right = (- 1000000000);
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
_hml_hall_left = min(_hml_hall_left, x);
;
_hml_hall_right = max(_hml_hall_right, x);
;
}
}
if(__hm_break3) break;
}}
var _hml_axis = (((_hml_hall_left + _hml_hall_right) / 2) + 16);
;
var _hml_spawn_y = (- 1000000000);
var _hml_boss_y = 1000000000;
var _hml_bottom_floor = noone;
;
{ var __hm_with4 = scrHMInstances(Floor), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if (((x <= _hml_axis) && ((x + 32) > _hml_axis))) {
{
var _hml_yy = (y + 16);
;
if (((_hml_yy > _hml_spawn_y) && hm_arkintide_mod_gml_hm_throne_clear(_hml_axis, _hml_yy, mskPlayer))) {
{
_hml_spawn_y = _hml_yy;
;
_hml_bottom_floor = id;
;
}
}
if (((_hml_yy < _hml_boss_y) && hm_arkintide_mod_gml_hm_throne_clear(_hml_axis, _hml_yy, mskNothingInactive))) {
_hml_boss_y = _hml_yy;
}
}
}
}
if(__hm_break6) break;
}}
if (((! instance_exists(_hml_bottom_floor)) || (_hml_boss_y == 1000000000))) {
exit;
}
if (scrHMVariableExists(_hml_bottom_floor, "hm_throne_placed")) {
exit;
}
_hml_bottom_floor.hm_throne_placed = 1;
;
{ var __hm_with7 = scrHMInstances(Player), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
scrHMModCall("mod", "maincode", "move_player_snap", index, _hml_axis, _hml_spawn_y);
;
speed = (0) * timescale;
;
hspeed = (0) * timescale;
;
vspeed = (0) * timescale;
;
}
}
if(__hm_break9) break;
}}
if (((((! instance_exists(NothingInactive)) && (! instance_exists(Nothing))) && (! instance_exists(BecomeNothing))) && (! instance_exists(Nothing2)))) {
{
{ var __hm_with10 = scrHMInstances(instance_create(_hml_axis, _hml_boss_y, NothingInactive)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
xstart = x;
;
ystart = y;
;
}
}
if(__hm_break12) break;
}}
}
}
{ var __hm_with13 = scrHMInstances(NothingInactive), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
x = _hml_axis;
;
y = _hml_boss_y;
;
xstart = x;
;
ystart = y;
;
}
}
if(__hm_break15) break;
}}
{ var __hm_with16 = scrHMInstances(Nothing), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
{
x = _hml_axis;
;
y = _hml_boss_y;
;
xstart = x;
;
ystart = y;
;
}
}
if(__hm_break18) break;
}}
var _hml_carpet_top = (_hml_boss_y + 80);
var _hml_carpet_scale = max(0.01, (((_hml_spawn_y + 16) - _hml_carpet_top) / sprite_get_height(sprCarpet)));
;
{ var __hm_with19 = scrHMInstances(instance_create(_hml_axis, (_hml_carpet_top + (sprite_get_yoffset(sprCarpet) * _hml_carpet_scale)), Carpet)), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
image_yscale = _hml_carpet_scale;
}
if(__hm_break21) break;
}}
;
{ var __hm_with22 = scrHMMatching(CustomObject, "name", "hm_throne_anchor"), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
scrHMDelete(id);
}
if(__hm_break24) break;
}}
;
}

// Source arkintide.mod.gml:0; hm_crown_altar (native content 1.1.0)
function hm_arkintide_mod_gml_hm_crown_altar() {
if (((((GameCont.subarea != 4) || (GameCont.crownvisits >= 3)) || instance_exists(ProtoStatue)) || (! instance_exists(Floor)))) {
exit;
}
var _hml_far = instance_furthest(10016, 10016, Floor);
;
var _hml_fl = instance_nearest((((_hml_far.x * 2) + 10016) / 3), (((_hml_far.y * 2) + 10016) / 3), Floor);
;
if (instance_exists(_hml_fl)) {
instance_create((_hml_fl.x + 16), (_hml_fl.y + 16), ProtoStatue);
}
}

// Source arkintide.mod.gml:0; hm_hunter_pending (native content 1.1.0)
function hm_arkintide_mod_gml_hm_hunter_pending() {scrHMLilHunterPending109();}

// Source arkintide.mod.gml:0; hm_hunter_wait (native content 1.1.0)
function hm_arkintide_mod_gml_hm_hunter_wait() {
    if(!variable_instance_exists(id,"hm_area109")) {
        hm_area109=GameCont.area;hm_sub109=GameCont.subarea;hm_loop109=GameCont.loops;
        hm_wait109=self[$ "hm_wait"]??30;
    }
    scrHMLilHunterWait109();
}

// Source arkintide.mod.gml:0; hm_cave_restore (native content 1.1.0)
function hm_arkintide_mod_gml_hm_cave_restore(_hml__x, _hml__y) {
// This callback is destroyed immediately after dispatch. The maintained host
// helper gives the native floor wave a stable HMWorld scope until it finishes.
scrHMCursedCavesRestore(_hml__x,_hml__y);
}

// Source arkintide.mod.gml:0; hm_convert_enemy (native content 1.1.0)
function hm_arkintide_mod_gml_hm_convert_enemy(_hml__kind) {
var _hml_xx = x;
var _hml_yy = y;
var _hml_health = hp;
var _hml_rad = raddrop;
;
var _hml_delta = 0;
var _hml_request = 0;
var _hml_initialized = 0;
;
if (scrHMVariableExists(id, "hm_rad_delta")) {
_hml_delta = hm_rad_delta;
}
if (scrHMVariableExists(id, "hm_rad_request")) {
_hml_request = hm_rad_request;
}
if (scrHMVariableExists(id, "hm_rad_initialized")) {
_hml_initialized = hm_rad_initialized;
}
scrHMDelete(id);
;
{ var __hm_with1 = scrHMInstances(instance_create(_hml_xx, _hml_yy, _hml__kind)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
hp = _hml_health;
;
raddrop = _hml_rad;
;
hm_rad_initialized = _hml_initialized;
;
hm_rad_delta = _hml_delta;
;
hm_rad_request = _hml_request;
;
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_venus_pickup (native content 1.1.0)
function hm_arkintide_mod_gml_hm_venus_pickup() {
if (((position_meeting(x, y, Floor) && (! place_meeting(x, y, Wall))) && (! place_meeting(x, y, InvisiWall)))) {
{
hm_safe_x = x;
;
hm_safe_y = y;
;
exit;
;
}
}
if ((!scrHMVariableExists(id, "hm_safe_x"))) {
{
var _hml_fl = instance_nearest(x, y, Floor);
;
if ((! instance_exists(_hml_fl))) {
exit;
}
hm_safe_x = (_hml_fl.x + 16);
;
hm_safe_y = (_hml_fl.y + 16);
;
}
}
if ((((point_distance(x, y, hm_safe_x, hm_safe_y) > 24) || place_meeting(x, y, Wall)) || place_meeting(x, y, InvisiWall))) {
{
x = hm_safe_x;
;
y = hm_safe_y;
;
speed = (0) * timescale;
;
}
}
}

// Source arkintide.mod.gml:0; hm_venus_boss_floor (native content 1.1.0)
function hm_arkintide_mod_gml_hm_venus_boss_floor(_hml__x, _hml__y) {
var _hml_landing = noone;
var _hml_best = 1000000000000000000;
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var _hml_xx = (x + 16);
var _hml_yy = (y + 16);
var _hml_dx = (_hml_xx - _hml__x);
var _hml_dy = (_hml_yy - _hml__y);
var _hml_dist = ((_hml_dx * _hml_dx) + (_hml_dy * _hml_dy));
;
if (((_hml_dist < _hml_best) && hm_arkintide_mod_gml_hm_throne_clear(_hml_xx, _hml_yy, mskBandit))) {
{
_hml_landing = id;
;
_hml_best = _hml_dist;
;
}
}
}
}
if(__hm_break3) break;
}}
return _hml_landing;
;
}

// Source arkintide.mod.gml:0; hm_venus_boss_bounds (native content 1.1.0)
function hm_arkintide_mod_gml_hm_venus_boss_bounds() {
if (((((GameCont.area != scrHMAreaResolve("venuz")) || (GameCont.subarea != 12)) || instance_exists(GenCont)) || (hp <= 0))) {
exit;
}
if (hm_arkintide_mod_gml_hm_throne_clear(x, y, mskBandit)) {
{
hm_venus_safe_x = x;
;
hm_venus_safe_y = y;
;
exit;
;
}
}
var _hml_safe = false;
var _hml_xx = x;
var _hml_yy = y;
;
if ((scrHMVariableExists(id, "hm_venus_safe_x") && hm_arkintide_mod_gml_hm_throne_clear(hm_venus_safe_x, hm_venus_safe_y, mskBandit))) {
{
_hml_xx = hm_venus_safe_x;
;
_hml_yy = hm_venus_safe_y;
;
_hml_safe = true;
;
}
} else {
{
var _hml_fl = hm_arkintide_mod_gml_hm_venus_boss_floor(x, y);
;
if (instance_exists(_hml_fl)) {
{
_hml_xx = (_hml_fl.x + 16);
;
_hml_yy = (_hml_fl.y + 16);
;
_hml_safe = true;
;
}
}
}
}
if (_hml_safe) {
{
x = _hml_xx;
;
y = _hml_yy;
;
xprevious = x;
;
yprevious = y;
;
speed = (0) * timescale;
;
hspeed = (0) * timescale;
;
vspeed = (0) * timescale;
;
walk = 0;
;
hm_venus_safe_x = x;
;
hm_venus_safe_y = y;
;
}
}
}

// Source arkintide.mod.gml:0; hm_palace_horror (native content 1.1.0)
function hm_arkintide_mod_gml_hm_palace_horror() {
if ((!scrHMVariableExists(id, "hm_horror"))) {
{
hm_horror = 1;
;
hp = 16;
;
raddrop = 0;
;
hm_rad_initialized = 0;
;
hm_rad_delta = 0;
;
spr_idle = sprEnemyHorrorIdle;
;
spr_walk = sprEnemyHorrorWalk;
;
spr_hurt = sprEnemyHorrorHurt;
;
spr_dead = sprEnemyHorrorDead;
;
sprite_index = spr_idle;
;
}
}
if ((!scrHMVariableExists(id, "hm_horror_death_offset"))) {
{
raddrop -= 25;
;
hm_horror_death_offset = 1;
;
}
}
ammo = 0;
;
charge = 100;
;
alarm[3] = (- 1);
;
snd_dead = (- 4);
;
if ((!scrHMVariableExists(id, "hm_horror_split"))) {
hm_horror_split = 0;
}
if (((((! hm_horror_split) && (hp > 0)) && ((raddrop + 25) > 10)) && (instance_number(HostileHorror) < 24))) {
{
hm_horror_split = 1;
;
raddrop -= 10;
;
{ var __hm_with1 = scrHMInstances(instance_create(x, y, HostileHorror)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
hm_horror_split = 1;
;
hm_arkintide_mod_gml_hm_palace_horror();
;
}
}
if(__hm_break3) break;
}}
}
}
}

// Source arkintide.mod.gml:0; hm_bird_aim (native content 1.1.0)
function hm_arkintide_mod_gml_hm_bird_aim() {
if (((flying && scrHMVariableExists(id, "hm_flight_locked")) && hm_flight_locked)) {
exit;
}
if ((! instance_exists(target))) {
exit;
}
var _hml_fl = instance_nearest(target.x, target.y, Floor);
;
if ((! instance_exists(_hml_fl))) {
exit;
}
flight_x = (_hml_fl.x + 16);
;
flight_y = (_hml_fl.y + 16);
;
if (flying) {
hm_flight_locked = 1;
}
}

// Source arkintide.mod.gml:0; hm_safe_land (native content 1.1.0)
function hm_arkintide_mod_gml_hm_safe_land() {
var _hml_fl = instance_nearest(x, y, Floor);
;
if ((! instance_exists(_hml_fl))) {
exit;
}
if ((! position_meeting(x, y, Floor))) {
{
x = (_hml_fl.x + 16);
;
y = (_hml_fl.y + 16);
;
}
}
}

// Source arkintide.mod.gml:0; hm_titank_health (native content 1.1.0)
function hm_arkintide_mod_gml_hm_titank_health() {
var _hml_alive = 0;
;
for (var _hml_leg = 0; (_hml_leg < legs); _hml_leg++) if ((foot_hp[_hml_leg] > 0)) {
_hml_alive++;
}
hp = _hml_alive;
;
}

// Source arkintide.mod.gml:0; hm_palace_generator (native content 1.1.0)
function hm_arkintide_mod_gml_hm_palace_generator(_hml__x, _hml__y) {
if ((collision_circle(_hml__x, _hml__y, 48, SmallGenerator, false, true) != noone)) {
return noone;
}
if ((collision_circle(_hml__x, _hml__y, 12, Wall, false, true) != noone)) {
return noone;
}
return instance_create(_hml__x, _hml__y, SmallGenerator);
;
}

// Source arkintide.mod.gml:0; hm_manhole_floor (native content 1.1.0)
function hm_arkintide_mod_gml_hm_manhole_floor(_hml__preferred) {
if ((instance_exists(_hml__preferred) && (_hml__preferred.sprite_index == sprFloor2))) {
return _hml__preferred;
}
var _hml_found = noone;
var _hml_best = 1000000;
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (((sprite_index == sprFloor2) && (! position_meeting((x + 16), (y + 16), Wall)))) {
{
var _hml_d = point_distance((x + 16), (y + 16), 10016, 10016);
;
if ((_hml_d < _hml_best)) {
{
_hml_found = id;
;
_hml_best = _hml_d;
;
}
}
}
}
}
if(__hm_break3) break;
}}
return _hml_found;
;
}

// Source arkintide.mod.gml:0; hm_native_controller (native content 1.1.0)
function hm_arkintide_mod_gml_hm_native_controller() {
GameCont.hm_elitebandit_step_ref = scrHMContentRef1100("mod", "enemies", "elitebandit_step");
;
var _hml_controller = instance_create(0, 0, CustomObject);
;
{ var __hm_with1 = scrHMInstances(_hml_controller), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "hm_native_controller";
;
hm_water_map = undefined;
;
hm_water_floor = noone;
;
hm_water_count = (- 1);
;
on_cleanup = scrHMContentRef1100("mod", "arkintide", "hm_batch_cleanup");
;
on_begin_step = scrHMContentRef1100("mod", "arkintide", "hm_native_begin");
;
on_step = scrHMContentRef1100("mod", "arkintide", "hm_native_step");
;
on_end_step = scrHMContentRef1100("mod", "arkintide", "hm_portal_style_tick");
;
}
}
if(__hm_break3) break;
}}
return _hml_controller;
;
}

// Source arkintide.mod.gml:0; hm_native_begin (native content 1.1.0)
function hm_arkintide_mod_gml_hm_native_begin() {
hm_arkintide_mod_gml_hm_gungod_replace_tick();
;
hm_arkintide_mod_gml_hm_stage_music_tick();
;
hm_arkintide_mod_gml_hm_batch_begin();
;
if (scrHMContentExists1100("mod", "options", "hm_settings_capture")) {
scrHMModCall("mod", "options", "hm_settings_capture");
}
hm_arkintide_mod_gml_hm_stage_protection();
;
hm_arkintide_mod_gml_hm_police_revival();
;
hm_arkintide_mod_gml_hm_pending_boss_exit();
;
{ var __hm_with1 = scrHMInstances(PlasmaBig), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
hm_arkintide_mod_gml_hm_native_plasma();
}
if(__hm_break3) break;
}}
;
{ var __hm_with4 = scrHMInstances(PlasmaHuge), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
hm_arkintide_mod_gml_hm_native_plasma();
}
if(__hm_break6) break;
}}
;
if (((GameCont.area == scrHMAreaResolve("venuz")) && (GameCont.subarea == 12))) {
{ var __hm_with7 = scrHMMatching(CustomEnemy, "name", "gungod"), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
hm_arkintide_mod_gml_hm_venus_boss_bounds();
}
if(__hm_break9) break;
}}
}
// Mobile retains its protected native corpse lifecycle.
}


// Source arkintide.mod.gml:0; hm_techcorpse_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_techcorpse_step() {
if ((hm_anim_pending && scrHMAnimationEnd1100(id))) {
{
hm_arkintide_mod_gml_hm_techcorpse_arm_exit();
;
exit;
;
}
}
if ((hm_exit_delay < 0)) {
exit;
}
hm_exit_delay -= 1;
;
if ((hm_exit_delay <= 0)) {
{
hm_exit_delay = (- 1);
;
scrHMContentEvent1100(Corpse, ev_alarm, 0);
;
if ((alarm[0] > 0)) {
{
hm_exit_delay = alarm[0];
;
alarm[0] = (- 1);
;
}
}
}
}
}

// Source arkintide.mod.gml:0; hm_native_plasma (native content 1.1.0)
function hm_arkintide_mod_gml_hm_native_plasma() {
if (hm_arkintide_mod_gml_hm_keep_plasma()) {
{
var _hml_shield = collision_line(x, y, (x + ((hspeed / timescale) * 1)), (y + ((vspeed / timescale) * 1)), PopoShield, false, true);
;
if ((! instance_exists(_hml_shield))) {
_hml_shield = instance_place(x, y, PopoShield);
}
if (((! instance_exists(_hml_shield)) || ((_hml_shield.image_speed / timescale) > 0))) {
exit;
}
if (((scrHMVariableExists(_hml_shield, "team") && scrHMVariableExists(id, "team")) && (_hml_shield.team == team))) {
exit;
}
direction = point_direction(_hml_shield.x, _hml_shield.y, x, y);
;
image_angle = direction;
;
var _hml_radius = (max(sprite_get_width(_hml_shield.sprite_index), sprite_get_height(_hml_shield.sprite_index)) / 2);
;
_hml_radius += ((max(sprite_get_width(sprite_index), sprite_get_height(sprite_index)) / 2) + 4);
;
x = (_hml_shield.x + lengthdir_x(_hml_radius, direction));
;
y = (_hml_shield.y + lengthdir_y(_hml_radius, direction));
;
scrHMSoundPlay(sndShielderDeflect);
;
}
}
}

// Source arkintide.mod.gml:0; hm_native_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_native_step() {
hm_arkintide_mod_gml_hm_camp_police_clear();
;
hm_arkintide_mod_gml_hm_batch_step();
;
hm_arkintide_mod_gml_hm_bounds_tick();
;
hm_arkintide_mod_gml_hm_empty_exit();
;
scrHMLilHunterReconcile115();
{ var __hm_with7 = scrHMInstances(VanSpawn), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{ var __hm_with10 = scrHMInstances(scrHMBindDraw(hm_arkintide_mod_gml_hm_van_warning, (- 13))), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
var __hm_other13=scrHMOther(other);
hm_source = __hm_other13;
}
if(__hm_break12) break;
}}
}
if(__hm_break9) break;
}}
;
if (((GameCont.area != scrHMAreaResolve("palace")) || (GameCont.subarea != 4))) {
{ var __hm_with14 = scrHMInstances(ProtoStatue), __hm_break16=false;
for (var __hm_index15=0; __hm_index15<array_length(__hm_with14); ++__hm_index15) {
if(instance_exists(__hm_with14[__hm_index15])) with (__hm_with14[__hm_index15]) {
scrHMDelete(id);
}
if(__hm_break16) break;
}}
}
{ var __hm_with17 = scrHMInstances(Portal), __hm_break19=false;
for (var __hm_index18=0; __hm_index18<array_length(__hm_with17); ++__hm_index18) {
if(instance_exists(__hm_with17[__hm_index18])) with (__hm_with17[__hm_index18]) {
if ((scrHMVariableExists(id, "hm_destination") && (endgame < 100))) {
GameCont.hm_destination = hm_destination;
}
}
if(__hm_break19) break;
}}
{ var __hm_with20 = scrHMMatching(HMBinding, "name", "guardianwall"), __hm_break22=false;
for (var __hm_index21=0; __hm_index21<array_length(__hm_with20); ++__hm_index21) {
if(instance_exists(__hm_with20[__hm_index21])) with (__hm_with20[__hm_index21]) {
hm_arkintide_mod_gml_hm_guardian_wall_step();
}
if(__hm_break22) break;
}}
;
var _hml_dark = 0;
;
{ var __hm_with23 = scrHMMatching(HMBinding, "name", "hm_guardiandark"), __hm_break25=false;
for (var __hm_index24=0; __hm_index24<array_length(__hm_with23); ++__hm_index24) {
if(instance_exists(__hm_with23[__hm_index24])) with (__hm_with23[__hm_index24]) {
{
_hml_dark++;
;
hm_arkintide_mod_gml_hm_guardian_dark_step();
;
}
}
if(__hm_break25) break;
}}
if ((((_hml_dark == 0) && scrHMVariableExists(id, "hm_dark_active")) && hm_dark_active)) {
{
hm_dark_active = 0;
;
{ var __hm_with26 = scrHMMatching(GameObject, "hm_guardian_layer", 1), __hm_break28=false;
for (var __hm_index27=0; __hm_index27<array_length(__hm_with26); ++__hm_index27) {
if(instance_exists(__hm_with26[__hm_index27])) with (__hm_with26[__hm_index27]) {
{
if ((depth == (- 11))) {
depth = hm_guardian_old_depth;
}
hm_guardian_layer = 0;
;
}
}
if(__hm_break28) break;
}}
}
} else {
if ((_hml_dark > 0)) {
{
hm_dark_active = 1;
;
{ var __hm_with29 = scrHMInstances(GameObject), __hm_break31=false;
for (var __hm_index30=0; __hm_index30<array_length(__hm_with29); ++__hm_index30) {
if(instance_exists(__hm_with29[__hm_index30])) with (__hm_with29[__hm_index30]) {
if (((depth > (- 11)) && ((((((instance_is(id, hitme) || instance_is(id, projectile)) || instance_is(id, Pickup)) || instance_is(id, Effect)) || instance_is(id, CrystalShield)) || instance_is(id, CrystalShieldDisappear)) || instance_is(id, PortalStrike)))) {
{
hm_guardian_old_depth = depth;
;
hm_guardian_layer = 1;
;
depth = (- 11);
;
}
}
}
if(__hm_break31) break;
}}
}
}
}
hm_arkintide_mod_gml_hm_portal_style_tick();
;
hm_arkintide_mod_gml_hm_infantry_capture();
;
hm_arkintide_mod_gml_hm_audio_tick();
;
}

// Source arkintide.mod.gml:0; hm_portal_commit (native content 1.1.0)
function hm_arkintide_mod_gml_hm_portal_commit(_hml__portal) {
if ((! instance_exists(_hml__portal))) {
exit;
}
if ((_hml__portal.endgame != 100)) {
exit;
}
if ((collision_line(x, y, _hml__portal.x, _hml__portal.y, Wall, false, true) != noone)) {
exit;
}
if (scrHMVariableExists(_hml__portal, "hm_destination")) {
GameCont.hm_destination = _hml__portal.hm_destination;
}
hm_arkintide_mod_gml_hm_portal_style_commit(_hml__portal);
;
{ var __hm_with1 = scrHMInstances(_hml__portal), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
event_perform(ev_collision, Player);
}
if(__hm_break3) break;
}}
;
}

// Source arkintide.mod.gml:0; hm_ground_bounds (native content 1.1.0)
function hm_arkintide_mod_gml_hm_ground_bounds() {
hm_arkintide_mod_gml_hm_ground_bounds_elapsed(1);
;
}

// Source arkintide.mod.gml:0; hm_empty_exit (native content 1.1.0)
function hm_arkintide_mod_gml_hm_empty_exit() {
if ((!scrHMVariableExists(id, "hm_empty_time"))) {
hm_empty_time = 0;
}
if (((((((GameCont.area != scrHMAreaResolve("nightdesert")) || instance_exists(GenCont)) || (! instance_exists(Player))) || instance_exists(enemy)) || instance_exists(Portal)) || instance_exists(SpiralCont))) {
{
hm_empty_time = 0;
;
exit;
;
}
}
hm_empty_time += 1;
;
if ((hm_empty_time < 60)) {
exit;
}
hm_empty_time = 0;
;
var _hml_armed = 0;
;
{ var __hm_with1 = scrHMInstances(Corpse), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((alarm[0] >= 0)) {
{
_hml_armed = 1;
;
__hm_break3=true; break;
;
}
}
}
if(__hm_break3) break;
}}
if (_hml_armed) {
exit;
}
var _hml_fl = instance_nearest(Player.x, Player.y, Floor);
;
if (instance_exists(_hml_fl)) {
{ var __hm_with4 = scrHMInstances(instance_create((_hml_fl.x + 16), (_hml_fl.y + 16), Corpse)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
sprite_index = mskNone;
;
alarm[0] = 1;
;
}
}
if(__hm_break6) break;
}}
}
}

// Source arkintide.mod.gml:0; hm_shadow_objects (native content 1.1.0)
function hm_arkintide_mod_gml_hm_shadow_objects() {
var _hml_result = [];
var _hml_length = 0;
;
{ var __hm_with1 = scrHMInstances(CustomObject), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((scrHMVariableExists(id, "shadow") && ((shadow == 1) || (shadow == 2)))) {
{
_hml_result[_hml_length] = id;
;
_hml_length++;
;
}
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(Effect), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if ((scrHMVariableExists(id, "shadow") && ((shadow == 1) || (shadow == 2)))) {
{
_hml_result[_hml_length] = id;
;
_hml_length++;
;
}
}
}
if(__hm_break6) break;
}}
return _hml_result;
;
}

// Source arkintide.mod.gml:0; hm_prepare_junkyard (native content 1.1.0)
function hm_arkintide_mod_gml_hm_prepare_junkyard() {
{ var __hm_with1 = scrHMInstances(BecomeScrapBoss), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
{ var __hm_with4 = scrHMInstances(Barrel), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
scrHMDelete(id);
}
}
if(__hm_break6) break;
}}
{ var __hm_with7 = scrHMInstances(ToxicBarrel), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
scrHMDelete(id);
}
}
if(__hm_break9) break;
}}
{ var __hm_with10 = scrHMInstances(Car), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
scrHMDelete(id);
}
}
if(__hm_break12) break;
}}
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_junkyard_wall_allowed (native content 1.1.0)
function hm_arkintide_mod_gml_hm_junkyard_wall_allowed(_hml__x, _hml__y) {
var _hml_near_player = false;
;
{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((point_distance(x, y, (_hml__x + 8), (_hml__y + 8)) < 128)) {
_hml_near_player = true;
}
}
if(__hm_break3) break;
}}
if (_hml_near_player) {
return false;
}
if ((collision_rectangle((_hml__x - 32), (_hml__y - 32), (_hml__x + 48), (_hml__y + 48), Wall, false, true) != noone)) {
return false;
}
if ((collision_rectangle((_hml__x - 16), (_hml__y - 16), (_hml__x + 32), (_hml__y + 32), prop, false, true) != noone)) {
return false;
}
return true;
;
}

// Source arkintide.mod.gml:0; hm_tinade_wall (native content 1.1.0)
function hm_arkintide_mod_gml_hm_tinade_wall() {
var _hml_dx = (x - xprevious);
var _hml_dy = (y - yprevious);
;
if (place_meeting(x, y, Wall)) {
{
x = xprevious;
;
y = yprevious;
;
}
}
move_bounce_solid(true);
;
if ((!scrHMVariableExists(id, "hm_bounce_frame"))) {
hm_bounce_frame = (- 100);
}
if ((((current_frame - hm_bounce_frame) >= 6) && ((abs(_hml_dx) + abs(_hml_dy)) > 0.05))) {
{
hm_bounce_frame = current_frame;
;
scrHMSoundPlay(sndGrenadeHitWall);
;
}
}
}

// Source arkintide.mod.gml:0; hm_van_warning (native content 1.1.0)
function hm_arkintide_mod_gml_hm_van_warning() {
if ((instance_exists(hm_source) && ((hm_source.sprite_index == sprVanPortalStart) || (hm_source.sprite_index == sprVanPortalStart)))) {
{
var _hml_kind = 0;
;
if ((scrHMVariableExists(hm_source, "hm_tank_portal") && hm_source.hm_tank_portal)) {
_hml_kind = 1;
}
hm_arkintide_mod_gml_hm_warning_icon(hm_source.x, hm_source.y, _hml_kind);
;
}
}
scrHMMenuDrawComplete();
;
}

// Source arkintide.mod.gml:0; hm_guardian_wall_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_guardian_wall_step() {
if (instance_exists(owner)) {
alpha = min(1, (alpha + (0.125 * 1)));
} else {
{
alpha -= (0.05 * 1);
;
if ((alpha <= 0)) {
scrHMDelete(id);
}
exit;
;
}
}
if ((!scrHMVariableExists(id, "hm_guardian_clock"))) {
hm_guardian_clock = 0;
}
if ((spr_ind != sprGuardianIdle)) {
exit;
}
_rot += (0.75 * 1);
;
hm_guardian_clock += 1;
;
if ((hm_guardian_clock < 10)) {
exit;
}
hm_guardian_clock -= 10;
;
for (var _hml_spoke = 0; (_hml_spoke < 24); _hml_spoke++) for (var _hml_ring = 3; (_hml_ring >= 1); _hml_ring--) {
if ((random(max(1, (250 - (5 * GameCont.loops)))) >= 1)) {
continue;
}
var _hml_px = (_x - lengthdir_x((96 * (1 + (0.5 * _hml_ring))), ((15 * _hml_spoke) + (_rot / _hml_ring))));
;
var _hml_py = (_y + lengthdir_y((96 * (1 + (0.5 * _hml_ring))), ((15 * _hml_spoke) + (_rot / _hml_ring))));
;
var _hml_p = instance_nearest(_hml_px, _hml_py, Player);
var _hml_angle = point_direction(_hml_px, _hml_py, _x, _y);
;
if (instance_exists(_hml_p)) {
_hml_angle = point_direction(_hml_px, _hml_py, _hml_p.x, _hml_p.y);
}
for (var _hml_shot = (- 1); (_hml_shot <= 1); _hml_shot++) { var __hm_with1 = scrHMInstances(instance_create(_hml_px, _hml_py, GuardianBullet)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
team = 1;
;
speed = (1.5) * timescale;
;
damage = 3;
;
hitid = [sprGuardianIdle, "LESSER GUARDIAN"];
;
direction = (_hml_angle + (15 * _hml_shot));
;
}
}
if(__hm_break3) break;
}}
scrHMSoundPlay(sndGuardianFire);
;
}
}

// Source arkintide.mod.gml:0; hm_guardian_dark_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_guardian_dark_step() {
if (instance_exists(owner)) {
{
alpha = min(1, (alpha + (0.05 * 1)));
;
if ((alpha > 0.5)) {
TopCont.darkness = 1;
}
}
} else {
{
alpha -= (0.05 * 1);
;
if ((alpha <= 0.5)) {
TopCont.darkness = 0;
}
if ((alpha <= 0)) {
scrHMDelete(id);
}
}
}
}

// Source arkintide.mod.gml:0; step (native content 1.1.0)
function hm_arkintide_mod_gml_step() {
if ((! instance_exists(GameCont))) {
exit;
}
var _hml_controller = noone;
;
if (scrHMVariableExists(GameCont, "hm_native_controller_id")) {
_hml_controller = GameCont.hm_native_controller_id;
}
if ((((! instance_exists(_hml_controller)) || (!scrHMVariableExists(_hml_controller, "name"))) || (_hml_controller.name != "hm_native_controller"))) {
{
GameCont.hm_native_controller_id = hm_arkintide_mod_gml_hm_native_controller();
;
}
}
if ((GameCont.area == scrHMAreaResolve("venuz"))) {
{ var __hm_with1 = scrHMInstances(WepPickup), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
hm_arkintide_mod_gml_hm_venus_pickup();
}
if(__hm_break3) break;
}}
}
if ((GameCont.loops > 0)) {
{
{ var __hm_with4 = scrHMMatching(CustomEnemy, "name", "IDPDTank"), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
hm_arkintide_mod_gml_hm_tank_base();
}
if(__hm_break6) break;
}}
;
if ((((GameCont.area != scrHMAreaResolve("throne")) && (GameCont.area != scrHMAreaResolve("end"))) && (GameCont.area != scrHMAreaResolve("venuz")))) {
GameCont.novans = 0;
}
}
}
}

// Source arkintide.mod.gml:0; hm_snow_bandit (native content 1.1.0)
function hm_arkintide_mod_gml_hm_snow_bandit() {
if ((((GameCont.area != scrHMAreaResolve("city")) && (GameCont.area != scrHMAreaResolve("icecave"))) && (GameCont.area != scrHMAreaResolve("noyetihere")))) {
exit;
}
spr_idle = sprSnowBanditIdle;
;
spr_walk = sprSnowBanditWalk;
;
spr_hurt = sprSnowBanditHurt;
;
spr_dead = sprSnowBanditDead;
;
sprite_index = spr_idle;
;
hitid = [sprSnowBanditIdle, "Bandit"];
;
}

// Source arkintide.mod.gml:0; hm_venus_auto_exit (native content 1.1.0)
function hm_arkintide_mod_gml_hm_venus_auto_exit() {
if (instance_exists(GenCont)) {
return false;
}
var _hml_blocked = 0;
;
{ var __hm_with1 = scrHMInstances(CustomObject), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (scrHMVariableExists(id, "name")) {
{
if ((name == "VenuzElevator")) {
_hml_blocked = 1;
}
if ((scrHMVariableExists(id, "Spawner") && Spawner)) {
{
switch (name) {
case "prisoner":

case "Molefish":

case "Molesarge":

case "Minigunner":

case "Jock":

case "Charger":

case "FireBaller":

case "SuperFireBaller":

case "Turtle":
_hml_blocked = 1;
;
break;
;
}
}
}
}
}
}
if(__hm_break3) break;
}}
return (! _hml_blocked);
;
}

// Source arkintide.mod.gml:0; hm_swim_sprite (native content 1.1.0)
function hm_arkintide_mod_gml_hm_swim_sprite() {
if (((sprite_exists(sprite_index) && (sprite_get_width(sprite_index) > 0)) && (sprite_get_height(sprite_index) > 0))) {
return true;
}
if (((scrHMVariableExists(id, "spr_idle") && sprite_exists(spr_idle)) && (spr_idle != mskNone))) {
{
sprite_index = spr_idle;
;
return true;
;
}
}
return false;
;
}

// Source arkintide.mod.gml:0; hm_throne_fall (native content 1.1.0)
function hm_arkintide_mod_gml_hm_throne_fall(_hml__falling) {
if (_hml__falling) {
{
if (((!scrHMVariableExists(id, "hm_throne_falling")) || (! hm_throne_falling))) {
{
hm_throne_falling = 1;
;
hm_throne_alpha = image_alpha;
;
scale = 1;
;
sprite_angle = 0;
;
angle = 0;
;
}
}
scale = max(0, (scale - (0.03 * 1)));
;
image_alpha = 0;
;
{ var __hm_with1 = scrHMInstances(scrHMBindDraw(hm_arkintide_mod_gml_hm_throne_fall_draw, (- 12))), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
var __hm_other4=scrHMOther(other);
creator = __hm_other4;
}
if(__hm_break3) break;
}}
;
}
} else {
if ((scrHMVariableExists(id, "hm_throne_falling") && hm_throne_falling)) {
{
hm_throne_falling = 0;
;
image_alpha = hm_throne_alpha;
;
scale = 1;
;
angle = 0;
;
}
}
}
}

// Source arkintide.mod.gml:0; hm_throne_fall_draw (native content 1.1.0)
function hm_arkintide_mod_gml_hm_throne_fall_draw() {
scrHMModCall("mod", "maincode", "PortalShrink");
;
}

// Source arkintide.mod.gml:0; hm_techcorpse_arm_exit (native content 1.1.0)
function hm_arkintide_mod_gml_hm_techcorpse_arm_exit() {
hm_anim_pending = 0;
;
scrHMContentEvent1100(Corpse, ev_other, ev_animation_end);
;
hm_exit_delay = alarm[0];
;
alarm[0] = (- 1);
;
}

// Source arkintide.mod.gml:0; hm_pending_boss_exit (native content 1.1.0)
function hm_arkintide_mod_gml_hm_pending_boss_exit() {
if ((!scrHMVariableExists(id, "hm_pending_boss_kind"))) {
{
hm_pending_boss_kind = 0;
;
hm_pending_boss_seen = 0;
;
}
}
if ((!scrHMVariableExists(id, "hm_pending_boss_calls"))) {
{
hm_pending_boss_calls = 0;
;
hm_pending_alarm_holds = 0;
;
hm_pending_alarm_bad = 0;
;
hm_pending_alarm_before = (- 1);
;
hm_pending_alarm_after = (- 1);
;
}
}
hm_pending_boss_calls++;
;
if (((instance_exists(GenCont) || (GameCont.area != scrHMAreaResolve("city"))) || ((GameCont.subarea != 3) && (GameCont.subarea != 5)))) {
{
hm_pending_boss_kind = 0;
;
hm_pending_boss_seen = 0;
;
exit;
;
}
}
var _hml_pending_name = "wanttitank";
var _hml_kind = 1;
;
if ((GameCont.subarea == 5)) {
{
_hml_pending_name = "hm_hunter_pending";
;
_hml_kind = 2;
;
}
}
if ((hm_pending_boss_kind && (hm_pending_boss_kind != _hml_kind))) {
{
hm_pending_boss_kind = 0;
;
hm_pending_boss_seen = 0;
;
}
}
var _hml_pending = (array_length(scrHMMatching(CustomObject, "name", _hml_pending_name)) > 0);
;
if (((! hm_pending_boss_kind) && _hml_pending)) {
{
hm_pending_boss_kind = _hml_kind;
;
hm_pending_boss_seen = 0;
;
}
}
if ((! hm_pending_boss_kind)) {
exit;
}
var _hml_arrived = instance_exists(LilHunter) || instance_exists(LilHunterFly);
;
if ((hm_pending_boss_kind == 1)) {
_hml_arrived = (array_length(scrHMMatching(CustomEnemy, "name", "titank")) > 0);
}
if (_hml_arrived) {
hm_pending_boss_seen = 1;
}
if ((((hm_pending_boss_seen && (! _hml_pending)) && (! instance_exists(enemy))) && (! instance_exists(becomenemy)))) {
{
hm_pending_boss_kind = 0;
;
hm_pending_boss_seen = 0;
;
exit;
;
}
}
var _hml_gate = id;
;
{ var __hm_with1 = scrHMInstances(Corpse), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((alarm[0] >= 0)) {
{
var _hml_before = alarm[0];
;
alarm[0] = max(_hml_before, 2);
;
_hml_gate.hm_pending_alarm_before = _hml_before;
;
_hml_gate.hm_pending_alarm_after = alarm[0];
;
_hml_gate.hm_pending_alarm_holds++;
;
if ((alarm[0] < 2)) {
_hml_gate.hm_pending_alarm_bad++;
}
}
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_unlock_area_equivalent (native content 1.1.0)
function hm_arkintide_mod_gml_hm_unlock_area_equivalent(_hml__area) {
switch (_hml__area) {
case "sewers":
return area_sewers;
;
case "turtles":
return area_pizza_sewers;
;
case "ravenboss":

case "junkyard":
return area_scrapyard;
;
case "caves":
return area_caves;
;
case "cavesinv":
return area_cursed_caves;
;
case "city":
return area_frozencity;
;
case "labs":
return area_labs;
;
case "jungle":
return area_jungle;
;
case "HQ":
return area_hq;
;
case "palace":
return area_palace;
;
case "nightdesert":
return area_desert;
;
}
return (- 1);
;
}

// Source arkintide.mod.gml:0; hm_native_unlock_notification (native content 1.1.0)
function hm_arkintide_mod_gml_hm_native_unlock_notification(_hml__race, _hml__skin, _hml__line1, _hml__line2) {
var _hml_popup = instance_create(0, 0, asset_get_index("UnlockPopup"));
;
_hml_popup.txt = _hml__line1;
;
_hml_popup.txt2 = _hml__line2;
;
var _hml_screen = instance_create(GameCont.x, GameCont.y, asset_get_index(((_hml__skin < 1) ? "UnlockScreen" : "BUnlockScreen")));
;
_hml_screen.race = _hml__race;
;
if ((_hml__skin >= 1)) {
variable_instance_set(_hml_screen, "bskin", _hml__skin);
}
}

// Source arkintide.mod.gml:0; hm_native_unlock_base (native content 1.1.0)
function hm_arkintide_mod_gml_hm_native_unlock_base(_hml__race, _hml__name, _hml__reason) {
if (UberCont.cgot[_hml__race]) {
return false;
}
var _hml_popup = instance_create(0, 0, asset_get_index("UnlockPopup"));
;
_hml_popup.txt = loc((("Unlock:Race:" + string(_hml__race)) + ":1"), _hml__name);
;
_hml_popup.txt2 = loc((("Unlock:Race:" + string(_hml__race)) + ":2"), _hml__reason);
;
UberCont.cgot[_hml__race] = 1;
;
var _hml_screen = instance_create(GameCont.x, GameCont.y, asset_get_index("UnlockScreen"));
;
_hml_screen.race = _hml__race;
;
return true;
;
}

// Source arkintide.mod.gml:0; hm_native_unlock_bskin (native content 1.1.0)
function hm_arkintide_mod_gml_hm_native_unlock_bskin(_hml__race, _hml__name, _hml__reason) {
if (((UberCont.cbgt[_hml__race] & 1) != 0)) {
return false;
}
UberCont.cbgt[_hml__race] = (UberCont.cbgt[_hml__race] | 1);
;
var _hml_all_b = true;
;
for (var _hml_r = 1; (_hml_r <= 16); _hml_r++) {
if ((((_hml_r <= 12) || (_hml_r == 16)) && ((UberCont.cbgt[_hml_r] & 1) == 0))) {
_hml_all_b = false;
}
}
if ((_hml_all_b && ((UberCont.cbgt[1] & 2) == 0))) {
{
UberCont.cbgt[1] = (UberCont.cbgt[1] | 2);
;
hm_arkintide_mod_gml_hm_native_unlock_notification(1, 2, loc("UnlockC:Skin:1:1", "@(w)FISH C-SKIN UNLOCKED"), loc("UnlockC:Skin:1:2", "@(s)FOR GETTING ALL B-SKINS"));
;
}
}
hm_arkintide_mod_gml_hm_native_unlock_notification(_hml__race, 1, loc((("Unlock:Skin:" + string(_hml__race)) + ":1"), _hml__name), loc((("Unlock:Skin:" + string(_hml__race)) + ":2"), _hml__reason));
;
return true;
;
}

// Source arkintide.mod.gml:0; hm_native_unlock_area (native content 1.1.0)
function hm_arkintide_mod_gml_hm_native_unlock_area() {
scrUnlocksArea();
}


// Source arkintide.mod.gml:0; hm_mapdata (native content 1.1.0)
function hm_arkintide_mod_gml_hm_mapdata(_hml__area, _hml__lastx, _hml__lasty, _hml__lastarea, _hml__lastsub, _hml__sub, _hml__loops) {
var _hml_pos = (- 1);
var _hml_secret = 0;
;
switch (_hml__area) {
case "nightdesert":
_hml_pos = 3;
;
break;
;
case "scorpionboss":
_hml_pos = 4;
;
break;
;
case "sewers":
_hml_pos = (5 + clamp((_hml__sub - 1), 0, 2));
;
break;
;
case "junkyard":
_hml_pos = (8 + clamp((_hml__sub - 1), 0, 4));
;
break;
;
case "ravenboss":
_hml_pos = 10;
;
break;
;
case "bigdog":
_hml_pos = 12;
;
break;
;
case "caves":
_hml_pos = (13 + clamp((_hml__sub - 1), 0, 2));
;
break;
;
case "city":
_hml_pos = (16 + clamp((_hml__sub - 1), 0, 4));
;
break;
;
case "labs":
_hml_pos = (21 + clamp((_hml__sub - 1), 0, 1));
;
break;
;
case "elevator":
_hml_pos = 23;
;
break;
;
case "palace":
_hml_pos = (24 + clamp((_hml__sub - 1), 0, 3));
;
break;
;
case "end":
return [0, 0, 0, 0];
;
case "throne":
_hml_pos = 28;
;
break;
;
case "cavesinv":

case "icecave":
_hml_pos = (13 + clamp((_hml__sub - 1), 0, 2));
;
_hml_secret = 1;
;
break;
;
case "oasis":
_hml_pos = 4;
;
_hml_secret = 1;
;
break;
;
case "jungle":
_hml_pos = 8;
;
_hml_secret = 1;
;
break;
;
case "turtles":
_hml_pos = 6;
;
_hml_secret = 1;
;
break;
;
}
if ((_hml_pos < 0)) {
return [_hml__lastx, 9, 1, 1];
}
var _hml_px = (_hml_pos * 9);
;
if ((_hml_pos > 2)) {
_hml_px = (18 + ((_hml_pos - 2) * 4.5));
}
return [_hml_px, (_hml_secret * 9), 1, 1];
;
}

// Source arkintide.mod.gml:0; hm_police_corpse_busy (native content 1.1.0)
function hm_arkintide_mod_gml_hm_police_corpse_busy(_hml__corpse, _hml__owner, _hml__tick) {
    if(!instance_exists(_hml__corpse)) return true;
    // The explicit-binding pass below owns this cache. A nearby Messenger
    // timer or invisible logic corpse must never reserve a police body.
    return scrHMVariableExists(_hml__corpse,"hm_police_busy_owner")
        && _hml__corpse.hm_police_busy_owner==_hml__owner
        && _hml__corpse.hm_police_busy_tick==_hml__tick;
}

// Source arkintide.mod.gml:0; hm_police_revival (native content 1.1.0)
function hm_arkintide_mod_gml_hm_police_revival() {
    if(!scrHMPoliceLate1116() || instance_exists(GenCont)
        || instance_exists(SpiralCont) || instance_exists(Portal)) return;
    with(WantRevivePopoFreak) {
        if(variable_instance_exists(id,"hm_messenger_corpse115")) continue;
        if(!variable_instance_exists(id,"hm_corpse107") && !variable_instance_exists(id,"hm_police_corpse")) continue;
        var _hml_body=self[$ "hm_corpse107"]??(self[$ "hm_police_corpse"]??noone);
        if(!scrHMPoliceBindCorpse107(id,_hml_body)) {scrHMDelete(id);continue;}
        x=_hml_body.x;y=_hml_body.y;
    }
    with(RevivePopoFreak) {
        if(variable_instance_exists(id,"hm_messenger_corpse115")) continue;
        if(!variable_instance_exists(id,"hm_corpse107") && !variable_instance_exists(id,"hm_police_corpse")) continue;
        var _hml_body=self[$ "hm_corpse107"]??(self[$ "hm_police_corpse"]??noone);
        if(!scrHMPoliceBindCorpse107(id,_hml_body)) {scrHMDelete(id);continue;}
        x=_hml_body.x;y=_hml_body.y;
    }
    var _hml_pending=false;
    with(Corpse) {
        if(variable_instance_exists(id,"hm_police_revive_once")) continue;
        var _hml_spr=sprite_index;
        if(array_contains([sprGruntDead,sprInspectorDead,sprShielderDead,
            sprEliteGruntDead,sprEliteInspectorDead,sprEliteShielderDead],_hml_spr)) {
            _hml_pending=true;break;
        }
    }
    if(!_hml_pending) return;
    if(!scrHMVariableExists(id,"hm_police_scan")) hm_police_scan=0;
    hm_police_scan++;
    var _hml_owner=id,_hml_tick=hm_police_scan;
    with(WantRevivePopoFreak) {
        if(variable_instance_exists(id,"hm_messenger_corpse115")) continue;
        var _hml_body=self[$ "hm_corpse107"]??(self[$ "hm_police_corpse"]??noone);
        if(instance_exists(_hml_body) && instance_is(_hml_body,Corpse)) {
            _hml_body.hm_police_busy_owner=_hml_owner;
            _hml_body.hm_police_busy_tick=_hml_tick;
        }
    }
    with(RevivePopoFreak) {
        if(variable_instance_exists(id,"hm_messenger_corpse115")) continue;
        var _hml_body=self[$ "hm_corpse107"]??(self[$ "hm_police_corpse"]??noone);
        if(instance_exists(_hml_body) && instance_is(_hml_body,Corpse)) {
            _hml_body.hm_police_busy_owner=_hml_owner;
            _hml_body.hm_police_busy_tick=_hml_tick;
        }
    }
    with(Corpse) {
        if(variable_instance_exists(id,"hm_police_revive_once")
            || variable_instance_exists(id,"hm_messenger_corpse115")) continue;
        var _hml_spr=sprite_index;
        if(!array_contains([sprGruntDead,sprInspectorDead,sprShielderDead,
            sprEliteGruntDead,sprEliteInspectorDead,sprEliteShielderDead],_hml_spr)) continue;
        if(hm_arkintide_mod_gml_hm_police_corpse_busy(id,_hml_owner,_hml_tick)) continue;
        var _hml_body=id,_hml_request=instance_create(x,y,WantRevivePopoFreak);
        if(scrHMPoliceBindCorpse107(_hml_request,_hml_body)) {
            hm_police_busy_owner=_hml_owner;
            hm_police_busy_tick=_hml_tick;
        }
    }
}

// Source arkintide.mod.gml:0; hm_water_player_motion (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_player_motion() {
if ((scrHMVariableExists(id, "creator") && instance_exists(creator))) {
{
var _hml_owner = creator;
;
if ((scrHMVariableExists(_hml_owner, "hm_water_motion_step") && (_hml_owner.hm_water_motion_step == id))) {
_hml_owner.hm_water_motion_step = noone;
}
{ var __hm_with1 = scrHMInstances(_hml_owner), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if (((((((((object_index == Player) && (hp > 0)) && (! instance_exists(GenCont))) && scrHMVariableExists(id, "swimming")) && (swimming == 1)) && (! instance_exists(SpiralCont))) && (distance_to_object(Portal) > 32)) && hm_arkintide_mod_gml_hm_water_at(x, y))) {
speed = (min((speed / timescale), (2 + (friction / (timescale * timescale))))) * timescale;
}
}
}
if(__hm_break3) break;
}}
}
}
instance_destroy();
;
}

// Source arkintide.mod.gml:0; hm_volley_alive (native content 1.1.0)
function hm_arkintide_mod_gml_hm_volley_alive(_hml__owner) {
if ((! instance_exists(_hml__owner))) {
return false;
}
return ((_hml__owner.hp > 0) && instance_exists(Player));
;
}

// Source arkintide.mod.gml:0; hm_tank_has_cannon (native content 1.1.0)
function hm_arkintide_mod_gml_hm_tank_has_cannon(_hml__owner) {
{ var __hm_with1 = scrHMMatching(CustomProjectile, "name", "IDPDLaserCannon"), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((creator == _hml__owner)) {
return true;
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMMatching(CustomObject, "name", "IDPDLaserCannon"), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if ((creator == _hml__owner)) {
return true;
}
}
if(__hm_break6) break;
}}
return false;
;
}

// Source arkintide.mod.gml:0; hm_combat_clear (native content 1.1.0)
function hm_arkintide_mod_gml_hm_combat_clear() {
if (instance_exists(GenCont)) {
return false;
}
{ var __hm_with1 = scrHMInstances(enemy), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((((hp > 0) && (team != 2)) && (! (scrHMVariableExists(id, "hm_noncombat") && hm_noncombat)))) {
return false;
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(becomenemy), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if (((object_index != WantVan) && (object_index != WantPopo))) {
return false;
}
}
if(__hm_break6) break;
}}
if (((array_length(scrHMMatching(CustomObject, "name", "hm_infantry_gate")) > 0) || (array_length(scrHMMatching(CustomObject, "name", "hm_robot_gate")) > 0))) {
return false;
}
if (((instance_exists(IDPDSpawn) || instance_exists(VanSpawn)) || instance_exists(WantLH))) {
return false;
}
return true;
;
}

// Source arkintide.mod.gml:0; hm_fish_protected (native content 1.1.0)
function hm_arkintide_mod_gml_hm_fish_protected() {
if (((GameCont.area != scrHMAreaResolve(1)) || (GameCont.subarea != 2))) {
return false;
}
if ((!scrHMVariableExists(id, "hm_fish_clear_ticks"))) {
return true;
}
return (hm_fish_clear_ticks < 90);
;
}

// Source arkintide.mod.gml:0; hm_fish_gate (native content 1.1.0)
function hm_arkintide_mod_gml_hm_fish_gate() {
if ((!scrHMVariableExists(id, "hm_fish_clear_ticks"))) {
hm_fish_clear_ticks = 0;
}
if ((! hm_arkintide_mod_gml_hm_combat_clear())) {
hm_fish_clear_ticks = 0;
} else {
hm_fish_clear_ticks = min(90, (hm_fish_clear_ticks + 1));
}
;
mask_index = mskNone;
;
if ((! hm_arkintide_mod_gml_hm_fish_protected())) {
mask_index = sprBigSkullOpen;
}
}

// Source arkintide.mod.gml:0; hm_entrance_hurt (native content 1.1.0)
function hm_arkintide_mod_gml_hm_entrance_hurt(_hml__damage) {
return;
;
}

// Source arkintide.mod.gml:0; hm_jungle_entrance (native content 1.1.0)
function hm_arkintide_mod_gml_hm_jungle_entrance() {
if ((instance_exists(GenCont) || (! instance_exists(Floor)))) {
exit;
}
if ((array_length(scrHMMatching(CustomHitme, "name", "   feed")) > 0)) {
exit;
}
var _hml_entrance = noone;
var _hml_best = (- 1);
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var _hml_px = (x + 16);
var _hml_py = (y + 16);
;
if ((! hm_arkintide_mod_gml_hm_throne_clear(_hml_px, _hml_py, mskBandit))) {
continue;
}
var _hml_score = point_distance(_hml_px, _hml_py, 10016, 10016);
;
if ((_hml_score > _hml_best)) {
{
_hml_best = _hml_score;
;
_hml_entrance = id;
;
}
}
}
}
if(__hm_break3) break;
}}
if ((! instance_exists(_hml_entrance))) {
_hml_entrance = instance_nearest(10016, 10016, Floor);
}
if (instance_exists(_hml_entrance)) {
scrHMModCall("mod", "props", "Flower_create", (_hml_entrance.x + 16), (_hml_entrance.y + 16));
}
}

// Source arkintide.mod.gml:0; hm_stage_protection (native content 1.1.0)
function hm_arkintide_mod_gml_hm_stage_protection() {
if (((GameCont.area != scrHMAreaResolve(3)) || (GameCont.subarea != 1))) {
exit;
}
var _hml_clear = hm_arkintide_mod_gml_hm_combat_clear();
;
{ var __hm_with1 = scrHMInstances(CarVenus), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if ((!scrHMVariableExists(id, "hm_car_mask"))) {
{
hm_car_mask = mask_index;
;
hm_car_canfix = 1;
;
if (scrHMVariableExists(id, "canfix")) {
hm_car_canfix = canfix;
}
}
}
if (_hml_clear) {
{
mask_index = hm_car_mask;
;
canfix = hm_car_canfix;
;
}
} else {
{
mask_index = mskNone;
;
canfix = 0;
;
}
}
}
}
if(__hm_break3) break;
}}
if ((! instance_exists(GenCont))) {
{
{ var __hm_with4 = scrHMInstances(WeaponChest), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
hm_arkintide_mod_gml_hm_tool_chest();
}
if(__hm_break6) break;
}}
;
{ var __hm_with7 = scrHMInstances(BigWeaponChest), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
hm_arkintide_mod_gml_hm_tool_chest();
}
if(__hm_break9) break;
}}
;
}
}
}

// Source arkintide.mod.gml:0; hm_tool_chest (native content 1.1.0)
function hm_arkintide_mod_gml_hm_tool_chest() {
scrHMToolChest1100();
}


// Source arkintide.mod.gml:0; hm_tool_chest_destroy (native content 1.1.0)
function hm_arkintide_mod_gml_hm_tool_chest_destroy() {
scrHMContentEvent1100(hm_chest_native, ev_destroy, 0);
;
}

// Source arkintide.mod.gml:0; hm_tool_weapon (native content 1.1.0)
function hm_arkintide_mod_gml_hm_tool_weapon() {
if ((GameCont.loops > 0)) {
return choose(27, 53);
}
return 27;
;
}

// Source arkintide.mod.gml:0; hm_tool_chest_open (native content 1.1.0)
function hm_arkintide_mod_gml_hm_tool_chest_open() {
if ((hm_chest_opened || instance_exists(GenCont))) {
exit;
}
hm_chest_opened = 1;
;
var _hml_latest = 0;
var _hml_native = hm_chest_native;
var _hml_weapon = hm_arkintide_mod_gml_hm_tool_weapon();
;
{ var __hm_with1 = scrHMInstances(WepPickup), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
_hml_latest = max(_hml_latest, id);
}
if(__hm_break3) break;
}}
;
var _hml_collision = Player;
;
if ((instance_exists((scrHMOther(other))) && ((scrHMOther(other)).object_index == PortalShock))) {
_hml_collision = PortalShock;
}
scrHMContentEvent1100(_hml_native, ev_collision, _hml_collision);
;
var _hml_changed = false;
;
{ var __hm_with4 = scrHMInstances(WepPickup), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if (((id > _hml_latest) && (! _hml_changed))) {
{
wep = scrHMWeaponResolve(_hml_weapon);
;
_hml_changed = true;
;
}
}
}
if(__hm_break6) break;
}}
}

// Source arkintide.mod.gml:0; hm_bonefish_track (native content 1.1.0)
function hm_arkintide_mod_gml_hm_bonefish_track() {
if (scrHMVariableExists(id, "hm_bone_watch")) {
exit;
}
hm_bone_watch = 1;
;
{ var __hm_with1 = scrHMInstances(instance_create(x, y, CustomObject)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "hm_bone_watch";
;
var __hm_other4=scrHMOther(other);
hm_source = __hm_other4.id;
;
var __hm_other5=scrHMOther(other);
hm_dead_sprite = __hm_other5.spr_dead;
;
hm_room = instance_find(Floor, 0);
;
hm_subarea = GameCont.subarea;
;
hm_loop = GameCont.loops;
;
hm_grace = 2;
;
on_step = scrHMContentRef1100("mod", "arkintide", "hm_bonefish_watch");
;
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_bonefish_watch (native content 1.1.0)
function hm_arkintide_mod_gml_hm_bonefish_watch() {
if ((((((GameCont.area != scrHMAreaResolve("oasis")) || (GameCont.subarea != hm_subarea)) || (GameCont.loops != hm_loop)) || (! instance_exists(hm_room))) || instance_exists(GenCont))) {
{
scrHMDelete(id);
;
exit;
;
}
}
if (instance_exists(hm_source)) {
{
x = hm_source.x;
;
y = hm_source.y;
;
exit;
;
}
}
var _hml_corpse = noone;
;
{ var __hm_with1 = scrHMInstances(Corpse), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (((((id > (scrHMOther(other)).hm_source) && (sprite_index == (scrHMOther(other)).hm_dead_sprite)) && (!scrHMVariableExists(id, "hm_bone_claimed"))) && (point_distance(x, y, (scrHMOther(other)).x, (scrHMOther(other)).y) < 24))) {
{
_hml_corpse = id;
;
__hm_break3=true; break;
;
}
}
}
if(__hm_break3) break;
}}
if (instance_exists(_hml_corpse)) {
{
_hml_corpse.hm_bone_claimed = 1;
;
hm_arkintide_mod_gml_hm_bonefish_supply(_hml_corpse.x, _hml_corpse.y);
;
scrHMDelete(id);
;
exit;
;
}
}
hm_grace -= 1;
;
if ((hm_grace <= 0)) {
scrHMDelete(id);
}
}

// Source arkintide.mod.gml:0; hm_bonefish_supply (native content 1.1.0)
function hm_arkintide_mod_gml_hm_bonefish_supply(_hml__x, _hml__y) {
if ((random(1) < 0.25)) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, choose(AmmoPickup, HPPickup))), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMMotionAdd(random(360), 2);
}
if(__hm_break3) break;
}}
}
}

// Source arkintide.mod.gml:0; hm_addon_enabled (native content 1.1.0)
function hm_arkintide_mod_gml_hm_addon_enabled(_hml__name) {
return (scrHMModExists("mod", "options", _hml__name) && (scrHMModGet("mod", "options", _hml__name) == "1"));
;
}

// Source arkintide.mod.gml:0; hm_throne_balls (native content 1.1.0)
function hm_arkintide_mod_gml_hm_throne_balls() {
return ((! scrHMModExists("mod", "options", "throneballs")) || (scrHMModGet("mod", "options", "throneballs") == "1"));
;
}

// Source arkintide.mod.gml:0; hm_crown_watch (native content 1.1.0)
function hm_arkintide_mod_gml_hm_crown_watch() {
scrHMCrownWatch1100();
}


// Source arkintide.mod.gml:0; hm_batch_begin (native content 1.1.0)
function hm_arkintide_mod_gml_hm_batch_begin() {
hm_arkintide_mod_gml_hm_camp_police_clear();
;
if ((! instance_exists(GameCont))) {
exit;
}
hm_arkintide_mod_gml_hm_debug_watch();
;
hm_arkintide_mod_gml_hm_portal_style_tick();
;
hm_arkintide_mod_gml_hm_infantry_capture();
;
hm_arkintide_mod_gml_hm_progression();
;
{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
hm_arkintide_mod_gml_hm_health_bonus();
}
if(__hm_break3) break;
}}
;
hm_arkintide_mod_gml_hm_crown_watch();
;
if ((GameCont.area == scrHMAreaResolve("throne"))) {
{
GameCont.novans = 1;
;
{ var __hm_with4 = scrHMInstances(VanSpawn), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
scrHMDelete(id);
}
if(__hm_break6) break;
}}
;
{ var __hm_with7 = scrHMInstances(Van), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
scrHMDelete(id);
}
if(__hm_break9) break;
}}
;
{ var __hm_with10 = scrHMMatching(CustomObject, "name", "3dvan"), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
if (instance_exists(baby)) {
scrHMDelete(baby);
}
scrHMDelete(id);
;
}
}
if(__hm_break12) break;
}}
{ var __hm_with13 = scrHMMatching(CustomEnemy, "name", "IDPDTank"), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
scrHMDelete(id);
}
if(__hm_break15) break;
}}
;
var _hml_second = instance_exists(NothingDeath);
;
{ var __hm_with16 = scrHMInstances(Nothing2), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
if (((((hp > 0) && (image_alpha > 0)) && (mask_index != 0)) && (mask_index != mskNone))) {
_hml_second = true;
}
}
if(__hm_break18) break;
}}
{ var __hm_with19 = scrHMInstances(CustomEnemy), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
if (((spr_idle == sprNothing2Idle) && (hp > 0))) {
_hml_second = true;
}
}
if(__hm_break21) break;
}}
if (_hml_second) {
{
{ var __hm_with22 = scrHMInstances(Corpse), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
if ((alarm[0] >= 0)) {
alarm[0] = max(2, alarm[0]);
}
}
if(__hm_break24) break;
}}
{ var __hm_with25 = scrHMInstances(Portal), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
scrHMDelete(id);
}
if(__hm_break27) break;
}}
;
}
}
}
}
{ var __hm_with28 = scrHMInstances(RavenFly), __hm_break30=false;
for (var __hm_index29=0; __hm_index29<array_length(__hm_with28); ++__hm_index29) {
if(instance_exists(__hm_with28[__hm_index29])) with (__hm_with28[__hm_index29]) {
hm_arkintide_mod_gml_hm_raven_receiver();
}
if(__hm_break30) break;
}}
;
if (((GameCont.area == scrHMAreaResolve("caves")) || (GameCont.area == scrHMAreaResolve("cavesinv")))) {
{ var __hm_with31 = scrHMMatching(CustomObject, "name", "hm_ice_entrance"), __hm_break33=false;
for (var __hm_index32=0; __hm_index32<array_length(__hm_with31); ++__hm_index32) {
if(instance_exists(__hm_with31[__hm_index32])) with (__hm_with31[__hm_index32]) {
hm_arkintide_mod_gml_hm_ice_entrance_clear();
}
if(__hm_break33) break;
}}
}
hm_arkintide_mod_gml_hm_stage_bandit_tick();
;
}

// Source arkintide.mod.gml:0; hm_progression (native content 1.1.0)
function hm_arkintide_mod_gml_hm_progression() {
if (scrHMVariableExists(GameCont, "hm_level_cap")) {
exit;
}
hm_arkintide_mod_gml_hm_progression_start();
;
}

// Source arkintide.mod.gml:0; hm_health_bonus (native content 1.1.0)
function hm_arkintide_mod_gml_hm_health_bonus() {
if ((scrHMVariableExists(id, "hm_hp_bonus") || (max_hp <= 0))) {
exit;
}
hm_arkintide_mod_gml_hm_progression();
;
hm_hp_bonus = 0;
;
if ((! GameCont.hm_playerboost)) {
exit;
}
hm_hp_bonus = 2;
;
var _hml_full = ((hp > 0) && (hp >= max_hp));
;
scrHMMaxHealthWrite(id, hm_hp_bonus, "+=");
;
if (_hml_full) {
{
hp += hm_hp_bonus;
;
lsthealth = hp;
;
}
}
}

// Source arkintide.mod.gml:0; hm_raven_slots (native content 1.1.0)
function hm_arkintide_mod_gml_hm_raven_slots() {
var _hml_alive = 0;
;
{ var __hm_with1 = scrHMInstances(Raven), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (((scrHMVariableExists(id, "hm_bird_summon") && hm_bird_summon) && (hp > 0))) {
_hml_alive++;
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(RavenFly), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if (((scrHMVariableExists(id, "hm_bird_summon") && hm_bird_summon) && (hp > 0))) {
_hml_alive++;
}
}
if(__hm_break6) break;
}}
return max(0, (20 - _hml_alive));
;
}

// Source arkintide.mod.gml:0; hm_batch_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_batch_step() {
if (instance_exists(GenCont)) {
{
hm_population_done = 0;
;
exit;
;
}
}
if (((! instance_exists(Floor)) || (! instance_exists(Player)))) {
exit;
}
if ((((GameCont.area == scrHMAreaResolve("caves")) || (GameCont.area == scrHMAreaResolve("cavesinv"))) && (GameCont.subarea == 3))) {
hm_arkintide_mod_gml_hm_jungle_entrance();
}
if (((((!scrHMVariableExists(id, "hm_population_area")) || (scrHMAreaResolve(hm_population_area) != GameCont.area)) || (hm_population_sub != GameCont.subarea)) || (hm_population_loop != GameCont.loops))) {
{
hm_population_area = GameCont.area;
;
hm_population_sub = GameCont.subarea;
;
hm_population_loop = GameCont.loops;
;
hm_population_done = 0;
;
}
}
if ((! hm_population_done)) {
{
hm_population_done = 1;
;
GameCont.hm_extra_room_started = current_frame;
;
if (((GameCont.loops >= 1) && (GameCont.area == scrHMAreaResolve(1)))) {
hm_arkintide_mod_gml_hm_desert_bandits();
}
if (((GameCont.loops > 0) && (GameCont.area == scrHMAreaResolve("oasis")))) {
hm_arkintide_mod_gml_hm_oasis_necromancers();
}
scrHMSnowPopulation1116();
if ((GameCont.loops >= 3)) {
hm_arkintide_mod_gml_hm_extra_population();
}
}
}
}

// Source arkintide.mod.gml:0; hm_venus_drop_init (native content 1.1.0)
function hm_arkintide_mod_gml_hm_venus_drop_init(_hml__rads, _hml__chance) {
if (((GameCont.area == scrHMAreaResolve("venuz")) || (GameCont.area == scrHMAreaResolve(103)))) {
exit;
}
raddrop = _hml__rads;
;
hm_rad_fixed = 1;
;
hm_supply_chance = _hml__chance;
;
hm_supply_done = 0;
;
}

// Source arkintide.mod.gml:0; hm_venus_supply (native content 1.1.0)
function hm_arkintide_mod_gml_hm_venus_supply() {
if ((((!scrHMVariableExists(id, "hm_supply_chance")) || (hp > 0)) || hm_supply_done)) {
exit;
}
hm_supply_done = 1;
;
if ((random(1) < hm_supply_chance)) {
{ var __hm_with1 = scrHMInstances(instance_create(x, y, choose(AmmoPickup, HPPickup))), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMMotionAdd(random(360), 2);
}
if(__hm_break3) break;
}}
}
}

// Source arkintide.mod.gml:0; hm_van_death (native content 1.1.0)
function hm_arkintide_mod_gml_hm_van_death() {
{ var __hm_with1 = scrHMInstances(WantVan), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
canspawn = 1;
}
if(__hm_break3) break;
}}
;
if ((! instance_exists(baby))) {
{
hm_arkintide_mod_gml_hm_van_recheck_exit();
;
exit;
;
}
}
var _hml_final = true;
;
{ var __hm_with4 = scrHMInstances(enemy), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if (((((id != (scrHMOther(other)).baby) && (hp > 0)) && (team != 2)) && (! (scrHMVariableExists(id, "hm_noncombat") && hm_noncombat)))) {
{
_hml_final = false;
;
__hm_break6=true; break;
;
}
}
}
if(__hm_break6) break;
}}
if ((instance_exists(becomenemy) || instance_exists(Portal))) {
_hml_final = false;
}
{ var __hm_with7 = scrHMInstances(Corpse), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
if (((scrHMVariableExists(id, "do_portal") && do_portal) && ((alarm[0] >= 0) || ((image_speed / timescale) > 0)))) {
_hml_final = false;
}
}
if(__hm_break9) break;
}}
{ var __hm_with10 = scrHMInstances(CustomObject), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
if ((((scrHMVariableExists(id, "name") && (name == "hm_techcorpse")) && scrHMVariableExists(id, "hm_exit_delay")) && (hm_exit_delay >= 0))) {
_hml_final = false;
}
}
if(__hm_break12) break;
}}
{ var __hm_with13 = scrHMInstances(baby), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
corpse = 0;
;
if (_hml_final) {
{
{ var __hm_with16 = scrHMInstances(instance_create(x, y, Corpse)), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
{
sprite_index = mskNone;
;
alarm[0] = 30;
;
}
}
if(__hm_break18) break;
}}
}
}
}
}
if(__hm_break15) break;
}}
}

// Source arkintide.mod.gml:0; hm_raven_receiver (native content 1.1.0)
function hm_arkintide_mod_gml_hm_raven_receiver() {
if ((scrHMVariableExists(id, "hm_ranged_receiver") && instance_exists(hm_ranged_receiver))) {
exit;
}
var _hml_bird = id;
;
{ var __hm_with1 = scrHMInstances(instance_create(x, (y + z), CustomHitme)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "hm_raven_receiver";
;
hm_bird = _hml_bird;
;
visible = false;
;
team = 1;
;
mask_index = mskBandit;
;
hp = 1000000;
;
scrHMMaxHealthWrite(id, hp, "=");
;
canmelee = 0;
;
friction = (100) * (timescale * timescale);
;
on_hurt = scrHMContentRef1100("mod", "arkintide", "hm_raven_hurt");
;
on_step = scrHMContentRef1100("mod", "arkintide", "hm_raven_follow");
;
_hml_bird.hm_ranged_receiver = id;
;
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_raven_follow (native content 1.1.0)
function hm_arkintide_mod_gml_hm_raven_follow() {
if (((! instance_exists(hm_bird)) || (hm_bird.object_index != RavenFly))) {
{
scrHMDelete(id);
;
exit;
;
}
}
x = hm_bird.x;
;
y = (hm_bird.y + hm_bird.z);
;
hp = 1000000;
;
if ((hm_bird.hp <= 0)) {
{
{ var __hm_with1 = scrHMInstances(hm_bird), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var _hml_yy = y;
;
scrHMContentChange1100(Raven, false);
;
y = _hml_yy;
;
hp = 0;
;
mask_index = mskBandit;
;
spr_dead = sprRavenDead;
;
}
}
if(__hm_break3) break;
}}
scrHMDelete(id);
;
}
}
}

// Source arkintide.mod.gml:0; hm_raven_hurt (native content 1.1.0)
function hm_arkintide_mod_gml_hm_raven_hurt(_hml__damage) {
if (((! instance_exists(hm_bird)) || (hm_bird.object_index != RavenFly))) {
exit;
}
if (instance_exists((scrHMOther(other)))) {
{
if (((instance_is((scrHMOther(other)), Slash) || instance_is((scrHMOther(other)), EnemySlash)) || instance_is((scrHMOther(other)), Slash))) {
exit;
}
}
}
hm_bird.hp -= _hml__damage;
;
hm_bird.nexthurt = (current_frame + 4);
;
}

// Source arkintide.mod.gml:0; hm_ice_entrance_clear (native content 1.1.0)
function hm_arkintide_mod_gml_hm_ice_entrance_clear() {
var _hml_entrance = id;
;
{ var __hm_with1 = scrHMInstances(enemy), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (((hp > 0) && (point_distance(x, y, _hml_entrance.x, _hml_entrance.y) < 36))) {
{
var _hml_source = id;
var _hml_found = noone;
var _hml_best = 1000000000;
;
{ var __hm_with4 = scrHMInstances(Floor), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
var _hml_px = (x + 16);
var _hml_py = (y + 16);
;
if ((point_distance(_hml_px, _hml_py, _hml_entrance.x, _hml_entrance.y) < 56)) {
continue;
}
var _hml_dist = point_distance(_hml_px, _hml_py, _hml_source.x, _hml_source.y);
;
if (((_hml_dist >= _hml_best) || (_hml_dist > 256))) {
continue;
}
{ var __hm_with7 = scrHMInstances(_hml_source), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
if ((((! place_meeting(_hml_px, _hml_py, Wall)) && (! place_meeting(_hml_px, _hml_py, InvisiWall))) && place_meeting(_hml_px, _hml_py, Floor))) {
{
var __hm_other10=scrHMOther(other);
_hml_found = __hm_other10;
;
_hml_best = _hml_dist;
;
}
}
}
if(__hm_break9) break;
}}
}
}
if(__hm_break6) break;
}}
if (instance_exists(_hml_found)) {
{
x = (_hml_found.x + 16);
;
y = (_hml_found.y + 16);
;
xprevious = x;
;
yprevious = y;
;
speed = (0) * timescale;
;
}
}
}
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_batch_cleanup (native content 1.1.0)
function hm_arkintide_mod_gml_hm_batch_cleanup() {
if ((scrHMVariableExists(id, "hm_water_map") && (hm_water_map != undefined))) {
{
ds_map_destroy(hm_water_map);
;
hm_water_map = undefined;
;
}
}
if ((scrHMVariableExists(id, "hm_rad_grid") && (hm_rad_grid != undefined))) {
{
ds_map_destroy(hm_rad_grid);
;
hm_rad_grid = undefined;
;
}
}
if ((scrHMVariableExists(GameCont, "hm_missile_loop") && GameCont.hm_missile_loop)) {
{
scrHMSoundStop(sndEliteGruntRocketFly);
;
GameCont.hm_missile_loop = 0;
;
}
}
}

// Source arkintide.mod.gml:0; hm_water_cache_build (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_cache_build() {
if ((instance_exists(GenCont) || (! instance_exists(Floor)))) {
exit;
}
if ((!scrHMVariableExists(GameCont, "hm_native_controller_id"))) {
exit;
}
var _hml_owner = GameCont.hm_native_controller_id;
;
if ((! instance_exists(_hml_owner))) {
exit;
}
if ((! scrHMVariableExists(_hml_owner, "hm_water_map"))) {
_hml_owner.hm_water_map = undefined;
}
var _hml_count = instance_number(Floor);
;
if (((((_hml_owner.hm_water_map != undefined) && scrHMVariableExists(_hml_owner, "hm_water_floor")) && instance_exists(_hml_owner.hm_water_floor)) && (_hml_owner.hm_water_count == _hml_count))) {
exit;
}
if ((_hml_owner.hm_water_map == undefined)) {
_hml_owner.hm_water_map = ds_map_create();
} else {
ds_map_clear(_hml_owner.hm_water_map);
}
;
_hml_owner.hm_water_floor = instance_find(Floor, 0);
;
_hml_owner.hm_water_count = _hml_count;
;
hm_arkintide_mod_gml_hm_water_invalidate();
;
var _hml_grid = _hml_owner.hm_water_map;
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var _hml_left = bbox_left;
var _hml_right = bbox_right;
var _hml_top = bbox_top;
var _hml_bottom = bbox_bottom;
;
if ((sprite_index == mskNone)) {
{
_hml_left = x;
;
_hml_right = (x + 31);
;
_hml_top = y;
;
_hml_bottom = (y + 31);
;
}
}
for (var _hml_cy = floor((_hml_top / 32)); (_hml_cy <= floor((_hml_bottom / 32))); _hml_cy++) for (var _hml_cx = floor((_hml_left / 32)); (_hml_cx <= floor((_hml_right / 32))); _hml_cx++) {
var _hml_key = ((string(_hml_cx) + ":") + string(_hml_cy));
var _hml_items = [];
;
if (ds_map_exists(_hml_grid, _hml_key)) {
_hml_items = ds_map_find_value(_hml_grid, _hml_key);
}
_hml_items[array_length(_hml_items)] = id;
;
ds_map_replace(_hml_grid, _hml_key, _hml_items);
;
}
}
}
if(__hm_break3) break;
}}
hm_arkintide_mod_gml_hm_water_flat_build(_hml_owner);
;
}

// Source arkintide.mod.gml:0; hm_water_candidates (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_candidates(_hml__x, _hml__y, _hml__list) {
var _hml_owner = noone;
;
if (scrHMVariableExists(GameCont, "hm_native_controller_id")) {
_hml_owner = GameCont.hm_native_controller_id;
}
if ((((! instance_exists(_hml_owner)) || (! scrHMVariableExists(_hml_owner, "hm_water_map"))) || (_hml_owner.hm_water_map == undefined))) {
{
collision_point_list(_hml__x, _hml__y, Floor, false, true, _hml__list, false);
;
exit;
;
}
}
var _hml_key = ((string(floor((_hml__x / 32))) + ":") + string(floor((_hml__y / 32))));
;
if ((! ds_map_exists(_hml_owner.hm_water_map, _hml_key))) {
exit;
}
var _hml_items = ds_map_find_value(_hml_owner.hm_water_map, _hml_key);
;
for (var _hml_i = 0; (_hml_i < array_length(_hml_items)); _hml_i++) {
var _hml_tile = _hml_items[_hml_i];
;
if ((! instance_exists(_hml_tile))) {
continue;
}
var _hml_left = _hml_tile.bbox_left;
var _hml_right = _hml_tile.bbox_right;
var _hml_top = _hml_tile.bbox_top;
var _hml_bottom = _hml_tile.bbox_bottom;
;
if ((_hml_tile.sprite_index == mskNone)) {
{
_hml_left = _hml_tile.x;
;
_hml_right = (_hml_tile.x + 31);
;
_hml_top = _hml_tile.y;
;
_hml_bottom = (_hml_tile.y + 31);
;
}
}
if (((((_hml__x >= _hml_left) && (_hml__x <= _hml_right)) && (_hml__y >= _hml_top)) && (_hml__y <= _hml_bottom))) {
ds_list_add(_hml__list, _hml_tile);
}
}
}

// Source arkintide.mod.gml:0; hm_attack_loops (native content 1.1.0)
function hm_arkintide_mod_gml_hm_attack_loops() {
if ((scrHMVariableExists(id, "hm_extra") && hm_extra)) {
return 0;
}
if ((((scrHMVariableExists(id, "creator") && instance_exists(creator)) && scrHMVariableExists(creator, "hm_extra")) && creator.hm_extra)) {
return 0;
}
if ((scrHMVariableExists(GameCont, "hm_extra_pending") && GameCont.hm_extra_pending)) {
return 0;
}
return GameCont.loops;
;
}

// Source arkintide.mod.gml:0; hm_desert_bandits (native content 1.1.0)
function hm_arkintide_mod_gml_hm_desert_bandits() {
var _hml_remaining = min(3, (1 + (GameCont.loops div 3)));
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((((_hml_remaining > 0) && (point_distance((x + 16), (y + 16), 10016, 10016) > 128)) && (collision_circle((x + 16), (y + 16), 12, [Wall, InvisiWall, enemy], false, true) == noone))) {
{
instance_create((x + 16), (y + 16), JungleBandit);
;
_hml_remaining--;
;
}
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_throne_generators (native content 1.1.0)
function hm_arkintide_mod_gml_hm_throne_generators(_hml__axis, _hml__top, _hml__bottom) {
var _hml_count = instance_number(BigGenerator);
var _hml_index = 0;
var _hml_pairs = ceil((_hml_count / 2));
var _hml_placed = [];
;
{ var __hm_with1 = scrHMInstances(BigGenerator), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var _hml_source = id;
var _hml_side = 1;
;
if (((_hml_index mod 2) == 0)) {
_hml_side = (- 1);
}
var _hml_mask = hm_arkintide_mod_gml_hm_effective_mask();
var _hml_row = (_hml_index div 2);
var _hml_desired_y = (_hml__top + 144);
;
if ((_hml_pairs > 1)) {
_hml_desired_y += ((max(0, (((_hml__bottom - _hml__top) * 0.38) - 144)) * _hml_row) / (_hml_pairs - 1));
}
var _hml_found = noone;
var _hml_best = 1000000000;
;
{ var __hm_with4 = scrHMInstances(Floor), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
var _hml_px = (x + 16);
var _hml_py = (y + 16);
;
if ((((_hml_py < (_hml__top + 80)) || (_hml_py >= ((_hml__top + _hml__bottom) / 2))) || (((_hml_px - _hml__axis) * _hml_side) <= 0))) {
continue;
}
var _hml_dist = point_distance(_hml_px, _hml_py, (_hml__axis + (_hml_side * 96)), _hml_desired_y);
;
if (((_hml_dist >= _hml_best) || (! hm_arkintide_mod_gml_hm_throne_clear(_hml_px, _hml_py, _hml_mask)))) {
continue;
}
var _hml_overlap = false;
;
for (var _hml_g = 0; (_hml_g < array_length(_hml_placed)); _hml_g++) if ((point_distance(_hml_px, _hml_py, _hml_placed[_hml_g].x, _hml_placed[_hml_g].y) < 72)) {
_hml_overlap = true;
}
if (_hml_overlap) {
continue;
}
_hml_found = id;
;
_hml_best = _hml_dist;
;
}
}
if(__hm_break6) break;
}}
if (instance_exists(_hml_found)) {
{
x = (_hml_found.x + 16);
;
y = (_hml_found.y + 16);
;
xstart = x;
;
ystart = y;
;
xprevious = x;
;
yprevious = y;
;
array_push(_hml_placed, id);
;
}
}
_hml_index++;
;
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_oasis_necromancers (native content 1.1.0)
function hm_arkintide_mod_gml_hm_oasis_necromancers() {
var _hml_remaining = min(3, (1 + (GameCont.loops div 3)));
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((((_hml_remaining > 0) && (point_distance((x + 16), (y + 16), 10016, 10016) > 128)) && (collision_circle((x + 16), (y + 16), 16, [Wall, InvisiWall, enemy], false, true) == noone))) {
{
instance_create((x + 16), (y + 16), Necromancer);
;
_hml_remaining--;
;
}
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_extra_pool (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_pool(_hml__area) {
switch (_hml__area) {
case 1:

case 219:

case 203:
return ["bandit", "junglebandit", "bubble", "hunter"];
;
case 218:
return ["bubble", "mom", "crystal", "turtle", "rat"];
;
case 208:
return ["bubble", "tech", "turtle", "gator"];
;
case 3:

case 217:

case 202:
return ["mom", "bandit", "bird"];
;
case 216:
return ["crystal", "cursedcrystal", "junglebandit", "gator"];
;
case 210:
return ["crystal", "cursedcrystal", "junglebandit"];
;
case 215:
return ["hunter", "bandit", "tech", "rogue", "dog"];
;
case 209:
return ["junglebandit", "bird", "bandit", "bubble", "gator"];
;
case 214:
return ["hunter", "cursedcrystal", "rogue"];
;
case 213:
return ["bandit", "junglebandit", "hunter"];
;
case 206:

case 106:
return ["rogue", "tech", "hunter"];
;
}
return [];
;
}

// Source arkintide.mod.gml:0; hm_extra_population (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_population() {
scrHMExtraPopulation1103();
}

// Source arkintide.mod.gml:0; hm_extra_spawn (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_spawn(_hml__kind, _hml__x, _hml__y) {
if(GameCont.loops<3) return noone;
if ((! hm_arkintide_mod_gml_hm_extra_fit(_hml__kind, _hml__x, _hml__y))) {
return noone;
}
if (((_hml__kind == "rat") && (! hm_arkintide_mod_gml_hm_extra_water_prepare(_hml__x, _hml__y)))) {
return noone;
}
var _hml_actor = noone;
var _hml_native = noone;
var _hml_base = 0;
var _hml_actual_loop = GameCont.loops;
;
switch (_hml__kind) {
case "bandit":

case "junglebandit":
_hml_native = BanditBoss;
;
break;
;
case "bubble":
_hml_native = OasisBoss;
;
break;
;
case "hunter":
_hml_native = LilHunter;
;
break;
;
case "mom":
_hml_native = FrogQueen;
;
break;
;
case "crystal":

case "cursedcrystal":
_hml_native = HyperCrystal;
;
break;
;
case "tech":
_hml_native = TechnoMancer;
;
break;
;
case "dog":
_hml_native = ScrapBoss;
;
break;
;
}
if ((_hml_native != noone)) {
{
var _hml_music = noone;
var _hml_saved_music = (- 1);
var _hml_ui = noone;
var _hml_portraits = 0;
;
if (instance_exists(MusCont)) {
{
_hml_music = instance_find(MusCont, 0);
;
_hml_saved_music = _hml_music.alarm[2];
;
}
}
if (instance_exists(UberCont)) {
{
_hml_ui = instance_find(UberCont, 0);
;
_hml_portraits = _hml_ui.opt_bossintro;
;
_hml_ui.opt_bossintro = 0;
;
}
}
GameCont.loops = 0;
;
_hml_actor = instance_create(_hml__x, _hml__y, _hml_native);
;
GameCont.loops = _hml_actual_loop;
;
if (instance_exists(_hml_ui)) {
_hml_ui.opt_bossintro = _hml_portraits;
}
if (instance_exists(_hml_music)) {
_hml_music.alarm[2] = _hml_saved_music;
}
if ((! instance_exists(_hml_actor))) {
return noone;
}
_hml_base = _hml_actor.max_hp;
;
{ var __hm_with1 = scrHMInstances(_hml_actor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
hm_extra_native = object_index;
;
hm_arkintide_mod_gml_hm_extra_combat(_hml__kind, _hml__x, _hml__y);
;
hm_arkintide_mod_gml_hm_extra_timer_take();
;
hm_arkintide_mod_gml_hm_extra_change(CustomEnemy);
;
hm_arkintide_mod_gml_hm_extra_bind();
;
}
}
if(__hm_break3) break;
}}
}
} else {
{
GameCont.hm_extra_pending = 1;
;
if ((_hml__kind == "gator")) {
_hml_actor = scrHMModCall("mod", "gatorboss", "gatorboss_create", _hml__x, _hml__y);
}
if ((_hml__kind == "bird")) {
_hml_actor = scrHMModCall("mod", "ravenboss", "ravenboss_create", _hml__x, _hml__y);
}
if ((_hml__kind == "turtle")) {
_hml_actor = scrHMModCall("mod", "turtles", (("turtle" + string(irandom_range(1, 4))) + "_create"), _hml__x, _hml__y);
}
if ((_hml__kind == "rogue")) {
_hml_actor = scrHMModCall("mod", "enemies", "enemyrogue_create", _hml__x, _hml__y);
}
if (((_hml__kind == "rat") && hm_arkintide_mod_gml_hm_extra_water_fit(_hml__x, _hml__y))) {
_hml_actor = scrHMModCall("mod", "ratboss", "ratboss_create", _hml__x, _hml__y);
}
GameCont.hm_extra_pending = 0;
;
if ((! instance_exists(_hml_actor))) {
return noone;
}
_hml_base = _hml_actor.max_hp;
;
}
}
{ var __hm_with4 = scrHMInstances(_hml_actor), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
hm_extra = 1;
;
hm_extra_kind = _hml__kind;
;
hm_extra_attack_at = (current_frame + 30);
;
if (scrHMVariableExists(GameCont, "hm_extra_room_started")) {
hm_extra_attack_at = (GameCont.hm_extra_room_started + 30);
}
if ((_hml_native == noone)) {
hm_arkintide_mod_gml_hm_extra_combat(_hml__kind, _hml__x, _hml__y);
}
boss = 0;
;
newintro = (- 1);
;
intro = 1;
;
corpse = 1;
;
team = 1;
;
hm_maxhealth_init = false;
;
scrHMMaxHealthWrite(id, (_hml_base * (1 + (0.05 * _hml_actual_loop))), "=");
;
hp = max_hp;
;
on_death = scrHMContentRef1100("mod", "arkintide", "hm_extra_loot");
;
on_destroy = undefined;
;
if ((_hml__kind == "rat")) {
{
team = 1;
;
canmelee = 1;
;
tenticles = (- 1);
;
storehp = hp;
;
midhealth = (- 1);
;
spr_idle = scrHMModGet("mod", "ratboss", "ratbossidle");
;
spr_hurt = scrHMModGet("mod", "ratboss", "ratbosshurt");
;
sprite_index = spr_idle;
;
on_step = scrHMContentRef1100("mod", "arkintide", "hm_extra_rat_step");
;
on_draw = scrHMContentRef1100("mod", "arkintide", "hm_extra_rat_draw");
;
}
}
if ((_hml__kind == "junglebandit")) {
spr_dead = global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_dead;
}
if ((_hml__kind == "tech")) {
{
spr_dead = sprTechnoMancerDead;
;
main = 1;
;
drawspr = sprTechnoMancerInactive;
;
drawimg = 0;
;
}
}
if ((_hml__kind == "gator")) {
{
intro = 1;
;
time = 0;
;
alrm2 = 2;
;
}
}
if ((_hml__kind == "bird")) {
{
z = 0;
;
flying = false;
;
mask_index = mskBanditBoss;
;
alrm0 = 1;
;
alrm1 = 45;
;
}
}
hm_extra_corpse_sprite = spr_dead;
;
if ((_hml__kind != "tech")) {
hm_extra_corpse_sprite = hm_arkintide_mod_gml_hm_extra_dead_sprite(spr_dead);
}
spr_dead = hm_extra_corpse_sprite;
;
}
}
if(__hm_break6) break;
}}
return _hml_actor;
;
}

// Source arkintide.mod.gml:0; hm_extra_dead_sprite (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_dead_sprite(_hml__sprite) {
if ((! sprite_exists(_hml__sprite))) {
return _hml__sprite;
}
var _hml_index = scrHMArrayFind1100(global.hm_module_vars[$ "mod:arkintide"].hm_extra_dead_sources, _hml__sprite);
;
if ((_hml_index >= 0)) {
return global.hm_module_vars[$ "mod:arkintide"].hm_extra_dead_copies[_hml_index];
}
var _hml_copy = sprite_duplicate(_hml__sprite);
;
array_push(global.hm_module_vars[$ "mod:arkintide"].hm_extra_dead_sources, _hml__sprite);
;
array_push(global.hm_module_vars[$ "mod:arkintide"].hm_extra_dead_copies, _hml_copy);
;
return _hml_copy;
;
}

// Source arkintide.mod.gml:0; hm_extra_bind (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_bind() {
scrHMExtraCrystalIdentity1116();
hm_extra = 1;
;
boss = 0;
;
newintro = (- 1);
;
can_die = true;
;
hm_maxhealth_init = false;
;
on_begin_step = scrHMContentRef1100("mod", "arkintide", "hm_extra_begin");
;
on_step = scrHMContentRef1100("mod", "arkintide", "hm_extra_step");
;
on_end_step = undefined;
;
on_draw = scrHMContentRef1100("mod", "arkintide", "hm_extra_draw");
;
on_hurt = undefined;
;
on_death = scrHMContentRef1100("mod", "arkintide", "hm_extra_loot");
;
on_destroy = undefined;
;
on_cleanup = undefined;
;
if (scrHMVariableExists(id, "hm_extra_corpse_sprite")) {
spr_dead = hm_extra_corpse_sprite;
}
}

// Source arkintide.mod.gml:0; hm_extra_timer_take (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_timer_take() {
if ((!scrHMVariableExists(id, "hm_extra_alarms"))) {
hm_extra_alarms = array_create(12, (- 1));
}
hm_extra_alarms[0] = alarm[0];
;
hm_extra_alarms[1] = alarm[1];
;
hm_extra_alarms[2] = alarm[2];
;
hm_extra_alarms[3] = alarm[3];
;
hm_extra_alarms[4] = alarm[4];
;
hm_extra_alarms[5] = alarm[5];
;
hm_extra_alarms[6] = alarm[6];
;
hm_extra_alarms[7] = alarm[7];
;
hm_extra_alarms[8] = alarm[8];
;
hm_extra_alarms[9] = alarm[9];
;
hm_extra_alarms[10] = alarm[10];
;
hm_extra_alarms[11] = alarm[11];
;
alarm[0] = (- 1);
;
alarm[1] = (- 1);
;
alarm[2] = (- 1);
;
alarm[3] = (- 1);
;
alarm[4] = (- 1);
;
alarm[5] = (- 1);
;
alarm[6] = (- 1);
;
alarm[7] = (- 1);
;
alarm[8] = (- 1);
;
alarm[9] = (- 1);
;
alarm[10] = (- 1);
;
alarm[11] = (- 1);
;
}

// Source arkintide.mod.gml:0; hm_extra_timer_restore (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_timer_restore() {
alarm[0] = hm_extra_alarms[0];
;
alarm[1] = hm_extra_alarms[1];
;
alarm[2] = hm_extra_alarms[2];
;
alarm[3] = hm_extra_alarms[3];
;
alarm[4] = hm_extra_alarms[4];
;
alarm[5] = hm_extra_alarms[5];
;
alarm[6] = hm_extra_alarms[6];
;
alarm[7] = hm_extra_alarms[7];
;
alarm[8] = hm_extra_alarms[8];
;
alarm[9] = hm_extra_alarms[9];
;
alarm[10] = hm_extra_alarms[10];
;
alarm[11] = hm_extra_alarms[11];
;
}

// Source arkintide.mod.gml:0; hm_extra_event (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_event(_hml__type, _hml__number) {
scrHMExtraCrystalIdentity1116();
var _hml_loop = GameCont.loops;
var _hml_area = GameCont.area;
var _hml_music = noone;
var _hml_saved_music = (- 1);
var _hml_ui = noone;
var _hml_portraits = 0;
;
if (instance_exists(MusCont)) {
{
_hml_music = instance_find(MusCont, 0);
;
_hml_saved_music = _hml_music.alarm[2];
;
}
}
if (instance_exists(UberCont)) {
{
_hml_ui = instance_find(UberCont, 0);
;
_hml_portraits = _hml_ui.opt_bossintro;
;
_hml_ui.opt_bossintro = 0;
;
}
}
GameCont.loops = 0;
;
if ((hm_extra_kind == "cursedcrystal")) {
GameCont.area = scrHMAreaResolve(104);
}
hm_arkintide_mod_gml_hm_extra_timer_restore();
;
hm_arkintide_mod_gml_hm_extra_change(hm_extra_native);
;
// Crystals implement their AI as User Event 0 and inherit Step from enemy.
// Performing a missing Step directly on HyperCrystal does not dispatch it.
if (hm_extra_native == HyperCrystal && _hml__type == ev_other && _hml__number == 15) {
scrTarget();
scrHMExtraCrystalNative1115();
} else {
scrHMContentEvent1100(hm_extra_native, _hml__type, _hml__number);
}
;
GameCont.loops = _hml_loop;
;
GameCont.area = scrHMAreaResolve(_hml_area);
;
if (instance_exists(_hml_ui)) {
_hml_ui.opt_bossintro = _hml_portraits;
}
if (instance_exists(_hml_music)) {
_hml_music.alarm[2] = _hml_saved_music;
}
if ((! instance_exists(id))) {
exit;
}
hm_arkintide_mod_gml_hm_extra_timer_take();
;
hm_extra_native = object_index;
;
hm_arkintide_mod_gml_hm_extra_change(CustomEnemy);
;
hm_arkintide_mod_gml_hm_extra_bind();
;
}

// Source arkintide.mod.gml:0; hm_extra_begin (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_begin() {
exit;
;
}

// Source arkintide.mod.gml:0; hm_extra_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_step() {
if (((hp <= 0) || (! hm_arkintide_mod_gml_hm_extra_ready()))) {
{
speed = (0) * timescale;
;
exit;
;
}
}
for (var _hml_a = 0; (_hml_a < 12); _hml_a++) if ((hm_extra_alarms[_hml_a] >= 0)) {
{
var _hml_before = hm_extra_alarms[_hml_a];
;
hm_extra_alarms[_hml_a] = max((- 1), (_hml_before - 1));
;
if (((_hml_before >= 0) && (hm_extra_alarms[_hml_a] <= 0))) {
{
hm_extra_alarms[_hml_a] = (- 1);
;
hm_arkintide_mod_gml_hm_extra_event(ev_alarm, _hml_a);
;
if ((! instance_exists(id))) {
exit;
}
}
}
}
}
hm_arkintide_mod_gml_hm_extra_event(ev_other, 15);
;
if ((! instance_exists(id))) {
exit;
}
hm_arkintide_mod_gml_hm_extra_breakwalls();
;
if ((! instance_exists(id))) {
exit;
}
if (((sprite_exists(sprite_index) && ((image_speed / timescale) > 0)) && ((image_index + (image_speed / timescale)) >= sprite_get_number(sprite_index)))) {
hm_arkintide_mod_gml_hm_extra_event(ev_other, 7);
}
}

// Source arkintide.mod.gml:0; hm_extra_breakwalls (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_breakwalls() {
if (((hm_extra_native != TechnoMancer) && (hm_extra_native != BanditBoss))) {
exit;
}
if (((hm_extra_native == BanditBoss) && (charge <= 0))) {
exit;
}
var _hml_source = id;
var _hml_wall = instance_place((x + ((hspeed / timescale) * 1)), (y + ((vspeed / timescale) * 1)), Wall);
;
if ((! instance_exists(_hml_wall))) {
_hml_wall = instance_place(x, y, Wall);
}
if ((! instance_exists(_hml_wall))) {
exit;
}
{ var __hm_with1 = scrHMInstances(_hml_wall), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{ var __hm_with4 = scrHMInstances(_hml_source), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
hm_arkintide_mod_gml_hm_extra_event(ev_collision, Wall);
}
if(__hm_break6) break;
}}
}
if(__hm_break3) break;
}}
;
}

// Source arkintide.mod.gml:0; hm_extra_draw (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_draw() {
scrHMExtraCrystalIdentity1116();
var _hml_sprite = sprite_index;
;
sprite_index = hm_arkintide_mod_gml_hm_extra_skin(_hml_sprite);
;
if (scrHMObjectHasEvent1100(hm_extra_native, ev_draw, 0)) {
scrHMContentEvent1100(hm_extra_native, ev_draw, 0);
} else {
draw_self();
}
;
sprite_index = _hml_sprite;
;
}

// Source arkintide.mod.gml:0; hm_extra_skin (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_skin(_hml__sprite) {
if ((hm_extra_kind == "junglebandit")) {
{
switch (_hml__sprite) {
case sprBanditBossIdle:
return global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_idle;
;
case sprBanditBossWalk:
return global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_walk;
;
case sprBanditBossFire:
return global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_fire;
;
case sprBanditBossTell:
return global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_tell;
;
case sprBanditBossDash:
return global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_dash;
;
case sprBanditBossStop:
return global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_stop;
;
case sprBanditBossHurt:
return global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_hurt;
;
case sprBanditBossDead:
return global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_dead;
;
}
}
}
if ((hm_extra_kind == "cursedcrystal")) {
{
if ((_hml__sprite == sprHyperCrystalIdle)) {
return global.hm_module_vars[$ "mod:arkintide"].hm_extra_cursed_idle;
}
if ((_hml__sprite == sprHyperCrystalHurt)) {
return global.hm_module_vars[$ "mod:arkintide"].hm_extra_cursed_hurt;
}
}
}
return _hml__sprite;
;
}

// Source arkintide.mod.gml:0; hm_extra_water_fit (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_water_fit(_hml__x, _hml__y) {
var _hml_left = ((_hml__x + sprite_get_bbox_left(mskVan)) - sprite_get_xoffset(mskVan));
;
var _hml_right = ((_hml__x + sprite_get_bbox_right(mskVan)) - sprite_get_xoffset(mskVan));
;
var _hml_top = ((_hml__y + sprite_get_bbox_top(mskVan)) - sprite_get_yoffset(mskVan));
;
var _hml_bottom = ((_hml__y + sprite_get_bbox_bottom(mskVan)) - sprite_get_yoffset(mskVan));
;
for (var _hml_yy = _hml_top; (_hml_yy <= _hml_bottom); _hml_yy += 16) {
for (var _hml_xx = _hml_left; (_hml_xx <= _hml_right); _hml_xx += 16) if ((! hm_arkintide_mod_gml_hm_water_at(_hml_xx, _hml_yy))) {
return false;
}
if ((! hm_arkintide_mod_gml_hm_water_at(_hml_right, _hml_yy))) {
return false;
}
}
for (var _hml_xx = _hml_left; (_hml_xx <= _hml_right); _hml_xx += 16) if ((! hm_arkintide_mod_gml_hm_water_at(_hml_xx, _hml_bottom))) {
return false;
}
return hm_arkintide_mod_gml_hm_water_at(_hml_right, _hml_bottom);
;
}

// Source arkintide.mod.gml:0; hm_extra_water_entrance_clear (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_water_entrance_clear(_hml__x, _hml__y) {
var _hml_left = ((_hml__x + sprite_get_bbox_left(mskVan)) - sprite_get_xoffset(mskVan));
;
var _hml_right = ((_hml__x + sprite_get_bbox_right(mskVan)) - sprite_get_xoffset(mskVan));
;
var _hml_top = ((_hml__y + sprite_get_bbox_top(mskVan)) - sprite_get_yoffset(mskVan));
;
var _hml_bottom = ((_hml__y + sprite_get_bbox_bottom(mskVan)) - sprite_get_yoffset(mskVan));
;
return (collision_rectangle(_hml_left, _hml_top, _hml_right, _hml_bottom, PizzaEntrance, false, true) == noone);
;
}

// Source arkintide.mod.gml:0; hm_extra_water_tiles (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_water_tiles(_hml__x, _hml__y) {
if (((GameCont.area != scrHMAreaResolve("sewers")) || (! scrHMModExists("area", "sewers", "sewagefloor")))) {
return [];
}
var _hml_origin = noone;
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((((((object_index != FloorExplo) && (x <= _hml__x)) && ((x + 32) > _hml__x)) && (y <= _hml__y)) && ((y + 32) > _hml__y))) {
_hml_origin = id;
}
}
if(__hm_break3) break;
}}
if ((! instance_exists(_hml_origin))) {
return [];
}
var _hml_left = (((_hml__x + sprite_get_bbox_left(mskVan)) - sprite_get_xoffset(mskVan)) - 8);
;
var _hml_right = (((_hml__x + sprite_get_bbox_right(mskVan)) - sprite_get_xoffset(mskVan)) + 8);
;
var _hml_top = (((_hml__y + sprite_get_bbox_top(mskVan)) - sprite_get_yoffset(mskVan)) - 12);
;
var _hml_bottom = (((_hml__y + sprite_get_bbox_bottom(mskVan)) - sprite_get_yoffset(mskVan)) + 8);
;
var _hml_x1 = (_hml_origin.x + (floor(((_hml_left - _hml_origin.x) / 32)) * 32));
var _hml_y1 = (_hml_origin.y + (floor(((_hml_top - _hml_origin.y) / 32)) * 32));
;
var _hml_x2 = (_hml_origin.x + (floor(((_hml_right - _hml_origin.x) / 32)) * 32));
var _hml_y2 = (_hml_origin.y + (floor(((_hml_bottom - _hml_origin.y) / 32)) * 32));
;
if ((collision_rectangle(_hml_x1, _hml_y1, (_hml_x2 + 31), (_hml_y2 + 31), [Wall, InvisiWall, PizzaEntrance], false, true) != noone)) {
return [];
}
var _hml_tiles = [];
;
for (var _hml_yy = _hml_y1; (_hml_yy <= _hml_y2); _hml_yy += 32) for (var _hml_xx = _hml_x1; (_hml_xx <= _hml_x2); _hml_xx += 32) {
var _hml_found = 0;
;
{ var __hm_with4 = scrHMInstances(Floor), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if (((abs((x - _hml_xx)) < 0.1) && (abs((y - _hml_yy)) < 0.1))) {
{
if ((object_index == FloorExplo)) {
return [];
}
_hml_tiles[array_length(_hml_tiles)] = id;
;
_hml_found++;
;
}
}
}
if(__hm_break6) break;
}}
if ((_hml_found == 0)) {
return [];
}
}
return _hml_tiles;
;
}

// Source arkintide.mod.gml:0; hm_extra_water_prepare (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_water_prepare(_hml__x, _hml__y) {
if ((! hm_arkintide_mod_gml_hm_extra_water_entrance_clear(_hml__x, _hml__y))) {
return false;
}
if (hm_arkintide_mod_gml_hm_extra_water_fit(_hml__x, _hml__y)) {
return true;
}
var _hml_tiles = hm_arkintide_mod_gml_hm_extra_water_tiles(_hml__x, _hml__y);
;
if ((array_length(_hml_tiles) == 0)) {
return false;
}
var _hml_water_sprite = scrHMModGet("area", "sewers", "sewagefloor");
;
if ((! sprite_exists(_hml_water_sprite))) {
return false;
}
for (var _hml_i = 0; (_hml_i < array_length(_hml_tiles)); _hml_i++) { var __hm_with1 = scrHMInstances(_hml_tiles[_hml_i]), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var _hml_surface = noone;
;
if ((scrHMVariableExists(id, "hm_water_surface") && instance_exists(hm_water_surface))) {
_hml_surface = hm_water_surface;
}
var _hml_was_water = instance_exists(_hml_surface);
;
if ((! instance_exists(_hml_surface))) {
_hml_surface = instance_create(x, y, CustomObject);
}
{ var __hm_with4 = scrHMInstances(_hml_surface), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
sprite_index = _hml_water_sprite;
;
name = "sewagefloor";
;
image_index = 0;
;
image_xscale = 0.8;
;
image_yscale = 0.8;
;
image_speed = (0) * timescale;
;
image_alpha = 1;
;
if ((! _hml_was_water)) {
var __hm_other7=scrHMOther(other);
depth = (__hm_other7.depth + 1);
}
var __hm_other8=scrHMOther(other);
hm_arkintide_mod_gml_hm_water_link(__hm_other8);
;
}
}
if(__hm_break6) break;
}}
name = "sewagefloor";
;
styleb = 1;
;
sprite_index = mskNone;
;
traction = 2;
;
image_alpha = 0;
;
if ((! _hml_was_water)) {
depth += 10;
}
hm_rat_water_pool = 1;
;
}
}
if(__hm_break3) break;
}}
var _hml_shore_sprite = scrHMModGet("area", "sewers", "sewagefloortop");
;
for (var _hml_i = 0; (_hml_i < array_length(_hml_tiles)); _hml_i++) {
var _hml_tile = _hml_tiles[_hml_i];
var _hml_above = noone;
;
{ var __hm_with9 = scrHMInstances(Floor), __hm_break11=false;
for (var __hm_index10=0; __hm_index10<array_length(__hm_with9); ++__hm_index10) {
if(instance_exists(__hm_with9[__hm_index10])) with (__hm_with9[__hm_index10]) {
if (((((abs((x - _hml_tile.x)) < 0.1) && (abs((y - (_hml_tile.y - 32))) < 0.1)) && scrHMVariableExists(id, "hm_water_surface")) && instance_exists(hm_water_surface))) {
_hml_above = id;
}
}
if(__hm_break11) break;
}}
if ((! instance_exists(_hml_above))) {
{
var _hml_water_surface = _hml_tile.hm_water_surface;
;
_hml_water_surface.sprite_index = _hml_shore_sprite;
;
}
}
}
hm_arkintide_mod_gml_hm_water_invalidate();
;
if ((scrHMVariableExists(GameCont, "hm_native_controller_id") && instance_exists(GameCont.hm_native_controller_id))) {
{
var _hml_owner = GameCont.hm_native_controller_id;
;
_hml_owner.hm_water_count = (- 1);
;
}
}
hm_arkintide_mod_gml_hm_water_cache_build();
;
return hm_arkintide_mod_gml_hm_extra_water_fit(_hml__x, _hml__y);
;
}

// Source arkintide.mod.gml:0; hm_extra_fit (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_fit(_hml__kind, _hml__x, _hml__y) {
var _hml_mask = mskBanditBoss;
;
switch (_hml__kind) {
case "crystal":

case "cursedcrystal":
_hml_mask = mskHyperCrystal;
;
break;
;
case "mom":
_hml_mask = mskFrogQueen;
;
break;
;
case "dog":
_hml_mask = mskScrapBoss;
;
break;
;
case "rat":
_hml_mask = mskVan;
;
break;
;
case "tech":
_hml_mask = mskTechnoMancer;
;
break;
;
case "hunter":

case "turtle":

case "rogue":
_hml_mask = mskBandit;
;
break;
;
}
if ((! hm_arkintide_mod_gml_hm_throne_clear(_hml__x, _hml__y, _hml_mask))) {
return false;
}
if ((_hml__kind == "rat")) {
{
if ((! hm_arkintide_mod_gml_hm_extra_water_entrance_clear(_hml__x, _hml__y))) {
return false;
}
return (hm_arkintide_mod_gml_hm_extra_water_fit(_hml__x, _hml__y) || (array_length(hm_arkintide_mod_gml_hm_extra_water_tiles(_hml__x, _hml__y)) > 0));
;
}
}
return true;
;
}

// Source arkintide.mod.gml:0; hm_extra_rat_draw (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_rat_draw() {
scrHMDrawSpriteExt(sprite_index, image_index, x, (y - 4), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
;
}

// Source arkintide.mod.gml:0; hm_extra_rat_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_rat_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_arkintide_mod_gml_hm_extra_rat_step_resume, id, scrHMOther(other), _args, 21, []);
}
function hm_arkintide_mod_gml_hm_extra_rat_step_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_arkintide_mod_gml_hm_extra_rat_step");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 2: // arkintide.mod.gml:1836
_hm.vars.__hm_repeat1--; _hm.pc=1;
break;
case 3: // arkintide.mod.gml:1847
{
;
}
_hm.pc=2;
break;
case 4: // arkintide.mod.gml:1847
_hm.wait_ticks=max(0,4); _hm.pc=3; return;
break;
case 5: // arkintide.mod.gml:1839
{
repeat (_hm.vars.count) {
{ var __hm_with2 = scrHMInstances(instance_create(x, y, EnemyBullet1)), __hm_break4=false;
for (var __hm_index3=0; __hm_index3<array_length(__hm_with2); ++__hm_index3) {
if(instance_exists(__hm_with2[__hm_index3])) with (__hm_with2[__hm_index3]) {
{
sprite_index = sprFireBall;
;
direction = (_hm.vars.a + _hm.vars.b);
;
speed = (4.5) * timescale;
;
team = 1;
;
var __hm_other5=scrHMOther(other);
creator = __hm_other5;
;
var __hm_other6=scrHMOther(other);
hitid = __hm_other6.hitid;
;
image_angle = direction;
;
}
}
if(__hm_break4) break;
}}
_hm.vars.a += (360 / _hm.vars.count);
;
}
_hm.vars.b += ((12 * _hm.vars.turn) + ((_hm.vars.b / _hm.vars.count) * 2));
;
}
_hm.pc=4;
break;
case 6: // arkintide.mod.gml:1838
_hm.result=undefined; _hm.done=true; return;
break;
case 7: // arkintide.mod.gml:1838
_hm.pc = ((hp <= 0)) ? 6 : 5;
break;
case 8: // arkintide.mod.gml:1837
_hm.result=undefined; _hm.done=true; return;
break;
case 9: // arkintide.mod.gml:1837
_hm.pc = ((! instance_exists(_hm.scope))) ? 8 : 7;
break;
case 1: // arkintide.mod.gml:1836
_hm.pc=(_hm.vars.__hm_repeat1>0)?9:0;
break;
case 10: // arkintide.mod.gml:1836
_hm.vars.__hm_repeat1=round(24); _hm.pc=1;
break;
case 11: // arkintide.mod.gml:1834
{
alrm1 = 300;
;
_hm.vars.a = 0;
_hm.vars.b = 0;
_hm.vars.turn = choose((- 1), 1);
_hm.vars.count = choose(3, 4, 5, 6);
;
}
_hm.pc=10;
break;
case 12: // arkintide.mod.gml:1831
_hm.result=undefined; _hm.done=true; return;
break;
case 13: // arkintide.mod.gml:1831
_hm.pc = ((collision_line(x, y, _hm.vars.target.x, _hm.vars.target.y, Wall, false, true) != noone)) ? 12 : 11;
break;
case 14: // arkintide.mod.gml:1830
{
_hm.vars.target = instance_nearest(x, y, Player);
;
}
_hm.pc=13;
break;
case 15: // arkintide.mod.gml:1829
_hm.result=undefined; _hm.done=true; return;
break;
case 16: // arkintide.mod.gml:1829
_hm.pc = (((alrm1 > 0) || (! instance_exists(Player)))) ? 15 : 14;
break;
case 17: // arkintide.mod.gml:1826
{
team = 1;
;
sprite_index = spr_idle;
;
speed = (0) * timescale;
;
canmelee = 1;
;
if ((nexthurt > current_frame)) {
sprite_index = spr_hurt;
}
alrm1 -= 1;
;
}
_hm.pc=16;
break;
case 18: // arkintide.mod.gml:1823
{
;
}
_hm.pc=17;
break;
case 19: // arkintide.mod.gml:1823
_hm.result=undefined; _hm.done=true; return;
break;
case 20: // arkintide.mod.gml:1823
{
speed = (0) * timescale;
;
}
_hm.pc=19;
break;
case 21: // arkintide.mod.gml:1823
_hm.pc = ((! hm_arkintide_mod_gml_hm_extra_ready())) ? 20 : 17;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

// Source arkintide.mod.gml:0; hm_warning_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_warning_step() {
if (((((! hm_arkintide_mod_gml_hm_police_allowed()) || (GameCont.area != scrHMAreaResolve(hm_gate_area))) || (GameCont.subarea != hm_gate_sub)) || (GameCont.loops != hm_gate_loop))) {
{
scrHMDelete(id);
;
exit;
;
}
}
if (((hm_phase < 2) && (1 > 0))) {
hm_arkintide_mod_gml_hm_warning_particles(min(1, max(0, hm_wait)));
}
hm_wait -= 1;
;
repeat (3) {
if ((hm_wait > 0)) {
break;
}
if ((hm_phase == 0)) {
{
hm_phase = 1;
;
hm_wait += 45;
;
}
} else {
if ((hm_phase == 1)) {
{
hm_phase = 2;
;
hm_wait += max(1, (sprite_get_number(sprVanPortalClose) * 2.5));
;
}
} else {
{
hm_arkintide_mod_gml_hm_warning_emit();
;
scrHMDelete(id);
;
exit;
;
}
}
}
}
if (((hm_phase == 2) && (hm_wait <= (max(1, (sprite_get_number(sprVanPortalClose) * 2.5)) - 12)))) {
hm_arkintide_mod_gml_hm_warning_emit();
}
}

// Source arkintide.mod.gml:0; hm_warning_draw (native content 1.1.0)
function hm_arkintide_mod_gml_hm_warning_draw() {
var _hml_spr = sprVanPortalStart;
var _hml_frame = (sprite_get_number(_hml_spr) - (hm_wait / 2.5));
;
if ((hm_phase == 1)) {
{
_hml_spr = sprVanPortalStart;
;
_hml_frame = (floor(((45 - hm_wait) / 2.5)) mod max(1, sprite_get_number(_hml_spr)));
;
}
}
if ((hm_phase == 2)) {
{
_hml_spr = sprVanPortalClose;
;
_hml_frame = (sprite_get_number(_hml_spr) - (hm_wait / 2.5));
;
}
}
scrHMDrawSpriteExt(_hml_spr, clamp(floor(_hml_frame), 0, (sprite_get_number(_hml_spr) - 1)), x, y, 1, 1, hm_angle, c_white, 1);
;
if ((! hm_spawned)) {
hm_arkintide_mod_gml_hm_warning_icon(x, y, 1);
}
}

// Source arkintide.mod.gml:0; hm_portal_style_commit (native content 1.1.0)
function hm_arkintide_mod_gml_hm_portal_style_commit(_hml__portal) {
scrHMPortalStyle1100(_hml__portal);
}


// Source arkintide.mod.gml:0; hm_portal_style_tick (native content 1.1.0)
function hm_arkintide_mod_gml_hm_portal_style_tick() {
scrHMPortalTick1100();
}


// Source arkintide.mod.gml:0; hm_playerboost_enabled (native content 1.1.0)
function hm_arkintide_mod_gml_hm_playerboost_enabled() {
return ((! scrHMModExists("mod", "options", "playerboost")) || (scrHMModGet("mod", "options", "playerboost") == "1"));
;
}

// Source arkintide.mod.gml:0; hm_progression_start (native content 1.1.0)
function hm_arkintide_mod_gml_hm_progression_start() {
scrHMContentInit1100();
if ((scrHMVariableExists(GameCont, "hm_level_cap") && (GameCont.hm_maxlevel1100 == GameCont.hm_level_cap))) {
GameCont.hm_maxlevel1100 = GameCont.hm_level_base;
}
GameCont.hm_playerboost = hm_arkintide_mod_gml_hm_playerboost_enabled();
;
GameCont.hm_level_base = GameCont.hm_maxlevel1100;
;
GameCont.hm_level_cap = (GameCont.hm_level_base + GameCont.hm_playerboost);
;
GameCont.hm_maxlevel1100 = GameCont.hm_level_cap;
;
}

// Source arkintide.mod.gml:0; hm_effective_mask (native content 1.1.0)
function hm_arkintide_mod_gml_hm_effective_mask() {
if (sprite_exists(mask_index)) {
return mask_index;
}
if (sprite_exists(sprite_index)) {
return sprite_index;
}
if ((scrHMVariableExists(id, "spr_idle") && sprite_exists(spr_idle))) {
return spr_idle;
}
return (- 1);
;
}

// Source arkintide.mod.gml:0; hm_extra_change (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_change(_hml__object) {
var _hml_spr = sprite_index;
var _hml_mask = mask_index;
var _hml_frame = image_index;
var _hml_rate = (image_speed / timescale);
;
var _hml_sx = image_xscale;
var _hml_sy = image_yscale;
var _hml_angle = image_angle;
var _hml_alpha = image_alpha;
var _hml_blend = image_blend;
;
var _hml_shown = visible;
var _hml_layer = depth;
;
scrHMContentChange1100(_hml__object, false);
;
sprite_index = _hml_spr;
;
mask_index = _hml_mask;
;
image_index = _hml_frame;
;
image_speed = (_hml_rate) * timescale;
;
image_xscale = _hml_sx;
;
image_yscale = _hml_sy;
;
image_angle = _hml_angle;
;
image_alpha = _hml_alpha;
;
image_blend = _hml_blend;
;
visible = _hml_shown;
;
depth = _hml_layer;
;
}

// Source arkintide.mod.gml:0; hm_extra_combat (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_combat(_hml__kind, _hml__x, _hml__y) {
x = _hml__x;
;
y = _hml__y;
;
xstart = x;
;
ystart = y;
;
xprevious = x;
;
yprevious = y;
;
speed = (0) * timescale;
;
hspeed = (0) * timescale;
;
vspeed = (0) * timescale;
;
visible = true;
;
image_alpha = 1;
;
image_index = 0;
;
image_speed = (0.4) * timescale;
;
intro = 1;
;
newintro = (- 1);
;
team = 1;
;
corpse = 1;
;
if (sprite_exists(spr_idle)) {
sprite_index = spr_idle;
}
if (((_hml__kind == "bandit") || (_hml__kind == "junglebandit"))) {
{
spr_idle = sprBanditBossIdle;
;
spr_walk = sprBanditBossWalk;
;
spr_fire = sprBanditBossFire;
;
spr_hurt = sprBanditBossHurt;
;
mask_index = mskBanditBoss;
;
sprite_index = spr_idle;
;
charge = 0;
;
ammo = 0;
;
walk = 0;
;
alarm[1] = 30;
;
alarm[2] = (- 1);
;
alarm[3] = (- 1);
;
alarm[4] = (- 1);
;
alarm[5] = (- 1);
;
alarm[6] = (- 1);
;
}
}
if ((_hml__kind == "bubble")) {
mask_index = mskBanditBoss;
}
if ((_hml__kind == "mom")) {
mask_index = mskFrogQueen;
}
if ((_hml__kind == "dog")) {
mask_index = mskScrapBoss;
}
if (((_hml__kind == "crystal") || (_hml__kind == "cursedcrystal"))) {
mask_index = mskHyperCrystal;
hm_extra_cursed1116 = _hml__kind == "cursedcrystal";
// Keep the native pre-loop combat state; extra crystals do not receive
// the global HyperCrystal scans once converted to CustomEnemy.
cnumber = 3;
crystalset = 1;
newcnumber = cnumber;
alarm[1] = 30;
hm_extra_teleport_at1115 = current_frame + 45;
}
if ((_hml__kind == "hunter")) {
{
z = 0;
;
canfly = false;
;
mask_index = mskBandit;
;
alarm[1] = 30;
;
}
}
if ((_hml__kind == "tech")) {
{
main = 1;
;
mask_index = mskTechnoMancer;
;
drawspr = sprTechnoMancerInactive;
;
drawimg = 0;
;
alarm[1] = 30;
;
}
}
if ((_hml__kind == "bird")) {
{
z = 0;
;
zspd = 0;
;
flying = false;
;
canfly = false;
;
wantfly = 0;
;
mask_index = mskBanditBoss;
;
sprite_index = spr_idle;
;
alrm0 = 1;
;
alrm1 = 45;
;
}
}
if (((_hml__kind == "turtle") || (_hml__kind == "rogue"))) {
mask_index = mskBandit;
}
}

// Source arkintide.mod.gml:0; hm_extra_limit (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_limit(_hml__loops) {
return (4 + floor((max(0, (_hml__loops - 3)) / 2)));
;
}

// Source arkintide.mod.gml:0; hm_bounds_tick (native content 1.1.0)
function hm_arkintide_mod_gml_hm_bounds_tick() {
if ((instance_exists(GenCont) || (! instance_exists(Player)))) {
exit;
}
{ var __hm_with1 = scrHMInstances(enemy), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if ((!scrHMVariableExists(id, "hm_bounds_due"))) {
{
hm_bounds_due = (current_frame + scrHMStagger1100());
;
hm_bounds_checked = current_frame;
;
}
}
if ((current_frame < hm_bounds_due)) {
continue;
}
var _hml_elapsed = max(0, (current_frame - hm_bounds_checked));
;
hm_bounds_checked = current_frame;
;
hm_bounds_due = (current_frame + 6);
;
hm_arkintide_mod_gml_hm_ground_bounds_elapsed(_hml_elapsed);
;
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_radiation_index (native content 1.1.0)
function hm_arkintide_mod_gml_hm_radiation_index() {
if(scrHMRadiationFlat1103()) return;
if ((! instance_exists(Rad))) {
exit;
}
if ((!scrHMVariableExists(GameCont, "hm_native_controller_id"))) {
exit;
}
var _hml_owner = GameCont.hm_native_controller_id;
;
if ((! instance_exists(_hml_owner))) {
exit;
}
if ((!scrHMVariableExists(_hml_owner, "hm_rad_grid"))) {
_hml_owner.hm_rad_grid = undefined;
}
if ((_hml_owner.hm_rad_grid == undefined)) {
_hml_owner.hm_rad_grid = ds_map_create();
} else {
ds_map_clear(_hml_owner.hm_rad_grid);
}
;
var _hml_grid = _hml_owner.hm_rad_grid;
var _hml_order = 0;
;
{ var __hm_with1 = scrHMInstances(Rad), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
hm_rad_order = _hml_order;
;
_hml_order++;
;
var _hml_key = ((string(floor((x / 64))) + ":") + string(floor((y / 64))));
var _hml_items = [];
;
if (ds_map_exists(_hml_grid, _hml_key)) {
_hml_items = ds_map_find_value(_hml_grid, _hml_key);
}
array_push(_hml_items, id);
;
ds_map_replace(_hml_grid, _hml_key, _hml_items);
;
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(enemy), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if ((team != 3)) {
{
var _hml_source = id;
var _hml_candidates = [];
;
for (var _hml_cy = floor(((y - 32) / 64)); (_hml_cy <= floor(((y + 32) / 64))); _hml_cy++) for (var _hml_cx = floor(((x - 32) / 64)); (_hml_cx <= floor(((x + 32) / 64))); _hml_cx++) {
var _hml_key = ((string(_hml_cx) + ":") + string(_hml_cy));
;
if ((! ds_map_exists(_hml_grid, _hml_key))) {
continue;
}
var _hml_items = ds_map_find_value(_hml_grid, _hml_key);
;
for (var _hml_i = 0; (_hml_i < array_length(_hml_items)); _hml_i++) {
var _hml_rad = _hml_items[_hml_i];
;
if ((! instance_exists(_hml_rad))) {
continue;
}
var _hml_dx = (x - _hml_rad.x);
var _hml_dy = (y - _hml_rad.y);
;
if ((((_hml_dx * _hml_dx) + (_hml_dy * _hml_dy)) > 1024)) {
continue;
}
array_push(_hml_candidates, _hml_rad);
;
}
}
for (var _hml_i = 1; (_hml_i < array_length(_hml_candidates)); _hml_i++) {
var _hml_value = _hml_candidates[_hml_i];
var _hml_j = (_hml_i - 1);
;
while ((_hml_j >= 0)) {
if ((_hml_candidates[_hml_j].hm_rad_order <= _hml_value.hm_rad_order)) {
break;
}
_hml_candidates[(_hml_j + 1)] = _hml_candidates[_hml_j];
;
_hml_j--;
;
}
_hml_candidates[(_hml_j + 1)] = _hml_value;
;
}
for (var _hml_i = 0; (_hml_i < array_length(_hml_candidates)); _hml_i++) {
var _hml_rad = _hml_candidates[_hml_i];
;
if ((! instance_exists(_hml_rad))) {
continue;
}
{ var __hm_with7 = scrHMInstances(_hml_rad), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
if (((distance_to_object(_hml_source) < 32) && (distance_to_object(Player) > 32))) {
{
scrHMMotionAdd(point_direction(x, y, _hml_source.x, _hml_source.y), 0.5);
;
if (place_meeting(x, y, _hml_source)) {
{
instance_create(x, y, RadEat);
;
_hml_source.raddrop += 1;
;
instance_destroy();
;
}
}
}
}
}
if(__hm_break9) break;
}}
}
}
}
}
if(__hm_break6) break;
}}
}

// Source arkintide.mod.gml:0; hm_infantry_capture (native content 1.1.0)
function hm_arkintide_mod_gml_hm_infantry_capture() {
if(scrHMThroneArrivalWaiting1103()) return;
if ((GameCont.loops < 3)) {
exit;
}
{ var __hm_with1 = scrHMInstances(IDPDSpawn), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if(object_index!=IDPDSpawn) continue;
var _hml_sprite = sprite_index;
var _hml_frame = image_index;
var _hml_angle = image_angle;
var _hml_phase = 0;
var _hml_delay = max(1, alarm[0]);
;
if ((_hml_sprite == sprIDPDPortalStart)) {
{
_hml_phase = 1;
;
_hml_delay = max(1, ((sprite_get_number(_hml_sprite) - _hml_frame) / max(0.01, (image_speed / timescale))));
;
}
}
if ((_hml_sprite == sprIDPDPortalClose)) {
{
if ((alarm[1] >= 0)) {
{
_hml_phase = 1;
;
_hml_delay = max(1, alarm[1]);
;
}
} else {
{
_hml_phase = 2;
;
_hml_delay = max(1, ((sprite_get_number(_hml_sprite) - _hml_frame) / max(0.01, (image_speed / timescale))));
;
}
}
}
}
scrHMContentChange1100(CustomObject, false);
;
name = "hm_infantry_gate";
;
hm_phase = _hml_phase;
;
hm_wait = _hml_delay;
;
hm_spawned = 0;
;
hm_gate_area = GameCont.area;
;
hm_gate_sub = GameCont.subarea;
;
hm_gate_loop = GameCont.loops;
;
hm_angle = _hml_angle;
;
sprite_visible = false;
;
image_speed = (0) * timescale;
;
depth = (- 7);
;
alarm[0] = (- 1);
;
alarm[1] = (- 1);
;
on_destroy = undefined;
;
on_begin_step = undefined;
;
on_end_step = undefined;
;
on_cleanup = undefined;
;
on_step = scrHMContentRef1100("mod", "arkintide", "hm_infantry_step");
;
on_draw = scrHMContentRef1100("mod", "arkintide", "hm_infantry_draw");
;
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_infantry_kind (native content 1.1.0)
function hm_arkintide_mod_gml_hm_infantry_kind() {
return scrHMPoliceKind1116();
;
}

// Source arkintide.mod.gml:0; hm_infantry_amount (native content 1.1.0)
function hm_arkintide_mod_gml_hm_infantry_amount(_hml__kind, _hml__loops) {
if ((_hml__kind == Grunt)) {
return min(5, max(1, (2 + _hml__loops)));
}
return 1;
;
}

// Source arkintide.mod.gml:0; hm_infantry_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_infantry_step() {
if ((! hm_arkintide_mod_gml_hm_police_allowed())) {
{
scrHMDelete(id);
;
exit;
;
}
}
if ((((GameCont.area != scrHMAreaResolve(hm_gate_area)) || (GameCont.subarea != hm_gate_sub)) || (GameCont.loops != hm_gate_loop))) {
{
scrHMDelete(id);
;
exit;
;
}
}
hm_wait -= 1;
;
repeat (4) {
if ((hm_wait > 0)) {
exit;
}
if ((hm_phase == 0)) {
{
hm_phase = 1;
;
hm_wait += max(1, (sprite_get_number(sprIDPDPortalStart) * 2.5));
;
}
} else {
if ((hm_phase == 1)) {
{
if ((! hm_spawned)) {
{
hm_spawned = 1;
;
var _hml_kind = hm_arkintide_mod_gml_hm_infantry_kind();
var _hml_amount = hm_arkintide_mod_gml_hm_infantry_amount(_hml_kind, GameCont.loops);
;
repeat (_hml_amount) { var __hm_with1 = scrHMInstances(instance_create((x + random_range((- 2), 2)), (y + random_range((- 2), 2)), _hml_kind)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if ((object_index == Grunt)) {
more = 1;
}
scrHMMotionAdd(random(360), 2);
;
}
}
if(__hm_break3) break;
}}
scrHMSoundPlay(sndFreakPopoEnter);
;
}
}
hm_phase = 2;
;
hm_wait += max(1, (sprite_get_number(sprIDPDPortalClose) * 2.5));
;
}
} else {
{
scrHMDelete(id);
;
exit;
;
}
}
}
}
}

// Source arkintide.mod.gml:0; hm_infantry_draw (native content 1.1.0)
function hm_arkintide_mod_gml_hm_infantry_draw() {
var _hml_sprite = sprIDPDPortalCharge;
var _hml_frame = ((45 - hm_wait) / 2.5);
;
if ((hm_phase == 1)) {
{
_hml_sprite = sprIDPDPortalStart;
;
_hml_frame = (sprite_get_number(_hml_sprite) - (hm_wait / 2.5));
;
}
}
if ((hm_phase == 2)) {
{
_hml_sprite = sprIDPDPortalClose;
;
_hml_frame = (sprite_get_number(_hml_sprite) - (hm_wait / 2.5));
;
}
}
scrHMDrawSpriteExt(_hml_sprite, clamp(floor(_hml_frame), 0, (sprite_get_number(_hml_sprite) - 1)), x, y, 1, 1, hm_angle, c_white, 1);
;
}

// Source arkintide.mod.gml:0; hm_debug_target (native content 1.1.0)
function hm_arkintide_mod_gml_hm_debug_target(_hml__area, _hml__sub) {
switch (_hml__area) {
case 1:
if (((_hml__sub >= 1) && (_hml__sub <= 3))) {
return [1, _hml__sub];
}
if ((_hml__sub == 4)) {
return ["nightdesert", 4];
}
if ((_hml__sub == 5)) {
return ["scorpionboss", 5];
}
break;
;
case 2:
if (((_hml__sub >= 1) && (_hml__sub <= 3))) {
return ["sewers", _hml__sub];
}
break;
;
case 3:
if (((_hml__sub == 1) || (_hml__sub == 2))) {
return [3, _hml__sub];
}
if ((_hml__sub == 3)) {
return ["ravenboss", 3];
}
if (((_hml__sub == 4) || (_hml__sub == 5))) {
return ["junkyard", _hml__sub];
}
break;
;
case 4:
if (((_hml__sub >= 1) && (_hml__sub <= 3))) {
return ["caves", _hml__sub];
}
break;
;
case 5:
if (((_hml__sub >= 1) && (_hml__sub <= 5))) {
return ["city", _hml__sub];
}
break;
;
case 6:
if (((_hml__sub == 1) || (_hml__sub == 2))) {
return ["labs", _hml__sub];
}
if ((_hml__sub == 3)) {
return ["elevator", 3];
}
break;
;
case 7:
if (((_hml__sub >= 1) && (_hml__sub <= 4))) {
return ["palace", _hml__sub];
}
if ((_hml__sub == 5)) {
return ["throne", 1];
}
break;
;
case 100:
if ((_hml__sub == 1)) {
return [100, 1];
}
break;
;
case 101:
return hm_arkintide_mod_gml_hm_debug_target("oasis", _hml__sub);
;
case 102:
if ((_hml__sub == 1)) {
return ["turtles", 1];
}
break;
;
case 103:
return hm_arkintide_mod_gml_hm_debug_target("venuz", _hml__sub);
;
case 104:
return hm_arkintide_mod_gml_hm_debug_target("cavesinv", _hml__sub);
;
case 105:
if ((_hml__sub == 1)) {
return ["jungle", 1];
}
break;
;
case 106:
return hm_arkintide_mod_gml_hm_debug_target("hq", _hml__sub);
;
case 107:
if ((_hml__sub == 1)) {
return ["mansion", 1];
}
break;
;
case "desert":
return hm_arkintide_mod_gml_hm_debug_target(1, _hml__sub);
;
case "sewer":

case "sewers":
return hm_arkintide_mod_gml_hm_debug_target(2, _hml__sub);
;
case "parking":

case "junkyard":
return hm_arkintide_mod_gml_hm_debug_target(3, _hml__sub);
;
case "caves":
return hm_arkintide_mod_gml_hm_debug_target(4, _hml__sub);
;
case "city":
return hm_arkintide_mod_gml_hm_debug_target(5, _hml__sub);
;
case "labs":
return hm_arkintide_mod_gml_hm_debug_target(6, _hml__sub);
;
case "palace":
return hm_arkintide_mod_gml_hm_debug_target(7, _hml__sub);
;
case "throne":
return ["throne", 1];
;
case "hq":
if (((_hml__sub >= 1) && (_hml__sub <= 3))) {
return ["HQ", _hml__sub];
}
break;
;
case "venus":

case "venuz":
if (((_hml__sub >= 1) && (_hml__sub <= 12))) {
return ["venuz", _hml__sub];
}
break;
;
case "oasis":
if (((_hml__sub >= 1) && (_hml__sub <= 3))) {
return ["oasis", _hml__sub];
}
break;
;
case "cursed":

case "cavesinv":
if (((_hml__sub >= 1) && (_hml__sub <= 3))) {
return ["cavesinv", _hml__sub];
}
break;
;
case "nightdesert":
return ["nightdesert", 4];
;
case "scorpionboss":
return ["scorpionboss", 5];
;
case "ravenboss":
return ["ravenboss", 3];
;
case "elevator":
return ["elevator", 3];
;
case "turtles":

case "pizza":
return ["turtles", 1];
;
case "jungle":
return ["jungle", 1];
;
case "icecave":

case "ice":
return ["icecave", 1];
;
case "mansion":
return ["mansion", 1];
;
case "end":
return ["end", 1];
;
case "bigdog":
return ["bigdog", 1];
;
case "banditcamp":
return ["banditcamp", 1];
;
case "noyetihere":
return ["noyetihere", 1];
;
}
return [];
;
}

// Source arkintide.mod.gml:0; hm_debug_goto (native content 1.1.0)
function hm_arkintide_mod_gml_hm_debug_goto(_hml__area, _hml__sub, _hml__loop, _hml__player) {
if (((floor(_hml__sub) != _hml__sub) || (floor(_hml__loop) != _hml__loop))) {
return false;
}
var _hml_target = hm_arkintide_mod_gml_hm_debug_target(_hml__area, _hml__sub);
;
if (((array_length(_hml_target) != 2) || (_hml__loop < 0))) {
return false;
}
if ((((! instance_exists(Player)) || instance_exists(GenCont)) || instance_exists(SpiralCont))) {
return false;
}
GameCont.hm_debug_area = _hml_target[0];
;
GameCont.hm_debug_sub = _hml_target[1];
;
GameCont.hm_debug_floor = instance_find(Floor, 0);
;
GameCont.hm_debug_pending = 1;
;
scrHMCrownReset1103();GameCont.hm_destination107=-1;GameCont.hm_destination_sub107=-1;
GameCont.hm_crown_return = 0;
;
GameCont.hm_crown_vault_seen = 0;
;
GameCont.hm_crown_exit_ready = 0;
;
GameCont.hm_palace_crown_floor = noone;
;
GameCont.hm_destination = "";
;
GameCont.hard += ((_hml__loop - GameCont.loops) * 16);
;
GameCont.loops = _hml__loop;
;
{ var __hm_with1 = scrHMInstances(Portal), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMDelete(id);
}
if(__hm_break3) break;
}}
;
{ var __hm_with4 = scrHMInstances(Player), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if ((index == _hml__player)) {
{ var __hm_with7 = scrHMInstances(instance_create(x, y, Portal)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
type = 1;
;
if ((_hml_target[0] == "HQ")) {
type = 2;
}
}
}
if(__hm_break9) break;
}}
}
}
if(__hm_break6) break;
}}
{ var __hm_with10 = scrHMInstances(enemy), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
hp = 0;
;
if ((distance_to_object(Player) > 200)) {
raddrop = 0;
}
}
}
if(__hm_break12) break;
}}
{ var __hm_with13 = scrHMInstances(NothingInactive), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
instance_destroy();
}
if(__hm_break15) break;
}}
;
return true;
;
}

// Source arkintide.mod.gml:0; hm_debug_watch (native content 1.1.0)
function hm_arkintide_mod_gml_hm_debug_watch() {
if (((!scrHMVariableExists(GameCont, "hm_debug_pending")) || (! GameCont.hm_debug_pending))) {
exit;
}
if (((((! instance_exists(GameCont.hm_debug_floor)) && (! instance_exists(GenCont))) && (GameCont.area == scrHMAreaResolve(GameCont.hm_debug_area))) && (GameCont.subarea == GameCont.hm_debug_sub))) {
{
GameCont.hm_debug_pending = 0;
;
GameCont.hm_destination = "";
;
}
}
}

// Source arkintide.mod.gml:0; hm_ground_bounds_elapsed (native content 1.1.0)
function hm_arkintide_mod_gml_hm_ground_bounds_elapsed(_hml__elapsed) {
if ((hp <= 0)) {
exit;
}
var _hml_eligible = (((((((((((((object_index == Bandit) || (object_index == Scorpion)) || (object_index == Maggot)) || (object_index == BigMaggot)) || (object_index == Gator)) || (object_index == BuffGator)) || (object_index == Rat)) || (object_index == Wolf)) || (object_index == SnowBot)) || (object_index == SnowTank)) || (object_index == Grunt)) || (object_index == Inspector)) || (object_index == Shielder));
;
if ((object_index == CustomEnemy)) {
{
_hml_eligible = 0;
;
if (is_array(on_step)) {
{
if ((array_length(on_step) == 3)) {
{
var _hml_ref = GameCont.hm_elitebandit_step_ref;
;
_hml_eligible = (((on_step[0] == _hml_ref[0]) && (on_step[1] == _hml_ref[1])) && (on_step[2] == _hml_ref[2]));
;
}
}
}
}
}
}
if ((! _hml_eligible)) {
exit;
}
if ((!scrHMVariableExists(id, "hm_outside_time"))) {
hm_outside_time = 0;
}
if ((place_meeting(x, y, Floor) && (! place_meeting(x, y, Wall)))) {
{
hm_outside_time = 0;
;
exit;
;
}
}
hm_outside_time += _hml__elapsed;
;
if ((hm_outside_time < 30)) {
exit;
}
var _hml_who = id;
var _hml_found = noone;
var _hml_best = 1000000000000000000;
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var _hml_xx = (x + 16);
var _hml_yy = (y + 16);
var _hml_dx = (_hml_xx - _hml_who.x);
var _hml_dy = (_hml_yy - _hml_who.y);
var _hml_d = ((_hml_dx * _hml_dx) + (_hml_dy * _hml_dy));
;
if ((_hml_d >= _hml_best)) {
continue;
}
{ var __hm_with4 = scrHMInstances(_hml_who), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if ((! place_meeting(_hml_xx, _hml_yy, Wall))) {
{
var __hm_other7=scrHMOther(other);
_hml_found = __hm_other7;
;
_hml_best = _hml_d;
;
}
}
}
if(__hm_break6) break;
}}
}
}
if(__hm_break3) break;
}}
if (instance_exists(_hml_found)) {
{
x = (_hml_found.x + 16);
;
y = (_hml_found.y + 16);
;
xprevious = x;
;
yprevious = y;
;
speed = (0) * timescale;
;
}
}
hm_outside_time = 0;
;
}

// Source arkintide.mod.gml:0; hm_extra_ready (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_ready() {
if ((!scrHMVariableExists(id, "hm_extra_attack_at"))) {
return true;
}
return (current_frame >= hm_extra_attack_at);
;
}

// Source arkintide.mod.gml:0; hm_extra_far_from_players (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_far_from_players(_hml__x, _hml__y) {
var _hml_clear = true;
;
{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((point_distance(x, y, _hml__x, _hml__y) < 160)) {
_hml_clear = false;
}
}
if(__hm_break3) break;
}}
return _hml_clear;
;
}

// Source arkintide.mod.gml:0; hm_stage_bandit_tick (native content 1.1.0)
function hm_arkintide_mod_gml_hm_stage_bandit_tick() {
if ((((GameCont.area != scrHMAreaResolve(1)) || (GameCont.subarea != 3)) || (GameCont.loops < 1))) {
exit;
}
{ var __hm_with1 = scrHMInstances(BanditBoss), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if ((!scrHMVariableExists(id, "hm_stage_bandit_rolled"))) {
{
hm_stage_bandit_rolled = 1;
;
hm_stage_jungle = (random(1) < 0.5);
;
if (hm_stage_jungle) {
{
hm_extra_kind = "junglebandit";
;
hitid = [global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_idle, "BIG BANDIT"];
;
var _hml_drawer = instance_create(x, y, CustomObject);
;
{ var __hm_with4 = scrHMInstances(_hml_drawer), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
var __hm_other7=scrHMOther(other);
creator = __hm_other7;
;
name = "hm_stage_bandit_drawer";
;
sprite_visible = false;
;
depth = creator.depth;
;
on_step = scrHMContentRef1100("mod", "arkintide", "hm_stage_bandit_drawer_step");
;
on_draw = scrHMContentRef1100("mod", "arkintide", "hm_stage_bandit_draw");
;
}
}
if(__hm_break6) break;
}}
}
}
}
}
if (hm_stage_jungle) {
image_alpha = 0;
}
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_stage_bandit_drawer_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_stage_bandit_drawer_step() {
if ((((! instance_exists(creator)) || (creator.hp <= 0)) || (creator.object_index != BanditBoss))) {
{
scrHMDelete(id);
;
exit;
;
}
}
depth = creator.depth;
;
}

// Source arkintide.mod.gml:0; hm_stage_bandit_draw (native content 1.1.0)
function hm_arkintide_mod_gml_hm_stage_bandit_draw() {
if (((! instance_exists(creator)) || (creator.hp <= 0))) {
exit;
}
{ var __hm_with1 = scrHMInstances(creator), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var _hml_sprite = sprite_index;
var _hml_alpha = image_alpha;
;
sprite_index = hm_arkintide_mod_gml_hm_extra_skin(_hml_sprite);
;
image_alpha = 1;
;
scrHMDrawSpriteExt(spr_shadow, 0, (x + spr_shadow_x), (y + spr_shadow_y), 1, 1, 0, c_white, 1);
;
scrHMContentEvent1100(BanditBoss, ev_draw, 0);
;
sprite_index = _hml_sprite;
;
image_alpha = _hml_alpha;
;
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_police_allowed (native content 1.1.0)
function hm_arkintide_mod_gml_hm_police_allowed() {
return ((GameCont.area != scrHMAreaResolve("end")) && (GameCont.area != scrHMAreaResolve(0)));
;
}

// Source arkintide.mod.gml:0; hm_camp_police_clear (native content 1.1.0)
function hm_arkintide_mod_gml_hm_camp_police_clear() {
if (hm_arkintide_mod_gml_hm_police_allowed()) {
exit;
}
GameCont.novans = 1;
;
{ var __hm_with1 = scrHMInstances(WantVan), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMDelete(id);
}
if(__hm_break3) break;
}}
;
{ var __hm_with4 = scrHMInstances(WantPopo), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
scrHMDelete(id);
}
if(__hm_break6) break;
}}
;
{ var __hm_with7 = scrHMInstances(IDPDSpawn), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
scrHMDelete(id);
}
if(__hm_break9) break;
}}
;
{ var __hm_with10 = scrHMInstances(VanSpawn), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
scrHMDelete(id);
}
if(__hm_break12) break;
}}
;
{ var __hm_with13 = scrHMInstances(Van), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
scrHMDelete(id);
}
if(__hm_break15) break;
}}
;
{ var __hm_with16 = scrHMInstances(Grunt), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
scrHMDelete(id);
}
if(__hm_break18) break;
}}
;
{ var __hm_with19 = scrHMInstances(Inspector), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
scrHMDelete(id);
}
if(__hm_break21) break;
}}
;
{ var __hm_with22 = scrHMInstances(Shielder), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
scrHMDelete(id);
}
if(__hm_break24) break;
}}
;
{ var __hm_with25 = scrHMInstances(EliteGrunt), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
scrHMDelete(id);
}
if(__hm_break27) break;
}}
;
{ var __hm_with28 = scrHMInstances(EliteInspector), __hm_break30=false;
for (var __hm_index29=0; __hm_index29<array_length(__hm_with28); ++__hm_index29) {
if(instance_exists(__hm_with28[__hm_index29])) with (__hm_with28[__hm_index29]) {
scrHMDelete(id);
}
if(__hm_break30) break;
}}
;
{ var __hm_with31 = scrHMInstances(EliteShielder), __hm_break33=false;
for (var __hm_index32=0; __hm_index32<array_length(__hm_with31); ++__hm_index32) {
if(instance_exists(__hm_with31[__hm_index32])) with (__hm_with31[__hm_index32]) {
scrHMDelete(id);
}
if(__hm_break33) break;
}}
;
{ var __hm_with34 = scrHMInstances(PopoFreak), __hm_break36=false;
for (var __hm_index35=0; __hm_index35<array_length(__hm_with34); ++__hm_index35) {
if(instance_exists(__hm_with34[__hm_index35])) with (__hm_with34[__hm_index35]) {
scrHMDelete(id);
}
if(__hm_break36) break;
}}
;
{ var __hm_with37 = scrHMInstances(RevivePopoFreak), __hm_break39=false;
for (var __hm_index38=0; __hm_index38<array_length(__hm_with37); ++__hm_index38) {
if(instance_exists(__hm_with37[__hm_index38])) with (__hm_with37[__hm_index38]) {
scrHMDelete(id);
}
if(__hm_break39) break;
}}
;
{ var __hm_with40 = scrHMInstances(WantRevivePopoFreak), __hm_break42=false;
for (var __hm_index41=0; __hm_index41<array_length(__hm_with40); ++__hm_index41) {
if(instance_exists(__hm_with40[__hm_index41])) with (__hm_with40[__hm_index41]) {
scrHMDelete(id);
}
if(__hm_break42) break;
}}
;
{ var __hm_with43 = scrHMInstances(PopoShield), __hm_break45=false;
for (var __hm_index44=0; __hm_index44<array_length(__hm_with43); ++__hm_index44) {
if(instance_exists(__hm_with43[__hm_index44])) with (__hm_with43[__hm_index44]) {
scrHMDelete(id);
}
if(__hm_break45) break;
}}
;
{ var __hm_with46 = scrHMInstances(CustomObject), __hm_break48=false;
for (var __hm_index47=0; __hm_index47<array_length(__hm_with46); ++__hm_index47) {
if(instance_exists(__hm_with46[__hm_index47])) with (__hm_with46[__hm_index47]) {
if (scrHMVariableExists(id, "name")) {
{
if ((name == "3dvan")) {
{
if (instance_exists(baby)) {
scrHMDelete(baby);
}
scrHMDelete(id);
;
}
} else {
if ((((name == "makeavan") || (name == "hm_robot_gate")) || (name == "hm_infantry_gate"))) {
scrHMDelete(id);
}
}
}
}
}
if(__hm_break48) break;
}}
{ var __hm_with49 = scrHMMatching(CustomEnemy, "name", "IDPDTank"), __hm_break51=false;
for (var __hm_index50=0; __hm_index50<array_length(__hm_with49); ++__hm_index50) {
if(instance_exists(__hm_with49[__hm_index50])) with (__hm_with49[__hm_index50]) {
scrHMDelete(id);
}
if(__hm_break51) break;
}}
;
}

// Source arkintide.mod.gml:0; hm_idpd_portal_sprite (native content 1.1.0)
function hm_arkintide_mod_gml_hm_idpd_portal_sprite() {
scrHMIDPDPortalSprite1102();
}

// Source arkintide.mod.gml:0; hm_throne_generator_zone (native content 1.1.0)
function hm_arkintide_mod_gml_hm_throne_generator_zone(_hml__x, _hml__y) {
return scrHMThroneGeneratorZone1100();
}


// Source arkintide.mod.gml:0; hm_missile_audio (native content 1.1.0)
function hm_arkintide_mod_gml_hm_missile_audio() {
GameCont.hm_missile_audio_frame = current_frame;
;
if (((! scrHMVariableExists(GameCont, "hm_missile_loop")) || (! GameCont.hm_missile_loop))) {
{
GameCont.hm_missile_loop = 1;
;
scrHMSoundLoop(sndEliteGruntRocketFly);
;
}
}
}

// Source arkintide.mod.gml:0; hm_audio_tick (native content 1.1.0)
function hm_arkintide_mod_gml_hm_audio_tick() {
if (((! scrHMVariableExists(GameCont, "hm_missile_loop")) || (! GameCont.hm_missile_loop))) {
exit;
}
if ((((! instance_exists(Player)) || instance_exists(GenCont)) || ((current_frame - GameCont.hm_missile_audio_frame) > 2))) {
{
scrHMSoundStop(sndEliteGruntRocketFly);
;
GameCont.hm_missile_loop = 0;
;
}
}
}

// Source arkintide.mod.gml:0; hm_water_invalidate (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_invalidate() {
if ((!scrHMVariableExists(GameCont, "hm_water_epoch"))) {
GameCont.hm_water_epoch = 0;
}
GameCont.hm_water_epoch++;
;
}

// Source arkintide.mod.gml:0; hm_water_rect (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_rect() {
if ((((((scrHMVariableExists(id, "hm_water_rect_sprite") && (hm_water_rect_sprite == sprite_index)) && (hm_water_rect_x == x)) && (hm_water_rect_y == y)) && (hm_water_rect_sx == image_xscale)) && (hm_water_rect_sy == image_yscale))) {
exit;
}
hm_water_rect_sprite = sprite_index;
;
hm_water_rect_x = x;
;
hm_water_rect_y = y;
;
hm_water_rect_sx = image_xscale;
;
hm_water_rect_sy = image_yscale;
;
hm_water_left = (x - (sprite_get_xoffset(sprite_index) * image_xscale));
;
hm_water_top = (y - (sprite_get_yoffset(sprite_index) * image_yscale));
;
hm_water_right = (hm_water_left + (sprite_get_width(sprite_index) * abs(image_xscale)));
;
hm_water_bottom = (hm_water_top + (sprite_get_height(sprite_index) * abs(image_yscale)));
;
if ((sprite_index == scrHMModGet("area", "sewers", "sewagefloortop"))) {
hm_water_top += (8 * abs(image_yscale));
}
}

// Source arkintide.mod.gml:0; hm_water_drawer_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_drawer_step() {
if (((((((! instance_exists(creator)) || (! scrHMVariableExists(creator, "swimming"))) || (! creator.swimming)) || (GameCont.area != scrHMAreaResolve(hm_water_area))) || (GameCont.subarea != hm_water_sub)) || (GameCont.loops != hm_water_loop))) {
{
scrHMDelete(id);
;
exit;
;
}
}
depth = (2 - (creator.y / 10000));
;
}

// Source arkintide.mod.gml:0; hm_ice_spider_create (native content 1.1.0)
function hm_arkintide_mod_gml_hm_ice_spider_create(_hml__x, _hml__y) {
var _hml_actor = instance_create(_hml__x, _hml__y, Spider);
;
{ var __hm_with1 = scrHMInstances(_hml_actor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
spr_idle = global.hm_module_vars[$ "mod:arkintide"].hm_ice_spider_idle;
;
spr_walk = global.hm_module_vars[$ "mod:arkintide"].hm_ice_spider_walk;
;
spr_hurt = global.hm_module_vars[$ "mod:arkintide"].hm_ice_spider_hurt;
;
spr_dead = global.hm_module_vars[$ "mod:arkintide"].hm_ice_spider_dead;
;
sprite_index = spr_idle;
;
hitid = [spr_idle, "Crystal Spider"];
;
raddrop += 50;
;
hm_ice_spider = 1;
;
}
}
if(__hm_break3) break;
}}
return _hml_actor;
;
}

// Source arkintide.mod.gml:0; hm_warning_particles (native content 1.1.0)
function hm_arkintide_mod_gml_hm_warning_particles(_hml__elapsed) {
hm_fx_wait -= _hml__elapsed;
;
repeat (4) if ((hm_fx_wait <= 0)) {
{
hm_fx_wait += 2.5;
;
var _hml_px = (x + random_range((- 48), 48));
var _hml_py = (y + random_range((- 48), 48));
;
{ var __hm_with1 = scrHMInstances(instance_create(_hml_px, _hml_py, IDPDPortalCharge)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var __hm_other4=scrHMOther(other);
scrHMMotionAdd(point_direction(x, y, __hm_other4.x, __hm_other4.y), (2 + random(1)));
;
var __hm_other5=scrHMOther(other);
alarm[0] = max(1, (ceil((point_distance(x, y, __hm_other5.x, __hm_other5.y) / max(0.1, (speed / timescale)))) + 1));
;
}
}
if(__hm_break3) break;
}}
}
}
if ((hm_fx_wait <= 0)) {
hm_fx_wait = 2.5;
}
}

// Source arkintide.mod.gml:0; hm_warning_emit (native content 1.1.0)
function hm_arkintide_mod_gml_hm_warning_emit() {
if (hm_spawned) {
exit;
}
hm_spawned = 1;
;
instance_create((x - 32), y, PortalClear);
;
instance_create((x + 32), y, PortalClear);
;
instance_create(x, (y - 32), PortalClear);
;
instance_create(x, (y + 32), PortalClear);
;
scrHMModCall("mod", "enemies", "IDPDTank_create", x, y, hm_angle);
;
scrHMSoundPlay(sndVanPortal);
;
}

// Source arkintide.mod.gml:0; hm_cursed_portal_hop (native content 1.1.0)
function hm_arkintide_mod_gml_hm_cursed_portal_hop() {
if ((!scrHMVariableExists(id, "hm_curse_anchor_x"))) {
{
hm_curse_anchor_x = xstart;
;
hm_curse_anchor_y = ystart;
;
}
}
if (((endgame < 100) || (! instance_exists(Floor)))) {
exit;
}
var _hml_ax = hm_curse_anchor_x;
var _hml_ay = hm_curse_anchor_y;
var _hml_found = noone;
var _hml_count = 0;
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var _hml_px = (x + 16);
var _hml_py = (y + 16);
;
if ((point_distance(_hml_px, _hml_py, _hml_ax, _hml_ay) > 160)) {
continue;
}
if ((collision_circle(_hml_px, _hml_py, 12, [Wall, InvisiWall], false, true) != noone)) {
continue;
}
_hml_count++;
;
if ((random(_hml_count) < 1)) {
_hml_found = id;
}
}
}
if(__hm_break3) break;
}}
if (instance_exists(_hml_found)) {
{
x = (_hml_found.x + 16);
;
y = (_hml_found.y + 16);
;
}
}
}

// Source arkintide.mod.gml:0; hm_extra_loot (native content 1.1.0)
function hm_arkintide_mod_gml_hm_extra_loot() {
if ((((! (scrHMVariableExists(id, "hm_extra") && hm_extra)) || (hp > 0)) || (team == 2))) {
exit;
}
if ((scrHMVariableExists(id, "hm_extra_loot_done") && hm_extra_loot_done)) {
exit;
}
hm_extra_loot_done = 1;
;
scrHMExtraDeathVisual1116();
scrHMPickupDrop1100(100, 0);
;
}

// Source arkintide.mod.gml:0; hm_bullet_maggot_allowed (native content 1.1.0)
function hm_arkintide_mod_gml_hm_bullet_maggot_allowed() {
if (scrHMVariableExists(id, "hitid")) {
{
if ((hitid == HitId.SuperFrog)) {
return false;
}
if (((is_array(hitid) && (array_length(hitid) > 0)) && (hitid[0] == sprSuperFrogIdle))) {
return false;
}
}
}
if (((scrHMVariableExists(id, "creator") && instance_exists(creator)) && (creator.object_index == SuperFrog))) {
return false;
}
return true;
;
}

// Source arkintide.mod.gml:0; hm_stage_boss_actor (native content 1.1.0)
function hm_arkintide_mod_gml_hm_stage_boss_actor() {
if(self[$ "hm_messenger_auto_revived115"]??false) return !(self[$ "hm_extra"]??false) && hp>0;

if(self[$ "hm_palace_guardian"]??false) return false;

if ((scrHMVariableExists(id, "hm_extra") && hm_extra)) {
return false;
}
if ((scrHMVariableExists(id, "name") && (name == "hm_gungod_landing"))) {
return true;
}
if (((hp <= 0) || (team == 2))) {
return false;
}
switch (object_index) {
case BanditBoss:

case ScrapBoss:

case HyperCrystal:

case LilHunter:

case FrogQueen:

case OasisBoss:

case TechnoMancer:

case NothingInactive:

case Nothing:

case Nothing2:

case Last:

case CrownGuardian:

case YVBoss:
return true;
;
}
if (((object_index == CustomEnemy) && scrHMVariableExists(id, "name"))) {
switch (name) {
case "scorpionboss":

case "gatorboss":

case "BIG BIRD":

case "ratboss":

case "turtle1":

case "turtle2":

case "turtle3":

case "turtle4":

case "titank":

case "guardianboss":

case "rogueboss":

case "hm_yv_phase":

case "GunGod":

case "gungod":
return true;
;
}
}
return false;
;
}

// Source arkintide.mod.gml:0; hm_stage_boss_alive (native content 1.1.0)
function hm_arkintide_mod_gml_hm_stage_boss_alive() {
var _hml_alive = false;
;
{ var __hm_with1 = scrHMInstances(enemy), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (hm_arkintide_mod_gml_hm_stage_boss_actor()) {
{
_hml_alive = true;
;
__hm_break3=true; break;
;
}
}
}
if(__hm_break3) break;
}}
if (((instance_exists(WantBoss) || instance_exists(WantLH)) || instance_exists(BecomeScrapBoss))) {
return true;
}
// Flying is an object change of the same live boss, not its death.
if(!_hml_alive) with(LilHunterFly) if(hp>0 && !(self[$ "hm_extra"]??false)) {_hml_alive=true;break;}
return _hml_alive;
;
}

// Source arkintide.mod.gml:0; hm_stage_music_tick (native content 1.1.0)
function hm_arkintide_mod_gml_hm_stage_music_tick() {
{ var __hm_with1 = scrHMInstances(MusCont), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (((alarm[1] >= 0) && (hm_arkintide_mod_gml_hm_stage_boss_alive() || scrHMThroneWinHeld1103()))) {
alarm[1] = (- 1);
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_bossbar_top (native content 1.1.0)
function hm_arkintide_mod_gml_hm_bossbar_top() {
switch (name) {
case "titank":

case "scorpionboss":

case "ratboss":

case "rogueboss":
case "roguefreak":

case "GunGod":

case "gungod":

case "hm_yv_phase":
return true;
;
}
return false;
;
}

// Source arkintide.mod.gml:0; hm_van_body_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_van_body_step() {
if ((hp <= 0)) {
{
instance_destroy();
;
exit;
;
}
}
if ((! canmelee)) {
exit;
}
{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
{
{ var __hm_with4 = scrHMInstances((scrHMOther(other))), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
scrHMContentEvent1100(enemy, ev_collision, Player);
}
if(__hm_break6) break;
}}
;
}
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_elevator_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_elevator_step() {
scrHMElevatorStep1102();
}

// Source arkintide.mod.gml:0; hm_gungod_shot (native content 1.1.0)
function hm_arkintide_mod_gml_hm_gungod_shot(_hml__x, _hml__y, _hml__angle) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, EnemyBullet4)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
direction = _hml__angle;
;
speed = (14) * timescale;
;
image_angle = direction;
;
var __hm_other4=scrHMOther(other);
creator = __hm_other4;
;
var __hm_other5=scrHMOther(other);
team = __hm_other5.team;
;
var __hm_other6=scrHMOther(other);
hitid = __hm_other6.hitid;
;
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_gungod_floor (native content 1.1.0)
function hm_arkintide_mod_gml_hm_gungod_floor(_hml__x, _hml__y) {
var _hml_landing = noone;
var _hml_best = 1000000000000000000;
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var _hml_xx = (x + 16);
var _hml_yy = (y + 16);
var _hml_dx = (_hml_xx - _hml__x);
var _hml_dy = (_hml_yy - _hml__y);
var _hml_dist = ((_hml_dx * _hml_dx) + (_hml_dy * _hml_dy));
;
if (((_hml_dist < _hml_best) && hm_arkintide_mod_gml_hm_throne_clear(_hml_xx, _hml_yy, mskVan))) {
{
_hml_landing = id;
;
_hml_best = _hml_dist;
;
}
}
}
}
if(__hm_break3) break;
}}
return _hml_landing;
;
}

// Source arkintide.mod.gml:0; hm_gungod_bounds (native content 1.1.0)
function hm_arkintide_mod_gml_hm_gungod_bounds() {
if ((instance_exists(GenCont) || (hp <= 0))) {
exit;
}
var _hml_mask = mask_index;
;
if ((_hml_mask < 0)) {
_hml_mask = sprite_index;
}
if (hm_arkintide_mod_gml_hm_throne_clear(x, y, _hml_mask)) {
{
hm_venus_safe_x = x;
;
hm_venus_safe_y = y;
;
exit;
;
}
}
var _hml_xx = x;
var _hml_yy = y;
var _hml_found = false;
;
if ((scrHMVariableExists(id, "hm_venus_safe_x") && hm_arkintide_mod_gml_hm_throne_clear(hm_venus_safe_x, hm_venus_safe_y, _hml_mask))) {
{
_hml_xx = hm_venus_safe_x;
;
_hml_yy = hm_venus_safe_y;
;
_hml_found = true;
;
}
} else {
{
var _hml_best = 1000000000000;
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var _hml_px = (x + 16);
var _hml_py = (y + 16);
var _hml_dist = point_distance(_hml_px, _hml_py, (scrHMOther(other)).x, (scrHMOther(other)).y);
;
if (((_hml_dist < _hml_best) && hm_arkintide_mod_gml_hm_throne_clear(_hml_px, _hml_py, _hml_mask))) {
{
_hml_xx = _hml_px;
;
_hml_yy = _hml_py;
;
_hml_best = _hml_dist;
;
_hml_found = true;
;
}
}
}
}
if(__hm_break3) break;
}}
}
}
if (_hml_found) {
{
x = _hml_xx;
;
y = _hml_yy;
;
xprevious = x;
;
yprevious = y;
;
speed = (0) * timescale;
;
hspeed = (0) * timescale;
;
vspeed = (0) * timescale;
;
hm_venus_safe_x = x;
;
hm_venus_safe_y = y;
;
}
}
}

// Source arkintide.mod.gml:0; hm_gungod_motion_guard (native content 1.1.0)
function hm_arkintide_mod_gml_hm_gungod_motion_guard() {
hm_arkintide_mod_gml_hm_gungod_bounds();
;
var _hml_mask = mask_index;
;
if ((_hml_mask < 0)) {
_hml_mask = sprite_index;
}
var _hml_travel = max(1, 1);
;
if ((! hm_arkintide_mod_gml_hm_throne_clear((x + ((hspeed / timescale) * _hml_travel)), (y + ((vspeed / timescale) * _hml_travel)), _hml_mask))) {
{
speed = (0) * timescale;
;
hspeed = (0) * timescale;
;
vspeed = (0) * timescale;
;
spd = 0;
;
right *= (- 1);
;
}
}
}

// Source arkintide.mod.gml:0; hm_gungod_hurt (native content 1.1.0)
function hm_arkintide_mod_gml_hm_gungod_hurt() {
if (hm_gungod_departed) {
exit;
}
if (((((instance_exists((scrHMOther(other))) && scrHMVariableExists((scrHMOther(other)), "hitid")) && is_array((scrHMOther(other)).hitid)) && (array_length((scrHMOther(other)).hitid) > 2)) && ((scrHMOther(other)).hitid[2] == id))) {
exit;
}
hp -= damage;
;
wframes = 4;
;
nexthurt = (current_frame + 12);
;
if ((snd_hurt >= 0)) {
scrHMSoundPlay(snd_hurt);
}
if ((! (hp <= 14250))) {
exit;
}
hm_gungod_departed = 1;
;
hp = 14250;
;
canmelee = 0;
;
corpse = 0;
;
var _hml_hull = id;
var _hml_landing = instance_create(x, y, CustomEnemy);
;
{ var __hm_with1 = scrHMInstances(_hml_landing), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "hm_gungod_landing";
;
hm_gungod_parent = _hml_hull;
;
target = hm_arkintide_mod_gml_hm_venus_boss_floor(x, y);
;
vspeed = ((- 5)) * timescale;
;
friction = (0.4) * (timescale * timescale);
;
nokill = 30;
;
hm_maxhealth_init = false;
;
scrHMMaxHealthWrite(id, 1, "=");
;
hp = 1;
;
can_die = false;
;
team = 2;
;
mask_index = mskNone;
;
canfly = 1;
;
canmelee = 0;
;
corpse = 0;
;
raddrop = 0;
;
sprite_index = sprMutant6Idle;
;
on_step = scrHMContentRef1100("mod", "gungod", "yungbullet");
;
}
}
if(__hm_break3) break;
}}
on_step = scrHMContentRef1100("mod", "gungod", "helicopterdown");
;
}

// Source arkintide.mod.gml:0; hm_yv_phase_create (native content 1.1.0)
function hm_arkintide_mod_gml_hm_yv_phase_create(_hml__x, _hml__y, _hml__hp) {
var _hml_actor = instance_create(_hml__x, _hml__y, YVBoss);
;
if ((! instance_exists(_hml_actor))) {
return noone;
}
{ var __hm_with1 = scrHMInstances(_hml_actor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
hm_arkintide_mod_gml_hm_extra_timer_take();
;
hm_arkintide_mod_gml_hm_extra_change(CustomEnemy);
;
hm_arkintide_mod_gml_hm_yv_phase_bind();
;
name = "hm_yv_phase";
;
hp = _hml__hp;
;
scrHMMaxHealthWrite(id, _hml__hp, "=");
scrHMBossHealth1103();
;
intro = 1;
;
team = 1;
;
canfly = 0;
;
corpse = 1;
;
hm_extra_alarms[1] = 30;
;
hm_extra_alarms[6] = (- 1);
;
hm_extra_alarms[7] = (- 1);
;
hm_arkintide_mod_gml_hm_gungod_bounds();
;
}
}
if(__hm_break3) break;
}}
return _hml_actor;
;
}

// Source arkintide.mod.gml:0; hm_yv_phase_bind (native content 1.1.0)
function hm_arkintide_mod_gml_hm_yv_phase_bind() {
can_die = true;
;
boss = 0;
;
newintro = (- 1);
;
hm_maxhealth_init = false;
;
on_begin_step = undefined;
;
on_end_step = undefined;
;
on_hurt = undefined;
;
on_cleanup = undefined;
;
on_step = scrHMContentRef1100("mod", "arkintide", "hm_yv_phase_step");
;
on_draw = scrHMContentRef1100("mod", "arkintide", "hm_yv_phase_draw");
;
on_death = scrHMContentRef1100("mod", "arkintide", "hm_yv_phase_loot");
;
on_destroy = undefined;
;
}

// Source arkintide.mod.gml:0; hm_yv_phase_event (native content 1.1.0)
function hm_arkintide_mod_gml_hm_yv_phase_event(_hml__type, _hml__number) {
hm_arkintide_mod_gml_hm_extra_timer_restore();
;
hm_arkintide_mod_gml_hm_extra_change(YVBoss);
;
scrHMContentEvent1100(YVBoss, _hml__type, _hml__number);
;
if ((! instance_exists(id))) {
exit;
}
hm_arkintide_mod_gml_hm_extra_timer_take();
;
hm_arkintide_mod_gml_hm_extra_change(CustomEnemy);
;
hm_arkintide_mod_gml_hm_yv_phase_bind();
;
if (((_hml__type == ev_alarm) && ((_hml__number == 1) || (_hml__number == 2)))) {
{ var __hm_with1 = scrHMInstances(projectile), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (((scrHMVariableExists(id, "creator") && (creator == (scrHMOther(other)).id)) && (! scrHMVariableExists(id, "hm_yv_shot_checked")))) {
{
hm_yv_shot_checked = 1;
;
if ((object_index == JockRocket)) {
sprite_index = sprGoldRocket;
}
}
}
}
if(__hm_break3) break;
}}
}
}

// Source arkintide.mod.gml:0; hm_yv_phase_step (native content 1.1.0)
function hm_arkintide_mod_gml_hm_yv_phase_step() {
if ((hp <= 0)) {
exit;
}
hm_arkintide_mod_gml_hm_gungod_bounds();
;
for (var _hml_a = 0; (_hml_a < 12); _hml_a++) if ((hm_extra_alarms[_hml_a] >= 0)) {
{
hm_extra_alarms[_hml_a] -= 1;
;
if ((hm_extra_alarms[_hml_a] <= 0)) {
{
hm_extra_alarms[_hml_a] = (- 1);
;
hm_arkintide_mod_gml_hm_yv_phase_event(ev_alarm, _hml_a);
;
if ((! instance_exists(id))) {
exit;
}
}
}
}
}
hm_arkintide_mod_gml_hm_yv_phase_event(ev_other, 15);
;
}

// Source arkintide.mod.gml:0; hm_yv_phase_draw (native content 1.1.0)
function hm_arkintide_mod_gml_hm_yv_phase_draw() {
scrHMContentEvent1100(YVBoss, ev_draw, 0);
;
}

// Source arkintide.mod.gml:0; hm_yv_phase_loot (native content 1.1.0)
function hm_arkintide_mod_gml_hm_yv_phase_loot() {
if (scrHMVariableExists(id, "hm_yv_loot_done")) {
exit;
}
hm_yv_loot_done = 1;
;
scrHMPickupDrop1100(100, 0);
;
if ((GameCont.area == scrHMAreaResolve("venuz"))) {
scrHMModCall("mod", "props", "VenuzCar_create", x, y, 300);
} else {
hm_arkintide_mod_gml_hm_gungod_win();
}
;
}

// Source arkintide.mod.gml:0; hm_gungod_win (native content 1.1.0)
function hm_arkintide_mod_gml_hm_gungod_win() {
if (hm_arkintide_mod_gml_hm_stage_boss_alive()) {
exit;
}
scrHMSoundPlay(sndBossWin);
;
scrHMSoundMusic(musBossDead);
;
}

// Source arkintide.mod.gml:0; hm_gungod_area_allowed (native content 1.1.0)
function hm_arkintide_mod_gml_hm_gungod_area_allowed() {
switch (GameCont.area) {
case 1:

case 2:

case 3:

case 4:

case 5:

case 6:

case 219:

case 203:

case 218:

case 204:

case 208:

case 217:

case 202:

case 216:

case 210:

case 201:

case 215:

case 209:

case 214:

case 205:
return true;
;
}
return false;
;
}

// Source arkintide.mod.gml:0; hm_gungod_replace_tick (native content 1.1.0)
function hm_arkintide_mod_gml_hm_gungod_replace_tick() {
scrHMReplacementTick1102();
}

// Source arkintide.mod.gml:0; hm_horror_bullets (native content 1.1.0)
function hm_arkintide_mod_gml_hm_horror_bullets() {
{ var __hm_with1 = scrHMInstances(HorrorBullet), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (((instance_exists(creator) && scrHMVariableExists(creator, "hm_horror")) && creator.hm_horror)) {
scrHMDelete(id);
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_snowtank_bullets (native content 1.1.0)
function hm_arkintide_mod_gml_hm_snowtank_bullets() {
{ var __hm_with1 = scrHMInstances(EnemyBullet4), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((instance_exists(creator) && (creator.object_index == SnowTank))) {
{
{ var __hm_with4 = scrHMInstances(instance_create(x, y, EnemyBullet3)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
team = 1;
;
var __hm_other7=scrHMOther(other);
speed = (((__hm_other7.speed / timescale) * 1.5)) * timescale;
;
var __hm_other8=scrHMOther(other);
direction = __hm_other8.direction;
;
image_angle = direction;
;
var __hm_other9=scrHMOther(other);
hitid = __hm_other9.hitid;
;
}
}
if(__hm_break6) break;
}}
instance_destroy();
;
}
}
}
if(__hm_break3) break;
}}
}

// Source arkintide.mod.gml:0; hm_van_body_hurt (native content 1.1.0)
function hm_arkintide_mod_gml_hm_van_body_hurt(_hml__damage, _hml__knockback, _hml__direction) {
return scrHMVanBodyHurt1101(_hml__damage, _hml__knockback, _hml__direction);
}

// Source arkintide.mod.gml:0; hm_van_recheck_exit (native content 1.1.0)
function hm_arkintide_mod_gml_hm_van_recheck_exit() {
scrHMVanRecheckExit1100();
}


// Source arkintide.mod.gml:0; hm_water_flat_build (native content 1.1.0)
function hm_arkintide_mod_gml_hm_water_flat_build(_hml_owner) {
_hml_owner.hm_water_cells = undefined;
;
var _hml_minx = 1000000000;
var _hml_miny = 1000000000;
var _hml_maxx = (- 1000000000);
var _hml_maxy = (- 1000000000);
;
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
var _hml_left = bbox_left;
var _hml_right = bbox_right;
var _hml_top = bbox_top;
var _hml_bottom = bbox_bottom;
;
if ((sprite_index == mskNone)) {
{
_hml_left = x;
;
_hml_right = (x + 31);
;
_hml_top = y;
;
_hml_bottom = (y + 31);
;
}
}
_hml_minx = min(_hml_minx, floor((_hml_left / 32)));
;
_hml_miny = min(_hml_miny, floor((_hml_top / 32)));
;
_hml_maxx = max(_hml_maxx, floor((_hml_right / 32)));
;
_hml_maxy = max(_hml_maxy, floor((_hml_bottom / 32)));
;
}
}
if(__hm_break3) break;
}}
var _hml_width = ((_hml_maxx - _hml_minx) + 1);
var _hml_height = ((_hml_maxy - _hml_miny) + 1);
;
if ((((_hml_width <= 0) || (_hml_height <= 0)) || ((_hml_width * _hml_height) > 65536))) {
return;
}
var _hml_cells = array_create((_hml_width * _hml_height), 0);
;
{ var __hm_with4 = scrHMInstances(Floor), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
var _hml_left = bbox_left;
var _hml_right = bbox_right;
var _hml_top = bbox_top;
var _hml_bottom = bbox_bottom;
;
if ((sprite_index == mskNone)) {
{
_hml_left = x;
;
_hml_right = (x + 31);
;
_hml_top = y;
;
_hml_bottom = (y + 31);
;
}
}
for (var _hml_cy = floor((_hml_top / 32)); (_hml_cy <= floor((_hml_bottom / 32))); _hml_cy++) for (var _hml_cx = floor((_hml_left / 32)); (_hml_cx <= floor((_hml_right / 32))); _hml_cx++) {
var _hml_index = ((_hml_cx - _hml_minx) + ((_hml_cy - _hml_miny) * _hml_width));
var _hml_items = _hml_cells[_hml_index];
;
if ((! is_array(_hml_items))) {
_hml_items = [];
}
array_push(_hml_items, id);
;
_hml_cells[_hml_index] = _hml_items;
;
}
}
}
if(__hm_break6) break;
}}
_hml_owner.hm_water_min_x = _hml_minx;
;
_hml_owner.hm_water_min_y = _hml_miny;
;
_hml_owner.hm_water_width = _hml_width;
;
_hml_owner.hm_water_height = _hml_height;
;
_hml_owner.hm_water_cells = _hml_cells;
;
}
