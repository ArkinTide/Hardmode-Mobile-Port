// The native health-dependent pause remains intact. The Loop1+ factor is
// this release's requested balance adjustment, not a desktop-derived value.
function scrHMChiefDecisionDelay1117() {
    var _delay=10+(hp/max_hp)*15;
    if(scrHMEnabled() && instance_exists(GameCont) && GameCont.loops>0) _delay*=.8;
    return _delay;
}
