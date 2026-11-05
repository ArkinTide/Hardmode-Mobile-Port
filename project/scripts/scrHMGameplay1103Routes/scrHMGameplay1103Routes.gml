// Real host routes. Add sync113vault to scrHMGameplayRoomStart's whitelist.
function scrHMGameplayVault1103() {
    if(ticks>=goal_ticks) scrHMGameplayCheck(variable_instance_exists(id,"vault_phase1103") && vault_phase1103==3,
        "charged altar round trip completes before the test deadline");
    if(room_ticks!=30) return;
    var _phase=variable_instance_exists(id,"vault_phase1103")?vault_phase1103:0;
    if(_phase==0) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("palace") && GameCont.subarea==4,
            "round trip starts at natural palace 7-4");
        scrHMGameplayCheck(instance_number(ProtoStatue)==1,"natural 7-4 owns exactly one crown altar");
        with(ProtoStatue) {
            rad=25;
            event_perform_object(ProtoStatue,ev_step,ev_step_normal);
            scrHMGameplayCheck(charged,"actual native altar Step charges with sufficient radiation");
            instance_destroy();
        }
        var _entrance=noone;
        with(Portal) if(type==3 && variable_instance_exists(id,"hm_destination107") && hm_destination107==area_vault) {_entrance=id;break;}
        scrHMGameplayCheck(instance_exists(_entrance),"actual charged altar Destroy creates explicit vault portal");
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("palace") && GameCont.subarea==4,
            "charging the entrance preserves the live source area");
        vault_loops1103=GameCont.loops;vault_phase1103=1;
        GameCont.can_advance_stage=true;GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0;
        with(_entrance) event_perform_object(Portal,ev_alarm,1);
    } else if(_phase==1) {
        scrHMGameplayCheck(GameCont.area==area_vault && GameCont.subarea==1,"actual room lifecycle enters the native crown vault");
        scrHMGameplayCheck(GameCont.crownvisits==1 && GameCont.loops==vault_loops1103,"native entry counts exactly one visit without looping");
        scrHMGameplayCheck(GameCont.lastarea==scrHMAreaResolve("palace") && GameCont.lastsubarea==4,
            "native vault remembers the exact 7-4 source");
        scrHMGameplayCheck(instance_exists(CrownPickup) && !instance_exists(NothingInactive),
            "vault generation contains its real crown pickup and no misplaced Throne");
        var _crown=instance_find(CrownPickup,0);
        with(player) with(_crown) event_perform_object(CrownPickup,ev_collision,Player);
        scrHMGameplayCheck(!instance_exists(_crown),"actual Player collision consumes the crown through native Destroy");
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("palace") && GameCont.subarea==4,
            "CrownPickup Destroy really restores source before exit commitment");
        var _exit=noone;with(Portal) if(type==3) {_exit=id;break;}
        scrHMGameplayCheck(instance_exists(_exit),"native crown collision produces its actual return portal");
        vault_phase1103=2;
        GameCont.can_advance_stage=true;GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0;
        with(_exit) event_perform_object(Portal,ev_alarm,1);
    } else if(_phase==2) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("throne") && GameCont.subarea==1,
            "vault return resumes Throne instead of 7-3 or 7-4");
        scrHMGameplayCheck(instance_number(NothingInactive)==1,"vault return generates one original sleeping Throne");
        scrHMGameplayCheck(GameCont.crownvisits==1 && GameCont.loops==vault_loops1103,
            "return neither consumes another visit nor changes the loop");
        vault_phase1103=3;
    }
}

