/// @description Draw wrapper
var _current_category = category

with (ResourcepackManager) {
	depth = other.depth - 1
}

// Draw
event_user(0)

if (!editing_mode) {
	with (UberCont) if (letterbox_frame != 0) {
		scrDrawLetterbox(letterbox_frame, true)
	}
}

if (_current_category == OptionCategory.Hardmode && !editing_mode) {
	var _header_color = draw_get_color(), _header_alpha = draw_get_alpha()
	draw_set_color(c_black)
	draw_set_alpha(1)
	draw_rectangle(0, 0, gui_w, LETTERBOX_SIZE, false)
	draw_set_color(_header_color)
	draw_set_alpha(_header_alpha)
}

#region Header

draw_align(fa_center, fa_middle)
var _name = loc("MainMenu:Settings", "SETTINGS"), _handled = false

with (CustomModeMenu) if (is_string(name)) {
	_name = name
	_handled = true
}

if (!_handled && _current_category != OptionCategory.Main) {
	var _main_options = options[OptionCategory.Main],
		_category = _current_category - 1
	
	if _category < array_length(_main_options) {
		var _opt = _main_options[_category]
		
		if (is_method(_opt.get_name)) {
			_name = method_execute(_opt.get_name, _opt)
		}
		else {
			_name = _opt.name
		}
	}
}

if (_current_category == OptionCategory.Hardmode) _name = scrHMLocalize("HARDMODE");
draw_text_bigname(gui_w div 2, 24, _name, c_uigray)

draw_align()

#endregion

if editing_mode && !UberCont.opt_gamepad {
	scrDrawMobileControls()
}
