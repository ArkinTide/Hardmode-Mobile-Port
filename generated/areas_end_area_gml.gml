// Source areas/end.area.gml:1; __load
function hm_areas_end_area_gml___load() {

}

// Source areas/end.area.gml:1; area_name
function hm_areas_end_area_gml_area_name() {
return "0-0";
;
}

// Source areas/end.area.gml:4; area_sprite
function hm_areas_end_area_gml_area_sprite(_hml_q) {
switch (_hml_q) {
case sprFloor1:
return sprFloor0;
;
case sprFloor1B:
return sprFloor0;
;
case sprFloor1Explo:
return sprFloor0Explo;
;
case sprWall1Trans:
return sprWall0Trans;
;
case sprWall1Bot:
return sprWall0Bot;
;
case sprWall1Out:
return sprWall0Out;
;
case sprWall1Top:
return sprWall0Top;
;
case sprDebris1:
return sprDebris0;
;
}
}

// Source areas/end.area.gml:16; area_transit
function hm_areas_end_area_gml_area_transit() {
if (((lastarea != scrHMAreaResolve("end")) and (lastarea == scrHMAreaResolve("throne")))) {
{
area = scrHMAreaResolve("end");
;
}
}
}

// Source areas/end.area.gml:22; area_finish
function hm_areas_end_area_gml_area_finish() {
area = scrHMAreaResolve(1);
;
subarea = 1;
;
}

// Source areas/end.area.gml:26; area_setup
function hm_areas_end_area_gml_area_setup() {
scrHMSoundMusic(musCredits);
;
scrHMSoundAmbient(amb0b);
;
goal = 50;
;
background_set_colour(make_color_rgb(106, 122, 175));
;
BackCont.shadow_color = c_black;
;
TopCont.darkness = 0;
;
scrHMSoundStop(sndIDPDPortalSpawn);
;
}

