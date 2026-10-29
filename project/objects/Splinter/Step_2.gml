// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
/// @description Thin trail
with (scrBoltTrail()) image_yscale *= 0.8