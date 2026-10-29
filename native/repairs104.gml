// Explicit host contracts for Hardmode 1.0.4.
function scrHMTitankHealth() {
    if(!(self[$ "hm_feet_ready"]??false) || hp<0) return;
    var _alive=0;
    for(var _i=0;_i<legs;++_i) {
        var _foot=hm_feet[_i];
        var _health=instance_exists(_foot)?max(0,_foot.hp):0;
        foot_hp[_i]=_health;
        if(_health>0) _alive++;
    }
    hp=_alive;
}

function scrHMUnlockArea(_area) {
    if(!scrHMEnabled()) return _area;
    switch(scrHMAreaKey(_area)) {
        case "area:sewers": return area_sewers;
        case "area:turtles": return area_pizza_sewers;
        case "area:ravenboss": case "area:junkyard": return area_scrapyards;
        case "area:caves": return area_caves;
        case "area:cavesinv": return area_cursed_caves;
        case "area:city": return area_city;
        case "area:labs": return area_labs;
        case "area:jungle": return area_jungle;
        case "area:HQ": return area_hq;
        case "area:palace": return area_palace;
        case "area:nightdesert": return area_desert;
    }
    return _area;
}

function scrHMManholeCreate(_x,_y) {
    var _lid=instance_create(_x,_y,PizzaEntrance);
    // Floor tiles have varying fractional depths after the ten-tick bank
    // setup. Keep the lid over both dry floors and the water top overlay.
    _lid.depth=1;
    return _lid;
}

function scrHMWaterKey(_x,_y) {return string(floor(_x/16))+","+string(floor(_y/16));}

function scrHMWaterMap() {
    var _map={};
    with(Floor) if(traction==2) {
        for(var _xx=x;_xx<x+32;_xx+=16) for(var _yy=y;_yy<y+32;_yy+=16)
            _map[$ scrHMWaterKey(_xx,_yy)]=true;
    }
    // Newly broken banks can overlap a former water cell. Dry, walkable
    // collision tiles take precedence; decorative 40px water caps do not.
    with(Floor) if(traction!=2) {
        var _width=(object_index==FloorExplo)?16:32;
        for(var _xx=x;_xx<x+_width;_xx+=16) for(var _yy=y;_yy<y+_width;_yy+=16)
            _map[$ scrHMWaterKey(_xx,_yy)]=false;
    }
    HMWorld.hm_water_map=_map;
    HMWorld.hm_water_floors=instance_number(Floor);
}

function scrHMWaterAt(_x,_y) {
    if(is_undefined(variable_instance_get(HMWorld,"hm_water_map")) || (variable_instance_get(HMWorld,"hm_water_floors")??-1)!=instance_number(Floor)) scrHMWaterMap();
    return HMWorld.hm_water_map[$ scrHMWaterKey(_x,_y)]??false;
}

function scrHMSwimLeave() {
    swimming=false;
    canfly=self[$ "hm_swim_fly"]??false;
    image_alpha=self[$ "hm_swim_alpha"]??1;
    spr_shadow=self[$ "shd_"]??shd12;
}

function scrHMSewerTick() {
    if(!instance_exists(Player)) {
        with(hitme) if(self[$ "swimming"]??false) scrHMSwimLeave();
        return;
    }
    // Constant-time water membership replaces all nearest-Floor/CustomObject
    // searches. Only the feet point counts, so a body overlapping the bank
    // cannot keep an entity swimming on dry ground.
    if(is_undefined(variable_instance_get(HMWorld,"hm_water_map")) || (variable_instance_get(HMWorld,"hm_water_floors")??-1)!=instance_number(Floor)) scrHMWaterMap();
    var _player=instance_nearest(x,y,Player),_map=HMWorld.hm_water_map;
    with(hitme) {
        if(self[$ "hm_portrait_frozen"]??false) continue;
        var _was=self[$ "swimming"]??false;
        if(!_was && (!variable_instance_exists(id,"right") || object_index==FireBaller || object_index==SuperFireBaller)) continue;
        var _near=point_distance(x,y,_player.x,_player.y)<view_width;
        var _water=(_map[$ scrHMWaterKey(x,y)]??false) && !instance_exists(SpiralCont);
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
        } else if(object_index!=CustomEnemy && speed>timescale) speed=timescale;
        if(random(32)<1 && object_index!=Player) direction=choose(0,90,180,270);
        if(speed>.4*timescale && HMWorld.logic_serial mod 4==0 && instance_number(Wind)<80) {
            with(instance_create(x,y-4,Wind)) {sprite_index=global.hm_module_vars[$ "mod:maincode"].ripple;depth=2;image_xscale=choose(-1,1);}
        }
        var _bind=scrHMBindDraw(hm_maincode_mod_gml_sewerboi,2-y/10000);
        _bind.creator=id;
    }
    with(Crab) friction=.8*timescale*timescale;
    // A handful of visible water specks, rather than a full floor scan plus
    // particles per cell on every simulation tick.
    if(HMWorld.logic_serial mod 4==0) repeat(3) {
        var _xx=_player.x+random_range(-view_width/2,view_width/2),_yy=_player.y+random_range(-view_height/2,view_height/2);
        if(_map[$ scrHMWaterKey(_xx,_yy)]??false) with(instance_create(_xx,_yy,RadEat)) image_angle=random(360);
    }
    if(HMWorld.logic_serial mod 4==0) with(Corpse) if(image_alpha>0 && (_map[$ scrHMWaterKey(x,y)]??false)) image_alpha=max(0,image_alpha-.04);
}

