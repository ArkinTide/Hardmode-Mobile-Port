// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if lockstep_stop
	exit

if active && current_frame_active {
    motion_add_m(direction, accel, maxspeed)
    instance_create(x, y, Smoke)
}