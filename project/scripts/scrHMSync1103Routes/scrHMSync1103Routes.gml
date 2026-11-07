// Source-owned routes and original b24 Throne behavior on the mobile host.
function scrHMCrownReset1103() {
    GameCont.hm_crown_route=0;GameCont.hm_crown_return=false;
    GameCont.hm_crown_vault_seen=false;GameCont.hm_crown_exit_ready=false;
}
function scrHMCrownEntry1103() {
    if(GameCont.area!=scrHMAreaResolve("palace") || GameCont.subarea!=4) return;
    GameCont.hm_crown_route=1;GameCont.hm_crown_return=true;
}
function scrHMCrownWatch1103() {
    var _route=variable_instance_get(GameCont,"hm_crown_route")??0;
    if(_route<2 && GameCont.area==scrHMAreaResolve("palace") && GameCont.subarea==4) {
        with(Portal) if(type==3 && (self[$ "hm_destination107"]??-1)==area_vault) scrHMCrownEntry1103();
    }
    // Keep area 100 owned by the host's actual crown-vault generator. A
    // CrownPickup may restore area/subarea before the return portal commits.
    if(_route==2 && GameCont.area!=area_vault) GameCont.hm_crown_exit_ready=true;
}
function scrHMCrownDestination1103(_destination) {
    if(_destination==area_vault && (variable_instance_get(GameCont,"hm_crown_route")??0)==1) {
        GameCont.hm_crown_route=2;GameCont.hm_crown_return=true;
        GameCont.hm_crown_vault_seen=true;
    }
}
function scrHMCrownExit1103() {
    if(!scrHMEnabled() || (variable_instance_get(GameCont,"hm_crown_route")??0)!=2) return;
    GameCont.hm_crown_route=3;GameCont.hm_crown_exit_ready=true;
    GameCont.hm_destination107=scrHMAreaResolve("throne");
    GameCont.hm_destination_sub107=1;
}

function scrHMElevatorAnchor1103() {
    if(GameCont.area!=scrHMAreaResolve("elevator") || instance_exists(GenCont)) return;
    var _device=noone;
    with(CustomHitme) if(name=="elevator") {_device=id;break;}
    if(!instance_exists(_device)) return;
    with(Corpse) {do_portal=false;alarm[0]=-1;}
    with(CustomObject) if(name=="hm_techcorpse") {do_portal=false;hm_exit_delay=-1;}
    with(Portal) {
        type=2;scrHMIDPDPortalSprite1102();
        if(endgame==100) {x=_device.x;y=_device.y-16;hm_elevator_owned=true;}
        _device.hm_elevator_exit=id;
    }
}
function scrHMElevatorStep1103() {
    sprite_index=spr_idle;mask_index=mskNone;
    scrHMElevatorAnchor1103();
    if(instance_exists(SpiralCont) || instance_exists(Spiral) || instance_exists(hm_elevator_exit)) return;
    if(!hm_arkintide_mod_gml_hm_combat_clear()) {hm_elevator_wait=40;return;}
    if(--hm_elevator_wait>0) return;
    hm_elevator_exit=instance_create(x,y-16,Portal);
    with(hm_elevator_exit) {type=2;hm_elevator_owned=true;scrHMIDPDPortalSprite1102();}
}

function scrHMThroneArrivalWaiting1103() {
    return scrHMEnabled() && instance_exists(GameCont)
        && GameCont.area==scrHMAreaResolve("throne") && GameCont.loops>0
        && (variable_instance_get(GameCont,"hm_throne_gate_wait")??90)>0;
}
function scrHMThroneGateDefer1103() {
    if(!scrHMThroneArrivalWaiting1103()) return false;
    hm_throne_gate_deferred1103=true;visible=false;image_speed=0;
    for(var _i=0;_i<12;++_i) alarm[_i]=-1;
    return true;
}
function scrHMThroneGateTick1103() {
    if(GameCont.area!=scrHMAreaResolve("throne") || GameCont.loops<=0) return;
    if(!scrHMReadyTick() || instance_exists(GenCont) || !instance_exists(Player)
       || UberCont.paused || lockstep_stop || instance_exists(HMWorld.hm_portrait_active)) return;
    if((variable_instance_get(GameCont,"hm_throne_gate_frame")??-1)==HMWorld.logic_serial) return;
    GameCont.hm_throne_gate_frame=HMWorld.logic_serial;
    GameCont.hm_throne_gate_wait=max(0,(variable_instance_get(GameCont,"hm_throne_gate_wait")??90)-1);
    if(GameCont.hm_throne_gate_wait>0) return;
    with(IDPDSpawn) if(self[$ "hm_throne_gate_deferred1103"]??false) {
        hm_throne_gate_deferred1103=false;visible=true;
        event_perform_object(IDPDSpawn,ev_create,0);
    }
}

function scrHMThroneWinHeld1103() {
    return GameCont.area==scrHMAreaResolve("throne")
        && !(variable_instance_get(GameCont,"hm_followup_throne_second_dead")??false);
}
function scrHMThroneTick1103() {
scrHMThronePoliceClear1104();
}
function scrHMThroneOpenWalls1103() {
// Retired: waking the Throne must preserve walls and their collision.
}
function scrHMRouteTick1103() {
    if(!instance_exists(GameCont)) return;
    scrHMCrownWatch1103();scrHMElevatorAnchor1103();scrHMThroneGateTick1103();scrHMThroneTick1103();
}
