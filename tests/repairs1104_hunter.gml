// Execute through the real gameplay driver; production 30Hz and60Hz host events remain active.
function scrHMGameplayHunter1104() {
    scrHMGameplayBossGroup115();
    scrHMGameplayCustom116();
    scrHMGameplayThrone116();
    scrHMGameplayCave116();
    scrHMGameplayCorpse116();
    if(mode=="hunter114arrival") {
        if(ticks==1) {
            hunter_seen114=false;hunter_arrival_tick114=-1;
            scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("city") && GameCont.subarea==5,
                "Hunter arrival observes the actual naturally generated5-5 room");
        }
        if(!hunter_seen114 && (instance_exists(LilHunter)||instance_exists(LilHunterFly))) {
            hunter_seen114=true;hunter_arrival_tick114=ticks;
        }
        if(ticks==295) {
            scrHMGameplayCheck(hunter_seen114 && hunter_arrival_tick114<=290,
                "normal stage Hunter appears within ten unpaused simulation seconds of generated player entry");
            show_debug_message("HARDMODE HUNTER114 ARRIVAL "+json_stringify({ticks:hunter_arrival_tick114,loops:GameCont.loops,rate:rate}));
        }
    }
    if(mode=="hunter114health") {
        if(ticks==10) {
            // Preserve the actual room controller, including absent roll
            // fields. A dedicated production controller isolates this HP
            // fixture from the independent random stage-boss replacement.
            hunter_native_controller114=GameCont.hm_native_controller_id;
            scrHMGameplayCheck(instance_exists(hunter_native_controller114)
                && hunter_native_controller114.name=="hm_native_controller",
                "health fixture preserves its actual original native room controller");
            hunter_replacement_context114=[];
            var _scopes=[HMWorld.id,GameCont.id,hunter_native_controller114];
            var _fields=[["hm_gungod_rolled","hm_gungod_replaced"],
                ["hm_native_controller_id","hm_elitebandit_step_ref","hm_yv_seen","hm_chief_seen"],
                ["hm_gungod_rolled","hm_gungod_replaced"]];
            for(var _s=0;_s<array_length(_scopes);++_s)
                for(var _f=0;_f<array_length(_fields[_s]);++_f) {
                    var _who=_scopes[_s],_key=_fields[_s][_f],_exists=variable_instance_exists(_who,_key);
                    array_push(hunter_replacement_context114,{who:_who,key:_key,exists:_exists,
                        value:_exists?variable_instance_get(_who,_key):undefined});
                }
            instance_deactivate_object(hunter_native_controller114);
            scrHMGameplayLane107();UberCont.opt_bossintro=0;
            scrHMModSet("mod","options","intropan","0");
            hunter_native_fixture114=hm_arkintide_mod_gml_hm_native_controller();
            hunter_native_fixture114.hm_gungod_rolled=true;
            hunter_native_fixture114.hm_gungod_replaced=false;
            GameCont.hm_native_controller_id=hunter_native_fixture114;
            show_debug_message("HARDMODE HUNTER114 FIXTURE CONTEXT "+json_stringify({tick:ticks,
                original_controller:hunter_native_controller114,fixture_controller:hunter_native_fixture114,
                saved_context_fields:array_length(hunter_replacement_context114),replacement_isolated:true}));
            hunter_skills114=ds_list_create();ds_list_copy(hunter_skills114,GameCont.skills);
            ds_list_clear(GameCont.skills);hunter_coop114=noone;
            scrHMGameplayCheck(is_undefined(scr_playerinstance_find(1)),"isolated co-op fixture starts with its secondary session slot free");
        }
        if(ticks>=10 && ticks<=90) {
            // Lane107 clears projectile, but explosions inherit damagesource
            // directly. Retire only hazards in/approaching this isolated test
            // lane, without changing the candidate's health or native AI.
            var _hazards=[];
            with(damagesource) if(point_distance(x,y,14256,14192)<=1024) {
                array_push(_hazards,{id:id,object:object_get_name(object_index),x:x,y:y});
                instance_destroy(id,false);
            }
            if(array_length(_hazards)>0)
                show_debug_message("HARDMODE HUNTER114 FIXTURE HAZARDS "+json_stringify({tick:ticks,removed:_hazards}));
        }
        if(ticks>=20 && ticks<=80 && (ticks-20) mod 20==0) {
            var _case=(ticks-20) div 20;
            with(enemy) instance_destroy(id,false);
            with(becomenemy) instance_destroy(id,false);
            if(instance_exists(hunter_coop114)) instance_destroy(hunter_coop114,false);
            if(!is_undefined(scr_playerinstance_find(1))) scr_playerinstance_destroy(1,false);
            ds_list_clear(GameCont.skills);
            if(_case>=2) ds_list_add(GameCont.skills,mut_scarier_face);
            if((_case mod 2)==1) {
                var _session=scr_playerinstance_create(1);
                _session.race=Race.Fish;_session.skin=0;
                hunter_coop114=scrPlayerCreate(1,Race.Fish,0);
                hunter_coop114.x=player.x;hunter_coop114.y=player.y;
                hunter_coop114.hp=100000;hunter_coop114.max_hp=100000;
            }
            hunter_health114=instance_create(player.x+80,player.y,LilHunter);
            hunter_expected114=(140+50*instance_number(Player))*(1+GameCont.loops/20);
            if(_case>=2) hunter_expected114=floor(hunter_expected114*.8);
            scrHMGameplayCheck(abs(hunter_health114.max_hp-hunter_expected114)<.001,
                "native Hunter constructor applies one common Loop, co-op and Scarier Face budget");
            hunter_health114.newintro=1;hunter_health114.intro=1;
            hunter_health114.alarm[1]=9999;hunter_health114.alarm[2]=9999;
            show_debug_message("HARDMODE HUNTER114 HEALTH CREATE "+json_stringify({tick:ticks,case_index:_case,
                actor:hunter_health114,loops:GameCont.loops,players:instance_number(Player),
                scarier_face:_case>=2,constructor_max:hunter_health114.max_hp,expected:hunter_expected114}));
        }
        if(ticks>=25 && ticks<=85 && (ticks-25) mod 20==0) {
            var _actors=[];
            with(LilHunter) array_push(_actors,{id:id,object:"LilHunter",hp:hp,max_hp:max_hp,
                intro:intro,newintro:self[$ "newintro"]??undefined,x:x,y:y,alarm1:alarm[1],alarm2:alarm[2]});
            with(LilHunterFly) array_push(_actors,{id:id,object:"LilHunterFly",hp:hp,max_hp:max_hp,x:x,y:y});
            with(LilHunterDie) array_push(_actors,{id:id,object:"LilHunterDie",x:x,y:y});
            show_debug_message("HARDMODE HUNTER114 HEALTH SIGHT "+json_stringify({tick:ticks,
                case_index:(ticks-25) div 20,expected_actor:hunter_health114,exists:instance_exists(hunter_health114),
                expected_max:hunter_expected114*(GameCont.loops>0?1.3:1),actors:_actors,
                fixture_controller:GameCont.hm_native_controller_id,
                replacement_rolled:hunter_native_fixture114.hm_gungod_rolled,
                replacement_active:hunter_native_fixture114.hm_gungod_replaced}));
            scrHMGameplayCheck(instance_exists(hunter_health114),"actual Hunter survives first-sight setup");
            var _expected=hunter_expected114*(GameCont.loops>0?1.3:1);
            scrHMGameplayCheck(hunter_health114.newintro<0 && abs(hunter_health114.max_hp-_expected)<.001,
                "natural MOD first-sight and post-hook apply one L1 bonus without extra Hunter multipliers");
            var _max=hunter_health114.max_hp;hunter_health114.hp=_max-3;
            with(hunter_health114) repeat(5) scrHMBossHealth1103();
            scrHMGameplayCheck(hunter_health114.max_hp==_max && hunter_health114.hp==_max-3,
                "repeated health sweeps preserve maximum and damage");
        }
        if(ticks==90) {
            with(enemy) instance_destroy(id,false);with(becomenemy) instance_destroy(id,false);
            if(instance_exists(hunter_coop114)) instance_destroy(hunter_coop114,false);
            if(!is_undefined(scr_playerinstance_find(1))) scr_playerinstance_destroy(1,false);
            ds_list_clear(GameCont.skills);
            var _pending_exists=variable_instance_exists(GameCont,"hm_extra_pending");
            var _pending=_pending_exists?variable_instance_get(GameCont,"hm_extra_pending"):undefined;
            var _extra=hm_arkintide_mod_gml_hm_extra_spawn("hunter",player.x+128,player.y);
            if(GameCont.loops<3) {
                scrHMGameplayCheck(_extra==noone && !instance_exists(_extra),
                    "actual extra-Hunter factory rejects Loop0 through Loop2");
                scrHMGameplayCheck(variable_instance_exists(GameCont,"hm_extra_pending")==_pending_exists
                    && (!_pending_exists || variable_instance_get(GameCont,"hm_extra_pending")==_pending),
                    "rejected extra Hunter preserves caller pending value and field presence");
            } else {
                scrHMGameplayCheck(instance_exists(_extra),"actual native extra-Hunter factory creates a combat actor");
                var _max=140*(1+.05*GameCont.loops);
                scrHMGameplayCheck(_extra.hm_extra && abs(_extra.max_hp-_max)<.001 && abs(_extra.hp-_max)<.001,
                    "extra Hunter preserves its original140 baseline with only one five-percent-per-Loop factor");
                scrHMGameplayCheck((variable_instance_get(GameCont,"hm_extra_pending")??false)==(_pending??false),
                    "native extra constructor restores its caller's pending context");
                with(_extra) repeat(5) scrHMBossHealth1103();
                scrHMGameplayCheck(abs(_extra.max_hp-_max)<.001,"normal boss sweep cannot add the L1 bonus to an extra Hunter");
                instance_destroy(_extra,false);
            }
            ds_list_copy(GameCont.skills,hunter_skills114);ds_list_destroy(hunter_skills114);
            instance_destroy(hunter_native_fixture114,false);
            instance_activate_object(hunter_native_controller114);
            scrHMGameplayCheck(instance_exists(hunter_native_controller114),
                "original native room controller survives fixture isolation and reactivation");
            for(var _i=0;_i<array_length(hunter_replacement_context114);++_i) {
                var _saved=hunter_replacement_context114[_i];
                if(_saved.exists) variable_instance_set(_saved.who,_saved.key,_saved.value);
                var _exists=variable_instance_exists(_saved.who,_saved.key);
                scrHMGameplayCheck(_exists==_saved.exists && (!_exists
                    || variable_instance_get(_saved.who,_saved.key)==_saved.value),
                    "health fixture restores exact replacement context value and field presence: "+_saved.key);
            }
            show_debug_message("HARDMODE HUNTER114 FIXTURE RESTORED "+json_stringify({tick:ticks,
                controller:GameCont.hm_native_controller_id,original:hunter_native_controller114,
                restored_context_fields:array_length(hunter_replacement_context114)}));
        }
    }
    if(mode=="hunter114death" && ticks==20) {
        scrHMGameplayLane107();
        var _die=instance_create(player.x+80,player.y,LilHunterDie);
        scrHMGameplayCheck(_die.hitid==HitId.LilHunterDie,"direct last-wish wreck initializes its death damage identity in Create");
        with(_die) {lastwish=1;event_perform(ev_alarm,2);}
        scrHMGameplayCheck(!instance_exists(_die),"actual wreck final Alarm2 and Destroy complete without missing hitid");
        var _blast=0;with(Explosion) if(hitid==HitId.LilHunterDie) _blast++;
        scrHMGameplayCheck(_blast>=3*(1+GameCont.loops),"all wreck explosions retain the correct LilHunterDie source");
        with(Explosion) instance_destroy(id,false);
    }
    if(mode=="hunter114menu" && ticks==20) {
        // Deactivation supplies the exact absent-controller menu condition,
        // without destroying the run's owned save/controller state.
        var _controller=GameCont.id;
        instance_deactivate_object(_controller);
        scrHMGameplayCheck(!instance_exists(GameCont),"menu fixture truly has no active GameCont");
        var _selector=instance_create(0,0,CustomModeWeaponSelector);
        with(_selector) event_user(1);
        var _groups=array_length(_selector.groups);
        var _names=[];
        for(var _i=0;_i<array_length(global.hm_module_order);++_i) {
            var _key=global.hm_module_order[_i];
            if(string_pos("weapon:",_key)!=1) continue;
            var _props=["weapon_name","weapon_area","weapon_sprt"];
            for(var _p=0;_p<array_length(_props);++_p) {
                var _prop=_props[_p];
                var _value=scrHMWeaponProperty(_key,_prop,-1);
                scrHMGameplayCheck(!is_undefined(_value),"all MOD "+_prop+" callbacks evaluate outside a run");
            }
            array_push(_names,_key);
        }
        scrHMGameplayCheck(_groups==Ammo.NUM_AMMO_TYPES+2 && array_length(_names)==11,
            "real CustomModeWeaponSelector creates the separate eleven-weapon Hardmode group without a controller");
        for(var _i=0;_i<array_length(_names);++_i) {
            var _key=string_delete(_names[_i],1,7),_weapon=global.hm_weapon_ids[$ _key],_count=0;
            for(var _g=0;_g<_groups;++_g)
                for(var _w=0;_w<array_length(_selector.groups[_g]);++_w)
                    if(_selector.groups[_g][_w]==_weapon) _count++;
            scrHMGameplayCheck(_count==1 && array_contains(_selector.groups[_selector.hm_group_index],_weapon),
                "actual CustomModeWeaponSelector membership contains exactly one "+_key);
        }
        instance_destroy(_selector,false);instance_activate_object(_controller);
        scrHMGameplayCheck(scrHMWeaponProperty("weapon:secretweapon2","weapon_area",-1)==-1,
            "live non-oasis area excludes the contextual Harpoon drop");
        var _area=GameCont.area;GameCont.area=scrHMAreaResolve("oasis");
        scrHMGameplayCheck(scrHMWeaponProperty("weapon:secretweapon2","weapon_area",-1)==1,
            "oasis still retains its genuine contextual Harpoon drop");
        GameCont.area=_area;
    }
}

