raddrop = 20
// One ordinary boss budget. The inherited enemy applies common Loop scaling.
max_hp = scrHMEnabled() ? (140 + ((variable_instance_get(GameCont,"hm_extra_pending")??false) ? 0 : 50 * instance_number(Player))) : (140 * (1 + (GameCont.loops / 3)))
meleedamage = 0
size = 1
spr_idle = sprLilHunter
spr_walk = sprLilHunter
spr_hurt = sprLilHunterHurt
spr_dead = sprLilHunterDead
event_inherited()
hitid = HitId.LilHunter
snd_hurt = sndLilHunterHurt
snd_dead = sndLilHunterDeath
walk = 0
gunangle = random_angle
forceliftoff = false
wkick = 0
dodge = 0
z = 0
intro = 0
spawns = 6

alarm[1] = irandom_range(30, 120)
alarm[2] = 30

sndtaunt = 0
tauntdelay = 0
sndhalfhp = 0

hitid = HitId.LilHunter
