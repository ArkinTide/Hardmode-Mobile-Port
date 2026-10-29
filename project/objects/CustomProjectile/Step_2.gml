// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if(!scrHMReadyTick()) exit;
if(!lockstep_stop) scrHMActorCallback("on_end_step");
