// Touch-accessible equivalents of the frozen MOD's console options.
function scrHMMobileOptions() {
    scrOptionsMenuCategoryBegin(OptionCategory.Hardmode);
    var _fields=["intropan","bossoutros","rads","weaponnames","portals","rogue","flames"];
    var _names=["BOSS INTRO CAMERA","BOSS OUTROS","ENEMIES ABSORB RADIATION","MOD WEAPON NAMES",
        "MOD PORTAL EFFECTS","MOD ROGUE PICKUPS","MOD FLAME EFFECTS"];
    for(var _i=0;_i<array_length(_fields);++_i) {
        scrOptionsMenuCreateElement({type:"button",name:scrHMLocalize(_names[_i]),hm_setting:_fields[_i],halign:fa_left,
            click:function(_opt) {scrHMModCall("mod","options","chat_command",_opt.hm_setting);},
            get_value:function(_opt) {return scrHMModGet("mod","options",_opt.hm_setting)=="1"?OPTION_ON:OPTION_OFF;}});
    }
    scrOptionsMenuCategoryEnd();
}

// Save only the module fields that are state. Sprites, sounds, code and room
// instance IDs must be recreated by the current build and area generation.
function scrHMStateFields() {
    return [
        ["mod:maincode",["gce","vans","runcount","venuz"]],
        ["area:elevator",["nextarea"]],
        ["area:jungle",["jw_set_bigbandit_to_set_the_subarea_to_3_when_they_spawn"]],
        ["mod:bosses/turtles",["seenturtles"]],
        ["area:venuz",["kills","items","time","secrets"]]
    ];
}
function scrHMStateCapture() {
    var _state={version:1,modules:{}},_schema=scrHMStateFields();
    for(var _i=0;_i<array_length(_schema);++_i) {
        var _key=_schema[_i][0],_fields=_schema[_i][1],_values={};
        for(var _j=0;_j<array_length(_fields);++_j) {
            var _field=_fields[_j],_value=global.hm_module_vars[$ _key][$ _field];
            if(is_real(_value)||is_string(_value)||is_bool(_value)) _values[$ _field]=_value;
        }
        _state.modules[$ _key]=_values;
    }
    return _state;
}
function scrHMStateRestore(_state) {
    if(!is_struct(_state)||_state[$ "version"]!=1||!is_struct(_state[$ "modules"])) return;
    var _schema=scrHMStateFields();
    for(var _i=0;_i<array_length(_schema);++_i) {
        var _key=_schema[_i][0],_fields=_schema[_i][1],_values=_state.modules[$ _key];
        if(!is_struct(_values)) continue;
        for(var _j=0;_j<array_length(_fields);++_j) {
            var _field=_fields[_j],_value=_values[$ _field];
            if(is_real(_value)||is_string(_value)||is_bool(_value)) global.hm_module_vars[$ _key][$ _field]=_value;
        }
    }
}
