// Independent runner test source; deliberately not registered in the project.
// Required integration in an isolated HMGameplayTest build only:
//   1. UberCont Begin Step, before the production clock:
//        scrHMClockTestGlobalBegin1117();
//   2. HMGameplayTest Begin Step:
//        scrHMClockTestBegin1117();
//   3. The existing Player Step test-input hook, after input_tick:
//        scrHMClockTestPlayerInput1117();
//   4. HMGameplayTest End Step, OUTSIDE HMWorld.logic_tick gating:
//        scrHMClockTestEnd1117();
// Production API: scrHMClockApply1117(rate), scrHMClockBegin1117(),
// UberCont.opt_hm_autoframerate. Neither the test nor its assertions replace
// native Player movement, built-in projectile motion, or the engine Alarm event.
//
// Suggested scenarios (area,sub,loop,initial_rate,goal_ticks,seed,mode):
// 1,1,1,60,360,42,clock117travel
// 1,1,1,60,120,42,clock117cache
// 1,1,1,60,180,42,clock117freeze
// 1,1,1,60,180,42,clock117pause
// 1,1,1,60,180,42,clock117phase
// 1,1,1,60,900,42,clock117auto
// 1,1,1,60,120,42,clock117option
// 1,1,1,60,120,42,clock117powered
// All produce HARDMODE CLOCK117 SAMPLE / RESULT JSON, physical_device:false.

function scrHMClockTestActive1117() {
    return instance_exists(HMGameplayTest)
        && string_pos("clock117",HMGameplayTest.mode)==1;
}

function scrHMClockTestCheck1117(_ok,_message) {
    if(!_ok) throw "Gameplay assertion: clock1117: "+_message;
    // The real pause intentionally makes the test controller inactive.
    // Assertions must remain usable from the always-active UberCont hook.
    if(instance_exists(HMGameplayTest)) HMGameplayTest.checks++;
}

function scrHMClockTestNear1117(_actual,_expected,_message) {
    scrHMClockTestCheck1117(abs(_actual-_expected)<.0001,
        _message+" actual="+string(_actual)+" expected="+string(_expected));
}

function scrHMClockTestApply1117(_rate) {
    save_set_value("options","framerate",_rate);
    UberCont.opt_framerate=_rate;
    with(UberCont) scrHMClockApply1117(_rate);
    scrHMClockTestCheck1117(game_get_speed(gamespeed_fps)==_rate,"transaction changes actual engine callback rate");
    scrHMClockTestNear1117(timescale,30/_rate,"transaction publishes the matching timescale");
}

function scrHMClockTestBullet1117(_x,_y) {
    var _body=instance_create(_x,_y,Bullet1);
    with(_body) {
        direction=0;speed=6*timescale;friction=0;gravity=0;
        image_speed=0;mask_index=mskNone;damage=0;
        alarm[0]=-1;alarm[1]=-1;
    }
    return _body;
}

function scrHMClockTestFinish1117() {
    clock_done1117=true;
    show_debug_message("HARDMODE CLOCK117 RESULT "+json_stringify({
        status:"PASS",mode:mode,physical_device:false,
        native_frames:clock_frames1117,wall_seconds:(get_timer()-clock_started1117)/1000000,
        logic_units:current_frame-clock_started_units1117,
        cap:game_get_speed(gamespeed_fps),time_scale:timescale,checks:checks}));
}

function scrHMClockTestInit1117() {
    scrHMGameplayLane107();
    // A long ordinary floor lane prevents camera travel or the map edge from
    // limiting the real held-input player / long-lived projectile observations.
    for(var _i=16;_i<80;++_i) for(var _j=0;_j<12;++_j)
        instance_create(14000+_i*32,14000+_j*32,Floor);
    UberCont.opt_hm_autoframerate=(mode=="clock117auto" || mode=="clock117pause");
    save_set_value("visual","hm_autoframerate",UberCont.opt_hm_autoframerate);
    scrHMClockTestApply1117(60);
    clock_started1117=get_timer();clock_started_units1117=current_frame;
    clock_frames1117=0;clock_done1117=false;clock_ready1117=true;
    clock_move1117=false;clock_segment1117=undefined;clock_phase1117=0;
    clock_old1117=scrHMClockTestBullet1117(player.x+40,player.y-64);
    clock_fresh1117=noone;clock_samples1117=[];
    if(mode=="clock117pause") {
        // Establish the actual automatic-fallback state while retaining the
        // user's saved 60 Hz preference. The pause then uses native UI events.
        scrHMClockTestApply1117(30);
        save_set_value("options","framerate",60);UberCont.opt_framerate=60;
        UberCont.hm_clock_budget1117={limited:true,hot:0,cool:0,probe:false,rate:30};
    }
    if(mode=="clock117auto") {
        clock_auto_stage1117="warm";clock_auto_stage_at1117=get_timer();
        clock_auto_low_seen1117=false;clock_auto_clear_at1117=0;
    }
    if(mode=="clock117powered") {
        clock_powered1117=[];
        var _kinds=[Rocket,JockRocket],_limits=[12,5],_accelerations=[2,.3];
        for(var _i=0;_i<2;++_i) {
            var _body=scrHMClockTestPoweredBody1117(_kinds[_i],player.x+40,player.y-96+_i*32,0);
            array_push(clock_powered1117,{kind:_kinds[_i],label:object_get_name(_kinds[_i]),
                old:_body,fresh:noone,limit:_limits[_i],acceleration:_accelerations[_i],
                expected_speed:0,accel_ticks:0,first_max:-1,
                initial_x:_body.x,expected_distance:0,reference_distance:0,
                fresh_x:0,fresh_expected_distance:0});
        }
    }
}

