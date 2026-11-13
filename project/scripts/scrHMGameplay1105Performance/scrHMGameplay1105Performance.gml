// Opt-in host-VM regressions. Expected water answers come from the retained
// non-batched exact geometry path; shield answers come from the original
// full projectile snapshot and precise collision tests.
function scrHMGameplayPerformance1105() {
    if(ticks!=20) return;
    if(mode=="sync115water") scrHMGameplayWaterProof1105();
    if(mode=="sync115bubbles") scrHMGameplayBubbles1105();
    if(mode=="sync115shield") scrHMGameplayShields1105();
    if(mode=="sync115environment") scrHMGameplayEnvironment1105();
    if(mode=="sync115waterprofile") scrHMGameplayWaterProfile1105();
}

// Frozen 1.1.4 complete water call tree from GitHub commit
// 48ac73f965f83240a1a88c1253207aff27866715. Only function identifiers are renamed.
// See release1105/water-baseline114-manifest.json for source function hashes.
function scrHMGameplayWaterKey114For115(_x,_y) {return string(floor(_x/16))+","+string(floor(_y/16));}

function scrHMGameplayWaterMap114For115() {
    var _map={};
    with(Floor) if(traction==2) {
        for(var _xx=x;_xx<x+32;_xx+=16) for(var _yy=y;_yy<y+32;_yy+=16)
            _map[$ scrHMGameplayWaterKey114For115(_xx,_yy)]=true;
    }
    // Newly broken banks can overlap a former water cell. Dry, walkable
    // collision tiles take precedence; decorative 40px water caps do not.
    with(Floor) if(traction!=2) {
        var _width=(object_index==FloorExplo)?16:32;
        for(var _xx=x;_xx<x+_width;_xx+=16) for(var _yy=y;_yy<y+_width;_yy+=16)
            _map[$ scrHMGameplayWaterKey114For115(_xx,_yy)]=false;
    }
    HMWorld.hm_water_map=_map;
    scrHMGameplayWaterRects114For115();
    HMWorld.hm_water_floors=instance_number(Floor);
}

function scrHMGameplayWaterAt114For115(_x,_y) {
    if(is_undefined(variable_instance_get(HMWorld,"hm_water_map")) || (variable_instance_get(HMWorld,"hm_water_floors")??-1)!=instance_number(Floor)) scrHMGameplayWaterMap114For115();
    return scrHMGameplayWaterDispatch114For115(_x,_y);
}

function scrHMGameplayWaterBank114For115(_floor,_x,_y) {
    var _surface=_floor[$ "hm_water_surface111"]??noone;
    if(!instance_exists(_surface) || _surface.sprite_index!=sprHM_areas_sewers_area_3) return false;
    // Rows 0..7 of the 40px sprite are bank/shore; scale .8 => 6.4 world px.
    var _top=_surface.y-sprite_get_yoffset(_surface.sprite_index)*_surface.image_yscale;
    return _y<_top+8*abs(_surface.image_yscale);
}

function scrHMGameplayWaterRects114For115() {
    var _rects={};
    with(Floor) {
        var _size=instance_is(id,FloorExplo)?16:32;
        for(var _xx=floor(x/16)*16;_xx<x+_size;_xx+=16)
            for(var _yy=floor(y/16)*16;_yy<y+_size;_yy+=16) {
                var _key=scrHMGameplayWaterKey114For115(_xx,_yy),_entries=_rects[$ _key]??[];
                array_push(_entries,id);_rects[$ _key]=_entries;
            }
    }
    HMWorld.hm_water_rects109=_rects;
}

