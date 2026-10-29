// Compact collision-only fill. Ordinary authored boundary tiles retain
// their masks, decoration and original MOD placement semantics.
function scrHMFillBlock106(_x,_y,_w,_h) {
    var _wall=instance_create(_x,_y,Wall);
    with(_wall) {
        visible=false;hm_interior_wall=true;
        hm_fill_w106=_w;hm_fill_h106=_h;
        image_xscale=_w/16;image_yscale=_h/16;
        hm_plain106=(_w>16||_h>16)||collision_rectangle(x-32,y-32,x+47,y+47,Floor,false,true)==noone;
    }
    return _wall;
}

function scrHMFillStep106() {
    if(!(self[$ "hm_fill_active"]??false)) return true;
    if(is_undefined(self[$ "hm_fill_taken106"])) hm_fill_taken106={};
    var _venuz=GameCont.area==scrHMAreaResolve("venuz");
    repeat(512) {
        var _xx=hm_fill_x,_yy=hm_fill_y,_key=string(_xx)+","+string(_yy);
        if(!(hm_fill_taken106[$ _key]??false) && !position_meeting(_xx+8,_yy+8,Floor) && !position_meeting(_xx+8,_yy+8,Wall)
            && (!_venuz || (!position_meeting(_xx+8,_yy+8,InvisiWall) && !position_meeting(_xx+8,_yy+8,DustOLD)))) {
            var _size=16;
            for(var _candidate=64;_candidate>=32;_candidate/=2) {
                if(_xx+_candidate>hm_fill_right || _yy+_candidate>hm_fill_bottom) continue;
                if(collision_rectangle(_xx-32,_yy-32,_xx+_candidate+31,_yy+_candidate+31,Floor,false,false)!=noone) continue;
                if(collision_rectangle(_xx,_yy,_xx+_candidate-1,_yy+_candidate-1,Wall,false,false)!=noone) continue;
                if(_venuz && (collision_rectangle(_xx,_yy,_xx+_candidate-1,_yy+_candidate-1,InvisiWall,false,false)!=noone
                    || collision_rectangle(_xx,_yy,_xx+_candidate-1,_yy+_candidate-1,DustOLD,false,false)!=noone)) continue;
                _size=_candidate;break;
            }
            scrHMFillBlock106(_xx,_yy,_size,_size);
            for(var _dx=0;_dx<_size;_dx+=16) for(var _dy=0;_dy<_size;_dy+=16)
                hm_fill_taken106[$ string(_xx+_dx)+","+string(_yy+_dy)]=true;
        }
        hm_fill_x+=16;
        if(hm_fill_x>=hm_fill_right) {hm_fill_x=hm_fill_left;hm_fill_y+=16;}
        if(hm_fill_y>=hm_fill_bottom) {hm_fill_active=false;hm_fill_taken106=undefined;return true;}
    }
    return false;
}

// Venus elevators rebuild their authored map inside the same room, bypassing
// GenCont. Reapply compact exterior collision after their deferred floor
// spawners have settled; the doors still create/carve their own floor cells.
function scrHMVenusTerrain106() {
    if(!instance_exists(GameCont) || instance_exists(GenCont)) return;
    if(GameCont.area!=scrHMAreaResolve("venuz")) {hm_venus_sub106=-999;hm_venus_fill106=false;return;}
    if((self[$ "hm_venus_sub106"]??-999)!=GameCont.subarea) {
        hm_venus_sub106=GameCont.subarea;hm_venus_pending106=3;hm_venus_fill106=false;
    }
    if(hm_venus_pending106>0) {
        hm_venus_pending106--;
        if(hm_venus_pending106>0) return;
        var _existing=false;with(Wall) if(self[$ "hm_interior_wall"]??false) {_existing=true;break;}
        if(_existing) return;
        scrHMWallFillBegin();hm_fill_taken106=undefined;hm_venus_fill106=true;
    }
    if(self[$ "hm_venus_fill106"]??false) if(scrHMFillStep106()) hm_venus_fill106=false;
}

