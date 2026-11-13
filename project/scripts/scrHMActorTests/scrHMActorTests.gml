function scrHMActorTestCheck(_condition,_message) {
    assert(_condition,"Hardmode actor: "+_message);global.hm_actor_checks++;
}
function scrHMActorTestStep() { visits++; }
function scrHMActorTestHurt(_amount,_knockback,_direction) {
    hp-=_amount/2;hurt_source=hm_last_hitid;
    hurt_knockback=_knockback;hurt_direction=_direction;
    scrHMMotionAdd(_direction,_knockback);
    global.hm_actor_hurts++;
}
function scrHMActorTestDeath() { global.hm_actor_order+="death;"; }
function scrHMActorTestDestroy() { global.hm_actor_order+="destroy;"; }
function scrHMActorTestCleanup() { global.hm_actor_order+="cleanup;"; }
function scrHMActorTestWall() { global.hm_actor_walls++;speed=0; }
function scrHMActorTestHit() { global.hm_actor_hits++;observed_other=other.id; }

function scrHMActorTestConvertedSchema(_actor,_label) {
    var _fields=["hm_custom_actor","hm_cleaned","can_die","name","z",
        "on_step","on_begin_step","on_end_step","on_destroy","on_cleanup",
        "on_draw","on_hurt","on_death","on_wall","on_hit"];
    for(var _i=0;_i<array_length(_fields);++_i)
        scrHMActorTestCheck(variable_instance_exists(_actor,_fields[_i]),_label+" initializes "+_fields[_i]);
    scrHMActorTestCheck(_actor.hm_custom_actor&&!_actor.hm_cleaned&&_actor.can_die&&_actor.z==0,
        _label+" initializes common lifecycle values without replaying native Create");
}

