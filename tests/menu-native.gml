// Exercise normal title -> play -> campfire selection and its real Draw
// callbacks. The earlier gameplay-only entrypoint skipped this path.
function scrHMMenuTests() {
    if(os_type!=os_windows) return false;
    var _enabled=false,_rate=30;
    for(var _i=1;_i<=parameter_count();++_i) {
        var _arg=parameter_string(_i);
        if(_arg=="--hardmode-menu-tests") _enabled=true;
        if(string_pos("--hardmode-menu-rate=",_arg)==1)
            _rate=real(string_delete(_arg,1,string_length("--hardmode-menu-rate=")));
    }
    if(!_enabled) return false;
    scrHMGameplayErrorInit();
    UberCont.dont_save=true;UberCont.opt_autopause=false;
    UberCont.want_quit_to_menu=true;UberCont.showtutorial=false;
    save_set_value("game","tutorial",false);
    save_set_value("etc","disclaimer",true);
    save_set_value("options","autopause",false);
    save_set_value("options","fullscreen",false);
    save_set_value("options","framerate",_rate);
    game_set_speed(_rate,gamespeed_fps);global.time_scale=30/_rate;
    var _test=instance_create(0,0,HMMenuTest);
    _test.rate=_rate;_test.frames=0;_test.ticks=0;_test.checks=0;_test.phase=0;
    _test.binding_ids=[];_test.shilling_draws=0;_test.version_draws=0;_test.language_index=-1;
    _test.languages=["English","Simplified Chinese","German","Traditional Chinese","Simplified Chinese"];
    room_goto(romGame);
    instance_destroy();
    return true;
}

function scrHMMenuCheck(_condition,_message) {
    if(!_condition) throw "Hardmode menu regression: "+_message;
    checks++;
}

function scrHMMenuOptionsCheck() {
    var _menu=instance_create(0,0,MenuOptions);
    var _main=_menu.options[OptionCategory.Main];
    for(var _i=0;_i<array_length(_main);++_i) {
        scrHMMenuCheck(_main[_i][$ "category"]!=OptionCategory.Resourcepacks,"no resourcepack entry");
        scrHMMenuCheck(_main[_i][$ "category"]!=OptionCategory.Coop_Menu,"no multiplayer entry");
    }
    scrOptionsMenuChangeCategory(OptionCategory.Hardmode,false);
    scrHMMenuCheck(_menu.item_count==7,"seven single-player MOD options");
    for(var _j=0;_j<_menu.item_count;++_j) {
        var _opt=_menu.items[_j];
        scrHMMenuCheck(_opt.hm_setting!="coopchests","no obsolete co-op ammo setting");
        if(scrHMChinese()) scrHMMenuCheck(_opt.name!=string_upper(_opt.name)||ord(string_char_at(_opt.name,1))>127,"Chinese option label");
    }
    with(_menu) instance_destroy();
}

