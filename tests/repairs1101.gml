// These scenarios keep actual gameplay/Draw events running on a private desktop.
function scrHMGameplay1101() {
    if(ticks==15) {
        scrHMGameplayCheck(variable_instance_exists(GameCont,"hm_maxlevel1100"),"cap exists before any level-dependent world hook");
        scrHMGameplayCheck(scrHMLevelCap1101()==11,"safe cap reader preserves the boosted maximum");
    }
    if(mode=="sync111boot" && ticks==20) {
        repeat(4) {scrHMContentInit1100();hm_arkintide_mod_gml_hm_progression_start();}
        scrHMGameplayCheck(PLAYER_LEVEL_MAX==11,"repeated run initialization never stacks the level bonus");
        scrHMGameplaySave();
        scrHMGameplayCheck(PLAYER_LEVEL_MAX==11,"continue restores the level cap before resumed world tasks");
    }
    if(string_pos("sync111van",mode)==1 && ticks==20) {
        if(mode!="sync111vanmap") scrHMGameplayLane107();
        with(WantVan) instance_destroy(id,false);with(WantPopo) instance_destroy(id,false);
        with(VanSpawn) instance_destroy(id,false);with(Van) instance_destroy(id,false);
        with(IDPDSpawn) instance_destroy(id,false);
        van_seen1101=false;van_body1101=false;van_peak_gate1101=0;van_contact1101=false;van_hit1101=false;
        // Use the actual portal Alarm1 -> native Van -> MOD 3D conversion.
        van_gate1101=instance_create(player.x+140,player.y,VanSpawn);
        scrHMGameplayCheck(instance_exists(van_gate1101),"real vehicle arrival portal survives creation");
    }
    if(string_pos("sync111van",mode)==1 && ticks>20) {
        with(CustomObject) if(name=="3dvan") {
            other.van_seen1101=true;
            if(instance_exists(baby)) other.van_body1101=true;
            if(instance_exists(baby) && !other.van_hit1101) {
                var _body=baby,_hp=baby.hp,_sprite=baby.sprite_index,_mask=baby.mask_index;
                var _shot=instance_create(x,y,CustomProjectile);
                _shot.hitid=HitId.Player;
                with(_shot) scr_projectile_hit(_body,7,0,0);
                instance_destroy(_shot,false);
                scrHMGameplayCheck(_body.hp==_hp-7,"projectile damage delegates once without recursion");
                scr_hit(_body,3,HitId.None);
                scrHMGameplayCheck(_body.hp==_hp-10,"raw explosive/melee damage delegates once without recursion");
                scrHMGameplayCheck(_body.object_index==CustomHitme && !is_undefined(_body.on_hurt),"van body restores its collision class and hurt callback");
                scrHMGameplayCheck(_body.sprite_index==_sprite && _body.mask_index==_mask,"native damage preserves the custom vehicle sprite and mask");
                other.van_hit1101=true;
            }
            if(other.mode=="sync111vanmap" && instance_exists(baby) && !other.van_contact1101) {
                other.player.x=baby.x;other.player.y=baby.y;
                baby.canmelee=true;
                with(baby) hm_arkintide_mod_gml_hm_van_body_step();
                other.van_contact1101=true;
            }
            if(other.ticks==250 && GameCont.loops<3 && instance_exists(baby)) baby.hp=0;
        }
        var _gates=0;with(CustomObject) if(name=="hm_robot_gate") _gates++;
        van_peak_gate1101=max(van_peak_gate1101,_gates);
        scrHMGameplayCheck(_gates<=2,"one van does not repeatedly create robot gates");
    }
    if(string_pos("sync111van",mode)==1 && ticks==goal_ticks-5) {
        scrHMGameplayCheck(van_seen1101 && van_body1101,"vehicle completes portal, 3D body, driving and parked/death lifecycle");
        scrHMGameplayCheck(instance_number(VanSpawn)==0,"vehicle arrival portal completes its animation");
        show_debug_message("VAN111 OBSERVATION "+json_stringify({loop:GameCont.loops,seen:van_seen1101,body:van_body1101,gates:van_peak_gate1101}));
    }
    if(mode=="sync111camera" && ticks==20) {
        scrHMGameplayLane107();
        scrHMModSet("mod","options","intropan","1");
        scrHMModSet("mod","options","bossoutros","1");
        camera_boss1101=hm_bosses_gungod_mod_gml_GunGod_create(player.x+120,player.y);
    }
    if(mode=="sync111camera" && ticks==22) {
        scrHMGameplayCheck(camera_boss1101.image_alpha==0,"Gun God keeps its custom-renderer alpha contract");
        scrHMGameplayCheck(camera_boss1101[$ "hm_entry_camera1101"]??false,"natural off-world Gun God step requests entrance camera in a loop");
        camera_intro1101=HMWorld.hm_portrait_active;
        scrHMGameplayCheck(instance_exists(camera_intro1101) && camera_intro1101.hm_camera1101,"real presentation controller owns the camera");
        scrHMGameplayCheck(global.hm_camera_targets[player.index]==camera_intro1101,"player camera targets boss pan controller");
        scrHMGameplayCheck(!scrHMBossCamera1101(camera_boss1101,false),"entrance camera never repeats");
    }
    if(mode=="sync111camera" && ticks==110) {
        scrHMGameplayCheck(!instance_exists(camera_intro1101) && player.can_walk,"camera pan releases player controls");
        scrHMGameplayCheck(scrHMBossCamera1101(camera_boss1101,true),"off-world final boss requests exit pan");
        camera_outro1101=HMWorld.hm_portrait_active;
        instance_destroy(camera_boss1101,false);
    }
    if(mode=="sync111camera" && ticks==210) {
        scrHMGameplayCheck(!instance_exists(camera_outro1101) && player.can_walk,"exit camera survives actor destruction and restores controls");
        camera_yv1101=instance_create(player.x+120,player.y,YVBoss);
        scrHMGameplayCheck(scrHMBossCamera1101(camera_yv1101,false),"native Y.V receives an entrance camera");
    }
    if(mode=="sync111camera" && ticks==310) {
        instance_destroy(camera_yv1101);
        camera_yvout1101=HMWorld.hm_portrait_active;
        scrHMGameplayCheck(instance_exists(camera_yvout1101) && camera_yvout1101.hm_camera_exit1101,"native Y.V real Destroy event requests exit camera");
    }
    if(mode=="sync111camera" && ticks==410) {
        scrHMGameplayCheck(!instance_exists(camera_yvout1101) && player.can_walk,"Y.V exit pan releases the camera");
        var _extra=hm_arkintide_mod_gml_hm_extra_spawn("bandit",player.x+130,player.y);
        scrHMGameplayCheck(!scrHMBossCamera1101(_extra,false) && !scrHMBossCamera1101(_extra,true),"extra bosses receive neither camera pan");
        instance_destroy(_extra,false);
    }
    if(string_pos("sync111title",mode)==1 && ticks==20) {
        scrHMGameplayLane107();
        if(mode=="sync111titleenglish") {scrLanguageSet("English");UberCont.opt_language="English";}
        var _preview=instance_create(player.x,player.y-60,CustomObject);
        _preview.name="titlepreview1101";_preview.on_draw=scrHMGameplayTitlePreview1101;
        var _names=["CURSED HYPER CRYSTAL","TECHNOMANCER","LIL' HUNTER","THRONE II","GUNGOD"];
        for(var _i=0;_i<array_length(_names);++_i) for(var _w=80;_w<=160;_w+=40) {
            var _title=scrHMBossTitleLayout1101(_w,_names[_i]);
            scrHMGameplayCheck(_title.scale<=1 && _title.height<=10.001,"boss title fits a separate compact row");
            scrHMGameplayCheck(_title.width<=_w-3.999,"long localized title fits within its bar width");
            scrHMGameplayCheck(_title.height>=5,"title does not collapse to atlas-padding-sized text");
        }
    }
    if(mode=="sync111roll" && ticks==20) {
        scrHMGameplayLane107();
        var _original=instance_create(player.x+120,player.y,BanditBoss);
        _original.newintro=-1;_original.hp=100;_original.max_hp=100;
        var _roller=instance_create(0,0,CustomObject);
        // Find a seed whose first roll is inside the real five-percent range.
        var _seed=0;
        repeat(1000) {random_set_seed(_seed);if(random(1)<.05) break;_seed++;}
        random_set_seed(_seed);
        with(_roller) hm_arkintide_mod_gml_hm_gungod_replace_tick();
        var _boss=noone;with(CustomEnemy) if(name=="GunGod") _boss=id;
        if(GameCont.loops==0) {
            scrHMGameplayCheck(!instance_exists(_boss)&&instance_exists(_original),"Loop0 cannot replace the normal stage boss");
        } else {
            scrHMGameplayCheck(instance_exists(_boss)&&!instance_exists(_original),"Loop1 and later use the actual five-percent stage replacement");
        }
    }
    if(mode=="sync111phase" && ticks==20) {
        scrHMGameplayLane107();
        scrHMModSet("mod","options","intropan","1");
        scrHMModSet("mod","options","bossoutros","1");
        phase_hull1101=hm_bosses_gungod_mod_gml_GunGod_create(player.x+120,player.y);
    }
    if(mode=="sync111phase" && ticks==22)
        scrHMGameplayCheck(phase_hull1101[$ "hm_entry_camera1101"]??false,"actual final-boss first phase automatically pans in");
    if(mode=="sync111phase" && ticks==180) scr_hit(phase_hull1101,1000,HitId.Player);
    if(mode=="sync111phase" && ticks==400) {
        phase_actor1101=noone;
        with(CustomEnemy) if(name==(GameCont.loops>=3?"hm_yv_phase":"gungod")) other.phase_actor1101=id;
        scrHMGameplayCheck(instance_exists(phase_actor1101),"final boss naturally reaches the expected second phase");
        if(instance_exists(phase_actor1101)) {
            scrHMGameplayCheck(phase_actor1101.hp==150,"second phase inherits its original health");
            scrHMGameplayCheck(phase_actor1101[$ "hm_entry_camera1101"]??false,"actual second phase automatically receives entrance camera");
        }
    }
    if(mode=="sync111phase" && ticks==520) with(phase_actor1101) hp=0;
    if(mode=="sync111phase" && ticks==522) {
        scrHMGameplayCheck(!instance_exists(phase_actor1101),"actual final boss second phase dies normally");
        scrHMGameplayCheck(instance_exists(HMWorld.hm_portrait_active) && HMWorld.hm_portrait_active.hm_camera_exit1101,"second-phase death automatically pans out");
    }
    if(mode=="sync111phase" && ticks==620)
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active) && player.can_walk,"final boss death pan releases player control");
    if(mode=="sync111disabled" && ticks==20) {
        scrHMGameplayLane107();
        scrHMModSet("mod","options","intropan","0");scrHMModSet("mod","options","bossoutros","0");
        disabled_actor1101=hm_bosses_gungod_mod_gml_GunGod_create(player.x+120,player.y);
    }
    if(mode=="sync111disabled" && ticks==25) {
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active),"disabled intro setting suppresses automatic entrance camera");
        scrHMGameplayCheck(!scrHMBossCamera1101(disabled_actor1101,true),"disabled outro setting suppresses exit camera");
        disabled_actor1101.hm_extra=true;
        scrHMModSet("mod","options","intropan","1");scrHMModSet("mod","options","bossoutros","1");
        scrHMGameplayCheck(!scrHMBossCamera1101(disabled_actor1101,false) && !scrHMBossCamera1101(disabled_actor1101,true),"extra final boss receives neither camera when settings are enabled");
    }
}

function scrHMGameplayTitlePreview1101() {
    var _names=["CURSED HYPER CRYSTAL","TECHNOMANCER","THRONE II"];
    for(var _i=0;_i<3;++_i)
        hm_hm_bossbar_mod_gml_hm_bossbar(x,y+_i*48,100,_names[_i],c_red,60,100);
}
