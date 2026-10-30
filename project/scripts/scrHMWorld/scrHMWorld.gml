// Lifecycle bridge for the statically compiled, frozen Hardmode modules.
function scrHMEnabled() {
    return variable_global_exists("hm_enabled") && global.hm_enabled;
}

function scrHMReadyTick() {
    return !scrHMEnabled() || (instance_exists(HMWorld) && HMWorld.logic_tick);
}

function scrHMHook(_hook) {
    if(!scrHMEnabled()) return;
    if(instance_exists(HMWorld) && instance_exists(variable_instance_get(HMWorld,"hm_portrait_active")??noone)) {
        if(_hook=="draw_gui") scrHMInvokeHere(scrHMScriptRef(hm_bosses_bossintros_mod_gml_draw_gui),[]);
        return;
    }
    var _args=[];
    for(var _i=1;_i<argument_count;++_i) array_push(_args,argument[_i]);
    var _codes=global.hm_hook_cache[$ _hook];
    if(is_undefined(_codes)) {
        _codes=[];
        for(var _i=0;_i<array_length(global.hm_module_order);++_i) {
            var _key=global.hm_module_order[_i];
            if(string_pos("mod:",_key)!=1 && _hook!="init") continue;
            if(string_pos("area:",_key)==1) continue;
            var _code=global.hm_module_scripts[$ _key][$ _hook];
            if(!is_undefined(_code)) array_push(_codes,scrHMScriptRef(_code));
        }
        global.hm_hook_cache[$ _hook]=_codes;
    }
    for(var _i=0;_i<array_length(_codes);++_i) scrHMInvokeHere(_codes[_i],_args);
}

function scrHMWorldInit() {
    scrHMRuntimeInit();
    global.hm_enabled=true;
    global.hm_hook_cache={};
    logic_accumulator=0;logic_tick=true;logic_serial=0;
    for(var _i=0;_i<array_length(global.hm_module_order);++_i) {
        var _key=global.hm_module_order[_i];
        scrHMInvokeHere(scrHMScriptRef(global.hm_module_scripts[$ _key].__load),[]);
    }
    scrHMHook("init");
    scrHMWeaponsInit();
}

function scrHMWorldBegin() {
    logic_tick=false;
    if(lockstep_stop || UberCont.paused) return;
    logic_accumulator+=timescale;
    if(logic_accumulator>=1) {
        logic_accumulator-=1;
        logic_tick=true;
        logic_serial++;
    }
}

function scrHMWorldStep() {
    if(!logic_tick || lockstep_stop || UberCont.paused) return;
    if(instance_exists(self[$ "hm_portrait_active"]??noone)) return;
    // Resume only the tasks retained by this room. The source's new forks
    // execute immediately and first resume on the following 30 Hz tick.
    scrHMTasksTick(1);
    if(instance_exists(GameCont)) scrHMHook("step");
}

function scrHMRunStart() {
    if(!scrHMEnabled()) return;
    global.hm_tasks=[];
    with(HMWorld) scrHMHook("game_start");
}

function scrHMAreaResolve(_area) {
    if(!is_string(_area)) return _area;
    assert(variable_struct_exists(global.hm_area_ids,_area),"Unknown Hardmode area: "+_area);
    return global.hm_area_ids[$ _area];
}

function scrHMRaceResolve(_race) {
    if(!is_string(_race)) return _race;
    switch(string_lower(_race)) {
        case "fish": return Race.Fish;
        case "crystal": return Race.Crystal;
        case "eyes": return Race.Eyes;
        case "melting": return Race.Melting;
        case "plant": return Race.Plant;
        case "yv": case "venuz": return Race.Venuz;
        case "steroids": return Race.Steroids;
        case "robot": return Race.Robot;
        case "chicken": return Race.Chicken;
        case "rebel": return Race.Rebel;
        case "horror": return Race.Horror;
        case "rogue": return Race.Rogue;
        case "skeleton": return Race.Skeleton;
        case "frog": return Race.Frog;
    }
    throw "Unknown Hardmode race: "+_race;
}

function scrHMAreaKey(_area) {
    if(!scrHMEnabled() && !variable_global_exists("hm_area_keys")) return undefined;
    return global.hm_area_keys[$ string(_area)];
}

