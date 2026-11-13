// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if lockstep_stop
	exit

if active && current_frame_active {
    // Acceleration runs once per 30 Hz logical tick; the resulting native
    // velocity still uses pixels per physical callback at either cap.
    motion_add_m(direction, accel * timescale, maxspeed)
    instance_create(x, y, Smoke)
}
