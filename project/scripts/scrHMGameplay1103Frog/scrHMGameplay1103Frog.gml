// Real native object/collision checks. Dispatch sync113frog in the sewer
// area at both 30 and 60 fps; no injected CustomEnemy replacement is used.
function scrHMGameplayFrogToxicCollision1103(_frog) {
    var _gas=instance_create(_frog.x,_frog.y,ToxicGas);
    with(_gas) with(_frog) event_perform_object(Exploder,ev_collision,ToxicGas);
    if(instance_exists(_gas)) instance_destroy(_gas,false);
}

function scrHMGameplayFrog1103() {
    if(mode!="sync113frog" || ticks!=20) return;
    var _area=GameCont.area;
    GameCont.area=scrHMAreaResolve("sewers");
    var _fixture=scrHMGameplayWaterFixture1103(false,0);
    with(enemy) instance_destroy(id,false);
    player.x=16016;player.y=16016;
    var _frog=instance_create(16048,16016,Exploder);
    var _hp=_frog.hp,_max=_frog.max_hp,_hit=_frog.hitid;
    var _idle=_frog.spr_idle,_walk=_frog.spr_walk,_hurt=_frog.spr_hurt,_dead=_frog.spr_dead;
    var _alarm=_frog.alarm[1],_drop=_frog.raddrop;
    _frog.swimming=false;
    with(_frog) scrHMGameplayCheck(scrHMFrogWaterConversionBlocked1103(),
        "actual sewer feet block transformation before the cached swimming flag is set");
    scrHMSewerTick1103();
    scrHMGameplayCheck(_frog.swimming && _frog.image_alpha==0 && _frog.canfly,
        "ordinary frog still enters the original clipped swimming presentation");
    var _bindings=0;with(HMBinding) if(creator==_frog) _bindings++;
    scrHMGameplayCheck(_bindings==1,"ordinary frog retains the production sewer draw binding");
    random_set_seed(731103);var _next=random(1000000);random_set_seed(731103);
    // Create consumes random numbers; execute the real collision against
    // one already-created cloud when proving the early-return RNG guard.
    var _gas=instance_create(_frog.x,_frog.y,ToxicGas);
    random_set_seed(731103);
    repeat(3) with(_gas) with(_frog) event_perform_object(Exploder,ev_collision,ToxicGas);
    scrHMGameplayCheck(random(1000000)==_next,"blocked water conversion does not consume native transformation RNG");
    instance_destroy(_gas,false);
    scrHMGameplayCheck(instance_exists(_frog) && _frog.object_index==Exploder && instance_number(SuperFrog)==0,
        "repeated real ToxicGas collisions retain the ordinary native frog instead of creating poison frogs");
    scrHMGameplayCheck(_frog.hp==_hp && _frog.max_hp==_max && _frog.hitid==_hit && _frog.raddrop==_drop,
        "blocked transformation preserves health damage identity and drops");
    scrHMGameplayCheck(_frog.spr_idle==_idle && _frog.spr_walk==_walk && _frog.spr_hurt==_hurt && _frog.spr_dead==_dead && _frog.alarm[1]==_alarm,
        "ordinary frog keeps its native AI sprites and scheduled movement alarm");
    with(player) scrHMGameplayCheck(!scrHMFrogWaterConversionBlocked1103(),
        "the playable character is never handled as an ordinary enemy frog");
    with(_frog) {
        event_perform_object(Exploder,ev_alarm,1);
        scrHMGameplayCheck(alarm[1]>=30 && alarm[1]<50 && object_index==Exploder,
            "the retained native frog still executes its ordinary movement alarm");
    }
    // Stale water state cannot suppress the unmodified dry-bank mechanic.
    _frog.x=16176;_frog.y=16016;_frog.swimming=true;
    with(_frog) scrHMGameplayCheck(!scrHMFrogWaterConversionBlocked1103(),
        "dry bank uses physical feet even when the previous swimming flag is true");
    scrHMGameplayFrogToxicCollision1103(_frog);
    scrHMGameplayCheck(!instance_exists(_frog) && instance_number(SuperFrog)==1,
        "dry-bank native ToxicGas collision still creates exactly one poison frog");
    with(SuperFrog) instance_destroy(id,false);
    with(ToxicGas) instance_destroy(id,false);
    // A naturally created poison frog keeps its normal class, gas emission
    // and ToxicGas healing event; the new guard is specific to Exploder.
    var _poison=instance_create(16080,16016,SuperFrog);
    scrHMGameplayCheck(_poison.object_index==SuperFrog && _poison.spr_idle==sprSuperFrogIdle && instance_number(ToxicGas)==10,
        "natural poison frogs retain their native identity sprites and gas creation");
    var _poison_max=_poison.max_hp;_poison.hp=_poison_max-1;
    with(_poison) {
        scrHMGameplayCheck(!scrHMFrogWaterConversionBlocked1103(),"natural poison frog never enters the ordinary-frog guard");
        event_perform_object(SuperFrog,ev_collision,ToxicGas);
    }
    scrHMGameplayCheck(_poison.hp==_poison_max,"natural poison frog retains its native gas healing");
    with(SuperFrog) instance_destroy(id,false);with(ToxicGas) instance_destroy(id,false);
    var _outside=instance_create(16048,16016,Exploder);
    GameCont.area=area_desert;
    with(_outside) scrHMGameplayCheck(!scrHMFrogWaterConversionBlocked1103(),"other areas retain their native poison conversion rule");
    scrHMGameplayFrogToxicCollision1103(_outside);
    scrHMGameplayCheck(!instance_exists(_outside) && instance_number(SuperFrog)==1,"native conversion remains active outside sewer levels");
    with(SuperFrog) instance_destroy(id,false);with(ToxicGas) instance_destroy(id,false);
    GameCont.area=scrHMAreaResolve("sewers");
    var _disabled=instance_create(16048,16016,Exploder);
    var _enabled=global.hm_enabled;global.hm_enabled=false;
    scrHMGameplayFrogToxicCollision1103(_disabled);
    global.hm_enabled=_enabled;
    scrHMGameplayCheck(!instance_exists(_disabled) && instance_number(SuperFrog)==1,"disabled Hardmode leaves the host conversion unchanged");
    GameCont.area=_area;
    show_debug_message("SYNC113 FROG WATER COLLISION COMPLETE");
}
