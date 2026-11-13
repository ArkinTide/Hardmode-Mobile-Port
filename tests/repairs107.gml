function scrHMGameplayLane107() {
    scrHMGameplayIsolate103();HMWorld.hm_portrait_active=noone;
    player.frozen=false;player.hm_portrait_frozen=false;
    player.can_walk=true;player.can_pick=true;player.can_spec=true;
    for(var _i=0;_i<16;++_i) for(var _j=0;_j<12;++_j)
        instance_create(14000+_i*32,14000+_j*32,Floor);
    player.x=14064;player.y=14160;player.speed=0;
}

function scrHMGameplayReviveBinding107(_record,_remember=false) {
    var _body=_record.body,_count=0,_timer=noone,_expected=GameCont.loops>=3?1:0;
    scrHMGameplayCheck(instance_exists(_body) && instance_is(_body,Corpse),
        "each lethally hit police target retains its actual corpse until the native revival");
    if(!instance_exists(_body)) return;
    with(WantRevivePopoFreak) {
        var _native=self[$ "hm_corpse107"]??noone,_mod=self[$ "hm_police_corpse"]??noone;
        if(_native==_body || _mod==_body) {_count++;_timer=id;}
    }
    scrHMGameplayCheck(_count==_expected,
        "each actual police corpse owns exactly one late-loop timer and none before Loop3");
    if(_expected && _count==1) {
        scrHMGameplayCheck(_timer.hm_corpse107==_body && _timer.hm_police_corpse==_body
            && (_body[$ "hm_police_revive_once"]??false),
            "native and imported revival aliases point to the same once-marked corpse");
        if(_remember) _record.timer=_timer;
        else scrHMGameplayCheck(_record.timer==_timer,
            "corpse movement never creates or substitutes a second revival timer");
        // This observer runs in End Step, after corpse physics. The scanner
        // runs once per 30 Hz logic tick; at 60 Hz two physical steps have
        // elapsed, so speed is pixels per half-tick rather than per scan.
        var _logic_travel=_body.speed/max(timescale,.001);
        scrHMGameplayCheck(point_distance(_timer.x,_timer.y,_body.x,_body.y)<=max(1,_logic_travel+1),
            "the original revival timer follows within its single logical tick of actual corpse travel");
    }
}

