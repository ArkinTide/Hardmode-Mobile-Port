// Follow-up to the Windows 1.0.11 field reports.
function scrHMWheelEvent112(_up) {
    if(os_type!=os_windows) return;
    scrDesktopWheelSwap(global.index,_up,!_up);
    if(instance_exists(HMGameplayTest) && HMGameplayTest.mode=="live112")
        with(HMGameplayTest) {
            live_events112=(self[$ "live_events112"]??0)+1;
            show_debug_message("WHEEL112 EVENT "+string(_up)+" allowed="+string(scrDesktopWheelAllowed111()));
        }
}
function scrHMWheelPoll112() {
    if(os_type!=os_windows) return;
    var _up=mouse_wheel_up(),_down=mouse_wheel_down();
    if(_up||_down) scrDesktopWheelSwap(global.index,_up,_down);
}

function scrHMCaveWalls112(_origin) {
    if(!instance_exists(_origin)) return;
    // Commit the destination palette in one bounded pass. Keep the packed
    // collision geometry, scales, masks and plain exterior renderers intact.
    // The independent floor fade is still allowed to finish afterwards.
    with(Wall) {
        sprite_index=sprWall4Bot;topspr=sprWall4Top;outspr=sprWall4Out;
    }
    with(TopSmall) sprite_index=sprWall4Trans;
    with(HMWorld) {
        hm_wall_theme_queue=[];hm_wall_theme_index=0;
        hm_wall_theme_area106=GameCont.area;hm_theme_started111=GameCont.area;
        hm_cave_restored112=true;
    }
}

function scrHMSwimSupported112(_x,_y) {
    // An actor still supported by the visible bank stays on land. Five
    // exact, hashed probes cover the small foot contact area; there is no
    // nearest-tile search and no delay timer on leaving the water.
    return scrHMWaterAt(_x,_y)
        && scrHMWaterExact109(_x-3,_y) && scrHMWaterExact109(_x+3,_y)
        && scrHMWaterExact109(_x,_y-2) && scrHMWaterExact109(_x,_y+2);
}

function scrHMMusicRoom112() {
    if(!scrHMEnabled() || !instance_exists(GameCont)) return false;
    if(!scrHMAreaHas(GameCont.area)) {
        // Native areas must select their own track after a custom room.
        // Do not let a cached custom track overwrite that room's selection.
        hm_music_desired=undefined;hm_music_area112=undefined;
        return false;
    }
    alarm[0]=-1;
    var _area=GameCont.area,_owner=self[$ "hm_music_area112"];
    if(is_undefined(_owner) || _owner!=_area) {
        var _native=scrHMVanillaLoopArea111(_area);
        var _song=asset_get_index("mus"+string(_native));
        var _amb=asset_get_index("amb"+string(_native));
        switch(scrHMAreaKey(_area)) {
            case "area:junkyard":_song=mus3b;_amb=amb3;break;
            case "area:ravenboss":_song=mus3;_amb=amb3;break;
            case "area:throne":_song=mus7;_amb=amb7;break;
            case "area:icecave":_song=mus100;_amb=amb100;break;
            case "area:noyetihere":_song=musBoss4Silence;_amb=amb100;break;
            case "area:end":_song=musCredits;_amb=amb0b;break;
        }
        if(!audio_exists(_song)) _song=musBoss4Silence;
        if(!audio_exists(_amb)) _amb=amb0b;
        scrHMSoundMusic(_song);scrHMSoundAmbient(_amb);
    }
    var _desired=self[$ "hm_music_desired"]??song;
    if(song!=_desired) {
        if(audio_exists(song)) audio_stop_sound(song);
        song=_desired;
    }
    if(audio_exists(song) && !audio_is_playing(song)) music_sound=snd_play_music(song,true);
    if(audio_exists(amb) && !audio_is_playing(amb)) snd_play_ambience(amb,true);
    oldarea=_area;return true;
}

function scrHMDesktopTiming112() {
    if(os_type!=os_windows) return;
    // Use the engine's requested-rate clock instead of the display-refresh
    // clock. Driver/DWM refresh division must not halve a 30/60 FPS target.
    display_set_timing_method(tm_sleep);
    // MakeGame's inherited 33 ms margin overrides options.ini and can
    // busy-wait for nearly a whole 30/60 FPS frame. Keep only a 1 ms tail.
    display_set_sleep_margin(1);
    display_reset(0,false);
    global.hm_desktop_clock112=true;
}

function scrHMBindingOffset112() {
    // These three renderers draw the creator at a separate depth. Match its
    // body transform so the top/cropped body does not lag behind that body.
    if(!instance_exists(creator) || !(creator[$ "hm_custom_actor"]??false)
        || !array_contains([scrHMScriptRef(hm_enemies_mod_gml_bigcrystaltopdraw),
            scrHMScriptRef(hm_maincode_mod_gml_sewerboi),
            scrHMScriptRef(hm_maincode_mod_gml_spacesewerboi)],hm_code)) return [0,0];
    var _offset=[0,0];
    with(creator) _offset=scrHMVisualOffset111();
    return _offset;
}
function scrHMBindingDraw112() {
    var _offset=scrHMBindingOffset112(),_matrix=matrix_get(matrix_world);
    var _shift=(_offset[0]!=0||_offset[1]!=0);
    if(_shift) matrix_set(matrix_world,matrix_multiply(_matrix,
        matrix_build(_offset[0],_offset[1],0,0,0,0,1,1,1)));
    scrHMBindingDraw();
    if(_shift) matrix_set(matrix_world,_matrix);
}
