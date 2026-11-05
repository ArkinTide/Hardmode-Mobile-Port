// One additional native Ultra choice on entering Loop2. The mobile host owns
// UltraIcon, ultrapoints and the localized/touch selection UI; no addon UI is
// imported. Plain GameCont values are included by its existing session save.
function scrHML2UltraReset1103() {
    if(!instance_exists(GameCont)) return;
    GameCont.hm_l2_ultra_triggered1103=false;
    GameCont.hm_l2_ultra_races1103=[];
    GameCont.hm_l2_ultra_done1103=[];
    GameCont.hm_l2_ultra_issued1103=[];
    GameCont.hm_l2_ultra_points1103=0;
}

function scrHML2UltraInit1103() {
    if(!instance_exists(GameCont)) return false;
    if(!variable_instance_exists(GameCont,"hm_l2_ultra_triggered1103")) scrHML2UltraReset1103();
    return true;
}

function scrHML2UltraChoices1103(_race) {
    var _result=[],_count=(_race==Race.Horror)?3:2;
    for(var _u=1;_u<=_count;++_u) {
        if(!scr_ultra_get(_race,_u)) array_push(_result,_u);
    }
    return _result;
}

function scrHML2UltraHasShared1103() {
    return scr_ultra_get_from_race(Race.CoopUltra)!=-1;
}

function scrHML2UltraGrant1103() {
    if(!scrHMEnabled() || !scrHML2UltraInit1103()) return;
    if(GameCont.hm_l2_ultra_triggered1103 || GameCont.loops<2) return;
    GameCont.hm_l2_ultra_triggered1103=true;
    var _races=[];
    for(var _p=0;_p<player_count;++_p) {
        var _pinst=scr_playerinstance_find(_p);
        if(!is_struct(_pinst)) continue;
        var _race=_pinst.get_race();
        if(_race<0 || _race>=Race.NUM_ALL_RACE_TYPES) continue;
        if(scrHML2UltraHasShared1103()) _race=Race.CoopUltra;
        if(!array_contains(_races,_race)) array_push(_races,_race);
    }
    // During normal play PlayerInstances exist. Retain current live players as
    // a fallback for a continued/late-created local slot and isolated tests.
    if(!array_length(_races)) with(Player) {
        var _race=race;
        if(scrHML2UltraHasShared1103()) _race=Race.CoopUltra;
        if(_race>=0 && _race<Race.NUM_ALL_RACE_TYPES && !array_contains(_races,_race)) array_push(_races,_race);
    }
    GameCont.hm_l2_ultra_races1103=_races;
    for(var _r=0;_r<array_length(_races);++_r) {
        var _race=_races[_r];
        var _empty=!array_length(scrHML2UltraChoices1103(_race));
        var _ready=!_empty && scr_ultra_get_from_race(_race)!=-1;
        array_push(GameCont.hm_l2_ultra_done1103,_empty);
        array_push(GameCont.hm_l2_ultra_issued1103,_ready);
        if(_ready) GameCont.hm_l2_ultra_points1103++;
    }
    GameCont.ultrapoints+=GameCont.hm_l2_ultra_points1103;
}

function scrHML2UltraTick1103() {
    if(!scrHMEnabled() || !scrHML2UltraInit1103()) return;
    if(GameCont.area==scrHMAreaResolve("end") && GameCont.loops>=2) scrHML2UltraGrant1103();
    // If an under-levelled co-op party chooses its shared native first Ultra,
    // its unissued queue becomes one shared entitlement, just like race0.
    if(GameCont.hm_l2_ultra_triggered1103 && scrHML2UltraHasShared1103()
       && !array_contains(GameCont.hm_l2_ultra_races1103,Race.CoopUltra)) {
        var _waiting=false,_issued=false;
        for(var _r=0;_r<array_length(GameCont.hm_l2_ultra_races1103);++_r) {
            if(!GameCont.hm_l2_ultra_done1103[_r]) _waiting=true;
            if(GameCont.hm_l2_ultra_issued1103[_r]) _issued=true;
        }
        if(_waiting && !_issued) {
            GameCont.hm_l2_ultra_races1103=[Race.CoopUltra];
            GameCont.hm_l2_ultra_done1103=[false];
            GameCont.hm_l2_ultra_issued1103=[false];
        }
    }
    for(var _r=0;_r<array_length(GameCont.hm_l2_ultra_races1103);++_r) {
        if(GameCont.hm_l2_ultra_done1103[_r] || GameCont.hm_l2_ultra_issued1103[_r]) continue;
        var _race=GameCont.hm_l2_ultra_races1103[_r];
        if(scr_ultra_get_from_race(_race)==-1) continue;
        if(!array_length(scrHML2UltraChoices1103(_race))) {
            GameCont.hm_l2_ultra_done1103[_r]=true;
            continue;
        }
        GameCont.hm_l2_ultra_issued1103[_r]=true;
        GameCont.hm_l2_ultra_points1103++;
        GameCont.ultrapoints++;
    }
}