function scrHMVenusAutoExit106() {
    if(instance_exists(GenCont)) return false;
    // Door-zero actors are materialized after generation. They must count
    // as pending combat, otherwise the empty-enemy check skips this map.
    var _blocked=false;
    with(CustomObject) {
        if(name=="VenuzElevator" || ((self[$ "Spawner"]??false)
            && array_contains(["prisoner","Molefish","Molesarge","Minigunner","Jock","Charger","FireBaller","SuperFireBaller","Turtle"],name))) {
            _blocked=true;break;
        }
    }
    return !_blocked;
}

function scrHMFillSplit106(_wall) {
    var _cells=[];
    if(!instance_exists(_wall)) return _cells;
    var _w=_wall[$ "hm_fill_w106"]??16,_h=_wall[$ "hm_fill_h106"]??16;
    if(_w==16&&_h==16) return [_wall];
    var _x=_wall.x,_y=_wall.y,_top=_wall.topspr,_out=_wall.outspr,_spr=_wall.sprite_index,_blend=_wall.image_blend;
    instance_destroy(_wall,false);
    for(var _dx=0;_dx<_w;_dx+=16) for(var _dy=0;_dy<_h;_dy+=16) {
        var _cell=scrHMFillBlock106(_x+_dx,_y+_dy,16,16);
        // During/after the cave conversion, newly exposed cells inherit
        // the destination theme. Their former packed parent's queue entry
        // may already have been consumed or be destroyed by this split.
        if((variable_instance_get(HMWorld,"hm_wall_theme_area106")??-999)!=GameCont.area) {
            _cell.topspr=_top;_cell.outspr=_out;_cell.sprite_index=_spr;
        }
        _cell.image_blend=_blend;
        array_push(_cells,_cell);
    }
    return _cells;
}

function scrHMCarveFill106(_size) {
    if(!scrHMEnabled() || !instance_exists(HMWorld)) return;
    var _list=ds_list_create(),_x=x,_y=y;
    // Materialize only the newly exposed two-layer neighbourhood. Deep
    // collision stays compact and never acquires decorative tile renderers.
    collision_rectangle_list(x-32,y-32,x+_size+31,y+_size+31,Wall,false,true,_list,false);
    var _cells=[];
    for(var _i=0;_i<ds_list_size(_list);++_i) {
        var _wall=_list[| _i];
        if(!(_wall[$ "hm_interior_wall"]??false)) continue;
        var _split=scrHMFillSplit106(_wall);
        for(var _j=0;_j<array_length(_split);++_j) array_push(_cells,_split[_j]);
    }
    ds_list_destroy(_list);
    for(var _i=0;_i<array_length(_cells);++_i) with(_cells[_i]) {
        if(x>=_x&&x<_x+_size&&y>=_y&&y<_y+_size) instance_destroy(id,false);
        else hm_plain106=collision_rectangle(x-32,y-32,x+47,y+47,Floor,false,true)==noone;
    }
    HMWorld.hm_water_map=undefined;
}

function scrHMDestroyFill106(_wall) {
    if(!scrHMEnabled() || !(_wall[$ "hm_interior_wall"]??false)
        || ((_wall[$ "hm_fill_w106"]??16)==16 && (_wall[$ "hm_fill_h106"]??16)==16)) return false;
    var _cause=id;
    if(_cause==_wall && instance_exists(other)) _cause=other.id;
    var _cx=_cause.x,_cy=_cause.y,_cause_live=(_cause!=_wall);
    var _cells=scrHMFillSplit106(_wall),_hit=false,_nearest=noone,_distance=1000000000;
    for(var _i=0;_i<array_length(_cells);++_i) {
        var _c=_cells[_i];
        if(!instance_exists(_c)) continue;
        var _d=point_distance(_c.x+8,_c.y+8,_cx,_cy);
        if(_d<_distance) {_distance=_d;_nearest=_c;}
        if(_cause_live && collision_rectangle(_c.x,_c.y,_c.x+15,_c.y+15,_cause,false,false)!=noone) {
            _hit=true;scrWallDestroy(_c);
        }
    }
    if(!_hit&&instance_exists(_nearest)) scrWallDestroy(_nearest);
    return true;
}

