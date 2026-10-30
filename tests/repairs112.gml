function scrHMGameplayRepairs112() {
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