// Exercise the production selector, disk preset parser and three loadout
// destinations. These checks use the registered dynamic IDs, not a second
// hand-maintained weapon list or a changed natural drop table.
function scrHMGameplayCustom116() {
    if(mode!="custom116" || ticks!=20) return;
    // Startup settings load after the fixture's first language selection.
    // Select again at the actual menu boundary so both language captures run.
    var _language_parts=string_split(scenario,",");
    if(array_length(_language_parts)>7) {
        scrLanguageSet(_language_parts[7]);UberCont.opt_language=_language_parts[7];
        scrHMGameplayCheck(UberCont.opt_language==_language_parts[7],"actual selector uses the requested scenario language");
    }
    var _saved={custom:UberCont.custom,options:UberCont.custom_options,
        slots:UberCont.custom_mode_slots,index:UberCont.custom_mode_slot_index,
        disclaimer:UberCont.custom_mode_disclaimer,proto:UberCont.protowep,protocurse:UberCont.protocurse};
    var _filepath=game_directory+"custom-mode.json",_had_file=file_exists(_filepath);
    var _old_file=_had_file?file_read(_filepath):"";
    var _pinst=scr_playerinstance_find(global.index);
    var _loadout={wep:_pinst.cwep,bwep:_pinst.bwep,curse:_pinst.start_curse,bcurse:_pinst.start_bcurse};
    var _ids=[],_keys=[];
    for(var _i=0;_i<array_length(global.hm_module_order);++_i) {
        var _key=global.hm_module_order[_i];
        if(string_pos("weapon:",_key)!=1) continue;
        array_push(_keys,_key);
        array_push(_ids,global.hm_weapon_ids[$ string_delete(_key,1,7)]);
    }
    scrHMGameplayCheck(array_length(_ids)==11,"custom weapon test enumerates the eleven real Hardmode registry entries");
    UberCont.custom=true;UberCont.custom_mode_slot_index=4;UberCont.custom_mode_disclaimer=true;
    UberCont.custom_mode_slots=[];
    for(var _i=0;_i<max_custom_mode_slots;++_i)
        array_push(UberCont.custom_mode_slots,new CustomModeOptions("Fixture "+string(_i)));
    UberCont.custom_options=UberCont.custom_mode_slots[4];
    // Crown -1 leaves this test concerned with the loadout alone and avoids
    // applying or removing unrelated live-room crown effects.
    UberCont.custom_options.crown=-1;
    var _controller=GameCont.id;
    instance_deactivate_object(_controller);
    scrHMGameplayCheck(!instance_exists(GameCont),"custom weapon selector runs in the real absent-controller menu condition");
    var _selector=instance_create(0,0,CustomModeWeaponSelector);
    with(_selector) event_user(1);
    scrHMGameplayCheck(_selector.hm_group_index==Ammo.NUM_AMMO_TYPES+1
        && array_length(_selector.groups[_selector.hm_group_index])==11,
        "dedicated Hardmode selector group exposes all eleven secret and contextual weapons");
    for(var _i=0;_i<array_length(_ids);++_i) {
        var _id=_ids[_i],_occurrences=0;
        for(var _g=0;_g<array_length(_selector.groups);++_g)
            for(var _w=0;_w<array_length(_selector.groups[_g]);++_w)
                if(_selector.groups[_g][_w]==_id) _occurrences++;
        scrHMGameplayCheck(_occurrences==1 && array_contains(_selector.groups[_selector.hm_group_index],_id),
            "visible menu contains exactly one registered "+_keys[_i]);
        scrHMGameplayCheck(sprite_exists(scr_weapon_get_sprite(_id))
            && scr_weapon_get_name(_id)!="" && scr_weapon_is_valid(_id),
            "menu weapon has actual artwork, display name and valid runtime metadata: "+_keys[_i]);
        for(var _slot=0;_slot<3;++_slot) {
            _selector.choosing_secondary=(_slot==1);_selector.choosing_proto=(_slot==2);
            var _param=_selector.get_weapon_key();
            scrCustomParamChange(_param,_id);
            with(_selector) event_user(1);
            scrHMGameplayCheck(scrCustomParam(_param)==_id
                && array_contains(_selector.groups[_selector.hm_group_index],_id),
                "reopening the actual "+_param+" selector preserves registered weapon "+_keys[_i]);
        }
    }
    instance_activate_object(_controller);
    scrHMGameplayCheck(instance_exists(GameCont),"custom weapon menu fixture restores the real run controller");
    for(var _i=0;_i<array_length(_ids);++_i) {
        var _primary=_ids[_i],_secondary=_ids[(_i+1) mod 11],_proto=_ids[(_i+2) mod 11];
        scrCustomParamChange("wep",_primary);scrCustomParamChange("bwep",_secondary);
        scrCustomParamChange("protowep",_proto);
        scrCustomModeSavePresets();
        UberCont.custom_mode_slots=[];UberCont.custom_mode_slot_index=-1;UberCont.custom_options=undefined;
        scrCustomModeLoadPresets();
        UberCont.custom_options=UberCont.custom_mode_slots[UberCont.custom_mode_slot_index];
        scrHMGameplayCheck(UberCont.custom_mode_slot_index==4 && array_length(UberCont.custom_mode_slots)==9
            && scrCustomParam("wep")==_primary && scrCustomParam("bwep")==_secondary
            && scrCustomParam("protowep")==_proto,
            "real preset disk save and load preserves all three dynamic weapon slots for "+_keys[_i]);
        var _other_slots=true;
        for(var _s=0;_s<9;++_s) if(_s!=4) {
            var _other=UberCont.custom_mode_slots[_s];
            _other_slots=_other_slots && _other.name=="Fixture "+string(_s)
                && _other.wep==-1 && _other.bwep==-1 && _other.protowep==-1;
        }
        scrHMGameplayCheck(_other_slots,"changing the active preset preserves all eight other custom slots");
        scrMenuPrepareCustomLoadout();
        scrHMGameplayCheck(_pinst.cwep==_primary && _pinst.bwep==_secondary && UberCont.protowep==_proto,
            "production custom start loadout retains primary, secondary and proto Hardmode IDs for "+_keys[_i]);
    }
    _selector.choosing_secondary=false;_selector.choosing_proto=false;_selector.setup=true;
    scrHMGameplayCustomDraw116(_selector);
    instance_destroy(_selector,false);
    _pinst.cwep=_loadout.wep;_pinst.bwep=_loadout.bwep;
    _pinst.start_curse=_loadout.curse;_pinst.start_bcurse=_loadout.bcurse;
    UberCont.custom=_saved.custom;UberCont.custom_options=_saved.options;
    UberCont.custom_mode_slots=_saved.slots;UberCont.custom_mode_slot_index=_saved.index;
    UberCont.custom_mode_disclaimer=_saved.disclaimer;UberCont.protowep=_saved.proto;UberCont.protocurse=_saved.protocurse;
    if(_had_file) file_write(_filepath,_old_file); else file_delete(_filepath);
    show_debug_message("HARDMODE CUSTOM116 "+json_stringify({weapons:_ids,keys:_keys,
        slots:3,presets:9,language:UberCont.opt_language,restored:true}));
}

