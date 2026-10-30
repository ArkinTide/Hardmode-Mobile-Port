// Hardmode b24: maincode.mod.gml, lines 237-253.
// Port policy: only apply the b24 reduction while below the actual level cap.
// Run after creation scripts have finished assigning raddrop, and before death
// drops. Store a signed adjustment rather than a snapshot: enemies can consume
// or absorb radiation during their lifetime.
function scrHMRadiationBelowMaximum() {
    if (!instance_exists(GameCont)) return false;
    var _maximum = PLAYER_LEVEL_MAX;
    return _maximum > 0 && GameCont.level < _maximum;
}

// Execute in the enemy's scope. The caller computes the cap once per world pass.
function scrHMRadiationSync(_below_maximum) {
    scrHMBoneFishRadiation109(_below_maximum);
    if(object_index==FastRat) {
        // FastRat's vanilla drop is 0; Rat's is 4. Keep this independent
        // signed delta so radiation absorbed during play is never reset.
        var _bonus=_below_maximum?0:4;
        raddrop+=_bonus-(self[$ "hm_greenrat_bonus107"]??0);
        hm_greenrat_bonus107=_bonus;
    }
    if (!variable_instance_exists(id, "hm_rad_reduced")) {
        hm_rad_reduced = false;
        hm_rad_adjustment = 0;
    }

    if (_below_maximum) {
        if (hm_rad_reduced) {scrHMRadiationRequests109(_below_maximum);return;}
        var _unmodified = raddrop;
        // b24 explicitly exempts radiation maggots from the ordinary -4 rule.
        if (object_index == RadMaggot || object_is_ancestor(object_index, RadMaggot)) {
            raddrop = 1;
        }
        else {
            // Preserve the original <=4 branch, including nonpositive drops.
            raddrop = (_unmodified <= 4) ? 0 : _unmodified - 4;
        }
        hm_rad_adjustment = _unmodified - raddrop;
        hm_rad_reduced = true;
    }
    else if (hm_rad_reduced) {
        raddrop += hm_rad_adjustment;
        hm_rad_adjustment = 0;
        hm_rad_reduced = false;
    }
    scrHMRadiationRequests109(_below_maximum);
}

function scrHMRadiationSyncWorld() {
    if (!instance_exists(GameCont)) return;
    var _below_maximum = scrHMRadiationBelowMaximum();
    with (enemy) scrHMRadiationSync(_below_maximum);
}