function scrHMClockTestVideoOpen1117() {
    scrHMClockTestCheck1117(!instance_exists(MenuOptions),"fixture opens one real settings menu");
    var _had_back=instance_exists(BackButton),_menu=instance_create(0,0,MenuOptions);
    _menu.clock_test_had_back1117=_had_back;
    with(_menu) scrOptionsMenuChangeCategory(OptionCategory.Video,false);
    var _found=-1;
    for(var _i=0;_i<array_length(_menu.items);++_i) {
        if(_menu.items[_i].key=="visual_hm_autoframerate") _found=_i;
    }
    scrHMClockTestCheck1117(_found>=0,"real Video menu exposes the automatic framerate switch");
    var _opt=_menu.items[_found];
    scrHMClockTestCheck1117(_opt.type=="switch" && _opt.visible && _opt.available,
        "real automatic framerate control is a visible enabled switch");
    with(_menu) {
        clock_test_option1117=_found;pointed_item=_found;wait=false;
        mouse_active=false;slider_change=0;last_change=current_frame-1000;
        mx_last=is_desktop?device_mouse_x_to_gui(0):-1000;
        my_last=is_desktop?device_mouse_y_to_gui(0):-1000;
        scroll_check=false;scroll_speed=0;
        // Use the ordinary complete category and native row measurements;
        // center the selected row just as the native keyboard scroll does.
        var _total=font_get_height_diff(),_before=0;
        for(var _i=0;_i<item_count;++_i) {
            var _height=max(items[_i].height,draw_step_size);
            _total+=_height;
            if(_i<pointed_item) _before+=_height;
        }
        scroll=8+font_get_height_diff()-_total*.5+_before;
    }
    return _menu;
}

function scrHMClockTestVideoEvent1117(_menu,_toggle,_screenshot) {
    // Execute the actual option submission/render event. The fixture supplies
    // a controller-confirm action; it does not replace the switch handler,
    // saveData write, scrOptionsUpdate or renderer with a test implementation.
    var _surface=surface_create(gui_w,gui_h);
    scrHMClockTestCheck1117(surface_exists(_surface),"native Video menu capture surface is available");
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_proj=matrix_get(matrix_projection);
    var _camera=camera_create_view(0,0,gui_w,gui_h,0,noone,-1,-1,0,0);
    surface_set_target(_surface);draw_clear_alpha(c_black,1);
    matrix_set(matrix_world,matrix_build_identity());camera_apply(_camera);
    with(_menu) {
        KeyCont.press_nort[global.index]=false;KeyCont.press_sout[global.index]=false;
        KeyCont.press_east[global.index]=false;KeyCont.press_west[global.index]=false;
        mouse_active=false;slider_change=_toggle?1:0;pointed_item=clock_test_option1117;
        event_user(1);slider_change=0;
    }
    surface_reset_target();
    if(is_string(_screenshot)) {
        surface_save(_surface,game_directory+_screenshot);
        scrHMClockTestCheck1117(file_exists(game_directory+_screenshot),"native Video screenshot is saved");
    }
    surface_free(_surface);
    camera_destroy(_camera);matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_proj);
}

function scrHMClockTestVideoClose1117(_menu) {
    var _stack=_menu.category_stack,_had_back=_menu.clock_test_had_back1117;
    // Ordinary Destroy saves unrelated progression and restores the camera;
    // explicit scrSave below tests persistence in the isolated runner only.
    instance_destroy(_menu,false);
    if(ds_exists(_stack,ds_type_stack)) ds_stack_destroy(_stack);
    if(!_had_back) instance_destroy(BackButton,false);
}

