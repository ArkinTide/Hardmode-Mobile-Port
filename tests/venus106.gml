// Automated progression through real doors, elevators and boss callbacks.
// The driver positions the player at interaction/combat waypoints and uses
// real native bullet collisions. It never assigns an area, opens a door,
// destroys a blocker, sets enemy HP or calls room_restart to advance.
function scrHMVenusShoot106(_target,_damage=1000) {
    if(!instance_exists(_target)) return;
    with(instance_create(_target.x,_target.y,Bullet1)) {
        team=team_player;creator=HMGameplayTest.player;hitid=HitId.Player;
        damage=_damage;speed=0;image_alpha=0;
    }
}

function scrHMVenusDoorPoint106(_door) {
    var _px=_door.x+16,_py=_door.y,_near=false;
    with(CustomObject) if(name=="star"&&point_distance(x,y,_door.x,_door.y)<96) _near=true;
    if(!_near) {player.x=_px;player.y=_py;player.speed=0;return;}
    var _points=[[16,0],[-16,0],[0,16],[0,-16],[12,12],[-12,12],[12,-12],[-12,-12],[0,0]];
    var _best=-1,_pla=player;
    for(var _i=0;_i<array_length(_points);++_i) {
        var _x=_door.x+_points[_i][0],_y=_door.y+_points[_i][1],_score=1000000;
        _pla.x=_x;_pla.y=_y;
        var _contact=false,_blocked=false;with(_door) _contact=distance_to_object(_pla)<=16;
        with(_pla) _blocked=place_meeting(x,y,Wall)||place_meeting(x,y,InvisiWall);
        if(!_contact||_blocked) continue;
        with(CustomObject) if(name=="star"||name=="VenuzElevator") _score=min(_score,point_distance(x,y,_x,_y));
        if(_score>_best) {_best=_score;_px=_x;_py=_y;}
    }
    player.x=_px;player.y=_py;player.speed=0;
}

function scrHMVenusPark106() {
    if(is_undefined(self[$ "venus_park106"])) {
        var _avoid=[];
        with(CustomObject) if(name=="VenuzElevator"||name=="star") array_push(_avoid,[x,y]);
        with(CustomEnemy) if(name=="ratboss"||name=="ratbosssleep") array_push(_avoid,[x,y]);
        var _best=-1,_point=[player.x,player.y];
        with(Floor) if(x>=0&&y>=0&&x<4096&&y<4096) {
            var _score=1000000;
            for(var _i=0;_i<array_length(_avoid);++_i) _score=min(_score,point_distance(x+16,y+16,_avoid[_i][0],_avoid[_i][1]));
            if(_score>_best) {_best=_score;_point=[x+16,y+16];}
        }
        venus_park106=_point;
    }
    player.x=venus_park106[0];player.y=venus_park106[1];player.speed=0;
}