function scrHMActorTestConversions() {
    var _targets=[CustomObject,CustomEnemy,CustomHitme,CustomProjectile];
    var _callbacks=["on_step","on_begin_step","on_end_step","on_destroy","on_cleanup",
        "on_draw","on_hurt","on_death","on_wall","on_hit"];
    for(var _i=0;_i<array_length(_targets);++_i) {
        var _target=_targets[_i],_label=object_get_name(_target)+" native conversion";
        // An event-free native probe prevents inherited Create/Destroy from
        // supplying the common schema or changing HP behind the regression.
        var _probe=instance_create(157,241,HMTestProbe),_probe_id=_probe.id;
        _probe.hp=37;_probe.max_hp=73;_probe.hm_native_sentinel=940+_i;
        _probe.sprite_index=sprBanditIdle;_probe.mask_index=sprBanditIdle;
        _probe.image_index=.25;_probe.image_speed=.25*timescale;
        _probe.image_xscale=1.5;_probe.image_yscale=.75;_probe.image_angle=47;
        _probe.image_alpha=.6;_probe.image_blend=c_lime;_probe.visible=false;_probe.depth=-123;
        scrHMActorTestCheck(!variable_instance_exists(_probe,"hm_custom_actor"),_label+" starts outside Custom lifecycle");
        with(_probe) hm_arkintide_mod_gml_hm_extra_change(_target);
        scrHMActorTestCheck(_probe.object_index==_target&&_probe.id==_probe_id&&_probe.x==157&&_probe.y==241,
            _label+" preserves native identity and position");
        scrHMActorTestCheck(_probe.hp==37&&_probe.max_hp==73&&_probe.hm_native_sentinel==940+_i,
            _label+" preserves native health and instance fields");
        scrHMActorTestCheck(_probe.sprite_index==sprBanditIdle&&_probe.mask_index==sprBanditIdle
            &&abs(_probe.image_index-.25)<.0001&&abs(_probe.image_speed-.25*timescale)<.0001
            &&_probe.image_xscale==1.5&&_probe.image_yscale==.75&&_probe.image_angle==47
            &&abs(_probe.image_alpha-.6)<.0001&&_probe.image_blend==c_lime&&!_probe.visible&&_probe.depth==-123,
            _label+" preserves the actual extra-change rendering contract");
        scrHMActorTestConvertedSchema(_probe,_label);
        scrHMActorTestCheck(_probe.name=="",_label+" initializes the common name");
        for(var _f=0;_f<array_length(_callbacks);++_f)
            scrHMActorTestCheck(is_undefined(variable_instance_get(_probe,_callbacks[_f])),
                _label+" initializes callback "+_callbacks[_f]);

        // A second conversion must retain already initialized lifecycle state.
        _probe.name="conversion-sentinel";_probe.z=17;_probe.can_die=false;
        for(var _f=0;_f<array_length(_callbacks);++_f)
            variable_instance_set(_probe,_callbacks[_f],scrHMActorTestStep);
        _probe.on_cleanup=scrHMActorTestCleanup;_probe.on_destroy=scrHMActorTestDestroy;
        var _next_target=_targets[(_i+1) mod array_length(_targets)];
        with(_probe) hm_arkintide_mod_gml_hm_extra_change(_next_target);
        scrHMActorTestCheck(_probe.object_index==_next_target&&_probe.hm_custom_actor&&!_probe.hm_cleaned
            &&!_probe.can_die&&_probe.name=="conversion-sentinel"&&_probe.z==17,
            _label+" initializes exactly once across a Custom-to-Custom change");
        scrHMActorTestCheck(_probe.hp==37&&_probe.max_hp==73&&_probe.hm_native_sentinel==940+_i,
            _label+" does not replay target Create during a later change");
        for(var _f=0;_f<array_length(_callbacks);++_f) {
            var _expected=scrHMActorTestStep;
            if(_callbacks[_f]=="on_cleanup") _expected=scrHMActorTestCleanup;
            if(_callbacks[_f]=="on_destroy") _expected=scrHMActorTestDestroy;
            scrHMActorTestCheck(scrHMScriptRef(variable_instance_get(_probe,_callbacks[_f]))==scrHMScriptRef(_expected),
                _label+" preserves callback "+_callbacks[_f]+" during a later change");
        }
        global.hm_actor_order="";
        with(_probe) {event_perform(ev_other,5);event_perform(ev_other,5);}
        scrHMActorTestCheck(_probe.hm_cleaned&&global.hm_actor_order=="cleanup;",
            _label+" repeated Room End calls cleanup exactly once");
        with(_probe) hm_arkintide_mod_gml_hm_extra_change(_target);
        scrHMActorTestCheck(_probe.object_index==_target&&_probe.hm_cleaned&&!_probe.can_die
            &&_probe.name=="conversion-sentinel"&&_probe.z==17,
            _label+" preserves completed cleanup across another Custom change");
        with(_probe) event_perform(ev_other,5);
        scrHMActorTestCheck(global.hm_actor_order=="cleanup;",_label+" changing a cleaned actor never reruns cleanup");
        // Probe lacks the inherited native enemy/projectile destruction fields.
        // Silent deletion deliberately avoids that unrelated inherited path.
        scrHMDelete(_probe);
        scrHMActorTestCheck(!instance_exists(_probe)&&global.hm_actor_order=="cleanup;",
            _label+" silent teardown does not run destruction or cleanup again");
    }
}

