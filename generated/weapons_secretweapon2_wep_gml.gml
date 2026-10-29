// Source weapons/secretweapon2.wep.gml:1; __load
function hm_weapons_secretweapon2_wep_gml___load() {
global.hm_module_vars[$ "weapon:secretweapon2"].gun = sprHM_weapons_secretweapon2_wep_1;
global.hm_module_vars[$ "weapon:secretweapon2"].harpoon = sprHM_weapons_secretweapon2_wep_2;
global.hm_module_vars[$ "weapon:secretweapon2"].harpoon2 = sprHM_weapons_secretweapon2_wep_3;
}

// Source weapons/secretweapon2.wep.gml:5; weapon_name
function hm_weapons_secretweapon2_wep_gml_weapon_name() {
return "Harpoon Gun";
;
}

// Source weapons/secretweapon2.wep.gml:7; weapon_type
function hm_weapons_secretweapon2_wep_gml_weapon_type() {
return 3;
;
}

// Source weapons/secretweapon2.wep.gml:10; weapon_cost
function hm_weapons_secretweapon2_wep_gml_weapon_cost() {
return 1;
;
}

// Source weapons/secretweapon2.wep.gml:13; weapon_load
function hm_weapons_secretweapon2_wep_gml_weapon_load() {
return 50;
;
}

// Source weapons/secretweapon2.wep.gml:16; weapon_auto
function hm_weapons_secretweapon2_wep_gml_weapon_auto() {
return 0;
;
}

// Source weapons/secretweapon2.wep.gml:19; weapon_area
function hm_weapons_secretweapon2_wep_gml_weapon_area() {
if (((GameCont.area == scrHMAreaResolve("oasis")) || (GameCont.area == scrHMAreaResolve(101)))) {
return 1;
} else {
return (- 1);
}
;
}

// Source weapons/secretweapon2.wep.gml:25; weapon_swap
function hm_weapons_secretweapon2_wep_gml_weapon_swap() {
return sndSwapBow;
;
}

// Source weapons/secretweapon2.wep.gml:28; weapon_sprt
function hm_weapons_secretweapon2_wep_gml_weapon_sprt() {
return global.hm_module_vars[$ "weapon:secretweapon2"].gun;
;
}

// Source weapons/secretweapon2.wep.gml:31; weapon_text
function hm_weapons_secretweapon2_wep_gml_weapon_text() {
return "";
;
}

// Source weapons/secretweapon2.wep.gml:34; weapon_laser_sight
function hm_weapons_secretweapon2_wep_gml_weapon_laser_sight() {
return false;
;
}

// Source weapons/secretweapon2.wep.gml:37; weapon_fire
function hm_weapons_secretweapon2_wep_gml_weapon_fire() {
scrHMSoundPitch(sndHeavyCrossbow, 0.5);
;
scrHMWeaponPost(10, 20, 20);
{ var __hm_with1 = scrHMInstances(instance_create((x + lengthdir_x(10, gunangle)), (y + lengthdir_y(10, gunangle)), HeavyBolt)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "harpoon";
var __hm_other4=scrHMOther(other);
right = __hm_other4.right;
var __hm_other5=scrHMOther(other);
direction = __hm_other5.gunangle;
speed = (12) * timescale;
damage = 50;
image_angle = direction;
;
var __hm_other6=scrHMOther(other);
hitid = [__hm_other6.spr_idle, __hm_other6.race];
;
sprite_index = global.hm_module_vars[$ "weapon:secretweapon2"].harpoon;
var __hm_other7=scrHMOther(other);
team = __hm_other7.team;
;
var __hm_other8=scrHMOther(other);
creator = __hm_other8;
;
}
}
if(__hm_break3) break;
}}
}

