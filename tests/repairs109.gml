// Exercise real host events and source callbacks, in isolated test saves.
function scrHMGameplayRepairs109() {
    scrHMGameplayRequests109();
    if(mode=="contracts109" && ticks==10) {
        scrHMGameplayLane107();
        var _selector=instance_create(0,0,CustomModeWeaponSelector);
        instance_deactivate_object(GameCont);
        for(var _w=1;_w<=maxwep;++_w) {scr_weapon_get_area(_w);scr_weapon_get_name(_w);}
        with(_selector) event_user(1);
        scrHMGameplayCheck(array_length(_selector.groups)==_selector.group_count,"real custom selector builds/sorts all weapon metadata without GameCont");
        instance_activate_object(GameCont);instance_destroy(_selector,false);
        var _body=noone,_portal=noone;
        with(player) _body=scrHMBindDraw(hm_maincode_mod_gml_PortalShrink,-10);
        with(instance_create(player.x,player.y,Portal)) {
            _portal=scrHMBindDraw(hm_maincode_mod_gml_StablePortal,-10);instance_destroy(id,false);
        }
        scrHMGameplayCheck(_body.depth<_portal.depth,"entry body draws strictly above stable portal independent of creation order");
        var _tech=instance_create(player.x+48,player.y,TechnoMancer);
        with(_tech) {hp=0;instance_destroy();}
        var _corpse=noone;with(CorpseActive) if(sprite_index==sprTechnoMancerDead) _corpse=id;
        scrHMGameplayCheck(instance_exists(_corpse)&&_corpse.hm_no_revive109,"TechnoMancer death marks its actual moving corpse");
        with(_corpse) {var _spr=sprite_index;instance_change(Corpse,false);sprite_index=_spr;}
        var _freaks=instance_number(Freak),_circle=instance_create(_corpse.x,_corpse.y,ReviveCircle);
        with(_circle) event_perform(ev_alarm,0);
        show_debug_message("HARDMODE REVIVE109 "+json_stringify({exists:instance_exists(_corpse),type:_corpse.object_index,flag:_corpse.hm_no_revive109,spr:_corpse.sprite_index,before:_freaks,after:instance_number(Freak)}));
        scrHMGameplayCheck(instance_exists(_corpse)&&_corpse.object_index==Corpse&&instance_number(Freak)==_freaks,"necromancer circle cannot revive TechnoMancer into Freak");
        var _ordinary=instance_create(player.x+64,player.y,Corpse);_ordinary.sprite_index=sprBanditDead;
        scrHMGameplayCheck(scrHMReviveNearest109(_corpse.x,_corpse.y)==_ordinary,"necromancer skips nearby ineligible boss in target selection");
        _circle=instance_create(_ordinary.x,_ordinary.y,ReviveCircle);with(_circle) event_perform(ev_alarm,0);
        scrHMGameplayCheck(instance_number(Freak)==_freaks+1,"ordinary corpses still revive");
        instance_destroy(enemy,false);instance_destroy(Corpse,false);
    }
    if(mode=="drops109" && ticks==10) {
        scrHMGameplayLane107();GameCont.loops=3;
        var _tank=hm_enemies_mod_gml_IDPDTank_create(player.x+80,player.y,0);
        var _n=instance_number(AmmoPickup)+instance_number(HPPickup);
        with(_tank) {scrHMTankSupplies109();scrHMTankSupplies109();}
        scrHMGameplayCheck(instance_number(AmmoPickup)+instance_number(HPPickup)==_n+2,"loop-three tank supplies are two drops exactly once");
        with(_tank) {scrHMRadiationSync(true);scrHMTankRadiation108();scrHMRadiationSync(false);}
        scrHMGameplayCheck(_tank.raddrop==70,"tank supply change retains 70 post-cap base radiation");
        instance_destroy(_tank,false);GameCont.area=scrHMAreaResolve("oasis");
        var _fish=instance_create(player.x+48,player.y,BoneFish);
        with(_fish) scrHMRadiationSync(true);
        scrHMGameplayCheck(_fish.raddrop==0,"bone fish retains original reduced pre-cap radiation");
        with(_fish) {scrHMRadiationSync(false);raddrop+=7;repeat(8)scrHMRadiationSync(false);}
        scrHMGameplayCheck(_fish.raddrop==17,"post-cap bone fish drops 10 base and preserves absorbed radiation idempotently");
        instance_destroy(_fish,false);
    }
    if(mode=="altar109" && ticks==15) {
        scrHMGameplayCheck(instance_number(ProtoStatue)==1,"natural palace 7-4 generation supplies one crown entrance");
        instance_destroy(ProtoStatue,false);GameCont.crownvisits=3;scrHMCrownAltar109();
        scrHMGameplayCheck(!instance_exists(ProtoStatue),"original three-visit cap forbids new crown altar");
        GameCont.crownvisits=2;repeat(4)scrHMCrownAltar109();
        scrHMGameplayCheck(instance_number(ProtoStatue)==1,"remaining visit permits exactly one altar");
    }
    if(mode=="hunter109" && ticks==10) {
        with(enemy) hp=0;
        scrHMGameplayCheck(scrHMPendingBoss(),"delayed hunter controller is pending combat immediately after generation");
    }
    if(mode=="hunter109" && ticks==300)
        scrHMGameplayCheck(scrHMPendingBoss()&&!instance_exists(Portal),"cleared 5-5 cannot exit during original hunter arrival wait");
    // At loop zero the native WantLH delay is 210, following the authored
    // 500-tick arrival wait. Inspect after both have completed.
    if(mode=="hunter109" && ticks==730) {
        show_debug_message("HARDMODE HUNTER109 "+json_stringify({normal:instance_number(LilHunter),flying:instance_number(LilHunterFly),pending:instance_number(WantLH)}));
        scrHMGameplayCheck(instance_number(LilHunter)+instance_number(LilHunterFly)==1+floor(GameCont.loops/2),"real delayed WantLH adds one hunter every two loops");
        scrHMGameplayCheck(!instance_exists(Portal),"no portal opens before the arriving hunters");
    }
    if(mode=="gators109" && ticks==15) {
        var _n=0;with(CustomEnemy) if(name=="gatorboss") _n++;
        scrHMGameplayCheck(_n==1+floor(GameCont.loops/2),"natural sewer encounter adds one super gator every two loops");
    }
    if(mode=="birds109" && ticks==10) with(enemy) hp=0;
    if(mode=="birds109" && ticks==400) {
        var _n=0,_r=instance_number(RavenFly)+instance_number(Raven);
        with(CustomEnemy) if(name=="BIG BIRD") {_n++;target=other.player;hm_bosses_ravenboss_mod_gml_ravenboss_callbackup(1);}
        scrHMGameplayCheck(_n==1+floor(GameCont.loops/2),"real threshold spawner adds one big bird every two loops");
        scrHMGameplayCheck(instance_number(RavenFly)+instance_number(Raven)-_r==GameCont.loops+1,"all birds combined request only the original single-boss minion budget");
    }
    if(mode=="water109" && ticks==15) {
        scrHMGameplayLane107();
        var _water=instance_create(16001,16003,Floor);_water.traction=2;
        var _dry=instance_create(16033,16003,Floor);_dry.traction=0;
        HMWorld.hm_water_map=undefined;
        scrHMGameplayCheck(!scrHMWaterAt(16000.99,16019)&&scrHMWaterAt(16001.01,16019),"fractional left water edge excludes neighbouring dry space");
        scrHMGameplayCheck(scrHMWaterAt(16032.99,16019)&&!scrHMWaterAt(16033,16019),"bank begins at exact half-open water boundary");
        scrHMGameplayCheck(!scrHMWaterAt(16017,16002.99)&&scrHMWaterAt(16017,16003.01),"fractional upper water edge is exact");
        _water.traction=0;
        scrHMGameplayCheck(!scrHMWaterAt(16017,16019),"same-count floor traction change immediately removes swimming");
        _water.traction=2;
        var _patch=instance_create(16017,16019,FloorExplo);HMWorld.hm_water_map=undefined;
        scrHMGameplayCheck(!scrHMWaterAt(16020,16022),"new dry explosion patch overrides remaining water rectangle");
        instance_destroy(_patch,false);
    }
    if(mode=="crystals109" && ticks==15) {
        scrHMGameplayLane107();var _n=0;
        repeat(400) {var _crystal=scrHMLoopCrystal109(player.x+64,player.y);if(instance_exists(_crystal)) {_n++;instance_destroy(_crystal,false);}}
        scrHMGameplayCheck(_n>0&&_n<40,"loop population adds pictured big crystal with bounded original-style weight");
        GameCont.loops=0;var _added=0;repeat(200) if(instance_exists(scrHMLoopCrystal109(player.x+64,player.y))) _added++;
        scrHMGameplayCheck(_added==0,"new big crystal distribution is loop-only");
    }
    if(mode=="night109" && ticks==10) {
        // Keep all naturally created types and run their actual damage/wake
        // paths. Never blanket-delete invisible enemies or wall inhabitants.
        show_debug_message("HARDMODE NIGHT109 INITIAL "+string(instance_number(enemy)));
        var _ones=[];with(hitme) if(hp==1&&max_hp==1) array_push(_ones,{type:object_get_name(object_index),spr:sprite_index,alpha:image_alpha,name:self[$ "name"],step:self[$ "on_step"],draw:self[$ "on_draw"],mask:mask_index});
        show_debug_message("HARDMODE NIGHT109 ONE_HP "+json_stringify(_ones));
        var _blank=0;with(CustomEnemy) if(name==""&&!sprite_exists(sprite_index)&&is_undefined(on_step)&&is_undefined(on_draw)) _blank++;
        scrHMGameplayCheck(_blank==0,"natural loop clustering creates no bare CustomEnemy shells");
    }
    if(mode=="night109" && ticks>=30 && ticks<220 && ticks mod 20==0) with(enemy) scr_hit(id,10000,HitId.Player);
    if(mode=="night109" && ticks==280) {
        var _state=[];with(enemy) array_push(_state,{type:object_get_name(object_index),name:self[$ "name"],hp:hp,spr:sprite_index,idle:self[$ "spr_idle"],step:self[$ "on_step"],x:x,y:y});
        show_debug_message("HARDMODE NIGHT109 REMAINING "+json_stringify(_state));
        var _ghost=0;with(enemy) if(hp>0&&!sprite_exists(sprite_index)&&is_undefined(self[$ "on_draw"])) _ghost++;
        scrHMGameplayCheck(_ghost==0,"night desert real damage leaves no unrendered enemy receiver");
        if(GameCont.loops==0) {
            scrHMGameplayCheck(instance_number(enemy)==0,"non-loop night wave clears all actual enemies");
            scrHMGameplayCheck(instance_exists(Portal),"night desert natural clear opens an exit");
        }
    }
    if(mode=="empty109" && ticks==10) {
        // Simulate the last enemy's real replacement/delete path, after all
        // previous death animations have finished. Keep ordinary 1HP props.
        with(enemy) instance_destroy(id,false);
        with(becomenemy) instance_destroy(id,false);
        with(Corpse) alarm[0]=-1;
        with(Portal) instance_destroy(id,false);
        empty_player_x109=player.x;empty_player_y109=player.y;
    }
    if(mode=="empty109" && ticks>=10) {
        player.x=empty_player_x109;player.y=empty_player_y109;player.speed=0;
        if(instance_exists(Portal)) empty_seen109=true;
    }
    if(mode=="empty109" && ticks==130) {
        var _left=[];with(enemy) array_push(_left,{type:object_get_name(object_index),name:self[$ "name"],hp:hp});
        var _timers=[];with(Corpse) array_push(_timers,{alarm:alarm[0],marker:self[$ "hm_exit_corpse"],spr:sprite_index});
        show_debug_message("HARDMODE EMPTY109 "+json_stringify({left:_left,pending:scrHMPendingBoss(),timers:_timers,timer:variable_instance_get(HMWorld,"hm_empty_exit109")}));
        scrHMGameplayCheck(instance_number(enemy)==0&&(self[$ "empty_seen109"]??false),"empty natural night encounter repairs expired/missing exit alarm without killing anything");
    }
    if(mode=="titank109" && ticks==20) {
        scrHMGameplayLane107();
        with(HMWorld) hm_bosses_titank_mod_gml_titank_create(other.player.x+120,other.player.y);
    }
    if(mode=="titank109" && ticks>=350) {
        var _tank=noone;with(CustomEnemy) if(name=="titank") _tank=id;
        if(instance_exists(_tank)) {
            if(!(self[$ "jump_killed109"]??false) && _tank.lastatk==1 && _tank.z>250) {
                var _foot=_tank.hm_feet[0];with(_foot) scr_hit(id,10000,HitId.Player);
                jump_killed109=true;jump_deadline109=ticks+150;
            }
            if(self[$ "jump_killed109"]??false) if(ticks==jump_deadline109) {
                show_debug_message("HARDMODE TITANK109 RECOVER "+json_stringify({z:_tank.z,start:_tank.zstart,canmove:_tank.canmove,last:_tank.lastatk}));
                scrHMGameplayCheck(_tank.hp==_tank.legs-1,"actual jump damage destroys a leg without killing the body");
                scrHMGameplayCheck(self[$ "jump_recovered109"]??false,"jump lands and recovers movement after takeoff leg loss");
                jump_checked109=true;
            }
            if((self[$ "jump_killed109"]??false) && _tank.canmove==1 && abs(_tank.z-_tank.zstart)<1) jump_recovered109=true;
            if(ticks mod 100==0) show_debug_message("HARDMODE TITANK109 "+json_stringify({tick:ticks,z:_tank.z,attack:_tank.lastatk,canmove:_tank.canmove,hp:_tank.hp}));
        }
    }
    if(mode=="titank109" && ticks==1100) scrHMGameplayCheck(self[$ "jump_checked109"]??false,"natural Titank performed and recovered its tested jump");
    if(mode=="guardian109" && ticks==10) {
        guardian109=hm_bosses_guardianboss_mod_gml_guardianboss_create(player.x+64,player.y);
    }
    if(mode=="guardian109" && ticks==100) {
        var _dark=0;with(HMBinding) if(hm_code==scrHMScriptRef(hm_bosses_guardianboss_mod_gml_guardiandark_draw)) _dark++;
        scrHMGameplayCheck(_dark==1,"guardian uses one dark arena renderer");
        var _bad=0;with(hitme) if(depth>-9) _bad++;
        scrHMGameplayCheck(_bad==0,"guardian entities are naturally above its dark layer without repeated Draw callbacks");
        with(CustomEnemy) if(name=="guardianboss") {hp=0;instance_destroy();}
    }
    if(mode=="guardian109" && ticks==300) {
        var _left=0;with(GameObject) if(!is_undefined(self[$ "hm_guard_depth109"])) _left++;
        scrHMGameplayCheck(_left==0,"guardian death restores temporary entity depths");
    }
    if(mode=="wall109" && ticks==15) {
        TopCont.darkness=0;
        var _transition=0,_plain_bad=0,_roof_bad=0,_bad=[];
        with(Wall) if(self[$ "hm_interior_wall"]??false) {
            var _tile=collision_point(x+8,y+8,TopSmall,false,true);
            if(scrHMPlainWall106()) {if(instance_exists(_tile)) {_plain_bad++;if(array_length(_bad)<10)array_push(_bad,[x,y,"plain",_tile.x,_tile.y]);}}
            else {
                _transition++;
                if(!instance_exists(_tile) || !scrHMTransitionRoof109()) {_roof_bad++;if(array_length(_bad)<10)array_push(_bad,[x,y,"roof",position_meeting(x,y,Floor)]);}
            }
        }
        show_debug_message("HARDMODE WALL109 "+json_stringify({transition:_transition,plain_bad:_plain_bad,roof_bad:_roof_bad,bad:_bad}));
        scrHMGameplayCheck(_transition>0,"final terrain contains a synthetic transition ring");
        scrHMGameplayCheck(_plain_bad==0&&_roof_bad==0,"transition lies outside authored edge, without detailed roof overpaint or a third ring");
    }
    if(mode=="profile109" && ticks==10) {
        scrHMGameplayLane107();
        var _owners=[];
        repeat(160) {
            var _owner=instance_create(player.x+32,player.y,CustomObject);
            with(_owner) scrHMBindDraw(hm_enemies_mod_gml_bigcrystaltopdraw,0);
            array_push(_owners,_owner);
        }
        var _count=instance_number(HMBinding),_cache_time=get_timer();
        repeat(8) for(var _i=0;_i<array_length(_owners);++_i) with(_owners[_i]) scrHMBindDraw(hm_enemies_mod_gml_bigcrystaltopdraw,0);
        _cache_time=get_timer()-_cache_time;
        var _scan_time=get_timer(),_matched=0;
        repeat(8) for(var _i=0;_i<array_length(_owners);++_i) {
            var _who=_owners[_i];
            with(HMBinding) if(creator==_who && hm_code==scrHMScriptRef(hm_enemies_mod_gml_bigcrystaltopdraw)) {_matched++;break;}
        }
        _scan_time=get_timer()-_scan_time;
        scrHMGameplayCheck(instance_number(HMBinding)==_count&&_matched==1280,"cached binding lookup reuses exactly one renderer per owner");
        show_debug_message("HARDMODE PROFILE109 "+json_stringify({rate:rate,owners:160,lookups:1280,cached_us:_cache_time,old_scan_us:_scan_time,bindings:_count}));
        for(var _i=0;_i<array_length(_owners);++_i) instance_destroy(_owners[_i],false);
        with(HMBinding) instance_destroy(id,false);
    }
    if(mode=="throneseed109" && ticks==10) {
        var _flags=[];with(Floor) if(self[$ "nokill"]??false) array_push(_flags,[x,y]);
        var _bosses=[];with(NothingInactive) array_push(_bosses,{x:x,y:y,alpha:image_alpha,visible:visible,floor:distance_to_object(Floor)});
        show_debug_message("HARDMODE THRONE SEED109 "+json_stringify({flags:_flags,bosses:_bosses,area:GameCont.area,sub:GameCont.subarea}));
        scrHMGameplayCheck(instance_number(NothingInactive)==1,"throne generation retains exactly one first-stage throne");
        with(NothingInactive) scrHMGameplayCheck(visible&&image_alpha==1&&distance_to_object(Floor)<48,"first throne has visible art on the real arena");
        with(NothingInactive) instance_destroy(id,false);
        with(Floor) nokill=0;
        repeat(3) scrHMThroneEntrance109();
        scrHMGameplayCheck(instance_number(NothingInactive)==1,"finalization recovers a missing seed-dependent initial throne exactly once");
        var _active=instance_create(NothingInactive.x,NothingInactive.y,BecomeNothing);
        instance_destroy(NothingInactive,false);scrHMThroneEntrance109();
        scrHMGameplayCheck(!instance_exists(NothingInactive),"finalization never resurrects first stage over an active phase transition");
        instance_destroy(_active,false);scrHMThroneEntrance109();
    }
    if(mode=="throneseed109" && ticks==80) scrHMGameplayCheck(instance_exists(NothingInactive),"initial throne persists before player activation");
    if(mode=="throneroute109" && room_ticks==10) {
        if(!(self[$ "throne_requested109"]??false)) {
            throne_requested109=true;GameCont.can_advance_stage=true;GameCont.is_level_ended=true;room_restart();
        } else {
            scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("throne"),"actual 7-4 finish selects the Hardmode throne arena");
            scrHMGameplayCheck(instance_number(NothingInactive)==1,"palace-to-throne room transition preserves exactly one initial throne");
            with(NothingInactive) scrHMGameplayCheck(visible&&image_alpha==1&&distance_to_object(Floor)<48,"transition throne is visible on generated terrain");
        }
    }
    if(mode=="buffgator109" && ticks==15) {
        scrHMGameplayLane107();var _added=0;
        // An idle player can touch the natural 2-2 crown entrance during the
        // settling frames. This isolated population probe uses its scenario.
        var _parts=string_split(scenario,",");
        GameCont.area=scrHMAreaResolve(_parts[0]);GameCont.subarea=real(_parts[1]);
        repeat(320) {var _g=scrHMLoopBuffGator109(player.x+64,player.y);if(instance_exists(_g)) {_added++;instance_destroy(_g,false);}}
        show_debug_message("HARDMODE BUFFGATOR109 "+json_stringify({added:_added,area:GameCont.area,sub:GameCont.subarea,loop:GameCont.loops,wall:position_meeting(player.x+64,player.y,Wall)}));
        scrHMGameplayCheck(_added>0&&_added<50,"requested loop area has bounded BuffGator additions");
        GameCont.loops=0;var _base=instance_number(BuffGator);
        repeat(120) scrHMLoopBuffGator109(player.x+64,player.y);
        scrHMGameplayCheck(instance_number(BuffGator)==_base,"new BuffGator population is loop-only");
    }
}