function scrHMGameplayWaterDispatch114For115(_x,_y) {
    if(variable_instance_get(HMWorld,"hm_water_batch1102")??false) return scrHMGameplayWaterExact114For115(_x,_y);
    // The hash supplies candidates, but a quantized 16px cell must never
    // include a neighbouring dry bank or a fractional edge outside the tile.
    var _entries=HMWorld.hm_water_rects109[$ scrHMGameplayWaterKey114For115(_x,_y)]??[];
    var _water=false;
    for(var _i=0;_i<array_length(_entries);++_i) {
        var _f=_entries[_i];
        if(!instance_exists(_f)) continue;
        var _size=instance_is(_f,FloorExplo)?16:32;
        if(_x<_f.x || _y<_f.y || _x>=_f.x+_size || _y>=_f.y+_size) continue;
        if(_f.traction!=2 || !instance_exists(_f[$ "hm_water_surface111"]??noone) || scrHMGameplayWaterBank114For115(_f,_x,_y)) return false;
        _water=true;
    }
    return _water;
}

function scrHMGameplayWaterBatchBegin114For115() {
    HMWorld.hm_water_batch_cache1102={};
    HMWorld.hm_water_batch1102=true;
}

function scrHMGameplayWaterBatchEnd114For115() {HMWorld.hm_water_batch1102=false;}

function scrHMGameplayWaterExact114For115(_x,_y) {
    var _key=scrHMGameplayWaterKey114For115(_x,_y);
    var _shapes=HMWorld.hm_water_batch_cache1102[$ _key];
    if(is_undefined(_shapes)) {
        _shapes=[];
        var _entries=HMWorld.hm_water_rects109[$ _key]??[];
        for(var _i=0;_i<array_length(_entries);++_i) {
            var _f=_entries[_i];if(!instance_exists(_f)) continue;
            var _size=instance_is(_f,FloorExplo)?16:32;
            var _surface=_f[$ "hm_water_surface111"]??noone;
            var _wet=_f.traction==2 && instance_exists(_surface),_bank=-1000000000000000000000000000000;
            if(_wet && _surface.sprite_index==sprHM_areas_sewers_area_3)
                _bank=_surface.y-sprite_get_yoffset(_surface.sprite_index)*_surface.image_yscale+8*abs(_surface.image_yscale);
            array_push(_shapes,[_f.x,_f.y,_f.x+_size,_f.y+_size,_wet,_bank]);
        }
        HMWorld.hm_water_batch_cache1102[$ _key]=_shapes;
    }
    var _water=false;
    for(var _i=0;_i<array_length(_shapes);++_i) {
        var _r=_shapes[_i];
        if(_x<_r[0] || _y<_r[1] || _x>=_r[2] || _y>=_r[3]) continue;
        if(!_r[4] || _y<_r[5]) return false;
        _water=true;
    }
    return _water;
}

function scrHMGameplayWaterSupport114For115(_x,_y) {
    // An actor still supported by the visible bank stays on land. Five
    // exact, hashed probes cover the small foot contact area; there is no
    // nearest-tile search and no delay timer on leaving the water.
    return scrHMGameplayWaterAt114For115(_x,_y)
        && scrHMGameplayWaterDispatch114For115(_x-3,_y) && scrHMGameplayWaterDispatch114For115(_x+3,_y)
        && scrHMGameplayWaterDispatch114For115(_x,_y-2) && scrHMGameplayWaterDispatch114For115(_x,_y+2);
}

function scrHMGameplayWaterPotential114For115() {
    var _floors=instance_number(Floor);
    if(instance_number(hitme)<_floors*.5) return undefined;
    var _boxes=[],_minx=1000000000000000000000000000000,_miny=1000000000000000000000000000000,_maxx=-1000000000000000000000000000000,_maxy=-1000000000000000000000000000000;
    with(Floor) if(traction==2 && instance_exists(self[$ "hm_water_surface111"]??noone)) {
        var _size=instance_is(id,FloorExplo)?16:32;
        var _x0=floor(x/32),_x1=ceil((x+_size)/32)-1;
        var _y0=floor(y/32),_y1=ceil((y+_size)/32)-1;
        array_push(_boxes,[_x0,_y0,_x1,_y1]);
        _minx=min(_minx,_x0);_maxx=max(_maxx,_x1);
        _miny=min(_miny,_y0);_maxy=max(_maxy,_y1);
    }
    if(array_length(_boxes)==0) return {cells:[],minx:0,miny:0,width:0,height:0};
    var _width=_maxx-_minx+1,_height=_maxy-_miny+1,_count=_width*_height;
    if(_width<=0 || _height<=0 || _count>65536 || _count>max(256,_floors*8)) return undefined;
    var _cells=array_create(_count,false);
    for(var _i=0;_i<array_length(_boxes);++_i) {
        var _r=_boxes[_i];
        for(var _yy=_r[1];_yy<=_r[3];++_yy) for(var _xx=_r[0];_xx<=_r[2];++_xx)
            _cells[_xx-_minx+(_yy-_miny)*_width]=true;
    }
    return {cells:_cells,minx:_minx,miny:_miny,width:_width,height:_height};
}

