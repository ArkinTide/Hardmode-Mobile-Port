function custom_sound_check(_sound) {
    if(variable_global_exists("hm_sound_replacements"))
        _sound=global.hm_sound_replacements[$ string(_sound)] ?? _sound;
    return global.custom_sounds[$ string(_sound)] ?? _sound;
}
