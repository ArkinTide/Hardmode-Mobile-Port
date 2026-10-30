// Source maincode.mod.gml:1; __load
function hm_maincode_mod_gml___load() {
global.hm_module_vars[$ "mod:maincode"].versionnumber = "b24";
global.hm_module_vars[$ "mod:maincode"].YALCredits = sprHM_maincode_mod_5;
global.hm_module_vars[$ "mod:maincode"].sewersentrance = sprHM_maincode_mod_6;
scrHMSpriteReplace(sprWall2Top, sprHM_maincode_mod_7);
global.hm_module_vars[$ "mod:maincode"].ripple = sprHM_maincode_mod_8;
global.hm_module_vars[$ "mod:maincode"].turretdeactivate = sprHM_maincode_mod_9;
scrHMSpriteReplace(sprTopPot, sprHM_maincode_mod_11);
global.hm_module_vars[$ "mod:maincode"].Bigdogportrait = sprHM_maincode_mod_12;
global.hm_module_vars[$ "mod:maincode"].Bigdogportraitfg = sprHM_maincode_mod_13;
global.hm_module_vars[$ "mod:maincode"].redfog = sprHM_maincode_mod_14;
global.hm_module_vars[$ "mod:maincode"].gce = 0;
;
global.hm_module_vars[$ "mod:maincode"].door = noone;
;
global.hm_module_vars[$ "mod:maincode"].vans = 0;
;
global.hm_module_vars[$ "mod:maincode"].runcount = 0;
;
global.hm_module_vars[$ "mod:maincode"].venuz = 0;
}

// Source maincode.mod.gml:21; game_start
function hm_maincode_mod_gml_game_start() {
can_walk = true;
;
can_pick = true;
;
can_spec = true;
;

GameCont.droppedguitar = 1;
GameCont.seenhq = 1;
global.hm_module_vars[$ "mod:maincode"].gce = 0;
;
global.hm_module_vars[$ "mod:maincode"].door = noone;
;
global.hm_module_vars[$ "mod:maincode"].vans = 0;
;
global.hm_module_vars[$ "mod:maincode"].runcount += 1;
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
scrHMSoundRestore(sndOasisCrabAttack);
;
scrHMWeaponSetArea(39, (- 1));
scrHMWeaponSetArea(40, (- 1));
scrHMWeaponSetArea(41, (- 1));
scrHMWeaponSetArea(42, (- 1));
scrHMWeaponSetArea(43, (- 1));
scrHMWeaponSetArea(44, (- 1));
scrHMWeaponSetArea(45, (- 1));
scrHMWeaponSetArea(98, (- 1));
scrHMWeaponSetArea(99, (- 1));
scrHMWeaponSetArea(100, (- 1));
scrHMWeaponSetArea(101, (- 1));
scrHMWeaponSetArea(102, (- 1));
scrHMWeaponSetArea(103, (- 1));
scrHMWeaponSetArea(122, (- 1));
scrHMWeaponSetArea(123, (- 1));
scrHMWeaponSetArea(127, (- 1));
scrHMWeaponSetArea(111, 24);
}

// Source maincode.mod.gml:221; draw_dark
function hm_maincode_mod_gml_draw_dark() {
{ var __hm_with1 = scrHMMatching(Campfire, "sprite_index", sprCampfire, sprCampfireBear), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
draw_set_alpha(1);
draw_set_color(0);
draw_circle(x, y, (40 + random(4)), false);
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMMatching(CampChar, "num", 11), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
draw_circle((x - 1), y, (12 + random(2)), false);
}
}
if(__hm_break6) break;
}}
{ var __hm_with7 = scrHMMatching(CampChar, "num", 3), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
if ((image_index > 18)) {
{
draw_circle((x - 2), (y - 6), (30 + random(3)), false);
}
}
}
if(__hm_break9) break;
}}
{ var __hm_with10 = scrHMInstances(TV), __hm_break12=false;
for (var __hm_index11=0; __hm_index11<array_length(__hm_with10); ++__hm_index11) {
if(instance_exists(__hm_with10[__hm_index11])) with (__hm_with10[__hm_index11]) {
{
draw_circle(x, y, (30 + random(3)), false);
}
}
if(__hm_break12) break;
}}
}

