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
