/// @function scrBossIntro
/// @param art_index
function scrBossIntro(_boss_index,_force=false) {
    if(scrHMExtraPresentation1104(id)) return;
    if(scrHMEnabled() && instance_exists(GameCont) && GameCont.loops>0 && !_force) return;
    if(scrHMBossNativeRequest1116(_boss_index)) return;
    with UberCont {
        if instance_exists(CoopController) || !opt_bossintro || !instance_exists(Player) exit
		
		scrGetPauseImage()
		scrLetterbox(true)
		
        want_pause = true
		paused = true
		
		snd_play(sndBossIntroIn)
		
        bossintro = true
        scrHMBossPresentationNative115(true);
        boss = _boss_index
        splatindex = 0
        bossnamex = 0
        insound = 0
        outsound = 0
        bossx = 320
        alarm[2] = 40
    }
}
