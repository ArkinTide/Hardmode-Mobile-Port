if lockstep_stop
	exit

if isset("appeary") {
    if appeary > 0 {
	    appeary = lerp(appeary, -1, 0.8)
		
	    if appeary <= 0 {
	        snd_play_pitch(sndMutAppear, random(0.9) + 0.1)
	        appeary = 0
	    }
	}
}
else {
	appeary = num * 32
}

var _x = x, _y = y + appeary - sign(selected),
	_blend = (selected ? c_white : c_gray),
	_cancel = variable_instance_exists(id,"hm_l2_cancel1103") && hm_l2_cancel1103,
	txt2;

if (_cancel) {
	draw_sprite_ext(sprSkillIcon, mut_patience, _x, _y, 1, 1, 0, _blend, 1)
}
else if (race != Race.CoopUltra) {
	var _index = (race - 1) * 3 + num - 1
	draw_sprite_ext(sprite_index, _index, _x, _y, 1, 1, 0, _blend, 1)
}
else {
	draw_sprite_ext(sprCoopSkillIcon, num - 1, _x, _y, 1, 1, 0, _blend, 1)
}

draw_align(fa_center, fa_middle)

if (_cancel) {
	txt2 = "@w" + scrHMLocalize("CANCEL SELECTION") + "#@s"
		 + scrHMLocalize("KEEP CURRENT ULTRA MUTATIONS") + "@s"
}
else {
	txt2 = "@w" + loc("Races", race, "Ultra", num, "Name", scrRaceGetUltraSkillName(race, num)) + "#"
		 + "@s" + loc("Races", race, "Ultra", num, "Text", scrRaceGetUltraSkillText(race, num)) + "@s"
}

if selected {
    draw_text_nt(round(view_width / 2), round(view_height - 61 - selected), txt2)
	if (selected < 3) selected ++
}

draw_align()