// Source weapons/secretweapon2.wep.gml:54; step
function hm_weapons_secretweapon2_wep_gml_step() {
if ((object_index == Player)) {
{
if (((wep == scrHMWeaponResolve("secretweapon2")) and (reload < 2))) {
var __hm_other1=scrHMOther(other);
scrHMBindDraw(hm_weapons_secretweapon2_wep_gml_harpoon, (id.depth + 0.1), __hm_other1);
}
if (((bwep == scrHMWeaponResolve("secretweapon2")) and (breload < 2))) {
{
if ((race != 7)) {
var __hm_other2=scrHMOther(other);
scrHMBindDraw(hm_weapons_secretweapon2_wep_gml_harpoonb, (id.depth + 0.1), __hm_other2);
} else {
var __hm_other3=scrHMOther(other);
scrHMBindDraw(hm_weapons_secretweapon2_wep_gml_harpoons, (id.depth + 0.1), __hm_other3);
}
}
}
}
}
{ var __hm_with4 = scrHMMatching(HeavyBolt, "name", "harpoon"), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
if (((!scrHMVariableExists(id, "scarf")) || (! instance_exists(scarf)))) {
{
scarf = instance_create(x, y, CustomObject);
;
{ var __hm_with7 = scrHMInstances(scarf), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
name = "Scarf";
;
var __hm_other10=scrHMOther(other);
creator = __hm_other10;
;
var __hm_other11=scrHMOther(other);
last_scarf = __hm_other11;
;
length = 5;
;
}
}
if(__hm_break9) break;
}}
}
}
{ var __hm_with12 = scrHMInstances(BoltTrail), __hm_break14=false;
for (var __hm_index13=0; __hm_index13<array_length(__hm_with12); ++__hm_index13) {
if(instance_exists(__hm_with12[__hm_index13])) with (__hm_with12[__hm_index13]) {
if ((creator == (scrHMOther(other)).creator)) {
instance_destroy();
}
}
if(__hm_break14) break;
}}
}
}
if(__hm_break6) break;
}}
{ var __hm_with15 = scrHMMatching(CustomObject, "name", "Scarf"), __hm_break17=false;
for (var __hm_index16=0; __hm_index16<array_length(__hm_with15); ++__hm_index16) {
if(instance_exists(__hm_with15[__hm_index16])) with (__hm_with15[__hm_index16]) {
{
if (((length >= 0) && instance_exists(last_scarf))) {
{
if ((last_scarf == creator)) {
{
targetx = (creator.x - lengthdir_x((12 / image_xscale), ((90 - (creator.right * 90)) + (sin((current_frame / length)) * 10))));
;
targety = (creator.y - lengthdir_y((12 / image_yscale), ((90 - (creator.right * 90)) + (sin((current_frame / length)) * 10))));
;
}
} else {
if (instance_exists(creator)) {
{
targetx = (last_scarf.x + lengthdir_x(((creator.speed / timescale) - 2), last_scarf.image_angle));
;
targety = (last_scarf.y + lengthdir_y(((creator.speed / timescale) - 2), last_scarf.image_angle));
;
}
}
}
image_angle = point_direction(x, y, last_scarf.x, last_scarf.y);
;
image_xscale = (1 + point_distance(x, y, last_scarf.x, last_scarf.y));
;
image_yscale = 0.5;
;
if ((last_scarf == creator)) {
{
x = targetx;
;
y = targety;
;
scrHMMotionSet(creator.direction, (creator.speed / timescale));
;
}
} else {
{
if (scrHMVariableExists(id, "targetx")) {
scrHMMotionSet(point_direction(x, y, targetx, targety), (point_distance(x, y, targetx, targety) / 2));
}
}
}
{ var __hm_with18 = scrHMInstances(creator), __hm_break20=false;
for (var __hm_index19=0; __hm_index19<array_length(__hm_with18); ++__hm_index19) {
if(instance_exists(__hm_with18[__hm_index19])) with (__hm_with18[__hm_index19]) {
{
if ((distance_to_object(Portal) <= 0)) {
{ var __hm_with21 = scrHMInstances((scrHMOther(other))), __hm_break23=false;
for (var __hm_index22=0; __hm_index22<array_length(__hm_with21); ++__hm_index22) {
if(instance_exists(__hm_with21[__hm_index22])) with (__hm_with21[__hm_index22]) {
if (visible) {
{
if ((instance_exists(last_scarf) && (! last_scarf.visible))) {
var __hm_other24=scrHMOther(other);
scrHMMotionSet(point_direction(x, y, __hm_other24.x, __hm_other24.y), 4);
}
if ((distance_to_object(Portal) <= 0)) {
visible = 0;
}
}
}
}
if(__hm_break23) break;
}}
}
}
}
if(__hm_break20) break;
}}
sprite_index = sprBoltTrail;
;
depth = (- 1);
;
if (((length > 0) && ((!scrHMVariableExists(id, "next_scarf")) || (! instance_exists(next_scarf))))) {
{
next_scarf = instance_create((x - lengthdir_x(1, last_scarf.image_angle)), (y - lengthdir_y(1, last_scarf.image_angle)), CustomObject);
;
{ var __hm_with25 = scrHMInstances(next_scarf), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
{
name = "Scarf";
;
var __hm_other28=scrHMOther(other);
last_scarf = __hm_other28;
;
var __hm_other29=scrHMOther(other);
creator = __hm_other29.creator;
;
var __hm_other30=scrHMOther(other);
length = (__hm_other30.length - 1);
;
}
}
if(__hm_break27) break;
}}
}
}
}
}
if (((length < 0) || (! instance_exists(last_scarf)))) {
{
repeat (2) { var __hm_with31 = scrHMInstances(instance_create(x, y, Feather)), __hm_break33=false;
for (var __hm_index32=0; __hm_index32<array_length(__hm_with31); ++__hm_index32) {
if(instance_exists(__hm_with31[__hm_index32])) with (__hm_with31[__hm_index32]) {
{
var __hm_other34=scrHMOther(other);
sprite_index = __hm_other34.sprite_index;
;
var __hm_other35=scrHMOther(other);
image_angle = __hm_other35.image_angle;
;
var __hm_other36=scrHMOther(other);
image_blend = __hm_other36.image_blend;
;
var __hm_other37=scrHMOther(other);
creator = __hm_other37.creator;
;
}
}
if(__hm_break33) break;
}}
instance_destroy();
;
}
}
}
}
if(__hm_break17) break;
}}
}

