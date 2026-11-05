// Real host-VM parity against the frozen 1.1.2 implementations appended below.
// The reference code has the original DS-map and exact five-foot query;
// it never calls either new optimization. All fixtures use native objects.
function scrHMGameplayPerfEqual1103(_expected,_actual,_message) {
    scrHMGameplayCheck(json_stringify(_expected)==json_stringify(_actual),_message);
}

function scrHMGameplayWaterFixture1103(_portal,_winds) {
    scrHMGameplayIsolate103();
    with(Wind) instance_destroy(id,false);
    with(RadEat) instance_destroy(id,false);
    with(Floor) instance_destroy(id,false);
    if(player[$ "swimming"]??false) with(player) scrHMSwimLeave();
    player.x=16016;player.y=16016;player.speed=timescale;player.direction=17;
    player.swimming=false;player.canfly=false;player.image_alpha=1;player.spr_shadow=shd24;
    player.hm_portrait_frozen=false;
    var _floors=[];
    for(var _xx=0;_xx<8;++_xx) for(var _yy=0;_yy<3;++_yy) {
        var _floor=instance_create(16000+32*_xx,16000+32*_yy,Floor);
        _floor.traction=(_xx==5?1:2);
        if(_xx!=6) {
            var _surface=instance_create(_floor.x,_floor.y,CustomObject);
            _surface.name="sewagefloor";
            _surface.sprite_index=(_yy==0?sprHM_areas_sewers_area_3:sprHM_areas_sewers_area_4);
            _surface.image_xscale=.8;_surface.image_yscale=.8;
            _floor.hm_water_surface111=_surface;
        }
        array_push(_floors,_floor);
    }
    // Dry overlap wins, a 16px explosion tile retains its exact footprint.
    var _overlap=instance_create(16016,16064,FloorExplo);
    _overlap.traction=1;array_push(_floors,_overlap);
    // Fractional full-cell seam and a separately linked real 16px wet tile
    // exercise the compiled generation APIs as well as the actor pass.
    for(var _i=0;_i<3;++_i) {
        var _small=_i==2;
        var _floor=instance_create(_small?16320.5:16384.25+32*_i,
            _small?16048.25:16016.5,_small?FloorExplo:Floor);
        _floor.traction=2;
        var _surface=instance_create(_floor.x,_floor.y,CustomObject);
        _surface.name="sewagefloor";_surface.sprite_index=sprHM_areas_sewers_area_4;
        _surface.image_xscale=.8;_surface.image_yscale=.8;
        _floor.hm_water_surface111=_surface;array_push(_floors,_floor);
    }
    var _actors=[player];
    var _hard=GameCont.hard;GameCont.hard=0;
    for(var _i=0;_i<32;++_i) {
        var _kind=(_i==1?Gator:(_i==2?BuffGator:(_i==3?Crab:Bandit)));
        var _actor=instance_create(16016+32*(_i mod 8),16016+32*((_i div 8) mod 3),_kind);
        _actor.speed=(1+_i mod 3)*timescale;_actor.direction=13+_i*7;
        _actor.swimming=(_i mod 5)==0;_actor.canfly=false;
        _actor.image_alpha=_actor.swimming?0:.7;_actor.spr_shadow=_actor.swimming?mskNone:shd24;
        _actor.hm_swim_fly=false;_actor.hm_swim_alpha=.7;_actor.shd_=shd24;
        _actor.hm_portrait_frozen=(_i==7);
        if(_i==20) _actor.x=player.x+view_width+128;
        if(_i==21) {_actor.x=16001;_actor.y=16016;}
        if(_i==22) {_actor.x=16016;_actor.y=16002;}
        array_push(_actors,_actor);
    }
    GameCont.hard=_hard;
    repeat(_winds) instance_create(15800,15800,Wind);
    var _corpse=instance_create(16016,16048,Corpse);_corpse.image_alpha=.6;
    if(_portal) {
        instance_create(16080,16048,Portal);
        with(PortalShock) instance_destroy(id,false);
        with(PortalClear) instance_destroy(id,false);
    }
    HMWorld.logic_serial=20;HMWorld.hm_water_entry_tick=-100;HMWorld.hm_water_sound_tick=-100;
    scrHMWaterMap();
    return {floors:_floors,actors:_actors,corpse:_corpse};
}