// Source areas/end.area.gml:35; area_start
function hm_areas_end_area_gml_area_start() {
scrHMSoundStop(sndIDPDPortalSpawn);
;
{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
curse = 0;
;
bcurse = 0;
;
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(Floor), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if ((random(7) < 1)) {
{ var __hm_with7 = scrHMInstances(instance_create(x, y, TopDecalNightDesert)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
dir = choose((- 1), 1);
}
if(__hm_break9) break;
}}
}
}
if(__hm_break6) break;
}}
{ var __hm_with10 = scrHMAuthoredWalls105(), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
if ((place_meeting((x + 16), y, Floor) and place_meeting((x + 48), y, Wall))) {
{
{ var __hm_with13 = scrHMInstances(instance_create((x + 16), y, Bones)), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
sprite_index = sprNightBones;
image_xscale = 1;
}
}
if(__hm_break15) break;
}}
{ var __hm_with16 = scrHMInstances(instance_create((x + 48), y, Bones)), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
{
sprite_index = sprNightBones;
image_xscale = (- 1);
}
}
if(__hm_break18) break;
}}
}
}
}
if(__hm_break12) break;
}}
var _hml__floor = instance_furthest(10016, 10016, Floor);
;
{ var __hm_with19 = scrHMMatching(Floor, "name", "fire"), __hm_break21=false;
for (var __hm_index20=0; __hm_index20<array_length(__hm_with19); ++__hm_index20) {
if(instance_exists(__hm_with19[__hm_index20])) with (__hm_with19[__hm_index20]) {
{ var __hm_with22 = scrHMInstances(instance_create((x + 16), (y + 16), Campfire)), __hm_break24=false;
for (var __hm_index23=0; __hm_index23<array_length(__hm_with22); ++__hm_index23) {
if(instance_exists(__hm_with22[__hm_index23])) with (__hm_with22[__hm_index23]) {
{
depth = 0;
mask_index = mskNone;
spr_idle = sprCampfireOff;
spr_shadow = mskNone;
{ var __hm_with25 = scrHMMatchingNE(prop, "object_index", "Campfire"), __hm_break27=false;
for (var __hm_index26=0; __hm_index26<array_length(__hm_with25); ++__hm_index26) {
if(instance_exists(__hm_with25[__hm_index26])) with (__hm_with25[__hm_index26]) {
if ((distance_to_object(Campfire) < 16)) {
scrHMDelete(id);
}
}
if(__hm_break27) break;
}}
scrHMModCall("mod", "props", "leave_create", x, y);
;
{ var __hm_with28 = scrHMInstances(Player), __hm_break30=false;
for (var __hm_index29=0; __hm_index29<array_length(__hm_with28); ++__hm_index29) {
if(instance_exists(__hm_with28[__hm_index29])) with (__hm_with28[__hm_index29]) {
if (((race == 1) and (GameCont.loops == 1))) {
{ var __hm_with31 = scrHMInstances(instance_create((scrHMOther(other)).x, (scrHMOther(other)).y, WepPickup)), __hm_break33=false;
for (var __hm_index32=0; __hm_index32<array_length(__hm_with31); ++__hm_index32) {
if(instance_exists(__hm_with31[__hm_index32])) with (__hm_with31[__hm_index32]) {
{
wep = scrHMWeaponResolve(115);
scrHMMotionAdd(random(360), 6);
}
}
if(__hm_break33) break;
}}
}
}
if(__hm_break30) break;
}}
}
}
if(__hm_break24) break;
}}
}
if(__hm_break21) break;
}}
{ var __hm_with34 = scrHMInstances(instance_create(0, 0, CustomEnemy)), __hm_break36=false;
for (var __hm_index35=0; __hm_index35<array_length(__hm_with34); ++__hm_index35) {
if(instance_exists(__hm_with34[__hm_index35])) with (__hm_with34[__hm_index35]) {
{
name = "portalblocker";
canfly = 1;
}
}
if(__hm_break36) break;
}}
scrHMSpriteRestore(sprBanditBossIdle);
;
scrHMSpriteRestore(sprBanditBossWalk);
;
scrHMSpriteRestore(sprBanditBossFire);
;
scrHMSpriteRestore(sprBanditBossTell);
;
scrHMSpriteRestore(sprBanditBossDash);
;
scrHMSpriteRestore(sprBanditBossStop);
;
scrHMSpriteRestore(sprBanditBossHurt);
;
scrHMSpriteRestore(sprBanditBossDead);
;
scrHMSpriteRestore(sprWeaponChestOpen);
;
scrHMSpriteRestore(sprSpiderIdle);
;
scrHMSpriteRestore(sprSpiderWalk);
;
scrHMSpriteRestore(sprSpiderHurt);
;
scrHMSpriteRestore(sprSpiderDead);
;
scrHMSpriteRestore(sprHyperCrystalIdle);
;
scrHMSpriteRestore(sprHyperCrystalHurt);
;
scrHMSpriteRestore(sprGoldTankIdle);
;
scrHMSpriteRestore(sprGoldTankWalk);
;
scrHMSpriteRestore(sprGoldTankDead);
;
scrHMSpriteRestore(sprGoldTankHurt);
;
scrHMSpriteRestore(sprGoldTankExplode);
;
scrHMSpriteRestore(sprBackFloor);
;
scrHMSpriteRestore(sprBackFloor2);
;
scrHMSpriteRestore(sprBackFloorSmall);
;
scrHMSoundRestore(sndEraser);
scrHMSoundRestore(sndHyperSlugger);
scrHMSoundRestore(sndDoubleFireShotgun);
scrHMSoundRestore(sndDoubleShotgun);
scrHMSoundRestore(sndFireShotgun);
scrHMSoundRestore(sndFlakCannon);
scrHMSoundRestore(sndFlakExplode);
scrHMSoundRestore(sndHeavySlugger);
scrHMSoundRestore(sndSawedOffShotgun);
scrHMSoundRestore(sndShotgun);
scrHMSoundRestore(sndSlugger);
scrHMSoundRestore(sndSuperFlakCannon);
scrHMSoundRestore(sndSuperFlakExplode);
scrHMSoundRestore(sndSuperSlugger);
scrHMSoundRestore(sndUltraShotgun);
scrHMSoundRestore(sndWaveGun);
scrHMSoundRestore(sndBloodLauncherExplo);
scrHMSoundRestore(sndBloodLauncher);
scrHMSoundRestore(sndClusterLauncher);
scrHMSoundRestore(sndFlareExplode);
scrHMSoundRestore(sndFlameCannon);
scrHMSoundRestore(sndFlare);
scrHMSoundRestore(sndGrenade);
scrHMSoundRestore(sndGrenadeRifle);
scrHMSoundRestore(sndHyperLauncher);
scrHMSoundRestore(sndGrenadeShotgun);
scrHMSoundRestore(sndExplosion);
scrHMSoundRestore(sndExplosionS);
scrHMSoundRestore(sndExplosionL);
scrHMSoundRestore(sndExplosionXL);
scrHMSoundRestore(sndExplosionCar);
scrHMSoundRestore(sndNukeExplosion);
scrHMSoundRestore(sndRocket);
scrHMSoundRestore(sndToxicLauncher);
scrHMSoundRestore(sndUltraGrenade);
scrHMSoundRestore(sndJackHammer);
scrHMSoundRestore(sndBloodCannon);
scrHMSoundRestore(sndMeatExplo);
scrHMSoundRestore(sndSuperBazooka);
scrHMSoundRestore(sndHeavyNader);
scrHMSoundRestore(sndGunGun);
scrHMSoundRestore(sndEnergySword);
scrHMSoundRestore(sndEnergyHammer);
scrHMSoundRestore(sndEnergySwordUpg);
scrHMSoundRestore(sndEnergyHammerUpg);
scrHMSoundRestore(sndEnergyScrewdriver);
scrHMSoundRestore(sndEnergyScrewdriverUpg);
scrHMSoundRestore(sndDevastator);
scrHMSoundRestore(sndDevastatorExplo);
scrHMSoundRestore(sndDoubleMinigun);
scrHMSoundRestore(sndBouncerSmg);
scrHMSoundRestore(sndBouncerBounce);
scrHMSoundRestore(sndBouncerShotgun);
scrHMSoundRestore(sndHeavyMachinegun);
scrHMSoundRestore(sndHeavyRevolver);
scrHMSoundRestore(sndHyperRifle);
scrHMSoundRestore(sndMachinegun);
scrHMSoundRestore(sndQuadMachinegun);
scrHMSoundRestore(sndTripleMachinegun);
scrHMSoundRestore(sndIncinerator);
scrHMSoundRestore(sndMinigun);
scrHMSoundRestore(sndPistol);
scrHMSoundRestore(sndFrogPistol);
scrHMSoundRestore(sndPopgun);
scrHMSoundRestore(sndRogueRifle);
scrHMSoundRestore(sndRustyRevolver);
scrHMSoundRestore(sndSmartgun);
scrHMSoundRestore(sndUltraPistol);
scrHMSoundRestore(sndBloodHammer);
scrHMSoundRestore(sndChickenSword);
scrHMSoundRestore(sndBlackSword);
scrHMSoundRestore(sndHammer);
scrHMSoundRestore(sndWrench);
scrHMSoundRestore(sndShovel);
scrHMSoundRestore(sndGuitar);
scrHMSoundRestore(sndUltraShovel);
scrHMSoundRestore(sndScrewdriver);
scrHMSoundRestore(sndSuperDiscGun);
scrHMSoundRestore(sndCrossbow);
scrHMSoundRestore(sndUltraCrossbow);
scrHMSoundRestore(sndDiscgun);
scrHMSoundRestore(sndSeekerPistol);
scrHMSoundRestore(sndSeekerShotgun);
scrHMSoundRestore(sndHeavyCrossbow);
scrHMSoundRestore(sndSplinterGun);
scrHMSoundRestore(sndSplinterPistol);
scrHMSoundRestore(sndSuperSplinterGun);
scrHMSoundRestore(sndToxicBoltGas);
scrHMSoundRestore(sndSuperCrossbow);
scrHMSoundRestore(sndGoldGrenade);
scrHMSoundRestore(sndGoldRocket);
scrHMSoundRestore(sndGoldDiscgun);
scrHMSoundRestore(sndGoldSlugger);
scrHMSoundRestore(sndGoldCrossbow);
scrHMSoundRestore(sndGoldSplinterGun);
scrHMSoundRestore(sndGoldMachinegun);
scrHMSoundRestore(sndGoldFrogPistol);
scrHMSoundRestore(sndGoldPistol);
scrHMSoundRestore(sndGoldWrench);
scrHMSoundRestore(sndGoldScrewdriver);
scrHMSoundRestore(sndPortalAppear);
scrHMSoundRestore(sndPortalOpen);
scrHMSoundRestore(sndSaplingDead);
scrHMSoundRestore(sndAllyDead);
scrHMSoundRestore(sndCorpseExplo);
scrHMSoundRestore(sndCorpseExploDead);
scrHMSoundRestore(sndPlayerDeath);
scrHMSoundRestore(sndChest);
scrHMSoundRestore(sndAmmoChest);
scrHMSoundRestore(sndGoldChest);
scrHMSoundRestore(sndCursedChest);
scrHMSoundRestore(sndHealthChest);
scrHMSoundRestore(sndHealthChestBig);
scrHMSoundRestore(sndWeaponChest);
scrHMSoundRestore(sndBigWeaponChest);
scrHMSoundRestore(sndBigCursedChest);
scrHMSoundRestore(sndEXPChest);
scrHMSoundRestore(sndEnemyDie);
scrHMSoundRestore(sndRadMaggotDie);
scrHMSoundRestore(sndFrogExplode);
scrHMSoundRestore(sndSuperFrogExplode);
scrHMSoundRestore(sndIDPDPortalSpawn);
scrHMSoundRestore(sndRatKingDie);
scrHMSoundRestore(sndRatDie);
scrHMSoundRestore(sndFastRatDie);
scrHMSoundRestore(sndGatorDie);
scrHMSoundRestore(sndBuffGatorDie);
scrHMSoundRestore(sndMutant1Dead);
scrHMSoundRestore(sndMutant2Dead);
scrHMSoundRestore(sndMutant3Dead);
scrHMSoundRestore(sndMutant4Dead);
scrHMSoundRestore(sndMutant5Dead);
scrHMSoundRestore(sndMutant6Dead);
scrHMSoundRestore(sndMutant7Dead);
scrHMSoundRestore(sndMutant8Dead);
scrHMSoundRestore(sndMutant9Dead);
scrHMSoundRestore(sndMutant10Dead);
scrHMSoundRestore(sndMutant11Dead);
scrHMSoundRestore(sndMutant12Dead);
scrHMSoundRestore(sndMutant13Dead);
scrHMSoundRestore(sndMutant14Dead);
scrHMSoundRestore(sndMutant15Dead);
scrHMSoundRestore(sndMutant16Dead);
}

