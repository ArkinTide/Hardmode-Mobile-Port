scrDrop(0, 5)
with(MusCont)
alarm[1] = 1

event_inherited()

repeat (3) scrDrop(100, 0)
// Hardmode cursed-caves post-death restoration
if(scrHMEnabled() && GameCont.area==scrHMAreaResolve("cavesinv")) with(HMWorld) scrHMBindEndStep(hm_maincode_mod_gml_CHCoutro,1,other.x,other.y);