function scrHMWallFillBegin() {
    if(!scrHMEnabled() || !instance_exists(Floor)) return;
    var _seed=instance_nearest(10016,10016,Floor);
    var _left=_seed.x,_right=_seed.x+32,_top=_seed.y,_bottom=_seed.y+32;
    // The gameplay map lives around (10000,10000), outside the nominal
    // GameMaker room dimensions. Exclude the distant menu diorama by
    // growing the connected level bounds from the actual spawn floor.
    var _changed=true;
    while(_changed) {
        _changed=false;
        with(Floor) if(x<=_right+32 && x+32>=_left-32 && y<=_bottom+32 && y+32>=_top-32) {
            var _l=min(_left,x),_r=max(_right,x+32),_t=min(_top,y),_b=max(_bottom,y+32);
            if(_l!=_left||_r!=_right||_t!=_top||_b!=_bottom) _changed=true;
            _left=_l;_right=_r;_top=_t;_bottom=_b;
        }
    }
    // Static cells have no Step/Draw work. Populate during generation in
    // bounded batches; keep ordinary Wall identity for native collisions,
    // explosions and the MOD's authored wall-spawn enemies.
    hm_fill_left=floor((_left-256)/16)*16;hm_fill_right=ceil((_right+256)/16)*16;
    hm_fill_y=floor((_top-256)/16)*16;hm_fill_bottom=ceil((_bottom+256)/16)*16;
    hm_fill_x=hm_fill_left;hm_fill_active=true;
}

function scrHMWallFillStep() {
    if(!(self[$ "hm_fill_active"]??false)) return true;
    repeat(512) {
        var _xx=hm_fill_x,_yy=hm_fill_y;
        if(!position_meeting(_xx+8,_yy+8,Floor) && !position_meeting(_xx+8,_yy+8,Wall)) {
            with(instance_create(_xx,_yy,Wall)) {visible=false;hm_interior_wall=true;}
        }
        hm_fill_x+=16;
        if(hm_fill_x>=hm_fill_right) {hm_fill_x=hm_fill_left;hm_fill_y+=16;}
        if(hm_fill_y>=hm_fill_bottom) {hm_fill_active=false;return true;}
    }
    return false;
}

function scrHMWallBreakUpdate104() {
    var _walls=ds_list_create(),_cx=x,_cy=y;
    collision_rectangle_list(x-48,y-48,x+48,y+48,Wall,false,false,_walls,false);
    for(var _i=0;_i<ds_list_size(_walls);++_i) with(_walls[| _i]) {
        if(point_distance(x,y,_cx,_cy)>32) continue;
        if(position_meeting(x,y,FloorExplo)) {instance_destroy();continue;}
        visible=place_meeting(x,y+16,Floor);
        if(place_free(x-16,y)) l=0; else l=4;
        if(place_free(x+16,y)) w=24-l; else w=20-l;
        if(place_free(x,y-16)) r=0; else r=4;
        if(place_free(x,y+16)) h=24-r; else h=20-r;
    }
    ds_list_destroy(_walls);
}

function scrHMWallThemeStart(_origin) {
    if(!instance_exists(_origin)) return;
    var _queue=[],_ox=_origin.x,_oy=_origin.y,_tick=HMWorld.logic_serial;
    with(Wall) array_push(_queue,[id,_tick+ceil(point_distance(x,y,_ox,_oy)/8),false]);
    with(TopSmall) array_push(_queue,[id,_tick+ceil(point_distance(x,y,_ox,_oy)/8),true]);
    array_sort(_queue,function(_a,_b){return _a[1]-_b[1];});
    HMWorld.hm_wall_theme_queue=_queue;HMWorld.hm_wall_theme_index=0;
}

