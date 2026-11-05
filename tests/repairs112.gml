function scrHMGameplayRepairs112() {
    if(mode=="jungleentry112" || mode=="junglepending112") scrHMGameplayJungle112();
    if(mode=="motion112") scrHMGameplayMobile112();
    if(ticks==1) scrHMGameplayCheck(variable_global_exists("hm_desktop_clock112")&&global.hm_desktop_clock112,
        "Windows clock is configured at startup before Hardmode initialization");
    if(mode=="live112") {
        if(ticks==1) {
            scrHMGameplayLane107();UberCont.opt_keyboard=true;UberCont.opt_gamepad=false;
            player.can_swap=true;player.wep=wep_revolver;player.bwep=wep_shotgun;
            live_wep112=player.wep;
        }
        if(player.wep!=live_wep112) {
            live_swaps112=(self[$ "live_swaps112"]??0)+1;
            show_debug_message("WHEEL112 SWAPPED "+string(player.wep));live_wep112=player.wep;
        }
        window_set_caption("Hardmode isolated silent input probe 1.0.12 | weapon "+string(player.wep));
        if(ticks mod 3==0) {
            var _file=file_text_open_write(game_directory+"live-state112.json");
            file_text_write_string(_file,json_stringify({weapon:player.wep,ticks:ticks,
                events:self[$ "live_events112"]??0,swaps:self[$ "live_swaps112"]??0,
                allowed:scrDesktopWheelAllowed111(),can_swap:player.can_swap,
                pending:KeyCont.wheel_pending111[0],keyboard:UberCont.opt_keyboard,
                pause:UberCont.paused,console:global.console_active}));file_text_close(_file);
        }
    }
    if(mode=="water112" && ticks==30) {
        scrHMGameplayLane107();
        var _f=instance_create(16000,16000,Floor);_f.traction=2;
        var _surface=instance_create(_f.x,_f.y,CustomObject);
        _surface.name="sewagefloor";_surface.sprite_index=sprHM_areas_sewers_area_4;
        _surface.image_xscale=.8;_surface.image_yscale=.8;
        with(_surface) scrHMWaterSurface111();HMWorld.hm_water_map=undefined;
        player.x=16016;player.y=16016;player.speed=0;
        with(player) scrHMSwimPlayer105();
        scrHMGameplayCheck(player[$ "swimming"]??false,"actual interior water allows swimming");
        for(var _i=0;_i<4;++_i) {
            player.x=16016;player.y=16016;
            switch(_i) {case 0:player.x=16001;break;case 1:player.x=16031;break;case 2:player.y=16001;break;case 3:player.y=16031;break;}
            with(player) scrHMSwimPlayer105();
            scrHMGameplayCheck(!(player[$ "swimming"]??false)&&player.image_alpha==1,"feet partly supported by the bank stay dry on side "+string(_i));
        }
        _surface.sprite_index=sprHM_areas_sewers_area_3;
        player.x=16016;player.y=16007;
        with(player) scrHMSwimPlayer105();
        scrHMGameplayCheck(!player.swimming,"top bank plus foot-contact margin does not trigger swimming");
        player.y=16016;with(player) scrHMSwimPlayer105();
        scrHMGameplayCheck(player.swimming,"top-bank exclusion retains actual deep water");
        instance_destroy(_surface,false);
        with(player) scrHMSwimPlayer105();
        scrHMGameplayCheck(!player.swimming,"stale wet floor without visible water has no splash/swimming");
        instance_destroy(_f,false);
    }
    if(mode=="waterbank112" && ticks==25) {
        // Keep real generated water, surfaces and floor geometry intact.
        with(enemy) instance_destroy(id,false);
        with(projectile) instance_destroy(id,false);
        with(Portal) instance_destroy(id,false);
        bank_surface112=noone;
        with(CustomObject) if(name=="sewagefloor" && sprite_index==sprHM_areas_sewers_area_3
            && scrHMSwimSupported112(x+16,y+16) && !scrHMSwimSupported112(x+16,y+4)) {
            other.bank_surface112=id;break;
        }
        scrHMGameplayCheck(instance_exists(bank_surface112),"generated map contains a visible shoreline with dry bank and actual water");
        player.x=bank_surface112.x+16;player.y=bank_surface112.y+4;player.speed=0;
        with(player) scrHMSwimPlayer105();
        scrHMGameplayCheck(!(player[$ "swimming"]??false)&&player.image_alpha==1,"actual generated shoreline keeps player on dry bank");
        BackCont.force_snap_camera_position=true;
    }
    if(mode=="waterbank112" && ticks==35) {
        surface_save(application_surface,game_directory+"shore112-bank.png");
        player.x=bank_surface112.x+16;player.y=bank_surface112.y+16;player.speed=0;
        with(player) scrHMSwimPlayer105();
        scrHMGameplayCheck(player.swimming,"moving from generated bank to deep water starts swimming");
    }
    if(mode=="waterbank112" && ticks==45) {
        surface_save(application_surface,game_directory+"shore112-water.png");
        player.x=bank_surface112.x+16;player.y=bank_surface112.y+4;player.speed=0;
        with(player) scrHMSwimPlayer105();
        scrHMGameplayCheck(!player.swimming&&player.image_alpha==1,"return from water to the real bank restores body immediately");
    }
    if(mode=="music112" && room_ticks==25) {
        var _room=self[$ "music_room112"]??0;
        var _songs=[mus3b,mus3b,mus4,mus5,mus7];
        scrHMGameplayCheck(MusCont.song==_songs[_room]&&audio_is_playing(_songs[_room]),"real room transition selects expected area music "+string(_room));
        if(_room>=2) scrHMGameplayCheck(!audio_is_playing(mus3b),"junkyard track is stopped after leaving its area");
        music_room112=_room+1;
        if(_room<4) {
            var _areas=["junkyard","caves","city","palace"];
            var _subs=[5,1,1,1];
            scrHMGameplayCheck(scrHMConsoleGoto(_areas[_room],_subs[_room],0),"room lifecycle accepts next music destination");
        }
    }
    if(mode=="caveextra112" && ticks>=10 && !(self[$ "cave_started112"]??false)
        && !instance_exists(HMWorld.hm_portrait_active) && !(player[$ "hm_portrait_frozen"]??false)) {
        cave_started112=true;cave_start112=ticks;
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("cavesinv") && !instance_exists(HyperCrystal),
            "non-final cursed room retains its identity before extra-boss regression");
        scrHMGameplayLane107();cave_extras112=[];
        var _kinds=["crystal","cursedcrystal"];
        for(var _i=0;_i<array_length(_kinds);++_i) {
            var _extra=hm_arkintide_mod_gml_hm_extra_spawn(_kinds[_i],14256+_i*128,14192);
            scrHMGameplayCheck(instance_exists(_extra) && _extra.object_index==CustomEnemy
                && (_extra[$ "hm_extra"]??false) && _extra.hp>0,
                "real extra HyperCrystal constructor leaves a living custom actor: "+_kinds[_i]);
            array_push(cave_extras112,_extra);
            // Exercise a stale binding as well as the production scheduling guard.
            with(_extra) scrHMBindEndStep(hm_maincode_mod_gml_CHCoutro,1,x,y);
        }
    }
    if(mode=="caveextra112" && (self[$ "cave_started112"]??false) && ticks>=cave_start112+5
        && !(self[$ "cave_killed112"]??false)) {
        // Constructors may trigger a natural presentation after the initial
        // wait. Deliver the real combat Step only once its actors can step.
        var _ready=HMWorld.logic_tick && !lockstep_stop && !UberCont.paused
            && !instance_exists(HMWorld.hm_portrait_active);
        for(var _i=0;_i<array_length(cave_extras112);++_i) {
            var _actor=cave_extras112[_i];
            if(instance_exists(_actor) && ((_actor[$ "hm_portrait_frozen"]??false)
                || (_actor[$ "frozen"]??false))) _ready=false;
        }
        if(_ready) {
            for(var _i=0;_i<array_length(cave_extras112);++_i)
                scrHMGameplayCheck(instance_exists(cave_extras112[_i]) && cave_extras112[_i].hp>0,
                    "outro callback does not confuse a living converted extra with a dead stage boss");
            scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("cavesinv")
                && !(variable_instance_get(GameCont,"hm_cave_cleansed")??false),
                "living ordinary and cursed extra crystals do not cleanse the room");
            cave_killed112=true;cave_kill112=ticks;
            for(var _i=0;_i<array_length(cave_extras112);++_i)
                with(cave_extras112[_i]) {hp=0;event_perform(ev_step,ev_step_normal);}
        }
    }
    if(mode=="caveextra112" && (self[$ "cave_killed112"]??false) && ticks==cave_kill112+5) {
        for(var _i=0;_i<array_length(cave_extras112);++_i)
            scrHMGameplayCheck(!instance_exists(cave_extras112[_i]),"extra crystal completes actual combat death");
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("cavesinv")
            && !(variable_instance_get(GameCont,"hm_cave_cleansed")??false),
            "dead extra crystals do not cleanse a room without the real stage boss");
        cave_done112=true;
    }
    if(mode=="caveextra112" && ticks>=goal_ticks)
        scrHMGameplayCheck(self[$ "cave_done112"]??false,"extra-boss regression really executes after any natural portrait and completes");
    if(mode=="cave112" && ticks==30) {
        var _boss=instance_find(HyperCrystal,0);
        scrHMGameplayCheck(instance_exists(_boss),"real cursed-cave boss generated");
        cave_shapes112=[];
        with(Wall) array_push(other.cave_shapes112,[id,image_xscale,image_yscale]);
        var _ground=instance_nearest(_boss.x,_boss.y,Floor);
        player.x=_ground.x+16;player.y=_ground.y+16;
        BackCont.force_snap_camera_position=true;
        with(_boss) {hp=0;event_perform(ev_step,ev_step_normal);}
    }
    if(mode=="cave112" && ticks==45) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("caves"),"native boss death restores cave identity");
        var _bad=0,_n=0;
        with(Wall) {_n++;if(sprite_index!=sprWall4Bot||topspr!=sprWall4Top||outspr!=sprWall4Out) _bad++;}
        with(TopSmall) {if(sprite_index!=sprWall4Trans) _bad++;}
        scrHMGameplayCheck(_n>0&&_bad==0,"wall face, roof, exterior and transition commit normal cave palette immediately");
        for(var _i=0;_i<array_length(cave_shapes112);++_i) {
            var _r=cave_shapes112[_i];
            scrHMGameplayCheck(instance_exists(_r[0])&&_r[0].image_xscale==_r[1]&&_r[0].image_yscale==_r[2],"palette conversion keeps collision geometry");
        }
    }
    if(mode=="cave112"&&ticks==60&&surface_exists(application_surface))
        surface_save(application_surface,game_directory+"cave112-restored.png");
}

