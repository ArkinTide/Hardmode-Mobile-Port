// Source bosses/gungod.mod.gml:1; __load

function hm_bosses_gungod_mod_gml___load() {

global.hm_module_vars[$ "mod:bosses/gungod"].GunGod = sprHM_bosses_gungod_mod_2;

}



// Source bosses/gungod.mod.gml:0; GunGod_create (native content 1.1.0)
function hm_bosses_gungod_mod_gml_GunGod_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomEnemy)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "GunGod";
spr_idle = global.hm_module_vars[$ "mod:bosses/gungod"].GunGod;
mask_index = mskVan;
hitid = [sprMoneyPile, "DA GUN GOD", id];
spr_shadow = mskNone;
hm_maxhealth_init = false;
;
scrHMMaxHealthWrite(id, 15000, "=");
hp = max_hp;
scrHMGunGodHealth1103();
;
can_die = false;
;
hm_gungod_departed = 0;
;
hm_gungod_anchor_x = _hml__x;
;
hm_gungod_anchor_y = _hml__y;
;
shd_y = 0;
friction = (0.1) * (timescale * timescale);
size = 1;
canfly = (GameCont.area == scrHMAreaResolve("venuz"));
;
team = 1;
depth = (- 10);
right = 1;
spd = 0;
z = 0;
rot = 0;
wframes = 0;
gunangle = 270;
;
zscale = 1;
;
attacktype = 1;
;
attackchange = 25;
;
attackpause = 60;
;
direction = 270;
;
image_alpha = 0;
;
image_xscale = 0.8;
image_yscale = 0.8;
on_draw = scrHMScriptRef(hm_bosses_gungod_mod_gml_GunGod_draw);
on_step = scrHMScriptRef(hm_bosses_gungod_mod_gml_GunGod_step);
on_hurt = scrHMScriptRef(hm_bosses_gungod_mod_gml_GunGod_hurt);
on_destroy = scrHMScriptRef(hm_bosses_gungod_mod_gml_GunGod_dead);
return id;
;
}
}
if(__hm_break3) break;
}}
}

// Source bosses/gungod.mod.gml:46; GunGod_draw

function hm_bosses_gungod_mod_gml_GunGod_draw() {

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

_hml_shad_scale = (1 - min((0.66 * (z / 96)), 0.66));

draw_set_color(make_color_rgb(20, 20, 20));

;

draw_set_alpha(0.4);

;

draw_ellipse(((x - 2) + (12 * _hml_shad_scale)), ((y + (8 * _hml_shad_scale)) + shd_y), ((x - 2) - (12 * _hml_shad_scale)), ((y - (8 * _hml_shad_scale)) + shd_y), 0);

;

draw_set_color(c_white);

;

draw_set_alpha(1);

;

if ((wframes > 0)) {

gpu_set_fog(true, c_white, 0, 0);

}

for (_hml_i = 0; (_hml_i <= 52); _hml_i++) {

repeat (zscale) {

scrHMDrawSpriteExt(global.hm_module_vars[$ "mod:bosses/gungod"].GunGod, clamp(_hml_i, 0, 51), x, ((y - (.5 * (_hml_i + _hml_g))) - z), image_xscale, image_yscale, image_angle, c_white, 1);

;

_hml_g += 1;

;

}

}

draw_set_color(c_white);

;

draw_set_alpha(random_range(0, 0.5));

;

draw_ellipse((x + random_range(59, 61)), (((y + 50) - random_range(44, 48)) - z), (x - random_range(59, 61)), (((y - 50) - random_range(44, 48)) - z), 0);

;

draw_set_color(c_white);

;

draw_set_alpha(1);

;

gpu_set_fog(0, 0, 0, 0);

}



