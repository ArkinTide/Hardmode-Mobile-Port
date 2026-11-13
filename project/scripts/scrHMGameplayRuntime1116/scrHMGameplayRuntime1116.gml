function scrHMGameplayRuntime1116() {
    if(ticks==20) {
        if(mode=="budget116") scrHMGameplayBudget1116();
        if(mode=="floors116") scrHMGameplayFloors1116();
        if(mode=="music116") scrHMGameplayMusic1116();
        if(mode=="guardian116") scrHMGameplayGuardian1116();
        if(mode=="guardian116fire") {
            scrHMGameplayLane107();UberCont.opt_bossintro=0;UberCont.opt_shake=0;
            hm_bosses_guardianboss_mod_gml_guardianboss_create(player.x+100,player.y);
            fire_weapons116=[wep_heavy_auto_crossbow,wep_auto_crossbow,wep_heavy_crossbow,
                wep_laser_rifle,wep_lightning_rifle,wep_plasma_gun];
            fire_counts116=array_create(array_length(fire_weapons116),0);
            fire_frames116=0;fire_start116=get_timer();
        }
    }
    if(mode=="guardian116fire" && ticks>=25 && ticks<205) {
        var _index=min(array_length(fire_weapons116)-1,(ticks-25) div 30);
        if(ticks mod 5==0) {
            with(player) {
                wep=other.fire_weapons116[_index];infammo=true;gunangle=0;
                scrFire(wep,false);
            }
            fire_counts116[_index]++;
        }
        fire_frames116++;
        if(ticks==200 && surface_exists(application_surface))
            surface_save(application_surface,game_directory+"guardian116-live-weapons.png");
    }
    if(mode=="guardian116fire" && ticks==205) {
        for(var _i=0;_i<array_length(fire_counts116);++_i)
            scrHMGameplayCheck(fire_counts116[_i]==6,"live Guardian battle exercised actual native weapon fire: "+string(fire_weapons116[_i]));
        var _visible=0;with(damagesource) {
            if(visible) {_visible++;scrHMGameplayCheck(depth<=-9,"live attacks retain their native draws above Guardian darkness");}
        }
        scrHMGameplayCheck(_visible>0 && fire_frames116==180,"live multi-weapon Guardian combat remains running after all six weapon families");
        show_debug_message("HARDMODE GUARDIAN116 LIVE "+json_stringify({logical_frames:fire_frames116,
            elapsed_seconds:(get_timer()-fire_start116)/1000000,visible_sources:_visible,
            render_cap:game_get_speed(gamespeed_fps),user_rate:UberCont.opt_framerate,physical_device:false}));
    }
    if(mode=="budget116" && ticks==80) {
        var _elapsed=(get_timer()-budget_start116)/1000000;
        var _logic=current_frame-budget_frame116;
        scrHMGameplayCheck(UberCont.opt_framerate==60 && game_get_speed(gamespeed_fps)==30,
            "real UberCont budget integration keeps the user's 60 preference while temporarily rendering at 30");
        scrHMGameplayCheck(abs(_logic-60)<2 && _elapsed>1.6 && _elapsed<3.4,
            "real capped host advances sixty native logical units in approximately two seconds, not four");
        show_debug_message("HARDMODE FRAME116 LIVE "+json_stringify({logical_units:_logic,elapsed_seconds:_elapsed,
            saved_rate:UberCont.opt_framerate,actual_cap:game_get_speed(gamespeed_fps),physical_device:false}));
    }
}

