snd_stop(snd)
snd_play(sndExplosionL)

var _ang = random_angle

repeat (2) {
	with(instance_create(
		x + ldrx(12, _ang),
		y + ldry(12, _ang),
		Explosion)) scrHMExplosionSource1115(other.id)
	
	_ang += 180
}
