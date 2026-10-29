/// @description click

global.index = 0
global.is_server = true

with (UberCont) {
	coop = false
	hardmode = false
	
	if (!(scrGameIsEventRun() || scrGameIsCustomMode())) {
		protowep = save_get_value("etc", "protowep", wep_rusty_revolver)
	}
	else {
		protowep = wep_rusty_revolver
	}
}

scrGameCustomModeReset()

with UberCont {
    daily_run = false
    weekly_run = false
	scr_playerinstance_reset()
}

var _image = floor(num)

// Original hard difficulty remains available.
if _image == 3 {
	UberCont.hardmode = true
}
else if _image == 4 {
	instance_destroy(PlayButton)
	instance_destroy(MainMenuButton)
	
	scrCustomModeLoadPresets()
	
	with (UberCont) {
		custom_options = custom_mode_slots[custom_mode_slot_index]
		custom = true
	}
	
	with instance_create(0, 0, MenuOptions) {
		scrOptionsMenuChangeCategory(OptionCategory.CustomMode, false)
		dispose_on_empty = true
	}
}

instance_destroy(PlayButton)
instance_destroy(MainMenuButton)

if !(instance_exists(Leaderboards)
	|| instance_exists(NicknameInput)
	|| instance_exists(MenuOptions)
) {
	instance_destroy(SpiralCont)
	instance_create(0, 0, GameCont)
	instance_create(0, 0, MenuGen)
	snd_play(sndMenuCharSelect)
}

with UberCont {
	gamepad_sel = 0
}

snd_play(sndClick)