function scrHMGameplayRepairs107() {
    if(mode=="trail107" && ticks==10) {scrHMGameplayLane107();trail_peak107=0;player.gunangle=90;}
    if(mode=="trail107" && ticks>=10 && ticks<=110 && ticks mod 10==0)
        repeat(4) with(player) scrHMWeaponFire(scrHMWeaponResolve("secretweapong1"));
    if(mode=="trail107" && ticks>=10) {
        var _count=0;with(Effect) if((self[$ "name"]??"")=="venuzpistoltrail") _count++;
        trail_peak107=max(trail_peak107,_count);
        if(ticks==180) {
            scrHMGameplayCheck(trail_peak107>4&&trail_peak107<=20,"sustained Venus weapon fire keeps a bounded trail population");
            scrHMGameplayCheck(_count==0,"all real shot trails expire after firing stops");
        }
    }
    if(mode=="car107" && ticks==10) {
        scrHMGameplayLane107();
        car107=hm_props_mod_gml_VenuzCar_create(player.x,player.y,0);
        KeyCont.press_pick[player.index]=true;
        with(car107) with(id) scrHMActorCallback("on_step");
        KeyCont.press_pick[player.index]=false;
        scrHMGameplayCheck(car107.driver==player.index,"actual interaction boards golden car");
    }
    if(mode=="car107" && ticks==25) {
        with(player) scrHMGameplayCheck(scrHMPlayerNativeHidden107()&&image_alpha==0,"car driver is excluded from body, weapon and shadow renderers");
        KeyCont.press_pick[player.index]=true;
        with(car107) with(id) scrHMActorCallback("on_step");
        KeyCont.press_pick[player.index]=false;
        with(player) scrHMGameplayCheck(!scrHMPlayerNativeHidden107()&&can_walk,"bailing onto real floor restores the player renderer and movement");
    }
    if(mode=="fall107" && ticks==10) {
        scrHMGameplayLane107();
        player.fallen_x107=player.x;player.fallen_y107=player.y;
        player.fallen_area107=GameCont.area;
        GameCont.area=scrHMAreaResolve("throne");
        player.fallen_sub107=GameCont.subarea;GameCont.subarea=1;
        player.x=15000;player.y=15000;player.fallen_start107=player.y;
        player.portalfall=player.y;player.fallen_scale107=1;player.fallen_seen107=false;
        player.fallen_floor107=instance_create(player.x,player.y,Floor);
        player.fallen_floor107.x-=1000;
        player.fallen_marker107=instance_create(0,0,Nothing2Death);
        with(player.fallen_marker107) {alarm[0]=-1;image_speed=0;}
    }
    if(mode=="fall107" && ticks==35) {
        scrHMGameplayCheck(player.image_alpha==0&&player.scale<.5&&player.scale>=0,"Throne II actual falling branch shrinks and hides native body");
        scrHMGameplayCheck(player.y>player.fallen_start107+100,"Throne II falling branch retains downward motion");
        instance_destroy(player.fallen_marker107,false);
        player.fallenable=-1;
        with(player) scrHMThroneFall107(false);
        GameCont.area=player.fallen_area107;GameCont.subarea=player.fallen_sub107;
        player.x=player.fallen_x107;player.y=player.fallen_y107;player.spr_shadow_y=0;
        with(player) scrHMGameplayCheck(image_alpha==1&&scale==1,"ending the fall restores normal rendering scale");
    }
    if(mode=="waves107" && ticks==10) {
        waves_seen107=instance_number(WantPopo);vans_seen107=instance_number(WantVan);
        scrHMGameplayCheck(waves_seen107>0&&vans_seen107>0,"native generation schedules loop police and van controllers");
        scrHMGameplayCheck(!GameCont.novans,"MOD does not disable loop vans");
        with(WantVan) {canspawn=true;spawnmoment=2;}
        with(WantPopo) spawnmoment=2;
        waves_portals107=false;waves_vans107=false;waves_police107=false;
    }
    if(mode=="waves107" && ticks>10) {
        if(instance_exists(IDPDSpawn)) waves_portals107=true;
        if(instance_exists(VanSpawn)||instance_exists(Van)) waves_vans107=true;
        if(instance_exists(Grunt)||instance_exists(Inspector)||instance_exists(Shielder)||instance_exists(PopoFreak)) waves_police107=true;
        if(ticks==180) {
            scrHMGameplayCheck(waves_portals107&&waves_police107,"native wave controllers produce portals and real police");
            scrHMGameplayCheck(waves_vans107,"native loop van controller reaches spawn sequence");
        }
    }
    if(mode=="portraitprofile107" && ticks==10) {
        portrait_samples107=[];portrait_spawn107=0;
        // The actual natural scene remains present beneath the real layers.
        for(var _i=0;_i<96;++_i) with(instance_create(player.x+160+(_i mod 16)*24,player.y+(_i div 16)*24,EnemyBullet2)) {
            speed=0;alarm[0]=900;
        }
    }
    if(mode=="portraitprofile107" && ticks==45) {
        var _start=get_timer();
        hm_bosses_bossintros_mod_gml_boss_trigger("BIG DOG",scrHMModGet("mod","maincode","Bigdogportrait"),scrHMModGet("mod","maincode","Bigdogportraitfg"),mskNone,player,60);
        portrait_spawn107=get_timer()-_start;
    }
    if(mode=="portraitprofile107" && ticks==150) {
        show_debug_message("HARDMODE PORTRAIT107 "+json_stringify({spawn_us:portrait_spawn107,frames:portrait_samples107}));
        scrHMGameplayCheck(array_length(portrait_samples107)>40,"real portrait frame profile collected across entry, display and exit");
        scrHMGameplayCheck(!instance_exists(variable_instance_get(HMWorld,"hm_portrait_active")??noone),"profiled portrait finishes and releases the live scene");
    }
    if(mode=="contracts107" && ticks==10) {
        scrHMGameplayLane107();
        var _area=GameCont.area,_sub=GameCont.subarea;
        player.extra_weps=[wep_revolver,wep_shotgun];
        player.extra_weps_reload=[9,8];player.extra_weps_curse=[true,true];
        player.extra_weps_can_shoot=[false,false];
        GameCont.area=scrHMAreaResolve("venuz");GameCont.subarea=1;
        with(GameCont) scrHMAreaCall(area,"area_setup");
        scrHMGameplayCheck(player.wep==0&&player.bwep==0&&array_length(player.extra_weps)==0,"actual Venus loadout removes every old weapon slot");
        scrHMGameplayCheck(array_length(player.extra_weps_reload)==0&&array_length(player.extra_weps_can_shoot)==0,"Venus clears matching extra-slot state");
        GameCont.area=_area;GameCont.subarea=_sub;
        player.wep=wep_revolver;player.bwep=wep_shotgun;
        var _level=GameCont.level,_green=instance_create(player.x+64,player.y,FastRat);
        GameCont.level=1;with(_green) scrHMRadiationSync(true);
        scrHMGameplayCheck(_green.raddrop==0,"green rat retains MOD drop before maximum level");
        GameCont.level=PLAYER_LEVEL_MAX;repeat(5) with(_green) scrHMRadiationSync(false);
        scrHMGameplayCheck(_green.raddrop==4,"green rat equals native ordinary rat after maximum level, without repeated addition");
        _green.raddrop+=5;with(_green) scrHMRadiationSync(false);
        scrHMGameplayCheck(_green.raddrop==9,"green rat preserves absorbed radiation");
        with(Rad) instance_destroy(id,false);
        _green.hp=0;instance_destroy(_green);
        var _rads=0;with(Rad) _rads+=object_index==BigRad?10:1;
        scrHMGameplayCheck(_rads==9,"green rat actual death drops base plus absorbed radiation");
        GameCont.level=_level;
    }
    if(mode=="prompt107" && ticks==10) {
        scrHMGameplayLane107();
        hm_props_mod_gml_leave_create(player.x,player.y);
        prompt107=noone;with(CustomObject) if(name==" leave") other.prompt107=id;
        scrHMGameplayCheck(instance_exists(prompt107),"source interaction object is created");
        prompt_frames107=0;
    }
    if(mode=="prompt107" && ticks==36) player.x+=100;
    if(mode=="prompt107" && ticks==40) {
        var _n=0;with(HMBinding) if(hm_code==scrHMScriptRef(hm_props_mod_gml_E)) _n++;
        scrHMGameplayCheck(_n==0,"interaction hint expires after leaving range");
        scrHMGameplayCheck(prompt_frames107>=20,"interaction renderer was checked on physical frames");
    }
    if(mode=="retry107" && ticks==10) {
        retry_sub107=GameCont.subarea;
        retry_old107=scrWeaponPickupCreate(player.x+40,player.y,wep_revolver);
        retry_old207=scrWeaponPickupCreate(player.x+56,player.y,wep_shotgun);
        scrMakePauseButtons();retry_button107=noone;
        with(PauseButton) if(self[$ "hm_retry_level107"]??false) other.retry_button107=id;
        scrHMGameplayCheck(instance_exists(retry_button107),"Venus pause menu exposes current-stage restart");
        with(retry_button107) scrHMGameplayCheck(scrMenuButtonName()==(UberCont.opt_language=="Simplified Chinese"?"重新开始本关":"RESTART LEVEL"),"retry action has an independent translated label");
    }
    if(mode=="retry107" && ticks==15) with(retry_button107) event_user(0);
    if(mode=="retry107" && ticks==200) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("venuz")&&GameCont.subarea==retry_sub107,"pause action rebuilds exactly the current main or secret Venus stage");
        scrHMGameplayCheck(!instance_exists(retry_old107)&&!instance_exists(retry_old207),"real elevator cleanup removes native weapon pickups");
        var _area=GameCont.area;GameCont.area=1;scrMakePauseButtons();
        var _extra=0;with(PauseButton) if(self[$ "hm_retry_level107"]??false) _extra++;
        scrHMGameplayCheck(_extra==0,"Venus retry action is absent outside Venus");
        instance_destroy(PauseButton,false);GameCont.area=_area;
    }
    if(mode=="pellet107" && ticks==10) {
        scrHMGameplayLane107();
        pellet_target107=instance_create(player.x+40,player.y,CustomEnemy);
        with(pellet_target107) {
            sprite_index=sprBigMaggotIdle;mask_index=mskBigMaggot;hp=1000;max_hp=1000;
            on_step=undefined;on_draw=undefined;on_hurt=undefined;team=1;friction=30;
        }
        player.gunangle=0;player.accuracy=0;
        with(player) scrHMWeaponFire(scrHMWeaponResolve("secretweapong2"));
        var _n=0;with(AllyBullet) if(self[$ "hm_venus_pellet107"]??false) _n++;
        scrHMGameplayCheck(_n==6,"source Venus shotgun creates six individually tagged pellets");
    }
    if(mode=="pellet107" && ticks==15) {
        show_debug_message("HARDMODE PELLET107 "+string(pellet_target107.hp));
        scrHMGameplayCheck(pellet_target107.hp==952,"six real point-blank pellet collisions deal 48 damage despite hit invulnerability");
    }
    if(mode=="raven107" && ticks==10) {
        scrHMGameplayLane107();
        var _keeper=instance_create(14360,14280,CustomEnemy);_keeper.hp=100000;_keeper.on_step=undefined;
        for(var _i=0;_i<80;++_i) with(instance_create(14120+(_i mod 8)*24,14032+(_i div 8)*24,Corpse)) {
            sprite_index=sprBanditDead;image_speed=0;speed=0;
        }
    }
    if(mode=="raven107" && ticks==15) {
        raven_count107=instance_number(Raven)+instance_number(RavenFly);
        scrHMGameplayCheck(raven_count107>0,"source corpse branch summons live flying ravens");
    }
    if(mode=="raven107" && ticks==250) {
        show_debug_message("HARDMODE RAVEN107 "+json_stringify({initial:raven_count107,ravens:instance_number(Raven)+instance_number(RavenFly),corpses:instance_number(Corpse)}));
        scrHMGameplayCheck(instance_number(Corpse)<=80,"live Raven flight changes do not create death corpses");
        scrHMGameplayCheck(instance_number(Raven)+instance_number(RavenFly)<=80,"one-shot corpse summoning never recursively multiplies ravens");
    }
    if(mode=="junk107") {
        if(ticks==1) {junk_blast107=false;junk_native107=false;junk_portraits107={};}
        if(instance_exists(Explosion)||instance_exists(SmallExplosion)||instance_exists(GroundFlame)) junk_blast107=true;
        if(UberCont.bossintro) junk_native107=true;
        with(CustomObject) if(name=="bossintro") other.junk_portraits107[$ string(id)]=true;
        if(ticks==12 && GameCont.subarea==5) {
            var _boss=instance_find(BecomeScrapBoss,0);
            scrHMGameplayCheck(instance_exists(_boss),"3-5 generates a sleeping Big Dog");
            player.x=_boss.x+32;player.y=_boss.y;player.speed=0;
        }
        if(ticks==8) scrHMGameplayCheck(!junk_blast107,"authored scrap roof placement creates no entrance explosions");
        if(ticks==330) {
            scrHMGameplayCheck(!junk_native107,"native Big Dog portrait is suppressed in MOD junkyard");
            var _n=array_length(variable_struct_get_names(junk_portraits107));
            show_debug_message("HARDMODE DOG107 "+json_stringify({portraits:_n,native:junk_native107,bosses:instance_number(ScrapBoss),sleeping:instance_number(BecomeScrapBoss)}));
            scrHMGameplayCheck(_n==(GameCont.subarea==5?1:0),"Big Dog has exactly one MOD portrait and ordinary junkyard has none");
            scrHMGameplayLane107();
            var _decal=instance_create(14120,14120,TopDecalScrapyard);_decal.image_index=0;
            instance_destroy(_decal);
            scrHMGameplayCheck(instance_number(Explosion)>=3,"normal combat death still detonates an explosive roof prop");
            instance_destroy(Explosion,false);instance_destroy(GroundFlame,false);
            junk_quiet_roof107=instance_create(14720,14120,TopDecalScrapyard);junk_quiet_roof107.image_index=0;
            var _wall=instance_create(14720,14120,Wall),_clear=instance_create(14720,14120,PortalClear);
            with(_wall) with(_clear) event_perform_object(PortalClear,ev_collision,Wall);
        }
        if(ticks==334) {
            scrHMGameplayCheck(!instance_exists(junk_quiet_roof107)&&!instance_exists(Explosion),"real portal-cleared floor removes explosive roof without a combat detonation");
            junk_combat_roof107=instance_create(14920,14120,TopDecalScrapyard);junk_combat_roof107.image_index=0;
            var _wall=instance_create(14920,14120,Wall);scrWallDestroy(_wall);
        }
        if(ticks==338)
            scrHMGameplayCheck(!instance_exists(junk_combat_roof107)&&instance_exists(Explosion),"ordinary battle wall destruction still detonates the roof through its real floor collision");
    }
    if(mode=="police107" && ticks==10) {
        if(scrHMPoliceArea107(GameCont.area)) {
        scrHMGameplayCheck(!instance_exists(Bandit),"HQ has no native chest-camping bandits");
        var _bandits=0;with(CustomEnemy) if(scrHMScriptRef(on_step)==scrHMScriptRef(hm_enemies_mod_gml_elitebandit_step)) _bandits++;
        scrHMGameplayCheck(_bandits==0,"HQ contains no converted chest-camping bandits");
        }
        police_portal107=instance_create(player.x+120,player.y,Portal);
    }
    if(mode=="police107" && ticks==40) {
        scrHMGameplayCheck(instance_exists(police_portal107)&&police_portal107.type==2,"HQ and 6-3 retain the IDPD type after sustained MOD steps");
        scrHMGameplayCheck(police_portal107.sprite_index==sprPopoPortal,"actual exit animation uses IDPD art");
    }
    if(mode=="horror107" && ticks==10) {
        scrHMGameplayLane107();horror107=instance_create(player.x+160,player.y,HostileHorror);
        horror_x107=horror107.x;horror_y107=horror107.y;horror_moved107=false;
    }
    if(mode=="horror107" && ticks>10 && instance_exists(horror107)) {
        if(point_distance(horror_x107,horror_y107,horror107.x,horror107.y)>5) horror_moved107=true;
        scrHMGameplayCheck(!instance_exists(HorrorBullet),"palace Horror movement never restores radiation attacks");
    }
    if(mode=="horror107" && ticks==180)
        scrHMGameplayCheck(horror_moved107&&horror107.hp==16,"palace Horror actually walks and retains sixteen HP");
    if(mode=="ice107" && ticks==10) {
        scrHMGameplayLane107();ice_source107=GameCont.area;
        hm_props_mod_gml_whitecrystal_create(player.x+64,player.y);
        ice107=instance_nearest(player.x+64,player.y,CustomObject);
    }
    if(mode=="ice107" && ticks>=11 && ticks<=65 && instance_exists(ice107)) {
        with(instance_create(ice107.x,ice107.y,Flame)) {damage=0;speed=0;}
    }
    if(mode=="ice107" && ticks==70) {
        scrHMGameplayCheck(ice107.open==-10000&&instance_exists(Portal),"real fire contact fully melts the entrance crystal");
        scrHMGameplayCheck(GameCont.area==ice_source107,"opening entrance does not prematurely change current area");
        var _portal=instance_nearest(ice107.x,ice107.y,Portal);
        player.x=_portal.x;player.y=_portal.y;player.speed=0;
    }
    if(mode=="ice107" && ticks==220)
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("icecave")&&instance_number(Floor)>5,"natural portal transition reaches playable ice cave");
    if(mode=="cavewalls107" && ticks==10) {
        scrHMGameplayCheck(instance_exists(HyperCrystal),"fixture reaches actual cursed HyperCrystal boss stage");
        cavewalls107=[];
        with(Wall) if(self[$ "hm_plain106"]??false) array_push(other.cavewalls107,[id,x,y,self[$ "hm_fill_w106"]??16,self[$ "hm_fill_h106"]??16]);
        scrHMGameplayCheck(array_length(cavewalls107)>0,"cursed cave has packed deep collision before conversion");
        with(HyperCrystal) scr_hit(id,max_hp*10,HitId.Player);
    }
    if(mode=="cavewalls107" && ticks==260) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("caves"),"real HyperCrystal death returns cave theme");
        for(var _i=0;_i<array_length(cavewalls107);++_i) {
            var _record=cavewalls107[_i],_wall=_record[0];
            scrHMGameplayCheck(instance_exists(_wall),"theme wave preserves each packed wall identity");
            if(instance_exists(_wall)) scrHMGameplayCheck((_wall[$ "hm_fill_w106"]??16)==_record[3]&&(_wall[$ "hm_fill_h106"]??16)==_record[4],"theme wave preserves full packed collision extent");
        }
    }
    if(mode=="reflect107" && ticks==10) {
        scrHMGameplayLane107();reflect107=[];
        var _shield_types=[PopoShield,EliteShield],_shots=[PlasmaBig,PlasmaHuge,Bullet1];
        for(var _s=0;_s<2;++_s) for(var _b=0;_b<3;++_b) {
            var _xx=14144+_b*96,_yy=14064+_s*128;
            var _shield=instance_create(_xx,_yy,_shield_types[_s]);
            _shield.image_speed=0;_shield.team=3;
            var _shot=instance_create(_xx-16,_yy,_shots[_b]);
            _shot.team=team_player;_shot.creator=player;_shot.hitid=HitId.Player;_shot.direction=0;_shot.speed=2*timescale;
            array_push(reflect107,[_shot,_shield,_b]);
            with(_shot) with(_shield) event_perform_object(object_index,ev_collision,projectile);
            scrHMGameplayCheck(_shot.team==(_b==2?3:team_player),"shield reflection preserves player plasma but retains ordinary bullet behavior");
            with(_shot) scrHMGameplayCheck(!scr_can_hit(HMGameplayTest.player,false)||_b==2,"reflected plasma cannot hurt the player");
            var _target=instance_create(_xx+24,_yy,CustomEnemy);_target.hp=100;_target.team=1;
            with(_shot) scrHMGameplayCheck(scr_can_hit(_target,false),"reflected plasma can still hit enemies");
            instance_destroy(_shot,false);instance_destroy(_shield,false);instance_destroy(_target,false);
        }
    }
    if(mode=="revive107" && ticks==10) {
        scrHMGameplayLane107();
        // A live enemy keeps this a combat room, as in the native mechanic.
        revive_keeper107=instance_create(14400,14280,CustomEnemy);revive_keeper107.hp=100000;
        revive_targets107=[];
        var _types=[Grunt,Inspector,Shielder,EliteGrunt,EliteInspector,EliteShielder];
        for(var _i=0;_i<6;++_i) {
            var _e=instance_create(14128+(_i mod 3)*96,14048+(_i div 3)*128,_types[_i]);
            _e.speed=0;_e.freeze=100;_e.alarm[1]=-1;
            array_push(revive_targets107,{who:_e,type:object_get_name(_types[_i]),
                dead:_e.spr_dead,x:_e.x,y:_e.y,hp:_e.hp,body:noone,timer:noone});
            scrHMVenusShoot106(_e,10000);
        }
    }
    if(mode=="revive107" && array_contains([12,25],ticks)) {
        var _actors=[],_bodies=[],_timers=[],_effects=[],_bullets=[];
        for(var _i=0;_i<array_length(revive_targets107);++_i) {
            var _record=revive_targets107[_i],_actor=_record.who,_live=instance_exists(_actor);
            array_push(_actors,{who:_actor,type:_record.type,exists:_live,
                dead:sprite_get_name(_record.dead),origin:[_record.x,_record.y],initial_hp:_record.hp,
                actual:_live?object_get_name(_actor.object_index):"destroyed",hp:_live?_actor.hp:-1,
                position:_live?[_actor.x,_actor.y]:[],frozen:_live?(_actor[$ "frozen"]??false):false,
                portrait:_live?(_actor[$ "hm_portrait_frozen"]??false):false});
        }
        with(Corpse) array_push(_bodies,{who:id,object:object_get_name(object_index),
            sprite:sprite_get_name(sprite_index),x:x,y:y,speed:speed,index:image_index,
            no_revive:self[$ "hm_no_revive109"]??false,once:self[$ "hm_police_revive_once"]??false});
        with(WantRevivePopoFreak) {
            var _native=self[$ "hm_corpse107"]??noone,_mod=self[$ "hm_police_corpse"]??noone;
            array_push(_timers,{who:id,x:x,y:y,alarm:alarm[0],native_body:_native,mod_body:_mod,
                native_exists:instance_exists(_native),mod_exists:instance_exists(_mod),
                native_position:instance_exists(_native)?[_native.x,_native.y]:[],
                mod_position:instance_exists(_mod)?[_mod.x,_mod.y]:[]});
        }
        with(RevivePopoFreak) array_push(_effects,{who:id,x:x,y:y,alarm:alarm[0],
            native_body:self[$ "hm_corpse107"]??noone,mod_body:self[$ "hm_police_corpse"]??noone});
        with(Bullet1) array_push(_bullets,{who:id,x:x,y:y,team:team,damage:damage});
        show_debug_message("HARDMODE REVIVE107 DIAGNOSTIC "+json_stringify({tick:ticks,targets:_actors,
            bodies:_bodies,timers:_timers,effects:_effects,bullets:_bullets,
            shields:instance_number(PopoShield),elite_shields:instance_number(EliteShield),
            freaks:instance_number(PopoFreak),portals:instance_number(Portal),active:HMWorld.hm_portrait_active}));
    }
    if(mode=="revive107" && ticks==12) {
        for(var _i=0;_i<array_length(revive_targets107);++_i) {
            var _record=revive_targets107[_i],_body=noone,_matches=0,_dead=_record.dead;
            with(Corpse) if(sprite_index==_dead) {_body=id;_matches++;}
            scrHMGameplayCheck(!instance_exists(_record.who) && _matches==1,
                "each of the six real police targets dies and creates exactly its native corpse");
            _record.body=_body;
            scrHMGameplayReviveBinding107(_record,true);
        }
    }
    if(mode=="revive107" && ticks==25)
        scrHMGameplayCheck(instance_number(WantRevivePopoFreak)==(GameCont.loops>=3?6:0),"real deaths schedule one original revival timer per police only from loop three");
    if(mode=="revive107" && array_contains([25,40,100,400,790],ticks)) {
        for(var _i=0;_i<array_length(revive_targets107);++_i)
            scrHMGameplayReviveBinding107(revive_targets107[_i]);
        scrHMGameplayCheck(instance_number(WantRevivePopoFreak)==(GameCont.loops>=3?6:0),
            "the entire moving six-corpse cohort keeps its original exact timer total");
        if(ticks==790) scrHMGameplayCheck(instance_number(PopoFreak)==0 && instance_number(RevivePopoFreak)==0,
            "the full native 800-tick wait is preserved before either resurrection stage");
    }
    if(mode=="revive107" && ticks==30) {
        var _old=revive_targets107[0].body;
        revive_decoy107=instance_create(_old.x,_old.y,Corpse);
        revive_decoy107.sprite_index=mskNone;revive_decoy107.mask_index=mskNone;
        for(var _i=0;_i<array_length(revive_targets107);++_i) {
            var _body=revive_targets107[_i].body;
            _body.x=14120+(_i mod 3)*96;_body.y=14140+(_i div 3)*96;_body.speed=0;
        }
    }
    if(mode=="revive107" && array_contains([30,790,815,835,855],ticks)) {
        var _corpses=[];with(Corpse) array_push(_corpses,[x,y,sprite_index]);
        show_debug_message("HARDMODE REVIVE107 "+json_stringify({tick:ticks,timers:instance_number(WantRevivePopoFreak),effects:instance_number(RevivePopoFreak),freaks:instance_number(PopoFreak),portal:instance_number(Portal),corpses:_corpses}));
    }
    if(mode=="revive107" && ticks==860) {
        scrHMGameplayCheck(instance_number(PopoFreak)==(GameCont.loops>=3?6:0),"native 800-tick timers actually revive police corpses as IDPD Freaks");
        for(var _i=0;_i<array_length(revive_targets107);++_i) {
            var _body=revive_targets107[_i].body;
            scrHMGameplayCheck(instance_exists(_body) && instance_is(_body,GameCont.loops>=3?PopoFreak:Corpse),
                "all six exact original corpse IDs complete the real native resurrection only from Loop3");
        }
        scrHMGameplayCheck(instance_exists(revive_decoy107) && instance_is(revive_decoy107,Corpse),
            "the invisible logic corpse never steals a police resurrection");
    }
    if(mode=="revive107" && ticks==870 && GameCont.loops>=3) {
        var _freak=revive_targets107[0].body;
        revive_freak_dead107=_freak.spr_dead;
        _freak.speed=0;_freak.freeze=100;
        scrHMVenusShoot106(_freak,10000);
    }
    if(mode=="revive107" && ticks==875 && GameCont.loops>=3) {
        var _body=noone,_matches=0,_dead=revive_freak_dead107;
        with(Corpse) if(sprite_index==_dead) {_body=id;_matches++;}
        scrHMGameplayCheck(_matches==1 && instance_number(WantRevivePopoFreak)==1,
            "a genuinely revived Freak death creates exactly one new native corpse and timer");
        revive_freak_record107={body:_body,timer:noone};
        scrHMGameplayReviveBinding107(revive_freak_record107,true);
        if(instance_exists(revive_freak_record107.timer))
            scrHMGameplayCheck(revive_freak_record107.timer.alarm[0]>780,
                "the Freak's next life retains the original 800-tick timer interval");
    }
    if(mode=="revive107" && array_contains([890,1000,1400,1660],ticks) && GameCont.loops>=3) {
        scrHMGameplayReviveBinding107(revive_freak_record107);
        scrHMGameplayCheck(instance_number(WantRevivePopoFreak)==1 && instance_number(PopoFreak)==5,
            "the returned Freak's second death keeps a single full-interval revival while its five peers remain alive");
        if(ticks==1660) scrHMGameplayCheck(instance_number(RevivePopoFreak)==0,
            "the returned Freak cannot skip its next complete native waiting interval");
    }
    if(mode=="revive107" && ticks==900 && GameCont.loops>=3) {
        var _body=revive_freak_record107.body;
        _body.x=14320;_body.y=14200;_body.speed=0;
    }
    if(mode=="revive107" && ticks==1700 && GameCont.loops>=3) {
        var _body=revive_freak_record107.body;
        scrHMGameplayCheck(instance_exists(_body) && instance_is(_body,PopoFreak)
            && instance_number(PopoFreak)==6 && instance_number(WantRevivePopoFreak)==0
            && instance_number(RevivePopoFreak)==0,
            "the returned Freak's exact new corpse completes a second real 800-tick plus effect resurrection");
    }
    if(mode=="van107" && ticks==10) {
        scrHMGameplayLane107();van107=instance_create(player.x+160,player.y,Van);
        for(var _i=0;_i<28;++_i) for(var _j=0;_j<5;++_j) instance_create(13300+_i*32,14100+_j*32,Floor);
        van_exploded107=false;van_custom107=noone;van_converted107=false;van_freak_peak107=0;
        van_hp107=van107.hp;
        scrHMGameplayCheck(van107.freak==(GameCont.loops>=3),"native van danger threshold follows actual loop count");
    }
    if(mode=="van107" && ticks>10 && !van_converted107) {
        with(CustomObject) if(name=="3dvan") {other.van_custom107=id;break;}
        if(instance_exists(van_custom107)) {
            van_converted107=true;
            scrHMGameplayCheck(van_custom107.hm_freak107==(GameCont.loops>=3),"converted Hardmode van retains loop danger policy");
        }
    }
    if(mode=="van107" && ticks>10 && van_converted107 && !instance_exists(van_custom107)) van_exploded107=true;
    if(mode=="van107" && ticks>10) van_freak_peak107=max(van_freak_peak107,instance_number(PopoFreak));
    if(mode=="van107" && ticks>10 && instance_exists(van107) && van107.hp!=van_hp107) {
        show_debug_message("HARDMODE VAN107 DAMAGE "+json_stringify({tick:ticks,hp:van107.hp,x:van107.x,y:van107.y}));van_hp107=van107.hp;
    }
    if(mode=="van107" && ticks>10 && instance_exists(van107) && ticks mod 10==0)
        show_debug_message("HARDMODE VAN107 "+json_stringify({tick:ticks,x:van107.x,y:van107.y,drive:van107.drive,speed:van107.drivespeed,hp:van107.hp,freak:van107.freak}));
    if(mode=="van107" && ticks==150) {
        scrHMGameplayCheck(van_converted107,"real native van is converted to the Hardmode vehicle");
        scrHMGameplayCheck(van_exploded107==(GameCont.loops>=3),"loop-three Hardmode van detonates after stopping, earlier vans unload normally");
        if(GameCont.loops<3) scrHMGameplayCheck(instance_exists(van_custom107)&&van_custom107.land==0,"ordinary Hardmode van completes its unload and remains parked");
        else scrHMGameplayCheck(van_freak_peak107>=3,"stopped dangerous van releases native IDPD Freaks");
    }
}

