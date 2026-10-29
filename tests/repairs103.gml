function scrHMGameplayIsolate103() {
    global.hm_tasks=[];
    with(enemy) instance_destroy(id,false);
    with(becomenemy) instance_destroy(id,false);
    with(CustomObject) instance_destroy(id,false);
    with(projectile) instance_destroy(id,false);
    with(Portal) instance_destroy(id,false);
    with(Corpse) instance_destroy(id,false);
    with(HMBinding) instance_destroy(id,false);
    HMWorld.hm_titank_entering=false;
}

function scrHMGameplayRepairs103() {
    if(mode=="caves103" && ticks<=30) show_debug_message("HARDMODE CAVES TICK "+string(ticks)+" tasks="+string(array_length(global.hm_tasks)));
    if(mode=="contracts103" && ticks==10) {
        scrHMGameplayIsolate103();
        HMWorld.hm_titank_entering=true;
        with(HMWorld) event_perform(ev_other,ev_room_end);
        scrHMGameplayCheck(!scrHMPendingBoss(),"interrupted boss entrance cannot block the next room or run");
        var _saved=[GameCont.area,GameCont.subarea];
        with(GameCont) {area=3;subarea=3;lastarea=3;lastsubarea=2;scrHMAreaTransit();}
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("ravenboss")&&GameCont.subarea==3,"3-2 proceeds to Raven 3-3 without caves alias collision");
        with(GameCont) scrHMAreaAdvance();
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("junkyard")&&GameCont.subarea==4,"Raven exits into extended junkyard 3-4");
        with(GameCont) scrHMAreaAdvance();
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("junkyard")&&GameCont.subarea==5,"extended junkyard retains 3-5");
        with(GameCont) scrHMAreaAdvance();
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("caves")&&GameCont.subarea==1,"3-5 proceeds to caves 4-1");
        GameCont.area=_saved[0];GameCont.subarea=_saved[1];
        var _dest=scrHMConsoleDestination(5,3);
        scrHMGameplayCheck(_dest[0]==scrHMAreaResolve("city")&&_dest[1]==3,"console 5-3 resolves to Titank arena");
        _dest=scrHMConsoleDestination(2,2);
        scrHMGameplayCheck(_dest[0]==scrHMAreaResolve("sewers")&&_dest[1]==2,"console 2-2 resolves to Hardmode sewers");
        _dest=scrHMConsoleDestination(3,3);
        scrHMGameplayCheck(_dest[0]==scrHMAreaResolve("ravenboss"),"console 3-3 resolves to Raven");
        UberCont.opt_console=false;UberCont.opt_orig_console=false;
        scrHMGameplayCheck(!UberCont.opt_console,"console preference can be off independently of run build");
        var _flame=instance_create(player.x+40,player.y,Flame);
        with(_flame) {_flame=hm_enemies_mod_gml_Flame_create(x,y);}
        scrHMGameplayCheck(instance_exists(_flame)&&_flame.name=="Flame"&&_flame.deflected==false,"native Flame conversion initializes all inherited fields");
        scrHMGameplayCheck(is_real(_flame.knockback_speed)&&is_real(_flame.team),"converted Flame retains recoil and team");
        var _oldmusic=MusCont.music_sound,_song=MusCont.song;
        scrHMSoundMusic(_song);
        scrHMGameplayCheck(MusCont.music_sound==_oldmusic,"same area theme keeps playback handle");
        with(MusCont) event_perform(ev_alarm,11);
        if(scrHMAreaHas(GameCont.area)) scrHMGameplayCheck(MusCont.song==_song,"native area alarm cannot replace custom theme with silence");
        scrHMGameplayCheck(scrHMLocalize("REACH THE FROZEN CITY")=="抵达冰冻都市","unlock hints use Chinese catalog");
    }
    if(mode=="sewer103" && ticks==40) {
        scrHMGameplayCheck(instance_exists(PizzaEntrance),"2-2 delayed area_start produces pizza manhole");
        scrHMGameplayCheck(MusCont.song==custom_sound_check(mus2),"sewer theme survives room-start alarm");
        var _old=MusCont.music_sound;
        with(GameCont) scrHMAreaCall(GameCont.area,"area_setup");
        scrHMGameplayCheck(MusCont.music_sound==_old,"next stage with same song does not restart music");
        var _floor=instance_furthest(player.x,player.y,Floor);
        bank_x=_floor.x;bank_y=_floor.y;
        bank_wall=collision_point(bank_x+56,bank_y+8,Wall,false,false);
        if(!instance_exists(bank_wall)) bank_wall=instance_create(bank_x+48,bank_y,Wall);
        with(instance_create(bank_x+48,bank_y,PortalClear)) {hm_water_clear=true;scrHMSewerBank(other.bank_wall);}
        var _plain=0;
        with(Floor) if(x==other.bank_x+48&&y==other.bank_y&&sprite_index==sprFloor2) _plain++;
        scrHMGameplayCheck(_plain>0,"water bank clearance creates an intact floor");
    }
    if(mode=="sewer103" && ticks==20) {
        var _water=noone,_near=infinity;
        with(Floor) if(traction==2 && point_distance(x+16,y+16,other.player.x,other.player.y)<_near) {
            _water=id;_near=point_distance(x+16,y+16,other.player.x,other.player.y);
        }
        scrHMGameplayCheck(instance_exists(_water),"sewer generates swimmable water");
        player.x=_water.x+16;player.y=_water.y+16;
    }
    if(mode=="sewer103" && ticks==30) scrHMGameplayCheck((player[$ "swimming"]??false)&&player.image_alpha==0,"real water entry uses the cropped swimming renderer");
    if(mode=="horror103" && ticks==10) {
        scrHMGameplayIsolate103();
        guardian=instance_create(player.x+100,player.y,DogGuardian);
    }
    if(mode=="horror103" && ticks==12) {
        // Let b24 set its real guardian drop before combat. An instant kill
        // in the creation callback bypassed that source hook at 60 FPS;
        // restored walking children could absorb the larger native drop
        // and legitimately split, invalidating the old exact-count check.
        scrHMGameplayCheck(guardian.norads==1,"normal MOD guardian radiation setup runs before the combat death");
        scr_hit(guardian,10000,HitId.Player);
    }
    if(mode=="horror103" && ticks==60) {
        var _count=0;
        with(HostileHorror) {
            _count++;
            scrHMGameplayCheck(hp<=16&&max_hp==16,"guardian child has sixteen effective HP");
            scrHMGameplayCheck(spr_idle==sprEnemyHorrorIdle&&sprite_index!=sprMutant11Idle,"guardian child uses hostile Horror art");
            scrHMGameplayCheck(ammo==0&&charge==100,"guardian child cannot fire radiation beam");
        }
        show_debug_message("HARDMODE HORROR103 CHILDREN "+string(_count));
        scrHMGameplayCheck(_count==3,"dog guardian corpse generates three Horrors after normal source initialization");
        scrHMGameplayCheck(!instance_exists(HorrorBullet),"guardian child creates no radiation projectiles");
        with(HostileHorror) scr_hit(id,16,HitId.Player);
    }
    if(mode=="horror103" && ticks==70) scrHMGameplayCheck(!instance_exists(HostileHorror),"sixteen damage kills all guardian children");
    if(mode=="caves103" && ticks==10) {
        scrHMGameplayCheck(instance_exists(HyperCrystal),"cursed caves contain HyperCrystal");
        with(InvSpider) hp=max_hp;
        with(HyperCrystal) {nospin=0;direction=0;hm_test_x=x;}
        cursed_ammo=instance_create(player.x+100,player.y+100,CursedPickup);
    }
    if(mode=="caves103" && ticks==25) {
        var _moved=false;with(HyperCrystal) if(abs(x-hm_test_x)>.2) _moved=true;
        scrHMGameplayCheck(_moved,"HyperCrystal can move with identical idle/fire sprites");
        with(HyperCrystal) hp=0;
    }
    if(mode=="caves103" && ticks==220) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("caves"),"HyperCrystal death restores ordinary caves");
        scrHMGameplayCheck(!instance_exists(InvSpider)&&!instance_exists(InvLaserCrystal),"cursed spiders and crystals are converted");
        var _cursed=0;with(Floor) if(array_contains([sprFloor104,sprFloor104B,sprFloor104Explo],sprite_index)) _cursed++;
        scrHMGameplayCheck(_cursed==0,"restoration wave converts all cursed floors");
        if(instance_exists(cursed_ammo)) scrHMGameplayCheck(cursed_ammo.object_index==AmmoPickup&&!cursed_ammo.cursed,"restoration decurses modern ammunition subclass");
        scrHMGameplayCheck(array_length(global.hm_tasks)<100,"terrain conversion finishes without growing continuation queue");
    }
    if(mode=="fist103" && ticks==10) {
        scrHMGameplayIsolate103();
        fist=instance_create(player.x+30,player.y,CustomProjectile);
        with(fist) {name="testfist";sprite_index=sprFlakBullet;mask_index=mskFlakBullet;team=1;speed=8*timescale;direction=0;
            hm_fist_timer0=0;hm_fist_timer1=0;alarm[0]=-1;alarm[1]=-1;hitid=HitId.None;
            on_step=hm_bosses_gatorboss_mod_gml_Gatorfist;on_wall=hm_bosses_gatorboss_mod_gml_Gatorfist_wall;}
        fist_wall=instance_create(fist.x+24,fist.y,Wall);
    }
    if(mode=="fist103" && ticks==18) {
        scrHMGameplayCheck(instance_exists(fist),"gator fist survives passage through wall");
        scrHMGameplayCheck(!instance_exists(fist_wall),"gator fist clears obstructing wall");
        scrHMGameplayCheck(fist.hm_fist_timer1>=8,"fist age increments independently of native alarms");
    }
    if(mode=="fist103" && ticks==26) scrHMGameplayCheck(instance_exists(SmallExplosion),"gator fist produces delayed explosions along path");
    if(mode=="laser103" && ticks==10) {
        scrHMGameplayIsolate103();
        laser_tank=hm_enemies_mod_gml_IDPDTank_create(player.x+70,player.y,0);
        with(laser_tank) {spawnanimation=0;spr_idle=global.hm_module_vars[$ "mod:enemies"].IDPDTankidle;alrm1=1;gunangle=180;speed=0;}
        laser_seen=false;
    }
    if(mode=="laser103" && ticks>10) {
        with(Laser) if(self[$ "hm_idpd_beam"]??false) {
            other.laser_seen=true;
            scrHMGameplayCheck(alarm[0]<0,"IDPD beam does not retrace from endpoint");
            scrHMGameplayCheck(abs(angle_difference(image_angle,point_direction(xstart,ystart,x,y)))<1,"IDPD beam points from muzzle toward impact");
            scrHMGameplayCheck(image_xscale>0,"IDPD beam uses native positive length");
        }
    }
    if(mode=="laser103" && ticks==250) scrHMGameplayCheck(laser_seen,"IDPD tank actually fires its charged beam");
    if(mode=="skull103" && ticks==20) {
        var _found=0;with(CustomHitme) if(name=="fishskull") {
            _found++;
            scrHMGameplayCheck(hp==(GameCont.loops>0?3000:100)&&max_hp==hp,"oasis fish skull has requested loop-dependent HP");
        }
        scrHMGameplayCheck(_found==1,"full-health 1-2 generation contains one fish skull");
    }
    if(mode=="bounds103" && ticks==10) {
        scrHMGameplayIsolate103();
        rescued=hm_enemies_mod_gml_elitebandit_create(9500,9500,0);
        wall_actor=instance_create(9500,9500,Wall);wall_static=instance_create(9500,9500,LaserCrystal);
        initial_static=[wall_static.x,wall_static.y];
    }
    if(mode=="bounds103" && ticks==60) {
        scrHMGameplayCheck(instance_exists(rescued)&&rescued.hp>0,"off-map walking bandit is rescued alive");
        with(rescued) scrHMGameplayCheck(place_meeting(x,y,Floor)&&!place_meeting(x,y,Wall),"rescued bandit stands on usable floor");
        scrHMGameplayCheck(instance_exists(wall_static)&&wall_static.x==initial_static[0]&&wall_static.y==initial_static[1],"wall crystal remains an authored wall enemy");
    }
    if(mode=="scorpion103" && ticks==10) {
        scrHMGameplayIsolate103();
        // This fixture measures the death sequence's own 30 Hz timeline.
        // Cinematic pause/resume is exercised separately by scorpion105.
        scrHMModSet("mod","options","bossoutros","0");
        loop_scorpion=hm_bosses_scorpionboss_mod_gml_scorpionboss_create(player.x+100,player.y);
        loop_scorpion.intro=1;
        scorpion_initial103=false;scorpion_final103=false;
    }
    if(mode=="scorpion103" && ticks==30) scr_hit(loop_scorpion,100000,HitId.Player);
    if(mode=="scorpion103" && ticks>30) {
        var _initial=0,_final=0;
        with(EnemyBullet2) {
            if(self[$ "fakeEnemyBullet"]??false) _initial++;
            if(self[$ "fancy"]??false) _final++;
        }
        if(_initial>200) scorpion_initial103=true;
        if(_final>0 && !scorpion_final103) {
            scorpion_final103=true;
            show_debug_message("HARDMODE SCORPION103 WAVE "+json_stringify({tick:ticks,count:_final}));
        }
    }
    if(mode=="scorpion103" && ticks==62) {
        scrHMGameplayCheck(scorpion_initial103,"loop scorpion delayed death burst survives boss destruction");
    }
    if(mode=="scorpion103" && ticks==130) {
        scrHMGameplayCheck(scorpion_final103,"loop scorpion final accelerated death wave is emitted");
    }
    if(mode=="exit103" && ticks==20) {
        with(enemy) hp=0;
    }
    if(mode=="exit103" && ticks>=20 && instance_exists(Portal)) {
        var _safe=instance_furthest(Portal.x,Portal.y,Floor);
        if(instance_exists(_safe)) {player.x=_safe.x+16;player.y=_safe.y+16;}
    }
    if(mode=="exit103" && ticks==150) {
        var _corpses=[];with(Corpse) array_push(_corpses,[object_get_name(object_index),alarm[0],self[$ "hm_exit_corpse"]]);
        show_debug_message("HARDMODE CLEARANCE "+json_stringify({enemies:instance_number(enemy),becoming:instance_number(becomenemy),pending:scrHMPendingBoss(),corpses:_corpses}));
        scrHMGameplayCheck(!scr_check_enemies(),"ordinary fifth-area enemies are all cleared");
        scrHMGameplayCheck(instance_exists(Portal),"ordinary fifth-area clearance produces exit");
    }
    if(mode=="goto103" && ticks==10) {
        scrHMGameplayCheck(scrHMConsoleCommand("5-3",1),"console accepts Hardmode destination");
    }
    if(mode=="goto103" && ticks==100) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("city")&&GameCont.subarea==3&&GameCont.loops==1,"real console transition reaches exact extended destination");
        var _spawner=false;with(CustomObject) if(name=="wanttitank") _spawner=true;
        scrHMGameplayCheck(_spawner,"console destination retains real Hardmode boss spawner");
    }
    if(mode=="performance103" && ticks==10) {
        scrHMGameplayIsolate103();
        repeat(512) with(instance_create(9500+random(400),9500+random(400),EnemyBullet2)) {team=1;speed=0;friction=0;}
        var _old=[],_now=[];
        repeat(30) {
            var _start=get_timer(),_targets=scrHMInstances(scrHMMatching(projectile,"team",1));
            var _previous=get_timer()-_start;
            var _start=get_timer(),_direct=scrHMMatching(projectile,"team",1);
            array_push(_old,_previous);array_push(_now,get_timer()-_start);
            scrHMGameplayCheck(array_length(_targets)==512&&array_length(_direct)==512,"optimized projectile filter preserves full snapshot");
        }
        array_sort(_old,true);array_sort(_now,true);
        show_debug_message("HARDMODE FILTER PROFILE "+json_stringify({projectiles:512,before_us:_old[15],after_us:_now[15],samples:30}));
    }
    if(mode=="route103" && room_ticks==60) {
        var _expected=[[3,1],[3,2],[scrHMAreaResolve("ravenboss"),3],[scrHMAreaResolve("junkyard"),4],[scrHMAreaResolve("junkyard"),5],[scrHMAreaResolve("caves"),1]];
        var _index=route_rooms-1;
        scrHMGameplayCheck(_index<array_length(_expected),"targeted route has six stages");
        scrHMGameplayCheck(GameCont.area==_expected[_index][0]&&GameCont.subarea==_expected[_index][1],"real junkyard route visits each expected stage in order");
        if(_index<5) {GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0;GameCont.can_advance_stage=true;GameCont.is_level_ended=true;room_restart();}
    }
}

function scrHMGameplayRender103() {
    if(!surface_exists(application_surface)) return;
    if(mode=="sewer103" && ticks==60) surface_save(application_surface,game_directory+"swimming.png");
    if(mode=="laser103" && !(self[$ "laser_captured"]??false)) {
        var _beam=false;with(Laser) if(self[$ "hm_idpd_beam"]??false) _beam=true;
        if(_beam) {surface_save(application_surface,game_directory+"idpd-laser.png");laser_captured=true;}
    }
}
