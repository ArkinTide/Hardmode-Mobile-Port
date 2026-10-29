// b24's Raven spawn retries an unbounded random cone until a valid floor is
// found. Some generated layouts have no floor in that cone (60 Hz seed 42).
// Keep its successful samples, then choose the nearest valid ring floor.
function scrHMRavenSpawnStep() {
    if(instance_number(enemy)>=enemies/2 || !instance_exists(Player)) return;
    var _player=instance_nearest(x,y,Player),_floor=noone;
    repeat(64) {
        var _r=random_range(64,140),_r2=random(360);
        var _candidate=instance_nearest(_player.x+lengthdir_x(_r2,_r),_player.y+lengthdir_y(_r2,_r),Floor);
        if(instance_exists(_candidate) && _candidate.object_index!=FloorExplo
           && point_distance(_candidate.x+16,_candidate.y+16,_player.x,_player.y)>=60) {
            _floor=_candidate;break;
        }
    }
    if(!instance_exists(_floor)) {
        var _score=1000000000;
        with(Floor) if(object_index!=FloorExplo) {
            var _distance=point_distance(x+16,y+16,_player.x,_player.y);
            var _value=abs(_distance-100)+((_distance<60)?10000:0);
            if(_value<_score) {_score=_value;_floor=id;}
        }
    }
    if(!instance_exists(_floor)) return;
    hm_bosses_ravenboss_mod_gml_ravenboss_create(_floor.x+16,_floor.y+16);
    scrHMSoundPitchVolume(sndRavenDie,.6,4);
    instance_destroy();
}
// The disposable threshold spawner must not own the 80-tick tank entrance.
// The source callback still controls every effect, wait and boss attribute.
function scrHMTitankEntrance(_x,_y) {
    HMWorld.hm_titank_entering=true;
    with(HMWorld) hm_bosses_titank_mod_gml_titank_create(_x,_y);
}