function scrHMGameplayCustomDraw116(_selector) {
    var _surface=surface_create(gui_w,gui_h);
    var _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign();
    var _color=draw_get_color(),_alpha=draw_get_alpha();
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection);
    var _camera=camera_create_view(0,0,gui_w,gui_h,0,noone,-1,-1,0,0);
    surface_set_target(_surface);draw_clear_alpha(c_black,1);
    matrix_set(matrix_world,matrix_build_identity());camera_apply(_camera);
    draw_reset_font();draw_set_halign(fa_center);draw_set_valign(fa_middle);
    draw_set_color(c_white);draw_set_alpha(1);
    with(_selector) event_user(0);
    // Run the same menu renderer with its real scroll range so every MOD
    // icon and the translated section title appear in the captured viewport.
    _selector.scroll=max(0,_selector.height-(gui_h-LETTERBOX_SIZE-40));
    draw_clear_alpha(c_black,1);with(_selector) event_user(0);
    surface_reset_target();
    var _path=game_directory+"custom116-"+UberCont.opt_language+".png";
    surface_save(_surface,_path);surface_free(_surface);
    camera_destroy(_camera);matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
    draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_color);draw_set_alpha(_alpha);
    scrHMGameplayCheck(file_exists(_path),"actual custom weapon renderer produces the localized Hardmode group image");
}

function scrHMGameplayThrone116() {
    if(mode!="throne116") return;
    if(ticks==1) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("throne"),"ending fixture uses the naturally authored Throne arena");
        UberCont.opt_bossintro=0;scrHMModSet("mod","options","intropan","0");
        scrHMModSet("mod","options","bossoutros","0");
        throne_frames116=0;throne_native_matches116=0;throne_samples116=[];
    }
    if(ticks==20) {
        var _sleep=instance_find(NothingInactive,0);
        scrHMGameplayCheck(instance_exists(_sleep),"ending fixture retains its generated sleeping Throne");
        with(_sleep) {active=true;hp=0;event_perform_object(NothingInactive,ev_step,ev_step_normal);}
        with(BecomeNothing) {
            sprite_index=sprNothingActivate;drawimg=sprite_get_number(sprite_index);
            event_perform_object(BecomeNothing,ev_step,ev_step_normal);
        }
    }
    if(ticks==25) {
        scrHMGameplayCheck(instance_exists(Nothing),"actual sleeping Throne wake creates first phase");
        with(Nothing) {hp=0;instance_destroy();}
    }
    if(ticks==160) {
        throne_second116=noone;
        with(CustomEnemy) if(spr_idle==sprNothing2Idle) other.throne_second116=id;
        scrHMGameplayCheck(instance_exists(throne_second116),"native first-phase death creates the actual custom second phase");
        throne_second116.hp=0;
    }
    if(ticks==166) {
        scrHMGameplayCheck(!instance_exists(throne_second116) && instance_exists(Nothing2Death)
            && player.fallenable==1,"actual second-phase defeat arms the original final descent");
        // Move beyond the authored platform, then observe the unchanged
        // native fall coroutine. Reset only its distance origin to keep the
        // test's remote observation from skipping straight to the credits.
        player.x=18000;player.y=18000;player.portalfall=player.y;player.speed=0;
    }
    if(ticks==199) {
        scrHMGameplayCheck(throne_frames116>=30 && throne_native_matches116>=6,
            "final descent stays visible on every physical frame and matches the native portal pose");
        scrHMGameplayCheck(player.y>=18240 && player.scale==1 && player.fallenable==1,
            "portal-entry artwork retains the full authored descent rather than skipping or shrinking the credits fall");
        show_debug_message("HARDMODE THRONE116 "+json_stringify({rate:rate,frames:throne_frames116,
            native_matches:throne_native_matches116,samples:throne_samples116,y:player.y,rotation:player.sprite_angle}));
    }
}

