// NTT's CustomChest is a distinct object with empty sprite/mask defaults.
// This mobile host already uses its real WeaponChest classes and their real
// collision/destruction events. Keep them unchanged: no instance_change,
// callback replacement, draw override or duplicate native-event delegation.
function scrHMToolChest1103() {
    if(!scrHMEnabled() || !instance_exists(GameCont)) return;
    // The first two junkyard stages use native area3; the named extension
    // owns only 3-4/3-5 after area_transit. Accept its alias for old callers.
    if(!array_contains([scrHMAreaResolve(3),scrHMAreaResolve("junkyard")],GameCont.area) || GameCont.subarea!=1) return;
    if(object_index!=WeaponChest && object_index!=BigWeaponChest) return;
    if(variable_instance_exists(id,"hm_tool_chest_native1103")) return;
    hm_tool_chest_native1103=object_index;
    hm_tool_chest1100=true;
}

// Call only after the native lockstep/GenCont/scrChestOpened early returns.
// Save locals before opening destroys the chest. Roll one tool per chest,
// while the original event still rolls every native weapon and its curse.
function scrHMToolChestBegin1103() {
    scrHMToolChest1103();
    if(!(self[$ "hm_tool_chest1100"]??false)) return undefined;
    var _latest=0;
    with(WepPickup) _latest=max(_latest,id);
    var _weapon=GameCont.loops>0?choose(wep_screwdriver,wep_energy_screwdriver):wep_screwdriver;
    return {latest:_latest,weapon:_weapon};
}

// Call after all real native drops have been created, before native destroy.
// Only the newest newly created pickup changes, including a large chest or
// Steroids' extra drop. Existing pickups, other new drops, ammo, curse, RNG
// bookkeeping, native chest counters and native destruction remain intact.
function scrHMToolChestFinish1103(_state) {
    if(is_undefined(_state)) return noone;
    var _newest=noone,_latest=_state.latest;
    with(WepPickup) if(id>_latest && (!instance_exists(_newest) || id>_newest)) _newest=id;
    if(instance_exists(_newest)) with(_newest) {
        wep=_state.weapon;
        // Unlike NTT's WepPickup.wep setter, plain host assignment does not
        // update metadata. Force refresh even when the desired screwdriver
        // equals Create's cached default but the native drop was different.
        hm_pickup_weapon=-1;
        scrHMPickupRefresh();
    }
    return _newest;
}
