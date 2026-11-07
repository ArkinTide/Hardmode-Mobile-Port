// Throne phase ownership is separate from native area-number conventions.
function scrHMThroneSecond1104() {
    if(!scrHMEnabled() || !instance_exists(GameCont)
       || GameCont.area!=scrHMAreaResolve("throne")) return false;
    if(variable_instance_get(GameCont,"hm_second_started1104")??false) return true;
    var _second=instance_exists(NothingDeath) || instance_exists(Nothing2Appear) || instance_exists(Nothing2Death);
    if(!_second) with(CustomEnemy) if(spr_idle==sprNothing2Idle) {_second=true;break;}
    // The old MOD leaves an invisible native Nothing2 at (0,0); it is not a boss.
    if(!_second) with(Nothing2) if(hp>0 && image_alpha>0 && mask_index!=mskNone && mask_index!=0) {_second=true;break;}
    if(_second) GameCont.hm_second_started1104=true;
    return _second;
}

function scrHMThronePoliceClear1104() {
    if(!scrHMThroneSecond1104()) return;
    // Never run destruction callbacks while cancelling a pending arrival.
    with(WantPopo) instance_destroy(id,false);
    with(WantVan) instance_destroy(id,false);
    with(IDPDSpawn) instance_destroy(id,false);
    with(VanSpawn) instance_destroy(id,false);
    with(CustomObject) if(array_contains(["hm_infantry_gate","hm_robot_gate","3dvan"],name)) {
        if(instance_exists(self[$ "baby"]??noone)) instance_destroy(baby,false);
        instance_destroy(id,false);
    }
}

function scrHMExtraPresentation1104(_focus) {
    if(!scrHMEnabled() || !instance_exists(GameCont)) return false;
    // During constructors the actor flag has not yet been assigned. Both
    // guards are needed for normal and extra instances of the same boss.
    if(variable_instance_get(GameCont,"hm_extra_pending")??false) return true;
    return instance_exists(_focus) && (_focus[$ "hm_extra"]??false);
}
