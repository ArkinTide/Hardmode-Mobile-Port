// Mobile 1.1.1: lifecycle-safe level cap and targeted boss camera pans.
function scrHMLevelCap1101() {
    var _base=scrCustomParam("maxlevel",10);
    if(!scrHMEnabled() || !instance_exists(GameCont)) return _base;
    if(!variable_instance_exists(GameCont,"hm_maxlevel1100")) scrHMContentInit1100();
    return variable_instance_get(GameCont,"hm_maxlevel1100");
}

function scrHMBossCameraEligible1101(_actor) {
    if(!instance_exists(_actor) || !instance_exists(GameCont)) return false;
    if(variable_instance_exists(_actor,"hm_extra") && _actor.hm_extra) return false;
    if(_actor.object_index==YVBoss) return true;
    var _name=_actor[$ "name"]??"";
    if(_name=="hm_yv_phase") return true;
    return GameCont.area!=scrHMAreaResolve("venuz") && array_contains(["GunGod","gungod"],_name);
}

function scrHMBossCamera1101(_actor,_exit) {
    if(!scrHMEnabled() || !scrHMBossCameraEligible1101(_actor) || instance_exists(GenCont)
       || !instance_exists(Player) || instance_exists(SpiralCont) || !instance_exists(HMWorld)) return false;
    var _flag=_exit?"hm_exit_camera1101":"hm_entry_camera1101";
    if(_actor[$ _flag]??false) return false;
    if(scrHMModGet("mod","options",_exit?"bossoutros":"intropan")!="1") {
        _actor[$ _flag]=true;
        return false;
    }
    if(instance_exists(HMWorld.hm_portrait_active)) return false;
    // A blank title requests the existing camera pan without a loop portrait.
    // The presentation controller owns its coordinates after actor destruction.
    hm_bosses_bossintros_mod_gml_boss_trigger("",mskNone,mskNone,mskNone,_actor,0);
    var _intro=HMWorld.hm_portrait_active;
    if(!instance_exists(_intro)) return false;
    _intro.hm_camera1101=true;
    _intro.hm_camera_exit1101=_exit;
    _intro.hm_camera_actor1101=_actor;
    _actor[$ _flag]=true;
    return true;
}

function scrHMBossCameraTick1101() {
    if(!scrHMBossCameraEligible1101(id)) return;
    if(can_die && hp<=0) {scrHMBossCamera1101(id,true);return;}
    // GunGod is drawn by on_draw at full opacity; its base sprite stays alpha 0.
    if(hp>0 && (image_alpha>0 || name=="GunGod") && mask_index!=mskNone) scrHMBossCamera1101(id,false);
}

function scrHMVanBodyHurt1101(_damage,_knockback,_direction) {
    var _sprite=sprite_index,_mask=mask_index,_callback=on_hurt;
    // The NTT callback delegates once to native Van damage. instance_change
    // retains fields, so leaving on_hurt installed re-enters this callback
    // through both projectile_hit and hit until the VM exhausts its stack.
    on_hurt=undefined;
    hm_arkintide_mod_gml_hm_extra_change(Van);
    var _hit=scr_projectile_hit(id,_damage,_knockback,_direction);
    hm_arkintide_mod_gml_hm_extra_change(CustomHitme);
    sprite_index=_sprite;mask_index=_mask;on_hurt=_callback;
    return _hit;
}

function scrHMBossTitleLayout1101(_width,_text) {
    var _previous=draw_get_font();
    var _font=fntCJK;
    draw_set_font(_font);
    var _label=scrHMLocalize(string(_text));
    // Atlas padding is not visible glyph height (CJK raw height is 27).
    // Use corrected metrics and the existing compact Latin/CJK glyph atlas.
    var _w=max(1,font_get_string_width(_label)),_h=max(1,font_get_string_height(_label));
    var _scale=min(.75,max(1,_width-4)/_w,10/_h);
    var _offset=font_get_height_diff()*_scale;
    draw_set_font(_previous);
    return {label:_label,font:_font,offset:_offset,scale:_scale,width:_w*_scale,height:_h*_scale};
}

function scrHMBossTitle1101(_x,_top,_width,_text) {
    var _layout=scrHMBossTitleLayout1101(_width,_text);
    var _font=draw_get_font(),_color=draw_get_color();
    var _y=floor(_top-3-_layout.height-_layout.offset);
    draw_set_font(_layout.font);draw_set_color(c_black);
    draw_text_transformed(round(_x)+1,_y+1,_layout.label,_layout.scale,_layout.scale,0);
    draw_set_color(_color);
    draw_text_transformed(round(_x),_y,_layout.label,_layout.scale,_layout.scale,0);
    draw_set_font(_font);
}
