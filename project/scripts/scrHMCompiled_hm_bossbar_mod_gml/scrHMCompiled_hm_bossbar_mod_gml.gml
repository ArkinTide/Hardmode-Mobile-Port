// Source hm_bossbar.mod.gml:0; __load (native content 1.1.0)
function hm_hm_bossbar_mod_gml___load() {

}

// Source hm_bossbar.mod.gml:0; draw (native content 1.1.0)
function hm_hm_bossbar_mod_gml_draw() {
// Boss bars are rendered once in HMWorld GUI End.
}

// Source hm_bossbar.mod.gml:0; draw_gui (native content 1.1.0)
function hm_hm_bossbar_mod_gml_draw_gui() {
// Deferred until GUI End, after world art and darkness.
}

// Source hm_bossbar.mod.gml:0; hm_extra_boss_name (native content 1.1.0)
function hm_hm_bossbar_mod_gml_hm_extra_boss_name() {
switch (hm_extra_kind) {
case "bandit":
return "BIG BANDIT";
;
case "junglebandit":
return "BIG BANDIT";
;
case "bubble":
return "BIG BUBBLER";
;
case "hunter":
return "LIL' HUNTER";
;
case "mom":
return "MOM";
;
case "crystal":
return "HYPER CRYSTAL";
;
case "cursedcrystal":
return "CURSED HYPER CRYSTAL";
;
case "tech":
return "TECHNOMANCER";
;
case "dog":
return "BIG DOG";
;
case "gator":
return "SUPER GATOR";
;
case "bird":
return "BIG BIRD";
;
case "turtle":
if (scrHMVariableExists(id, "name")) {
{
var _hml_title = hm_hm_bossbar_mod_gml_hm_custom_boss_name();
;
if ((_hml_title != "")) {
return _hml_title;
}
}
}
return "TURTLE";
;
case "rogue":
return "The Messenger";
;
case "rat":
return "BIG RAT";
;
}
return "";
;
}

// Source hm_bossbar.mod.gml:0; hm_custom_boss_name (native content 1.1.0)
function hm_hm_bossbar_mod_gml_hm_custom_boss_name() {
switch (name) {
case "roguefreak": return "The Messenger";
case "hm_palace_guardian": return "CROWN GUARDIAN";
case "scorpionboss":
return "GIANT SCORPION";
;
case "gatorboss":
return "SUPER GATOR";
;
case "BIG BIRD":
return "BIG BIRD";
;
case "ratboss":
return "BIG RAT";
;
case "turtle1":
return "LEONARDO";
;
case "turtle2":
return "RAPHAEL";
;
case "turtle3":
return "MICHELANGELO";
;
case "turtle4":
return "DONATELLO";
;
case "titank":
return "TITANK";
;
case "guardianboss":
return "GREAT GUARDIAN";
;
case "rogueboss":
return "The Messenger";
;
case "hm_yv_phase":
return "Y.V";
;
case "IDPDTank":
return "IDPD TANK";
;
case "GunGod":

case "gungod":
return "DA GUN GOD";
;
}
return "";
;
}