function scrHMAreaHas(_area) { return !is_undefined(scrHMAreaKey(_area)); }

function scrHMAreaCall(_area,_hook) {
    var _key=scrHMAreaKey(_area);
    if(is_undefined(_key)) return undefined;
    var _code=global.hm_module_scripts[$ _key][$ _hook];
    if(is_undefined(_code)) return undefined;
    var _args=[];
    for(var _i=2;_i<argument_count;++_i) array_push(_args,argument[_i]);
    // area_start can wait/fork after GenCont destroys itself. NTT owns this
    // event on the persistent level controller, not the disposable generator.
    if(_hook=="area_start") {
        var _result;
        with(GameCont) _result=scrHMInvokeHere(scrHMScriptRef(_code),_args);
        return _result;
    }
    return scrHMInvokeHere(scrHMScriptRef(_code),_args);
}

function scrHMAreaTransit() {
    if(area==area_vault) {subarea=1;maxsubarea=1;finalsubarea=true;return;}
    for(var _i=0;_i<array_length(global.hm_module_order);++_i) {
        var _key=global.hm_module_order[_i];
        if(string_pos("area:",_key)==1) {
            var _code=global.hm_module_scripts[$ _key].area_transit;
            scrHMInvokeHere(scrHMScriptRef(_code),[]);
        }
    }
    maxsubarea=scrAreaGetMaxSubarea(area);
    finalsubarea=(subarea==maxsubarea);
    if(waypoints>0) {waypnt[waypoints-1]=area;waysub[waypoints-1]=subarea;}
}

function scrHMAreaAdvance() {
    if(scrHMAdvanceDestination107()) return;
    var _old_area=area,_old_subarea=subarea;
    lastarea=_old_area;lastsubarea=_old_subarea;
    scrHMAreaCall(_old_area,"area_finish");
    hard++;
    waypnt[waypoints]=area;waysub[waypoints]=subarea;waylps[waypoints]=loops;waypoints++;
    scrHMAreaTransit();
}

function scrHMAssetIndex(_name) {
    // Host tile objects form names from numeric area IDs. NTT's area_sprite
    // contract instead maps the ordinary desert sprite to the active theme.
    if(!scrHMEnabled() || !instance_exists(GameCont) || !scrHMAreaHas(GameCont.area)) return asset_get_index(_name);
    var _suffix=string(GameCont.area);
    if(string_pos(_suffix,_name)==0) return asset_get_index(_name);
    var _base=asset_get_index(string_replace(_name,_suffix,"1"));
    if(_base<0) return asset_get_index(_name);
    var _mapped=scrHMAreaCall(GameCont.area,"area_sprite",_base);
    return is_undefined(_mapped)?_base:_mapped;
}

function scrHMWeaponsInit() {
    // Dynamic weapon metadata in the supplied NTT source reads GameCont.area
    // even on the title screen. Use a disposable stock controller solely for
    // initial defaults, then continue querying the live area at runtime.
    var _temporary=noone;
    if(!instance_exists(GameCont)) _temporary=instance_create(0,0,GameCont);
    for(var _i=0;_i<array_length(global.hm_module_order);++_i) {
        var _key=global.hm_module_order[_i];
        if(string_pos("weapon:",_key)!=1) continue;
        var _name=string_delete(_key,1,7),_weapon=++maxwep;
        global.hm_weapon_ids[$ _name]=_weapon;
        global.hm_weapon_ids[$ "weapons/"+_name]=_weapon;
        global.hm_weapon_keys[$ string(_weapon)]=_key;
        wep_name[_weapon]=string_upper(scrHMWeaponProperty(_key,"weapon_name",_name));
        wep_type[_weapon]=scrHMWeaponProperty(_key,"weapon_type",0);
        wep_cost[_weapon]=scrHMWeaponProperty(_key,"weapon_cost",0);
        wep_load[_weapon]=scrHMWeaponProperty(_key,"weapon_load",1);
        wep_area[_weapon]=scrHMWeaponProperty(_key,"weapon_area",-1);
        wep_auto[_weapon]=scrHMWeaponProperty(_key,"weapon_auto",false);
        wep_sprt[_weapon]=scrHMWeaponProperty(_key,"weapon_sprt",sprDefault);
        wep_text[_weapon]=scrHMWeaponProperty(_key,"weapon_text","");
        wep_swap[_weapon]=scrHMWeaponProperty(_key,"weapon_swap",sndSwapPistol);
        wep_mele[_weapon]=scrHMWeaponProperty(_key,"weapon_melee",false);
        wep_gold[_weapon]=scrHMWeaponProperty(_key,"weapon_gold",false);
        wep_rads[_weapon]=0;wep_lout[_weapon]=-1;
        wep_naim[_weapon]=false;
    }
    if(instance_exists(_temporary)) instance_destroy(_temporary,false);
}

