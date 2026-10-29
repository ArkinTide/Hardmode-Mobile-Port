// Source areas/oasis.area.gml:1; __load
function hm_areas_oasis_area_gml___load() {
global.hm_module_vars[$ "area:oasis"].BoneFish1Fire = sprHM_areas_oasis_area_2;
global.hm_module_vars[$ "area:oasis"].BoneFish2Fire = sprHM_areas_oasis_area_3;
global.hm_module_vars[$ "area:oasis"].BoneFish3Fire = sprHM_areas_oasis_area_4;
global.hm_module_vars[$ "area:oasis"].BoneFish4Fire = sprHM_areas_oasis_area_5;
global.hm_module_vars[$ "area:oasis"].BoneFish2Idle = sprHM_areas_oasis_area_6;
global.hm_module_vars[$ "area:oasis"].BoneFish3Idle = sprHM_areas_oasis_area_7;
global.hm_module_vars[$ "area:oasis"].BoneFish4Idle = sprHM_areas_oasis_area_8;
global.hm_module_vars[$ "area:oasis"].BoneFish2Walk = sprHM_areas_oasis_area_9;
global.hm_module_vars[$ "area:oasis"].BoneFish3Walk = sprHM_areas_oasis_area_10;
global.hm_module_vars[$ "area:oasis"].BoneFish4Walk = sprHM_areas_oasis_area_11;
global.hm_module_vars[$ "area:oasis"].BoneFish2Hurt = sprHM_areas_oasis_area_12;
global.hm_module_vars[$ "area:oasis"].BoneFish3Hurt = sprHM_areas_oasis_area_13;
global.hm_module_vars[$ "area:oasis"].BoneFish4Hurt = sprHM_areas_oasis_area_14;
global.hm_module_vars[$ "area:oasis"].BoneFish2Dead = sprHM_areas_oasis_area_15;
global.hm_module_vars[$ "area:oasis"].BoneFish3Dead = sprHM_areas_oasis_area_16;
global.hm_module_vars[$ "area:oasis"].BoneFish4Dead = sprHM_areas_oasis_area_17;
global.hm_module_vars[$ "area:oasis"].crabdead = sprHM_areas_oasis_area_18;
global.hm_module_vars[$ "area:oasis"].toxicfog = sprHM_areas_oasis_area_20;
}

// Source areas/oasis.area.gml:22; area_name
function hm_areas_oasis_area_gml_area_name() {
return ("?-" + string(GameCont.subarea));
;
}

// Source areas/oasis.area.gml:25; area_sprite
function hm_areas_oasis_area_gml_area_sprite(_hml_q) {
if ((GameCont.subarea <= 4)) {
{
switch (_hml_q) {
case sprFloor1:
return sprFloor101;
;
case sprFloor1B:
return sprFloor101B;
;
case sprFloor1Explo:
return sprFloor101Explo;
;
case sprWall1Trans:
return sprWall101Trans;
;
case sprWall1Bot:
return sprWall101Bot;
;
case sprWall1Out:
return sprWall101Out;
;
case sprWall1Top:
return sprWall101Top;
;
case sprDebris1:
return sprDebris101;
;
case sprDetail1:
return sprDetail101;
;
}
}
} else {
{
switch (_hml_q) {
case sprFloor1:
return sprFloor101B;
;
case sprFloor1B:
return sprFloor2;
;
case sprFloor1Explo:
return sprFloor2Explo;
;
case sprWall1Trans:
return sprWall2Trans;
;
case sprWall1Bot:
return sprWall2Bot;
;
case sprWall1Out:
return sprWall2Out;
;
case sprWall1Top:
return sprWall2Top;
;
case sprDebris1:
return sprDebris2;
;
case sprDetail1:
return sprDetail1;
;
}
}
}
}

// Source areas/oasis.area.gml:54; area_transit
function hm_areas_oasis_area_gml_area_transit() {
if ((((lastarea != scrHMAreaResolve("oasis")) and (area == scrHMAreaResolve(101))) and (lastarea == scrHMAreaResolve(1)))) {
{
area = scrHMAreaResolve("oasis");
;
subarea = 1;
}
}
}