function scrHMClockTestOption1117() {
    ds_map_delete(UberCont.saveData,"visual_hm_autoframerate");
    save_set_value("etc","language","Simplified Chinese");
    scrOptionsUpdate();
    scrHMClockTestCheck1117(UberCont.opt_hm_autoframerate
        && UberCont.saveData[? "visual_hm_autoframerate"],"missing saved option defaults to enabled");
    var _menu=scrHMClockTestVideoOpen1117();
    scrHMClockTestCheck1117(_menu.items[_menu.clock_test_option1117].value,
        "new native Video switch reads the enabled default");
    scrHMClockTestVideoEvent1117(_menu,false,"video-options117.png");
    scrHMClockTestVideoEvent1117(_menu,true,undefined);
    scrHMClockTestCheck1117(!UberCont.opt_hm_autoframerate
        && !UberCont.saveData[? "visual_hm_autoframerate"],
        "native switch submission updates runtime option and saved preference together");
    scrHMClockTestVideoClose1117(_menu);
    scrSave();
    scrHMClockTestCheck1117(file_exists(game_directory+"NuclearThrone.sav"),"native scrSave writes the isolated test save");
    var _saved=json_decode(file_read(game_directory+"NuclearThrone.sav"));
    scrHMClockTestCheck1117(ds_exists(_saved,ds_type_map)
        && ds_map_exists(_saved,"visual_hm_autoframerate")
        && !_saved[? "visual_hm_autoframerate"],"native persisted JSON retains the disabled automatic option");
    var _old_save=UberCont.saveData;
    UberCont.saveData=_saved;UberCont.opt_hm_autoframerate=true;
    ds_map_destroy(_old_save);scrOptionsUpdate();
    scrHMClockTestCheck1117(!UberCont.opt_hm_autoframerate,"reloading saved preferences retains the disabled option");
    _menu=scrHMClockTestVideoOpen1117();
    scrHMClockTestCheck1117(!_menu.items[_menu.clock_test_option1117].value,
        "reopened native Video menu displays the persisted disabled option");
    scrHMClockTestVideoClose1117(_menu);
    show_debug_message("HARDMODE CLOCK117 SAMPLE "+json_stringify({mode:mode,
        default_enabled:true,native_menu_submission:true,persisted_disabled:true,
        reloaded_disabled:true,screenshot:"video-options117.png",physical_device:false}));
    scrHMClockTestFinish1117();
}

// This always-active hook is needed because the real pause code deactivates
// HMGameplayTest along with gameplay actors. It does no work in normal runs.
function scrHMClockTestGlobalBegin1117() {
    if(!variable_global_exists("hm_clock_pause_test1117")) return;
    var _pending=global.hm_clock_pause_test1117;
    if(is_undefined(_pending) || _pending.done) return;
    var _elapsed=(get_timer()-_pending.started)/1000000;
    if(_elapsed>.15 && !_pending.changed) {
        scrHMClockTestCheck1117(UberCont.paused && !instance_exists(_pending.controller),
            "real pause has deactivated the gameplay controller and actors");
        var _menu=scrHMClockTestVideoOpen1117();
        scrHMClockTestVideoEvent1117(_menu,true,undefined);
        scrHMClockTestVideoClose1117(_menu);
        with(UberCont) scrHMClockBegin1117();
        scrHMClockTestCheck1117(!UberCont.opt_hm_autoframerate
            && !UberCont.saveData[? "visual_hm_autoframerate"],
            "native Video event disables automatic fallback during a real pause");
        scrHMClockTestCheck1117(UberCont.paused && game_get_speed(gamespeed_fps)==30,
            "disabling fallback while truly paused defers the physical rebase until gameplay is active");
        _pending.changed=true;
    }
    if(_elapsed>.45 && _pending.changed) {
        scrHMClockTestPauseTrace1117("before_native_unpause",_pending);
        scrGameUnpause();
        scrHMClockTestPauseTrace1117("immediately_after_native_unpause",_pending);
        _pending.done=true;
        if(instance_exists(_pending.controller)) {
            _pending.controller.clock_pause_resumed1117=true;
            _pending.controller.clock_pause_resume_at1117=get_timer();
        }
    }
}

function scrHMClockTestPauseTrace1117(_stage,_pending) {
    var _body=_pending.body,_seen=false,_all_count=0;
    with(all) {
        _all_count++;
        if(id==_body) _seen=true;
    }
    var _exists=instance_exists(_body),_player_exists=instance_exists(Player);
    show_debug_message("HARDMODE CLOCK117 PAUSE TRACE "+json_stringify({
        stage:_stage,current_units:current_frame,cap:game_get_speed(gamespeed_fps),time_scale:timescale,
        paused:UberCont.paused,want_pause:UberCont.want_pause,quit_pause:UberCont.quit_pause,
        body_exists:_exists,body_seen_in_all:_seen,active_count:_all_count,
        body_physical_speed:_exists?_body.speed:-1,
        player_exists:_player_exists,player_physical_cap:_player_exists?Player.maxspeed:-1,
        clock_frame:variable_instance_get(UberCont,"hm_clock_frame1117")??-999,
        physical_device:false}));
}

