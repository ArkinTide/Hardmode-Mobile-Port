// Call once per physical End Step, after scrHMGameplayTestStep(). The actual
// replacement constructor, native alarms and native skill choices all run.
// No fixture writes an attack alarm, ammo, attacktype or combat sprite.
function scrHMGameplayChief1117() {
    if(mode!="chief117full" && mode!="chief117half") return;
    if(ticks<20) return;
    if(!(self[$ "chief117_initialized"]??false)) {
        chief117_initialized=true;
        scrHMGameplayLane107();scrHMGameplayNoReplacement1115();
        scrHMModSet("mod","options","intropan","0");
        scrHMModSet("mod","options","bossoutros","0");
        scrHMModSet("mod","options","bossportraits","0");
        UberCont.opt_bossintro=0;GameCont.hm_chief_seen=true;
        chief117_ratio=mode=="chief117half"?.5:1;
        chief117_actor=scrHMChiefCreate1102(player.x+110,player.y);
        chief117_actor.hp=chief117_actor.max_hp*chief117_ratio;
        chief117_target=[player.x,player.y];
        chief117_samples=[];chief117_actions=[];
        chief117_active=false;chief117_rest=undefined;
        chief117_action="";chief117_complete=false;
        chief117_combat_at=-1;
    }
    if(!instance_exists(chief117_actor)) throw "Natural Captain observer lost its actual actor";
    // Remove unrelated summons and missiles after their native events have
    // executed. A stationary, invulnerable player supplies a stable target.
    with(enemy) if(id!=other.chief117_actor) instance_destroy(id,false);
    with(projectile) instance_destroy(id,false);
    player.x=chief117_target[0];player.y=chief117_target[1];
    player.speed=0;player.hp=player.max_hp;
    var _actor=chief117_actor;
    _actor.hp=_actor.max_hp*chief117_ratio;
    if(!_actor.hm_chief_combat1115 || (_actor[$ "hm_portrait_frozen"]??false)) return;
    if(chief117_combat_at<0) chief117_combat_at=ticks;
    var _idle=_actor.drawspr==sprLastIdle;
    if(!chief117_active && !_idle) {
        chief117_active=true;
        chief117_action=sprite_get_name(_actor.drawspr);
        if(!array_contains(chief117_actions,chief117_action)) array_push(chief117_actions,chief117_action);
        if(!is_undefined(chief117_rest)) {
            var _sample=chief117_rest;
            _sample.next_action=chief117_action;
            _sample.end_logic=ticks;_sample.end_physical=age;_sample.end_clock=current_frame;
            _sample.elapsed_logic=ticks-_sample.start_logic;
            _sample.elapsed_physical=age-_sample.start_physical;
            _sample.elapsed_clock=current_frame-_sample.start_clock;
            _sample.elapsed_seconds=_sample.elapsed_physical/rate;
            array_push(chief117_samples,_sample);
            chief117_rest=undefined;
        }
    }
    if(chief117_active && _idle && _actor.alarm[1]>0) {
        chief117_active=false;
        chief117_rest={previous_action:chief117_action,start_logic:ticks,start_physical:age,
            start_clock:current_frame,observed_alarm:_actor.alarm[1],health:_actor.hp/_actor.max_hp};
    }
    if(ticks>=goal_ticks-5 && !chief117_complete) {
        chief117_complete=true;
        var _count=array_length(chief117_samples);
        var _nominal=(chief117_ratio==1?25:17.5)*(GameCont.loops>0?.8:1);
        var _sum=0,_min=infinity,_max=0;
        scrHMGameplayCheck(_count>=8,"Captain completes at least eight naturally chosen skill-to-skill rests");
        scrHMGameplayCheck(array_length(chief117_actions)>=2,
            "the observer follows multiple naturally selected native skill families");
        for(var _i=0;_i<_count;++_i) {
            var _sample=chief117_samples[_i],_logical=_sample.elapsed_physical*30/rate;
            _sum+=_logical;_min=min(_min,_logical);_max=max(_max,_logical);
            scrHMGameplayCheck(abs(_sample.observed_alarm-_nominal)<=1,
                "natural skill completion assigns the expected health- and Loop-dependent decision pause");
            scrHMGameplayCheck(abs(_logical-_nominal)<=2,
                "natural next skill starts after the same logical pause at thirty and sixty callbacks");
        }
        show_debug_message("HARDMODE CHIEF1117 NATURAL "+json_stringify({rate:rate,loop:GameCont.loops,
            health:chief117_ratio,combat_at:chief117_combat_at,nominal_logic:_nominal,
            mean_logic:_count>0?_sum/_count:0,min_logic:_min,max_logic:_max,
            samples:chief117_samples,actions:chief117_actions}));
    }
}
