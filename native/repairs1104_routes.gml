// Throne phase ownership is separate from native area-number conventions.
function scrHMThroneSecond1104() {
    if(!scrHMEnabled() || !instance_exists(GameCont)
       || GameCont.area!=scrHMAreaResolve("throne")) return false;
    if(variable_instance_get(GameCont,"hm_second_started1104")??false) return true;
    var _second=instance_exists(NothingDeath) || instance_exists(Nothing2Appear) || instance_exists(Nothing2Death);
    if(!_second) with(CustomEnemy) if(spr_idle==sprNothing2Idle) {_second=true;break;}
    // The old MOD leaves an invisible native Nothing2 at (0,0); it is not a boss.
    if(!_second) with(Nothing2) if(hp>0 && image_alpha>0 && mask_index!=mskNone && mask_index!=0) {_second=true;break;}
    if(_second) GameCont.hm_second_started1104=true;
    return _second;
}

function scrHMThronePoliceClear1104() {
    if(!scrHMThroneSecond1104()) return;
    // Never run destruction callbacks while cancelling a pending arrival.
    with(WantPopo) instance_destroy(id,false);
    with(WantVan) instance_destroy(id,false);
    with(IDPDSpawn) instance_destroy(id,false);
    with(VanSpawn) instance_destroy(id,false);
    with(CustomObject) if(array_contains(["hm_infantry_gate","hm_robot_gate","3dvan"],name)) {
        if(instance_exists(self[$ "baby"]??noone)) instance_destroy(baby,false);
        instance_destroy(id,false);
    }
}

function scrHMExtraPresentation1104(_focus) {
    if(!scrHMEnabled() || !instance_exists(GameCont)) return false;
    // During constructors the actor flag has not yet been assigned. Both
    // guards are needed for normal and extra instances of the same boss.
    if(variable_instance_get(GameCont,"hm_extra_pending")??false) return true;
    // Some native MOD calls focus the player/floor instead of the caller.
    if(self[$ "hm_extra"]??false) return true;
    var _source=self[$ "creator"]??noone;
    if(instance_exists(_source) && (_source[$ "hm_extra"]??false)) return true;
    return instance_exists(_focus) && (_focus[$ "hm_extra"]??false);
}

function scrHMExtraCrystalNative1115() {
    // The wrapper runs at 30 Hz while host motion/friction run at 30/60 Hz.
    // Native acceleration and countdowns therefore need one full logic tick.
    // In half-time frames the old .5*timescale^2 impulse was smaller than
    // the two intervening host-friction deductions, leaving the crystal still.
    var _scale=timescale;
    hspeed/=_scale;vspeed/=_scale;friction/=(_scale*_scale);image_speed/=_scale;
    global.time_scale=1;
    scrHMContentEvent1100(HyperCrystal,ev_other,10);
    global.time_scale=_scale;
    hspeed*=_scale;vspeed*=_scale;friction*=(_scale*_scale);image_speed*=_scale;
}

function scrHMExtraCrystalTick1115() {
    if(hp<=0 || !instance_exists(target)) return;
    // The ordinary/cursed crystal scans cannot see CustomEnemy wrappers.
    if(fastspin>0) image_speed=min(1.2*timescale,image_speed+.05*timescale);
    else image_speed=max(.4*timescale,image_speed-.05*timescale);
    if((self[$ "hm_extra_kind"]??"")!="cursedcrystal") return;
    canfly=true;
    if(current_frame<(self[$ "hm_extra_teleport_at1115"]??0)) return;
    hm_extra_teleport_at1115=current_frame+irandom_range(30,60);
    // Use the original lateral 64-pixel blink, with collision validation.
    // Trying the opposite side avoids an invisible enemy trapped in a wall.
    var _toward=point_direction(x,y,target.x,target.y);
    var _angle=_toward+choose(-90,90)+random_range(-30,30);
    var _distance=point_distance(x,y,target.x,target.y)>view_width-32
        ?min(point_distance(x,y,target.x,target.y)/2,160):64;
    if(_distance>64) _angle=_toward;
    for(var _i=0;_i<8;++_i) {
        var _a=_angle+_i*45,_x=x+lengthdir_x(_distance,_a),_y=y+lengthdir_y(_distance,_a);
        if(!hm_arkintide_mod_gml_hm_extra_fit("cursedcrystal",_x,_y)) continue;
        x=_x;y=_y;xprevious=x;yprevious=y;
        direction=_toward;
        hm_extra_last_blink1115=current_frame;
        instance_create(x,y,PortalClear);
        return;
    }
}

