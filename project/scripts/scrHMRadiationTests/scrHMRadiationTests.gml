// Explicit desktop-only regressions. Never activated by normal mobile startup.
function scrHMRadiationTestCheck(_condition, _description) {
    assert(_condition, "Hardmode radiation: " + _description);
    global.hm_test_checks++;
}

function scrHMRadiationTestEnemy(_object, _amount) {
    var _enemy = instance_create(10000, 10000, _object);
    _enemy.raddrop = _amount;
    _enemy.corpse = false;
    return _enemy;
}

function scrHMRadiationTestDroppedAmount() {
    var _amount = 0;
    with (Rad) _amount += (object_index == BigRad) ? 10 : 1;
    return _amount;
}

function scrHMRadiationTestKill(_enemy, _expected) {
    with (Rad) instance_destroy(id, false);
    _enemy.hp = 0;
    instance_destroy(_enemy);
    scrHMRadiationTestCheck(scrHMRadiationTestDroppedAmount() == _expected,
        "actual death pickup total: expected " + string(_expected) + ", got " + string(scrHMRadiationTestDroppedAmount()));
    with (Rad) instance_destroy(id, false);
}

function scrHMRadiationTestCapLog(_phase,_rate,_custom,_boost,_expected,_created,_read_cap) {
    var _cont=instance_find(GameCont,0),_fields=[];
    var _names=["hm_maxlevel1100","hm_level_base","hm_level_cap","hm_playerboost"];
    for(var _i=0;_i<array_length(_names);++_i) {
        var _exists=instance_exists(_cont) && variable_instance_exists(_cont,_names[_i]);
        array_push(_fields,{field:_names[_i],exists:_exists,
            value:_exists?variable_instance_get(_cont,_names[_i]):"<absent>"});
    }
    var _option=scrHMModGet("mod","options","playerboost");
    show_debug_message("HARDMODE RADIATION CAP CONTEXT "+json_stringify({
        phase:_phase,rate:_rate,custom:_custom,desired_boost:_boost,expected_cap:_expected,
        created_id:string(_created),active_id:string(_cont),active_count:instance_number(GameCont),
        created_active:instance_exists(_created),enabled:scrHMEnabled(),custom_active:UberCont.custom,
        configured_base:scrCustomParam("maxlevel",10),option:_option,option_is_string:is_string(_option),
        policy_boost:hm_arkintide_mod_gml_hm_playerboost_enabled(),
        actual_cap:_read_cap?PLAYER_LEVEL_MAX:-1,cache:_fields}));
}