function scrHMGameplayWaterRun1103(_optimized,_portal,_winds,_seed) {
    var _fixture=scrHMGameplayWaterFixture1103(_portal,_winds);
    random_set_seed(_seed);
    if(_optimized) scrHMSewerTick1103();else scrHMGameplaySewerReference1103();
    var _actors=[],_effects=[],_bindings=[],_random=[];
    for(var _i=0;_i<array_length(_fixture.actors);++_i) {
        var _a=_fixture.actors[_i];
        array_push(_actors,[_a.x,_a.y,_a.speed,_a.direction,_a.friction,
            _a[$ "swimming"]??false,_a.canfly,_a.image_alpha,_a.spr_shadow]);
    }
    with(Wind) array_push(_effects,[0,x,y,sprite_index,image_xscale,depth]);
    with(RadEat) array_push(_effects,[1,x,y,image_angle]);
    with(HMBinding) array_push(_bindings,[x,y,depth,hm_refresh_tick,hm_draw]);
    repeat(16) array_push(_random,random(1000000));
    return [_actors,_effects,_bindings,_fixture.corpse.image_alpha,
        HMWorld.hm_water_entry_tick,HMWorld.hm_water_sound_tick,_random];
}

function scrHMGameplayWaterAPIs1103(_points,_feet,_centers) {
    var _scratch=ds_list_create();
    for(var _i=0;_i<array_length(_points);++_i) {
        var _p=_points[_i];
        scrHMGameplayCheck(hm_arkintide_mod_gml_hm_water_at(_p[0],_p[1])==_feet[_i],
            "compiled water_at matches mobile feet at fractional seams, dry banks and FloorExplo16");
        scrHMGameplayCheck(hm_arkintide_mod_gml_hm_water_at_list(_p[0],_p[1],_scratch)==_feet[_i],
            "compiled water_at_list matches mobile feet at fractional seams, dry banks and FloorExplo16");
        scrHMGameplayCheck(hm_arkintide_mod_gml_hm_water_point(_p[0],_p[1])==_centers[_i],
            "compiled water_point matches mobile physical center geometry");
        scrHMGameplayCheck(hm_arkintide_mod_gml_hm_water_point_list(_p[0],_p[1],_scratch)==_centers[_i],
            "compiled water_point_list matches mobile physical center geometry");
    }
    ds_list_destroy(_scratch);
}

function scrHMGameplayWaterProof1103() {
    var _fixture=scrHMGameplayWaterFixture1103(false,0),_points=[];
    var _offsets=[-.01,0,.01,1.99,2,2.01,3,3.01,7.99,8,15.99,16,16.01,31.99,32,32.01];
    for(var _f=0;_f<array_length(_fixture.floors);++_f) {
        var _floor=_fixture.floors[_f];
        for(var _i=0;_i<array_length(_offsets);++_i)
        for(var _j=0;_j<array_length(_offsets);++_j)
            array_push(_points,[_floor.x+_offsets[_i],_floor.y+_offsets[_j]]);
    }
    var _expected=[],_centers=[],_random=[];
    scrHMWaterBatchEnd1102();random_set_seed(710311);
    for(var _i=0;_i<array_length(_points);++_i) {
        array_push(_expected,scrHMSwimSupported112(_points[_i][0],_points[_i][1]));
        array_push(_centers,scrHMWaterAt(_points[_i][0],_points[_i][1]));
    }
    repeat(16) array_push(_random,random(1000000));
    random_set_seed(710311);
    scrHMGameplayWaterAPIs1103(_points,_expected,_centers);
    var _potential=scrHMWaterPotential1103();
    scrHMGameplayCheck(!is_undefined(_potential),"dense live fixture selects the conservative wet-cell proof");
    scrHMWaterBatchBegin1102();
    for(var _i=0;_i<array_length(_points);++_i) {
        var _p=_points[_i],_possible=scrHMWaterPossible1103(_potential,_p[0],_p[1]);
        var _actual=_possible && scrHMSwimSupported112(_p[0],_p[1]);
        scrHMGameplayCheck(_actual==_expected[_i],"flat dry proof matches original fractional seam/bank/overlap and 16px floor geometry");
    }
    scrHMGameplayWaterAPIs1103(_points,_expected,_centers);
    scrHMWaterBatchEnd1102();
    for(var _i=0;_i<16;++_i) scrHMGameplayCheck(random(1000000)==_random[_i],"water broad phase and exact cache preserve the random stream");
    var _floor=_fixture.floors[1],_x=_floor.x+16,_y=_floor.y+16;
    scrHMGameplayCheck(scrHMSwimSupported112(_x,_y),"mutation check starts on a real linked wet floor");
    _floor.traction=1;
    scrHMGameplayCheck(!scrHMSwimSupported112(_x,_y),"outside-pass query observes live changed traction immediately");
    _potential=scrHMWaterPotential1103();
    scrHMGameplayCheck(!scrHMWaterPossible1103(_potential,_x,_y),"new pass discards previous wet proof after a live traction change");
    _floor.traction=2;instance_destroy(_floor.hm_water_surface111,false);
    _potential=scrHMWaterPotential1103();
    scrHMGameplayCheck(!scrHMWaterPossible1103(_potential,_x,_y),"new pass discards a deleted water-surface link");
    with(enemy) instance_destroy(id,false);
    scrHMGameplayCheck(is_undefined(scrHMWaterPotential1103()),"sparse scene retains the exact query without a flat allocation");
    scrHMGameplayCheck(scrHMWaterPossible1103(undefined,_x,_y),"fallback never rejects a query");
}