// Add jungleentry112 to scrHMGameplayRoomStart's whitelist. The pending-point
// case stops after the real Flower callback; the zero-point case also travels
// through its real Portal and native room generation, without forcing an area.
function scrHMGameplayJungle112() {
    if(ticks>=20 && !(self[$ "jungle_started112"]??false)
        && !instance_exists(HMWorld.hm_portrait_active) && !(player[$ "hm_portrait_frozen"]??false)) {
        jungle_started112=true;jungle_start112=ticks;
        jungle_flower112=noone;
        with(CustomHitme) if(name=="   feed") {other.jungle_flower112=id;break;}
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("caves") && GameCont.subarea==3
            && instance_exists(jungle_flower112),"natural 4-3 contains its actual Jungle entrance");
        scrHMGameplayIsolate103();
        with(WantPopo) instance_destroy(id,false);
        with(WantVan) instance_destroy(id,false);
        GameCont.skillpoints=(mode=="junglepending112")?1:0;
        jungle_points112=GameCont.skillpoints;
        jungle_ultra112=GameCont.ultrapoints;
        jungle_l2_points112=variable_instance_get(GameCont,"hm_l2_ultra_points1103")??0;
        scrHMSetSkill(18,1);
        player.x=jungle_flower112.x;player.y=jungle_flower112.y;player.speed=0;
        KeyCont.press_pick[player.index]=true;
        repeat(4) with(jungle_flower112) with(id) scrHMActorCallback("on_step");
        KeyCont.press_pick[player.index]=false;
        scrHMGameplayCheck(jungle_flower112.fed==4,"four actual interactions feed the real entrance");
        jungle_phase112=1;
    }
    if((self[$ "jungle_phase112"]??0)==1 && ticks>=jungle_start112+8
        && instance_exists(jungle_flower112) && jungle_flower112.driver!=-1
        && instance_exists(jungle_flower112.driver)) {
        // Keep all authored callbacks and waits; shorten only the travel distance.
        jungle_flower112.zmax=jungle_flower112.y+1;
        jungle_phase112=2;
    }
    if((self[$ "jungle_phase112"]??0)==2 && GameCont.area==scrHMAreaResolve("jungleboogie")) {
        scrHMGameplayCheck(GameCont.skillpoints==jungle_points112,
            "the real entrance neither grants a mutation nor clears an existing pending point");
        scrHMGameplayCheck(scrHMGetSkill(18)==0,"the original Last Wish cleanup still runs");
        scrHMGameplayCheck(GameCont.ultrapoints==jungle_ultra112
            && (variable_instance_get(GameCont,"hm_l2_ultra_points1103")??0)==jungle_l2_points112,
            "Jungle entry leaves native and Loop2 Ultra accounting unchanged");
        if(mode=="junglepending112") {
            jungle_phase112=4;goal_ticks=ticks;
        } else {
            var _entrance=noone;
            with(Portal) if(nompportal) {_entrance=id;break;}
            scrHMGameplayCheck(instance_exists(_entrance),"the real Flower callback creates its committed Portal");
            jungle_rooms112=route_rooms;jungle_phase112=3;
            GameCont.can_advance_stage=true;
            with(_entrance) event_perform_object(Portal,ev_alarm,1);
        }
    }
    if((self[$ "jungle_phase112"]??0)==3 && route_rooms>jungle_rooms112) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("jungle") && GameCont.subarea==1,
            "the actual entrance Portal and room lifecycle arrive in Jungle 1");
        scrHMGameplayCheck(GameCont.skillpoints==0 && !instance_exists(LevCont)
            && !instance_exists(SkillIcon),"zero pending points do not open a free mutation selection on arrival");
        jungle_phase112=4;goal_ticks=ticks;
    }
    if(ticks>=goal_ticks) scrHMGameplayCheck((self[$ "jungle_phase112"]??0)==4,
        "the requested Jungle entrance regression completes before its deadline");
}