function scrHMExplosionSource1115(_source) {
    if(!scrHMEnabled() || !instance_exists(_source)) return;
    var _owner=_source[$ "hm_rocket_owner1115"]??noone;
    if(_owner==noone) return;
    // Keep the original launcher even if a melee deflection changes creator.
    hm_rocket_owner1115=_owner;
    creator=_source[$ "creator"]??noone;
    hitid=_source[$ "hitid"]??hitid;
    // Explosion team stays native: immunity applies only to its own boss.
}

function scrHMSelfRocketImmune1115(_target,_source) {
    if(!scrHMEnabled() || !instance_exists(_target) || !instance_exists(_source)) return false;
    return (_source[$ "hm_rocket_owner1115"]??noone)==_target;
}

// Isolated, multi-frame regression scenarios registered by the main driver.
function scrHMGameplayExtra1115() {
    if(string_pos("extra1115",mode)!=1) return;
    var _kind=string_delete(mode,1,9);
    if(_kind=="jungle") _kind="junglebandit";
    if(_kind=="cursed") _kind="cursedcrystal";
    if(ticks==10) {
        scrHMGameplayLane107();
        scrHMGameplayNoReplacement1115();
        extra_complete1115=false;
        UberCont.opt_bossintro=1;
        scrHMModSet("mod","options","intropan","1");
        scrHMModSet("mod","options","bossoutros","1");
        extra_actor1115=hm_arkintide_mod_gml_hm_extra_spawn(_kind,player.x+180,player.y);
        scrHMGameplayCheck(instance_exists(extra_actor1115),"extra fixture uses the production factory: "+_kind);
        extra_max1115=extra_actor1115.max_hp;
        extra_spawn_frame1115=current_frame;
        extra_start1115={x:extra_actor1115.x,y:extra_actor1115.y,angle:extra_actor1115[$ "angle"]??0};
        if(_kind=="cursedcrystal") extra_actor1115.hm_extra_teleport_at1115=current_frame+35;
    }
    if((_kind=="bandit"||_kind=="junglebandit") && ticks==40) {
        with(extra_actor1115) {
            hm_arkintide_mod_gml_hm_extra_event(ev_alarm,5);
            hm_bosses_bossintros_mod_gml_boss_trigger("",mskNone,mskNone,mskNone,target,0);
        }
        scrHMGameplayCheck(!UberCont.bossintro && !instance_exists(HMWorld.hm_portrait_active),
            "native and player-focused introductions reject extra "+_kind);
        var _binding=instance_create(0,0,HMBinding);
        _binding.creator=extra_actor1115;
        var _px=player.x,_py=player.y;
        with(_binding) hm_enemies_mod_gml_banditbossoutro(_px,_py);
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active),"delayed extra bandit outro stays suppressed");
    }
    if((_kind=="crystal"||_kind=="cursedcrystal") && ticks==120) {
        scrHMGameplayCheck(instance_exists(extra_actor1115),"extra crystal survives real AI ticks");
        scrHMGameplayCheck(extra_actor1115.angle>extra_start1115.angle+20,
            "extra crystal runs its native User Event 0 rotation/movement AI");
        scrHMGameplayCheck(extra_actor1115.crystals==1 && extra_actor1115.cnumber==3,
            "extra crystal native alarm summons its pre-loop three-crystal formation");
        scrHMGameplayCheck(extra_actor1115.max_hp==extra_max1115,
            "extra crystal keeps its single five-percent-per-loop HP budget");
        if(_kind=="cursedcrystal") {
            scrHMGameplayCheck((extra_actor1115[$ "hm_extra_last_blink1115"]??-1)>extra_spawn_frame1115,
                "cursed extra crystal blinks to a validated open-floor destination");
            var _cursed=true;
            for(var _i=0;_i<extra_actor1115.cnumber;++_i) {
                var _child=extra_actor1115.crystal[_i];
                if(instance_exists(_child) && !array_contains([InvLaserCrystal,LightningCrystal],_child.object_index)) _cursed=false;
            }
            scrHMGameplayCheck(_cursed,"cursed extra crystal summons only cursed or lightning crystals in every area");
        }
        scrHMGameplayCheck(!UberCont.bossintro && !instance_exists(HMWorld.hm_portrait_active),
            "extra crystal never requests a boss presentation");
        extra_complete1115=true;
    }
    if(_kind=="hunter" && ticks==40) scr_hit(extra_actor1115,extra_actor1115.hp+100,HitId.Player);
    if(_kind=="hunter" && ticks==43) {
        extra_wreck1115=noone;
        with(LilHunterDie) if(self[$ "hm_extra"]??false) other.extra_wreck1115=id;
        scrHMGameplayCheck(instance_exists(extra_wreck1115),"extra Hunter death spawns its native flying wreck");
        scrHMGameplayCheck(extra_wreck1115.lastwish==1 && extra_wreck1115.hitid==HitId.LilHunterDie,
            "extra Hunter wreck retains its death damage identity without normal boss conversion");
        extra_wreck_start1115={x:extra_wreck1115.x,y:extra_wreck1115.y};
    }
    if(_kind=="hunter" && ticks==60) {
        scrHMGameplayCheck(instance_exists(extra_wreck1115)
            && point_distance(extra_wreck1115.x,extra_wreck1115.y,extra_wreck_start1115.x,extra_wreck_start1115.y)>2,
            "extra Hunter wreck really flies before its final self-destruction");
        with(extra_wreck1115) event_perform(ev_alarm,2);
        scrHMGameplayCheck(!instance_exists(extra_wreck1115),"extra Hunter wreck completes native self-destruction");
        var _blasts=0;with(Explosion) if(hitid==HitId.LilHunterDie) _blasts++;
        scrHMGameplayCheck(_blasts==3,"extra Hunter death uses exactly the base three explosions at every Loop");
        var _badcorpse=false;with(Corpse) if(sprite_index==sprLilHunterDead) _badcorpse=true;
        scrHMGameplayCheck(!_badcorpse && !instance_exists(HMWorld.hm_portrait_active),
            "extra Hunter death creates no normal boss outro or normal corpse marker");
        extra_complete1115=true;
    }
    if((_kind=="bandit"||_kind=="junglebandit") && ticks==60)
        scr_hit(extra_actor1115,extra_actor1115.hp+100,HitId.Player);
    if((_kind=="bandit"||_kind=="junglebandit") && ticks==90) {
        scrHMGameplayCheck(!instance_exists(extra_actor1115),"actual extra bandit completes death before outro observation");
        scrHMGameplayCheck(!UberCont.bossintro && !instance_exists(HMWorld.hm_portrait_active),
            "extra bandit death does not play an outro");
        extra_complete1115=true;
    }
    if(ticks==goal_ticks-5) scrHMGameplayCheck(self[$ "extra_complete1115"]??false,
        "all intended extra-boss observations executed before scenario completion");
}

