// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if current_frame_active {
	scr_damage_create(x + orandom(16), y + orandom(16), PlasmaImpact)
	
	x += orandom(1)
	y += orandom(1)
}