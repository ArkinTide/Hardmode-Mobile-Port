// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if lockstep_stop
	exit

if sprite_index == sprBigGuardianBulletSpawn {
    x -= hspeed
    y -= vspeed
}
else friction = (0.1) * timescale * timescale

if (speed == 0) instance_destroy()