// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
x = xstart
y = ystart

hp = max_hp

event_inherited()
