// Source bosses/throne.mod.gml:1; __load
function hm_bosses_throne_mod_gml___load() {

}

// Source bosses/throne.mod.gml:5; throne_create
function hm_bosses_throne_mod_gml_throne_create(_hml__x, _hml__y) {
{ var __hm_with1 = scrHMInstances(instance_create(_hml__x, _hml__y, CustomEnemy)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
hitid = [sprNothing2Idle, "THRONE"];
scrHMMaxHealthWrite(id, 1000, "=");
scrHMMaxHealthWrite(id, (600 * (GameCont.loops + 1)), "+=");
scrHMMaxHealthWrite(id, (600 * instance_number(Player)), "+=");
hp = max_hp;
spr_idle = sprNothing2Idle;
snd_hurt = sndNothing2Hurt;
mask_index = mskNothing2;
scrHMSoundMusic(musBoss4B);
{ var __hm_with4 = scrHMInstances(Wall), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
if (place_meeting(x, y, Floor)) {
instance_destroy();
} else {
instance_change(InvisiWall, true);
}
}
}
if(__hm_break6) break;
}}
{ var __hm_with7 = scrHMInstances(TopSmall), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
instance_destroy();
}
if(__hm_break9) break;
}}
{ var __hm_with10 = scrHMInstances(Bones), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
instance_destroy();
}
if(__hm_break12) break;
}}
visible = 1;
image_speed = (0.4) * timescale;
wframes = 0;
canfly = 1;
meleedamage = 10;
on_step = scrHMScriptRef(hm_bosses_throne_mod_gml_Throne2Step);
on_destroy = scrHMScriptRef(hm_bosses_throne_mod_gml_Throne2Destroy);
on_hurt = scrHMScriptRef(hm_bosses_throne_mod_gml_Throne2Hit);
on_draw = scrHMScriptRef(hm_bosses_throne_mod_gml_Throne2Draw);
alrm0 = 1;
alrm1 = (20 + irandom(20));
intro = 0;
speed = (5) * timescale;
friction = (0) * (timescale * timescale);
halfsnd = 0;
dir = 0;
rot = 1;
{ var __hm_with13 = scrHMInstances(enemy), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
if ((spr_idle != sprNothing2Idle)) {
scrHMDelete(id);
}
}
if(__hm_break15) break;
}}
{ var __hm_with16 = scrHMInstances(prop), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
scrHMDelete(id);
}
if(__hm_break18) break;
}}
size = 5;
hm_bosses_throne_mod_gml_move_alarm();
ammo = 0;
firing = 0;
}
}
if(__hm_break3) break;
}}
}

// Source bosses/throne.mod.gml:57; Throne2Step
function hm_bosses_throne_mod_gml_Throne2Step() {
if ((hp < 0)) {
instance_destroy();
}
if ((wframes > 0)) {
wframes -= 1;
}
sprite_index = spr_idle;
if ((alrm0 > (- 1))) {
alrm0 -= 1;
}
if ((alrm0 == 0)) {
hm_bosses_throne_mod_gml_move_alarm();
}
if ((alrm1 > (- 1))) {
alrm1 -= 1;
}
if ((alrm1 == 0)) {
hm_bosses_throne_mod_gml_attack_alarm();
}
if (((hp <= (max_hp / 2)) and (halfsnd == 0))) {
{
scrHMSoundPlay(sndNothing2HalfHP);
halfsnd = 1;
}
}
speed = (5) * timescale;
if ((firing == 1)) {
speed = (2) * timescale;
}
if ((!scrHMVariableExists(id, "dir"))) {
dir = 0;
}
dir += (2 * rot);
if ((dir > 360)) {
dir = 0;
}
if ((dir < 0)) {
dir = 360;
}
}

// Source bosses/throne.mod.gml:114; Throne2Destroy
function hm_bosses_throne_mod_gml_Throne2Destroy() {
scrHMSoundPlay(sndNothing2DeadStart);
scrHMSoundPlay(sndBossWin);
scrHMSoundMusic(musBossDead);
instance_create(x, y, Nothing2Death);
}

// Source bosses/throne.mod.gml:120; Throne2Hit
function hm_bosses_throne_mod_gml_Throne2Hit(_hml_damage) {
hp -= _hml_damage;
scrHMSoundPlay(snd_hurt);
wframes = 4;
nexthurt = (current_frame + 12);
}

// Source bosses/throne.mod.gml:126; Throne2Draw
function hm_bosses_throne_mod_gml_Throne2Draw() {
if ((wframes > 0)) {
gpu_set_fog(true, c_white, 0, 0);
}
scrHMDrawSprite(sprite_index, image_index, x, y);
gpu_set_fog(false, c_white, 0, 0);
draw_set_color(c_black);
{ var __hm_with1 = scrHMInstances(Throne2Ball), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMDrawTextPlain(x, y, string(timeout));
}
if(__hm_break3) break;
}}
draw_set_color(c_white);
}

// Source bosses/throne.mod.gml:139; move_alarm
function hm_bosses_throne_mod_gml_move_alarm() {
if (instance_exists(Player)) {
{
var _hml_t = undefined;
var _hml_tx = undefined;
var _hml_ty = undefined;
var _hml_td = undefined;
;
_hml_t = Player;
_hml_td = point_direction(x, y, _hml_t.x, _hml_t.y);
direction = (_hml_td + 45);
alrm0 = (25 + irandom(15));
if ((random(300) < 1)) {
rot *= (- 1);
}
}
}
}