function scrHMClockTestBegin1117() {
    if(!scrHMClockTestActive1117() || !(self[$ "clock_ready1117"]??false)
        || clock_done1117) return;
    // The production idempotent entry point may already have run from
    // UberCont or HMWorld. Re-entry must not consume budget time twice.
    with(UberCont) scrHMClockBegin1117();
    if(mode=="clock117pause" && (self[$ "clock_pause_resumed1117"]??false)
        && (self[$ "clock_pause_traces1117"]??0)<3) {
        clock_pause_traces1117=(self[$ "clock_pause_traces1117"]??0)+1;
        scrHMClockTestPauseTrace1117("resumed_begin_"+string(clock_pause_traces1117),global.hm_clock_pause_test1117);
    }
    if(mode=="clock117auto" && clock_auto_stage1117=="load") {
        // Actual runner work, not a fabricated fps_real/state-machine input.
        // 22ms per callback is sustained overload at a requested 60 Hz.
        var _until=get_timer()+22000;
        while(get_timer()<_until) { }
    }
    if(mode=="clock117travel" && is_undefined(clock_segment1117)) {
        var _rates=[60,30,60,30,60],_rate=_rates[clock_phase1117];
        if(game_get_speed(gamespeed_fps)!=_rate) return;
        clock_move1117=true;
        clock_fresh1117=scrHMClockTestBullet1117(clock_old1117.x,clock_old1117.y-32);
        clock_segment1117={rate:_rate,units:current_frame,started:get_timer(),
            player_x:player.x,old_x:clock_old1117.x,fresh_x:clock_fresh1117.x};
    }
    if(mode=="clock117powered") {
        // The real Rocket normal Step runs before UberCont normal Step
        // advances current_frame. End Step observes the opposite half-phase;
        // record the actual native Step gate while still in Begin Step.
        clock_powered_step_active1117=current_frame_active;
        clock_powered_step_units1117=current_frame;
        if(is_undefined(clock_segment1117)) scrHMClockTestPoweredBegin1117();
    }
}

function scrHMClockTestPoweredBody1117(_kind,_x,_y,_logical_speed) {
    var _body=instance_create(_x,_y,_kind);
    with(_body) {
        // Start the real powered state immediately rather than waiting for
        // its unrelated launch-delay alarm. Preserve the native accel field
        // and execute the inherited Rocket Step on every ordinary callback.
        active=true;alarm[1]=-1;direction=0;speed=_logical_speed*timescale;
        friction=0;gravity=0;damage=0;mask_index=mskNone;
        team=team_player;creator=other.player;
    }
    return _body;
}

function scrHMClockTestPoweredBegin1117() {
    var _rates=[60,30,60],_rate=_rates[clock_phase1117];
    if(game_get_speed(gamespeed_fps)!=_rate) return;
    // The same old Rocket/JockRocket retain their accelerating flight across
    // both transactions. New native instances at each destination cap are
    // seeded with the analytic logical speed, not the old body's stored one.
    for(var _i=0;_i<array_length(clock_powered1117);++_i) {
        var _r=clock_powered1117[_i];
        scrHMClockTestCheck1117(instance_exists(_r.old),"powered native rocket survives the cap transition");
        scrHMClockTestNear1117(_r.old.speed/timescale,_r.expected_speed,
            _r.label+" retains the correct physical velocity before the next native Step");
        scrHMClockTestNear1117(_r.old.accel,_r.acceleration,
            _r.label+" logical acceleration constant is never rebased as a physical cache");
        _r.fresh=scrHMClockTestPoweredBody1117(_r.kind,_r.old.x,_r.old.y-12,_r.expected_speed);
        _r.fresh_x=_r.fresh.x;_r.fresh_expected_distance=0;
        _r.phase_old_x=_r.old.x;
        scrHMClockTestNear1117(_r.old.maxspeed,_r.fresh.maxspeed,
            _r.label+" existing and destination-rate native maximum-speed caches agree");
    }
    clock_segment1117={rate:_rate,units:current_frame,started:get_timer()};
}