function scrHMGameplayRadiationRun1103(_optimized,_layout,_protect,_seed) {
    scrHMGameplayIsolate103();
    with(Rad) instance_destroy(id,false);with(RadEat) instance_destroy(id,false);
    var _owner=instance_create(0,0,CustomObject);GameCont.hm_native_controller_id=_owner;
    if(player[$ "swimming"]??false) with(player) scrHMSwimLeave();
    player.x=16000+(_protect==0?1000:(_protect==1?0:32.01));
    player.y=16000;player.speed=0;
    var _enemies=[],_rads=[],_offsets=[-64.001,-64,-32.001,-32,-.01,0,.01,31.999,32,32.001,63.999,64,64.001];
    var _positions=[[-64,0],[0,0],[0,0],[32,0],[64,64],[128,-64],[-96,64]];
    for(var _i=0;_i<array_length(_positions);++_i) {
        var _p=_positions[_i],_enemy=instance_create(16000+_p[0],16000+_p[1],Bandit);
        _enemy.raddrop=10+_i;_enemy.team=(_i==3?3:team_enemy);array_push(_enemies,_enemy);
    }
    random_set_seed(982177);
    var _count=(_layout==0?80:(_layout==1?1:(_layout==2?20:(_layout==3?0:32))));
    for(var _i=0;_i<_count;++_i) {
        var _x=16000,_y=16000;
        if(_layout==2) _x+=_i*10000;
        else if(_i<array_length(_offsets)) _x+=_offsets[_i];
        else {_x+=random_range(-192,192);_y+=random_range(-192,192);}
        var _rad=instance_create(_x,_y,Rad);_rad.hspeed=.25;_rad.vspeed=-.5;
        array_push(_rads,_rad);
    }
    if(_layout==4) GameCont.hm_native_controller_id=noone;
    random_set_seed(_seed);
    var _used=false;
    if(_optimized) _used=scrHMRadiationFlat1103();
    if(!_optimized || !_used) scrHMGameplayRadiationReference1103();
    var _radstate=[],_drops=[],_effects=[],_random=[];
    for(var _i=0;_i<array_length(_rads);++_i) {
        var _rad=_rads[_i];
        if(!instance_exists(_rad)) array_push(_radstate,[false]);
        else array_push(_radstate,[true,_rad.x,_rad.y,_rad.hspeed,_rad.vspeed,_rad.speed,_rad.direction,_rad[$ "hm_rad_order"]??-1]);
    }
    for(var _i=0;_i<array_length(_enemies);++_i) array_push(_drops,_enemies[_i].raddrop);
    with(RadEat) array_push(_effects,[x,y]);
    repeat(16) array_push(_random,random(1000000));
    if(!is_undefined(_owner[$ "hm_rad_grid"])) ds_map_destroy(_owner.hm_rad_grid);
    instance_destroy(_owner,false);GameCont.hm_native_controller_id=noone;
    if(_optimized) scrHMGameplayCheck(_used==(_layout==0 || _layout==3),"dense compact and empty cases use flat path; sparse/spread/no-owner retain fallback");
    return [_radstate,_drops,_effects,_random];
}