function scrHMWeaponProperty(_key,_property,_default) {
    var _code=global.hm_module_scripts[$ _key][$ _property];
    return is_undefined(_code)?_default:scrHMInvokeHere(scrHMScriptRef(_code),[]);
}

function scrHMWeaponFire(_weapon) {
    if(!scrHMEnabled()) return false;
    var _key=global.hm_weapon_keys[$ string(_weapon)];
    if(is_undefined(_key)) return false;
    // NTT dispatches the weapon event on its carrier; top-level other is the
    // carrier too. Do not inherit an unrelated native helper's calling scope.
    with(id) scrHMInvokeHere(scrHMScriptRef(global.hm_module_scripts[$ _key].weapon_fire),[_weapon]);
    return true;
}

function scrHMWeaponStep() {
    if(!scrHMEnabled() || !scrHMReadyTick() || lockstep_stop || UberCont.paused) return;
    // NTT calls step(primary) on the carrier, once for each occupied slot.
    // Calling it on the world controller also runs global scans while the
    // weapon is absent and places player effects at the controller's origin.
    var _slots=[wep,bwep];
    for(var _slot=0;_slot<2;++_slot) {
        var _key=global.hm_weapon_keys[$ string(_slots[_slot])];
        if(is_undefined(_key)) continue;
        var _code=global.hm_module_scripts[$ _key][$ "step"];
        if(!is_undefined(_code)) with(id) scrHMInvokeHere(scrHMScriptRef(_code),[_slot==0]);
    }
}

function scrHMBindDraw(_code,_depth) {
    var _args=[];
    for(var _i=2;_i<argument_count;++_i) array_push(_args,argument[_i]);
    _code=scrHMScriptRef(_code);
    var _menu=(_code==scrHMScriptRef(hm_maincode_mod_gml_shilling)
        ||_code==scrHMScriptRef(hm_maincode_mod_gml_versionnumber)
        ||_code==scrHMScriptRef(hm_maincode_mod_gml_StablePortal)
        ||_code==scrHMScriptRef(hm_maincode_mod_gml_PortalShrink)
        ||_code==scrHMScriptRef(hm_maincode_mod_gml_bigdogintro)
        ||_code==scrHMScriptRef(hm_maincode_mod_gml_sewerboi)
        ||_code==scrHMScriptRef(hm_maincode_mod_gml_spacesewerboi)
        ||_code==scrHMScriptRef(hm_enemies_mod_gml_bigcrystaltopdraw)
        ||_code==scrHMScriptRef(hm_props_mod_gml_E)
        ||_code==scrHMScriptRef(hm_props_mod_gml_outsider_draw));
    var _binding=noone;
    // The source refreshes these one-shot rendering callbacks at 30 Hz. Retain
    // their renderer for intervening 60 FPS frames without accumulating it.
    if(_menu) {
        if(is_undefined(self[$ "hm_draw_bindings109"])) hm_draw_bindings109={};
        _binding=hm_draw_bindings109[$ string(_code)]??noone;
        if(instance_exists(_binding) && (_binding.creator!=id || _binding.hm_code!=_code)) _binding=noone;
    }
    if(!instance_exists(_binding)) _binding=instance_create(x,y,HMBinding);
    if(_menu) hm_draw_bindings109[$ string(_code)]=_binding;
    _binding.hm_menu_overlay=_menu;
    _binding.hm_refresh_tick=HMWorld.logic_serial;
    if(_code==scrHMScriptRef(hm_maincode_mod_gml_PortalShrink)) _depth=-12;
    _binding.depth=_depth;_binding.hm_code=_code;
    _binding.hm_args=_args;_binding.hm_draw=true;_binding.creator=id;
    return _binding;
}