function scrHMGameplayWaterPossible114For115(_potential,_x,_y) {
    if(is_undefined(_potential)) return true;
    var _gx=floor(_x/32)-_potential.minx,_gy=floor(_y/32)-_potential.miny;
    if(_gx<0 || _gy<0 || _gx>=_potential.width || _gy>=_potential.height) return false;
    return _potential.cells[_gx+_gy*_potential.width];
}

// kind 0 is the released 1.1.4 potential-grid rebuild plus hashed queries;
// kind 1 is restored released production after all numeric candidates regressed;
// kind 2 is independent non-batched exact geometry used only for correctness;
// kind 3 measures ungated production hash queries to expose dry-query overhead.
function scrHMGameplayWaterPass115(_points,_kind,_collect=false) {
    var _potential=undefined,_hits=0,_answers=[];
    if(_kind==0) {
        _potential=scrHMGameplayWaterPotential114For115();
        scrHMGameplayWaterBatchBegin114For115();
    } else if(_kind==1 || _kind==3) {
        if(_kind==1) _potential=scrHMWaterPotential1103();
        scrHMWaterBatchBegin1102();
    }
    else scrHMWaterBatchEnd1102();
    for(var _i=0;_i<array_length(_points);++_i) {
        var _p=_points[_i],_wet;
        if(_kind==0) _wet=scrHMGameplayWaterPossible114For115(_potential,_p[0],_p[1])
            && scrHMGameplayWaterSupport114For115(_p[0],_p[1]);
        else if(_kind==1) _wet=scrHMWaterPossible1103(_potential,_p[0],_p[1])
            && scrHMSwimSupported112(_p[0],_p[1]);
        else _wet=scrHMSwimSupported112(_p[0],_p[1]);
        if(_wet) _hits++;
        if(_collect) array_push(_answers,_wet);
    }
    if(_kind==0) scrHMGameplayWaterBatchEnd114For115();
    else scrHMWaterBatchEnd1102();
    return _collect?_answers:_hits;
}

