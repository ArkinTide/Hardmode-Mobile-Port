// NTT swimming owns the cropped body renderer.
if(scrHMEnabled() && (self[$ "swimming"]??false)) exit;
draw_sprite_ext(sprite_index, image_index, x, y,
	image_xscale * right, image_yscale, image_angle, image_blend, image_alpha)