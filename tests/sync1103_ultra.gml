// Run via real mobile-host VM at both 30/60 FPS. The native selection action
// is UltraIcon.User0; no production input predicates are overridden here.
function scrHMGameplayUltra1103() {
    if(!array_contains(["sync113ultra","sync113horror","sync113ultradefer","sync113ultrasave","sync113ultraoff","sync113ultrapending",
        "sync113ultracancel","sync113ultracancelsave","sync113ultracancelpending","sync113ultracancelhorror",
        "sync113ultracancelyv","sync113ultracancelcoop"],mode)) return;
    if(ticks==20) {
        scrHMGameplayLane107();
        ultra_cancel1103=string_pos("cancel",mode)>0;
        ultra_race1103=array_contains(["sync113horror","sync113ultracancelhorror"],mode)?Race.Horror:Race.Crystal;
        if(mode=="sync113ultracancelyv") ultra_race1103=Race.Venuz;
        if(mode=="sync113ultracancelcoop") ultra_race1103=Race.CoopUltra;
        var _playing_race=ultra_race1103==Race.CoopUltra?Race.Crystal:ultra_race1103;
        with(player) scrPlayerRaceChange(_playing_race,0);
        var _pinst=scr_playerinstance_find(0);
        if(!is_struct(_pinst)) _pinst=scr_playerinstance_create(0);
        _pinst.race=_playing_race;_pinst.skin=0;
        scrUltrasReset();scrHML2UltraReset1103();
        GameCont.skillpoints=0;GameCont.crownpoints=0;GameCont.ultrapoints=0;
        if(mode=="sync113ultraoff") {
            scrHMModSet("mod","options","playerboost","0");
            hm_arkintide_mod_gml_hm_progression_start();UberCont.opt_griller=false;
        }
        GameCont.loops=1;
        scrHML2UltraGrant1103();
        scrHMGameplayCheck(!GameCont.hm_l2_ultra_triggered1103 && !GameCont.ultrapoints,"L1 never queues the bonus");
        if(ultra_cancel1103) {
            GameCont.ultrapoints=1;
            var _first=instance_create(0,0,LevCont),_first_cancel=0;
            with(UltraIcon) if(variable_instance_exists(id,"hm_l2_cancel1103") && hm_l2_cancel1103) _first_cancel++;
            scrHMGameplayCheck(instance_number(UltraIcon)>0 && !_first_cancel,"native first Ultra has no cancel option");
            with(UltraIcon) instance_destroy(id,false);
            instance_destroy(_first,false);GameCont.ultrapoints=0;
        }
        if(mode!="sync113ultradefer") {
            var _base=player.max_hp;
            scr_ultra_set(ultra_race1103,1,1);
            if(ultra_race1103==Race.Crystal) scrHMGameplayCheck(player.max_hp==_base+6,"native first Crystal Ultra really applies its health effect");
        }
        ultra_hp1103=player.max_hp;
        GameCont.loops=2;scrHML2UltraGrant1103();
        scrHMGameplayCheck(GameCont.hm_l2_ultra_triggered1103,"L2 queues one per-run entitlement");
        if(mode=="sync113ultradefer") {
            scrHMGameplayCheck(!GameCont.hm_l2_ultra_points1103 && !GameCont.ultrapoints,"under-levelled first Ultra is not replaced");
            GameCont.ultrapoints=1;
            scr_ultra_set(ultra_race1103,1,1);
            GameCont.ultrapoints--;
            scrHML2UltraTick1103();
        }
        scrHMGameplayCheck(GameCont.hm_l2_ultra_points1103==1 && GameCont.ultrapoints==1,"exactly one extra native point");
        repeat(5) {scrHML2UltraTick1103();scrHML2UltraGrant1103();}
        scrHMGameplayCheck(GameCont.hm_l2_ultra_points1103==1 && GameCont.ultrapoints==1,"ticks and repeated grant do not stack");
        if(array_contains(["sync113ultrapending","sync113ultracancelpending"],mode)) {
            scrSavegameSave();
            GameCont.hm_l2_ultra_triggered1103=false;GameCont.hm_l2_ultra_points1103=0;
            with(Player) instance_destroy(id,false);
            scrHMGameplayCheck(scrSavegameLoad(),"real disk continue restores an unused bonus");
            player=instance_find(Player,0);
            scrHMGameplayCheck(GameCont.hm_l2_ultra_triggered1103 && GameCont.hm_l2_ultra_points1103==1 && GameCont.ultrapoints==1,"unused native point and entitlement survive session serialization");
        }
        GameCont.skillpoints=1;
        var _normal=instance_create(0,0,LevCont);
        scrHMGameplayCheck(instance_number(SkillIcon)>0 && !variable_instance_exists(_normal,"hm_l2_menu1103"),"ordinary mutation retains priority");
        with(SkillIcon) instance_destroy(id,false);instance_destroy(_normal,false);
        GameCont.skillpoints=0;
        ultra_controller1103=instance_create(0,0,LevCont);
        var _wrong=0,_choices=0,_cancels=0;ultra_icon1103=noone;
        with(UltraIcon) {
            if(variable_instance_exists(id,"hm_l2_cancel1103") && hm_l2_cancel1103) {
                _cancels++;
                if(race!=other.ultra_race1103 || num!=0 || sprite_index!=sprSkillIcon) _wrong++;
                if(other.ultra_cancel1103) other.ultra_icon1103=id;
                continue;
            }
            _choices++;
            if(race!=other.ultra_race1103 || num==1 || !variable_instance_exists(id,"hm_l2_bonus1103") || !hm_l2_bonus1103) _wrong++;
            if(num==2 && !other.ultra_cancel1103) other.ultra_icon1103=id;
        }
        scrHMGameplayCheck(!_wrong && _choices==(ultra_race1103==Race.Horror?2:1),"native bonus icons contain only exact unowned choices");
        scrHMGameplayCheck(_cancels==1,"second Ultra has exactly one cancel option");
        scrHMGameplayCheck(instance_exists(ultra_icon1103),"desired choice has a real synchronized native icon");
        ultra_hp1103=player.max_hp;
    }
    if(ticks==30) {
        scrHMGameplayCheck(instance_exists(ultra_icon1103),"native Ultra menu remains selectable");
        ultra_hp1103=player.max_hp;
        var _owned=json_stringify(GameCont.ultra_got),_hud=json_stringify(GameCont.ultra_hud),
            _patience=scr_skill_get(mut_patience),_deferred=GameCont.patiencepick,
            _home=GameCont.gocrib,_advance=GameCont.can_advance_stage;
        with(ultra_icon1103) event_user(0);
        if(ultra_cancel1103) {
            scrHMGameplayCheck(json_stringify(GameCont.ultra_got)==_owned && json_stringify(GameCont.ultra_hud)==_hud,"cancel leaves all native Ultra ownership and HUD entries unchanged");
            scrHMGameplayCheck(scr_skill_get(mut_patience)==_patience && GameCont.patiencepick==_deferred,"Patience icon never grants or defers a mutation");
            scrHMGameplayCheck(GameCont.gocrib==_home && GameCont.can_advance_stage==_advance,"cancel does not trigger Y.V./Cuz home visit");
        }
        else scrHMGameplayCheck(scr_ultra_get(ultra_race1103,1)==1 && scr_ultra_get(ultra_race1103,2)==1,"native confirmation keeps both Ultras");
        if(ultra_race1103==Race.Horror) scrHMGameplayCheck(!scr_ultra_get(ultra_race1103,3),"Horror receives one extra selection only");
        scrHMGameplayCheck(!GameCont.ultrapoints && !GameCont.hm_l2_ultra_points1103 && GameCont.hm_l2_ultra_done1103[0],"native confirmation consumes exactly the reserved point");
        scrHMGameplayCheck(!instance_exists(LevCont) && instance_exists(GenCont),"native submit returns to actual generation");
        // Framework restores its synthetic player's max_hp every frame, so
        // check the first effect before/after this same confirmation event.
        scrHMGameplayCheck(player.max_hp==ultra_hp1103,"bonus does not remove the first Ultra's health effect");
    }
    if(ticks==40) {
        repeat(5) {scrHML2UltraTick1103();scrHML2UltraGrant1103();}
        scrHMGameplayCheck(!GameCont.ultrapoints && !GameCont.hm_l2_ultra_points1103,"subsequent world ticks do not award a third Ultra");
        if(array_contains(["sync113ultrasave","sync113ultracancelsave"],mode)) {
            scrSavegameSave();
            GameCont.hm_l2_ultra_triggered1103=false;GameCont.hm_l2_ultra_done1103=[];
            with(Player) instance_destroy(id,false);
            scrHMGameplayCheck(scrSavegameLoad(),"real disk continue restores the Ultra entitlement");
            player=instance_find(Player,0);
            scrHMGameplayCheck(GameCont.hm_l2_ultra_triggered1103 && GameCont.hm_l2_ultra_done1103[0],"used entitlement survives existing session serialization");
            scrHML2UltraTick1103();scrHML2UltraGrant1103();
            scrHMGameplayCheck(!GameCont.ultrapoints && !GameCont.hm_l2_ultra_points1103,"continue cannot claim the bonus twice");
        }
        scrHML2UltraReset1103();GameCont.loops=0;
        scrHMGameplayCheck(!GameCont.hm_l2_ultra_triggered1103 && !array_length(GameCont.hm_l2_ultra_races1103),"new-run hook resets only the bonus entitlement");
        scrHMGameplayCheck(scr_ultra_get(ultra_race1103,1)==1 && scr_ultra_get(ultra_race1103,2)==(ultra_cancel1103?0:1),"entitlement reset never changes native ownership");
    }
}
