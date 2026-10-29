// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if lockstep_stop
	exit

if !instance_exists(Cinematic) {
    event_inherited() exit
}

drawframe += (0.4) * timescale