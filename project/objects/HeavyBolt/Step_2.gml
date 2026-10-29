// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
/// @description Heavy trail
with (scrBoltTrail()) image_yscale = 1.2