function scrHMMenuCrown106() {
    var _race=Race.Chicken,_pinst=scr_playerinstance_find();
    var _old_race=_pinst.race,_old_crown=scrCrownGetCurrent();
    var _old_choice=save_get_value("ccrown",_race,crwn_none);
    var _old_unlocked=UberCont.cgot[_race],_old_row=UberCont.crowngot[_race];
    UberCont.cgot[_race]=true;
    UberCont.crowngot[_race]=array_create(crownmax+1,false);
    UberCont.crowngot[_race,crwn_none]=true;
    var _invalid=[15,-1,2.5,"15"];
    for(var _i=0;_i<array_length(_invalid);++_i) {
        var _bad=_invalid[_i];
        save_set_value("ccrown",_race,_bad);
        scrHMMenuCheck(scr_loadout_race_get_start_crown(_race)==crwn_none,"invalid saved crown falls back to no crown");
        scrHMMenuCheck(!scr_loadout_race_is_crown_unlocked(_race,_bad),"invalid crown cannot index the unlock array");
        scrHMMenuCheck(!scr_loadout_race_set_start_crown(_race,_bad),"invalid crown cannot replace a valid selection");
        scr_loadout_race_unlock_crown(_race,_bad);
        scrHMMenuCheck(array_length(UberCont.crowngot[_race])==crownmax+1,"invalid unlock does not extend crown progress");
    }
    var _bad_races=[-1,Race.NUM_ALL_RACE_TYPES+1,1.5];
    for(var _i=0;_i<array_length(_bad_races);++_i) {
        var _bad_race=_bad_races[_i];
        scrHMMenuCheck(!scr_loadout_race_is_crown_unlocked(_bad_race,crwn_none),"invalid character ID cannot index crown progress");
    }
    // Reproduce the screenshot through the real touch/click event with a
    // 14-entry crown row and ccrown_9=15, rather than only calling a guard.
    save_set_value("ccrown",_race,15);_pinst.race=Race.Fish;
    var _character=noone;with(CharSelect) if(race==_race) {_character=id;break;}
    scrHMMenuCheck(instance_exists(_character),"Chicken selection exists for invalid-crown regression");
    var _old_can=_character.can;_character.can=true;
    with(_character) event_perform(ev_mouse,ev_left_press);
    scrHMMenuCheck(_pinst.race==_race&&scrCrownGetCurrent()==crwn_none,"clicking Chicken with crown15 selects safely");
    UberCont.crowngot[_race,Crown.Love]=true;
    save_set_value("ccrown",_race,Crown.Love);_pinst.race=Race.Fish;
    with(_character) event_perform(ev_mouse,ev_left_press);
    scrHMMenuCheck(_pinst.race==_race&&scrCrownGetCurrent()==Crown.Love,"valid saved and unlocked crowns remain selected");
    scrHMMenuCheck(UberCont.crowngot[_race,Crown.Love],"valid unlock remains intact");
    _character.can=_old_can;
    UberCont.cgot[_race]=_old_unlocked;UberCont.crowngot[_race]=_old_row;
    save_set_value("ccrown",_race,_old_choice);
    _pinst.race=_old_race;scrCrownSetCurrent(_old_crown,true);
    with(CharSelect) selected=race==_old_race;
    crown_invalid_save_checked106=true;
}