// Invoke at the END of native LevCont.Create, after its usual first-choice,
// Crown of Destiny, grilling and alignment work. Returning false leaves all
// ordinary/first-Ultra/crown UI intact. This method runs in the LevCont context.
function scrHML2UltraMenu1103() {
    scrHML2UltraTick1103();
    if(!scrHMEnabled() || !instance_exists(GameCont) || object_index!=LevCont) return false;
    if(GameCont.hm_l2_ultra_points1103<=0 || GameCont.skillpoints>0 || GameCont.crownpoints>0) return false;
    if(GameCont.ultrapoints>GameCont.hm_l2_ultra_points1103) return false;
    if(variable_instance_exists(id,"hm_l2_menu1103") && hm_l2_menu1103) return true;
    var _offer=-1,_choices=[];
    for(var _r=0;_r<array_length(GameCont.hm_l2_ultra_races1103);++_r) {
        if(GameCont.hm_l2_ultra_done1103[_r] || !GameCont.hm_l2_ultra_issued1103[_r]) continue;
        _choices=scrHML2UltraChoices1103(GameCont.hm_l2_ultra_races1103[_r]);
        if(array_length(_choices)) {_offer=_r;break;}
        // Another legitimate character effect may have exhausted the queue.
        // Remove only this unused reserved point; do not offer an empty menu.
        GameCont.hm_l2_ultra_done1103[_r]=true;
        GameCont.hm_l2_ultra_points1103=max(0,GameCont.hm_l2_ultra_points1103-1);
        GameCont.ultrapoints=max(0,GameCont.ultrapoints-1);
    }
    if(_offer<0) {
        scrLevelUpScreenSubmit();
        return true;
    }
    with(UltraIcon) instance_destroy(id,false);
    hm_l2_menu1103=true;
    var _race=GameCont.hm_l2_ultra_races1103[_offer];
    for(var _u=0;_u<array_length(_choices);++_u) {
        var _icon=instance_create(0,0,UltraIcon);
        _icon.race=_race;
        _icon.num=_choices[_u];
        _icon.hm_l2_bonus1103=true;
        _icon.hm_l2_owner1103=_offer;
    }
    // Existing native alignment, localized text, mouse/touch hitbox and input
    // remain authoritative. In particular `num` is the actual Ultra ID, even
    // when a filtered Horror menu contains only IDs 2 and 3.
    event_user(0);
    return true;
}

// Invoke in native UltraIcon.Other_10 AFTER scr_ultra_set, as the left operand
// of `if(helper(...) || !scrNeedMorePlayerUltras()) GameCont.ultrapoints--;`.
// Native effect, sound, Y.V./Cuz home visit and submission remain unchanged.
function scrHML2UltraConfirm1103(_race,_num) {
    if(!scrHMEnabled() || !variable_instance_exists(id,"hm_l2_bonus1103") || !hm_l2_bonus1103 || !scrHML2UltraInit1103()) return false;
    var _owner=variable_instance_exists(id,"hm_l2_owner1103")?hm_l2_owner1103:-1;
    if(_owner<0 || _owner>=array_length(GameCont.hm_l2_ultra_races1103)) return false;
    if(GameCont.hm_l2_ultra_races1103[_owner]!=_race || !scr_ultra_get(_race,_num)) return false;
    // Confirmation belongs to this reserved endpoint even if another co-op
    // character is still waiting for its first Ultra; do not consume its point.
    if(!GameCont.hm_l2_ultra_done1103[_owner]) {
        GameCont.hm_l2_ultra_done1103[_owner]=true;
        GameCont.hm_l2_ultra_points1103=max(0,GameCont.hm_l2_ultra_points1103-1);
    }
    return true;
}