// Source bosses/gungod.mod.gml:0; GunGod_step (native content 1.1.0)
function hm_bosses_gungod_mod_gml_GunGod_step() {
if ((GameCont.area != scrHMAreaResolve("venuz"))) {
hm_arkintide_mod_gml_hm_gungod_bounds();
}
spr_idle = global.hm_module_vars[$ "mod:bosses/gungod"].GunGod;
sprite_index = spr_idle;
if (instance_exists(Player)) {
{
var _hml_t = undefined;
var _hml_tx = undefined;
var _hml_ty = undefined;
var _hml_td = undefined;
;
_hml_t = instance_nearest(x, y, Player);
_hml_td = point_direction(x, y, _hml_t.x, _hml_t.y);
if ((distance_to_point(hm_gungod_anchor_x, hm_gungod_anchor_y) > 400)) {
direction = point_direction(x, y, _hml_t.x, _hml_t.y);
} else {
direction = (point_direction(x, y, hm_gungod_anchor_x, hm_gungod_anchor_y) + (90 * right));
}
if ((attackpause > 0)) {
{
if ((attackpause > 30)) {
direction = (point_direction(x, y, _hml_t.x, _hml_t.y) + 180);
} else {
if ((distance_to_point(hm_gungod_anchor_x, hm_gungod_anchor_y) > 200)) {
direction = point_direction(x, y, _hml_t.x, _hml_t.y);
}
}
}
}
gunangle = point_direction(x, y, (_hml_t.x + (_hml_t.hspeed / timescale)), (_hml_t.y + (_hml_t.vspeed / timescale)));
speed = (spd) * timescale;
}
}
image_angle = (gunangle + 90);
if ((random(100) < 1)) {
{
right *= (- 1);
spd *= (- 1);
}
}
if ((spd < 5)) {
spd += 0.1;
}
if ((wframes > 0)) {
wframes--;
}
if (((GameCont.area == scrHMAreaResolve("venuz")) && (distance_to_point(10020, 9400) < 260))) {
scrHMMotionAdd((point_direction(x, y, 10020, 9400) + 180), 0.2);
}
if (((GameCont.area == scrHMAreaResolve("venuz")) && (distance_to_point(10020, 9400) < 120))) {
scrHMMotionAdd((point_direction(x, y, 10020, 9400) + 180), 2);
}
if ((instance_exists(Player) and (attackpause <= 0))) {
{
if (((attacktype == 1) and (random(15) < 1))) {
{
repeat (choose(1, 2, 3, 4)+max(0,floor(GameCont.loops))) {
var _hml_a = choose((- 90), 90);
;
{ var __hm_with1 = scrHMInstances(instance_create(((x + (hspeed / timescale)) + lengthdir_x(15, (gunangle + _hml_a))), (((y + (vspeed / timescale)) + lengthdir_y(15, (gunangle + _hml_a))) - 20), JockRocket)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if (instance_exists(Player)) {
{
var _hml_t = instance_nearest(x, y, Player);
;
direction = point_direction(x, y, (_hml_t.x + lengthdir_x((_hml_t.hspeed / timescale), _hml_t.direction)), (_hml_t.y + lengthdir_y((_hml_t.vspeed / timescale), _hml_t.direction)));
}
} else {
var __hm_other4=scrHMOther(other);
direction = __hm_other4.gunangle;
}
var __hm_other5=scrHMOther(other);
hitid = __hm_other5.hitid;
;
image_angle = direction;
var __hm_other6=scrHMOther(other);
team = __hm_other6.team;
var __hm_other7=scrHMOther(other);
creator = __hm_other7;
hm_rocket_owner1115 = __hm_other7.id;
hm_rocket_nochain1116 = true;
sprite_index = sprGoldRocket;
;
speed = (random_range((- 6), 2)) * timescale;
if ((y > ((scrHMOther(other)).y - 20))) {
var __hm_other8=scrHMOther(other);
depth = (__hm_other8.depth - 1);
}
}
}
if(__hm_break3) break;
}}
attackchange--;
;
}
}
} else {
if ((attacktype == (- 1))) {
repeat (2) {
var _hml_a = choose((- 90), 90);
;
var _hml_gang_ = (gunangle + random_range((- 10), 10));
;
var _hml__x = ((x + (hspeed / timescale)) + lengthdir_x(15, (gunangle + _hml_a)));
var _hml__y = ((y + (vspeed / timescale)) + lengthdir_y(15, (gunangle + _hml_a)));
if ((GameCont.area != scrHMAreaResolve("venuz"))) {
hm_arkintide_mod_gml_hm_gungod_shot(_hml__x, _hml__y, _hml_gang_);
} else {
{
var _hml_dist = 4;
;
if ((spd > 2)) {
spd = 0;
}
scrHMSoundPitchVolume(sndMinigun, 0.9, min(1, ((view_width / 4) / max(1, distance_to_object(Player)))));
;
while ((((place_free((_hml__x + lengthdir_x(_hml_dist, _hml_gang_)), (_hml__y + lengthdir_y(_hml_dist, _hml_gang_))) and (! place_meeting((_hml__x + lengthdir_x(_hml_dist, _hml_gang_)), (_hml__y + lengthdir_y(_hml_dist, _hml_gang_)), Player))) and (! place_meeting((_hml__x + lengthdir_x(_hml_dist, _hml_gang_)), (_hml__y + lengthdir_y(_hml_dist, _hml_gang_)), CustomHitme))) and (_hml_dist < (view_width * 3)))) {
_hml_dist += 4;
;
}
{ var __hm_with9 = scrHMInstances(instance_create((_hml__x + lengthdir_x(_hml_dist, _hml_gang_)), (_hml__y + lengthdir_y(_hml_dist, _hml_gang_)), Bullet1)), __hm_break11=false;
for (var __hm_index10=0; __hm_index10<array_length(__hm_with9); ++__hm_index10) {
if(instance_exists(__hm_with9[__hm_index10])) with (__hm_with9[__hm_index10]) {
{
scrHMMotionAdd(_hml_gang_, 10);
;
image_angle = direction;
;
image_alpha = 0;
var __hm_other12=scrHMOther(other);
hitid = __hm_other12.hitid;
;
damage = 1;
knockback_speed = (1) * timescale;
var __hm_other13=scrHMOther(other);
team = __hm_other13.team;
;
var __hm_other14=scrHMOther(other);
creator = __hm_other14;
;
}
}
if(__hm_break11) break;
}}
{ var __hm_with15 = scrHMInstances(instance_create((_hml__x + lengthdir_x(_hml_dist, _hml_gang_)), (_hml__y + lengthdir_y(_hml_dist, _hml_gang_)), Effect)), __hm_break17=false;
for (var __hm_index16=0; __hm_index16<array_length(__hm_with15); ++__hm_index16) {
if(instance_exists(__hm_with15[__hm_index16])) with (__hm_with15[__hm_index16]) {
{
name = "venuzpistoltrail";
sprite_index = sprBoltTrail;
direction = _hml_gang_;
image_angle = (direction + 90);
;
var __hm_other18=scrHMOther(other);
creator = __hm_other18;
;
image_yscale *= _hml_dist;
image_xscale = random_range(0.5, 1.5);
image_alpha = random_range(0, 1);
}
}
if(__hm_break17) break;
}}
{ var __hm_with19 = scrHMInstances(instance_create((_hml__x + lengthdir_x(4, _hml_gang_)), (_hml__y + lengthdir_y(4, _hml_gang_)), EBulletHit)), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
{
sprite_index = sprScrapBossMissileTrail;
image_angle = (_hml_gang_ + 180);
image_speed = (1) * timescale;
}
}
if(__hm_break21) break;
}}
}
}
if ((random(10) < 1)) {
attackchange--;
}
}
}
}
}
}
if ((attackchange <= 0)) {
{
attackchange = 10;
;
attacktype *= (- 1);
;
attackpause = 60;
;
}
}
if ((attackpause > 0)) {
attackpause--;
}
{ var __hm_with22 = scrHMInstances(projectile), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
if (((scrHMVariableExists(id, "creator") && (creator == (scrHMOther(other)).id)) && (distance_to_object(Player) > (view_width * 3)))) {
scrHMDelete(id);
}
}
if(__hm_break24) break;
}}
if ((GameCont.area != scrHMAreaResolve("venuz"))) {
hm_arkintide_mod_gml_hm_gungod_motion_guard();
}
}

