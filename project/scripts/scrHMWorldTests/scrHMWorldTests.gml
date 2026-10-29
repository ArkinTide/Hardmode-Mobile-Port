function scrHMWorldCheck(_condition,_message) {
    if(!_condition) throw "Hardmode world check: "+_message;
    global.hm_world_checks++;
}

function scrHMWorldTests() {
    if(os_type!=os_windows) return false;
    var _enabled=false;
    for(var _i=1;_i<=parameter_count();++_i) if(parameter_string(_i)=="--hardmode-world-tests") _enabled=true;
    if(!_enabled) return false;
    UberCont.dont_save=true;
    global.hm_world_checks=0;
    try {
        if(!instance_exists(GameCont)) instance_create(0,0,GameCont);
        if(!instance_exists(BackCont)) instance_create(0,0,BackCont);
        if(!instance_exists(TopCont)) instance_create(0,0,TopCont);
        if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
        var _world=instance_create(0,0,HMWorld);
        scrHMWorldCheck(array_length(global.hm_module_order)==45,"all supplied enabled modules registered");
        var _weapons=variable_struct_get_names(global.hm_weapon_keys);
        scrHMWorldCheck(array_length(_weapons)==11&&maxwep==139,"all eleven secret weapons registered");
        for(var _i=0;_i<array_length(_weapons);++_i) {
            var _weapon=real(_weapons[_i]);
            scrHMWorldCheck(scr_weapon_is_valid(_weapon)&&sprite_exists(scr_weapon_get_sprite(_weapon)),"weapon native metadata "+string(_weapon));
        }
        for(var _rate=30;_rate<=60;_rate+=30) {
            game_set_speed(_rate,gamespeed_fps);global.time_scale=30/_rate;
            with(_world) {logic_accumulator=0;logic_tick=false;}
            var _draw_probe=instance_create(0,0,HMTestProbe);
            _draw_probe.result=0;
            var _ticks=0;
            repeat(_rate) {
                with(_world) scrHMWorldBegin();
                if(_world.logic_tick) _ticks++;
                with(_draw_probe) observed_before=hm_tests_compiler_fixture_gml_draw_logic_probe();
            }
            scrHMWorldCheck(_ticks==30,"MOD tick count per second at "+string(_rate));
            scrHMWorldCheck(_draw_probe.result==90,"draw-side simulation state advances exactly 30 times per second");
            scrHMWorldCheck(_draw_probe.observed_before==3,"renderer locals are evaluated on every physical frame");
            var _effects=scrHMMatching(CustomObject,"name","draw_probe");
            scrHMWorldCheck(array_length(_effects)==30,"draw-side attacks spawn only on a logic tick");
            scrHMDelete(_effects);instance_destroy(_draw_probe,false);
            var _keys=variable_struct_get_names(global.hm_area_ids);
            for(var _i=0;_i<array_length(_keys);++_i) {
                var _name=_keys[_i],_area=scrHMAreaResolve(_name);
                if(!scrHMAreaHas(_area)) continue;
                GameCont.area=_area;GameCont.subarea=1;
                var _floor=scrHMAssetIndex("sprFloor"+string(_area));
                scrHMWorldCheck(sprite_exists(_floor),"area floor mapping "+_name);
                var _wall=scrHMAssetIndex("sprWall"+string(_area)+"Bot");
                scrHMWorldCheck(sprite_exists(_wall),"area wall mapping "+_name);
                var _label=scrAreaGetMapName(_area,1,0);
                scrHMWorldCheck(is_string(_label)&&string_length(_label)>0,"area HUD name "+_name);
                scrHMWorldCheck(scrAreaGetMaxSubarea(_area)>=1,"area stage length "+_name);
            }
            with(GameCont) {
                area=1;subarea=3;lastarea=1;lastsubarea=3;
                scrHMAreaTransit();
            }
            scrHMWorldCheck(GameCont.area==scrHMAreaResolve("nightdesert"),"desert extension transit");
            with(GameCont) scrHMAreaAdvance();
            scrHMWorldCheck(GameCont.area==scrHMAreaResolve("scorpionboss"),"night desert to scorpion boss");
            with(GameCont) scrHMAreaAdvance();
            scrHMWorldCheck(GameCont.area==scrHMAreaResolve("sewers"),"scorpion boss to extended sewers");
            GameCont.subarea=1;
            with(GameCont) scrHMAreaAdvance();
            scrHMWorldCheck(GameCont.area==scrHMAreaResolve("sewers")&&GameCont.subarea==2,"custom subarea advances once");
            show_debug_message("HARDMODE WORLD RATE PASS "+string(_rate));
        }
        show_debug_message("HARDMODE WORLD RESULT "+json_stringify({status:"PASS",checks:global.hm_world_checks,rates:[30,60]}));
    } catch(_error) {
        show_debug_message("HARDMODE WORLD FAILED "+(is_struct(_error)?_error.longMessage:string(_error)));
    }
    global.hm_enabled=false;global.hm_tasks=[];
    instance_destroy(CustomObject,false);instance_destroy(CustomEnemy,false);
    instance_destroy(CustomHitme,false);instance_destroy(CustomProjectile,false);
    instance_destroy(HMBinding,false);instance_destroy(HMWorld,false);
    game_end();return true;
}
