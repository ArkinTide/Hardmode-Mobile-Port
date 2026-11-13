// Real-host fixtures for Report17 and Followup18. Include this script in the
// gameplay fixture and invoke scrHMGameplay1103Bosses() from its logic step.
function scrHMGameplay1103Bosses() {
    if(mode=="sync113bosshealth" && ticks==20) {
        scrHMGameplayLane107();UberCont.opt_bossintro=0;
        var _loops=GameCont.loops;
        for(var _loop=0;_loop<=1;++_loop) {
            GameCont.loops=_loop;
            hm_bosses_ravenboss_mod_gml_ravenboss_create(player.x+140,player.y);
            var _bird=noone;with(CustomEnemy) if(name=="BIG BIRD") {_bird=id;break;}
            scrHMGameplayCheck(instance_exists(_bird),"real asynchronous Bird constructor creates its native MOD actor immediately");
            var _birdbase=round(150*(1+_loop/20));
            scrHMGameplayCheck(abs(_bird.max_hp-_birdbase*(_loop>0?1.3:1))<.001,"normal Bird has 150 baseline before native scaling and one L1 bonus");
            scrHMGameplayCheck(_bird.hp==_bird.max_hp,"Bird starts at its complete scaled health budget");
            var _gator=hm_bosses_gatorboss_mod_gml_gatorboss_create(player.x+100,player.y);
            var _base=round(120*(1+_loop/20));
            scrHMGameplayCheck(abs(_gator.max_hp-_base*(_loop>0?1.3:1))<.001,"normal Gator retains 120 baseline and receives native scaling then one L1 bonus");
            var _before=_gator.max_hp;with(_gator) repeat(4) scrHMBossHealth1103();
            scrHMGameplayCheck(_gator.max_hp==_before,"ordinary boss L1 bonus is latched once");
            var _messenger=hm_enemies_mod_gml_enemyrogue_create(player.x+120,player.y);
            var _roguebase=round((50+30*instance_number(Player)*_loop)*(1+_loop/20));
            scrHMGameplayCheck(abs(_messenger.max_hp-_roguebase*(_loop>0?1.3:1))<.001,"Messenger 50 baseline preserves full constructor scaling");
            var _god=hm_bosses_gungod_mod_gml_GunGod_create(player.x+160,player.y);
            scrHMGameplayCheck(abs(_god.max_hp-(14250+750*(_loop>0?1.3:1)))<.001,"helicopter bonus does not multiply the phase sentinel");
            with(_god) repeat(4) scrHMGunGodHealth1103();
            scrHMGameplayCheck(abs(_god.max_hp-(14250+750*(_loop>0?1.3:1)))<.001,"sentinel health bonus is latched once");
            var _native=instance_create(player.x+200,player.y,BanditBoss),_nativebase=_native.max_hp;
            _native.newintro=0;scrHMNativeBossHealth1103();
            scrHMGameplayCheck(_native.max_hp==_nativebase && !(_native[$ "hm_report_boss_health_done1103"]??false),"native boss keeps its initial health while Hardmode first-sight setup is pending");
            _native.max_hp+=50;_native.hp=_native.max_hp;_nativebase=_native.max_hp;_native.newintro=-1;
            repeat(4) scrHMNativeBossHealth1103();
            scrHMGameplayCheck(abs(_native.max_hp-_nativebase*(_loop>0?1.3:1))<.001,"completed native boss setup receives one bonus after its additive MOD budget");
            with(enemy) instance_destroy(id,false);
            with(IDPDSpawn) instance_destroy(id,false);
        }
        GameCont.loops=3;
        var _extra=instance_create(player.x+120,player.y,CustomEnemy);
        with(_extra) {hm_extra=true;max_hp=345;hp=200;scrHMBossHealth1103();}
        scrHMGameplayCheck(_extra.max_hp==345 && _extra.hp==200,"additional boss keeps its separate five-percent health and current damage");
        instance_destroy(_extra,false);
        var _phase=hm_enemies_mod_gml_enemyyv_create(player.x+140,player.y);
        var _yv=instance_create(player.x+180,player.y,YVBoss);
        with(_yv) scrHMBossHealth1103();
        var _phasehealth=_yv.max_hp;
        scrHMGameplayCheck(_phase.name=="hm_yv_phase" && _phase.hp==_phasehealth && _phase.max_hp==_phasehealth,"Loop3 handoff uses YV's own native current-Loop health instead of the retired 150 phase budget");
        with(_phase) {hm_arkintide_mod_gml_hm_yv_phase_bind();repeat(4) scrHMBossHealth1103();}
        scrHMGameplayCheck(_phase.hp==_phasehealth && _phase.max_hp==_phasehealth,"native YV event rebinding cannot multiply its own native phase health again");
        instance_destroy(_yv,false);
        instance_destroy(_phase,false);GameCont.loops=_loops;
        var _sleep=instance_create(player.x+120,player.y,NothingInactive);
        var _show=true;with(_sleep) _show=scrHMThroneBarVisible1103();
        scrHMGameplayCheck(!_show,"sleeping Throne transition prop has no bossbar");
        instance_destroy(_sleep,false);
        with(enemy) instance_destroy(id,false);
    }
    if(mode=="sync113messengerportrait" && ticks==20) {
        scrHMGameplayLane107();GameCont.loops=0;UberCont.opt_bossintro=1;
        scrHMModSet("mod","options","intropan","1");
        portrait_messenger113=hm_enemies_mod_gml_enemyrogue_create(player.x+64,player.y);
        with(IDPDSpawn) instance_destroy(id,false);
        with(portrait_messenger113) hm_enemies_mod_gml_enemyrogue_step();
        var _intro=HMWorld.hm_portrait_active;
        scrHMGameplayCheck(instance_exists(_intro) && _intro.name=="bossintro","real original Messenger Step triggers its portrait-enabled entrance");
        scrHMGameplayCheck(_intro.bossname=="The#Messenger","actual boss trigger uses the Messenger title");
        scrHMGameplayCheck(_intro.spr[1]==sprHMMessengerPortrait1103 && _intro.spr[0]==mskNone && _intro.spr[2]==mskNone,"actual portrait uses Rogue B art without the old Lieutenant foreground");
        scrHMGameplayCheck(_intro.fadedark==1 && !player.can_walk && portrait_messenger113.hm_portrait_frozen,"actual portrait freezes camera actors and player controls");
        var _camera=view_camera[0];
        camera_set_view_pos(_camera,player.x-view_width/2,player.y-view_height/2);
        portrait_rendered113=false;portrait_font_restored113=false;
        portrait_recorder113=instance_create(0,0,CustomObject);
        with(portrait_recorder113) {
            name="test_messenger_portrait113";owner=other.id;
            on_draw=scrHMScriptRef(scrHMGameplayMessengerPortraitDraw1103);
        }
    }
    if(mode=="sync113messengerportrait" && ticks==100) {
        scrHMGameplayCheck(portrait_rendered113,"real Draw event rendered the actual boss portrait, splat and pixel title into a saved frame");
        scrHMGameplayCheck(portrait_font_restored113,"original-art title path restores its incoming UI font");
        scrHMGameplayCheck(file_exists(game_directory+"messenger-portrait113.png"),"portrait raster evidence was saved from real sprite draw calls");
        scrHMGameplayCheck(font_exists(global.hm_report_title_font1103) && sprite_get_number(sprHMBossTitleGlyphs1103)==74,"original title glyph font uses the complete original seventy-four frames");
    }
    if(mode=="sync113messengerportrait" && ticks==150) {
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active) && player.can_walk && player.can_pick,"natural portrait completion releases the actual control and camera freeze");
        scrHMGameplayCheck(instance_exists(portrait_messenger113) && !portrait_messenger113.hm_portrait_frozen,"Messenger resumes its living native MOD actor after the portrait");
        instance_destroy(portrait_recorder113,false);
    }
    if(mode=="sync113bosspolicy" && ticks==20) {
        scrHMGameplayLane107();
        var _area=GameCont.area,_sub=GameCont.subarea,_loops=GameCont.loops;
        var _excluded=[scrHMAreaResolve("HQ"),area_hq,scrHMAreaResolve("throne"),scrHMAreaResolve("venuz"),scrHMAreaResolve("mansion"),area_crib];
        scrHMGameplayCheck(_loops==1 || _loops==3,"replacement exclusions test the requested actual Loop1 or Loop3 scenario");
        for(var _case=0;_case<array_length(_excluded);++_case) {
            GameCont.area=_excluded[_case];GameCont.subarea=1;
            var _boss=instance_create(player.x+120,player.y,BanditBoss);
            _boss.newintro=-1;
            var _roller=instance_create(0,0,CustomObject);
            random_set_seed(71030+_case);var _expected=random(1);random_set_seed(71030+_case);
            repeat(20) with(_roller) scrHMReplacementTick1102();
            var _actual=random(1);
            scrHMGameplayCheck(!scrHMReplacementArea1102(),"HQ, Throne and every Venus campaign identity are excluded from both replacement slots");
            scrHMGameplayCheck(instance_exists(_boss) && !variable_instance_exists(_roller,"hm_gungod_rolled"),"excluded encounter keeps its original boss without creating a replacement roll latch");
            scrHMGameplayCheck(_actual==_expected,"excluded replacement tick consumes no random roll");
            var _replacement=false;with(enemy) if(scrHMReplacementActor1102()) _replacement=true;
            scrHMGameplayCheck(!_replacement,"excluded encounter creates neither Captain nor Venus final boss");
            instance_destroy(_boss,false);instance_destroy(_roller,false);
        }
        GameCont.area=_area;GameCont.subarea=_sub;GameCont.loops=_loops;
    }
    if(mode=="sync113thronehealth" && ticks==20) {
        UberCont.opt_bossintro=0;scrHMModSet("mod","options","intropan","0");
        var _sleep=instance_find(NothingInactive,0);
        scrHMGameplayCheck(instance_exists(_sleep),"real original Throne generator supplies the sleeping boss");
        with(_sleep) {active=true;hp=0;event_perform_object(NothingInactive,ev_step,ev_step_normal);}
        scrHMGameplayCheck(instance_exists(BecomeNothing),"native sleeping damage creates the actual activation transition");
        // Health is the contract here. Complete the real activation frame as
        // the route fixture does, then allow maincode to initialize its health.
        with(BecomeNothing) {
            sprite_index=sprNothingActivate;drawimg=sprite_get_number(sprite_index);
            event_perform_object(BecomeNothing,ev_step,ev_step_normal);
        }
    }
    if(mode=="sync113thronehealth" && ticks==35) {
        var _boss=instance_find(Nothing,0);
        scrHMGameplayCheck(instance_exists(_boss),"real sleeping Throne Step creates its active fighting identity");
        var _expected=1500*(1+GameCont.loops/3)*(1+GameCont.loops/20)*.8*(GameCont.loops>0?1.3:1);
        scrHMGameplayCheck(abs(_boss.max_hp-_expected)<.001,"real Throne native Create and maincode setup produce 1200 at Loop0 and one completed L1 bonus");
        var _before=_boss.max_hp;with(_boss) repeat(4) scrHMBossHealth1103();
        scrHMGameplayCheck(_boss.max_hp==_before,"real Throne maincode health latch prevents repeat scaling");
    }
    if(mode=="sync113messenger" && ticks==20) {
        scrHMGameplayLane107();UberCont.opt_bossintro=0;
        messenger113=hm_enemies_mod_gml_enemyrogue_create(player.x+80,player.y);
        var _health=messenger113.hp;
        scr_hit(messenger113,7,[sprPopoExplo,"IDPD STRIKE",messenger113.id]);
        scrHMGameplayCheck(messenger113.hp==_health,"Messenger ignores its own exactly tagged explosion");
        scr_hit(messenger113,7,[sprPopoExplo,"IDPD STRIKE",player.id]);
        scrHMGameplayCheck(messenger113.hp==_health-7,"another owner's neutral blast still damages Messenger");
        scr_hit(messenger113,3,HitId.Player);
        scrHMGameplayCheck(messenger113.hp==_health-10,"ordinary player damage is applied once");
        var _old_onhurt=messenger113.on_hurt;
        scrHMGameplayCheck(scrHMScriptRef(_old_onhurt)==scrHMScriptRef(scrHMMessengerHurt1103),"default damage re-entry restores Messenger's hurt hook");
        var _blast=instance_create(player.x+180,player.y,PopoExplosion);
        with(_blast) scrHMMessengerTagExplosion1103(other.messenger113);
        scrHMGameplayCheck(_blast.hitid[2]==messenger113.id && _blast.creator==messenger113.id,"strike/retaliation explosion owner tag survives the projectile callback");
        instance_destroy(_blast,false);
        var _body=instance_create(player.x+100,player.y,Corpse);
        _body.specialrevive="rogue";
        var _revived=noone;with(_body) _revived=hm_enemies_mod_gml_enemyrogue_create(x,y);
        instance_destroy(_body,false);
        scrHMGameplayCheck(_revived.name=="roguefreak" && _revived.hm_messenger_no_presentation1103,"revived Messenger retains its enemy identity and explicit presentation exclusion");
        with(_revived) {target=other.player;intro=0;scrHMMessengerIntro1103();}
        scrHMGameplayCheck(_revived.intro==1,"revived Messenger immediately resumes combat");
        var _presentations=0;with(CustomObject) if(name=="bossintro") _presentations++;
        scrHMGameplayCheck(_presentations==0,"revived Messenger does not capture a portrait or entrance camera");
        var _title="";with(_revived) _title=hm_hm_bossbar_mod_gml_hm_custom_boss_name();
        scrHMGameplayCheck(_title=="The Messenger","revived Messenger still resolves a named health bar");
        scrHMGameplayCheck(scrHMMessengerSkipPresentation1103(_revived),"revived Messenger is also excluded from death presentations");
        with(enemy) instance_destroy(id,false);with(IDPDSpawn) instance_destroy(id,false);
    }
    if(mode=="sync113minigun" && ticks==20) {
        scrHMGameplayLane107();
        var _camera=view_camera[0];
        // Put the player and the firing actor in the active real camera.
        minigun113=hm_enemies_mod_gml_Minigunner_create(player.x+64,player.y);
        camera_set_view_pos(_camera,player.x-view_width/2,player.y-view_height/2);
        with(minigun113) {sprite_index=spr_idle;alrm1=0;nexthurt=-1;speed=0;scrHMMinigunnerStep1103();}
        scrHMGameplayCheck(minigun113.hm_minigun_state1103==1 && minigun113.firing==0,"visible Minigunner starts the native warning before firing");
        scrHMGameplayCheck(instance_exists(HitWarning),"pre-burst warning uses the host's bandit exclamation object");
        var _shots=instance_number(EnemyBullet4);
        with(minigun113) repeat(59) scrHMMinigunnerStep1103();
        scrHMGameplayCheck(instance_number(EnemyBullet4)==_shots,"sixty logical ticks of warning cannot emit an early bullet");
        with(minigun113) scrHMMinigunnerStep1103();
        scrHMGameplayCheck(instance_number(EnemyBullet4)==_shots+1,"warned burst starts after the full windup");
        minigun113.x=player.x+view_width*3;
        with(minigun113) scrHMMinigunnerStep1103();
        scrHMGameplayCheck(minigun113.hm_minigun_state1103==0 && minigun113.firing==0,"leaving the camera cancels a pending firing burst");
        var _last=instance_number(EnemyBullet4);
        with(minigun113) repeat(120) scrHMMinigunnerStep1103();
        scrHMGameplayCheck(instance_number(EnemyBullet4)==_last,"cancelled offscreen task cannot keep emitting projectiles");
        minigun113.x=player.x+64;
        with(minigun113) {alrm1=0;scrHMMinigunnerStep1103();}
        scrHMGameplayCheck(minigun113.hm_minigun_state1103==1 && minigun113.hm_minigun_wait1103==60,"re-entering view requires a fresh warning");
        instance_destroy(minigun113,false);with(EnemyBullet4) instance_destroy(id,false);
    }
    if(mode=="sync113guardian" && ticks==20) {
        scrHMGameplayLane107();
        var _actor=scrHMPalaceGuardianCreate1103(player.x+100,player.y);
        var _hp=_actor.max_hp;
        with(_actor) scrHMBossHealth1103();
        scrHMGameplayCheck(_actor.object_index==CrownGuardian && _actor.hm_palace_guardian,"Palace population guardian keeps real native AI and marker");
        scrHMGameplayCheck(_actor.max_hp==_hp,"ordinary Palace Guardian receives no stage-boss thirty-percent bonus");
        var _is_boss=true;with(_actor) _is_boss=hm_arkintide_mod_gml_hm_stage_boss_actor();
        scrHMGameplayCheck(!_is_boss,"ordinary Palace guardian never consumes a replacement or extra boss slot");
        var _music=MusCont.alarm[1];_actor.hp=0;
        instance_destroy(_actor);
        scrHMGameplayCheck(MusCont.alarm[1]==_music,"ordinary Guardian death does not schedule boss-win music");
        scrHMGameplayCheck(instance_exists(PortalClear),"native Guardian projectile clear survives the ordinary death branch");
    }
}

