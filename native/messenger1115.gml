// Match the native IDPD Freak chain: every corpse may return, but an open
// exit cancels its pending timer. Only the visible fifteen-frame rise holds
// clearance, so a cleared room cannot become an endless revival encounter.
function scrHMMessengerAutoCorpse115(_owner) {
    if(!scrHMEnabled() || !instance_exists(GameCont) || GameCont.loops<3
        || !instance_exists(_owner) || _owner.hp>0 || instance_exists(GenCont)) return;
    if(instance_exists(self[$ "hm_messenger_timer115"]??noone)) return;
    hm_messenger_corpse115=true;
    hm_messenger_extra115=_owner[$ "hm_extra"]??false;
    hm_messenger_extra_kind115=_owner[$ "hm_extra_kind"]??"rogue";
    hm_messenger_extra_attack115=_owner[$ "hm_extra_attack_at"]??current_frame;
    var _timer=instance_create(x,y,WantRevivePopoFreak);
    _timer.hm_messenger_corpse115=id;
    _timer.hm_messenger_area115=GameCont.area;
    _timer.hm_messenger_sub115=GameCont.subarea;
    _timer.hm_messenger_loop115=GameCont.loops;
    _timer.hm_messenger_started115=current_frame;
    // Read the real constructor's interval instead of introducing a second
    // independently maintained constant for the native Freak timing.
    _timer.alarm[0]*=2;
    hm_messenger_timer115=_timer;
}
function scrHMMessengerReviveTimer115() {
    if(!variable_instance_exists(id,"hm_messenger_corpse115")) return false;
    var _body=hm_messenger_corpse115;
    if(!instance_exists(Portal) && instance_exists(_body) && instance_is(_body,Corpse)
        && GameCont.area==hm_messenger_area115 && GameCont.subarea==hm_messenger_sub115
        && GameCont.loops==hm_messenger_loop115) {
        var _effect=instance_create(_body.x,_body.y,RevivePopoFreak);
        _effect.hm_messenger_corpse115=_body;
        _effect.hm_messenger_started115=hm_messenger_started115;
        _effect.hm_messenger_rise115=current_frame;
    }
    instance_destroy();return true;
}
function scrHMMessengerReviveEffect115() {
    if(!variable_instance_exists(id,"hm_messenger_corpse115")) return false;
    var _body=hm_messenger_corpse115,_actor=noone,_xx=x,_yy=y;
    if(!instance_exists(Portal) && instance_exists(_body) && instance_is(_body,Corpse)) {
        var _extra=_body.hm_messenger_extra115;
        var _pending=variable_instance_get(GameCont,"hm_extra_pending")??false;
        GameCont.hm_extra_pending=_extra;
        // Keep the native corpse -> roguefreak constructor context. Its
        // freak sprites, weapons, damage hook and health bar stay intact.
        with(_body) _actor=hm_enemies_mod_gml_enemyrogue_create(x,y);
        GameCont.hm_extra_pending=_pending;
        if(instance_exists(_actor)) with(_actor) {
            hm_messenger_auto_revived115=true;
            hm_messenger_no_presentation1103=_extra;
            hm_extra=_extra;
            if(_extra) {
                hm_extra_kind=_body.hm_messenger_extra_kind115;
                hm_extra_attack_at=_body.hm_messenger_extra_attack115;
                music=1;intro=1;boss=0;newintro=-1;corpse=1;team=1;
                on_death=scrHMContentRef1100("mod","arkintide","hm_extra_loot");
                on_destroy=undefined;
                max_hp=30*(1+.05*GameCont.loops);hp=max_hp;
            } else {
                // A returned life is a new combat encounter. Retaining the
                // first life's completed group would suppress its entrance.
                hm_boss_kind115="messenger_revive_"+string(id);
            }
            hm_messenger_rise115=other.hm_messenger_rise115;
            hm_messenger_started115=other.hm_messenger_started115;
        }
        if(instance_exists(_actor)) {
            with(instance_create(_body.x,_body.y,ReviveFX)) sprite_index=sprPopoRevive;
            snd_play_hit_big(sndFreakPopoRevive,.1);
            GameCont.kills-=1;
            instance_destroy(_body,false);
        }
    }
    snd_play_hit_big(sndNecromancerRevive,.2);
    instance_destroy();
    if(!instance_exists(_actor)) scrHMDeathExit(_xx,_yy);
    return true;
}
function scrHMMessengerReviving115() {
    var _pending=false;
    with(RevivePopoFreak) if(variable_instance_exists(id,"hm_messenger_corpse115")
        && instance_exists(hm_messenger_corpse115)) {_pending=true;break;}
    return _pending;
}
function scrHMMessengerNativeCorpse115(_owner) {
    if(!instance_exists(_owner) || !array_contains(["rogueboss","roguefreak"],_owner[$ "name"]??"")) return;
    specialrevive="rogue";
    scrHMMessengerAutoCorpse115(_owner);
}