// Source maincode.mod.gml:237; step
function hm_maincode_mod_gml_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_maincode_mod_gml_step_resume, id, scrHMOther(other), _args, 374, []);
}
function hm_maincode_mod_gml_step_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_maincode_mod_gml_step");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // maincode.mod.gml:2650
{
;
}
_hm.pc=0;
break;
case 2: // maincode.mod.gml:2650
_hm.pc=0;
break;
case 3: // maincode.mod.gml:2633
{
if ((random(12) < 1)) {
{ var __hm_with2 = scrHMInstances(instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), SnowFlake)), __hm_break4=false;
for (var __hm_index3=0; __hm_index3<array_length(__hm_with2); ++__hm_index3) {
if(instance_exists(__hm_with2[__hm_index3])) with (__hm_with2[__hm_index3]) {
{
sprite_index = sprLeaf;
}
}
if(__hm_break4) break;
}}
}
{ var __hm_with5 = scrHMInstances(enemy), __hm_break7=false;
for (var __hm_index6=0; __hm_index6<array_length(__hm_with5); ++__hm_index6) {
if(instance_exists(__hm_with5[__hm_index6])) with (__hm_with5[__hm_index6]) {
if (instance_exists(target)) {
{
if (((target >= 0) && (collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0))) {
targetvisible = 1;
} else {
targetvisible = 0;
}
;
if (((targetvisible == 0) and (image_alpha > 0))) {
image_alpha -= 0.1;
}
if ((targetvisible == 1)) {
image_alpha = 2;
}
if (((image_alpha <= 0) and ((speed / timescale) > (friction / (timescale * timescale))))) {
if ((random(5) < 1)) {
{ var __hm_with8 = scrHMInstances(instance_create(x, y, Feather)), __hm_break10=false;
for (var __hm_index9=0; __hm_index9<array_length(__hm_with8); ++__hm_index9) {
if(instance_exists(__hm_with8[__hm_index9])) with (__hm_with8[__hm_index9]) {
sprite_index = sprLeaf;
}
if(__hm_break10) break;
}}
}
}
}
}
}
if(__hm_break7) break;
}}
}
_hm.pc=2;
break;
case 4: // maincode.mod.gml:2631
{
;
}
_hm.pc=3;
break;
case 5: // maincode.mod.gml:2631
_hm.pc=0;
break;
case 6: // maincode.mod.gml:2465
{
{ var __hm_with11 = scrHMMatchingNE(projectile, "object_index", ToxicGas), __hm_break13=false;
for (var __hm_index12=0; __hm_index12<array_length(__hm_with11); ++__hm_index12) {
if(instance_exists(__hm_with11[__hm_index12])) with (__hm_with11[__hm_index12]) {
if ((random(6) < 1)) {
instance_create(x, y, Bubble);
}
}
if(__hm_break13) break;
}}
{ var __hm_with14 = scrHMInstances(LightBeam), __hm_break16=false;
for (var __hm_index15=0; __hm_index15<array_length(__hm_with14); ++__hm_index15) {
if(instance_exists(__hm_with14[__hm_index15])) with (__hm_with14[__hm_index15]) {
{
if ((random(20) < 1)) {
scrHMMotionAdd(random(360), 0.1);
}
if (((speed / timescale) > 1)) {
speed = (0.1) * timescale;
}
}
}
if(__hm_break16) break;
}}
{ var __hm_with17 = scrHMInstances(Wall), __hm_break19=false;
for (var __hm_index18=0; __hm_index18<array_length(__hm_with17); ++__hm_index18) {
if(instance_exists(__hm_with17[__hm_index18])) with (__hm_with17[__hm_index18]) {
depth = (0 - (y / 10016));
}
if(__hm_break19) break;
}}
{ var __hm_with20 = scrHMInstances(WaterMine), __hm_break22=false;
for (var __hm_index21=0; __hm_index21<array_length(__hm_with20); ++__hm_index21) {
if(instance_exists(__hm_with20[__hm_index21])) with (__hm_with20[__hm_index21]) {
depth = (0 - (y / 10016));
}
if(__hm_break22) break;
}}
{ var __hm_with23 = scrHMInstances(WaterMineExplode), __hm_break25=false;
for (var __hm_index24=0; __hm_index24<array_length(__hm_with23); ++__hm_index24) {
if(instance_exists(__hm_with23[__hm_index24])) with (__hm_with23[__hm_index24]) {
depth = (0 - (y / 10016));
}
if(__hm_break25) break;
}}
{ var __hm_with26 = scrHMInstances(GroundFlame), __hm_break28=false;
for (var __hm_index27=0; __hm_index27<array_length(__hm_with26); ++__hm_index27) {
if(instance_exists(__hm_with26[__hm_index27])) with (__hm_with26[__hm_index27]) {
{
{ var __hm_with29 = scrHMInstances(instance_create(x, y, Bubble)), __hm_break31=false;
for (var __hm_index30=0; __hm_index30<array_length(__hm_with29); ++__hm_index30) {
if(instance_exists(__hm_with29[__hm_index30])) with (__hm_with29[__hm_index30]) {
var __hm_other32=scrHMOther(other);
scrHMMotionAdd(__hm_other32.direction, (__hm_other32.speed / timescale));
}
if(__hm_break31) break;
}}
instance_destroy();
}
}
if(__hm_break28) break;
}}
{ var __hm_with33 = scrHMMatching(AllyBullet, "team", 0), __hm_break35=false;
for (var __hm_index34=0; __hm_index34<array_length(__hm_with33); ++__hm_index34) {
if(instance_exists(__hm_with33[__hm_index34])) with (__hm_with33[__hm_index34]) {
sprite_index = sprFireBall;
}
if(__hm_break35) break;
}}
{ var __hm_with36 = scrHMInstances(Bullet1), __hm_break38=false;
for (var __hm_index37=0; __hm_index37<array_length(__hm_with36); ++__hm_index37) {
if(instance_exists(__hm_with36[__hm_index37])) with (__hm_with36[__hm_index37]) {
speed = (4) * timescale;
}
if(__hm_break38) break;
}}
{ var __hm_with39 = scrHMMatchingNE(Bullet2, "reset", 1), __hm_break41=false;
for (var __hm_index40=0; __hm_index40<array_length(__hm_with39); ++__hm_index40) {
if(instance_exists(__hm_with39[__hm_index40])) with (__hm_with39[__hm_index40]) {
{
reset = 1;
speed = (8) * timescale;
image_speed = (0.25) * timescale;
}
}
if(__hm_break41) break;
}}
{ var __hm_with42 = scrHMMatchingNE(Slug, "reset", 1), __hm_break44=false;
for (var __hm_index43=0; __hm_index43<array_length(__hm_with42); ++__hm_index43) {
if(instance_exists(__hm_with42[__hm_index43])) with (__hm_with42[__hm_index43]) {
{
reset = 1;
speed = (10) * timescale;
image_speed = (0.25) * timescale;
}
}
if(__hm_break44) break;
}}
{ var __hm_with45 = scrHMMatchingNE(FlakBullet, "reset", 1), __hm_break47=false;
for (var __hm_index46=0; __hm_index46<array_length(__hm_with45); ++__hm_index46) {
if(instance_exists(__hm_with45[__hm_index46])) with (__hm_with45[__hm_index46]) {
{
reset = 1;
speed = (7) * timescale;
image_speed = (0.25) * timescale;
}
}
if(__hm_break47) break;
}}
{ var __hm_with48 = scrHMMatchingNE(FlameShell, "reset", 1), __hm_break50=false;
for (var __hm_index49=0; __hm_index49<array_length(__hm_with48); ++__hm_index49) {
if(instance_exists(__hm_with48[__hm_index49])) with (__hm_with48[__hm_index49]) {
{
reset = 1;
speed = (6) * timescale;
}
}
if(__hm_break50) break;
}}
{ var __hm_with51 = scrHMInstances(HeavyBullet), __hm_break53=false;
for (var __hm_index52=0; __hm_index52<array_length(__hm_with51); ++__hm_index52) {
if(instance_exists(__hm_with51[__hm_index52])) with (__hm_with51[__hm_index52]) {
speed = (2) * timescale;
}
if(__hm_break53) break;
}}
{ var __hm_with54 = scrHMInstances(BouncerBullet), __hm_break56=false;
for (var __hm_index55=0; __hm_index55<array_length(__hm_with54); ++__hm_index55) {
if(instance_exists(__hm_with54[__hm_index55])) with (__hm_with54[__hm_index55]) {
speed = (2) * timescale;
}
if(__hm_break56) break;
}}
{ var __hm_with57 = scrHMMatching(AllyBullet, "team", 1), __hm_break59=false;
for (var __hm_index58=0; __hm_index58<array_length(__hm_with57); ++__hm_index58) {
if(instance_exists(__hm_with57[__hm_index58])) with (__hm_with57[__hm_index58]) {
speed = (4) * timescale;
}
if(__hm_break59) break;
}}
{ var __hm_with60 = scrHMMatchingGT(Bolt, "speed", 0), __hm_break62=false;
for (var __hm_index61=0; __hm_index61<array_length(__hm_with60); ++__hm_index61) {
if(instance_exists(__hm_with60[__hm_index61])) with (__hm_with60[__hm_index61]) {
speed = (6) * timescale;
}
if(__hm_break62) break;
}}
{ var __hm_with63 = scrHMMatchingGT(Splinter, "speed", 0), __hm_break65=false;
for (var __hm_index64=0; __hm_index64<array_length(__hm_with63); ++__hm_index64) {
if(instance_exists(__hm_with63[__hm_index64])) with (__hm_with63[__hm_index64]) {
speed = (4) * timescale;
}
if(__hm_break65) break;
}}
{ var __hm_with66 = scrHMMatchingGT(ToxicBolt, "speed", 0), __hm_break68=false;
for (var __hm_index67=0; __hm_index67<array_length(__hm_with66); ++__hm_index67) {
if(instance_exists(__hm_with66[__hm_index67])) with (__hm_with66[__hm_index67]) {
speed = (6) * timescale;
}
if(__hm_break68) break;
}}
{ var __hm_with69 = scrHMMatchingGT(HeavyBolt, "speed", 0), __hm_break71=false;
for (var __hm_index70=0; __hm_index70<array_length(__hm_with69); ++__hm_index70) {
if(instance_exists(__hm_with69[__hm_index70])) with (__hm_with69[__hm_index70]) {
speed = (8) * timescale;
}
if(__hm_break71) break;
}}
{ var __hm_with72 = scrHMInstances(Disc), __hm_break74=false;
for (var __hm_index73=0; __hm_index73<array_length(__hm_with72); ++__hm_index73) {
if(instance_exists(__hm_with72[__hm_index73])) with (__hm_with72[__hm_index73]) {
speed = (3) * timescale;
}
if(__hm_break74) break;
}}
{ var __hm_with75 = scrHMInstances(Grenade), __hm_break77=false;
for (var __hm_index76=0; __hm_index76<array_length(__hm_with75); ++__hm_index76) {
if(instance_exists(__hm_with75[__hm_index76])) with (__hm_with75[__hm_index76]) {
speed = (3) * timescale;
}
if(__hm_break77) break;
}}
{ var __hm_with78 = scrHMInstances(HeavyGrenade), __hm_break80=false;
for (var __hm_index79=0; __hm_index79<array_length(__hm_with78); ++__hm_index79) {
if(instance_exists(__hm_with78[__hm_index79])) with (__hm_with78[__hm_index79]) {
speed = (3) * timescale;
}
if(__hm_break80) break;
}}
{ var __hm_with81 = scrHMInstances(ClusterNade), __hm_break83=false;
for (var __hm_index82=0; __hm_index82<array_length(__hm_with81); ++__hm_index82) {
if(instance_exists(__hm_with81[__hm_index82])) with (__hm_with81[__hm_index82]) {
speed = (3) * timescale;
}
if(__hm_break83) break;
}}
{ var __hm_with84 = scrHMInstances(Rocket), __hm_break86=false;
for (var __hm_index85=0; __hm_index85<array_length(__hm_with84); ++__hm_index85) {
if(instance_exists(__hm_with84[__hm_index85])) with (__hm_with84[__hm_index85]) {
speed = (4) * timescale;
}
if(__hm_break86) break;
}}
{ var __hm_with87 = scrHMInstances(Nuke), __hm_break89=false;
for (var __hm_index88=0; __hm_index88<array_length(__hm_with87); ++__hm_index88) {
if(instance_exists(__hm_with87[__hm_index88])) with (__hm_with87[__hm_index88]) {
speed = (3) * timescale;
}
if(__hm_break89) break;
}}
{ var __hm_with90 = scrHMInstances(Smoke), __hm_break92=false;
for (var __hm_index91=0; __hm_index91<array_length(__hm_with90); ++__hm_index91) {
if(instance_exists(__hm_with90[__hm_index91])) with (__hm_with90[__hm_index91]) {
{
{ var __hm_with93 = scrHMInstances(instance_create(x, y, Bubble)), __hm_break95=false;
for (var __hm_index94=0; __hm_index94<array_length(__hm_with93); ++__hm_index94) {
if(instance_exists(__hm_with93[__hm_index94])) with (__hm_with93[__hm_index94]) {
var __hm_other96=scrHMOther(other);
scrHMMotionAdd(__hm_other96.direction, (__hm_other96.speed / timescale));
}
if(__hm_break95) break;
}}
instance_destroy();
}
}
if(__hm_break92) break;
}}
{ var __hm_with97 = scrHMInstances(Flame), __hm_break99=false;
for (var __hm_index98=0; __hm_index98<array_length(__hm_with97); ++__hm_index98) {
if(instance_exists(__hm_with97[__hm_index98])) with (__hm_with97[__hm_index98]) {
{
{ var __hm_with100 = scrHMInstances(instance_create(x, y, Bubble)), __hm_break102=false;
for (var __hm_index101=0; __hm_index101<array_length(__hm_with100); ++__hm_index101) {
if(instance_exists(__hm_with100[__hm_index101])) with (__hm_with100[__hm_index101]) {
var __hm_other103=scrHMOther(other);
scrHMMotionAdd(__hm_other103.direction, (__hm_other103.speed / timescale));
}
if(__hm_break102) break;
}}
instance_destroy();
}
}
if(__hm_break99) break;
}}
{ var __hm_with104 = scrHMInstances(Dust), __hm_break106=false;
for (var __hm_index105=0; __hm_index105<array_length(__hm_with104); ++__hm_index105) {
if(instance_exists(__hm_with104[__hm_index105])) with (__hm_with104[__hm_index105]) {
{
instance_create(x, y, Bubble);
instance_destroy();
}
}
if(__hm_break106) break;
}}
{ var __hm_with107 = scrHMInstances(ToxicGas), __hm_break109=false;
for (var __hm_index108=0; __hm_index108<array_length(__hm_with107); ++__hm_index108) {
if(instance_exists(__hm_with107[__hm_index108])) with (__hm_with107[__hm_index108]) {
{
friction = (0.1) * (timescale * timescale);
}
}
if(__hm_break109) break;
}}
if ((! scrHMGetSkill(12))) {
{
{ var __hm_with110 = scrHMInstances(EnemyBullet1), __hm_break112=false;
for (var __hm_index111=0; __hm_index111<array_length(__hm_with110); ++__hm_index111) {
if(instance_exists(__hm_with110[__hm_index111])) with (__hm_with110[__hm_index111]) {
speed = (3) * timescale;
}
if(__hm_break112) break;
}}
{ var __hm_with113 = scrHMInstances(EnemyBullet2), __hm_break115=false;
for (var __hm_index114=0; __hm_index114<array_length(__hm_with113); ++__hm_index114) {
if(instance_exists(__hm_with113[__hm_index114])) with (__hm_with113[__hm_index114]) {
speed = (4) * timescale;
}
if(__hm_break115) break;
}}
{ var __hm_with116 = scrHMMatchingNE(EnemyBullet3, "reset", 1), __hm_break118=false;
for (var __hm_index117=0; __hm_index117<array_length(__hm_with116); ++__hm_index117) {
if(instance_exists(__hm_with116[__hm_index117])) with (__hm_with116[__hm_index117]) {
{
reset = 1;
speed = ((3 + random(3))) * timescale;
image_speed = (0.25) * timescale;
}
}
if(__hm_break118) break;
}}
{ var __hm_with119 = scrHMMatchingNE(EnemyFlak, "reset", 1), __hm_break121=false;
for (var __hm_index120=0; __hm_index120<array_length(__hm_with119); ++__hm_index120) {
if(instance_exists(__hm_with119[__hm_index120])) with (__hm_with119[__hm_index120]) {
{
reset = 1;
speed = (7) * timescale;
image_speed = (0.25) * timescale;
}
}
if(__hm_break121) break;
}}
{ var __hm_with122 = scrHMInstances(EnemyBullet4), __hm_break124=false;
for (var __hm_index123=0; __hm_index123<array_length(__hm_with122); ++__hm_index123) {
if(instance_exists(__hm_with122[__hm_index123])) with (__hm_with122[__hm_index123]) {
speed = (3) * timescale;
}
if(__hm_break124) break;
}}
{ var __hm_with125 = scrHMMatchingNE(AllyBullet, "reset", 1), __hm_break127=false;
for (var __hm_index126=0; __hm_index126<array_length(__hm_with125); ++__hm_index126) {
if(instance_exists(__hm_with125[__hm_index126])) with (__hm_with125[__hm_index126]) {
if ((team == 0)) {
{
reset = 1;
speed = ((1 + choose(0, 1, 2))) * timescale;
}
}
}
if(__hm_break127) break;
}}
{ var __hm_with128 = scrHMInstances(IDPDBullet), __hm_break130=false;
for (var __hm_index129=0; __hm_index129<array_length(__hm_with128); ++__hm_index129) {
if(instance_exists(__hm_with128[__hm_index129])) with (__hm_with128[__hm_index129]) {
speed = (3) * timescale;
}
if(__hm_break130) break;
}}
}
} else {
{
{ var __hm_with131 = scrHMInstances(EnemyBullet1), __hm_break133=false;
for (var __hm_index132=0; __hm_index132<array_length(__hm_with131); ++__hm_index132) {
if(instance_exists(__hm_with131[__hm_index132])) with (__hm_with131[__hm_index132]) {
speed = (1) * timescale;
}
if(__hm_break133) break;
}}
{ var __hm_with134 = scrHMInstances(EnemyBullet2), __hm_break136=false;
for (var __hm_index135=0; __hm_index135<array_length(__hm_with134); ++__hm_index135) {
if(instance_exists(__hm_with134[__hm_index135])) with (__hm_with134[__hm_index135]) {
speed = (2) * timescale;
}
if(__hm_break136) break;
}}
{ var __hm_with137 = scrHMMatchingNE(EnemyBullet3, "reset", 1), __hm_break139=false;
for (var __hm_index138=0; __hm_index138<array_length(__hm_with137); ++__hm_index138) {
if(instance_exists(__hm_with137[__hm_index138])) with (__hm_with137[__hm_index138]) {
{
reset = 1;
speed = ((3 + random(3))) * timescale;
image_speed = (0.25) * timescale;
}
}
if(__hm_break139) break;
}}
{ var __hm_with140 = scrHMMatchingNE(EnemyFlak, "reset", 1), __hm_break142=false;
for (var __hm_index141=0; __hm_index141<array_length(__hm_with140); ++__hm_index141) {
if(instance_exists(__hm_with140[__hm_index141])) with (__hm_with140[__hm_index141]) {
{
reset = 1;
speed = (3) * timescale;
image_speed = (0.25) * timescale;
}
}
if(__hm_break142) break;
}}
{ var __hm_with143 = scrHMInstances(EnemyBullet4), __hm_break145=false;
for (var __hm_index144=0; __hm_index144<array_length(__hm_with143); ++__hm_index144) {
if(instance_exists(__hm_with143[__hm_index144])) with (__hm_with143[__hm_index144]) {
speed = (1) * timescale;
}
if(__hm_break145) break;
}}
{ var __hm_with146 = scrHMInstances(IDPDBullet), __hm_break148=false;
for (var __hm_index147=0; __hm_index147<array_length(__hm_with146); ++__hm_index147) {
if(instance_exists(__hm_with146[__hm_index147])) with (__hm_with146[__hm_index147]) {
speed = (2) * timescale;
}
if(__hm_break148) break;
}}
{ var __hm_with149 = scrHMMatchingNE(AllyBullet, "reset", 1), __hm_break151=false;
for (var __hm_index150=0; __hm_index150<array_length(__hm_with149); ++__hm_index150) {
if(instance_exists(__hm_with149[__hm_index150])) with (__hm_with149[__hm_index150]) {
if ((team == 0)) {
{
reset = 1;
speed = ((1 + choose(0, 0, 1))) * timescale;
}
}
}
if(__hm_break151) break;
}}
}
}
{ var __hm_with152 = scrHMInstances(SuperFrog), __hm_break154=false;
for (var __hm_index153=0; __hm_index153<array_length(__hm_with152); ++__hm_index153) {
if(instance_exists(__hm_with152[__hm_index153])) with (__hm_with152[__hm_index153]) {
{
instance_change(Bubble, 1);
instance_destroy();
}
}
if(__hm_break154) break;
}}
{ var __hm_with155 = scrHMInstances(Lightning), __hm_break157=false;
for (var __hm_index156=0; __hm_index156<array_length(__hm_with155); ++__hm_index156) {
if(instance_exists(__hm_with155[__hm_index156])) with (__hm_with155[__hm_index156]) {
{
if (instance_exists(creator)) {
{
team = 0;
x = creator.x;
y = creator.y;
damage = 3;
knockback_speed = (random(360)) * timescale;
hitid = [sprLightningDeath, "PHYSICS"];
}
}
}
}
if(__hm_break157) break;
}}
{ var __hm_with158 = scrHMMatching(Effect, "sprite_index", sprPlayerBubble), __hm_break160=false;
for (var __hm_index159=0; __hm_index159<array_length(__hm_with158); ++__hm_index159) {
if(instance_exists(__hm_with158[__hm_index159])) with (__hm_with158[__hm_index159]) {
{
if (instance_exists(creator)) {
{
x = (creator.x + (creator.hspeed / timescale));
y = (creator.y + (creator.vspeed / timescale));
}
} else {
{
sprite_index = sprPlayerBubblePop;
image_speed = (0.4) * timescale;
}
}
}
}
if(__hm_break160) break;
}}
{ var __hm_with161 = scrHMMatching(Effect, "sprite_index", sprPlayerBubblePop), __hm_break163=false;
for (var __hm_index162=0; __hm_index162<array_length(__hm_with161); ++__hm_index162) {
if(instance_exists(__hm_with161[__hm_index162])) with (__hm_with161[__hm_index162]) {
if ((image_index >= 3)) {
instance_destroy();
}
}
if(__hm_break163) break;
}}
}
_hm.pc=5;
break;
case 7: // maincode.mod.gml:2463
{
;
}
_hm.pc=6;
break;
case 8: // maincode.mod.gml:2463
_hm.pc=0;
break;
case 9: // maincode.mod.gml:2441
{
{ var __hm_with164 = scrHMMatchingNE(scrHMAuthoredWalls105(), "thing", 1), __hm_break166=false;
for (var __hm_index165=0; __hm_index165<array_length(__hm_with164); ++__hm_index165) {
if(instance_exists(__hm_with164[__hm_index165])) with (__hm_with164[__hm_index165]) {
if ((!scrHMVariableExists(id, "open"))) {
{
thing = 1;
instance_create(x, y, InvisiWall);
}
}
}
if(__hm_break166) break;
}}
{ var __hm_with167 = scrHMMatchingNE(FloorExplo, "thing", 1), __hm_break169=false;
for (var __hm_index168=0; __hm_index168<array_length(__hm_with167); ++__hm_index168) {
if(instance_exists(__hm_with167[__hm_index168])) with (__hm_with167[__hm_index168]) {
if ((!scrHMVariableExists(id, "noregen"))) {
{
thing = 1;
thing2 = 10;
}
}
}
if(__hm_break169) break;
}}
{ var __hm_with170 = scrHMMatchingGT(FloorExplo, "thing2", 0), __hm_break172=false;
for (var __hm_index171=0; __hm_index171<array_length(__hm_with170); ++__hm_index171) {
if(instance_exists(__hm_with170[__hm_index171])) with (__hm_with170[__hm_index171]) {
{
thing2 -= choose(0, 0, 1);
}
}
if(__hm_break172) break;
}}
{ var __hm_with173 = scrHMMatching(FloorExplo, "thing2", 0), __hm_break175=false;
for (var __hm_index174=0; __hm_index174<array_length(__hm_with173); ++__hm_index174) {
if(instance_exists(__hm_with173[__hm_index174])) with (__hm_with173[__hm_index174]) {
{
instance_create(x, y, Wall);
instance_destroy();
}
}
if(__hm_break175) break;
}}
{ var __hm_with176 = scrHMMatchingNE(hitme, "object_index", Player), __hm_break178=false;
for (var __hm_index177=0; __hm_index177<array_length(__hm_with176); ++__hm_index177) {
if(instance_exists(__hm_with176[__hm_index177])) with (__hm_with176[__hm_index177]) {
if (place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), InvisiWall)) {
move_bounce_solid(false);
}
}
if(__hm_break178) break;
}}
}
_hm.pc=8;
break;
case 10: // maincode.mod.gml:2352
{
global.hm_module_vars[$ "mod:maincode"].gce = 1;
;
global.hm_module_vars[$ "mod:maincode"].door = noone;
;
}
_hm.pc=9;
break;
case 11: // maincode.mod.gml:2359
scrHMTaskWithNext(_hm);
break;
case 12: // maincode.mod.gml:2359
scrHMTaskWithAbort(_hm);
break;
case 13: // maincode.mod.gml:2434
{
;
}
_hm.pc=11;
break;
case 14: // maincode.mod.gml:2434
_hm.result=undefined; _hm.done=true; return;
break;
case 16: // maincode.mod.gml:2432
{
;
}
_hm.pc=15;
break;
case 17: // maincode.mod.gml:2432
_hm.wait_ticks=max(0,1); _hm.pc=16; return;
break;
case 18: // maincode.mod.gml:2405
scrHMTaskWithNext(_hm);
break;
case 19: // maincode.mod.gml:2405
scrHMTaskWithAbort(_hm);
break;
case 20: // maincode.mod.gml:2428
{
;
}
_hm.pc=18;
break;
case 21: // maincode.mod.gml:2428
_hm.result=undefined; _hm.done=true; return;
break;
case 23: // maincode.mod.gml:2426
{
;
}
_hm.pc=22;
break;
case 24: // maincode.mod.gml:2426
_hm.wait_ticks=max(0,1); _hm.pc=23; return;
break;
case 25: // maincode.mod.gml:2423
{
;
}
_hm.pc=24;
break;
case 26: // maincode.mod.gml:2423
_hm.pc=21;
break;
case 27: // maincode.mod.gml:2414
{
{ var __hm_with179 = scrHMInstances(instance_create((x + 8), (y + 8), Portal)), __hm_break181=false;
for (var __hm_index180=0; __hm_index180<array_length(__hm_with179); ++__hm_index180) {
if(instance_exists(__hm_with179[__hm_index180])) with (__hm_with179[__hm_index180]) {
{
image_alpha = 0;
;
GameCont.area = scrHMAreaResolve(107);
;
GameCont.lastarea = scrHMAreaResolve("junkyard");
;
GameCont.lastsubarea = 4;
;
}
}
if(__hm_break181) break;
}}
image_blend = c_black;
;
}
_hm.pc=26;
break;
case 28: // maincode.mod.gml:2413
_hm.pc = (_hm.vars._allTogetherNow) ? 27 : 24;
break;
case 29: // maincode.mod.gml:2410
{
_hm.vars._allTogetherNow = 1;
;
{ var __hm_with182 = scrHMInstances(Player), __hm_break184=false;
for (var __hm_index183=0; __hm_index183<array_length(__hm_with182); ++__hm_index183) {
if(instance_exists(__hm_with182[__hm_index183])) with (__hm_with182[__hm_index183]) {
if ((distance_to_object((scrHMOther(other))) > 0)) {
_hm.vars._allTogetherNow = 0;
}
}
if(__hm_break184) break;
}}
}
_hm.pc=28;
break;
case 30: // maincode.mod.gml:2409
_hm.pc = ((_hm.other_scope.open == 2)) ? 29 : 24;
break;
case 22: // maincode.mod.gml:2408
_hm.pc=(instance_exists(_hm.scope))?30:21;
break;
case 31: // maincode.mod.gml:2407
_hm.pc = (scrHMTaskFork(_hm, 22)) ? 22 : 18;
break;
case 32: // maincode.mod.gml:2406
{
noregen = 1;
}
_hm.pc=31;
break;
case 33: // maincode.mod.gml:2405
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(x, y, FloorExplo)),32,17);
break;
case 34: // maincode.mod.gml:2402
{
;
}
_hm.pc=33;
break;
case 35: // maincode.mod.gml:2402
_hm.result=undefined; _hm.done=true; return;
break;
case 36: // maincode.mod.gml:2399
{
open = 2;
;
mask_index = mskWall;
;
}
_hm.pc=35;
break;
case 38: // maincode.mod.gml:2389
_hm.vars.__hm_repeat185--; _hm.pc=37;
break;
case 39: // maincode.mod.gml:2397
{
;
}
_hm.pc=38;
break;
case 40: // maincode.mod.gml:2397
_hm.wait_ticks=max(0,1); _hm.pc=39; return;
break;
case 41: // maincode.mod.gml:2390
{
if (instance_exists(id)) {
{
y -= 1;
;
if ((random(1) < 0.5)) {
instance_create(x, (y + 16), Dust);
}
if ((random(1) < 0.5)) {
instance_create((x + 16), (y + 16), Dust);
}
}
}
}
_hm.pc=40;
break;
case 37: // maincode.mod.gml:2389
_hm.pc=(_hm.vars.__hm_repeat185>0)?41:36;
break;
case 42: // maincode.mod.gml:2389
_hm.vars.__hm_repeat185=round(16); _hm.pc=37;
break;
case 43: // maincode.mod.gml:2388
_hm.pc = (scrHMTaskFork(_hm, 42)) ? 42 : 33;
break;
case 44: // maincode.mod.gml:2382
{
open = 1;
;
mask_index = mskNone;
;
{ var __hm_with186 = scrHMInstances(instance_nearest((x + 16), (y + 16), Player)), __hm_break188=false;
for (var __hm_index187=0; __hm_index187<array_length(__hm_with186); ++__hm_index187) {
if(instance_exists(__hm_with186[__hm_index187])) with (__hm_with186[__hm_index187]) {
scrHMSoundPlay(snd_chst);
}
if(__hm_break188) break;
}}
;
}
_hm.pc=43;
break;
case 45: // maincode.mod.gml:2379
_hm.pc = ((((! open) && instance_exists(Player)) && (distance_to_object(Player) <= 1))) ? 44 : 17;
break;
case 15: // maincode.mod.gml:2378
_hm.pc=(instance_exists(_hm.scope))?45:14;
break;
case 46: // maincode.mod.gml:2377
_hm.pc = (scrHMTaskFork(_hm, 15)) ? 15 : 11;
break;
case 47: // maincode.mod.gml:2368
{
global.hm_module_vars[$ "mod:maincode"].door = id;
;
open = 0;
;
{ var __hm_with189 = scrHMInstances(InvisiWall), __hm_break191=false;
for (var __hm_index190=0; __hm_index190<array_length(__hm_with189); ++__hm_index190) {
if(instance_exists(__hm_with189[__hm_index190])) with (__hm_with189[__hm_index190]) {
if (place_meeting(x, y, (scrHMOther(other)))) {
instance_destroy();
}
}
if(__hm_break191) break;
}}
repeat (4) { var __hm_with192 = scrHMInstances(instance_create((x + irandom(16)), ((y + 16) + irandom(4)), Effect)), __hm_break194=false;
for (var __hm_index193=0; __hm_index193<array_length(__hm_with192); ++__hm_index193) {
if(instance_exists(__hm_with192[__hm_index193])) with (__hm_with192[__hm_index193]) {
{
sprite_index = sprMoney;
image_angle = random(360);
}
}
if(__hm_break194) break;
}}
}
_hm.pc=46;
break;
case 48: // maincode.mod.gml:2360
_hm.pc = (((((((((global.hm_module_vars[$ "mod:maincode"].door == noone) && (distance_to_object(Player) >= 64)) && (! place_free((x - 16), y))) && (! place_free((x + 16), y))) && (! place_free(x, (y - 16)))) && (! place_free((x - 16), (y - 16)))) && (! place_free((x + 16), (y - 16)))) && place_free(x, (y + 16)))) ? 47 : 11;
break;
case 49: // maincode.mod.gml:2359
scrHMTaskWithEnter(_hm,scrHMAuthoredWalls105(),48,9);
break;
case 50: // maincode.mod.gml:2358
{
global.hm_module_vars[$ "mod:maincode"].gce = 0;
;
}
_hm.pc=49;
break;
case 51: // maincode.mod.gml:2357
_hm.pc = (global.hm_module_vars[$ "mod:maincode"].gce) ? 50 : 9;
break;
case 52: // maincode.mod.gml:2352
_hm.pc = (instance_exists(GenCont)) ? 10 : 51;
break;
case 53: // maincode.mod.gml:2336
{
{ var __hm_with195 = scrHMInstances(GenCont), __hm_break197=false;
for (var __hm_index196=0; __hm_index196<array_length(__hm_with195); ++__hm_index196) {
if(instance_exists(__hm_with195[__hm_index196])) with (__hm_with195[__hm_index196]) {
if ((!scrHMVariableExists(id, "settip"))) {
{
if ((random(3) < 2)) {
tip = "those 2 levels took 14 hours to port";
} else {
tip = "moni in wall???";
}
settip = 1;
}
}
}
if(__hm_break197) break;
}}
{ var __hm_with198 = scrHMInstances(SpiralCont), __hm_break200=false;
for (var __hm_index199=0; __hm_index199<array_length(__hm_with198); ++__hm_index199) {
if(instance_exists(__hm_with198[__hm_index199])) with (__hm_with198[__hm_index199]) {
type = 4;
}
if(__hm_break200) break;
}}
;
{ var __hm_with201 = scrHMInstances(Spiral), __hm_break203=false;
for (var __hm_index202=0; __hm_index202<array_length(__hm_with201); ++__hm_index202) {
if(instance_exists(__hm_with201[__hm_index202])) with (__hm_with201[__hm_index202]) {
{
type = 4;
;
sprite_index = mskNone;
}
}
if(__hm_break203) break;
}}
{ var __hm_with204 = scrHMInstances(EnemyBullet1), __hm_break206=false;
for (var __hm_index205=0; __hm_index205<array_length(__hm_with204); ++__hm_index205) {
if(instance_exists(__hm_with204[__hm_index205])) with (__hm_with204[__hm_index205]) {
speed = (6) * timescale;
}
if(__hm_break206) break;
}}
{ var __hm_with207 = scrHMMatchingNE(EnemyBullet3, "weee", 1), __hm_break209=false;
for (var __hm_index208=0; __hm_index208<array_length(__hm_with207); ++__hm_index208) {
if(instance_exists(__hm_with207[__hm_index208])) with (__hm_with207[__hm_index208]) {
{
speed *= 1.5;
weee = 1;
}
}
if(__hm_break209) break;
}}
}
_hm.pc=52;
break;
case 54: // maincode.mod.gml:2334
{
;
}
_hm.pc=53;
break;
case 55: // maincode.mod.gml:2334
_hm.pc=0;
break;
case 56: // maincode.mod.gml:2297
{
if ((GameCont.subarea == 12)) {
{
{ var __hm_with210 = scrHMInstances(InvisiWall), __hm_break212=false;
for (var __hm_index211=0; __hm_index211<array_length(__hm_with210); ++__hm_index211) {
if(instance_exists(__hm_with210[__hm_index211])) with (__hm_with210[__hm_index211]) {
{
if ((y > 314)) {
y -= 1;
}
if ((x < 58)) {
x += 1;
}
if ((x > 378)) {
x -= 1;
}
}
}
if(__hm_break212) break;
}}
{ var __hm_with213 = scrHMInstances(Explosion), __hm_break215=false;
for (var __hm_index214=0; __hm_index214<array_length(__hm_with213); ++__hm_index214) {
if(instance_exists(__hm_with213[__hm_index214])) with (__hm_with213[__hm_index214]) {
if (place_meeting(x, y, Floor)) {
if ((random(100) < 1)) {
instance_create(x, y, AmmoPickup);
}
}
}
if(__hm_break215) break;
}}
}
}
if ((((GameCont.subarea > 9) and (GameCont.subarea < 99)) || (GameCont.subarea == 200))) {
{
{ var __hm_with216 = scrHMInstances(instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), CaveSparkle)), __hm_break218=false;
for (var __hm_index217=0; __hm_index217<array_length(__hm_with216); ++__hm_index217) {
if(instance_exists(__hm_with216[__hm_index217])) with (__hm_with216[__hm_index217]) {
{
depth = 21;
image_angle = random(360);
if (((x < 10176) and (x > 9856))) {
image_alpha = 0;
}
}
}
if(__hm_break218) break;
}}
{ var __hm_with219 = scrHMInstances(Debris), __hm_break221=false;
for (var __hm_index220=0; __hm_index220<array_length(__hm_with219); ++__hm_index220) {
if(instance_exists(__hm_with219[__hm_index220])) with (__hm_with219[__hm_index220]) {
if ((! place_meeting(x, y, Floor))) {
vspeed = (2) * timescale;
}
}
if(__hm_break221) break;
}}
}
}
{ var __hm_with222 = scrHMInstances(Feather), __hm_break224=false;
for (var __hm_index223=0; __hm_index223<array_length(__hm_with222); ++__hm_index223) {
if(instance_exists(__hm_with222[__hm_index223])) with (__hm_with222[__hm_index223]) {
{
if ((! place_meeting(x, y, Floor))) {
{
vspeed += (1) * timescale;
fall += 1;
}
}
if (((distance_to_object(Dust) < 8) and (Dust.sprite_index == sprGroundFlame))) {
{
{ var __hm_with225 = scrHMInstances(instance_create(x, y, Flame)), __hm_break227=false;
for (var __hm_index226=0; __hm_index226<array_length(__hm_with225); ++__hm_index226) {
if(instance_exists(__hm_with225[__hm_index226])) with (__hm_with225[__hm_index226]) {
team = 2;
}
if(__hm_break227) break;
}}
instance_destroy();
}
}
}
}
if(__hm_break224) break;
}}
{ var __hm_with228 = scrHMMatching(Corpse, "sprite_index", sprMoneyPileDead), __hm_break230=false;
for (var __hm_index229=0; __hm_index229<array_length(__hm_with228); ++__hm_index229) {
if(instance_exists(__hm_with228[__hm_index229])) with (__hm_with228[__hm_index229]) {
if (((distance_to_object(Dust) < 8) and (Dust.sprite_index == sprGroundFlame))) {
{
{ var __hm_with231 = scrHMInstances(instance_create(x, y, Flame)), __hm_break233=false;
for (var __hm_index232=0; __hm_index232<array_length(__hm_with231); ++__hm_index232) {
if(instance_exists(__hm_with231[__hm_index232])) with (__hm_with231[__hm_index232]) {
team = 2;
}
if(__hm_break233) break;
}}
instance_destroy();
}
}
}
if(__hm_break230) break;
}}
}
_hm.pc=55;
break;
case 57: // maincode.mod.gml:2236
scrHMTaskWithNext(_hm);
break;
case 58: // maincode.mod.gml:2236
scrHMTaskWithAbort(_hm);
break;
case 59: // maincode.mod.gml:2275
{
if ((instance_exists(id) and (ind_ > instance_number(Player)))) {
{
scrHMModCall("mod", "enemies", "prisoner_create", x, y);
;
}
}
instance_destroy();
}
_hm.pc=57;
break;
case 60: // maincode.mod.gml:2259
scrHMTaskWithNext(_hm);
break;
case 61: // maincode.mod.gml:2259
scrHMTaskWithAbort(_hm);
break;
case 62: // maincode.mod.gml:2272
{
;
}
_hm.pc=60;
break;
case 63: // maincode.mod.gml:2272
_hm.result=undefined; _hm.done=true; return;
break;
case 64: // maincode.mod.gml:2262
{
if (instance_exists(id)) {
{ var __hm_with234 = scrHMInstances(instance_nearest(x, (y - 64), enemy)), __hm_break236=false;
for (var __hm_index235=0; __hm_index235<array_length(__hm_with234); ++__hm_index235) {
if(instance_exists(__hm_with234[__hm_index235])) with (__hm_with234[__hm_index235]) {
{
weapondrop = 0;
hp = 1;
}
}
if(__hm_break236) break;
}}
}
wep = scrHMWeaponResolve("secretweapong1");
ammo[1] = 20;
ammo[1] -= 1;
scrHMPlayerFire(90);
}
_hm.pc=63;
break;
case 65: // maincode.mod.gml:2261
_hm.wait_ticks=max(0,1); _hm.pc=64; return;
break;
case 66: // maincode.mod.gml:2260
_hm.pc = (scrHMTaskFork(_hm, 65)) ? 65 : 60;
break;
case 67: // maincode.mod.gml:2259
scrHMTaskWithEnter(_hm,scrHMMatching(Player, "index", 0),66,59);
break;
case 68: // maincode.mod.gml:2245
{
{ var __hm_with237 = scrHMMatching(Player, "index", ind_), __hm_break239=false;
for (var __hm_index238=0; __hm_index238<array_length(__hm_with237); ++__hm_index238) {
if(instance_exists(__hm_with237[__hm_index238])) with (__hm_with237[__hm_index238]) {
{
var __hm_other240=scrHMOther(other);
x = __hm_other240.x;
var __hm_other241=scrHMOther(other);
y = __hm_other241.y;
depth = (- 2);
visible = 1;
image_alpha = 1;
angle = 0;
speed = (0) * timescale;
can_shoot = 1;
can_spec = 1;
can_walk = 1;
canfly = 0;
;
}
}
if(__hm_break239) break;
}}
}
_hm.pc=67;
break;
case 69: // maincode.mod.gml:2244
_hm.pc = ((! instance_exists(GenCont))) ? 68 : 57;
break;
case 70: // maincode.mod.gml:2242
{
{ var __hm_with242 = scrHMInstances(scrHMBindDraw(hm_maincode_mod_gml_venuzfadein, (- 9))), __hm_break244=false;
for (var __hm_index243=0; __hm_index243<array_length(__hm_with242); ++__hm_index243) {
if(instance_exists(__hm_with242[__hm_index243])) with (__hm_with242[__hm_index243]) {
fade = 100;
}
if(__hm_break244) break;
}}
}
_hm.pc=69;
break;
case 71: // maincode.mod.gml:2281
{
{ var __hm_with245 = scrHMInstances(Player), __hm_break247=false;
for (var __hm_index246=0; __hm_index246<array_length(__hm_with245); ++__hm_index246) {
if(instance_exists(__hm_with245[__hm_index246])) with (__hm_with245[__hm_index246]) {
{
var __hm_other248=scrHMOther(other);
x = __hm_other248.x;
var __hm_other249=scrHMOther(other);
y = __hm_other249.y;
}
}
if(__hm_break247) break;
}}
if (instance_exists(id)) {
{
instance_destroy();
}
}
}
_hm.pc=57;
break;
case 72: // maincode.mod.gml:2241
_hm.pc = ((GameCont.subarea == 1)) ? 70 : 71;
break;
case 73: // maincode.mod.gml:2238
{
{ var __hm_with250 = scrHMInstances(Player), __hm_break252=false;
for (var __hm_index251=0; __hm_index251<array_length(__hm_with250); ++__hm_index251) {
if(instance_exists(__hm_with250[__hm_index251])) with (__hm_with250[__hm_index251]) {
var __hm_other253=scrHMOther(other);
hm_maincode_mod_gml_move_player_snap(index, __hm_other253.x, __hm_other253.y);
}
if(__hm_break252) break;
}}
}
_hm.pc=72;
break;
case 74: // maincode.mod.gml:2236
scrHMTaskWithEnter(_hm,scrHMMatching(CustomObject, "name", "spawnpoint"),73,56);
break;
case 75: // maincode.mod.gml:2134
{
{ var __hm_with254 = scrHMMatching(scrHMAuthoredWalls105(), "thing", undefined), __hm_break256=false;
for (var __hm_index255=0; __hm_index255<array_length(__hm_with254); ++__hm_index255) {
if(instance_exists(__hm_with254[__hm_index255])) with (__hm_with254[__hm_index255]) {
{
thing = 1;
instance_create(x, y, InvisiWall);
}
}
if(__hm_break256) break;
}}
{ var __hm_with257 = scrHMMatching(FloorExplo, "thing", undefined), __hm_break259=false;
for (var __hm_index258=0; __hm_index258<array_length(__hm_with257); ++__hm_index258) {
if(instance_exists(__hm_with257[__hm_index258])) with (__hm_with257[__hm_index258]) {
{
thing = 1;
thing2 = 3;
}
}
if(__hm_break259) break;
}}
{ var __hm_with260 = scrHMMatchingGT(FloorExplo, "thing2", 0), __hm_break262=false;
for (var __hm_index261=0; __hm_index261<array_length(__hm_with260); ++__hm_index261) {
if(instance_exists(__hm_with260[__hm_index261])) with (__hm_with260[__hm_index261]) {
{
thing2 -= choose(0, 0, 1);
}
}
if(__hm_break262) break;
}}
{ var __hm_with263 = scrHMMatching(FloorExplo, "thing2", 0), __hm_break265=false;
for (var __hm_index264=0; __hm_index264<array_length(__hm_with263); ++__hm_index264) {
if(instance_exists(__hm_with263[__hm_index264])) with (__hm_with263[__hm_index264]) {
if ((! instance_exists(Portal))) {
{
instance_create(x, y, Wall);
instance_destroy();
}
}
}
if(__hm_break265) break;
}}
{ var __hm_with266 = scrHMMatchingNE(hitme, "object_index", Player), __hm_break268=false;
for (var __hm_index267=0; __hm_index267<array_length(__hm_with266); ++__hm_index267) {
if(instance_exists(__hm_with266[__hm_index267])) with (__hm_with266[__hm_index267]) {
if (place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), InvisiWall)) {
move_bounce_solid(false);
}
}
if(__hm_break268) break;
}}
{ var __hm_with269 = scrHMMatching(CustomObject, "name", "VenuzElevator"), __hm_break271=false;
for (var __hm_index270=0; __hm_index270<array_length(__hm_with269); ++__hm_index270) {
if(instance_exists(__hm_with269[__hm_index270])) with (__hm_with269[__hm_index270]) {
{
if (place_meeting(x, y, Floor)) {
activated = 1;
}
if ((activated == 1)) {
{
{ var __hm_with272 = scrHMInstances(Wall), __hm_break274=false;
for (var __hm_index273=0; __hm_index273<array_length(__hm_with272); ++__hm_index273) {
if(instance_exists(__hm_with272[__hm_index273])) with (__hm_with272[__hm_index273]) {
if ((distance_to_object((scrHMOther(other))) < 16)) {
{
sprite_index = sprWall103Bot;
topspr = sprWall103Top;
outindex = 0;
outspr = sprWall103Out;
}
}
}
if(__hm_break274) break;
}}
{ var __hm_with275 = scrHMInstances(FloorExplo), __hm_break277=false;
for (var __hm_index276=0; __hm_index276<array_length(__hm_with275); ++__hm_index276) {
if(instance_exists(__hm_with275[__hm_index276])) with (__hm_with275[__hm_index276]) {
if ((distance_to_object((scrHMOther(other))) < 16)) {
sprite_index = sprFloor103Explo;
}
}
if(__hm_break277) break;
}}
}
}
}
}
if(__hm_break271) break;
}}
if ((((GameCont.subarea <= 6) and (GameCont.subarea > 3)) || (GameCont.subarea == 200))) {
{
{ var __hm_with278 = scrHMMatchingNE(hitme, "object_index", FireBaller, SuperFireBaller), __hm_break280=false;
for (var __hm_index279=0; __hm_index279<array_length(__hm_with278); ++__hm_index279) {
if(instance_exists(__hm_with278[__hm_index279])) with (__hm_with278[__hm_index279]) {
if (((scrHMVariableExists(id, "right") and ((object_index == Player) || (distance_to_object(Player) < (view_width * 2)))) and (!scrHMVariableExists(id, "boss")))) {
{
image_alpha = 0;
{ var __hm_with281 = scrHMInstances(scrHMBindDraw(hm_maincode_mod_gml_spacesewerboi, depth)), __hm_break283=false;
for (var __hm_index282=0; __hm_index282<array_length(__hm_with281); ++__hm_index282) {
if(instance_exists(__hm_with281[__hm_index282])) with (__hm_with281[__hm_index282]) {
var __hm_other284=scrHMOther(other);
creator = __hm_other284;
}
if(__hm_break283) break;
}}
}
}
}
if(__hm_break280) break;
}}
}
}
if ((GameCont.subarea == 7)) {
{ var __hm_with285 = scrHMMatching(Player, "image_alpha", 0), __hm_break287=false;
for (var __hm_index286=0; __hm_index286<array_length(__hm_with285); ++__hm_index286) {
if(instance_exists(__hm_with285[__hm_index286])) with (__hm_with285[__hm_index286]) {
image_alpha = 1;
}
if(__hm_break287) break;
}}
}
{ var __hm_with288 = scrHMMatching(CustomObject, "name", "window"), __hm_break290=false;
for (var __hm_index289=0; __hm_index289<array_length(__hm_with288); ++__hm_index289) {
if(instance_exists(__hm_with288[__hm_index289])) with (__hm_with288[__hm_index289]) {
{
image_alpha = 0;
sprite_index = sprCaveSparkle;
if ((distance_to_object(Wall) <= 14)) {
scrHMDelete(instance_nearest(x, (y + 4), Wall));
}
if ((distance_to_object(TopSmall) <= 14)) {
scrHMDelete(instance_nearest(x, (y + 4), TopSmall));
}
}
}
if(__hm_break290) break;
}}
{ var __hm_with291 = scrHMMatching(DustOLD, "imasecret", 1), __hm_break293=false;
for (var __hm_index292=0; __hm_index292<array_length(__hm_with291); ++__hm_index292) {
if(instance_exists(__hm_with291[__hm_index292])) with (__hm_with291[__hm_index292]) {
if (instance_exists(Wall)) {
{
{ var __hm_with294 = scrHMInstances(instance_create(x, y, Effect)), __hm_break296=false;
for (var __hm_index295=0; __hm_index295<array_length(__hm_with294); ++__hm_index295) {
if(instance_exists(__hm_with294[__hm_index295])) with (__hm_with294[__hm_index295]) {
{
sprite_index = (instance_nearest(x, y, Wall)).sprite_index;
image_speed = (0) * timescale;
secret = 1;
}
}
if(__hm_break296) break;
}}
{ var __hm_with297 = scrHMInstances(instance_create(x, (y + 16), Effect)), __hm_break299=false;
for (var __hm_index298=0; __hm_index298<array_length(__hm_with297); ++__hm_index298) {
if(instance_exists(__hm_with297[__hm_index298])) with (__hm_with297[__hm_index298]) {
{
sprite_index = (instance_nearest(x, (y + 16), Wall)).sprite_index;
image_speed = (0) * timescale;
secret = 1;
}
}
if(__hm_break299) break;
}}
{ var __hm_with300 = scrHMInstances(instance_create((x + 16), (y + 16), Effect)), __hm_break302=false;
for (var __hm_index301=0; __hm_index301<array_length(__hm_with300); ++__hm_index301) {
if(instance_exists(__hm_with300[__hm_index301])) with (__hm_with300[__hm_index301]) {
{
sprite_index = (instance_nearest((x + 16), y, Wall)).sprite_index;
image_speed = (0) * timescale;
secret = 1;
}
}
if(__hm_break302) break;
}}
{ var __hm_with303 = scrHMInstances(instance_create((x + 16), y, Effect)), __hm_break305=false;
for (var __hm_index304=0; __hm_index304<array_length(__hm_with303); ++__hm_index304) {
if(instance_exists(__hm_with303[__hm_index304])) with (__hm_with303[__hm_index304]) {
{
sprite_index = (instance_nearest((x + 16), (y + 16), Wall)).sprite_index;
image_speed = (0) * timescale;
secret = 1;
}
}
if(__hm_break305) break;
}}
{ var __hm_with306 = scrHMInstances(instance_create(x, (y - 8), Effect)), __hm_break308=false;
for (var __hm_index307=0; __hm_index307<array_length(__hm_with306); ++__hm_index307) {
if(instance_exists(__hm_with306[__hm_index307])) with (__hm_with306[__hm_index307]) {
{
sprite_index = (instance_nearest((x + 16), ((y + 16) + 16), TopSmall)).sprite_index;
image_speed = (0) * timescale;
depth = (- 10);
secret = 1;
}
}
if(__hm_break308) break;
}}
{ var __hm_with309 = scrHMInstances(instance_create(x, ((y + 16) - 8), Effect)), __hm_break311=false;
for (var __hm_index310=0; __hm_index310<array_length(__hm_with309); ++__hm_index310) {
if(instance_exists(__hm_with309[__hm_index310])) with (__hm_with309[__hm_index310]) {
{
sprite_index = (instance_nearest((x + 16), ((y + 16) + 16), TopSmall)).sprite_index;
image_speed = (0) * timescale;
depth = (- 10);
secret = 1;
}
}
if(__hm_break311) break;
}}
{ var __hm_with312 = scrHMInstances(instance_create((x + 16), ((y + 16) - 8), Effect)), __hm_break314=false;
for (var __hm_index313=0; __hm_index313<array_length(__hm_with312); ++__hm_index313) {
if(instance_exists(__hm_with312[__hm_index313])) with (__hm_with312[__hm_index313]) {
{
sprite_index = (instance_nearest((x + 16), ((y + 16) + 16), TopSmall)).sprite_index;
image_speed = (0) * timescale;
depth = (- 10);
secret = 1;
}
}
if(__hm_break314) break;
}}
{ var __hm_with315 = scrHMInstances(instance_create((x + 16), (y - 8), Effect)), __hm_break317=false;
for (var __hm_index316=0; __hm_index316<array_length(__hm_with315); ++__hm_index316) {
if(instance_exists(__hm_with315[__hm_index316])) with (__hm_with315[__hm_index316]) {
{
sprite_index = (instance_nearest((x + 16), (y + 16), TopSmall)).sprite_index;
image_speed = (0) * timescale;
depth = (- 10);
secret = 1;
}
}
if(__hm_break317) break;
}}
name = "imadoor";
}
}
}
if(__hm_break293) break;
}}
}
_hm.pc=74;
break;
case 76: // maincode.mod.gml:2044
scrHMTaskWithNext(_hm);
break;
case 77: // maincode.mod.gml:2044
scrHMTaskWithAbort(_hm);
break;
case 78: // maincode.mod.gml:2127
{
;
}
_hm.pc=76;
break;
case 79: // maincode.mod.gml:2127
_hm.result=undefined; _hm.done=true; return;
break;
case 81: // maincode.mod.gml:2110
_hm.vars.__hm_repeat318--; _hm.pc=80;
break;
case 82: // maincode.mod.gml:2125
_hm.wait_ticks=max(0,1); _hm.pc=81; return;
break;
case 83: // maincode.mod.gml:2111
{
{ var __hm_with319 = scrHMInstances(Player), __hm_break321=false;
for (var __hm_index320=0; __hm_index320<array_length(__hm_with319); ++__hm_index320) {
if(instance_exists(__hm_with319[__hm_index320])) with (__hm_with319[__hm_index320]) {
{
can_die = 1;
hp = max_hp;
wep = scrHMWeaponResolve(_hm.vars.w1);
if (((GameCont.subarea != 12) and (GameCont.subarea != 11))) {
{
ammo[1] = 30;
ammo[2] = 0;
ammo[3] = 0;
ammo[4] = 0;
ammo[5] = 0;
}
}
bwep = scrHMWeaponResolve(_hm.vars.w2);
scrHMMotionAdd(random(360), 1);
}
}
if(__hm_break321) break;
}}
}
_hm.pc=82;
break;
case 80: // maincode.mod.gml:2110
_hm.pc=(_hm.vars.__hm_repeat318>0)?83:79;
break;
case 84: // maincode.mod.gml:2110
_hm.vars.__hm_repeat318=round(10); _hm.pc=80;
break;
case 85: // maincode.mod.gml:2109
_hm.pc = (scrHMTaskFork(_hm, 84)) ? 84 : 76;
break;
case 86: // maincode.mod.gml:2075
{
{ var __hm_with322 = scrHMMatching(CustomObject, "name", "VenuzElevator"), __hm_break324=false;
for (var __hm_index323=0; __hm_index323<array_length(__hm_with322); ++__hm_index323) {
if(instance_exists(__hm_with322[__hm_index323])) with (__hm_with322[__hm_index323]) {
scrHMDelete(id);
}
if(__hm_break324) break;
}}
{ var __hm_with325 = scrHMInstances(instance_create((x - 8), (y - 8), CustomObject)), __hm_break327=false;
for (var __hm_index326=0; __hm_index326<array_length(__hm_with325); ++__hm_index326) {
if(instance_exists(__hm_with325[__hm_index326])) with (__hm_with325[__hm_index326]) {
{
name = "VenuzElevator";
image_speed = (0) * timescale;
sprite_index = sprFloor103;
image_alpha = 0;
image_index = 1;
depth = 7;
activated = 1;
if ((GameCont.subarea > 0)) {
GameCont.subarea -= 1;
}
}
}
if(__hm_break327) break;
}}
hp = max_hp;
can_die = 1;
_hm.vars.w1 = "secretweapong1";
;
_hm.vars.w2 = 0;
if ((GameCont.subarea == 11)) {
{
_hm.vars.w1 = wep;
_hm.vars.w2 = bwep;
}
} else {
{
ammo[1] = 30;
ammo[2] = 0;
ammo[3] = 0;
ammo[4] = 0;
ammo[5] = 0;
}
}
wep = scrHMWeaponResolve(_hm.vars.w1);
bwep = scrHMWeaponResolve(_hm.vars.w2);
{ var __hm_with328 = scrHMInstances(Revive), __hm_break330=false;
for (var __hm_index329=0; __hm_index329<array_length(__hm_with328); ++__hm_index329) {
if(instance_exists(__hm_with328[__hm_index329])) with (__hm_with328[__hm_index329]) {
{
x = (instance_nearest(x, y, Player)).x;
y = (instance_nearest(x, y, Player)).y;
}
}
if(__hm_break330) break;
}}
}
_hm.pc=85;
break;
case 87: // maincode.mod.gml:2074
_hm.pc = (((can_die == 0) and (hp <= 0))) ? 86 : 76;
break;
case 88: // maincode.mod.gml:2045
{
if ((scrHMButtonPressed(index, "okay") and scrHMButtonCheck(index, "horn"))) {
{
{ var __hm_with331 = scrHMMatching(CustomObject, "name", "VenuzElevator"), __hm_break333=false;
for (var __hm_index332=0; __hm_index332<array_length(__hm_with331); ++__hm_index332) {
if(instance_exists(__hm_with331[__hm_index332])) with (__hm_with331[__hm_index332]) {
scrHMDelete(id);
}
if(__hm_break333) break;
}}
{ var __hm_with334 = scrHMInstances(instance_create((x - 8), (y - 8), CustomObject)), __hm_break336=false;
for (var __hm_index335=0; __hm_index335<array_length(__hm_with334); ++__hm_index335) {
if(instance_exists(__hm_with334[__hm_index335])) with (__hm_with334[__hm_index335]) {
{
name = "VenuzElevator";
image_speed = (0) * timescale;
sprite_index = sprFloor103;
image_alpha = 0;
image_index = 1;
depth = 7;
activated = 1;
if ((GameCont.subarea > 0)) {
GameCont.subarea -= 1;
}
}
}
if(__hm_break336) break;
}}
}
}
if (((GameCont.subarea == 300) and (instance_number(enemy) <= 1) and scrHMVenusAutoExit106())) {
{ var __hm_with337 = scrHMInstances(instance_create((x - 8), (y - 8), CustomObject)), __hm_break339=false;
for (var __hm_index338=0; __hm_index338<array_length(__hm_with337); ++__hm_index338) {
if(instance_exists(__hm_with337[__hm_index338])) with (__hm_with337[__hm_index338]) {
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
if(__hm_break339) break;
}}
}
if ((instance_number(Player) <= 1)) {
can_die = 0;
}
}
_hm.pc=87;
break;
case 89: // maincode.mod.gml:2044
scrHMTaskWithEnter(_hm,scrHMInstances(Player),88,75);
break;
case 90: // maincode.mod.gml:2037
{
scrHMSoundStop(mus1);
;
scrHMSoundStop(mus1b);
;
scrHMSoundStop(mus3);
;
scrHMSoundStop(mus3b);
;
{ var __hm_with340 = scrHMInstances(SpiralCont), __hm_break342=false;
for (var __hm_index341=0; __hm_index341<array_length(__hm_with340); ++__hm_index341) {
if(instance_exists(__hm_with340[__hm_index341])) with (__hm_with340[__hm_index341]) {
type = 4;
}
if(__hm_break342) break;
}}
;
{ var __hm_with343 = scrHMInstances(Spiral), __hm_break345=false;
for (var __hm_index344=0; __hm_index344<array_length(__hm_with343); ++__hm_index344) {
if(instance_exists(__hm_with343[__hm_index344])) with (__hm_with343[__hm_index344]) {
{
type = 4;
;
sprite_index = mskNone;
}
}
if(__hm_break345) break;
}}
}
_hm.pc=89;
break;
case 91: // maincode.mod.gml:2034
{
;
}
_hm.pc=90;
break;
case 92: // maincode.mod.gml:2034
_hm.pc=0;
break;
case 93: // maincode.mod.gml:2029
{
{ var __hm_with346 = scrHMInstances(WantPopo), __hm_break348=false;
for (var __hm_index347=0; __hm_index347<array_length(__hm_with346); ++__hm_index347) {
if(instance_exists(__hm_with346[__hm_index347])) with (__hm_with346[__hm_index347]) {
instance_destroy();
}
if(__hm_break348) break;
}}
{ var __hm_with349 = scrHMInstances(IDPDSpawn), __hm_break351=false;
for (var __hm_index350=0; __hm_index350<array_length(__hm_with349); ++__hm_index350) {
if(instance_exists(__hm_with349[__hm_index350])) with (__hm_with349[__hm_index350]) {
instance_destroy();
}
if(__hm_break351) break;
}}
scrHMSoundStop(sndIDPDPortalSpawn);
;
scrHMSoundStop(sndEliteIDPDPortalSpawn);
;
}
_hm.pc=92;
break;
case 94: // maincode.mod.gml:2027
{
;
}
_hm.pc=93;
break;
case 95: // maincode.mod.gml:2027
_hm.pc=0;
break;
case 96: // maincode.mod.gml:2007
{
{ var __hm_with352 = scrHMMatching(Nothing2, "mask_index", mskNone), __hm_break354=false;
for (var __hm_index353=0; __hm_index353<array_length(__hm_with352); ++__hm_index353) {
if(instance_exists(__hm_with352[__hm_index353])) with (__hm_with352[__hm_index353]) {
{
x = 0;
y = 0;
alarm[0] = (- 1);
alarm[1] = (- 1);
alarm[2] = (- 1);
alarm[3] = (- 1);
intro = (- 1);
mask_index = mskNone;
}
}
if(__hm_break354) break;
}}
{ var __hm_with355 = scrHMInstances(Portal), __hm_break357=false;
for (var __hm_index356=0; __hm_index356<array_length(__hm_with355); ++__hm_index356) {
if(instance_exists(__hm_with355[__hm_index356])) with (__hm_with355[__hm_index356]) {
if (instance_exists(Player)) {
{
_hm.vars.np_ = instance_nearest(x, y, Player);
;
x = _hm.vars.np_.x;
y = (_hm.vars.np_.y + 2);
image_alpha = 0;
image_speed = (0.2) * timescale;
}
}
}
if(__hm_break357) break;
}}
{ var __hm_with358 = scrHMMatchingNE(Portal, "nokill", 1), __hm_break360=false;
for (var __hm_index359=0; __hm_index359<array_length(__hm_with358); ++__hm_index359) {
if(instance_exists(__hm_with358[__hm_index359])) with (__hm_with358[__hm_index359]) {
instance_destroy();
}
if(__hm_break360) break;
}}
}
_hm.pc=95;
break;
case 97: // maincode.mod.gml:1916
scrHMTaskWithNext(_hm);
break;
case 98: // maincode.mod.gml:1916
scrHMTaskWithAbort(_hm);
break;
case 99: // maincode.mod.gml:1993
{
if ((y > (portalfall + 4000))) {
{
{ var __hm_with361 = scrHMInstances(instance_create(x, y, Portal)), __hm_break363=false;
for (var __hm_index362=0; __hm_index362<array_length(__hm_with361); ++__hm_index362) {
if(instance_exists(__hm_with361[__hm_index362])) with (__hm_with361[__hm_index362]) {
{
nokill = 1;
nompportal = 1;
endgame = 0;
scrHMSoundStopAll();
}
}
if(__hm_break363) break;
}}
spr_shadow_y = 0;
fallenable = (- 1);
scrHMThroneFall107(false);
sprite_angle = 0;
scrHMSoundMusic(musCredits);
}
}
}
_hm.pc=97;
break;
case 100: // maincode.mod.gml:1984
{
if (instance_exists(id)) {
{ var __hm_with364 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break366=false;
for (var __hm_index365=0; __hm_index365<array_length(__hm_with364); ++__hm_index365) {
if(instance_exists(__hm_with364[__hm_index365])) with (__hm_with364[__hm_index365]) {
{
name = "credits";
sprite_index = global.hm_module_vars[$ "mod:maincode"].YALCredits;
image_speed = (0) * timescale;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break366) break;
}}
}
}
_hm.pc=99;
break;
case 101: // maincode.mod.gml:1983
_hm.wait_ticks=max(0,50); _hm.pc=100; return;
break;
case 102: // maincode.mod.gml:1975
{
if (instance_exists(id)) {
{ var __hm_with367 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break369=false;
for (var __hm_index368=0; __hm_index368<array_length(__hm_with367); ++__hm_index368) {
if(instance_exists(__hm_with367[__hm_index368])) with (__hm_with367[__hm_index368]) {
{
name = "credits";
sprite_index = sprCreditsTeam;
image_speed = (0) * timescale;
image_index = 5;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break369) break;
}}
}
}
_hm.pc=101;
break;
case 103: // maincode.mod.gml:1974
_hm.wait_ticks=max(0,15); _hm.pc=102; return;
break;
case 104: // maincode.mod.gml:1966
{
if (instance_exists(id)) {
{ var __hm_with370 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break372=false;
for (var __hm_index371=0; __hm_index371<array_length(__hm_with370); ++__hm_index371) {
if(instance_exists(__hm_with370[__hm_index371])) with (__hm_with370[__hm_index371]) {
{
name = "credits";
sprite_index = sprCreditsTeam;
image_speed = (0) * timescale;
image_index = 4;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break372) break;
}}
}
}
_hm.pc=103;
break;
case 105: // maincode.mod.gml:1965
_hm.wait_ticks=max(0,15); _hm.pc=104; return;
break;
case 106: // maincode.mod.gml:1957
{
if (instance_exists(id)) {
{ var __hm_with373 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break375=false;
for (var __hm_index374=0; __hm_index374<array_length(__hm_with373); ++__hm_index374) {
if(instance_exists(__hm_with373[__hm_index374])) with (__hm_with373[__hm_index374]) {
{
name = "credits";
sprite_index = sprCreditsTeam;
image_speed = (0) * timescale;
image_index = 3;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break375) break;
}}
}
}
_hm.pc=105;
break;
case 107: // maincode.mod.gml:1956
_hm.wait_ticks=max(0,15); _hm.pc=106; return;
break;
case 108: // maincode.mod.gml:1948
{
if (instance_exists(id)) {
{ var __hm_with376 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break378=false;
for (var __hm_index377=0; __hm_index377<array_length(__hm_with376); ++__hm_index377) {
if(instance_exists(__hm_with376[__hm_index377])) with (__hm_with376[__hm_index377]) {
{
name = "credits";
sprite_index = sprCreditsTeam;
image_speed = (0) * timescale;
image_index = 2;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break378) break;
}}
}
}
_hm.pc=107;
break;
case 109: // maincode.mod.gml:1947
_hm.wait_ticks=max(0,50); _hm.pc=108; return;
break;
case 110: // maincode.mod.gml:1939
{
if (instance_exists(id)) {
{ var __hm_with379 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break381=false;
for (var __hm_index380=0; __hm_index380<array_length(__hm_with379); ++__hm_index380) {
if(instance_exists(__hm_with379[__hm_index380])) with (__hm_with379[__hm_index380]) {
{
name = "credits";
sprite_index = sprCreditsTeam;
image_speed = (0) * timescale;
image_index = 1;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break381) break;
}}
}
}
_hm.pc=109;
break;
case 111: // maincode.mod.gml:1938
_hm.wait_ticks=max(0,10); _hm.pc=110; return;
break;
case 112: // maincode.mod.gml:1930
{
if (instance_exists(id)) {
{ var __hm_with382 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break384=false;
for (var __hm_index383=0; __hm_index383<array_length(__hm_with382); ++__hm_index383) {
if(instance_exists(__hm_with382[__hm_index383])) with (__hm_with382[__hm_index383]) {
{
name = "credits";
sprite_index = sprCreditsTeam;
image_speed = (0) * timescale;
image_index = 0;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break384) break;
}}
}
}
_hm.pc=111;
break;
case 113: // maincode.mod.gml:1929
_hm.pc = (scrHMTaskFork(_hm, 112)) ? 112 : 99;
break;
case 114: // maincode.mod.gml:1928
{
credits = instance_create(0, 0, CustomObject);
}
_hm.pc=113;
break;
case 115: // maincode.mod.gml:1927
_hm.pc = (((y > (portalfall + 2000)) and ((!scrHMVariableExists(_hm.scope, "credits")) || (! instance_exists(credits))))) ? 114 : 99;
break;
case 116: // maincode.mod.gml:1917
{
if (((! place_meeting(x, y, Floor)) and (distance_to_object(Portal) > 32))) {
{
scrHMThroneFall107(true);
sprite_angle += 15;
gunangle += 15;
y += 8;
spr_shadow_y = 10000;
}
} else {
{
scrHMThroneFall107(false);
sprite_angle = 0;
spr_shadow_y = 0;
}
}
}
_hm.pc=115;
break;
case 117: // maincode.mod.gml:1916
scrHMTaskWithEnter(_hm,scrHMMatching(Player, "fallenable", 1),116,96);
break;
case 118: // maincode.mod.gml:1892
{
if ((instance_number(SpiralCont) > 1)) {
{ var __hm_with385 = scrHMInstances(instance_nearest(0, 0, SpiralCont)), __hm_break387=false;
for (var __hm_index386=0; __hm_index386<array_length(__hm_with385); ++__hm_index386) {
if(instance_exists(__hm_with385[__hm_index386])) with (__hm_with385[__hm_index386]) {
scrHMDelete(id);
}
if(__hm_break387) break;
}}
}
{ var __hm_with388 = scrHMInstances(Nothing2Death), __hm_break390=false;
for (var __hm_index389=0; __hm_index389<array_length(__hm_with388); ++__hm_index389) {
if(instance_exists(__hm_with388[__hm_index389])) with (__hm_with388[__hm_index389]) {
{
scrHMSoundStop(musBoss4A);
;
scrHMSoundStop(musBoss4B);
;
{ var __hm_with391 = scrHMInstances(SpiralCont), __hm_break393=false;
for (var __hm_index392=0; __hm_index392<array_length(__hm_with391); ++__hm_index392) {
if(instance_exists(__hm_with391[__hm_index392])) with (__hm_with391[__hm_index392]) {
noreloadplease = 1;
}
if(__hm_break393) break;
}}
{ var __hm_with394 = scrHMInstances(InvisiWall), __hm_break396=false;
for (var __hm_index395=0; __hm_index395<array_length(__hm_with394); ++__hm_index395) {
if(instance_exists(__hm_with394[__hm_index395])) with (__hm_with394[__hm_index395]) {
instance_destroy();
}
if(__hm_break396) break;
}}
if ((instance_number(CustomEnemy) < 2)) {
{ var __hm_with397 = scrHMInstances(instance_create(0, 0, CustomEnemy)), __hm_break399=false;
for (var __hm_index398=0; __hm_index398<array_length(__hm_with397); ++__hm_index398) {
if(instance_exists(__hm_with397[__hm_index398])) with (__hm_with397[__hm_index398]) {
{
name = "portalblocker";
canfly = 1;
}
}
if(__hm_break399) break;
}}
}
{ var __hm_with400 = scrHMInstances(Portal), __hm_break402=false;
for (var __hm_index401=0; __hm_index401<array_length(__hm_with400); ++__hm_index401) {
if(instance_exists(__hm_with400[__hm_index401])) with (__hm_with400[__hm_index401]) {
instance_destroy();
}
if(__hm_break402) break;
}}
{ var __hm_with403 = scrHMInstances(Player), __hm_break405=false;
for (var __hm_index404=0; __hm_index404<array_length(__hm_with403); ++__hm_index404) {
if(instance_exists(__hm_with403[__hm_index404])) with (__hm_with403[__hm_index404]) {
if (((!scrHMVariableExists(id, "fallenable")) || (fallenable == (- 1)))) {
{
fallenable = 1;
portalfall = y;
}
}
}
if(__hm_break405) break;
}}
}
}
if(__hm_break390) break;
}}
{ var __hm_with406 = scrHMMatching(Effect, "name", "credits"), __hm_break408=false;
for (var __hm_index407=0; __hm_index407<array_length(__hm_with406); ++__hm_index407) {
if(instance_exists(__hm_with406[__hm_index407])) with (__hm_with406[__hm_index407]) {
{
image_angle += 14;
}
}
if(__hm_break408) break;
}}
}
_hm.pc=117;
break;
case 119: // maincode.mod.gml:1856
scrHMTaskWithNext(_hm);
break;
case 120: // maincode.mod.gml:1856
scrHMTaskWithAbort(_hm);
break;
case 121: // maincode.mod.gml:1861
{
;
{ var __hm_with409 = scrHMInstances(Floor), __hm_break411=false;
for (var __hm_index410=0; __hm_index410<array_length(__hm_with409); ++__hm_index410) {
if(instance_exists(__hm_with409[__hm_index410])) with (__hm_with409[__hm_index410]) {
if ((distance_to_object(Player) > 300)) {
instance_destroy();
}
}
if(__hm_break411) break;
}}
{ var __hm_with412 = scrHMInstances(Wall), __hm_break414=false;
for (var __hm_index413=0; __hm_index413<array_length(__hm_with412); ++__hm_index413) {
if(instance_exists(__hm_with412[__hm_index413])) with (__hm_with412[__hm_index413]) {
{
instance_create(x, y, InvisiWall);
instance_destroy();
}
}
if(__hm_break414) break;
}}
{ var __hm_with415 = scrHMInstances(Carpet), __hm_break417=false;
for (var __hm_index416=0; __hm_index416<array_length(__hm_with415); ++__hm_index416) {
if(instance_exists(__hm_with415[__hm_index416])) with (__hm_with415[__hm_index416]) {
instance_destroy();
}
if(__hm_break417) break;
}}
if (instance_exists(id)) {
{
instance_change(Wind, 1);
{ var __hm_with418 = scrHMInstances(Portal), __hm_break420=false;
for (var __hm_index419=0; __hm_index419<array_length(__hm_with418); ++__hm_index419) {
if(instance_exists(__hm_with418[__hm_index419])) with (__hm_with418[__hm_index419]) {
instance_destroy();
}
if(__hm_break420) break;
}}
{ var __hm_with421 = scrHMInstances(instance_create(x, y, SpiralCont)), __hm_break423=false;
for (var __hm_index422=0; __hm_index422<array_length(__hm_with421); ++__hm_index422) {
if(instance_exists(__hm_with421[__hm_index422])) with (__hm_with421[__hm_index422]) {
{
noreloadplease = 1;
depth = 10;
}
}
if(__hm_break423) break;
}}
scrHMModCall("mod", "throne", "throne_create", x, y);
{ var __hm_with424 = scrHMInstances(instance_create(0, 0, Nothing2)), __hm_break426=false;
for (var __hm_index425=0; __hm_index425<array_length(__hm_with424); ++__hm_index425) {
if(instance_exists(__hm_with424[__hm_index425])) with (__hm_with424[__hm_index425]) {
{
alarm[0] = (- 1);
alarm[1] = (- 1);
alarm[2] = (- 1);
alarm[3] = (- 1);
intro = (- 1);
image_alpha = 0;
mask_index = 0;
}
}
if(__hm_break426) break;
}}
instance_destroy();
}
}
}
_hm.pc=119;
break;
case 122: // maincode.mod.gml:1861
_hm.wait_ticks=max(0,100); _hm.pc=121; return;
break;
case 123: // maincode.mod.gml:1857
{
_hm.vars._x = x;
;
_hm.vars._y = y;
;
{ var __hm_with427 = scrHMInstances(SpiralCont), __hm_break429=false;
for (var __hm_index428=0; __hm_index428<array_length(__hm_with427); ++__hm_index428) {
if(instance_exists(__hm_with427[__hm_index428])) with (__hm_with427[__hm_index428]) {
noreloadplease = 1;
}
if(__hm_break429) break;
}}
}
_hm.pc=122;
break;
case 124: // maincode.mod.gml:1856
scrHMTaskWithEnter(_hm,scrHMInstances(NothingDeath),123,118);
break;
case 125: // maincode.mod.gml:1835
{
{ var __hm_with430 = scrHMInstances(NothingInactive), __hm_break432=false;
for (var __hm_index431=0; __hm_index431<array_length(__hm_with430); ++__hm_index431) {
if(instance_exists(__hm_with430[__hm_index431])) with (__hm_with430[__hm_index431]) {
{
{ var __hm_with433 = scrHMInstances(BigGenerator), __hm_break435=false;
for (var __hm_index434=0; __hm_index434<array_length(__hm_with433); ++__hm_index434) {
if(instance_exists(__hm_with433[__hm_index434])) with (__hm_with433[__hm_index434]) {
{
hp = 90;
sprite_index = sprBigGeneratorInactive;
}
}
if(__hm_break435) break;
}}
}
}
if(__hm_break432) break;
}}
{ var __hm_with436 = scrHMInstances(Nothing), __hm_break438=false;
for (var __hm_index437=0; __hm_index437<array_length(__hm_with436); ++__hm_index437) {
if(instance_exists(__hm_with436[__hm_index437])) with (__hm_with436[__hm_index437]) {
{
if (((hp < (max_hp - instance_number(BigGenerator))) and instance_exists(BigGenerator))) {
hp += (instance_number(BigGenerator) * 2);
}
if ((!scrHMVariableExists(id, "morehp"))) {
{
scrHMMaxHealthWrite(id, 1.6, "*=");
hp *= 1.6;
morehp = 1;
}
}
if (((! instance_exists(BigGenerator)) and (!scrHMVariableExists(id, "mohp")))) {
{
hp += 400;
mohp = 1;
}
}
}
}
if(__hm_break438) break;
}}
{ var __hm_with439 = scrHMMatching(enemy, "canfly", 0), __hm_break441=false;
for (var __hm_index440=0; __hm_index440<array_length(__hm_with439); ++__hm_index440) {
if(instance_exists(__hm_with439[__hm_index440])) with (__hm_with439[__hm_index440]) {
canfly = 1;
}
if(__hm_break441) break;
}}
}
_hm.pc=124;
break;
case 126: // maincode.mod.gml:1833
{
;
}
_hm.pc=125;
break;
case 127: // maincode.mod.gml:1833
_hm.pc=0;
break;
case 128: // maincode.mod.gml:1800
{
{ var __hm_with442 = scrHMInstances(Portal), __hm_break444=false;
for (var __hm_index443=0; __hm_index443<array_length(__hm_with442); ++__hm_index443) {
if(instance_exists(__hm_with442[__hm_index443])) with (__hm_with442[__hm_index443]) {
{
type = 2;
}
}
if(__hm_break444) break;
}}
{ var __hm_with445 = scrHMInstances(TopPot), __hm_break447=false;
for (var __hm_index446=0; __hm_index446<array_length(__hm_with445); ++__hm_index446) {
if(instance_exists(__hm_with445[__hm_index446])) with (__hm_with445[__hm_index446]) {
if (((place_meeting(x, ((y - 16) - 13), Wall) and (! place_meeting(x, ((y - 32) - 13), Wall))) and place_meeting(x, ((y - 32) - 13), Floor))) {
y -= 16;
}
}
if(__hm_break447) break;
}}
{ var __hm_with448 = scrHMMatchingNE(scrHMAuthoredWalls105(), "thing", 1), __hm_break450=false;
for (var __hm_index449=0; __hm_index449<array_length(__hm_with448); ++__hm_index449) {
if(instance_exists(__hm_with448[__hm_index449])) with (__hm_with448[__hm_index449]) {
{
thing = 1;
instance_create(x, y, InvisiWall);
}
}
if(__hm_break450) break;
}}
{ var __hm_with451 = scrHMMatchingNE(FloorExplo, "thing", 1), __hm_break453=false;
for (var __hm_index452=0; __hm_index452<array_length(__hm_with451); ++__hm_index452) {
if(instance_exists(__hm_with451[__hm_index452])) with (__hm_with451[__hm_index452]) {
{
thing = 1;
thing2 = 10;
}
}
if(__hm_break453) break;
}}
{ var __hm_with454 = scrHMMatchingGT(FloorExplo, "thing2", 0), __hm_break456=false;
for (var __hm_index455=0; __hm_index455<array_length(__hm_with454); ++__hm_index455) {
if(instance_exists(__hm_with454[__hm_index455])) with (__hm_with454[__hm_index455]) {
{
thing2 -= choose(0, 0, 1);
}
}
if(__hm_break456) break;
}}
{ var __hm_with457 = scrHMMatching(FloorExplo, "thing2", 0), __hm_break459=false;
for (var __hm_index458=0; __hm_index458<array_length(__hm_with457); ++__hm_index458) {
if(instance_exists(__hm_with457[__hm_index458])) with (__hm_with457[__hm_index458]) {
{
instance_create(x, y, Wall);
instance_destroy();
}
}
if(__hm_break459) break;
}}
{ var __hm_with460 = scrHMMatchingNE(hitme, "object_index", Player), __hm_break462=false;
for (var __hm_index461=0; __hm_index461<array_length(__hm_with460); ++__hm_index461) {
if(instance_exists(__hm_with460[__hm_index461])) with (__hm_with460[__hm_index461]) {
if (place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), InvisiWall)) {
move_bounce_solid(false);
}
}
if(__hm_break462) break;
}}
{ var __hm_with463 = scrHMInstances(LastIntro), __hm_break465=false;
for (var __hm_index464=0; __hm_index464<array_length(__hm_with463); ++__hm_index464) {
if(instance_exists(__hm_with463[__hm_index464])) with (__hm_with463[__hm_index464]) {
{
{ var __hm_with466 = scrHMInstances(IDPDSpawn), __hm_break468=false;
for (var __hm_index467=0; __hm_index467<array_length(__hm_with466); ++__hm_index467) {
if(instance_exists(__hm_with466[__hm_index467])) with (__hm_with466[__hm_index467]) {
scrHMDelete(id);
}
if(__hm_break468) break;
}}
{ var __hm_with469 = scrHMMatching(enemy, "team", 3), __hm_break471=false;
for (var __hm_index470=0; __hm_index470<array_length(__hm_with469); ++__hm_index470) {
if(instance_exists(__hm_with469[__hm_index470])) with (__hm_with469[__hm_index470]) {
scrHMDelete(id);
}
if(__hm_break471) break;
}}
scrHMSoundStop(sndIDPDPortalSpawn);
}
}
if(__hm_break465) break;
}}
{ var __hm_with472 = scrHMInstances(BigTV), __hm_break474=false;
for (var __hm_index473=0; __hm_index473<array_length(__hm_with472); ++__hm_index473) {
if(instance_exists(__hm_with472[__hm_index473])) with (__hm_with472[__hm_index473]) {
if (scrHMModExists("area", "elevator", "tv1")) {
spr_idle = scrHMModGet("area", "elevator", "tv1");
}
}
if(__hm_break474) break;
}}
}
_hm.pc=127;
break;
case 130: // maincode.mod.gml:1793
_hm.vars.__hm_repeat475--; _hm.pc=129;
break;
case 131: // maincode.mod.gml:1796
_hm.wait_ticks=max(0,choose(0, 0, 1, 1, 2, 2, 3)); _hm.pc=130; return;
break;
case 132: // maincode.mod.gml:1794
{
_hm.vars.here = instance_nearest((Player.x + random_range((- 120), 120)), (Player.y + random_range((- 120), 120)), Floor);
instance_create((_hm.vars.here.x + 16), (_hm.vars.here.y + 16), IDPDSpawn);
}
_hm.pc=131;
break;
case 129: // maincode.mod.gml:1793
_hm.pc=(_hm.vars.__hm_repeat475>0)?132:128;
break;
case 133: // maincode.mod.gml:1793
_hm.vars.__hm_repeat475=round(choose(1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 4)); _hm.pc=129;
break;
case 134: // maincode.mod.gml:1792
_hm.pc = (scrHMTaskFork(_hm, 133)) ? 133 : 128;
break;
case 135: // maincode.mod.gml:1791
_hm.pc = (instance_exists(Player)) ? 134 : 128;
break;
case 136: // maincode.mod.gml:1790
_hm.pc = ((random((250 + (instance_number(Corpse) * 5))) < 1)) ? 135 : 128;
break;
case 137: // maincode.mod.gml:1789
_hm.pc = ((! instance_exists(SpiralCont))) ? 136 : 128;
break;
case 138: // maincode.mod.gml:1788
{
GameCont.subarea = 5;
}
_hm.pc=137;
break;
case 139: // maincode.mod.gml:1786
{
;
}
_hm.pc=138;
break;
case 140: // maincode.mod.gml:1786
_hm.pc=0;
break;
case 141: // maincode.mod.gml:1755
{
{ var __hm_with476 = scrHMInstances(Portal), __hm_break478=false;
for (var __hm_index477=0; __hm_index477<array_length(__hm_with476); ++__hm_index477) {
if(instance_exists(__hm_with476[__hm_index477])) with (__hm_with476[__hm_index477]) {
{
type = 2;
}
}
if(__hm_break478) break;
}}
{ var __hm_with479 = scrHMInstances(TopPot), __hm_break481=false;
for (var __hm_index480=0; __hm_index480<array_length(__hm_with479); ++__hm_index480) {
if(instance_exists(__hm_with479[__hm_index480])) with (__hm_with479[__hm_index480]) {
if (((place_meeting(x, ((y - 16) - 13), Wall) and (! place_meeting(x, ((y - 32) - 13), Wall))) and place_meeting(x, ((y - 32) - 13), Floor))) {
y -= 16;
}
}
if(__hm_break481) break;
}}
{ var __hm_with482 = scrHMMatchingNE(scrHMAuthoredWalls105(), "thing", 1), __hm_break484=false;
for (var __hm_index483=0; __hm_index483<array_length(__hm_with482); ++__hm_index483) {
if(instance_exists(__hm_with482[__hm_index483])) with (__hm_with482[__hm_index483]) {
{
thing = 1;
instance_create(x, y, InvisiWall);
}
}
if(__hm_break484) break;
}}
{ var __hm_with485 = scrHMMatchingNE(FloorExplo, "thing", 1), __hm_break487=false;
for (var __hm_index486=0; __hm_index486<array_length(__hm_with485); ++__hm_index486) {
if(instance_exists(__hm_with485[__hm_index486])) with (__hm_with485[__hm_index486]) {
{
thing = 1;
thing2 = 10;
}
}
if(__hm_break487) break;
}}
{ var __hm_with488 = scrHMMatchingGT(FloorExplo, "thing2", 0), __hm_break490=false;
for (var __hm_index489=0; __hm_index489<array_length(__hm_with488); ++__hm_index489) {
if(instance_exists(__hm_with488[__hm_index489])) with (__hm_with488[__hm_index489]) {
{
thing2 -= choose(0, 0, 1);
}
}
if(__hm_break490) break;
}}
{ var __hm_with491 = scrHMMatching(FloorExplo, "thing2", 0), __hm_break493=false;
for (var __hm_index492=0; __hm_index492<array_length(__hm_with491); ++__hm_index492) {
if(instance_exists(__hm_with491[__hm_index492])) with (__hm_with491[__hm_index492]) {
{
instance_create(x, y, Wall);
instance_destroy();
}
}
if(__hm_break493) break;
}}
{ var __hm_with494 = scrHMMatchingNE(hitme, "object_index", Player), __hm_break496=false;
for (var __hm_index495=0; __hm_index495<array_length(__hm_with494); ++__hm_index495) {
if(instance_exists(__hm_with494[__hm_index495])) with (__hm_with494[__hm_index495]) {
if (place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), InvisiWall)) {
move_bounce_solid(false);
}
}
if(__hm_break496) break;
}}
{ var __hm_with497 = scrHMMatchingGT(WepPickup, "ammo", 0), __hm_break499=false;
for (var __hm_index498=0; __hm_index498<array_length(__hm_with497); ++__hm_index498) {
if(instance_exists(__hm_with497[__hm_index498])) with (__hm_with497[__hm_index498]) {
if ((! hm_maincode_mod_gml_either(wep, scrHMWeaponResolve(20), scrHMWeaponResolve(24), scrHMWeaponResolve(28), scrHMWeaponResolve(34), scrHMWeaponResolve(35), scrHMWeaponResolve(36), scrHMWeaponResolve(53), scrHMWeaponResolve(54), scrHMWeaponResolve(55), scrHMWeaponResolve(57), scrHMWeaponResolve(58), scrHMWeaponResolve(59), scrHMWeaponResolve(64), scrHMWeaponResolve(65), scrHMWeaponResolve(70), scrHMWeaponResolve("secretweaponi3"), scrHMWeaponResolve(96), scrHMWeaponResolve(97), scrHMWeaponResolve(118), scrHMWeaponResolve("secretweaponi1"), scrHMWeaponResolve("secretweaponi2")))) {
{
if ((random(2) < 1)) {
wep = scrHMWeaponResolve(choose(20, 24, 28, 34, 35, 36, 53, 54, 55, 57, 58, 59, 64, 65));
} else {
wep = scrHMWeaponResolve(choose(70, 96, 97, 118, "secretweaponi1", "secretweaponi2", "secretweaponi3"));
}
}
}
}
if(__hm_break499) break;
}}
}
_hm.pc=140;
break;
case 143: // maincode.mod.gml:1748
_hm.vars.__hm_repeat500--; _hm.pc=142;
break;
case 144: // maincode.mod.gml:1751
_hm.wait_ticks=max(0,choose(0, 0, 1, 1, 2, 2, 3)); _hm.pc=143; return;
break;
case 145: // maincode.mod.gml:1749
{
_hm.vars.here = instance_nearest((Player.x + random_range((- 120), 120)), (Player.y + random_range((- 120), 120)), Floor);
instance_create((_hm.vars.here.x + 16), (_hm.vars.here.y + 16), IDPDSpawn);
}
_hm.pc=144;
break;
case 142: // maincode.mod.gml:1748
_hm.pc=(_hm.vars.__hm_repeat500>0)?145:141;
break;
case 146: // maincode.mod.gml:1748
_hm.vars.__hm_repeat500=round(choose(1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 4)); _hm.pc=142;
break;
case 147: // maincode.mod.gml:1747
_hm.pc = (scrHMTaskFork(_hm, 146)) ? 146 : 141;
break;
case 148: // maincode.mod.gml:1746
_hm.pc = (instance_exists(Player)) ? 147 : 141;
break;
case 149: // maincode.mod.gml:1745
_hm.pc = ((random(((1000 / (GameCont.subarea + 3)) + (instance_number(Corpse) * 5))) < 1)) ? 148 : 141;
break;
case 150: // maincode.mod.gml:1744
_hm.pc = ((! instance_exists(SpiralCont))) ? 149 : 141;
break;
case 151: // maincode.mod.gml:1742
{
{ var __hm_with501 = scrHMInstances(SpiralCont), __hm_break503=false;
for (var __hm_index502=0; __hm_index502<array_length(__hm_with501); ++__hm_index502) {
if(instance_exists(__hm_with501[__hm_index502])) with (__hm_with501[__hm_index502]) {
type = 3;
}
if(__hm_break503) break;
}}
;
{ var __hm_with504 = scrHMInstances(Spiral), __hm_break506=false;
for (var __hm_index505=0; __hm_index505<array_length(__hm_with504); ++__hm_index505) {
if(instance_exists(__hm_with504[__hm_index505])) with (__hm_with504[__hm_index505]) {
type = 3;
}
if(__hm_break506) break;
}}
;
}
_hm.pc=150;
break;
case 152: // maincode.mod.gml:1740
{
;
}
_hm.pc=151;
break;
case 153: // maincode.mod.gml:1740
_hm.pc=0;
break;
case 154: // maincode.mod.gml:1718
{
{ var __hm_with507 = scrHMInstances(Wall), __hm_break509=false;
for (var __hm_index508=0; __hm_index508<array_length(__hm_with507); ++__hm_index508) {
if(instance_exists(__hm_with507[__hm_index508])) with (__hm_with507[__hm_index508]) {
depth = (0 - (y / 10016));
}
if(__hm_break509) break;
}}
{ var __hm_with510 = scrHMMatching(CustomHitme, "name", "bigtube1", "bigtube2"), __hm_break512=false;
for (var __hm_index511=0; __hm_index511<array_length(__hm_with510); ++__hm_index511) {
if(instance_exists(__hm_with510[__hm_index511])) with (__hm_with510[__hm_index511]) {
depth = (0 - (y / 10016));
}
if(__hm_break512) break;
}}
{ var __hm_with513 = scrHMInstances(prop), __hm_break515=false;
for (var __hm_index514=0; __hm_index514<array_length(__hm_with513); ++__hm_index514) {
if(instance_exists(__hm_with513[__hm_index514])) with (__hm_with513[__hm_index514]) {
depth = (0 - (y / 10016));
}
if(__hm_break515) break;
}}
{ var __hm_with516 = scrHMMatchingNE(Inspector, "transform", 1), __hm_break518=false;
for (var __hm_index517=0; __hm_index517<array_length(__hm_with516); ++__hm_index517) {
if(instance_exists(__hm_with516[__hm_index517])) with (__hm_with516[__hm_index517]) {
{
transform = 1;
if ((random(2) < 1)) {
{
instance_create(x, y, Necromancer);
instance_destroy();
}
}
}
}
if(__hm_break518) break;
}}
{ var __hm_with519 = scrHMMatchingNE(Shielder, "transform", 1), __hm_break521=false;
for (var __hm_index520=0; __hm_index520<array_length(__hm_with519); ++__hm_index520) {
if(instance_exists(__hm_with519[__hm_index520])) with (__hm_with519[__hm_index520]) {
{
transform = 1;
if ((random(2) < 1)) {
{
instance_create(x, y, Necromancer);
instance_destroy();
}
}
}
}
if(__hm_break521) break;
}}
{ var __hm_with522 = scrHMInstances(RevivePopoFreak), __hm_break524=false;
for (var __hm_index523=0; __hm_index523<array_length(__hm_with522); ++__hm_index523) {
if(instance_exists(__hm_with522[__hm_index523])) with (__hm_with522[__hm_index523]) {
if ((GameCont.loops < 3)) {
instance_destroy();
}
}
if(__hm_break524) break;
}}
{ var __hm_with525 = scrHMInstances(WantRevivePopoFreak), __hm_break527=false;
for (var __hm_index526=0; __hm_index526<array_length(__hm_with525); ++__hm_index526) {
if(instance_exists(__hm_with525[__hm_index526])) with (__hm_with525[__hm_index526]) {
if ((GameCont.loops < 3)) {
instance_destroy();
}
}
if(__hm_break527) break;
}}
}
_hm.pc=153;
break;
case 155: // maincode.mod.gml:1716
{
;
}
_hm.pc=154;
break;
case 156: // maincode.mod.gml:1716
_hm.pc=0;
break;
case 157: // maincode.mod.gml:1703
scrHMTaskWithNext(_hm);
break;
case 158: // maincode.mod.gml:1703
scrHMTaskWithAbort(_hm);
break;
case 159: // maincode.mod.gml:1705
scrHMTaskWithNext(_hm);
break;
case 160: // maincode.mod.gml:1705
scrHMTaskWithAbort(_hm);
break;
case 162: // maincode.mod.gml:1707
_hm.vars.__hm_repeat528--; _hm.pc=161;
break;
case 163: // maincode.mod.gml:1711
_hm.wait_ticks=max(0,choose(0, 0, 1, 1, 2, 2, 3)); _hm.pc=162; return;
break;
case 164: // maincode.mod.gml:1708
{
_hm.vars.here = instance_nearest((x + random_range((- 120), 120)), (y + random_range((- 120), 120)), Floor);
{ var __hm_with529 = scrHMInstances(instance_create((_hm.vars.here.x + 16), (_hm.vars.here.y + 16), Turret)), __hm_break531=false;
for (var __hm_index530=0; __hm_index530<array_length(__hm_with529); ++__hm_index530) {
if(instance_exists(__hm_with529[__hm_index530])) with (__hm_with529[__hm_index530]) {
timeout = random_range(100, 300);
}
if(__hm_break531) break;
}}
}
_hm.pc=163;
break;
case 165: // maincode.mod.gml:1707
_hm.pc = (instance_exists(_hm.scope)) ? 164 : 162;
break;
case 161: // maincode.mod.gml:1707
_hm.pc=(_hm.vars.__hm_repeat528>0)?165:159;
break;
case 166: // maincode.mod.gml:1707
_hm.vars.__hm_repeat528=round(choose(1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 4, 12)); _hm.pc=161;
break;
case 167: // maincode.mod.gml:1706
_hm.pc = (scrHMTaskFork(_hm, 166)) ? 166 : 159;
break;
case 168: // maincode.mod.gml:1705
scrHMTaskWithEnter(_hm,scrHMInstances(Player),167,157);
break;
case 169: // maincode.mod.gml:1704
_hm.pc = ((random(400) < 1)) ? 168 : 157;
break;
case 170: // maincode.mod.gml:1703
scrHMTaskWithEnter(_hm,scrHMInstances(TechnoMancer),169,156);
break;
case 171: // maincode.mod.gml:1703
_hm.pc = ((! instance_exists(Spiral))) ? 170 : 156;
break;
case 172: // maincode.mod.gml:1666
{
{ var __hm_with532 = scrHMInstances(Wall), __hm_break534=false;
for (var __hm_index533=0; __hm_index533<array_length(__hm_with532); ++__hm_index533) {
if(instance_exists(__hm_with532[__hm_index533])) with (__hm_with532[__hm_index533]) {
depth = (0 - (y / 10016));
}
if(__hm_break534) break;
}}
{ var __hm_with535 = scrHMMatching(CustomHitme, "name", "bigtube1", "bigtube2"), __hm_break537=false;
for (var __hm_index536=0; __hm_index536<array_length(__hm_with535); ++__hm_index536) {
if(instance_exists(__hm_with535[__hm_index536])) with (__hm_with535[__hm_index536]) {
depth = (0 - (y / 10016));
}
if(__hm_break537) break;
}}
{ var __hm_with538 = scrHMInstances(prop), __hm_break540=false;
for (var __hm_index539=0; __hm_index539<array_length(__hm_with538); ++__hm_index539) {
if(instance_exists(__hm_with538[__hm_index539])) with (__hm_with538[__hm_index539]) {
depth = (0 - (y / 10016));
}
if(__hm_break540) break;
}}
{ var __hm_with541 = scrHMInstances(Cactus), __hm_break543=false;
for (var __hm_index542=0; __hm_index542<array_length(__hm_with541); ++__hm_index542) {
if(instance_exists(__hm_with541[__hm_index542])) with (__hm_with541[__hm_index542]) {
if ((! instance_exists(SpiralCont))) {
{
instance_create(x, y, IDPDChest);
instance_change(Wind, 0);
instance_destroy();
}
}
}
if(__hm_break543) break;
}}
{ var __hm_with544 = scrHMMatchingGT(Turret, "timeout", 0), __hm_break546=false;
for (var __hm_index545=0; __hm_index545<array_length(__hm_with544); ++__hm_index545) {
if(instance_exists(__hm_with544[__hm_index545])) with (__hm_with544[__hm_index545]) {
timeout -= 1;
}
if(__hm_break546) break;
}}
{ var __hm_with547 = scrHMMatchingLE(Turret, "timeout", 0), __hm_break549=false;
for (var __hm_index548=0; __hm_index548<array_length(__hm_with547); ++__hm_index548) {
if(instance_exists(__hm_with547[__hm_index548])) with (__hm_with547[__hm_index548]) {
{
if ((spr_idle != global.hm_module_vars[$ "mod:maincode"].turretdeactivate)) {
{
spr_idle = global.hm_module_vars[$ "mod:maincode"].turretdeactivate;
;
scrHMSoundPlay(sndTurretSpawn);
;
ammo = 0;
;
alarm[2] = (- 1);
;
mask_index = mskNone;
}
}
}
}
if(__hm_break549) break;
}}
{ var __hm_with550 = scrHMMatching(Turret, "spr_idle", global.hm_module_vars[$ "mod:maincode"].turretdeactivate), __hm_break552=false;
for (var __hm_index551=0; __hm_index551<array_length(__hm_with550); ++__hm_index551) {
if(instance_exists(__hm_with550[__hm_index551])) with (__hm_with550[__hm_index551]) {
if ((image_index >= 10)) {
scrHMDelete(id);
}
}
if(__hm_break552) break;
}}
{ var __hm_with553 = scrHMInstances(RevivePopoFreak), __hm_break555=false;
for (var __hm_index554=0; __hm_index554<array_length(__hm_with553); ++__hm_index554) {
if(instance_exists(__hm_with553[__hm_index554])) with (__hm_with553[__hm_index554]) {
if ((GameCont.loops < 3)) {
instance_destroy();
}
}
if(__hm_break555) break;
}}
{ var __hm_with556 = scrHMInstances(WantRevivePopoFreak), __hm_break558=false;
for (var __hm_index557=0; __hm_index557<array_length(__hm_with556); ++__hm_index557) {
if(instance_exists(__hm_with556[__hm_index557])) with (__hm_with556[__hm_index557]) {
if ((GameCont.loops < 3)) {
instance_destroy();
}
}
if(__hm_break558) break;
}}
{ var __hm_with559 = scrHMInstances(Inspector), __hm_break561=false;
for (var __hm_index560=0; __hm_index560<array_length(__hm_with559); ++__hm_index560) {
if(instance_exists(__hm_with559[__hm_index560])) with (__hm_with559[__hm_index560]) {
{
instance_create(x, y, Necromancer);
instance_destroy();
}
}
if(__hm_break561) break;
}}
{ var __hm_with562 = scrHMInstances(Shielder), __hm_break564=false;
for (var __hm_index563=0; __hm_index563<array_length(__hm_with562); ++__hm_index563) {
if(instance_exists(__hm_with562[__hm_index563])) with (__hm_with562[__hm_index563]) {
{
instance_create(x, y, Necromancer);
instance_destroy();
}
}
if(__hm_break564) break;
}}
{ var __hm_with565 = scrHMInstances(TechnoMancer), __hm_break567=false;
for (var __hm_index566=0; __hm_index566<array_length(__hm_with565); ++__hm_index566) {
if(instance_exists(__hm_with565[__hm_index566])) with (__hm_with565[__hm_index566]) {
depth = (0 - (y / 10016));
}
if(__hm_break567) break;
}}
}
_hm.pc=171;
break;
case 173: // maincode.mod.gml:1664
{
;
}
_hm.pc=172;
break;
case 174: // maincode.mod.gml:1664
_hm.pc=0;
break;
case 175: // maincode.mod.gml:1568
{
{ var __hm_with568 = scrHMInstances(LilHunterDie), __hm_break570=false;
for (var __hm_index569=0; __hm_index569<array_length(__hm_with568); ++__hm_index569) {
if(instance_exists(__hm_with568[__hm_index569])) with (__hm_with568[__hm_index569]) {
if ((!scrHMVariableExists(id, "lastwish"))) {
{
{ var __hm_with571 = scrHMInstances(instance_create(x, y, EliteGrunt)), __hm_break573=false;
for (var __hm_index572=0; __hm_index572<array_length(__hm_with571); ++__hm_index572) {
if(instance_exists(__hm_with571[__hm_index572])) with (__hm_with571[__hm_index572]) {
{
spr_idle = sprLilHunterLift;
spr_hurt = sprLilHunterHurt;
spr_walk = sprLilHunterLift;
spr_dead = sprLilHunterDead;
hitid = [sprLilHunter, "lil hunter"];
scrHMMaxHealthWrite(id, 100, "=");
hp = 100;
var __hm_other574=scrHMOther(other);
direction = __hm_other574.direction;
fuel = 800;
grenades = 0;
roll = 20;
}
}
if(__hm_break573) break;
}}
scrHMDelete(id);
}
}
}
if(__hm_break570) break;
}}
{ var __hm_with575 = scrHMMatching(EliteGrunt, "spr_idle", sprLilHunterLift), __hm_break577=false;
for (var __hm_index576=0; __hm_index576<array_length(__hm_with575); ++__hm_index576) {
if(instance_exists(__hm_with575[__hm_index576])) with (__hm_with575[__hm_index576]) {
{
grenades = 0;
{ var __hm_with578 = scrHMInstances(instance_create(x, y, AcidStreak)), __hm_break580=false;
for (var __hm_index579=0; __hm_index579<array_length(__hm_with578); ++__hm_index579) {
if(instance_exists(__hm_with578[__hm_index579])) with (__hm_with578[__hm_index579]) {
{
var __hm_other581=scrHMOther(other);
image_angle = (__hm_other581.direction + 180);
var __hm_other582=scrHMOther(other);
depth = (__hm_other582.depth + .1);
}
}
if(__hm_break580) break;
}}
{ var __hm_with583 = scrHMMatching(EnemyBullet1, "creator", id), __hm_break585=false;
for (var __hm_index584=0; __hm_index584<array_length(__hm_with583); ++__hm_index584) {
if(instance_exists(__hm_with583[__hm_index584])) with (__hm_with583[__hm_index584]) {
{
hitid = [sprLilHunter, "lil hunter"];
}
}
if(__hm_break585) break;
}}
roll -= 1;
if ((roll == 15)) {
{
gunangle = (direction + random_range((- 30), 30));
ammo = 6;
alarm[2] = 6;
}
}
{ var __hm_with586 = scrHMInstances(instance_create(x, y, Smoke)), __hm_break588=false;
for (var __hm_index587=0; __hm_index587<array_length(__hm_with586); ++__hm_index587) {
if(instance_exists(__hm_with586[__hm_index587])) with (__hm_with586[__hm_index587]) {
{
var __hm_other589=scrHMOther(other);
depth = (__hm_other589.depth + .2);
}
}
if(__hm_break588) break;
}}
if ((roll <= 0)) {
{
{ var __hm_with590 = scrHMInstances(instance_create(x, y, LilHunterDie)), __hm_break592=false;
for (var __hm_index591=0; __hm_index591<array_length(__hm_with590); ++__hm_index591) {
if(instance_exists(__hm_with590[__hm_index591])) with (__hm_with590[__hm_index591]) {
lastwish = 1;
}
if(__hm_break592) break;
}}
scrHMDelete(id);
}
}
}
}
if(__hm_break577) break;
}}
{ var __hm_with593 = scrHMInstances(LilHunter), __hm_break595=false;
for (var __hm_index594=0; __hm_index594<array_length(__hm_with593); ++__hm_index594) {
if(instance_exists(__hm_with593[__hm_index594])) with (__hm_with593[__hm_index594]) {
{
_hm.vars.LH = id;
;
if ((!scrHMVariableExists(id, "morehp"))) {
{
team = 3;
animating = 1;
spawns += 6;
morehp = 1;
}
}
{ var __hm_with596 = scrHMMatchingNE(projectile, "team", team), __hm_break598=false;
for (var __hm_index597=0; __hm_index597<array_length(__hm_with596); ++__hm_index597) {
if(instance_exists(__hm_with596[__hm_index597])) with (__hm_with596[__hm_index597]) {
if (place_meeting(((x + (hspeed / timescale)) + lengthdir_x((speed / timescale), direction)), ((y + (vspeed / timescale)) + lengthdir_y((speed / timescale), direction)), (scrHMOther(other)))) {
{
var __hm_other599=scrHMOther(other);
__hm_other599.dodge = 3;
var __hm_other600=scrHMOther(other);
__hm_other600.direction = (direction + (90 * __hm_other600.right));
}
}
}
if(__hm_break598) break;
}}
if (((alarm[1] > 1) and ((floor(current_frame) mod 12) == 1))) {
alarm[1] -= 1;
}
{ var __hm_with601 = scrHMMatching(EnemyBullet1, "creator", id), __hm_break603=false;
for (var __hm_index602=0; __hm_index602<array_length(__hm_with601); ++__hm_index602) {
if(instance_exists(__hm_with601[__hm_index602])) with (__hm_with601[__hm_index602]) {
{
{ var __hm_with604 = scrHMInstances(instance_create(x, y, IDPDBullet)), __hm_break606=false;
for (var __hm_index605=0; __hm_index605<array_length(__hm_with604); ++__hm_index605) {
if(instance_exists(__hm_with604[__hm_index605])) with (__hm_with604[__hm_index605]) {
{
team = 3;
var __hm_other607=scrHMOther(other);
speed = ((__hm_other607.speed / timescale)) * timescale;
var __hm_other608=scrHMOther(other);
direction = __hm_other608.direction;
image_angle = direction;
var __hm_other609=scrHMOther(other);
hitid = __hm_other609.hitid;
}
}
if(__hm_break606) break;
}}
scrHMDelete(id);
}
}
if(__hm_break603) break;
}}
{ var __hm_with610 = scrHMMatching(LHBouncer, "creator", id), __hm_break612=false;
for (var __hm_index611=0; __hm_index611<array_length(__hm_with610); ++__hm_index611) {
if(instance_exists(__hm_with610[__hm_index611])) with (__hm_with610[__hm_index611]) {
{
{ var __hm_with613 = scrHMInstances(instance_create(x, y, TrapFire)), __hm_break615=false;
for (var __hm_index614=0; __hm_index614<array_length(__hm_with613); ++__hm_index614) {
if(instance_exists(__hm_with613[__hm_index614])) with (__hm_with613[__hm_index614]) {
{
team = 3;
friction += (choose(0.1, 0, 0, (- 0.1))) * (timescale * timescale);
sprite_index = sprFireLilHunter;
var __hm_other616=scrHMOther(other);
speed = ((__hm_other616.speed / timescale)) * timescale;
var __hm_other617=scrHMOther(other);
direction = __hm_other617.direction;
image_angle = direction;
var __hm_other618=scrHMOther(other);
hitid = __hm_other618.hitid;
}
}
if(__hm_break615) break;
}}
scrHMDelete(id);
}
}
if(__hm_break612) break;
}}
}
}
if(__hm_break595) break;
}}
if (instance_exists(Player)) {
{ var __hm_with619 = scrHMInstances(Explosion), __hm_break621=false;
for (var __hm_index620=0; __hm_index620<array_length(__hm_with619); ++__hm_index620) {
if(instance_exists(__hm_with619[__hm_index620])) with (__hm_with619[__hm_index620]) {
if ((!scrHMVariableExists(id, "yeti"))) {
{
if ((random(600) < 1)) {
{ var __hm_with622 = scrHMInstances(instance_nearest((Player.x + random_range((view_width * (- 1)), view_width)), (Player.y + random_range((view_width * (- 1)), view_width)), Floor)), __hm_break624=false;
for (var __hm_index623=0; __hm_index623<array_length(__hm_with622); ++__hm_index623) {
if(instance_exists(__hm_with622[__hm_index623])) with (__hm_with622[__hm_index623]) {
{
scrHMModCall("mod", "props", "lookout_create", (x + 16), (y + 16));
;
}
}
if(__hm_break624) break;
}}
}
yeti = 1;
}
}
}
if(__hm_break621) break;
}}
}
}
_hm.pc=174;
break;
case 176: // maincode.mod.gml:1522
scrHMTaskWithNext(_hm);
break;
case 177: // maincode.mod.gml:1522
scrHMTaskWithAbort(_hm);
break;
case 178: // maincode.mod.gml:1565
{
;
}
_hm.pc=176;
break;
case 179: // maincode.mod.gml:1565
_hm.result=undefined; _hm.done=true; return;
break;
case 180: // maincode.mod.gml:1544
instance_create(0, 0, VanSpawn);
_hm.pc=179;
break;
case 181: // maincode.mod.gml:1562
{
;
}
_hm.pc=179;
break;
case 182: // maincode.mod.gml:1562
_hm.result=undefined; _hm.done=true; return;
break;
case 184: // maincode.mod.gml:1546
_hm.vars.__hm_repeat625--; _hm.pc=183;
break;
case 185: // maincode.mod.gml:1560
_hm.wait_ticks=max(0,1); _hm.pc=184; return;
break;
case 186: // maincode.mod.gml:1547
{
if (((random(3) < 1) and instance_exists(id))) {
{
walk = 0;
{ var __hm_with626 = scrHMInstances(instance_create(x, y, CaveSparkle)), __hm_break628=false;
for (var __hm_index627=0; __hm_index627<array_length(__hm_with626); ++__hm_index627) {
if(instance_exists(__hm_with626[__hm_index627])) with (__hm_with626[__hm_index627]) {
{
sprite_index = sprIDPDPortalCharge;
image_angle = random(360);
vspeed -= (random(12)) * timescale;
hspeed = (choose(random_range((- 1), 1), 0, 0)) * timescale;
depth = (- 10);
if (instance_exists(Player)) {
scrHMSoundPitchVolume(sndShotgunHitWall, 2, ((view_width / 4) / distance_to_object(Player)));
}
}
}
if(__hm_break628) break;
}}
}
}
}
_hm.pc=185;
break;
case 183: // maincode.mod.gml:1546
_hm.pc=(_hm.vars.__hm_repeat625>0)?186:182;
break;
case 187: // maincode.mod.gml:1546
_hm.vars.__hm_repeat625=round(25); _hm.pc=183;
break;
case 188: // maincode.mod.gml:1545
_hm.pc = (scrHMTaskFork(_hm, 187)) ? 187 : 179;
break;
case 189: // maincode.mod.gml:1543
_hm.pc = ((! instance_exists(VanSpawn))) ? 180 : 188;
break;
case 190: // maincode.mod.gml:1542
_hm.pc = (instance_exists(_hm.scope)) ? 189 : 179;
break;
case 192: // maincode.mod.gml:1526
_hm.vars.__hm_repeat629--; _hm.pc=191;
break;
case 193: // maincode.mod.gml:1540
_hm.wait_ticks=max(0,1); _hm.pc=192; return;
break;
case 194: // maincode.mod.gml:1527
{
if (((random(3) < 1) and instance_exists(id))) {
{
walk = 0;
{ var __hm_with630 = scrHMInstances(instance_create(x, y, CaveSparkle)), __hm_break632=false;
for (var __hm_index631=0; __hm_index631<array_length(__hm_with630); ++__hm_index631) {
if(instance_exists(__hm_with630[__hm_index631])) with (__hm_with630[__hm_index631]) {
{
sprite_index = sprIDPDPortalCharge;
image_angle = random(360);
vspeed -= (random(12)) * timescale;
hspeed = (choose(random_range((- 1), 1), 0, 0)) * timescale;
depth = (- 10);
if (instance_exists(Player)) {
scrHMSoundPitchVolume(sndShotgunHitWall, 2, ((view_width / 4) / distance_to_object(Player)));
}
}
}
if(__hm_break632) break;
}}
}
}
}
_hm.pc=193;
break;
case 191: // maincode.mod.gml:1526
_hm.pc=(_hm.vars.__hm_repeat629>0)?194:190;
break;
case 195: // maincode.mod.gml:1526
_hm.vars.__hm_repeat629=round(75); _hm.pc=191;
break;
case 196: // maincode.mod.gml:1525
_hm.pc = (scrHMTaskFork(_hm, 195)) ? 195 : 176;
break;
case 197: // maincode.mod.gml:1523
{
global.hm_module_vars[$ "mod:maincode"].vans -= 1;
van = 1;
}
_hm.pc=196;
break;
case 198: // maincode.mod.gml:1522
_hm.pc = ((((((!instance_is(id,Van) && (!scrHMVariableExists(_hm.scope, "van"))) and (distance_to_object(Corpse) < 64)) and (! instance_exists(VanSpawn))) and (! instance_exists(CaveSparkle))) and (global.hm_module_vars[$ "mod:maincode"].vans > 0))) ? 197 : 176;
break;
case 199: // maincode.mod.gml:1522
scrHMTaskWithEnter(_hm,scrHMMatching(enemy, "team", 3),198,175);
break;
case 200: // maincode.mod.gml:1443
{
{ var __hm_with633 = scrHMInstances(GenCont), __hm_break635=false;
for (var __hm_index634=0; __hm_index634<array_length(__hm_with633); ++__hm_index634) {
if(instance_exists(__hm_with633[__hm_index634])) with (__hm_with633[__hm_index634]) {
if ((!scrHMVariableExists(id, "settip"))) {
{
if ((random(25) < 1)) {
tip = "the @WDevastator@s gets stronger#the further it goes";
} else {
if ((random(24) < 1)) {
tip = "the @Wflame cannon@s deals damage now";
} else {
if ((random(23) < 1)) {
tip = "there is no yeti";
} else {
if ((random(22) < 1)) {
tip = "@Wcold@s";
}
}
}
}
settip = 1;
}
}
}
if(__hm_break635) break;
}}
{ var __hm_with636 = scrHMInstances(GenCont), __hm_break638=false;
for (var __hm_index637=0; __hm_index637<array_length(__hm_with636); ++__hm_index637) {
if(instance_exists(__hm_with636[__hm_index637])) with (__hm_with636[__hm_index637]) {
global.hm_module_vars[$ "mod:maincode"].vans = min(GameCont.subarea, 3);
}
if(__hm_break638) break;
}}
instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), SnowFlake);
if ((random(50) < 1)) {
{
{ var __hm_with639 = scrHMInstances(Player), __hm_break641=false;
for (var __hm_index640=0; __hm_index640<array_length(__hm_with639); ++__hm_index640) {
if(instance_exists(__hm_with639[__hm_index640])) with (__hm_with639[__hm_index640]) {
if (((race != scrHMRaceResolve(8)) and (race != scrHMRaceResolve(5)))) {
{
{ var __hm_with642 = scrHMInstances(instance_create(x, y, Breath)), __hm_break644=false;
for (var __hm_index643=0; __hm_index643<array_length(__hm_with642); ++__hm_index643) {
if(instance_exists(__hm_with642[__hm_index643])) with (__hm_with642[__hm_index643]) {
var __hm_other645=scrHMOther(other);
image_xscale = __hm_other645.right;
}
if(__hm_break644) break;
}}
}
}
}
if(__hm_break641) break;
}}
}
}
{ var __hm_with646 = scrHMInstances(Necromancer), __hm_break648=false;
for (var __hm_index647=0; __hm_index647<array_length(__hm_with646); ++__hm_index647) {
if(instance_exists(__hm_with646[__hm_index647])) with (__hm_with646[__hm_index647]) {
if(!(self[$ "hm_vanilla_loop111"]??false))
{
instance_create(x, y, Sniper);
instance_change(Wind, 0);
instance_destroy();
}
}
if(__hm_break648) break;
}}
{ var __hm_with649 = scrHMInstances(ExploGuardian), __hm_break651=false;
for (var __hm_index650=0; __hm_index650<array_length(__hm_with649); ++__hm_index650) {
if(instance_exists(__hm_with649[__hm_index650])) with (__hm_with649[__hm_index650]) {
if(!(self[$ "hm_vanilla_loop111"]??false))
{
instance_create(x, y, Inspector);
instance_change(Wind, 0);
instance_destroy();
}
}
if(__hm_break651) break;
}}
{ var __hm_with652 = scrHMInstances(DogGuardian), __hm_break654=false;
for (var __hm_index653=0; __hm_index653<array_length(__hm_with652); ++__hm_index653) {
if(instance_exists(__hm_with652[__hm_index653])) with (__hm_with652[__hm_index653]) {
if(!(self[$ "hm_vanilla_loop111"]??false))
{
instance_create(x, y, SnowTank);
instance_change(Wind, 0);
instance_destroy();
}
}
if(__hm_break654) break;
}}
{ var __hm_with655 = scrHMMatching([EliteGrunt, EliteInspector, EliteShielder], "hmset", undefined), __hm_break657=false;
for (var __hm_index656=0; __hm_index656<array_length(__hm_with655); ++__hm_index656) {
if(instance_exists(__hm_with655[__hm_index656])) with (__hm_with655[__hm_index656]) {
{
if ((random((2 + GameCont.loops)) < 1)) {
{
instance_create(x, y, Grunt);
scrHMDelete(id);
}
} else {
hmset = 1;
}
}
}
if(__hm_break657) break;
}}
{ var __hm_with658 = scrHMInstances(VanSpawn), __hm_break660=false;
for (var __hm_index659=0; __hm_index659<array_length(__hm_with658); ++__hm_index659) {
if(instance_exists(__hm_with658[__hm_index659])) with (__hm_with658[__hm_index659]) {
if (((floor(current_frame) mod 3) == 1)) {
alarm[0]++;
}
}
if(__hm_break660) break;
}}
{ var __hm_with661 = scrHMInstances(Van), __hm_break663=false;
for (var __hm_index662=0; __hm_index662<array_length(__hm_with661); ++__hm_index662) {
if(instance_exists(__hm_with661[__hm_index662])) with (__hm_with661[__hm_index662]) {
if ((GameCont.loops < 3)) {
freak = 0;
}
}
if(__hm_break663) break;
}}
{ var __hm_with664 = scrHMInstances(IDPDSpawn), __hm_break666=false;
for (var __hm_index665=0; __hm_index665<array_length(__hm_with664); ++__hm_index665) {
if(instance_exists(__hm_with664[__hm_index665])) with (__hm_with664[__hm_index665]) {
{
freak = 0;
if (((!scrHMVariableExists(id, "setelite")) and (! instance_exists(LilHunter)))) {
{
if ((random(5) < GameCont.subarea)) {
elite = 1;
}
setelite = 1;
}
}
}
}
if(__hm_break666) break;
}}
{ var __hm_with667 = scrHMInstances(TopDecalCity), __hm_break669=false;
for (var __hm_index668=0; __hm_index668<array_length(__hm_with667); ++__hm_index668) {
if(instance_exists(__hm_with667[__hm_index668])) with (__hm_with667[__hm_index668]) {
if ((!scrHMVariableExists(id, "why_are_you_so_far_down"))) {
{
if ((place_meeting(x, (y - 16), Wall) and (image_index != 2))) {
y -= 7;
}
why_are_you_so_far_down = 1;
}
}
}
if(__hm_break669) break;
}}
{ var __hm_with670 = scrHMInstances(SnowTank), __hm_break672=false;
for (var __hm_index671=0; __hm_index671<array_length(__hm_with670); ++__hm_index671) {
if(instance_exists(__hm_with670[__hm_index671])) with (__hm_with670[__hm_index671]) {
{
{ var __hm_with673 = scrHMMatching(EnemyBullet4, "creator", id), __hm_break675=false;
for (var __hm_index674=0; __hm_index674<array_length(__hm_with673); ++__hm_index674) {
if(instance_exists(__hm_with673[__hm_index674])) with (__hm_with673[__hm_index674]) {
{
{ var __hm_with676 = scrHMInstances(instance_create(x, y, EnemyBullet3)), __hm_break678=false;
for (var __hm_index677=0; __hm_index677<array_length(__hm_with676); ++__hm_index677) {
if(instance_exists(__hm_with676[__hm_index677])) with (__hm_with676[__hm_index677]) {
{
team = 1;
var __hm_other679=scrHMOther(other);
speed = (((__hm_other679.speed / timescale) * 1.5)) * timescale;
var __hm_other680=scrHMOther(other);
direction = __hm_other680.direction;
image_angle = direction;
var __hm_other681=scrHMOther(other);
hitid = __hm_other681.hitid;
}
}
if(__hm_break678) break;
}}
instance_destroy();
}
}
if(__hm_break675) break;
}}
}
}
if(__hm_break672) break;
}}
}
_hm.pc=199;
break;
case 201: // maincode.mod.gml:1441
{
;
}
_hm.pc=200;
break;
case 202: // maincode.mod.gml:1441
_hm.pc=0;
break;
case 203: // maincode.mod.gml:1373
{
{ var __hm_with682 = scrHMInstances(BigWeaponChest), __hm_break684=false;
for (var __hm_index683=0; __hm_index683<array_length(__hm_with682); ++__hm_index683) {
if(instance_exists(__hm_with682[__hm_index683])) with (__hm_with682[__hm_index683]) {
{
curse = 1;
instance_change(CursedBigChest, 1);
sprite_index = sprCursedChestBig;
}
}
if(__hm_break684) break;
}}
{ var __hm_with685 = scrHMInstances(HyperCrystal), __hm_break687=false;
for (var __hm_index686=0; __hm_index686<array_length(__hm_with685); ++__hm_index686) {
if(instance_exists(__hm_with685[__hm_index686])) with (__hm_with685[__hm_index686]) {
{
repeat (random(20)) { var __hm_with688 = scrHMInstances(instance_create((x + random_range((- 32), 32)), (y + random_range((- 32), 32)), Curse)), __hm_break690=false;
for (var __hm_index689=0; __hm_index689<array_length(__hm_with688); ++__hm_index689) {
if(instance_exists(__hm_with688[__hm_index689])) with (__hm_with688[__hm_index689]) {
{
if ((random(3) < 1)) {
var __hm_other691=scrHMOther(other);
depth = (__hm_other691.depth - 1);
}
image_speed = (choose(random_range(0.1, 1), 0.4, 0.4, 0.4, 0.4)) * timescale;
if ((random(10) < 1)) {
sprite_index = sprCaveSparkle;
}
}
}
if(__hm_break690) break;
}}
canfly = 1;
;
{ var __hm_with692 = scrHMInstances(LaserCrystal), __hm_break694=false;
for (var __hm_index693=0; __hm_index693<array_length(__hm_with692); ++__hm_index693) {
if(instance_exists(__hm_with692[__hm_index693])) with (__hm_with692[__hm_index693]) {
if ((distance_to_object((scrHMOther(other))) < 64)) {
{
if ((random(3) > 1)) {
instance_change(InvLaserCrystal, 1);
} else {
instance_change(LightningCrystal, 1);
}
}
}
}
if(__hm_break694) break;
}}
if ((target > 0)) {
{
if ((random(45) < 1)) {
{
_hm.vars.dir_ = ((point_direction(x, y, target.x, target.y) + choose((- 90), 90)) + random_range((- 30), 30));
;
instance_create((x + lengthdir_x(64, _hm.vars.dir_)), (y + lengthdir_y(64, _hm.vars.dir_)), PortalClear);
x = (x + lengthdir_x(64, _hm.vars.dir_));
y = (y + lengthdir_y(64, _hm.vars.dir_));
}
} else {
if ((random(100) < 1)) {
{
x += random_range((- 16), 16);
y += random_range((- 16), 16);
}
} else {
if (((random(15) < 1) and (distance_to_object(target) > (view_width - 32)))) {
{
x = (x + lengthdir_x((distance_to_object(target) / 2), point_direction(x, y, target.x, target.y)));
y = (y + lengthdir_y((distance_to_object(target) / 2), point_direction(x, y, target.x, target.y)));
instance_create(x, y, PortalClear);
direction = point_direction(x, y, target.x, target.y);
}
}
}
}
if ((random(200) < 1)) {
{
_hm.vars.dist_ = point_distance(target.x, target.y, x, y);
;
_hm.vars.ang_ = point_direction(target.x, target.y, x, y);
;
_hm.vars.nfl_ = instance_nearest((target.x + lengthdir_x(_hm.vars.dist_, (_hm.vars.ang_ + 180))), (target.y + lengthdir_y(_hm.vars.dist_, (_hm.vars.ang_ + 180))), Floor);
if (((_hm.vars.dist_ > 64) and (point_distance((target.x + lengthdir_x(_hm.vars.dist_, (_hm.vars.ang_ + 180))), (target.y + lengthdir_y(_hm.vars.dist_, (_hm.vars.ang_ + 180))), _hm.vars.nfl_.x, _hm.vars.nfl_.y) < 64))) {
{
x = (target.x + lengthdir_x(_hm.vars.dist_, (_hm.vars.ang_ + 180)));
;
y = (target.y + lengthdir_y(_hm.vars.dist_, (_hm.vars.ang_ + 180)));
;
{ var __hm_with695 = scrHMInstances(instance_create(x, y, PortalClear)), __hm_break697=false;
for (var __hm_index696=0; __hm_index696<array_length(__hm_with695); ++__hm_index696) {
if(instance_exists(__hm_with695[__hm_index696])) with (__hm_with695[__hm_index696]) {
{
image_xscale = 2;
image_yscale = 2;
}
}
if(__hm_break697) break;
}}
alarm[1] = 1;
wantdist = 26;
fastspin = 0;
}
}
}
}
fastspin = choose(0, 0, 0, 1, 3, 50, 10);
}
}
}
}
if(__hm_break687) break;
}}
if (((current_time mod 10) <= 1)) {
{
{ var __hm_with698 = scrHMInstances(Portal), __hm_break700=false;
for (var __hm_index699=0; __hm_index699<array_length(__hm_with698); ++__hm_index699) {
if(instance_exists(__hm_with698[__hm_index699])) with (__hm_with698[__hm_index699]) {
{
_hm.vars.port_ = instance_nearest((x + random_range((- 20), 20)), (y + random_range((- 20), 20)), Floor);
;
x = (_hm.vars.port_.x + random(16));
y = (_hm.vars.port_.y + random(16));
}
}
if(__hm_break700) break;
}}
}
}
}
_hm.pc=202;
break;
case 204: // maincode.mod.gml:1370
{
;
}
_hm.pc=203;
break;
case 205: // maincode.mod.gml:1370
_hm.pc=0;
break;
case 206: // maincode.mod.gml:1356
{
_hm.vars.fl = random_range((- 16), 16);
;
{ var __hm_with701 = scrHMInstances(Floor), __hm_break703=false;
for (var __hm_index702=0; __hm_index702<array_length(__hm_with701); ++__hm_index702) {
if(instance_exists(__hm_with701[__hm_index702])) with (__hm_with701[__hm_index702]) {
if ((random(200) < 1)) {
{ var __hm_with704 = scrHMInstances(instance_create((x + _hm.vars.fl), (y + _hm.vars.fl), CaveSparkle)), __hm_break706=false;
for (var __hm_index705=0; __hm_index705<array_length(__hm_with704); ++__hm_index705) {
if(instance_exists(__hm_with704[__hm_index705])) with (__hm_with704[__hm_index705]) {
image_angle = random(360);
}
if(__hm_break706) break;
}}
}
}
if(__hm_break703) break;
}}
{ var __hm_with707 = scrHMMatching(Effect, "name", "skycrystal"), __hm_break709=false;
for (var __hm_index708=0; __hm_index708<array_length(__hm_with707); ++__hm_index708) {
if(instance_exists(__hm_with707[__hm_index708])) with (__hm_with707[__hm_index708]) {
if (instance_exists(Player)) {
{
_hm.vars.np_ = instance_nearest(x, (y + 250), Player);
if ((point_distance(_hm.vars.np_.x, (y + 200), _hm.vars.np_.x, _hm.vars.np_.y) < 150)) {
{
image_alpha = (1 - (point_distance(_hm.vars.np_.x, (y + 250), _hm.vars.np_.x, _hm.vars.np_.y) / 150));
}
}
}
}
}
if(__hm_break709) break;
}}
}
_hm.pc=205;
break;
case 207: // maincode.mod.gml:1354
{
;
}
_hm.pc=206;
break;
case 208: // maincode.mod.gml:1354
_hm.pc=0;
break;
case 209: // maincode.mod.gml:1297
{
{ var __hm_with710 = scrHMMatching(Explosion, "name", "gatorexplosion"), __hm_break712=false;
for (var __hm_index711=0; __hm_index711<array_length(__hm_with710); ++__hm_index711) {
if(instance_exists(__hm_with710[__hm_index711])) with (__hm_with710[__hm_index711]) {
{
if ((random(100) < 1)) {
instance_create(x, y, LightBeam);
}
}
}
if(__hm_break712) break;
}}
_hm.vars.fl = random_range((- 16), 16);
;
{ var __hm_with713 = scrHMInstances(Floor), __hm_break715=false;
for (var __hm_index714=0; __hm_index714<array_length(__hm_with713); ++__hm_index714) {
if(instance_exists(__hm_with713[__hm_index714])) with (__hm_with713[__hm_index714]) {
if ((random(300) < 1)) {
{ var __hm_with716 = scrHMInstances(instance_create((x + _hm.vars.fl), (y + _hm.vars.fl), CaveSparkle)), __hm_break718=false;
for (var __hm_index717=0; __hm_index717<array_length(__hm_with716); ++__hm_index717) {
if(instance_exists(__hm_with716[__hm_index717])) with (__hm_with716[__hm_index717]) {
image_angle = random(360);
}
if(__hm_break718) break;
}}
}
}
if(__hm_break715) break;
}}
{ var __hm_with719 = scrHMMatchingGT(Effect, "z", 0), __hm_break721=false;
for (var __hm_index720=0; __hm_index720<array_length(__hm_with719); ++__hm_index720) {
if(instance_exists(__hm_with719[__hm_index720])) with (__hm_with719[__hm_index720]) {
{
image_angle += 25;
image_alpha = 0;
instance_create(x, (y - z), Dust);
}
}
if(__hm_break721) break;
}}
{ var __hm_with722 = scrHMMatchingLE(Effect, "z", 0), __hm_break724=false;
for (var __hm_index723=0; __hm_index723<array_length(__hm_with722); ++__hm_index723) {
if(instance_exists(__hm_with722[__hm_index723])) with (__hm_with722[__hm_index723]) {
{
{ var __hm_with725 = scrHMInstances(instance_create(x, y, Debris)), __hm_break727=false;
for (var __hm_index726=0; __hm_index726<array_length(__hm_with725); ++__hm_index726) {
if(instance_exists(__hm_with725[__hm_index726])) with (__hm_with725[__hm_index726]) {
var __hm_other728=scrHMOther(other);
image_index = __hm_other728.image_index;
}
if(__hm_break727) break;
}}
instance_destroy();
}
}
if(__hm_break724) break;
}}
{ var __hm_with729 = scrHMMatchingGT(Gator, "z", 0), __hm_break731=false;
for (var __hm_index730=0; __hm_index730<array_length(__hm_with729); ++__hm_index730) {
if(instance_exists(__hm_with729[__hm_index730])) with (__hm_with729[__hm_index730]) {
{
image_angle += 25;
mask_index = mskNone;
canfly = 1;
speed = (0) * timescale;
image_alpha = 0;
}
}
if(__hm_break731) break;
}}
{ var __hm_with732 = scrHMMatching(Gator, "z", 0), __hm_break734=false;
for (var __hm_index733=0; __hm_index733<array_length(__hm_with732); ++__hm_index733) {
if(instance_exists(__hm_with732[__hm_index733])) with (__hm_with732[__hm_index733]) {
{
image_angle = 0;
image_alpha = 1;
mask_index = mskBandit;
canfly = 0;
z = (- 1);
repeat (32) { var __hm_with735 = scrHMInstances(instance_create(x, y, Dust)), __hm_break737=false;
for (var __hm_index736=0; __hm_index736<array_length(__hm_with735); ++__hm_index736) {
if(instance_exists(__hm_with735[__hm_index736])) with (__hm_with735[__hm_index736]) {
scrHMMotionAdd(random(360), random(6));
}
if(__hm_break737) break;
}}
}
}
if(__hm_break734) break;
}}
{ var __hm_with738 = scrHMMatchingGT(Spider, "z", 0), __hm_break740=false;
for (var __hm_index739=0; __hm_index739<array_length(__hm_with738); ++__hm_index739) {
if(instance_exists(__hm_with738[__hm_index739])) with (__hm_with738[__hm_index739]) {
{
image_angle += 25;
mask_index = mskNone;
canfly = 1;
speed = (0) * timescale;
image_alpha = 0;
}
}
if(__hm_break740) break;
}}
{ var __hm_with741 = scrHMMatching(Spider, "z", 0), __hm_break743=false;
for (var __hm_index742=0; __hm_index742<array_length(__hm_with741); ++__hm_index742) {
if(instance_exists(__hm_with741[__hm_index742])) with (__hm_with741[__hm_index742]) {
{
image_angle = 0;
image_alpha = 1;
mask_index = mskSpider;
canfly = 0;
z = (- 1);
repeat (32) { var __hm_with744 = scrHMInstances(instance_create(x, y, Dust)), __hm_break746=false;
for (var __hm_index745=0; __hm_index745<array_length(__hm_with744); ++__hm_index745) {
if(instance_exists(__hm_with744[__hm_index745])) with (__hm_with744[__hm_index745]) {
scrHMMotionAdd(random(360), random(6));
}
if(__hm_break746) break;
}}
}
}
if(__hm_break743) break;
}}
}
_hm.pc=208;
break;
case 210: // maincode.mod.gml:1265
scrHMTaskWithNext(_hm);
break;
case 211: // maincode.mod.gml:1265
scrHMTaskWithAbort(_hm);
break;
case 212: // maincode.mod.gml:1271
{
canfly = 1;
walk = 0;
mask_index = mskNone;
x = mount.x;
y = (mount.y - 12);
if ((((target > 0) && (random(2) > 1)) && (collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0))) {
{
{ var __hm_with747 = scrHMMatching(Salamander, "rider", id), __hm_break749=false;
for (var __hm_index748=0; __hm_index748<array_length(__hm_with747); ++__hm_index748) {
if(instance_exists(__hm_with747[__hm_index748])) with (__hm_with747[__hm_index748]) {
var __hm_other750=scrHMOther(other);
scrHMMotionAdd(point_direction(x, y, __hm_other750.target.x, __hm_other750.target.y), 3);
}
if(__hm_break749) break;
}}
}
}
}
_hm.pc=210;
break;
case 213: // maincode.mod.gml:1288
{
if (instance_exists(id)) {
{
mask_index = mskBandit;
mount = 0;
}
}
}
_hm.pc=210;
break;
case 214: // maincode.mod.gml:1287
_hm.wait_ticks=max(0,10); _hm.pc=213; return;
break;
case 215: // maincode.mod.gml:1286
_hm.pc = (scrHMTaskFork(_hm, 214)) ? 214 : 210;
break;
case 216: // maincode.mod.gml:1283
{
canfly = 0;
mount = 0;
scrHMMotionAdd(270, 4);
}
_hm.pc=215;
break;
case 217: // maincode.mod.gml:1271
_hm.pc = (instance_exists(mount)) ? 212 : 216;
break;
case 218: // maincode.mod.gml:1270
_hm.pc = ((mount > 0)) ? 217 : 210;
break;
case 219: // maincode.mod.gml:1266
{
{ var __hm_with751 = scrHMInstances(Salamander), __hm_break753=false;
for (var __hm_index752=0; __hm_index752<array_length(__hm_with751); ++__hm_index752) {
if(instance_exists(__hm_with751[__hm_index752])) with (__hm_with751[__hm_index752]) {
if ((((rider == 0) and place_meeting(x, y, (scrHMOther(other)))) and ((scrHMOther(other)).mount == 0))) {
{
var __hm_other754=scrHMOther(other);
__hm_other754.mount = id;
var __hm_other755=scrHMOther(other);
rider = __hm_other755;
}
}
}
if(__hm_break753) break;
}}
}
_hm.pc=218;
break;
case 220: // maincode.mod.gml:1265
scrHMTaskWithEnter(_hm,scrHMInstances(BuffGator),219,209);
break;
case 221: // maincode.mod.gml:1263
{
{ var __hm_with756 = scrHMInstances(BuffGator), __hm_break758=false;
for (var __hm_index757=0; __hm_index757<array_length(__hm_with756); ++__hm_index757) {
if(instance_exists(__hm_with756[__hm_index757])) with (__hm_with756[__hm_index757]) {
if ((!scrHMVariableExists(id, "mount"))) {
mount = 0;
}
}
if(__hm_break758) break;
}}
}
_hm.pc=220;
break;
case 222: // maincode.mod.gml:1235
scrHMTaskWithNext(_hm);
break;
case 223: // maincode.mod.gml:1235
scrHMTaskWithAbort(_hm);
break;
case 224: // maincode.mod.gml:1241
{
canfly = 1;
walk = 0;
mask_index = mskNone;
x = mount.x;
y = (mount.y - 12);
}
_hm.pc=222;
break;
case 225: // maincode.mod.gml:1254
{
if (instance_exists(id)) {
{
mask_index = mskBandit;
mount = 0;
}
}
}
_hm.pc=222;
break;
case 226: // maincode.mod.gml:1253
_hm.wait_ticks=max(0,10); _hm.pc=225; return;
break;
case 227: // maincode.mod.gml:1252
_hm.pc = (scrHMTaskFork(_hm, 226)) ? 226 : 222;
break;
case 228: // maincode.mod.gml:1249
{
canfly = 0;
mount = 0;
scrHMMotionAdd(270, 4);
}
_hm.pc=227;
break;
case 229: // maincode.mod.gml:1241
_hm.pc = (instance_exists(mount)) ? 224 : 228;
break;
case 230: // maincode.mod.gml:1240
_hm.pc = ((mount > 0)) ? 229 : 222;
break;
case 231: // maincode.mod.gml:1236
{
{ var __hm_with759 = scrHMInstances(Salamander), __hm_break761=false;
for (var __hm_index760=0; __hm_index760<array_length(__hm_with759); ++__hm_index760) {
if(instance_exists(__hm_with759[__hm_index760])) with (__hm_with759[__hm_index760]) {
if ((((rider == 0) and place_meeting(x, y, (scrHMOther(other)))) and ((scrHMOther(other)).mount == 0))) {
{
var __hm_other762=scrHMOther(other);
__hm_other762.mount = id;
var __hm_other763=scrHMOther(other);
rider = __hm_other763;
}
}
}
if(__hm_break761) break;
}}
}
_hm.pc=230;
break;
case 232: // maincode.mod.gml:1235
scrHMTaskWithEnter(_hm,scrHMInstances(Gator),231,221);
break;
case 233: // maincode.mod.gml:1227
{
{ var __hm_with764 = scrHMInstances(Salamander), __hm_break766=false;
for (var __hm_index765=0; __hm_index765<array_length(__hm_with764); ++__hm_index765) {
if(instance_exists(__hm_with764[__hm_index765])) with (__hm_with764[__hm_index765]) {
{
if ((!scrHMVariableExists(id, "rider"))) {
rider = 0;
}
if (((rider > 0) and (! instance_exists(rider)))) {
rider = 0;
}
}
}
if(__hm_break766) break;
}}
{ var __hm_with767 = scrHMInstances(Gator), __hm_break769=false;
for (var __hm_index768=0; __hm_index768<array_length(__hm_with767); ++__hm_index768) {
if(instance_exists(__hm_with767[__hm_index768])) with (__hm_with767[__hm_index768]) {
if ((!scrHMVariableExists(id, "mount"))) {
mount = 0;
}
}
if(__hm_break769) break;
}}
}
_hm.pc=232;
break;
case 234: // maincode.mod.gml:1225
{
;
}
_hm.pc=233;
break;
case 235: // maincode.mod.gml:1225
_hm.pc=0;
break;
case 236: // maincode.mod.gml:1210
{
{ var __hm_with770 = scrHMMatching(Explosion, "name", "gatorexplosion"), __hm_break772=false;
for (var __hm_index771=0; __hm_index771<array_length(__hm_with770); ++__hm_index771) {
if(instance_exists(__hm_with770[__hm_index771])) with (__hm_with770[__hm_index771]) {
{
if ((random(100) < 1)) {
instance_create(x, y, LightBeam);
}
}
}
if(__hm_break772) break;
}}
_hm.vars.fl = random_range((- 16), 16);
;
{ var __hm_with773 = scrHMInstances(Floor), __hm_break775=false;
for (var __hm_index774=0; __hm_index774<array_length(__hm_with773); ++__hm_index774) {
if(instance_exists(__hm_with773[__hm_index774])) with (__hm_with773[__hm_index774]) {
if ((random(300) < 1)) {
{ var __hm_with776 = scrHMInstances(instance_create((x + _hm.vars.fl), (y + _hm.vars.fl), CaveSparkle)), __hm_break778=false;
for (var __hm_index777=0; __hm_index777<array_length(__hm_with776); ++__hm_index777) {
if(instance_exists(__hm_with776[__hm_index777])) with (__hm_with776[__hm_index777]) {
image_angle = random(360);
}
if(__hm_break778) break;
}}
}
}
if(__hm_break775) break;
}}
}
_hm.pc=235;
break;
case 237: // maincode.mod.gml:1178
scrHMTaskWithNext(_hm);
break;
case 238: // maincode.mod.gml:1178
scrHMTaskWithAbort(_hm);
break;
case 239: // maincode.mod.gml:1184
{
canfly = 1;
walk = 0;
mask_index = mskNone;
x = mount.x;
y = (mount.y - 12);
if ((((target > 0) && (random(2) > 1)) && (collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0))) {
{
{ var __hm_with779 = scrHMMatching(Salamander, "rider", id), __hm_break781=false;
for (var __hm_index780=0; __hm_index780<array_length(__hm_with779); ++__hm_index780) {
if(instance_exists(__hm_with779[__hm_index780])) with (__hm_with779[__hm_index780]) {
var __hm_other782=scrHMOther(other);
scrHMMotionAdd(point_direction(x, y, __hm_other782.target.x, __hm_other782.target.y), 3);
}
if(__hm_break781) break;
}}
}
}
}
_hm.pc=237;
break;
case 240: // maincode.mod.gml:1201
{
if (instance_exists(id)) {
{
mask_index = mskBandit;
mount = 0;
}
}
}
_hm.pc=237;
break;
case 241: // maincode.mod.gml:1200
_hm.wait_ticks=max(0,10); _hm.pc=240; return;
break;
case 242: // maincode.mod.gml:1199
_hm.pc = (scrHMTaskFork(_hm, 241)) ? 241 : 237;
break;
case 243: // maincode.mod.gml:1196
{
canfly = 0;
mount = 0;
scrHMMotionAdd(270, 4);
}
_hm.pc=242;
break;
case 244: // maincode.mod.gml:1184
_hm.pc = (instance_exists(mount)) ? 239 : 243;
break;
case 245: // maincode.mod.gml:1183
_hm.pc = ((mount > 0)) ? 244 : 237;
break;
case 246: // maincode.mod.gml:1179
{
{ var __hm_with783 = scrHMInstances(Salamander), __hm_break785=false;
for (var __hm_index784=0; __hm_index784<array_length(__hm_with783); ++__hm_index784) {
if(instance_exists(__hm_with783[__hm_index784])) with (__hm_with783[__hm_index784]) {
if ((((rider == 0) and place_meeting(x, y, (scrHMOther(other)))) and ((scrHMOther(other)).mount == 0))) {
{
var __hm_other786=scrHMOther(other);
__hm_other786.mount = id;
var __hm_other787=scrHMOther(other);
rider = __hm_other787;
}
}
}
if(__hm_break785) break;
}}
}
_hm.pc=245;
break;
case 247: // maincode.mod.gml:1178
scrHMTaskWithEnter(_hm,scrHMInstances(BuffGator),246,236);
break;
case 248: // maincode.mod.gml:1176
{
{ var __hm_with788 = scrHMInstances(BuffGator), __hm_break790=false;
for (var __hm_index789=0; __hm_index789<array_length(__hm_with788); ++__hm_index789) {
if(instance_exists(__hm_with788[__hm_index789])) with (__hm_with788[__hm_index789]) {
if ((!scrHMVariableExists(id, "mount"))) {
mount = 0;
}
}
if(__hm_break790) break;
}}
}
_hm.pc=247;
break;
case 249: // maincode.mod.gml:1148
scrHMTaskWithNext(_hm);
break;
case 250: // maincode.mod.gml:1148
scrHMTaskWithAbort(_hm);
break;
case 251: // maincode.mod.gml:1154
{
canfly = 1;
walk = 0;
mask_index = mskNone;
x = mount.x;
y = (mount.y - 12);
}
_hm.pc=249;
break;
case 252: // maincode.mod.gml:1167
{
if (instance_exists(id)) {
{
mask_index = mskBandit;
mount = 0;
}
}
}
_hm.pc=249;
break;
case 253: // maincode.mod.gml:1166
_hm.wait_ticks=max(0,10); _hm.pc=252; return;
break;
case 254: // maincode.mod.gml:1165
_hm.pc = (scrHMTaskFork(_hm, 253)) ? 253 : 249;
break;
case 255: // maincode.mod.gml:1162
{
canfly = 0;
mount = 0;
scrHMMotionAdd(270, 4);
}
_hm.pc=254;
break;
case 256: // maincode.mod.gml:1154
_hm.pc = (instance_exists(mount)) ? 251 : 255;
break;
case 257: // maincode.mod.gml:1153
_hm.pc = ((mount > 0)) ? 256 : 249;
break;
case 258: // maincode.mod.gml:1149
{
{ var __hm_with791 = scrHMInstances(Salamander), __hm_break793=false;
for (var __hm_index792=0; __hm_index792<array_length(__hm_with791); ++__hm_index792) {
if(instance_exists(__hm_with791[__hm_index792])) with (__hm_with791[__hm_index792]) {
if ((((rider == 0) and place_meeting(x, y, (scrHMOther(other)))) and ((scrHMOther(other)).mount == 0))) {
{
var __hm_other794=scrHMOther(other);
__hm_other794.mount = id;
var __hm_other795=scrHMOther(other);
rider = __hm_other795;
}
}
}
if(__hm_break793) break;
}}
}
_hm.pc=257;
break;
case 259: // maincode.mod.gml:1148
scrHMTaskWithEnter(_hm,scrHMInstances(Gator),258,248);
break;
case 260: // maincode.mod.gml:1140
{
{ var __hm_with796 = scrHMInstances(Salamander), __hm_break798=false;
for (var __hm_index797=0; __hm_index797<array_length(__hm_with796); ++__hm_index797) {
if(instance_exists(__hm_with796[__hm_index797])) with (__hm_with796[__hm_index797]) {
{
if ((!scrHMVariableExists(id, "rider"))) {
rider = 0;
}
if (((rider > 0) and (! instance_exists(rider)))) {
rider = 0;
}
}
}
if(__hm_break798) break;
}}
{ var __hm_with799 = scrHMInstances(Gator), __hm_break801=false;
for (var __hm_index800=0; __hm_index800<array_length(__hm_with799); ++__hm_index800) {
if(instance_exists(__hm_with799[__hm_index800])) with (__hm_with799[__hm_index800]) {
if ((!scrHMVariableExists(id, "mount"))) {
mount = 0;
}
}
if(__hm_break801) break;
}}
}
_hm.pc=259;
break;
case 261: // maincode.mod.gml:1138
{
;
}
_hm.pc=260;
break;
case 262: // maincode.mod.gml:1138
_hm.pc=0;
break;
case 263: // maincode.mod.gml:1105
{
{ var __hm_with802 = scrHMInstances(ScrapBossMissile), __hm_break804=false;
for (var __hm_index803=0; __hm_index803<array_length(__hm_with802); ++__hm_index803) {
if(instance_exists(__hm_with802[__hm_index803])) with (__hm_with802[__hm_index803]) {
{
if ((random(4) < 1)) {
{ var __hm_with805 = scrHMInstances(instance_create((x + lengthdir_x((- 8), direction)), (y + lengthdir_y((- 8), direction)), TrapFire)), __hm_break807=false;
for (var __hm_index806=0; __hm_index806<array_length(__hm_with805); ++__hm_index806) {
if(instance_exists(__hm_with805[__hm_index806])) with (__hm_with805[__hm_index806]) {
{
var __hm_other808=scrHMOther(other);
team = __hm_other808.team;
var __hm_other809=scrHMOther(other);
creator = __hm_other809;
var __hm_other810=scrHMOther(other);
depth = (__hm_other810.depth + choose((- 0.1), 0.1));
var __hm_other811=scrHMOther(other);
direction = __hm_other811.direction;
image_angle = direction;
image_yscale = 0.5;
var __hm_other812=scrHMOther(other);
hitid = __hm_other812.hitid;
image_index += 3;
}
}
if(__hm_break807) break;
}}
}
alarm[1] = (- 1);
if (place_meeting((x + ((hspeed / timescale) * 3)), (y + ((vspeed / timescale) * 3)), Wall)) {
{ var __hm_with813 = scrHMInstances(instance_nearest((x + ((hspeed / timescale) * 3)), (y + ((vspeed / timescale) * 3)), Wall)), __hm_break815=false;
for (var __hm_index814=0; __hm_index814<array_length(__hm_with813); ++__hm_index814) {
if(instance_exists(__hm_with813[__hm_index814])) with (__hm_with813[__hm_index814]) {
{
instance_create(x, y, FloorExplo);
instance_destroy();
}
}
if(__hm_break815) break;
}}
}
x += lengthdir_x(0.5, direction);
y += lengthdir_y(0.5, direction);
{ var __hm_with816 = scrHMInstances(EnemyBullet1), __hm_break818=false;
for (var __hm_index817=0; __hm_index817<array_length(__hm_with816); ++__hm_index817) {
if(instance_exists(__hm_with816[__hm_index817])) with (__hm_with816[__hm_index817]) {
if (scrHMMissileShot111(creator,scrHMOther(other))) {
{
{ var __hm_with819 = scrHMInstances(instance_create(x, y, EnemyBullet3)), __hm_break821=false;
for (var __hm_index820=0; __hm_index820<array_length(__hm_with819); ++__hm_index820) {
if(instance_exists(__hm_with819[__hm_index820])) with (__hm_with819[__hm_index820]) {
{
speed = ((6 * (GameCont.loops + 1))) * timescale;
var __hm_other822=scrHMOther(other);
creator = __hm_other822.creator;
var __hm_other823=scrHMOther(other);
direction = __hm_other823.direction;
image_angle = direction;
var __hm_other824=scrHMOther(other);
team = __hm_other824.team;
var __hm_other825=scrHMOther(other);
hitid = __hm_other825.hitid;
}
}
if(__hm_break821) break;
}}
instance_destroy();
}
}
}
if(__hm_break818) break;
}}
}
}
if(__hm_break804) break;
}}
}
_hm.pc=262;
break;
case 264: // maincode.mod.gml:999
{
repeat (6) instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), RainDrop);
}
_hm.pc=263;
break;
case 265: // maincode.mod.gml:1092
{
{ var __hm_with826 = scrHMInstances(LHBouncer), __hm_break828=false;
for (var __hm_index827=0; __hm_index827<array_length(__hm_with826); ++__hm_index827) {
if(instance_exists(__hm_with826[__hm_index827])) with (__hm_with826[__hm_index827]) {
{
image_angle = direction;
;
}
}
if(__hm_break828) break;
}}
{ var __hm_with829 = scrHMInstances(BigDogExplo), __hm_break831=false;
for (var __hm_index830=0; __hm_index830<array_length(__hm_with829); ++__hm_index830) {
if(instance_exists(__hm_with829[__hm_index830])) with (__hm_with829[__hm_index830]) {
{
if ((!scrHMVariableExists(id, "intro"))) {
{
if (instance_exists(Player)) {
{
if ((scrHMModExists("mod", "options", "bossoutros") and (scrHMModGet("mod", "options", "bossoutros") == "1"))) {
scrHMModCall("mod", "bossintros", "boss_trigger", "", mskNone, mskNone, mskNone, id, 0);
}
intro = 1;
}
}
}
}
}
}
if(__hm_break831) break;
}}
}
_hm.pc=263;
break;
case 266: // maincode.mod.gml:1045
scrHMTaskWithNext(_hm);
break;
case 267: // maincode.mod.gml:1045
scrHMTaskWithAbort(_hm);
break;
case 268: // maincode.mod.gml:1074
scrHMBigDogShots105();
_hm.pc=266;
break;
case 269: // maincode.mod.gml:1054
{
if ((instance_exists(id) and (intro == (- 1)))) {
{
scrHMSoundMusic(musBoss2);
if ((scrHMModGet("mod", "options", "intropan") == "1")) {
{
if ((UberCont.opt_bossintro == 1)) {
scrHMModCall("mod", "bossintros", "boss_trigger", "BIG DOG", global.hm_module_vars[$ "mod:maincode"].Bigdogportrait, global.hm_module_vars[$ "mod:maincode"].Bigdogportraitfg, mskNone, id, 60);
} else {
scrHMModCall("mod", "bossintros", "boss_trigger", "", mskNone, mskNone, mskNone, id, 60);
}
}
} else {
if ((UberCont.opt_bossintro == 1)) {
scrHMModCall("mod", "bossintros", "boss_trigger", "BIG DOG", global.hm_module_vars[$ "mod:maincode"].Bigdogportrait, global.hm_module_vars[$ "mod:maincode"].Bigdogportraitfg, mskNone, instance_nearest(x, y, Player), 0);
}
}
intro = (- 2);
}
}
}
_hm.pc=268;
break;
case 270: // maincode.mod.gml:1053
_hm.wait_ticks=max(0,30); _hm.pc=269; return;
break;
case 271: // maincode.mod.gml:1052
_hm.pc = (scrHMTaskFork(_hm, 270)) ? 270 : 268;
break;
case 272: // maincode.mod.gml:1
{
hm_dog_intro107 = true;
}
_hm.pc=271;
break;
case 273: // maincode.mod.gml:1052
{

}
_hm.pc=268;
break;
case 274: // maincode.mod.gml:1052
_hm.pc = ((! scrHMVariableExists(_hm.scope, "hm_dog_intro107"))) ? 272 : 273;
break;
case 275: // maincode.mod.gml:1047
{
introanimation += 0.4;
image_alpha = 0;
friction = (30) * (timescale * timescale);
{ var __hm_with843 = scrHMInstances(scrHMBindDraw(hm_maincode_mod_gml_bigdogintro, 0)), __hm_break845=false;
for (var __hm_index844=0; __hm_index844<array_length(__hm_with843); ++__hm_index844) {
if(instance_exists(__hm_with843[__hm_index844])) with (__hm_with843[__hm_index844]) {
var __hm_other846=scrHMOther(other);
creator = __hm_other846;
}
if(__hm_break845) break;
}}
}
_hm.pc=274;
break;
case 276: // maincode.mod.gml:1068
{
image_alpha = 1;
mask_index = mskScrapBoss;
friction = (0.4) * (timescale * timescale);
}
_hm.pc=268;
break;
case 277: // maincode.mod.gml:1046
_hm.pc = ((introanimation < 11)) ? 275 : 276;
break;
case 278: // maincode.mod.gml:1046
_hm.pc = ((scrHMModExists("mod", "options", "intropan") and (scrHMModGet("mod", "options", "intropan") == "1"))) ? 277 : 268;
break;
case 279: // maincode.mod.gml:1045
scrHMTaskWithEnter(_hm,scrHMInstances(ScrapBoss),278,265);
break;
case 280: // maincode.mod.gml:1013
scrHMTaskWithNext(_hm);
break;
case 281: // maincode.mod.gml:1013
scrHMTaskWithAbort(_hm);
break;
case 282: // maincode.mod.gml:1038
{
;
if (instance_exists(id)) {
{ var __hm_with847 = scrHMInstances(instance_create(x, y, PortalClear)), __hm_break849=false;
for (var __hm_index848=0; __hm_index848<array_length(__hm_with847); ++__hm_index848) {
if(instance_exists(__hm_with847[__hm_index848])) with (__hm_with847[__hm_index848]) {
{
image_xscale = 3.5;
image_yscale = 3.5;
}
}
if(__hm_break849) break;
}}
}
}
_hm.pc=280;
break;
case 283: // maincode.mod.gml:1038
_hm.wait_ticks=max(0,5); _hm.pc=282; return;
break;
case 284: // maincode.mod.gml:1033
{
;
if (instance_exists(id)) {
{ var __hm_with850 = scrHMInstances(instance_create(x, y, PortalClear)), __hm_break852=false;
for (var __hm_index851=0; __hm_index851<array_length(__hm_with850); ++__hm_index851) {
if(instance_exists(__hm_with850[__hm_index851])) with (__hm_with850[__hm_index851]) {
{
image_xscale = 3;
image_yscale = 3;
}
}
if(__hm_break852) break;
}}
}
}
_hm.pc=283;
break;
case 285: // maincode.mod.gml:1033
_hm.wait_ticks=max(0,5); _hm.pc=284; return;
break;
case 286: // maincode.mod.gml:1028
{
;
if (instance_exists(id)) {
{ var __hm_with853 = scrHMInstances(instance_create(x, y, PortalClear)), __hm_break855=false;
for (var __hm_index854=0; __hm_index854<array_length(__hm_with853); ++__hm_index854) {
if(instance_exists(__hm_with853[__hm_index854])) with (__hm_with853[__hm_index854]) {
{
image_xscale = 2.5;
image_yscale = 2.5;
}
}
if(__hm_break855) break;
}}
}
}
_hm.pc=285;
break;
case 287: // maincode.mod.gml:1028
_hm.wait_ticks=max(0,5); _hm.pc=286; return;
break;
case 288: // maincode.mod.gml:1027
_hm.pc = (scrHMTaskFork(_hm, 287)) ? 287 : 280;
break;
case 289: // maincode.mod.gml:1014
{
intro = (- 1);
morehp = 1;
scrHMMaxHealthWrite(id, 400, "=");
scrHMMaxHealthWrite(id, ((max_hp / 2) * instance_number(Player)), "+=");
scrHMMaxHealthWrite(id, (GameCont.loops + 1), "*=");
hp = max_hp;
if ((scrHMModExists("mod", "options", "intropan") and (scrHMModGet("mod", "options", "intropan") == "1"))) {
introanimation = 0;
}
{ var __hm_with856 = scrHMInstances(instance_create(x, y, PortalClear)), __hm_break858=false;
for (var __hm_index857=0; __hm_index857<array_length(__hm_with856); ++__hm_index857) {
if(instance_exists(__hm_with856[__hm_index857])) with (__hm_with856[__hm_index857]) {
{
image_xscale = 2;
image_yscale = 2;
}
}
if(__hm_break858) break;
}}
speed = (0) * timescale;
}
_hm.pc=288;
break;
case 290: // maincode.mod.gml:1013
scrHMTaskWithEnter(_hm,scrHMMatchingNE(ScrapBoss, "morehp", 1),289,279);
break;
case 291: // maincode.mod.gml:1004
{
if ((random(6) < 1)) {
instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), RainDrop);
}
if ((random(42) < 1)) {
instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), LightBeam);
}
{ var __hm_with859 = scrHMInstances(LightBeam), __hm_break861=false;
for (var __hm_index860=0; __hm_index860<array_length(__hm_with859); ++__hm_index860) {
if(instance_exists(__hm_with859[__hm_index860])) with (__hm_with859[__hm_index860]) {
{
scrHMMotionSet(180, 0.3);
if ((random(500) < 1)) {
instance_destroy();
}
}
}
if(__hm_break861) break;
}}
}
_hm.pc=290;
break;
case 292: // maincode.mod.gml:999
_hm.pc = ((GameCont.subarea == 4)) ? 264 : 291;
break;
case 293: // maincode.mod.gml:997
{
;
}
_hm.pc=292;
break;
case 294: // maincode.mod.gml:997
_hm.pc=0;
break;
case 295: // maincode.mod.gml:952
{
repeat (6) instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), RainDrop);
{ var __hm_with862 = scrHMInstances(RainDrop), __hm_break864=false;
for (var __hm_index863=0; __hm_index863<array_length(__hm_with862); ++__hm_index863) {
if(instance_exists(__hm_with862[__hm_index863])) with (__hm_with862[__hm_index863]) {
{
addy -= 6;
addx -= 6;
}
}
if(__hm_break864) break;
}}
{ var __hm_with865 = scrHMInstances(instance_nearest((view_xview + random(view_width)), (view_yview + random(view_height)), Floor)), __hm_break867=false;
for (var __hm_index866=0; __hm_index866<array_length(__hm_with865); ++__hm_index866) {
if(instance_exists(__hm_with865[__hm_index866])) with (__hm_with865[__hm_index866]) {
if ((random(6) < 1)) {
{
if ((((place_meeting((x - 32), y, Floor) and place_meeting((x + 32), y, Floor)) and place_meeting(x, (y - 32), Floor)) and place_meeting(x, (y + 32), Floor))) {
{ var __hm_with868 = scrHMInstances(instance_create((x + random(32)), (y + random(32)), Wind)), __hm_break870=false;
for (var __hm_index869=0; __hm_index869<array_length(__hm_with868); ++__hm_index869) {
if(instance_exists(__hm_with868[__hm_index869])) with (__hm_with868[__hm_index869]) {
{
image_xscale = (- 1);
direction = 0;
}
}
if(__hm_break870) break;
}}
}
}
}
}
if(__hm_break867) break;
}}
{ var __hm_with871 = scrHMInstances(Corpse), __hm_break873=false;
for (var __hm_index872=0; __hm_index872<array_length(__hm_with871); ++__hm_index872) {
if(instance_exists(__hm_with871[__hm_index872])) with (__hm_with871[__hm_index872]) {
if (((!scrHMVariableExists(id, "bird")) and instance_exists(enemy))) {
{
if ((random(5) < 1)) {
{
{ var __hm_with874 = scrHMInstances(instance_create((x + random_range(200, (- 200))), (y - random_range(250, 300)), Raven)), __hm_break876=false;
for (var __hm_index875=0; __hm_index875<array_length(__hm_with874); ++__hm_index875) {
if(instance_exists(__hm_with874[__hm_index875])) with (__hm_with874[__hm_index875]) {
{
assassin = 0;
image_alpha = 0;
instance_change(RavenFly,false);emergencylanding=0;z=0;
;
image_index = 0;
;
_hm.vars.f = instance_nearest(((scrHMOther(other)).x + random_range((- 80), 80)), ((scrHMOther(other)).y + random_range((- 80), 80)), Floor);
;
if ((_hm.vars.f.object_index == FloorExplo)) {
{
if (place_meeting(_hm.vars.f.x, _hm.vars.f.y, Wall)) {
{
var __hm_other877=scrHMOther(other);
targetx = __hm_other877.x;
var __hm_other878=scrHMOther(other);
targety = __hm_other878.y;
}
} else {
{
targetx = _hm.vars.f.x;
targety = _hm.vars.f.y;
}
}
}
} else {
{
if (place_meeting(_hm.vars.f.x, _hm.vars.f.y, Wall)) {
{
var __hm_other879=scrHMOther(other);
targetx = __hm_other879.x;
var __hm_other880=scrHMOther(other);
targety = __hm_other880.y;
}
} else {
{
targetx = (_hm.vars.f.x + 16);
targety = (_hm.vars.f.y + 16);
}
}
}
}
}
}
if(__hm_break876) break;
}}
}
}
bird = 1;
}
}
}
if(__hm_break873) break;
}}
}
_hm.pc=294;
break;
case 296: // maincode.mod.gml:950
{
;
}
_hm.pc=295;
break;
case 297: // maincode.mod.gml:950
_hm.pc=0;
break;
case 298: // maincode.mod.gml:944
{
{ var __hm_with881 = scrHMMatching(Raven, "assassin", undefined), __hm_break883=false;
for (var __hm_index882=0; __hm_index882<array_length(__hm_with881); ++__hm_index882) {
if(instance_exists(__hm_with881[__hm_index882])) with (__hm_with881[__hm_index882]) {
{
if ((random(10) < 1)) {
assassin = 1;
} else {
assassin = 0;
}
}
}
if(__hm_break883) break;
}}
}
_hm.pc=297;
break;
case 299: // maincode.mod.gml:898
scrHMTaskWithNext(_hm);
break;
case 300: // maincode.mod.gml:898
scrHMTaskWithAbort(_hm);
break;
case 301: // maincode.mod.gml:932
{
{ var __hm_with884 = scrHMInstances(instance_create((x + random_range(200, (- 200))), (y - random_range(250, 300)), Raven)), __hm_break886=false;
for (var __hm_index885=0; __hm_index885<array_length(__hm_with884); ++__hm_index885) {
if(instance_exists(__hm_with884[__hm_index885])) with (__hm_with884[__hm_index885]) {
{
image_alpha = 0;
assassin = 0;
instance_change(RavenFly,false);emergencylanding=0;z=0;
;
image_index = 0;
;
targetx = (_hm.vars.f.x + 16);
targety = (_hm.vars.f.y + 16);
__hm_break886=true; break;
;
}
}
if(__hm_break886) break;
}}
}
_hm.pc=299;
break;
case 302: // maincode.mod.gml:930
_hm.pc=300;
break;
case 303: // maincode.mod.gml:929
_hm.pc = ((_hm.vars.r > 200)) ? 302 : 301;
break;
case 304: // maincode.mod.gml:902
{
_hm.vars.r = 120;
;
_hm.vars.f = instance_nearest((x + random_range((_hm.vars.r * (- 1)), _hm.vars.r)), (y + random_range((_hm.vars.r * (- 1)), _hm.vars.r)), Floor);
;
while (position_meeting((_hm.vars.f.x + (sprite_get_width(_hm.vars.f.sprite_index) / 4)), (_hm.vars.f.y + (sprite_get_height(_hm.vars.f.sprite_index) / 4)), Wall)) {
_hm.vars.f = instance_nearest((x + random_range((_hm.vars.r * (- 1)), _hm.vars.r)), (y + random_range((_hm.vars.r * (- 1)), _hm.vars.r)), Floor);
;
}
while (position_meeting((_hm.vars.f.x + ((sprite_get_width(_hm.vars.f.sprite_index) / 4) * 3)), (_hm.vars.f.y + ((sprite_get_height(_hm.vars.f.sprite_index) / 4) * 3)), Wall)) {
_hm.vars.f = instance_nearest((x + random_range((_hm.vars.r * (- 1)), _hm.vars.r)), (y + random_range((_hm.vars.r * (- 1)), _hm.vars.r)), Floor);
;
}
while (position_meeting((_hm.vars.f.x + (sprite_get_width(_hm.vars.f.sprite_index) / 4)), (_hm.vars.f.y + ((sprite_get_height(_hm.vars.f.sprite_index) / 4) * 3)), Wall)) {
_hm.vars.f = instance_nearest((x + random_range((_hm.vars.r * (- 1)), _hm.vars.r)), (y + random_range((_hm.vars.r * (- 1)), _hm.vars.r)), Floor);
;
}
while (position_meeting((_hm.vars.f.x + ((sprite_get_width(_hm.vars.f.sprite_index) / 4) * 3)), (_hm.vars.f.y + (sprite_get_height(_hm.vars.f.sprite_index) / 4)), Wall)) {
_hm.vars.f = instance_nearest((x + random_range((_hm.vars.r * (- 1)), _hm.vars.r)), (y + random_range((_hm.vars.r * (- 1)), _hm.vars.r)), Floor);
;
}
while ((_hm.vars.f.object_index == FloorExplo)) {
_hm.vars.f = instance_nearest((x + random_range((_hm.vars.r * (- 1)), _hm.vars.r)), (y + random_range((_hm.vars.r * (- 1)), _hm.vars.r)), Floor);
;
_hm.vars.r += 16;
}
}
_hm.pc=303;
break;
case 305: // maincode.mod.gml:901
_hm.pc = (scrHMTaskFork(_hm, 304)) ? 304 : 299;
break;
case 306: // maincode.mod.gml:900
_hm.pc = ((random(5) < 1)) ? 305 : 299;
break;
case 307: // maincode.mod.gml:899
{
bird = 1;
}
_hm.pc=306;
break;
case 308: // maincode.mod.gml:898
_hm.pc = (((!scrHMVariableExists(_hm.scope, "bird")) and instance_exists(enemy))) ? 307 : 299;
break;
case 309: // maincode.mod.gml:898
scrHMTaskWithEnter(_hm,scrHMInstances(Corpse),308,298);
break;
case 310: // maincode.mod.gml:888
{
{ var __hm_with887 = scrHMInstances(BuffGator), __hm_break889=false;
for (var __hm_index888=0; __hm_index888<array_length(__hm_with887); ++__hm_index888) {
if(instance_exists(__hm_with887[__hm_index888])) with (__hm_with887[__hm_index888]) {
{
instance_create(x, y, Jock);
instance_change(Wind, 0);
instance_destroy();
}
}
if(__hm_break889) break;
}}
{ var __hm_with890 = scrHMInstances(Bandit), __hm_break892=false;
for (var __hm_index891=0; __hm_index891<array_length(__hm_with890); ++__hm_index891) {
if(instance_exists(__hm_with890[__hm_index891])) with (__hm_with890[__hm_index891]) {
{
instance_create(x, y, Raven);
instance_change(Wind, 0);
instance_destroy();
}
}
if(__hm_break892) break;
}}
}
_hm.pc=309;
break;
case 311: // maincode.mod.gml:886
{
;
}
_hm.pc=310;
break;
case 312: // maincode.mod.gml:886
_hm.pc=0;
break;
case 313: // maincode.mod.gml:865
{
{ var __hm_with893 = scrHMInstances(IDPDSpawn), __hm_break895=false;
for (var __hm_index894=0; __hm_index894<array_length(__hm_with893); ++__hm_index894) {
if(instance_exists(__hm_with893[__hm_index894])) with (__hm_with893[__hm_index894]) {
if ((GameCont.loops <= 0)) {
scrHMDelete(id);
}
}
if(__hm_break895) break;
}}
scrHMSoundStop(sndIDPDPortalSpawn);
scrHMSoundStop(sndEliteIDPDPortalSpawn);
{ var __hm_with896 = scrHMInstances(GenCont), __hm_break898=false;
for (var __hm_index897=0; __hm_index897<array_length(__hm_with896); ++__hm_index897) {
if(instance_exists(__hm_with896[__hm_index897])) with (__hm_with896[__hm_index897]) {
if ((!scrHMVariableExists(id, "settip"))) {
{
if ((random(5) < 1)) {
tip = "turtles have arms";
} else {
if ((random(4) < 1)) {
tip = "kowabunga dude";
} else {
if ((random(3) < 1)) {
tip = "pizza boys";
} else {
if ((random(2) < 1)) {
tip = "no relation";
}
}
}
}
settip = 1;
}
}
}
if(__hm_break898) break;
}}
{ var __hm_with899 = scrHMInstances(instance_nearest((view_xview + random(view_width)), (view_yview + random(view_height)), Floor)), __hm_break901=false;
for (var __hm_index900=0; __hm_index900<array_length(__hm_with899); ++__hm_index900) {
if(instance_exists(__hm_with899[__hm_index900])) with (__hm_with899[__hm_index900]) {
if ((random(6) < 1)) {
{
if ((((place_meeting((x - 32), y, Floor) and place_meeting((x + 32), y, Floor)) and place_meeting(x, (y - 32), Floor)) and place_meeting(x, (y + 32), Floor))) {
{ var __hm_with902 = scrHMInstances(instance_create((x + random(32)), (y + random(32)), Drip)), __hm_break904=false;
for (var __hm_index903=0; __hm_index903<array_length(__hm_with902); ++__hm_index903) {
if(instance_exists(__hm_with902[__hm_index903])) with (__hm_with902[__hm_index903]) {
sprite_index = sprCheeseDrip;
}
if(__hm_break904) break;
}}
}
}
}
}
if(__hm_break901) break;
}}
{ var __hm_with905 = scrHMInstances(HPPickup), __hm_break907=false;
for (var __hm_index906=0; __hm_index906<array_length(__hm_with905); ++__hm_index906) {
if(instance_exists(__hm_with905[__hm_index906])) with (__hm_with905[__hm_index906]) {
sprite_index = sprSlice;
}
if(__hm_break907) break;
}}
}
_hm.pc=312;
break;
case 314: // maincode.mod.gml:1
{
;
}
_hm.pc=313;
break;
case 315: // maincode.mod.gml:1
_hm.pc=0;
break;
case 316: // maincode.mod.gml:1
{
scrHMSewerTick();
;
}
_hm.pc=315;
break;
case 317: // maincode.mod.gml:1
{
;
}
_hm.pc=316;
break;
case 318: // maincode.mod.gml:1
_hm.pc=0;
break;
case 319: // maincode.mod.gml:1
{
scrHMSewerTick();
;
}
_hm.pc=318;
break;
case 320: // maincode.mod.gml:686
{
;
}
_hm.pc=319;
break;
case 321: // maincode.mod.gml:686
_hm.pc=0;
break;
case 322: // maincode.mod.gml:658
scrHMTaskWithNext(_hm);
break;
case 323: // maincode.mod.gml:658
scrHMTaskWithAbort(_hm);
break;
case 324: // maincode.mod.gml:670
{
scrHMModCall("mod", "props", "fancylid_create", x, y);
image_index = 1;
}
_hm.pc=322;
break;
case 325: // maincode.mod.gml:669
_hm.wait_ticks=max(0,60); _hm.pc=324; return;
break;
case 326: // maincode.mod.gml:668
{
activated = 1;
;
}
_hm.pc=325;
break;
case 327: // maincode.mod.gml:667
_hm.pc = ((_hm.vars.no == 0)) ? 326 : 322;
break;
case 328: // maincode.mod.gml:664
{
{ var __hm_with908 = scrHMMatching(CustomObject, "name", "bossintros"), __hm_break910=false;
for (var __hm_index909=0; __hm_index909<array_length(__hm_with908); ++__hm_index909) {
if(instance_exists(__hm_with908[__hm_index909])) with (__hm_with908[__hm_index909]) {
_hm.vars.no += 1;
}
if(__hm_break910) break;
}}
}
_hm.pc=327;
break;
case 329: // maincode.mod.gml:677
{
;
if (instance_exists(id)) {
{
scrHMModCall("mod", "props", "fancylid_create", x, y);
image_index = 1;
}
}
}
_hm.pc=322;
break;
case 330: // maincode.mod.gml:676
_hm.wait_ticks=max(0,60); _hm.pc=329; return;
break;
case 331: // maincode.mod.gml:677
_hm.wait_ticks=max(0,180); _hm.pc=329; return;
break;
case 332: // maincode.mod.gml:676
_hm.pc = ((GameCont.loops == 0)) ? 330 : 331;
break;
case 333: // maincode.mod.gml:675
{
activated = 1;
;
}
_hm.pc=332;
break;
case 334: // maincode.mod.gml:674
_hm.pc = ((_hm.vars.no == 0)) ? 333 : 322;
break;
case 335: // maincode.mod.gml:662
_hm.pc = ((scrHMModExists("mod", "options", "bossoutros") and (scrHMModGet("mod", "options", "bossoutros") == "1"))) ? 328 : 334;
break;
case 336: // maincode.mod.gml:659
{
_hm.vars.no = 0;
;
if ((instance_number(enemy) > 1)) {
_hm.vars.no += 1;
}
}
_hm.pc=335;
break;
case 337: // maincode.mod.gml:658
_hm.pc = (((!scrHMVariableExists(_hm.scope, "activated")) and (image_index == 0))) ? 336 : 322;
break;
case 338: // maincode.mod.gml:658
scrHMTaskWithEnter(_hm,scrHMMatching(CustomObject, "name", "sewersentrance"),337,321);
break;
case 339: // maincode.mod.gml:639
{
{ var __hm_with911 = scrHMInstances(IDPDSpawn), __hm_break913=false;
for (var __hm_index912=0; __hm_index912<array_length(__hm_with911); ++__hm_index912) {
if(instance_exists(__hm_with911[__hm_index912])) with (__hm_with911[__hm_index912]) {
if ((GameCont.loops <= 0)) {
scrHMDelete(id);
}
}
if(__hm_break913) break;
}}
scrHMSoundStop(sndIDPDPortalSpawn);
scrHMSoundStop(sndEliteIDPDPortalSpawn);
{ var __hm_with914 = scrHMInstances(FloorExplo), __hm_break916=false;
for (var __hm_index915=0; __hm_index915<array_length(__hm_with914); ++__hm_index915) {
if(instance_exists(__hm_with914[__hm_index915])) with (__hm_with914[__hm_index915]) {
if (((!scrHMVariableExists(id, "ammo")) and (! instance_exists(Portal)))) {
{
ammo = 1;
scrHMModCall("mod", "enemies", "scrPickups", 2);
}
}
}
if(__hm_break916) break;
}}
{ var __hm_with917 = scrHMInstances(TopDecalDesert), __hm_break919=false;
for (var __hm_index918=0; __hm_index918<array_length(__hm_with917); ++__hm_index918) {
if(instance_exists(__hm_with917[__hm_index918])) with (__hm_with917[__hm_index918]) {
if ((!scrHMVariableExists(id, "why_are_you_so_far_down"))) {
{
if (place_meeting(x, (y - 16), Wall)) {
y -= 20;
}
why_are_you_so_far_down = 1;
}
}
}
if(__hm_break919) break;
}}
{ var __hm_with920 = scrHMInstances(instance_nearest((view_xview + random(view_width)), (view_yview + random(view_height)), Floor)), __hm_break922=false;
for (var __hm_index921=0; __hm_index921<array_length(__hm_with920); ++__hm_index921) {
if(instance_exists(__hm_with920[__hm_index921])) with (__hm_with920[__hm_index921]) {
if ((random(6) < 1)) {
{
if ((((place_meeting((x - 32), y, Floor) and place_meeting((x + 32), y, Floor)) and place_meeting(x, (y - 32), Floor)) and place_meeting(x, (y + 32), Floor))) {
{ var __hm_with923 = scrHMInstances(instance_create((x + random(32)), (y + random(32)), Wind)), __hm_break925=false;
for (var __hm_index924=0; __hm_index924<array_length(__hm_with923); ++__hm_index924) {
if(instance_exists(__hm_with923[__hm_index924])) with (__hm_with923[__hm_index924]) {
{
image_xscale = (- 1);
direction = 0;
}
}
if(__hm_break925) break;
}}
}
}
}
}
if(__hm_break922) break;
}}
}
_hm.pc=338;
break;
case 340: // maincode.mod.gml:637
{
;
}
_hm.pc=339;
break;
case 341: // maincode.mod.gml:637
_hm.pc=0;
break;
case 342: // maincode.mod.gml:618
{
{ var __hm_with926 = scrHMInstances(TopDecalNightDesert), __hm_break928=false;
for (var __hm_index927=0; __hm_index927<array_length(__hm_with926); ++__hm_index927) {
if(instance_exists(__hm_with926[__hm_index927])) with (__hm_with926[__hm_index927]) {
if ((!scrHMVariableExists(id, "why_are_you_so_far_down"))) {
{
if (place_meeting(x, (y - 16), Wall)) {
y -= 20;
}
why_are_you_so_far_down = 1;
}
}
}
if(__hm_break928) break;
}}
{ var __hm_with929 = scrHMInstances(Campfire), __hm_break931=false;
for (var __hm_index930=0; __hm_index930<array_length(__hm_with929); ++__hm_index930) {
if(instance_exists(__hm_with929[__hm_index930])) with (__hm_with929[__hm_index930]) {
{
if ((random(60) < 1)) {
{ var __hm_with932 = scrHMInstances(instance_create((x + random_range((- 3), 3)), ((y + random_range((- 3), 3)) - 10), FireFly)), __hm_break934=false;
for (var __hm_index933=0; __hm_index933<array_length(__hm_with932); ++__hm_index933) {
if(instance_exists(__hm_with932[__hm_index933])) with (__hm_with932[__hm_index933]) {
depth = (- 4);
}
if(__hm_break934) break;
}}
}
if (((spr_idle == sprCampfireOff) and ((position_meeting(x, y, Explosion) || position_meeting(x, y, Flame)) || (position_meeting(x, y, CustomProjectile) and (CustomProjectile.sprite_index == sprTrapFire))))) {
{
spr_idle = sprCampfire;
{ var __hm_with935 = scrHMInstances(instance_create(x, y, AmmoPickup)), __hm_break937=false;
for (var __hm_index936=0; __hm_index936<array_length(__hm_with935); ++__hm_index936) {
if(instance_exists(__hm_with935[__hm_index936])) with (__hm_with935[__hm_index936]) {
scrHMMotionAdd(random_range(60, 110), random(6));
}
if(__hm_break937) break;
}}
}
}
}
}
if(__hm_break931) break;
}}
{ var __hm_with938 = scrHMInstances(instance_nearest((view_xview + random(view_width)), (view_yview + random(view_height)), Floor)), __hm_break940=false;
for (var __hm_index939=0; __hm_index939<array_length(__hm_with938); ++__hm_index939) {
if(instance_exists(__hm_with938[__hm_index939])) with (__hm_with938[__hm_index939]) {
if ((random(6) < 1)) {
{
if ((((place_meeting((x - 32), y, Floor) and place_meeting((x + 32), y, Floor)) and place_meeting(x, (y - 32), Floor)) and place_meeting(x, (y + 32), Floor))) {
instance_create((x + random(32)), (y + random(32)), WindNight);
}
}
}
}
if(__hm_break940) break;
}}
}
_hm.pc=341;
break;
case 343: // maincode.mod.gml:616
{
;
}
_hm.pc=342;
break;
case 344: // maincode.mod.gml:616
_hm.pc=0;
break;
case 345: // maincode.mod.gml:612
{
if ((GameCont.subarea == 3)) {
{
if (instance_exists(GenCont)) {
TopCont.fog = global.hm_module_vars[$ "mod:maincode"].redfog;
}
{ var __hm_with941 = scrHMInstances(TopCont), __hm_break943=false;
for (var __hm_index942=0; __hm_index942<array_length(__hm_with941); ++__hm_index942) {
if(instance_exists(__hm_with941[__hm_index942])) with (__hm_with941[__hm_index942]) {
fogscroll = 100;
}
if(__hm_break943) break;
}}
}
}
}
_hm.pc=344;
break;
case 346: // maincode.mod.gml:561
scrHMTaskWithNext(_hm);
break;
case 347: // maincode.mod.gml:561
scrHMTaskWithAbort(_hm);
break;
case 348: // maincode.mod.gml:562
{
instance_destroy();
}
_hm.pc=346;
break;
case 349: // maincode.mod.gml:604
{
if ((intro > 2)) {
{
intro -= 2;
gunangle += random_range(25, 35);
}
}
}
_hm.pc=346;
break;
case 350: // maincode.mod.gml:601
{
;
}
_hm.pc=349;
break;
case 351: // maincode.mod.gml:601
_hm.result=undefined; _hm.done=true; return;
break;
case 352: // maincode.mod.gml:577
{
if ((instance_exists(id) and instance_exists(Player))) {
{
intro = 125;
charge = 0;
gunangle = point_direction(x, y, target.x, target.y);
spr_idle = sprBanditBossIdle;
spr_walk = sprBanditBossWalk;
spr_fire = sprBanditBossFire;
_hm.vars.i2 = 0;
{ var __hm_with944 = scrHMMatching(CustomObject, "name", "bossintro"), __hm_break946=false;
for (var __hm_index945=0; __hm_index945<array_length(__hm_with944); ++__hm_index945) {
if(instance_exists(__hm_with944[__hm_index945])) with (__hm_with944[__hm_index945]) {
{
_hm.vars.i2 += 1;
}
}
if(__hm_break946) break;
}}
if ((_hm.vars.i2 == 0)) {
{
scrHMSoundMusic(musBoss1);
if ((scrHMModGet("mod", "options", "intropan") == "1")) {
{
if ((UberCont.opt_bossintro == 1)) {
scrHMModCall("mod", "bossintros", "boss_trigger", "BIG BANDIT", sprBossIntroBackLayer, sprBossIntro, mskNone, id, 60);
} else {
scrHMModCall("mod", "bossintros", "boss_trigger", "", mskNone, mskNone, mskNone, id, 60);
}
}
} else {
if ((UberCont.opt_bossintro == 1)) {
scrHMModCall("mod", "bossintros", "boss_trigger", "BIG BANDIT", sprBossIntroBackLayer, sprBossIntro, mskNone, instance_nearest(x, y, Player), 0);
}
}
}
}
}
}
}
_hm.pc=351;
break;
case 353: // maincode.mod.gml:576
_hm.wait_ticks=max(0,15); _hm.pc=352; return;
break;
case 354: // maincode.mod.gml:575
_hm.pc = (scrHMTaskFork(_hm, 353)) ? 353 : 349;
break;
case 355: // maincode.mod.gml:568
{
intro = 2;
charge = 1;
alarm[1] = 60;
alarm[4] = 5;
spr_idle = sprBanditBossTell;
spr_walk = sprBanditBossDash;
spr_fire = sprBanditBossStop;
}
_hm.pc=354;
break;
case 356: // maincode.mod.gml:567
_hm.pc = ((((speed / timescale) < (friction / (timescale * timescale))) and (intro < 1))) ? 355 : 349;
break;
case 357: // maincode.mod.gml:566
_hm.pc = (((UberCont.opt_bossintro == 1) || (scrHMModExists("mod", "options", "intropan") and (scrHMModGet("mod", "options", "intropan") == "1")))) ? 356 : 346;
break;
case 358: // maincode.mod.gml:562
_hm.pc = ((GameCont.subarea < 3)) ? 348 : 357;
break;
case 359: // maincode.mod.gml:561
scrHMTaskWithEnter(_hm,scrHMInstances(BanditBoss),358,345);
break;
case 360: // maincode.mod.gml:501
{
if (((global.hm_module_vars[$ "mod:maincode"].venuz == 1) and instance_exists(Wall))) {
{
{ var __hm_with947 = scrHMInstances(instance_nearest(10016, 10016, Player)), __hm_break949=false;
for (var __hm_index948=0; __hm_index948<array_length(__hm_with947); ++__hm_index948) {
if(instance_exists(__hm_with947[__hm_index948])) with (__hm_with947[__hm_index948]) {
scrHMModCall("mod", "props", "VenuzCar_create", y, x, 50);
}
if(__hm_break949) break;
}}
scrHMSoundLoop(sndCarLoop);
global.hm_module_vars[$ "mod:maincode"].venuz = 0;
}
}
{ var __hm_with950 = scrHMInstances(GenCont), __hm_break952=false;
for (var __hm_index951=0; __hm_index951<array_length(__hm_with950); ++__hm_index951) {
if(instance_exists(__hm_with950[__hm_index951])) with (__hm_with950[__hm_index951]) {
if ((!scrHMVariableExists(id, "settip"))) {
{
if (((random(10) < 1) and (global.hm_module_vars[$ "mod:maincode"].runcount < 5))) {
tip = "                     click @W[modded]@s to#                  hide the list of mods";
} else {
if ((random(10) < 1)) {
tip = "monsters absorb radiation";
}
}
settip = 1;
}
}
}
if(__hm_break952) break;
}}
{ var __hm_with953 = scrHMInstances(Bones), __hm_break955=false;
for (var __hm_index954=0; __hm_index954<array_length(__hm_with953); ++__hm_index954) {
if(instance_exists(__hm_with953[__hm_index954])) with (__hm_with953[__hm_index954]) {
if ((!scrHMVariableExists(id, "randomchance"))) {
{
if ((random(320) < 1)) {
{
{ var __hm_with956 = scrHMInstances(Floor), __hm_break958=false;
for (var __hm_index957=0; __hm_index957<array_length(__hm_with956); ++__hm_index957) {
if(instance_exists(__hm_with956[__hm_index957])) with (__hm_with956[__hm_index957]) {
if ((random(5) < 4)) {
instance_create((x + 16), (y + 16), Cactus);
}
}
if(__hm_break958) break;
}}
}
}
{ var __hm_with959 = scrHMInstances(Floor), __hm_break961=false;
for (var __hm_index960=0; __hm_index960<array_length(__hm_with959); ++__hm_index960) {
if(instance_exists(__hm_with959[__hm_index960])) with (__hm_with959[__hm_index960]) {
if ((random(150) < 1)) {
{
instance_create(x, y, TopDecalDesert);
}
}
}
if(__hm_break961) break;
}}
randomchance = 1;
}
}
}
if(__hm_break955) break;
}}
{ var __hm_with962 = scrHMInstances(TopDecalDesert), __hm_break964=false;
for (var __hm_index963=0; __hm_index963<array_length(__hm_with962); ++__hm_index963) {
if(instance_exists(__hm_with962[__hm_index963])) with (__hm_with962[__hm_index963]) {
if ((!scrHMVariableExists(id, "why_are_you_so_far_down"))) {
{
if (place_meeting(x, (y - 16), Wall)) {
y -= 8;
}
why_are_you_so_far_down = 1;
}
}
}
if(__hm_break964) break;
}}
{ var __hm_with965 = scrHMInstances(FloorMaker), __hm_break967=false;
for (var __hm_index966=0; __hm_index966<array_length(__hm_with965); ++__hm_index966) {
if(instance_exists(__hm_with965[__hm_index966])) with (__hm_with965[__hm_index966]) {
{
if ((!scrHMVariableExists(id, "pick"))) {
{
pick = choose(0, 90, 180, 270);
;
}
}
if ((random(3) > 2)) {
direction = pick;
}
}
}
if(__hm_break967) break;
}}
;
{ var __hm_with968 = scrHMInstances(Bandit), __hm_break970=false;
for (var __hm_index969=0; __hm_index969<array_length(__hm_with968); ++__hm_index969) {
if(instance_exists(__hm_with968[__hm_index969])) with (__hm_with968[__hm_index969]) {
{
if ((random(6) < 1)) {
scrHMModCall("mod", "enemies", "elitebanditsleep_create", x, y);
} else {
{
if (((GameCont.loops > 0) and (random(32) < (1 + GameCont.loops)))) {
scrHMModCall("mod", "enemies", "enemyrebel_create", x, y);
} else {
scrHMModCall("mod", "enemies", "elitebandit_create", x, y, 0);
}
;
}
}
instance_change(Wind, 0);
instance_destroy();
}
}
if(__hm_break970) break;
}}
}
_hm.pc=359;
break;
case 361: // maincode.mod.gml:499
_hm.vars.__hm_switch1=GameCont.area;
if (_hm.vars.__hm_switch1==scrHMAreaResolve(1)) {_hm.pc=360;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("nightdesert")) {_hm.pc=342;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("scorpionboss")) {_hm.pc=339;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("sewers")) {_hm.pc=319;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve(102)) {_hm.pc=316;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("turtles")) {_hm.pc=313;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve(3)) {_hm.pc=310;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("ravenboss")) {_hm.pc=295;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("junkyard")) {_hm.pc=292;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("gatorcave")) {_hm.pc=260;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("gatorboss")) {_hm.pc=233;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("caves")) {_hm.pc=206;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("cavesinv")) {_hm.pc=203;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("city")) {_hm.pc=200;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("labs")) {_hm.pc=172;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("elevator")) {_hm.pc=154;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("HQ")) {_hm.pc=151;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve(106)) {_hm.pc=138;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("throne")) {_hm.pc=125;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("end")) {_hm.pc=93;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("venuz")) {_hm.pc=90;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("mansion")) {_hm.pc=53;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("oasis")) {_hm.pc=6;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("jungle")) {_hm.pc=3;} else {_hm.pc=0;}
break;
case 362: // maincode.mod.gml:467
{
{ var __hm_with971 = scrHMInstances(Devastator), __hm_break973=false;
for (var __hm_index972=0; __hm_index972<array_length(__hm_with971); ++__hm_index972) {
if(instance_exists(__hm_with971[__hm_index972])) with (__hm_with971[__hm_index972]) {
{
if ((damage < 500)) {
damage += 5;
}
if ((damage < 100)) {
instance_create((x + (hspeed / timescale)), (y + (vspeed / timescale)), PortalClear);
}
}
}
if(__hm_break973) break;
}}
{ var __hm_with974 = scrHMInstances(FlameBall), __hm_break976=false;
for (var __hm_index975=0; __hm_index975<array_length(__hm_with974); ++__hm_index975) {
if(instance_exists(__hm_with974[__hm_index975])) with (__hm_with974[__hm_index975]) {
{
_hm.vars.n_ = instance_nearest(x, y, hitme);
if ((((damage > 0) and place_meeting(x, y, _hm.vars.n_)) and (_hm.vars.n_.team != team))) {
{
{ var __hm_with977 = scrHMInstances(_hm.vars.n_), __hm_break979=false;
for (var __hm_index978=0; __hm_index978<array_length(__hm_with977); ++__hm_index978) {
if(instance_exists(__hm_with977[__hm_index978])) with (__hm_with977[__hm_index978]) {
if ((((sprite_index == spr_hurt) and (image_index <= 1)) || (sprite_index != spr_hurt))) {
{
hp -= 2;
scrHMSoundPlay(snd_hurt);
nexthurt += 4;
if ((spr_hurt != (- 1))) {
sprite_index = spr_hurt;
}
image_index = 0;
}
}
}
if(__hm_break979) break;
}}
}
}
}
}
if(__hm_break976) break;
}}
{ var __hm_with980 = scrHMMatchingNE(CrownObject, "image_alpha", 1), __hm_break982=false;
for (var __hm_index981=0; __hm_index981<array_length(__hm_with980); ++__hm_index981) {
if(instance_exists(__hm_with980[__hm_index981])) with (__hm_with980[__hm_index981]) {
image_alpha = 1;
}
if(__hm_break982) break;
}}
{ var __hm_with983 = scrHMInstances(GenCont), __hm_break985=false;
for (var __hm_index984=0; __hm_index984<array_length(__hm_with983); ++__hm_index984) {
if(instance_exists(__hm_with983[__hm_index984])) with (__hm_with983[__hm_index984]) {
if ((!scrHMVariableExists(id, "settip"))) {
{
{ var __hm_with986 = scrHMInstances(Player), __hm_break988=false;
for (var __hm_index987=0; __hm_index987<array_length(__hm_with986); ++__hm_index987) {
if(instance_exists(__hm_with986[__hm_index987])) with (__hm_with986[__hm_index987]) {
if (((wep == scrHMWeaponResolve(111)) and (random(20) < 1))) {
var __hm_other989=scrHMOther(other);
__hm_other989.tip = "the SPC was a mistake";
}
}
if(__hm_break988) break;
}}
settip = 1;
}
}
}
if(__hm_break985) break;
}}
}
_hm.pc=361;
break;
case 363: // maincode.mod.gml:441
scrHMTaskWithNext(_hm);
break;
case 364: // maincode.mod.gml:441
scrHMTaskWithAbort(_hm);
break;
case 365: // maincode.mod.gml:459
{
{ var __hm_with990 = scrHMMatching(Floor, "sprite_index", sprFloor4, sprFloor104B), __hm_break992=false;
for (var __hm_index991=0; __hm_index991<array_length(__hm_with990); ++__hm_index991) {
if(instance_exists(__hm_with990[__hm_index991])) with (__hm_with990[__hm_index991]) {
if (((distance_to_object((scrHMOther(other))) < 32) and (random(60) < 1))) {
{
if ((styleb == 1)) {
sprite_index = sprFloor104B;
} else {
sprite_index = sprFloor104;
}
}
}
}
if(__hm_break992) break;
}}
}
_hm.pc=363;
break;
case 366: // maincode.mod.gml:444
scrHMTaskWithNext(_hm);
break;
case 367: // maincode.mod.gml:444
scrHMTaskWithAbort(_hm);
break;
case 368: // maincode.mod.gml:446
{
if (instance_exists(id)) {
{
_hm.vars._x = x;
;
_hm.vars._y = y;
;
_hm.vars.area = GameCont.area;
;
_hm.vars.subarea = GameCont.subarea;
;
if (((scrHMAreaResolve(_hm.vars.area) == GameCont.area) && (_hm.vars.subarea == GameCont.subarea))) {
{
instance_destroy();
;
instance_create(_hm.vars._x, _hm.vars._y, Wall);
;
}
}
}
}
}
_hm.pc=366;
break;
case 369: // maincode.mod.gml:446
_hm.pc = (scrHMTaskFork(_hm, 368)) ? 368 : 366;
break;
case 370: // maincode.mod.gml:445
_hm.pc = ((((instance_exists(_hm.other_scope) and instance_exists(_hm.scope)) and (distance_to_object(_hm.other_scope) < 32)) and (random(60) < 1))) ? 369 : 366;
break;
case 371: // maincode.mod.gml:444
scrHMTaskWithEnter(_hm,scrHMMatching(Wall, "sprite_index", sprWall4Bot),370,365);
break;
case 372: // maincode.mod.gml:442
{
if ((GameCont.area == scrHMAreaResolve("caves"))) {
GameCont.area = scrHMAreaResolve("cavesinv");
}
}
_hm.pc=371;
break;
case 373: // maincode.mod.gml:441
scrHMTaskWithEnter(_hm,scrHMMatchingGE(Player, "curse", 1),372,362);
break;
case 374: // maincode.mod.gml:254
{
if ((scrHMModExists("mod", "options", "rads") and (scrHMModGet("mod", "options", "rads") == "1"))) {
{
{ var __hm_with993 = scrHMMatchingNE(enemy, "team", 3), __hm_break995=false;
for (var __hm_index994=0; __hm_index994<array_length(__hm_with993); ++__hm_index994) {
if(instance_exists(__hm_with993[__hm_index994])) with (__hm_with993[__hm_index994]) {
{
{ var __hm_with996 = scrHMInstances(Rad), __hm_break998=false;
for (var __hm_index997=0; __hm_index997<array_length(__hm_with996); ++__hm_index997) {
if(instance_exists(__hm_with996[__hm_index997])) with (__hm_with996[__hm_index997]) {
if (((distance_to_object((scrHMOther(other))) < 32) and (distance_to_object(Player) > 32))) {
{
var __hm_other999=scrHMOther(other);
scrHMMotionAdd(point_direction(x, y, __hm_other999.x, __hm_other999.y), 0.5);
if (place_meeting(x, y, (scrHMOther(other)))) {
{
instance_create(x, y, RadEat);
instance_destroy();
var __hm_other1000=scrHMOther(other);
__hm_other1000.raddrop += 1;
}
}
}
}
}
if(__hm_break998) break;
}}
}
}
if(__hm_break995) break;
}}
}
}
{ var __hm_with1001 = scrHMInstances(Player), __hm_break1003=false;
for (var __hm_index1002=0; __hm_index1002<array_length(__hm_with1001); ++__hm_index1002) {
if(instance_exists(__hm_with1001[__hm_index1002])) with (__hm_with1001[__hm_index1002]) {
if ((!scrHMVariableExists(id, "scale"))) {
scale = 1;
}
}
if(__hm_break1003) break;
}}
if ((scrHMModExists("mod", "options", "portals") and (scrHMModGet("mod", "options", "portals") == "1"))) {
{
{ var __hm_with1004 = scrHMInstances(Portal), __hm_break1006=false;
for (var __hm_index1005=0; __hm_index1005<array_length(__hm_with1004); ++__hm_index1005) {
if(instance_exists(__hm_with1004[__hm_index1005])) with (__hm_with1004[__hm_index1005]) {
if (((!scrHMVariableExists(id, "nompportal")) and (! instance_exists(BigPortal)))) {
{
image_alpha = 0;
{ var __hm_with1007 = scrHMInstances(Player), __hm_break1009=false;
for (var __hm_index1008=0; __hm_index1008<array_length(__hm_with1007); ++__hm_index1008) {
if(instance_exists(__hm_with1007[__hm_index1008])) with (__hm_with1007[__hm_index1008]) {
{
if ((!scrHMVariableExists(id, "scale"))) {
scale = 1;
}
_hm.vars.por = instance_nearest(x, y, Portal);
if ((point_distance(_hm.vars.por.x, _hm.vars.por.y, x, y) > 24)) {
{
_hm.vars.por.endgame = 100;
if ((image_alpha == 0)) {
{
scale = 1;
if ((scrHMVariableExists(id, "swimming") and (swimming == 1))) {
image_alpha = 0;
} else {
if ((mask_index != mskNone)) {
image_alpha = 1;
}
}
can_shoot = 1;
if ((race == scrHMRaceResolve("steroids"))) {
bcan_shoot = 1;
}
can_walk = 1;
reload = 0;
}
}
}
} else {
{
_hm.vars.por.endgame -= (1 / instance_number(Player));
if ((scale > 0)) {
scale -= 0.03;
}
{ var __hm_with1010 = scrHMInstances(scrHMBindDraw(hm_maincode_mod_gml_PortalShrink, (- 10))), __hm_break1012=false;
for (var __hm_index1011=0; __hm_index1011<array_length(__hm_with1010); ++__hm_index1011) {
if(instance_exists(__hm_with1010[__hm_index1011])) with (__hm_with1010[__hm_index1011]) {
var __hm_other1013=scrHMOther(other);
creator = __hm_other1013;
}
if(__hm_break1012) break;
}}
image_alpha = 0;
can_walk = 0;
if ((distance_to_point((scrHMOther(other)).x, (scrHMOther(other)).y) > 2)) {
var __hm_other1014=scrHMOther(other);
direction = point_direction(x, y, __hm_other1014.x, __hm_other1014.y);
} else {
speed = (0) * timescale;
}
}
}
}
}
if(__hm_break1009) break;
}}
{ var __hm_with1015 = scrHMInstances(scrHMBindDraw(hm_maincode_mod_gml_StablePortal, (- 10))), __hm_break1017=false;
for (var __hm_index1016=0; __hm_index1016<array_length(__hm_with1015); ++__hm_index1016) {
if(instance_exists(__hm_with1015[__hm_index1016])) with (__hm_with1015[__hm_index1016]) {
var __hm_other1018=scrHMOther(other);
creator = __hm_other1018;
}
if(__hm_break1017) break;
}}
}
}
}
if(__hm_break1006) break;
}}
{ var __hm_with1019 = scrHMInstances(GenCont), __hm_break1021=false;
for (var __hm_index1020=0; __hm_index1020<array_length(__hm_with1019); ++__hm_index1020) {
if(instance_exists(__hm_with1019[__hm_index1020])) with (__hm_with1019[__hm_index1020]) {
{ var __hm_with1022 = scrHMInstances(Player), __hm_break1024=false;
for (var __hm_index1023=0; __hm_index1023<array_length(__hm_with1022); ++__hm_index1023) {
if(instance_exists(__hm_with1022[__hm_index1023])) with (__hm_with1022[__hm_index1023]) {
if ((scrHMVariableExists(id, "scale") and (! instance_exists(Portal)))) {
{
if ((!scrHMVariableExists(id, "scale"))) {
scale = 1;
}
scale = 1;
image_alpha = 1;
can_shoot = 1;
if ((race == scrHMRaceResolve("steroids"))) {
bcan_shoot = 1;
}
can_walk = 1;
reload = 0;
}
}
}
if(__hm_break1024) break;
}}
}
if(__hm_break1021) break;
}}
}
}
{ var __hm_with1025 = scrHMInstances(Player), __hm_break1027=false;
for (var __hm_index1026=0; __hm_index1026<array_length(__hm_with1025); ++__hm_index1026) {
if(instance_exists(__hm_with1025[__hm_index1026])) with (__hm_with1025[__hm_index1026]) {
if (scrHMButtonPressed(index, "horn")) {
{
if (((((race != 6) && (race <= 15)) && (race != 14)) && ((bskin == 0) || (bskin == 1)))) {
scrHMSoundPlay(asset_get_index((("sndMutant" + string(race)) + "Cnfm")));
} else {
if ((race != 6)) {
scrHMSoundPlay(snd_wrld);
}
}
}
}
}
if(__hm_break1027) break;
}}
if ((scrHMModExists("mod", "options", "rogue") and (scrHMModGet("mod", "options", "rogue") == "1"))) {
{
_hm.vars.rog = 0;
;
{ var __hm_with1028 = scrHMMatching(Player, "race", "rogue"), __hm_break1030=false;
for (var __hm_index1029=0; __hm_index1029<array_length(__hm_with1028); ++__hm_index1029) {
if(instance_exists(__hm_with1028[__hm_index1029])) with (__hm_with1028[__hm_index1029]) {
_hm.vars.rog = 1;
}
if(__hm_break1030) break;
}}
if ((_hm.vars.rog == 1)) {
{
{ var __hm_with1031 = scrHMInstances(RogueChest), __hm_break1033=false;
for (var __hm_index1032=0; __hm_index1032<array_length(__hm_with1031); ++__hm_index1032) {
if(instance_exists(__hm_with1031[__hm_index1032])) with (__hm_with1031[__hm_index1032]) {
{
scrHMRogueCanisters109();
}
}
if(__hm_break1033) break;
}}
if (instance_exists(Portal)) {
{
{ var __hm_with1034 = scrHMMatching(enemy, "object_index", Grunt), __hm_break1036=false;
for (var __hm_index1035=0; __hm_index1035<array_length(__hm_with1034); ++__hm_index1035) {
if(instance_exists(__hm_with1034[__hm_index1035])) with (__hm_with1034[__hm_index1035]) {
scrHMBindEndStep(hm_maincode_mod_gml_resourceful, 1, id, x, y, 12);
}
if(__hm_break1036) break;
}}
{ var __hm_with1037 = scrHMMatching(enemy, "object_index", Inspector, Shielder, PopoFreak), __hm_break1039=false;
for (var __hm_index1038=0; __hm_index1038<array_length(__hm_with1037); ++__hm_index1038) {
if(instance_exists(__hm_with1037[__hm_index1038])) with (__hm_with1037[__hm_index1038]) {
scrHMBindEndStep(hm_maincode_mod_gml_resourceful, 1, id, x, y, 8);
}
if(__hm_break1039) break;
}}
{ var __hm_with1040 = scrHMMatching(enemy, "object_index", EliteGrunt, EliteInspector, EliteShielder), __hm_break1042=false;
for (var __hm_index1041=0; __hm_index1041<array_length(__hm_with1040); ++__hm_index1041) {
if(instance_exists(__hm_with1040[__hm_index1041])) with (__hm_with1040[__hm_index1041]) {
scrHMBindEndStep(hm_maincode_mod_gml_resourceful, 1, id, x, y, 4);
}
if(__hm_break1042) break;
}}
}
}
}
}
}
}
{ var __hm_with1043 = scrHMMatching(CharSelect, "race", 1), __hm_break1045=false;
for (var __hm_index1044=0; __hm_index1044<array_length(__hm_with1043); ++__hm_index1044) {
if(instance_exists(__hm_with1043[__hm_index1044])) with (__hm_with1043[__hm_index1044]) {
{
{ var __hm_with1046 = scrHMInstances(TopCont), __hm_break1048=false;
for (var __hm_index1047=0; __hm_index1047<array_length(__hm_with1046); ++__hm_index1047) {
if(instance_exists(__hm_with1046[__hm_index1047])) with (__hm_with1046[__hm_index1047]) {
darkness = 1;
}
if(__hm_break1048) break;
}}
scrHMBindDraw(hm_maincode_mod_gml_shilling, (- 100));
scrHMBindDraw(hm_maincode_mod_gml_versionnumber, (- 1002));
{ var __hm_with1049 = scrHMInstances(Campfire), __hm_break1051=false;
for (var __hm_index1050=0; __hm_index1050<array_length(__hm_with1049); ++__hm_index1050) {
if(instance_exists(__hm_with1049[__hm_index1050])) with (__hm_with1049[__hm_index1050]) {
if ((random(7) < 1)) {
{ var __hm_with1052 = scrHMInstances(instance_create((x + random_range((- 3), 3)), ((y + random_range((- 3), 3)) - 10), FireFly)), __hm_break1054=false;
for (var __hm_index1053=0; __hm_index1053<array_length(__hm_with1052); ++__hm_index1053) {
if(instance_exists(__hm_with1052[__hm_index1053])) with (__hm_with1052[__hm_index1053]) {
{
depth = (- 4);
scrHMMotionAdd((80 + random(20)), choose(0, random(3)));
}
}
if(__hm_break1054) break;
}}
}
}
if(__hm_break1051) break;
}}
{ var __hm_with1055 = scrHMMatching(CampChar, "num", 15, 14), __hm_break1057=false;
for (var __hm_index1056=0; __hm_index1056<array_length(__hm_with1055); ++__hm_index1056) {
if(instance_exists(__hm_with1055[__hm_index1056])) with (__hm_with1055[__hm_index1056]) {
instance_destroy();
}
if(__hm_break1057) break;
}}
}
}
if(__hm_break1045) break;
}}
{ var __hm_with1058 = scrHMInstances(GenCont), __hm_break1060=false;
for (var __hm_index1059=0; __hm_index1059<array_length(__hm_with1058); ++__hm_index1059) {
if(instance_exists(__hm_with1058[__hm_index1059])) with (__hm_with1058[__hm_index1059]) {
safedist = 180;
}
if(__hm_break1060) break;
}}
if ((GameCont.area != scrHMAreaResolve("city"))) {
{
{ var __hm_with1061 = scrHMInstances(CarThrow), __hm_break1063=false;
for (var __hm_index1062=0; __hm_index1062<array_length(__hm_with1061); ++__hm_index1062) {
if(instance_exists(__hm_with1061[__hm_index1062])) with (__hm_with1061[__hm_index1062]) {
{
hitid = [sprCarThrown, "Thrown Car"];
}
}
if(__hm_break1063) break;
}}
GameCont.novans = (GameCont.loops <= 0);
if ((((GameCont.area != scrHMAreaResolve("labs")) && (GameCont.area != scrHMAreaResolve("elevator"))) && (GameCont.area != scrHMAreaResolve(106)))) {
{
{ var __hm_with1064 = scrHMInstances(WantPopo), __hm_break1066=false;
for (var __hm_index1065=0; __hm_index1065<array_length(__hm_with1064); ++__hm_index1065) {
if(instance_exists(__hm_with1064[__hm_index1065])) with (__hm_with1064[__hm_index1065]) {
if ((GameCont.loops <= 0)) {
instance_destroy();
}
}
if(__hm_break1066) break;
}}
{ var __hm_with1067 = scrHMInstances(IDPDSpawn), __hm_break1069=false;
for (var __hm_index1068=0; __hm_index1068<array_length(__hm_with1067); ++__hm_index1068) {
if(instance_exists(__hm_with1067[__hm_index1068])) with (__hm_with1067[__hm_index1068]) {
freak = 0;
}
if(__hm_break1069) break;
}}
}
}
}
}
if ((instance_number(Player) > 1)) {
{ var __hm_with1070 = scrHMInstances(AmmoChest), __hm_break1072=false;
for (var __hm_index1071=0; __hm_index1071<array_length(__hm_with1070); ++__hm_index1071) {
if(instance_exists(__hm_with1070[__hm_index1071])) with (__hm_with1070[__hm_index1071]) {
if ((! instance_exists(SpiralCont))) {
{
scrHMModCall("mod", "props", "mpAmmoChest_create", x, y);
scrHMDelete(id);
}
}
}
if(__hm_break1072) break;
}}
}
{ var __hm_with1073 = scrHMInstances(AmmoChestMystery), __hm_break1075=false;
for (var __hm_index1074=0; __hm_index1074<array_length(__hm_with1073); ++__hm_index1074) {
if(instance_exists(__hm_with1073[__hm_index1074])) with (__hm_with1073[__hm_index1074]) {
if ((! instance_exists(SpiralCont))) {
{
instance_change(AmmoChest, 1);
}
}
}
if(__hm_break1075) break;
}}
{ var __hm_with1076 = scrHMMatching(ChestOpen, "sprite_index", sprAmmoChestMysteryOpen), __hm_break1078=false;
for (var __hm_index1077=0; __hm_index1077<array_length(__hm_with1076); ++__hm_index1077) {
if(instance_exists(__hm_with1076[__hm_index1077])) with (__hm_with1076[__hm_index1077]) {
instance_destroy();
}
if(__hm_break1078) break;
}}
{ var __hm_with1079 = scrHMMatchingNE(WeaponChest, "set_curse", 1), __hm_break1081=false;
for (var __hm_index1080=0; __hm_index1080<array_length(__hm_with1079); ++__hm_index1080) {
if(instance_exists(__hm_with1079[__hm_index1080])) with (__hm_with1079[__hm_index1080]) {
if (((((GameCont.crown == 1) and (GameCont.area != scrHMAreaResolve("HQ"))) and (GameCont.hard > 3)) and (object_index != BigWeaponChest))) {
{
if ((GameCont.hard <= 16)) {
{
if ((random((40 - GameCont.hard)) < 1)) {
{
curse = 1;
sprite_index = sprCursedChest;
}
}
}
} else {
if ((random(14) < 1)) {
{
curse = 1;
sprite_index = sprCursedChest;
}
}
}
set_curse = 1;
}
}
}
if(__hm_break1081) break;
}}
{ var __hm_with1082 = scrHMMatchingNE(BigWeaponChest, "set_curse", 1), __hm_break1084=false;
for (var __hm_index1083=0; __hm_index1083<array_length(__hm_with1082); ++__hm_index1083) {
if(instance_exists(__hm_with1082[__hm_index1083])) with (__hm_with1082[__hm_index1083]) {
if ((GameCont.crown == 1)) {
{
if ((GameCont.hard <= 16)) {
{
if (((random(((14 + 16) - GameCont.hard)) < 1) and ((GameCont.area == scrHMAreaResolve(4)) || (GameCont.area == scrHMAreaResolve(104)) || (GameCont.area == scrHMAreaResolve("caves")) || (GameCont.area == scrHMAreaResolve("cavesinv")) || (GameCont.area == scrHMAreaResolve("icecave"))))) {
{
curse = 1;
instance_change(CursedBigChest, 1);
}
}
}
} else {
if (((random(14) < 1) and ((GameCont.area == scrHMAreaResolve(4)) || (GameCont.area == scrHMAreaResolve(104)) || (GameCont.area == scrHMAreaResolve("caves")) || (GameCont.area == scrHMAreaResolve("cavesinv")) || (GameCont.area == scrHMAreaResolve("icecave"))))) {
{
curse = 1;
instance_change(CursedBigChest, 1);
}
}
}
set_curse = 1;
}
}
}
if(__hm_break1084) break;
}}
{ var __hm_with1085 = scrHMInstances(Player), __hm_break1087=false;
for (var __hm_index1086=0; __hm_index1086<array_length(__hm_with1085); ++__hm_index1086) {
if(instance_exists(__hm_with1085[__hm_index1086])) with (__hm_with1085[__hm_index1086]) {
{
if (instance_exists(SkillIcon)) {
{
if ((curse == 2)) {
curse = 1;
}
if ((bcurse == 2)) {
bcurse = 1;
}
}
} else {
{
if ((curse == 1)) {
curse = 2;
}
if ((bcurse == 1)) {
bcurse = 2;
}
}
}
}
}
if(__hm_break1087) break;
}}
}
_hm.pc=373;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source maincode.mod.gml:2653; move_player_snap
function hm_maincode_mod_gml_move_player_snap() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_maincode_mod_gml_move_player_snap_resume, id, scrHMOther(other), _args, 14, ["_index", "_x", "_y"]);
}
function hm_maincode_mod_gml_move_player_snap_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_maincode_mod_gml_move_player_snap");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // maincode.mod.gml:2654
scrHMTaskWithNext(_hm);
break;
case 2: // maincode.mod.gml:2654
scrHMTaskWithAbort(_hm);
break;
case 3: // maincode.mod.gml:2671
{
;
}
_hm.pc=1;
break;
case 4: // maincode.mod.gml:2671
_hm.result=undefined; _hm.done=true; return;
break;
case 5: // maincode.mod.gml:2670
{
global.hm_camera_targets[_hm.vars._index] = _hm.vars._vo;
;
}
_hm.pc=4;
break;
case 6: // maincode.mod.gml:2665
scrHMTaskWithNext(_hm);
break;
case 7: // maincode.mod.gml:2665
scrHMTaskWithAbort(_hm);
break;
case 8: // maincode.mod.gml:2667
{
;
if (instance_exists(id)) {
instance_destroy();
}
}
_hm.pc=6;
break;
case 9: // maincode.mod.gml:2667
_hm.wait_ticks=max(0,1); _hm.pc=8; return;
break;
case 10: // maincode.mod.gml:2666
{
global.hm_camera_targets[_hm.vars._index] = id;
;
}
_hm.pc=9;
break;
case 11: // maincode.mod.gml:2665
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create((x + lengthdir_x(_dis, _dir)), (y + lengthdir_y(_dis, _dir)), GameObject)),10,5);
break;
case 12: // maincode.mod.gml:2664
_hm.pc = (scrHMTaskFork(_hm, 11)) ? 11 : 1;
break;
case 13: // maincode.mod.gml:2655
{
_hm.vars._vo = global.hm_camera_targets[_hm.vars._index];
;
_dis = (point_distance(_hm.vars._x, _hm.vars._y, x, y) * (7 / 3));
;
_dir = (point_direction(_hm.vars._x, _hm.vars._y, x, y) + 180);
;
x = _hm.vars._x;
;
y = _hm.vars._y;
;
}
_hm.pc=12;
break;
case 14: // maincode.mod.gml:2654
scrHMTaskWithEnter(_hm,scrHMInstances(scrHMPlayerFind(_hm.vars._index)),13,0);
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source maincode.mod.gml:2674; venuzfadein
function hm_maincode_mod_gml_venuzfadein() {
if ((fade > 0)) {
{
fade -= 4;
draw_set_alpha((fade / 175));
;
draw_set_color(0);
;
draw_rectangle(view_xview, view_yview, (view_xview + view_width), (view_yview + view_height), 0);
draw_set_alpha(1);
draw_set_color(c_white);
;
}
} else {
scrHMDelete(id);
}
}