// Source hm_bossbar.mod.gml:0; hm_bossbar (native content 1.1.0)
function hm_hm_bossbar_mod_gml_hm_bossbar(_hml__x, _hml__y, _hml__width, _hml__text, _hml__color, _hml__hp, _hml__max) {
if (((_hml__hp <= 0) || (_hml__max <= 0))) {
exit;
}
var _hml_color = draw_get_color();
var _hml_alpha = draw_get_alpha();
var _hml_ha = draw_get_halign();
var _hml_va = draw_get_valign();
;
var _hml_left = floor((_hml__x - (_hml__width / 2)));
var _hml_top = ceil(_hml__y);
var _hml_ratio = clamp((_hml__hp / _hml__max), 0, 1);
;
draw_set_alpha(1);
;
draw_set_font(fntM1);
;
draw_set_halign(fa_center);
;
draw_set_valign(fa_top);
;
draw_set_color(c_white);
;
scrHMBossTitle1101((_hml_left + (_hml__width / 2)), _hml_top, _hml__width, _hml__text);
;
draw_set_color(c_black);
;
draw_rectangle((_hml_left - 1), (_hml_top - 1), ((_hml_left + _hml__width) + 1), (_hml_top + 11), false);
;
draw_set_color(_hml__color);
;
draw_rectangle(_hml_left, _hml_top, (_hml_left + (_hml_ratio * _hml__width)), (_hml_top + 10), false);
;
draw_set_color(c_white);
;
draw_rectangle(_hml_left, _hml_top, (_hml_left + _hml__width), (_hml_top + 10), true);
;
scrHMDrawText((_hml_left + (_hml__width / 2)), (_hml_top + 1), ((string(ceil(_hml__hp)) + "/") + string(ceil(_hml__max))));
;
draw_set_color(_hml_color);
;
draw_set_alpha(_hml_alpha);
;
draw_set_halign(_hml_ha);
;
draw_set_valign(_hml_va);
;
draw_set_font(fntM1);
;
}
function scrHMBossBarsLocal1104() {
if (((! hm_arkintide_mod_gml_hm_addon_enabled("bossbars")) || (! instance_exists(Player)))) {
exit;
}
{ var __hm_with1 = scrHMInstances(BanditBoss), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMBossWorldBar1104(x, (y - 36), 100, "BIG BANDIT", c_red, hp, max_hp);
}
if(__hm_break3) break;
}}
;
{ var __hm_with4 = scrHMInstances(ScrapBoss), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
scrHMBossWorldBar1104(x, (y - 36), 100, "BIG DOG", c_red, hp, max_hp);
}
if(__hm_break6) break;
}}
;
{ var __hm_with7 = scrHMInstances(LilHunter), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
scrHMBossWorldBar1104(x, (y - 36), 80, "LIL' HUNTER", c_red, hp, max_hp);
}
if(__hm_break9) break;
}}
;
{ var __hm_with10 = scrHMInstances(BigGenerator), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
scrHMBossWorldBar1104(x, (y - 40), 80, "GENERATOR", c_lime, hp, max_hp);
}
if(__hm_break12) break;
}}
;
{ var __hm_with13 = scrHMInstances(FrogQueen), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
scrHMBossWorldBar1104(x, (y - 36), 100, "MOM", c_red, hp, max_hp);
}
if(__hm_break15) break;
}}
;
{ var __hm_with16 = scrHMInstances(TechnoMancer), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
scrHMBossWorldBar1104(x, (y - 60), 100, "TECHNOMANCER", c_red, hp, max_hp);
}
if(__hm_break18) break;
}}
;
{ var __hm_with19 = scrHMInstances(OasisBoss), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
scrHMBossWorldBar1104(x, (y - 36), 100, "BIG BUBBLER", c_red, hp, max_hp);
}
if(__hm_break21) break;
}}
;
{ var __hm_with22 = scrHMInstances(CrownGuardian), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
scrHMBossWorldBar1104(x, (y - 36), 100, "CROWN GUARDIAN", c_red, hp, max_hp);
}
if(__hm_break24) break;
}}
;
{ var __hm_with25 = scrHMInstances(HyperCrystal), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
{
var _hml_title = "HYPER CRYSTAL";
var _hml_color = c_orange;
;
if (((GameCont.area == scrHMAreaResolve(104)) || (GameCont.area == scrHMAreaResolve("cavesinv")))) {
{
_hml_title = "CURSED HYPER CRYSTAL";
;
_hml_color = c_purple;
;
}
}
scrHMBossWorldBar1104(x, (y - 70), 120, _hml_title, _hml_color, hp, max_hp);
;
}
}
if(__hm_break27) break;
}}
{ var __hm_with28 = scrHMInstances(CustomEnemy), __hm_break30=false;
for (var __hm_index29=0; __hm_index29<array_length(__hm_with28); ++__hm_index29) {
if(instance_exists(__hm_with28[__hm_index29])) with (__hm_with28[__hm_index29]) {
{
if ((scrHMVariableExists(id, "hm_extra") && hm_extra)) {
{
if ((((hp <= 0) || (team == 2)) || (!scrHMVariableExists(id, "hm_extra_kind")))) {
continue;
}
var _hml_title = hm_hm_bossbar_mod_gml_hm_extra_boss_name();
;
if ((_hml_title == "")) {
continue;
}
var _hml_py = (y - 48);
;
if (scrHMVariableExists(id, "z")) {
_hml_py -= max(0, z);
}
scrHMBossWorldBar1104(x, _hml_py, 80, _hml_title, c_red, hp, max_hp);
;
}
} else {
{
if ((((hp <= 0) || (team == 2)) || (!scrHMVariableExists(id, "name")))) {
continue;
}
var _hml_title = hm_hm_bossbar_mod_gml_hm_custom_boss_name();
;
if (((_hml_title == "") || scrHMBossTop1104())) {
continue;
}
var _hml_hp = hp;
var _hml_capacity = max_hp;
var _hml_py = (y - 40);
;
if ((name == "titank")) {
{
_hml_hp = 0;
;
_hml_capacity = (150 * legs)*scrHMBossLoopFactor1103();
;
for (var _hml_leg = 0; (_hml_leg < legs); _hml_leg++) _hml_hp += max(0, foot_hp[_hml_leg]);
;
_hml_py = ((y - z) - 60);
;
}
}
if ((name == "GunGod")) {
{
if ((hp > max_hp)) {
continue;
}
_hml_hp = max(0, (hp - 14250));
;
_hml_capacity = max(1,max_hp-14250);
;
_hml_py = ((y - z) - 50);
;
}
}
scrHMBossWorldBar1104(x, _hml_py, 110, _hml_title, c_red, _hml_hp, _hml_capacity);
;
}
}
}
}
if(__hm_break30) break;
}}
}