function scrHMPlainWall106() {
    if(!(self[$ "hm_interior_wall"]??false)) return false;
    return self[$ "hm_plain106"]??true;
}

function scrHMDrawPlainWall106() {
    var _color=draw_get_color(),_alpha=draw_get_alpha();
    var _base=scrHMWallColour106(topspr);
    draw_set_color(make_color_rgb(color_get_red(_base)*color_get_red(image_blend)/255,
        color_get_green(_base)*color_get_green(image_blend)/255,color_get_blue(_base)*color_get_blue(image_blend)/255));
    draw_set_alpha(image_alpha);
    draw_rectangle(x,y-8,x+(self[$ "hm_fill_w106"]??16),y+(self[$ "hm_fill_h106"]??16)-8,false);
    draw_set_color(_color);draw_set_alpha(_alpha);
}

function scrHMSwimSprite106() {
    if(sprite_exists(sprite_index) && sprite_get_width(sprite_index)>0 && sprite_get_height(sprite_index)>0) return true;
    // Player animation can temporarily use mskNone/-1 while hidden in a
    // cutscene; only restore a genuine actor idle sprite when it is valid.
    var _idle=self[$ "spr_idle"]??-1;
    if(sprite_exists(_idle) && _idle!=mskNone) {sprite_index=_idle;return true;}
    return false;
}

function scrHMThroneSeed106() {
    var _found=false;with(Floor) if(self[$ "nokill"]??false) {_found=true;break;}
    if(!_found) {
        var _seed=instance_nearest(10000,10000,Floor);
        if(instance_exists(_seed)) _seed.nokill=1;
    }
}

function scrHMSnowBandit106() {
    if(GameCont.area!=scrHMAreaResolve("city") && GameCont.area!=scrHMAreaResolve("icecave") && GameCont.area!=scrHMAreaResolve("noyetihere")) return;
    spr_idle=sprSnowBanditIdle;spr_walk=sprSnowBanditWalk;spr_hurt=sprSnowBanditHurt;spr_dead=sprSnowBanditDead;
    sprite_index=spr_idle;hitid=[sprSnowBanditIdle,"Bandit"];
}

function scrHMCarPrepare106() {
    with(Player) {
        if(is_undefined(self[$ "pla_msk"])) pla_msk=mask_index>=0?mask_index:mskPlayer;
        if(is_undefined(self[$ "pla_shd"])) pla_shd=spr_shadow;
    }
}

// Loadout choices can survive imports/older builds. Validate both dimensions
// before a legacy two-dimensional crown array read, including custom mode.
function scrHMCrownLoadoutValid106(_race,_crown) {
    if(!is_numeric(_race)||!is_numeric(_crown)) return false;
    if(_race!=floor(_race)||_crown!=floor(_crown)||_race<0||_crown<0||_crown>crownmax) return false;
    with(UberCont) {
        if(_race>=array_length(cgot)||_race>=array_length(crowngot)) return false;
        var _row=crowngot[_race];
        return is_array(_row)&&_crown<array_length(_row);
    }
    return false;
}

function scrHMSewerBank106(_wall) {
    if(!instance_exists(_wall)) return;
    // A packed wall can materialize several floor cells. Mark the creation
    // itself instead of looking for a floor at the former block's origin.
    var _previous=variable_global_exists("hm_sewer_bank106")?global.hm_sewer_bank106:false;
    global.hm_sewer_bank106=true;
    scrWallDestroy(_wall);
    global.hm_sewer_bank106=_previous;
}