function scrHMGameplayLift1103() {
    if(ticks==20) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("elevator"),"lift fixture uses naturally generated 6-3");
        lift1103=noone;
        with(CustomHitme) if(name=="elevator") {other.lift1103=id;break;}
        scrHMGameplayCheck(instance_exists(lift1103),"real 6-3 device is present");
        var _screens=0;
        with(BigTV) {
            show_debug_message("HARDMODE LIFT113 SCREEN "+json_stringify({hp:hp,max_hp:max_hp,loop:GameCont.loops}));
            scrHMGameplayCheck(max_hp==9999,"natural 6-3 screen has the requested 9999 maximum HP at every Loop");
            // Twenty real combat ticks have elapsed; hostile shots may have
            // damaged this destructible prop without changing its capacity.
            scrHMGameplayCheck(hp>0 && hp<=max_hp,"natural 6-3 screen remains alive with valid current health");
            _screens++;
        }
        scrHMGameplayCheck(_screens==1,"natural 6-3 creates one large screen");
        with(enemy) instance_destroy(id,false);
        with(becomenemy) instance_destroy(id,false);
        with(IDPDSpawn) instance_destroy(id,false);
        with(Portal) instance_destroy(id,false);
        with(SpiralCont) instance_destroy(id,false);
        with(Spiral) instance_destroy(id,false);
        with(CustomObject) if(array_contains(["hm_infantry_gate","hm_robot_gate"],name)) instance_destroy(id,false);
        lift1103.hm_elevator_exit=noone;lift1103.hm_elevator_wait=40;
        lift_blocker1103=instance_create(lift1103.x+96,lift1103.y+32,Bandit);
        lift_corpse1103=instance_create(lift1103.x+80,lift1103.y+32,Corpse);
        lift_corpse1103.forceportal=true;lift_corpse1103.do_portal=true;lift_corpse1103.alarm[0]=20;
        lift_techcorpse1103=instance_create(lift1103.x-80,lift1103.y+32,CustomObject);
        lift_techcorpse1103.name="hm_techcorpse";lift_techcorpse1103.do_portal=true;lift_techcorpse1103.hm_exit_delay=20;
        var _safe=instance_furthest(lift1103.x,lift1103.y,Floor);
        player.x=_safe.x+16;player.y=_safe.y+16;player.speed=0;
    }
    if(ticks>=20 && ticks<=95) {
        // This fixture isolates the device's real forty-tick timer. Natural
        // Loop reinforcements may already have delayed callbacks queued at
        // tick20; the separate sync112exit case tests their genuine combat
        // clearance and actual travel. Keep only our explicit live Bandit.
        var _blocker=lift_blocker1103;
        with(WantPopo) instance_destroy(id,false);
        with(WantVan) instance_destroy(id,false);
        with(IDPDSpawn) instance_destroy(id,false);
        with(VanSpawn) instance_destroy(id,false);
        with(WantLH) instance_destroy(id,false);
        with(becomenemy) instance_destroy(id,false);
        with(CustomObject) if(array_contains(["makeavan","hm_infantry_gate","hm_robot_gate"],name)) instance_destroy(id,false);
        with(enemy) if(id!=_blocker) instance_destroy(id,false);
    }
    if(ticks==40) {
        scrHMGameplayCheck(instance_exists(lift_blocker1103) && lift_blocker1103.hp>0
            && !hm_arkintide_mod_gml_hm_combat_clear(),"the fixture's living Bandit still blocks combat clearance");
        scrHMGameplayCheck(!instance_exists(Portal),"an enemy still alive prevents the device's clear timer exit");
        scrHMGameplayCheck(lift_corpse1103.alarm[0]<0 && !lift_corpse1103.do_portal,
            "real Corpse's competing automatic exit is disarmed");
        scrHMGameplayCheck(!lift_techcorpse1103.do_portal && lift_techcorpse1103.hm_exit_delay<0,
            "Technomancer corpse's competing exit is disarmed");
        instance_destroy(lift_blocker1103,false);
        lift1103.hm_elevator_wait=40;lift_clear1103=ticks;
    }
    if(ticks>40 && ticks<79) scrHMGameplayCheck(!instance_exists(Portal),"clearance waits its full forty logical ticks");
    if(ticks==95) {
        var _remaining=[],_gates=[],_portals=[];
        with(enemy) array_push(_remaining,[id,object_get_name(object_index),self[$ "name"]??"",hp,team,x,y]);
        with(becomenemy) array_push(_gates,[id,object_get_name(object_index),x,y]);
        with(IDPDSpawn) array_push(_gates,[id,"IDPDSpawn",x,y]);
        with(VanSpawn) array_push(_gates,[id,"VanSpawn",x,y]);
        with(CustomObject) if(array_contains(["makeavan","hm_infantry_gate","hm_robot_gate"],name))
            array_push(_gates,[id,name,x,y]);
        with(Portal) array_push(_portals,[id,x,y,type,endgame,close,sprite_get_name(sprite_index)]);
        show_debug_message("HARDMODE LIFT113 CLEAR STATE "+json_stringify({
            tick:ticks,rate:rate,loop:GameCont.loops,combat_clear:hm_arkintide_mod_gml_hm_combat_clear(),
            device_exists:instance_exists(lift1103),device:[lift1103.x,lift1103.y,lift1103.hm_elevator_wait,lift1103.hm_elevator_exit],
            enemies:_remaining,gates:_gates,portals:_portals,
            pending:[instance_number(WantPopo),instance_number(WantVan),instance_number(WantLH)],
            presentation:[UberCont.paused,UberCont.bossintro,instance_exists(HMWorld.hm_portrait_active)],
            spirals:[instance_number(SpiralCont),instance_number(Spiral)]}));
        var _portal=lift1103.hm_elevator_exit;
        scrHMGameplayCheck(instance_exists(_portal) && instance_number(Portal)==1,"one device-owned portal opens after the real clear wait");
        scrHMGameplayCheck(_portal.x==lift1103.x && _portal.y==lift1103.y-16,
            "exit uses the original device X and requested sixteen-pixel upward offset");
        // Ignore the device's intentionally empty mask, whose zero-size bbox
        // is still returned by non-precise queries. Check all other hits so
        // an inert first result cannot conceal a real pipe/prop/wall blocker.
        var _near=ds_list_create(),_blocked=false;
        collision_circle_list(_portal.x,_portal.y,14,[CustomHitme,prop,Wall,InvisiWall],false,true,_near,false);
        for(var _i=0;_i<ds_list_size(_near);++_i) {
            var _block=_near[| _i];
            if(!instance_exists(_block)) continue;
            var _inert=_block.mask_index==mskNone;
            show_debug_message("HARDMODE LIFT113 BLOCKER "+json_stringify({
                portal:[_portal.x,_portal.y],device:[lift1103.x,lift1103.y],
                object:object_get_name(_block.object_index),name:_block[$ "name"]??"",
                position:[_block.x,_block.y],bounds:[_block.bbox_left,_block.bbox_top,_block.bbox_right,_block.bbox_bottom],
                ignored_empty_mask:_inert}));
            if(!_inert) _blocked=true;
        }
        ds_list_destroy(_near);
        scrHMGameplayCheck(!_blocked,"device-owned exit remains free of physical tube and obstacle collisions");
        scrHMGameplayCheck(hm_arkintide_mod_gml_hm_throne_clear(_portal.x,_portal.y,mskBandit),
            "device-owned exit keeps the player's complete floor footprint");
        scrHMGameplayCheck(_portal.type==2 && variable_instance_exists(_portal,"hm_elevator_owned") && _portal.hm_elevator_owned,"device's actual exit has IDPD type and ownership");
        _portal.endgame=99;_portal.x+=17;_portal.y+=11;
        lift_exit1103=_portal;lift_committed1103=[_portal.x,_portal.y];
    }
    if(ticks==96) {
        scrHMGameplayCheck(instance_exists(lift_exit1103) && lift_exit1103.x==lift_committed1103[0]
            && lift_exit1103.y==lift_committed1103[1],"a committed portal is not moved by the next real anchor tick");
    }
}