function scrHMGameplayThroneDraw116() {
    if(mode!="throne116" || ticks<168 || ticks>198) return;
    throne_frames116++;
    scrHMGameplayCheck(player.visible && player.image_alpha==1 && player.sprite_index==player.spr_hurt
        && floor(player.image_index)==1 && player.image_speed==0 && player.spr_shadow_y==10000,
        "each physical ending frame keeps the visible portal-entry body and hides its floor shadow");
    if(throne_frames116==1) {
        throne_serial116=HMWorld.logic_serial;throne_y116=player.y;throne_angle116=player.sprite_angle;
    }
    var _elapsed=HMWorld.logic_serial-throne_serial116;
    if(throne_frames116<=10) show_debug_message("HARDMODE THRONE116 CADENCE "+json_stringify({tick:ticks,serial:HMWorld.logic_serial,elapsed:_elapsed,y:player.y,y_origin:throne_y116,angle:player.sprite_angle,angle_origin:throne_angle116,scale:timescale,ready:HMWorld.logic_tick}));
    scrHMGameplayCheck(abs(player.y-throne_y116-8*_elapsed)<.001
        && abs(player.sprite_angle-throne_angle116-15*_elapsed)<.001,
        "native descent and rotation advance exactly once per logic tick at either rendering rate");
    if(throne_native_matches116>=6) return;
    var _actual=surface_create(128,128),_reference=surface_create(128,128);
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection);
    var _camera=camera_create_view(player.x-64,player.y-64,128,128,0,noone,-1,-1,0,0);
    surface_set_target(_actual);draw_clear_alpha(c_black,1);
    matrix_set(matrix_world,matrix_build_identity());camera_apply(_camera);
    var _angle=player.angle,_sprite_angle=player.sprite_angle;
    var _draw_font=draw_get_font(),_draw_alpha=draw_get_alpha(),_draw_color=draw_get_color();
    var _draw_halign=draw_get_halign(),_draw_valign=draw_get_valign();
    with(player) event_perform(ev_draw,0);
    scrHMGameplayCheck(player.angle==_angle && player.sprite_angle==_sprite_angle,
        "real Player Draw never mutates ending rotation on extra physical frames");
    scrHMGameplayCheck(draw_get_font()==_draw_font && draw_get_alpha()==_draw_alpha
        && draw_get_color()==_draw_color && draw_get_halign()==_draw_halign && draw_get_valign()==_draw_valign,
        "portal-entry Player Draw preserves its caller's complete text and colour state");
    surface_reset_target();
    var _native=instance_create(0,0,HMBinding);
    _native.creator=player;_native.hm_menu_overlay=true;
    surface_set_target(_reference);draw_clear_alpha(c_black,1);
    matrix_set(matrix_world,matrix_build_identity());camera_apply(_camera);
    player.angle=_sprite_angle;
    with(_native) hm_maincode_mod_gml_PortalShrink();
    player.angle=_angle;
    surface_reset_target();instance_destroy(_native,false);
    var _actual_pixels=buffer_create(128*128*4,buffer_fixed,1);
    var _reference_pixels=buffer_create(128*128*4,buffer_fixed,1);
    buffer_get_surface(_actual_pixels,_actual,0);buffer_get_surface(_reference_pixels,_reference,0);
    var _matching=true,_visible=0,_different=0;
    for(var _pixel_index=0;_pixel_index<128*128;++_pixel_index) {
        var _pixel=buffer_peek(_actual_pixels,_pixel_index*4,buffer_u32);
        if(_pixel!=buffer_peek(_reference_pixels,_pixel_index*4,buffer_u32)) {_matching=false;_different++;}
        if((_pixel & $ffffff)!=0) _visible++;
    }
    buffer_delete(_actual_pixels);buffer_delete(_reference_pixels);
    var _shot=game_directory+"throne116-"+string(rate)+"-"+string(throne_native_matches116)+".png";
    surface_save(_actual,_shot);
    surface_save(_reference,string_replace(_shot,".png","-reference.png"));
    show_debug_message("HARDMODE THRONE116 PIXELS "+json_stringify({tick:ticks,visible:_visible,different:_different}));
    scrHMGameplayCheck(_matching && _visible>20,
        "actual ending Player Draw matches native PortalShrink body and both weapon layers pixel for pixel");
    array_push(throne_samples116,{tick:ticks,serial:HMWorld.logic_serial,y:player.y,
        rotation:player.sprite_angle,visible_pixels:_visible,sprite:sprite_get_name(player.sprite_index)});
    throne_native_matches116++;
    surface_free(_actual);surface_free(_reference);camera_destroy(_camera);
    matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
}

// These scenarios keep the real runtime/native object constructors active.
// Run count in city,5 at L0/L1/L2/L10/L20, and group cases at both 30/60 FPS.
function scrHMGameplayBossGroup115() {
    scrHMGameplayMessenger115();
    if(mode=="group115replace") return;

    if(mode=="hunter115count") {
        if(ticks==1) {
            hunter_expected115=1+floor(max(0,GameCont.loops)/2);
            hunter_race115=player.race;
            with(HMWorld) {hm_gungod_rolled=true;hm_gungod_replaced=false;}
            var _controller=variable_instance_get(GameCont, "hm_native_controller_id")??noone;
            if(instance_exists(_controller)) with(_controller) {hm_gungod_rolled=true;hm_gungod_replaced=false;}
        }
        if(array_contains([290,310,330,350],ticks)) {
            var _count=0;
            with(LilHunter) if(!(self[$ "hm_extra"]??false)) _count++;
            with(LilHunterFly) if(!(self[$ "hm_extra"]??false)) _count++;
            scrHMGameplayCheck(_count==hunter_expected115,"normal stage Hunter count is exactly one plus floor Loop/2");
            scrHMGameplayCheck(instance_number(WantLH)==0,"arrival retires every delayed native Hunter request");
        }
        if(ticks==300 || ticks==320) {
            player.race=ticks==300?Race.Robot:hunter_race115;
            repeat(5) {scrHMLilHunterPending109();scrHMLilHunterReconcile115();}
        }
        if(ticks==340) {
            with(LilHunter) if(!(self[$ "hm_extra"]??false)) {
                instance_change(LilHunterFly,false);sprite_index=sprLilHunterLift;z=-80;break;
            }
            repeat(5) {scrHMLilHunterPending109();scrHMLilHunterReconcile115();}
        }
        if(ticks==360) {
            with(LilHunter) if(!(self[$ "hm_extra"]??false)) instance_destroy(id,false);
            with(LilHunterFly) if(!(self[$ "hm_extra"]??false)) instance_destroy(id,false);
            repeat(5) {scrHMLilHunterPending109();scrHMLilHunterReconcile115();}
            var _pending=false;
            with(CustomObject) if(array_contains(["hm_hunter_pending","hm_hunter_arrival109"],name)) _pending=true;
            scrHMGameplayCheck(!_pending && instance_number(WantLH)==0,"defeated room schedule cannot be recreated by race/pending checks");
            show_debug_message("HARDMODE HUNTER115 COUNT "+json_stringify({loops:GameCont.loops,expected:hunter_expected115,
                scheduled:scrHMBossGroupReserve115("hunter").hunter_spawned,rate:rate}));
        }
    }
    if(string_pos("group115",mode)!=1) return;
    if(ticks==10) {
        scrHMGameplayLane107();HMWorld.hm_boss_room115="";
        scrHMModSet("mod","options","intropan","1");scrHMModSet("mod","options","bossoutros","1");
        UberCont.opt_bossintro=0;
        group_type115=mode=="group115bubbler"?OasisBoss:(mode=="group115crystal"?HyperCrystal:LilHunter);
        group_kind115=mode=="group115bubbler"?"bubbler":(mode=="group115crystal"?"crystal":"hunter");
        group_members115=[];scrHMBossGroupReserve115(group_kind115,3);
        group_final_checked115=false;
        repeat(2) {
            var _actor=instance_create(player.x+96+array_length(group_members115)*24,player.y,group_type115);
            with(_actor) {intro=1;newintro=-1;for(var _a=0;_a<12;++_a) alarm[_a]=9999;}
            array_push(group_members115,_actor);scrHMBossGroupRegister115(_actor);
        }
        with(group_members115[0]) hm_bosses_bossintros_mod_gml_boss_trigger("",mskNone,mskNone,mskNone,id,0);
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active),"group intro waits for every scheduled normal boss");
    }
    if(ticks==20) {
        var _actor=instance_create(player.x+160,player.y,group_type115);
        with(_actor) {intro=1;newintro=-1;for(var _a=0;_a<12;++_a) alarm[_a]=9999;}
        array_push(group_members115,_actor);scrHMBossGroupRegister115(_actor);
        scrHMBossGroupTick115();
        var _group=scrHMBossGroupReserve115(group_kind115);
        scrHMGameplayCheck(_group.entry_count==1 && instance_exists(HMWorld.hm_portrait_active),"completed normal group starts exactly one real entrance camera");
        var _hp=player.hp,_hurt=scr_hit(player,1,HitId.None);
        scrHMGameplayCheck(!_hurt && player.hp==_hp && scrHMBossPresentationProtected115(),"actual entrance camera protects the player from damage");
    }
    if(ticks==25) {
        for(var _i=0;_i<array_length(group_members115);++_i)
            with(group_members115[_i]) hm_bosses_bossintros_mod_gml_boss_trigger("",mskNone,mskNone,mskNone,id,0);
        scrHMGameplayCheck(scrHMBossGroupReserve115(group_kind115).entry_count==1,"each co-member cannot replay its group entrance");
    }
    if(ticks==100) {
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active) && player.can_walk,"entrance naturally releases controls before damage grace expires");
        var _hp=player.hp,_hurt=scr_hit(player,1,HitId.None);
        scrHMGameplayCheck(!_hurt && player.hp==_hp,"post-entrance two-second grace still blocks positive damage");
        instance_destroy(group_members115[0],false);instance_destroy(group_members115[1],false);
        scrHMBossGroupTick115();
        scrHMGameplayCheck(scrHMBossGroupReserve115(group_kind115).exit_count==0,"partial group defeat cannot start the departure camera");
    }
    if(ticks==110) {
        instance_destroy(group_members115[2],false);scrHMBossGroupTick115();
        scrHMGameplayCheck(scrHMBossGroupReserve115(group_kind115).exit_count==1
            && instance_exists(HMWorld.hm_portrait_active),"only final normal member starts one group departure camera");
        group_outro_seen115=true;group_guard_done115=false;
    }
    if(ticks>110 && (self[$ "group_outro_seen115"]??false)) {
        if(instance_exists(HMWorld.hm_portrait_active)) {
            var _hp=player.hp;
            scrHMGameplayCheck(!scr_hit(player,1,HitId.None) && player.hp==_hp,"departure camera retains player damage immunity");
        } else if(!group_guard_done115) {
            var _until=variable_instance_get(HMWorld, "hm_presentation_until115")??-1;
            if(current_frame<_until) {
                scrHMGameplayCheck(player.can_walk && scrHMBossPresentationProtected115(),"departure grace protects without freezing player control");
            } else {
                var _hp=player.hp;
                scrHMGameplayCheck(!scrHMBossPresentationProtected115() && scr_hit(player,1,HitId.None)
                    && player.hp==_hp-1,"damage resumes after exactly sixty logical frames of grace");
                group_guard_done115=true;
            }
        }
    }
    if(ticks==290) {
        var _group=scrHMBossGroupReserve115(group_kind115);
        scrHMGameplayCheck(_group.entry_count==1 && _group.exit_count==1 && group_guard_done115,
            "normal multi-boss encounter ends with one introduction, one outro and finite immunity");
        group_final_checked115=true;
        show_debug_message("HARDMODE GROUP115 "+json_stringify({kind:group_kind115,rate:rate,
            entries:_group.entry_count,exits:_group.exit_count,members:array_length(_group.members)}));
    }
    if(ticks==goal_ticks-5) scrHMGameplayCheck(self[$ "group_final_checked115"]??false,
        "group encounter reached all required introduction, departure and immunity assertions");
}

