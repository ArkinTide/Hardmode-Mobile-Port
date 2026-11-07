// Execute through the real gameplay driver; production 30Hz and60Hz host events remain active.
function scrHMGameplayHunter1104() {
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
            var _pending=variable_instance_get(GameCont,"hm_extra_pending")??false;
            var _extra=hm_arkintide_mod_gml_hm_extra_spawn("hunter",player.x+128,player.y);
            scrHMGameplayCheck(instance_exists(_extra),"actual native extra-Hunter factory creates a combat actor");
            var _max=140*(1+.05*GameCont.loops);
            scrHMGameplayCheck(_extra.hm_extra && abs(_extra.max_hp-_max)<.001 && abs(_extra.hp-_max)<.001,
                "extra Hunter preserves its original140 baseline with only one five-percent-per-Loop factor");
            scrHMGameplayCheck((variable_instance_get(GameCont,"hm_extra_pending")??false)==_pending,
                "native extra constructor restores its caller's pending context");
            with(_extra) repeat(5) scrHMBossHealth1103();
            scrHMGameplayCheck(abs(_extra.max_hp-_max)<.001,"normal boss sweep cannot add the L1 bonus to an extra Hunter");
            instance_destroy(_extra,false);
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
        scrHMGameplayCheck(_groups==Ammo.NUM_AMMO_TYPES+1 && array_length(_names)==11,
            "real CustomModeWeaponSelector grouping covers all eleven MOD weapons without a controller");
        instance_destroy(_selector,false);instance_activate_object(_controller);
        scrHMGameplayCheck(scrHMWeaponProperty("weapon:secretweapon2","weapon_area",-1)==-1,
            "live non-oasis area excludes the contextual Harpoon drop");
        var _area=GameCont.area;GameCont.area=scrHMAreaResolve("oasis");
        scrHMGameplayCheck(scrHMWeaponProperty("weapon:secretweapon2","weapon_area",-1)==1,
            "oasis still retains its genuine contextual Harpoon drop");
        GameCont.area=_area;
    }
}
