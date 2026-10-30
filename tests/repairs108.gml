// Real native callbacks and collision paths, isolated from user saves.
function scrHMGameplayRepairs108() {
    if(mode=="wall108" && ticks==12) {
        var _plain=0,_detail=0,_fringe=0;
        with(Wall) {if(scrHMPlainWall106()) _plain++;else _detail++;}
        with(TopSmall) if(position_meeting(x+8,y+8,Wall)) _fringe++;
        scrHMGameplayCheck(_plain>0&&_detail>0,"normal generation retains compact solid fill and detailed boundary");
        scrHMGameplayCheck(_fringe>0,"transition sprites survive over exterior collision cells");
        var _n=instance_number(TopSmall);scrHMWallTransitions108();
        scrHMGameplayCheck(instance_number(TopSmall)==_n,"repeat terrain maintenance does not accumulate fringe sprites");
        wall_frame108=true;
    }
    if(mode=="venuswall108" && ticks==20) {
        var _fill=0;with(Wall) if(self[$ "hm_interior_wall"]??false) _fill++;
        scrHMGameplayCheck(_fill==0,"authored Venus map has no synthetic exterior wall ring");
        // Secret room 400 has 28 authored floor cells. Require real geometry
        // without treating a legitimately compact room as a missing map.
        scrHMGameplayCheck(instance_number(Floor)>5&&instance_number(Wall)>10,"mansion retains authored floor and visible walls");
        // Native wall frames deliberately wrap: choose(0..4)+choose(0,4)
        // may equal the frame count. A sprite asset assigned as the index
        // is the actual source typo; ordinary wrapped indices are valid.
        var _bad=0;with(Wall) if(!sprite_exists(outspr)||!sprite_exists(topspr)||outindex==sprWall103Out) _bad++;
        scrHMGameplayCheck(_bad==0,"mansion walls retain valid art and no sprite-ID-as-frame assignments");
    }
    if(mode=="pickup108" && ticks==10) {
        scrHMGameplayLane107();GameCont.area=scrHMAreaResolve("venuz");
        pickups108=[];
        for(var _i=0;_i<8;++_i) {
            var _p=scrWeaponPickupCreate(14012,14032+_i*32,wep_shotgun);
            _p.direction=180;_p.speed=16*timescale;_p.friction=0;
            with(_p) scrHMVenusPickup108();array_push(pickups108,_p);
            instance_create(13984,14016+_i*32,InvisiWall);
        }
    }
    if(mode=="pickup108" && ticks==45) {
        for(var _i=0;_i<array_length(pickups108);++_i) with(pickups108[_i]) {
            scrHMGameplayCheck(position_meeting(x,y,Floor)&&!place_meeting(x,y,InvisiWall),"fast chest-like weapon ejection stays on reachable current floor");
            scrHMGameplayCheck(wep==wep_shotgun,"boundary recovery preserves the actual dropped weapon");
        }
    }
    if(mode=="car108" && ticks==10) {
        scrHMGameplayLane107();
        var _car=hm_props_mod_gml_VenuzCar_create(player.x,player.y,0);
        KeyCont.press_pick[player.index]=true;
        with(_car) with(id) scrHMActorCallback("on_step");
        KeyCont.press_pick[player.index]=false;
        scrHMGameplayCheck(_car.driver==player.index,"normal interaction boards the real golden car");
        var _touch=KeyCont.touch[player.index],_pad=UberCont.opt_gamepad;
        for(var _device=0;_device<2;++_device) for(var _angle=0;_angle<360;_angle+=90) {
            KeyCont.touch[player.index]=(_device==0);UberCont.opt_gamepad=(_device==1);
            KeyCont.moving[player.index]=true;KeyCont.dir_move[player.index]=_angle;
            // Run the source callback with the actual input adapter, then
            // integrate its velocity at the host's 30/60 physical step size.
            var _x0=player.x,_y0=player.y;
            _car.x=_x0;_car.y=_y0;_car.speed=0;_car.image_angle=_angle;_car.z=0;_car.portal=200;
            for(var _j=0;_j<15;++_j) {
                with(_car) with(id) scrHMActorCallback("on_step");
                _car.x+=_car.hspeed/timescale;_car.y+=_car.vspeed/timescale;
            }
            var _travel=point_distance(_x0,_y0,_car.x,_car.y);
            scrHMGameplayCheck(_travel>12,"both touch and gamepad directions accelerate the driven car");
            scrHMGameplayCheck(abs(angle_difference(point_direction(_x0,_y0,_car.x,_car.y),_angle))<.01,"car drives straight toward each of four analog directions");
            scrHMGameplayCheck(abs(angle_difference(_car.image_angle,_angle))<.01,"held direction does not cause continuous spinning");
        }
        KeyCont.touch[player.index]=_touch;UberCont.opt_gamepad=_pad;KeyCont.moving[player.index]=false;
        instance_destroy(_car,false);
    }
    if(mode=="portal108" && ticks==10) {
        scrHMGameplayLane107();
        scrHMModSet("mod","options","portals","1");
        portal108=instance_create(player.x+20,player.y,Portal);
        with(portal108) {sprite_index=sprPortal;endgame=100;close=false;image_speed=0;}
        portal_enter108=false;
    }
    if(mode=="portal108" && ticks==12) {
        scrHMGameplayCheck(portal108.close&&portal108.endgame<=30&&portal108.alarm[1]>0,"source shrink radius commits real native portal entry and its transition alarm");
        scrHMGameplayCheck(player.mask_index==mskNone,"committed entry releases the player's wall mask");
        instance_destroy(portal108,false);
    }
    if(mode=="police108" && ticks==10) {
        scrHMGameplayLane107();
        var _saved=GameCont.loops;GameCont.loops=3;var _freak=0,_regular=0,_elite=0;
        for(var _i=0;_i<180;++_i) {
            // Exercise the real portal event, not a separate spawn model.
            var _p=instance_create(14360,14160,IDPDSpawn);
            with(_p) {alarm[1]=-1;event_perform(ev_alarm,1);}
            with(enemy) {
                if(object_index==PopoFreak) _freak++;
                else if(array_contains([EliteGrunt,EliteInspector,EliteShielder],object_index)) _elite++;
                else _regular++;
                instance_destroy(id,false);
            }
            instance_destroy(_p,false);
        }
        scrHMGameplayCheck(_freak>60&&_freak<120&&_regular>10&&_elite>10,"late-loop real portals produce both halves of the mixed police roster");
        GameCont.loops=_saved;
        var _van=instance_create(14200,14160,CustomObject);_van.hm_freak107=true;_van.land=1;_van.drivespeed=0;_van.speed=0;
        GameCont.loops=3;with(_van) scrHMVanStop107();
        scrHMGameplayCheck(!instance_exists(_van)&&instance_number(enemy)==3,"stopped dangerous van releases exactly three members of the mixed roster");
        GameCont.loops=_saved;
    }
    if(mode=="tank108" && ticks==10) {
        scrHMGameplayLane107();
        var _old=GameCont.loops;GameCont.loops=3;
        var _tank=hm_enemies_mod_gml_IDPDTank_create(player.x+96,player.y,0);
        with(_tank) {scrHMRadiationSync(true);scrHMTankRadiation108();}
        scrHMGameplayCheck(_tank.raddrop==66,"loop-three tank has 70 base radiation with pre-cap MOD reduction");
        _tank.raddrop+=5;repeat(4) with(_tank) {scrHMTankRadiation108();scrHMRadiationSync(true);}
        scrHMGameplayCheck(_tank.raddrop==71,"tank retains absorbed radiation without repeated base addition");
        with(_tank) scrHMRadiationSync(false);
        scrHMGameplayCheck(_tank.raddrop==75,"max-level tank restores 70 original base plus absorbed radiation");
        scrHMGameplayCheck(_tank.spawnanimation==0&&_tank.spr_idle==scrHMModGet("mod","enemies","IDPDTankidle"),"tank is active without old entrance presentation");
        hm_bosses_bossintros_mod_gml_boss_trigger("IDPD TANK",mskNone,mskNone,mskNone,_tank,60);
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active),"tank never starts a portrait/camera presentation");
        var _shot=instance_create(player.x+96,player.y,CustomProjectile);
        _shot.creator=_tank;_shot.charge=.5;_shot.aim=0;_tank.gunangle=90;
        with(_shot) scrHMTankAim108();
        scrHMGameplayCheck(abs(_shot.aim)<=1.5&&abs(_shot.aim)>0,"tank early charge has limited angular tracking");
        _shot.charge=1.1;var _aim=_shot.aim;_tank.gunangle=180;
        with(_shot) scrHMTankAim108();
        scrHMGameplayCheck(_shot.aim==_aim,"late charge warning is locked to the eventual laser direction");
        instance_destroy(_shot,false);
        scrHMModSet("mod","options","bossoutros","1");
        _tank.hp=0;instance_destroy(_tank);
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active),"actual tank death callback skips its departure camera presentation");
        hm_bosses_bossintros_mod_gml_boss_trigger("BIG DOG",mskNone,mskNone,mskNone,player,60);
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active),"loop boss portrait is disabled");
        var _intro_option=UberCont.opt_bossintro,_paused=UberCont.paused;
        UberCont.opt_bossintro=true;UberCont.bossintro=false;
        for(var _loop=1;_loop<=3;_loop+=2) {
            GameCont.loops=_loop;scrBossIntro(3);
            scrHMGameplayCheck(!UberCont.bossintro&&UberCont.paused==_paused,
                "native throne portrait entry also stays disabled after looping");
        }
        UberCont.opt_bossintro=_intro_option;
        GameCont.loops=_old;
    }
    if(mode=="tankportal108" && ticks==10) {
        scrHMGameplayLane107();var _clears=instance_number(PortalClear);
        tankportal108=scrHMTankPortal108(player.x+128,player.y,180);
        scrHMGameplayCheck(tankportal108.x==player.x+128&&tankportal108.y==player.y,
            "tank portal Create preserves its requested position without random relocation");
        scrHMGameplayCheck(instance_number(PortalClear)==_clears,
            "tank portal does not clear an unrelated tile during van-style placement");
        vanportal108=instance_create(player.x-64,player.y,VanSpawn);
        scrHMGameplayCheck(tankportal108.sprite_index==sprVanPortalStart,"tank uses the same large IDPD opening as a van");
        scrHMGameplayCheck(sprite_get_width(sprHMVanWarning108)==24&&sprite_get_height(sprHMIDPDTankWarning108)==20,"warning assets use supplied van and source tank head");
        warning_frames108=0;tank_opened108=false;
    }
    if(mode=="tankportal108" && ticks==85) {
        var _n=0;with(CustomEnemy) if(name=="IDPDTank") _n++;
        scrHMGameplayCheck(_n>=1,"large portal's real alarms spawn the IDPD tank");
        scrHMGameplayCheck(warning_frames108>=20,"warning is rendered throughout the portal opening");
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active),"portal arrival never freezes the scene for a tank presentation");
    }
    if(mode=="tankportal108" && ticks>=10) {
        // The isolated lane is far from the generated map. Aim the actual
        // camera at both portals before rendering, without mouse offsets.
        global.hm_camera_targets[global.index]=noone;
        view_xview=player.x+32-view_width/2;view_yview=player.y-24-view_height/2;
        BackCont.viewxf=view_xview;BackCont.viewyf=view_yview;
        BackCont.viewx2=0;BackCont.viewy2=0;BackCont.force_snap_camera_position=true;
        KeyCont.dis_fire[player.index]=0;
        camera_set_view_pos(view_camera,view_xview,view_yview);
    }
    if(mode=="sniper108" && ticks==10) {
        scrHMGameplayLane107();
        var _mount=instance_create(player.x+96,player.y,Wolf);
        sniper108=instance_create(_mount.x,_mount.y-12,Sniper);sniper108.mount=_mount;sniper108.mask_index=mskNone;
        sniper108.nexthurt=0;sniper108.hp=100;sniper108.freeze=50;
        instance_destroy(_mount,false);
    }
    if(mode=="sniper108" && ticks==12) {
        scrHMGameplayCheck(sniper108.mount>0&&sniper108.mask_index==mskBandit,"falling rider has its hit mask before ten-tick landing");
        var _hp=sniper108.hp;var _shot=instance_create(sniper108.x,sniper108.y,Bullet1);
        _shot.team=team_player;_shot.damage=3;_shot.hitid=HitId.Player;
        with(sniper108) with(_shot) event_perform(ev_collision,hitme);
        scrHMGameplayCheck(sniper108.hp<_hp,"real player projectile damages the dismounted sniper during its fall");
    }
    if(mode=="reflect108" && ticks==10) {
        scrHMGameplayLane107();
        var _callbacks=[hm_enemies_mod_gml_bigshield_step,hm_enemies_mod_gml_EliteSpiderShield_step,hm_enemies_mod_gml_customshield_step];
        for(var _c=0;_c<3;++_c) for(var _b=0;_b<2;++_b) {
            var _shield=instance_create(player.x+96,player.y,CustomObject);
            _shield.sprite_index=sprShieldB;_shield.mask_index=mskShield;_shield.team=3;_shield.image_speed=0;
            _shield.creator=player;_shield.time=100;_shield.on_step=undefined;
            var _shot=instance_create(_shield.x+4,_shield.y,_b==0?PlasmaBig:PlasmaHuge);
            _shot.team=team_player;_shot.hitid=HitId.Player;_shot.direction=180;_shot.speed=0;
            with(_shield) with(id) scrHMInvokeHere(_callbacks[_c],[]);
            scrHMGameplayCheck(_shot.team==team_player&&_shot.hitid==HitId.Player,"custom crystal/spider shield keeps plasma damage attribution");
            instance_destroy(_shot);
            var _children=0;with(projectile) if(instance_is(id,PlasmaBig)||instance_is(id,PlasmaBall)) {
                _children++;
                scrHMGameplayCheck(team==team_player&&!scr_can_hit(HMGameplayTest.player,false),"reflected plasma's real explosion descendants cannot hit the player");
            }
            scrHMGameplayCheck(_children==(_b==0?10:4),"reflected plasma keeps its full native split/explosion payload");
            with(projectile) instance_destroy(id,false);instance_destroy(_shield,false);
        }
    }
    if(mode=="beam108" && ticks==10) {
        scrHMGameplayLane107();
        var _beam=instance_create(15008,15008,NothingBeam);_beam.alarm[0]=-1;_beam.alarm[1]=-1;
        var _wall=scrHMFillBlock106(14992,15120,64,64);var _old_us=0,_new_us=0;
        for(var _i=0;_i<30;++_i) with(_beam) {
            x=15008+(_i mod 3)*2;y=15008;_wall.y=15016+_i*16;
            var _time=get_timer();image_yscale=1;
            repeat(1024) {image_yscale-=timescale;if(place_meeting(x,y,Wall)) break;}
            var _expected=image_yscale;_old_us+=get_timer()-_time;
            _time=get_timer();scrHMThroneBeam108();_new_us+=get_timer()-_time;
            scrHMGameplayCheck(image_yscale==_expected,"optimized throne ray preserves the exact original collision scale");
        }
        show_debug_message("HARDMODE BEAM108 "+json_stringify({legacy_us:_old_us,optimized_us:_new_us,rate:rate}));
        instance_destroy(_beam,false);instance_destroy(_wall,false);
    }
    if(mode=="filter108" && ticks==10) {
        scrHMGameplayLane107();
        for(var _i=0;_i<512;++_i) with(instance_create(player.x+80,player.y,EnemyBullet2)) {
            team=_i mod 3;if(_i mod 2==0) hm_optional108=_i mod 5;
            speed=0;alarm[0]=1000;
        }
        var _fields=["team","hm_optional108","object_index","alarm0"],_values=[[1,2],[undefined,3],[EnemyBullet2],[1000]];
        var _a=0,_b=0;
        for(var _f=0;_f<4;++_f) for(var _op=0;_op<6;++_op) {
            var _t=get_timer(),_expected=scrHMFilter([projectile],_fields[_f],_values[_f],_op);_a+=get_timer()-_t;
            _t=get_timer();var _actual=scrHMFilter(projectile,_fields[_f],_values[_f],_op);_b+=get_timer()-_t;
            scrHMGameplayCheck(array_length(_expected)==array_length(_actual),"native filter preserves counts including optional fields, alarms and comparisons");
            for(var _j=0;_j<array_length(_expected);++_j)
                scrHMGameplayCheck(_expected[_j]==_actual[_j],"native filter preserves instance selection and ordering");
        }
        show_debug_message("HARDMODE FILTER108 "+json_stringify({legacy_us:_a,optimized_us:_b,rate:rate}));
        scrHMGameplayCheck(array_length(scrHMFilter(undefined,"team",[1],0))==0,"undefined filter targets retain empty-instance semantics");
        scrHMGameplayCheck(array_length(scrHMFilter({},"team",[1],0))==0,"struct filter targets retain empty-instance semantics");
    }
    if(mode=="crater108" && ticks==10) {
        scrHMGameplayLane107();
        var _van=instance_create(player.x+120,player.y,CustomObject);
        _van.baby=noone;
        with(_van) with(id) hm_enemies_mod_gml_vanexplo();
        var _n=0;with(Effect) if(self[$ "hm_van_crater108"]??false) {
            _n++;scrHMGameplayCheck(image_xscale==1&&image_yscale==1,"police van explosion leaves small scorch sprites");
        }
        scrHMGameplayCheck(_n==3,"police van leaves three separate small craters");
        instance_destroy(_van,false);
    }
    if(mode=="text108" && ticks==10) {
        scrLanguageSet("Simplified Chinese");UberCont.opt_language="Simplified Chinese";
        var _names=["VENUZ PISTOL","VENUZ SHOTGUN","VENUZ MINIGUN","VENUZ ROCKET LAUNCHER","VENUZ SMG"];
        for(var _i=0;_i<array_length(_names);++_i) {
            var _text=scrHMLocalize(_names[_i]);
            scrHMGameplayCheck(string_pos("金星",_text)==1&&string_pos("维纳斯",_text)==0,"all exported Venus weapon display names use 金星");
        }
    }
}

function scrHMGameplayRender108() {
    if(mode=="tankportal108" && ticks>=12&&ticks<=40) {
        if(instance_exists(tankportal108)&&tankportal108.sprite_index==sprVanPortalStart) warning_frames108++;
    }
    if(array_contains(["wall108","venuswall108","pickup108","tankportal108"],mode)
        && array_contains([20,40,84],ticks) && surface_exists(application_surface))
        surface_save(application_surface,game_directory+mode+"-"+string(ticks)+"-"+string(age)+".png");
}