// Source maincode.mod.gml:2684; StablePortal
function hm_maincode_mod_gml_StablePortal() {
{ var __hm_with1 = scrHMInstances(creator), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMDrawSpriteExt(sprite_index, image_index, x, y, 1, 1, 0, c_white, 1);
}
if(__hm_break3) break;
}}
scrHMMenuDrawComplete();
}

// Source maincode.mod.gml:2688; PortalShrink
function hm_maincode_mod_gml_PortalShrink() {
{ var __hm_with1 = scrHMInstances(creator), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
if ((bwep != scrHMWeaponResolve(0))) {
{
if ((race != 7)) {
scrHMDrawSpriteExt(scrHMWeaponSprite(bwep), 0, (x - (right * 2)), (y + 4), scale, scale, ((90 + (15 * right)) * scale), c_silver, 1);
} else {
scrHMDrawSpriteExt(scrHMWeaponSprite(bwep), 0, (x + lengthdir_x((bwkick * (- 1)), gunangle)), (y + lengthdir_y((bwkick * (- 1)), gunangle)), scale, ((right * (- 1)) * scale), (gunangle + wepangle), c_white, 1);
}
;
}
}
if ((gunangle < 180)) {
{
scrHMDrawSpriteExt(scrHMWeaponSprite(wep), 0, (x + lengthdir_x(wkick, gunangle)), ((y + lengthdir_y(wkick, gunangle)) + 4), scale, (right * scale), (((gunangle * scale) + wepangle) * scale), c_white, 1);
;
}
}
scrHMDrawSpriteExt(spr_hurt, 1, x, y, scale, (scale * right), angle, c_white, 1);
if ((gunangle >= 180)) {
scrHMDrawSpriteExt(scrHMWeaponSprite(wep), 0, (x + lengthdir_x((wkick * (- 1)), gunangle)), ((y + lengthdir_y((wkick * (- 1)), gunangle)) + 4), scale, (right * scale), ((gunangle + wepangle) * scale), c_white, 1);
}
if(scrHMReadyTick()) { angle += 5; }
}
}
if(__hm_break3) break;
}}
scrHMMenuDrawComplete();
}

