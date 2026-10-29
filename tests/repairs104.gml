function scrHMGameplayRepairs104() {
    if(mode=="errors104" && ticks==10) {
        scrHMGameplayIsolate103();
        var _ring=instance_create(player.x+60,player.y,ReviveCircle);
        var _corpse=instance_create(_ring.x,_ring.y,Corpse);
        _corpse.specialrevive="rogue";_corpse.sprite_index=sprGruntDead;_corpse.mask_index=mskBandit;
        _ring.alarm[0]=4;
        with(HMWorld) hm_props_mod_gml_step();
        scrHMGameplayCheck(!instance_exists(_corpse),"revive field uses the native other.alarm[0] without an unset alarm0");
        var _boss=hm_bosses_gatorboss_mod_gml_gatorboss_create(player.x+90,player.y);
        _boss.target=player;_boss.targetvisible=1;_boss.alrm2=2;_boss.alrm0=20;
        instance_create(player.x+50,player.y,Gator);
        instance_destroy(player,false);
        gator104=_boss;
    }
    if(mode=="errors104" && ticks==40) {
        scrHMGameplayCheck(instance_exists(gator104),"gator AI survives player destruction for thirty ticks");
        scrHMGameplayCheck(!gator104.targetvisible,"gator cannot command friends against a dead player");
    }
    if(mode=="raven104" && ticks==10) {
        scrHMGameplayIsolate103();
        scrHMModSet("mod","options","intropan","0");UberCont.opt_bossintros=0;
        // Deep walls may be packed into larger collision blocks. A stable
        // floor lane opens their actual footprint instead of deleting by origin.
        for(var _i=0;_i<12;++_i) for(var _j=0;_j<6;++_j) instance_create(14000+32*_i,14000+32*_j,Floor);
        player.x=14048;player.y=14096;
        raven104=hm_bosses_ravenboss_mod_gml_ravenboss_create(14144,14096);
        with(raven104) {flying=false;z=0;sprite_index=spr_idle;alrm2=0;alrm3=0;alrm4=0;alrm1=1;alrm0=1000;ammo=3;target=other.player;targetvisible=1;}
    }
    if(mode=="raven104" && ticks==12) {
        // A legitimate random liftoff can refill ammo on the same tick as
        // firing. Observe real projectiles rather than infer firing from ammo.
        var _shots=0;with(JockRocket) if(creator==other.raven104) {_shots++;instance_destroy(id,false);}
        scrHMGameplayCheck(_shots>0,"Raven fires its real native rocket while standing");
        with(raven104) {x=14144;y=14096;speed=0;flying=false;z=0;sprite_index=spr_walk;alrm2=0;alrm3=0;alrm4=0;alrm0=1000;alrm1=1;ammo=3;}
    }
    if(mode=="raven104" && ticks==14) {
        var _shots=0;with(JockRocket) if(creator==other.raven104) _shots++;
        scrHMGameplayCheck(_shots>0,"Raven fires a new native rocket while walking too");
    }
    if(mode=="water104" && ticks==25) {
        water104=noone;dry104=noone;
        with(Floor) {
            if(traction==2 && !instance_exists(other.water104)) other.water104=id;
            if(traction!=2 && object_index==Floor && !instance_exists(other.dry104)) other.dry104=id;
        }
        scrHMGameplayCheck(instance_exists(water104)&&instance_exists(dry104),"sewer has actual water cells and dry bank cells");
        player.x=water104.x+16;player.y=water104.y+16;
        with(HMWorld) scrHMSewerTick();
        scrHMGameplayCheck(player.swimming&&player.image_alpha==0,"point in actual water enters swimming");
        player.x=dry104.x+16;player.y=dry104.y+16;
        var _decoration=instance_create(player.x,player.y,CustomObject);_decoration.sprite_index=mskPlayer;
        with(HMWorld) scrHMSewerTick();
        scrHMGameplayCheck(!player.swimming&&player.image_alpha==1,"overlapping unrelated custom props cannot keep a swimmer on land");
        scrHMGameplayCheck(!scrHMWaterAt(dry104.x+16,dry104.y+16),"dry bank has no swim state despite adjacent water");
        var _lid=noone;with(PizzaEntrance) {_lid=id;break;}
        scrHMGameplayCheck(instance_exists(_lid)&&_lid.depth<dry104.depth,"pizza manhole is above the final bank depth");
        var _samples=[];repeat(40) {
            var _start=get_timer();with(HMWorld) scrHMSewerTick();array_push(_samples,get_timer()-_start);
        }
        array_sort(_samples,true);show_debug_message("HARDMODE SEWER104 PROFILE "+json_stringify({median_us:_samples[20],entities:instance_number(hitme),floors:instance_number(Floor),walls:instance_number(Wall)}));
    }
    if(mode=="walls104" && ticks==10) {
        var _interior=0,_checked=0;with(Wall) if((self[$ "hm_interior_wall"]??false) && distance_to_point(10016,10016)<4096) {
            _interior++;
            if(_checked<100) {scrHMGameplayCheck(position_meeting(x+8,y+8,Wall),"interior wall cell retains native collision");_checked++;}
        }
        scrHMGameplayCheck(_interior>100,"interior is filled beyond the former two edge layers");
        var _old=GameCont.area;GameCont.area=scrHMAreaResolve("caves");
        scrHMWallThemeStart(player);
        wall_target104=scrHMAssetIndex("sprWall"+string(GameCont.area)+"Top");
        wall_trans104=scrHMAssetIndex("sprWall"+string(GameCont.area)+"Trans");
    }
    if(mode=="walls104" && ticks==245) {
        var _outer=0;
        with(Wall) if(distance_to_point(10016,10016)<4096) {
            if(topspr!=other.wall_target104) show_debug_message("HARDMODE WALL104 MISMATCH "+json_stringify({x:x,y:y,actual:topspr,target:other.wall_target104,area:GameCont.area,queue:array_length(HMWorld.hm_wall_theme_queue),index:HMWorld.hm_wall_theme_index}));
            scrHMGameplayCheck(topspr==other.wall_target104,"wall theme wave reaches outer and inner wall tops");
            if(self[$ "hm_interior_wall"]??false) _outer++;
        }
        with(TopSmall) if(distance_to_point(10016,10016)<4096) scrHMGameplayCheck(sprite_index==other.wall_trans104,"outer transition tiles follow the same color change");
        scrHMGameplayCheck(_outer>100,"color update preserves interior collisions");
    }
    if(mode=="walls104" && ticks==250) {
        var _samples=[];
        repeat(32) {
            var _wall=instance_nearest(player.x,player.y,Wall),_xx=_wall.x,_yy=_wall.y;
            var _start=get_timer();scrWallDestroy(_wall);array_push(_samples,get_timer()-_start);
            scrHMGameplayCheck(position_meeting(_xx+8,_yy+8,FloorExplo)&&!position_meeting(_xx+8,_yy+8,Wall),"native wall destruction opens each new collision cell");
        }
        array_sort(_samples,true);
        show_debug_message("HARDMODE WALLBREAK104 PROFILE "+json_stringify({median_us:_samples[16],maximum_us:_samples[31],walls:instance_number(Wall),samples:32}));
    }
    if(mode=="oasis104" && ticks==10) {
        scrHMGameplayCheck(!TopCont.darkness,"Oasis is a bright area independent of its numeric custom ID");
    }
    if(mode=="intro104" && ticks==10) {
        scrHMGameplayIsolate103();
        var _bullet=instance_create(player.x+20,player.y,EnemyBullet2);_bullet.speed=2*timescale;
        intro_bullet104=_bullet;intro_speed104=_bullet.speed;
        var _waterfloor=instance_nearest(player.x+32,player.y,Floor);_waterfloor.traction=2;
        HMWorld.hm_water_map=undefined;
        intro_gator104=instance_create(_waterfloor.x+16,_waterfloor.y+16,BuffGator);
        scrHMGameplayCheck(scrHMWaterAt(intro_gator104.x,intro_gator104.y),"intro fixture places the gator in real water");
        intro_target104=instance_create(player.x+180,player.y-60,CustomObject);
        intro_start104=point_distance(view_xview_center,view_yview_center,intro_target104.x,intro_target104.y);
        hm_bosses_bossintros_mod_gml_boss_trigger("BIG BIRD",mskNone,mskNone,mskNone,intro_target104,0);
        var _intro=noone;with(CustomObject) if(name=="bossintro") {_intro=id;break;}
        scrHMGameplayCheck(global.hm_camera_targets[player.index]==_intro,"intro explicitly owns the active camera target");
        scrHMGameplayCheck(player.hm_portrait_frozen&&_bullet.hm_portrait_frozen,"portrait freezes actors and projectiles once");
        with(HMWorld) scrHMSewerTick();
        scrHMGameplayCheck(intro_gator104.speed==0,"sewer global water tick cannot move a portrait-frozen gator");
        var _start=get_timer();with(_intro) scrHMBossStep104();
        show_debug_message("HARDMODE INTRO104 PROFILE "+json_stringify({step_us:get_timer()-_start,records:array_length(_intro.hm_portrait_records)}));
    }
    if(mode=="intro104" && ticks==18) {
        scrHMGameplayCheck(point_distance(view_xview_center,view_yview_center,intro_target104.x,intro_target104.y)<intro_start104*.7,"real BackCont camera moves toward the cinematic target");
    }
    if(mode=="intro104" && ticks==80) {
        scrHMGameplayCheck(player.can_walk&&player.can_spec&&!player.hm_portrait_frozen,"portrait restores player movement and skills");
        scrHMGameplayCheck(global.hm_camera_targets[player.index]==player,"camera returns to the player after the portrait");
        if(instance_exists(intro_bullet104)) scrHMGameplayCheck(!intro_bullet104.hm_portrait_frozen,"projectile is released after the portrait");
    }
    if(mode=="earlytank104" && ticks==10) {
        scrHMGameplayIsolate103();scrHMModSet("mod","options","intropan","0");UberCont.opt_bossintros=0;
        with(HMWorld) hm_bosses_titank_mod_gml_titank_create(other.player.x+80,other.player.y);
        tank_killed104=false;tank_time104=-1;
    }
    if(mode=="earlytank104" && ticks>10 && !tank_killed104) {
        var _tank=noone;with(CustomEnemy) if(name=="titank") {_tank=id;break;}
        if(instance_exists(_tank) && (_tank[$ "hm_feet_ready"]??false)) {
            scrHMGameplayCheck(array_length(_tank.hm_feet)==_tank.legs,"all leg receivers are tracked independently");
            for(var _i=0;_i<_tank.legs;++_i) _tank.hm_feet[_i].hp=0;
            tank_killed104=true;tank_time104=ticks;tank_body104=_tank;
        }
    }
    if(mode=="earlytank104" && ticks>10 && tank_killed104 && ticks==tank_time104+30) {
        scrHMGameplayCheck(!instance_exists(tank_body104)||tank_body104.hp<=0,"delayed intro cannot heal a tank whose legs died early");
    }
    if(mode=="earlytank104" && ticks==700) scrHMGameplayCheck(tank_killed104&&!instance_exists(tank_body104),"early simultaneous leg kills complete the real death sequence");
    if(mode=="unlocks104" && ticks==10) {
        var _old=GameCont.area;
        var _areas=["sewers","city","labs","jungle"],_races=[Race.Eyes,Race.Robot,Race.Steroids,Race.Chicken];
        for(var _i=0;_i<array_length(_areas);++_i) {
            scr_race_set_unlocked(_races[_i],false);GameCont.area=scrHMAreaResolve(_areas[_i]);
            with(player) scrUnlocksArea();
            scrHMGameplayCheck(scr_race_is_unlocked(_races[_i]),"entering extended "+_areas[_i]+" unlocks its original character");
        }
        GameCont.area=_old;
        scrHMGameplayCheck(scrHMLocFallback("Weapons:1:Name","PISTOL")==global.language_current[$ "Weapons:1:Name"],"stock keyed Chinese translation takes precedence");
        scrHMGameplayCheck(scrHMLocalize("TITANK")=="泰坦战车","new Hardmode text retains its translation");
    }
    if(mode=="storage104" && ticks==10) {
        var _old=game_directory+"migration-old/",_dest=game_directory+"migration-new/";
        directory_create(_old);directory_create(_dest);
        scrHMGameplayCheck(scrHMStorageWritable(_old)&&scrHMStorageWritable(_dest),"migration roots are writable");
        file_write(_old+"NuclearThrone.sav","{\"progress\":12}");
        if(file_exists(_dest+"NuclearThrone.sav")) file_delete(_dest+"NuclearThrone.sav");
        scrHMStorageMigrate(_old,_dest);
        scrHMGameplayCheck(file_read(_dest+"NuclearThrone.sav")==file_read(_old+"NuclearThrone.sav"),"valid private progress migrates to the new root");
        file_write(_dest+"NuclearThrone.sav","{\"progress\":99}");scrHMStorageMigrate(_old,_dest);
        scrHMGameplayCheck(json_parse(file_read(_dest+"NuclearThrone.sav")).progress==99,"valid imported destination is never overwritten by older progress");
        file_write(_dest+"savegame.dat","continued-run");file_write(_old+"savegame.dat","older-run");scrHMStorageMigrate(_old,_dest);
        scrHMGameplayCheck(file_read(_dest+"savegame.dat")=="continued-run","existing continuation data wins during migration");
    }
}

function scrHMGameplayRender104() {
    if(!surface_exists(application_surface)) return;
    if((mode=="water104"&&ticks==26)||(mode=="oasis104"&&ticks==15)
       ||(mode=="walls104"&&ticks==246)||(mode=="intro104"&&array_contains([12,20,35,60],ticks)))
        surface_save(application_surface,game_directory+mode+"-"+string(ticks)+".png");
}
