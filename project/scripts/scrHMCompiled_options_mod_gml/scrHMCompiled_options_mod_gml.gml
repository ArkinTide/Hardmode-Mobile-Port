// Source options.mod.gml:1; __load
function hm_options_mod_gml___load() {
global.hm_module_vars[$ "mod:options"].intropan = "1";
;
global.hm_module_vars[$ "mod:options"].bossoutros = "1";
;
global.hm_module_vars[$ "mod:options"].rads = "1";
;
global.hm_module_vars[$ "mod:options"].weaponnames = "1";
;
global.hm_module_vars[$ "mod:options"].coopchests = "1";
;
global.hm_module_vars[$ "mod:options"].portals = "1";
;
global.hm_module_vars[$ "mod:options"].rogue = "1";
;
global.hm_module_vars[$ "mod:options"].flames = "1";
;
hm_options_mod_gml_basicload();
;
if ((global.hm_module_vars[$ "mod:options"].weaponnames == "1")) {
{
scrHMWeaponSetName(81, "IDPD RIFLE");
scrHMWeaponSetName(46, "SWORD");
}
} else {
{
scrHMWeaponSetName(81, "ROGUE RIFLE");
scrHMWeaponSetName(46, "CHICKEN SWORD");
}
}
#macro savefile "hardsave.txt"
}

// Source options.mod.gml:23; game_start
function hm_options_mod_gml_game_start() {
hm_options_mod_gml_basicsave();
;
}

// Source options.mod.gml:26; basicload
function hm_options_mod_gml_basicload() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_options_mod_gml_basicload_resume, id, scrHMOther(other), _args, 2, []);
}
function hm_options_mod_gml_basicload_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_options_mod_gml_basicload");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // options.mod.gml:28
{
;
if (scrHMFileExists(savefile)) {
{
_hm.vars._settings = scrHMStringLoad(savefile);
;
_hm.vars._settings = string_split(_hm.vars._settings, "*");
;
global.hm_module_vars[$ "mod:options"].intropan = _hm.vars._settings[0];
;
global.hm_module_vars[$ "mod:options"].bossoutros = _hm.vars._settings[1];
;
global.hm_module_vars[$ "mod:options"].rads = _hm.vars._settings[2];
;
global.hm_module_vars[$ "mod:options"].weaponnames = _hm.vars._settings[3];
;
global.hm_module_vars[$ "mod:options"].coopchests = _hm.vars._settings[4];
;
global.hm_module_vars[$ "mod:options"].portals = _hm.vars._settings[5];
;
global.hm_module_vars[$ "mod:options"].rogue = _hm.vars._settings[6];
;
global.hm_module_vars[$ "mod:options"].flames = _hm.vars._settings[7];
;
scrHMFileUnload(savefile);
;
}
} else {
{

}
}
}
_hm.pc=0;
break;
case 2: // options.mod.gml:28
_hm.wait_ticks=max(0,scrHMFileLoad(savefile)); _hm.pc=1; return;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}


// Source options.mod.gml:50; basicsave
function hm_options_mod_gml_basicsave() {
var _hml__str = ((((((((((((((("" + string(global.hm_module_vars[$ "mod:options"].intropan)) + "*") + string(global.hm_module_vars[$ "mod:options"].bossoutros)) + "*") + string(global.hm_module_vars[$ "mod:options"].rads)) + "*") + string(global.hm_module_vars[$ "mod:options"].weaponnames)) + "*") + string(global.hm_module_vars[$ "mod:options"].coopchests)) + "*") + string(global.hm_module_vars[$ "mod:options"].portals)) + "*") + string(global.hm_module_vars[$ "mod:options"].rogue)) + "*") + string(global.hm_module_vars[$ "mod:options"].flames));
;
scrHMStringSave(_hml__str, savefile);
;
}