function scrHMGameplayWaterProfile1105() {
    scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("sewers"),"water timing uses a real generated Hardmode sewer");
    var _floors=[],_points=[],_added=[];
    with(Floor) if(point_distance(x,y,other.player.x,other.player.y)<4096) array_push(_floors,id);
    scrHMGameplayCheck(array_length(_floors)>20,"water timing retains generated map geometry");
    with(hitme) if((self[$ "swimming"]??false) || variable_instance_exists(id,"right")) array_push(_points,[x,y]);
    // Add real native actors before timing, distributing them over the same
    // generated floor geometry. Neither timed path runs AI or changes actors.
    var _needed=max(0,600-array_length(_points));
    repeat(_needed) {
        var _i=array_length(_added),_f=_floors[(_i*17) mod array_length(_floors)];
        var _a=instance_create(_f.x+((_i mod 3)==0?2:16),_f.y+((_i mod 5)==0?4:16),Bandit);
        _a.speed=0;array_push(_added,_a);array_push(_points,[_a.x,_a.y]);
    }
    scrHMWaterMap();
    var _expected=scrHMGameplayWaterPass115(_points,2,true);
    scrHMGameplayPerfEqual1103(_expected,scrHMGameplayWaterPass115(_points,0,true),"released hashed water path matches independent exact geometry on the real crowded sewer");
    scrHMGameplayPerfEqual1103(_expected,scrHMGameplayWaterPass115(_points,1,true),"restored released hashed path matches independent exact geometry on the same crowded sewer");
    scrHMGameplayPerfEqual1103(_expected,scrHMGameplayWaterPass115(_points,3,true),"ungated diagnostic hash preserves the same exact answers");
    var _potential=scrHMWaterPotential1103(),_survivors=0;
    for(var _i=0;_i<array_length(_points);++_i) {
        var _p=_points[_i];
        if(scrHMWaterPossible1103(_potential,_p[0],_p[1])) _survivors++;
    }
    var _old=[],_new=[],_ungated=[],_old_hits=0,_new_hits=0,_ungated_hits=0,_build=[];
    repeat(3) {scrHMGameplayWaterPass115(_points,0);scrHMGameplayWaterPass115(_points,1);}
    for(var _sample=0;_sample<12;++_sample) {
        // Alternate execution order so warm caches/scheduler drift do not
        // systematically favor one side of the paired measurement.
        for(var _which=0;_which<2;++_which) {
            var _kind=(_sample+_which) mod 2,_t=get_timer(),_hits=0;
            repeat(4) _hits+=scrHMGameplayWaterPass115(_points,_kind);
            var _elapsed=get_timer()-_t;
            if(_kind==0) {array_push(_old,_elapsed);_old_hits+=_hits;}
            else {array_push(_new,_elapsed);_new_hits+=_hits;}
        }
        var _t=get_timer(),_hits=0;
        repeat(4) _hits+=scrHMGameplayWaterPass115(_points,3);
        array_push(_ungated,get_timer()-_t);_ungated_hits+=_hits;
        _t=get_timer();scrHMWaterRects109();array_push(_build,get_timer()-_t);
    }
    array_sort(_old,true);array_sort(_new,true);array_sort(_ungated,true);array_sort(_build,true);
    scrHMGameplayCheck(_old_hits==_new_hits && _old_hits==_ungated_hits,"all timed water passes return identical wet actor counts");
    var _bindings=scrHMGameplaySewerBindingProfile1115();
    show_debug_message("HARDMODE WATER115 PROFILE "+json_stringify({area:GameCont.area,loops:GameCont.loops,rate:rate,
        floors:instance_number(Floor),entities:instance_number(hitme),actor_queries:array_length(_points),samples:12,passes_per_sample:4,
        original_median_us:_old[6],optimized_median_us:_new[6],ungated_hash_median_us:_ungated[6],
        candidate_hash_build_median_us:_build[6],strategy:"released_hash_gate_restored",sewer_binding_profile:_bindings,wet_actor_results:_new_hits,coarse_survivors_per_pass:_survivors,
        real_generated_geometry:true,physical_device:false,scope:"restored released coarse gate and exact five-foot hash queries; excludes AI and draw"}));
    for(var _i=0;_i<array_length(_added);++_i) if(instance_exists(_added[_i])) instance_destroy(_added[_i],false);
    show_debug_message("HARDMODE WATER115 PROFILE COMPLETE");
}

function scrHMGameplayWaterPair1105(_x,_y,_message) {
    scrHMWaterBatchEnd1102();
    var _expected=scrHMSwimSupported112(_x,_y);
    var _potential=scrHMWaterPotential1103();
    scrHMWaterBatchBegin1102();
    var _actual=scrHMWaterPossible1103(_potential,_x,_y) && scrHMSwimSupported112(_x,_y);
    scrHMWaterBatchEnd1102();
    scrHMGameplayCheck(_actual==_expected,_message);
    return _actual;
}

