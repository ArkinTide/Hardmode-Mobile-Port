// Hardmode's custom area IDs are not base-game secret area numbers.
function scrHMRoutePosition109(_area,_sub,_previous=0) {
    static _main=[
        [1,0,3],["nightdesert",3,1],["scorpionboss",4,1],
        ["sewers",5,3],["junkyard",8,5],["ravenboss",10,1],["bigdog",12,1],
        ["caves",13,3],["city",16,5],["labs",21,2],["elevator",23,1],
        ["palace",24,4],["throne",28,1],["end",28,1]
    ];
    for(var _i=0;_i<array_length(_main);++_i) {
        var _entry=_main[_i];
        if(_area==scrHMAreaResolve(_entry[0])) return [_entry[1]+clamp(_sub-1,0,_entry[2]-1),0];
    }
    if(_area>=1 && _area<=7) {
        static _starts=[0,5,8,13,16,21,24],_lengths=[3,3,2,3,5,2,4];
        return [_starts[_area-1]+clamp(_sub-1,0,_lengths[_area-1]-1),0];
    }
    if(_area==scrHMAreaResolve("cavesinv") || _area==scrHMAreaResolve("icecave")) return [13+clamp(_sub-1,0,2),1];
    if(_area==scrHMAreaResolve("oasis")) return [4,1];
    if(_area==scrHMAreaResolve("jungle")) return [8,1];
    if(_area==scrHMAreaResolve("turtles")) return [6,1];
    // Crown, HQ and Venus are branches of the actual previous main waypoint.
    return [_previous,1];
}

function scrHMRoadmap109(_x,_y,_pos) {
    var _ha=draw_get_halign(),_va=draw_get_valign(),_color=draw_get_color();
    draw_set_color(c_white);draw_align(fa_left,fa_middle);
    draw_sprite(sprScoreSplat,2,_x-68,_y-15);draw_sprite(sprScoreSplat,2,_x+8,_y-15);
    draw_sprite(sprKillsIcon,0,_x+14,_y-15);
    draw_text_nt(_x-60,_y-14,scrAreaGetMapName(GameCont.area,GameCont.subarea,GameCont.loops));
    draw_text_nt(_x+23,_y-14,string(GameCont.kills));
    var _left=_x-126,_lengths=[5,3,5,3,5,3,5],_base=0;
    for(var _i=0;_i<7;++_i) {
        var _bx=_left+_base*9;_base+=_lengths[_i];
        draw_line_pixelated(_bx+1,_y+1,_left+min(_base,28)*9+1,_y+1,c_black,1);
        draw_line_pixelated(_bx+1,_y,_left+min(_base,28)*9+1,_y,c_white,1);
        draw_sprite_ext(sprMapDot,0,_bx,_y+1,1,1,0,c_white,1);
    }
    draw_sprite_ext(sprMapCrown,0,_left+28*9-3,_y+1,1,1,0,c_white,1);
    var _px=_left,_py=_y,_lastloop=-1,_previous=0;
    for(var _n=0;_n<min(_pos,GameCont.waypoints);++_n) {
        var _loop=GameCont.waylps[_n];
        if(_loop!=_lastloop) {_px=_left;_py=_y;_previous=0;_lastloop=_loop;}
        var _position=scrHMRoutePosition109(GameCont.waypnt[_n],GameCont.waysub[_n],_previous);
        var _nx=_left+_position[0]*9,_ny=_y+_position[1]*10;
        var _c=make_color_hsv((_loop*39) mod 255,200,200);
        draw_line_pixelated(_px+1,_py+1,_nx+1,_ny+1,c_black,1);
        draw_line_pixelated(_px+1,_py,_nx+1,_ny,_c,1);
        draw_sprite_ext(_position[1]?sprMapDotOut:sprMapDot,0,_nx,_ny+1,1,1,0,_c,1);
        _px=_nx;_py=_ny;if(!_position[1]) _previous=_position[0];
    }
    for(var _i=0;_i<player_count;++_i) {
        var _p=scr_playerinstance_find(_i);if(is_undefined(_p)) continue;
        var _sprite=sprMapIcon,_image=scr_race_get_skin_subimage(_p.get_race(),_p.get_skin());
        if(_p.is_race(Race.Chicken)&&_p.hp<=0) {_sprite=sprMapIconChickenHeadless;_image=_p.get_skin();}
        draw_sprite(_sprite,_image,_px+(_i mod 2)*3,_py+(_i div 2)*3);
    }
    draw_set_color(_color);draw_align(_ha,_va);
}