// Source maincode.mod.gml:2707; either
function hm_maincode_mod_gml_either() {
var _hml_v = argument[0];
var _hml_i = 0;
;
repeat ((argument_count - 1)) {
if ((argument[(++ _hml_i)] == _hml_v)) {
return true;
}
}
return false;
;
}

// Source maincode.mod.gml:2715; bigdogintro
function hm_maincode_mod_gml_bigdogintro() {
{ var __hm_with1 = scrHMInstances(creator), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
draw_set_color(make_color_rgb(20, 20, 20));
;
scrHMDrawSpriteExt(shd64, 1, x, (y + spr_shadow_y), image_xscale, image_yscale, 1, c_white, 0.4);
;
scrHMDrawSpriteExt(sprScrapBossIntro, introanimation, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
;
}
}
if(__hm_break3) break;
}}
scrHMMenuDrawComplete();
}

// Source maincode.mod.gml:2722; CHCoutro
function hm_maincode_mod_gml_CHCoutro(_x,_y) {scrHMCursedCavesRestore(_x,_y);instance_destroy();}

// Source maincode.mod.gml:2734; sewerboi
function hm_maincode_mod_gml_sewerboi() {
if(!instance_exists(creator) || !(creator[$ "swimming"]??false)) return;
{ var __hm_with1 = scrHMInstances(creator), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if(!scrHMSwimSprite106()) continue;
{
if ((object_index == Player)) {
{
if ((bwep != scrHMWeaponResolve(0))) {
{
if ((race != 7)) {
scrHMDrawSpriteExt(scrHMWeaponSprite(bwep), 0, (x - (right * 2)), (y + 4), 1, ((bwepflip * right) * (- 1)), (90 + (15 * right)), c_silver, 1);
} else {
scrHMDrawSpriteExt(scrHMWeaponSprite(bwep), 0, (x + lengthdir_x((bwkick * (- 1)), gunangle)), (y + lengthdir_y((bwkick * (- 1)), gunangle)), 1, (right * (- 1)), (gunangle + wepangle), c_white, 1);
}
;
}
}
if ((gunangle < 180)) {
{
scrHMDrawSpriteExt(scrHMWeaponSprite(wep), 0, (x + lengthdir_x((wkick * (- 1)), gunangle)), ((y + lengthdir_y((wkick * (- 1)), gunangle)) + 4), 1, right, (gunangle + wepangle), c_white, 1);
;
}
}
if ((angle == 0)) {
draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_get_width(sprite_index), (sprite_get_height(sprite_index) - (sprite_get_height(sprite_index) / 2)), (x - ((sprite_get_width(sprite_index) / 2) * right)), ((y + 4) - (sprite_get_height(sprite_index) / 2)), right, 1, image_blend, 1);
} else {
scrHMDrawSpriteExt(sprite_index, image_index, x, (y + 2), 1, right, (angle + (180 * scrHMGetSkill(5))), image_blend, 1);
}
;
if ((gunangle >= 180)) {
scrHMDrawSpriteExt(scrHMWeaponSprite(wep), 0, (x + lengthdir_x((wkick * (- 1)), gunangle)), ((y + lengthdir_y((wkick * (- 1)), gunangle)) + 4), 1, right, (gunangle + wepangle), c_white, 1);
}
}
} else {
if ((object_index == Gator)) {
{
if ((gunangle < 180)) {
scrHMDrawSpriteExt(sprShotgun, 0, (x + lengthdir_x((wkick * (- 1)), gunangle)), ((y + lengthdir_y((wkick * (- 1)), gunangle)) + 4), 1, right, gunangle, c_white, 1);
}
draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_get_width(sprite_index), (sprite_get_height(sprite_index) - (sprite_get_height(sprite_index) / 2)), (x - ((sprite_get_width(sprite_index) / 2) * right)), ((y + 4) - (sprite_get_height(sprite_index) / 2)), right, 1, image_blend, 1);
if ((gunangle >= 180)) {
scrHMDrawSpriteExt(sprShotgun, 0, (x + lengthdir_x((wkick * (- 1)), gunangle)), ((y + lengthdir_y((wkick * (- 1)), gunangle)) + 4), 1, right, gunangle, c_white, 1);
}
}
} else {
if ((object_index == BuffGator)) {
{
if ((gunangle < 180)) {
scrHMDrawSpriteExt(sprFlakCannon, 0, (x + lengthdir_x((wkick * (- 1)), gunangle)), ((y + lengthdir_y((wkick * (- 1)), gunangle)) + 4), 1, right, gunangle, c_white, 1);
}
draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_get_width(sprite_index), (sprite_get_height(sprite_index) - (sprite_get_height(sprite_index) / 2)), (x - ((sprite_get_width(sprite_index) / 2) * right)), ((y + 4) - (sprite_get_height(sprite_index) / 2)), right, 1, image_blend, 1);
if ((gunangle >= 180)) {
scrHMDrawSpriteExt(sprFlakCannon, 0, (x + lengthdir_x((wkick * (- 1)), gunangle)), ((y + lengthdir_y((wkick * (- 1)), gunangle)) + 4), 1, right, gunangle, c_white, 1);
}
}
} else {
{
draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_get_width(sprite_index), (sprite_get_height(sprite_index) - (sprite_get_height(sprite_index) / 2)), (x - ((sprite_get_width(sprite_index) / 2) * right)), ((y + 4) - (sprite_get_height(sprite_index) / 2)), right, 1, image_blend, 1);
}
}
}
}
}
}
if(__hm_break3) break;
}}
scrHMMenuDrawComplete();
}