// Source areas/oasis.area.gml:60; area_finish
function hm_areas_oasis_area_gml_area_finish() {
if ((GameCont.subarea < 5)) {
{
area = scrHMAreaResolve("oasis");
;
subarea += 1;
}
} else {
{
area = scrHMAreaResolve("sewers");
subarea = 3;
scrHMSpriteRestore(sprWeaponChestOpen);
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
}
}

// Source areas/oasis.area.gml:215; area_setup
function hm_areas_oasis_area_gml_area_setup() {
if ((GameCont.subarea < 4)) {
scrHMSoundMusic(mus101);
} else {
scrHMSoundMusic(musBoss5);
}
scrHMSoundAmbient(amb101);
goal = 110;
;
if ((GameCont.subarea == 4)) {
{
background_set_colour(make_color_rgb(81, 209, 200));
;
{ var __hm_with1 = scrHMInstances(TopCont), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
fog = global.hm_module_vars[$ "area:oasis"].toxicfog;
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(BackCont), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
shadow_color = 4401921;
}
if(__hm_break6) break;
}}
}
} else {
if ((GameCont.subarea == 5)) {
{
background_set_colour(make_color_rgb(76, 89, 70));
;
{ var __hm_with7 = scrHMInstances(TopCont), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
fog = global.hm_module_vars[$ "area:oasis"].toxicfog;
{ var __hm_with10 = scrHMInstances(BackCont), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
shadow_color = c_black;
}
if(__hm_break12) break;
}}
}
}
if(__hm_break9) break;
}}
}
} else {
{
background_set_colour(make_color_rgb(81, 209, 200));
;
{ var __hm_with13 = scrHMInstances(BackCont), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
shadow_color = 4401921;
}
if(__hm_break15) break;
}}
}
}
}
{ var __hm_with16 = scrHMInstances(TopCont), __hm_break18=false;
for (var __hm_index17=0; __hm_index17<array_length(__hm_with16); ++__hm_index17) {
if(instance_exists(__hm_with16[__hm_index17])) with (__hm_with16[__hm_index17]) {
{
noblood = 1;
}
}
if(__hm_break18) break;
}}
scrHMSpriteReplace(sprWeaponChestOpen, sprHM_areas_oasis_area_248);
scrHMSoundAssign(sndEraser, sndOasisShoot);
scrHMSoundAssign(sndHyperSlugger, sndOasisShoot);
scrHMSoundAssign(sndDoubleFireShotgun, sndOasisShoot);
scrHMSoundAssign(sndDoubleShotgun, sndOasisShoot);
scrHMSoundAssign(sndFireShotgun, sndOasisShoot);
scrHMSoundAssign(sndFlakCannon, sndOasisShoot);
scrHMSoundAssign(sndFlakExplode, sndOasisExplosionSmall);
scrHMSoundAssign(sndHeavySlugger, sndOasisShoot);
scrHMSoundAssign(sndSawedOffShotgun, sndOasisShoot);
scrHMSoundAssign(sndShotgun, sndOasisShoot);
scrHMSoundAssign(sndSlugger, sndOasisShoot);
scrHMSoundAssign(sndSuperFlakCannon, sndOasisShoot);
scrHMSoundAssign(sndSuperFlakExplode, sndOasisExplosion);
scrHMSoundAssign(sndSuperSlugger, sndOasisShoot);
scrHMSoundAssign(sndUltraShotgun, sndOasisShoot);
scrHMSoundAssign(sndWaveGun, sndOasisShoot);
scrHMSoundAssign(sndBloodLauncherExplo, sndOasisExplosion);
scrHMSoundAssign(sndBloodLauncher, sndOasisShoot);
scrHMSoundAssign(sndClusterLauncher, sndOasisShoot);
scrHMSoundAssign(sndFlareExplode, sndOasisExplosionSmall);
scrHMSoundAssign(sndFlameCannon, sndOasisShoot);
scrHMSoundAssign(sndFlare, sndOasisShoot);
scrHMSoundAssign(sndGrenade, sndOasisShoot);
scrHMSoundAssign(sndGrenadeRifle, sndOasisShoot);
scrHMSoundAssign(sndHyperLauncher, sndOasisShoot);
scrHMSoundAssign(sndGrenadeShotgun, sndOasisShoot);
scrHMSoundAssign(sndExplosion, sndOasisExplosion);
scrHMSoundAssign(sndExplosionS, sndOasisExplosionSmall);
scrHMSoundAssign(sndExplosionL, sndOasisExplosion);
scrHMSoundAssign(sndExplosionXL, sndOasisExplosion);
scrHMSoundAssign(sndExplosionCar, sndOasisExplosion);
scrHMSoundAssign(sndNukeExplosion, sndOasisExplosion);
scrHMSoundAssign(sndRocket, sndOasisShoot);
scrHMSoundAssign(sndToxicLauncher, sndOasisShoot);
scrHMSoundAssign(sndUltraGrenade, sndOasisShoot);
scrHMSoundAssign(sndJackHammer, sndOasisMelee);
scrHMSoundAssign(sndBloodCannon, sndOasisShoot);
scrHMSoundAssign(sndMeatExplo, sndOasisExplosionSmall);
scrHMSoundAssign(sndSuperBazooka, sndOasisShoot);
scrHMSoundAssign(sndHeavyNader, sndOasisShoot);
scrHMSoundAssign(sndGunGun, sndOasisShoot);
scrHMSoundAssign(sndEnergySword, sndOasisMelee);
scrHMSoundAssign(sndEnergyHammer, sndOasisMelee);
scrHMSoundAssign(sndEnergySwordUpg, sndOasisMelee);
scrHMSoundAssign(sndEnergyHammerUpg, sndOasisMelee);
scrHMSoundAssign(sndEnergyScrewdriver, sndOasisMelee);
scrHMSoundAssign(sndEnergyScrewdriverUpg, sndOasisMelee);
scrHMSoundAssign(sndDevastator, sndOasisShoot);
scrHMSoundAssign(sndDevastatorExplo, sndOasisExplosion);
scrHMSoundAssign(sndDoubleMinigun, sndOasisShoot);
scrHMSoundAssign(sndBouncerSmg, sndOasisShoot);
scrHMSoundAssign(sndBouncerBounce, sndOasisShoot);
scrHMSoundAssign(sndBouncerShotgun, sndOasisShoot);
scrHMSoundAssign(sndHeavyMachinegun, sndOasisShoot);
scrHMSoundAssign(sndHeavyRevolver, sndOasisShoot);
scrHMSoundAssign(sndHyperRifle, sndOasisShoot);
scrHMSoundAssign(sndMachinegun, sndOasisShoot);
scrHMSoundAssign(sndQuadMachinegun, sndOasisShoot);
scrHMSoundAssign(sndTripleMachinegun, sndOasisShoot);
scrHMSoundAssign(sndIncinerator, sndOasisShoot);
scrHMSoundAssign(sndMinigun, sndOasisShoot);
scrHMSoundAssign(sndPistol, sndOasisShoot);
scrHMSoundAssign(sndFrogPistol, sndOasisCrabAttack);
scrHMSoundAssign(sndPopgun, sndOasisShoot);
scrHMSoundAssign(sndRogueRifle, sndOasisShoot);
scrHMSoundAssign(sndRustyRevolver, sndOasisShoot);
scrHMSoundAssign(sndSmartgun, sndOasisShoot);
scrHMSoundAssign(sndUltraPistol, sndOasisShoot);
scrHMSoundAssign(sndBloodHammer, sndOasisMelee);
scrHMSoundAssign(sndChickenSword, sndOasisMelee);
scrHMSoundAssign(sndBlackSword, sndOasisMelee);
scrHMSoundAssign(sndHammer, sndOasisMelee);
scrHMSoundAssign(sndWrench, sndOasisMelee);
scrHMSoundAssign(sndShovel, sndOasisMelee);
scrHMSoundAssign(sndGuitar, sndOasisMelee);
scrHMSoundAssign(sndUltraShovel, sndOasisMelee);
scrHMSoundAssign(sndScrewdriver, sndOasisMelee);
scrHMSoundAssign(sndSuperDiscGun, sndOasisShoot);
scrHMSoundAssign(sndCrossbow, sndOasisShoot);
scrHMSoundAssign(sndUltraCrossbow, sndOasisShoot);
scrHMSoundAssign(sndDiscgun, sndOasisShoot);
scrHMSoundAssign(sndSeekerPistol, sndOasisShoot);
scrHMSoundAssign(sndSeekerShotgun, sndOasisShoot);
scrHMSoundAssign(sndHeavyCrossbow, sndOasisShoot);
scrHMSoundAssign(sndSplinterGun, sndOasisShoot);
scrHMSoundAssign(sndSplinterPistol, sndOasisShoot);
scrHMSoundAssign(sndSuperSplinterGun, sndOasisShoot);
scrHMSoundAssign(sndToxicBoltGas, sndOasisShoot);
scrHMSoundAssign(sndSuperCrossbow, sndOasisShoot);
scrHMSoundAssign(sndGoldGrenade, sndOasisShoot);
scrHMSoundAssign(sndGoldRocket, sndOasisShoot);
scrHMSoundAssign(sndGoldDiscgun, sndOasisShoot);
scrHMSoundAssign(sndGoldSlugger, sndOasisShoot);
scrHMSoundAssign(sndGoldCrossbow, sndOasisShoot);
scrHMSoundAssign(sndGoldSplinterGun, sndOasisShoot);
scrHMSoundAssign(sndGoldMachinegun, sndOasisShoot);
scrHMSoundAssign(sndGoldFrogPistol, sndOasisCrabAttack);
scrHMSoundAssign(sndGoldPistol, sndOasisShoot);
scrHMSoundAssign(sndGoldWrench, sndOasisShoot);
scrHMSoundAssign(sndGoldScrewdriver, sndOasisMelee);
scrHMSoundAssign(sndPortalAppear, sndOasisPortal);
scrHMSoundAssign(sndPortalOpen, sndOasisPortal);
scrHMSoundAssign(sndSaplingDead, sndOasisDeath);
scrHMSoundAssign(sndAllyDead, sndOasisDeath);
scrHMSoundAssign(sndCorpseExplo, sndOasisExplosion);
scrHMSoundAssign(sndCorpseExploDead, sndOasisDeath);
scrHMSoundAssign(sndPlayerDeath, sndOasisDeath);
scrHMSoundAssign(sndChest, sndOasisChest);
scrHMSoundAssign(sndAmmoChest, sndOasisChest);
scrHMSoundAssign(sndGoldChest, sndOasisChest);
scrHMSoundAssign(sndCursedChest, sndOasisChest);
scrHMSoundAssign(sndHealthChest, sndOasisChest);
scrHMSoundAssign(sndHealthChestBig, sndOasisChest);
scrHMSoundAssign(sndWeaponChest, sndOasisChest);
scrHMSoundAssign(sndBigWeaponChest, sndOasisChest);
scrHMSoundAssign(sndBigCursedChest, sndOasisDeath);
scrHMSoundAssign(sndEXPChest, sndOasisChest);
scrHMSoundAssign(sndEnemyDie, sndOasisDeath);
scrHMSoundAssign(sndRadMaggotDie, sndOasisDeath);
scrHMSoundAssign(sndFrogExplode, sndOasisExplosionSmall);
scrHMSoundAssign(sndSuperFrogExplode, sndOasisExplosion);
scrHMSoundAssign(sndIDPDPortalSpawn, sndOasisPopo);
scrHMSoundAssign(sndRatKingDie, sndOasisDeath);
scrHMSoundAssign(sndRatDie, sndOasisDeath);
scrHMSoundAssign(sndFastRatDie, sndOasisDeath);
scrHMSoundAssign(sndGatorDie, sndOasisDeath);
scrHMSoundAssign(sndBuffGatorDie, sndOasisDeath);
scrHMSoundAssign(sndMutant1Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant2Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant3Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant4Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant5Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant6Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant7Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant8Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant9Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant10Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant11Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant12Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant13Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant14Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant15Dead, sndOasisDeath);
scrHMSoundAssign(sndMutant16Dead, sndOasisDeath);

