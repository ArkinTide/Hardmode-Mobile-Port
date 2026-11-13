// Independent production-path regressions. Registered and run by release1107.
function scrHMGameplayPresentation1117() {
    if(string_pos("presentation117",mode)!=1) return;
    scrHMGameplayPresentationFrame1117();
    // scrHMGameplayTestStep keeps ticks unchanged while the real room
    // generator runs. Do not redispatch a tick's actions during that wait.
    if(instance_exists(GenCont)) return;
    if(!instance_exists(HMWorld) || !HMWorld.logic_tick) return;
    if(ticks==1) {
        UberCont.opt_bossintro=0;UberCont.opt_shake=0;
        with(CustomObject) if(name=="hm_native_controller") {
            hm_gungod_rolled=true;hm_gungod_replaced=false;
        }
    }
    if(mode=="presentation117phase") scrHMGameplayPhase1117();
    if(mode=="presentation117titles") {
        if(ticks==20) {
            scrHMGameplayLane107();scrHMGameplayNoReplacement1115();
            scrHMGameplayCheck(scrHMChinese(),"portrait-title fixture uses the real Simplified Chinese language selection");
            title_native1117=[];title_custom1117=[];title_captured1117=false;
            var _kinds=["bandit","dog","hunter","throne","throne2","mother","crystal","tech","chief","crystal","yv","gungod"];
            var _expected=["大匪","大狗","小猎人","核能王座","王座II","母亲","超能水晶","科技术士","局长","诅咒超级水晶","Y.V","枪神"];
            for(var _i=0;_i<12;++_i) {
                var _actor=instance_create(0,0,CustomObject),_index=min(10,_i);
                _actor.name="hm_title_fixture1117";_actor.hm_boss_kind115=_kinds[_i];
                scrHMBossNativeAttach1116(_actor,_index);
                _actor.hm_native_age1116=12;_actor.hm_native_x1116=16;
                _actor.hm_native_splat1116=3;
                array_push(title_native1117,{actor:_actor,index:_index,kind:_kinds[_i],expected:_expected[_i]});
            }
            var _sources=["BIG BANDIT","BIG DOG","BIG BUBBLER","BIG BIRD","GRAND SCORPION","GREATER GUARDIAN",
                "SUPER GATOR","TURTLES","TITANK","The#Messenger","THE#THRONE","HYPER#CRYSTAL",
                "CURSED#HYPER#CRYSTAL","MUTANT RAT","DA GUN GOD","Y.V"];
            for(var _i=0;_i<array_length(_sources);++_i) {
                var _label=scrHMBossPortraitLabel1117(_sources[_i]);
                scrHMGameplayCheck(_label!=_sources[_i] || _label=="Y.V",
                    "every actual custom portrait title resolves through the Chinese atlas: "+_sources[_i]);
                array_push(title_custom1117,{source:_sources[_i],label:_label});
            }
        }
        if(ticks==40) {
            scrHMGameplayCheck(title_captured1117,"both contact sheets come from actual native/custom title Draw paths");
            show_debug_message("HARDMODE PRESENTATION117 TITLES "+json_stringify({native:title_native_labels1117,
                custom:title_custom1117,language:UberCont.opt_language,rate:rate}));
        }
    }
    if(string_pos("presentation117timing",mode)==1) scrHMGameplayPresentationTiming1117();
    if(string_pos("presentation117flower",mode)==1) scrHMGameplayFlower1117();
}