// Source bosses/gungod.mod.gml:0; GunGod_hurt (native content 1.1.0)
function hm_bosses_gungod_mod_gml_GunGod_hurt(_hml_damage) {
if (hm_gungod_departed) {
exit;
}
if (((((instance_exists((scrHMOther(other))) && scrHMVariableExists((scrHMOther(other)), "hitid")) && is_array((scrHMOther(other)).hitid)) && (array_length((scrHMOther(other)).hitid) > 2)) && ((scrHMOther(other)).hitid[2] == id))) {
exit;
}
hp -= _hml_damage;
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

// Source bosses/gungod.mod.gml:207; GunGod_dead

function hm_bosses_gungod_mod_gml_GunGod_dead() {



}



// Source bosses/gungod.mod.gml:0; yungbullet (native content 1.1.0)
function hm_bosses_gungod_mod_gml_yungbullet() {
if(!instance_exists(target)) target=instance_nearest(x,y,Floor);
if(!instance_exists(target)) return;
if ((((! instance_exists(target)) || (target.object_index != Floor)) || (! hm_arkintide_mod_gml_hm_throne_clear((target.x + 16), (target.y + 16), mskBandit)))) {
{
target = hm_arkintide_mod_gml_hm_venus_boss_floor(x, y);
;
}
}
if ((! instance_exists(target))) {
{
speed = (0) * timescale;
;
exit;
;
}
}
sprite_index = sprMutant6Idle;
;
image_angle += (10 * 1);
;
if ((nokill > 0)) {
nokill -= 1;
}
if ((nokill > 10)) {
vspeed -= (1) * timescale;
} else {
{
direction = point_direction(x, y, (target.x + 16), (target.y + 16));
;
speed = (min(10, max(1, ((speed / timescale) + 1)))) * timescale;
;
}
}
if (((speed / timescale) > 10)) {
speed = (10) * timescale;
}
if (((nokill <= 0) && (point_distance(x, y, (target.x + 16), (target.y + 16)) <= max(12, ((speed / timescale) * 1))))) {
{
var _hml_next = scrHMModCall("mod", "enemies", "enemyyv_create", (target.x + 16), (target.y + 16));
;
if ((! instance_exists(_hml_next))) {
{
speed = (0) * timescale;
;
exit;
;
}
}
if ((scrHMVariableExists(id, "hm_gungod_parent") && instance_exists(hm_gungod_parent))) {
scrHMDelete(hm_gungod_parent);
}
scrHMSoundPlay(sndHitWall);
;
scrHMDelete(id);
;
}
}
}

// Source bosses/gungod.mod.gml:0; helicopterdown (native content 1.1.0)
function hm_bosses_gungod_mod_gml_helicopterdown() {
mask_index=mskNone;
spr_idle = global.hm_module_vars[$ "mod:bosses/gungod"].GunGod;
sprite_index = spr_idle;
vspeed -= (1) * timescale;
image_angle += (speed / timescale);
if ((random((speed / timescale)) < 5)) {
instance_create((x + random_range((- 20), 20)), (y + random_range((- 20), 20)), SmallExplosion);
}
instance_create((x + random_range((- 10), 10)), (y + random_range((- 10), 10)), Smoke);
if (instance_exists(Player)) {
target = instance_nearest(x, y, Player);
} else {
target = instance_nearest(x, y, Floor);
}
if ((! instance_exists(target))) {
{
scrHMDelete(id);
;
exit;
;
}
}
scrHMMotionAdd((point_direction(x, y, target.x, target.y) + 180), 3);
if ((distance_to_object(Floor) > (view_width * 2))) {
{
scrHMDelete(id);
}
}
}