with(TopCont) darkness=0;
}

// Source areas/oasis.area.gml:394; area_start
function hm_areas_oasis_area_gml_area_start() {
{ var __hm_with1 = scrHMAuthoredWalls105(), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if ((random(10) < 1)) {
{
if (place_meeting((x + 16), y, Floor)) {
{ var __hm_with4 = scrHMInstances(instance_create((x + 16), y, Bones)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
sprite_index = sprCoral;
image_xscale = 1;
}
}
if(__hm_break6) break;
}}
} else {
if (place_meeting((x - 16), y, Floor)) {
{ var __hm_with7 = scrHMInstances(instance_create(x, y, Bones)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
sprite_index = sprCoral;
image_xscale = (- 1);
}
}
if(__hm_break9) break;
}}
}
}
}
}
}
if(__hm_break3) break;
}}
{ var __hm_with10 = scrHMInstances(Player), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
if ((((((((race != 1) and (race != 2)) and (race != 6)) and (race != 8)) and (race != 11)) and (race != 14)) and (race != 15))) {
{ var __hm_with13 = scrHMInstances(instance_create(x, y, Effect)), __hm_break15=false;
for (var __hm_index14=0; __hm_index14<array_length(__hm_with13); ++__hm_index14) {
if(instance_exists(__hm_with13[__hm_index14])) with (__hm_with13[__hm_index14]) {
{
sprite_index = sprPlayerBubble;
image_speed = (0) * timescale;
var __hm_other16=scrHMOther(other);
creator = __hm_other16;
}
}
if(__hm_break15) break;
}}
}
}
if(__hm_break12) break;
}}
{ var __hm_with17 = scrHMInstances(WeaponChest), __hm_break19=false;
for (var __hm_index18=0; __hm_index18<array_length(__hm_with17); ++__hm_index18) {
if(instance_exists(__hm_with17[__hm_index18])) with (__hm_with17[__hm_index18]) {
if ((random(12) < 1)) {
{
scrHMModCall("mod", "enemies", "ClamMimic_create", (x + 16), (y + 16));
;
scrHMDelete(id);
}
} else {
if ((object_index != BigWeaponChest)) {
sprite_index = sprClamChest;
}
}
}
if(__hm_break19) break;
}}
{ var __hm_with20 = scrHMInstances(Mimic), __hm_break22=false;
for (var __hm_index21=0; __hm_index21<array_length(__hm_with20); ++__hm_index21) {
if(instance_exists(__hm_with20[__hm_index21])) with (__hm_with20[__hm_index21]) {
{
scrHMModCall("mod", "enemies", "ClamMimic_create", (x + 16), (y + 16));
;
instance_change(Bubble, 1);
instance_destroy();
}
}
if(__hm_break22) break;
}}
{ var __hm_with23 = scrHMInstances(BoneFish), __hm_break25=false;
for (var __hm_index24=0; __hm_index24<array_length(__hm_with23); ++__hm_index24) {
if(instance_exists(__hm_with23[__hm_index24])) with (__hm_with23[__hm_index24]) {
{
if ((random(4) < 1)) {
{
spr_idle = global.hm_module_vars[$ "area:oasis"].BoneFish2Idle;
spr_walk = global.hm_module_vars[$ "area:oasis"].BoneFish2Walk;
spr_hurt = global.hm_module_vars[$ "area:oasis"].BoneFish2Hurt;
spr_dead = global.hm_module_vars[$ "area:oasis"].BoneFish2Dead;
s_fire = global.hm_module_vars[$ "area:oasis"].BoneFish2Fire;
s_idle = global.hm_module_vars[$ "area:oasis"].BoneFish2Idle;
hitid = [spr_idle, "BoneFish"];
}
} else {
if ((random(3) < 1)) {
{
spr_idle = global.hm_module_vars[$ "area:oasis"].BoneFish3Idle;
spr_walk = global.hm_module_vars[$ "area:oasis"].BoneFish3Walk;
spr_hurt = global.hm_module_vars[$ "area:oasis"].BoneFish3Hurt;
spr_dead = global.hm_module_vars[$ "area:oasis"].BoneFish3Dead;
s_fire = global.hm_module_vars[$ "area:oasis"].BoneFish3Fire;
s_idle = global.hm_module_vars[$ "area:oasis"].BoneFish3Idle;
hitid = [spr_idle, "BoneFish"];
}
} else {
if ((random(2) < 1)) {
{
spr_idle = global.hm_module_vars[$ "area:oasis"].BoneFish4Idle;
spr_walk = global.hm_module_vars[$ "area:oasis"].BoneFish4Walk;
spr_hurt = global.hm_module_vars[$ "area:oasis"].BoneFish4Hurt;
spr_dead = global.hm_module_vars[$ "area:oasis"].BoneFish4Dead;
s_fire = global.hm_module_vars[$ "area:oasis"].BoneFish4Fire;
s_idle = global.hm_module_vars[$ "area:oasis"].BoneFish4Idle;
hitid = [spr_idle, "BoneFish"];
}
} else {
{
s_fire = global.hm_module_vars[$ "area:oasis"].BoneFish1Fire;
s_idle = sprBoneFish1Idle;
}
}
}
}
}
}
if(__hm_break25) break;
}}
if ((GameCont.subarea == 3)) {
{
var _hml__floor = instance_furthest(10016, 10016, Floor);
;
{ var __hm_with26 = scrHMInstances(instance_nearest((((((_hml__floor.x * 2) + 10016) / 3) + random(128)) - 64), (((((_hml__floor.y * 2) + 10016) / 3) + random(128)) - 64), Floor)), __hm_break28=false;
for (var __hm_index27=0; __hm_index27<array_length(__hm_with26); ++__hm_index27) {
if(instance_exists(__hm_with26[__hm_index27])) with (__hm_with26[__hm_index27]) {
{ var __hm_with29 = scrHMInstances(instance_create((x + 16), (y + 16), OasisBoss)), __hm_break31=false;
for (var __hm_index30=0; __hm_index30<array_length(__hm_with29); ++__hm_index30) {
if(instance_exists(__hm_with29[__hm_index30])) with (__hm_with29[__hm_index30]) {
hitid = [sprOasisBossIdle, "Big Bubbler"];
}
if(__hm_break31) break;
}}
}
if(__hm_break28) break;
}}
}
} else {
if ((GameCont.subarea == 5)) {
{
var _hml__floor = instance_furthest(10016, 10016, Floor);
;
{ var __hm_with32 = scrHMInstances(instance_nearest((((((_hml__floor.x * 2) + 10016) / 3) + random(128)) - 64), (((((_hml__floor.y * 2) + 10016) / 3) + random(128)) - 64), Floor)), __hm_break34=false;
for (var __hm_index33=0; __hm_index33<array_length(__hm_with32); ++__hm_index33) {
if(instance_exists(__hm_with32[__hm_index33])) with (__hm_with32[__hm_index33]) {
instance_create((x + 16), (y + 16), FrogQueen);
}
if(__hm_break34) break;
}}
}
}
}
{ var __hm_with35 = scrHMMatching(Floor, "sprite_index", sprFloor101B), __hm_break37=false;
for (var __hm_index36=0; __hm_index36<array_length(__hm_with35); ++__hm_index36) {
if(instance_exists(__hm_with35[__hm_index36])) with (__hm_with35[__hm_index36]) {
depth -= 1;
}
if(__hm_break37) break;
}}
{ var __hm_with38 = scrHMInstances(BoneFish), __hm_break40=false;
for (var __hm_index39=0; __hm_index39<array_length(__hm_with38); ++__hm_index39) {
if(instance_exists(__hm_with38[__hm_index39])) with (__hm_with38[__hm_index39]) {
alarm[2] += random_range(50, 200);
}
if(__hm_break40) break;
}}
}

