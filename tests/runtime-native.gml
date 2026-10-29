function scrHMRuntimeCheck(_condition,_message) {
    if(!_condition) show_debug_message("HARDMODE RUNTIME FAILED at "+string(global.hm_runtime_checks)+": "+_message);
    assert(_condition,"Hardmode API: "+_message);
    global.hm_runtime_checks++;
}

function scrHMRuntimeTests() {
    if(os_type!=os_windows) return false;
    var _enabled=false;
    for(var _i=1;_i<=parameter_count();++_i) if(parameter_string(_i)=="--hardmode-runtime-tests") _enabled=true;
    if(!_enabled) return false;
    UberCont.dont_save=true;
    global.hm_runtime_checks=0;
    for(var _rate=30;_rate<=60;_rate+=30) {
        game_set_speed(_rate,gamespeed_fps);global.time_scale=30/_rate;
        scrHMRuntimeInit();
        scrHMRuntimeCheck(array_length(global.hm_module_order)==45,"actual main.txt module count");
        scrHMRuntimeCheck(scrHMModuleKey("mod","areas/venuz.area")=="area:venuz","area API alias");
        scrHMRuntimeCheck(scrHMModuleKey("wep","weapons/secretweapon1")=="weapon:secretweapon1","weapon API alias");
        scrHMRuntimeCheck(scrHMModuleKey("mod","bossintros")=="mod:bosses/bossintros","loaded boss module basename alias");
        scrHMRuntimeCheck(!scrHMModExists("mod","platformer","gce"),"optional unloaded module is absent");
        scrHMRegisterModule("mod:runtime-fixtures/module_a",{__load:hm_runtime_fixtures_module_a_mod_gml___load,
            update:hm_runtime_fixtures_module_a_mod_gml_update,arity:hm_runtime_fixtures_module_a_mod_gml_arity});
        scrHMRegisterModule("mod:runtime-fixtures/module_b",{__load:hm_runtime_fixtures_module_b_mod_gml___load,
            read_other:hm_runtime_fixtures_module_b_mod_gml_read_other});
        var _root=instance_create(0,0,HMTestProbe),_a=instance_create(0,0,HMTestProbe),_b=instance_create(0,0,HMTestProbe);
        _root.marker=2;_root.hp=17;_a.marker=5;_a.hp=30;_b.marker=9;_b.hp=50;
        with(_root) {
            scrHMModCall("mod","runtime-fixtures/module_a","__load");
            scrHMModCall("mod","runtime-fixtures/module_b","__load");
        }
        scrHMRuntimeCheck(scrHMModGet("mod","runtime-fixtures/module_a","shared")==10
            &&scrHMModGet("mod","runtime-fixtures/module_b","shared")==100,"independent module globals");
        with(_a) scrHMModCall("mod","runtime-fixtures/module_a","update",3);
        scrHMRuntimeCheck(_a.result==13&&!variable_instance_exists(_root,"result"),"module calls keep caller instance");
        with(_b) scrHMModCall("mod","runtime-fixtures/module_b","read_other");
        scrHMRuntimeCheck(_b.result==13,"module variable lookup crosses namespace deliberately");
        scrHMRuntimeCheck(scrHMModGet("mod","runtime-fixtures/module_a","kills")==7,"module kills is not enemy kill-credit flag");
        scrHMModSet("mod","runtime-fixtures/module_b","shared",200);
        scrHMRuntimeCheck(scrHMModGet("mod","runtime-fixtures/module_a","shared")==13
            &&scrHMModGet("mod","runtime-fixtures/module_b","shared")==200,"variable writes remain local");
        with(_root) scrHMModCall("mod","runtime-fixtures/module_a","arity");
        scrHMRuntimeCheck(_root.result==0,"zero argument invocation keeps argument_count");
        with(_root) scrHMModCall("mod","runtime-fixtures/module_a","arity",1,2,3,4,5,6);
        scrHMRuntimeCheck(_root.result==6,"six argument invocation keeps argument_count");
        var _ref;
        with(_root) _ref=scrHMScriptRef(hm_runtime_fixtures_module_b_mod_gml_target_callback);
        scrHMInvoke(_a,_ref,[4]);
        scrHMRuntimeCheck(_a.marker==9&&_root.marker==2,"callbacks rebind to receiving instance");
        with(_root) with(_a) scrHMInvoke(id,hm_runtime_fixtures_module_b_mod_gml_context_callback,[]);
        scrHMRuntimeCheck(_a.observed_other==2,"callback retains collision or with other");
        with(_root) scrHMInvoke(_b,hm_runtime_fixtures_module_b_mod_gml_context_callback,[]);
        scrHMRuntimeCheck(_b.observed_other==2,"different receiver gets calling instance as other");
        with(_root) hm_runtime_fixtures_module_a_mod_gml_task_nested(_a);
        scrHMTasksTick(1);
        scrHMRuntimeCheck(_a.observed_other==2&&_a.observed_after_wait==2&&_root.result==71,"nested asynchronous call preserves logical other before and after suspension");
        var _disposable=instance_create(0,0,HMTestProbe);
        with(_root) hm_runtime_fixtures_module_a_mod_gml_task_destroy_with(_disposable);
        scrHMTasksTick(1);
        scrHMRuntimeCheck(!instance_exists(_disposable)&&_root.result==72,"destroying a with target resumes its parent continuation");
        with(_root) hm_runtime_fixtures_module_a_mod_gml_units_setup();
        show_debug_message("HARDMODE MOTION SETUP "+json_stringify({rate:_rate,delta:timescale,speed:_root.speed,friction:_root.friction,gravity:_root.gravity}));
        // GML's comparison epsilon is itself 0.00001; use a tolerance above
        // it so zero does not compare equal to the tolerance boundary.
        scrHMRuntimeCheck(abs(_root.speed-6*timescale)<0.0001&&abs(_root.friction-0.4*timescale*timescale)<0.0001,"velocity and friction stored in native frame units");
        with(_root) hm_runtime_fixtures_module_a_mod_gml_units_adjust();
        show_debug_message("HARDMODE MOTION STATE "+json_stringify({rate:_rate,speed:_root.speed,result:_root.result}));
        scrHMRuntimeCheck(abs(_root.speed-8*timescale)<0.0001&&_root.result[0]==8,"compound velocity changes and native motion add");
        scrHMRuntimeCheck(_root.result[1]==0.4&&_root.result[2]==0.2&&_root.result[3]==0.4&&_root.result[4]==17,"legacy reads restore units without scaling module globals");
        with(_root) hm_runtime_fixtures_module_a_mod_gml_units_increment();
        show_debug_message("HARDMODE MOTION INCREMENT "+json_stringify({speed:_root.speed,result:_root.result,second:_root.second}));
        scrHMRuntimeCheck(_root.result==8&&_root.second==10&&abs(_root.speed-10*timescale)<0.0001,"prefix/postfix motion increments preserve expression result");
        with(_root) hm_runtime_fixtures_module_a_mod_gml_units_local();
        scrHMRuntimeCheck(_root.result==10,"local named speed is not a built-in velocity");
        _a.friction=0.8*timescale*timescale;
        with(_root) hm_runtime_fixtures_module_a_mod_gml_units_member(_a);
        scrHMRuntimeCheck(_root.result==9&&abs(_a.speed-9*timescale)<0.0001&&abs(_a.friction-0.4*timescale*timescale)<0.0001,"cross-instance velocity and compound friction assignment");
        scrHMRuntimeCheck(array_length(scrHMInstances([HMTestProbe,_a,[_b]]))==3,"object arrays expand once without duplicates");
        scrHMRuntimeCheck(array_length(scrHMMatching(HMTestProbe,"my_health",17,50))==2,"matching multiple allowed values and health alias");
        scrHMRuntimeCheck(array_length(scrHMMatching(HMTestProbe,"absent",undefined))==3,"missing field compares to legacy null");
        scrHMRuntimeCheck(array_length(scrHMMatchingNE(HMTestProbe,"my_health",17,50))==1,"not equal excludes all supplied alternatives");
        scrHMRuntimeCheck(array_length(scrHMMatchingNE(HMTestProbe,"absent",1,2))==3,"missing fields included in not-equal filter");
        scrHMRuntimeCheck(array_length(scrHMMatchingGE(HMTestProbe,"my_health",30))==2,"greater equal filter");
        scrHMRuntimeCheck(array_length(scrHMMatchingGT(HMTestProbe,"my_health",30))==1,"greater filter");
        scrHMRuntimeCheck(array_length(scrHMMatchingLE(HMTestProbe,"my_health",30))==2,"less equal filter");
        scrHMRuntimeCheck(array_length(scrHMMatchingLT(HMTestProbe,"my_health",30))==1,"less filter");
        scrHMRuntimeCheck(array_length(scrHMMatchingLT(HMTestProbe,"absent",30))==0,"missing field excluded from ordering");
        _root.alarm[4]=33;
        scrHMRuntimeCheck(array_length(scrHMMatching(HMTestProbe,"alarm4",33))==1,"native alarm index field lookup");
        scrHMRuntimeCheck(array_length(scrHMMatching(HMTestProbe,"object_index","HMTestProbe"))==3,"object name matching");
        _a.race=Race.Rogue;_b.race=Race.Fish;
        scrHMRuntimeCheck(array_length(scrHMMatching([_a,_b],"race","rogue"))==1,"named race filter resolves native character IDs");
        scrHMRuntimeCheck(array_length(scrHMMatching([_a,_b],"race_id",Race.Fish))==1,"numeric race alias filter remains valid");
        scrHMRuntimeCheck(scrHMVariableExists(_root,"my_health")&&!scrHMVariableExists(_root,"absent"),"legacy variable existence");
        KeyCont.hold_spec[0]=true;KeyCont.press_spec[0]=true;
        scrHMRuntimeCheck(scrHMButtonCheck(0,"spec")&&scrHMButtonPressed(0,"spec"),"input uses shared touch/controller actions");
        KeyCont.hold_spec[0]=false;KeyCont.press_spec[0]=false;
        scrHMRuntimeCheck(!scrHMButtonCheck(0,"spec")&&!scrHMButtonPressed(0,"spec"),"input release reflected");
        var _audio=scrHMSoundAdd("../music/01 Godz Of Gunz.ogg");
        scrHMRuntimeCheck(audio_exists(_audio),"registered bundled music");
        scrHMSoundAssign(sndPistol,_audio);
        scrHMRuntimeCheck(custom_sound_check(sndPistol)==_audio,"sound replacement uses base mixer mapping");
        scrHMSoundRestore(sndPistol);
        scrHMRuntimeCheck(custom_sound_check(sndPistol)==sndPistol,"sound restore removes replacement");
        var _sprite=sprite_duplicate(sprBanditIdle),_width=sprite_get_width(_sprite);
        scrHMSpriteReplace(_sprite,sprMaggotIdle);
        scrHMRuntimeCheck(sprite_get_width(_sprite)==sprite_get_width(sprMaggotIdle),"sprite replacement changes native resource");
        scrHMSpriteRestore(_sprite);
        scrHMRuntimeCheck(sprite_get_width(_sprite)==_width,"sprite restore retains original geometry");
        sprite_delete(global.hm_sprite_backups[$ string(_sprite)]);
        variable_struct_remove(global.hm_sprite_backups,string(_sprite));sprite_delete(_sprite);
        var _text="1*0*1*0*1*1*0*1";
        scrHMStringSave(_text,"api-regression.txt");
        scrHMRuntimeCheck(scrHMFileExists("api-regression.txt")&&scrHMStringLoad("api-regression.txt")==_text,"private settings file round trip");
        file_delete(scrHMPrivateFile("api-regression.txt"));
        scrHMDelete([_a,_b]);
        scrHMRuntimeCheck(instance_exists(_root)&&!instance_exists(_a)&&!instance_exists(_b),"silent deletion of exact instance array");
        scrHMDelete(_root);
        show_debug_message("HARDMODE RUNTIME RATE PASS "+string(_rate));
    }
    show_debug_message("HARDMODE RUNTIME RESULT "+json_stringify({status:"PASS",checks:global.hm_runtime_checks,rates:[30,60]}));
    game_end();return true;
}