function scrHMGameplayWaterProof1105() {
    // Thousands of fractional seams, dry overlaps, 16px blast tiles, compiled
    // API answers, whole-pass visual state and RNG are retained as regressions.
    scrHMGameplayWaterProof1103();
    for(var _portal=0;_portal<2;++_portal) for(var _cap=0;_cap<2;++_cap) {
        var _winds=_cap?79:0;
        var _expected=scrHMGameplayWaterRun1103(false,_portal,_winds,983117);
        var _actual=scrHMGameplayWaterRun1103(true,_portal,_winds,983117);
        scrHMGameplayPerfEqual1103(_expected,_actual,"cached gate whole sewer pass preserves swimming, effects, bindings, sound debounce and subsequent RNG");
    }
    var _fixture=scrHMGameplayWaterFixture1103(false,0);
    var _binding_proof=scrHMGameplaySewerBindingProfile1115("authored_native_water_fixture");
    scrHMGameplayCheck(!(_binding_proof[$ "not_applicable"]??false),"independent native wet fixture always exercises specialized sewer renderer lifecycle");
    show_debug_message("HARDMODE SEWERBIND115 FIXTURE "+json_stringify(_binding_proof));
    var _floor=_fixture.floors[1],_x=_floor.x+16,_y=_floor.y+16;
    scrHMGameplayCheck(scrHMGameplayWaterPair1105(_x,_y,"batched hash matches independent exact wet query"),"linked wet floor remains water");
    _floor.traction=1;
    scrHMGameplayCheck(!scrHMGameplayWaterPair1105(_x,_y,"new batch refreshes live wet-to-dry state"),"changed traction becomes dry without a geometry rebuild");
    _floor.traction=2;
    scrHMGameplayCheck(scrHMGameplayWaterPair1105(_x,_y,"new batch refreshes dry-to-wet state"),"restored traction becomes wet");
    instance_destroy(_floor.hm_water_surface111,false);
    scrHMGameplayCheck(!scrHMGameplayWaterPair1105(_x,_y,"new batch refreshes a deleted linked surface"),"deleted water surface no longer supports swimming");
    var _far=instance_create(18000.25,18000.5,Floor);
    _far.traction=1;
    var _surface=instance_create(_far.x,_far.y,CustomObject);
    _surface.sprite_index=sprHM_areas_sewers_area_4;_surface.image_yscale=.8;
    _far.hm_water_surface111=_surface;
    scrHMWaterMap();
    _far.traction=2;
    scrHMGameplayCheck(scrHMGameplayWaterPair1105(_far.x+16,_far.y+16,"hashed lookup observes live dry-to-wet mutation"),"new remote water is not falsely rejected by stale wet bounds");
    var _old_count=instance_number(Floor),_old_x=_far.x,_old_y=_far.y;
    instance_destroy(_far,false);
    var _replacement=instance_create(_old_x,_old_y,Floor);_replacement.traction=1;
    scrHMGameplayCheck(instance_number(Floor)==_old_count,"replacement fixture preserves Floor count");
    scrHMGameplayCheck(is_undefined(HMWorld.hm_water_map),"native Floor creation invalidates geometry even when the final Floor count is unchanged");
    scrHMGameplayCheck(!scrHMGameplayWaterPair1105(_old_x+16,_old_y+16,"ordinary query rebuilds stale same-count candidates automatically"),"replacement floor is dry");
    var _live=_fixture.floors[4],_lx=_live.x+16,_ly=_live.y+16;
    scrHMGameplayCheck(scrHMGameplayWaterPair1105(_lx,_ly,"wet geometry remains valid before adding a blast patch"),"blast patch fixture begins in water");
    var _blast=instance_create(_live.x+12,_live.y+12,FloorExplo);_blast.traction=1;
    scrHMGameplayCheck(!scrHMGameplayWaterPair1105(_lx,_ly,"native FloorExplo creation invalidates cached wet candidates"),"new dry blast floor takes precedence over water");
    instance_destroy(_blast,false);
    scrHMGameplayCheck(scrHMGameplayWaterPair1105(_lx,_ly,"removed floor count rebuilds cached dry overlap candidates"),"deleting a dry blast patch restores live water");
    _replacement.traction=2;_replacement.hm_water_surface111=_surface;
    _replacement.x=1600000;_replacement.y=1600000;_surface.x=_replacement.x;_surface.y=_replacement.y;
    scrHMWaterMap();
    scrHMGameplayCheck(scrHMGameplayWaterPair1105(_replacement.x+16,_replacement.y+16,"spread-out hashed lookup matches exact geometry"),"spread-out live water still works");
    show_debug_message("HARDMODE WATER115 PROOF COMPLETE");
}

