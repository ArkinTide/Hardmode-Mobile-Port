// Keep the native 30 Hz simulation within one collision step. Under sustained
// load, give it a full step per displayed frame instead of running at half
// speed while still trying to render 60 frames. The user's setting is retained.
function scrHMFrameBudgetState1116(_state,_target,_capacity,_elapsed,_active) {
    if(!_active || _target!=60) return {limited:false,hot:0,cool:0,rate:_target};
    var _dt=clamp(_elapsed,0,.1);
    if(!_state.limited) {
        _state.hot=(_capacity<58)?_state.hot+_dt:max(0,_state.hot-_dt*2);
        _state.cool=0;
        if(_state.hot>=.75) {_state.limited=true;_state.hot=0;}
    } else {
        _state.cool=(_capacity>=90)?_state.cool+_dt:0;
        if(_state.cool>=5) {_state.limited=false;_state.cool=0;}
    }
    _state.rate=_state.limited?30:60;
    return _state;
}

function scrHMFrameBudget1116() {
    if(!scrHMEnabled()) return;
    var _target=opt_framerate;
    if(game_get_speed(gamespeed_fps)>=game_speed_uncaped) return;
    if(is_undefined(self[$ "hm_frame_budget116"]))
        hm_frame_budget116={limited:false,hot:0,cool:0,rate:_target};
    var _active=instance_exists(GameCont) && instance_exists(Player)
        && !instance_exists(GenCont) && !paused && !lockstep_stop;
    var _capacity=fps_real;
    if(!hm_frame_budget116.limited && delta_time>0)
        _capacity=min(_capacity,1000000/delta_time);
    hm_frame_budget116=scrHMFrameBudgetState1116(hm_frame_budget116,_target,
        _capacity,delta_time/1000000,_active);
    if(game_get_speed(gamespeed_fps)!=hm_frame_budget116.rate)
        game_set_speed(hm_frame_budget116.rate,gamespeed_fps);
}

function scrHMVisibleFloors1116(_left,_top,_right,_bottom,_list) {
    // Native broadphase uses the same bounding boxes as the old full-room
    // Floor traversal, while only visiting candidates near the camera.
    // The broadphase excludes exact edge contacts while the original camera
    // predicate includes bbox_right/bottom at its near edge. Expand one pixel
    // before applying the original exact predicate below.
    collision_rectangle_list(_left-1,_top-1,_right+1,_bottom+1,Floor,false,false,_list,false);
    for(var _i=ds_list_size(_list)-1;_i>=0;--_i) {
        var _floor=_list[|_i];
        if(_floor.bbox_left>=_right || _floor.bbox_top>=_bottom
            || _floor.bbox_right<_left || _floor.bbox_bottom<_top) ds_list_delete(_list,_i);
    }
}

function scrHMDesertMusic1116() {
    if(!scrHMEnabled() || !instance_exists(GameCont)) return;
    // The scorpion arena is 1-5, a separate custom area after desert 1-4.
    // Retain the live side-B handle and position instead of restarting A.
    var _key=scrHMAreaKey(GameCont.area);
    if(_key!="area:scorpionboss") return;
    if((self[$ "hm_music_area112"]??noone)==GameCont.area) return;
    var _desired=custom_sound_check(mus1b);
    if(song==_desired && audio_is_playing(song)) {
        hm_music_desired=_desired;hm_music_area112=GameCont.area;
        oldarea=GameCont.area;return;
    }
    scrHMSoundMusic(mus1b);scrHMSoundAmbient(amb1);
    hm_music_area112=GameCont.area;oldarea=GameCont.area;
}
