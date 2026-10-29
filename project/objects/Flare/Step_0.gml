// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if lockstep_stop
	exit

if current_frame_active && friction > (0.15) * timescale * timescale {
	var _dir = direction + orandom(10)
    scr_projectile_create(x, y, Flame, _dir, random(1))
}