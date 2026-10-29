// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if lockstep_stop
	exit

if (wkick != 0) wkick = approach(wkick, 0, timescale)

if(scrHMEnabled() && (self[$ "hm_palace_horror"]??false) && hp<=0) {scrHMPalaceHorrorStep();exit;}
if(scrHMEnabled() && (self[$ "frozen"]??false)) exit;
if (hp <= 0) instance_destroy()

if (spr_chrg != -1) {
    if (sprite_index != spr_hurt && sprite_index != spr_chrg) {
        sprite_index = spr_idle
    }

    if (sprite_index == spr_hurt || sprite_index == spr_chrg) {
        if (image_index > 2) sprite_index = spr_idle
    }
}
else if (spr_fire != -1) {
    if (speed <= 0) {
		if (sprite_index != spr_hurt && sprite_index != spr_fire) {
			sprite_index = spr_idle
		}
    }
	else if (sprite_index != spr_hurt && sprite_index != spr_fire) {
		sprite_index = spr_walk
    }
	
    if (sprite_index == spr_hurt) {
        if (image_index > 2) sprite_index = spr_idle
    }
}
else {
	if (speed <= 0) {
        if (sprite_index != spr_hurt) sprite_index = spr_idle
    }
	else if (sprite_index != spr_hurt) {
        sprite_index = spr_walk
    }
    
	if (sprite_index == spr_hurt) {
        if (image_index > 2) sprite_index = spr_idle
    }
}

scrTarget()

event_user(0)
if(instance_exists(id)) scrHMGroundBounds();