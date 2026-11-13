if(scrHMEnabled() && scrHMMessengerReviveEffect115()) exit;
if(scrHMPoliceRevivalBlocked1116()) exit;
var _corpse=self[$ "hm_corpse107"]??(self[$ "hm_police_corpse"]??noone);
if(!scrHMEnabled() && !instance_exists(_corpse)) _corpse=instance_nearest(x,y,Corpse);
if(instance_exists(_corpse) && instance_is(_corpse,Corpse)) with(_corpse) {
    mask_index = mskBandit
    if (place_meeting(x, y, other) && ((sprite_index != mskNone) && place_free(x, y))) {
        snd_play_hit_big(sndFreakPopoRevive, 0.1)
        with instance_create(x, y, ReviveFX)
        sprite_index = sprPopoRevive

        instance_change(PopoFreak, 1)

        depth = -2

        GameCont.kills -= 1
    }
}
snd_play_hit_big(sndNecromancerRevive, 0.2)
instance_destroy()
