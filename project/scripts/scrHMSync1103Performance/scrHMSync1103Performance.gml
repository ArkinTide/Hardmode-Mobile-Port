// Pass-local work reduction; all mobile geometry, random calls and native
// effects remain in their existing order. Sparse or spread-out scenes use
// the original exact implementation without building a large flat array.
function scrHMWaterPotential1103() {
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

function scrHMWaterPossible1103(_potential,_x,_y) {
    if(is_undefined(_potential)) return true;
    var _gx=floor(_x/32)-_potential.minx,_gy=floor(_y/32)-_potential.miny;
    if(_gx<0 || _gy<0 || _gx>=_potential.width || _gy>=_potential.height) return false;
    return _potential.cells[_gx+_gy*_potential.width];
}

function scrHMSewerTick1103() {
    if(!instance_exists(Player)) {
        with(hitme) if(self[$ "swimming"]??false) scrHMSwimLeave();
        return;
    }
    if(is_undefined(variable_instance_get(HMWorld,"hm_water_map")) || (variable_instance_get(HMWorld,"hm_water_floors")??-1)!=instance_number(Floor)) scrHMWaterMap();
    var _player=instance_nearest(x,y,Player),_map=HMWorld.hm_water_map;
    // None of the callbacks below create/delete SpiralCont or Portal. Wind
    // Create only sets its animation, so its live count changes by our own
    // creations during this synchronous pass.
    var _spiral=instance_exists(SpiralCont),_portal=instance_exists(Portal);
    var _ripple=HMWorld.logic_serial mod 4==0,_winds=instance_number(Wind);
    // Keep the released conservative dry rejection. Most crowded sewer
    // actors are on dry ground; exact five-foot probes only follow a possible
    // water center. This grid reads live floor state once for the whole pass.
    var _potential=scrHMWaterPotential1103();
    scrHMWaterBatchBegin1102();
    with(hitme) {
        if(self[$ "hm_portrait_frozen"]??false) continue;
        var _was=self[$ "swimming"]??false;
        if(!_was && (!variable_instance_exists(id,"right") || object_index==FireBaller || object_index==SuperFireBaller)) continue;
        var _near=point_distance(x,y,_player.x,_player.y)<view_width;
        var _water=scrHMWaterPossible1103(_potential,x,y) && scrHMSwimSupported112(x,y) && !_spiral;
        if(_water && _portal && distance_to_object(Portal)<=32) _water=false;
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
        // Retain random(32) for the Player as well: reordering this condition
        // would silently change every subsequent random result in the run.
        if(random(32)<1 && object_index!=Player) direction=choose(0,90,180,270);
        if(speed>.4*timescale && _ripple && _winds<80) {
            with(instance_create(x,y-4,Wind)) {sprite_index=global.hm_module_vars[$ "mod:maincode"].ripple;depth=2;image_xscale=choose(-1,1);}
            _winds++;
        }
        var _bind=scrHMSewerBindDraw1115();
        _bind.creator=id;
    }
    scrHMWaterBatchEnd1102();
    with(Crab) friction=.8*timescale*timescale;
    if(_ripple) repeat(3) {
        var _xx=_player.x+random_range(-view_width/2,view_width/2),_yy=_player.y+random_range(-view_height/2,view_height/2);
        if(_map[$ scrHMWaterKey(_xx,_yy)]??false) with(instance_create(_xx,_yy,RadEat)) image_angle=random(360);
    }
    if(_ripple) with(Corpse) if(image_alpha>0 && (_map[$ scrHMWaterKey(x,y)]??false)) image_alpha=max(0,image_alpha-.04);
}

function scrHMRadiationFlat1103() {
    var _count=instance_number(Rad);
    if(_count==0) return true;
    if(_count<16 || !variable_instance_exists(GameCont,"hm_native_controller_id")) return false;
    var _owner=GameCont.hm_native_controller_id;
    if(!instance_exists(_owner)) return false;
    // Retain precisely the same snapshot enumeration used by the compiled
    // adapter, including Rad children and stable global order.
    var _rads=scrHMInstances(Rad);
    var _minx=1000000000000000000000000000000,_miny=1000000000000000000000000000000,_maxx=-1000000000000000000000000000000,_maxy=-1000000000000000000000000000000;
    for(var _i=0;_i<array_length(_rads);++_i) with(_rads[_i]) {
        var _gx=floor(x/64),_gy=floor(y/64);
        _minx=min(_minx,_gx);_maxx=max(_maxx,_gx);
        _miny=min(_miny,_gy);_maxy=max(_maxy,_gy);
    }
    var _width=_maxx-_minx+1,_height=_maxy-_miny+1,_cells=_width*_height;
    if(_width<=0 || _height<=0 || _cells>65536 || _cells>max(256,_count*8)) return false;
    var _grid=array_create(_cells,0),_order=0;
    for(var _i=0;_i<array_length(_rads);++_i) with(_rads[_i]) {
        hm_rad_order=_order++;
        var _index=floor(x/64)-_minx+(floor(y/64)-_miny)*_width;
        var _items=_grid[_index];if(!is_array(_items)) _items=[];
        array_push(_items,id);_grid[_index]=_items;
    }
    var _enemies=scrHMInstances(enemy);
    for(var _i=0;_i<array_length(_enemies);++_i) if(instance_exists(_enemies[_i])) with(_enemies[_i]) if(team!=3) {
        var _source=id,_candidates=[];
        var _x0=max(0,floor((x-32)/64)-_minx),_x1=min(_width-1,floor((x+32)/64)-_minx);
        var _y0=max(0,floor((y-32)/64)-_miny),_y1=min(_height-1,floor((y+32)/64)-_miny);
        for(var _cy=_y0;_cy<=_y1;++_cy) for(var _cx=_x0;_cx<=_x1;++_cx) {
            var _items=_grid[_cx+_cy*_width];if(!is_array(_items)) continue;
            for(var _j=0;_j<array_length(_items);++_j) {
                var _rad=_items[_j];if(!instance_exists(_rad)) continue;
                var _dx=x-_rad.x,_dy=y-_rad.y;
                if(_dx*_dx+_dy*_dy>1024) continue;
                array_push(_candidates,_rad);
            }
        }
        for(var _j=1;_j<array_length(_candidates);++_j) {
            var _value=_candidates[_j],_k=_j-1;
            while(_k>=0) {if(_candidates[_k].hm_rad_order<=_value.hm_rad_order) break;_candidates[_k+1]=_candidates[_k];_k--;}
            _candidates[_k+1]=_value;
        }
        for(var _j=0;_j<array_length(_candidates);++_j) {
            var _rad=_candidates[_j];if(!instance_exists(_rad)) continue;
            with(_rad) if(distance_to_object(_source)<32 && distance_to_object(Player)>32) {
                scrHMMotionAdd(point_direction(x,y,_source.x,_source.y),.5);
                if(place_meeting(x,y,_source)) {
                    instance_create(x,y,RadEat);_source.raddrop+=1;instance_destroy();
                }
            }
        }
    }
    return true;
}


// Oasis presentation-only bubbles keep a bounded visible budget. Combat
// entities, random draws, and the restored released water queries remain intact.
function scrHMOasisBubble1105(_x,_y) {
    if(!scrHMEnabled() || !instance_exists(GameCont)
        || GameCont.area!=scrHMAreaResolve("oasis")) return instance_create(_x,_y,Bubble);
    var _serial=HMWorld.logic_serial;
    if((variable_instance_get(HMWorld, "hm_oasis_bubble_tick1105")??-1)!=_serial) {
        HMWorld.hm_oasis_bubble_tick1105=_serial;
        HMWorld.hm_oasis_bubble_count1105=0;
    }
    var _visible=_x>=view_xview-32 && _x<=view_xview+view_width+32
        && _y>=view_yview-32 && _y<=view_yview+view_height+32;
    if(_visible && HMWorld.hm_oasis_bubble_count1105<3 && instance_number(Bubble)<80) {
        HMWorld.hm_oasis_bubble_count1105++;
        return instance_create(_x,_y,Bubble);
    }
    var _discard=random_angle;_discard=random(2);_discard=random(.2);
    return noone;
}

// A persistent Player can carry its swimming flag across rooms. Water
// geometry and native underwater audio belong to the current room, never
// to the last generated room or a continued run's former state.
function scrHMRoomWaterState1105(_new_room=false) {
    if(!scrHMEnabled() || !instance_exists(GameCont)) return;
    var _area=GameCont.area,_sub=GameCont.subarea,_loop=GameCont.loops;
    if(_new_room || (variable_instance_get(HMWorld, "hm_water_area1105")??undefined)!=_area
        || (variable_instance_get(HMWorld, "hm_water_sub1105")??undefined)!=_sub
        || (variable_instance_get(HMWorld, "hm_water_loop1105")??undefined)!=_loop) {
        HMWorld.hm_water_area1105=_area;HMWorld.hm_water_sub1105=_sub;
        HMWorld.hm_water_loop1105=_loop;
        HMWorld.hm_water_map=undefined;HMWorld.hm_water_index1105=undefined;
        HMWorld.hm_water_batch1102=false;
    }
    if(_area==scrHMAreaResolve("throne")) {
        GameCont.underwater=false;
        with(Player) if(self[$ "swimming"]??false) scrHMSwimLeave();
    }
}

// Query the native broad phase before performing a shield's original precise
// per-projectile test. When multiple candidates overlap, retain the exact
// with(projectile) order: random ricochets and Destroy callbacks must keep
// their former order even when children are enumerated by object type.
function scrHMShieldProjectiles1105(_target) {
    var _list=ds_list_create(),_found=[];
    collision_rectangle_list(_target.bbox_left-1,_target.bbox_top-1,
        _target.bbox_right+1,_target.bbox_bottom+1,projectile,false,true,_list,false);
    var _count=ds_list_size(_list);
    if(_count<2) {
        if(_count==1) array_push(_found,_list[| 0]);
        ds_list_destroy(_list);return _found;
    }
    var _stamp=(variable_instance_get(HMWorld, "hm_shield_probe1105")??0)+1;
    HMWorld.hm_shield_probe1105=_stamp;
    for(var _i=0;_i<_count;++_i) {
        var _item=_list[| _i];
        if(instance_exists(_item)) _item.hm_shield_probe1105=_stamp;
    }
    ds_list_destroy(_list);
    with(projectile) if((self[$ "hm_shield_probe1105"]??-1)==_stamp) array_push(_found,id);
    return _found;
}

// This one zero-argument renderer is refreshed for every wet actor at 30 Hz.
// Its generic initialization/ownership map stays authoritative; intervening
// frames and cleanup still use the same HMBinding Draw/EndStep events.
function scrHMSewerBindDraw1115() {
    var _binding=self[$ "hm_sewer_binding1115"]??noone;
    var _code=scrHMScriptRef(hm_maincode_mod_gml_sewerboi);
    var _map=self[$ "hm_draw_bindings109"]??undefined;
    var _key=instance_exists(_binding)?(_binding[$ "hm_sewer_key1115"]??""):"";
    if(!instance_exists(_binding) || _binding.object_index!=HMBinding || _binding.creator!=id
        || _binding.hm_code!=_code || !is_struct(_map) || _key=="" || (_map[$ _key]??noone)!=_binding) {
        _binding=scrHMBindDraw(hm_maincode_mod_gml_sewerboi,2-y/10000);
        _binding.hm_sewer_key1115=string(_code);
        hm_sewer_binding1115=_binding;
    } else {
        _binding.hm_refresh_tick=HMWorld.logic_serial;
        _binding.depth=2-y/10000;
        _binding.hm_menu_overlay=true;_binding.hm_draw=true;
        if(array_length(_binding.hm_args)!=0) _binding.hm_args=[];
    }
    return _binding;
}
