function scrHMGameplayRoutes1104() {
    scrHMGameplayChief1115();
    scrHMGameplayYV1115();
    if(mode=="fix114arena" && (ticks==20 || ticks==60)) {
        // Observe the real area_start entry actors without changing enemy HP,
        // player position, pending thresholds or map geometry. Guardian's
        // statue needs >200 near-player ticks; Bird waits for half the room's
        // enemies to die. Pending entry actors are not combat-boss evidence.
        var _parts=string_split(scenario,","),_palace=_parts[0]=="palace";
        var _expected=scrHMAreaResolve(_palace?"palace":"ravenboss");
        scrHMGameplayCheck(GameCont.area==_expected && GameCont.subarea==real(_parts[1]),
            "natural arena remains in its requested area and subarea");
        scrHMGameplayCheck(!instance_exists(GenCont) && instance_number(Floor)>=5,
            "real affected arena generation completed with native Floor");
        scrHMGameplayCheck(instance_exists(player) && instance_is(player,Player) && player.hp>0,
            "natural arena retains its actual living Player");
        var _intro=HMWorld.hm_portrait_active,_recorded=false,_owned=false;
        if(instance_exists(_intro)) {
            var _records=_intro[$ "hm_portrait_records"]??[];
            for(var _i=0;_i<array_length(_records);++_i)
                if(_records[_i].who==player.id) _recorded=true;
            _owned=_intro.name=="bossintro" && scrHMScriptRef(_intro.on_step)
                ==scrHMScriptRef(hm_bosses_bossintros_mod_gml_customboss_step)
                && _recorded && (player[$ "hm_portrait_frozen"]??false)
                && global.hm_camera_targets[player.index]==_intro.id
                && variable_instance_exists(player,"_mask") && player.mask_index==mskNone;
        }
        scrHMGameplayCheck((player.can_walk && player.can_pick) || _owned,
            "Player controls are available or owned by the actual live boss presentation with a saved Player freeze record");
        if(ticks==20) {
            arena_intro114=instance_exists(_intro)?_intro.id:noone;
            arena_bossx114=instance_exists(_intro)?_intro.bossx:0;
            arena_saw_intro114=instance_exists(_intro);
        } else if(instance_exists(_intro) && _intro.id==arena_intro114) {
            scrHMGameplayCheck(_intro.bossx<arena_bossx114,
                "same natural presentation makes forward progress instead of retaining a permanent owned lock");
        }
        if(instance_exists(_intro)) arena_saw_intro114=true;
        // Presentation temporarily uses mskNone on Player. Probe the saved
        // real Player mask on this test controller, then restore it in the
        // same call; never alter Player or disable the real presentation.
        var _probe_before=[x,y,sprite_index,mask_index,image_xscale,image_yscale,image_angle];
        x=player.x;y=player.y;sprite_index=player.sprite_index;
        mask_index=_owned?player._mask:player.mask_index;
        image_xscale=player.image_xscale;image_yscale=player.image_yscale;image_angle=player.image_angle;
        var _reach=scrHMGameplayAllAreasReach1103(id);
        x=_probe_before[0];y=_probe_before[1];sprite_index=_probe_before[2];mask_index=_probe_before[3];
        image_xscale=_probe_before[4];image_yscale=_probe_before[5];image_angle=_probe_before[6];
        scrHMGameplayCheck(_reach>=3,
            "Player occupies native Floor with clear Wall/InvisiWall collision and a reachable approach");
        var _pending=0,_active=0,_valid_pending=0,_valid_active=0,_witnesses=[];
        with(CustomObject) {
            if((_palace && name=="guardianstatue") || (!_palace && name=="wantRavenboss")) {
                _pending++;
                var _callback=_palace?hm_bosses_guardianboss_mod_gml_GuardianStatue_step
                    :hm_bosses_ravenboss_mod_gml_wantravenboss_step;
                var _valid=scrHMScriptRef(on_step)==scrHMScriptRef(_callback);
                if(_valid) _valid_pending++;
                array_push(_witnesses,{id:id,name:name,x:x,y:y,state:"pending",callback_valid:_valid});
            }
        }
        with(CustomEnemy) {
            if(((_palace && name=="guardianboss") || (!_palace && name=="BIG BIRD"))
                && !(self[$ "hm_extra"]??false)) {
                _active++;
                var _callback=_palace?hm_bosses_guardianboss_mod_gml_guardianboss_step
                    :hm_bosses_ravenboss_mod_gml_ravenboss_step;
                var _valid=hp>0 && max_hp>0 && scrHMScriptRef(on_step)==scrHMScriptRef(_callback);
                if(_valid) _valid_active++;
                array_push(_witnesses,{id:id,name:name,x:x,y:y,state:"active",hp:hp,max_hp:max_hp,callback_valid:_valid});
            }
        }
        scrHMGameplayCheck(_pending+_active>0,
            "actual area_start retains its natural boss entry actor or a live activated boss");
        scrHMGameplayCheck(_pending==_valid_pending && _active==_valid_active,
            "every natural pending/active arena witness has its actual production callback and live state");
        show_debug_message("HARDMODE ARENA114 "+json_stringify({scenario:scenario,ticks:ticks,
            pending:_pending,active:_active,reachable_spawn_points:_reach,witnesses:_witnesses,
            controls_available:player.can_walk && player.can_pick,presentation_owned:_owned,
            presentation:instance_exists(_intro)?_intro.id:noone,
            presentation_position:instance_exists(_intro)?_intro.bossx:0}));
    }
    if(mode=="fix114arena" && ticks==80) {
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active),
            "natural arena presentation finishes within the observation interval");
        scrHMGameplayCheck(instance_exists(player) && player.can_walk && player.can_pick
            && !(player[$ "hm_portrait_frozen"]??false),
            "actual presentation completion restores Player controls and releases its freeze");
        scrHMGameplayCheck(!arena_saw_intro114 || global.hm_camera_targets[player.index]==player.id,
            "actual presentation completion returns the camera to Player");
    }
    if(mode=="fix114music" && ticks==20) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("palace") && GameCont.subarea==4,"music check begins naturally in7-4");
        scrHMGameplayCheck(MusCont.song==custom_sound_check(mus7b),"natural7-4 already plays PalaceB before the test changes anything");
        var _handle=MusCont.music_sound;
        scrHMGameplayCheck(MusCont.song==custom_sound_check(mus7b),"7-4 owns Palace sideB");
        GameCont.area=scrHMAreaResolve("throne");
        hm_areas_throne_area_gml_area_setup();
        scrHMGameplayCheck(MusCont.song==custom_sound_check(mus7b) && MusCont.music_sound==_handle,"actual Throne setup continues same playback handle");
        with(MusCont) {hm_music_area112=-999;scrHMMusicRoom112();}
        scrHMGameplayCheck(MusCont.song==custom_sound_check(mus7b) && MusCont.music_sound==_handle,"fallback music repair preserves PalaceB playback");
    }
    if(mode=="fix114throne" && ticks==1) {
        // This fixture measures the phase-II continuation at a fixed logical
        // deadline. Presentation freezes have their own real-camera coverage;
        // keep their pauses outside the sustained police-gate stress budget.
        UberCont.opt_bossintro=0;
        scrHMModSet("mod","options","intropan","0");
        scrHMModSet("mod","options","bossoutros","0");
    }
    if(mode=="fix114throne" && ticks==20) {
        UberCont.opt_bossintro=0;
        var _idle=instance_find(NothingInactive,0);
        scrHMGameplayCheck(instance_exists(_idle),"naturally generated Throne starts sleeping");
        walls114=[];
        with(Wall) array_push(other.walls114,[id,x,y,mask_index,solid]);
        with(InvisiWall) array_push(other.walls114,[id,x,y,mask_index,solid]);
        roofs114=instance_number(TopSmall);
        scrHMGameplayCheck(array_length(walls114)>0,"actual arena has collision wall witnesses");
        // Reconstruct the connected arena used by the retired 120-cell
        // clearance. Distant menu geometry must not count as a witness.
        var _seed=instance_nearest(player.x,player.y,Floor);
        var _left=_seed.x,_top=_seed.y,_right=_seed.x+32,_bottom=_seed.y+32,_changed=true;
        while(_changed) {
            _changed=false;
            with(Floor) if(x<=_right+32 && x+32>=_left-32 && y<=_bottom+32 && y+32>=_top-32) {
                var _l=min(_left,x),_t=min(_top,y),_r=max(_right,x+32),_b=max(_bottom,y+32);
                if(_l!=_left || _t!=_top || _r!=_right || _b!=_bottom) _changed=true;
                _left=_l;_top=_t;_right=_r;_bottom=_b;
            }
        }
        var _mid=(_top+_bottom)/2;
        remote_walls114=[];
        with(Wall) if(x>=_left && x<_right && y>=_mid-60*32 && y<_mid+60*32) {
            // A native contact can split a packed Wall into 16px cells.
            // Preserve collision geometry, rather than requiring the packed
            // parent's instance ID to survive that legitimate local split.
            var _width=self[$ "hm_fill_w106"]??16,_height=self[$ "hm_fill_h106"]??16;
            for(var _dx=0;_dx<_width;_dx+=16) for(var _dy=0;_dy<_height;_dy+=16) {
                var _cx=x+_dx+8,_cy=y+_dy+8;
                if(collision_point(_cx,_cy,id,false,false)!=noone)
                    array_push(other.remote_walls114,{id:id,x:_cx,y:_cy,origin_x:x,origin_y:y,
                        bounds:[bbox_left,bbox_top,bbox_right,bbox_bottom],width:_width,height:_height});
            }
        }
        scrHMGameplayCheck(array_length(remote_walls114)>0,
            "real arena supplies original collision cells inside the old 120-cell sweep");
        with(_idle) {active=true;hp=0;event_perform_object(NothingInactive,ev_step,ev_step_normal);}
        with(BecomeNothing) {sprite_index=sprNothingActivate;drawimg=sprite_get_number(sprite_index);event_perform_object(BecomeNothing,ev_step,ev_step_normal);}
        scrHMGameplayCheck(instance_number(Nothing)==1,"native wake transition creates fighting Throne");
        native_contacts114=[];
    }
    if(mode=="fix114throne" && ticks>=20 && ticks<=23) {
        // Nothing/Create activates BigGeneratorInactive synchronously. Read
        // the actual active masks after that constructor, and over all real
        // collision ticks; sleeping-actor origins do not bound those masks.
        with(Nothing) array_push(other.native_contacts114,{id:id,kind:"Nothing",tick:other.ticks,
            x:x,y:y,left:bbox_left,top:bbox_top,right:bbox_right,bottom:bbox_bottom});
        with(BigGenerator) array_push(other.native_contacts114,{id:id,kind:"BigGenerator",tick:other.ticks,
            x:x,y:y,left:bbox_left,top:bbox_top,right:bbox_right,bottom:bbox_bottom});
    }
    if(mode=="fix114throne" && ticks==23) {
        // Native Nothing/BigGenerator Collision_Wall legitimately destroy
        // touching walls and update adjacent masks. Test the removed broad
        // carve independently, after those real collision events have run.
        var _natural_changes=[];
        for(var _i=0;_i<array_length(walls114);++_i) {
            var _w=walls114[_i],_actor=_w[0];
            if(!instance_exists(_actor)) array_push(_natural_changes,{id:_actor,x:_w[1],y:_w[2],change:"native removal"});
            else if(_actor.x!=_w[1] || _actor.y!=_w[2] || _actor.mask_index!=_w[3] || _actor.solid!=_w[4])
                array_push(_natural_changes,{id:_actor,x:_w[1],y:_w[2],change:"native neighbor geometry"});
        }
        var _remote_kept=0,_remote_total=0,_remote_missing=[],_native_local=0;
        for(var _i=0;_i<array_length(remote_walls114);++_i) {
            var _w=remote_walls114[_i];
            var _local=false;
            for(var _j=0;_j<array_length(native_contacts114);++_j) {
                var _n=native_contacts114[_j];
                // Collision_Wall removes touching 16px cells. FloorExplo
                // then materializes a further 32px neighbourhood: 16+32.
                // This bounds the real local operation from live bboxes,
                // including mirrored generators, instead of a radius from
                // the sleeping Throne and not-yet-created generators.
                if(_w.x+7>=_n.left-48 && _w.x-8<=_n.right+48
                    && _w.y+7>=_n.top-48 && _w.y-8<=_n.bottom+48) {_local=true;break;}
            }
            if(_local) {_native_local++;continue;}
            _remote_total++;
            var _at=collision_point(_w.x,_w.y,Wall,false,false);
            if(instance_exists(_at) && _at.solid) _remote_kept++;
            else array_push(_remote_missing,_w);
        }
        show_debug_message("HARDMODE THRONE114 NATIVE WALL CHANGES "+json_stringify({
            original_cells:array_length(remote_walls114),native_local_cells:_native_local,
            remote_witnesses:_remote_total,remote_retained:_remote_kept,remote_missing:_remote_missing,
            native_contacts:native_contacts114,
            changed:_natural_changes,roofs_before:roofs114,roofs_after:instance_number(TopSmall)}));
        scrHMGameplayCheck(_remote_total>0,
            "old broad sweep contains actual collision witnesses beyond the live native contact neighbourhoods");
        scrHMGameplayCheck(_remote_kept==_remote_total,
            "actual native wake retains every remote original collision cell inside the former broad clearance");
        walls114=[];
        with(Wall) array_push(other.walls114,[id,x,y,mask_index,solid]);
        with(InvisiWall) array_push(other.walls114,[id,x,y,mask_index,solid]);
        var _wall_count=instance_number(Wall)+instance_number(InvisiWall),_roof_snapshot=[];
        with(TopSmall) array_push(_roof_snapshot,[id,x,y,sprite_index]);
        scrHMThroneTick1103();scrHMThroneOpenWalls1103();
        var _kept=0;
        for(var _i=0;_i<array_length(walls114);++_i) {
            var _w=walls114[_i],_actor=_w[0];
            if(instance_exists(_actor) && _actor.x==_w[1] && _actor.y==_w[2] && _actor.mask_index==_w[3] && _actor.solid==_w[4]) _kept++;
        }
        scrHMGameplayCheck(_kept==array_length(walls114)
            && instance_number(Wall)+instance_number(InvisiWall)==_wall_count,
            "retired wake helpers preserve every live wall identity, mask and collision synchronously");
        var _roofs_kept=0;
        for(var _i=0;_i<array_length(_roof_snapshot);++_i) {
            var _r=_roof_snapshot[_i];
            if(instance_exists(_r[0]) && _r[0].x==_r[1] && _r[0].y==_r[2] && _r[0].sprite_index==_r[3]) _roofs_kept++;
        }
        scrHMGameplayCheck(_roofs_kept==array_length(_roof_snapshot) && instance_number(TopSmall)==array_length(_roof_snapshot),
            "retired wake helpers preserve every live wall roof synchronously");
        with(Nothing) {hp=0;instance_destroy();}
        scrHMGameplayCheck(scrHMThroneSecond1104(),"first phase death latches police exclusion before custom second phase");
        player.race=Race.Rogue;
        portals_attempted114=0;
    }
    if(mode=="fix114throne" && ticks>=24 && ticks<185) {
        var _g=instance_create(player.x+64,player.y,IDPDSpawn);
        scrHMGameplayCheck(!instance_exists(_g),"phaseII rejects every native portal before its Create completes");
        var _p=instance_create(player.x+32,player.y,Portal);
        scrHMGameplayCheck(!instance_exists(IDPDSpawn),"Rogue exit creation cannot create phaseII police gates");
        if(instance_exists(_p)) instance_destroy(_p,false);
        var _gate=instance_create(player.x+64,player.y,CustomObject);
        _gate.name="hm_infantry_gate";
        scrHMThronePoliceClear1104();
        scrHMGameplayCheck(!instance_exists(_gate),"captured infantry gates are cancelled without spawning");
        portals_attempted114++;
    }
    if(mode=="fix114throne" && ticks==186) {
        var _second=false;with(CustomEnemy) if(spr_idle==sprNothing2Idle) _second=true;
        scrHMGameplayCheck(_second,"actual death continuation has created live custom ThroneII during the portal stress");
        scrHMGameplayCheck(portals_attempted114==161 && !instance_exists(IDPDSpawn) && !instance_exists(VanSpawn),"sustained transition+phaseII+Rogue attempts leave zero police gates");
        with(NothingDeath) instance_destroy(id,false);with(Nothing2) instance_destroy(id,false);
        with(CustomEnemy) if(spr_idle==sprNothing2Idle) instance_destroy(id,false);
        hm_areas_throne_area_gml_area_setup();
        scrHMGameplayCheck(!scrHMThroneSecond1104(),"next actual Throne setup resets the prior phaseII exclusion latch");
        var _initial=instance_create(player.x+64,player.y,IDPDSpawn);
        scrHMGameplayCheck(instance_exists(_initial),"next initial Throne visit still permits its normal delayed police arrival");
        if(instance_exists(_initial)) instance_destroy(_initial,false);
    }
    if(mode=="fix114extra" && ticks==20) {
        scrHMGameplayLane107();
        scrHMModSet("mod","options","intropan","1");scrHMModSet("mod","options","bossoutros","1");
        var _extra=instance_create(player.x+96,player.y,CustomEnemy);
        _extra.hm_extra=true;_extra.name="GunGod";_extra.spr_idle=sprNothing2Idle;
        with(_extra) {
            hm_bosses_bossintros_mod_gml_boss_trigger("",mskNone,mskNone,mskNone,id,0);
            hm_bosses_bossintros_mod_gml_boss_death();
            scrHMBossCamera1101(id,false);scrHMBossCamera1101(id,true);
        }
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active),"extra actor cannot start either entry or exit camera");
        GameCont.hm_extra_pending=true;
        var _building=instance_create(player.x+64,player.y,CustomEnemy);
        with(_building) hm_bosses_bossintros_mod_gml_boss_trigger("",mskNone,mskNone,mskNone,id,0);
        GameCont.hm_extra_pending=false;
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active),"constructor cannot start a pan before extra flag assignment");
        scrHMGameplayCheck(player.can_walk,"suppressed extra presentation preserves player input");
        instance_destroy(_building,false);instance_destroy(_extra,false);
    }
}

