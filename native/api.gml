// Native adapters for the APIs used by the frozen Hardmode b24 source.
// Module registries are generated from main.txt's actual load order.
function scrHMRuntimeInit() {
    global.hm_module_vars = {};
    global.hm_module_scripts = {};
    global.hm_module_aliases = {};
    global.hm_module_order = [];
    global.hm_sound_assets = {};
    global.hm_sound_replacements = {};
    global.hm_sprite_backups = {};
    global.hm_weapon_ids = {};
    global.hm_weapon_keys = {};
    global.hm_area_ids = {};
    global.hm_area_keys = {};
    global.hm_area_lengths = {};
    global.hm_camera_targets = array_create(4,noone);
    scrHMRegisterIdentities();
    scrHMTaskRuntimeInit();
    scrHMRegisterModules();
    scrHMRegisterAudio();
}

function scrHMModuleKey(_kind, _name) {
    _name = string_replace_all(_name, "\\", "/");
    if (string_pos("areas/", _name)==1) {
        _kind="area"; _name=string_delete(_name,1,6);
    } else if (string_pos("weapons/", _name)==1) {
        _kind="weapon"; _name=string_delete(_name,1,8);
    }
    if (_kind=="wep") _kind="weapon";
    if (string_copy(_name,string_length(_name)-4,5)==".area") _name=string_delete(_name,string_length(_name)-4,5);
    var _key=_kind+":"+_name;
    return global.hm_module_aliases[$ _key] ?? _key;
}

function scrHMRegisterModule(_key, _scripts) {
    assert(!variable_struct_exists(global.hm_module_vars,_key),"Duplicate Hardmode module: "+_key);
    global.hm_module_vars[$ _key]={};
    global.hm_module_scripts[$ _key]=_scripts;
    array_push(global.hm_module_order,_key);
}

function scrHMModExists(_kind, _module, _field) {
    var _key=scrHMModuleKey(_kind,_module);
    return variable_struct_exists(global.hm_module_vars,_key)
        && variable_struct_exists(global.hm_module_vars[$ _key],_field);
}

function scrHMModGet(_kind, _module, _field) {
    var _key=scrHMModuleKey(_kind,_module);
    assert(variable_struct_exists(global.hm_module_vars,_key),"Unknown Hardmode module: "+_key);
    return global.hm_module_vars[$ _key][$ _field];
}

function scrHMModSet(_kind, _module, _field, _value) {
    var _key=scrHMModuleKey(_kind,_module);
    assert(variable_struct_exists(global.hm_module_vars,_key),"Unknown Hardmode module: "+_key);
    global.hm_module_vars[$ _key][$ _field]=_value;
    return _value;
}

function scrHMScriptRef(_code) {
    // Capture code, not a creation-time instance. Callback self is the object
    // receiving the event; a creator can disappear before a callback runs.
    return is_method(_code) ? method_get_index(_code) : _code;
}

function scrHMOther(_scope) {
    // Calling a resumable function as a struct member changes GML's physical
    // other to its task. Expose the source's logical other to nested calls.
    if(is_struct(_scope) && variable_struct_exists(_scope,"other_scope")) return scrHMOther(_scope.other_scope);
    // Modern native with supplies the instance scope object. NTT's other
    // was an instance ID, used in creator filters and persisted by forks.
    // Normalize it before assigning creator/parent or comparing identities.
    if(!is_undefined(_scope) && instance_exists(_scope)) return _scope.id;
    return _scope;
}

function scrHMInvoke(_scope, _code, _args) {
    _code=scrHMScriptRef(_code);
    if(_scope==id) return scrHMInvokeHere(_code,_args);
    var _result;
    with(_scope) _result=scrHMInvokeHere(_code,_args);
    return _result;
}

