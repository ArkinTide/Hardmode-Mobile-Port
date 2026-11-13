// Execute through the real gameplay driver; production 30Hz and60Hz host events remain active.
function scrHMGameplayHunter1104() {
    scrHMGameplayBossGroup115();
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
