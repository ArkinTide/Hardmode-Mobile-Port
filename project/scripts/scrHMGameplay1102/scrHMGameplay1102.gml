// Production host VM scenarios. No native NTT event mock is used here.
function scrHMGameplay1102() {
    if(mode=="sync112water" && ticks==20) {
        var _points=[];
        with(Floor) for(var _xx=x-2;_xx<=x+34;_xx+=6) for(var _yy=y-2;_yy<=y+34;_yy+=6)
            array_push(_points,[_xx,_yy]);
        scrHMWaterMap();
        var _old=[];
        scrHMWaterBatchEnd1102();
        for(var _i=0;_i<array_length(_points);++_i) array_push(_old,scrHMWaterExact109(_points[_i][0],_points[_i][1]));
        scrHMWaterBatchBegin1102();
        for(var _i=0;_i<array_length(_points);++_i)
            scrHMGameplayCheck(_old[_i]==scrHMWaterExact109(_points[_i][0],_points[_i][1]),"same-pass water geometry including bank and overlap");
        scrHMWaterBatchEnd1102();
        var _floor=noone;with(Floor) if(traction==2 && instance_exists(self[$ "hm_water_surface111"]??noone)) {_floor=id;break;}
        scrHMGameplayCheck(instance_exists(_floor),"real sewer contains linked physical water");
        var _x=_floor.x+16,_y=_floor.y+20;
        scrHMWaterBatchBegin1102();var _wet=scrHMWaterExact109(_x,_y);scrHMWaterBatchEnd1102();
        var _traction=_floor.traction;_floor.traction=0;
        scrHMGameplayCheck(!scrHMWaterExact109(_x,_y),"queries outside pass see changed dry material immediately");
        scrHMWaterBatchBegin1102();
        scrHMGameplayCheck(!scrHMWaterExact109(_x,_y),"next pass discards earlier wet geometry");
        scrHMWaterBatchEnd1102();_floor.traction=_traction;
        show_debug_message("SYNC112 WATER "+json_stringify({points:array_length(_points),wet:_wet}));
    }
    if(mode=="sync112roll" && ticks==20) {
        scrHMGameplayLane107();
        var _loops=GameCont.loops,_area=GameCont.area;
        for(var _kind=1;_kind<=2;++_kind) {
            var _seed=0;
            repeat(2000) {random_set_seed(_seed);var _r=random(1);if(_r>=(_kind-1)*.05 && _r<_kind*.05) break;_seed++;}
            var _boss=instance_create(player.x+120,player.y,BanditBoss);
            _boss.newintro=-1;
            var _roller=instance_create(0,0,CustomObject);
            random_set_seed(_seed);with(_roller) scrHMReplacementTick1102();
            var _replacement=noone;
            with(enemy) if(scrHMReplacementActor1102()) _replacement=id;
            if(_loops==0) scrHMGameplayCheck(instance_exists(_boss) && !instance_exists(_replacement),"Loop0 keeps normal boss in both probability slots");
            else {
                scrHMGameplayCheck(!instance_exists(_boss) && instance_exists(_replacement),"Loop1+ replaces the actual boss exactly once");
                scrHMGameplayCheck(_kind==1?_replacement.object_index==Last:_replacement.name=="GunGod","disjoint slots select Captain or final boss");
            }
            with(enemy) instance_destroy(id,false);instance_destroy(_roller,false);
        }
        for(var _case=0;_case<3;++_case) {
            GameCont.area=[scrHMAreaResolve("throne"),scrHMAreaResolve("venuz"),area_crib][_case];
            var _boss=instance_create(player.x+120,player.y,BanditBoss),_roller=instance_create(0,0,CustomObject);
            repeat(30) with(_roller) scrHMReplacementTick1102();
            scrHMGameplayCheck(!scrHMReplacementArea1102() && instance_exists(_boss),"Throne and Venus retain their own final encounter");
            scrHMGameplayCheck(!variable_instance_exists(_roller,"hm_gungod_rolled"),"excluded rooms never consume a replacement roll");
            instance_destroy(_boss,false);instance_destroy(_roller,false);
        }
        GameCont.area=_area;
    }
    if(mode=="sync112chief" && ticks==20) {
        scrHMGameplayLane107();
        UberCont.opt_bossintro=0;
        scrHMModSet("mod","options","intropan","1");scrHMModSet("mod","options","bossoutros","1");
        chief112=scrHMChiefCreate1102(player.x+120,player.y);
        chief_shots112=0;chief_exit112=false;chief_fx112=false;chief_portal112=false;
        scrHMGameplayCheck(chief112.drawspr==sprLastWarpIn && chief112.alarm[1]<0,"chief warps in before starting native attack timer");
    }
    if(mode=="sync112chief" && ticks>20 && ticks<500) {
        scrHMGameplayCheck(instance_exists(chief112),"chief survives normal native combat callbacks");
        chief_shots112=max(chief_shots112,instance_number(IDPDBullet)+instance_number(LastBall));
    }
    if(mode=="sync112chief" && ticks==160) {
        scrHMGameplayCheck(chief112.hm_chief_presented1102 && GameCont.hm_chief_seen,"first chief presentation is latched once per run");
        scrHMGameplayCheck(chief112[$ "hm_entry_camera1101"]??false,"native chief receives entrance camera");
        scrHMGameplayCheck(!instance_exists(LastDie),"native combat wrapper never creates ending objects");
    }
    if(mode=="sync112chief" && ticks>=450 && ticks<500) {
        // Loop3 population may append real extra bosses after lane setup.
        // They must be killed too; a living extra correctly blocks clearance.
        with(enemy) if(id!=other.chief112 && hp>0) scr_hit(id,hp+100,HitId.Player);
    }
    if(mode=="sync112chief" && ticks==500) {
        scrHMGameplayCheck(chief_shots112>0,"native Captain executes real projectile attacks");
        scrHMGameplayCheck(instance_number(enemy)==1,"all delayed non-target enemies have finished their real deaths before the Captain exit check");
        chief112.hp=5;
        var _shot=instance_create(chief112.x,chief112.y,Bullet1);
        _shot.damage=20;_shot.speed=0;_shot.team=team_player;_shot.hitid=HitId.Player;_shot.creator=player;
    }
    if(mode=="sync112chief" && ticks>500 && ticks<550) {
        with(CustomObject) if(name=="hm_chief_departure") {
            other.chief_fx112=true;
            if(self[$ "hm_exit_camera1101"]??false) other.chief_exit112=true;
        }
    }
    if(mode=="sync112chief" && ticks>500 && instance_exists(Portal)) chief_portal112=true;
    if(mode=="sync112chief" && ticks==620) {
        var _actors=[],_pending=[],_corpses=[];
        with(enemy) array_push(_actors,[object_get_name(object_index),self[$ "name"],hp]);
        with(becomenemy) array_push(_pending,object_get_name(object_index));
        with(Corpse) array_push(_corpses,[x,y,alarm[0],self[$ "hm_exit_corpse"]]);
        show_debug_message("SYNC112 CHIEF EXIT "+json_stringify({area:GameCont.area,sub:GameCont.subarea,portal_seen:chief_portal112,
            actors:_actors,pending:_pending,corpses:_corpses,boss_pending:scrHMPendingBoss()}));
        scrHMGameplayCheck(!instance_exists(chief112),"real player bullet kills native Captain");
        scrHMGameplayCheck(chief_fx112 && chief_exit112,"death produces the visual-only IDPD gate and outro camera");
        scrHMGameplayCheck(!instance_exists(LastDie) && !instance_exists(LastCutscene),"outside chief cannot trigger stock ending");
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active) && player.can_walk,"outro releases controls after the boss is deleted");
        scrHMGameplayCheck(chief_portal112,"real room-clear exit is generated separately from visual gate even if entered before final check");
    }
    if(mode=="sync112ball" && ticks==20) {
        scrHMGameplayLane107();
        for(var _loop=0;_loop<=3;++_loop) {
            with(IDPDBullet) instance_destroy(id,false);
            GameCont.loops=_loop;
            var _ball=instance_create(player.x+120,player.y,LastBall);
            _ball.hitid=HitId.Captain;_ball.creator=player;_ball.team=team_enemy;
            instance_destroy(_ball);
            scrHMGameplayCheck(instance_number(IDPDBullet)==80+8*_loop,"native ball retains eighty shots and adds one eight-shot beam per Loop");
            with(IDPDBullet) scrHMGameplayCheck(team==team_enemy,"extra ball shots preserve hostile team");
        }
    }
    if(mode=="sync112rocket" && ticks==20) {
        scrHMGameplayLane107();
        var _counts=[];
        for(var _loop=0;_loop<=3;++_loop) {
            with(JockRocket) instance_destroy(id,false);
            GameCont.loops=_loop;
            var _boss=hm_bosses_gungod_mod_gml_GunGod_create(player.x+120,player.y);
            with(_boss) {attacktype=1;attackpause=0;alarm1=100;alarm2=100;alarm3=100;}
            var _seed=0;
            repeat(1000) {
                random_set_seed(_seed);
                with(_boss) hm_bosses_gungod_mod_gml_GunGod_step();
                if(instance_number(JockRocket)>0) break;
                _seed++;
            }
            array_push(_counts,instance_number(JockRocket));
            scrHMGameplayCheck(_counts[_loop]>=1+_loop && _counts[_loop]<=4+_loop,"actual helicopter rocket burst retains random base and adds Loop count");
            instance_destroy(_boss,false);
        }
        show_debug_message("SYNC112 ROCKETS "+json_stringify(_counts));
    }
    if(mode=="sync112exit" && ticks==20) {
        with(WantPopo) instance_destroy(id,false);with(WantVan) instance_destroy(id,false);
        with(CustomObject) if(name=="hm_robot_gate"||name=="hm_infantry_gate") instance_destroy(id,false);
        portal112=noone;entered112=false;start112=GameCont.area;
    }
    if(mode=="sync112exit" && ticks>=20 && GameCont.area==start112 && !entered112) {
        // Native actors finish death from their hurt animation, not hp alone.
        // Clear combat and any revived wave through the normal hurt callback.
        if(ticks mod 10==0) with(enemy) if(hp>0) scr_hit(id,hp+100,HitId.Player);
        with(WantPopo) instance_destroy(id,false);with(WantVan) instance_destroy(id,false);
        with(IDPDSpawn) instance_destroy(id,false);
    }
    if(mode=="sync112exit" && ticks>=20 && GameCont.area==start112) {
        with(Rad) instance_destroy(id,false);
        GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0;
    }
    if(mode=="sync112exit" && ticks>=40 && GameCont.area==start112) {
        with(CustomEnemy) scrHMGameplayCheck(name!="portalblocker","6-3 has no invisible enemy sentinel");
        with(CustomHitme) if(name=="elevator") scrHMGameplayCheck(mask_index==mskNone,"elevator cannot collide with player");
        if(!instance_exists(portal112)) {
            with(CustomHitme) if(name=="elevator" && instance_exists(hm_elevator_exit)) other.portal112=hm_elevator_exit;
            if(instance_exists(portal112)) {
                scrHMGameplayCheck(portal112.type==2,"real elevator exit is host IDPD portal");
                scrHMGameplayCheck(hm_arkintide_mod_gml_hm_throne_clear(portal112.x,portal112.y,mskBandit),"actual exit has complete player floor");
                scrHMGameplayCheck(collision_circle(portal112.x,portal112.y,14,CustomHitme,false,true)==noone,"exit does not overlap elevator tubes");
                // This fixture validates the exit, not the intervening
                // mutation/crown selection awarded by clearing the whole map.
                GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0;
                entered112=true;player.x=portal112.x;player.y=portal112.y;player.speed=0;
            }
        }
    }
    if(mode=="sync112exit" && ticks mod 100==0) {
        var _doors=[],_actors=[],_elevators=[];
        with(Portal) array_push(_doors,[x,y,endgame,close,sprite_get_name(sprite_index),image_index,alarm[1]]);
        with(enemy) array_push(_actors,[object_get_name(object_index),self[$ "name"],hp,x,y]);
        with(CustomHitme) if(name=="elevator") array_push(_elevators,[x,y,hm_elevator_wait,hm_elevator_exit]);
        show_debug_message("SYNC112 EXIT "+json_stringify({tick:ticks,area:GameCont.area,sub:GameCont.subarea,entered:entered112,
            player:[player.x,player.y,player.visible,player.can_walk],doors:_doors,actors:_actors,elevators:_elevators}));
    }
    if(mode=="sync112exit" && ticks==goal_ticks-5) {
        scrHMGameplayCheck(entered112 && GameCont.area!=start112,"real 6-3 exit completes animation and reaches next area");
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("palace") && GameCont.subarea==1,"elevator reaches Palace 7-1");
    }
    if(mode=="sync112portrait" && ticks==20) {
        scrHMGameplayLane107();
        UberCont.opt_bossintro=1;GameCont.hm_chief_seen=false;
        var _first=scrHMChiefCreate1102(player.x+120,player.y);
        with(_first) {hm_chief_arrival1102=0;scrHMChiefStep1102();}
        scrHMGameplayCheck(UberCont.bossintro && UberCont.boss==8 && UberCont.paused,"first outside-HQ Captain invokes real native portrait even after Loop0");
        scrHMGameplayCheck(GameCont.hm_chief_seen,"first portrait is remembered in this run");
        // Dismiss the real portrait in this automated fixture; no input tool.
        UberCont.bossintro=false;UberCont.paused=false;UberCont.want_pause=false;UberCont.alarm[2]=-1;
        instance_destroy(_first,false);
        var _second=scrHMChiefCreate1102(player.x+120,player.y);
        with(_second) {hm_chief_arrival1102=0;scrHMChiefStep1102();}
        scrHMGameplayCheck(!UberCont.bossintro && !UberCont.paused,"later Captain does not repeat the once-per-run portrait");
        instance_destroy(_second,false);
        GameCont.hm_chief_seen=false;UberCont.opt_bossintro=0;
        var _disabled=scrHMChiefCreate1102(player.x+120,player.y);
        with(_disabled) {hm_chief_arrival1102=0;scrHMChiefStep1102();}
        scrHMGameplayCheck(!UberCont.bossintro && !UberCont.paused,"portrait preference remains respected");
        instance_destroy(_disabled,false);
    }
}
