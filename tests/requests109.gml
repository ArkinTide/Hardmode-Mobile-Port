function scrHMGameplayRequests109() {
    if(mode=="rats109" && ticks==10) {
        scrHMGameplayLane107();
        scrHMGameplayCheck(scrHMRatRevive109(),"rat revival defaults to enabled");
        scrHMRatToggle109();
        rat109=instance_create(player.x+64,player.y,Rat);
    }
    if(mode=="rats109" && ticks==14) {
        scrHMGameplayCheck((rat109[$ "infected"]??0)==0,"disabled rat has no borrowed revival health");
        with(rat109) scr_hit(id,1000,HitId.Player);
    }
    if(mode=="rats109" && ticks==22) {
        scrHMGameplayCheck(!instance_exists(FastRat),"actual rat death cannot revive when setting is off");
        scrHMRatToggle109();rat109=instance_create(player.x+64,player.y,Rat);
    }
    if(mode=="rats109" && ticks==26) {
        scrHMGameplayCheck(rat109.infected==1,"re-enabled setting restores original infected lifecycle");
        var _hp=rat109.hp;scrHMRatToggle109();
        scrHMGameplayCheck(rat109.hp==_hp-6,"turning off restores the living rat's underlying health");
        scrHMRatToggle109();
    }
    if(mode=="rats109" && ticks==30) {
        scrHMGameplayCheck(rat109.infected==1,"existing rats can be re-enabled without adding health repeatedly");
        with(rat109) scr_hit(id,1000,HitId.Player);
    }
    if(mode=="rats109" && ticks==40) {
        scrHMGameplayCheck(instance_exists(FastRat),"enabled rat death retains original green rat revival");
        var _saved=string_split(scrHMStringLoad("hardsave.txt"),"*");
        scrHMGameplayCheck(array_length(_saved)==9&&_saved[8]=="1","ninth field persists default-enabled rat revival");
        scrHMRatToggle109();_saved=string_split(scrHMStringLoad("hardsave.txt"),"*");
        scrHMGameplayCheck(_saved[8]=="0","disabled rat revival persists to disk");
    }
    if(mode=="rats109" && ticks==42) {
        scrHMStringSave("1*1*1*1*1*1*1*1","hardsave.txt");
        hm_options_mod_gml_basicload();
    }
    if(mode=="rats109" && ticks==47) {
        scrHMGameplayCheck(scrHMRatRevive109(),"old eight-field settings migrate to enabled revival");
        scrHMStringSave("1*1*1*1*1*1*1*1*0","hardsave.txt");
        hm_options_mod_gml_basicload();
    }
    if(mode=="rats109" && ticks==53) {
        scrHMGameplayCheck(!scrHMRatRevive109(),"real loader restores disabled ninth-field setting");
        scrHMRatToggle109();
    }
    if(mode=="requests109" && ticks==10) {
        scrHMGameplayLane107();
        var _cases=[[1,3,2],["nightdesert",1,3],["scorpionboss",1,4],
            ["sewers",3,7],["junkyard",4,11],["city",5,20],["elevator",1,23],
            ["palace",3,26],["palace",4,27],["throne",1,28]];
        for(var _i=0;_i<array_length(_cases);++_i) {
            var _c=_cases[_i],_position=scrHMRoutePosition109(scrHMAreaResolve(_c[0]),_c[1]);
            scrHMGameplayCheck(_position[0]==_c[2]&&_position[1]==0,"Hardmode progress maps real main-line stage "+string(_c[0])+"/"+string(_c[1]));
        }
        scrHMGameplayCheck(scrHMRoutePosition109(scrHMAreaResolve("venuz"),12,11)[0]==11,"Venus branch remains at its real main-line entrance");
        var _can=instance_create(player.x+48,player.y,RogueChest);
        var _n=instance_number(RadChest);with(_can) repeat(10)scrHMRogueCanisters109();
        scrHMGameplayCheck(instance_exists(_can)&&instance_number(RadChest)==_n+1,"Rogue retains strike canister and receives one rad canister without repeats");
        with(RadChest) scrHMGameplayCheck(!place_meeting(x,y,Wall),"additional Rogue canister is reachable off the walls");
        draw_align(fa_right,fa_middle);scrDrawInteractionHUD(player);
        scrHMGameplayCheck(draw_get_halign()==fa_right&&draw_get_valign()==fa_middle,"interaction text owns and restores draw alignment");
    }
    if(mode=="minigunner109" && ticks==10) {
        scrHMGameplayLane107();
        var _n=0;repeat(320) {var _g=scrHMLoopMinigunner109(player.x+64,player.y);if(instance_exists(_g)) {_n++;instance_destroy(_g,false);}}
        scrHMGameplayCheck(_n>0&&_n<40,"loop junkyard population includes pictured Minigunner with bounded weight");
        gunner109=hm_enemies_mod_gml_Minigunner_create(player.x+80,player.y);
        gunner109.gunangle=180;var _before=instance_number(EnemyBullet4);
        with(gunner109)scrHMMinigunnerShot109();
        scrHMGameplayCheck(instance_number(EnemyBullet4)==_before+1,"non-Venus Minigunner uses a native sniper bullet");
        with(EnemyBullet4)scrHMGameplayCheck(damage==3&&team==1&&image_alpha==1,"sniper round retains native damage, visibility and enemy team");
        with(gunner109) {alrm1=0;alrm2=1;activated=1;}
    }
    if(mode=="minigunner109" && ticks==100) {
        scrHMGameplayCheck(gunner109.firing==1,"real source firing continuation runs outside Venus");
        var _trail=0;with(Effect)if(name=="venuzpistoltrail")_trail++;
        scrHMGameplayCheck(_trail==0,"non-Venus actual firing uses no Venus hitscan trail");
    }
    if(mode=="venusyc109" && GameCont.area==scrHMAreaResolve("venuz") && GameCont.subarea==12 && ticks>500) {
        scrHMGameplayCheck(!instance_exists(YungVenuzCouch)&&!instance_exists(ChestOpen),"Y.C final boss remains free of prior lounge art");
        goal_ticks=ticks;
    }
}