// Source areas/oasis.area.gml:477; area_make_floor
function hm_areas_oasis_area_gml_area_make_floor() {
instance_create(x, y, Floor);
;
var _hml_turn = choose(0, 0, 0, 0, 0, 0, 0, 90, 90, 90, (- 90), (- 90), (- 90), 180);
;
direction += _hml_turn;
;
if (((_hml_turn == 180) && (point_distance(x, y, 10016, 10016) > 48))) {
{
instance_create(x, y, Floor);
;
instance_create((x + 16), (y + 16), WeaponChest);
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
if ((point_distance(x, y, 10016, 10016) > 48)) {
{
instance_create((x + 16), (y + 16), AmmoChest);
;
instance_create(x, y, Floor);
;
}
}
instance_destroy();
;
}
} else {
if ((random(4) < 1)) {
{
instance_create(x, y, FloorMaker);
;
}
}
}
}

// Source areas/oasis.area.gml:504; area_pop_enemies
function hm_areas_oasis_area_gml_area_pop_enemies() {
{ var __hm_with1 = scrHMInstances(instance_create((x + 16), (y + 16), BoneFish)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
s_idle = spr_idle;
}
}
if(__hm_break3) break;
}}
if ((random(10) < 1)) {
{ var __hm_with4 = scrHMInstances(instance_create((x + 16), (y + 16), Crab)), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
spr_dead = global.hm_module_vars[$ "area:oasis"].crabdead;
}
if(__hm_break6) break;
}}
}
if ((GameCont.subarea <= 3)) {
{
if (((GameCont.subarea > 1) and (GameCont.loops > 0))) {
{
if ((random(50) < (1 + GameCont.loops))) {
repeat (choose(2, 3, 4)) scrHMModCall("mod", "enemies", "enemyfish_create", (x + 16), (y + 16));
}
}
}
}
} else {
{
if ((random(64) < (1 + GameCont.loops))) {
{ var __hm_with7 = scrHMInstances(instance_create((x + 16), (y + 16), Gator)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
friction = (0.1) * (timescale * timescale);
}
if(__hm_break9) break;
}}
}
if ((random(72) < (1 + GameCont.loops))) {
{ var __hm_with10 = scrHMInstances(instance_create((x + 16), (y + 16), BuffGator)), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
friction = (0.1) * (timescale * timescale);
}
if(__hm_break12) break;
}}
}
if ((random(64) < (1 + GameCont.loops))) {
instance_create((x + 16), (y + 16), Ratking);
}
if ((random(22) < (1 + GameCont.loops))) {
instance_create((x + 16), (y + 16), Rat);
}
if ((random(22) < (1 + GameCont.loops))) {
instance_create((x + 16), (y + 16), Exploder);
}
if ((random(64) < 1)) {
instance_create((x + 16), (y + 16), ToxicBarrel);
}
if ((random(32) < (1 + GameCont.loops))) {
instance_create((x + 16), (y + 16), Turtle);
}
}
}
}

// Source areas/oasis.area.gml:524; area_pop_props
function hm_areas_oasis_area_gml_area_pop_props() {
if ((GameCont.subarea <= 3)) {
{
if ((random(16) < 1)) {
instance_create((x + 16), (y + 16), WaterMine);
}
if ((random(48) < 1)) {
instance_create((x + 16), (y + 16), Anchor);
}
}
} else {
{
if ((random(24) < 1)) {
instance_create((x + 16), (y + 16), Pipe);
}
}
}
if ((random(3) < 1)) {
instance_create((x + 16), (y + 16), LightBeam);
}
if ((random(24) < 1)) {
instance_create((x + 16), (y + 16), WaterPlant);
}
if ((random(24) < 1)) {
instance_create((x + 16), (y + 16), OasisBarrel);
}
}

// Source areas/oasis.area.gml:535; area_mapdata
function hm_areas_oasis_area_gml_area_mapdata(_hml_lx, _hml_ly, _hml_lp, _hml_ls, _hml_ws, _hml_ll) {
return [_hml_lx, 9, 1, 1, 1];
;
}