// Source areas/end.area.gml:244; area_make_floor
function hm_areas_end_area_gml_area_make_floor() {
if ((instance_number(Floor) <= 1)) {
{
{ var __hm_with1 = scrHMInstances(instance_create(x, y, Floor)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
name = "fire";
}
}
if(__hm_break3) break;
}}
direction = 0;
{ var __hm_with4 = scrHMInstances(instance_create(x, y, FloorMaker)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
direction = 90;
}
if(__hm_break6) break;
}}
{ var __hm_with7 = scrHMInstances(instance_create(x, y, FloorMaker)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
direction = 180;
}
if(__hm_break9) break;
}}
{ var __hm_with10 = scrHMInstances(instance_create(x, y, FloorMaker)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
direction = 270;
}
if(__hm_break12) break;
}}
}
}
instance_create(x, y, Floor);
;
var _hml_turn = choose(0, 0, 90, 90, (- 90), 90, (- 90), 90, (- 90), 180);
;
direction += _hml_turn;
;
if (((_hml_turn == 180) && (point_distance(x, y, 10016, 10016) > 48))) {
{
instance_create(x, y, Floor);
;
}
}
if ((random(10) < 1)) {
{
instance_create((x + 32), y, Floor);
;
instance_create((x - 32), y, Floor);
;
instance_create(x, (y + 32), Floor);
;
instance_create(x, (y - 32), Floor);
;
}
}
if ((random((19 + instance_number(FloorMaker))) > 22)) {
{
instance_create(x, y, FloorMaker);
;
}
}
}

// Source areas/end.area.gml:273; area_pop_props
function hm_areas_end_area_gml_area_pop_props() {
if ((random(4) < 1)) {
instance_create((x + 16), (y + 16), NightCactus);
}
if ((random(16) < 1)) {
instance_create((x + 16), (y + 16), BonePile);
}
}

// Source areas/end.area.gml:277; area_mapdata
function hm_areas_end_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return [(_hml_lx + 27), 0];
;
}
