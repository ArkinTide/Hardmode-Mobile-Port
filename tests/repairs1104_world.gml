// Dispatch sync114poison, sync114arrow, sync114gator, sync114poisonspawn.
// All cases run production native constructors, collision/alarm events and AI.
function scrHMGameplay1104World() {
    if(mode=="sync114poison" && ticks==20) {
        GameCont.area=scrHMAreaResolve("sewers");
        var _fixture=scrHMGameplayWaterFixture1103(false,0);
        with(enemy) instance_destroy(id,false);
        with(projectile) instance_destroy(id,false);
        player.x=16016;player.y=16016;
        var _frog=instance_create(16048,16016,Exploder);
        var _gas=instance_create(_frog.x,_frog.y,ToxicGas);
        repeat(5) with(_gas) with(_frog) event_perform_object(Exploder,ev_collision,ToxicGas);
        scrHMGameplayCheck(instance_exists(_frog) && _frog.object_index==Exploder && instance_number(SuperFrog)==0,
            "wet native frog cannot change into a poison frog through repeated real gas collisions");
        instance_destroy(_frog,false);instance_destroy(_gas,false);
        var _poison=instance_create(16080,16016,SuperFrog);
        repeat(30) with(_poison) event_perform_object(SuperFrog,ev_alarm,2);
        scrHMGameplayCheck(instance_number(EnemyBullet2)==30,"thirty real poison frog emissions remain projectiles");
        with(EnemyBullet2) {
            scrHMGameplayCheck(maggot==1 && hm_poison_no_maggot1104,
                "poison frog emissions are excluded before the MOD's next conversion pass");
            creator=noone;hitid=HitId.None;
            scrHMGameplayCheck(!hm_arkintide_mod_gml_hm_bullet_maggot_allowed(),
                "poison exclusion survives source death and another callback's hit-id replacement");
        }
        with(_poison) event_perform_object(SuperFrog,ev_destroy,0);
        scrHMGameplayCheck(instance_number(EnemyBullet2)==50,"native frog death adds exactly twenty ordinary poison projectiles");
        with(EnemyBullet2) scrHMGameplayCheck(maggot==1 && !hm_arkintide_mod_gml_hm_bullet_maggot_allowed(),
            "all emitted and death-ring poison projectiles reject maggot conversion");
        scrHMGameplayCheck(instance_number(RadMaggot)==0,"poison emission and death create no radiation maggots");
        with(enemy) instance_destroy(id,false);with(projectile) instance_destroy(id,false);
    }
    if(mode=="sync114poisonspawn" && ticks==20) {
        scrHMGameplayLane107();
        var _area=GameCont.area,_loop=GameCont.loops;
        var _floor=instance_nearest(player.x,player.y,Floor);
        var _regions=[2,3],_areas=[scrHMAreaResolve("sewers"),scrHMAreaResolve("junkyard")];
        for(var _r=0;_r<2;++_r) {
            GameCont.area=_areas[_r];GameCont.loops=1;
            with(enemy) instance_destroy(id,false);
            for(var _try=0;_try<300 && instance_number(SuperFrog)==0;++_try)
                with(_floor) hm_arkintide_mod_gml_hm_loop_population(_regions[_r]);
            scrHMGameplayCheck(instance_number(SuperFrog)>0,
                "real numbered Loop population can select the new native poison frog");
        }
        with(enemy) instance_destroy(id,false);
        GameCont.area=scrHMAreaResolve("oasis");GameCont.loops=1;
        for(var _try=0;_try<1024 && instance_number(SuperFrog)==0;++_try)
            with(_floor) hm_areas_oasis_area_gml_area_pop_enemies();
        scrHMGameplayCheck(instance_number(SuperFrog)>0,"real oasis population hook can create poison frogs after Loop0");
        with(enemy) instance_destroy(id,false);GameCont.loops=0;
        repeat(128) with(_floor) scrHMOasisPoisonSpawn1104();
        scrHMGameplayCheck(instance_number(SuperFrog)==0,"oasis poison addition leaves Loop0 unchanged");
        GameCont.area=_area;GameCont.loops=_loop;
    }
    if(mode=="sync114arrow" && ticks==20) {
        scrHMGameplayLane107();
        var _wall=instance_create(player.x+120,player.y,Wall);
        arrow114=instance_create(player.x+100,player.y,Bolt);
        arrow114.direction=0;arrow114.speed=6*timescale;
        var _arrow=arrow114;
        with(_wall) with(_arrow) event_perform_object(Bolt,ev_collision,Wall);
        scrHMGameplayCheck(arrow114.hm_bolt_wall1104 && arrow114.speed==0,
            "real Bolt wall collision records the native contact position and stops flight");
        arrow_x114=arrow114.x;arrow_y114=arrow114.y;
        with(arrow114) {x+=3;y+=2;motion_add(30,2);event_perform_object(Bolt,ev_step,ev_step_end);}
        scrHMGameplayCheck(arrow114.x==arrow_x114 && arrow114.y==arrow_y114 && arrow114.speed==0,
            "embedded bolt rejects a later displacement and impulse before rendering");
        with(player) scrEyesTelekinesis();
        scrHMGameplayCheck(arrow114.x==arrow_x114 && arrow114.y==arrow_y114,
            "Eyes telekinesis cannot push the embedded wall arrow");
        var _flying=instance_create(player.x+60,player.y-60,Bolt);
        _flying.speed=6*timescale;
        var _fx=_flying.x,_fy=_flying.y;
        with(player) scrEyesTelekinesis();
        scrHMGameplayCheck(_flying.x!=_fx || _flying.y!=_fy,
            "in-flight bolt keeps the native telekinesis displacement");
        instance_destroy(_flying,false);
    }
    if(mode=="sync114arrow" && ticks==25) {
        scrHMGameplayCheck(instance_exists(arrow114) && arrow114.x==arrow_x114 && arrow114.y==arrow_y114,
            "native wall bolt remains fixed across real physics ticks");
    }
    if(mode=="sync114arrow" && ticks==55) {
        scrHMGameplayCheck(!instance_exists(arrow114),"the original wall-bolt expiry still removes the pinned arrow");
    }
    if(mode=="sync114gator" && ticks==20) {
        scrHMGameplayLane107();with(projectile) instance_destroy(id,false);
        gator114=hm_bosses_gatorboss_mod_gml_gatorboss_create(player.x+120,player.y);
        gator114.time=10000;gator114.intro=-1;gator114.alrm2=0;
        var _near=instance_create(gator114.x+48,gator114.y,Bolt);
        _near.team=team_player;_near.direction=180;_near.speed=4*timescale;
        var _same=instance_create(gator114.x+48,gator114.y,EnemyBullet1);
        _same.team=gator114.team;
        repeat(1024) {
            var _far=instance_create(gator114.x+2000+random(400),gator114.y+random(400),EnemyBullet1);
            _far.team=team_player;_far.speed=0;
        }
        var _candidates=[];with(gator114) _candidates=scrHMGatorDodgeCandidates1104();
        scrHMGameplayCheck(array_contains(_candidates,_near),"near hostile projectile remains in predictive dodge candidates");
        scrHMGameplayCheck(!array_contains(_candidates,_same),"same-team projectile remains excluded from dodging");
        scrHMGameplayCheck(array_length(_candidates)==1,"1024 distant projectiles never reach the precise dodge loop");
        var _start=get_timer();repeat(30) with(gator114) scrHMGatorDodgeCandidates1104();var _local=get_timer()-_start;
        _start=get_timer();repeat(30) with(gator114) scrHMMatchingNE(projectile,"team",team);var _full=get_timer()-_start;
        show_debug_message("HARDMODE GATOR114 PROFILE "+json_stringify({local_us:_local,full_us:_full,projectiles:instance_number(projectile),candidates:array_length(_candidates)}));
        with(projectile) instance_destroy(id,false);
        with(gator114) {
            sprite_index=spr_idle;nexthurt=current_frame+10;
            hm_bosses_gatorboss_mod_gml_gatorboss_step();
            scrHMGameplayCheck(sprite_index==spr_hurt,"actual hurt AI enters the hurt sprite");
            image_index=1;
            hm_bosses_gatorboss_mod_gml_gatorboss_step();
            scrHMGameplayCheck(image_index==1,"continued hurt AI does not reset the sprite or replay its entry sound");
            var _floor=scrHMGatorFloor1104(),_cached=scrHMGatorFloor1104();
            scrHMGameplayCheck(_floor==_cached,"stationary Gator reuses its live nearest-floor result");
            x+=32;var _moved=scrHMGatorFloor1104();
            scrHMGameplayCheck(_moved==instance_nearest(x-16,y-16,Floor),"movement immediately refreshes the exact native floor result");
        }
    }
}