function scrHMGameplayRender107() {
    if(mode=="fall107" && ticks>=12 && ticks<=30) {
        var _n=0;with(HMBinding) if(hm_code==scrHMScriptRef(hm_maincode_mod_gml_PortalShrink)) _n++;
        scrHMGameplayCheck(_n==1,"Throne II falling uses one persistent portal renderer on every physical frame");
    }
    if(mode=="portraitprofile107" && ticks>15 && ticks<145)
        array_push(portrait_samples107,[ticks,get_timer()-hm_frame_start106,instance_exists(variable_instance_get(HMWorld,"hm_portrait_active")??noone)]);
    if(mode=="prompt107" && ticks>=12 && ticks<=34) {
        var _n=0;with(HMBinding) if(hm_code==scrHMScriptRef(hm_props_mod_gml_E)&&creator==other.prompt107) _n++;
        scrHMGameplayCheck(_n==1,"interaction text has exactly one renderer on every physical frame");
        prompt_frames107++;
    }
    if((mode=="prompt107"&&array_contains([15,16,40],ticks))
        ||(mode=="retry107"&&ticks==12)||(mode=="police107"&&ticks==40)
        ||(mode=="cavewalls107"&&array_contains([12,260],ticks))
        ||(mode=="car107"&&array_contains([15,28],ticks))
        ||(mode=="fall107"&&ticks==22))
        if(surface_exists(application_surface)) surface_save(application_surface,game_directory+mode+"-"+string(ticks)+"-"+string(age)+".png");
}