function scrHMInvokeHere(_code, _args) {
    switch(array_length(_args)) {
        case 0: return script_execute(_code);
        case 1: return script_execute(_code,_args[0]);
        case 2: return script_execute(_code,_args[0],_args[1]);
        case 3: return script_execute(_code,_args[0],_args[1],_args[2]);
        case 4: return script_execute(_code,_args[0],_args[1],_args[2],_args[3]);
        case 5: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4]);
        case 6: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5]);
        case 7: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6]);
        case 8: return script_execute(_code,_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],_args[7]);
    }
    throw "Hardmode invocation exceeds audited arity";
}

function scrHMModCall(_kind, _module, _name) {
    var _key=scrHMModuleKey(_kind,_module);
    // b24 labs.area:122 spells the first tube differently from props:2172.
    // Keep the supplied source frozen and resolve only this proven typo.
    if(_key=="mod:props" && _name=="bigtube_create") _name="bigtube1_create";
    assert(variable_struct_exists(global.hm_module_scripts,_key),"Unknown Hardmode module: "+_key);
    var _scripts=global.hm_module_scripts[$ _key];
    assert(variable_struct_exists(_scripts,_name),"Unknown Hardmode function: "+_key+"::"+_name);
    var _args=[];
    for(var _i=3;_i<argument_count;++_i) array_push(_args,argument[_i]);
    return scrHMInvoke(id,_scripts[$ _name],_args);
}

function scrHMFieldName(_name) {
    switch(_name) {
        case "my_health": return "hp";
        case "maxhealth": return "max_hp";
        case "race_id": return "race";
        case "kills": return "givekill";
        case "new": return "hm_field_new";
        case "canwalk": return "can_walk";
        case "canpick": return "can_pick";
        case "canspec": return "can_spec";
        case "canaim": return "can_aim";
        case "candie": return "can_die";
        case "canswap": return "can_swap";
        case "force": return "knockback_speed";
        case "shadcol": return "shadow_color";
    }
    return _name;
}

function scrHMVariableExists(_target, _field) {
    _field=scrHMFieldName(_field);
    if(is_struct(_target)) return variable_struct_exists(_target,_field);
    return instance_exists(_target) && variable_instance_exists(_target,_field);
}

function scrHMFieldGet(_target, _field) {
    _field=scrHMFieldName(_field);
    if(is_struct(_target)) return _target[$ _field];
    if(!instance_exists(_target)) return undefined;
    if(string_length(_field)==6 && string_copy(_field,1,5)=="alarm") {
        var _index=real(string_char_at(_field,6));
        return _target.alarm[_index];
    }
    if(!variable_instance_exists(_target,_field)) return undefined;
    return variable_instance_get(_target,_field);
}

function scrHMFilter(_target, _field, _values, _operation) {
    _field=scrHMFieldName(_field);
    for(var _j=0;_j<array_length(_values);++_j) {
        var _expected=_values[_j];
        if(_field=="object_index" && is_string(_expected)) _expected=asset_get_index(_expected);
        if(_field=="wep"||_field=="bwep") _expected=scrHMWeaponResolve(_expected);
        if(_field=="area"||_field=="lastarea") _expected=scrHMAreaResolve(_expected);
        if(_field=="race") _expected=scrHMRaceResolve(_expected);
        _values[_j]=_expected;
    }
    var _found=[],_items=scrHMInstances(_target);
    for(var _i=0;_i<array_length(_items);++_i) {
        var _item=_items[_i],_value=undefined,_match=false;
        // The snapshot is built immediately before this read and nothing in
        // this loop destroys instances. Preserve missing-field semantics.
        if(_field=="object_index") _value=_item.object_index;
        else if(string_length(_field)==6 && string_copy(_field,1,5)=="alarm")
            _value=_item.alarm[real(string_char_at(_field,6))];
        else if(variable_instance_exists(_item,_field)) _value=variable_instance_get(_item,_field);
        for(var _j=0;_j<array_length(_values);++_j) {
            var _expected=_values[_j];
            switch(_operation) {
                case 0: _match=(_value==_expected); break;
                case 1: _match=(_value==_expected); break;
                // Missing fields never participate in ordered comparisons.
                case 2: _match=!is_undefined(_value)&&_value>=_expected; break;
                case 3: _match=!is_undefined(_value)&&_value>_expected; break;
                case 4: _match=!is_undefined(_value)&&_value<=_expected; break;
                case 5: _match=!is_undefined(_value)&&_value<_expected; break;
            }
            if(_match) break;
        }
        if(_operation==1) _match=!_match;
        if(_match) array_push(_found,_item);
    }
    return _found;
}