// Source options.mod.gml:65; chat_command
function hm_options_mod_gml_chat_command() {
if ((argument0 == "intropan")) {
{
if ((global.hm_module_vars[$ "mod:options"].intropan == "1")) {
{
scrHMTrace("intropan disabled");
;
global.hm_module_vars[$ "mod:options"].intropan = "0";
;
}
} else {
if ((global.hm_module_vars[$ "mod:options"].intropan == "0")) {
{
scrHMTrace("intropan enabled");
;
global.hm_module_vars[$ "mod:options"].intropan = "1";
;
}
}
}
hm_options_mod_gml_basicsave();
;
var _hml__str = ((((((((((((("" + string(global.hm_module_vars[$ "mod:options"].intropan)) + "*") + string(global.hm_module_vars[$ "mod:options"].bossoutros)) + "*") + string(global.hm_module_vars[$ "mod:options"].rads)) + "*") + string(global.hm_module_vars[$ "mod:options"].weaponnames)) + "*") + string(global.hm_module_vars[$ "mod:options"].coopchests)) + "*") + string(global.hm_module_vars[$ "mod:options"].portals)) + "*") + string(global.hm_module_vars[$ "mod:options"].rogue));
;
scrHMTrace(_hml__str);
;
return true;
;
}
}
if ((argument0 == "bossoutros")) {
{
if ((global.hm_module_vars[$ "mod:options"].bossoutros == "1")) {
{
scrHMTrace("bossoutros disabled");
;
global.hm_module_vars[$ "mod:options"].bossoutros = "0";
;
}
} else {
if ((global.hm_module_vars[$ "mod:options"].bossoutros == "0")) {
{
scrHMTrace("bossoutros enabled");
;
global.hm_module_vars[$ "mod:options"].bossoutros = "1";
;
}
}
}
hm_options_mod_gml_basicsave();
;
var _hml__str = ((((((((((((("" + string(global.hm_module_vars[$ "mod:options"].intropan)) + "*") + string(global.hm_module_vars[$ "mod:options"].bossoutros)) + "*") + string(global.hm_module_vars[$ "mod:options"].rads)) + "*") + string(global.hm_module_vars[$ "mod:options"].weaponnames)) + "*") + string(global.hm_module_vars[$ "mod:options"].coopchests)) + "*") + string(global.hm_module_vars[$ "mod:options"].portals)) + "*") + string(global.hm_module_vars[$ "mod:options"].rogue));
;
scrHMTrace(_hml__str);
;
return true;
;
}
}
if ((argument0 == "rads")) {
{
if ((global.hm_module_vars[$ "mod:options"].rads == "1")) {
{
scrHMTrace("enemies will not absorb rads");
;
global.hm_module_vars[$ "mod:options"].rads = "0";
;
}
} else {
if ((global.hm_module_vars[$ "mod:options"].rads == "0")) {
{
scrHMTrace("enemies will absorb nearby rads (and drop them on death)");
;
global.hm_module_vars[$ "mod:options"].rads = "1";
;
}
}
}
hm_options_mod_gml_basicsave();
;
var _hml__str = ((((((((((((("" + string(global.hm_module_vars[$ "mod:options"].intropan)) + "*") + string(global.hm_module_vars[$ "mod:options"].bossoutros)) + "*") + string(global.hm_module_vars[$ "mod:options"].rads)) + "*") + string(global.hm_module_vars[$ "mod:options"].weaponnames)) + "*") + string(global.hm_module_vars[$ "mod:options"].coopchests)) + "*") + string(global.hm_module_vars[$ "mod:options"].portals)) + "*") + string(global.hm_module_vars[$ "mod:options"].rogue));
;
scrHMTrace(_hml__str);
;
return true;
;
}
}
if ((argument0 == "weaponnames")) {
{
if ((global.hm_module_vars[$ "mod:options"].weaponnames == "1")) {
{
scrHMTrace("mutant weapon names restored (ie: CHICKEN SWORD)");
;
scrHMWeaponSetName(81, "ROGUE RIFLE");
scrHMWeaponSetName(46, "CHICKEN SWORD");
global.hm_module_vars[$ "mod:options"].weaponnames = "0";
;
}
} else {
if ((global.hm_module_vars[$ "mod:options"].weaponnames == "0")) {
{
scrHMTrace("some weapons are renamed (ie: CHICKEN SWORD is SWORD)");
;
scrHMWeaponSetName(81, "IDPD RIFLE");
scrHMWeaponSetName(46, "SWORD");
global.hm_module_vars[$ "mod:options"].weaponnames = "1";
;
}
}
}
scrHMTrace(global.hm_module_vars[$ "mod:options"].weaponnames);
hm_options_mod_gml_basicsave();
;
var _hml__str = ((((((((((((("" + string(global.hm_module_vars[$ "mod:options"].intropan)) + "*") + string(global.hm_module_vars[$ "mod:options"].bossoutros)) + "*") + string(global.hm_module_vars[$ "mod:options"].rads)) + "*") + string(global.hm_module_vars[$ "mod:options"].weaponnames)) + "*") + string(global.hm_module_vars[$ "mod:options"].coopchests)) + "*") + string(global.hm_module_vars[$ "mod:options"].portals)) + "*") + string(global.hm_module_vars[$ "mod:options"].rogue));
;
scrHMTrace(_hml__str);
;
return true;
;
}
}
if ((argument0 == "coopchests")) {
{
if ((global.hm_module_vars[$ "mod:options"].coopchests == "1")) {
{
scrHMTrace("ammo chests will only spawn ammo for one player");
;
global.hm_module_vars[$ "mod:options"].coopchests = "0";
;
}
} else {
if ((global.hm_module_vars[$ "mod:options"].coopchests == "0")) {
{
scrHMTrace("ammo chests will spawn extra ammo for other players");
;
global.hm_module_vars[$ "mod:options"].coopchests = "1";
;
}
}
}
hm_options_mod_gml_basicsave();
;
var _hml__str = ((((((((((((("" + string(global.hm_module_vars[$ "mod:options"].intropan)) + "*") + string(global.hm_module_vars[$ "mod:options"].bossoutros)) + "*") + string(global.hm_module_vars[$ "mod:options"].rads)) + "*") + string(global.hm_module_vars[$ "mod:options"].weaponnames)) + "*") + string(global.hm_module_vars[$ "mod:options"].coopchests)) + "*") + string(global.hm_module_vars[$ "mod:options"].portals)) + "*") + string(global.hm_module_vars[$ "mod:options"].rogue));
;
scrHMTrace(_hml__str);
;
return true;
;
}
}
if ((argument0 == "portals")) {
{
if ((global.hm_module_vars[$ "mod:options"].portals == "1")) {
{
scrHMTrace("disable new portal effects");
;
global.hm_module_vars[$ "mod:options"].portals = "0";
;
}
} else {
if ((global.hm_module_vars[$ "mod:options"].portals == "0")) {
{
scrHMTrace("fancy portals, waits for all alive players in Co op");
;
global.hm_module_vars[$ "mod:options"].portals = "1";
;
}
}
}
hm_options_mod_gml_basicsave();
;
var _hml__str = ((((((((((((("" + string(global.hm_module_vars[$ "mod:options"].intropan)) + "*") + string(global.hm_module_vars[$ "mod:options"].bossoutros)) + "*") + string(global.hm_module_vars[$ "mod:options"].rads)) + "*") + string(global.hm_module_vars[$ "mod:options"].weaponnames)) + "*") + string(global.hm_module_vars[$ "mod:options"].coopchests)) + "*") + string(global.hm_module_vars[$ "mod:options"].portals)) + "*") + string(global.hm_module_vars[$ "mod:options"].rogue));
;
scrHMTrace(_hml__str);
;
return true;
;
}
}
if ((argument0 == "rogue")) {
{
if ((global.hm_module_vars[$ "mod:options"].rogue == "1")) {
{
scrHMTrace("rogue will find strike canisters, idpd will not drop strike ammo, less rads");
;
global.hm_module_vars[$ "mod:options"].rogue = "0";
;
}
} else {
if ((global.hm_module_vars[$ "mod:options"].rogue == "0")) {
{
scrHMTrace("rogue will find rad canisters, idpd spawned after portal can drop strike ammo");
;
global.hm_module_vars[$ "mod:options"].rogue = "1";
;
}
}
}
hm_options_mod_gml_basicsave();
;
var _hml__str = ((((((((((((("" + string(global.hm_module_vars[$ "mod:options"].intropan)) + "*") + string(global.hm_module_vars[$ "mod:options"].bossoutros)) + "*") + string(global.hm_module_vars[$ "mod:options"].rads)) + "*") + string(global.hm_module_vars[$ "mod:options"].weaponnames)) + "*") + string(global.hm_module_vars[$ "mod:options"].coopchests)) + "*") + string(global.hm_module_vars[$ "mod:options"].portals)) + "*") + string(global.hm_module_vars[$ "mod:options"].rogue));
;
scrHMTrace(_hml__str);
;
return true;
;
}
}
if ((argument0 == "flames")) {
{
if ((global.hm_module_vars[$ "mod:options"].flames == "1")) {
{
scrHMTrace("original nt flames");
;
global.hm_module_vars[$ "mod:options"].flames = "0";
;
}
} else {
if ((global.hm_module_vars[$ "mod:options"].flames == "0")) {
{
scrHMTrace("recoded flames, can lag a bit with the dragon, there are a lot of projectiles");
;
global.hm_module_vars[$ "mod:options"].flames = "1";
;
}
}
}
hm_options_mod_gml_basicsave();
;
var _hml__str = ((((((((((((((("" + string(global.hm_module_vars[$ "mod:options"].intropan)) + "*") + string(global.hm_module_vars[$ "mod:options"].bossoutros)) + "*") + string(global.hm_module_vars[$ "mod:options"].rads)) + "*") + string(global.hm_module_vars[$ "mod:options"].weaponnames)) + "*") + string(global.hm_module_vars[$ "mod:options"].coopchests)) + "*") + string(global.hm_module_vars[$ "mod:options"].portals)) + "*") + string(global.hm_module_vars[$ "mod:options"].rogue)) + "*") + string(global.hm_module_vars[$ "mod:options"].flames));
;
scrHMTrace(_hml__str);
;
return true;
;
}
}
if ((argument0 == "options")) {
{
scrHMTrace(("options:" + global.hm_module_vars[$ "mod:options"].intropan), global.hm_module_vars[$ "mod:options"].bossoutros, global.hm_module_vars[$ "mod:options"].rads, global.hm_module_vars[$ "mod:options"].weaponnames, global.hm_module_vars[$ "mod:options"].coopchests, global.hm_module_vars[$ "mod:options"].portals, global.hm_module_vars[$ "mod:options"].rogue, (global.hm_module_vars[$ "mod:options"].flames + "\n\t\t---this mod has a save file and will remember options---\n\t\t/intropan -freezes the game and pans to bosses\n\t\t/bossoutros -pauses and pans on boss death\n\t\t/rads -enemies absorb rads(drop when they are killed)\n\t\t/weaponnames -some weapons are renamed(chicken sword = sword)\n\t\t/coopchests -ammo for all players in co-op\n\t\t/portals -fancy portals, waits for all alive players in Co op\n\t\t/rogue -rogue will find rad canisters, idpd can drop strike ammo\n\t\t/flames -recoded flame projectiles, adds a afterburn and lets other damage sources hurt them"));
;
return true;
;
}
}
}
