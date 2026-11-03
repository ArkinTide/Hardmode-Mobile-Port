// Targeted integration tests for native content on the mobile host.
function scrHMGameplaySync1100() {
    if(ticks==15) {
        scrHMGameplayCheck(PLAYER_LEVEL_MAX==11,"player boost increases level cap exactly once");
        scrHMContentBegin1100();
        scrHMGameplayCheck(PLAYER_LEVEL_MAX==11,"repeated initialization does not stack cap");
        scrHMGameplayCheck(!scrHMContentExists1100("mod","grillskills","draw_gui"),"mobile retains its built-in mutation selector");
        scrHMGameplayCheck(scrHMContentExists1100("mod","arkintide","hm_extra_spawn"),"native helper registry is available");
        scrHMGameplayCheck(scrHMContentExists1100("mod","maincode","venus_request_retry"),"new callbacks are registered");
    }
    if(mode=="syncpolicy" && ticks==20) {
        scrHMGameplayLane107();
        var _types=[Raven,SnowBot,DogGuardian,FastRat,LaserCrystal,LightningCrystal,InvLaserCrystal];
        var _base=[5,5,20,0,20,20,20],_before=[1,1,10,0,6,6,6];
        for(var _i=0;_i<array_length(_types);++_i) {
            var _e=instance_create(14300,14120,_types[_i]);
            _e.raddrop=_base[_i];
            with(_e) {
                scrHMRadiationSync(true);
                scrHMGameplayCheck(raddrop==_before[_i],"pre-cap native radiation policy "+object_get_name(object_index));
                raddrop+=3;scrHMRadiationSync(true);
                scrHMGameplayCheck(raddrop==_before[_i]+3,"repeat sync retains absorbed radiation");
                scrHMRadiationSync(false);
                scrHMGameplayCheck(raddrop==_base[_i]+3+(_i==3?4:0),"maximum restores original drop and preserves absorption");
            }
            instance_destroy(_e,false);
        }
        scrHMGameplayCheck(player.hm_hp_bonus==2,"boost applies the two HP bonus to a real player");
        var _maxhp=player.max_hp;
        with(player) repeat(3) hm_arkintide_mod_gml_hm_health_bonus();
        scrHMGameplayCheck(player.max_hp==_maxhp,"repeated progression does not stack HP");
        scrHMModSet("mod","options","playerboost","0");hm_arkintide_mod_gml_hm_progression_start();
        scrHMGameplayCheck(PLAYER_LEVEL_MAX==10,"disabled boost restores the ordinary cap for a new run");
        scrHMModSet("mod","options","playerboost","1");hm_arkintide_mod_gml_hm_progression_start();
        scrHMGameplayCheck(PLAYER_LEVEL_MAX==11,"re-enabling boost adds exactly one level");
        var _frog=instance_create(14300,14120,EnemyBullet1);_frog.hitid=HitId.SuperFrog;
        with(_frog) scrHMGameplayCheck(!hm_arkintide_mod_gml_hm_bullet_maggot_allowed(),"poison frog bullets cannot create rad maggots");
        instance_destroy(_frog,false);
    }
    if(string_pos("syncextra-",mode)==1 && ticks==20) {
        scrHMGameplayLane107();
        sync_kind1100=string_delete(mode,1,10);
        sync_shots1100=0;sync_start1100=[14256,14192];
        sync_actor1100=hm_arkintide_mod_gml_hm_extra_spawn(sync_kind1100,14256,14192);
        scrHMGameplayCheck(instance_exists(sync_actor1100),"extra boss spawns: "+sync_kind1100);
        scrHMGameplayCheck(sync_actor1100[$ "hm_extra"]==1,"extra boss has native policy marker");
        scrHMGameplayCheck(sync_actor1100.hp==sync_actor1100.max_hp,"extra boss begins alive at scaled maximum");
        scrHMGameplayCheck(!sync_actor1100.boss,"extra boss does not replace the stage boss");
    }
    if(string_pos("syncextra-",mode)==1 && ticks>20 && ticks<goal_ticks-35) {
        scrHMGameplayCheck(instance_exists(sync_actor1100),"extra boss survives active AI and its own attacks");
        // Turtles attack only in melee range; give their actual AI a target.
        if(sync_kind1100=="turtle") {player.x=sync_actor1100.x+36;player.y=sync_actor1100.y;player.speed=0;}
        sync_shots1100=max(sync_shots1100,instance_number(projectile)+instance_number(EnemySlash)+instance_number(Shank));
        if(ticks==goal_ticks-36) {
            show_debug_message("SYNC EXTRA OBSERVATION "+json_stringify({kind:sync_kind1100,shots:sync_shots1100,x:sync_actor1100.x,y:sync_actor1100.y,hp:sync_actor1100.hp}));
            if(sync_kind1100!="rat") scrHMGameplayCheck(sync_shots1100>0,"extra boss executes attacks");
        }
    }
    if(string_pos("syncextra-",mode)==1 && ticks==goal_ticks-34) {
        // Count this death's supplies before automatic pickup can collect them.
        with(AmmoPickup) instance_destroy(id,false);
        with(HPPickup) instance_destroy(id,false);
        player.x=14480;player.y=14340;player.speed=0;
        sync_drops1100=instance_number(AmmoPickup)+instance_number(HPPickup);
        with(player) for(var _i=0;_i<Ammo.NUM_AMMO_TYPES;++_i) ammo[_i]=0;
        with(sync_actor1100) {raddrop=10;hp=0;}
    }
    if(string_pos("syncextra-",mode)==1 && ticks==goal_ticks-30) {
        scrHMGameplayCheck(!instance_exists(sync_actor1100),"extra boss completes real death");
        scrHMGameplayCheck(instance_number(AmmoPickup)+instance_number(HPPickup)>sync_drops1100,"extra boss drops supplies");
        if(sync_kind1100=="tech") {
            var _corpse=noone;with(Corpse) if(sprite_index==sprTechnoMancerDead) _corpse=id;
            scrHMGameplayCheck(instance_exists(_corpse)&&_corpse.hm_no_revive109,"extra Technomancer corpse cannot be revived");
        }
    }
    if(mode=="syncsettings" && ticks==30) {
        scrHMGameplaySave();
        scrHMGameplayCheck(PLAYER_LEVEL_MAX==11 && player.hm_hp_bonus==2,"disk continue preserves cap and HP bonus marker");
        scrHMGameplayCheck(scrHMModGet("mod","options","bossbars")=="1","bossbars survive settings serialization");
    }
    if(mode=="syncthrone" && ticks==30) {
        scrHMGameplayCheck(instance_number(NothingInactive)==1,"double hall creates exactly one initial throne");
        var _left=1000000000,_right=-1000000000,_top=1000000000,_bottom=-1000000000;
        with(Floor) {_left=min(_left,x);_right=max(_right,x+32);_top=min(_top,y);_bottom=max(_bottom,y+32);}
        var _axis=(_left+_right)/2,_boss=instance_find(NothingInactive,0);
        var _generators=[];with(BigGenerator) array_push(_generators,[x,y]);
        show_debug_message("SYNC THRONE GEOMETRY "+json_stringify({left:_left,right:_right,top:_top,bottom:_bottom,player:[player.x,player.y],boss:[_boss.x,_boss.y],generators:_generators}));
        scrHMGameplayCheck(abs(player.x-_axis)<1 && abs(_boss.x-_axis)<1,"player and throne share actual hall centerline");
        scrHMGameplayCheck(player.y>_bottom-80 && _boss.y<_top+256,"player is at hall bottom and boss at top with its full collision footprint");
        scrHMGameplayCheck(_bottom-_top>1000,"hall has doubled authored length");
        var _bad=0;with(BigGenerator) if(y>(_top+_bottom)/2) _bad++;
        scrHMGameplayCheck(!_bad && instance_number(BigGenerator)>=4,"complete generator annexes remain on the throne side");
        with(player) scrHMGameplayCheck(!place_meeting(x,y,Wall),"player spawn is unobstructed");
        with(_boss) scrHMGameplayCheck(!place_meeting(x,y,Wall),"throne spawn is unobstructed");
    }
    if(mode=="syncportal" && ticks==20) {
        scrHMGameplayLane107();
        var _portal=instance_create(player.x+100,player.y,Portal);_portal.type=2;_portal.close=true;
        scrHMPortalStyle1100(_portal);instance_destroy(_portal,false);
        var _spiral=instance_create(0,0,SpiralCont);
        scrHMGameplayCheck(_spiral.type==SpiralType.IDPD,"police transition uses IDPD type before prewarm");
        var _wrong=0;with(Spiral) if(sprite_index!=sprSpiralIDPD&&sprite_index!=sprSpiralIDPD2) _wrong++;
        scrHMGameplayCheck(instance_number(Spiral)>0 && !_wrong,"all prewarmed rings are blue IDPD from the first frame");
    }
    if(mode=="syncwarning" && ticks==20) {
        scrHMGameplayLane107();
        with(WantVan) instance_destroy(id,false);with(WantPopo) instance_destroy(id,false);
        with(VanSpawn) instance_destroy(id,false);with(Van) instance_destroy(id,false);
        with(IDPDSpawn) instance_destroy(id,false);
        sync_gate1100=hm_arkintide_mod_gml_hm_spawn_warning(player.x+160,player.y,1,180);
        scrHMGameplayCheck(instance_exists(sync_gate1100),"robot warning uses an independent portal controller");
        sync_tank_tick1100=-1;sync_van_tick1100=-1;sync_charge_frames1100=[];sync_fx1100=0;
    }
    if(mode=="syncwarning" && ticks>20 && ticks<160) {
        sync_fx1100=max(sync_fx1100,instance_number(IDPDPortalCharge));
        if(instance_exists(sync_gate1100) && sync_gate1100.hm_phase==1) {
            var _frame=floor((45-sync_gate1100.hm_wait)/2.5) mod sprite_get_number(sprVanPortalStart);
            if(!array_contains(sync_charge_frames1100,_frame)) array_push(sync_charge_frames1100,_frame);
        }
        var _tanks=0;with(CustomEnemy) if(name=="IDPDTank") _tanks++;
        if(_tanks>0 && sync_tank_tick1100<0) sync_tank_tick1100=ticks;
        if(instance_exists(Van) && sync_van_tick1100<0) {
            sync_van_tick1100=ticks;
            // Stop this comparison vehicle before its independent parked-van
            // AI legitimately requests another robot arrival.
            with(Van) instance_destroy(id,false);
            with(CustomObject) if(name=="3dvan") {if(instance_exists(baby)) instance_destroy(baby,false);instance_destroy(id,false);}
        }
        scrHMGameplayCheck(_tanks<=1,"one robot gate never duplicates its robot");
    }
    if(mode=="syncwarning" && ticks==160) {
        show_debug_message("SYNC WARNING "+json_stringify({tank:sync_tank_tick1100,van:sync_van_tick1100,charge_frames:sync_charge_frames1100,particles:sync_fx1100}));
        var _emission=sprite_get_number(sprVanPortalStart)*2.5+45+12;
        scrHMGameplayCheck(abs(sync_tank_tick1100-20-_emission)<=2,"robot emerges twelve logical ticks into the native portal close animation");
        scrHMGameplayCheck(array_length(sync_charge_frames1100)>1 && sync_fx1100>0,"warning charge actually animates and emits particles");
        scrHMGameplayCheck(!instance_exists(sync_gate1100) && instance_number(VanSpawn)==0,"finished gates leave no recurring vehicle portals");
    }
    if(mode=="syncwater" && ticks==20) {
        scrHMGameplayLane107();var _walls=instance_number(Wall),_wet=0;
        scrHMGameplayCheck(hm_arkintide_mod_gml_hm_extra_water_prepare(14256,14192),"a fitting sewer pool is created on real complete floor tiles");
        with(Floor) if(self[$ "hm_rat_water_pool"]??false) {
            _wet++;scrHMGameplayCheck(instance_exists(hm_water_surface)&&hm_water_surface==hm_water_surface111,"forced pool uses both native and mobile water links");
        }
        scrHMGameplayCheck(_wet>0 && instance_number(Wall)==_walls,"pool creates visible water without deleting terrain");
        sync_rat1100=hm_arkintide_mod_gml_hm_extra_spawn("rat",14256,14192);
        scrHMGameplayCheck(instance_exists(sync_rat1100)&&sync_rat1100.team!=team_player,"rat spawns in its prepared mask-fitting pool");
    }
    if(mode=="syncwater" && ticks==60) {
        scrHMGameplayCheck(sync_rat1100.swimming && sync_rat1100.image_alpha==0,"actual sewer simulation submerges the rat with its dedicated renderer");
        var _hp=sync_rat1100.hp;scr_hit(sync_rat1100,1,HitId.Player);
        scrHMGameplayCheck(sync_rat1100.hp<_hp,"sewer rat is damageable outside Venus");
        var _tentacles=0;with(CustomEnemy) if(string_pos("tentacle",string_lower(name))>0) _tentacles++;
        scrHMGameplayCheck(!_tentacles,"off-world rat never creates tentacles");
    }
    if(mode=="syncgungod" && ticks==20) {
        scrHMGameplayLane107();
        sync_gungod1100=hm_bosses_gungod_mod_gml_GunGod_create(14256,14192);
        scrHMGameplayCheck(instance_exists(sync_gungod1100)&&sync_gungod1100.hp==15000,"off-world Gun God begins alive");
        scrHMGameplayCheck(!sync_gungod1100.canfly,"off-world Gun God cannot pass through walls");
    }
    if(mode=="syncgungod" && ticks==180) {
        scrHMGameplayCheck(instance_exists(sync_gungod1100)&&sync_gungod1100.hp==15000,"Gun God survives its own attacks");
        scr_hit(sync_gungod1100,1000,HitId.Player);
    }
    if(mode=="syncgungod" && ticks==400) {
        var _phase=noone;with(CustomEnemy) if(name=="hm_yv_phase") _phase=id;
        scrHMGameplayCheck(instance_exists(_phase),"loop-three final boss replaces phase two with YV");
        scrHMGameplayCheck(_phase.hp>0 && !_phase.canfly,"YV phase is alive and respects terrain outside Venus");
        sync_phase1100=_phase;
    }
    if(mode=="syncgungod" && ticks==520) with(sync_phase1100) hp=0;
    if(mode=="syncgungod" && ticks==560) scrHMGameplayCheck(!instance_exists(sync_phase1100),"YV phase completes death and loot");
}
