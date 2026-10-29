// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
// Water membership follows this frame movement.
if(!lockstep_stop && !UberCont.paused) scrHMSwimPlayer105();