function scrHMMenuTestStep() {
    frames++;UberCont.dont_save=true;UberCont.opt_autopause=false;
    if(frames>rate*25) throw "Timed out while testing title and character selection: "+json_stringify({phase:phase,ticks:ticks,
        main:instance_number(MainMenuButton),play:instance_number(PlayButton),logo:instance_number(Logo),
        select:instance_number(CharSelect),gen:instance_number(MenuGen),world:instance_number(HMWorld)});
    if(frames==rate*3 && surface_exists(application_surface))
        surface_save(application_surface,game_directory+"menu-diagnostic.png");
    // Menu text must survive on render-only frames between 30 Hz logic ticks.
    for(var _i=0;_i<array_length(binding_ids);++_i)
        scrHMMenuCheck(instance_exists(binding_ids[_i]),"menu overlay survives the previous Draw callback");
    binding_ids=[];
    if(phase==0) {
        // The achievement icon inherits MainMenuButton and is counted by
        // instance_number(parent), although it is not one of the text entries.
        var _main_count=0;
        with(MainMenuButton) if(object_index==MainMenuButton) _main_count++;
        if(_main_count!=4) return;
        scrHMMenuCheck(!instance_exists(ButtonDiscord),"Discord icon removed");
        with(MainMenuButton) if(object_index==MainMenuButton&&image_index==1) throw "Multiplayer button still present";
        scrHMMenuOptionsCheck();
        phase=1;
        with(MainMenuButton) if(object_index==MainMenuButton&&image_index==0) {event_user(0);break;}
        return;
    }
    if(phase==1) {
        if(!instance_exists(PlayButton)) return;
        with(PlayButton) if(num==1||num==2) throw "Daily or weekly entry still present";
        phase=2;
        with(PlayButton) if(num==0) {event_user(0);break;}
        return;
    }
    if(!instance_exists(CharSelect)||instance_exists(FloorMaker)) return;
    if(ticks>2) {
        var _menu_bindings=0;
        with(HMBinding) if(hm_draw&&(hm_code==scrHMScriptRef(hm_maincode_mod_gml_shilling)
                ||hm_code==scrHMScriptRef(hm_maincode_mod_gml_versionnumber))) _menu_bindings++;
        scrHMMenuCheck(_menu_bindings==2,"exactly two visible menu overlays on every render frame");
    }
    if(!HMWorld.logic_tick) return;
    ticks++;
    if(ticks==1) scrHMMenuCrown106();
    var _language_index=floor((ticks-1)/45);
    if(_language_index>=array_length(languages)) {
        scrHMMenuCheck(shilling_draws>150&&version_draws>150,"both source Draw callbacks exercised repeatedly");
        scrHMMenuCheck(!instance_exists(CoopController)&&!instance_exists(ResourcepackManager),"disabled features inactive");
        with(CharSelect) instance_destroy();
        with(HMBinding) event_perform(ev_step,ev_step_end);
        var _left=0;with(HMBinding) if(hm_draw) _left++;
        scrHMMenuCheck(_left==0,"menu overlays disappear with character selection");
        var _receipt={status:"PASS",rate:rate,checks:checks,languages:languages,
            shilling_draws:shilling_draws,version_draws:version_draws,frames:frames,
            crown_invalid_save_checked:crown_invalid_save_checked106};
        // Execute actual character-screen cancellation on the surviving
        // controller; the native cleanup legitimately destroys this test.
        if(!instance_exists(BackButton)) instance_create(0,0,BackButton);
        with(HMWorld) {
            var _world=id;
            with(Menu) loadout_open=false;
            with(BackButton) {event_user(0);break;}
            if(instance_number(HMWorld)!=1 || !instance_exists(_world)) throw "Returning from character selection deleted Hardmode";
            if(!instance_exists(GameCont)) instance_create(0,0,GameCont);
            scrHMRunStart();
            if(!scrHMEnabled() || array_length(global.hm_module_order)!=45 || !variable_struct_exists(global.hm_area_ids,"palace")) throw "Hardmode registry disappeared after menu cancellation";
            _receipt.checks+=2;_receipt.menu_cancel_preserves_world=true;
            show_debug_message("HARDMODE MENU RESULT "+json_stringify(_receipt));
            global.hm_enabled=false;global.hm_tasks=[];game_end();
        }
        return;
    }
    if(_language_index!=language_index) {
        language_index=_language_index;
        scrLanguageSet(languages[language_index]);
        UberCont.opt_language=languages[language_index];
        save_set_value("etc","language",languages[language_index]);
        var _catalog=scrHMLocalizationCatalog(),_keys=variable_struct_get_names(_catalog);
        for(var _k=0;_k<array_length(_keys);++_k) {
            var _text=_keys[_k];
            scrHMMenuCheck(scrHMLocalize(_text)==(scrHMChinese()?_catalog[$ _text]:_text),"language-gated dictionary");
        }
        scrHMMenuCheck(scrHMWeaponProperty("weapon:secretweapon1","weapon_name","")=="trident","raw weapon ID/name unchanged");
        scrHMMenuCheck(scr_weapon_get_name(global.hm_weapon_ids.secretweapon1)==(scrHMChinese()?"三叉戟":"trident"),"localized weapon presentation");
        scrHMMenuCheck(scrDeathCauseGetName([sprOasisBossIdle,"Big Bubbler"])==(scrHMChinese()?"巨型吐泡怪":"Big Bubbler"),"localized death cause");
        scrHMMenuCheck(scrHMLocalize("GREATER#GUARDIAN")== (scrHMChinese()?"上位守卫":"GREATER#GUARDIAN"),"legacy multiline boss title");
        scrHMMenuCheck(scrHMLocalize(" +3 BOLTS ")== (scrHMChinese()?" +3 箭矢 ":" +3 BOLTS "),"stock dynamic ammo pickup text and surrounding whitespace");
        scrHMMenuOptionsCheck();
        scrHMMenuCheck(global.language_current[$ "Init:Id"]==languages[language_index],"settings retain selected language");
        var _pinst=scr_playerinstance_find();
        var _race=(_pinst.race==Race.Fish)?Race.Crystal:Race.Fish;
        with(CharSelect) if(race==_race) {event_perform(ev_mouse,ev_left_press);break;}
    }
    if(ticks mod 45==25 && surface_exists(application_surface))
        surface_save(application_surface,game_directory+"menu-"+string(language_index)+".png");
    var _shilling=scrHMScriptRef(hm_maincode_mod_gml_shilling);
    var _version=scrHMScriptRef(hm_maincode_mod_gml_versionnumber);
    with(HMBinding) if(hm_draw&&(hm_code==_shilling||hm_code==_version)) {
        array_push(other.binding_ids,id);
        if(hm_code==_shilling) other.shilling_draws++;
        if(hm_code==_version) other.version_draws++;
    }
}
