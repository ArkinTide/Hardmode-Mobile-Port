// Exercise live simulation and rendering. Profiling includes normal Step,
// native collision events and Draw, with the game running and unpaused.
function scrHMGameplayRepairs106() {
    if(mode=="profile106" && ticks==10) {
        frame_samples106=[];
        profile_walls106=instance_number(Wall);
        profile_actors106=instance_number(enemy);
    }
    if(mode=="profile106" && ticks==165) {
        var _samples=frame_samples106;array_sort(_samples,true);
        show_debug_message("HARDMODE FRAME106 "+json_stringify({area:GameCont.area,sub:GameCont.subarea,
            rate:rate,walls:profile_walls106,actors:profile_actors106,samples:array_length(_samples),
            median_us:_samples[array_length(_samples) div 2],p95_us:_samples[floor(array_length(_samples)*.95)]}));
    }
    if(mode=="attack106" && ticks==10) {
        scrHMGameplayIsolate103();
        current_frame=floor(current_frame)+.5;
        // Open a clear, stable test lane; use the actual on_step callbacks,
        // AI timers and projectile creation, rather than directly firing.
        for(var _i=0;_i<16;++_i) for(var _j=0;_j<6;++_j) instance_create(14000+32*_i,14000+32*_j,Floor);
        player.x=14032;player.y=14096;
        attack106=[];attack_seen106={};attack_cooldowns106={};attack_fires106={};
        var _names=["Molefish","Molesarge","Minigunner","Chick"];
        for(var _i=0;_i<array_length(_names);++_i) {
            var _e=scrHMModCall("mod","enemies",_names[_i]+"_create",14128+(_i mod 4)*64,14032+(_i div 4)*96);
            array_push(attack106,_e);
        }
        show_debug_message("HARDMODE COLLISION106 "+json_stringify({none:noone,clear:collision_line(14032,14096,14128,14032,Wall,0,0),
            negated:!collision_line(14032,14096,14128,14032,Wall,0,0)}));
    }
    if(mode=="attack106" && ticks>10) {
        player.x=14032;player.y=14096;player.speed=0;
        var _seen=attack_seen106;
        with(projectile) if(instance_exists(self[$ "creator"]??noone)) _seen[$ string(creator)]=true;
        with(Effect) if((self[$ "name"]??"")=="venuzpistoltrail" && instance_exists(creator)) _seen[$ string(creator)]=true;
        for(var _i=0;_i<array_length(attack106);++_i) {
            var _e=attack106[_i],_key=string(_e);
            var _last=attack_cooldowns106[$ _key]??_e.alrm1;
            if(_e.alrm1>_last+15) attack_fires106[$ _key]=(attack_fires106[$ _key]??0)+1;
            attack_cooldowns106[$ _key]=_e.alrm1;
        }
        if(ticks mod 100==0) {
            var _state=[];
            for(var _i=0;_i<array_length(attack106);++_i) {
                var _e=attack106[_i];
                if(instance_exists(_e)) array_push(_state,[_e.name,_e.targetvisible,_e[$ "alrm1"],_seen[$ string(_e)]??false,_e.x,_e.y,_e.target,_e[$ "firing"],attack_fires106[$ string(_e)]??0]);
            }
            show_debug_message("HARDMODE ATTACK106 "+json_stringify(_state));
            show_debug_message("HARDMODE SHOTS106 "+json_stringify({effects:instance_number(Effect),bullets:instance_number(Bullet1),seen:attack_seen106}));
        }
    }
    if(mode=="attack106" && ticks==1190) {
        for(var _i=0;_i<array_length(attack106);++_i) {
            var _e=attack106[_i];
            scrHMGameplayCheck(attack_seen106[$ string(_e)]??false,"Venus "+_e.name+" creates real projectiles or visible shot trails with its own creator ID");
        }
    }
    if(mode=="natural106") {
        if(ticks==10) natural_shots106=false;
        if(ticks==90) with(enemy) hp=0;
        if(ticks==450) {
            var _tank=noone;with(CustomEnemy) if(name=="titank") _tank=id;
            scrHMGameplayCheck(instance_exists(_tank),"natural Titank entrance completes");
            var _live=0;for(var _i=0;_i<_tank.legs;++_i) if(instance_exists(_tank.hm_feet[_i])&&_tank.hm_feet[_i].hp>0) _live++;
            show_debug_message("HARDMODE NATURAL106 "+json_stringify({legs:_tank.legs,live:_live,hp:_tank.hp,x:_tank.x,y:_tank.y,z:_tank.z,tasks:array_length(global.hm_tasks)}));
            scrHMGameplayCheck(_live==4,"all four natural Titank receivers survive entrance and portrait");
            player.x=_tank.x+80;player.y=_tank.y+100;
        }
        if(ticks==900) {
            var _state=[];with(CustomEnemy) if(name=="titank") array_push(_state,[x,y,z,attacking,hp,foot_hp]);
            show_debug_message("HARDMODE NATURAL106 END "+json_stringify(_state));
            scrHMGameplayCheck(natural_shots106,"natural Titank fires actual projectiles after entrance and portrait");
        }
        if(ticks>450) with(projectile) if(is_array(hitid) && array_length(hitid)>1 && hitid[1]=="Titank") other.natural_shots106=true;
    }
    if(mode=="hunter106" && ticks==10) {
        scrHMGameplayIsolate103();
        for(var _i=0;_i<16;++_i) for(var _j=0;_j<12;++_j) instance_create(14000+32*_i,14000+32*_j,Floor);
        player.x=14064;player.y=14192;
        hunter106=instance_create(14160,14192,LilHunter);hunter106.team=3;
        hunter_idpd106=false;hunter_fire106=false;hunter_native106=0;
    }
    if(mode=="hunter106" && ticks>10 && ticks<85) {
        // Fire the native attack event at both ranges; the original MOD's
        // normal world hook must convert those shots on its following tick.
        if(ticks mod 3==0) {
            with(hunter106) {
                if(object_index!=LilHunter) instance_change(LilHunter,false);
                x=other.player.x+(other.ticks<45?96:160);y=other.player.y;
                speed=0;forceliftoff=false;walk=0;alarm[1]=-1;
                event_perform(ev_alarm,1);
                alarm[1]=-1;
            }
            hunter_native106+=instance_number(EnemyBullet1)+instance_number(LHBouncer);
        } else {
            if(instance_exists(IDPDBullet)) hunter_idpd106=true;
            with(TrapFire) if(sprite_index==sprFireLilHunter && team==3) other.hunter_fire106=true;
        }
    }
    if(mode=="hunter106" && ticks==85) {
        show_debug_message("HARDMODE HUNTER106 "+json_stringify({native:hunter_native106,idpd:hunter_idpd106,fire:hunter_fire106}));
        scrHMGameplayCheck(hunter_native106>0,"native Lil Hunter emits its real attack events");
        scrHMGameplayCheck(hunter_idpd106&&hunter_fire106,"MOD converts native attacks into IDPD bullets and Hunter flames");
    }
    if(mode=="contracts106" && ticks==10) {
        scrHMGameplayIsolate103();
        GameCont.area=scrHMAreaResolve("HQ");
        var _portal=instance_create(player.x+48,player.y,Portal);
        scrHMGameplayCheck(_portal.type==2,"police HQ exit is blue");
        instance_destroy(_portal,false);
        GameCont.area=scrHMAreaResolve("city");
        var _bandit=instance_create(player.x+48,player.y,Bandit);
        scrHMGameplayCheck(_bandit.spr_idle==sprSnowBanditIdle,"native city bandit wears snow art");
        var _custom=hm_enemies_mod_gml_elitebandit_create(player.x+64,player.y,1);
        scrHMGameplayCheck(_custom.spr_idle==sprSnowBanditIdle,"custom armed city bandit wears snow art");
        GameCont.area=scrHMAreaResolve("venuz");
        var _car=hm_props_mod_gml_VenuzCar_create(player.x+80,player.y,0);
        scrHMGameplayCheck(instance_exists(_car),"VenuzCar reads the real background color");
        var _receiver=instance_create(player.x,player.y,CustomEnemy);_receiver.sprite_index=-1;
        with(_receiver) scrHMGameplayCheck(!scrHMSwimSprite106(),"invisible logical receiver skips invalid sprite dimensions");
        var _list=ds_list_create();scrHMWeaponList(_list,6,3);
        scrHMGameplayCheck(ds_list_size(_list)>0,"goto low-hardness weapon range remains nonempty");
        for(var _i=0;_i<ds_list_size(_list);++_i) scrHMGameplayCheck(sprite_exists(scrHMWeaponSprite(_list[| _i])),"goto prop weapons resolve to real sprites");
        ds_list_destroy(_list);
    }
    if(mode=="packed106" && ticks==10) {
        scrHMGameplayIsolate103();
        var _block=scrHMFillBlock106(15008,15008,64,64);
        for(var _i=0;_i<4;++_i) for(var _j=0;_j<4;++_j)
            scrHMGameplayCheck(position_meeting(15016+_i*16,15016+_j*16,Wall),"packed wall retains every collision cell");
        instance_create(15024,15024,Floor);
        var _hole=0,_solid=0,_textured=0;
        for(var _i=0;_i<4;++_i) for(var _j=0;_j<4;++_j) {
            var _open=(_i>=1&&_i<=2&&_j>=1&&_j<=2);
            var _wall=collision_point(15016+_i*16,15016+_j*16,Wall,false,false);
            scrHMGameplayCheck(instance_exists(_wall)!=_open,"new floor removes exactly its four packed collision cells");
            if(instance_exists(_wall)) with(_wall) {if(!scrHMPlainWall106()) _textured++;}
        }
        scrHMGameplayCheck(_textured==12,"new floor exposes a textured boundary around compact exterior");
        var _break=scrHMFillBlock106(15200,15008,64,64);
        with(_break) scrWallDestroy(id);
        scrHMGameplayCheck(position_meeting(15208,15016,FloorExplo),"native destruction materializes and opens one packed cell");
        scrHMGameplayCheck(position_meeting(15256,15064,Wall),"native destruction preserves distant collision in the same packed block");
        bank_test106=scrHMFillBlock106(15408,15008,64,64);
        with(instance_create(15416,15016,PortalClear)) {hm_water_clear=true;scrHMSewerBank(other.bank_test106);}
        var _intact=0,_broken=0;
        with(FloorExplo) if(x>=15408&&x<15472&&y>=15008&&y<15072) {
            if(sprite_index==sprFloor2&&image_index==0) _intact++;else _broken++;
        }
        scrHMGameplayCheck(_intact>0&&_broken==0,"split sewer bank uses intact floors at each new cell");
    }
    if(mode=="throne106" && ticks==10) {
        var _tagged=0;with(Floor) if(self[$ "nokill"]??false) _tagged++;
        show_debug_message("HARDMODE THRONE106 "+json_stringify({tagged:_tagged,floors:instance_number(Floor),walls:instance_number(Wall),
            throne:instance_number(NothingInactive),player_x:player.x,player_y:player.y}));
        scrHMGameplayCheck(_tagged==1 && instance_number(NothingInactive)==1,"throne has exactly one retained seed and one boss");
        scrHMGameplayCheck(!TopCont.darkness,"throne does not inherit darkness from an even custom area ID");
    }
    if(mode=="goto106" && ticks==10) scrHMGameplayCheck(GameCont.hard==0 && instance_number(Floor)>5,"goto snow stage populates successfully at initial hardness zero");
    if(mode=="titank106" && ticks==10) {
        scrHMGameplayIsolate103();
        for(var _i=0;_i<14;++_i) for(var _j=0;_j<14;++_j) instance_create(14000+32*_i,14000+32*_j,Floor);
        player.x=14048;player.y=14048;
        with(HMWorld) hm_bosses_titank_mod_gml_titank_create(14224,14224);
    }
    if(mode=="titank106" && ticks mod 100==0) {
        with(CustomEnemy) if(name=="titank") {
            var _state=[];
            for(var _i=0;_i<legs;++_i) array_push(_state,[foot_hp[_i],hm_feet[_i],instance_exists(hm_feet[_i])]);
            show_debug_message("HARDMODE TITANK106 "+json_stringify({tick:other.ticks,feet:_state,hp:hp,z:z,attack:attacking,
                tasks:array_length(global.hm_tasks),x:x,y:y,weapon:instance_number(projectile),frozen:self[$ "frozen"]??false}));
        }
    }
}

function scrHMGameplayRender106() {
    if(mode=="profile106" && ticks>15 && ticks<160) array_push(frame_samples106,get_timer()-hm_frame_start106);
    if(array_contains(["profile106","throne106","attack106"],mode) && ticks==80 && surface_exists(application_surface))
        surface_save(application_surface,game_directory+mode+"-"+string(GameCont.area)+"-"+string(GameCont.subarea)+".png");
}
