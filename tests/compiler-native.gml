function scrHMCompilerCheck(_condition, _message) {
    assert(_condition, "Hardmode native compiler: " + _message);
    global.hm_compiler_checks++;
}

function scrHMCompilerProbe() {
    var _probe=instance_create(0,0,HMTestProbe);
    _probe.result=0; _probe.done=0; _probe.visits=0;
    _probe.left=1; _probe.right=2; _probe.marker=10;
    _probe.observed_before=0; _probe.observed_after=0;
    return _probe;
}

function scrHMCompilerResetTasks() {
    with(HMTestProbe) instance_destroy(id,false);
    scrHMTaskRuntimeInit();
}

function scrHMCompilerTests() {
    if(os_type!=os_windows) return false;
    var _enabled=false;
    for(var _i=1;_i<=parameter_count();++_i) if(parameter_string(_i)=="--hardmode-compiler-tests") _enabled=true;
    if(!_enabled) return false;
    global.hm_compiler_checks=0;
    for(var _rate=30;_rate<=60;_rate+=30) {
        var _delta=30/_rate;
        scrHMCompilerResetTasks();
        var _root=scrHMCompilerProbe(),_a=scrHMCompilerProbe(),_b=scrHMCompilerProbe(),_c=scrHMCompilerProbe();
        global.hm_test_targets=[_a,_b]; global.hm_test_nested=_c;
        with(_root) hm_tests_compiler_fixture_gml_sync_conditions();
        scrHMCompilerCheck(_root.result==8,"legacy equality precedence");
        _root.right=3;
        with(_root) hm_tests_compiler_fixture_gml_sync_conditions();
        scrHMCompilerCheck(_root.result==9,"legacy conditional false arm");
        with(_root) hm_tests_compiler_fixture_gml_sync_with_break();
        scrHMCompilerCheck(_a.visits==1&&_b.visits==0&&_root.done==1,"synchronous with break stops enumeration");

        _root.result=0;
        with(_root) hm_tests_compiler_fixture_gml_wait_local(7);
        scrHMCompilerCheck(_root.result==7,"task executes before first wait");
        repeat(_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==7,"wait does not resume early");
        repeat(_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==14&&array_length(global.hm_tasks)==0,"locals and parameter survive wait");

        _root.result=0;
        with(_root) hm_tests_compiler_fixture_gml_fork_local(9);
        scrHMCompilerCheck(_root.result==1,"fork parent continues immediately");
        repeat(_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==10,"fork retains independent scalar locals");

        _root.done=0;_a.done=0;_b.done=0;_a.marker=20;_b.marker=30;
        with(_root) hm_tests_compiler_fixture_gml_with_resume();
        repeat(5*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_a.observed_before==10&&_a.observed_after==10,"first with retains other across wait");
        scrHMCompilerCheck(_b.observed_before==10&&_b.observed_after==10,"next with target gets caller as other");
        scrHMCompilerCheck(_c.observed_before==30&&_c.observed_after==30,"nested with retains immediate caller");
        scrHMCompilerCheck(_root.done==1&&_a.done==1&&_b.done==1,"nested with restores caller scope");

        _root.done=0;_a.visits=0;_b.visits=0;
        with(_root) hm_tests_compiler_fixture_gml_with_control();
        repeat(4*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_a.visits==2&&_b.visits==1&&_root.done==1,"async with break and continue unwind their frame");

        _root.result=0;
        with(_root) hm_tests_compiler_fixture_gml_counted_loop(9);
        repeat(6*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==8,"for locals, continue, break, and waits");

        _root.result=0;_root.done=0;
        with(_root) hm_tests_compiler_fixture_gml_switch_resume(1);
        repeat(_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==5&&_root.done==1,"switch fall-through survives wait");
        _root.result=0;_root.done=0;
        with(_root) hm_tests_compiler_fixture_gml_switch_resume(99);
        scrHMCompilerCheck(_root.result==100&&_root.done==1,"switch default path");

        _root.result=0;
        with(_root) hm_tests_compiler_fixture_gml_short_fork(false);
        scrHMCompilerCheck(_root.result==1&&array_length(global.hm_tasks)==0,"short-circuited fork does not spawn");
        with(_root) hm_tests_compiler_fixture_gml_short_fork(true);
        repeat(_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==6&&array_length(global.hm_tasks)==0,"conditional fork true child");
        _a.visits=0;_b.visits=0;
        global.hm_test_targets=[_a,_b,_a];
        with(_root) hm_tests_compiler_fixture_gml_matching_snapshot();
        scrHMCompilerCheck(_a.visits==1&&_b.visits==0,"filtered snapshot preserves unique input targets");
        with(_root) hm_tests_compiler_fixture_gml_matching_snapshot_async();
        repeat(3*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_a.visits==2&&_b.visits==1,"filtered async with preserves snapshot and continuation");
        _root.result=0;_root.frozen=true;
        with(_root) hm_tests_compiler_fixture_gml_wait_local(3);
        repeat(5*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==3,"frozen owner suspends its continuation");
        _root.frozen=false;
        repeat(2*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==6&&array_length(global.hm_tasks)==0,"unfreezing resumes retained continuation");
        var _dead1=scrHMCompilerProbe(),_dead2=scrHMCompilerProbe();
        global.hm_test_targets=[_dead1,_dead2];_root.done=0;
        with(_root) hm_tests_compiler_fixture_gml_fork_delete_targets();
        repeat(3*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(!instance_exists(_dead1)&&!instance_exists(_dead2),"forked destruction affects its captured targets");
        scrHMCompilerCheck(_root.done==1&&array_length(global.hm_tasks)==0,"dead fork cannot resume its parent's with iteration");
        show_debug_message("HARDMODE COMPILER RATE PASS "+string(_rate));
    }
    scrHMCompilerResetTasks();
    UberCont.dont_save=true;
    show_debug_message("HARDMODE COMPILER RESULT "+json_stringify({status:"PASS",checks:global.hm_compiler_checks,rates:[30,60]}));
    game_end();
    return true;
}