function scrHMClockTestPowered1117() {
    if(is_undefined(clock_segment1117)) return;
    var _s=clock_segment1117,_units=current_frame-_s.units;
    var _lengths=[2,2,26],_advance=clock_powered_step_active1117;
    for(var _i=0;_i<array_length(clock_powered1117);++_i) {
        var _r=clock_powered1117[_i];
        scrHMClockTestCheck1117(instance_exists(_r.old) && instance_exists(_r.fresh),
            _r.label+" old and fresh native actors survive real powered flight");
        if(_advance) {
            _r.accel_ticks++;
            _r.expected_speed=min(_r.limit,_r.acceleration*_r.accel_ticks);
            _r.reference_distance+=_r.expected_speed;
        }
        _r.expected_distance+=_r.expected_speed*timescale;
        _r.fresh_expected_distance+=_r.expected_speed*timescale;
        scrHMClockTestNear1117(_r.old.speed/timescale,_r.expected_speed,
            _r.label+" native logical acceleration matches the original 30 Hz design");
        scrHMClockTestNear1117(_r.fresh.speed/timescale,_r.expected_speed,
            _r.label+" new and persistent actors accelerate at the same logical rate");
        scrHMClockTestNear1117(_r.old.accel,_r.acceleration,
            _r.label+" retained acceleration is a logical constant after each actual Step");
        scrHMClockTestCheck1117(abs(_r.old.x-_r.initial_x-_r.expected_distance)<=6.001,
            _r.label+" actual old-body displacement matches powered native integration within half a logic step");
        scrHMClockTestCheck1117(abs(_r.fresh.x-_r.fresh_x-_r.fresh_expected_distance)<=6.001,
            _r.label+" actual destination-born body displacement matches powered native integration");
        scrHMClockTestCheck1117(abs((_r.old.x-_r.phase_old_x)-(_r.fresh.x-_r.fresh_x))<=.001,
            _r.label+" existing and freshly created powered bodies travel the same actual distance");
        if(_r.first_max<0 && _r.expected_speed>=_r.limit-.000001) {
            _r.first_max=_r.accel_ticks;
            scrHMClockTestCheck1117(_r.first_max==ceil(_r.limit/_r.acceleration),
                _r.label+" first reaches native maximum speed on its original logical acceleration tick");
        }
    }
    if(_units<_lengths[clock_phase1117]) return;
    for(var _i=0;_i<array_length(clock_powered1117);++_i) {
        var _r=clock_powered1117[_i];
        show_debug_message("HARDMODE CLOCK117 SAMPLE "+json_stringify({mode:mode,
            phase:clock_phase1117,actor:_r.label,cap:_s.rate,time_scale:timescale,
            logic_units:_units,accel_ticks:_r.accel_ticks,logical_speed:_r.old.speed/timescale,
            expected_logical_speed:_r.expected_speed,maximum_logical_speed:_r.limit,
            first_max_tick:_r.first_max,old_distance:_r.old.x-_r.initial_x,
            fresh_phase_distance:_r.fresh.x-_r.fresh_x,
            expected_native_distance:_r.expected_distance,reference_30hz_distance:_r.reference_distance,
            native_step_gate:_advance,native_step_units:clock_powered_step_units1117,end_step_units:current_frame,
            wall_seconds:(get_timer()-_s.started)/1000000,physical_device:false}));
        instance_destroy(_r.fresh,false);_r.fresh=noone;
    }
    clock_phase1117++;clock_segment1117=undefined;
    if(clock_phase1117>=3) {
        for(var _i=0;_i<array_length(clock_powered1117);++_i) {
            var _r=clock_powered1117[_i];
            scrHMClockTestCheck1117(_r.first_max==ceil(_r.limit/_r.acceleration),
                _r.label+" powered flight really reaches its expected maximum velocity");
            scrHMClockTestCheck1117(abs(_r.old.x-_r.initial_x-_r.reference_distance)<=6.001,
                _r.label+" full 60/30/60 flight agrees with the original 30 Hz distance within 6 pixels");
            instance_destroy(_r.old,false);
        }
        scrHMClockTestFinish1117();return;
    }
    var _rates=[60,30,60];
    save_set_value("options","framerate",_rates[clock_phase1117]);
    UberCont.opt_framerate=_rates[clock_phase1117];
}

// Called from inside the real Player Step, after the game's input poll.
function scrHMClockTestPlayerInput1117() {
    if(!scrHMClockTestActive1117() || !(variable_instance_get(HMGameplayTest,"clock_move1117")??false)) return;
    KeyCont.moving[index]=1;KeyCont.precisemovement[index]=false;
    KeyCont.hold_east[index]=true;KeyCont.hold_west[index]=false;
    KeyCont.hold_nort[index]=false;KeyCont.hold_sout[index]=false;
    KeyCont.hold_spec[index]=false;KeyCont.hold_fire[index]=false;
}