function scrHMGameplayMessenger115() {
    if(mode=="group115replace" && ticks==20) {
        scrHMGameplayLane107();HMWorld.hm_boss_room115="";
        scrHMModSet("mod","options","intropan","1");scrHMModSet("mod","options","bossoutros","1");
        var _original=instance_create(player.x+96,player.y,OasisBoss);
        scrHMBossGroupRegister115(_original);
        scrHMBossGroupRetire115(_original);scrHMDelete(_original);
        scrHMBossGroupTick115();
        var _group=scrHMBossGroupReserve115("bubbler");
        scrHMGameplayCheck(_group.retired && _group.exit_count==0 && !instance_exists(HMWorld.hm_portrait_active),
            "replacing a living normal boss cannot be mistaken for a defeated boss outro");
        group_replace_checked115=true;
    }
    if(mode=="group115replace" && ticks==goal_ticks-5)
        scrHMGameplayCheck(self[$ "group_replace_checked115"]??false,"replacement group retirement reached its required terminal assertion");
    if(string_pos("messenger115",mode)!=1) return;
    var _short=mode!="messenger115natural";
    if(ticks==20) {
        scrHMGameplayLane107();HMWorld.hm_boss_room115="";
        scrHMGameplayNoReplacement1115();
        scrHMModSet("mod","options","intropan","1");scrHMModSet("mod","options","bossoutros","1");
        var _reference=instance_create(player.x,player.y,WantRevivePopoFreak);
        messenger_native_delay115=_reference.alarm[0];instance_destroy(_reference,false);
        messenger_keeper115=instance_create(14400,14280,CustomEnemy);messenger_keeper115.hp=100000;
        var _boss=hm_enemies_mod_gml_enemyrogue_create(player.x+80,player.y);
        var _body=noone;
        with(_boss) {hp=0;instance_destroy();}
        with(Corpse) if(self[$ "hm_messenger_corpse115"]??false) {_body=id;break;}
        messenger_corpse115=_body;
        if(GameCont.loops<3) {
            var _count=0;with(WantRevivePopoFreak) if(variable_instance_exists(id,"hm_messenger_corpse115")) _count++;
            scrHMGameplayCheck(_count==0,"normal Messenger does not gain automatic revival before Loop three");
            messenger_early_checked115=true;
            return;
        }
        scrHMGameplayCheck(instance_exists(messenger_corpse115),"actual Messenger death retains its marked visible corpse");
        messenger_timer115=messenger_corpse115.hm_messenger_timer115;
        scrHMGameplayCheck(instance_exists(messenger_timer115) && messenger_timer115.alarm[0]==messenger_native_delay115*2,
            "Messenger schedules exactly twice the real native IDPD Freak constructor interval");
        scrHMGameplayCheck(!scrHMMessengerReviving115(),"long revival timer does not block ordinary room clearance");
        messenger_effect115=noone;messenger_revived115=noone;messenger_checked115=false;
        messenger_effect_seen115=false;messenger_return_seen115=false;messenger_cleared115=false;
        if(_short) messenger_timer115.alarm[0]=5;
    }
    if(GameCont.loops<3) {
        if(ticks==goal_ticks-5) scrHMGameplayCheck(self[$ "messenger_early_checked115"]??false,
            "pre-Loop-three Messenger revival exclusion reached its required terminal assertion");
        return;
    }
    if(ticks<=20) return;
    if(!messenger_effect_seen115) {
        var _effect=noone;
        with(RevivePopoFreak) if(variable_instance_exists(id,"hm_messenger_corpse115")) {
            _effect=id;break;
        }
        messenger_effect115=_effect;
        if(instance_exists(messenger_effect115)) {
            messenger_effect_seen115=true;messenger_effect_tick115=ticks;
            scrHMGameplayCheck(messenger_effect115.sprite_index==sprPopoReviveArea,
                "automatic Messenger rise uses the actual IDPD Freak revival-area sprite");
            scrHMGameplayCheck(messenger_effect115.alarm[0]>0 && messenger_effect115.alarm[0]<=15,
                "actual revival-area constructor retains its fifteen-frame effect");
            scrHMGameplayCheck(scrHMMessengerReviving115() && scrHMPendingBoss() && scr_check_enemies(),
                "visible revival effect blocks clearance until its combat actor exists");
        }
    }
    if(messenger_effect_seen115 && !messenger_return_seen115) {
        var _returned=noone;
        with(CustomEnemy) if(self[$ "hm_messenger_auto_revived115"]??false) {_returned=id;break;}
        messenger_revived115=_returned;
        if(instance_exists(messenger_revived115)) {
            messenger_return_seen115=true;messenger_return_tick115=ticks;
            scrHMGameplayCheck(!instance_exists(messenger_corpse115) && !instance_exists(messenger_effect115),
                "native revival consumes only its owned corpse and completed effect");
            scrHMGameplayCheck(ticks-messenger_effect_tick115>=14 && ticks-messenger_effect_tick115<=16,
                "Messenger appears only after the full fifteen-frame native revival effect");
            scrHMGameplayCheck(messenger_revived115.name=="roguefreak" && messenger_revived115.hp>0,
                "automatic revival keeps the original armed roguefreak actor");
            var _title="";with(messenger_revived115) _title=hm_hm_bossbar_mod_gml_hm_custom_boss_name();
            scrHMGameplayCheck(_title=="The Messenger" && !scrHMMessengerSkipPresentation1103(messenger_revived115),
                "automatically revived Messenger has its boss bar and may receive a new entrance");
            // The full native wait leaves the constructor's police free to
            // move this observer. A healthy Messenger deliberately waits
            // until a player approaches within 120 pixels before its pan.
            show_debug_message("HARDMODE MESSENGER115 APPROACH "+json_stringify({tick:ticks,
                before_distance:point_distance(player.x,player.y,messenger_revived115.x,messenger_revived115.y),
                before_intro:messenger_revived115.intro,
                before_camera:instance_exists(HMWorld.hm_portrait_active)}));
            player.x=messenger_revived115.x-80;player.y=messenger_revived115.y;player.speed=0;
            with(messenger_revived115) {
                target=other.player;targetvisible=1;intro=0;scrHMMessengerIntro1103();
            }
            scrHMGameplayCheck(instance_exists(HMWorld.hm_portrait_active) && scrHMBossPresentationProtected115(),
                "returned normal Messenger may run a real protected entrance camera");
        }
    }
    if(messenger_return_seen115 && ticks>=messenger_return_tick115+150 && !messenger_checked115) {
        messenger_checked115=true;
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active) && player.can_walk,
            "revived Messenger entrance releases controls normally");
        with(messenger_revived115) {hp=0;instance_destroy();}
        var _timer=noone;
        with(WantRevivePopoFreak) if(variable_instance_exists(id,"hm_messenger_corpse115")) {_timer=id;break;}
        messenger_second_timer115=_timer;
        scrHMGameplayCheck(instance_exists(messenger_second_timer115)
            && messenger_second_timer115.alarm[0]==messenger_native_delay115*2,
            "a second death follows the Freak's repeatable full-interval revival policy");
        instance_destroy(messenger_keeper115,false);
        // The real Messenger constructor also schedules police arrivals.
        // Finish those unrelated encounter queues before asserting that a
        // genuinely empty room can open its exit during the long timer.
        with(IDPDSpawn) instance_destroy(id,false);
        with(VanSpawn) instance_destroy(id,false);
        with(WantPopo) instance_destroy(id,false);
        with(WantVan) instance_destroy(id,false);
        with(enemy) instance_destroy(id,false);with(becomenemy) instance_destroy(id,false);
        show_debug_message("HARDMODE MESSENGER115 CLEAR BLOCKERS "+json_stringify({
            rad_maggot_chest:instance_number(RadMaggotChest),vault:instance_number(VaultStatue),
            crown:instance_number(CrownPickup),tutorial:instance_number(TutCont),scrap_transition:instance_number(BecomeScrapBoss),
            sitting:instance_number(SitDown),generator:instance_number(GenCont),area:GameCont.area,sub:GameCont.subarea,
            maxsub:GameCont.maxsubarea,pending:scrHMPendingBoss(),enemies:scr_check_enemies()}));
        // The lane fixture retains the generated room's noncombat props.
        // Their stock clearance exclusions must not contaminate this test of
        // a Messenger timer in an otherwise genuinely empty encounter.
        with(RadMaggotChest) instance_destroy(id,false);
        with(VaultStatue) instance_destroy(id,false);
        with(CrownPickup) instance_destroy(id,false);
        with(TutCont) instance_destroy(id,false);
        with(BecomeScrapBoss) instance_destroy(id,false);
        with(SitDown) instance_destroy(id,false);
        scrHMGameplayCheck(!scr_check_enemies() && !instance_exists(GenCont)
            && !instance_exists(RadMaggotChest) && !instance_exists(VaultStatue) && !instance_exists(CrownPickup),
            "Messenger timer clearance fixture has no unrelated native exit exclusions");
        var _exit_x=player.x+48,_exit_y=player.y;
        messenger_watch_floor115=instance_furthest(_exit_x,_exit_y,Floor);
        scrHMGameplayCheck(instance_exists(messenger_watch_floor115)
            && point_distance(_exit_x,_exit_y,messenger_watch_floor115.x+16,messenger_watch_floor115.y+16)>160,
            "Messenger exit observation has a real safe floor beyond the native portal attraction radius");
        // Observe the live exit without being pulled through it and tearing
        // down this room before the final repeated-timer assertions run.
        player.x=messenger_watch_floor115.x+16;player.y=messenger_watch_floor115.y+16;player.speed=0;
        scrHMDeathExit(_exit_x,_exit_y);
    }
    if(messenger_checked115 && instance_exists(self[$ "messenger_watch_floor115"]??noone)) {
        player.x=messenger_watch_floor115.x+16;player.y=messenger_watch_floor115.y+16;player.speed=0;
    }
    if(messenger_checked115 && !messenger_cleared115 && instance_exists(Portal)) {
        messenger_cleared115=true;
        scrHMGameplayCheck(!scrHMMessengerReviving115(),"a pending long revival timer still permits the cleared room's real exit");
        with(messenger_second_timer115) event_perform(ev_alarm,0);
        scrHMGameplayCheck(!instance_exists(messenger_second_timer115) && !scrHMMessengerReviving115(),
            "opening the exit cancels Messenger's next automatic revival like a native Freak");
    }
    if(ticks==goal_ticks-5) {
        var _corpses=[];with(Corpse) if(self[$ "hm_exit_corpse"]??false)
            array_push(_corpses,[alarm[0],sprite_get_name(sprite_index),x,y]);
        show_debug_message("HARDMODE MESSENGER115 "+json_stringify({tick:ticks,effect:messenger_effect_seen115,
            returned:messenger_return_seen115,checked:messenger_checked115,cleared:messenger_cleared115,
            enemies:instance_number(enemy),pending:scrHMPendingBoss(),portal:instance_number(Portal),
            police_gates:instance_number(IDPDSpawn),timers:instance_number(WantRevivePopoFreak),
            exit_corpses:_corpses,players:instance_number(Player),becoming:instance_number(becomenemy)}));
        scrHMGameplayCheck(messenger_effect_seen115 && messenger_return_seen115
            && messenger_checked115 && messenger_cleared115,"complete Messenger revival, entrance, repeated timer and normal exit all finish");
    }
}

