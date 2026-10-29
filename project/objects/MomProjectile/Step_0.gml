// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if current_frame_active {
	scr_projectile_create(x + orandom(2), y + orandom(0), ToxicGas)
}