function scrHMGameplayBudget1116() {
    scrHMGameplayLane107();
    var _state={limited:false,hot:0,cool:0,rate:60};
    repeat(200) _state=scrHMFrameBudgetState1116(_state,60,150,1/60,true);
    scrHMGameplayCheck(!_state.limited && _state.rate==60,"healthy 60 FPS load keeps full rendering");
    repeat(20) _state=scrHMFrameBudgetState1116(_state,60,40,1/40,true);
    scrHMGameplayCheck(!_state.limited,"short overload does not oscillate the render cap");
    repeat(12) _state=scrHMFrameBudgetState1116(_state,60,40,1/40,true);
    scrHMGameplayCheck(_state.limited && _state.rate==30,"sustained overload chooses native 30 Hz without a variable collision timestep");
    repeat(120) _state=scrHMFrameBudgetState1116(_state,60,100,1/30,true);
    scrHMGameplayCheck(_state.limited,"four healthy seconds do not trigger a premature return to 60");
    repeat(32) _state=scrHMFrameBudgetState1116(_state,60,100,1/30,true);
    scrHMGameplayCheck(!_state.limited && _state.rate==60,"five healthy seconds restore the user's 60 target");
    for(var _capacity=30;_capacity<=50;_capacity+=5) {
        _state={limited:false,hot:0,cool:0,rate:60};
        var _wall=0,_logic=0;
        repeat(600) {
            var _rate=min(_capacity,_state.rate),_dt=1/_rate;
            _wall+=_dt;_logic+=30/_state.rate;
            _state=scrHMFrameBudgetState1116(_state,60,_capacity,_dt,true);
        }
        scrHMGameplayCheck(_logic/30>=_wall-.9,"bounded overload policy keeps long-run game time within its short settling interval");
    }
    _state=scrHMFrameBudgetState1116({limited:true,hot:0,cool:0,rate:30},30,30,.03,true);
    scrHMGameplayCheck(!_state.limited && _state.rate==30,"explicit 30 setting remains authoritative");
    UberCont.opt_framerate=60;
    UberCont.hm_frame_budget116={limited:true,hot:0,cool:0,rate:30};
    with(UberCont) scrHMFrameBudget1116();
    budget_start116=get_timer();budget_frame116=current_frame;
}

function scrHMGameplayFloors1116() {
    var _old=ds_list_create(),_new=ds_list_create(),_old_times=[],_new_times=[];
    for(var _sample=0;_sample<24;++_sample) {
        var _xx=player.x-180+_sample*13,_yy=player.y-110+_sample*7;
        ds_list_clear(_old);ds_list_clear(_new);
        with(Floor) if(bbox_right>=_xx && bbox_bottom>=_yy && bbox_left<_xx+400 && bbox_top<_yy+240)
            ds_list_add(_old,id);
        scrHMVisibleFloors1116(_xx,_yy,_xx+400,_yy+240,_new);
        if(ds_list_size(_old)!=ds_list_size(_new)) {
            var _missing=[],_extra=[];
            for(var _i=0;_i<ds_list_size(_old);++_i) if(ds_list_find_index(_new,_old[|_i])<0) {
                var _f=_old[|_i];array_push(_missing,[_f.object_index,_f.x,_f.y,_f.bbox_left,_f.bbox_top,_f.bbox_right,_f.bbox_bottom]);
            }
            for(var _i=0;_i<ds_list_size(_new);++_i) if(ds_list_find_index(_old,_new[|_i])<0) {
                var _f=_new[|_i];array_push(_extra,[_f.object_index,_f.x,_f.y,_f.bbox_left,_f.bbox_top,_f.bbox_right,_f.bbox_bottom]);
            }
            show_debug_message("HARDMODE FLOORS116 DIFFERENCE "+json_stringify({left:_xx,top:_yy,old:ds_list_size(_old),current:ds_list_size(_new),missing:_missing,extra:_extra}));
        }
        scrHMGameplayCheck(ds_list_size(_old)==ds_list_size(_new),"broadphase visible-floor set equals full-room bbox traversal");
        for(var _i=0;_i<ds_list_size(_old);++_i)
            scrHMGameplayCheck(ds_list_find_index(_new,_old[|_i])>=0,"every formerly visible floor is retained");
        for(var _which=0;_which<2;++_which) {
            var _kind=(_sample+_which) mod 2,_t=get_timer();
            repeat(20) {
                ds_list_clear(_new);
                if(_kind==0) {
                    with(Floor) if(bbox_right>=_xx && bbox_bottom>=_yy && bbox_left<_xx+400 && bbox_top<_yy+240)
                        ds_list_add(_new,id);
                } else scrHMVisibleFloors1116(_xx,_yy,_xx+400,_yy+240,_new);
            }
            if(_kind==0) array_push(_old_times,get_timer()-_t);else array_push(_new_times,get_timer()-_t);
        }
    }
    array_sort(_old_times,true);array_sort(_new_times,true);
    show_debug_message("HARDMODE FLOORS116 PROFILE "+json_stringify({floors:instance_number(Floor),samples:24,passes_per_sample:20,
        original_median_us:_old_times[12],optimized_median_us:_new_times[12],physical_device:false}));
    ds_list_destroy(_old);ds_list_destroy(_new);
}

