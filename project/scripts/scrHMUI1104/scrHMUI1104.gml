// Boss health UI belongs to GUI End, so walls, monsters and arena darkening
// cannot cover either the top HUD or the bars anchored above extra bosses.
function scrHMBossBarsOverlay1104() {
    if(!scrHMEnabled() || !instance_exists(GameCont) || !instance_exists(Player)) return;
    if(instance_exists(HMWorld.hm_portrait_active)) return;
    var _font=draw_get_font(),_color=draw_get_color(),_alpha=draw_get_alpha();
    var _ha=draw_get_halign(),_va=draw_get_valign();
    scrHMBossBarsLocal1104();
    scrHMBossBarsTop1104();
    draw_set_font(_font);draw_set_color(_color);draw_set_alpha(_alpha);
    draw_set_halign(_ha);draw_set_valign(_va);
}

function scrHMBossTop1104() {
    return name=="guardianboss" || hm_arkintide_mod_gml_hm_bossbar_top();
}

function scrHMBossWorldBar1104(_x,_y,_width,_title,_color,_hp,_maximum) {
    hm_hm_bossbar_mod_gml_hm_bossbar(_x-view_xview,_y-view_yview,_width,_title,_color,_hp,_maximum);
}

function scrHMGuardianLayerRestore1104() {
    if(!is_undefined(self[$ "hm_guard_depth109"])) {
        if(depth==hm_guard_set109) depth=hm_guard_depth109;
        hm_guard_depth109=undefined;
    }
}

function scrHMGuardianLayerLift1104() {
    if(depth>-9) {hm_guard_depth109=depth;depth=-9;hm_guard_set109=depth;}
}

function scrHMGuardianLayers1104() {
    if(!scrHMEnabled()) return;
    var _active=false;
    with(HMBinding) if(hm_code==scrHMScriptRef(hm_bosses_guardianboss_mod_gml_guardiandark_draw)) {_active=true;break;}
    if(!_active && !(self[$ "hm_guard_layers109"]??false)) return;
    hm_guard_layers109=_active;
    // Native bullets, burst sources, explosions, beams and plasma impacts
    // all descend from damagesource, independently of GameObject. Traverse
    // these two disjoint roots once and retain every actual native Draw event.
    with(GameObject) scrHMGuardianLayerRestore1104();
    with(damagesource) scrHMGuardianLayerRestore1104();
    if(!_active) return;
    with(GameObject) if(instance_is(id,hitme)||instance_is(id,Pickup)||instance_is(id,Effect)
        ||instance_is(id,CrystalShield)
        ||instance_is(id,CrystalShieldDisappear)||instance_is(id,PortalStrike)) scrHMGuardianLayerLift1104();
    with(damagesource) scrHMGuardianLayerLift1104();
}
