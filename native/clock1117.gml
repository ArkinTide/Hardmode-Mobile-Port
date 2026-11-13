// Frame-cap changes are a transaction before Begin Step/Alarm processing.
// Stored physical velocities use pixels/callback; HM script constants remain
// in pixels/30 Hz logic tick and must not be rescaled by their field name.
function scrHMClockAnimationRatio1117(_sprite,_from,_to) {
    if(sprite_exists(_sprite) && sprite_get_speed_type(_sprite)==spritespeed_framespersecond) return 1;
    return _to/max(.001,_from);
}

function scrHMClockActor1117(_from,_to) {
    var _ratio=_to/max(.001,_from);
    hspeed*=_ratio;vspeed*=_ratio;
    friction*=_ratio*_ratio;
    gravity*=object_index==Bubble?_ratio:_ratio*_ratio;
    image_speed*=scrHMClockAnimationRatio1117(sprite_index,_from,_to);
    if(variable_instance_exists(id,"knockback_speed")) knockback_speed*=_ratio;
    // Native caps are physical velocities. CustomEnemy/3dvan/gator fields
    // with the same names are logical constants, so are deliberately absent.
    if(object_index==Player || object_index==DogGuardian || object_index==InvSpider
        || object_index==Spider || object_index==Rocket || object_index==JockRocket) {
        if(variable_instance_exists(id,"maxspeed")) maxspeed*=_ratio;
    }
    if(object_is_ancestor(object_index,projectile) || object_index==projectile) {
        if(variable_instance_exists(id,"wallbounce") && object_index!=CustomProjectile) wallbounce*=_ratio;
    }
    if(object_index==DogGuardian || object_index==SodaCan) {
        if(variable_instance_exists(id,"zspeed")) zspeed*=_ratio;
    }
}

function scrHMClockApply1117(_rate) {
    if(game_get_speed(gamespeed_fps)>=game_speed_uncaped) return false;
    var _from=global.time_scale,_to=clamp(30/max(1,_rate),.01,1);
    if(abs(_from-_to)>.000001) with(all) scrHMClockActor1117(_from,_to);
    // Preserve the alarm/logic fractional phases across either direction.
    global.time_scale=_to;
    if(game_get_speed(gamespeed_fps)!=_rate) game_set_speed(_rate,gamespeed_fps);
    return true;
}

function scrHMClockBudget1117(_state,_target,_capacity,_elapsed,_active,_enabled) {
    if(!_active) return _state;
    if(!_enabled || _target!=60) return {limited:false,hot:0,cool:0,probe:false,rate:_target};
    var _dt=clamp(_elapsed,0,.1);
    if(_state.limited) {
        _state.cool+=_dt;
        if(_state.cool>=5) {
            _state.limited=false;_state.probe=true;_state.hot=0;_state.cool=0;
        }
    } else {
        _state.hot=(_capacity<54)?_state.hot+_dt:max(0,_state.hot-_dt*2);
        _state.cool=(_capacity>=56)?_state.cool+_dt:0;
        if(_state.hot>=.8) {
            _state.limited=true;_state.probe=false;_state.hot=0;_state.cool=0;
        } else if(_state.cool>=1.5) _state.probe=false;
    }
    _state.rate=_state.limited?30:60;
    return _state;
}

function scrHMClockSafe1117() {
    // Activation requested during native unpause settles after that event.
    // Wait for its bookkeeping to finish before enumerating physical caches.
    return instance_exists(UberCont) && !UberCont.paused && UberCont.want_pause<=0 && !UberCont.quit_pause
        && !instance_exists(PauseImage) && !lockstep_stop && !instance_exists(GenCont);
}

function scrHMClockPresentationTicks1117() {
    var _clock=variable_instance_get(UberCont,"hm_presentation_time1117")??0;
    var _last=self[$ "hm_presentation_last1117"];
    hm_presentation_last1117=_clock;
    if(is_undefined(_last)) return 1;
    var _phase=(self[$ "hm_presentation_phase1117"]??0)+max(0,_clock-_last)*30;
    var _ticks=floor(_phase+.000001);
    hm_presentation_phase1117=_phase-_ticks;
    return _ticks;
}

function scrHMClockBegin1117() {
    if(!scrHMEnabled() || !instance_exists(UberCont)) return;
    with(UberCont) {
        // HMWorld and UberCont can be created in either order. Both call this
        // before consuming timescale, once for the same physical frame.
        if((self[$ "hm_clock_frame1117"]??-999)==current_frame) return;
        hm_clock_frame1117=current_frame;
        self[$ "hm_presentation_time1117"]??=0;
        if(!scrHMClockSafe1117()) return;
        hm_presentation_time1117+=clamp(delta_time/1000000,0,.25);
        if(game_get_speed(gamespeed_fps)>=game_speed_uncaped) return;
        if(is_undefined(self[$ "hm_clock_budget1117"]))
            hm_clock_budget1117={limited:false,hot:0,cool:0,probe:false,rate:opt_framerate};
        // fps_real is a trailing statistic that can still describe the old
        // 30 Hz cap throughout a healthy 60 Hz probe. Sample callback time.
        var _capacity=delta_time>0?1000000/delta_time:fps_real;
        var _active=instance_exists(GameCont) && instance_exists(Player);
        // A disabled switch also restores the requested cap on the next safe
        // Begin Step. Menu-only options never mutate inactive actor caches.
        hm_clock_budget1117=scrHMClockBudget1117(hm_clock_budget1117,opt_framerate,
            _capacity,delta_time/1000000,true,_active && (self[$ "opt_hm_autoframerate"]??true));
        scrHMClockApply1117(hm_clock_budget1117.rate);
    }
}