// Source bosses/throne.mod.gml:152; attack_alarm
function hm_bosses_throne_mod_gml_attack_alarm() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_bosses_throne_mod_gml_attack_alarm_resume, id, scrHMOther(other), _args, 18, []);
}
function hm_bosses_throne_mod_gml_attack_alarm_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_bosses_throne_mod_gml_attack_alarm");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // bosses/throne.mod.gml:206
{
if (instance_exists(id)) {
alrm1 = (80 + irandom(30));
}
}
_hm.pc=0;
break;
case 3: // bosses/throne.mod.gml:193
_hm.vars.__hm_repeat1--; _hm.pc=2;
break;
case 4: // bosses/throne.mod.gml:204
_hm.wait_ticks=max(0,8); _hm.pc=3; return;
break;
case 5: // bosses/throne.mod.gml:196
{
target = instance_nearest(x, y, Player);
gunangle = point_direction(x, y, target.x, target.y);
{ var __hm_with2 = scrHMInstances(instance_create(x, y, BigGuardianBullet)), __hm_break4=false;
for (var __hm_index3=0; __hm_index3<array_length(__hm_with2); ++__hm_index3) {
if(instance_exists(__hm_with2[__hm_index3])) with (__hm_with2[__hm_index3]) {
{
var __hm_other5=scrHMOther(other);
team = __hm_other5.team;
var __hm_other6=scrHMOther(other);
scrHMMotionAdd(((__hm_other6.gunangle - 80) + irandom(160)), (4 + irandom(3)));
scrHMSoundPlay(sndBigBallFire);
}
}
if(__hm_break4) break;
}}
}
_hm.pc=4;
break;
case 6: // bosses/throne.mod.gml:194
_hm.pc = (instance_exists(Player)) ? 5 : 3;
break;
case 2: // bosses/throne.mod.gml:193
_hm.pc=(_hm.vars.__hm_repeat1>0)?6:1;
break;
case 7: // bosses/throne.mod.gml:193
_hm.vars.__hm_repeat1=round((2 + GameCont.loops)); _hm.pc=2;
break;
case 8: // bosses/throne.mod.gml:191
_hm.pc = ((atk == 2)) ? 7 : 0;
break;
case 9: // bosses/throne.mod.gml:188
{
firing = 0;
alrm1 = (80 + irandom(30));
}
_hm.pc=8;
break;
case 11: // bosses/throne.mod.gml:175
_hm.vars.__hm_repeat7--; _hm.pc=10;
break;
case 12: // bosses/throne.mod.gml:186
_hm.wait_ticks=max(0,1); _hm.pc=11; return;
break;
case 13: // bosses/throne.mod.gml:177
{
for (_hm.vars.i = 0; (_hm.vars.i < 10); _hm.vars.i++) {
{ var __hm_with8 = scrHMInstances(instance_create(x, y, GuardianBullet)), __hm_break10=false;
for (var __hm_index9=0; __hm_index9<array_length(__hm_with8); ++__hm_index9) {
if(instance_exists(__hm_with8[__hm_index9])) with (__hm_with8[__hm_index9]) {
{
scrHMMotionAdd((_hm.vars.i * (360 / 10)), 6);
var __hm_other11=scrHMOther(other);
team = __hm_other11.team;
}
}
if(__hm_break10) break;
}}
}
firing = 1;
}
_hm.pc=12;
break;
case 10: // bosses/throne.mod.gml:175
_hm.pc=(_hm.vars.__hm_repeat7>0)?13:9;
break;
case 14: // bosses/throne.mod.gml:175
_hm.vars.__hm_repeat7=round((15 + (15 * GameCont.loops))); _hm.pc=10;
break;
case 15: // bosses/throne.mod.gml:174
{
scrHMSoundPlay(sndUltraLaser);
}
_hm.pc=14;
break;
case 16: // bosses/throne.mod.gml:172
_hm.pc = ((atk == 1)) ? 15 : 8;
break;
case 17: // bosses/throne.mod.gml:154
{
if ((ammo == 0)) {
atk = choose(0, 1, 2);
}
if ((atk == 0)) {
{
repeat ((4 + GameCont.loops)) {
target = instance_nearest(x, y, Player);
gunangle = point_direction(x, y, target.x, target.y);
{ var __hm_with12 = scrHMInstances(instance_create(x, y, Throne2Ball)), __hm_break14=false;
for (var __hm_index13=0; __hm_index13<array_length(__hm_with12); ++__hm_index13) {
if(instance_exists(__hm_with12[__hm_index13])) with (__hm_with12[__hm_index13]) {
{
var __hm_other15=scrHMOther(other);
team = __hm_other15.team;
var __hm_other16=scrHMOther(other);
scrHMMotionAdd(((__hm_other16.gunangle - 80) + irandom(160)), (6 + irandom(4)));
}
}
if(__hm_break14) break;
}}
}
scrHMSoundPlay(sndNothing2Ball);
alrm1 = (80 + irandom(30));
}
}
}
_hm.pc=16;
break;
case 18: // bosses/throne.mod.gml:153
_hm.pc = (instance_exists(Player)) ? 17 : 0;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source bosses/throne.mod.gml:210; Throne2Platform
function hm_bosses_throne_mod_gml_Throne2Platform() {
{ var __hm_with1 = scrHMInstances(Floor), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if ((object_index != FloorExplo)) {
{
scrHMDrawSprite(sprBackFloor2, image_index, x, y);
scrHMDrawSprite(sprBackFloor, image_index, x, y);
}
} else {
scrHMDrawSprite(sprBackFloorSmall, image_index, x, y);
}
}
}
if(__hm_break3) break;
}}
}