function scrHMActorTestInfantryCapture() {
    var _old_enabled=scrHMEnabled(),_old_area=GameCont.area,_old_sub=GameCont.subarea;
    var _old_loops=GameCont.loops,_old_popolevel=GameCont.popolevel;
    var _test_area=scrHMAreaResolve("sewers"),_throne_area=scrHMAreaResolve("throne");
    scrHMActorTestCheck(!instance_exists(Player)&&instance_number(IDPDSpawn)==0,
        "native infantry capture fixture has no player placement loop or unrelated gates");
    // Arrival weights are exercised by sync115idpdgate. Capture must retain
    // native animation and alarm ownership without stepping these fixtures.
    global.hm_enabled=true;GameCont.area=_test_area;GameCont.subarea=2;GameCont.loops=3;
    scrHMActorTestCheck(_test_area!=_throne_area&&scrHMAreaKey(_test_area)=="area:sewers"
        &&scrHMAreaKey(_throne_area)=="area:throne",
        "native infantry capture uses distinct real sewer and Throne identities");
    scrHMActorTestCheck(scrHMEnabled()&&!scrHMThroneArrivalWaiting1103()&&GameCont.loops==3,
        "native infantry capture has active Hardmode and no production Throne defer guard");
    scrHMActorTestCheck(!is_undefined(scrHMContentRef1100("mod","arkintide","hm_infantry_step"))
        &&!is_undefined(scrHMContentRef1100("mod","arkintide","hm_infantry_draw")),
        "native infantry capture has real registered callback references");
    for(var _case=0;_case<5;++_case) {
        var _label="native infantry capture case "+string(_case);
        var _gate=instance_create(197,263,IDPDSpawn),_gate_id=_gate.id;
        scrHMActorTestCheck(instance_exists(_gate)&&_gate.object_index==IDPDSpawn,
            _label+" creates the actual native gate");
        scrHMActorTestCheck(GameCont.area==_test_area&&GameCont.loops==3&&!scrHMThroneArrivalWaiting1103()
            &&!(variable_instance_get(_gate,"hm_throne_gate_deferred1103")??false),
            _label+" native creation preserves the production capture preconditions");
        var _native_gates=scrHMInstances(IDPDSpawn);
        scrHMActorTestCheck(array_contains(_native_gates,_gate_id),
            _label+" is visible to the native-instance query");
        _gate.sprite_index=sprBanditIdle;_gate.image_index=.25;_gate.image_speed=.25*timescale;
        _gate.image_angle=47;_gate.alarm[0]=17;_gate.alarm[1]=-1;
        _gate.hp=37;_gate.max_hp=73;_gate.hm_native_sentinel=960+_case;
        if(_case==1) _gate.sprite_index=sprIDPDPortalStart;
        else if(_case==2) {_gate.sprite_index=sprIDPDPortalClose;_gate.alarm[1]=23;}
        else if(_case==3) _gate.sprite_index=sprIDPDPortalClose;
        var _native_sprite=_gate.sprite_index,_native_alarm1=_gate.alarm[1];
        var _native_visible=_gate.visible,_native_depth=_gate.depth;
        hm_arkintide_mod_gml_hm_infantry_capture();
        scrHMActorTestCheck(_gate.object_index==IDPDSpawn&&_gate.object_index!=CustomObject&&_gate.id==_gate_id
            &&_gate.x==197&&_gate.y==263&&instance_number(IDPDSpawn)==1
            &&array_contains(scrHMInstances(IDPDSpawn),_gate_id),
            _label+" retains the same native instance instead of converting to CustomObject");
        scrHMActorTestCheck(_gate.sprite_index==_native_sprite&&abs(_gate.image_index-.25)<.0001
            &&abs(_gate.image_speed-.25*timescale)<.0001&&_gate.image_angle==47
            &&_gate.visible==_native_visible&&_gate.depth==_native_depth
            &&_gate.alarm[0]==17&&_gate.alarm[1]==_native_alarm1,
            _label+" preserves native animation, orientation, renderer and remaining alarm times");
        scrHMActorTestCheck(_gate.hp==37&&_gate.max_hp==73&&_gate.hm_native_sentinel==960+_case,
            _label+" does not reset native health or unrelated instance fields");
        var _custom_fields=["hm_custom_actor","hm_cleaned","hm_phase","hm_wait","hm_spawned",
            "on_step","on_draw","on_begin_step","on_end_step","on_destroy","on_cleanup",
            "on_hurt","on_death","on_wall","on_hit"];
        for(var _f=0;_f<array_length(_custom_fields);++_f)
            scrHMActorTestCheck(!variable_instance_exists(_gate,_custom_fields[_f]),
                _label+" does not install Custom lifecycle field "+_custom_fields[_f]);
        hm_arkintide_mod_gml_hm_infantry_capture();
        scrHMActorTestCheck(_gate.object_index==IDPDSpawn&&_gate.id==_gate_id
            &&_gate.sprite_index==_native_sprite&&abs(_gate.image_index-.25)<.0001
            &&abs(_gate.image_speed-.25*timescale)<.0001
            &&_gate.alarm[0]==17&&_gate.alarm[1]==_native_alarm1
            &&!variable_instance_exists(_gate,"hm_custom_actor"),
            _label+" repeated capture preserves native ownership and timing");
        global.hm_actor_order="";
        if(_case<4) {
            with(_gate) {event_perform(ev_other,5);event_perform(ev_other,5);}
            scrHMActorTestCheck(instance_exists(_gate)&&_gate.object_index==IDPDSpawn
                &&!variable_instance_exists(_gate,"hm_custom_actor")&&global.hm_actor_order=="",
                _label+" immediate Room End never enters the Custom cleanup lifecycle");
        }
        with(_gate) instance_destroy();
        scrHMActorTestCheck(!instance_exists(_gate)&&instance_number(IDPDSpawn)==0&&global.hm_actor_order=="",
            _label+" native teardown leaves no gate or Custom callbacks");
    }
    global.hm_enabled=_old_enabled;GameCont.area=_old_area;GameCont.subarea=_old_sub;
    GameCont.loops=_old_loops;GameCont.popolevel=_old_popolevel;
}