// These observations run in the real host events. No test advances the
// Captain's arrival, portrait timeout, camera timer or attack alarms.
function scrHMGameplayChief1115() {
    if(mode!="chief1115first" && mode!="chief1115repeat") return;
    if(ticks==10) {
        scrHMGameplayLane107();scrHMGameplayUICamera1104();
        scrHMGameplayNoReplacement1115();
        UberCont.opt_bossintro=1;
        scrHMModSet("mod","options","intropan","1");
        scrHMModSet("mod","options","bossoutros","1");
        GameCont.hm_chief_seen=mode=="chief1115repeat";
        chief1115=scrHMChiefCreate1102(player.x+110,player.y);
        global.hm_chief_visual1115={actor:chief1115,mode:mode,warp:false,portrait:false,camera:false,
            portrait_frames:0,portrait_count:0,native_active:false,camera_frames:0};
        chief_stage1115=[];chief_safe1115=true;chief_combat_at1115=-1;chief_complete1115=false;
        scrHMGameplayCheck(chief1115.drawspr==sprLastWarpIn && chief1115.drawimg==0
            && chief1115.hm_chief_arrival1102==20,"replacement Captain begins in the native teleport arrival pose");
        scrHMGameplayCheck(chief1115.alarm[1]==-1 && !chief1115.hm_chief_combat1115,
            "Captain entry starts with native attacks disarmed");
    }
    if(ticks<11) return;
    scrHMGameplayCheck(instance_exists(chief1115),"Captain remains the live native actor until the complete presentation observation ends");
    if(!chief1115.hm_chief_combat1115) {
        if(!array_contains([sprLastWarpIn,sprLastIdle],chief1115.drawspr)) chief_safe1115=false;
        if(chief1115.alarm[1]>0 || chief1115.ammo>0 || chief1115.charge>0) chief_safe1115=false;
    } else if(chief_combat_at1115<0) chief_combat_at1115=ticks;
    if(ticks mod 10==0 && ticks<160) array_push(chief_stage1115,{tick:ticks,
        arrival:chief1115.hm_chief_arrival1102,combat:chief1115.hm_chief_combat1115,
        sprite:sprite_get_name(chief1115.drawspr),frame:chief1115.drawimg,
        camera:instance_exists(HMWorld.hm_portrait_active),native:UberCont.bossintro});
    if(ticks==190) {
        scrHMGameplayCheck(chief1115.hm_chief_combat1115 && chief_combat_at1115>10,
            "real warp, portrait and camera finish before the Captain enters combat");
        scrHMGameplayCheck(chief_safe1115,"arrival and presentations never run or repeat the punch, dash or firing attack animation");
        var _visual=global.hm_chief_visual1115;
        scrHMGameplayCheck(_visual.warp && _visual.camera,"real draw events observe both the animated teleport and camera presentation");
        scrHMGameplayCheck(_visual.portrait_count==(mode=="chief1115first"?1:0),
            "first Captain portrait plays once per run and repeat replacement skips it");
        scrHMGameplayCheck(player.can_walk && player.can_pick && !(player[$ "hm_portrait_frozen"]??false),
            "Captain presentation returns the camera and controls to the actual Player");
        // Exercise the native teleport-landing attack alarm after normal
        // combat starts; this retains its actual reinforcement gate.
        chief1115.drawspr=sprLastWarpIn;chief1115.drawimg=0;
        chief1115.alarm[5]=1;
    }
    if(ticks==220) {
        scrHMGameplayCheck(chief1115.hm_chief_summons1115>=1,
            "native combat teleport landing summons the replacement Captain reinforcement gate");
        var _oldloop=GameCont.loops;
        var _ordinary=instance_create(player.x+180,player.y,Last);
        var _intro=_ordinary.intro,_alarm=_ordinary.alarm[1];
        for(var _i=0;_i<4;++_i) {
            var _loop=[0,1,10,30][_i];GameCont.loops=_loop;
            var _normal=0,_replacement=0;
            with(_ordinary) _normal=scrHMChiefSpeed1115();
            with(chief1115) _replacement=scrHMChiefSpeed1115();
            var _expected=min(2,1+_loop*.05),_delta=abs(_normal-_expected),_same=abs(_normal-_replacement);
            show_debug_message("HARDMODE CHIEF1115 SPEED "+json_stringify({loop:_loop,normal:_normal,replacement:_replacement,
                expected:_expected,delta:_delta,same:_same,epsilon:math_get_epsilon(),
                ordinary:object_get_name(_ordinary.object_index),replacement_object:object_get_name(chief1115.object_index)}));
            // A strict less-than at the VM's own epsilon compares as equal
            // even for zero error. This tolerance remains far below .05.
            scrHMGameplayCheck(_delta<.001 && _same<.001,
                "ordinary HQ and replacement Captain share the explicit capped five-percent Loop cadence");
        }
        GameCont.loops=_oldloop;
        scrHMGameplayCheck(_ordinary.intro==_intro && _ordinary.alarm[1]==_alarm
            && !(_ordinary[$ "hm_chief1102"]??false),"ordinary HQ Captain retains native introduction and campaign identity");
        GameCont.loops=10;
        _ordinary.alarm[1]=100;_ordinary.hm_chief_action1115=0;
        with(_ordinary) {
            // Two whole logical ticks, independent of the rendering rate.
            // This calls the same action supplement as ordinary Last.Step.
            var _scale=global.time_scale;global.time_scale=1;
            scrHMChiefAction1115();scrHMChiefAction1115();
            global.time_scale=_scale;
        }
        scrHMGameplayCheck(_ordinary.alarm[1]==99,
            "ordinary HQ Captain action supplement adds one native alarm tick over two Loop10 logic ticks");
        GameCont.loops=_oldloop;
        instance_destroy(_ordinary,false);
        chief_complete1115=true;
    }
    if(ticks==270) {
        scrHMGameplayCheck(chief_complete1115,"Captain entry and ordinary/replacement Loop checks all executed before completion");
        show_debug_message("HARDMODE CHIEF1115 "+json_stringify({mode:mode,rate:rate,
        combat_at:chief_combat_at1115,no_entry_attack:chief_safe1115,summons:chief1115.hm_chief_summons1115,
        visuals:global.hm_chief_visual1115,stages:chief_stage1115}));
    }
}