function scrHMGameplayMusic1116() {
    scrHMGameplayLane107();
    var _area=GameCont.area,_sub=GameCont.subarea;
    GameCont.area=scrHMAreaResolve("nightdesert");GameCont.subarea=1;
    scrHMSoundMusic(mus1b);scrHMSoundAmbient(amb1);
    var _handle=MusCont.music_sound;
    var _position=audio_sound_get_track_position(_handle);
    GameCont.area=scrHMAreaResolve("scorpionboss");GameCont.subarea=1;
    with(MusCont) {hm_music_area112=_area;scrHMMusicRoom112();}
    scrHMGameplayCheck(MusCont.song==custom_sound_check(mus1b) && MusCont.music_sound==_handle,
        "1-5 room music retains the actual 1-4 side B playback handle");
    scrHMGameplayCheck(audio_sound_get_track_position(_handle)>=_position,"desert side B track position does not rewind");
    scrHMSoundMusic(musBoss1);var _boss_handle=MusCont.music_sound;
    with(MusCont) scrHMMusicRoom112();
    scrHMGameplayCheck(MusCont.song==custom_sound_check(musBoss1) && MusCont.music_sound==_boss_handle,
        "room maintenance does not replace a later boss combat track with side B");
    GameCont.area=_area;GameCont.subarea=_sub;
}

function scrHMGameplayGuardianOldLayers1116() {
    with(GameObject) scrHMGuardianLayerRestore1104();
    with(damagesource) scrHMGuardianLayerRestore1104();
    with(GameObject) if(instance_is(id,hitme)||instance_is(id,Pickup)||instance_is(id,Effect)
        ||instance_is(id,CrystalShield)||instance_is(id,CrystalShieldDisappear)||instance_is(id,PortalStrike))
        scrHMGuardianLayerLift1104();
    with(damagesource) scrHMGuardianLayerLift1104();
}

function scrHMGameplayGuardian1116() {
    scrHMGameplayLane107();UberCont.opt_bossintro=0;UberCont.opt_shake=0;
    hm_bosses_guardianboss_mod_gml_guardianboss_create(player.x+100,player.y);
    with(CustomEnemy) if(name=="guardianboss") {on_step=undefined;spritealpha=1;}
    var _objects=[Bullet1,EnemyBullet1,CustomProjectile,Bolt,Bolt,Bolt,BoltStick,
        Laser,Lightning,Explosion,PlasmaImpact,Flame,BigGuardianBullet,GuardianBullet];
    var _shots=[];
    for(var _n=0;_n<840;++_n) {
        var _shot=instance_create(player.x+(_n mod 40)*7-130,player.y+floor(_n/40)*5,_objects[_n mod array_length(_objects)]);
        with(_shot) {speed=0;hspeed=0;vspeed=0;damage=0;mask_index=mskNone;alarm[0]=-1;}
        array_push(_shots,_shot);
    }
    var _old=[],_new=[];
    for(var _sample=0;_sample<18;++_sample) {
        for(var _which=0;_which<2;++_which) {
            var _kind=(_sample+_which) mod 2,_t=get_timer();
            repeat(12) with(HMWorld) {
                if(_kind==0) scrHMGameplayGuardianOldLayers1116();else scrHMGuardianLayers1104();
            }
            var _elapsed=get_timer()-_t;
            if(_kind==0) array_push(_old,_elapsed);else array_push(_new,_elapsed);
        }
    }
    // Alternating samples may end on the retained old path, which did not
    // cover BoltStick. Validate the actual new path, outside measured time.
    with(HMWorld) scrHMGuardianLayers1104();
    var _miss=[];
    for(var _i=0;_i<array_length(_shots);++_i) if(_shots[_i].depth>-9)
        array_push(_miss,{type:object_get_name(_shots[_i].object_index),depth:_shots[_i].depth});
    if(array_length(_miss)>0) show_debug_message("HARDMODE GUARDIAN116 MISSING "+json_stringify({
        cache:variable_instance_get(HMWorld,"hm_guard_dark116"),bindings:instance_number(HMBinding),missing:_miss}));
    for(var _i=0;_i<array_length(_shots);++_i)
        scrHMGameplayCheck(_shots[_i].depth<=-9,"all projectile families including crossbow bolts remain above the Guardian blackout");
    array_sort(_old,true);array_sort(_new,true);
    show_debug_message("HARDMODE GUARDIAN116 PROFILE "+json_stringify({sources:array_length(_shots),samples:18,passes_per_sample:12,
        original_median_us:_old[9],optimized_median_us:_new[9],physical_device:false}));
    for(var _i=0;_i<array_length(_shots);++_i) instance_destroy(_shots[_i],false);
    with(enemy) instance_destroy(id,false);
}
