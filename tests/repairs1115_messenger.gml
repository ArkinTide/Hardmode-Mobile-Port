function scrHMGameplayMessenger115() {
    if(mode=="group115replace" && ticks==20) {
        scrHMGameplayLane107();HMWorld.hm_boss_room115="";
        scrHMModSet("mod","options","intropan","1");scrHMModSet("mod","options","bossoutros","1");
        var _original=instance_create(player.x+96,player.y,OasisBoss);
        scrHMBossGroupRegister115(_original);
        scrHMBossGroupRetire115(_original);scrHMDelete(_original);
        scrHMBossGroupTick115();
        var _group=scrHMBossGroupReserve115("bubbler");
        scrHMGameplayCheck(_group.retired && _group.exit_count==0 && !instance_exists(HMWorld.hm_portrait_active),
            "replacing a living normal boss cannot be mistaken for a defeated boss outro");
        group_replace_checked115=true;
    }
    if(mode=="group115replace" && ticks==goal_ticks-5)
        scrHMGameplayCheck(self[$ "group_replace_checked115"]??false,"replacement group retirement reached its required terminal assertion");
    if(string_pos("messenger115",mode)!=1) return;
    var _short=mode!="messenger115natural";
    if(ticks==20) {
        scrHMGameplayLane107();HMWorld.hm_boss_room115="";
        scrHMGameplayNoReplacement1115();
        scrHMModSet("mod","options","intropan","1");scrHMModSet("mod","options","bossoutros","1");
        var _reference=instance_create(player.x,player.y,WantRevivePopoFreak);
        messenger_native_delay115=_reference.alarm[0];instance_destroy(_reference,false);
        messenger_keeper115=instance_create(14400,14280,CustomEnemy);messenger_keeper115.hp=100000;
        var _boss=hm_enemies_mod_gml_enemyrogue_create(player.x+80,player.y);
        var _body=noone;
        with(_boss) {hp=0;instance_destroy();}
        with(Corpse) if(self[$ "hm_messenger_corpse115"]??false) {_body=id;break;}
        messenger_corpse115=_body;
        if(GameCont.loops<3) {
            var _count=0;with(WantRevivePopoFreak) if(variable_instance_exists(id,"hm_messenger_corpse115")) _count++;
            scrHMGameplayCheck(_count==0,"normal Messenger does not gain automatic revival before Loop three");
            messenger_early_checked115=true;
            return;
        }
        scrHMGameplayCheck(instance_exists(messenger_corpse115),"actual Messenger death retains its marked visible corpse");
        messenger_timer115=messenger_corpse115.hm_messenger_timer115;
        scrHMGameplayCheck(instance_exists(messenger_timer115) && messenger_timer115.alarm[0]==messenger_native_delay115*2,
            "Messenger schedules exactly twice the real native IDPD Freak constructor interval");
        scrHMGameplayCheck(!scrHMMessengerReviving115(),"long revival timer does not block ordinary room clearance");
        messenger_effect115=noone;messenger_revived115=noone;messenger_checked115=false;
        messenger_effect_seen115=false;messenger_return_seen115=false;messenger_cleared115=false;
        if(_short) messenger_timer115.alarm[0]=5;
    }
    if(GameCont.loops<3) {
        if(ticks==goal_ticks-5) scrHMGameplayCheck(self[$ "messenger_early_checked115"]??false,
            "pre-Loop-three Messenger revival exclusion reached its required terminal assertion");
        return;
    }
    if(ticks<=20) return;
    if(!messenger_effect_seen115) {
        var _effect=noone;
        with(RevivePopoFreak) if(variable_instance_exists(id,"hm_messenger_corpse115")) {
            _effect=id;break;
        }
        messenger_effect115=_effect;
        if(instance_exists(messenger_effect115)) {
            messenger_effect_seen115=true;messenger_effect_tick115=ticks;
            scrHMGameplayCheck(messenger_effect115.sprite_index==sprPopoReviveArea,
                "automatic Messenger rise uses the actual IDPD Freak revival-area sprite");
            scrHMGameplayCheck(messenger_effect115.alarm[0]>0 && messenger_effect115.alarm[0]<=15,
                "actual revival-area constructor retains its fifteen-frame effect");
            scrHMGameplayCheck(scrHMMessengerReviving115() && scrHMPendingBoss() && scr_check_enemies(),
                "visible revival effect blocks clearance until its combat actor exists");
        }
    }
    if(messenger_effect_seen115 && !messenger_return_seen115) {
        var _returned=noone;
        with(CustomEnemy) if(self[$ "hm_messenger_auto_revived115"]??false) {_returned=id;break;}
        messenger_revived115=_returned;
        if(instance_exists(messenger_revived115)) {
            messenger_return_seen115=true;messenger_return_tick115=ticks;
            scrHMGameplayCheck(!instance_exists(messenger_corpse115) && !instance_exists(messenger_effect115),
                "native revival consumes only its owned corpse and completed effect");
            scrHMGameplayCheck(ticks-messenger_effect_tick115>=14 && ticks-messenger_effect_tick115<=16,
                "Messenger appears only after the full fifteen-frame native revival effect");
            scrHMGameplayCheck(messenger_revived115.name=="roguefreak" && messenger_revived115.hp>0,
                "automatic revival keeps the original armed roguefreak actor");
            var _title="";with(messenger_revived115) _title=hm_hm_bossbar_mod_gml_hm_custom_boss_name();
            scrHMGameplayCheck(_title=="The Messenger" && !scrHMMessengerSkipPresentation1103(messenger_revived115),
                "automatically revived Messenger has its boss bar and may receive a new entrance");
            // The full native wait leaves the constructor's police free to
            // move this observer. A healthy Messenger deliberately waits
            // until a player approaches within 120 pixels before its pan.
            show_debug_message("HARDMODE MESSENGER115 APPROACH "+json_stringify({tick:ticks,
                before_distance:point_distance(player.x,player.y,messenger_revived115.x,messenger_revived115.y),
                before_intro:messenger_revived115.intro,
                before_camera:instance_exists(HMWorld.hm_portrait_active)}));
            player.x=messenger_revived115.x-80;player.y=messenger_revived115.y;player.speed=0;
            with(messenger_revived115) {
                target=other.player;targetvisible=1;intro=0;scrHMMessengerIntro1103();
            }
            scrHMGameplayCheck(instance_exists(HMWorld.hm_portrait_active) && scrHMBossPresentationProtected115(),
                "returned normal Messenger may run a real protected entrance camera");
        }
    }
    if(messenger_return_seen115 && ticks>=messenger_return_tick115+150 && !messenger_checked115) {
        messenger_checked115=true;
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active) && player.can_walk,
            "revived Messenger entrance releases controls normally");
        with(messenger_revived115) {hp=0;instance_destroy();}
        var _timer=noone;
        with(WantRevivePopoFreak) if(variable_instance_exists(id,"hm_messenger_corpse115")) {_timer=id;break;}
        messenger_second_timer115=_timer;
        scrHMGameplayCheck(instance_exists(messenger_second_timer115)
            && messenger_second_timer115.alarm[0]==messenger_native_delay115*2,
            "a second death follows the Freak's repeatable full-interval revival policy");
        instance_destroy(messenger_keeper115,false);
        // The real Messenger constructor also schedules police arrivals.
        // Finish those unrelated encounter queues before asserting that a
        // genuinely empty room can open its exit during the long timer.
        with(IDPDSpawn) instance_destroy(id,false);
        with(VanSpawn) instance_destroy(id,false);
        with(WantPopo) instance_destroy(id,false);
        with(WantVan) instance_destroy(id,false);
        with(enemy) instance_destroy(id,false);with(becomenemy) instance_destroy(id,false);
        show_debug_message("HARDMODE MESSENGER115 CLEAR BLOCKERS "+json_stringify({
            rad_maggot_chest:instance_number(RadMaggotChest),vault:instance_number(VaultStatue),
            crown:instance_number(CrownPickup),tutorial:instance_number(TutCont),scrap_transition:instance_number(BecomeScrapBoss),
            sitting:instance_number(SitDown),generator:instance_number(GenCont),area:GameCont.area,sub:GameCont.subarea,
            maxsub:GameCont.maxsubarea,pending:scrHMPendingBoss(),enemies:scr_check_enemies()}));
        // The lane fixture retains the generated room's noncombat props.
        // Their stock clearance exclusions must not contaminate this test of
        // a Messenger timer in an otherwise genuinely empty encounter.
        with(RadMaggotChest) instance_destroy(id,false);
        with(VaultStatue) instance_destroy(id,false);
        with(CrownPickup) instance_destroy(id,false);
        with(TutCont) instance_destroy(id,false);
        with(BecomeScrapBoss) instance_destroy(id,false);
        with(SitDown) instance_destroy(id,false);
        scrHMGameplayCheck(!scr_check_enemies() && !instance_exists(GenCont)
            && !instance_exists(RadMaggotChest) && !instance_exists(VaultStatue) && !instance_exists(CrownPickup),
            "Messenger timer clearance fixture has no unrelated native exit exclusions");
        var _exit_x=player.x+48,_exit_y=player.y;
        messenger_watch_floor115=instance_furthest(_exit_x,_exit_y,Floor);
        scrHMGameplayCheck(instance_exists(messenger_watch_floor115)
            && point_distance(_exit_x,_exit_y,messenger_watch_floor115.x+16,messenger_watch_floor115.y+16)>160,
            "Messenger exit observation has a real safe floor beyond the native portal attraction radius");
        // Observe the live exit without being pulled through it and tearing
        // down this room before the final repeated-timer assertions run.
        player.x=messenger_watch_floor115.x+16;player.y=messenger_watch_floor115.y+16;player.speed=0;
        scrHMDeathExit(_exit_x,_exit_y);
    }
    if(messenger_checked115 && instance_exists(self[$ "messenger_watch_floor115"]??noone)) {
        player.x=messenger_watch_floor115.x+16;player.y=messenger_watch_floor115.y+16;player.speed=0;
    }
    if(messenger_checked115 && !messenger_cleared115 && instance_exists(Portal)) {
        messenger_cleared115=true;
        scrHMGameplayCheck(!scrHMMessengerReviving115(),"a pending long revival timer still permits the cleared room's real exit");
        with(messenger_second_timer115) event_perform(ev_alarm,0);
        scrHMGameplayCheck(!instance_exists(messenger_second_timer115) && !scrHMMessengerReviving115(),
            "opening the exit cancels Messenger's next automatic revival like a native Freak");
    }
    if(ticks==goal_ticks-5) {
        var _corpses=[];with(Corpse) if(self[$ "hm_exit_corpse"]??false)
            array_push(_corpses,[alarm[0],sprite_get_name(sprite_index),x,y]);
        show_debug_message("HARDMODE MESSENGER115 "+json_stringify({tick:ticks,effect:messenger_effect_seen115,
            returned:messenger_return_seen115,checked:messenger_checked115,cleared:messenger_cleared115,
            enemies:instance_number(enemy),pending:scrHMPendingBoss(),portal:instance_number(Portal),
            police_gates:instance_number(IDPDSpawn),timers:instance_number(WantRevivePopoFreak),
            exit_corpses:_corpses,players:instance_number(Player),becoming:instance_number(becomenemy)}));
        scrHMGameplayCheck(messenger_effect_seen115 && messenger_return_seen115
            && messenger_checked115 && messenger_cleared115,"complete Messenger revival, entrance, repeated timer and normal exit all finish");
    }
}