function scrHMActorsTests() {
    if(os_type!=os_windows) return false;
    var _enabled=false;
    for(var _i=1;_i<=parameter_count();++_i) if(parameter_string(_i)=="--hardmode-actors-tests") _enabled=true;
    if(!_enabled) return false;
    scrHMRuntimeInit();
    UberCont.dont_save=true;UberCont.opt_freeze=0;
    if(!instance_exists(GameCont)) instance_create(0,0,GameCont);
    global.hm_actor_checks=0;
    for(var _rate=30;_rate<=60;_rate+=30) {
        game_set_speed(_rate,gamespeed_fps);global.time_scale=30/_rate;
        global.hm_actor_order="";global.hm_actor_hurts=0;global.hm_actor_walls=0;global.hm_actor_hits=0;
        var _old_loops=GameCont.loops;
        GameCont.loops=20;
        var _health=instance_create(0,0,CustomEnemy);
        scrHMActorTestCheck(_health.hp==1&&_health.max_hp==1&&_health.hm_maxhealth_init,"custom enemy starts with pending legacy initialization");
        with(_health) hm_tests_compiler_fixture_gml_legacy_health_first();
        scrHMActorTestCheck(_health.hp==200&&_health.max_hp==200&&!_health.hm_maxhealth_init,"first emitted maximum write initializes loop-scaled health");
        _health.hp=150;
        with(_health) hm_tests_compiler_fixture_gml_legacy_health_later();
        scrHMActorTestCheck(_health.hp==150&&_health.max_hp==500,"compound maximum writes do not reapply scaling or heal");
        with(_health) visits=hm_tests_compiler_fixture_gml_legacy_health_local();
        scrHMActorTestCheck(_health.visits==7&&_health.max_hp==500,"local maxhealth is not an actor setter");
        scrHMDelete(_health);
        var _health_prop=instance_create(0,0,CustomHitme);
        with(_health_prop) hm_tests_compiler_fixture_gml_legacy_health_first();
        scrHMActorTestCheck(_health_prop.hp==1&&_health_prop.max_hp==100,"custom prop maximum writes preserve the prop health contract");
        scrHMDelete(_health_prop);GameCont.loops=_old_loops;
        var _enemy=instance_create(0,0,CustomEnemy);
        _enemy.hp=20;_enemy.max_hp=20;_enemy.visits=0;_enemy.corpse=false;_enemy.raddrop=0;
        _enemy.on_step=scrHMActorTestStep;
        _enemy.on_hurt=scrHMActorTestHurt;
        _enemy.on_death=scrHMActorTestDeath;
        _enemy.on_destroy=scrHMActorTestDestroy;
        _enemy.on_cleanup=scrHMActorTestCleanup;
        scrHMActorTestCheck(instance_is(_enemy,enemy)&&instance_is(_enemy,hitme),"enemy uses actual damage/counting hierarchy");
        with(_enemy) event_perform(ev_step,ev_step_normal);
        scrHMActorTestCheck(_enemy.visits==1,"custom step called once");
        scr_hit(_enemy,8,HitId.Bandit);
        scrHMActorTestCheck(_enemy.hp==16&&global.hm_actor_hurts==1&&_enemy.hurt_source==HitId.Bandit,"hurt callback owns damage exactly once");
        scrHMActorTestCheck(_enemy.hurt_knockback==0&&_enemy.hurt_direction==0,"raw hit supplies numeric zero recoil arguments");
        var _bullet=instance_create(0,0,CustomProjectile);
        _bullet.hitid=HitId.Bandit;_bullet.direction=120;
        with(_bullet) scr_projectile_hit(_enemy,4,6*timescale);
        scrHMActorTestCheck(_enemy.hp==14&&_enemy.hurt_knockback==6&&_enemy.hurt_direction==120,"projectile callback receives legacy recoil vector");
        scrHMActorTestCheck(abs(_enemy.speed-6*timescale)<.0001,"custom recoil is applied once at either frame rate");
        scrHMDelete(_bullet);
        _enemy.hp=16;
        _enemy.on_hurt=undefined;
        _enemy.sprite_index=sprBanditIdle;
        scr_hit(_enemy,3,HitId.Bandit);
        scrHMActorTestCheck(_enemy.hp==13,"default hurt follows original damage path");
        scrHMActorTestCheck(_enemy.sprite_index==sprBanditIdle,"default hit preserves custom actor state until its step");
        var _kills=GameCont.kills;
        _enemy.hp=0;
        with(_enemy) event_perform(ev_step,ev_step_normal);
        scrHMActorTestCheck(!instance_exists(_enemy)&&GameCont.kills==_kills+1,"death counts exactly once");
        scrHMActorTestCheck(global.hm_actor_order=="death;destroy;cleanup;","death/destroy/cleanup order");

        global.hm_actor_order="";
        _enemy=instance_create(0,0,CustomEnemy);
        _enemy.on_death=scrHMActorTestDeath;_enemy.on_destroy=scrHMActorTestDestroy;_enemy.on_cleanup=scrHMActorTestCleanup;
        _enemy.hp=0;_enemy.can_die=false;_enemy.visits=0;_enemy.on_step=scrHMActorTestStep;
        with(_enemy) event_perform(ev_step,ev_step_normal);
        scrHMActorTestCheck(instance_exists(_enemy)&&_enemy.visits==1&&global.hm_actor_order=="","candie false retains scripted dying state");
        scrHMDelete(_enemy);
        scrHMActorTestCheck(global.hm_actor_order=="","silent delete skips destroy/drop callbacks");

        var _prop=instance_create(0,0,CustomHitme);
        _prop.hp=20;_prop.on_hurt=scrHMActorTestHurt;
        scr_hit(_prop,10,HitId.Bandit);
        scrHMActorTestCheck(_prop.hp==15&&!instance_is(_prop,enemy),"custom hitme is damageable without blocking portal counts");
        scrHMDelete(_prop);

        var _object=instance_create(0,0,CustomObject);
        _object.visits=0;_object.on_step=scrHMActorTestStep;
        with(_object) event_perform(ev_step,ev_step_normal);
        scrHMActorTestCheck(_object.visits==1&&!instance_is(_object,enemy),"custom object has independent lifecycle");
        _object.on_cleanup=scrHMActorTestCleanup;global.hm_actor_order="";
        with(_object) {scrHMActorCleanup();scrHMActorCleanup();}
        scrHMActorTestCheck(global.hm_actor_order=="cleanup;","cleanup idempotent across explicit lifecycle paths");
        scrHMDelete(_object);

        var _projectile=instance_create(0,0,CustomProjectile),_target=instance_create(0,0,CustomHitme);
        _projectile.team=team_player;_projectile.on_hit=scrHMActorTestHit;_target.team=team_enemy;
        with(_target) with(_projectile) scrHMProjectileCollision();
        scrHMActorTestCheck(global.hm_actor_hits==1&&_projectile.observed_other==_target,"projectile hit callback retains collided target");
        _target.team=team_player;
        with(_target) with(_projectile) scrHMProjectileCollision();
        scrHMActorTestCheck(global.hm_actor_hits==1,"friendly projectile ignores its own team");
        _projectile.on_wall=scrHMActorTestWall;
        with(_projectile) scrHMProjectileWall();
        scrHMActorTestCheck(instance_exists(_projectile)&&global.hm_actor_walls==1,"custom wall callback can preserve projectile");
        _projectile.on_wall=undefined;
        with(_projectile) scrHMProjectileWall();
        scrHMActorTestCheck(!instance_exists(_projectile),"default projectile wall response destroys it");
        scrHMDelete(_target);
        scrHMActorTestConversions();
        scrHMActorTestInfantryCapture();
        show_debug_message("HARDMODE ACTORS RATE PASS "+string(_rate));
    }
    show_debug_message("HARDMODE ACTORS RESULT "+json_stringify({status:"PASS",checks:global.hm_actor_checks,rates:[30,60]}));
    game_end();return true;
}