// Source maincode.mod.gml:2771; spacesewerboi
function hm_maincode_mod_gml_spacesewerboi() {
{ var __hm_with1 = scrHMInstances(creator), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if(!scrHMSwimSprite106()) continue;
{
if ((object_index == Player)) {
{
if ((bwep != scrHMWeaponResolve(0))) {
{
if ((race != 7)) {
scrHMDrawSpriteExt(scrHMWeaponSprite(bwep), 0, (x - (right * 2)), (y + 4), 1, ((bwepflip * right) * (- 1)), (90 + (15 * right)), c_silver, 1);
} else {
scrHMDrawSpriteExt(scrHMWeaponSprite(bwep), 0, (x + lengthdir_x((bwkick * (- 1)), gunangle)), ((y + lengthdir_y((bwkick * (- 1)), gunangle)) + 4), 1, (right * (- 1)), (gunangle + wepangle), c_white, 1);
}
;
}
}
if ((gunangle < 180)) {
{
scrHMDrawSpriteExt(scrHMWeaponSprite(wep), 0, (x + lengthdir_x((wkick * (- 1)), gunangle)), (y + lengthdir_y((wkick * (- 1)), gunangle)), 1, right, (gunangle + wepangle), c_white, 1);
;
}
}
if ((angle == 0)) {
draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_get_width(sprite_index), (sprite_get_height(sprite_index) - (sprite_get_height(sprite_index) / 4)), (x - ((sprite_get_width(sprite_index) / 2) * right)), ((y - 4) - (sprite_get_height(sprite_index) / 4)), right, 1, image_blend, 1);
} else {
scrHMDrawSpriteExt(sprite_index, image_index, x, (y + 2), 1, right, (angle + (180 * scrHMGetSkill(5))), image_blend, 1);
}
;
if ((gunangle >= 180)) {
scrHMDrawSpriteExt(scrHMWeaponSprite(wep), 0, (x + lengthdir_x((wkick * (- 1)), gunangle)), (y + lengthdir_y((wkick * (- 1)), gunangle)), 1, right, (gunangle + wepangle), c_white, 1);
}
}
} else {
if (scrHMVariableExists(id, "gunsprite")) {
{
if ((gunangle < 180)) {
scrHMDrawSpriteExt(gunsprite, 0, (x + lengthdir_x((wkick * (- 1)), gunangle)), ((y + lengthdir_y((wkick * (- 1)), gunangle)) + 4), 1, right, gunangle, c_white, 1);
}
draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_get_width(sprite_index), (sprite_get_height(sprite_index) - (sprite_get_height(sprite_index) / 4)), (x - ((sprite_get_width(sprite_index) / 2) * right)), ((y - 4) - (sprite_get_height(sprite_index) / 4)), right, 1, image_blend, 1);
if ((gunangle >= 180)) {
scrHMDrawSpriteExt(gunsprite, 0, (x + lengthdir_x((wkick * (- 1)), gunangle)), ((y + lengthdir_y((wkick * (- 1)), gunangle)) + 4), 1, right, gunangle, c_white, 1);
}
}
} else {
{
draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_get_width(sprite_index), (sprite_get_height(sprite_index) - (sprite_get_height(sprite_index) / 4)), (x - ((sprite_get_width(sprite_index) / 2) * right)), ((y - 2) - (sprite_get_height(sprite_index) / 4)), right, 1, image_blend, 1);
}
}
}
}
}
if(__hm_break3) break;
}}
scrHMMenuDrawComplete();
}