function scrHMGameplayPhase1117() {
    if(ticks==20) {
        scrHMGameplayLane107();scrHMGameplayNoReplacement1115();HMWorld.hm_boss_room115="";
        UberCont.opt_bossintro=1;scrHMModSet("mod","options","intropan","1");
        scrHMModSet("mod","options","bossoutros","1");
        phase_hull1117=hm_bosses_gungod_mod_gml_GunGod_create(player.x+200,player.y-40);
        with(phase_hull1117) scrBossIntro(10,true);
        phase_first_group1117=scrHMBossGroups115()[$ "gungod"];
        phase_second1117=noone;phase_second_group1117=undefined;
        scrHMGameplayCheck(!is_undefined(phase_first_group1117) && phase_first_group1117.entry_count==1,
            "real helicopter entry registers exactly one production presentation");
    }
    if(ticks==150) {
        scrHMGameplayCheck(instance_exists(phase_hull1117) && !instance_exists(HMWorld.hm_portrait_active),
            "the real first-phase portrait finishes before applying lethal combat damage");
        scr_hit(phase_hull1117,100000,HitId.Player);
        scrHMGameplayCheck(phase_hull1117.hm_gungod_departed && phase_first_group1117.phase_transition1117
            && phase_first_group1117.exit_count==0,"actual GunGod hurt retires the first phase without an exit camera");
    }
    if(ticks>150) {
        with(CustomEnemy) if(array_contains(["gungod","hm_yv_phase"],name) && hp>0) {
            other.phase_second1117=id;
        }
        if(instance_exists(phase_second1117)) {
            var _kind=GameCont.loops>0?"yvphase":"gungod";
            var _group=scrHMBossGroups115()[$ _kind];
            if(!is_undefined(_group)) phase_second_group1117=_group;
        }
        var _active=HMWorld.hm_portrait_active;
        scrHMGameplayCheck(!instance_exists(_active) || !(_active[$ "hm_boss_exit115"]??false),
            "live phase handoff never starts a first-phase death presentation");
    }
    if(ticks==350) {
        scrHMGameplayCheck(instance_exists(phase_second1117) && !is_undefined(phase_second_group1117),
            "real landing actor creates and registers the actual second-phase combat actor");
        scrHMGameplayCheck(phase_first_group1117.exit_count==0 && phase_second_group1117.entry_count==1
            && phase_second_group1117.exit_count==0 && !instance_exists(HMWorld.hm_portrait_active),
            "phase two gets one entrance and neither phase receives a false death scene");
        show_debug_message("HARDMODE PRESENTATION117 PHASE "+json_stringify({loop:GameCont.loops,rate:rate,
            phase1_exit_count:phase_first_group1117.exit_count,phase2_entry_count:phase_second_group1117.entry_count,
            phase2_exit_count:phase_second_group1117.exit_count,phase2_kind:phase_second_group1117.kind}));
    }
}

function scrHMGameplayPresentationTiming1117() {
    if(ticks==20) {
        scrHMGameplayLane107();scrHMGameplayNoReplacement1115();HMWorld.hm_boss_room115="";
        GameCont.subarea=3;UberCont.opt_hm_autoframerate=false;
        UberCont.opt_bossintro=1;scrHMModSet("mod","options","intropan","1");
        scrHMModSet("mod","options","bossoutros","1");
        timing_actor1117=instance_create(player.x+240,player.y-40,BanditBoss);
        with(timing_actor1117) {intro=1;newintro=-1;speed=0;for(var _i=0;_i<12;++_i) alarm[_i]=-1;scrBossIntro(0,true);}
        timing_intro1117=HMWorld.hm_portrait_active;
        timing_start1117=get_timer();timing_all_start1117=timing_start1117;timing_stage1117=1;
        timing_distance1117=point_distance(view_xview_center,view_yview_center,timing_intro1117.x,timing_intro1117.y);
        timing_target1117=[timing_intro1117.x,timing_intro1117.y];
        timing_callbacks1117=0;timing_durations1117=[];timing_errors1117=[];timing_done1117=false;
        scrHMGameplayCheck(instance_exists(timing_intro1117) && timing_intro1117.x==timing_actor1117.x
            && timing_intro1117.y==timing_actor1117.y,"entry controller focuses the actual boss position");
    }
    if((self[$ "timing_stage1117"]??0)>0 && !instance_exists(timing_intro1117)) {
        var _elapsed=(get_timer()-timing_start1117)/1000000;
        scrHMGameplayCheck(_elapsed>1.6 && _elapsed<2.65,
            "real entrance/departure duration follows two seconds of unpaused wall time at the actual callback rate");
        array_push(timing_durations1117,_elapsed);
        var _error=point_distance(view_xview_center,view_yview_center,timing_target1117[0],timing_target1117[1]);
        array_push(timing_errors1117,_error);
        scrHMGameplayCheck(_error<max(48,timing_distance1117*.02),
            "real camera reaches the same encounter focus within two seconds even below thirty callbacks per second");
        scrHMGameplayCheck(!player.hm_portrait_frozen && player.can_walk,
            "wall-clock presentation restores the original player state exactly once");
        if(timing_stage1117==1) {
            timing_actor1117.x=player.x+320;timing_actor1117.y=player.y-80;
            timing_death1117=[timing_actor1117.x,timing_actor1117.y];
            with(timing_actor1117) {hp=0;instance_destroy();}
            scrHMBossGroupTick115();timing_intro1117=HMWorld.hm_portrait_active;
            scrHMGameplayCheck(instance_exists(timing_intro1117) && timing_intro1117.hm_boss_exit115
                && timing_intro1117.x==timing_death1117[0] && timing_intro1117.y==timing_death1117[1],
                "last native Destroy keeps the departure target at the precise final boss position");
            timing_start1117=get_timer();timing_stage1117=2;timing_target1117=timing_death1117;
            timing_distance1117=point_distance(view_xview_center,view_yview_center,timing_intro1117.x,timing_intro1117.y);
        } else {
            timing_stage1117=0;timing_done1117=true;
            var _wall=(get_timer()-timing_all_start1117)/1000000;
            var _actual_fps=timing_callbacks1117/max(.001,_wall);
            if(mode=="presentation117timing20") scrHMGameplayCheck(_actual_fps<22,
                "the artificial load really reduces physical callbacks below twenty-two per second");
            show_debug_message("HARDMODE PRESENTATION117 TIMING "+json_stringify({mode:mode,rate:rate,
                durations:timing_durations1117,actual_callbacks:timing_callbacks1117,
                artificial_callback_cap:mode=="presentation117timing20"?20:rate,
                actual_callback_fps:_actual_fps,wall_seconds:_wall,focus_errors:timing_errors1117,
                final_focus:timing_death1117}));
            goal_ticks=ticks;
        }
    }
    if(ticks==goal_ticks) scrHMGameplayCheck(timing_done1117,"both real presentation controllers finish before the timing deadline");
}

