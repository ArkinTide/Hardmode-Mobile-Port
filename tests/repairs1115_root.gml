// These fixtures call actual constructors, damage/drop and portal events.
function scrHMGameplayRoot1115() {
    if(mode=="sync115stagebandit" && ticks==20) {
        scrHMGameplayLane107();
        var _area=GameCont.area,_sub=GameCont.subarea,_loop=GameCont.loops;
        GameCont.area=scrHMAreaResolve(1);GameCont.subarea=3;
        for(var _l=0;_l<4;++_l) {
            GameCont.loops=_l;var _jungle=0,_plain=0;
            for(var _seed=0;_seed<32;++_seed) {
                var _boss=instance_create(player.x+120,player.y,BanditBoss);
                _boss.newintro=-1;
                random_set_seed(_seed);var _expected=random(1)<.5;
                random_set_seed(_seed);repeat(4) hm_arkintide_mod_gml_hm_stage_bandit_tick();
                if(_l==0) {
                    scrHMGameplayCheck(!variable_instance_exists(_boss,"hm_stage_bandit_rolled"),
                        "Loop0 keeps the original stage Bandit without a replacement roll");
                } else {
                    scrHMGameplayCheck(_boss.hm_stage_jungle==_expected,
                        "from Loop1 the real 1-3 stage tick uses one exact fifty-percent Jungle Bandit roll");
                    if(_expected) {
                        _jungle++;var _drawer=noone;
                        with(CustomObject) if(name=="hm_stage_bandit_drawer" && creator==_boss) {_drawer=id;break;}
                        scrHMGameplayCheck(instance_exists(_drawer) && !is_undefined(_drawer.on_draw),
                            "selected Jungle Bandit retains the production sprite drawer");
                    } else _plain++;
                }
                instance_destroy(_boss,false);
                with(CustomObject) if(name=="hm_stage_bandit_drawer") instance_destroy(id,false);
            }
            if(_l>0) scrHMGameplayCheck(_jungle>0 && _plain>0,"the unchanged RNG can choose either normal stage boss skin");
        }
        GameCont.area=_area;GameCont.subarea=_sub;GameCont.loops=_loop;
    }
    if(string_pos("sync115replacement",mode)==1 && ticks==20) {
        scrHMGameplayLane107();UberCont.opt_bossintro=0;
        scrHMModSet("mod","options","intropan","0");scrHMModSet("mod","options","bossoutros","0");
        var _chief=mode=="sync115replacementchief";
        var _original=instance_create(player.x+120,player.y,BanditBoss);
        _original.newintro=-1;scrHMBossGroupRegister115(_original);
        var _retired=scrHMBossGroupReserve115("bandit");
        var _normal=hm_bosses_gungod_mod_gml_GunGod_create(player.x+160,player.y);
        var _budget=_normal.max_hp-14250;instance_destroy(_normal,false);
        var _seed=0;
        repeat(10000) {
            random_set_seed(_seed);var _roll=random(1);
            if((_chief && _roll<.05) || (!_chief && _roll>=.05 && _roll<.10)) break;
            _seed++;
        }
        var _roller=instance_create(0,0,CustomObject);
        random_set_seed(_seed);with(_roller) scrHMReplacementTick1102();
        scrHMGameplayCheck(_roller.hm_gungod_replaced && !instance_exists(_original),
            "real replacement roller constructs the selected boss and retires the original encounter");
        var _replacement=noone;
        with(enemy) if(scrHMReplacementActor1102()) {_replacement=id;break;}
        scrHMGameplayCheck(instance_exists(_replacement),"replacement tick leaves a real active final-boss actor");
        scrHMGameplayCheck(_retired.exit_count==0 && !_retired.observed,
            "deleting the replaced normal boss retires its ledger without a false victory presentation");
        if(_chief) {
            scrHMGameplayCheck(_replacement.object_index==Last && _replacement.name=="hm_chief",
                "replacement slot always uses the Captain teleport-entry factory");
        } else {
            scrHMGameplayCheck(abs((_replacement.max_hp-14250)-_budget*1.5)<.001,
                "real replacement tick gives exactly fifty percent more combat health and preserves the phase sentinel");
        }
        instance_destroy(_roller,false);with(enemy) instance_destroy(id,false);
    }
    if(mode=="sync115phasehealth" && ticks==20) {
        scrHMGameplayLane107();UberCont.opt_bossintro=0;
        scrHMModSet("mod","options","intropan","0");
        var _loop=GameCont.loops;
        for(var _l=0;_l<4;++_l) {
            GameCont.loops=_l;
            var _phase=hm_enemies_mod_gml_enemyyv_create(player.x+160,player.y);
            if(_l==0) {
                scrHMGameplayCheck(_phase.name=="gungod","Loop0 retains the authored grounded second phase");
            } else {
                var _native=instance_create(player.x+220,player.y,YVBoss);
                with(_native) scrHMBossHealth1103();
                scrHMGameplayCheck(_phase.name=="hm_yv_phase","Y.V replaces phase two from Loop1");
                scrHMGameplayCheck(abs(_phase.hp-_native.hp)<.001 && abs(_phase.max_hp-_native.max_hp)<.001,
                    "phase two uses Y.V's own current-Loop native health and mutation scaling");
                var _hp=_phase.max_hp;
                with(_phase) {repeat(4) {hm_arkintide_mod_gml_hm_yv_phase_bind();scrHMBossHealth1103();}}
                scrHMGameplayCheck(abs(_phase.max_hp-_hp)<.001,"repeated phase event binding never rescales Y.V health");
                show_debug_message("HARDMODE YV115 HEALTH "+json_stringify({loop:_l,hp:_phase.hp,native:_native.hp}));
                instance_destroy(_native,false);
            }
            instance_destroy(_phase,false);
        }
        GameCont.loops=_loop;
        var _normal=hm_bosses_gungod_mod_gml_GunGod_create(player.x+100,player.y);
        var _replacement=hm_bosses_gungod_mod_gml_GunGod_create(player.x+160,player.y);
        var _combat=_normal.max_hp-14250;
        with(_replacement) repeat(4) scrHMReplacementGunGodHealth1115();
        scrHMGameplayCheck(abs((_replacement.max_hp-14250)-_combat*1.5)<.001,
            "replacement helicopter damageable health is exactly fifty percent above the same-Loop original");
        scrHMGameplayCheck(_normal.max_hp==14250+_combat,"ordinary Venus encounter is not changed by replacement health");
        _replacement.hp=14250+1;
        with(_replacement) hm_bosses_gungod_mod_gml_GunGod_hurt(2);
        scrHMGameplayCheck(_replacement.hm_gungod_departed==1 && _replacement.hp==14250,
            "replacement's phase sentinel still performs the real nonlethal handoff");
        with(enemy) instance_destroy(id,false);
    }
    if(mode=="sync115supplies" && ticks==20) {
        scrHMGameplayLane107();UberCont.opt_bossintro=0;
        scrHMModSet("mod","options","intropan","0");scrHMModSet("mod","options","bossoutros","0");
        with(Rad) instance_destroy(id,false);with(BigRad) instance_destroy(id,false);
        var _chief=scrHMChiefCreate1102(player.x+120,player.y);
        var _yv=hm_enemies_mod_gml_enemyyv_create(player.x+160,player.y);
        var _hull=hm_bosses_gungod_mod_gml_GunGod_create(player.x+200,player.y);
        var _targets=[_chief,_yv,_hull];
        for(var _i=0;_i<array_length(_targets);++_i) with(_targets[_i]) {
            scrRadDrop(x,y,100);
            scrRadDrop(x,y,1,false,false);
        }
        scrHMGameplayCheck(instance_number(Rad)==0 && instance_number(BigRad)==0,
            "Captain and both Venus phases suppress all radiation, including the added Melting point");
        var _before=instance_number(AmmoPickup)+instance_number(HPPickup);
        with(_chief) {scrHMChiefDeath1102();scrHMChiefDeath1102();}
        scrHMGameplayCheck(instance_number(AmmoPickup)+instance_number(HPPickup)==_before+3,
            "Captain final death creates exactly three supplies even if death is requested twice");
        _before=instance_number(AmmoPickup)+instance_number(HPPickup);
        with(_yv) repeat(2) {
            if(name=="hm_yv_phase") hm_arkintide_mod_gml_hm_yv_phase_loot();
            else hm_enemies_mod_gml_yv_dead();
        }
        scrHMGameplayCheck(instance_number(AmmoPickup)+instance_number(HPPickup)==_before+3,
            "Venus final death grants three independent supplies and the reward lock prevents duplicates");
        var _native=instance_create(player.x+260,player.y,Bandit);
        with(_native) scrRadDrop(x,y,1,false,false);
        scrHMGameplayCheck(instance_number(Rad)==1,"ordinary enemies retain their radiation drops");
        with(enemy) instance_destroy(id,false);
    }
    if(mode=="sync115idpdgate" && ticks==20) {
        scrHMGameplayLane107();with(IDPDSpawn) instance_destroy(id,false);
        gate115=instance_create(player.x+120,player.y,IDPDSpawn);
        scrHMGameplayCheck(gate115.object_index==IDPDSpawn && gate115.visible,
            "mobile arrival retains the native portal identity and renderer");
        gate115.alarm[0]=1;gate115elite=gate115.elite;
        gate115before=instance_number(enemy);gate115arrived=false;
    }
    if(mode=="sync115idpdgate" && ticks>=22 && ticks<34) {
        scrHMGameplayCheck(instance_exists(gate115) && gate115.visible,
            "visible native close animation persists until its unit spawn deadline");
    }
    if(mode=="sync115idpdgate" && ticks==36) {
        var _new=0;
        with(enemy) if((self[$ "hm_arrival_gate1115"]??noone)==other.gate115) _new++;
        scrHMGameplayCheck(_new>=1 && _new<=5,"native portal produces between one and five units exactly once");
        var _kind=gate115.hm_spawn_kind1115;
        scrHMGameplayCheck(_new==gate115.hm_spawn_count1115,"portal's actual living arrivals match its one batch before normal AI conversion");
        if(_kind!=Grunt) scrHMGameplayCheck(_new==1,"every non-infantry kind exits its portal alone");
        gate115arrived=true;gate115count=_new;
    }
    if(mode=="sync115idpdgate" && ticks==75) {
        scrHMGameplayCheck(gate115arrived && !instance_exists(gate115),"native arrival gate eventually closes and releases itself");
        var _arrivals=0;
        with(enemy) if((self[$ "hm_arrival_gate1115"]??noone)==other.gate115) _arrivals++;
        scrHMGameplayCheck(_arrivals<=gate115count,"finished portal cannot repeatedly spawn more police");
    }
    if(mode=="sync115throne" && ticks==1) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("throne") && player.sprite_angle==0,
            "real native Player.Create initializes ending rotation before the Throne logic reads it");
        scrHMGameplayCheck(!GameCont.underwater && !(player[$ "swimming"]??false),
            "naturally generated Throne is never an underwater room");
        UberCont.opt_bossintro=0;scrHMModSet("mod","options","intropan","0");
        scrHMModSet("mod","options","bossoutros","0");
    }
    if(mode=="sync115throne" && ticks==20) {
        var _sleep=instance_find(NothingInactive,0);
        scrHMGameplayCheck(instance_exists(_sleep),"authored arena provides its real sleeping Throne");
        with(_sleep) {active=true;hp=0;event_perform_object(NothingInactive,ev_step,ev_step_normal);}
        with(BecomeNothing) {
            sprite_index=sprNothingActivate;drawimg=sprite_get_number(sprite_index);
            event_perform_object(BecomeNothing,ev_step,ev_step_normal);
        }
    }
    if(mode=="sync115throne" && ticks==25) {
        scrHMGameplayCheck(instance_exists(Nothing),"native wake reaches the real first phase");
        with(Nothing) {hp=0;instance_destroy();}
    }
    if(mode=="sync115throne" && ticks==160) {
        throne_second115=noone;
        with(CustomEnemy) if(spr_idle==sprNothing2Idle) other.throne_second115=id;
        scrHMGameplayCheck(instance_exists(throne_second115),"native first-phase death naturally reaches custom ThroneII");
        var _floor=noone;
        with(Floor) if(collision_point(x+16,y+16,Wall,false,true)==noone) {_floor=id;break;}
        scrHMGameplayCheck(instance_exists(_floor),"live ThroneII arena still has usable platform floor");
        player.x=_floor.x+16;player.y=_floor.y+16;player.fallenable=-1;
        with(player) scrHMThronePlayerGround1115();
        throne_safe115=[player.x,player.y];
        player.x=18000;with(player) scrHMThronePlayerGround1115();
        scrHMGameplayCheck(player.x==throne_safe115[0] && player.y==throne_safe115[1],
            "live ThroneII platform rejects a horizontal step onto floorless void");
        player.y=18000;with(player) scrHMThronePlayerGround1115();
        scrHMGameplayCheck(player.x==throne_safe115[0] && player.y==throne_safe115[1],
            "live ThroneII platform rejects a vertical step onto floorless void");
        // Exercise the actual post-death setup, without the old fixture's
        // manual sprite_angle=0 that hid the uninitialized-field crash.
        player.sprite_angle=undefined;player.fallenable=-1;
        throne_second115.hp=0;
    }
    if(mode=="sync115throne" && ticks==166) {
        scrHMGameplayCheck(!instance_exists(throne_second115) && instance_exists(Nothing2Death),
            "real second-phase death creates its authored final death controller");
        scrHMGameplayCheck(player.fallenable==1 && !is_undefined(player.sprite_angle),
            "actual death setup initializes ending rotation and enables the authored fall");
        player.x=18000;player.y=18000;player.speed=0;
        throne_fall_y115=player.y;throne_fall_angle115=player.sprite_angle;
        with(player) scrHMThronePlayerGround1115();
        scrHMGameplayCheck(player.x==18000 && player.y==18000,"post-death platform guard releases the native ending descent");
    }
    if(mode=="sync115throne" && ticks==181) {
        scrHMGameplayCheck(player.y>=throne_fall_y115+80 && player.sprite_angle>throne_fall_angle115,
            "real ending advances its rotating eight-pixel-per-tick descent at either render rate");
        scrHMGameplayCheck(player.image_alpha==1 && player.scale==1 && player.spr_shadow_y==10000,
            "desktop-style fall keeps the body visible and full size while hiding its floor shadow");
        show_debug_message("HARDMODE THRONE115 FALL "+json_stringify({rate:rate,dy:player.y-throne_fall_y115,
            rotation:player.sprite_angle-throne_fall_angle115,scale:player.scale,alpha:player.image_alpha}));
    }
    if(mode=="sync115policy" && ticks==20) {
        scrHMGameplayLane107();
        var _area=GameCont.area,_sub=GameCont.subarea,_loop=GameCont.loops;
        var _areas=[scrHMAreaResolve("throne"),scrHMAreaResolve("HQ")];
        var _subs=[1,5];
        for(var _i=0;_i<array_length(_areas);++_i) {
            GameCont.area=_areas[_i];GameCont.subarea=_subs[_i];GameCont.loops=10;
            random_set_seed(71150+_i);var _next=random(1);random_set_seed(71150+_i);
            repeat(20) scrHMExtraPopulation1103();
            scrHMGameplayCheck(instance_number(enemy)==0 && random(1)==_next,
                "Throne and HQ-5 extra population exit before spawning or consuming RNG");
        }
        GameCont.area=scrHMAreaResolve("palace");GameCont.loops=1;
        scrHMGameplayCheck(scrHMLoopEnemyStart1115()==1,"ordinary regions begin the moved enemy additions at Loop1");
        GameCont.area=scrHMAreaResolve("HQ");
        scrHMGameplayCheck(scrHMLoopEnemyStart1115()==3,"HQ police/freak additions retain the Loop3 threshold");
        GameCont.area=_area;GameCont.subarea=_sub;GameCont.loops=_loop;
    }
}