function scrHMMatching(_target, _field) {
    var _values=[]; for(var _i=2;_i<argument_count;++_i) array_push(_values,argument[_i]);
    return scrHMFilter(_target,_field,_values,0);
}
function scrHMMatchingNE(_target, _field) {
    var _values=[]; for(var _i=2;_i<argument_count;++_i) array_push(_values,argument[_i]);
    return scrHMFilter(_target,_field,_values,1);
}
function scrHMMatchingGE(_target,_field,_value) { return scrHMFilter(_target,_field,[_value],2); }
function scrHMMatchingGT(_target,_field,_value) { return scrHMFilter(_target,_field,[_value],3); }
function scrHMMatchingLE(_target,_field,_value) { return scrHMFilter(_target,_field,[_value],4); }
function scrHMMatchingLT(_target,_field,_value) { return scrHMFilter(_target,_field,[_value],5); }

function scrHMDelete(_target) {
    // instance_delete in NTT deliberately skips destroy/drop callbacks.
    var _items=scrHMInstances(_target);
    for(var _i=0;_i<array_length(_items);++_i) instance_destroy(_items[_i],false);
}

function scrHMSoundAdd(_path) {
    assert(variable_struct_exists(global.hm_sound_assets,_path),"Unregistered Hardmode audio: "+_path);
    return global.hm_sound_assets[$ _path];
}
// Compiled MOD resources are owned by the runner, while resource packs own
// dynamic audio streams. Keep their ownership separate during game cleanup.
function scrHMSoundAssign(_sound,_replacement) { global.hm_sound_replacements[$ string(_sound)]=_replacement; }
function scrHMSoundRestore(_sound) { variable_struct_remove(global.hm_sound_replacements,string(_sound)); }
// The three b24 playback return values are stored in snd_hurt/snd_dead.
// Keep those reusable asset IDs; a modern playback handle expires and cannot
// be passed to audio_play_sound_at by the inherited damage event.
function scrHMSoundPlay(_sound) { snd_play(_sound);return _sound; }
function scrHMSoundPitch(_sound,_pitch) { return scrHMSoundPitchVolume(_sound,_pitch,1); }
function scrHMSoundPitchVolume(_sound,_pitch,_volume) {
    _volume=clamp(_volume,0,1);
    // The source's inverse-distance splash can be emitted by several tiles
    // in one tick. NTT gain saturates at full volume; modern gain does not.
    if(_sound==sndSewerDrip && instance_exists(HMWorld)) {
        if((variable_instance_get(HMWorld,"hm_water_sound_tick")??-100)+3>HMWorld.logic_serial) return _sound;
        HMWorld.hm_water_sound_tick=HMWorld.logic_serial;
        _volume*=.35;
    }
    static _slime=[sndFootSlime1,sndFootSlime2,sndFootSlime3,sndFootSlime4,sndFootSlime5,sndFootSlime6];
    if(array_contains(_slime,_sound)) _volume*=.35;
    var _handle=snd_play(_sound);
    if(_handle>=0) {audio_sound_pitch(_handle,_pitch);audio_sound_gain(_handle,_volume*UberCont.opt_sndvol,0);}
    return _sound;
}
function scrHMSoundLoop(_sound) {
    return audio_play_sound_on(UberCont.mainsound,custom_sound_check(_sound),true,1,1,0);
}
function scrHMSoundStop(_sound) { audio_stop_sound(custom_sound_check(_sound)); }
function scrHMSoundStopAll() { audio_stop_all(); }
function scrHMSoundMusic(_sound) {
    with(MusCont) {
        var _next=custom_sound_check(_sound);
        if(song!=_next || !audio_is_playing(song)) {
            if(audio_exists(song)) audio_stop_sound(song);
            song=_next;
            music_sound=snd_play_music(song,true);
        }
        hm_music_desired=_next;
        alarm[0]=-1;
        alarm[1]=-1;alarm[3]=-1;
    }
}
function scrHMSoundAmbient(_sound) {
    with(MusCont) {
        var _next=custom_sound_check(_sound);
        if(amb!=_next || !audio_is_playing(amb)) {
            if(audio_exists(amb)) audio_stop_sound(amb);
            amb=_next;
            snd_play_ambience(amb);
        }
    }
}