function scrHMGameplayRocket1115() {
    if(string_pos("rocket1115",mode)!=1) return;
    if(ticks==goal_ticks-5) scrHMGameplayCheck(self[$ "rocket_complete1115"]??false,
        "real boss launch, neutral/child blast immunity and player damage assertions all executed");
    if(ticks!=20) return;
    scrHMGameplayLane107();
    var _bird=mode=="rocket1115bird";
    var _boss=_bird?hm_arkintide_mod_gml_hm_extra_spawn("bird",player.x+180,player.y)
        :hm_bosses_gungod_mod_gml_GunGod_create(player.x+180,player.y);
    scrHMGameplayCheck(instance_exists(_boss),"rocket fixture uses the production boss factory");
    _boss.hm_entry_camera1101=true;_boss.hm_exit_camera1101=true;_boss.on_step=undefined;
    with(JockRocket) instance_destroy(id,false);
    with(_boss) {
        if(_bird) {
            // The production extra factory deliberately delays attacks for
            // one second. This fixture exercises the actual rocket attack.
            hm_extra_attack_at=current_frame;
            flying=false;alrm0=0;alrm1=1;alrm2=0;alrm3=0;alrm4=0;
            ammo=1;angry=0;sprite_index=spr_idle;image_index=0;
            hm_bosses_ravenboss_mod_gml_ravenboss_step();
        } else {
            attacktype=1;attackchange=1000;attackpause=0;
            for(var _i=0;_i<120 && !instance_exists(JockRocket);++_i) {
                attackpause=0;
                hm_bosses_gungod_mod_gml_GunGod_step();
            }
        }
    }
    var _rocket=noone;
    with(JockRocket) if((self[$ "hm_rocket_owner1115"]??noone)==_boss.id) _rocket=id;
    scrHMGameplayCheck(instance_exists(_rocket),"real boss attack emits a rocket with its immutable launcher");
    var _owner=_boss.id,_before=_boss.hp;
    // A reflected rocket retains the original launcher's immunity.
    _rocket.creator=player.id;_rocket.team=player.team;_rocket.x=_boss.x;_rocket.y=_boss.y;
    with(Explosion) instance_destroy(id,false);
    instance_destroy(_rocket);
    var _blasts=[];
    with(Explosion) if((self[$ "hm_rocket_owner1115"]??noone)==_owner) array_push(_blasts,id);
    scrHMGameplayCheck(array_length(_blasts)==2,"native JockRocket destruction propagates both blast origins");
    var _blast=_blasts[0];
    scrHMGameplayCheck(_blast.team==team_none,"own-rocket immunity preserves neutral native explosion collision teams");
    with(_boss) with(_blast) event_perform_object(Explosion,ev_collision,hitme);
    with(_blast) {
        scr_hit(_owner,1,hitid);
        scr_projectile_hit(_owner,1);
        event_perform_object(Explosion,ev_alarm,1);
    }
    scrHMGameplayCheck(_boss.hp==_before,"own rocket direct, projectile and real explosion collision cannot hurt its boss");
    var _small=0;
    with(SmallExplosion) if((self[$ "hm_rocket_owner1115"]??noone)==_owner) {
        _small++;
        scr_hit(_owner,1,hitid);
    }
    scrHMGameplayCheck(_small==3 && _boss.hp==_before,"Crown-of-Death child blasts retain the same narrowly scoped immunity");
    var _target=instance_create(_boss.x+100,_boss.y,Bandit),_target_hp=_target.hp;
    with(_blast) scr_hit(_target,1,hitid);
    scrHMGameplayCheck(_target.hp==_target_hp-1,"the boss's rocket still damages other enemies");
    var _player_shot=instance_create(player.x,player.y,Bullet1);
    _player_shot.creator=player.id;_player_shot.hitid=HitId.Player;_player_shot.team=player.team;
    with(_player_shot) scr_projectile_hit(_owner,1);
    scrHMGameplayCheck(_boss.hp==_before-1,"normal player bullets still damage the protected boss");
    instance_destroy(_player_shot,false);
    show_debug_message("HARDMODE ROCKET1115 "+json_stringify({kind:_bird?"bird":"gungod",loops:GameCont.loops,
        neutral_blasts:array_length(_blasts),child_blasts:_small,self_damage:0,player_damage:1}));
    rocket_complete1115=true;
}
