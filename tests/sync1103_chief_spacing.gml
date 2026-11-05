// Real LastBall Destroy coverage at 30/60Hz. Register this fixture and invoke
// scrHMGameplayChiefSpacing1103() for sync113chiefspacing from the logic step.
// The disabled-Hardmode case executes the retained native Destroy fallback;
// Loop0 must preserve its emission order, eight speeds and random consumption.
function scrHMGameplayChiefSpacing1103() {
    if(mode!="sync113chiefspacing" || ticks!=20) return;
    scrHMGameplayLane107();
    var _original_loops=GameCont.loops,_original_enabled=global.hm_enabled;
    // Native direction uses single-precision angle storage. Its cumulative
    // stock angles reach 2880 degrees, producing ~0.000061-degree differences
    // from the equivalent reduced angles. Allow 0.001 degree for angles only;
    // speed, count, RNG consumption, attribution and damage keep their checks.
    var _angle_tolerance=.001;
    var _loops=[0,1,3,10],_reference=[],_reference_next=0,_reference_angle=0,_results=[];
    for(var _case=-1;_case<array_length(_loops);++_case) {
        with(IDPDBullet) instance_destroy(id,false);
        GameCont.loops=_case<0?0:_loops[_case];
        // Off-floor destruction avoids Rad/drop RNG; the projectile is still
        // a real native LastBall with its actual Destroy and projectile API.
        var _ball=instance_create(20000.25,20000.75,LastBall);
        _ball.creator=player;_ball.team=team_enemy;_ball.hitid=HitId.Captain;
        _ball.direction=137.25;_ball.speed=0;
        global.hm_enabled=_case>=0;
        random_set_seed(731103);
        var _expected_angle=random_angle;
        random_set_seed(731103);
        instance_destroy(_ball);
        var _next=random(1);
        global.hm_enabled=_original_enabled;
        var _shots=[];
        with(IDPDBullet) array_push(_shots,[direction,speed,team,hitid,creator,image_angle,damage]);
        scrHMGameplayCheck(!instance_exists(_ball),"actual Captain ball Destroy completes without retaining the source projectile");
        if(_case<0) {
            _reference=_shots;_reference_next=_next;
            scrHMGameplayCheck(array_length(_reference)==80,"non-Hardmode native fallback retains ten eight-projectile beams");
            // The same seeded draw identifies the anchor without assuming
            // that native instance enumeration follows projectile creation.
            _reference_angle=_expected_angle;
            continue;
        }
        var _beams=10+_loops[_case],_expected_gap=360/_beams;
        scrHMGameplayCheck(array_length(_shots)==_beams*8,"actual Destroy adds exactly one complete eight-projectile beam per Loop");
        if(_case==0) {
            var _same=array_length(_shots)==array_length(_reference),_mismatches=[];
            for(var _i=0;_i<min(array_length(_shots),array_length(_reference));++_i) {
                var _actual=_shots[_i],_stock=_reference[_i];
                if(abs(angle_difference(_actual[0],_stock[0]))>_angle_tolerance || abs(_actual[1]-_stock[1])>.00001
                   || _actual[2]!=_stock[2] || _actual[3]!=_stock[3] || _actual[4]!=_stock[4]
                   || abs(angle_difference(_actual[5],_stock[5]))>_angle_tolerance || _actual[6]!=_stock[6]) {
                    _same=false;
                    if(array_length(_mismatches)<12) array_push(_mismatches,{
                        index:_i,actual:_actual,native:_stock,
                        angle_error:angle_difference(_actual[0],_stock[0]),speed_error:_actual[1]-_stock[1],
                        team_equal:_actual[2]==_stock[2],hitid_equal:_actual[3]==_stock[3],
                        creator_equal:_actual[4]==_stock[4],damage_equal:_actual[6]==_stock[6]
                    });
                }
            }
            if(!_same) show_debug_message("HARDMODE CHIEFSPACING113 MISMATCH "+json_stringify({
                fields:["direction","speed","team","hitid","creator","image_angle","damage"],
                native_count:array_length(_reference),actual_count:array_length(_shots),
                native_next_random:_reference_next,actual_next_random:_next,
                anchor:_reference_angle,source_player:player,first_mismatches:_mismatches,
                native_shots:_reference,actual_shots:_shots
            }));
            scrHMGameplayCheck(_same,"Loop0 matches the actual native fallback's ordered angles, speeds, team, hit attribution, creator and damage");
            scrHMGameplayCheck(_next==_reference_next,"Loop0 preserves the native fallback's exact random consumption");
        }
        var _groups=[],_ownership=true,_valid_speeds=true,_image_angles=true;
        for(var _i=0;_i<array_length(_shots);++_i) {
            var _shot=_shots[_i];
            if(_shot[2]!=team_enemy || _shot[3]!=HitId.Captain || _shot[4]!=player || _shot[6]!=3) _ownership=false;
            if(abs(angle_difference(_shot[0],_shot[5]))>_angle_tolerance) _image_angles=false;
            var _group=-1;
            for(var _g=0;_g<array_length(_groups);++_g)
                if(abs(angle_difference(_groups[_g].angle,_shot[0]))<_angle_tolerance) {_group=_g;break;}
            if(_group<0) {
                _group=array_length(_groups);
                array_push(_groups,{angle:_shot[0],count:0,speeds:array_create(8,false)});
            }
            var _entry=_groups[_group];_entry.count++;
            var _speed=_shot[1]/timescale,_index=round((_speed-4)/.6);
            if(_index<0 || _index>=8 || abs(_speed-(4+.6*_index))>.00001) _valid_speeds=false;
            else {
                if(_entry.speeds[_index]) _valid_speeds=false;
                _entry.speeds[_index]=true;
            }
        }
        scrHMGameplayCheck(array_length(_groups)==_beams,"the complete emitted burst has ten-plus-Loop distinct radial directions");
        scrHMGameplayCheck(_ownership,"every real projectile preserves hostile team, Captain hit attribution, original creator and native three-point damage");
        scrHMGameplayCheck(_image_angles,"every real projectile's image faces its emitted direction");
        scrHMGameplayCheck(_valid_speeds,"each beam retains the eight unique native speeds scaled by the actual render rate");
        array_sort(_groups,function(_a,_b) {return _a.angle-_b.angle;});
        var _counts=true,_all_speeds=true,_min_gap=360,_max_gap=0,_gap_error=0,_kept_origin=false;
        for(var _g=0;_g<array_length(_groups);++_g) {
            var _entry=_groups[_g];
            if(_entry.count!=8) _counts=false;
            for(var _speed=0;_speed<8;++_speed) if(!_entry.speeds[_speed]) _all_speeds=false;
            if(abs(angle_difference(_entry.angle,_reference_angle))<_angle_tolerance) _kept_origin=true;
            var _next_angle=_groups[(_g+1) mod array_length(_groups)].angle;
            var _gap=(_next_angle-_entry.angle+360) mod 360;
            _min_gap=min(_min_gap,_gap);_max_gap=max(_max_gap,_gap);
            _gap_error=max(_gap_error,abs(_gap-_expected_gap));
        }
        scrHMGameplayCheck(_counts && _all_speeds,"every distinct beam contains all eight native projectiles exactly once");
        scrHMGameplayCheck(_kept_origin,"every Loop uses the original random starting direction rather than the source ball direction");
        scrHMGameplayCheck(_gap_error<_angle_tolerance,"all adjacent beam gaps including the full-circle wrap equal 360 divided by the complete beam count within native angle precision");
        array_push(_results,{loops:_loops[_case],beams:array_length(_groups),shots:array_length(_shots),
            expected_gap:_expected_gap,minimum_gap:_min_gap,maximum_gap:_max_gap,gap_error:_gap_error,
            eight_native_speeds:_valid_speeds && _all_speeds,ownership_preserved:_ownership});
    }
    with(IDPDBullet) instance_destroy(id,false);
    with(PortalClear) instance_destroy(id,false);
    GameCont.loops=_original_loops;global.hm_enabled=_original_enabled;
    show_debug_message("HARDMODE CHIEFSPACING113 "+json_stringify({rate:rate,cases:_results,physical_device:false}));
}