function scrHMSpriteReplace(_target,_replacement) {
    var _key=string(_target);
    if(!variable_struct_exists(global.hm_sprite_backups,_key)) global.hm_sprite_backups[$ _key]=sprite_duplicate(_target);
    sprite_assign(_target,_replacement);
    return _target;
}
function scrHMSpriteRestore(_target) {
    var _key=string(_target);
    if(variable_struct_exists(global.hm_sprite_backups,_key)) sprite_assign(_target,global.hm_sprite_backups[$ _key]);
}

function scrHMWeaponName(_weapon) { return scr_weapon_get_name(scrHMWeaponResolve(_weapon)); }
function scrHMWeaponSprite(_weapon) { return scr_weapon_get_sprite(scrHMWeaponResolve(_weapon)); }
function scrHMWeaponType(_weapon) { return scr_weapon_get_type(scrHMWeaponResolve(_weapon)); }
function scrHMWeaponSetName(_weapon,_name) { wep_name[scrHMWeaponResolve(_weapon)]=_name; }
function scrHMWeaponSetArea(_weapon,_area) { wep_area[scrHMWeaponResolve(_weapon)]=_area; }
function scrHMWeaponResolve(_weapon) {
    if(is_numeric(_weapon)) return _weapon;
    assert(variable_struct_exists(global.hm_weapon_ids,_weapon),"Unknown Hardmode weapon: "+string(_weapon));
    return global.hm_weapon_ids[$ _weapon];
}
function scrHMWeaponList(_list,_minimum,_maximum) {
    for(var _i=1;_i<=maxwep;++_i) {
        var _area=scr_weapon_get_area(_i);
        if(_area>=_minimum&&_area<=_maximum) ds_list_add(_list,_i);
    }
}
function scrHMWeaponPost(_kick,_shift,_shake) { scr_weapon_post(gunangle,_shift,_shake,_kick); }
function scrHMPlayerFind(_index) {
    var _found=noone;
    with(Player) if(index==_index) {_found=id;break;}
    return _found;
}
function scrHMPlayerFire(_direction) {
    // NTT player_fire's argument is aim direction, not a weapon ID. The
    // opening Venus scene already pays its one round in the source script.
    var _old=gunangle;gunangle=_direction;
    var _result=scrFire(scrHMWeaponResolve(wep),false);
    gunangle=_old;return _result;
}
function scrHMButtonValue(_index,_action,_prefix) {
    if(_action=="okay") {
        if(_index!=global.index) return false;
        if(KeyCont.touch[_index]) {
            var _touch=KeyCont[$ _prefix+"_pick"];
            return _touch[_index];
        }
        if(UberCont.opt_gamepad) return (_prefix=="press")
            ? input_gamepad_check_pressed(_index,gp_face1) : input_gamepad_check(_index,gp_face1);
        return (_prefix=="press")?scr_keyboard_check_pressed(vk_enter):scr_keyboard_check_held(vk_enter);
    }
    var _key=_prefix+"_"+_action;
    if(!variable_struct_exists(KeyCont,_key)) return false;
    var _values=KeyCont[$ _key];
    return _index>=0&&_index<array_length(_values)&&_values[_index];
}
function scrHMButtonCheck(_index,_action) { return scrHMButtonValue(_index,_action,"hold"); }
function scrHMButtonPressed(_index,_action) { return scrHMButtonValue(_index,_action,"press"); }
function scrHMGetSkill(_skill) { return scr_skill_get(_skill); }
function scrHMSetSkill(_skill,_value) { return scr_skill_set(_skill,_value); }

