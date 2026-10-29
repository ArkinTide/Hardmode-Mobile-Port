// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if lockstep_stop
	exit

if (hp <= 0) instance_destroy()

x = xstart
y = ystart
speed = 0

if x > 10016 {
    image_xscale = -1
    right = -1
}
else image_xscale = 1