// Followup 1.1.5 rules kept outside historical content generators.
function scrHMFinalBossNoRadiation1115() {
    if(!scrHMEnabled()) return false;
    if(object_index==Last) return true;
    return array_contains(["hm_chief","GunGod","gungod","hm_gungod_landing","hm_yv_phase"],self[$ "name"]??"");
}

function scrHMReplacementGunGodHealth1115() {
    if(self[$ "hm_replacement_health1115"]??false) return;
    hm_replacement_health1115=true;
    // Only the damageable helicopter budget grows. The 14250 sentinel is
    // consumed by the handoff, and must never acquire a health multiplier.
    max_hp=14250+(max_hp-14250)*1.5;
    hp=14250+(hp-14250)*1.5;
}

// The helicopter has not died: retire its presentation ledger before its
// harmless departure actor is created. Loop0 phase two reuses "gungod", so
// remove the finished phase ledger and let the real combat actor register anew.
function scrHMGunGodHandoff1117(_actor) {
    if(!instance_exists(_actor) || (_actor[$ "hm_extra"]??false)
        || !instance_exists(HMWorld)) return;
    var _kind=scrHMBossGroupKind115(_actor);
    if(_kind=="") return;
    var _groups=scrHMBossGroups115(),_group=_groups[$ _kind];
    scrHMBossGroupRetire115(_actor);
    if(!is_undefined(_group)) _group.phase_transition1117=true;
    if(variable_struct_exists(_groups,_kind)) variable_struct_remove(_groups,_kind);
}