function scrHMClockTestCache1117() {
    // These are real native/custom instances. New objects at the destination
    // rate provide the oracle for storage fields with different native units.
    var _rocket=instance_create(player.x+48,player.y+64,Rocket);
    var _spider=instance_create(player.x+96,player.y+64,Spider);
    var _slug=instance_create(player.x+144,player.y+64,HeavySlug);
    var _bubble=instance_create(player.x+192,player.y+64,Bubble);
    var _raw=instance_create(player.x+240,player.y+64,CustomObject);
    _raw.maxspeed=8;_raw.wallbounce=3;
    var _sprite=sprite_duplicate(sprBanditIdle);
    sprite_set_speed(_sprite,12,spritespeed_framespersecond);
    var _corpse=instance_create(player.x+288,player.y+64,Corpse);
    _corpse.sprite_index=_sprite;_corpse.hm_extra_death_frames1116=sprite_get_number(_sprite);
    _corpse.image_speed=scrHMDeathAnimationSpeed1116(_sprite);
    var _native=[_rocket,_spider,_slug,_bubble],_saved=[];
    for(var _i=0;_i<array_length(_native);++_i) with(_native[_i]) {
        array_push(_saved,{who:id,hs:hspeed,vs:vspeed,anim:image_speed,fric:friction,
            max:self[$ "maxspeed"]??undefined,kick:self[$ "knockback_speed"]??undefined,
            wall:self[$ "wallbounce"]??undefined});
    }
    var _pmax=player.maxspeed,_acc=HMWorld.logic_accumulator,_alarmacc=global.alarm_topup_acc;
    scrHMClockTestApply1117(30);
    var _fresh_rocket=instance_create(player.x+48,player.y+96,Rocket);
    var _fresh_spider=instance_create(player.x+96,player.y+96,Spider);
    var _fresh_slug=instance_create(player.x+144,player.y+96,HeavySlug);
    var _fresh_bubble=instance_create(player.x+192,player.y+96,Bubble);
    scrHMClockTestNear1117(player.maxspeed,_pmax*2,"native persistent Player cached cap is rebased");
    scrHMClockTestNear1117(_rocket.maxspeed,_fresh_rocket.maxspeed,"existing/new native Rocket caps agree");
    scrHMClockTestNear1117(_rocket.knockback_speed,_fresh_rocket.knockback_speed,"existing/new Rocket knockback agrees");
    scrHMClockTestNear1117(_spider.maxspeed,_fresh_spider.maxspeed,"existing/new Spider caps agree");
    scrHMClockTestNear1117(_slug.wallbounce,_fresh_slug.wallbounce,"existing/new HeavySlug bounce impulse agrees");
    scrHMClockTestNear1117(_bubble.gravity,_fresh_bubble.gravity,"existing/new Bubble gravity uses the same storage convention");
    scrHMClockTestNear1117(_raw.maxspeed,8,"custom logical-unit maxspeed is not rebased as a native cap");
    scrHMClockTestNear1117(_raw.wallbounce,3,"custom logical-unit wallbounce is retained");
    scrHMClockTestNear1117(_corpse.image_speed,1,"FPS death sprite is not time-scaled twice");
    scrHMClockTestNear1117(HMWorld.logic_accumulator,_acc,"transaction preserves pending logical remainder");
    scrHMClockTestNear1117(global.alarm_topup_acc,_alarmacc,"transaction preserves native Alarm remainder");
    scrHMClockTestApply1117(60);
    scrHMClockTestNear1117(player.maxspeed,_pmax,"round trip restores cached Player cap");
    for(var _i=0;_i<array_length(_saved);++_i) {
        var _s=_saved[_i];
        scrHMClockTestNear1117(_s.who.hspeed,_s.hs,"round trip preserves horizontal velocity");
        scrHMClockTestNear1117(_s.who.vspeed,_s.vs,"round trip preserves vertical velocity");
        scrHMClockTestNear1117(_s.who.friction,_s.fric,"round trip preserves friction");
    }
    var _cleanup=[_rocket,_spider,_slug,_bubble,_raw,_corpse,
        _fresh_rocket,_fresh_spider,_fresh_slug,_fresh_bubble];
    for(var _i=0;_i<array_length(_cleanup);++_i) instance_destroy(_cleanup[_i],false);
    sprite_delete(_sprite);
    scrHMClockTestFinish1117();
}

function scrHMClockTestTravel1117() {
    if(is_undefined(clock_segment1117)) return;
    var _s=clock_segment1117,_units=current_frame-_s.units;
    if(_units<60) return;
    scrHMClockTestCheck1117(instance_exists(clock_old1117)&&instance_exists(clock_fresh1117),
        "old and newly created projectiles survive actual cross-rate physics");
    var _old=clock_old1117.x-_s.old_x,_fresh=clock_fresh1117.x-_s.fresh_x;
    var _distance=player.x-_s.player_x,_wall=(get_timer()-_s.started)/1000000;
    scrHMClockTestCheck1117(abs(_old-6*_units)<.1 && abs(_fresh-6*_units)<.1,
        "old/new bullets travel the same native world distance per real logical second");
    // Native friction integration differs slightly between 30 and 60; a broad
    // 15% comparison rejects the reported persistent 50% movement regression.
    scrHMClockTestCheck1117(_distance/_units>3 && _distance/_units<4.2,
        "real held-input Player keeps its ordinary movement speed");
    if(array_length(clock_samples1117)>0) {
        var _reference=clock_samples1117[0].player_per_unit;
        scrHMClockTestCheck1117(abs((_distance/_units)/_reference-1)<.15,
            "changing callback rate never leaves the persistent Player at half speed");
    }
    var _row={mode:mode,phase:clock_phase1117,cap:_s.rate,time_scale:timescale,
        wall_seconds:_wall,logic_units:_units,player_distance:_distance,
        player_per_unit:_distance/_units,old_bullet_distance:_old,fresh_bullet_distance:_fresh,
        physical_device:false};
    array_push(clock_samples1117,_row);
    show_debug_message("HARDMODE CLOCK117 SAMPLE "+json_stringify(_row));
    instance_destroy(clock_fresh1117,false);clock_fresh1117=noone;
    clock_phase1117++;clock_segment1117=undefined;
    if(clock_phase1117>=5) {clock_move1117=false;scrHMClockTestFinish1117();return;}
    var _rates=[60,30,60,30,60];
    UberCont.opt_framerate=_rates[clock_phase1117];
}

