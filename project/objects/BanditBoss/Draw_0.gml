// NTT swimming owns the cropped body renderer.
if(scrHMEnabled() && (self[$ "swimming"]??false)) exit;
if lockstep_stop
	exit

var _hm_sprite1116=sprite_index;
if(scrHMEnabled() && (self[$ "hm_stage_jungle"]??false)) sprite_index=hm_arkintide_mod_gml_hm_extra_skin(sprite_index);
if gunangle <= 180 draw_sprite_ext(sprBanditBossGun, -1, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, c_white, 1) draw_sprite_ext(sprite_index, -1, x, y, right, 1, 0, c_white, 1)
if gunangle > 180 draw_sprite_ext(sprBanditBossGun, -1, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, c_white, 1)
sprite_index=_hm_sprite1116;