function scrHMGameplayPerformance1103() {
    if(mode=="sync113waterpass" && ticks==20) {
        scrHMGameplayWaterProof1103();
        for(var _portal=0;_portal<2;++_portal) for(var _cap=0;_cap<2;++_cap) {
            var _winds=_cap?79:0;
            var _expected=scrHMGameplayWaterRun1103(false,_portal,_winds,983117);
            var _actual=scrHMGameplayWaterRun1103(true,_portal,_winds,983117);
            scrHMGameplayPerfEqual1103(_expected,_actual,"whole native sewer pass preserves swimming pose/speed, ripple cap, bindings, sound debounce, corpse fade and subsequent RNG");
        }
        show_debug_message("SYNC113 WATER PASS PARITY COMPLETE");
    }
    if(mode=="sync113radpass" && ticks==20) {
        var _owner=variable_instance_get(GameCont,"hm_native_controller_id")??noone;
        for(var _layout=0;_layout<5;++_layout) for(var _protect=0;_protect<3;++_protect) {
            var _expected=scrHMGameplayRadiationRun1103(false,_layout,_protect,710318);
            var _actual=scrHMGameplayRadiationRun1103(true,_layout,_protect,710318);
            scrHMGameplayPerfEqual1103(_expected,_actual,"flat native radiation matches frozen DS-map survivor/motion/order, shared absorption/drop ownership, native RadEat order, protected Player and subsequent RNG");
        }
        if(instance_exists(_owner)) GameCont.hm_native_controller_id=_owner;
        show_debug_message("SYNC113 RADIATION PASS PARITY COMPLETE");
    }
}

// Frozen pre-sync production references. Keep unchanged for parity tests.
function scrHMGameplaySewerReference1103() {
    if(!instance_exists(Player)) {
        with(hitme) if(self[$ "swimming"]??false) scrHMSwimLeave();
        return;
    }
    // Constant-time water membership replaces all nearest-Floor/CustomObject
    // searches. Only the feet point counts, so a body overlapping the bank
    // cannot keep an entity swimming on dry ground.
    if(is_undefined(variable_instance_get(HMWorld,"hm_water_map")) || (variable_instance_get(HMWorld,"hm_water_floors")??-1)!=instance_number(Floor)) scrHMWaterMap();
    var _player=instance_nearest(x,y,Player),_map=HMWorld.hm_water_map;
    scrHMWaterBatchBegin1102();
    with(hitme) {
        if(self[$ "hm_portrait_frozen"]??false) continue;
        var _was=self[$ "swimming"]??false;
        if(!_was && (!variable_instance_exists(id,"right") || object_index==FireBaller || object_index==SuperFireBaller)) continue;
        var _near=point_distance(x,y,_player.x,_player.y)<view_width;
        var _water=scrHMSwimSupported112(x,y) && !instance_exists(SpiralCont);
        if(_water && distance_to_object(Portal)<=32) _water=false;
        if(!_water) {
            if(_was) {scrHMSwimLeave();if(_near) scrHMSoundPitchVolume(sndSewerDrip,1,.22);}
            continue;
        }
        if(!_was) {
            if(!_near && object_index!=Player) continue;
            hm_swim_fly=self[$ "canfly"]??false;hm_swim_alpha=image_alpha;shd_=spr_shadow;
            swimming=true;canfly=true;image_alpha=0;spr_shadow=mskNone;
            if(_near) scrHMWaterEntrySound();
        }
        if(!_near && object_index!=Player) continue;
        if(object_index==Gator || object_index==BuffGator) {
            speed=5*timescale;direction=round(direction/90)*90;
        } else if(object_index!=Player && object_index!=CustomEnemy && speed>timescale) speed=timescale;
        if(random(32)<1 && object_index!=Player) direction=choose(0,90,180,270);
        if(speed>.4*timescale && HMWorld.logic_serial mod 4==0 && instance_number(Wind)<80) {
            with(instance_create(x,y-4,Wind)) {sprite_index=global.hm_module_vars[$ "mod:maincode"].ripple;depth=2;image_xscale=choose(-1,1);}
        }
        var _bind=scrHMBindDraw(hm_maincode_mod_gml_sewerboi,2-y/10000);
        _bind.creator=id;
    }
    scrHMWaterBatchEnd1102();
    with(Crab) friction=.8*timescale*timescale;
    // A handful of visible water specks, rather than a full floor scan plus
    // particles per cell on every simulation tick.
    if(HMWorld.logic_serial mod 4==0) repeat(3) {
        var _xx=_player.x+random_range(-view_width/2,view_width/2),_yy=_player.y+random_range(-view_height/2,view_height/2);
        if(_map[$ scrHMWaterKey(_xx,_yy)]??false) with(instance_create(_xx,_yy,RadEat)) image_angle=random(360);
    }
    if(HMWorld.logic_serial mod 4==0) with(Corpse) if(image_alpha>0 && (_map[$ scrHMWaterKey(x,y)]??false)) image_alpha=max(0,image_alpha-.04);
}

