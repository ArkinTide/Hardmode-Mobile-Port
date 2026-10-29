// Source bosses/bossintros.mod.gml:1; __load
function hm_bosses_bossintros_mod_gml___load() {

}

// Source bosses/bossintros.mod.gml:2; boss_trigger
function hm_bosses_bossintros_mod_gml_boss_trigger() {
var _hml_only1 = 1;
;
{ var __hm_with1 = scrHMMatching(CustomObject, "name", "bossintro"), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
_hml_only1 += 1;
}
if(__hm_break3) break;
}}
;
if ((_hml_only1 == 1)) {
{ var __hm_with4 = scrHMInstances(instance_create(argument4.x, argument4.y, CustomObject)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
name = "bossintro";
;
bossname = argument0;
;
if (((bossname == "") || (scrHMModExists("mod", "options", "bossportraits") and (scrHMModGet("mod", "options", "bossportraits") == "0")))) {
fadedark = 0;
} else {
{
fadedark = 1;
scrHMSoundPlay(sndBossIntroIn);
}
}
bossname = string_replace_all(bossname, " ", "#");
;
spr[0] = argument1;
;
spr[1] = argument2;
;
spr[2] = argument3;
;
on_step = scrHMScriptRef(hm_bosses_bossintros_mod_gml_customboss_step);
;
bossx = view_width;
;
bosssplat = 0;
;
letterind = 3;
;
if ((TopCont.darkness == 1)) {
light = 1;
}
depth = (- 11);
;
{ var __hm_with7 = scrHMInstances(Player), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
var __hm_other10=scrHMOther(other);
global.hm_camera_targets[index] = __hm_other10;
}
if(__hm_break9) break;
}}
{

}
{ var __hm_with11 = scrHMInstances(Player), __hm_break13=false;
for (var __hm_index12=0; __hm_index12<array_length(__hm_with11); ++__hm_index12) {
if(instance_exists(__hm_with11[__hm_index12])) with (__hm_with11[__hm_index12]) {
{
_x = x;
_y = y;
_mask = mask_index;
;
can_walk = false;
;
can_pick = false;
;
can_spec = false;
;
can_swap = false;
;
can_aim = false;
;
_reload = reload;
;
_breload = breload;
;
reload = 99999;
;
breload = 99999;
;
mask_index = mskNone;
}
}
if(__hm_break13) break;
}}
customheight = argument5;
}
}
if(__hm_break6) break;
}}
}

scrHMBossFreeze104();
}

// Source bosses/bossintros.mod.gml:63; customboss_step
function hm_bosses_bossintros_mod_gml_customboss_step() {scrHMBossStep104();}

// Source bosses/bossintros.mod.gml:284; draw_gui
function hm_bosses_bossintros_mod_gml_draw_gui() {
{ var __hm_with1 = scrHMMatching(CustomObject, "name", "bossintro"), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if ((fadedark == 1)) {
{
if ((bossx > (view_width * 0.33))) {
{
draw_set_alpha(0.7);
;
draw_set_color(c_black);
;
draw_rectangle(0, 0, view_width, view_height, 0);
;
}
}
}
}
if ((bossname != "")) {
{
draw_set_alpha(1);
;
draw_set_color(c_white);
;
scrHMDrawBossLetterbox(letterind);
;

;
scrHMDrawSprite(spr[0], 0, (bossx * 1.10), 0);
;
scrHMDrawSprite(spr[1], 0, bossx, 0);
;
scrHMDrawSprite(spr[2], 0, (bossx * 0.90), 0);
;
if ((bossx > (view_width * 0.33))) {
{
scrHMDrawSprite(sprBossNameSplat, bosssplat, (view_width * 0.50), ((view_height * 0.5) + customheight));
;
}
}
draw_set_font(fntBig);
;
draw_set_halign(1);
;
scrHMDrawText((((view_width * 0.80) - (bossx / 3)) - 64), ((view_height * 0.4) + customheight), (" " + bossname));
;
draw_set_halign(0);
;
}
}
}
}
if(__hm_break3) break;
}}
}

// Source bosses/bossintros.mod.gml:311; boss_death
function hm_bosses_bossintros_mod_gml_boss_death() {
if ((instance_exists(Player) and (! instance_exists(SpiralCont)))) {
hm_bosses_bossintros_mod_gml_boss_trigger("", mskNone, mskNone, mskNone, id, 0);
}
}
