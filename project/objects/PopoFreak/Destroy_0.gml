scrDrop(60, 0)
event_inherited()

with Player {
	if is_me && race == Race.Rogue {
	    UberCont.ctot_uniq[race] ++
	}
}

if random(4) < 1 {
    repeat 3 {
        with instance_create(x, y, PopoNade) {
            hitid = other.hitid
            motion_add(other.direction, (4) * timescale)
            motion_add(random_angle, (4) * timescale)
            image_angle = direction
            team = other.team
        }
    }
}

with WantVan
canspawn = 1

if(!scrHMEnabled()) instance_create(x, y, WantRevivePopoFreak)
else if(scrHMPoliceLate1116()) {
    var _corpse=self[$ "hm_death_corpse107"]??noone;
    if(instance_exists(_corpse)) {
        var _timer=instance_create(x,y,WantRevivePopoFreak);
        scrHMPoliceBindCorpse107(_timer,_corpse);
    }
}