// Physical End Step hook: impose actual callback load without changing the
// native simulation timestep. This is only active for this isolated fixture.
function scrHMGameplayPresentationFrame1117() {
    if(string_pos("presentation117timing",mode)!=1 || !(self[$ "timing_stage1117"]??0)) return;
    timing_callbacks1117++;
    if(mode=="presentation117timing20") {
        var _until=get_timer()+50000;
        while(get_timer()<_until) {} // Reproducible real 20-callback overload.
    }
}

function scrHMGameplayFlower1117() {
    var _wish=mode=="presentation117flowerwish";
    if(ticks==1 && !(self[$ "flower_bootstrapped1117"]??false)) {
        flower_bootstrapped1117=true;
        scrHMSetSkill(18,_wish?1:0);ready_age=-1;
        // A same-stage regeneration must use the host's ordinary no-advance
        // contract; the initial room entry has already consumed that flag.
        GameCont.can_advance_stage=false;room_restart();
        flower_seen1117=false;flower_first1117=noone;flower_late1117=false;
    }
    if(ticks==20) scrHMGameplayNoReplacement1115();
    if(ticks>=20) {
        var _count=0,_actor=noone;
        with(CustomHitme) if(name=="   feed") {_count++;_actor=id;}
        scrHMGameplayCheck(_count<=1,"natural generation and delayed excavation never expose two usable final-cave flowers");
        if(instance_exists(_actor)) {
            flower_seen1117=true;
            if(!instance_exists(flower_first1117)) flower_first1117=_actor;
            scrHMGameplayCheck(_actor==flower_first1117,"late entrance requests keep the same live flower and its interaction state");
            var _patch=0,_cx=_actor.x,_cy=_actor.y;
            with(Floor) if(point_distance(x+16,y+16,_cx,_cy)<52 && sprite_index==sprFloor105) _patch++;
            with(FloorExplo) if(point_distance(x+8,y+8,_cx,_cy)<52 && sprite_index==sprFloor105) _patch++;
            scrHMGameplayCheck(_patch>0,"the sole flower always stands on original jungle-style floor with or without Last Wish");
            if(!flower_late1117 && ticks>=170) {
                var _floors=instance_number(Floor),_exploded=instance_number(FloorExplo);
                var _again=hm_props_mod_gml_Flower_create(_actor.x+120,_actor.y);
                scrHMGameplayCheck(_again==_actor && instance_number(Floor)==_floors && instance_number(FloorExplo)==_exploded,
                    "repeated production factory returns the same flower without deleting any floor geometry");
                hm_props_mod_gml_cave_create(_actor.x+32,_actor.y);
                flower_late1117=true;
            }
        }
    }
    if(ticks==350) {
        scrHMGameplayCheck(flower_seen1117 && flower_late1117 && instance_exists(flower_first1117)
            && array_length(scrHMMatching(CustomHitme,"name","   feed"))==1,
            "late native excavation finishes with exactly one persistent flower and jungle floor");
        show_debug_message("HARDMODE PRESENTATION117 FLOWER "+json_stringify({area:GameCont.area,rate:rate,
            last_wish:_wish,count:array_length(scrHMMatching(CustomHitme,"name","   feed")),
            jungle_floor:flower_first1117.hm_flower_floor1117,late_excavation:flower_late1117}));
        flower_capture_pending1117=true;
    }
    if(ticks==310 && instance_exists(flower_first1117)) {
        var _floor=instance_nearest(flower_first1117.x,flower_first1117.y+64,Floor);
        if(instance_exists(_floor)) {player.x=_floor.x+16;player.y=_floor.y+16;player.speed=0;}
        KeyCont.dis_fire[player.index]=0;
        with(BackCont) force_snap_camera_position=true;
    }
    if(ticks==380) scrHMGameplayCheck(self[$ "flower_captured1117"]??false,
        "actual gameplay camera captures the sole flower and its existing jungle floor after the late excavation finishes");
}