function scrHMGameplayChiefDraw1115() {
    if(!variable_global_exists("hm_chief_visual1115")) return;
    var _v=global.hm_chief_visual1115;
    if(UberCont.bossintro) {
        if(!_v.native_active) {_v.portrait_count++;_v.native_active=true;}
        _v.portrait_frames++;
        if(!_v.portrait && _v.portrait_frames>=12) {
            screen_save(game_directory+"chief1115-portrait.png");_v.portrait=true;
        }
        return;
    }
    _v.native_active=false;
    if(!instance_exists(_v.actor)) return;
    if(!_v.warp && _v.actor.hm_chief_arrival1102>2 && _v.actor.hm_chief_arrival1102<14
       && surface_exists(application_surface)) {
        surface_save(application_surface,game_directory+"chief1115-warp.png");_v.warp=true;
    }
    if(instance_exists(HMWorld.hm_portrait_active)) {
        _v.camera_frames++;
        if(!_v.camera && _v.camera_frames>=6 && surface_exists(application_surface)) {
            surface_save(application_surface,game_directory+"chief1115-camera.png");_v.camera=true;
        }
    }
}

function scrHMGameplayYV1115() {
    if(mode!="yv1115minigun") return;
    if(ticks==10) {
        scrHMGameplayLane107();UberCont.opt_bossintro=0;
        scrHMGameplayNoReplacement1115();
        scrHMModSet("mod","options","intropan","0");
        yv1115=instance_create(player.x+160,player.y,YVBoss);
        with(yv1115) {
            hm_entry_camera1101=true;hm_exit_camera1101=true;
            for(var _i=0;_i<12;++_i) alarm[_i]=-1;
            intro=true;wep=wep_minigun;ammo=90;gunangle=0;minigun_side=1;
            alarm[2]=1;speed=0;walk=0;
        }
        yv_first1115=-1;yv_last1115=-1;yv_ammo1115=90;yv_shots1115=0;yv_complete1115=false;
        scrHMGameplayCheck(yv1115.wep==wep_minigun && yv1115.ammo==90,
            "Y.V cadence fixture uses the real native minigun with ninety rounds");
    }
    if(ticks<11) return;
    scrHMGameplayCheck(instance_exists(yv1115),"Y.V remains present while native minigun cadence is observed");
    var _shot=yv_ammo1115-max(0,yv1115.ammo);
    if(_shot>0) {
        if(yv_first1115<0) yv_first1115=ticks;
        yv_last1115=ticks;yv_shots1115+=_shot;
    }
    yv_ammo1115=max(0,yv1115.ammo);
    if(ticks==120) {
        scrHMGameplayCheck(yv_shots1115==90 && yv1115.ammo==0,
            "ninety native minigun shots finish at both rendering frame settings");
        scrHMGameplayCheck(yv_last1115-yv_first1115>=88 && yv_last1115-yv_first1115<=91,
            "native minigun cadence remains one shot per thirty-Hz logical tick");
        scrHMGameplayCheck(yv1115.gunangle>=72 && yv1115.gunangle<=90,
            "native ninety-shot sweep retains the reference point-eight-to-one degree turn per shot");
        show_debug_message("HARDMODE YV1115 "+json_stringify({rate:rate,shots:yv_shots1115,
            first_tick:yv_first1115,last_tick:yv_last1115,angle:yv1115.gunangle}));
        yv_complete1115=true;
    }
    if(ticks==125) scrHMGameplayCheck(yv_complete1115,"all ninety-shot cadence and turning assertions execute before test completion");
}

function scrHMGameplayNoReplacement1115() {
    // Lane isolation removes CustomObject controllers. Recreate the actual
    // production controller, then disable only its independent random boss
    // substitution so it cannot replace the actor this scenario observes.
    var _controller=hm_arkintide_mod_gml_hm_native_controller();
    _controller.hm_gungod_rolled=true;_controller.hm_gungod_replaced=false;
    GameCont.hm_native_controller_id=_controller;
}
