// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if lockstep_stop
	exit

if (!canbreak) hp = 1000

x = xstart
y = ystart

speed = 0

if (place_meeting(x, y, Nothing)) instance_destroy()