function scrHMGameplayThrone1103() {
    // Run the same guarded hook before observing it, independent of instance
    // Step ordering. The ordinary world caller still executes each frame.
    if(GameCont.loops>0) scrHMThroneGateTick1103();
    if(ticks==1) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("throne"),"test uses naturally generated original Throne arena");
        var _seed=noone,_seeds=0;
        with(Floor) if(variable_instance_exists(id,"nokill") && nokill) {_seed=id;_seeds++;}
        scrHMGameplayCheck(_seeds==1,"original authored floor seed remains unique");
        scrHMGameplayCheck(instance_number(NothingInactive)==1,"original area_start creates exactly one sleeping Throne");
        throne_idle1103=instance_find(NothingInactive,0);
        scrHMGameplayCheck(throne_idle1103.x==_seed.x+16
            && throne_idle1103.y==_seed.y-1568-64*min(GameCont.loops*2,4),
            "original b24 seed-relative boss position is preserved without adaptive displacement");
        with(throne_idle1103) scrHMGameplayCheck(!scrHMThroneBarVisible1103(),"sleeping Throne is excluded from the boss bar");
        throne_gate_seen1103=(GameCont.loops<=0);
        if(GameCont.loops>0) {
            throne_gate1103=instance_create(player.x+96,player.y,IDPDSpawn);
            throne_gate_wait1103=GameCont.hm_throne_gate_wait;
            scrHMGameplayCheck(throne_gate_wait1103>0 && throne_gate_wait1103<=90,
                "loop arrival retains its ninety-logic-tick police hold");
            scrHMGameplayCheck(throne_gate1103.hm_throne_gate_deferred1103 && !throne_gate1103.visible
                && throne_gate1103.image_speed==0,"actual native IDPDSpawn creation defers its visuals and alarms");
            var _before=GameCont.hm_throne_gate_wait;
            repeat(12) scrHMThroneGateTick1103();
            scrHMGameplayCheck(GameCont.hm_throne_gate_wait==_before,"duplicate callers cannot consume twelve extra arrival ticks");
        }
    }
    if(ticks>1 && !throne_gate_seen1103) {
        scrHMGameplayCheck(GameCont.hm_throne_gate_wait==max(0,throne_gate_wait1103-1),
            "police hold advances once per actual 30 Hz logical tick at either draw rate");
        throne_gate_wait1103=GameCont.hm_throne_gate_wait;
        if(throne_gate_wait1103>0) {
            scrHMGameplayCheck(instance_exists(throne_gate1103) && throne_gate1103.hm_throne_gate_deferred1103
                && !throne_gate1103.visible && throne_gate1103.alarm[0]<0,"deferred real portal remains closed before the deadline");
        } else {
            scrHMGameplayCheck(instance_exists(throne_gate1103) && !throne_gate1103.hm_throne_gate_deferred1103
                && throne_gate1103.visible && throne_gate1103.image_speed>0 && throne_gate1103.alarm[0]>0,
                "deadline replays real IDPDSpawn Create exactly when its hold expires");
            throne_gate_seen1103=true;
        }
    }
    if(ticks==125) {
        scrHMGameplayCheck(throne_gate_seen1103,"real deferred portal reached its scheduled arrival");
        scrHMGameplayCheck(instance_exists(throne_idle1103),"sleeping Throne survives the arrival period");
        throne_bounds1103=GameCont.hm_followup_throne_bounds;
        scrHMGameplayCheck(array_length(throne_bounds1103)==4,"full original room floor bounds are captured before wake");
        var _inside=0;
        with(Wall) if(x>=other.throne_bounds1103[0] && x<other.throne_bounds1103[2]
            && y>=(other.throne_bounds1103[1]+other.throne_bounds1103[3])/2-1920
            && y<(other.throne_bounds1103[1]+other.throne_bounds1103[3])/2+1920) _inside++;
        scrHMGameplayCheck(_inside>0,"original arena actually has walls inside the requested wake-up strip");
        var _ox=throne_bounds1103[2]+16,_oy=(throne_bounds1103[1]+throne_bounds1103[3])/2;
        var _existing=collision_point(_ox+8,_oy+8,Wall,false,false);
        // Real exterior fill already occupies this point. Wall.Create deletes
        // overlapping duplicates and InvisiWall.Collision_Wall does likewise.
        // A maskless InvisiWall still participates in the same coordinate-only
        // sweep, without being culled by unrelated physical overlap dispatch.
        throne_outside1103=instance_create(_ox,_oy,InvisiWall);
        throne_outside1103.mask_index=mskNone;
        scrHMGameplayCheck(instance_exists(throne_outside1103),"out-of-strip sweep witness exists before wake");
        show_debug_message("HARDMODE THRONE113 WALL WITNESS "+json_stringify(["bounds",throne_bounds1103,
            "outside",[_ox,_oy],"existing_wall",instance_exists(_existing),"inside_walls",_inside,"witness",throne_outside1103]));
        with(throne_idle1103) {active=true;hp=0;event_perform_object(NothingInactive,ev_step,ev_step_normal);}
        scrHMGameplayCheck(instance_exists(BecomeNothing),"native sleeping damage creates the actual wake-up transition");
        with(BecomeNothing) {
            sprite_index=sprNothingActivate;drawimg=sprite_get_number(sprite_index);
            event_perform_object(BecomeNothing,ev_step,ev_step_normal);
        }
        scrHMGameplayCheck(instance_number(Nothing)==1,"actual native wake animation spawns the fighting Throne");
    }
    if(ticks==128) {
        var _inside=0;
        with(Wall) if(x>=other.throne_bounds1103[0] && x<other.throne_bounds1103[2]
            && y>=(other.throne_bounds1103[1]+other.throne_bounds1103[3])/2-1920
            && y<(other.throne_bounds1103[1]+other.throne_bounds1103[3])/2+1920) _inside++;
        with(InvisiWall) if(x>=other.throne_bounds1103[0] && x<other.throne_bounds1103[2]
            && y>=(other.throne_bounds1103[1]+other.throne_bounds1103[3])/2-1920
            && y<(other.throne_bounds1103[1]+other.throne_bounds1103[3])/2+1920) _inside++;
        scrHMGameplayCheck(_inside==0,"actual wake clears the whole room-width, 120-cell longitudinal wall strip");
        scrHMGameplayCheck(instance_exists(throne_outside1103),"wake leaves walls beyond the full room width alone");
        with(Nothing) scrHMGameplayCheck(scrHMThroneBarVisible1103(),"awake fighting Throne becomes bar-eligible");
    }
    if(ticks==140) {
        throne_firstsong1103=MusCont.song;
        with(Nothing) instance_destroy();
        scrHMGameplayCheck(instance_exists(NothingDeath),"real first-phase Destroy begins native death sequence");
        scrHMGameplayCheck(scrHMThroneWinHeld1103() && MusCont.song==throne_firstsong1103,
            "first-phase native Destroy preserves music while scheduling its real victory alarm");
    }
    if(ticks==145) scrHMGameplayCheck(scrHMThroneWinHeld1103() && MusCont.song==throne_firstsong1103,
        "real alarm lifecycle preserves music while the hundred-tick second-phase transition is pending");
    if(ticks==270) {
        var _second=noone;
        with(CustomEnemy) if(scrHMScriptRef(on_step)==scrHMScriptRef(hm_bosses_throne_mod_gml_Throne2Step)) {_second=id;break;}
        scrHMGameplayCheck(instance_exists(_second),"real first-phase death continuation creates original custom phase two");
        scrHMGameplayCheck(scrHMThroneWinHeld1103(),"victory remains held through live phase two");
        _second.hp=0;throne_second1103=_second;
    }
    if(ticks==275) {
        scrHMGameplayCheck(!instance_exists(throne_second1103) && instance_exists(Nothing2Death),
            "real custom second-phase death creates native final death animation");
        scrHMGameplayCheck(GameCont.hm_followup_throne_second_dead && !scrHMThroneWinHeld1103(),
            "phase two death finally releases the victory music guard");
        scrHMGameplayCheck(MusCont.song==custom_sound_check(musBossDead),"only second-phase death starts the authored victory theme");
        // Reproduce the native alarm's no-Floor edge synchronously, preserving
        // the actual explosion/drop/debris event and its normal self-delete.
        with(Floor) instance_destroy(id,false);
        var _rad=instance_number(BigRad),_parts=instance_number(Nothing2Corpse),_portals=instance_number(BigPortal);
        with(Nothing2Death) {alarm[0]=-1;event_perform_object(Nothing2Death,ev_alarm,0);}
        scrHMGameplayCheck(!instance_exists(Nothing2Death) && !instance_exists(Floor),"native death alarm safely completes with no Floor anchors");
        scrHMGameplayCheck(instance_number(BigRad)==_rad+10 && instance_number(Nothing2Corpse)==_parts+5,
            "no-Floor guard retains all ten native radiation drops and five debris parts");
        scrHMGameplayCheck(instance_number(BigPortal)==_portals,"native death alarm does not create an early final exit");
        // Five remote cells keep the generic harness's generation watchdog
        // enabled; none is under the falling player or the ending camera.
        for(var _i=0;_i<5;++_i) instance_create(18000+_i*32,18000,Floor);
        with(Portal) instance_destroy(id,false);
        player.fallenable=1;player.portalfall=player.y;player.speed=0;
        player.image_alpha=1;player.scale=1;player.sprite_angle=0;player.angle=0;
        throne_fally1103=player.y;
    }
    if(ticks==290) {
        scrHMGameplayCheck(player.y>=throne_fally1103+80 && player.spr_shadow_y==10000,
            "actual ending logic descends and hides only the shadow off-platform");
        scrHMGameplayCheck(player.image_alpha==1 && player.scale==1 && abs(player.sprite_angle)>0,
            "original fall rotates the full-size visible player instead of applying PortalShrink");
        player.y=player.portalfall+3992;
    }
    if(ticks==296) {
        var _exit=noone;with(Portal) if(variable_instance_exists(id,"nokill") && nokill
            && variable_instance_exists(id,"nompportal") && nompportal) {_exit=id;break;}
        scrHMGameplayCheck(instance_exists(_exit) && _exit.endgame<100 && player.fallenable==-1,
            "original 4000-pixel descent owns the committed final portal");
        scrHMGameplayCheck(player.spr_shadow_y==0 && player.sprite_angle==0,
            "finishing the original descent resets angle and shadow offset");
        goal_ticks=ticks;
    }
}

function scrHMGameplayRoutes1103() {
    if(mode=="sync113vault") scrHMGameplayVault1103();
    if(mode=="sync113lift") scrHMGameplayLift1103();
    if(mode=="sync113throne") scrHMGameplayThrone1103();
}
