// NTT swimming owns the cropped body renderer.
if(scrHMEnabled() && (self[$ "swimming"]??false)) exit;
if lockstep_stop
	exit

if ((sprite_index == spr_hurt) && (image_index < 1.5)) gpu_set_fog(1, c_white, depth, (depth + 1))
var _chief_hold=scrHMEnabled() && (self[$ "hm_chief1102"]??false)
    && (!(self[$ "hm_chief_combat1115"]??false) || (self[$ "hm_portrait_frozen"]??false) || UberCont.paused)
if(!_chief_hold || (!(self[$ "hm_chief_presented1102"]??true) && !UberCont.paused)) drawimg += (0.4) * timescale
if(_chief_hold) drawimg=min(drawimg,sprite_get_number(drawspr)-1)
draw_sprite_ext(drawspr, drawimg, x, y, right, 1, 0, c_white, 1)
gpu_set_fog(0, 0, 0, 0)