function scrHMRunRadiationTests() {
    if (os_type != os_windows) return false;
    var _enabled = false, _custom = 0;
    for (var _i = 1; _i <= parameter_count(); ++_i) {
        if (parameter_string(_i) == "--hardmode-radiation-tests") _enabled = true;
        if (parameter_string(_i) == "--hardmode-radiation-custom-tests") {_enabled = true;_custom = 1;}
    }
    if (!_enabled) return false;

    global.hm_test_checks = 0;
    UberCont.opt_freeze = 0;
    UberCont.dont_save = true;
    UberCont.opt_achievs = false;
    // A separate native:radiation-custom process selects its real custom
    // options before the first GameCont exists. Keep that controller alive
    // throughout this process, as in a normal run; only change the supported
    // player-boost setting through the production progression initializer.
    UberCont.custom = _custom == 1;
    if (_custom) {
        UberCont.custom_options = new CustomModeOptions("Hardmode radiation regression");
        UberCont.custom_options.maxlevel = 5;
    }
    // MakeGame.Alarm0 reaches this explicit regression before the normal
    // game world is constructed. Use the same native world bootstrap as the
    // production run (and native world regression), including module loads;
    // do not fabricate registry globals or enable Hardmode by hand.
    if (!instance_exists(GameCont)) instance_create(0, 0, GameCont);
    if (!instance_exists(BackCont)) instance_create(0, 0, BackCont);
    if (!instance_exists(TopCont)) instance_create(0, 0, TopCont);
    if (!instance_exists(MusCont)) instance_create(0, 0, MusCont);
    var _created = instance_find(GameCont,0);
    var _world = instance_create(0, 0, HMWorld);
    scrHMTasksTick(1); // Finish the real option loader's filesystem wait.
    scrHMRadiationTestCheck(scrHMEnabled() && instance_exists(_world),
        "native HMWorld Create bootstraps the actual Hardmode runtime");
    scrHMRadiationTestCheck(scrHMModExists("mod", "options", "playerboost")
        && !is_undefined(scrHMContentRef1100("mod", "arkintide", "hm_radiation")),
        "production option and radiation modules are loaded before their use");
    // Default and custom base caps have independent native processes. Within
    // this process all 30/60 Hz and boost combinations share the actual live
    // controller and production's idempotent option-change initialization.
    var _amounts = [-1, 0, 1, 2, 4, 5, 10, 20, 75, 100];
    for (var _rate = 30; _rate <= 60; _rate += 30) {
        game_set_speed(_rate, gamespeed_fps);
        global.time_scale = 30 / _rate;
       for (var _boost = 0; _boost <= 1; ++_boost) {
        with (enemy) instance_destroy(id, false);
        var _maximum = (_custom ? 5 : 10) + _boost;
        scrHMRadiationTestCapLog("before-production-option-change",_rate,_custom,_boost,_maximum,_created,false);
        scrHMModSet("mod", "options", "playerboost", string(_boost));
        scrHMRadiationTestCapLog("after-production-option-change",_rate,_custom,_boost,_maximum,_created,false);
        scrHMRadiationTestCheck(instance_exists(_created) && instance_number(GameCont)==1
            && instance_find(GameCont,0)==_created,
            "original native controller remains the unique active GameCont");
        hm_arkintide_mod_gml_hm_progression_start();
        scrHMRadiationTestCapLog("before-cap-assertion",_rate,_custom,_boost,_maximum,_created,true);
        scrHMRadiationTestCheck(PLAYER_LEVEL_MAX == _maximum,
            "native run honors the configured cap and player-boost switch");
        repeat (3) hm_arkintide_mod_gml_hm_progression_start();
        scrHMRadiationTestCheck(PLAYER_LEVEL_MAX == _maximum,
            "repeated production initialization does not stack the extra level");
        var _levels = [1, _maximum - 1, _maximum, _maximum + 1];
        for (var _l = 0; _l < array_length(_levels); ++_l) {
            GameCont.level = _levels[_l];
            scrHMRadiationTestCheck(scrHMRadiationBelowMaximum() == (GameCont.level < _maximum),
                "production boundary uses the actual configured maximum");
            for (var _a = 0; _a < array_length(_amounts); ++_a) {
                var _amount = _amounts[_a], _enemy = scrHMRadiationTestEnemy(Bandit, _amount);
                var _expected = GameCont.level < _maximum ? max(0, _amount - 4) : _amount;
                repeat (_rate * 2) scrHMRadiationSyncWorld();
                scrHMRadiationTestCheck(_enemy.raddrop == _expected, "level/drop matrix; repeated sync must be idempotent");
                instance_destroy(_enemy, false);
            }
            var _maggot = scrHMRadiationTestEnemy(RadMaggot, 2);
            scrHMRadiationSyncWorld();
            scrHMRadiationTestCheck(_maggot.raddrop == (GameCont.level < _maximum ? 1 : 2), "radiation maggot exception");
            instance_destroy(_maggot, false);
        }

        GameCont.level = _maximum - 1;
        var _existing = scrHMRadiationTestEnemy(Bandit, 20);
        scrHMRadiationSyncWorld();
        _existing.raddrop += 7; // Absorbed pickups must survive the cap transition.
        _existing.raddrop -= 3; // Radiation spent on an ability must stay spent.
        GameCont.rad = GameCont.level * 60 + 1;
        with (GameCont) event_perform(ev_step, ev_step_normal);
        scrHMRadiationTestCheck(GameCont.level == _maximum, "native level-up reached the actual cap");
        // The native GameCont event owns leveling; the main module owns the
        // later radiation pass (maincode.step_resume case 361). Exercise the
        // same production policy through its world-sync boundary explicitly.
        // This is not a claim that the entire main-module scheduler ran.
        show_debug_message("HARDMODE RADIATION SCHEDULER BOUNDARY " + json_stringify({
            rate:_rate,custom:_custom,boost:_boost,maximum:_maximum,
            after_native_levelup:_existing.raddrop,
            boundary:"scrHMRadiationSyncWorld -> scrHMRadiationSync -> hm_radiation",
            full_main_module_tick:false}));
        scrHMRadiationSyncWorld();
        scrHMRadiationTestCheck(_existing.raddrop == 24, "post-level scheduler boundary restores only the reduction delta");
        repeat (_rate) scrHMRadiationSyncWorld();
        scrHMRadiationTestCheck(_existing.raddrop == 24, "no repeated cap refund");
        scrHMRadiationTestKill(_existing, 24);
        scrHMRadiationTestKill(scrHMRadiationTestEnemy(Bandit, 5), 5);

        GameCont.level = _maximum - 1;
        // No preceding world step: the destroy hook must still apply the rule.
        scrHMRadiationTestKill(scrHMRadiationTestEnemy(Bandit, 5), 1);
        scrHMRadiationTestKill(scrHMRadiationTestEnemy(RadMaggot, 2), 1);
        var _m = scrHMRadiationTestEnemy(RadMaggot, 2);
        scrHMRadiationSyncWorld();
        _m.raddrop += 3;
        GameCont.level = _maximum;
        scrHMRadiationTestKill(_m, 5);

        // A zero-reward scripted spawn must not suddenly gain a vanilla reward.
        GameCont.level = _maximum - 1;
        var _zero = scrHMRadiationTestEnemy(Bandit, 0);
        scrHMRadiationSyncWorld();
        _zero.raddrop += 4;
        GameCont.level = _maximum;
        scrHMRadiationTestKill(_zero, 4);

        // User-requested rewards: real native Create amounts, actual death
        // pickups, and reversible signed deltas across the real level cap.
        var _objects109=[Raven,SnowBot,DogGuardian,LaserCrystal,LightningCrystal,InvLaserCrystal];
        var _before109=[1,1,10,8,11,11],_after109=[4,5,20,22,25,25];
        for(var _n109=0;_n109<array_length(_objects109);++_n109) {
            GameCont.level=_maximum-1;
            var _e109=instance_create(10000,10000,_objects109[_n109]);
            _e109.corpse=false;
            repeat(10)scrHMRadiationSyncWorld();
            scrHMRadiationTestCheck(_e109.raddrop==_before109[_n109],"requested pre-cap reward from native Create");
            _e109.raddrop+=3;
            repeat(10)scrHMRadiationSyncWorld();
            scrHMRadiationTestCheck(_e109.raddrop==_before109[_n109]+3,"pre-cap repeats preserve absorbed radiation");
            GameCont.level=_maximum;repeat(10)scrHMRadiationSyncWorld();
            scrHMRadiationTestCheck(_e109.raddrop==_after109[_n109]+3,"cap restores native reward and absorbed radiation");
            GameCont.level=_maximum-1;repeat(10)scrHMRadiationSyncWorld();
            scrHMRadiationTestCheck(_e109.raddrop==_before109[_n109]+3,"cap reversal does not compound special adjustments");
            scrHMRadiationTestKill(_e109,_before109[_n109]+3);
        }
        show_debug_message("HARDMODE RADIATION CONFIG PASS " + json_stringify({rate:_rate,custom:_custom,boost:_boost,maximum:_maximum}));
       }
        show_debug_message("HARDMODE RADIATION RATE PASS " + string(_rate));
    }
    show_debug_message("HARDMODE RADIATION CONTROLLER "+string(_created));
    var _report = json_stringify({status:"PASS",checks:global.hm_test_checks,rates:[30,60],
        custom_base:_custom?5:10,boost_settings:[0,1],physical_device_tested:false});
    file_write(working_directory + "hardmode-radiation-tests.json", _report);
    show_debug_message("HARDMODE "+(_custom?"RADIATION-CUSTOM":"RADIATION")+" RESULT " + _report);
    game_end();
    return true;
}