function scrHMGameplayRadiationReference1103() {
if ((! instance_exists(Rad))) {
exit;
}
if ((!scrHMVariableExists(GameCont, "hm_native_controller_id"))) {
exit;
}
var _hml_owner = GameCont.hm_native_controller_id;
;
if ((! instance_exists(_hml_owner))) {
exit;
}
if ((!scrHMVariableExists(_hml_owner, "hm_rad_grid"))) {
_hml_owner.hm_rad_grid = undefined;
}
if ((_hml_owner.hm_rad_grid == undefined)) {
_hml_owner.hm_rad_grid = ds_map_create();
} else {
ds_map_clear(_hml_owner.hm_rad_grid);
}
;
var _hml_grid = _hml_owner.hm_rad_grid;
var _hml_order = 0;
;
{ var __hm_with1 = scrHMInstances(Rad), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
hm_rad_order = _hml_order;
;
_hml_order++;
;
var _hml_key = ((string(floor((x / 64))) + ":") + string(floor((y / 64))));
var _hml_items = [];
;
if (ds_map_exists(_hml_grid, _hml_key)) {
_hml_items = ds_map_find_value(_hml_grid, _hml_key);
}
array_push(_hml_items, id);
;
ds_map_replace(_hml_grid, _hml_key, _hml_items);
;
}
}
if(__hm_break3) break;
}}
{ var __hm_with4 = scrHMInstances(enemy), __hm_break6=false;
for (var __hm_index5=0; __hm_index5<array_length(__hm_with4); ++__hm_index5) {
if(instance_exists(__hm_with4[__hm_index5])) with (__hm_with4[__hm_index5]) {
if ((team != 3)) {
{
var _hml_source = id;
var _hml_candidates = [];
;
for (var _hml_cy = floor(((y - 32) / 64)); (_hml_cy <= floor(((y + 32) / 64))); _hml_cy++) for (var _hml_cx = floor(((x - 32) / 64)); (_hml_cx <= floor(((x + 32) / 64))); _hml_cx++) {
var _hml_key = ((string(_hml_cx) + ":") + string(_hml_cy));
;
if ((! ds_map_exists(_hml_grid, _hml_key))) {
continue;
}
var _hml_items = ds_map_find_value(_hml_grid, _hml_key);
;
for (var _hml_i = 0; (_hml_i < array_length(_hml_items)); _hml_i++) {
var _hml_rad = _hml_items[_hml_i];
;
if ((! instance_exists(_hml_rad))) {
continue;
}
var _hml_dx = (x - _hml_rad.x);
var _hml_dy = (y - _hml_rad.y);
;
if ((((_hml_dx * _hml_dx) + (_hml_dy * _hml_dy)) > 1024)) {
continue;
}
array_push(_hml_candidates, _hml_rad);
;
}
}
for (var _hml_i = 1; (_hml_i < array_length(_hml_candidates)); _hml_i++) {
var _hml_value = _hml_candidates[_hml_i];
var _hml_j = (_hml_i - 1);
;
while ((_hml_j >= 0)) {
if ((_hml_candidates[_hml_j].hm_rad_order <= _hml_value.hm_rad_order)) {
break;
}
_hml_candidates[(_hml_j + 1)] = _hml_candidates[_hml_j];
;
_hml_j--;
;
}
_hml_candidates[(_hml_j + 1)] = _hml_value;
;
}
for (var _hml_i = 0; (_hml_i < array_length(_hml_candidates)); _hml_i++) {
var _hml_rad = _hml_candidates[_hml_i];
;
if ((! instance_exists(_hml_rad))) {
continue;
}
{ var __hm_with7 = scrHMInstances(_hml_rad), __hm_break9=false;
for (var __hm_index8=0; __hm_index8<array_length(__hm_with7); ++__hm_index8) {
if(instance_exists(__hm_with7[__hm_index8])) with (__hm_with7[__hm_index8]) {
if (((distance_to_object(_hml_source) < 32) && (distance_to_object(Player) > 32))) {
{
scrHMMotionAdd(point_direction(x, y, _hml_source.x, _hml_source.y), 0.5);
;
if (place_meeting(x, y, _hml_source)) {
{
instance_create(x, y, RadEat);
;
_hml_source.raddrop += 1;
;
instance_destroy();
;
}
}
}
}
}
if(__hm_break9) break;
}}
}
}
}
}
if(__hm_break6) break;
}}
}

