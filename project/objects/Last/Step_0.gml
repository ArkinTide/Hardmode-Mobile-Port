if(scrHMEnabled() && scrHMChiefStep1102()) exit;
// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if lockstep_stop
	exit

event_inherited()
var _chief_speed=scrHMChiefSpeed1115()
scrHMChiefAction1115()
if (charge == 1) {
    instance_create(((x + random(8)) - 4), ((y + 4) + random(4)), Dust)
    motion_add(gunangle, (6) * timescale * _chief_speed)
    speed = (14) * timescale * _chief_speed
} else {
    if (walk > 0) {
        walk -= (1) * timescale
        motion_add(direction, (2) * timescale * timescale * _chief_speed)
        motion_add(gunangle, (1) * timescale * timescale * _chief_speed)
    }
    if (speed > (3) * timescale * _chief_speed) speed = (3) * timescale * _chief_speed
}
if ((hp < (max_hp / 2)) && (sndhalfhp == 0)) {
    snd_play(sndLastHalfHP)
    sndhalfhp = 1
}
if ((!instance_exists(Player)) && (sndtaunt == 0)) {
    tauntdelay += (1) * timescale
    if (tauntdelay > 50) {
        snd_play(sndLastTaunt)
        sndtaunt = 1
    }
}