// Preserve the naturally generated terrain while exercising the real stage
// Destroy callback and stale callbacks whose converted extra creator is dead.
function scrHMGameplayCave116() {
    if(mode!="cave116stage" && mode!="cave116extra") return;
    if(ticks<10) return;
    if(ticks==10) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("cavesinv"),"cave fixture uses the actual generated cursed room");
        cave_terrain116=[];cave_far116=noone;cave_distance116=0;cave_finish116=-1;
        player.curse=0;player.can_walk=false;player.speed=0;
        cave_boss116=instance_find(HyperCrystal,0);
        // Isolate combat without replacing any generated floor or wall.
        // Otherwise unrelated explosions legitimately split packed walls.
        with(enemy) if(id!=other.cave_boss116) instance_destroy(id,false);
        with(becomenemy) instance_destroy(id,false);
        with(projectile) instance_destroy(id,false);
        with(Explosion) instance_destroy(id,false);
        // This fixture preserves the generated room and its live controller.
        // The Lane helper recreates that controller after deleting all props;
        // recreating it here instead reruns native population one tick later.
        var _controller=variable_instance_get(GameCont,"hm_native_controller_id")??noone;
        scrHMGameplayCheck(instance_exists(_controller)
            && _controller.name=="hm_native_controller","actual cave retains its completed native population controller");
        var _controllers=[];
        with(CustomObject) if(name=="hm_native_controller") {
            array_push(_controllers,{who:id,area:self[$ "hm_population_area"]??undefined,
                sub:self[$ "hm_population_sub"]??undefined,loop:self[$ "hm_population_loop"]??undefined,
                done:self[$ "hm_population_done"]??undefined});
            hm_gungod_rolled=true;hm_gungod_replaced=false;
            hm_population_area=GameCont.area;hm_population_sub=GameCont.subarea;
            hm_population_loop=GameCont.loops;hm_population_done=1;
        }
        show_debug_message("HARDMODE CAVE116 CONTROLLER "+json_stringify({tick:ticks,controllers:_controllers}));
        scrHMGameplayCheck(array_length(_controllers)==1,"cave isolation reuses exactly one generated native population controller");
        // Keep natural exit clearance outside this palette regression.
        cave_keeper116=instance_create(player.x,player.y,CustomEnemy);
        with(cave_keeper116) {name="hm_cave_palette_fixture";frozen=true;speed=0;sprite_index=mskNone;canfly=1;}
        if(mode=="cave116stage") {
            scrHMGameplayCheck(instance_exists(cave_boss116),"actual cursed cave stage boss exists before combat death");
            cave_origin116=[cave_boss116.x,cave_boss116.y];
            with(cave_boss116) {frozen=true;speed=0;for(var _a=0;_a<12;++_a) alarm[_a]=-1;}
        } else {
            scrHMGameplayCheck(!instance_exists(cave_boss116),"extra test starts in a non-final cursed cave");
            cave_origin116=[player.x,player.y];cave_extras116=[];
            var _kinds=["crystal","cursedcrystal"];
            for(var _i=0;_i<array_length(_kinds);++_i) {
                var _tile=scrHMExtraTile1103(_kinds[_i]);
                scrHMGameplayCheck(instance_exists(_tile),"actual cave contains a collision-valid extra crystal location");
                var _actor=hm_arkintide_mod_gml_hm_extra_spawn(_kinds[_i],_tile.x+16,_tile.y+16);
                scrHMGameplayCheck(instance_exists(_actor) && (_actor[$ "hm_extra"]??false),"actual extra crystal factory retains extra provenance");
                with(_actor) {
                    frozen=true;speed=0;hm_extra_teleport_at1115=current_frame+1000000;
                    for(var _a=0;_a<12;++_a) alarm[_a]=-1;
                }
                array_push(cave_extras116,_actor);
            }
        }
        UberCont.opt_bossintro=0;scrHMModSet("mod","options","intropan","0");scrHMModSet("mod","options","bossoutros","0");
    }
    if(ticks==150) {
        // Authored cave_create drills for125 ticks and then creates its
        // entrance/ice floor. Observe its real completed map as the baseline.
        var _drills=0;
        with(CustomObject) if((self[$ "on_step"]??undefined)==scrHMScriptRef(hm_props_mod_gml_cave_step)) _drills++;
        scrHMGameplayCheck(_drills==0 && !instance_exists(PortalClear),"native cave entrance carving finishes before the palette-only geometry baseline");
        var _unrelated=[];
        with(CustomEnemy) if(id!=other.cave_keeper116
            && (other.mode=="cave116stage" || !array_contains(other.cave_extras116,id)))
            array_push(_unrelated,{who:id,name:name,kind:self[$ "hm_extra_kind"]??"",x:x,y:y});
        show_debug_message("HARDMODE CAVE116 ISOLATION "+json_stringify({tick:ticks,unrelated:_unrelated,
            enemies:instance_number(enemy),expected:mode=="cave116stage"?2:3}));
        scrHMGameplayCheck(array_length(_unrelated)==0 && instance_number(enemy)==(mode=="cave116stage"?2:3),
            "retaining the native controller cannot enqueue any unrelated population after fixture isolation");
        if(mode=="cave116stage") cave_origin116=[cave_boss116.x,cave_boss116.y];
        with(Floor) {
            array_push(other.cave_terrain116,{who:id,x:x,y:y,xs:image_xscale,ys:image_yscale,mask:mask_index,angle:image_angle,sprite:sprite_index,kind:0});
            var _distance=point_distance(x,y,other.cave_origin116[0],other.cave_origin116[1]);
            if(_distance>other.cave_distance116) {other.cave_distance116=_distance;other.cave_far116=id;}
        }
        with(Wall) array_push(other.cave_terrain116,{who:id,x:x,y:y,xs:image_xscale,ys:image_yscale,mask:mask_index,angle:image_angle,sprite:sprite_index,kind:1,top:topspr,out:outspr});
        with(TopSmall) array_push(other.cave_terrain116,{who:id,x:x,y:y,xs:image_xscale,ys:image_yscale,mask:mask_index,angle:image_angle,sprite:sprite_index,kind:2});
        scrHMGameplayCheck(array_length(cave_terrain116)>100 && instance_exists(cave_far116),"terrain fixture captures near and far actual floor and wall geometry");
        cave_finish116=180+ceil(cave_distance116/8)+20;
        cave_missing_logged116=false;
        scrHMGameplayCheck(cave_finish116+12<goal_ticks,"scenario duration covers furthest native wave plus the final eleven-frame fade");
    }
    if(ticks>150 && ticks<cave_finish116 && !cave_missing_logged116) {
        for(var _i=0;_i<array_length(cave_terrain116);++_i) if(!instance_exists(cave_terrain116[_i].who)) {
            cave_missing_logged116=true;
            var _actors=[];
            with(CustomEnemy) array_push(_actors,{who:id,name:name,kind:self[$ "hm_extra_kind"]??"",
                x:x,y:y,hp:hp,frozen:self[$ "frozen"]??false,blink:self[$ "hm_extra_last_blink1115"]??-1,
                teleport:self[$ "hm_extra_teleport_at1115"]??-1});
            show_debug_message("HARDMODE CAVE116 FIRST MISSING "+json_stringify({tick:ticks,
                before:cave_terrain116[_i],portals:instance_number(PortalClear),actors:_actors}));
            break;
        }
    }
    if(ticks==170) {
        if(mode=="cave116stage") with(cave_boss116) {frozen=false;hp=0;event_perform(ev_step,ev_step_normal);}
        else for(var _i=0;_i<array_length(cave_extras116);++_i) with(cave_extras116[_i]) {
            // Deliberately retain a real scheduled callback beyond its source's death.
            scrHMBindEndStep(hm_maincode_mod_gml_CHCoutro,5,x,y);
            frozen=false;hp=0;event_perform(ev_step,ev_step_normal);
        }
    }
    if(ticks==cave_finish116) {
        var _stage=mode=="cave116stage";
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve(_stage?"caves":"cavesinv")
            && (variable_instance_get(GameCont,"hm_cave_cleansed")??false)==_stage,
            "only the real stage boss commits the cave identity after all dead-source callbacks");
        if(_stage) scrHMGameplayCheck(variable_instance_get(HMWorld,"hm_cave_palette_done116")??false,"bounded palette finish executes after furthest native floor fade");
        var _floors=0,_walls=0,_bad=0;
        for(var _i=0;_i<array_length(cave_terrain116);++_i) {
            var _r=cave_terrain116[_i],_who=_r.who;
            var _shape=instance_exists(_who) && _who.x==_r.x && _who.y==_r.y
                && _who.image_xscale==_r.xs && _who.image_yscale==_r.ys
                && _who.mask_index==_r.mask && _who.image_angle==_r.angle;
            if(!_shape) show_debug_message("HARDMODE CAVE116 GEOMETRY "+json_stringify({before:_r,exists:instance_exists(_who),after:instance_exists(_who)?{x:_who.x,y:_who.y,xs:_who.image_xscale,ys:_who.image_yscale,mask:_who.mask_index,angle:_who.image_angle,sprite:sprite_get_name(_who.sprite_index)}:undefined}));
            scrHMGameplayCheck(_shape,
                "palette restoration preserves every actual terrain instance and collision shape");
            var _expected=_stage?scrHMCavePaletteSprite116(_r.sprite):_r.sprite;
            if(_who.sprite_index!=_expected) {_bad++;if(_bad<12) show_debug_message("HARDMODE CAVE116 PALETTE "+json_stringify({kind:_r.kind,x:_r.x,y:_r.y,before:sprite_get_name(_r.sprite),expected:sprite_get_name(_expected),actual:sprite_get_name(_who.sprite_index)}));}
            if(_r.kind==0) _floors++;
            if(_r.kind==1) {
                _walls++;
                if(_who.topspr!=(_stage?sprWall4Top:_r.top) || _who.outspr!=(_stage?sprWall4Out:_r.out)) _bad++;
            }
        }
        scrHMGameplayCheck(_bad==0 && _floors>0 && _walls>0,"all distant A/B/broken floors and wall face/top/exterior/transition palettes finish consistently");
        player.x=cave_far116.x+16;player.y=cave_far116.y+16;BackCont.force_snap_camera_position=true;
        show_debug_message("HARDMODE CAVE116 "+json_stringify({mode:mode,far_distance:cave_distance116,floors:_floors,walls:_walls,bad:_bad,finish:ticks}));
    }
    if(ticks==cave_finish116+10 && surface_exists(application_surface))
        surface_save(application_surface,game_directory+mode+"-far.png");
}