function scrHMBossBarsTop1104() {
if (((! hm_arkintide_mod_gml_hm_addon_enabled("bossbars")) || (! instance_exists(Player)))) {
exit;
}
var _hml_row = 0;
;
{ var __hm_with1 = scrHMInstances(Nothing2), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (((((hp > 0) && (image_alpha > 0)) && (mask_index != 0)) && (mask_index != mskNone))) {
{
hm_hm_bossbar_mod_gml_hm_bossbar((view_width / 2), (20 + (_hml_row * 26)), 160, "THRONE II", c_lime, hp, max_hp);
;
_hml_row++;
;
}
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(Last), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if ((hp > 0)) {
{
hm_hm_bossbar_mod_gml_hm_bossbar((view_width / 2), (20 + (_hml_row * 26)), 160, "CAPTAIN", c_blue, hp, max_hp);
;
_hml_row++;
;
}
}
}
if(__hm_break6) break;
}}
{ var __hm_with7 = scrHMInstances(CustomEnemy), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
if ((((! (scrHMVariableExists(id, "hm_extra") && hm_extra)) && (spr_idle == sprNothing2Idle)) && (hp > 0))) {
{
hm_hm_bossbar_mod_gml_hm_bossbar((view_width / 2), (20 + (_hml_row * 26)), 160, "THRONE II", c_lime, hp, max_hp);
;
_hml_row++;
;
}
}
}
if(__hm_break9) break;
}}
{ var __hm_with13 = scrHMInstances(Nothing), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
if (scrHMThroneBarVisible1103()) {
{
hm_hm_bossbar_mod_gml_hm_bossbar((view_width / 2), (20 + (_hml_row * 26)), 160, "THE NUCLEAR THRONE", c_lime, hp, max_hp);
;
_hml_row++;
;
}
}
}
if(__hm_break15) break;
}}
{ var __hm_with16 = scrHMInstances(YVBoss), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
if ((hp > 0)) {
{
hm_hm_bossbar_mod_gml_hm_bossbar((view_width / 2), (20 + (_hml_row * 26)), 160, "Y.V", c_yellow, hp, max_hp);
;
_hml_row++;
;
}
}
}
if(__hm_break18) break;
}}
{ var __hm_with19 = scrHMInstances(CustomEnemy), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
if (((((! (scrHMVariableExists(id, "hm_extra") && hm_extra)) && (hp > 0)) && scrHMVariableExists(id, "name")) && scrHMBossTop1104())) {
{
var _hml_title = hm_hm_bossbar_mod_gml_hm_custom_boss_name();
var _hml_hp = hp;
var _hml_capacity = max_hp;
;
if ((name == "titank")) {
{
_hml_hp = 0;
;
_hml_capacity = (150 * legs)*scrHMBossLoopFactor1103();
;
for (var _hml_leg = 0; (_hml_leg < legs); _hml_leg++) _hml_hp += max(0, foot_hp[_hml_leg]);
;
}
}
if ((name == "GunGod")) {
{
if (hm_gungod_departed) {
continue;
}
_hml_hp = max(0, (hp - 14250));
;
_hml_capacity = max(1,max_hp-14250);
;
}
}
hm_hm_bossbar_mod_gml_hm_bossbar((view_width / 2), (20 + (_hml_row * 26)), 160, _hml_title, c_red, _hml_hp, _hml_capacity);
;
_hml_row++;
;
}
}
}
if(__hm_break21) break;
}}
}
