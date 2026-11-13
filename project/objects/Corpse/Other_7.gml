// Empty custom death sprites have no animation-end lifecycle.
if(scrHMEnabled() && (!sprite_exists(sprite_index)||sprite_index==mskNone)) {image_speed=0;exit;}
if(scrHMEnabled() && (self[$ "hm_extra"]??false)) {
    hm_extra_animend_count1116=(self[$ "hm_extra_animend_count1116"]??0)+1;
    hm_extra_animend_serial1116=HMWorld.logic_serial;
    if(instance_exists(HMGameplayTest)) show_debug_message("HARDMODE DEATH116 ANIMEND "+json_stringify({
        kind:self[$ "hm_extra_kind"]??"",owner:self[$ "hm_extra_death_owner1116"]??noone,body:id,
        serial:HMWorld.logic_serial,frame:current_frame,index:image_index,frames:image_number,
        speed:image_speed,sprite:sprite_get_name(sprite_index),count:hm_extra_animend_count1116}));
}
image_index = image_number - 1
image_speed = 0
if(scrHMEnabled()) scrHMCorpseSettle116();

if (forceportal || scr_check_enemies()) exit

with (Corpse) alarm[0] = -1

alarm[0] = 30
	
if !place_meeting(x, y, Floor) {
	with instance_nearest(x, y, Floor) {
		other.x = bbox_center_x
		other.y = bbox_center_y
	}
	xprevious = x
	yprevious = y
}