function scrHMGameplayVenus106() {
    if(!variable_instance_exists(id,"venus_path106")) {
        venus_path106=mode=="venusyc109"?[401,12]:(mode=="venus106"?[1,2,3,4,5,6,7,8,9,10,11,12]:[1,2,3,100,4,5,6,200,7,8,9,300,10,11,400,401,12]);
        var _start=0;for(var _i=0;_i<array_length(venus_path106);++_i) if(venus_path106[_i]==GameCont.subarea) {_start=_i;break;}
        if(_start>0) {
            var _trim=[];for(var _i=_start;_i<array_length(venus_path106);++_i) array_push(_trim,venus_path106[_i]);
            venus_path106=_trim;
        }
        venus_index106=-1;venus_sub106=-999;venus_phase106="settle";
        venus_age106=0;venus_phase_age106=0;venus_doors106=0;
        venus_shots106=0;venus_rooms106=[];venus_types106={};
        venus_air106=false;venus_ground106=false;venus_air_hit106=false;
        venus_air_shots106=false;venus_ground_shots106=false;venus_car106=noone;
        venus_air_counters106={};venus_air_projectiles106=false;
        venus_exit_room106=-1;venus_clear106=false;
    }
    GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0;
    // Keep combat waypoints stable under enemy knockback. Enemy damage and
    // AI still run normally; this driver does not test player survivability.
    player.nexthurt=current_frame+3;
    if(GameCont.area!=scrHMAreaResolve("venuz")) {
        scrHMGameplayCheck(venus_index106==array_length(venus_path106)-1,"Venus exit follows every expected stage");
        // Source sets junkyard/subarea=4 before BigPortal. Its normal
        // area_transit then advances to 3-5 in the newly generated room.
        if(venus_exit_room106<0) venus_exit_room106=route_rooms;
        var _ready=player.can_walk&&player.visible&&player.image_alpha>0&&!(player[$ "hm_portrait_frozen"]??false);
        if(route_rooms>venus_exit_room106 && room_ticks>=90 && (_ready||room_ticks>=600)) {
            scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("junkyard")&&GameCont.subarea==5,"Venus car returns through the source transition to junkyard 3-5");
            show_debug_message("HARDMODE VENUS106 RETURN "+json_stringify({ticks:room_ticks,floors:instance_number(Floor),walk:player.can_walk,visible:player.visible,alpha:player.image_alpha,portrait:player[$ "hm_portrait_frozen"],z:player.z,canfly:player.canfly}));
            scrHMGameplayCheck(instance_number(Floor)>5&&_ready,"return transition restores a visible playable character after the normal entry/boss presentation");
            var _boss_evidence={air_seen:venus_air106,ground_seen:venus_ground106,air_attacked:venus_air_shots106,
                ground_attacked:venus_ground_shots106,air_projectiles:venus_air_projectiles106,test_air_damage:venus_air_hit106};
            show_debug_message("HARDMODE VENUS106 BOSS EVIDENCE "+json_stringify(_boss_evidence));
            scrHMGameplayCheck(venus_air106&&venus_ground106&&venus_air_shots106&&venus_ground_shots106,"both natural Gun God phases attack before defeat: "+json_stringify(_boss_evidence));
            show_debug_message("HARDMODE VENUS106 COMPLETE "+json_stringify({path:venus_path106,rooms:venus_rooms106,doors:venus_doors106,enemy_shot_frames:venus_shots106,types:venus_types106,rate:rate,boss:_boss_evidence}));
            goal_ticks=ticks;
        }
        return;
    }
    if(mode=="venus106" && scrHMModGet("area","venuz","secrets")!=0)
        throw "Main Venus driver touched a star: "+json_stringify({sub:GameCont.subarea,phase:venus_phase106,x:player.x,y:player.y});
    var _sub=GameCont.subarea;
    if(_sub!=venus_sub106) {
        show_debug_message("HARDMODE VENUS106 TRANSIT "+json_stringify({observed:_sub,previous:venus_sub106,phase:venus_phase106,index:venus_index106+1,path:venus_path106,secrets:scrHMModGet("area","venuz","secrets")}));
        if(venus_index106>=0) {
            scrHMGameplayCheck(venus_clear106||(venus_sub106==300&&venus_phase106=="clear"),"previous Venus stage cleared through combat before elevator use");
            array_push(venus_rooms106,{sub:venus_sub106,ticks:venus_age106});
        }
        venus_index106++;
        scrHMGameplayCheck(venus_index106<array_length(venus_path106)&&_sub==venus_path106[venus_index106],"natural Venus elevator reaches the next expected stage, got "+string(_sub)+" at index "+string(venus_index106));
        venus_sub106=_sub;venus_age106=0;venus_phase_age106=0;
        venus_phase106="settle";venus_clear106=false;venus_door106=noone;
        venus_park106=undefined;
        show_debug_message("HARDMODE VENUS106 STAGE "+json_stringify({sub:_sub,floors:instance_number(Floor),walls:instance_number(Wall),rate:rate}));
    }
    venus_age106++;venus_phase_age106++;
    if(venus_age106>6000) throw "Venus stage stalls: "+string(_sub)+" phase="+venus_phase106;
    // The source boss can attack and leave its aircraft during the normal
    // arrival interval. Observe from creation, including those settle ticks.
    // Its attackchange decrements only after emitting a real burst. Count
    // that as well as surviving projectiles: a rocket can hit a wall before
    // this End Step observer runs, especially between 60 FPS logic ticks.
    if(_sub==12) {
        with(CustomEnemy) if(name=="GunGod") {
            if(!other.venus_air106) show_debug_message("HARDMODE VENUS106 AIR FIRST "+json_stringify({age:other.venus_age106,hp:hp,attackchange:attackchange,phase:other.venus_phase106}));
            other.venus_air106=true;
            var _key=string(id),_last=other.venus_air_counters106[$ _key]??25;
            if(attackchange!=_last) {
                if(!other.venus_air_shots106) show_debug_message("HARDMODE VENUS106 AIR BURST "+json_stringify({age:other.venus_age106,before:_last,after:attackchange,phase:other.venus_phase106}));
                other.venus_air_shots106=true;
            }
            other.venus_air_counters106[$ _key]=attackchange;
        }
        with(projectile) if(instance_exists(self[$ "creator"]??noone)) {
            var _source=creator;
            if(instance_is(_source,CustomEnemy)&&(_source[$ "name"]??"")=="GunGod") {
                other.venus_air_projectiles106=true;other.venus_air_shots106=true;
            }
        }
        with(CustomEnemy) if(name=="gungod") {
            if(!other.venus_ground106) show_debug_message("HARDMODE VENUS106 GROUND FIRST "+json_stringify({age:other.venus_age106,hp:hp,phase:other.venus_phase106}));
            other.venus_ground106=true;
            if(ammo<255) other.venus_ground_shots106=true;
        }
    }
    with(enemy) if((self[$ "name"]??"")!="portalblocker") other.venus_types106[$ object_get_name(object_index)+":"+(self[$ "name"]??"")]=true;
    with(projectile) if(team!=team_player) {
        other.venus_shots106++;
    }
    if(venus_phase106=="settle" && venus_phase_age106>=90) {
        if(mode=="venusyc109") {
            if(_sub==401) {
                scrHMGameplayCheck(instance_number(YungVenuzCouch)==1,"Y.C secret lounge legitimately creates the seated YV");
                with(GiantWeaponChest) {instance_create(x,y,ChestOpen);instance_destroy(id,false);}
            } else if(_sub==12) {
                scrHMGameplayCheck(!instance_exists(YungVenuzCouch)&&!instance_exists(ChestOpen),"actual lounge elevator removes seated YV and opened chest art before final boss");
            }
        }
        scrHMGameplayCheck(instance_number(Floor)>5&&!TopCont.darkness,"Venus stage is populated and has no false darkness");
        var _song=(_sub<=3||_sub==100)?"gungodz02":((_sub<=6||_sub==200)?"gungodz03":((_sub<=9||_sub==300)?"gungodz04":(_sub==12?"gungodz07":"gungodz06")));
        if(venus_path106[0]==1 || venus_index106>0) scrHMGameplayCheck(audio_is_playing(custom_sound_check(scrHMModGet("area","venuz",_song))),"Venus stage retains its expected source music while muted");
        with(WepPickup) scrHMGameplayCheck(sprite_index==scrHMWeaponSprite(wep),"Venus weapon pickup retains its actual weapon art");
        var _packed=0;with(Wall) if(self[$ "hm_interior_wall"]??false) _packed++;
        show_debug_message("HARDMODE VENUS106 TERRAIN "+json_stringify({sub:_sub,packed:_packed,walls:instance_number(Wall)}));
        scrHMGameplayCheck(_packed==0&&instance_number(Floor)>5&&instance_number(Wall)>0,
            "Venus elevator preserves authored geometry without an extra synthetic collision ring");
        if(surface_exists(application_surface)) surface_save(application_surface,game_directory+"venus-stage-"+string(_sub)+".png");
        venus_phase106=_sub==12?"bossair":"doors";venus_phase_age106=0;
    }
    if(venus_phase106=="doors") {
        var _door=noone,_number=100000;
        with(CustomObject) if(name=="door" && (self[$ "open"]??-999)==0 && number<_number) {_door=id;_number=number;}
        if(instance_exists(_door)) {
            venus_door106=_door;scrHMVenusDoorPoint106(_door);
            venus_phase106="doorwait";venus_phase_age106=0;
        } else {venus_phase106="clear";venus_phase_age106=0;}
    }
    if(venus_phase106=="doorwait") {
        if(instance_exists(venus_door106) && venus_door106.open==0) {
            scrHMVenusDoorPoint106(venus_door106);
            if(venus_phase_age106>90) throw "Venus door does not react to player contact: "+json_stringify({sub:_sub,door:[venus_door106.x,venus_door106.y,venus_door106.number],player:[player.x,player.y],rate:rate});
        } else if(venus_phase_age106>=75) {
            venus_doors106++;venus_phase106="doors";venus_phase_age106=0;
        }
    }
    if(venus_phase106=="clear") {
        scrHMVenusPark106();
        if(venus_phase_age106 mod 15==0) with(enemy) if((self[$ "name"]??"")!="portalblocker" && hp>0) scrHMVenusShoot106(id);
        var _remaining=0;with(enemy) if((self[$ "name"]??"")!="portalblocker"&&hp>0) _remaining++;
        if(_remaining==0 && venus_phase_age106>=120) {
            venus_clear106=true;venus_phase106="star";venus_phase_age106=0;
        }
    }
    if(venus_phase106=="star") {
        var _star=noone;
        if(mode=="venussecrets106") with(CustomObject) if(name=="star") {_star=id;break;}
        if(instance_exists(_star)) {player.x=_star.x;player.y=_star.y;player.speed=0;}
        else {venus_phase106="exit";venus_phase_age106=0;}
    }
    if(venus_phase106=="exit") {
        var _elevator=noone;with(CustomObject) if(name=="VenuzElevator") {_elevator=id;break;}
        if(instance_exists(_elevator)) {
            player.x=_elevator.x+16;player.y=_elevator.y+16;player.speed=0;
        } else if(venus_phase_age106>180) throw "Venus cleared stage has no elevator: "+string(_sub);
    }
    if(venus_phase106=="bossair") {
        var _boss=noone;with(CustomEnemy) if(name=="GunGod") {_boss=id;break;}
        if(instance_exists(_boss)) {
            venus_air106=true;
            if(venus_phase_age106>=240 && venus_air_shots106 && !venus_air_hit106) {scrHMVenusShoot106(_boss,1200);venus_air_hit106=true;}
        }
        var _ground=noone;with(CustomEnemy) if(name=="gungod") {_ground=id;break;}
        if(instance_exists(_ground)) {venus_ground106=true;venus_phase106="bossground";venus_phase_age106=0;}
    }
    if(venus_phase106=="bossground") {
        var _boss=noone;with(CustomEnemy) if(name=="gungod") {_boss=id;break;}
        if(instance_exists(_boss)) {
            if(_boss.ammo<255) venus_ground_shots106=true;
            player.x=_boss.x+72;player.y=_boss.y;player.speed=0;
            if(venus_phase_age106>240&&venus_ground_shots106&&venus_phase_age106 mod 15==0) scrHMVenusShoot106(_boss,300);
        } else {
            venus_phase106="carwait";venus_phase_age106=0;venus_clear106=true;
            scrHMGameplayCheck(venus_ground106,"ground phase existed before its death creates an escape car");
        }
    }
    if(venus_phase106=="carwait" || venus_phase106=="drive") {
        if(!instance_exists(venus_car106)) with(CustomObject) if(name=="VenuzCar") {other.venus_car106=id;break;}
        if(instance_exists(venus_car106)) {
            var _car=venus_car106;
            if(venus_phase106=="carwait" && _car.z<17) {
                player.x=_car.x;player.y=_car.y;player.speed=0;
                KeyCont.press_pick[player.index]=true;
                with(_car) with(id) scrHMActorCallback("on_step");
                KeyCont.press_pick[player.index]=false;
                scrHMGameplayCheck(_car.driver==player.index,"normal interact input enters the natural escape car");
                venus_exit_room106=route_rooms;
                venus_phase106="drive";venus_phase_age106=0;
            }
            if(venus_phase106=="drive") {
                KeyCont.hold_nort[player.index]=true;
                with(_car) with(id) scrHMActorCallback("on_step");
                KeyCont.hold_nort[player.index]=false;
            }
        }
    }
    if(venus_age106 mod 300==0) {
        var _actors=[];with(enemy) if((self[$ "name"]??"")!="portalblocker") array_push(_actors,[object_get_name(object_index),self[$ "name"],hp,x,y]);
        show_debug_message("HARDMODE VENUS106 PROGRESS "+json_stringify({sub:_sub,phase:venus_phase106,ticks:venus_age106,actors:_actors,doors:venus_doors106}));
    }
}
