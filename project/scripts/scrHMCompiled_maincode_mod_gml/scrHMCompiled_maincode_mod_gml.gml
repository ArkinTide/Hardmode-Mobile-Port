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

// Source maincode.mod.gml:0; game_start (native content 1.1.0)
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
GameCont.hm_crown_return = 0;
;
GameCont.hm_crown_vault_seen = 0;
;
GameCont.hm_crown_exit_ready = 0;
;
GameCont.hm_palace_crown_floor = noone;
;
GameCont.hm_transition_idpd = 0;
;
GameCont.hm_debug_pending = 0;
;
hm_arkintide_mod_gml_hm_progression_start();
;
{ var __hm_with1 = scrHMInstances(Player), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
hm_arkintide_mod_gml_hm_health_bonus();
}
if(__hm_break3) break;
}}
;
GameCont.hm_yv_seen = 0;
;
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

// Source maincode.mod.gml:0; step (native content 1.1.0)
function hm_maincode_mod_gml_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_maincode_mod_gml_step_resume, id, scrHMOther(other), _args, 361, []);
}
function hm_maincode_mod_gml_step_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_maincode_mod_gml_step");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // maincode.mod.gml:2339
{
hm_arkintide_mod_gml_hm_portal_style_tick();
;
hm_arkintide_mod_gml_hm_infantry_capture();
;
}
_hm.pc=0;
break;
case 2: // maincode.mod.gml:2335
{
;
}
_hm.pc=1;
break;
case 3: // maincode.mod.gml:2335
_hm.pc=1;
break;
case 4: // maincode.mod.gml:2318
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
_hm.pc=3;
break;
case 5: // maincode.mod.gml:2316
{
;
}
_hm.pc=4;
break;
case 6: // maincode.mod.gml:2316
_hm.pc=1;
break;
case 7: // maincode.mod.gml:2150
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
scrHMContentChange1100(Bubble, 1);
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
_hm.pc=6;
break;
case 8: // maincode.mod.gml:2148
{
;
}
_hm.pc=7;
break;
case 9: // maincode.mod.gml:2148
_hm.pc=1;
break;
case 10: // maincode.mod.gml:2126
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
_hm.pc=9;
break;
case 11: // maincode.mod.gml:2037
{
global.hm_module_vars[$ "mod:maincode"].gce = 1;
;
global.hm_module_vars[$ "mod:maincode"].door = noone;
;
}
_hm.pc=10;
break;
case 12: // maincode.mod.gml:2044
scrHMTaskWithNext(_hm);
break;
case 13: // maincode.mod.gml:2044
scrHMTaskWithAbort(_hm);
break;
case 14: // maincode.mod.gml:2119
{
;
}
_hm.pc=12;
break;
case 15: // maincode.mod.gml:2119
_hm.result=undefined; _hm.done=true; return;
break;
case 17: // maincode.mod.gml:2117
{
;
}
_hm.pc=16;
break;
case 18: // maincode.mod.gml:2117
_hm.wait_ticks=max(0,1); _hm.pc=17; return;
break;
case 19: // maincode.mod.gml:2090
scrHMTaskWithNext(_hm);
break;
case 20: // maincode.mod.gml:2090
scrHMTaskWithAbort(_hm);
break;
case 21: // maincode.mod.gml:2113
{
;
}
_hm.pc=19;
break;
case 22: // maincode.mod.gml:2113
_hm.result=undefined; _hm.done=true; return;
break;
case 24: // maincode.mod.gml:2111
{
;
}
_hm.pc=23;
break;
case 25: // maincode.mod.gml:2111
_hm.wait_ticks=max(0,1); _hm.pc=24; return;
break;
case 26: // maincode.mod.gml:2108
{
;
}
_hm.pc=25;
break;
case 27: // maincode.mod.gml:2108
_hm.pc=22;
break;
case 28: // maincode.mod.gml:2099
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
_hm.pc=27;
break;
case 29: // maincode.mod.gml:2098
_hm.pc = (_hm.vars._allTogetherNow) ? 28 : 25;
break;
case 30: // maincode.mod.gml:2095
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
_hm.pc=29;
break;
case 31: // maincode.mod.gml:2094
_hm.pc = ((_hm.other_scope.open == 2)) ? 30 : 25;
break;
case 23: // maincode.mod.gml:2093
_hm.pc=(instance_exists(_hm.scope))?31:22;
break;
case 32: // maincode.mod.gml:2092
_hm.pc = (scrHMTaskFork(_hm, 23)) ? 23 : 19;
break;
case 33: // maincode.mod.gml:2091
{
noregen = 1;
}
_hm.pc=32;
break;
case 34: // maincode.mod.gml:2090
scrHMTaskWithEnter(_hm,scrHMInstances(instance_create(x, y, FloorExplo)),33,18);
break;
case 35: // maincode.mod.gml:2087
{
;
}
_hm.pc=34;
break;
case 36: // maincode.mod.gml:2087
_hm.result=undefined; _hm.done=true; return;
break;
case 37: // maincode.mod.gml:2084
{
open = 2;
;
mask_index = mskWall;
;
}
_hm.pc=36;
break;
case 39: // maincode.mod.gml:2074
_hm.vars.__hm_repeat185--; _hm.pc=38;
break;
case 40: // maincode.mod.gml:2082
{
;
}
_hm.pc=39;
break;
case 41: // maincode.mod.gml:2082
_hm.wait_ticks=max(0,1); _hm.pc=40; return;
break;
case 42: // maincode.mod.gml:2075
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
_hm.pc=41;
break;
case 38: // maincode.mod.gml:2074
_hm.pc=(_hm.vars.__hm_repeat185>0)?42:37;
break;
case 43: // maincode.mod.gml:2074
_hm.vars.__hm_repeat185=round(16); _hm.pc=38;
break;
case 44: // maincode.mod.gml:2073
_hm.pc = (scrHMTaskFork(_hm, 43)) ? 43 : 34;
break;
case 45: // maincode.mod.gml:2067
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
_hm.pc=44;
break;
case 46: // maincode.mod.gml:2064
_hm.pc = ((((! open) && instance_exists(Player)) && (distance_to_object(Player) <= 1))) ? 45 : 18;
break;
case 16: // maincode.mod.gml:2063
_hm.pc=(instance_exists(_hm.scope))?46:15;
break;
case 47: // maincode.mod.gml:2062
_hm.pc = (scrHMTaskFork(_hm, 16)) ? 16 : 12;
break;
case 48: // maincode.mod.gml:2053
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
_hm.pc=47;
break;
case 49: // maincode.mod.gml:2045
_hm.pc = (((((((((global.hm_module_vars[$ "mod:maincode"].door == noone) && (distance_to_object(Player) >= 64)) && (! place_free((x - 16), y))) && (! place_free((x + 16), y))) && (! place_free(x, (y - 16)))) && (! place_free((x - 16), (y - 16)))) && (! place_free((x + 16), (y - 16)))) && place_free(x, (y + 16)))) ? 48 : 12;
break;
case 50: // maincode.mod.gml:2044
scrHMTaskWithEnter(_hm,scrHMInstances(Wall),49,10);
break;
case 51: // maincode.mod.gml:2043
{
global.hm_module_vars[$ "mod:maincode"].gce = 0;
;
}
_hm.pc=50;
break;
case 52: // maincode.mod.gml:2042
_hm.pc = (global.hm_module_vars[$ "mod:maincode"].gce) ? 51 : 10;
break;
case 53: // maincode.mod.gml:2037
_hm.pc = (instance_exists(GenCont)) ? 11 : 52;
break;
case 54: // maincode.mod.gml:2021
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
type = 3;
}
if(__hm_break200) break;
}}
;
{ var __hm_with201 = scrHMInstances(Spiral), __hm_break203=false;
for (var __hm_index202=0; __hm_index202<array_length(__hm_with201); ++__hm_index202) {
if(instance_exists(__hm_with201[__hm_index202])) with (__hm_with201[__hm_index202]) {
{
type = 3;
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
_hm.pc=53;
break;
case 55: // maincode.mod.gml:2019
{
;
}
_hm.pc=54;
break;
case 56: // maincode.mod.gml:2019
_hm.pc=1;
break;
case 57: // maincode.mod.gml:1879
{
{ var __hm_with210 = scrHMMatching(scrHMAuthoredWalls105(), "thing", undefined), __hm_break212=false;
for (var __hm_index211=0; __hm_index211<array_length(__hm_with210); ++__hm_index211) {
if(instance_exists(__hm_with210[__hm_index211])) with (__hm_with210[__hm_index211]) {
{
thing = 1;
instance_create(x, y, InvisiWall);
}
}
if(__hm_break212) break;
}}
{ var __hm_with213 = scrHMMatching(FloorExplo, "thing", undefined), __hm_break215=false;
for (var __hm_index214=0; __hm_index214<array_length(__hm_with213); ++__hm_index214) {
if(instance_exists(__hm_with213[__hm_index214])) with (__hm_with213[__hm_index214]) {
{
thing = 1;
thing2 = 3;
}
}
if(__hm_break215) break;
}}
{ var __hm_with216 = scrHMMatchingGT(FloorExplo, "thing2", 0), __hm_break218=false;
for (var __hm_index217=0; __hm_index217<array_length(__hm_with216); ++__hm_index217) {
if(instance_exists(__hm_with216[__hm_index217])) with (__hm_with216[__hm_index217]) {
{
thing2 -= choose(0, 0, 1);
}
}
if(__hm_break218) break;
}}
{ var __hm_with219 = scrHMMatching(FloorExplo, "thing2", 0), __hm_break221=false;
for (var __hm_index220=0; __hm_index220<array_length(__hm_with219); ++__hm_index220) {
if(instance_exists(__hm_with219[__hm_index220])) with (__hm_with219[__hm_index220]) {
if ((! instance_exists(Portal))) {
{
instance_create(x, y, Wall);
instance_destroy();
}
}
}
if(__hm_break221) break;
}}
{ var __hm_with222 = scrHMMatchingNE(hitme, "object_index", Player), __hm_break224=false;
for (var __hm_index223=0; __hm_index223<array_length(__hm_with222); ++__hm_index223) {
if(instance_exists(__hm_with222[__hm_index223])) with (__hm_with222[__hm_index223]) {
if (place_meeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), InvisiWall)) {
move_bounce_solid(false);
}
}
if(__hm_break224) break;
}}
{ var __hm_with225 = scrHMMatching(CustomObject, "name", "VenuzElevator"), __hm_break227=false;
for (var __hm_index226=0; __hm_index226<array_length(__hm_with225); ++__hm_index226) {
if(instance_exists(__hm_with225[__hm_index226])) with (__hm_with225[__hm_index226]) {
{
if (place_meeting(x, y, Floor)) {
activated = 1;
}
if ((activated == 1)) {
{
{ var __hm_with228 = scrHMInstances(Wall), __hm_break230=false;
for (var __hm_index229=0; __hm_index229<array_length(__hm_with228); ++__hm_index229) {
if(instance_exists(__hm_with228[__hm_index229])) with (__hm_with228[__hm_index229]) {
if ((distance_to_object((scrHMOther(other))) < 16)) {
{
sprite_index = sprWall103Bot;
topspr = sprWall103Top;
outindex = 0;
outspr = sprWall103Out;
}
}
}
if(__hm_break230) break;
}}
{ var __hm_with231 = scrHMInstances(FloorExplo), __hm_break233=false;
for (var __hm_index232=0; __hm_index232<array_length(__hm_with231); ++__hm_index232) {
if(instance_exists(__hm_with231[__hm_index232])) with (__hm_with231[__hm_index232]) {
if ((distance_to_object((scrHMOther(other))) < 16)) {
sprite_index = sprFloor103Explo;
}
}
if(__hm_break233) break;
}}
}
}
}
}
if(__hm_break227) break;
}}
if ((((GameCont.subarea <= 6) and (GameCont.subarea > 3)) || (GameCont.subarea == 200))) {
{
{ var __hm_with234 = scrHMMatchingNE(hitme, "object_index", FireBaller, SuperFireBaller), __hm_break236=false;
for (var __hm_index235=0; __hm_index235<array_length(__hm_with234); ++__hm_index235) {
if(instance_exists(__hm_with234[__hm_index235])) with (__hm_with234[__hm_index235]) {
if (((scrHMVariableExists(id, "right") and ((object_index == Player) || (distance_to_object(Player) < (view_width * 2)))) and (!scrHMVariableExists(id, "boss")))) {
{
image_alpha = 0;
{ var __hm_with237 = scrHMInstances(scrHMBindDraw(hm_maincode_mod_gml_spacesewerboi, depth)), __hm_break239=false;
for (var __hm_index238=0; __hm_index238<array_length(__hm_with237); ++__hm_index238) {
if(instance_exists(__hm_with237[__hm_index238])) with (__hm_with237[__hm_index238]) {
var __hm_other240=scrHMOther(other);
creator = __hm_other240;
}
if(__hm_break239) break;
}}
}
}
}
if(__hm_break236) break;
}}
}
}
if ((GameCont.subarea == 7)) {
{ var __hm_with241 = scrHMMatching(Player, "image_alpha", 0), __hm_break243=false;
for (var __hm_index242=0; __hm_index242<array_length(__hm_with241); ++__hm_index242) {
if(instance_exists(__hm_with241[__hm_index242])) with (__hm_with241[__hm_index242]) {
image_alpha = 1;
}
if(__hm_break243) break;
}}
}
{ var __hm_with244 = scrHMMatching(CustomObject, "name", "window"), __hm_break246=false;
for (var __hm_index245=0; __hm_index245<array_length(__hm_with244); ++__hm_index245) {
if(instance_exists(__hm_with244[__hm_index245])) with (__hm_with244[__hm_index245]) {
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
if(__hm_break246) break;
}}
{ var __hm_with247 = scrHMMatching(DustOLD, "imasecret", 1), __hm_break249=false;
for (var __hm_index248=0; __hm_index248<array_length(__hm_with247); ++__hm_index248) {
if(instance_exists(__hm_with247[__hm_index248])) with (__hm_with247[__hm_index248]) {
if (instance_exists(Wall)) {
{
{ var __hm_with250 = scrHMInstances(instance_create(x, y, Effect)), __hm_break252=false;
for (var __hm_index251=0; __hm_index251<array_length(__hm_with250); ++__hm_index251) {
if(instance_exists(__hm_with250[__hm_index251])) with (__hm_with250[__hm_index251]) {
{
sprite_index = (instance_nearest(x, y, Wall)).sprite_index;
image_speed = (0) * timescale;
secret = 1;
}
}
if(__hm_break252) break;
}}
{ var __hm_with253 = scrHMInstances(instance_create(x, (y + 16), Effect)), __hm_break255=false;
for (var __hm_index254=0; __hm_index254<array_length(__hm_with253); ++__hm_index254) {
if(instance_exists(__hm_with253[__hm_index254])) with (__hm_with253[__hm_index254]) {
{
sprite_index = (instance_nearest(x, (y + 16), Wall)).sprite_index;
image_speed = (0) * timescale;
secret = 1;
}
}
if(__hm_break255) break;
}}
{ var __hm_with256 = scrHMInstances(instance_create((x + 16), (y + 16), Effect)), __hm_break258=false;
for (var __hm_index257=0; __hm_index257<array_length(__hm_with256); ++__hm_index257) {
if(instance_exists(__hm_with256[__hm_index257])) with (__hm_with256[__hm_index257]) {
{
sprite_index = (instance_nearest((x + 16), y, Wall)).sprite_index;
image_speed = (0) * timescale;
secret = 1;
}
}
if(__hm_break258) break;
}}
{ var __hm_with259 = scrHMInstances(instance_create((x + 16), y, Effect)), __hm_break261=false;
for (var __hm_index260=0; __hm_index260<array_length(__hm_with259); ++__hm_index260) {
if(instance_exists(__hm_with259[__hm_index260])) with (__hm_with259[__hm_index260]) {
{
sprite_index = (instance_nearest((x + 16), (y + 16), Wall)).sprite_index;
image_speed = (0) * timescale;
secret = 1;
}
}
if(__hm_break261) break;
}}
{ var __hm_with262 = scrHMInstances(instance_create(x, (y - 8), Effect)), __hm_break264=false;
for (var __hm_index263=0; __hm_index263<array_length(__hm_with262); ++__hm_index263) {
if(instance_exists(__hm_with262[__hm_index263])) with (__hm_with262[__hm_index263]) {
{
sprite_index = (instance_nearest((x + 16), ((y + 16) + 16), TopSmall)).sprite_index;
image_speed = (0) * timescale;
depth = (- 10);
secret = 1;
}
}
if(__hm_break264) break;
}}
{ var __hm_with265 = scrHMInstances(instance_create(x, ((y + 16) - 8), Effect)), __hm_break267=false;
for (var __hm_index266=0; __hm_index266<array_length(__hm_with265); ++__hm_index266) {
if(instance_exists(__hm_with265[__hm_index266])) with (__hm_with265[__hm_index266]) {
{
sprite_index = (instance_nearest((x + 16), ((y + 16) + 16), TopSmall)).sprite_index;
image_speed = (0) * timescale;
depth = (- 10);
secret = 1;
}
}
if(__hm_break267) break;
}}
{ var __hm_with268 = scrHMInstances(instance_create((x + 16), ((y + 16) - 8), Effect)), __hm_break270=false;
for (var __hm_index269=0; __hm_index269<array_length(__hm_with268); ++__hm_index269) {
if(instance_exists(__hm_with268[__hm_index269])) with (__hm_with268[__hm_index269]) {
{
sprite_index = (instance_nearest((x + 16), ((y + 16) + 16), TopSmall)).sprite_index;
image_speed = (0) * timescale;
depth = (- 10);
secret = 1;
}
}
if(__hm_break270) break;
}}
{ var __hm_with271 = scrHMInstances(instance_create((x + 16), (y - 8), Effect)), __hm_break273=false;
for (var __hm_index272=0; __hm_index272<array_length(__hm_with271); ++__hm_index272) {
if(instance_exists(__hm_with271[__hm_index272])) with (__hm_with271[__hm_index272]) {
{
sprite_index = (instance_nearest((x + 16), (y + 16), TopSmall)).sprite_index;
image_speed = (0) * timescale;
depth = (- 10);
secret = 1;
}
}
if(__hm_break273) break;
}}
name = "imadoor";
}
}
}
if(__hm_break249) break;
}}
hm_maincode_mod_gml_venus_place_players();
;
if ((GameCont.subarea == 12)) {
{
{ var __hm_with274 = scrHMInstances(InvisiWall), __hm_break276=false;
for (var __hm_index275=0; __hm_index275<array_length(__hm_with274); ++__hm_index275) {
if(instance_exists(__hm_with274[__hm_index275])) with (__hm_with274[__hm_index275]) {
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
if(__hm_break276) break;
}}
{ var __hm_with277 = scrHMInstances(Explosion), __hm_break279=false;
for (var __hm_index278=0; __hm_index278<array_length(__hm_with277); ++__hm_index278) {
if(instance_exists(__hm_with277[__hm_index278])) with (__hm_with277[__hm_index278]) {
if (place_meeting(x, y, Floor)) {
if ((random(100) < 1)) {
instance_create(x, y, AmmoPickup);
}
}
}
if(__hm_break279) break;
}}
}
}
if ((((GameCont.subarea > 9) and (GameCont.subarea < 99)) || (GameCont.subarea == 200))) {
{
{ var __hm_with280 = scrHMInstances(instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), CaveSparkle)), __hm_break282=false;
for (var __hm_index281=0; __hm_index281<array_length(__hm_with280); ++__hm_index281) {
if(instance_exists(__hm_with280[__hm_index281])) with (__hm_with280[__hm_index281]) {
{
depth = 21;
image_angle = random(360);
if (((x < 10176) and (x > 9856))) {
image_alpha = 0;
}
}
}
if(__hm_break282) break;
}}
{ var __hm_with283 = scrHMInstances(Debris), __hm_break285=false;
for (var __hm_index284=0; __hm_index284<array_length(__hm_with283); ++__hm_index284) {
if(instance_exists(__hm_with283[__hm_index284])) with (__hm_with283[__hm_index284]) {
if ((! place_meeting(x, y, Floor))) {
vspeed = (2) * timescale;
}
}
if(__hm_break285) break;
}}
}
}
{ var __hm_with286 = scrHMInstances(Feather), __hm_break288=false;
for (var __hm_index287=0; __hm_index287<array_length(__hm_with286); ++__hm_index287) {
if(instance_exists(__hm_with286[__hm_index287])) with (__hm_with286[__hm_index287]) {
{
if ((! place_meeting(x, y, Floor))) {
{
vspeed += (1) * timescale;
fall += 1;
}
}
if (((distance_to_object(Dust) < 8) and (Dust.sprite_index == sprGroundFlame))) {
{
{ var __hm_with289 = scrHMInstances(instance_create(x, y, Flame)), __hm_break291=false;
for (var __hm_index290=0; __hm_index290<array_length(__hm_with289); ++__hm_index290) {
if(instance_exists(__hm_with289[__hm_index290])) with (__hm_with289[__hm_index290]) {
team = 2;
}
if(__hm_break291) break;
}}
instance_destroy();
}
}
}
}
if(__hm_break288) break;
}}
{ var __hm_with292 = scrHMMatching(Corpse, "sprite_index", sprMoneyPileDead), __hm_break294=false;
for (var __hm_index293=0; __hm_index293<array_length(__hm_with292); ++__hm_index293) {
if(instance_exists(__hm_with292[__hm_index293])) with (__hm_with292[__hm_index293]) {
if (((distance_to_object(Dust) < 8) and (Dust.sprite_index == sprGroundFlame))) {
{
{ var __hm_with295 = scrHMInstances(instance_create(x, y, Flame)), __hm_break297=false;
for (var __hm_index296=0; __hm_index296<array_length(__hm_with295); ++__hm_index296) {
if(instance_exists(__hm_with295[__hm_index296])) with (__hm_with295[__hm_index296]) {
team = 2;
}
if(__hm_break297) break;
}}
instance_destroy();
}
}
}
if(__hm_break294) break;
}}
}
_hm.pc=56;
break;
case 58: // maincode.mod.gml:1814
scrHMTaskWithNext(_hm);
break;
case 59: // maincode.mod.gml:1814
scrHMTaskWithAbort(_hm);
break;
case 60: // maincode.mod.gml:1872
{
;
}
_hm.pc=58;
break;
case 61: // maincode.mod.gml:1872
_hm.result=undefined; _hm.done=true; return;
break;
case 63: // maincode.mod.gml:1855
_hm.vars.__hm_repeat298--; _hm.pc=62;
break;
case 64: // maincode.mod.gml:1870
_hm.wait_ticks=max(0,1); _hm.pc=63; return;
break;
case 65: // maincode.mod.gml:1856
{
{ var __hm_with299 = scrHMInstances(Player), __hm_break301=false;
for (var __hm_index300=0; __hm_index300<array_length(__hm_with299); ++__hm_index300) {
if(instance_exists(__hm_with299[__hm_index300])) with (__hm_with299[__hm_index300]) {
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
}
}
if(__hm_break301) break;
}}
}
_hm.pc=64;
break;
case 62: // maincode.mod.gml:1855
_hm.pc=(_hm.vars.__hm_repeat298>0)?65:61;
break;
case 66: // maincode.mod.gml:1855
_hm.vars.__hm_repeat298=round(10); _hm.pc=62;
break;
case 67: // maincode.mod.gml:1854
_hm.pc = (scrHMTaskFork(_hm, 66)) ? 66 : 58;
break;
case 68: // maincode.mod.gml:1830
{
hm_maincode_mod_gml_venus_request_retry();
;
hp = max_hp;
speed = (0) * timescale;
;
hspeed = (0) * timescale;
;
vspeed = (0) * timescale;
;
switchwep = 0;
;
bswitchwep = 0;
;
reload = 0;
;
breload = 0;
;
can_die = 1;
_hm.vars.w1 = "secretweapong1";
;
_hm.vars.w2 = 0;
if ((GameCont.subarea == 12)) {
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
{ var __hm_with302 = scrHMInstances(Revive), __hm_break304=false;
for (var __hm_index303=0; __hm_index303<array_length(__hm_with302); ++__hm_index303) {
if(instance_exists(__hm_with302[__hm_index303])) with (__hm_with302[__hm_index303]) {
{
x = (instance_nearest(x, y, Player)).x;
y = (instance_nearest(x, y, Player)).y;
}
}
if(__hm_break304) break;
}}
}
_hm.pc=67;
break;
case 69: // maincode.mod.gml:1829
_hm.pc = (((can_die == 0) and (hp <= 0))) ? 68 : 58;
break;
case 70: // maincode.mod.gml:1815
{
hm_maincode_mod_gml_venus_retry_input();
;
if ((((GameCont.subarea == 300) and (instance_number(enemy) <= 1)) && hm_arkintide_mod_gml_hm_venus_auto_exit())) {
{ var __hm_with305 = scrHMInstances(instance_create((x - 8), (y - 8), CustomObject)), __hm_break307=false;
for (var __hm_index306=0; __hm_index306<array_length(__hm_with305); ++__hm_index306) {
if(instance_exists(__hm_with305[__hm_index306])) with (__hm_with305[__hm_index306]) {
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
if(__hm_break307) break;
}}
}
if ((instance_number(Player) <= 1)) {
can_die = 0;
}
}
_hm.pc=69;
break;
case 71: // maincode.mod.gml:1814
scrHMTaskWithEnter(_hm,scrHMInstances(Player),70,57);
break;
case 72: // maincode.mod.gml:1807
{
scrHMSoundStop(mus1);
;
scrHMSoundStop(mus1b);
;
scrHMSoundStop(mus3);
;
scrHMSoundStop(mus3b);
;
{ var __hm_with308 = scrHMInstances(SpiralCont), __hm_break310=false;
for (var __hm_index309=0; __hm_index309<array_length(__hm_with308); ++__hm_index309) {
if(instance_exists(__hm_with308[__hm_index309])) with (__hm_with308[__hm_index309]) {
type = 3;
}
if(__hm_break310) break;
}}
;
{ var __hm_with311 = scrHMInstances(Spiral), __hm_break313=false;
for (var __hm_index312=0; __hm_index312<array_length(__hm_with311); ++__hm_index312) {
if(instance_exists(__hm_with311[__hm_index312])) with (__hm_with311[__hm_index312]) {
{
type = 3;
;
sprite_index = mskNone;
}
}
if(__hm_break313) break;
}}
}
_hm.pc=71;
break;
case 73: // maincode.mod.gml:1804
{
;
}
_hm.pc=72;
break;
case 74: // maincode.mod.gml:1804
_hm.pc=1;
break;
case 75: // maincode.mod.gml:1799
{
{ var __hm_with314 = scrHMInstances(WantPopo), __hm_break316=false;
for (var __hm_index315=0; __hm_index315<array_length(__hm_with314); ++__hm_index315) {
if(instance_exists(__hm_with314[__hm_index315])) with (__hm_with314[__hm_index315]) {
instance_destroy();
}
if(__hm_break316) break;
}}
{ var __hm_with317 = scrHMInstances(IDPDSpawn), __hm_break319=false;
for (var __hm_index318=0; __hm_index318<array_length(__hm_with317); ++__hm_index318) {
if(instance_exists(__hm_with317[__hm_index318])) with (__hm_with317[__hm_index318]) {
instance_destroy();
}
if(__hm_break319) break;
}}
scrHMSoundStop(sndIDPDPortalSpawn);
;
scrHMSoundStop(sndEliteIDPDPortalSpawn);
;
}
_hm.pc=74;
break;
case 76: // maincode.mod.gml:1797
{
;
}
_hm.pc=75;
break;
case 77: // maincode.mod.gml:1797
_hm.pc=1;
break;
case 78: // maincode.mod.gml:1777
{
{ var __hm_with320 = scrHMMatching(Nothing2, "mask_index", mskNone), __hm_break322=false;
for (var __hm_index321=0; __hm_index321<array_length(__hm_with320); ++__hm_index321) {
if(instance_exists(__hm_with320[__hm_index321])) with (__hm_with320[__hm_index321]) {
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
if(__hm_break322) break;
}}
{ var __hm_with323 = scrHMInstances(Portal), __hm_break325=false;
for (var __hm_index324=0; __hm_index324<array_length(__hm_with323); ++__hm_index324) {
if(instance_exists(__hm_with323[__hm_index324])) with (__hm_with323[__hm_index324]) {
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
if(__hm_break325) break;
}}
{ var __hm_with326 = scrHMMatchingNE(Portal, "nokill", 1), __hm_break328=false;
for (var __hm_index327=0; __hm_index327<array_length(__hm_with326); ++__hm_index327) {
if(instance_exists(__hm_with326[__hm_index327])) with (__hm_with326[__hm_index327]) {
instance_destroy();
}
if(__hm_break328) break;
}}
}
_hm.pc=77;
break;
case 79: // maincode.mod.gml:1683
scrHMTaskWithNext(_hm);
break;
case 80: // maincode.mod.gml:1683
scrHMTaskWithAbort(_hm);
break;
case 81: // maincode.mod.gml:1762
{
if ((y > (portalfall + 4000))) {
{
{ var __hm_with329 = scrHMInstances(instance_create(x, y, Portal)), __hm_break331=false;
for (var __hm_index330=0; __hm_index330<array_length(__hm_with329); ++__hm_index330) {
if(instance_exists(__hm_with329[__hm_index330])) with (__hm_with329[__hm_index330]) {
{
nokill = 1;
nompportal = 1;
endgame = 0;
scrHMSoundStopAll();
}
}
if(__hm_break331) break;
}}
spr_shadow_y = 0;
fallenable = (- 1);
hm_arkintide_mod_gml_hm_throne_fall(false);
;
sprite_angle = 0;
scrHMSoundMusic(musCredits);
}
}
}
_hm.pc=79;
break;
case 82: // maincode.mod.gml:1753
{
if (instance_exists(id)) {
{ var __hm_with332 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break334=false;
for (var __hm_index333=0; __hm_index333<array_length(__hm_with332); ++__hm_index333) {
if(instance_exists(__hm_with332[__hm_index333])) with (__hm_with332[__hm_index333]) {
{
name = "credits";
sprite_index = global.hm_module_vars[$ "mod:maincode"].YALCredits;
image_speed = (0) * timescale;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break334) break;
}}
}
}
_hm.pc=81;
break;
case 83: // maincode.mod.gml:1752
_hm.wait_ticks=max(0,50); _hm.pc=82; return;
break;
case 84: // maincode.mod.gml:1744
{
if (instance_exists(id)) {
{ var __hm_with335 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break337=false;
for (var __hm_index336=0; __hm_index336<array_length(__hm_with335); ++__hm_index336) {
if(instance_exists(__hm_with335[__hm_index336])) with (__hm_with335[__hm_index336]) {
{
name = "credits";
sprite_index = sprCreditsTeam;
image_speed = (0) * timescale;
image_index = 5;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break337) break;
}}
}
}
_hm.pc=83;
break;
case 85: // maincode.mod.gml:1743
_hm.wait_ticks=max(0,15); _hm.pc=84; return;
break;
case 86: // maincode.mod.gml:1735
{
if (instance_exists(id)) {
{ var __hm_with338 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break340=false;
for (var __hm_index339=0; __hm_index339<array_length(__hm_with338); ++__hm_index339) {
if(instance_exists(__hm_with338[__hm_index339])) with (__hm_with338[__hm_index339]) {
{
name = "credits";
sprite_index = sprCreditsTeam;
image_speed = (0) * timescale;
image_index = 4;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break340) break;
}}
}
}
_hm.pc=85;
break;
case 87: // maincode.mod.gml:1734
_hm.wait_ticks=max(0,15); _hm.pc=86; return;
break;
case 88: // maincode.mod.gml:1726
{
if (instance_exists(id)) {
{ var __hm_with341 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break343=false;
for (var __hm_index342=0; __hm_index342<array_length(__hm_with341); ++__hm_index342) {
if(instance_exists(__hm_with341[__hm_index342])) with (__hm_with341[__hm_index342]) {
{
name = "credits";
sprite_index = sprCreditsTeam;
image_speed = (0) * timescale;
image_index = 3;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break343) break;
}}
}
}
_hm.pc=87;
break;
case 89: // maincode.mod.gml:1725
_hm.wait_ticks=max(0,15); _hm.pc=88; return;
break;
case 90: // maincode.mod.gml:1717
{
if (instance_exists(id)) {
{ var __hm_with344 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break346=false;
for (var __hm_index345=0; __hm_index345<array_length(__hm_with344); ++__hm_index345) {
if(instance_exists(__hm_with344[__hm_index345])) with (__hm_with344[__hm_index345]) {
{
name = "credits";
sprite_index = sprCreditsTeam;
image_speed = (0) * timescale;
image_index = 2;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break346) break;
}}
}
}
_hm.pc=89;
break;
case 91: // maincode.mod.gml:1716
_hm.wait_ticks=max(0,50); _hm.pc=90; return;
break;
case 92: // maincode.mod.gml:1708
{
if (instance_exists(id)) {
{ var __hm_with347 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break349=false;
for (var __hm_index348=0; __hm_index348<array_length(__hm_with347); ++__hm_index348) {
if(instance_exists(__hm_with347[__hm_index348])) with (__hm_with347[__hm_index348]) {
{
name = "credits";
sprite_index = sprCreditsTeam;
image_speed = (0) * timescale;
image_index = 1;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break349) break;
}}
}
}
_hm.pc=91;
break;
case 93: // maincode.mod.gml:1707
_hm.wait_ticks=max(0,10); _hm.pc=92; return;
break;
case 94: // maincode.mod.gml:1699
{
if (instance_exists(id)) {
{ var __hm_with350 = scrHMInstances(instance_create((x + random_range((- 100), 100)), (y + 200), Effect)), __hm_break352=false;
for (var __hm_index351=0; __hm_index351<array_length(__hm_with350); ++__hm_index351) {
if(instance_exists(__hm_with350[__hm_index351])) with (__hm_with350[__hm_index351]) {
{
name = "credits";
sprite_index = sprCreditsTeam;
image_speed = (0) * timescale;
image_index = 0;
scrHMMotionAdd(random(360), random(2));
}
}
if(__hm_break352) break;
}}
}
}
_hm.pc=93;
break;
case 95: // maincode.mod.gml:1698
_hm.pc = (scrHMTaskFork(_hm, 94)) ? 94 : 81;
break;
case 96: // maincode.mod.gml:1697
{
credits = instance_create(0, 0, CustomObject);
}
_hm.pc=95;
break;
case 97: // maincode.mod.gml:1696
_hm.pc = (((y > (portalfall + 2000)) and ((!scrHMVariableExists(_hm.scope, "credits")) || (! instance_exists(credits))))) ? 96 : 81;
break;
case 98: // maincode.mod.gml:1684
{
if (((! place_meeting(x, y, Floor)) and (distance_to_object(Portal) > 32))) {
{
hm_arkintide_mod_gml_hm_throne_fall(true);
;
sprite_angle += 15;
gunangle += 15;
y += 8;
spr_shadow_y = 10000;
}
} else {
{
hm_arkintide_mod_gml_hm_throne_fall(false);
;
sprite_angle = 0;
spr_shadow_y = 0;
}
}
}
_hm.pc=97;
break;
case 99: // maincode.mod.gml:1683
scrHMTaskWithEnter(_hm,scrHMMatching(Player, "fallenable", 1),98,78);
break;
case 100: // maincode.mod.gml:1659
{
if ((instance_number(SpiralCont) > 1)) {
{ var __hm_with353 = scrHMInstances(instance_nearest(0, 0, SpiralCont)), __hm_break355=false;
for (var __hm_index354=0; __hm_index354<array_length(__hm_with353); ++__hm_index354) {
if(instance_exists(__hm_with353[__hm_index354])) with (__hm_with353[__hm_index354]) {
scrHMDelete(id);
}
if(__hm_break355) break;
}}
}
{ var __hm_with356 = scrHMInstances(Nothing2Death), __hm_break358=false;
for (var __hm_index357=0; __hm_index357<array_length(__hm_with356); ++__hm_index357) {
if(instance_exists(__hm_with356[__hm_index357])) with (__hm_with356[__hm_index357]) {
{
scrHMSoundStop(musBoss4A);
;
scrHMSoundStop(musBoss4B);
;
{ var __hm_with359 = scrHMInstances(SpiralCont), __hm_break361=false;
for (var __hm_index360=0; __hm_index360<array_length(__hm_with359); ++__hm_index360) {
if(instance_exists(__hm_with359[__hm_index360])) with (__hm_with359[__hm_index360]) {
noreloadplease = 1;
}
if(__hm_break361) break;
}}
{ var __hm_with362 = scrHMInstances(InvisiWall), __hm_break364=false;
for (var __hm_index363=0; __hm_index363<array_length(__hm_with362); ++__hm_index363) {
if(instance_exists(__hm_with362[__hm_index363])) with (__hm_with362[__hm_index363]) {
instance_destroy();
}
if(__hm_break364) break;
}}
if ((instance_number(CustomEnemy) < 2)) {
{ var __hm_with365 = scrHMInstances(instance_create(0, 0, CustomEnemy)), __hm_break367=false;
for (var __hm_index366=0; __hm_index366<array_length(__hm_with365); ++__hm_index366) {
if(instance_exists(__hm_with365[__hm_index366])) with (__hm_with365[__hm_index366]) {
{
name = "portalblocker";
canfly = 1;
}
}
if(__hm_break367) break;
}}
}
{ var __hm_with368 = scrHMInstances(Portal), __hm_break370=false;
for (var __hm_index369=0; __hm_index369<array_length(__hm_with368); ++__hm_index369) {
if(instance_exists(__hm_with368[__hm_index369])) with (__hm_with368[__hm_index369]) {
instance_destroy();
}
if(__hm_break370) break;
}}
{ var __hm_with371 = scrHMInstances(Player), __hm_break373=false;
for (var __hm_index372=0; __hm_index372<array_length(__hm_with371); ++__hm_index372) {
if(instance_exists(__hm_with371[__hm_index372])) with (__hm_with371[__hm_index372]) {
if (((!scrHMVariableExists(id, "fallenable")) || (fallenable == (- 1)))) {
{
fallenable = 1;
portalfall = y;
}
}
}
if(__hm_break373) break;
}}
}
}
if(__hm_break358) break;
}}
{ var __hm_with374 = scrHMMatching(Effect, "name", "credits"), __hm_break376=false;
for (var __hm_index375=0; __hm_index375<array_length(__hm_with374); ++__hm_index375) {
if(instance_exists(__hm_with374[__hm_index375])) with (__hm_with374[__hm_index375]) {
{
image_angle += 14;
}
}
if(__hm_break376) break;
}}
}
_hm.pc=99;
break;
case 101: // maincode.mod.gml:1623
scrHMTaskWithNext(_hm);
break;
case 102: // maincode.mod.gml:1623
scrHMTaskWithAbort(_hm);
break;
case 103: // maincode.mod.gml:1628
{
;
{ var __hm_with377 = scrHMInstances(Floor), __hm_break379=false;
for (var __hm_index378=0; __hm_index378<array_length(__hm_with377); ++__hm_index378) {
if(instance_exists(__hm_with377[__hm_index378])) with (__hm_with377[__hm_index378]) {
if ((distance_to_object(Player) > 300)) {
instance_destroy();
}
}
if(__hm_break379) break;
}}
{ var __hm_with380 = scrHMInstances(Wall), __hm_break382=false;
for (var __hm_index381=0; __hm_index381<array_length(__hm_with380); ++__hm_index381) {
if(instance_exists(__hm_with380[__hm_index381])) with (__hm_with380[__hm_index381]) {
{
instance_create(x, y, InvisiWall);
instance_destroy();
}
}
if(__hm_break382) break;
}}
{ var __hm_with383 = scrHMInstances(Carpet), __hm_break385=false;
for (var __hm_index384=0; __hm_index384<array_length(__hm_with383); ++__hm_index384) {
if(instance_exists(__hm_with383[__hm_index384])) with (__hm_with383[__hm_index384]) {
instance_destroy();
}
if(__hm_break385) break;
}}
if (instance_exists(id)) {
{
scrHMContentChange1100(Wind,false);
{ var __hm_with386 = scrHMInstances(Portal), __hm_break388=false;
for (var __hm_index387=0; __hm_index387<array_length(__hm_with386); ++__hm_index387) {
if(instance_exists(__hm_with386[__hm_index387])) with (__hm_with386[__hm_index387]) {
instance_destroy();
}
if(__hm_break388) break;
}}
{ var __hm_with389 = scrHMInstances(instance_create(x, y, SpiralCont)), __hm_break391=false;
for (var __hm_index390=0; __hm_index390<array_length(__hm_with389); ++__hm_index390) {
if(instance_exists(__hm_with389[__hm_index390])) with (__hm_with389[__hm_index390]) {
{
noreloadplease = 1;
depth = 10;
}
}
if(__hm_break391) break;
}}
scrHMModCall("mod", "throne", "throne_create", x, y);
{ var __hm_with392 = scrHMInstances(instance_create(0, 0, Nothing2)), __hm_break394=false;
for (var __hm_index393=0; __hm_index393<array_length(__hm_with392); ++__hm_index393) {
if(instance_exists(__hm_with392[__hm_index393])) with (__hm_with392[__hm_index393]) {
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
if(__hm_break394) break;
}}
instance_destroy();
}
}
}
_hm.pc=101;
break;
case 104: // maincode.mod.gml:1628
_hm.wait_ticks=max(0,100); _hm.pc=103; return;
break;
case 105: // maincode.mod.gml:1624
{
_hm.vars._x = x;
;
_hm.vars._y = y;
;
{ var __hm_with395 = scrHMInstances(SpiralCont), __hm_break397=false;
for (var __hm_index396=0; __hm_index396<array_length(__hm_with395); ++__hm_index396) {
if(instance_exists(__hm_with395[__hm_index396])) with (__hm_with395[__hm_index396]) {
noreloadplease = 1;
}
if(__hm_break397) break;
}}
}
_hm.pc=104;
break;
case 106: // maincode.mod.gml:1623
scrHMTaskWithEnter(_hm,scrHMInstances(NothingDeath),105,100);
break;
case 107: // maincode.mod.gml:1602
{
{ var __hm_with398 = scrHMInstances(NothingInactive), __hm_break400=false;
for (var __hm_index399=0; __hm_index399<array_length(__hm_with398); ++__hm_index399) {
if(instance_exists(__hm_with398[__hm_index399])) with (__hm_with398[__hm_index399]) {
{
{ var __hm_with401 = scrHMInstances(BigGenerator), __hm_break403=false;
for (var __hm_index402=0; __hm_index402<array_length(__hm_with401); ++__hm_index402) {
if(instance_exists(__hm_with401[__hm_index402])) with (__hm_with401[__hm_index402]) {
{
hp = 90;
sprite_index = sprBigGeneratorInactive;
}
}
if(__hm_break403) break;
}}
}
}
if(__hm_break400) break;
}}
{ var __hm_with404 = scrHMInstances(Nothing), __hm_break406=false;
for (var __hm_index405=0; __hm_index405<array_length(__hm_with404); ++__hm_index405) {
if(instance_exists(__hm_with404[__hm_index405])) with (__hm_with404[__hm_index405]) {
{
if (((hp < (max_hp - instance_number(BigGenerator))) and instance_exists(BigGenerator))) {
hp += instance_number(BigGenerator);
}
if ((!scrHMVariableExists(id, "morehp"))) {
{
scrHMMaxHealthWrite(id, 0.8, "*=");
hp *= 0.8;
morehp = 1;
}
}
if (((! instance_exists(BigGenerator)) and (!scrHMVariableExists(id, "mohp")))) {
{
hp += 200;
mohp = 1;
}
}
}
}
if(__hm_break406) break;
}}
{ var __hm_with407 = scrHMMatching(enemy, "canfly", 0), __hm_break409=false;
for (var __hm_index408=0; __hm_index408<array_length(__hm_with407); ++__hm_index408) {
if(instance_exists(__hm_with407[__hm_index408])) with (__hm_with407[__hm_index408]) {
canfly = 1;
}
if(__hm_break409) break;
}}
}
_hm.pc=106;
break;
case 108: // maincode.mod.gml:1600
{
;
}
_hm.pc=107;
break;
case 109: // maincode.mod.gml:1600
_hm.pc=1;
break;
case 110: // maincode.mod.gml:1583
{
{ var __hm_with410 = scrHMInstances(Portal), __hm_break412=false;
for (var __hm_index411=0; __hm_index411<array_length(__hm_with410); ++__hm_index411) {
if(instance_exists(__hm_with410[__hm_index411])) with (__hm_with410[__hm_index411]) {
{
type = 2;
}
}
if(__hm_break412) break;
}}
{ var __hm_with413 = scrHMInstances(TopPot), __hm_break415=false;
for (var __hm_index414=0; __hm_index414<array_length(__hm_with413); ++__hm_index414) {
if(instance_exists(__hm_with413[__hm_index414])) with (__hm_with413[__hm_index414]) {
if (((place_meeting(x, ((y - 16) - 13), Wall) and (! place_meeting(x, ((y - 32) - 13), Wall))) and place_meeting(x, ((y - 32) - 13), Floor))) {
y -= 16;
}
}
if(__hm_break415) break;
}}
{ var __hm_with416 = scrHMInstances(LastIntro), __hm_break418=false;
for (var __hm_index417=0; __hm_index417<array_length(__hm_with416); ++__hm_index417) {
if(instance_exists(__hm_with416[__hm_index417])) with (__hm_with416[__hm_index417]) {
{
{ var __hm_with419 = scrHMInstances(IDPDSpawn), __hm_break421=false;
for (var __hm_index420=0; __hm_index420<array_length(__hm_with419); ++__hm_index420) {
if(instance_exists(__hm_with419[__hm_index420])) with (__hm_with419[__hm_index420]) {
scrHMDelete(id);
}
if(__hm_break421) break;
}}
{ var __hm_with422 = scrHMMatching(enemy, "team", 3), __hm_break424=false;
for (var __hm_index423=0; __hm_index423<array_length(__hm_with422); ++__hm_index423) {
if(instance_exists(__hm_with422[__hm_index423])) with (__hm_with422[__hm_index423]) {
scrHMDelete(id);
}
if(__hm_break424) break;
}}
scrHMSoundStop(sndIDPDPortalSpawn);
}
}
if(__hm_break418) break;
}}
{ var __hm_with425 = scrHMInstances(BigTV), __hm_break427=false;
for (var __hm_index426=0; __hm_index426<array_length(__hm_with425); ++__hm_index426) {
if(instance_exists(__hm_with425[__hm_index426])) with (__hm_with425[__hm_index426]) {
if (scrHMModExists("area", "elevator", "tv1")) {
spr_idle = scrHMModGet("area", "elevator", "tv1");
}
}
if(__hm_break427) break;
}}
}
_hm.pc=109;
break;
case 112: // maincode.mod.gml:1576
_hm.vars.__hm_repeat428--; _hm.pc=111;
break;
case 113: // maincode.mod.gml:1579
_hm.wait_ticks=max(0,choose(0, 0, 1, 1, 2, 2, 3)); _hm.pc=112; return;
break;
case 114: // maincode.mod.gml:1577
{
_hm.vars.here = instance_nearest((Player.x + random_range((- 120), 120)), (Player.y + random_range((- 120), 120)), Floor);
instance_create((_hm.vars.here.x + 16), (_hm.vars.here.y + 16), IDPDSpawn);
}
_hm.pc=113;
break;
case 111: // maincode.mod.gml:1576
_hm.pc=(_hm.vars.__hm_repeat428>0)?114:110;
break;
case 115: // maincode.mod.gml:1576
_hm.vars.__hm_repeat428=round(choose(1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 4)); _hm.pc=111;
break;
case 116: // maincode.mod.gml:1575
_hm.pc = (scrHMTaskFork(_hm, 115)) ? 115 : 110;
break;
case 117: // maincode.mod.gml:1574
_hm.pc = (instance_exists(Player)) ? 116 : 110;
break;
case 118: // maincode.mod.gml:1573
_hm.pc = ((random((250 + (instance_number(Corpse) * 5))) < 1)) ? 117 : 110;
break;
case 119: // maincode.mod.gml:1572
_hm.pc = ((! instance_exists(SpiralCont))) ? 118 : 110;
break;
case 120: // maincode.mod.gml:1570
{
TopCont.darkness = (GameCont.loops >= 3);
;
GameCont.subarea = 5;
}
_hm.pc=119;
break;
case 121: // maincode.mod.gml:1568
{
;
}
_hm.pc=120;
break;
case 122: // maincode.mod.gml:1568
_hm.pc=1;
break;
case 123: // maincode.mod.gml:1554
{
{ var __hm_with429 = scrHMInstances(Portal), __hm_break431=false;
for (var __hm_index430=0; __hm_index430<array_length(__hm_with429); ++__hm_index430) {
if(instance_exists(__hm_with429[__hm_index430])) with (__hm_with429[__hm_index430]) {
{
type = 2;
}
}
if(__hm_break431) break;
}}
{ var __hm_with432 = scrHMInstances(TopPot), __hm_break434=false;
for (var __hm_index433=0; __hm_index433<array_length(__hm_with432); ++__hm_index433) {
if(instance_exists(__hm_with432[__hm_index433])) with (__hm_with432[__hm_index433]) {
if (((place_meeting(x, ((y - 16) - 13), Wall) and (! place_meeting(x, ((y - 32) - 13), Wall))) and place_meeting(x, ((y - 32) - 13), Floor))) {
y -= 16;
}
}
if(__hm_break434) break;
}}
{ var __hm_with435 = scrHMMatchingGT(WepPickup, "ammo", 0), __hm_break437=false;
for (var __hm_index436=0; __hm_index436<array_length(__hm_with435); ++__hm_index436) {
if(instance_exists(__hm_with435[__hm_index436])) with (__hm_with435[__hm_index436]) {
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
if(__hm_break437) break;
}}
}
_hm.pc=122;
break;
case 125: // maincode.mod.gml:1547
_hm.vars.__hm_repeat438--; _hm.pc=124;
break;
case 126: // maincode.mod.gml:1550
_hm.wait_ticks=max(0,choose(0, 0, 1, 1, 2, 2, 3)); _hm.pc=125; return;
break;
case 127: // maincode.mod.gml:1548
{
_hm.vars.here = instance_nearest((Player.x + random_range((- 120), 120)), (Player.y + random_range((- 120), 120)), Floor);
instance_create((_hm.vars.here.x + 16), (_hm.vars.here.y + 16), IDPDSpawn);
}
_hm.pc=126;
break;
case 124: // maincode.mod.gml:1547
_hm.pc=(_hm.vars.__hm_repeat438>0)?127:123;
break;
case 128: // maincode.mod.gml:1547
_hm.vars.__hm_repeat438=round(choose(1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 4)); _hm.pc=124;
break;
case 129: // maincode.mod.gml:1546
_hm.pc = (scrHMTaskFork(_hm, 128)) ? 128 : 123;
break;
case 130: // maincode.mod.gml:1545
_hm.pc = (instance_exists(Player)) ? 129 : 123;
break;
case 131: // maincode.mod.gml:1544
_hm.pc = ((random(((1000 / (GameCont.subarea + 3)) + (instance_number(Corpse) * 5))) < 1)) ? 130 : 123;
break;
case 132: // maincode.mod.gml:1543
_hm.pc = ((! instance_exists(SpiralCont))) ? 131 : 123;
break;
case 133: // maincode.mod.gml:1540
{
TopCont.darkness = (GameCont.loops >= 3);
;
{ var __hm_with439 = scrHMInstances(SpiralCont), __hm_break441=false;
for (var __hm_index440=0; __hm_index440<array_length(__hm_with439); ++__hm_index440) {
if(instance_exists(__hm_with439[__hm_index440])) with (__hm_with439[__hm_index440]) {
type = 2;
}
if(__hm_break441) break;
}}
;
{ var __hm_with442 = scrHMInstances(Spiral), __hm_break444=false;
for (var __hm_index443=0; __hm_index443<array_length(__hm_with442); ++__hm_index443) {
if(instance_exists(__hm_with442[__hm_index443])) with (__hm_with442[__hm_index443]) {
type = 2;
}
if(__hm_break444) break;
}}
;
}
_hm.pc=132;
break;
case 134: // maincode.mod.gml:1538
{
;
}
_hm.pc=133;
break;
case 135: // maincode.mod.gml:1538
_hm.pc=1;
break;
case 136: // maincode.mod.gml:1516
{
{ var __hm_with445 = scrHMInstances(Wall), __hm_break447=false;
for (var __hm_index446=0; __hm_index446<array_length(__hm_with445); ++__hm_index446) {
if(instance_exists(__hm_with445[__hm_index446])) with (__hm_with445[__hm_index446]) {
depth = (0 - (y / 10016));
}
if(__hm_break447) break;
}}
{ var __hm_with448 = scrHMMatching(CustomHitme, "name", "bigtube1", "bigtube2"), __hm_break450=false;
for (var __hm_index449=0; __hm_index449<array_length(__hm_with448); ++__hm_index449) {
if(instance_exists(__hm_with448[__hm_index449])) with (__hm_with448[__hm_index449]) {
depth = (0 - (y / 10016));
}
if(__hm_break450) break;
}}
{ var __hm_with451 = scrHMInstances(prop), __hm_break453=false;
for (var __hm_index452=0; __hm_index452<array_length(__hm_with451); ++__hm_index452) {
if(instance_exists(__hm_with451[__hm_index452])) with (__hm_with451[__hm_index452]) {
depth = (0 - (y / 10016));
}
if(__hm_break453) break;
}}
{ var __hm_with454 = scrHMMatchingNE(Inspector, "transform", 1), __hm_break456=false;
for (var __hm_index455=0; __hm_index455<array_length(__hm_with454); ++__hm_index455) {
if(instance_exists(__hm_with454[__hm_index455])) with (__hm_with454[__hm_index455]) {
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
if(__hm_break456) break;
}}
{ var __hm_with457 = scrHMMatchingNE(Shielder, "transform", 1), __hm_break459=false;
for (var __hm_index458=0; __hm_index458<array_length(__hm_with457); ++__hm_index458) {
if(instance_exists(__hm_with457[__hm_index458])) with (__hm_with457[__hm_index458]) {
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
if(__hm_break459) break;
}}
if ((GameCont.loops < 3)) {
{ var __hm_with460 = scrHMInstances(RevivePopoFreak), __hm_break462=false;
for (var __hm_index461=0; __hm_index461<array_length(__hm_with460); ++__hm_index461) {
if(instance_exists(__hm_with460[__hm_index461])) with (__hm_with460[__hm_index461]) {
instance_destroy();
}
if(__hm_break462) break;
}}
}
if ((GameCont.loops < 3)) {
{ var __hm_with463 = scrHMInstances(WantRevivePopoFreak), __hm_break465=false;
for (var __hm_index464=0; __hm_index464<array_length(__hm_with463); ++__hm_index464) {
if(instance_exists(__hm_with463[__hm_index464])) with (__hm_with463[__hm_index464]) {
instance_destroy();
}
if(__hm_break465) break;
}}
}
}
_hm.pc=135;
break;
case 137: // maincode.mod.gml:1514
{
;
}
_hm.pc=136;
break;
case 138: // maincode.mod.gml:1514
_hm.pc=1;
break;
case 139: // maincode.mod.gml:1501
scrHMTaskWithNext(_hm);
break;
case 140: // maincode.mod.gml:1501
scrHMTaskWithAbort(_hm);
break;
case 141: // maincode.mod.gml:1503
scrHMTaskWithNext(_hm);
break;
case 142: // maincode.mod.gml:1503
scrHMTaskWithAbort(_hm);
break;
case 144: // maincode.mod.gml:1505
_hm.vars.__hm_repeat466--; _hm.pc=143;
break;
case 145: // maincode.mod.gml:1509
_hm.wait_ticks=max(0,choose(0, 0, 1, 1, 2, 2, 3)); _hm.pc=144; return;
break;
case 146: // maincode.mod.gml:1506
{
_hm.vars.here = instance_nearest((x + random_range((- 120), 120)), (y + random_range((- 120), 120)), Floor);
{ var __hm_with467 = scrHMInstances(instance_create((_hm.vars.here.x + 16), (_hm.vars.here.y + 16), Turret)), __hm_break469=false;
for (var __hm_index468=0; __hm_index468<array_length(__hm_with467); ++__hm_index468) {
if(instance_exists(__hm_with467[__hm_index468])) with (__hm_with467[__hm_index468]) {
timeout = random_range(100, 300);
}
if(__hm_break469) break;
}}
}
_hm.pc=145;
break;
case 147: // maincode.mod.gml:1505
_hm.pc = (instance_exists(_hm.scope)) ? 146 : 144;
break;
case 143: // maincode.mod.gml:1505
_hm.pc=(_hm.vars.__hm_repeat466>0)?147:141;
break;
case 148: // maincode.mod.gml:1505
_hm.vars.__hm_repeat466=round(choose(1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 4, 12)); _hm.pc=143;
break;
case 149: // maincode.mod.gml:1504
_hm.pc = (scrHMTaskFork(_hm, 148)) ? 148 : 141;
break;
case 150: // maincode.mod.gml:1503
scrHMTaskWithEnter(_hm,scrHMInstances(Player),149,139);
break;
case 151: // maincode.mod.gml:1502
_hm.pc = ((random(400) < 1)) ? 150 : 139;
break;
case 152: // maincode.mod.gml:1501
scrHMTaskWithEnter(_hm,scrHMInstances(TechnoMancer),151,138);
break;
case 153: // maincode.mod.gml:1501
_hm.pc = ((! instance_exists(Spiral))) ? 152 : 138;
break;
case 154: // maincode.mod.gml:1464
{
{ var __hm_with470 = scrHMInstances(Wall), __hm_break472=false;
for (var __hm_index471=0; __hm_index471<array_length(__hm_with470); ++__hm_index471) {
if(instance_exists(__hm_with470[__hm_index471])) with (__hm_with470[__hm_index471]) {
depth = (0 - (y / 10016));
}
if(__hm_break472) break;
}}
{ var __hm_with473 = scrHMMatching(CustomHitme, "name", "bigtube1", "bigtube2"), __hm_break475=false;
for (var __hm_index474=0; __hm_index474<array_length(__hm_with473); ++__hm_index474) {
if(instance_exists(__hm_with473[__hm_index474])) with (__hm_with473[__hm_index474]) {
depth = (0 - (y / 10016));
}
if(__hm_break475) break;
}}
{ var __hm_with476 = scrHMInstances(prop), __hm_break478=false;
for (var __hm_index477=0; __hm_index477<array_length(__hm_with476); ++__hm_index477) {
if(instance_exists(__hm_with476[__hm_index477])) with (__hm_with476[__hm_index477]) {
depth = (0 - (y / 10016));
}
if(__hm_break478) break;
}}
{ var __hm_with479 = scrHMInstances(Cactus), __hm_break481=false;
for (var __hm_index480=0; __hm_index480<array_length(__hm_with479); ++__hm_index480) {
if(instance_exists(__hm_with479[__hm_index480])) with (__hm_with479[__hm_index480]) {
if ((! instance_exists(SpiralCont))) {
{
instance_create(x, y, IDPDChest);
scrHMContentChange1100(Wind, 0);
instance_destroy();
}
}
}
if(__hm_break481) break;
}}
{ var __hm_with482 = scrHMMatchingGT(Turret, "timeout", 0), __hm_break484=false;
for (var __hm_index483=0; __hm_index483<array_length(__hm_with482); ++__hm_index483) {
if(instance_exists(__hm_with482[__hm_index483])) with (__hm_with482[__hm_index483]) {
timeout -= 1;
}
if(__hm_break484) break;
}}
{ var __hm_with485 = scrHMMatchingLE(Turret, "timeout", 0), __hm_break487=false;
for (var __hm_index486=0; __hm_index486<array_length(__hm_with485); ++__hm_index486) {
if(instance_exists(__hm_with485[__hm_index486])) with (__hm_with485[__hm_index486]) {
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
if(__hm_break487) break;
}}
{ var __hm_with488 = scrHMMatching(Turret, "spr_idle", global.hm_module_vars[$ "mod:maincode"].turretdeactivate), __hm_break490=false;
for (var __hm_index489=0; __hm_index489<array_length(__hm_with488); ++__hm_index489) {
if(instance_exists(__hm_with488[__hm_index489])) with (__hm_with488[__hm_index489]) {
if ((image_index >= 10)) {
scrHMDelete(id);
}
}
if(__hm_break490) break;
}}
if ((GameCont.loops < 3)) {
{ var __hm_with491 = scrHMInstances(RevivePopoFreak), __hm_break493=false;
for (var __hm_index492=0; __hm_index492<array_length(__hm_with491); ++__hm_index492) {
if(instance_exists(__hm_with491[__hm_index492])) with (__hm_with491[__hm_index492]) {
instance_destroy();
}
if(__hm_break493) break;
}}
}
if ((GameCont.loops < 3)) {
{ var __hm_with494 = scrHMInstances(WantRevivePopoFreak), __hm_break496=false;
for (var __hm_index495=0; __hm_index495<array_length(__hm_with494); ++__hm_index495) {
if(instance_exists(__hm_with494[__hm_index495])) with (__hm_with494[__hm_index495]) {
instance_destroy();
}
if(__hm_break496) break;
}}
}
{ var __hm_with497 = scrHMInstances(Inspector), __hm_break499=false;
for (var __hm_index498=0; __hm_index498<array_length(__hm_with497); ++__hm_index498) {
if(instance_exists(__hm_with497[__hm_index498])) with (__hm_with497[__hm_index498]) {
{
instance_create(x, y, Necromancer);
instance_destroy();
}
}
if(__hm_break499) break;
}}
{ var __hm_with500 = scrHMInstances(Shielder), __hm_break502=false;
for (var __hm_index501=0; __hm_index501<array_length(__hm_with500); ++__hm_index501) {
if(instance_exists(__hm_with500[__hm_index501])) with (__hm_with500[__hm_index501]) {
{
instance_create(x, y, Necromancer);
instance_destroy();
}
}
if(__hm_break502) break;
}}
{ var __hm_with503 = scrHMInstances(TechnoMancer), __hm_break505=false;
for (var __hm_index504=0; __hm_index504<array_length(__hm_with503); ++__hm_index504) {
if(instance_exists(__hm_with503[__hm_index504])) with (__hm_with503[__hm_index504]) {
depth = (0 - (y / 10016));
}
if(__hm_break505) break;
}}
}
_hm.pc=153;
break;
case 155: // maincode.mod.gml:1462
{
;
}
_hm.pc=154;
break;
case 156: // maincode.mod.gml:1462
_hm.pc=1;
break;
case 157: // maincode.mod.gml:1366
{
{ var __hm_with506 = scrHMInstances(LilHunterDie), __hm_break508=false;
for (var __hm_index507=0; __hm_index507<array_length(__hm_with506); ++__hm_index507) {
if(instance_exists(__hm_with506[__hm_index507])) with (__hm_with506[__hm_index507]) {
if ((!scrHMVariableExists(id, "lastwish"))) {
{
{ var __hm_with509 = scrHMInstances(instance_create(x, y, EliteGrunt)), __hm_break511=false;
for (var __hm_index510=0; __hm_index510<array_length(__hm_with509); ++__hm_index510) {
if(instance_exists(__hm_with509[__hm_index510])) with (__hm_with509[__hm_index510]) {
{
spr_idle = sprLilHunterLift;
spr_hurt = sprLilHunterHurt;
spr_walk = sprLilHunterLift;
spr_dead = sprLilHunterDead;
hitid = [sprLilHunter, "lil hunter"];
scrHMMaxHealthWrite(id, 100, "=");
hp = 100;
var __hm_other512=scrHMOther(other);
direction = __hm_other512.direction;
fuel = 800;
grenades = 0;
roll = 20;
}
}
if(__hm_break511) break;
}}
scrHMDelete(id);
}
}
}
if(__hm_break508) break;
}}
{ var __hm_with513 = scrHMMatching(EliteGrunt, "spr_idle", sprLilHunterLift), __hm_break515=false;
for (var __hm_index514=0; __hm_index514<array_length(__hm_with513); ++__hm_index514) {
if(instance_exists(__hm_with513[__hm_index514])) with (__hm_with513[__hm_index514]) {
{
grenades = 0;
{ var __hm_with516 = scrHMInstances(instance_create(x, y, AcidStreak)), __hm_break518=false;
for (var __hm_index517=0; __hm_index517<array_length(__hm_with516); ++__hm_index517) {
if(instance_exists(__hm_with516[__hm_index517])) with (__hm_with516[__hm_index517]) {
{
var __hm_other519=scrHMOther(other);
image_angle = (__hm_other519.direction + 180);
var __hm_other520=scrHMOther(other);
depth = (__hm_other520.depth + .1);
}
}
if(__hm_break518) break;
}}
{ var __hm_with521 = scrHMMatching(EnemyBullet1, "creator", id), __hm_break523=false;
for (var __hm_index522=0; __hm_index522<array_length(__hm_with521); ++__hm_index522) {
if(instance_exists(__hm_with521[__hm_index522])) with (__hm_with521[__hm_index522]) {
{
hitid = [sprLilHunter, "lil hunter"];
}
}
if(__hm_break523) break;
}}
roll -= 1;
if ((roll == 15)) {
{
gunangle = (direction + random_range((- 30), 30));
ammo = 6;
alarm[2] = 6;
}
}
{ var __hm_with524 = scrHMInstances(instance_create(x, y, Smoke)), __hm_break526=false;
for (var __hm_index525=0; __hm_index525<array_length(__hm_with524); ++__hm_index525) {
if(instance_exists(__hm_with524[__hm_index525])) with (__hm_with524[__hm_index525]) {
{
var __hm_other527=scrHMOther(other);
depth = (__hm_other527.depth + .2);
}
}
if(__hm_break526) break;
}}
if ((roll <= 0)) {
{
{ var __hm_with528 = scrHMInstances(instance_create(x, y, LilHunterDie)), __hm_break530=false;
for (var __hm_index529=0; __hm_index529<array_length(__hm_with528); ++__hm_index529) {
if(instance_exists(__hm_with528[__hm_index529])) with (__hm_with528[__hm_index529]) {
lastwish = 1;
}
if(__hm_break530) break;
}}
scrHMDelete(id);
}
}
}
}
if(__hm_break515) break;
}}
{ var __hm_with531 = scrHMInstances(LilHunter), __hm_break533=false;
for (var __hm_index532=0; __hm_index532<array_length(__hm_with531); ++__hm_index532) {
if(instance_exists(__hm_with531[__hm_index532])) with (__hm_with531[__hm_index532]) {
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
{ var __hm_with534 = scrHMInstances(projectile), __hm_break536=false;
for (var __hm_index535=0; __hm_index535<array_length(__hm_with534); ++__hm_index535) {
if(instance_exists(__hm_with534[__hm_index535])) with (__hm_with534[__hm_index535]) {
if (((team != (scrHMOther(other)).team) && place_meeting(((x + (hspeed / timescale)) + lengthdir_x((speed / timescale), direction)), ((y + (vspeed / timescale)) + lengthdir_y((speed / timescale), direction)), (scrHMOther(other))))) {
{
var __hm_other537=scrHMOther(other);
__hm_other537.dodge = 3;
var __hm_other538=scrHMOther(other);
__hm_other538.direction = (direction + (90 * __hm_other538.right));
}
}
}
if(__hm_break536) break;
}}
if (((alarm[1] > 1) and ((floor(current_frame) mod 12) == 1))) {
alarm[1] -= 1;
}
{ var __hm_with539 = scrHMMatching(EnemyBullet1, "creator", id), __hm_break541=false;
for (var __hm_index540=0; __hm_index540<array_length(__hm_with539); ++__hm_index540) {
if(instance_exists(__hm_with539[__hm_index540])) with (__hm_with539[__hm_index540]) {
{
{ var __hm_with542 = scrHMInstances(instance_create(x, y, IDPDBullet)), __hm_break544=false;
for (var __hm_index543=0; __hm_index543<array_length(__hm_with542); ++__hm_index543) {
if(instance_exists(__hm_with542[__hm_index543])) with (__hm_with542[__hm_index543]) {
{
team = 3;
var __hm_other545=scrHMOther(other);
speed = ((__hm_other545.speed / timescale)) * timescale;
var __hm_other546=scrHMOther(other);
direction = __hm_other546.direction;
image_angle = direction;
var __hm_other547=scrHMOther(other);
hitid = __hm_other547.hitid;
}
}
if(__hm_break544) break;
}}
scrHMDelete(id);
}
}
if(__hm_break541) break;
}}
{ var __hm_with548 = scrHMMatching(LHBouncer, "creator", id), __hm_break550=false;
for (var __hm_index549=0; __hm_index549<array_length(__hm_with548); ++__hm_index549) {
if(instance_exists(__hm_with548[__hm_index549])) with (__hm_with548[__hm_index549]) {
{
{ var __hm_with551 = scrHMInstances(instance_create(x, y, TrapFire)), __hm_break553=false;
for (var __hm_index552=0; __hm_index552<array_length(__hm_with551); ++__hm_index552) {
if(instance_exists(__hm_with551[__hm_index552])) with (__hm_with551[__hm_index552]) {
{
team = 3;
friction += (choose(0.1, 0, 0, (- 0.1))) * (timescale * timescale);
sprite_index = sprFireLilHunter;
var __hm_other554=scrHMOther(other);
speed = ((__hm_other554.speed / timescale)) * timescale;
var __hm_other555=scrHMOther(other);
direction = __hm_other555.direction;
image_angle = direction;
var __hm_other556=scrHMOther(other);
hitid = __hm_other556.hitid;
}
}
if(__hm_break553) break;
}}
scrHMDelete(id);
}
}
if(__hm_break550) break;
}}
}
}
if(__hm_break533) break;
}}
if (instance_exists(Player)) {
{ var __hm_with557 = scrHMInstances(Explosion), __hm_break559=false;
for (var __hm_index558=0; __hm_index558<array_length(__hm_with557); ++__hm_index558) {
if(instance_exists(__hm_with557[__hm_index558])) with (__hm_with557[__hm_index558]) {
if ((!scrHMVariableExists(id, "yeti"))) {
{
if ((random(600) < 1)) {
{ var __hm_with560 = scrHMInstances(instance_nearest((Player.x + random_range((view_width * (- 1)), view_width)), (Player.y + random_range((view_width * (- 1)), view_width)), Floor)), __hm_break562=false;
for (var __hm_index561=0; __hm_index561<array_length(__hm_with560); ++__hm_index561) {
if(instance_exists(__hm_with560[__hm_index561])) with (__hm_with560[__hm_index561]) {
{
scrHMModCall("mod", "props", "lookout_create", (x + 16), (y + 16));
;
}
}
if(__hm_break562) break;
}}
}
yeti = 1;
}
}
}
if(__hm_break559) break;
}}
}
}
_hm.pc=156;
break;
case 158: // maincode.mod.gml:1320
scrHMTaskWithNext(_hm);
break;
case 159: // maincode.mod.gml:1320
scrHMTaskWithAbort(_hm);
break;
case 160: // maincode.mod.gml:1363
{
;
}
_hm.pc=158;
break;
case 161: // maincode.mod.gml:1363
_hm.result=undefined; _hm.done=true; return;
break;
case 162: // maincode.mod.gml:1342
instance_create(0, 0, VanSpawn);
_hm.pc=161;
break;
case 163: // maincode.mod.gml:1360
{
;
}
_hm.pc=161;
break;
case 164: // maincode.mod.gml:1360
_hm.result=undefined; _hm.done=true; return;
break;
case 166: // maincode.mod.gml:1344
_hm.vars.__hm_repeat563--; _hm.pc=165;
break;
case 167: // maincode.mod.gml:1358
_hm.wait_ticks=max(0,1); _hm.pc=166; return;
break;
case 168: // maincode.mod.gml:1345
{
if (((random(3) < 1) and instance_exists(id))) {
{
walk = 0;
{ var __hm_with564 = scrHMInstances(instance_create(x, y, CaveSparkle)), __hm_break566=false;
for (var __hm_index565=0; __hm_index565<array_length(__hm_with564); ++__hm_index565) {
if(instance_exists(__hm_with564[__hm_index565])) with (__hm_with564[__hm_index565]) {
{
sprite_index = sprIDPDPortalCharge;
image_angle = random(360);
vspeed -= (random(12)) * timescale;
hspeed = (choose(random_range((- 1), 1), 0, 0)) * timescale;
depth = (- 10);
if (instance_exists(Player)) {
scrHMSoundPitchVolume(sndShotgunHitWall, 2, min(1, ((view_width / 4) / max(1, distance_to_object(Player)))));
}
}
}
if(__hm_break566) break;
}}
}
}
}
_hm.pc=167;
break;
case 165: // maincode.mod.gml:1344
_hm.pc=(_hm.vars.__hm_repeat563>0)?168:164;
break;
case 169: // maincode.mod.gml:1344
_hm.vars.__hm_repeat563=round(25); _hm.pc=165;
break;
case 170: // maincode.mod.gml:1343
_hm.pc = (scrHMTaskFork(_hm, 169)) ? 169 : 161;
break;
case 171: // maincode.mod.gml:1341
_hm.pc = ((! instance_exists(VanSpawn))) ? 162 : 170;
break;
case 172: // maincode.mod.gml:1340
_hm.pc = (instance_exists(_hm.scope)) ? 171 : 161;
break;
case 174: // maincode.mod.gml:1324
_hm.vars.__hm_repeat567--; _hm.pc=173;
break;
case 175: // maincode.mod.gml:1338
_hm.wait_ticks=max(0,1); _hm.pc=174; return;
break;
case 176: // maincode.mod.gml:1325
{
if (((random(3) < 1) and instance_exists(id))) {
{
walk = 0;
{ var __hm_with568 = scrHMInstances(instance_create(x, y, CaveSparkle)), __hm_break570=false;
for (var __hm_index569=0; __hm_index569<array_length(__hm_with568); ++__hm_index569) {
if(instance_exists(__hm_with568[__hm_index569])) with (__hm_with568[__hm_index569]) {
{
sprite_index = sprIDPDPortalCharge;
image_angle = random(360);
vspeed -= (random(12)) * timescale;
hspeed = (choose(random_range((- 1), 1), 0, 0)) * timescale;
depth = (- 10);
if (instance_exists(Player)) {
scrHMSoundPitchVolume(sndShotgunHitWall, 2, min(1, ((view_width / 4) / max(1, distance_to_object(Player)))));
}
}
}
if(__hm_break570) break;
}}
}
}
}
_hm.pc=175;
break;
case 173: // maincode.mod.gml:1324
_hm.pc=(_hm.vars.__hm_repeat567>0)?176:172;
break;
case 177: // maincode.mod.gml:1324
_hm.vars.__hm_repeat567=round(75); _hm.pc=173;
break;
case 178: // maincode.mod.gml:1323
_hm.pc = (scrHMTaskFork(_hm, 177)) ? 177 : 158;
break;
case 179: // maincode.mod.gml:1321
{
global.hm_module_vars[$ "mod:maincode"].vans -= 1;
van = 1;
}
_hm.pc=178;
break;
case 180: // maincode.mod.gml:1320
_hm.pc = ((((((!instance_is(id,Van) && !scrHMVariableExists(_hm.scope, "van")) and (distance_to_object(Corpse) < 64)) and (! instance_exists(VanSpawn))) and (! instance_exists(CaveSparkle))) and (global.hm_module_vars[$ "mod:maincode"].vans > 0))) ? 179 : 158;
break;
case 181: // maincode.mod.gml:1320
scrHMTaskWithEnter(_hm,scrHMMatching(enemy, "team", 3),180,157);
break;
case 182: // maincode.mod.gml:1252
{
{ var __hm_with571 = scrHMInstances(GenCont), __hm_break573=false;
for (var __hm_index572=0; __hm_index572<array_length(__hm_with571); ++__hm_index572) {
if(instance_exists(__hm_with571[__hm_index572])) with (__hm_with571[__hm_index572]) {
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
if(__hm_break573) break;
}}
{ var __hm_with574 = scrHMInstances(GenCont), __hm_break576=false;
for (var __hm_index575=0; __hm_index575<array_length(__hm_with574); ++__hm_index575) {
if(instance_exists(__hm_with574[__hm_index575])) with (__hm_with574[__hm_index575]) {
global.hm_module_vars[$ "mod:maincode"].vans = min(GameCont.subarea, 3);
}
if(__hm_break576) break;
}}
instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), SnowFlake);
if ((random(50) < 1)) {
{
{ var __hm_with577 = scrHMInstances(Player), __hm_break579=false;
for (var __hm_index578=0; __hm_index578<array_length(__hm_with577); ++__hm_index578) {
if(instance_exists(__hm_with577[__hm_index578])) with (__hm_with577[__hm_index578]) {
if (((race != scrHMRaceResolve(8)) and (race != scrHMRaceResolve(5)))) {
{
{ var __hm_with580 = scrHMInstances(instance_create(x, y, Breath)), __hm_break582=false;
for (var __hm_index581=0; __hm_index581<array_length(__hm_with580); ++__hm_index581) {
if(instance_exists(__hm_with580[__hm_index581])) with (__hm_with580[__hm_index581]) {
var __hm_other583=scrHMOther(other);
image_xscale = __hm_other583.right;
}
if(__hm_break582) break;
}}
}
}
}
if(__hm_break579) break;
}}
}
}
{ var __hm_with584 = scrHMInstances(Necromancer), __hm_break586=false;
for (var __hm_index585=0; __hm_index585<array_length(__hm_with584); ++__hm_index585) {
if(instance_exists(__hm_with584[__hm_index585])) with (__hm_with584[__hm_index585]) {
if ((!scrHMVariableExists(id, "hm_native_loop"))) {
{
instance_create(x, y, Sniper);
scrHMContentChange1100(Wind, 0);
instance_destroy();
}
}
}
if(__hm_break586) break;
}}
{ var __hm_with587 = scrHMInstances(ExploGuardian), __hm_break589=false;
for (var __hm_index588=0; __hm_index588<array_length(__hm_with587); ++__hm_index588) {
if(instance_exists(__hm_with587[__hm_index588])) with (__hm_with587[__hm_index588]) {
if ((!scrHMVariableExists(id, "hm_native_loop"))) {
{
instance_create(x, y, Inspector);
scrHMContentChange1100(Wind, 0);
instance_destroy();
}
}
}
if(__hm_break589) break;
}}
{ var __hm_with590 = scrHMInstances(DogGuardian), __hm_break592=false;
for (var __hm_index591=0; __hm_index591<array_length(__hm_with590); ++__hm_index591) {
if(instance_exists(__hm_with590[__hm_index591])) with (__hm_with590[__hm_index591]) {
if ((!scrHMVariableExists(id, "hm_native_loop"))) {
{
instance_create(x, y, SnowTank);
scrHMContentChange1100(Wind, 0);
instance_destroy();
}
}
}
if(__hm_break592) break;
}}
{ var __hm_with593 = scrHMMatching([EliteGrunt, EliteInspector, EliteShielder], "hmset", undefined), __hm_break595=false;
for (var __hm_index594=0; __hm_index594<array_length(__hm_with593); ++__hm_index594) {
if(instance_exists(__hm_with593[__hm_index594])) with (__hm_with593[__hm_index594]) {
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
if(__hm_break595) break;
}}
{ var __hm_with596 = scrHMInstances(VanSpawn), __hm_break598=false;
for (var __hm_index597=0; __hm_index597<array_length(__hm_with596); ++__hm_index597) {
if(instance_exists(__hm_with596[__hm_index597])) with (__hm_with596[__hm_index597]) {
if (((floor(current_frame) mod 3) == 1)) {
alarm[0]++;
}
}
if(__hm_break598) break;
}}
{ var __hm_with599 = scrHMInstances(Van), __hm_break601=false;
for (var __hm_index600=0; __hm_index600<array_length(__hm_with599); ++__hm_index600) {
if(instance_exists(__hm_with599[__hm_index600])) with (__hm_with599[__hm_index600]) {
freak = 0;
}
if(__hm_break601) break;
}}
{ var __hm_with602 = scrHMInstances(IDPDSpawn), __hm_break604=false;
for (var __hm_index603=0; __hm_index603<array_length(__hm_with602); ++__hm_index603) {
if(instance_exists(__hm_with602[__hm_index603])) with (__hm_with602[__hm_index603]) {
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
if(__hm_break604) break;
}}
{ var __hm_with605 = scrHMInstances(TopDecalCity), __hm_break607=false;
for (var __hm_index606=0; __hm_index606<array_length(__hm_with605); ++__hm_index606) {
if(instance_exists(__hm_with605[__hm_index606])) with (__hm_with605[__hm_index606]) {
if ((!scrHMVariableExists(id, "why_are_you_so_far_down"))) {
{
if ((place_meeting(x, (y - 16), Wall) and (image_index != 2))) {
y -= 7;
}
why_are_you_so_far_down = 1;
}
}
}
if(__hm_break607) break;
}}
hm_arkintide_mod_gml_hm_snowtank_bullets();
;
}
_hm.pc=181;
break;
case 183: // maincode.mod.gml:1250
{
;
}
_hm.pc=182;
break;
case 184: // maincode.mod.gml:1250
_hm.pc=1;
break;
case 185: // maincode.mod.gml:1183
{
{ var __hm_with608 = scrHMInstances(BigWeaponChest), __hm_break610=false;
for (var __hm_index609=0; __hm_index609<array_length(__hm_with608); ++__hm_index609) {
if(instance_exists(__hm_with608[__hm_index609])) with (__hm_with608[__hm_index609]) {
{
curse = 1;
scrHMContentChange1100(CursedBigChest, 1);
sprite_index = sprCursedChestBig;
}
}
if(__hm_break610) break;
}}
{ var __hm_with611 = scrHMInstances(HyperCrystal), __hm_break613=false;
for (var __hm_index612=0; __hm_index612<array_length(__hm_with611); ++__hm_index612) {
if(instance_exists(__hm_with611[__hm_index612])) with (__hm_with611[__hm_index612]) {
{
if ((!scrHMVariableExists(id, "hm_cursed_music"))) {
{
hm_cursed_music = 1;
;
scrHMSoundMusic(musBoss6B);
;
}
}
repeat (random(20)) { var __hm_with614 = scrHMInstances(instance_create((x + random_range((- 32), 32)), (y + random_range((- 32), 32)), Curse)), __hm_break616=false;
for (var __hm_index615=0; __hm_index615<array_length(__hm_with614); ++__hm_index615) {
if(instance_exists(__hm_with614[__hm_index615])) with (__hm_with614[__hm_index615]) {
{
if ((random(3) < 1)) {
var __hm_other617=scrHMOther(other);
depth = (__hm_other617.depth - 1);
}
image_speed = (choose(random_range(0.1, 1), 0.4, 0.4, 0.4, 0.4)) * timescale;
if ((random(10) < 1)) {
sprite_index = sprCaveSparkle;
}
}
}
if(__hm_break616) break;
}}
canfly = 1;
scrHMBindEndStep(hm_maincode_mod_gml_CHCoutro, 1, x, y);
{ var __hm_with618 = scrHMInstances(LaserCrystal), __hm_break620=false;
for (var __hm_index619=0; __hm_index619<array_length(__hm_with618); ++__hm_index619) {
if(instance_exists(__hm_with618[__hm_index619])) with (__hm_with618[__hm_index619]) {
if ((distance_to_object((scrHMOther(other))) < 64)) {
{
if ((random(3) > 1)) {
scrHMContentChange1100(InvLaserCrystal, 1);
} else {
scrHMContentChange1100(LightningCrystal, 1);
}
}
}
}
if(__hm_break620) break;
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
{ var __hm_with621 = scrHMInstances(instance_create(x, y, PortalClear)), __hm_break623=false;
for (var __hm_index622=0; __hm_index622<array_length(__hm_with621); ++__hm_index622) {
if(instance_exists(__hm_with621[__hm_index622])) with (__hm_with621[__hm_index622]) {
{
image_xscale = 2;
image_yscale = 2;
}
}
if(__hm_break623) break;
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
if(__hm_break613) break;
}}
if (((current_time mod 10) <= 1)) {
{
{ var __hm_with624 = scrHMInstances(Portal), __hm_break626=false;
for (var __hm_index625=0; __hm_index625<array_length(__hm_with624); ++__hm_index625) {
if(instance_exists(__hm_with624[__hm_index625])) with (__hm_with624[__hm_index625]) {
{
hm_arkintide_mod_gml_hm_cursed_portal_hop();
;
}
}
if(__hm_break626) break;
}}
}
}
}
_hm.pc=184;
break;
case 186: // maincode.mod.gml:1180
{
;
}
_hm.pc=185;
break;
case 187: // maincode.mod.gml:1180
_hm.pc=1;
break;
case 188: // maincode.mod.gml:1166
{
_hm.vars.fl = random_range((- 16), 16);
;
{ var __hm_with627 = scrHMInstances(Floor), __hm_break629=false;
for (var __hm_index628=0; __hm_index628<array_length(__hm_with627); ++__hm_index628) {
if(instance_exists(__hm_with627[__hm_index628])) with (__hm_with627[__hm_index628]) {
if ((random(200) < 1)) {
{ var __hm_with630 = scrHMInstances(instance_create((x + _hm.vars.fl), (y + _hm.vars.fl), CaveSparkle)), __hm_break632=false;
for (var __hm_index631=0; __hm_index631<array_length(__hm_with630); ++__hm_index631) {
if(instance_exists(__hm_with630[__hm_index631])) with (__hm_with630[__hm_index631]) {
image_angle = random(360);
}
if(__hm_break632) break;
}}
}
}
if(__hm_break629) break;
}}
{ var __hm_with633 = scrHMMatching(Effect, "name", "skycrystal"), __hm_break635=false;
for (var __hm_index634=0; __hm_index634<array_length(__hm_with633); ++__hm_index634) {
if(instance_exists(__hm_with633[__hm_index634])) with (__hm_with633[__hm_index634]) {
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
if(__hm_break635) break;
}}
}
_hm.pc=187;
break;
case 189: // maincode.mod.gml:1164
{
;
}
_hm.pc=188;
break;
case 190: // maincode.mod.gml:1164
_hm.pc=1;
break;
case 191: // maincode.mod.gml:1107
{
{ var __hm_with636 = scrHMMatching(Explosion, "name", "gatorexplosion"), __hm_break638=false;
for (var __hm_index637=0; __hm_index637<array_length(__hm_with636); ++__hm_index637) {
if(instance_exists(__hm_with636[__hm_index637])) with (__hm_with636[__hm_index637]) {
{
if ((random(100) < 1)) {
instance_create(x, y, LightBeam);
}
}
}
if(__hm_break638) break;
}}
_hm.vars.fl = random_range((- 16), 16);
;
{ var __hm_with639 = scrHMInstances(Floor), __hm_break641=false;
for (var __hm_index640=0; __hm_index640<array_length(__hm_with639); ++__hm_index640) {
if(instance_exists(__hm_with639[__hm_index640])) with (__hm_with639[__hm_index640]) {
if ((random(300) < 1)) {
{ var __hm_with642 = scrHMInstances(instance_create((x + _hm.vars.fl), (y + _hm.vars.fl), CaveSparkle)), __hm_break644=false;
for (var __hm_index643=0; __hm_index643<array_length(__hm_with642); ++__hm_index643) {
if(instance_exists(__hm_with642[__hm_index643])) with (__hm_with642[__hm_index643]) {
image_angle = random(360);
}
if(__hm_break644) break;
}}
}
}
if(__hm_break641) break;
}}
{ var __hm_with645 = scrHMMatchingGT(Effect, "z", 0), __hm_break647=false;
for (var __hm_index646=0; __hm_index646<array_length(__hm_with645); ++__hm_index646) {
if(instance_exists(__hm_with645[__hm_index646])) with (__hm_with645[__hm_index646]) {
{
image_angle += 25;
image_alpha = 0;
instance_create(x, (y - z), Dust);
}
}
if(__hm_break647) break;
}}
{ var __hm_with648 = scrHMMatchingLE(Effect, "z", 0), __hm_break650=false;
for (var __hm_index649=0; __hm_index649<array_length(__hm_with648); ++__hm_index649) {
if(instance_exists(__hm_with648[__hm_index649])) with (__hm_with648[__hm_index649]) {
{
{ var __hm_with651 = scrHMInstances(instance_create(x, y, Debris)), __hm_break653=false;
for (var __hm_index652=0; __hm_index652<array_length(__hm_with651); ++__hm_index652) {
if(instance_exists(__hm_with651[__hm_index652])) with (__hm_with651[__hm_index652]) {
var __hm_other654=scrHMOther(other);
image_index = __hm_other654.image_index;
}
if(__hm_break653) break;
}}
instance_destroy();
}
}
if(__hm_break650) break;
}}
{ var __hm_with655 = scrHMMatchingGT(Gator, "z", 0), __hm_break657=false;
for (var __hm_index656=0; __hm_index656<array_length(__hm_with655); ++__hm_index656) {
if(instance_exists(__hm_with655[__hm_index656])) with (__hm_with655[__hm_index656]) {
{
image_angle += 25;
mask_index = mskNone;
canfly = 1;
speed = (0) * timescale;
image_alpha = 0;
}
}
if(__hm_break657) break;
}}
{ var __hm_with658 = scrHMMatching(Gator, "z", 0), __hm_break660=false;
for (var __hm_index659=0; __hm_index659<array_length(__hm_with658); ++__hm_index659) {
if(instance_exists(__hm_with658[__hm_index659])) with (__hm_with658[__hm_index659]) {
{
image_angle = 0;
image_alpha = 1;
mask_index = mskBandit;
canfly = 0;
z = (- 1);
repeat (32) { var __hm_with661 = scrHMInstances(instance_create(x, y, Dust)), __hm_break663=false;
for (var __hm_index662=0; __hm_index662<array_length(__hm_with661); ++__hm_index662) {
if(instance_exists(__hm_with661[__hm_index662])) with (__hm_with661[__hm_index662]) {
scrHMMotionAdd(random(360), random(6));
}
if(__hm_break663) break;
}}
}
}
if(__hm_break660) break;
}}
{ var __hm_with664 = scrHMMatchingGT(Spider, "z", 0), __hm_break666=false;
for (var __hm_index665=0; __hm_index665<array_length(__hm_with664); ++__hm_index665) {
if(instance_exists(__hm_with664[__hm_index665])) with (__hm_with664[__hm_index665]) {
{
image_angle += 25;
mask_index = mskNone;
canfly = 1;
speed = (0) * timescale;
image_alpha = 0;
}
}
if(__hm_break666) break;
}}
{ var __hm_with667 = scrHMMatching(Spider, "z", 0), __hm_break669=false;
for (var __hm_index668=0; __hm_index668<array_length(__hm_with667); ++__hm_index668) {
if(instance_exists(__hm_with667[__hm_index668])) with (__hm_with667[__hm_index668]) {
{
image_angle = 0;
image_alpha = 1;
mask_index = mskSpider;
canfly = 0;
z = (- 1);
repeat (32) { var __hm_with670 = scrHMInstances(instance_create(x, y, Dust)), __hm_break672=false;
for (var __hm_index671=0; __hm_index671<array_length(__hm_with670); ++__hm_index671) {
if(instance_exists(__hm_with670[__hm_index671])) with (__hm_with670[__hm_index671]) {
scrHMMotionAdd(random(360), random(6));
}
if(__hm_break672) break;
}}
}
}
if(__hm_break669) break;
}}
}
_hm.pc=190;
break;
case 192: // maincode.mod.gml:1075
scrHMTaskWithNext(_hm);
break;
case 193: // maincode.mod.gml:1075
scrHMTaskWithAbort(_hm);
break;
case 194: // maincode.mod.gml:1081
{
canfly = 1;
walk = 0;
mask_index = mskNone;
x = mount.x;
y = (mount.y - 12);
if ((((target > 0) && (random(2) > 1)) && (collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0))) {
{
{ var __hm_with673 = scrHMMatching(Salamander, "rider", id), __hm_break675=false;
for (var __hm_index674=0; __hm_index674<array_length(__hm_with673); ++__hm_index674) {
if(instance_exists(__hm_with673[__hm_index674])) with (__hm_with673[__hm_index674]) {
var __hm_other676=scrHMOther(other);
scrHMMotionAdd(point_direction(x, y, __hm_other676.target.x, __hm_other676.target.y), 3);
}
if(__hm_break675) break;
}}
}
}
}
_hm.pc=192;
break;
case 195: // maincode.mod.gml:1098
{
if (instance_exists(id)) {
{
mask_index = mskBandit;
mount = 0;
}
}
}
_hm.pc=192;
break;
case 196: // maincode.mod.gml:1097
_hm.wait_ticks=max(0,10); _hm.pc=195; return;
break;
case 197: // maincode.mod.gml:1096
_hm.pc = (scrHMTaskFork(_hm, 196)) ? 196 : 192;
break;
case 198: // maincode.mod.gml:1093
{
canfly = 0;
mount = 0;
scrHMMotionAdd(270, 4);
}
_hm.pc=197;
break;
case 199: // maincode.mod.gml:1081
_hm.pc = (instance_exists(mount)) ? 194 : 198;
break;
case 200: // maincode.mod.gml:1080
_hm.pc = ((mount > 0)) ? 199 : 192;
break;
case 201: // maincode.mod.gml:1076
{
{ var __hm_with677 = scrHMInstances(Salamander), __hm_break679=false;
for (var __hm_index678=0; __hm_index678<array_length(__hm_with677); ++__hm_index678) {
if(instance_exists(__hm_with677[__hm_index678])) with (__hm_with677[__hm_index678]) {
if ((((rider == 0) and place_meeting(x, y, (scrHMOther(other)))) and ((scrHMOther(other)).mount == 0))) {
{
var __hm_other680=scrHMOther(other);
__hm_other680.mount = id;
var __hm_other681=scrHMOther(other);
rider = __hm_other681;
}
}
}
if(__hm_break679) break;
}}
}
_hm.pc=200;
break;
case 202: // maincode.mod.gml:1075
scrHMTaskWithEnter(_hm,scrHMInstances(BuffGator),201,191);
break;
case 203: // maincode.mod.gml:1073
{
{ var __hm_with682 = scrHMInstances(BuffGator), __hm_break684=false;
for (var __hm_index683=0; __hm_index683<array_length(__hm_with682); ++__hm_index683) {
if(instance_exists(__hm_with682[__hm_index683])) with (__hm_with682[__hm_index683]) {
if ((!scrHMVariableExists(id, "mount"))) {
mount = 0;
}
}
if(__hm_break684) break;
}}
}
_hm.pc=202;
break;
case 204: // maincode.mod.gml:1045
scrHMTaskWithNext(_hm);
break;
case 205: // maincode.mod.gml:1045
scrHMTaskWithAbort(_hm);
break;
case 206: // maincode.mod.gml:1051
{
canfly = 1;
walk = 0;
mask_index = mskNone;
x = mount.x;
y = (mount.y - 12);
}
_hm.pc=204;
break;
case 207: // maincode.mod.gml:1064
{
if (instance_exists(id)) {
{
mask_index = mskBandit;
mount = 0;
}
}
}
_hm.pc=204;
break;
case 208: // maincode.mod.gml:1063
_hm.wait_ticks=max(0,10); _hm.pc=207; return;
break;
case 209: // maincode.mod.gml:1062
_hm.pc = (scrHMTaskFork(_hm, 208)) ? 208 : 204;
break;
case 210: // maincode.mod.gml:1059
{
canfly = 0;
mount = 0;
scrHMMotionAdd(270, 4);
}
_hm.pc=209;
break;
case 211: // maincode.mod.gml:1051
_hm.pc = (instance_exists(mount)) ? 206 : 210;
break;
case 212: // maincode.mod.gml:1050
_hm.pc = ((mount > 0)) ? 211 : 204;
break;
case 213: // maincode.mod.gml:1046
{
{ var __hm_with685 = scrHMInstances(Salamander), __hm_break687=false;
for (var __hm_index686=0; __hm_index686<array_length(__hm_with685); ++__hm_index686) {
if(instance_exists(__hm_with685[__hm_index686])) with (__hm_with685[__hm_index686]) {
if ((((rider == 0) and place_meeting(x, y, (scrHMOther(other)))) and ((scrHMOther(other)).mount == 0))) {
{
var __hm_other688=scrHMOther(other);
__hm_other688.mount = id;
var __hm_other689=scrHMOther(other);
rider = __hm_other689;
}
}
}
if(__hm_break687) break;
}}
}
_hm.pc=212;
break;
case 214: // maincode.mod.gml:1045
scrHMTaskWithEnter(_hm,scrHMInstances(Gator),213,203);
break;
case 215: // maincode.mod.gml:1037
{
{ var __hm_with690 = scrHMInstances(Salamander), __hm_break692=false;
for (var __hm_index691=0; __hm_index691<array_length(__hm_with690); ++__hm_index691) {
if(instance_exists(__hm_with690[__hm_index691])) with (__hm_with690[__hm_index691]) {
{
if ((!scrHMVariableExists(id, "rider"))) {
rider = 0;
}
if (((rider > 0) and (! instance_exists(rider)))) {
rider = 0;
}
}
}
if(__hm_break692) break;
}}
{ var __hm_with693 = scrHMInstances(Gator), __hm_break695=false;
for (var __hm_index694=0; __hm_index694<array_length(__hm_with693); ++__hm_index694) {
if(instance_exists(__hm_with693[__hm_index694])) with (__hm_with693[__hm_index694]) {
if ((!scrHMVariableExists(id, "mount"))) {
mount = 0;
}
}
if(__hm_break695) break;
}}
}
_hm.pc=214;
break;
case 216: // maincode.mod.gml:1035
{
;
}
_hm.pc=215;
break;
case 217: // maincode.mod.gml:1035
_hm.pc=1;
break;
case 218: // maincode.mod.gml:1020
{
{ var __hm_with696 = scrHMMatching(Explosion, "name", "gatorexplosion"), __hm_break698=false;
for (var __hm_index697=0; __hm_index697<array_length(__hm_with696); ++__hm_index697) {
if(instance_exists(__hm_with696[__hm_index697])) with (__hm_with696[__hm_index697]) {
{
if ((random(100) < 1)) {
instance_create(x, y, LightBeam);
}
}
}
if(__hm_break698) break;
}}
_hm.vars.fl = random_range((- 16), 16);
;
{ var __hm_with699 = scrHMInstances(Floor), __hm_break701=false;
for (var __hm_index700=0; __hm_index700<array_length(__hm_with699); ++__hm_index700) {
if(instance_exists(__hm_with699[__hm_index700])) with (__hm_with699[__hm_index700]) {
if ((random(300) < 1)) {
{ var __hm_with702 = scrHMInstances(instance_create((x + _hm.vars.fl), (y + _hm.vars.fl), CaveSparkle)), __hm_break704=false;
for (var __hm_index703=0; __hm_index703<array_length(__hm_with702); ++__hm_index703) {
if(instance_exists(__hm_with702[__hm_index703])) with (__hm_with702[__hm_index703]) {
image_angle = random(360);
}
if(__hm_break704) break;
}}
}
}
if(__hm_break701) break;
}}
}
_hm.pc=217;
break;
case 219: // maincode.mod.gml:988
scrHMTaskWithNext(_hm);
break;
case 220: // maincode.mod.gml:988
scrHMTaskWithAbort(_hm);
break;
case 221: // maincode.mod.gml:994
{
canfly = 1;
walk = 0;
mask_index = mskNone;
x = mount.x;
y = (mount.y - 12);
if ((((target > 0) && (random(2) > 1)) && (collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0))) {
{
{ var __hm_with705 = scrHMMatching(Salamander, "rider", id), __hm_break707=false;
for (var __hm_index706=0; __hm_index706<array_length(__hm_with705); ++__hm_index706) {
if(instance_exists(__hm_with705[__hm_index706])) with (__hm_with705[__hm_index706]) {
var __hm_other708=scrHMOther(other);
scrHMMotionAdd(point_direction(x, y, __hm_other708.target.x, __hm_other708.target.y), 3);
}
if(__hm_break707) break;
}}
}
}
}
_hm.pc=219;
break;
case 222: // maincode.mod.gml:1011
{
if (instance_exists(id)) {
{
mask_index = mskBandit;
mount = 0;
}
}
}
_hm.pc=219;
break;
case 223: // maincode.mod.gml:1010
_hm.wait_ticks=max(0,10); _hm.pc=222; return;
break;
case 224: // maincode.mod.gml:1009
_hm.pc = (scrHMTaskFork(_hm, 223)) ? 223 : 219;
break;
case 225: // maincode.mod.gml:1006
{
canfly = 0;
mount = 0;
scrHMMotionAdd(270, 4);
}
_hm.pc=224;
break;
case 226: // maincode.mod.gml:994
_hm.pc = (instance_exists(mount)) ? 221 : 225;
break;
case 227: // maincode.mod.gml:993
_hm.pc = ((mount > 0)) ? 226 : 219;
break;
case 228: // maincode.mod.gml:989
{
{ var __hm_with709 = scrHMInstances(Salamander), __hm_break711=false;
for (var __hm_index710=0; __hm_index710<array_length(__hm_with709); ++__hm_index710) {
if(instance_exists(__hm_with709[__hm_index710])) with (__hm_with709[__hm_index710]) {
if ((((rider == 0) and place_meeting(x, y, (scrHMOther(other)))) and ((scrHMOther(other)).mount == 0))) {
{
var __hm_other712=scrHMOther(other);
__hm_other712.mount = id;
var __hm_other713=scrHMOther(other);
rider = __hm_other713;
}
}
}
if(__hm_break711) break;
}}
}
_hm.pc=227;
break;
case 229: // maincode.mod.gml:988
scrHMTaskWithEnter(_hm,scrHMInstances(BuffGator),228,218);
break;
case 230: // maincode.mod.gml:986
{
{ var __hm_with714 = scrHMInstances(BuffGator), __hm_break716=false;
for (var __hm_index715=0; __hm_index715<array_length(__hm_with714); ++__hm_index715) {
if(instance_exists(__hm_with714[__hm_index715])) with (__hm_with714[__hm_index715]) {
if ((!scrHMVariableExists(id, "mount"))) {
mount = 0;
}
}
if(__hm_break716) break;
}}
}
_hm.pc=229;
break;
case 231: // maincode.mod.gml:958
scrHMTaskWithNext(_hm);
break;
case 232: // maincode.mod.gml:958
scrHMTaskWithAbort(_hm);
break;
case 233: // maincode.mod.gml:964
{
canfly = 1;
walk = 0;
mask_index = mskNone;
x = mount.x;
y = (mount.y - 12);
}
_hm.pc=231;
break;
case 234: // maincode.mod.gml:977
{
if (instance_exists(id)) {
{
mask_index = mskBandit;
mount = 0;
}
}
}
_hm.pc=231;
break;
case 235: // maincode.mod.gml:976
_hm.wait_ticks=max(0,10); _hm.pc=234; return;
break;
case 236: // maincode.mod.gml:975
_hm.pc = (scrHMTaskFork(_hm, 235)) ? 235 : 231;
break;
case 237: // maincode.mod.gml:972
{
canfly = 0;
mount = 0;
scrHMMotionAdd(270, 4);
}
_hm.pc=236;
break;
case 238: // maincode.mod.gml:964
_hm.pc = (instance_exists(mount)) ? 233 : 237;
break;
case 239: // maincode.mod.gml:963
_hm.pc = ((mount > 0)) ? 238 : 231;
break;
case 240: // maincode.mod.gml:959
{
{ var __hm_with717 = scrHMInstances(Salamander), __hm_break719=false;
for (var __hm_index718=0; __hm_index718<array_length(__hm_with717); ++__hm_index718) {
if(instance_exists(__hm_with717[__hm_index718])) with (__hm_with717[__hm_index718]) {
if ((((rider == 0) and place_meeting(x, y, (scrHMOther(other)))) and ((scrHMOther(other)).mount == 0))) {
{
var __hm_other720=scrHMOther(other);
__hm_other720.mount = id;
var __hm_other721=scrHMOther(other);
rider = __hm_other721;
}
}
}
if(__hm_break719) break;
}}
}
_hm.pc=239;
break;
case 241: // maincode.mod.gml:958
scrHMTaskWithEnter(_hm,scrHMInstances(Gator),240,230);
break;
case 242: // maincode.mod.gml:950
{
{ var __hm_with722 = scrHMInstances(Salamander), __hm_break724=false;
for (var __hm_index723=0; __hm_index723<array_length(__hm_with722); ++__hm_index723) {
if(instance_exists(__hm_with722[__hm_index723])) with (__hm_with722[__hm_index723]) {
{
if ((!scrHMVariableExists(id, "rider"))) {
rider = 0;
}
if (((rider > 0) and (! instance_exists(rider)))) {
rider = 0;
}
}
}
if(__hm_break724) break;
}}
{ var __hm_with725 = scrHMInstances(Gator), __hm_break727=false;
for (var __hm_index726=0; __hm_index726<array_length(__hm_with725); ++__hm_index726) {
if(instance_exists(__hm_with725[__hm_index726])) with (__hm_with725[__hm_index726]) {
if ((!scrHMVariableExists(id, "mount"))) {
mount = 0;
}
}
if(__hm_break727) break;
}}
}
_hm.pc=241;
break;
case 243: // maincode.mod.gml:948
{
;
}
_hm.pc=242;
break;
case 244: // maincode.mod.gml:948
_hm.pc=1;
break;
case 245: // maincode.mod.gml:915
{
{ var __hm_with728 = scrHMInstances(ScrapBossMissile), __hm_break730=false;
for (var __hm_index729=0; __hm_index729<array_length(__hm_with728); ++__hm_index729) {
if(instance_exists(__hm_with728[__hm_index729])) with (__hm_with728[__hm_index729]) {
{
if ((random(4) < 1)) {
{ var __hm_with731 = scrHMInstances(instance_create((x + lengthdir_x((- 8), direction)), (y + lengthdir_y((- 8), direction)), TrapFire)), __hm_break733=false;
for (var __hm_index732=0; __hm_index732<array_length(__hm_with731); ++__hm_index732) {
if(instance_exists(__hm_with731[__hm_index732])) with (__hm_with731[__hm_index732]) {
{
var __hm_other734=scrHMOther(other);
team = __hm_other734.team;
var __hm_other735=scrHMOther(other);
creator = __hm_other735;
var __hm_other736=scrHMOther(other);
depth = (__hm_other736.depth + choose((- 0.1), 0.1));
var __hm_other737=scrHMOther(other);
direction = __hm_other737.direction;
image_angle = direction;
image_yscale = 0.5;
var __hm_other738=scrHMOther(other);
hitid = __hm_other738.hitid;
image_index += 3;
}
}
if(__hm_break733) break;
}}
}
alarm[1] = (- 1);
if (place_meeting((x + ((hspeed / timescale) * 3)), (y + ((vspeed / timescale) * 3)), Wall)) {
{ var __hm_with739 = scrHMInstances(instance_nearest((x + ((hspeed / timescale) * 3)), (y + ((vspeed / timescale) * 3)), Wall)), __hm_break741=false;
for (var __hm_index740=0; __hm_index740<array_length(__hm_with739); ++__hm_index740) {
if(instance_exists(__hm_with739[__hm_index740])) with (__hm_with739[__hm_index740]) {
{
instance_create(x, y, FloorExplo);
instance_destroy();
}
}
if(__hm_break741) break;
}}
}
x += lengthdir_x(0.5, direction);
y += lengthdir_y(0.5, direction);
{ var __hm_with742 = scrHMInstances(EnemyBullet1), __hm_break744=false;
for (var __hm_index743=0; __hm_index743<array_length(__hm_with742); ++__hm_index743) {
if(instance_exists(__hm_with742[__hm_index743])) with (__hm_with742[__hm_index743]) {
if ((creator == (scrHMOther(other)))) {
{
{ var __hm_with745 = scrHMInstances(instance_create(x, y, EnemyBullet3)), __hm_break747=false;
for (var __hm_index746=0; __hm_index746<array_length(__hm_with745); ++__hm_index746) {
if(instance_exists(__hm_with745[__hm_index746])) with (__hm_with745[__hm_index746]) {
{
speed = ((6 * (GameCont.loops + 1))) * timescale;
var __hm_other748=scrHMOther(other);
creator = __hm_other748.creator;
var __hm_other749=scrHMOther(other);
direction = __hm_other749.direction;
image_angle = direction;
var __hm_other750=scrHMOther(other);
team = __hm_other750.team;
var __hm_other751=scrHMOther(other);
hitid = __hm_other751.hitid;
}
}
if(__hm_break747) break;
}}
instance_destroy();
}
}
}
if(__hm_break744) break;
}}
}
}
if(__hm_break730) break;
}}
}
_hm.pc=244;
break;
case 246: // maincode.mod.gml:808
{
repeat (6) instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), RainDrop);
}
_hm.pc=245;
break;
case 247: // maincode.mod.gml:902
{
{ var __hm_with752 = scrHMInstances(LHBouncer), __hm_break754=false;
for (var __hm_index753=0; __hm_index753<array_length(__hm_with752); ++__hm_index753) {
if(instance_exists(__hm_with752[__hm_index753])) with (__hm_with752[__hm_index753]) {
{
image_angle = direction;
;
}
}
if(__hm_break754) break;
}}
{ var __hm_with755 = scrHMInstances(BigDogExplo), __hm_break757=false;
for (var __hm_index756=0; __hm_index756<array_length(__hm_with755); ++__hm_index756) {
if(instance_exists(__hm_with755[__hm_index756])) with (__hm_with755[__hm_index756]) {
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
if(__hm_break757) break;
}}
}
_hm.pc=245;
break;
case 248: // maincode.mod.gml:854
scrHMTaskWithNext(_hm);
break;
case 249: // maincode.mod.gml:854
scrHMTaskWithAbort(_hm);
break;
case 250: // maincode.mod.gml:884
{
{ var __hm_with758 = scrHMInstances(EnemyBullet1), __hm_break760=false;
for (var __hm_index759=0; __hm_index759<array_length(__hm_with758); ++__hm_index759) {
if(instance_exists(__hm_with758[__hm_index759])) with (__hm_with758[__hm_index759]) {
if ((creator == (scrHMOther(other)))) {
{
{ var __hm_with761 = scrHMInstances(instance_create(x, y, LHBouncer)), __hm_break763=false;
for (var __hm_index762=0; __hm_index762<array_length(__hm_with761); ++__hm_index762) {
if(instance_exists(__hm_with761[__hm_index762])) with (__hm_with761[__hm_index762]) {
{
rot = 0;
sprite_index = sprEnemyBullet1;
mask_index = mskEnemyBullet1;
var __hm_other764=scrHMOther(other);
creator = __hm_other764.creator;
var __hm_other765=scrHMOther(other);
team = __hm_other765.team;
var __hm_other766=scrHMOther(other);
speed = ((__hm_other766.speed / timescale)) * timescale;
var __hm_other767=scrHMOther(other);
hitid = __hm_other767.hitid;
var __hm_other768=scrHMOther(other);
direction = __hm_other768.direction;
image_angle = direction;
;
image_blend = merge_color(image_blend, c_red, 0.2);
if ((random(5) < 1)) {
instance_destroy();
}
}
}
if(__hm_break763) break;
}}
scrHMContentChange1100(Wind, 0);
instance_destroy();
}
}
}
if(__hm_break760) break;
}}
}
_hm.pc=248;
break;
case 251: // maincode.mod.gml:864
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
_hm.pc=250;
break;
case 252: // maincode.mod.gml:863
_hm.wait_ticks=max(0,30); _hm.pc=251; return;
break;
case 253: // maincode.mod.gml:862
{
hm_intro_claimed = 1;
;
}
_hm.pc=252;
break;
case 254: // maincode.mod.gml:861
_hm.pc = (((!scrHMVariableExists(_hm.scope, "hm_intro_claimed")) && scrHMTaskFork(_hm, 253))) ? 253 : 250;
break;
case 255: // maincode.mod.gml:856
{
introanimation += 0.4;
image_alpha = 0;
friction = (30) * (timescale * timescale);
{ var __hm_with769 = scrHMInstances(scrHMBindDraw(hm_maincode_mod_gml_bigdogintro, 0)), __hm_break771=false;
for (var __hm_index770=0; __hm_index770<array_length(__hm_with769); ++__hm_index770) {
if(instance_exists(__hm_with769[__hm_index770])) with (__hm_with769[__hm_index770]) {
var __hm_other772=scrHMOther(other);
creator = __hm_other772;
}
if(__hm_break771) break;
}}
}
_hm.pc=254;
break;
case 256: // maincode.mod.gml:878
{
image_alpha = 1;
mask_index = mskScrapBoss;
friction = (0.4) * (timescale * timescale);
}
_hm.pc=250;
break;
case 257: // maincode.mod.gml:855
_hm.pc = ((introanimation < 11)) ? 255 : 256;
break;
case 258: // maincode.mod.gml:855
_hm.pc = ((scrHMModExists("mod", "options", "intropan") and (scrHMModGet("mod", "options", "intropan") == "1"))) ? 257 : 250;
break;
case 259: // maincode.mod.gml:854
scrHMTaskWithEnter(_hm,scrHMInstances(ScrapBoss),258,247);
break;
case 260: // maincode.mod.gml:822
scrHMTaskWithNext(_hm);
break;
case 261: // maincode.mod.gml:822
scrHMTaskWithAbort(_hm);
break;
case 262: // maincode.mod.gml:847
{
;
if (instance_exists(id)) {
{ var __hm_with773 = scrHMInstances(instance_create(x, y, PortalClear)), __hm_break775=false;
for (var __hm_index774=0; __hm_index774<array_length(__hm_with773); ++__hm_index774) {
if(instance_exists(__hm_with773[__hm_index774])) with (__hm_with773[__hm_index774]) {
{
image_xscale = 3.5;
image_yscale = 3.5;
}
}
if(__hm_break775) break;
}}
}
}
_hm.pc=260;
break;
case 263: // maincode.mod.gml:847
_hm.wait_ticks=max(0,5); _hm.pc=262; return;
break;
case 264: // maincode.mod.gml:842
{
;
if (instance_exists(id)) {
{ var __hm_with776 = scrHMInstances(instance_create(x, y, PortalClear)), __hm_break778=false;
for (var __hm_index777=0; __hm_index777<array_length(__hm_with776); ++__hm_index777) {
if(instance_exists(__hm_with776[__hm_index777])) with (__hm_with776[__hm_index777]) {
{
image_xscale = 3;
image_yscale = 3;
}
}
if(__hm_break778) break;
}}
}
}
_hm.pc=263;
break;
case 265: // maincode.mod.gml:842
_hm.wait_ticks=max(0,5); _hm.pc=264; return;
break;
case 266: // maincode.mod.gml:837
{
;
if (instance_exists(id)) {
{ var __hm_with779 = scrHMInstances(instance_create(x, y, PortalClear)), __hm_break781=false;
for (var __hm_index780=0; __hm_index780<array_length(__hm_with779); ++__hm_index780) {
if(instance_exists(__hm_with779[__hm_index780])) with (__hm_with779[__hm_index780]) {
{
image_xscale = 2.5;
image_yscale = 2.5;
}
}
if(__hm_break781) break;
}}
}
}
_hm.pc=265;
break;
case 267: // maincode.mod.gml:837
_hm.wait_ticks=max(0,5); _hm.pc=266; return;
break;
case 268: // maincode.mod.gml:836
_hm.pc = (scrHMTaskFork(_hm, 267)) ? 267 : 260;
break;
case 269: // maincode.mod.gml:823
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
{ var __hm_with782 = scrHMInstances(instance_create(x, y, PortalClear)), __hm_break784=false;
for (var __hm_index783=0; __hm_index783<array_length(__hm_with782); ++__hm_index783) {
if(instance_exists(__hm_with782[__hm_index783])) with (__hm_with782[__hm_index783]) {
{
image_xscale = 2;
image_yscale = 2;
}
}
if(__hm_break784) break;
}}
speed = (0) * timescale;
}
_hm.pc=268;
break;
case 270: // maincode.mod.gml:822
scrHMTaskWithEnter(_hm,scrHMMatchingNE(ScrapBoss, "morehp", 1),269,259);
break;
case 271: // maincode.mod.gml:813
{
if ((random(6) < 1)) {
instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), RainDrop);
}
if ((random(42) < 1)) {
instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), LightBeam);
}
{ var __hm_with785 = scrHMInstances(LightBeam), __hm_break787=false;
for (var __hm_index786=0; __hm_index786<array_length(__hm_with785); ++__hm_index786) {
if(instance_exists(__hm_with785[__hm_index786])) with (__hm_with785[__hm_index786]) {
{
scrHMMotionSet(180, 0.3);
if ((random(500) < 1)) {
instance_destroy();
}
}
}
if(__hm_break787) break;
}}
}
_hm.pc=270;
break;
case 272: // maincode.mod.gml:808
_hm.pc = ((GameCont.subarea == 4)) ? 246 : 271;
break;
case 273: // maincode.mod.gml:806
{
;
}
_hm.pc=272;
break;
case 274: // maincode.mod.gml:806
_hm.pc=1;
break;
case 275: // maincode.mod.gml:761
{
repeat (6) instance_create(((view_xview + random((view_width * 2))) - (view_width / 2)), ((view_yview + random((view_height * 2))) - (view_height / 2)), RainDrop);
{ var __hm_with788 = scrHMInstances(RainDrop), __hm_break790=false;
for (var __hm_index789=0; __hm_index789<array_length(__hm_with788); ++__hm_index789) {
if(instance_exists(__hm_with788[__hm_index789])) with (__hm_with788[__hm_index789]) {
{
addy -= 6;
addx -= 6;
}
}
if(__hm_break790) break;
}}
{ var __hm_with791 = scrHMInstances(instance_nearest((view_xview + random(view_width)), (view_yview + random(view_height)), Floor)), __hm_break793=false;
for (var __hm_index792=0; __hm_index792<array_length(__hm_with791); ++__hm_index792) {
if(instance_exists(__hm_with791[__hm_index792])) with (__hm_with791[__hm_index792]) {
if ((random(6) < 1)) {
{
if ((((place_meeting((x - 32), y, Floor) and place_meeting((x + 32), y, Floor)) and place_meeting(x, (y - 32), Floor)) and place_meeting(x, (y + 32), Floor))) {
{ var __hm_with794 = scrHMInstances(instance_create((x + random(32)), (y + random(32)), Wind)), __hm_break796=false;
for (var __hm_index795=0; __hm_index795<array_length(__hm_with794); ++__hm_index795) {
if(instance_exists(__hm_with794[__hm_index795])) with (__hm_with794[__hm_index795]) {
{
image_xscale = (- 1);
direction = 0;
}
}
if(__hm_break796) break;
}}
}
}
}
}
if(__hm_break793) break;
}}
{ var __hm_with797 = scrHMInstances(Corpse), __hm_break799=false;
for (var __hm_index798=0; __hm_index798<array_length(__hm_with797); ++__hm_index798) {
if(instance_exists(__hm_with797[__hm_index798])) with (__hm_with797[__hm_index798]) {
if (((!scrHMVariableExists(id, "bird")) and instance_exists(enemy))) {
{
if ((random(5) < 1)) {
{
{ var __hm_with800 = scrHMInstances(instance_create((x + random_range(200, (- 200))), (y - random_range(250, 300)), Raven)), __hm_break802=false;
for (var __hm_index801=0; __hm_index801<array_length(__hm_with800); ++__hm_index801) {
if(instance_exists(__hm_with800[__hm_index801])) with (__hm_with800[__hm_index801]) {
{
assassin = 0;
image_alpha = 0;
scrHMContentChange1100(RavenFly, false);
;
event_perform(ev_create, 0);
;
image_index = 0;
;
_hm.vars.f = instance_nearest(((scrHMOther(other)).x + random_range((- 80), 80)), ((scrHMOther(other)).y + random_range((- 80), 80)), Floor);
;
if ((_hm.vars.f.object_index == FloorExplo)) {
{
if (place_meeting(_hm.vars.f.x, _hm.vars.f.y, Wall)) {
{
var __hm_other803=scrHMOther(other);
targetx = __hm_other803.x;
var __hm_other804=scrHMOther(other);
targety = __hm_other804.y;
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
var __hm_other805=scrHMOther(other);
targetx = __hm_other805.x;
var __hm_other806=scrHMOther(other);
targety = __hm_other806.y;
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
if(__hm_break802) break;
}}
}
}
bird = 1;
}
}
}
if(__hm_break799) break;
}}
}
_hm.pc=274;
break;
case 276: // maincode.mod.gml:759
{
;
}
_hm.pc=275;
break;
case 277: // maincode.mod.gml:759
_hm.pc=1;
break;
case 278: // maincode.mod.gml:753
{
{ var __hm_with807 = scrHMMatching(Raven, "assassin", undefined), __hm_break809=false;
for (var __hm_index808=0; __hm_index808<array_length(__hm_with807); ++__hm_index808) {
if(instance_exists(__hm_with807[__hm_index808])) with (__hm_with807[__hm_index808]) {
{
if ((random(10) < 1)) {
assassin = 1;
} else {
assassin = 0;
}
}
}
if(__hm_break809) break;
}}
}
_hm.pc=277;
break;
case 279: // maincode.mod.gml:707
scrHMTaskWithNext(_hm);
break;
case 280: // maincode.mod.gml:707
scrHMTaskWithAbort(_hm);
break;
case 281: // maincode.mod.gml:741
{
{ var __hm_with810 = scrHMInstances(instance_create((x + random_range(200, (- 200))), (y - random_range(250, 300)), Raven)), __hm_break812=false;
for (var __hm_index811=0; __hm_index811<array_length(__hm_with810); ++__hm_index811) {
if(instance_exists(__hm_with810[__hm_index811])) with (__hm_with810[__hm_index811]) {
{
image_alpha = 0;
assassin = 0;
scrHMContentChange1100(RavenFly, false);
;
event_perform(ev_create, 0);
;
image_index = 0;
;
targetx = (_hm.vars.f.x + 16);
targety = (_hm.vars.f.y + 16);
__hm_break812=true; break;
;
}
}
if(__hm_break812) break;
}}
}
_hm.pc=279;
break;
case 282: // maincode.mod.gml:739
_hm.pc=280;
break;
case 283: // maincode.mod.gml:738
_hm.pc = ((_hm.vars.r > 200)) ? 282 : 281;
break;
case 284: // maincode.mod.gml:711
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
_hm.pc=283;
break;
case 285: // maincode.mod.gml:710
_hm.pc = (scrHMTaskFork(_hm, 284)) ? 284 : 279;
break;
case 286: // maincode.mod.gml:709
_hm.pc = ((random(5) < 1)) ? 285 : 279;
break;
case 287: // maincode.mod.gml:708
{
bird = 1;
}
_hm.pc=286;
break;
case 288: // maincode.mod.gml:707
_hm.pc = (((!scrHMVariableExists(_hm.scope, "bird")) and instance_exists(enemy))) ? 287 : 279;
break;
case 289: // maincode.mod.gml:707
scrHMTaskWithEnter(_hm,scrHMInstances(Corpse),288,278);
break;
case 290: // maincode.mod.gml:697
{
{ var __hm_with813 = scrHMInstances(BuffGator), __hm_break815=false;
for (var __hm_index814=0; __hm_index814<array_length(__hm_with813); ++__hm_index814) {
if(instance_exists(__hm_with813[__hm_index814])) with (__hm_with813[__hm_index814]) {
{
instance_create(x, y, Jock);
scrHMContentChange1100(Wind, 0);
instance_destroy();
}
}
if(__hm_break815) break;
}}
{ var __hm_with816 = scrHMInstances(Bandit), __hm_break818=false;
for (var __hm_index817=0; __hm_index817<array_length(__hm_with816); ++__hm_index817) {
if(instance_exists(__hm_with816[__hm_index817])) with (__hm_with816[__hm_index817]) {
{
instance_create(x, y, Raven);
scrHMContentChange1100(Wind, 0);
instance_destroy();
}
}
if(__hm_break818) break;
}}
}
_hm.pc=289;
break;
case 291: // maincode.mod.gml:695
{
;
}
_hm.pc=290;
break;
case 292: // maincode.mod.gml:695
_hm.pc=1;
break;
case 293: // maincode.mod.gml:674
{
if ((GameCont.loops == 0)) {
{ var __hm_with819 = scrHMInstances(IDPDSpawn), __hm_break821=false;
for (var __hm_index820=0; __hm_index820<array_length(__hm_with819); ++__hm_index820) {
if(instance_exists(__hm_with819[__hm_index820])) with (__hm_with819[__hm_index820]) {
scrHMDelete(id);
}
if(__hm_break821) break;
}}
}
scrHMSoundStop(sndIDPDPortalSpawn);
scrHMSoundStop(sndEliteIDPDPortalSpawn);
{ var __hm_with822 = scrHMInstances(GenCont), __hm_break824=false;
for (var __hm_index823=0; __hm_index823<array_length(__hm_with822); ++__hm_index823) {
if(instance_exists(__hm_with822[__hm_index823])) with (__hm_with822[__hm_index823]) {
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
if(__hm_break824) break;
}}
{ var __hm_with825 = scrHMInstances(instance_nearest((view_xview + random(view_width)), (view_yview + random(view_height)), Floor)), __hm_break827=false;
for (var __hm_index826=0; __hm_index826<array_length(__hm_with825); ++__hm_index826) {
if(instance_exists(__hm_with825[__hm_index826])) with (__hm_with825[__hm_index826]) {
if ((random(6) < 1)) {
{
if ((((place_meeting((x - 32), y, Floor) and place_meeting((x + 32), y, Floor)) and place_meeting(x, (y - 32), Floor)) and place_meeting(x, (y + 32), Floor))) {
{ var __hm_with828 = scrHMInstances(instance_create((x + random(32)), (y + random(32)), Drip)), __hm_break830=false;
for (var __hm_index829=0; __hm_index829<array_length(__hm_with828); ++__hm_index829) {
if(instance_exists(__hm_with828[__hm_index829])) with (__hm_with828[__hm_index829]) {
sprite_index = sprCheeseDrip;
}
if(__hm_break830) break;
}}
}
}
}
}
if(__hm_break827) break;
}}
{ var __hm_with831 = scrHMInstances(HPPickup), __hm_break833=false;
for (var __hm_index832=0; __hm_index832<array_length(__hm_with831); ++__hm_index832) {
if(instance_exists(__hm_with831[__hm_index832])) with (__hm_with831[__hm_index832]) {
sprite_index = sprSlice;
}
if(__hm_break833) break;
}}
}
_hm.pc=292;
break;
case 294: // maincode.mod.gml:672
{
;
}
_hm.pc=293;
break;
case 295: // maincode.mod.gml:672
_hm.pc=1;
break;
case 296: // maincode.mod.gml:671
{
hm_arkintide_mod_gml_hm_water_tick();
;
}
_hm.pc=295;
break;
case 297: // maincode.mod.gml:669
{

}
_hm.pc=296;
break;
case 298: // maincode.mod.gml:668
{
;
}
_hm.pc=297;
break;
case 299: // maincode.mod.gml:668
_hm.pc=1;
break;
case 300: // maincode.mod.gml:640
scrHMTaskWithNext(_hm);
break;
case 301: // maincode.mod.gml:640
scrHMTaskWithAbort(_hm);
break;
case 302: // maincode.mod.gml:652
{
scrHMModCall("mod", "props", "fancylid_create", x, y);
image_index = 1;
}
_hm.pc=300;
break;
case 303: // maincode.mod.gml:651
_hm.wait_ticks=max(0,60); _hm.pc=302; return;
break;
case 304: // maincode.mod.gml:650
{
activated = 1;
;
}
_hm.pc=303;
break;
case 305: // maincode.mod.gml:649
_hm.pc = ((_hm.vars.no == 0)) ? 304 : 300;
break;
case 306: // maincode.mod.gml:646
{
{ var __hm_with834 = scrHMMatching(CustomObject, "name", "bossintros"), __hm_break836=false;
for (var __hm_index835=0; __hm_index835<array_length(__hm_with834); ++__hm_index835) {
if(instance_exists(__hm_with834[__hm_index835])) with (__hm_with834[__hm_index835]) {
_hm.vars.no += 1;
}
if(__hm_break836) break;
}}
}
_hm.pc=305;
break;
case 307: // maincode.mod.gml:659
{
;
if (instance_exists(id)) {
{
scrHMModCall("mod", "props", "fancylid_create", x, y);
image_index = 1;
}
}
}
_hm.pc=300;
break;
case 308: // maincode.mod.gml:658
_hm.wait_ticks=max(0,60); _hm.pc=307; return;
break;
case 309: // maincode.mod.gml:659
_hm.wait_ticks=max(0,180); _hm.pc=307; return;
break;
case 310: // maincode.mod.gml:658
_hm.pc = ((GameCont.loops == 0)) ? 308 : 309;
break;
case 311: // maincode.mod.gml:657
{
activated = 1;
;
}
_hm.pc=310;
break;
case 312: // maincode.mod.gml:656
_hm.pc = ((_hm.vars.no == 0)) ? 311 : 300;
break;
case 313: // maincode.mod.gml:644
_hm.pc = ((scrHMModExists("mod", "options", "bossoutros") and (scrHMModGet("mod", "options", "bossoutros") == "1"))) ? 306 : 312;
break;
case 314: // maincode.mod.gml:641
{
_hm.vars.no = 0;
;
if ((instance_number(enemy) > 1)) {
_hm.vars.no += 1;
}
}
_hm.pc=313;
break;
case 315: // maincode.mod.gml:640
_hm.pc = (((!scrHMVariableExists(_hm.scope, "activated")) and (image_index == 0))) ? 314 : 300;
break;
case 316: // maincode.mod.gml:640
scrHMTaskWithEnter(_hm,scrHMMatching(CustomObject, "name", "sewersentrance"),315,299);
break;
case 317: // maincode.mod.gml:621
{
if ((GameCont.loops == 0)) {
{ var __hm_with837 = scrHMInstances(IDPDSpawn), __hm_break839=false;
for (var __hm_index838=0; __hm_index838<array_length(__hm_with837); ++__hm_index838) {
if(instance_exists(__hm_with837[__hm_index838])) with (__hm_with837[__hm_index838]) {
scrHMDelete(id);
}
if(__hm_break839) break;
}}
}
scrHMSoundStop(sndIDPDPortalSpawn);
scrHMSoundStop(sndEliteIDPDPortalSpawn);
{ var __hm_with840 = scrHMInstances(FloorExplo), __hm_break842=false;
for (var __hm_index841=0; __hm_index841<array_length(__hm_with840); ++__hm_index841) {
if(instance_exists(__hm_with840[__hm_index841])) with (__hm_with840[__hm_index841]) {
if (((!scrHMVariableExists(id, "ammo")) and (! instance_exists(Portal)))) {
{
ammo = 1;
scrHMModCall("mod", "enemies", "scrPickups", 2);
}
}
}
if(__hm_break842) break;
}}
{ var __hm_with843 = scrHMInstances(TopDecalDesert), __hm_break845=false;
for (var __hm_index844=0; __hm_index844<array_length(__hm_with843); ++__hm_index844) {
if(instance_exists(__hm_with843[__hm_index844])) with (__hm_with843[__hm_index844]) {
if ((!scrHMVariableExists(id, "why_are_you_so_far_down"))) {
{
if (place_meeting(x, (y - 16), Wall)) {
y -= 20;
}
why_are_you_so_far_down = 1;
}
}
}
if(__hm_break845) break;
}}
{ var __hm_with846 = scrHMInstances(instance_nearest((view_xview + random(view_width)), (view_yview + random(view_height)), Floor)), __hm_break848=false;
for (var __hm_index847=0; __hm_index847<array_length(__hm_with846); ++__hm_index847) {
if(instance_exists(__hm_with846[__hm_index847])) with (__hm_with846[__hm_index847]) {
if ((random(6) < 1)) {
{
if ((((place_meeting((x - 32), y, Floor) and place_meeting((x + 32), y, Floor)) and place_meeting(x, (y - 32), Floor)) and place_meeting(x, (y + 32), Floor))) {
{ var __hm_with849 = scrHMInstances(instance_create((x + random(32)), (y + random(32)), Wind)), __hm_break851=false;
for (var __hm_index850=0; __hm_index850<array_length(__hm_with849); ++__hm_index850) {
if(instance_exists(__hm_with849[__hm_index850])) with (__hm_with849[__hm_index850]) {
{
image_xscale = (- 1);
direction = 0;
}
}
if(__hm_break851) break;
}}
}
}
}
}
if(__hm_break848) break;
}}
}
_hm.pc=316;
break;
case 318: // maincode.mod.gml:619
{
;
}
_hm.pc=317;
break;
case 319: // maincode.mod.gml:619
_hm.pc=1;
break;
case 320: // maincode.mod.gml:600
{
{ var __hm_with852 = scrHMInstances(TopDecalNightDesert), __hm_break854=false;
for (var __hm_index853=0; __hm_index853<array_length(__hm_with852); ++__hm_index853) {
if(instance_exists(__hm_with852[__hm_index853])) with (__hm_with852[__hm_index853]) {
if ((!scrHMVariableExists(id, "why_are_you_so_far_down"))) {
{
if (place_meeting(x, (y - 16), Wall)) {
y -= 20;
}
why_are_you_so_far_down = 1;
}
}
}
if(__hm_break854) break;
}}
{ var __hm_with855 = scrHMInstances(Campfire), __hm_break857=false;
for (var __hm_index856=0; __hm_index856<array_length(__hm_with855); ++__hm_index856) {
if(instance_exists(__hm_with855[__hm_index856])) with (__hm_with855[__hm_index856]) {
{
if ((random(60) < 1)) {
{ var __hm_with858 = scrHMInstances(instance_create((x + random_range((- 3), 3)), ((y + random_range((- 3), 3)) - 10), FireFly)), __hm_break860=false;
for (var __hm_index859=0; __hm_index859<array_length(__hm_with858); ++__hm_index859) {
if(instance_exists(__hm_with858[__hm_index859])) with (__hm_with858[__hm_index859]) {
depth = (- 4);
}
if(__hm_break860) break;
}}
}
if (((spr_idle == sprCampfireOff) and ((position_meeting(x, y, Explosion) || position_meeting(x, y, Flame)) || (position_meeting(x, y, CustomProjectile) and (CustomProjectile.sprite_index == sprTrapFire))))) {
{
spr_idle = sprCampfire;
{ var __hm_with861 = scrHMInstances(instance_create(x, y, AmmoPickup)), __hm_break863=false;
for (var __hm_index862=0; __hm_index862<array_length(__hm_with861); ++__hm_index862) {
if(instance_exists(__hm_with861[__hm_index862])) with (__hm_with861[__hm_index862]) {
scrHMMotionAdd(random_range(60, 110), random(6));
}
if(__hm_break863) break;
}}
}
}
}
}
if(__hm_break857) break;
}}
{ var __hm_with864 = scrHMInstances(instance_nearest((view_xview + random(view_width)), (view_yview + random(view_height)), Floor)), __hm_break866=false;
for (var __hm_index865=0; __hm_index865<array_length(__hm_with864); ++__hm_index865) {
if(instance_exists(__hm_with864[__hm_index865])) with (__hm_with864[__hm_index865]) {
if ((random(6) < 1)) {
{
if ((((place_meeting((x - 32), y, Floor) and place_meeting((x + 32), y, Floor)) and place_meeting(x, (y - 32), Floor)) and place_meeting(x, (y + 32), Floor))) {
instance_create((x + random(32)), (y + random(32)), WindNight);
}
}
}
}
if(__hm_break866) break;
}}
}
_hm.pc=319;
break;
case 321: // maincode.mod.gml:598
{
;
}
_hm.pc=320;
break;
case 322: // maincode.mod.gml:598
_hm.pc=1;
break;
case 323: // maincode.mod.gml:594
{
if ((GameCont.subarea == 3)) {
{
if (instance_exists(GenCont)) {
TopCont.fog = global.hm_module_vars[$ "mod:maincode"].redfog;
}
{ var __hm_with867 = scrHMInstances(TopCont), __hm_break869=false;
for (var __hm_index868=0; __hm_index868<array_length(__hm_with867); ++__hm_index868) {
if(instance_exists(__hm_with867[__hm_index868])) with (__hm_with867[__hm_index868]) {
fogscroll = 100;
}
if(__hm_break869) break;
}}
}
}
}
_hm.pc=322;
break;
case 324: // maincode.mod.gml:543
scrHMTaskWithNext(_hm);
break;
case 325: // maincode.mod.gml:543
scrHMTaskWithAbort(_hm);
break;
case 326: // maincode.mod.gml:544
{
instance_destroy();
}
_hm.pc=324;
break;
case 327: // maincode.mod.gml:586
{
if ((intro > 2)) {
{
intro -= 2;
gunangle += random_range(25, 35);
}
}
}
_hm.pc=324;
break;
case 328: // maincode.mod.gml:583
{
;
}
_hm.pc=327;
break;
case 329: // maincode.mod.gml:583
_hm.result=undefined; _hm.done=true; return;
break;
case 330: // maincode.mod.gml:559
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
{ var __hm_with870 = scrHMMatching(CustomObject, "name", "bossintro"), __hm_break872=false;
for (var __hm_index871=0; __hm_index871<array_length(__hm_with870); ++__hm_index871) {
if(instance_exists(__hm_with870[__hm_index871])) with (__hm_with870[__hm_index871]) {
{
_hm.vars.i2 += 1;
}
}
if(__hm_break872) break;
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
_hm.pc=329;
break;
case 331: // maincode.mod.gml:558
_hm.wait_ticks=max(0,15); _hm.pc=330; return;
break;
case 332: // maincode.mod.gml:557
_hm.pc = (scrHMTaskFork(_hm, 331)) ? 331 : 327;
break;
case 333: // maincode.mod.gml:550
{
intro = 2;
charge = 1;
alarm[1] = 60;
alarm[4] = 5;
spr_idle = sprBanditBossTell;
spr_walk = sprBanditBossDash;
spr_fire = sprBanditBossStop;
}
_hm.pc=332;
break;
case 334: // maincode.mod.gml:549
_hm.pc = ((((speed / timescale) < (friction / (timescale * timescale))) and (intro < 1))) ? 333 : 327;
break;
case 335: // maincode.mod.gml:548
_hm.pc = (((UberCont.opt_bossintro == 1) || (scrHMModExists("mod", "options", "intropan") and (scrHMModGet("mod", "options", "intropan") == "1")))) ? 334 : 324;
break;
case 336: // maincode.mod.gml:544
_hm.pc = ((GameCont.subarea < 3)) ? 326 : 335;
break;
case 337: // maincode.mod.gml:543
scrHMTaskWithEnter(_hm,scrHMInstances(BanditBoss),336,323);
break;
case 338: // maincode.mod.gml:531
{
{ var __hm_with873 = scrHMInstances(Bandit), __hm_break875=false;
for (var __hm_index874=0; __hm_index874<array_length(__hm_with873); ++__hm_index874) {
if(instance_exists(__hm_with873[__hm_index874])) with (__hm_with873[__hm_index874]) {
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
scrHMContentChange1100(Wind, 0);
instance_destroy();
}
}
if(__hm_break875) break;
}}
}
_hm.pc=337;
break;
case 339: // maincode.mod.gml:520
scrHMTaskWithNext(_hm);
break;
case 340: // maincode.mod.gml:520
scrHMTaskWithAbort(_hm);
break;
case 341: // maincode.mod.gml:525
{
if ((_hm.vars.ch_ == 0)) {
{
_hm.vars.flr_ = instance_furthest(Player.x, Player.y, Floor);
;
{ var __hm_with876 = scrHMInstances(instance_nearest((_hm.vars.flr_.x + random_range((- 112), 112)), (_hm.vars.flr_.y + random_range((- 112), 112)), Floor)), __hm_break878=false;
for (var __hm_index877=0; __hm_index877<array_length(__hm_with876); ++__hm_index877) {
if(instance_exists(__hm_with876[__hm_index877])) with (__hm_with876[__hm_index877]) {
scrHMModCall("mod", "props", "fishskull_create", (x + 16), (y + 16));
}
if(__hm_break878) break;
}}
}
}
}
_hm.pc=339;
break;
case 342: // maincode.mod.gml:524
_hm.wait_ticks=max(0,1); _hm.pc=341; return;
break;
case 343: // maincode.mod.gml:521
{
_hm.vars.ch_ = 0;
;
{ var __hm_with879 = scrHMMatching(CustomHitme, "name", "fishskull"), __hm_break881=false;
for (var __hm_index880=0; __hm_index880<array_length(__hm_with879); ++__hm_index880) {
if(instance_exists(__hm_with879[__hm_index880])) with (__hm_with879[__hm_index880]) {
_hm.vars.ch_ += 1;
}
if(__hm_break881) break;
}}
}
_hm.pc=342;
break;
case 344: // maincode.mod.gml:520
_hm.pc = ((((GameCont.subarea == 2) and (instance_number(Floor) >= 100)) and (Player.hp == Player.max_hp))) ? 343 : 339;
break;
case 345: // maincode.mod.gml:520
scrHMTaskWithEnter(_hm,scrHMInstances(GenCont),344,338);
break;
case 346: // maincode.mod.gml:483
{
if (((global.hm_module_vars[$ "mod:maincode"].venuz == 1) and instance_exists(Wall))) {
{
{ var __hm_with882 = scrHMInstances(instance_nearest(10016, 10016, Player)), __hm_break884=false;
for (var __hm_index883=0; __hm_index883<array_length(__hm_with882); ++__hm_index883) {
if(instance_exists(__hm_with882[__hm_index883])) with (__hm_with882[__hm_index883]) {
scrHMModCall("mod", "props", "VenuzCar_create", y, x, 50);
}
if(__hm_break884) break;
}}
scrHMSoundLoop(sndCarLoop);
global.hm_module_vars[$ "mod:maincode"].venuz = 0;
}
}
{ var __hm_with885 = scrHMInstances(GenCont), __hm_break887=false;
for (var __hm_index886=0; __hm_index886<array_length(__hm_with885); ++__hm_index886) {
if(instance_exists(__hm_with885[__hm_index886])) with (__hm_with885[__hm_index886]) {
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
if(__hm_break887) break;
}}
{ var __hm_with888 = scrHMInstances(Bones), __hm_break890=false;
for (var __hm_index889=0; __hm_index889<array_length(__hm_with888); ++__hm_index889) {
if(instance_exists(__hm_with888[__hm_index889])) with (__hm_with888[__hm_index889]) {
if ((!scrHMVariableExists(id, "randomchance"))) {
{
if ((random(320) < 1)) {
{
{ var __hm_with891 = scrHMInstances(Floor), __hm_break893=false;
for (var __hm_index892=0; __hm_index892<array_length(__hm_with891); ++__hm_index892) {
if(instance_exists(__hm_with891[__hm_index892])) with (__hm_with891[__hm_index892]) {
if ((random(5) < 4)) {
instance_create((x + 16), (y + 16), Cactus);
}
}
if(__hm_break893) break;
}}
}
}
{ var __hm_with894 = scrHMInstances(Floor), __hm_break896=false;
for (var __hm_index895=0; __hm_index895<array_length(__hm_with894); ++__hm_index895) {
if(instance_exists(__hm_with894[__hm_index895])) with (__hm_with894[__hm_index895]) {
if ((random(150) < 1)) {
{
instance_create(x, y, TopDecalDesert);
}
}
}
if(__hm_break896) break;
}}
randomchance = 1;
}
}
}
if(__hm_break890) break;
}}
{ var __hm_with897 = scrHMInstances(TopDecalDesert), __hm_break899=false;
for (var __hm_index898=0; __hm_index898<array_length(__hm_with897); ++__hm_index898) {
if(instance_exists(__hm_with897[__hm_index898])) with (__hm_with897[__hm_index898]) {
if ((!scrHMVariableExists(id, "why_are_you_so_far_down"))) {
{
if (place_meeting(x, (y - 16), Wall)) {
y -= 8;
}
why_are_you_so_far_down = 1;
}
}
}
if(__hm_break899) break;
}}
{ var __hm_with900 = scrHMInstances(FloorMaker), __hm_break902=false;
for (var __hm_index901=0; __hm_index901<array_length(__hm_with900); ++__hm_index901) {
if(instance_exists(__hm_with900[__hm_index901])) with (__hm_with900[__hm_index901]) {
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
if(__hm_break902) break;
}}
}
_hm.pc=345;
break;
case 347: // maincode.mod.gml:481
_hm.vars.__hm_switch1=GameCont.area;
if (_hm.vars.__hm_switch1==scrHMAreaResolve(1)) {_hm.pc=346;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("nightdesert")) {_hm.pc=320;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("scorpionboss")) {_hm.pc=317;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("sewers")) {_hm.pc=297;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve(102)) {_hm.pc=296;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("turtles")) {_hm.pc=293;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve(3)) {_hm.pc=290;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("ravenboss")) {_hm.pc=275;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("junkyard")) {_hm.pc=272;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("gatorcave")) {_hm.pc=242;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("gatorboss")) {_hm.pc=215;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("caves")) {_hm.pc=188;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("cavesinv")) {_hm.pc=185;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("city")) {_hm.pc=182;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("labs")) {_hm.pc=154;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("elevator")) {_hm.pc=136;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("HQ")) {_hm.pc=133;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve(106)) {_hm.pc=120;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("throne")) {_hm.pc=107;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("end")) {_hm.pc=75;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("venuz")) {_hm.pc=72;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("mansion")) {_hm.pc=54;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("oasis")) {_hm.pc=7;} else if (_hm.vars.__hm_switch1==scrHMAreaResolve("jungle")) {_hm.pc=4;} else {_hm.pc=1;}
break;
case 348: // maincode.mod.gml:449
{
{ var __hm_with903 = scrHMInstances(Devastator), __hm_break905=false;
for (var __hm_index904=0; __hm_index904<array_length(__hm_with903); ++__hm_index904) {
if(instance_exists(__hm_with903[__hm_index904])) with (__hm_with903[__hm_index904]) {
{
if ((damage < 500)) {
damage += 5;
}
if ((damage < 100)) {
instance_create((x + (hspeed / timescale)), (y + (vspeed / timescale)), PortalClear);
}
}
}
if(__hm_break905) break;
}}
{ var __hm_with906 = scrHMInstances(FlameBall), __hm_break908=false;
for (var __hm_index907=0; __hm_index907<array_length(__hm_with906); ++__hm_index907) {
if(instance_exists(__hm_with906[__hm_index907])) with (__hm_with906[__hm_index907]) {
{
_hm.vars.n_ = instance_nearest(x, y, hitme);
if ((((damage > 0) and place_meeting(x, y, _hm.vars.n_)) and (_hm.vars.n_.team != team))) {
{
{ var __hm_with909 = scrHMInstances(_hm.vars.n_), __hm_break911=false;
for (var __hm_index910=0; __hm_index910<array_length(__hm_with909); ++__hm_index910) {
if(instance_exists(__hm_with909[__hm_index910])) with (__hm_with909[__hm_index910]) {
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
if(__hm_break911) break;
}}
}
}
}
}
if(__hm_break908) break;
}}
{ var __hm_with912 = scrHMMatchingNE(CrownObject, "image_alpha", 1), __hm_break914=false;
for (var __hm_index913=0; __hm_index913<array_length(__hm_with912); ++__hm_index913) {
if(instance_exists(__hm_with912[__hm_index913])) with (__hm_with912[__hm_index913]) {
image_alpha = 1;
}
if(__hm_break914) break;
}}
{ var __hm_with915 = scrHMInstances(GenCont), __hm_break917=false;
for (var __hm_index916=0; __hm_index916<array_length(__hm_with915); ++__hm_index916) {
if(instance_exists(__hm_with915[__hm_index916])) with (__hm_with915[__hm_index916]) {
if ((!scrHMVariableExists(id, "settip"))) {
{
{ var __hm_with918 = scrHMInstances(Player), __hm_break920=false;
for (var __hm_index919=0; __hm_index919<array_length(__hm_with918); ++__hm_index919) {
if(instance_exists(__hm_with918[__hm_index919])) with (__hm_with918[__hm_index919]) {
if (((wep == scrHMWeaponResolve(111)) and (random(20) < 1))) {
var __hm_other921=scrHMOther(other);
__hm_other921.tip = "the SPC was a mistake";
}
}
if(__hm_break920) break;
}}
settip = 1;
}
}
}
if(__hm_break917) break;
}}
}
_hm.pc=347;
break;
case 349: // maincode.mod.gml:423
scrHMTaskWithNext(_hm);
break;
case 350: // maincode.mod.gml:423
scrHMTaskWithAbort(_hm);
break;
case 351: // maincode.mod.gml:441
{
{ var __hm_with922 = scrHMMatching(Floor, "sprite_index", sprFloor4, sprFloor104B), __hm_break924=false;
for (var __hm_index923=0; __hm_index923<array_length(__hm_with922); ++__hm_index923) {
if(instance_exists(__hm_with922[__hm_index923])) with (__hm_with922[__hm_index923]) {
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
if(__hm_break924) break;
}}
}
_hm.pc=349;
break;
case 352: // maincode.mod.gml:426
scrHMTaskWithNext(_hm);
break;
case 353: // maincode.mod.gml:426
scrHMTaskWithAbort(_hm);
break;
case 354: // maincode.mod.gml:428
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
_hm.pc=352;
break;
case 355: // maincode.mod.gml:428
_hm.pc = (scrHMTaskFork(_hm, 354)) ? 354 : 352;
break;
case 356: // maincode.mod.gml:427
_hm.pc = ((((instance_exists(_hm.other_scope) and instance_exists(_hm.scope)) and (distance_to_object(_hm.other_scope) < 32)) and (random(60) < 1))) ? 355 : 352;
break;
case 357: // maincode.mod.gml:426
scrHMTaskWithEnter(_hm,scrHMMatching(Wall, "sprite_index", sprWall4Bot),356,351);
break;
case 358: // maincode.mod.gml:424
{
if ((GameCont.area == scrHMAreaResolve("caves"))) {
GameCont.area = scrHMAreaResolve("cavesinv");
}
}
_hm.pc=357;
break;
case 359: // maincode.mod.gml:423
scrHMTaskWithEnter(_hm,scrHMMatchingGE(Player, "curse", 1),358,348);
break;
case 360: // maincode.mod.gml:422
_hm.pc = ((! (scrHMVariableExists(GameCont, "hm_cave_cleansed") && GameCont.hm_cave_cleansed))) ? 359 : 348;
break;
case 361: // maincode.mod.gml:249
{
if ((GameCont.area == scrHMAreaResolve("oasis"))) {
{ var __hm_with925 = scrHMInstances(BoneFish), __hm_break927=false;
for (var __hm_index926=0; __hm_index926<array_length(__hm_with925); ++__hm_index926) {
if(instance_exists(__hm_with925[__hm_index926])) with (__hm_with925[__hm_index926]) {
hm_arkintide_mod_gml_hm_bonefish_track();
}
if(__hm_break927) break;
}}
}
hm_arkintide_mod_gml_hm_crown_watch();
;
_hm.vars.hm_below = (GameCont.level < GameCont.hm_maxlevel1100);
;
{ var __hm_with928 = scrHMInstances(enemy), __hm_break930=false;
for (var __hm_index929=0; __hm_index929<array_length(__hm_with928); ++__hm_index929) {
if(instance_exists(__hm_with928[__hm_index929])) with (__hm_with928[__hm_index929]) {
hm_arkintide_mod_gml_hm_radiation(_hm.vars.hm_below);
}
if(__hm_break930) break;
}}
;
if (((instance_exists(Rad) && scrHMModExists("mod", "options", "rads")) && (scrHMModGet("mod", "options", "rads") == "1"))) {
hm_arkintide_mod_gml_hm_radiation_index();
}
{ var __hm_with931 = scrHMInstances(Player), __hm_break933=false;
for (var __hm_index932=0; __hm_index932<array_length(__hm_with931); ++__hm_index932) {
if(instance_exists(__hm_with931[__hm_index932])) with (__hm_with931[__hm_index932]) {
if ((!scrHMVariableExists(id, "scale"))) {
scale = 1;
}
}
if(__hm_break933) break;
}}
if ((scrHMModExists("mod", "options", "portals") and (scrHMModGet("mod", "options", "portals") == "1"))) {
{
{ var __hm_with934 = scrHMInstances(Portal), __hm_break936=false;
for (var __hm_index935=0; __hm_index935<array_length(__hm_with934); ++__hm_index935) {
if(instance_exists(__hm_with934[__hm_index935])) with (__hm_with934[__hm_index935]) {
if (((!scrHMVariableExists(id, "nompportal")) and (! instance_exists(BigPortal)))) {
{
image_alpha = 0;
{ var __hm_with937 = scrHMInstances(Player), __hm_break939=false;
for (var __hm_index938=0; __hm_index938<array_length(__hm_with937); ++__hm_index938) {
if(instance_exists(__hm_with937[__hm_index938])) with (__hm_with937[__hm_index938]) {
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
hm_arkintide_mod_gml_hm_portal_commit(_hm.vars.por);
;
_hm.vars.por.endgame -= (1 / instance_number(Player));
if ((scale > 0)) {
scale -= (0.03 * 1);
}
{ var __hm_with940 = scrHMInstances(scrHMBindDraw(hm_maincode_mod_gml_PortalShrink, (- 12))), __hm_break942=false;
for (var __hm_index941=0; __hm_index941<array_length(__hm_with940); ++__hm_index941) {
if(instance_exists(__hm_with940[__hm_index941])) with (__hm_with940[__hm_index941]) {
var __hm_other943=scrHMOther(other);
creator = __hm_other943;
}
if(__hm_break942) break;
}}
image_alpha = 0;
can_walk = 0;
if ((distance_to_point((scrHMOther(other)).x, (scrHMOther(other)).y) > 2)) {
var __hm_other944=scrHMOther(other);
direction = point_direction(x, y, __hm_other944.x, __hm_other944.y);
} else {
speed = (0) * timescale;
}
}
}
}
}
if(__hm_break939) break;
}}
{ var __hm_with945 = scrHMInstances(scrHMBindDraw(hm_maincode_mod_gml_StablePortal, (- 10))), __hm_break947=false;
for (var __hm_index946=0; __hm_index946<array_length(__hm_with945); ++__hm_index946) {
if(instance_exists(__hm_with945[__hm_index946])) with (__hm_with945[__hm_index946]) {
var __hm_other948=scrHMOther(other);
creator = __hm_other948;
}
if(__hm_break947) break;
}}
}
}
}
if(__hm_break936) break;
}}
{ var __hm_with949 = scrHMInstances(GenCont), __hm_break951=false;
for (var __hm_index950=0; __hm_index950<array_length(__hm_with949); ++__hm_index950) {
if(instance_exists(__hm_with949[__hm_index950])) with (__hm_with949[__hm_index950]) {
{ var __hm_with952 = scrHMInstances(Player), __hm_break954=false;
for (var __hm_index953=0; __hm_index953<array_length(__hm_with952); ++__hm_index953) {
if(instance_exists(__hm_with952[__hm_index953])) with (__hm_with952[__hm_index953]) {
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
if(__hm_break954) break;
}}
}
if(__hm_break951) break;
}}
}
}
{ var __hm_with955 = scrHMInstances(Player), __hm_break957=false;
for (var __hm_index956=0; __hm_index956<array_length(__hm_with955); ++__hm_index956) {
if(instance_exists(__hm_with955[__hm_index956])) with (__hm_with955[__hm_index956]) {
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
if(__hm_break957) break;
}}
if ((scrHMModExists("mod", "options", "rogue") and (scrHMModGet("mod", "options", "rogue") == "1"))) {
{
_hm.vars.rog = 0;
;
{ var __hm_with958 = scrHMMatching(Player, "race", "rogue"), __hm_break960=false;
for (var __hm_index959=0; __hm_index959<array_length(__hm_with958); ++__hm_index959) {
if(instance_exists(__hm_with958[__hm_index959])) with (__hm_with958[__hm_index959]) {
_hm.vars.rog = 1;
}
if(__hm_break960) break;
}}
if ((_hm.vars.rog == 1)) {
{
{ var __hm_with961 = scrHMInstances(RogueChest), __hm_break963=false;
for (var __hm_index962=0; __hm_index962<array_length(__hm_with961); ++__hm_index962) {
if(instance_exists(__hm_with961[__hm_index962])) with (__hm_with961[__hm_index962]) {
{
hm_arkintide_mod_gml_hm_dual_canister();
;
}
}
if(__hm_break963) break;
}}
if (instance_exists(Portal)) {
{
{ var __hm_with964 = scrHMMatching(enemy, "object_index", Grunt), __hm_break966=false;
for (var __hm_index965=0; __hm_index965<array_length(__hm_with964); ++__hm_index965) {
if(instance_exists(__hm_with964[__hm_index965])) with (__hm_with964[__hm_index965]) {
scrHMBindEndStep(hm_maincode_mod_gml_resourceful, 1, id, x, y, 12);
}
if(__hm_break966) break;
}}
{ var __hm_with967 = scrHMMatching(enemy, "object_index", Inspector, Shielder, PopoFreak), __hm_break969=false;
for (var __hm_index968=0; __hm_index968<array_length(__hm_with967); ++__hm_index968) {
if(instance_exists(__hm_with967[__hm_index968])) with (__hm_with967[__hm_index968]) {
scrHMBindEndStep(hm_maincode_mod_gml_resourceful, 1, id, x, y, 8);
}
if(__hm_break969) break;
}}
{ var __hm_with970 = scrHMMatching(enemy, "object_index", EliteGrunt, EliteInspector, EliteShielder), __hm_break972=false;
for (var __hm_index971=0; __hm_index971<array_length(__hm_with970); ++__hm_index971) {
if(instance_exists(__hm_with970[__hm_index971])) with (__hm_with970[__hm_index971]) {
scrHMBindEndStep(hm_maincode_mod_gml_resourceful, 1, id, x, y, 4);
}
if(__hm_break972) break;
}}
}
}
}
}
}
}
{ var __hm_with973 = scrHMMatching(CharSelect, "race", 1), __hm_break975=false;
for (var __hm_index974=0; __hm_index974<array_length(__hm_with973); ++__hm_index974) {
if(instance_exists(__hm_with973[__hm_index974])) with (__hm_with973[__hm_index974]) {
{
{ var __hm_with976 = scrHMInstances(TopCont), __hm_break978=false;
for (var __hm_index977=0; __hm_index977<array_length(__hm_with976); ++__hm_index977) {
if(instance_exists(__hm_with976[__hm_index977])) with (__hm_with976[__hm_index977]) {
darkness = 1;
}
if(__hm_break978) break;
}}
scrHMBindDraw(hm_maincode_mod_gml_shilling, (- 100));
scrHMBindDraw(hm_maincode_mod_gml_versionnumber, (- 1002));
{ var __hm_with979 = scrHMInstances(Campfire), __hm_break981=false;
for (var __hm_index980=0; __hm_index980<array_length(__hm_with979); ++__hm_index980) {
if(instance_exists(__hm_with979[__hm_index980])) with (__hm_with979[__hm_index980]) {
if ((random(7) < 1)) {
{ var __hm_with982 = scrHMInstances(instance_create((x + random_range((- 3), 3)), ((y + random_range((- 3), 3)) - 10), FireFly)), __hm_break984=false;
for (var __hm_index983=0; __hm_index983<array_length(__hm_with982); ++__hm_index983) {
if(instance_exists(__hm_with982[__hm_index983])) with (__hm_with982[__hm_index983]) {
{
depth = (- 4);
scrHMMotionAdd((80 + random(20)), choose(0, random(3)));
}
}
if(__hm_break984) break;
}}
}
}
if(__hm_break981) break;
}}
{ var __hm_with985 = scrHMMatching(CampChar, "num", 15, 14), __hm_break987=false;
for (var __hm_index986=0; __hm_index986<array_length(__hm_with985); ++__hm_index986) {
if(instance_exists(__hm_with985[__hm_index986])) with (__hm_with985[__hm_index986]) {
instance_destroy();
}
if(__hm_break987) break;
}}
}
}
if(__hm_break975) break;
}}
{ var __hm_with988 = scrHMInstances(GenCont), __hm_break990=false;
for (var __hm_index989=0; __hm_index989<array_length(__hm_with988); ++__hm_index989) {
if(instance_exists(__hm_with988[__hm_index989])) with (__hm_with988[__hm_index989]) {
safedist = 180;
}
if(__hm_break990) break;
}}
if (((GameCont.loops == 0) && (GameCont.area != scrHMAreaResolve("city")))) {
GameCont.novans = 1;
} else {
if ((((GameCont.area != scrHMAreaResolve("throne")) && (GameCont.area != scrHMAreaResolve("end"))) && (GameCont.area != scrHMAreaResolve("venuz")))) {
GameCont.novans = 0;
}
}
{ var __hm_with991 = scrHMInstances(CarThrow), __hm_break993=false;
for (var __hm_index992=0; __hm_index992<array_length(__hm_with991); ++__hm_index992) {
if(instance_exists(__hm_with991[__hm_index992])) with (__hm_with991[__hm_index992]) {
hitid = [sprCarThrown, "Thrown Car"];
}
if(__hm_break993) break;
}}
;
if ((instance_number(Player) > 1)) {
{ var __hm_with994 = scrHMInstances(AmmoChest), __hm_break996=false;
for (var __hm_index995=0; __hm_index995<array_length(__hm_with994); ++__hm_index995) {
if(instance_exists(__hm_with994[__hm_index995])) with (__hm_with994[__hm_index995]) {
if ((! instance_exists(SpiralCont))) {
{
scrHMModCall("mod", "props", "mpAmmoChest_create", x, y);
scrHMDelete(id);
}
}
}
if(__hm_break996) break;
}}
}
{ var __hm_with997 = scrHMInstances(AmmoChestMystery), __hm_break999=false;
for (var __hm_index998=0; __hm_index998<array_length(__hm_with997); ++__hm_index998) {
if(instance_exists(__hm_with997[__hm_index998])) with (__hm_with997[__hm_index998]) {
if ((! instance_exists(SpiralCont))) {
{
scrHMContentChange1100(AmmoChest, 1);
}
}
}
if(__hm_break999) break;
}}
{ var __hm_with1000 = scrHMMatching(ChestOpen, "sprite_index", sprAmmoChestMysteryOpen), __hm_break1002=false;
for (var __hm_index1001=0; __hm_index1001<array_length(__hm_with1000); ++__hm_index1001) {
if(instance_exists(__hm_with1000[__hm_index1001])) with (__hm_with1000[__hm_index1001]) {
instance_destroy();
}
if(__hm_break1002) break;
}}
{ var __hm_with1003 = scrHMMatchingNE(WeaponChest, "set_curse", 1), __hm_break1005=false;
for (var __hm_index1004=0; __hm_index1004<array_length(__hm_with1003); ++__hm_index1004) {
if(instance_exists(__hm_with1003[__hm_index1004])) with (__hm_with1003[__hm_index1004]) {
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
if(__hm_break1005) break;
}}
{ var __hm_with1006 = scrHMMatchingNE(BigWeaponChest, "set_curse", 1), __hm_break1008=false;
for (var __hm_index1007=0; __hm_index1007<array_length(__hm_with1006); ++__hm_index1007) {
if(instance_exists(__hm_with1006[__hm_index1007])) with (__hm_with1006[__hm_index1007]) {
if ((GameCont.crown == 1)) {
{
if ((GameCont.hard <= 16)) {
{
if (((random(((14 + 16) - GameCont.hard)) < 1) and ((GameCont.area == scrHMAreaResolve(4)) || (GameCont.area == scrHMAreaResolve(104)) || (GameCont.area == scrHMAreaResolve("caves")) || (GameCont.area == scrHMAreaResolve("cavesinv")) || (GameCont.area == scrHMAreaResolve("icecave"))))) {
{
curse = 1;
scrHMContentChange1100(CursedBigChest, 1);
}
}
}
} else {
if (((random(14) < 1) and ((GameCont.area == scrHMAreaResolve(4)) || (GameCont.area == scrHMAreaResolve(104)) || (GameCont.area == scrHMAreaResolve("caves")) || (GameCont.area == scrHMAreaResolve("cavesinv")) || (GameCont.area == scrHMAreaResolve("icecave"))))) {
{
curse = 1;
scrHMContentChange1100(CursedBigChest, 1);
}
}
}
set_curse = 1;
}
}
}
if(__hm_break1008) break;
}}
{ var __hm_with1009 = scrHMInstances(Player), __hm_break1011=false;
for (var __hm_index1010=0; __hm_index1010<array_length(__hm_with1009); ++__hm_index1010) {
if(instance_exists(__hm_with1009[__hm_index1010])) with (__hm_with1009[__hm_index1010]) {
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
if(__hm_break1011) break;
}}
}
_hm.pc=360;
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

// Source maincode.mod.gml:0; CHCoutro (native content 1.1.0)
function hm_maincode_mod_gml_CHCoutro() {
if ((! instance_exists(HyperCrystal))) {
hm_arkintide_mod_gml_hm_cave_restore(argument0, argument1);
}
instance_destroy();
;
}

// Source maincode.mod.gml:0; sewerboi (native content 1.1.0)
function hm_maincode_mod_gml_sewerboi() {
if(scrHMRatWaterDraw1100()) return;
if(!instance_exists(creator) || !(creator[$ "swimming"]??false)) return;
if ((((! instance_exists(creator)) || (! scrHMVariableExists(creator, "swimming"))) || (! creator.swimming))) {
{
scrHMMenuDrawComplete();
;
exit;
;
}
}
{ var __hm_with1 = scrHMInstances(creator), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if(!scrHMSwimSprite106()) continue;
if (hm_arkintide_mod_gml_hm_swim_sprite()) {
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
}
if(__hm_break3) break;
}}
scrHMMenuDrawComplete();
}

// Source maincode.mod.gml:0; spacesewerboi (native content 1.1.0)
function hm_maincode_mod_gml_spacesewerboi() {
if ((! instance_exists(creator))) {
{
scrHMMenuDrawComplete();
;
exit;
;
}
}
{ var __hm_with1 = scrHMInstances(creator), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if(!scrHMSwimSprite106()) continue;
if (hm_arkintide_mod_gml_hm_swim_sprite()) {
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
// Source maincode.mod.gml:0; venus_request_retry (native content 1.1.0)
function hm_maincode_mod_gml_venus_request_retry() {
if (((GameCont.area != scrHMAreaResolve("venuz")) || instance_exists(GenCont))) {
exit;
}
var _hml_pending = noone;
;
{ var __hm_with1 = scrHMMatching(CustomObject, "name", "VenuzElevator"), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if (scrHMVariableExists(id, "hm_venus_retry_subarea")) {
_hml_pending = id;
}
}
if(__hm_break3) break;
}}
if (instance_exists(_hml_pending)) {
exit;
}
var _hml_retry_stage = GameCont.subarea;
;
{ var __hm_with4 = scrHMMatching(CustomObject, "name", "VenuzElevator"), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
scrHMDelete(id);
}
if(__hm_break6) break;
}}
;
{ var __hm_with7 = scrHMInstances(instance_create((x - 16), (y - 16), CustomObject)), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
{
name = "VenuzElevator";
;
image_speed = (0) * timescale;
;
sprite_index = sprFloor103;
;
image_alpha = 0;
;
image_index = 1;
;
depth = 7;
;
activated = 1;
;
hm_venus_retry_subarea = _hml_retry_stage;
;
}
}
if(__hm_break9) break;
}}
}

// Source maincode.mod.gml:0; venus_place_players (native content 1.1.0)
function hm_maincode_mod_gml_venus_place_players() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_maincode_mod_gml_venus_place_players_resume, id, scrHMOther(other), _args, 19, []);
}
function hm_maincode_mod_gml_venus_place_players_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_maincode_mod_gml_venus_place_players");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // maincode.mod.gml:2548
scrHMTaskWithNext(_hm);
break;
case 2: // maincode.mod.gml:2548
scrHMTaskWithAbort(_hm);
break;
case 3: // maincode.mod.gml:2586
{
if ((instance_exists(id) and (ind_ > instance_number(Player)))) {
{
scrHMModCall("mod", "enemies", "prisoner_create", x, y);
;
}
}
instance_destroy();
}
_hm.pc=1;
break;
case 4: // maincode.mod.gml:2570
scrHMTaskWithNext(_hm);
break;
case 5: // maincode.mod.gml:2570
scrHMTaskWithAbort(_hm);
break;
case 6: // maincode.mod.gml:2583
{
;
}
_hm.pc=4;
break;
case 7: // maincode.mod.gml:2583
_hm.result=undefined; _hm.done=true; return;
break;
case 8: // maincode.mod.gml:2573
{
if (instance_exists(id)) {
{ var __hm_with1 = scrHMInstances(instance_nearest(x, (y - 64), enemy)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
weapondrop = 0;
hp = 1;
}
}
if(__hm_break3) break;
}}
}
wep = scrHMWeaponResolve("secretweapong1");
ammo[1] = 20;
ammo[1] -= 1;
scrHMPlayerFire(90);
}
_hm.pc=7;
break;
case 9: // maincode.mod.gml:2572
_hm.wait_ticks=max(0,1); _hm.pc=8; return;
break;
case 10: // maincode.mod.gml:2571
_hm.pc = (scrHMTaskFork(_hm, 9)) ? 9 : 4;
break;
case 11: // maincode.mod.gml:2570
scrHMTaskWithEnter(_hm,scrHMMatching(Player, "index", 0),10,3);
break;
case 12: // maincode.mod.gml:2556
{
{ var __hm_with4 = scrHMMatching(Player, "index", ind_), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
{
var __hm_other7=scrHMOther(other);
hm_maincode_mod_gml_move_player_snap(index, __hm_other7.x, __hm_other7.y);
;
speed = (0) * timescale;
;
hspeed = (0) * timescale;
;
vspeed = (0) * timescale;
;
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
if(__hm_break6) break;
}}
}
_hm.pc=11;
break;
case 13: // maincode.mod.gml:2555
_hm.pc = ((! instance_exists(GenCont))) ? 12 : 1;
break;
case 14: // maincode.mod.gml:2553
{
{ var __hm_with8 = scrHMInstances(scrHMBindDraw(hm_maincode_mod_gml_venuzfadein, (- 9))), __hm_break10=false;
for (var __hm_index9=0; __hm_index9<array_length(__hm_with8); ++__hm_index9) {
if(instance_exists(__hm_with8[__hm_index9])) with (__hm_with8[__hm_index9]) {
fade = 100;
}
if(__hm_break10) break;
}}
}
_hm.pc=13;
break;
case 15: // maincode.mod.gml:2592
{
{ var __hm_with11 = scrHMInstances(Player), __hm_break13=false;
for (var __hm_index12=0; __hm_index12<array_length(__hm_with11); ++__hm_index12) {
if(instance_exists(__hm_with11[__hm_index12])) with (__hm_with11[__hm_index12]) {
{
var __hm_other14=scrHMOther(other);
hm_maincode_mod_gml_move_player_snap(index, __hm_other14.x, __hm_other14.y);
;
speed = (0) * timescale;
;
hspeed = (0) * timescale;
;
vspeed = (0) * timescale;
;
}
}
if(__hm_break13) break;
}}
if (instance_exists(id)) {
{
instance_destroy();
}
}
}
_hm.pc=1;
break;
case 16: // maincode.mod.gml:2552
_hm.pc = ((GameCont.subarea == 1)) ? 14 : 15;
break;
case 17: // maincode.mod.gml:2548
scrHMTaskWithEnter(_hm,scrHMMatching(CustomObject, "name", "spawnpoint"),16,0);
break;
case 18: // maincode.mod.gml:2547
_hm.result=undefined; _hm.done=true; return;
break;
case 19: // maincode.mod.gml:2547
_hm.pc = (instance_exists(GenCont)) ? 18 : 17;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

// Source maincode.mod.gml:0; venus_retry_input (native content 1.1.0)
function hm_maincode_mod_gml_venus_retry_input() {
if ((GameCont.area != scrHMAreaResolve("venuz"))) {
exit;
}
var _hml_horn = scrHMButtonCheck(index, "horn");
var _hml_okay = scrHMButtonCheck(index, "okay");
;
if ((!scrHMVariableExists(id, "hm_venus_horn"))) {
hm_venus_horn = 0;
}
if ((!scrHMVariableExists(id, "hm_venus_okay"))) {
hm_venus_okay = 0;
}
var _hml_retry = ((_hml_horn && (! hm_venus_horn)) || (_hml_okay && (! hm_venus_okay)));
;
hm_venus_horn = _hml_horn;
;
hm_venus_okay = _hml_okay;
;
if (((_hml_retry && (! scrHMButtonCheck(index, "talk"))) && (! instance_exists(GenCont)))) {
hm_maincode_mod_gml_venus_request_retry();
}
}

// Source maincode.mod.gml:0; hm_swim_actor_draw (native content 1.1.0)
function hm_maincode_mod_gml_hm_swim_actor_draw() {
if (((((instance_exists(creator) && scrHMVariableExists(creator, "swimming")) && creator.swimming) && scrHMVariableExists(creator, "hm_extra_kind")) && (creator.hm_extra_kind == "rat"))) {
{
{ var __hm_with1 = scrHMInstances(creator), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
scrHMDrawSpriteExt(sprite_index, image_index, x, (y - 4), image_xscale, image_yscale, image_angle, image_blend, hm_water_alpha);
}
if(__hm_break3) break;
}}
;
exit;
;
}
}
if ((((! instance_exists(creator)) || (! scrHMVariableExists(creator, "swimming"))) || (! creator.swimming))) {
exit;
}
{ var __hm_with4 = scrHMInstances(creator), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if (hm_arkintide_mod_gml_hm_swim_sprite()) {
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
}
if(__hm_break6) break;
}}
}