function scrHMGameplayBubbles1105() {
    scrHMGameplayIsolate103();with(Bubble) instance_destroy(id,false);
    var _area=GameCont.area;GameCont.area=scrHMAreaResolve("oasis");
    var _x=view_xview+view_width/2,_y=view_yview+view_height/2;
    var _expected=[],_actual=[],_seed=715005;
    random_set_seed(_seed);
    repeat(100) {var _bubble=instance_create(_x,_y,Bubble);instance_destroy(_bubble,false);}
    repeat(16) array_push(_expected,random(1000000));
    random_set_seed(_seed);HMWorld.hm_oasis_bubble_tick1105=-1;
    var _projectiles=instance_number(projectile),_enemies=instance_number(enemy),_visible=0;
    repeat(100) if(instance_exists(scrHMOasisBubble1105(_x,_y))) _visible++;
    repeat(16) array_push(_actual,random(1000000));
    scrHMGameplayPerfEqual1103(_expected,_actual,"ambient bubble limits preserve subsequent combat RNG");
    scrHMGameplayCheck(_visible==3 && instance_number(Bubble)==3,"crowded oasis emits at most three ambient bubbles per logic tick");
    HMWorld.logic_serial++;
    scrHMGameplayCheck(!instance_exists(scrHMOasisBubble1105(view_xview-100,view_yview-100)),"offscreen ambient bubble is not allocated");
    with(Bubble) instance_destroy(id,false);
    repeat(80) instance_create(_x,_y,Bubble);
    HMWorld.logic_serial++;
    scrHMGameplayCheck(!instance_exists(scrHMOasisBubble1105(_x,_y)) && instance_number(Bubble)==80,"existing environmental bubbles respect live ambient cap");
    scrHMGameplayCheck(instance_number(projectile)==_projectiles && instance_number(enemy)==_enemies,"bubble budget changes neither projectiles nor enemies");
    with(Bubble) instance_destroy(id,false);
    GameCont.area=_area;HMWorld.hm_oasis_bubble_tick1105=-1;
    show_debug_message("HARDMODE BUBBLES115 PROOF COMPLETE");
}

function scrHMGameplayShieldHits1105(_shield,_optimized) {
    var _hits=[],_candidates=_optimized?scrHMShieldProjectiles1105(_shield):scrHMInstances(projectile);
    for(var _i=0;_i<array_length(_candidates);++_i) with(_candidates[_i])
        if(place_meeting(x,y,_shield)) array_push(_hits,id);
    return _hits;
}

