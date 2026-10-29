// Translate presentation only: names used as AI keys, module IDs, saves and
// callback arguments remain the original English strings.
function scrHMChinese() {
    return variable_global_exists("language_current")
        && is_struct(global.language_current)
        && global.language_current[$ "Init:Id"]=="Simplified Chinese";
}

function scrHMLocalize(_text) {
    if(!is_string(_text) || !scrHMChinese()) return _text;
    // Retain compatibility with the shipped iOS runner's older builtin set.
    var _begin=1,_last=string_length(_text);
    while(_begin<=_last && ord(string_char_at(_text,_begin))<=32) _begin++;
    while(_last>=_begin && ord(string_char_at(_text,_last))<=32) _last--;
    var _core=string_copy(_text,_begin,_last-_begin+1);
    if(_core=="") return _text;
    var _catalog=scrHMLocalizationCatalog();
    var _translated=_catalog[$ string_upper(_core)];
    // Boss introductions turn spaces into GMS1 newline markers.
    if(is_undefined(_translated) && string_pos("#",_core)>0)
        _translated=_catalog[$ string_upper(string_replace_all(_core,"#"," "))];
    // Recoverable arrows use variable counts, e.g. +3 BOLTS.
    if(is_undefined(_translated) && string_char_at(_core,1)=="+") {
        var _space=string_pos(" ",_core);
        if(_space>2) {
            var _number=true;
            for(var _i=2;_i<_space;++_i) {
                var _ord=ord(string_char_at(_core,_i));
                if(_ord<48||_ord>57) _number=false;
            }
            var _unit=_catalog[$ string_upper(string_delete(_core,1,_space))];
            if(_number&&!is_undefined(_unit)) _translated=string_copy(_core,1,_space)+_unit;
        }
    }
    if(is_undefined(_translated)) return _text;
    var _end=_begin+string_length(_core);
    return string_copy(_text,1,_begin-1)+_translated
        +string_copy(_text,_end,string_length(_text));
}

function scrHMLocFallback(_key,_text) {
    var _translated=scrHMLocalize(_text);
    // An existing base-game translation always keeps its original wording.
    return global.language_current[$ _key] ?? _translated;
}

function scrHMTextFont() {
    var _font=draw_get_font();
    if(scrHMChinese())
        draw_set_font(_font==fntBig?global.language_font_bigname_default:global.language_font_default);
    return _font;
}

function scrHMDrawTextPlain(_x,_y,_text) {
    var _font=scrHMTextFont();
    draw_text(_x,_y,scrHMLocalize(string(_text)));
    draw_set_font(_font);
}

function scrHMDrawTextTransformed(_x,_y,_text,_xs,_ys,_angle) {
    var _font=scrHMTextFont();
    draw_text_transformed(_x,_y,scrHMLocalize(string(_text)),_xs,_ys,_angle);
    draw_set_font(_font);
}
