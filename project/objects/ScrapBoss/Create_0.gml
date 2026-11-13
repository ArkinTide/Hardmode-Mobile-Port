raddrop = 90
max_hp = ceil(300 * (1 + GameCont.loops / 1.2))
meleedamage = 0
size = 3

spr_idle = sprScrapBossIdle
spr_walk = sprScrapBossWalk
spr_hurt = sprScrapBossHurt
spr_dead = sprScrapBossDead
spr_fire = sprScrapBossFire

event_inherited()

right = 1

scrTarget()

if instance_exists(target) {
    gunangle = mcr_target_direction
} else gunangle = 0

alarm[0] = 30
ammo = 15
turn = choose(1, -1)
walk = 0

if !snd_is_playing(musBoss2) {
    with MusCont {
        alarm[2] = 1
    }
}

dir = random_angle
repeat(10) {
    with instance_create(x, y, Dust) {
        motion_add(other.dir, (8) * timescale)
    }

    dir += 36
}

with Wall {
    if (place_meeting(x, y, other)) scrWallDestroy(id)
}

snd_hurt = sndBigDogHit
snd_dead = sndBigDogDeath

sndhalfhp = 0
sndtaunt = 0
tauntdelay = 0

if instance_exists(Player) {
    with (Raven) scrRavenLift()
}

spr_shadow = shd96

alarm[2] = 20

hitid = HitId.BigDog
// The authored eye-opening animation belongs to the boss, including bosses
// created outside the junkyard script task. Extra bosses appear directly.
hm_dog_native_intro1116=scrHMEnabled() && !(instance_exists(GameCont) && (variable_instance_get(GameCont,"hm_extra_pending")??false))
hm_dog_open1116=hm_dog_native_intro1116 ? 0 : 11
