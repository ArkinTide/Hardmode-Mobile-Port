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
        show_debug_message("HARDMODE ACTORS RATE PASS "+string(_rate));
    }
    show_debug_message("HARDMODE ACTORS RESULT "+json_stringify({status:"PASS",checks:global.hm_actor_checks,rates:[30,60]}));
    game_end();return true;
}
