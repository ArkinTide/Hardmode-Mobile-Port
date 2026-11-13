snd_stop(snd)

snd_play(sndExplosionL)

with(instance_create(x, y, Explosion)) scrHMExplosionSource1115(other.id)

var _dir = random_angle

repeat 3 {
    with instance_create(
		x + ldrx(16, _dir),
		y + ldry(16, _dir),
		SmallExplosion
	) {
        team = other.team
        hitid = other.hitid
        scrHMExplosionSource1115(other.id)
    }

    _dir += 360 / 3
}
