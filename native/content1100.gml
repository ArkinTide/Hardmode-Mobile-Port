// Mobile host contracts for synchronized NTT content. Gameplay runs at 30 Hz.
function scrHMContentRef1100(_kind,_module,_name) {
    var _key=scrHMModuleKey(_kind,_module);
    var _scripts=global.hm_module_scripts[$ _key];
    if(is_undefined(_scripts)) return undefined;
    return _scripts[$ _name];
}
function scrHMContentExists1100(_kind,_module,_name) {
    return !is_undefined(scrHMContentRef1100(_kind,_module,_name));
}
function scrHMContentChange1100(_object,_events) {
    instance_change(_object,_events);
    if(_object==CustomEnemy && !(self[$ "hm_custom_actor"]??false)) scrHMActorInit();
}
function scrHMContentEvent1100(_object,_event,_number) {
    // NTT's native per-tick enemy event corresponds to the host Step.
    if(_event==ev_other && _number==15) {_event=ev_step;_number=0;}
    event_perform_object(_object,_event,_number);
}
function scrHMAnimationEnd1100(_actor) {
    if(!instance_exists(_actor)||!sprite_exists(_actor.sprite_index)) return false;
    return _actor.image_speed>0 && _actor.image_index+_actor.image_speed>=sprite_get_number(_actor.sprite_index);
}
function scrHMLevelCap1100() {
    var _base=scrCustomParam("maxlevel",10);
    if(!scrHMEnabled()||!instance_exists(GameCont)) return _base;
    return variable_instance_get(GameCont,"hm_maxlevel1100")??_base;
}
function scrHMContentBegin1100() {
    if(!scrHMEnabled()||!instance_exists(GameCont)||!scrHMReadyTick()
       ||lockstep_stop||UberCont.paused||instance_exists(GenCont)) return;
    hm_arkintide_mod_gml_hm_progression();
}
function scrHMContentInit1100() {
    // Settings are initialized before the first run; platform state is not
    // stored in NTT's desktop menu module.
    if(!instance_exists(GameCont)) return;
    if(!variable_instance_exists(GameCont,"hm_maxlevel1100")) GameCont.hm_maxlevel1100=scrCustomParam("maxlevel",10);
}

function scrHMArrayFind1100(_items,_value) {
    for(var _i=0;_i<array_length(_items);++_i) if(_items[_i]==_value) return _i;
    return -1;
}
function scrHMStagger1100() {
    if(!variable_global_exists("hm_sync_serial1100")) global.hm_sync_serial1100=0;
    if(!variable_instance_exists(id,"hm_sync_serial1100")) hm_sync_serial1100=global.hm_sync_serial1100++;
    return hm_sync_serial1100 mod 6;
}
function scrHMPickupDrop1100(_supplies,_weapons) { return scrDrop(_supplies,_weapons); }
function scrHMBindStep1100(_code,_delay) {
    var _binding=scrHMBindEndStep(_code,_delay);
    _binding.hm_step1100=true;
    return _binding;
}
function scrHMToolChest1100() {
    if(GameCont.area!=scrHMAreaResolve("junkyard") || GameCont.subarea!=1) return;
    hm_tool_chest1100=true;
}
function scrHMLoopPopulationFallback1100() {
    // Active native regional callbacks already perform the stock loop roll.
    // Keep the older fallback only for custom areas without that callback.
    var _key=scrHMAreaKey(GameCont.area);
    if(array_contains(["area:nightdesert","area:scorpionboss","area:sewers",
        "area:junkyard","area:ravenboss","area:caves","area:cavesinv",
        "area:city","area:labs","area:elevator","area:palace"],_key)) return;
    scrHMVanillaLoopPopulate111();
}
function scrHMThroneGeneratorZone1100() {
    // The mobile generator budgets unique floor tiles. A native pixel offset
    // places the entire annex near the player's landing on this longer hall.
    // Build annex floors, statues and generators together in its upper third,
    // before wall construction, rather than moving the finished generators.
    if(!instance_exists(FloorMaker)) return false;
    var _budget=FloorMaker.goal,_built=instance_number(Floor);
    return _built>_budget*.65 && _built<_budget*.90;
}
function scrHMToolWeapon1100(_original) {
    if(!(self[$ "hm_tool_chest1100"]??false)) return _original;
    return GameCont.loops>0?choose(wep_screwdriver,wep_energy_screwdriver):wep_screwdriver;
}
function scrHMCrownWatch1100() {
    if(GameCont.area==scrHMAreaResolve("palace") && GameCont.subarea==4) {
        with(Portal) if(type==3) GameCont.hm_crown_return=true;
    }
    if(GameCont.area==area_vault && GameCont.lastarea==scrHMAreaResolve("palace") && GameCont.lastsubarea==4) {
        GameCont.hm_crown_return=true;
        GameCont.hm_destination107=scrHMAreaResolve("throne");GameCont.hm_destination_sub107=1;
    }
}
function scrHMPortalStyle1100(_portal) {
    if(!instance_exists(_portal)) return;
    if(_portal.close) {
        GameCont.hm_transition_idpd=_portal.type==2;
        if(_portal.type!=2) GameCont.hm_transition_seen=false;
    }
    if(GameCont.area==scrHMAreaResolve("palace") && GameCont.subarea==4 && _portal.type==3)
        GameCont.hm_crown_return=true;
}
function scrHMPortalTick1100() {
    hm_arkintide_mod_gml_hm_camp_police_clear();
    with(Portal) {
        if(type==2 && (sprite_index==sprPortal || sprite_index==sprProtoPortal)) sprite_index=sprPopoPortal;
        scrHMPortalStyle1100(id);
    }
    if(instance_exists(SpiralCont) && (variable_instance_get(GameCont,"hm_transition_idpd")??false)) {
        GameCont.hm_transition_seen=true;
        with(SpiralCont) type=SpiralType.IDPD;
        with(Spiral) if(sprite_index==sprSpiral||sprite_index==sprSpiralProto) sprite_index=sprSpiralIDPD;
    } else if(!instance_exists(SpiralCont) && !instance_exists(Portal)
        && (variable_instance_get(GameCont,"hm_transition_seen")??false)) {
        GameCont.hm_transition_idpd=false;GameCont.hm_transition_seen=false;
    }
    scrHMCrownWatch1100();
}
function scrHMVanRecheckExit1100() {
    // The host records the last combat death separately from van wreckage.
    // Re-arm that corpse after a gate closes, never move it onto the van.
    if(instance_exists(GenCont)||instance_exists(Portal)||scrHMPendingBoss()) return;
    var _blocked=false;
    with(enemy) if(hp>0 && team!=team_player && !(self[$ "hm_noncombat"]??false)) {_blocked=true;break;}
    if(_blocked) return;
    with(CustomObject) if(name=="hm_robot_gate"||name=="hm_infantry_gate") {_blocked=true;break;}
    if(_blocked) return;
    with(Corpse) if(self[$ "hm_exit_corpse"]??false) alarm[0]=1;
}
function scrHMRatWaterDraw1100() {
    if(!instance_exists(creator)||!(creator[$ "swimming"]??false)
       ||(creator[$ "hm_extra_kind"]??"")!="rat") return false;
    with(creator) scrHMDrawSpriteExt(sprite_index,image_index,x,y-4,image_xscale,image_yscale,image_angle,image_blend,hm_swim_alpha);
    return true;
}