function scrHMGameplayMessengerPortraitDraw1103() {
    if(!instance_exists(owner) || owner.portrait_rendered113) return;
    var _intro=HMWorld.hm_portrait_active;
    if(!instance_exists(_intro) || _intro.bossx>view_width*.70) return;
    var _surface=surface_create(ceil(view_width),ceil(view_height));
    var _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign();
    var _color=draw_get_color(),_alpha=draw_get_alpha();
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection);
    var _camera=camera_create_view(0,0,view_width,view_height,0,noone,-1,-1,0,0);
    surface_set_target(_surface);draw_clear_alpha(c_black,1);
    matrix_set(matrix_world,matrix_build_identity());camera_apply(_camera);
    // Execute the same native GUI module called by the live world renderer.
    // This covers actual art, splat, pixel title, camera-relative positioning
    // and every sprite/font API without replacing them with instrumentation.
    hm_bosses_bossintros_mod_gml_draw_gui();
    surface_reset_target();
    surface_save(_surface,game_directory+"messenger-portrait113.png");
    // Capture the independent original-font probe separately so the visual
    // evidence is the real Messenger portrait without a second title overlay.
    surface_set_target(_surface);draw_clear_alpha(c_black,1);
    draw_set_font(fntM1);var _before=draw_get_font();
    scrHMReportIntroDraw1103(view_width/2,32,"BIG#BUBBLER");
    owner.portrait_font_restored113=draw_get_font()==_before;
    surface_reset_target();
    surface_save(_surface,game_directory+"boss-title113.png");surface_free(_surface);
    camera_destroy(_camera);matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
    draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_color);draw_set_alpha(_alpha);
    owner.portrait_rendered113=true;
}