function scrHMGameplayCorpseKill116(_actor) {
    scrHMGameplayCheck(instance_exists(_actor),"actual Hardmode enemy constructor creates corpse regression actor");
    with(_actor) {speed=0;hp=0;scrHMEnemyStep();}
}

function scrHMGameplayCorpseRow116(_record) {
    var _body=_record.who,_control=_record[$ "control"]??noone;
    return {who:_body,exists:instance_exists(_body),source:sprite_get_name(_record.source),
        expected:sprite_get_name(scrHMCorpseSprite116(_record.source)),
        original:instance_exists(_body)?sprite_get_name(_body[$ "hm_corpse_original116"]??_record.source):"missing",
        provenance:instance_exists(_body)?(_body[$ "hm_enemy_body116"]??false):false,
        object:instance_exists(_body)?object_get_name(_body.object_index):"missing",
        actual:instance_exists(_body)?sprite_get_name(_body.sprite_index):"missing",
        frame:instance_exists(_body)?_body.image_index:-1,speed:instance_exists(_body)?_body.image_speed:-1,
        num:instance_exists(_body)?_body.image_number:0,mask:instance_exists(_body)?_body.mask_index:-1,
        revive:instance_exists(_body)?(_body[$ "specialrevive"]??undefined):undefined,
        control:_control,control_exists:instance_exists(_control),
        control_sprite:instance_exists(_control)?sprite_get_name(_control.sprite_index):"missing",
        control_mask:instance_exists(_control)?_control.mask_index:-1,
        control_frame:instance_exists(_control)?_control.image_index:-1,
        control_speed:instance_exists(_control)?_control.image_speed:-1};
}