function scrHMClockTestFreeze1117() {
    if(clock_frames1117==2) {
        // Use the real constructor: HMWorld draws every bossintro and expects
        // the complete presentation contract, and this also invokes Freeze.
        hm_bosses_bossintros_mod_gml_boss_trigger("",mskNone,mskNone,mskNone,player,0);
        clock_intro1117=HMWorld.hm_portrait_active;
        scrHMClockTestCheck1117(instance_exists(clock_intro1117),
            "real boss constructor creates the production presentation owner");
        scrHMClockTestCheck1117(clock_intro1117.name=="bossintro"
            && variable_instance_exists(clock_intro1117,"hm_portrait_records")
            && array_length(clock_intro1117.hm_portrait_records)>0,
            "real boss constructor stores the freeze records on its intro");
        scrHMClockTestCheck1117(variable_instance_exists(clock_old1117,"hm_portrait_frozen")
            && clock_old1117.hm_portrait_frozen
            && clock_old1117.speed==0,
            "native bullet is really frozen by the production boss freeze");
        UberCont.opt_framerate=30;
    }
    if(clock_frames1117==6) {
        scrHMClockTestCheck1117(game_get_speed(gamespeed_fps)==30,"rate transition completes while the actual boss freeze is active");
        with(clock_intro1117) scrHMBossRestore104();
        instance_destroy(clock_intro1117,false);
        scrHMClockTestNear1117(clock_old1117.speed/timescale,6,"boss restore uses the destination physical velocity units");
        clock_segment1117={units:current_frame,started:get_timer(),old_x:clock_old1117.x};
    }
    if(clock_frames1117>6 && !is_undefined(clock_segment1117)) {
        var _s=clock_segment1117,_units=current_frame-_s.units;
        if(_units>=60) {
            var _distance=clock_old1117.x-_s.old_x;
            scrHMClockTestCheck1117(abs(_distance-6*_units)<.1,
                "restored frozen projectile really travels at its pre-freeze world speed");
            show_debug_message("HARDMODE CLOCK117 SAMPLE "+json_stringify({mode:mode,
                cap:game_get_speed(gamespeed_fps),wall_seconds:(get_timer()-_s.started)/1000000,
                logic_units:_units,old_bullet_distance:_distance,physical_device:false}));
            scrHMClockTestFinish1117();
        }
    }
}

function scrHMClockTestPause1117() {
    if(clock_frames1117==2) {
        clock_pause_resumed1117=false;
        global.hm_clock_pause_test1117={controller:id,body:clock_old1117,
            started:get_timer(),changed:false,done:false};
        scrHMClockTestPauseTrace1117("before_native_pause",global.hm_clock_pause_test1117);
        scrGamePause();
    }
    if(!(self[$ "clock_pause_resumed1117"]??false) || game_get_speed(gamespeed_fps)!=60) return;
    if(is_undefined(clock_segment1117)) {
        scrHMClockTestNear1117(clock_old1117.speed/timescale,6,"inactive bullet is rebased after real unpause activation");
        scrHMClockTestNear1117(player.maxspeed/timescale,4,"inactive Player cap is rebased after real unpause activation");
        scrHMClockTestCheck1117(!UberCont.opt_hm_autoframerate
            && UberCont.opt_framerate==60,"resume restores the requested cap while retaining the disabled option");
        clock_move1117=true;
        clock_segment1117={units:current_frame,started:get_timer(),old_x:clock_old1117.x,player_x:player.x};
        return;
    }
    var _s=clock_segment1117,_units=current_frame-_s.units;
    if(_units<60) return;
    var _distance=clock_old1117.x-_s.old_x,_player_distance=player.x-_s.player_x;
    scrHMClockTestCheck1117(abs(_distance-6*_units)<.1 && _player_distance/_units>3,
        "unpaused existing bullet and persistent Player retain their actual world motion");
    show_debug_message("HARDMODE CLOCK117 SAMPLE "+json_stringify({mode:mode,
        cap:game_get_speed(gamespeed_fps),wall_seconds:(get_timer()-_s.started)/1000000,
        logic_units:_units,old_bullet_distance:_distance,player_distance:_player_distance,physical_device:false}));
    clock_move1117=false;scrHMClockTestFinish1117();
}

