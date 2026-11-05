function scrHMGameplayWaterIndex113() {
    if(mode!="profile106" || ticks!=166) return;
    var _samples=self[$ "frame_samples106"]??undefined;
    scrHMGameplayCheck(is_array(_samples),"real profile exposes collected frame samples");
    if(!is_array(_samples)) return;
    scrHMGameplayCheck(array_length(_samples)>100,"real profile covers more than 100 rendered frames");
    var _finite=true,_minimum=1000000000000,_maximum=0;
    for(var _i=0;_i<array_length(_samples);++_i) {
        var _sample=_samples[_i];
        if(!(_sample>=0 && _sample<1000000000000)) _finite=false;
        _minimum=min(_minimum,_sample);_maximum=max(_maximum,_sample);
    }
    scrHMGameplayCheck(_finite,"all real frame samples are finite nonnegative durations");
    scrHMGameplayCheck(instance_exists(Player) && instance_exists(player),"real profile retains a live player instance");
    scrHMGameplayCheck(instance_number(Floor)>0,"real profile retains generated floor geometry");
    show_debug_message("HARDMODE PROFILE113 PROOF "+json_stringify({
        rate:rate,area:GameCont.area,loops:GameCont.loops,
        samples:array_length(_samples),minimum_us:_minimum,maximum_us:_maximum,
        floors:instance_number(Floor),player_exists:instance_exists(player),
        all_finite:_finite,physical_device:false
    }));
}