function scrHMGameplayShields1105() {
    scrHMGameplayIsolate103();
    var _shield=instance_create(16000,16000,CustomObject);
    _shield.mask_index=mskBandit;_shield.sprite_index=sprBanditIdle;
    var _types=[Bullet1,EnemyBullet1,CustomProjectile];
    for(var _i=0;_i<900;++_i) {
        var _p=instance_create(16400+(_i mod 30)*32,16400+(_i div 30)*32,_types[_i mod 3]);
        _p.mask_index=mskBandit;_p.speed=0;
    }
    for(var _i=0;_i<24;++_i) {
        var _p=instance_create(16000+(_i mod 6)*5-12,16000+(_i div 6)*5-7,_types[_i mod 3]);
        _p.mask_index=mskBandit;_p.speed=0;_p.team=_i mod 3;
        _p.image_xscale=choose(-1,1)*(.4+(_i mod 4)*.6);
        _p.image_yscale=.6+(_i mod 3)*.7;_p.image_angle=_i*17;
    }
    for(var _i=0;_i<6;++_i) {
        _shield.image_xscale=.4+_i*.4;_shield.image_yscale=1.7-_i*.2;_shield.image_angle=_i*29;
        var _expected=scrHMGameplayShieldHits1105(_shield,false),_actual=scrHMGameplayShieldHits1105(_shield,true);
        scrHMGameplayPerfEqual1103(_expected,_actual,"shield native broad phase preserves precise hit membership and original mixed-child enumeration order");
    }
    _shield.x=19000;_shield.y=19000;
    scrHMGameplayCheck(array_length(scrHMShieldProjectiles1105(_shield))==0,"empty shield returns before constructing a whole-map projectile snapshot");
    _shield.x=16000;_shield.y=16000;
    var _old=[],_new=[],_old_hits=0,_new_hits=0;
    for(var _sample=0;_sample<12;++_sample) {
        for(var _which=0;_which<2;++_which) {
            var _kind=(_sample+_which) mod 2,_t=get_timer(),_hits=0;
            repeat(12) _hits+=array_length(scrHMGameplayShieldHits1105(_shield,_kind==1));
            var _elapsed=get_timer()-_t;
            if(_kind==0) {array_push(_old,_elapsed);_old_hits+=_hits;}
            else {array_push(_new,_elapsed);_new_hits+=_hits;}
        }
    }
    array_sort(_old,true);array_sort(_new,true);
    scrHMGameplayCheck(_old_hits==_new_hits,"timed shield probes retain the same exact collisions");
    show_debug_message("HARDMODE SHIELDS115 PROFILE "+json_stringify({projectiles:instance_number(projectile),samples:12,queries_per_sample:12,
        original_median_us:_old[6],optimized_median_us:_new[6],hits:_new_hits,physical_device:false}));
    with(projectile) instance_destroy(id,false);instance_destroy(_shield,false);
}

function scrHMGameplayEnvironment1105() {
    var _area=GameCont.area,_sub=GameCont.subarea,_loop=GameCont.loops;
    GameCont.area=scrHMAreaResolve("throne");GameCont.underwater=true;
    player.swimming=true;player.hm_swim_fly=false;player.hm_swim_alpha=.7;
    player.shd_=shd24;player.canfly=true;player.image_alpha=0;player.spr_shadow=mskNone;
    scrHMRoomWaterState1105(true);
    scrHMGameplayCheck(!GameCont.underwater && !player.swimming && !player.canfly && player.image_alpha==.7 && player.spr_shadow==shd24,
        "Throne clears stale native underwater state and persistent player swimming presentation");
    scrHMGameplayCheck(is_undefined(HMWorld.hm_water_map) && is_undefined(HMWorld.hm_water_index1105) && !HMWorld.hm_water_batch1102,
        "new room invalidates former geometry even if Floor count is unchanged");
    GameCont.underwater=true;scrHMRoomWaterState1105();
    scrHMGameplayCheck(!GameCont.underwater,"Throne state cannot be re-enabled by continued-room state");
    GameCont.area=scrHMAreaResolve("oasis");GameCont.underwater=false;scrHMRoomWaterState1105();
    scrHMGameplayCheck(!GameCont.underwater,"Hardmode oasis retains its authored independent underwater presentation");
    GameCont.area=_area;GameCont.subarea=_sub;GameCont.loops=_loop;scrHMRoomWaterState1105(true);
    show_debug_message("HARDMODE ENVIRONMENT115 PROOF COMPLETE");
}