function scrHMGameplayCorpse116() {
    if(mode!="corpse116") return;
    if(ticks==10) {
        scrHMGameplayLane107();UberCont.opt_bossintro=0;
        scrHMModSet("mod","options","intropan","0");scrHMModSet("mod","options","bossoutros","0");
        player.x=14240;player.y=14220;BackCont.force_snap_camera_position=true;
        corpse_sources116=[sprMutant2BDead,sprMutant4Dead,sprMutant4BDead,sprMutant5Dead,
            sprHM_enemies_mod_64,sprMutant8Dead,sprMutant9Dead,sprMutant14Dead];
        var _ctors=[hm_enemies_mod_gml_crystalshielder_create,hm_enemies_mod_gml_enemyplant_create,
            hm_enemies_mod_gml_enemysteroids_create,hm_enemies_mod_gml_enemyrobot_create,
            hm_enemies_mod_gml_enemychicken_create,hm_enemies_mod_gml_enemyskeleton_create];
        for(var _i=0;_i<array_length(_ctors);++_i) {
            var _actor=scrHMInvokeHere(scrHMScriptRef(_ctors[_i]),[14120+(_i mod 3)*80,14100+(_i div 3)*80]);
            scrHMGameplayCorpseKill116(_actor);
        }
        var _melting=false,_melting_b=false;
        for(var _i=0;_i<32 && !(_melting && _melting_b);++_i) {
            var _actor=hm_enemies_mod_gml_enemymelting_create(14360,14100+(_melting?80:0));
            if(_actor.spr_dead==sprMutant4Dead) _melting=true;
            if(_actor.spr_dead==sprMutant4BDead) _melting_b=true;
            scrHMGameplayCorpseKill116(_actor);
        }
        scrHMGameplayCheck(_melting && _melting_b,"real random Melting factory exercises both authored death skins");
        // The revived Messenger borrows bright player death art; Steroids
        // already authors an appropriately dark final corpse and is a control.
        var _messenger=hm_enemies_mod_gml_enemyrogue_create(14440,14100);
        scrHMGameplayCorpseKill116(_messenger);
        var _revive_body=noone,_freak=noone;
        with(Corpse) if(x==14440 && (self[$ "specialrevive"]??"")=="rogue") _revive_body=id;
        scrHMGameplayCheck(instance_exists(_revive_body),"actual Messenger death supplies the native revival corpse context");
        with(_revive_body) _freak=hm_enemies_mod_gml_enemyrogue_create(14440,14180);
        scrHMGameplayCheck(instance_exists(_freak) && _freak.name=="roguefreak"
            && _freak.spr_dead==global.hm_module_vars[$ "mod:enemies"].roguefreakdead,
            "native corpse-context factory constructs the true bright RogueFreak family");
        scrHMGameplayCorpseKill116(_freak);
        with(IDPDSpawn) instance_destroy(id,false);
        with(PopoExplosion) instance_destroy(id,false);
        with(WantRevivePopoFreak) instance_destroy(id,false);
        var _native=instance_create(14360,14260,Bandit);_native.speed=0;_native.hp=0;instance_destroy(_native);
        // Player Destroy creates this unmarked native body. The common corpse
        // event must leave its original shared player death art unchanged.
        corpse_player116=instance_create(14120,14260,Corpse);
        corpse_player116.sprite_index=sprMutant4Dead;corpse_player116.image_xscale=-1;
    }
    if(ticks==11) {
        // Chicken's real first death creates its headless continuation; finish
        // that actual second actor rather than faking a generic corpse.
        with(CustomEnemy) if(name=="" || name=="enemychicken") {hp=0;scrHMEnemyStep();}
    }
    if(ticks==12) {
        corpse_bodies116=[];
        with(Corpse) if(self[$ "hm_enemy_body116"]??false)
            array_push(other.corpse_bodies116,{who:id,source:sprite_index,blend:image_blend,alpha:image_alpha,
                xs:image_xscale,ys:image_yscale,mask:mask_index,revive:self[$ "specialrevive"]??undefined});
        var _initial=[];
        for(var _i=0;_i<array_length(corpse_bodies116);++_i)
            array_push(_initial,scrHMGameplayCorpseRow116(corpse_bodies116[_i]));
        show_debug_message("HARDMODE CORPSE116 INITIAL "+json_stringify({tick:ticks,bodies:_initial}));
        scrHMGameplayCheck(array_length(corpse_bodies116)>=9,"real combat deaths create all custom families plus a native comparison body");
        for(var _i=0;_i<array_length(corpse_bodies116);++_i) {
            var _r=corpse_bodies116[_i];
            if(array_contains(corpse_sources116,_r.source))
                scrHMGameplayCheck(_r.who.sprite_index==_r.source && _r.who.image_speed>0,
                    "enemy death retains its original bright animation before the settled frame");
            // An unmarked native control follows the same animation and
            // CorpseActive -> Corpse transition, including its default mask.
            var _origin=_r.who,_control=instance_create(_origin.x,_origin.y,_origin.object_index);
            _control.sprite_index=_origin.sprite_index;_control.image_index=_origin.image_index;
            _control.image_speed=_origin.image_speed;_control.mask_index=_origin.mask_index;
            _control.image_blend=_origin.image_blend;_control.image_alpha=_origin.image_alpha;
            _control.image_xscale=_origin.image_xscale;_control.image_yscale=_origin.image_yscale;
            _control.speed=_origin.speed;_control.direction=_origin.direction;_control.friction=_origin.friction;
            _control.specialrevive=_r.revive;_control.forceportal=true;
            _r.control=_control;
        }
    }
    if(ticks==50) {
        var _seen=[],_rows=[];
        for(var _i=0;_i<array_length(corpse_bodies116);++_i)
            array_push(_rows,scrHMGameplayCorpseRow116(corpse_bodies116[_i]));
        show_debug_message("HARDMODE CORPSE116 SETTLED PRECHECK "+json_stringify({tick:ticks,bodies:_rows}));
        for(var _i=0;_i<array_length(corpse_bodies116);++_i) {
            var _r=corpse_bodies116[_i],_body=_r.who,_control=_r.control;
            scrHMGameplayCheck(instance_exists(_body),"corpse survives through its actual native animation lifecycle");
            scrHMGameplayCheck(instance_exists(_control) && _control.sprite_index==_r.source
                && _control.image_speed==0,"unmarked comparison completes the original native corpse lifecycle");
            var _expected=scrHMCorpseSprite116(_r.source);
            if(array_contains(corpse_sources116,_r.source))
                scrHMGameplayCheck(_expected!=_r.source,"each bright family resolves to an independent private corpse strip");
            scrHMGameplayCheck(_body.sprite_index==_expected && _body.image_speed==0
                && floor(_body.image_index)==sprite_get_number(_expected)-1,
                "actual Corpse animation end selects only the correct final enemy-owned artwork");
            var _same=_body.image_blend==_r.blend && _body.image_alpha==_r.alpha
                && _body.image_xscale==_r.xs && _body.image_yscale==_r.ys && _body.mask_index==_control.mask_index
                && (_body[$ "specialrevive"]??undefined)==_r.revive;
            if(!_same) show_debug_message("HARDMODE CORPSE116 METADATA "+json_stringify({source:sprite_get_name(_r.source),
                before:_r,after:{blend:_body.image_blend,alpha:_body.image_alpha,xs:_body.image_xscale,
                ys:_body.image_yscale,mask:_body.mask_index,revive:_body[$ "specialrevive"]??undefined}}));
            scrHMGameplayCheck(_same,
                "settled artwork keeps alpha, custom tint, collision geometry, orientation and revival metadata");
            var _before={blend:_body.image_blend,alpha:_body.image_alpha,xs:_body.image_xscale,
                ys:_body.image_yscale,mask:_body.mask_index,revive:_body[$ "specialrevive"]??undefined};
            _body.sprite_index=_r.source;
            with(_body) scrHMCorpseSettle116();
            scrHMGameplayCheck(_body.sprite_index==_expected && _body.image_blend==_before.blend
                && _body.image_alpha==_before.alpha && _body.image_xscale==_before.xs
                && _body.image_yscale==_before.ys && _body.mask_index==_before.mask
                && (_body[$ "specialrevive"]??undefined)==_before.revive,
                "gray-art helper itself changes no alpha, tint, scale, mask or revival metadata");
            if(array_contains(corpse_sources116,_r.source) && !array_contains(_seen,_r.source)) array_push(_seen,_r.source);
        }
        var _missing=[];
        for(var _i=0;_i<array_length(corpse_sources116);++_i)
            if(!array_contains(_seen,corpse_sources116[_i])) array_push(_missing,sprite_get_name(corpse_sources116[_i]));
        show_debug_message("HARDMODE CORPSE116 COVERAGE "+json_stringify({seen:_seen,missing:_missing,bodies:_rows}));
        scrHMGameplayCheck(array_length(_seen)==8,"all eight previously bright corpse families reach their private dark-gray final frame");
        scrHMGameplayCheck(corpse_player116.sprite_index==sprMutant4Dead && corpse_player116.image_blend==c_white
            && corpse_player116.image_speed==0,"unmarked player corpse retains the original full-colour death artwork");
        show_debug_message("HARDMODE CORPSE116 "+json_stringify({rate:rate,bodies:_rows,player_unchanged:true}));
    }
    if(ticks==55 && surface_exists(application_surface))
        surface_save(application_surface,game_directory+"corpse116-settled.png");
}
