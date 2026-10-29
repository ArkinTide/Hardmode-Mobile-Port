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

function scrHMRunRadiationTests() {
    if (os_type != os_windows) return false;
    var _enabled = false;
    for (var _i = 1; _i <= parameter_count(); ++_i) {
        if (parameter_string(_i) == "--hardmode-radiation-tests") _enabled = true;
    }
    if (!_enabled) return false;

    global.hm_test_checks = 0;
    UberCont.opt_freeze = 0;
    UberCont.dont_save = true;
    UberCont.opt_achievs = false;
    if (!instance_exists(GameCont)) instance_create(0, 0, GameCont);
    // Exercise actual drop creation and the level-up event with the native VM.
    var _levels = [1, 9, 10, 11], _amounts = [-1, 0, 1, 2, 4, 5, 10, 20, 75, 100];
    for (var _rate = 30; _rate <= 60; _rate += 30) {
        game_set_speed(_rate, gamespeed_fps);
        global.time_scale = 30 / _rate;
        for (var _l = 0; _l < array_length(_levels); ++_l) {
            GameCont.level = _levels[_l];
            for (var _a = 0; _a < array_length(_amounts); ++_a) {
                var _amount = _amounts[_a], _enemy = scrHMRadiationTestEnemy(Bandit, _amount);
                var _expected = GameCont.level < 10 ? max(0, _amount - 4) : _amount;
                repeat (_rate * 2) scrHMRadiationSyncWorld();
                scrHMRadiationTestCheck(_enemy.raddrop == _expected, "level/drop matrix; repeated sync must be idempotent");
                instance_destroy(_enemy, false);
            }
            var _maggot = scrHMRadiationTestEnemy(RadMaggot, 2);
            scrHMRadiationSyncWorld();
            scrHMRadiationTestCheck(_maggot.raddrop == (GameCont.level < 10 ? 1 : 2), "radiation maggot exception");
            instance_destroy(_maggot, false);
        }

        GameCont.level = 9;
        var _existing = scrHMRadiationTestEnemy(Bandit, 20);
        scrHMRadiationSyncWorld();
        _existing.raddrop += 7; // Absorbed pickups must survive the cap transition.
        _existing.raddrop -= 3; // Radiation spent on an ability must stay spent.
        GameCont.rad = GameCont.level * 60 + 1;
        with (GameCont) event_perform(ev_step, ev_step_normal);
        scrHMRadiationTestCheck(GameCont.level == 10, "native level-up reached the cap");
        scrHMRadiationTestCheck(_existing.raddrop == 24, "native level-up restored only the reduction delta");
        repeat (_rate) scrHMRadiationSyncWorld();
        scrHMRadiationTestCheck(_existing.raddrop == 24, "no repeated cap refund");
        scrHMRadiationTestKill(_existing, 24);
        scrHMRadiationTestKill(scrHMRadiationTestEnemy(Bandit, 5), 5);

        GameCont.level = 9;
        // No preceding world step: the destroy hook must still apply the rule.
        scrHMRadiationTestKill(scrHMRadiationTestEnemy(Bandit, 5), 1);
        scrHMRadiationTestKill(scrHMRadiationTestEnemy(RadMaggot, 2), 1);
        var _m = scrHMRadiationTestEnemy(RadMaggot, 2);
        scrHMRadiationSyncWorld();
        _m.raddrop += 3;
        GameCont.level = 10;
        scrHMRadiationTestKill(_m, 5);

        // A zero-reward scripted spawn must not suddenly gain a vanilla reward.
        GameCont.level = 9;
        var _zero = scrHMRadiationTestEnemy(Bandit, 0);
        scrHMRadiationSyncWorld();
        _zero.raddrop += 4;
        GameCont.level = 10;
        scrHMRadiationTestKill(_zero, 4);

        // Actual configured cap rather than a hard-coded 10 (custom mode).
        UberCont.custom = true;
        UberCont.custom_options = new CustomModeOptions("Hardmode radiation regression");
        UberCont.custom_options.maxlevel = 5;
        GameCont.level = 4;
        var _cap = scrHMRadiationTestEnemy(Bandit, 10);
        scrHMRadiationSyncWorld();
        scrHMRadiationTestCheck(_cap.raddrop == 6, "configured cap: below maximum");
        GameCont.level = 5;
        scrHMRadiationSyncWorld();
        scrHMRadiationTestCheck(_cap.raddrop == 10, "configured cap: at maximum");
        instance_destroy(_cap, false);
        UberCont.custom = false;

        show_debug_message("HARDMODE RADIATION RATE PASS " + string(_rate));
    }
    var _report = json_stringify({status:"PASS",checks:global.hm_test_checks,rates:[30,60],physical_device_tested:false});
    file_write(working_directory + "hardmode-radiation-tests.json", _report);
    show_debug_message("HARDMODE RADIATION RESULT " + _report);
    game_end();
    return true;
}