function scrHMGameplaySewerBindingProfile1115(_source="generated_sewer") {
    var _actors=[],_spawned=[];
    with(hitme) if(variable_instance_exists(id,"right") && scrHMSwimSupported112(x,y)) array_push(_actors,id);
    if(array_length(_actors)==0) {
        // Actor distribution is not evidence that generated water is absent.
        // Probe real native Floor footprints before constructing wet actors.
        var _sites=[];
        with(Floor) if(traction==2 && instance_exists(self[$ "hm_water_surface111"]??noone)) {
            var _offsets=[8,16,24];
            for(var _xx=0;_xx<3;++_xx) for(var _yy=0;_yy<3;++_yy) {
                var _px=x+_offsets[_xx],_py=y+_offsets[_yy];
                if(scrHMSwimSupported112(_px,_py)) array_push(_sites,[_px,_py]);
            }
        }
        if(array_length(_sites)==0) return {actors:0,samples:0,passes_per_sample:0,
            original_median_us:0,optimized_median_us:0,refreshes:0,physical_device:false,
            not_applicable:true,reason:"generated sewer has no exact five-foot water footprint"};
        for(var _i=0;_i<24;++_i) {
            var _point=_sites[_i mod array_length(_sites)];
            var _actor=instance_create(_point[0],_point[1],Bandit);_actor.speed=0;_actor.right=1;
            scrHMGameplayCheck(scrHMSwimSupported112(_actor.x,_actor.y),"binding fixture actor has a verified real generated wet five-foot contact");
            array_push(_actors,_actor);array_push(_spawned,_actor);
        }
    }
    scrHMGameplayCheck(array_length(_actors)>0,"binding timing uses real wet native actors on the generated sewer map");
    for(var _i=0;_i<array_length(_actors);++_i) with(_actors[_i]) {
        var _original=scrHMBindDraw(hm_maincode_mod_gml_sewerboi,2-y/10000);
        var _special=scrHMSewerBindDraw1115();
        scrHMGameplayCheck(_original==_special && _special.creator==id && _special.hm_draw
            && _special.hm_menu_overlay && array_length(_special.hm_args)==0,
            "specialized sewer refresh reuses the same native zero-argument draw binding and owner");
    }
    var _before=instance_number(HMBinding),_old=[],_new=[],_old_count=0,_new_count=0;
    for(var _sample=0;_sample<12;++_sample) {
        for(var _which=0;_which<2;++_which) {
            var _kind=(_sample+_which) mod 2,_t=get_timer(),_count=0;
            repeat(4) for(var _i=0;_i<array_length(_actors);++_i) with(_actors[_i]) {
                var _binding=_kind==0?scrHMBindDraw(hm_maincode_mod_gml_sewerboi,2-y/10000):scrHMSewerBindDraw1115();
                if(instance_exists(_binding)) _count++;
            }
            var _elapsed=get_timer()-_t;
            if(_kind==0) {array_push(_old,_elapsed);_old_count+=_count;}
            else {array_push(_new,_elapsed);_new_count+=_count;}
        }
    }
    array_sort(_old,true);array_sort(_new,true);
    scrHMGameplayCheck(_old_count==_new_count && instance_number(HMBinding)==_before,
        "timed specialized sewer refresh preserves binding ownership/count with no new renderer allocations");
    var _actor=_actors[0],_old_binding=_actor.hm_sewer_binding1115;
    instance_destroy(_old_binding,false);
    with(_actor) {
        var _binding=scrHMSewerBindDraw1115();
        scrHMGameplayCheck(instance_exists(_binding) && _binding!=_old_binding && _binding.creator==id,
            "destroyed sewer renderer is recreated through generic binding ownership initialization");
        var _random_before=[],_random_after=[];
        random_set_seed(715115);repeat(16) array_push(_random_before,random(100000));
        random_set_seed(715115);repeat(16) scrHMSewerBindDraw1115();repeat(16) array_push(_random_after,random(100000));
        scrHMGameplayPerfEqual1103(_random_before,_random_after,"specialized sewer binding refresh does not consume gameplay RNG");
    }
    var _report={actors:array_length(_actors),samples:12,passes_per_sample:4,
        original_median_us:_old[6],optimized_median_us:_new[6],refreshes:_new_count,
        physical_device:false,real_generated_water_footprint:_source=="generated_sewer",fixture_source:_source,
        scope:"native generic vs specialized sewer draw-binding refresh on identical wet actors"};
    for(var _i=0;_i<array_length(_spawned);++_i) if(instance_exists(_spawned[_i])) instance_destroy(_spawned[_i],false);
    return _report;
}