function scrHMGameplayPresentationDraw1117() {
    if(string_pos("presentation117flower",mode)==1 && (self[$ "flower_capture_pending1117"]??false)
        && !(self[$ "flower_captured1117"]??false) && surface_exists(application_surface)) {
        surface_save(application_surface,game_directory+"presentation117-flower.png");
        flower_captured1117=true;flower_capture_pending1117=false;
    }
    if(mode!="presentation117titles" || ticks<25 || (self[$ "title_captured1117"]??false)) return;
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection);
    var _font=draw_get_font(),_color=draw_get_color(),_alpha=draw_get_alpha();
    var _ha=draw_get_halign(),_va=draw_get_valign();
    var _surface=surface_create(view_width*4,view_height*3);
    var _camera=camera_create_view(0,0,view_width*4,view_height*3,0,noone,-1,-1,0,0);
    surface_set_target(_surface);draw_clear(c_black);title_native_labels1117=[];
    matrix_set(matrix_world,matrix_build_identity());camera_apply(_camera);
    for(var _i=0;_i<array_length(title_native1117);++_i) {
        var _record=title_native1117[_i];
        matrix_set(matrix_world,matrix_build((_i mod 4)*view_width,(_i div 4)*view_height,0,0,0,0,1,1,1));
        with(_record.actor) scrHMBossNativeDraw1116();
        scrHMGameplayCheck(_record.actor.hm_native_title1117==_record.expected,
            "actual native title Draw uses its expected Chinese name, including the Y.V exception: index="
            +string(_record.index)+" kind="+_record.kind+" actual="+string(_record.actor.hm_native_title1117)
            +" expected="+_record.expected);
        array_push(title_native_labels1117,{index:_record.index,kind:_record.kind,label:_record.actor.hm_native_title1117});
    }
    surface_reset_target();matrix_set(matrix_world,_world);
    surface_save(_surface,game_directory+"presentation117-native-titles.png");surface_free(_surface);
    _surface=surface_create(720,480);surface_set_target(_surface);draw_clear(make_color_rgb(34,28,30));
    camera_set_view_size(_camera,720,480);matrix_set(matrix_world,matrix_build_identity());camera_apply(_camera);
    for(var _i=0;_i<array_length(title_custom1117);++_i) {
        var _record=title_custom1117[_i];
        matrix_set(matrix_world,matrix_build((_i mod 4)*180,(_i div 4)*120,0,0,0,0,1,1,1));
        draw_sprite(sprBossNameSplat,3,70,50);draw_set_halign(fa_center);draw_set_valign(fa_top);
        scrHMReportIntroDraw1103(90,44,_record.source);
        scrHMGameplayCheck(hm_custom_title1117==_record.label,
            "actual custom portrait title renderer selects the translated text rather than Latin-only sprite glyphs");
    }
    surface_reset_target();matrix_set(matrix_world,_world);
    surface_save(_surface,game_directory+"presentation117-custom-titles.png");surface_free(_surface);
    camera_destroy(_camera);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
    draw_set_font(_font);draw_set_color(_color);draw_set_alpha(_alpha);
    draw_set_halign(_ha);draw_set_valign(_va);title_captured1117=true;
}
