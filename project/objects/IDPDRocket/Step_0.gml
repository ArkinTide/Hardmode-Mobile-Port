// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if lockstep_stop
	exit

if active = 1 {
    instance_create(x, y, Smoke)
    if speed < (12) * timescale speed += (1) * timescale
}