// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if sprite_index == sprGuardianBulletSpawn {
    x -= hspeed
    y -= vspeed
}