function scrHMGameplayRender109() {
    if(!surface_exists(application_surface)) return;
    if(mode=="requests109" && ticks==20) {
        var _saved=[GameCont.area,GameCont.subarea,GameCont.waypnt,GameCont.waysub,GameCont.waylps,GameCont.waypoints];
        GameCont.area=scrHMAreaResolve("palace");GameCont.subarea=3;
        GameCont.waypnt=[1,1,scrHMAreaResolve("nightdesert"),scrHMAreaResolve("scorpionboss"),scrHMAreaResolve("sewers"),3,scrHMAreaResolve("ravenboss"),scrHMAreaResolve("junkyard"),scrHMAreaResolve("caves"),scrHMAreaResolve("city"),scrHMAreaResolve("labs"),scrHMAreaResolve("elevator"),scrHMAreaResolve("palace")];
        GameCont.waysub=[1,3,4,5,3,2,3,5,3,5,2,3,3];
        GameCont.waylps=array_create(13,0);GameCont.waypoints=13;
        surface_set_target(application_surface);
        draw_set_color(c_black);draw_set_alpha(1);draw_rectangle(view_xview,view_yview,view_xview+view_width,view_yview+86,false);
        scrDrawRoadmap(view_xview+view_width/2,view_yview+48,13);
        surface_reset_target();
        surface_save(application_surface,game_directory+"roadmap-7-3.png");
        GameCont.area=_saved[0];GameCont.subarea=_saved[1];GameCont.waypnt=_saved[2];GameCont.waysub=_saved[3];GameCont.waylps=_saved[4];GameCont.waypoints=_saved[5];
    }
    if(array_contains(["wall109","guardian109","crystals109","water109"],mode) && array_contains([20,95,140],ticks))
        surface_save(application_surface,game_directory+mode+"-"+string(ticks)+"-"+string(age)+".png");
}