function scrHMPrivateFile(_path) {
    assert(is_string(_path)&&string_pos("..",_path)==0&&string_pos(":",_path)==0
        &&string_pos("/",_path)==0&&string_pos("\\",_path)==0,"Invalid Hardmode settings filename");
    return game_directory+_path;
}
function scrHMFileExists(_path) { return file_exists(scrHMPrivateFile(_path)); }
function scrHMFileLoad(_path) { scrHMPrivateFile(_path);return 0; }
function scrHMFileUnload(_path) { scrHMPrivateFile(_path); }
function scrHMStringLoad(_path) {
    var _file=file_text_open_read(scrHMPrivateFile(_path)),_text="";
    while(!file_text_eof(_file)) {
        _text+=file_text_read_string(_file);file_text_readln(_file);
        if(!file_text_eof(_file)) _text+="\n";
    }
    file_text_close(_file);return _text;
}
function scrHMStringSave(_text,_path) {
    var _target=scrHMPrivateFile(_path),_temporary=_target+".tmp";
    var _file=file_text_open_write(_temporary);
    file_text_write_string(_file,_text);file_text_close(_file);
    var _buffer=buffer_load(_temporary);
    buffer_save(_buffer,_target);
    buffer_delete(_buffer);
    file_delete(_temporary);
}
function scrHMTrace() {
    var _text="Hardmode: ";
    for(var _i=0;_i<argument_count;++_i) _text+=scrHMLocalize(string(argument[_i]))+" ";
    show_debug_message(_text);
}
function scrHMDrawText(_x,_y,_text) {
    var _font=scrHMTextFont();
    draw_text_nt(_x,_y,string_replace_all(scrHMLocalize(_text),"#","\n"));
    draw_set_font(_font);
}
// NTT's GMS1 drawing calls deliberately do nothing for the no-sprite value.
// Actors created after their step may not choose an idle sprite until next tick.
function scrHMDrawSprite(_sprite,_subimage,_x,_y) {
    if(_sprite==-1) return;
    draw_sprite(_sprite,_subimage,_x,_y);
}
function scrHMDrawSpriteExt(_sprite,_subimage,_x,_y,_xs,_ys,_angle,_color,_alpha) {
    if(_sprite==-1) return;
    draw_sprite_ext(_sprite,_subimage,_x,_y,_xs,_ys,_angle,_color,_alpha);
}
function scrHMDrawTextShadow(_x,_y,_text) {
    var _font=scrHMTextFont();_text=scrHMLocalize(_text);
    var _color=draw_get_color();draw_set_color(c_black);draw_text(_x+1,_y+1,_text);
    draw_set_color(_color);draw_text(_x,_y,_text);
    draw_set_font(_font);
}
function scrHMPointSeen(_x,_y,_view) {
    var _camera=view_camera[_view];
    return point_in_rectangle(_x,_y,camera_get_view_x(_camera),camera_get_view_y(_camera),
        camera_get_view_x(_camera)+camera_get_view_width(_camera),camera_get_view_y(_camera)+camera_get_view_height(_camera));
}

function scrHMMotionAdd(_direction,_speed) { motion_add(_direction,_speed*timescale); }
function scrHMMotionSet(_direction,_speed) { motion_set(_direction,_speed*timescale); }
function scrHMMoveTowardsPoint(_x,_y,_speed) { move_towards_point(_x,_y,_speed*timescale); }
function scrHMScaledIncrement(_scope,_field,_delta,_post,_factor) {
    var _previous=variable_instance_get(_scope,_field)/_factor;
    variable_instance_set(_scope,_field,(_previous+_delta)*_factor);
    return _post?_previous:(_previous+_delta);
}