function scrHMBindEndStep(_code,_delay) {
    var _args=[];
    for(var _i=2;_i<argument_count;++_i) array_push(_args,argument[_i]);
    var _binding=instance_create(x,y,HMBinding);
    _binding.hm_code=scrHMScriptRef(_code);_binding.hm_args=_args;
    _binding.hm_delay=_delay;_binding.creator=id;
    return _binding;
}

function scrHMBindingEndStep() {
    if(hm_menu_overlay && (!instance_exists(creator)||(hm_refresh_tick!=HMWorld.logic_serial && !instance_exists(variable_instance_get(HMWorld,"hm_portrait_active")??noone)))) {
        instance_destroy();return;
    }
    if(hm_draw || !scrHMReadyTick() || lockstep_stop || UberCont.paused) return;
    if(hm_delay>0) {hm_delay--;if(hm_delay>0)return;}
    scrHMInvokeHere(hm_code,hm_args);
}

function scrHMBindingDraw() {
    if(!hm_draw || lockstep_stop) return;
    if(hm_menu_overlay) {
        if(instance_exists(creator) && hm_code==scrHMScriptRef(hm_maincode_mod_gml_sewerboi) && !(creator[$ "swimming"]??false)) {instance_destroy();return;}
        if(!instance_exists(creator)) {instance_destroy();return;}
        var _font=draw_get_font(),_alpha=draw_get_alpha(),_color=draw_get_color();
        var _halign=draw_get_halign(),_valign=draw_get_valign();
        scrHMInvokeHere(hm_code,hm_args);
        draw_set_font(_font);draw_set_alpha(_alpha);draw_set_color(_color);
        draw_set_halign(_halign);draw_set_valign(_valign);
        return;
    }
    scrHMInvokeHere(hm_code,hm_args);
}

function scrHMMenuDrawComplete() {
    // Only audited refresh-every-tick renderers use this compiler adapter.
    // Other callbacks retain their original instance_destroy semantics.
    if(!(self[$ "hm_menu_overlay"]??false)) instance_destroy();
}


function scrHMPickupRefresh() {
    if(!scrHMEnabled() || hm_pickup_weapon==wep) return;
    wep=scrHMWeaponResolve(wep);
    hm_pickup_weapon=wep;
    name=scr_weapon_get_name(wep);
    sprite_index=scr_weapon_get_sprite(wep);
    type=scr_weapon_get_type(wep);
}


function scrHMDrawFog() {
    var _spr=self[$ "fog"]??-1;
    if(GameCont.area==area_pizza_sewers) _spr=sprFog102;
    else if(GameCont.area==area_sewers || UberCont.halloween) _spr=sprFog2;
    if(!sprite_exists(_spr)) return;
    var _w=sprite_get_width(_spr),_h=sprite_get_height(_spr);
    var _left=floor(view_xview/_w)*_w-fogscroll+sprite_get_xoffset(_spr);
    var _top=floor(view_yview/_h)*_h+sprite_get_yoffset(_spr);
    for(var _x=-1;_x<=ceil(view_width/_w)+1;++_x)
        for(var _y=-1;_y<=ceil(view_height/_h)+1;++_y)
            draw_sprite_ext(_spr,0,_left+_x*_w,_top+_y*_h,1,1,0,c_white,FOG_ALPHA);
    if(!UberCont.paused) fogscroll=(fogscroll+timescale*.5) mod _w;
}


function scrHMDrawBossLetterbox(_frame) {
    // NTT authored a 320 px letterbox. Mobile viewports can be wider.
    var _scale=view_width/sprite_get_width(sprLetterbox);
    draw_sprite_ext(sprLetterbox,_frame,0,0,_scale,1,0,c_white,1);
    draw_sprite_ext(sprLetterbox,_frame,view_width,view_height,-_scale,-1,0,c_white,1);
}