// Source maincode.mod.gml:2803; draw_pause
function hm_maincode_mod_gml_draw_pause() {
draw_set_color(c_white);
draw_set_alpha(1);
;
draw_set_font(fntSmall);
scrHMDrawTextTransformed(((view_xview + (view_width / 2)) - 128), ((view_yview + (view_height / 2)) + 114), global.hm_module_vars[$ "mod:maincode"].versionnumber, 1, 1, 0);
;
draw_set_halign(2);
scrHMDrawTextTransformed(((view_xview + (view_width / 2)) + 160), ((view_yview + (view_height / 2)) + 114), string(global.hm_module_vars[$ "mod:maincode"].runcount), 1, 1, 0);
;
if ((GameCont.area == scrHMAreaResolve("venuz"))) {
{
draw_set_font(fntConsole);
draw_set_halign(1);
scrHMDrawTextTransformed((view_xview + (view_width / 2)), ((view_yview + (view_height / 2)) - 30), "hold B and press ENTER to restart level", 1, 1, 0);
;
}
}
draw_set_halign(0);
}

// Source maincode.mod.gml:2818; shilling
function hm_maincode_mod_gml_shilling() {
draw_set_color(c_white);
draw_set_alpha(0.2);
;
draw_set_font(fntM1);
scrHMDrawTextPlain(((view_xview + (view_width / 2)) - 72), ((view_yview + (view_height / 2)) - 82), "HARD MODE by BLAAC");
;
draw_set_alpha(1);
;
draw_set_font(fntSmall);
draw_set_alpha(1);
;
scrHMMenuDrawComplete();
}

// Source maincode.mod.gml:2827; versionnumber
function hm_maincode_mod_gml_versionnumber() {scrHMMenuDrawComplete();}

// Source maincode.mod.gml:2836; resourceful
function hm_maincode_mod_gml_resourceful() {
if (((! instance_exists(argument0)) && (random(argument3) < 1))) {
{
{ var __hm_with1 = scrHMInstances(instance_create(argument1, argument2, RogueAmmo)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
scrHMMotionAdd(random(360), 2);
}
}
if(__hm_break3) break;
}}
}
}
instance_destroy();
}

// Source maincode.mod.gml:2843; chat_command
function hm_maincode_mod_gml_chat_command() {
if ((argument0 == "venuz")) {
{
global.hm_module_vars[$ "mod:maincode"].venuz = 1;
scrHMTrace("going to space");
}
}
}