// Source weapons/secretweapon2.wep.gml:142; harpoon
function hm_weapons_secretweapon2_wep_gml_harpoon() {
{ var __hm_with1 = scrHMInstances(argument0), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
scrHMDrawSpriteExt(global.hm_module_vars[$ "weapon:secretweapon2"].harpoon2, 1, ((x + (1 * right)) + lengthdir_x(8, gunangle)), (y + lengthdir_y(8, gunangle)), 1, right, gunangle, c_white, 1);
;
}
}
if(__hm_break3) break;
}}
instance_destroy();
}

// Source weapons/secretweapon2.wep.gml:147; harpoonb
function hm_weapons_secretweapon2_wep_gml_harpoonb() {
{ var __hm_with1 = scrHMInstances(argument0), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
scrHMDrawSpriteExt(global.hm_module_vars[$ "weapon:secretweapon2"].harpoon2, 1, ((x + (2 * right)) + lengthdir_x(8, (90 + (15 * right)))), (y + lengthdir_y(8, (90 + (15 * right)))), 1, (right * (- 1)), (90 + (15 * right)), c_silver, 1);
}
}
if(__hm_break3) break;
}}
instance_destroy();
}

// Source weapons/secretweapon2.wep.gml:152; harpoons
function hm_weapons_secretweapon2_wep_gml_harpoons() {
{ var __hm_with1 = scrHMInstances(argument0), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
scrHMDrawSpriteExt(global.hm_module_vars[$ "weapon:secretweapon2"].harpoon2, 1, ((x + (1 * right)) + lengthdir_x(8, gunangle)), ((y + lengthdir_y(8, gunangle)) - 4), 1, (right * (- 1)), gunangle, c_white, 1);
;
}
}
if(__hm_break3) break;
}}
instance_destroy();
}
