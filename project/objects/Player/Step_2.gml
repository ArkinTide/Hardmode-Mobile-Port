// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
// Water membership follows this frame movement.
if(!lockstep_stop && !UberCont.paused) scrHMSwimPlayer105();
if(!lockstep_stop && !UberCont.paused) scrHMThronePlayerGround1115();
if(!lockstep_stop && !UberCont.paused) scrHMThroneExitPose116();
