function scrHMModulesTests() {
    if(os_type!=os_windows) return false;
    var _enabled=false;
    for(var _i=1;_i<=parameter_count();++_i) if(parameter_string(_i)=="--hardmode-modules-tests") _enabled=true;
    if(!_enabled) return false;
    UberCont.dont_save=true;
    scrHMRuntimeInit();
    var _checks=0;
    for(var _i=0;_i<array_length(global.hm_module_order);++_i) {
        var _key=global.hm_module_order[_i];
        try {
            scrHMInvoke(id,global.hm_module_scripts[$ _key].__load,[]);
            _checks++;
            show_debug_message("HARDMODE MODULE LOAD PASS "+_key);
        } catch(_error) {
            show_debug_message("HARDMODE MODULE LOAD FAILED "+_key+": "+_error.longMessage);
            game_end();return true;
        }
    }
    // Finish synchronous filesystem readiness and check the source defaults.
    scrHMTasksTick(1);
    assert(scrHMModGet("mod","options","rads")=="1","Hardmode option module loaded");
    _checks++;
    assert(scrHMModGet("area","venuz","kills")==0,"Hardmode area global kills counter preserved");
    _checks++;
    show_debug_message("HARDMODE MODULES RESULT "+json_stringify({status:"PASS",checks:_checks,modules:45}));
    game_end();return true;
}