function scrHMWallThemeTick() {
    var _queue=self[$ "hm_wall_theme_queue"]??[],_index=self[$ "hm_wall_theme_index"]??0;
    if(_index>=array_length(_queue)) return;
    repeat(256) {
        var _item=_queue[_index];
        if(_item[1]>logic_serial) break;
        if(instance_exists(_item[0])) with(_item[0]) {
            if(_item[2]) sprite_index=scrHMAssetIndex("sprWall"+string(GameCont.area)+"Trans");
            else {
                sprite_index=scrHMAssetIndex("sprWall"+string(GameCont.area)+"Bot");
                topspr=scrHMAssetIndex("sprWall"+string(GameCont.area)+"Top");
                outspr=scrHMAssetIndex("sprWall"+string(GameCont.area)+"Out");
            }
        }
        _index++;
        if(_index>=array_length(_queue)) break;
    }
    hm_wall_theme_index=_index;
    if(_index>=array_length(_queue)) hm_wall_theme_queue=[];
}

function scrHMBossFreeze104() {
    var _intro=noone;
    with(CustomObject) if(name=="bossintro") {_intro=id;break;}
    if(!instance_exists(_intro) || variable_instance_exists(_intro,"hm_portrait_records")) return;
    var _records=[],_fields=["alrm0","alrm1","alrm2","alrm3","alrm4","walk"];
    var _actors=scrHMInstances([hitme,projectile,RavenFly]);
    for(var _actor=0;_actor<array_length(_actors);++_actor) with(_actors[_actor]) {
        var _timers=[];
        for(var _i=0;_i<12;++_i) {array_push(_timers,alarm[_i]);alarm[_i]=-1;}
        var _values={};
        for(var _i=0;_i<array_length(_fields);++_i) {
            var _key=_fields[_i],_value=self[$ _key];
            if(!is_undefined(_value)) {_values[$ _key]=_value;self[$ _key]=-1;}
        }
        array_push(_records,{who:id,timers:_timers,values:_values,speed:speed,direction:direction,
            anim:image_speed,was_frozen:self[$ "frozen"]??false});
        speed=0;image_speed=0;frozen=true;hm_portrait_frozen=true;
    }
    _intro.hm_portrait_records=_records;
    // Explicitly retain the intro instance rather than relying on the
    // physical GML 'other' across the script/coroutine call boundary.
    with(Player) global.hm_camera_targets[index]=_intro;
}

function scrHMBossRestore104() {
    var _records=self[$ "hm_portrait_records"]??[];
    for(var _i=0;_i<array_length(_records);++_i) {
        var _record=_records[_i];
        if(!instance_exists(_record.who)) continue;
        with(_record.who) {
            for(var _j=0;_j<12;++_j) alarm[_j]=_record.timers[_j];
            var _keys=variable_struct_get_names(_record.values);
            for(var _j=0;_j<array_length(_keys);++_j) self[$ _keys[_j]]=_record.values[$ _keys[_j]];
            speed=_record.speed;direction=_record.direction;image_speed=_record.anim;
            frozen=_record.was_frozen;hm_portrait_frozen=false;
        }
    }
    hm_portrait_records=[];
    with(Player) {
        can_walk=true;can_pick=(race!=Race.BigDog);can_spec=true;can_swap=true;can_aim=true;
        if(variable_instance_exists(id,"_mask")) mask_index=_mask;
        if(variable_instance_exists(id,"_reload")) reload=_reload;
        if(variable_instance_exists(id,"_breload")) breload=_breload;
        global.hm_camera_targets[index]=id;
    }
}

function scrHMBossStep104() {
    if(bosssplat<2) bosssplat=min(2,bosssplat+.4);
    if(bossx>view_width*.60) bossx-=view_width/24;
    else if(bossx>=view_width*.33) bossx-=view_width/180;
    else {bossx-=view_width/6;letterind=max(0,letterind-1);}
    if(bossx<view_width*.33 || instance_exists(SpiralCont) || !instance_exists(Player)) {
        scrHMBossRestore104();
        if(fadedark==1) scrHMSoundPlay(sndBossIntroOut);
        instance_destroy();
    }
}