function scrHMClockTestPhase1117() {
    if(clock_frames1117==2) {
        HMWorld.logic_accumulator=.5;global.alarm_topup_acc=.5;
        clock_phase_start1117=current_frame;clock_phase_serial1117=HMWorld.logic_serial;
        clock_phase_frames1117=0;clock_phase_compensation1117=.5;
        // A native alarm only decrements when its object has that Alarm event.
        // Rocket has Alarm 1; CustomObject has none and cannot be an oracle.
        clock_alarm1117=instance_create(player.x,player.y-64,Rocket);
        with(clock_alarm1117) {
            active=false;speed=0;friction=0;gravity=0;
            mask_index=mskNone;damage=0;image_speed=0;
            for(var _alarm=0;_alarm<12;++_alarm) alarm[_alarm]=-1;
            alarm[1]=1000;
        }
        UberCont.opt_framerate=30;return;
    }
    if(clock_frames1117<=2) return;
    clock_phase_frames1117++;clock_phase_compensation1117+=1-timescale;
    var _units=current_frame-clock_phase_start1117;
    scrHMClockTestCheck1117(HMWorld.logic_serial-clock_phase_serial1117==floor(.5+_units+.000001),
        "frequent real rate transitions preserve HMWorld logical phase without lost ticks");
    scrHMClockTestNear1117(global.alarm_topup_acc,frac(clock_phase_compensation1117),
        "native Alarm compensation keeps fractional phase through rate transitions");
    scrHMClockTestNear1117(clock_alarm1117.alarm[1],
        1000-clock_phase_frames1117+floor(clock_phase_compensation1117),
        "actual engine Alarm decrement agrees with the retained compensation phase");
    if(clock_phase_frames1117 mod 7==0)
        UberCont.opt_framerate=(UberCont.opt_framerate==60)?30:60;
    if(clock_phase_frames1117>=90) scrHMClockTestFinish1117();
}

function scrHMClockTestAuto1117() {
    var _elapsed=(get_timer()-clock_auto_stage_at1117)/1000000;
    var _cap=game_get_speed(gamespeed_fps);
    if(clock_auto_stage1117=="warm" && _elapsed>=1) {
        clock_auto_stage1117="load";clock_auto_stage_at1117=get_timer();
    } else if(clock_auto_stage1117=="load") {
        if(_cap==30) {
            clock_auto_low_seen1117=true;clock_auto_stage1117="clear";
            clock_auto_clear_at1117=get_timer();clock_auto_stage_at1117=get_timer();
            clock_auto_x1117=clock_old1117.x;clock_auto_units1117=current_frame;
        } else scrHMClockTestCheck1117(_elapsed<5,"real sustained overload activates automatic native-rate fallback");
    } else if(clock_auto_stage1117=="clear") {
        var _units=current_frame-clock_auto_units1117;
        scrHMClockTestCheck1117(abs(clock_old1117.x-clock_auto_x1117-6*_units)<.1,
            "old bullet retains native motion through the real automatic fallback and recovery probe");
        if(_cap==60 && _elapsed>7) {
            scrHMClockTestCheck1117(UberCont.opt_framerate==60&&clock_auto_low_seen1117,
                "real budget recovery restores the saved target after measured overload ends");
            show_debug_message("HARDMODE CLOCK117 SAMPLE "+json_stringify({mode:mode,
                recovery_seconds:_elapsed,cap:_cap,logic_units:_units,
                old_bullet_distance:clock_old1117.x-clock_auto_x1117,physical_device:false}));
            scrHMClockTestFinish1117();
        } else scrHMClockTestCheck1117(_elapsed<12,"real automatic recovery completes within twelve seconds");
    }
}

function scrHMClockTestEnd1117() {
    if(!scrHMClockTestActive1117()) return;
    if(!(self[$ "clock_ready1117"]??false)) {
        if(instance_exists(GenCont) || ticks<20 || instance_number(Floor)<5) return;
        scrHMClockTestInit1117();return;
    }
    if(clock_done1117) return;
    clock_frames1117++;
    switch(mode) {
        case "clock117cache": if(clock_frames1117==2) scrHMClockTestCache1117();break;
        case "clock117travel": scrHMClockTestTravel1117();break;
        case "clock117freeze": scrHMClockTestFreeze1117();break;
        case "clock117pause": scrHMClockTestPause1117();break;
        case "clock117phase": scrHMClockTestPhase1117();break;
        case "clock117auto": scrHMClockTestAuto1117();break;
        case "clock117option": if(clock_frames1117==2) scrHMClockTestOption1117();break;
        case "clock117powered": scrHMClockTestPowered1117();break;
    }
    scrHMClockTestCheck1117(ticks<goal_ticks-1 || clock_done1117,
        "clock scenario must complete before the generic runner reaches its success deadline");
}
