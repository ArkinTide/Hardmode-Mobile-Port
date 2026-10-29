// Hardmode 1.0.5: explicit host contracts, no changes to frozen MOD inputs.
function scrHMBackgroundColour105() {
    var _element=__background_get_colour_element();
    return _element[0]!=-1?layer_background_get_blend(_element[0]):c_black;
}
function scrHMRavenAim105() {
    if(!instance_exists(target)) return;
    if(flying) {
        // Commit the slam when close, rather than chasing a moving target
        // forever at an asymptotic distance greater than the landing radius.
        if((self[$ "hm_flight_locked"]??false)) return;
        if(point_distance(x,y,target.x,target.y)<64 || (self[$ "hm_flight_age"]??0)>=90) hm_flight_locked=true;
    }
    flight_x=target.x;flight_y=target.y;
}

function scrHMSwimPlayer105() {
    if(!scrHMEnabled() || !instance_exists(GameCont) || !instance_exists(HMWorld) || instance_exists(GenCont)) return;
    if(GameCont.area!=scrHMAreaResolve("sewers") && GameCont.area!=102) return;
    if(self[$ "hm_portrait_frozen"]??false) return;
    var _water=scrHMWaterAt(x,y) && !instance_exists(SpiralCont) && distance_to_object(Portal)>32;
    var _was=self[$ "swimming"]??false;
    if(!_water) {
        if(_was) {scrHMSwimLeave();scrHMSoundPitchVolume(sndSewerDrip,1,.22);}
        return;
    }
    if(!_was) {
        hm_swim_fly=self[$ "canfly"]??false;hm_swim_alpha=image_alpha;shd_=spr_shadow;
        swimming=true;canfly=true;image_alpha=0;spr_shadow=mskNone;
        scrHMWaterEntrySound();
    }
    var _bind=scrHMBindDraw(hm_maincode_mod_gml_sewerboi,2-y/10000);_bind.creator=id;
}

function scrHMSwimSpeed105() {
    if(!scrHMEnabled() || !(self[$ "swimming"]??false) || (self[$ "hm_portrait_frozen"]??false)) return;
    // The imported cave floor's high friction must not stack with swimming.
    // Compensate the engine's subsequent friction to get 2 px / logic tick
    // at both supported rates, instead of nearly stopping at 30 FPS.
    friction=.45*timescale*timescale;
    speed=min(speed,2*timescale+friction);
}

function scrHMInteriorEdge105() {return scrHMPlainWall106();}
function scrHMInteriorEdge105Legacy() {
    // Newly exposed fill cells rejoin the same two-layer textured boundary.
    if(!(self[$ "hm_interior_wall"]??false)) return false;
    return collision_rectangle(x-32,y-32,x+47,y+47,Floor,false,true)==noone;
}

function scrHMFindGround105(_x,_y) {
    var _best=1000000000000,_xx=_x,_yy=_y,_found=false,_who=id;
    with(Floor) {
        var _size=object_index==FloorExplo?16:32;
        var _cx=x+_size/2,_cy=y+_size/2,_d=point_distance(_cx,_cy,_x,_y);
        if(_d>=_best) continue;
        with(_who) if(!place_meeting(_cx,_cy,Wall)) {_best=_d;_xx=_cx;_yy=_cy;_found=true;}
    }
    return [_found,_xx,_yy];
}

function scrHMRavenLand105() {
    if(!scrHMEnabled()) return;
    if(place_meeting(x,y,Wall) || !position_meeting(x,y,Floor)) {
        var _ground=scrHMFindGround105(x,y);
        if(_ground[0]) {x=_ground[1];y=_ground[2];speed=0;}
    }
}

function scrHMAuthoredWalls105() {
    var _walls=[];
    with(Wall) if(!(self[$ "hm_interior_wall"]??false)) array_push(_walls,id);
    return _walls;
}

function scrHMNearestAuthoredWall105(_x,_y) {
    var _nearest=noone,_distance=1000000000000;
    with(Wall) if(!(self[$ "hm_interior_wall"]??false)) {
        var _d=point_distance(x,y,_x,_y);
        if(_d<_distance) {_distance=_d;_nearest=id;}
    }
    return _nearest;
}

function scrHMPalaceGenerator105(_x,_y) {
    // Sprite masks can exclude the origin, so position_meeting at the
    // intended origin does not reliably find an existing generator there.
    var _present=false;
    with(SmallGenerator) if(x==_x && y==_y) {_present=true;break;}
    if(!_present) instance_create(_x,_y,SmallGenerator);
}

function scrHMDrawHooks105(_gui) {
    var _font=draw_get_font(),_color=draw_get_color(),_alpha=draw_get_alpha();
    var _halign=draw_get_halign(),_valign=draw_get_valign();
    if(_gui) scrHMHook("draw_gui");
    else {scrHMHook("draw");if(UberCont.paused) scrHMHook("draw_pause");}
    draw_set_font(_font);draw_set_color(_color);draw_set_alpha(_alpha);
    draw_set_halign(_halign);draw_set_valign(_valign);
}

function scrHMCarveFill105(_size) {scrHMCarveFill106(_size);}
function scrHMCarveFill105Legacy(_size) {
    if(!scrHMEnabled() || !instance_exists(HMWorld)) return;
    var _walls=ds_list_create();
    collision_rectangle_list(x,y,x+_size-1,y+_size-1,Wall,false,true,_walls,false);
    for(var _i=0;_i<ds_list_size(_walls);++_i) with(_walls[| _i])
        if(self[$ "hm_interior_wall"]??false) instance_destroy(id,false);
    ds_list_destroy(_walls);
    HMWorld.hm_water_map=undefined;
}

function scrHMBigDogShots105() {
    var _boss=id;
    with(EnemyBullet1) if(creator==_boss) {
        var _source=id,_speed=speed,_direction=direction,_creator=creator,_team=team,_hitid=hitid;
        var _shot=instance_create(x,y,LHBouncer);
        with(_shot) {
            bounce=true;hm_bigdog_bullet=true;rot=0;
            sprite_index=sprEnemyBullet1;mask_index=mskEnemyBullet1;
            creator=_creator;team=_team;speed=_speed;direction=_direction;hitid=_hitid;
            image_angle=direction;image_blend=merge_color(image_blend,c_red,.2);
            if(random(5)<1) instance_destroy();
        }
        with(_source) {instance_change(Wind,false);instance_destroy();}
    }
}
