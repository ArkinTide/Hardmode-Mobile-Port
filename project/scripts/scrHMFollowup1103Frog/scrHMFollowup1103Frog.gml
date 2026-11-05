// Mobile follow-up: the host's sole Exploder -> SuperFrog replacement is
// its ToxicGas collision. Suppress only that replacement while an ordinary
// enemy frog is physically supported by sewer water. Do not use the cached
// swimming flag: it can still describe the previous bank/logic tick.
function scrHMFrogWaterConversionBlocked1103() {
    if(!scrHMEnabled() || !instance_exists(GameCont) || object_index!=Exploder) return false;
    if(GameCont.area!=area_sewers && scrHMAreaKey(GameCont.area)!="area:sewers") return false;
    return scrHMSwimSupported112(x,y);
}
