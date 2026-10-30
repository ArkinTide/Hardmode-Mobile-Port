// Hardmode 1.0.8. All gameplay still runs at the original 30 Hz.
function scrHMSkipBossPresentation108(_name,_focus) {
    if(!scrHMEnabled()) return false;
    if(instance_exists(_focus) && (_focus[$ "name"]??"")=="IDPDTank") return true;
    // Disable portraits after looping; preserve essential blank-name pans.
    return instance_exists(GameCont) && GameCont.loops>0 && _name!="";
}

function scrHMTankRadiation108() {
    // This is a base drop. Preserve radiation absorbed after initialization
    // and the user's pre-cap -4 / post-cap original-drop policy.
    var _base=GameCont.loops>=3?70:0;
    raddrop+=_base-(self[$ "hm_tank_base108"]??0);
    hm_tank_base108=_base;
}

function scrHMTankAim108() {
    // Track slowly during the early charge, then lock for the final 0.75 s.
    // The warning and the real ray use the same locked direction.
    if(charge<1.05 && instance_exists(creator))
        aim-=clamp(angle_difference(aim,creator.gunangle),-1.5,1.5);
}

function scrHMPoliceSpawn108(_x,_y) {
    if(!scrHMEnabled() || GameCont.loops<3 || random(1)>=.5)
        return instance_create(_x,_y,PopoFreak);
    // Half of late-loop arrivals are regular/elite police, independently
    // of their later revival. Native police Destroy owns that timer.
    return instance_create(_x,_y,choose(Grunt,Inspector,Shielder,EliteGrunt,EliteInspector,EliteShielder));
}

function scrHMVanCrater108() {
    // Called on the source's single scorch Effect. Reuse it as one small
    // crater, and add two separated peers; no full-screen 3x scorch.
    image_xscale=1;image_yscale=1;
    hm_van_crater108=true;
    for(var _i=0;_i<2;++_i) with(instance_create(x+(_i==0?-16:16),y+(_i==0?6:-6),Effect)) {
        sprite_index=sprScorch;image_xscale=1;image_yscale=1;hm_van_crater108=true;
    }
}

function scrHMPortalEntry108() {
    if(!scrHMEnabled() || close || !instance_exists(Player) || instance_exists(BigPortal)
        || !scrHMModExists("mod","options","portals") || scrHMModGet("mod","options","portals")!="1") return;
    if(sprite_index!=sprPortal && sprite_index!=sprProtoPortal && sprite_index!=sprPopoPortal) return;
    var _portal=id;
    with(Player) if(point_distance(x,y,_portal.x,_portal.y)<=24
        && collision_line(x,y,_portal.x,_portal.y,Wall,false,true)==noone) {
        // Use the native entry event at b24's commit radius. Waiting for a
        // smaller sprite overlap left a disabled player stuck at the rim.
        with(_portal) event_perform(ev_collision,Player);
    }
}

function scrHMTopAllowed108() {
    if(position_meeting(x,y,Floor) || collision_point(x+8,y+8,TopSmall,false,true)!=noone) return false;
    var _wall=collision_point(x+8,y+8,Wall,false,true);
    return !instance_exists(_wall) || (_wall[$ "hm_interior_wall"]??false);
}

function scrHMWallTransitions108(_left=-100000000,_top=-100000000,_right=100000000,_bottom=100000000) {
    if(!scrHMEnabled()) return;
    var _edges=[];
    with(Wall) if(!scrHMPlainWall106() && x>=_left && x<=_right && y>=_top && y<=_bottom)
        array_push(_edges,id);
    for(var _i=0;_i<array_length(_edges);++_i) with(_edges[_i]) {
        var _source=id;
        for(var _dx=-16;_dx<=16;_dx+=16) for(var _dy=-16;_dy<=16;_dy+=16) {
            if(_dx==0&&_dy==0) continue;
            var _wx=x+_dx,_wy=y+_dy,_cell=collision_point(_wx+8,_wy+8,Wall,false,true);
            if(!instance_exists(_cell) || !(_cell[$ "hm_interior_wall"]??false)) continue;
            var _plain=false;with(_cell) _plain=scrHMPlainWall106();
            if(!_plain) continue;
            if(collision_point(_wx+8,_wy+8,TopSmall,false,false)!=noone || position_meeting(_wx,_wy,Floor)) continue;
            with(instance_create(_wx,_wy,TopSmall)) image_blend=_source.image_blend;
        }
    }
}

function scrHMVenusCleanup108() {
    // Original elevator has already removed its old floor, walls, props,
    // enemies and effects here. Delete host-only leftovers before new area
    // construction, including non-drawing solid door masks and dead draws.
    instance_destroy(DustOLD,false);instance_destroy(WepPickup,false);
    instance_destroy(TopPot,false);instance_destroy(HMBinding,false);
    instance_destroy(WantRevivePopoFreak,false);instance_destroy(RevivePopoFreak,false);
    // These camouflage tiles belong to the old secret doorway, never to
    // the newly constructed floor. b24's Effect cleanup deliberately skips them.
    with(Effect) if(self[$ "secret"]??false) instance_destroy(id,false);
    // All asynchronous old-room tasks are tied to old instance IDs. Finish
    // them now so dead scope trees never accumulate across same-room floors.
    for(var _i=0;_i<array_length(global.hm_tasks);++_i) {
        var _task=global.hm_tasks[_i];
        if(!instance_exists(_task.scope)) _task.done=true;
    }
    HMWorld.hm_venus_sub106=-999;HMWorld.hm_venus_pending106=0;HMWorld.hm_venus_fill106=false;
    HMWorld.hm_fill_active=false;HMWorld.hm_fill_taken106=undefined;
    HMWorld.hm_water_map=undefined;HMWorld.hm_wall_theme_queue=[];HMWorld.hm_wall_theme_index=0;
    ds_list_clear(global.lis_walls_visible);ds_list_clear(global.lis_floors_visible);
}

function scrHMCarAnalog108(_index) {
    return _index>=0 && _index<array_length(KeyCont.touch)
        && (KeyCont.touch[_index] || UberCont.opt_gamepad);
}

function scrHMCarSteer108() {
    if(driver<0 || !scrHMCarAnalog108(driver) || !KeyCont.moving[driver]) return;
    // Mobile movement sticks express a world direction. The desktop MOD
    // instead has separate accelerator/steering buttons. Translate here,
    // without changing the inputs consumed by the player or the menus.
    var _desired=KeyCont.dir_move[driver],_turn=2+(speed/timescale)/2;
    image_angle-=clamp(angle_difference(image_angle,_desired),-_turn,_turn);
}

function scrHMCarButton108(_index,_action) {
    if(!scrHMCarAnalog108(_index)) return scrHMButtonCheck(_index,_action);
    return _action=="nort" && KeyCont.moving[_index];
}

function scrHMVenusPickup108() {
    if(!scrHMEnabled() || GameCont.area!=scrHMAreaResolve("venuz") || !instance_exists(Floor)) return;
    // Remember a safe point on the current floor, so a high-speed chest
    // ejection cannot strand a weapon behind an authored invisible border.
    if(position_meeting(x,y,Floor) && !place_meeting(x,y,Wall) && !place_meeting(x,y,InvisiWall)) {
        hm_safe_x108=x;hm_safe_y108=y;return;
    }
    if(is_undefined(self[$ "hm_safe_x108"])) {
        var _floor=instance_nearest(x,y,Floor);
        if(!instance_exists(_floor) || point_distance(x,y,_floor.x+16,_floor.y+16)>96) return;
        hm_safe_x108=_floor.x+16;hm_safe_y108=_floor.y+16;
    }
    if(point_distance(x,y,hm_safe_x108,hm_safe_y108)>24
        || place_meeting(x,y,InvisiWall) || place_meeting(x,y,Wall)) {
        x=hm_safe_x108;y=hm_safe_y108;speed=0;
    }
}

function scrHMThroneBeam108() {
    // Exact same scale grid and collision mask as the original 1024-step
    // sweep. Once negative, the beam's rectangular mask grows monotonically.
    var _first=ceil(1/timescale)+1;
    for(var _n=1;_n<=_first;++_n) {
        image_yscale=1-_n*timescale;
        if(place_meeting(x,y,Wall)) return;
    }
    image_yscale=1-1024*timescale;
    if(!place_meeting(x,y,Wall)) return;
    var _low=_first,_high=1024;
    while(_high-_low>1) {
        var _mid=(_low+_high) div 2;
        image_yscale=1-_mid*timescale;
        if(place_meeting(x,y,Wall)) _high=_mid;else _low=_mid;
    }
    image_yscale=1-_high*timescale;
}

function scrHMFilterOne108(_target,_field,_values,_operation) {
    if(is_struct(_target)||is_undefined(_target)) return [];
    var _found=[],_alarm=(string_length(_field)==6 && string_copy(_field,1,5)=="alarm");
    var _alarm_index=_alarm?real(string_char_at(_field,6)):0;
    // Native with traverses the same ordered object family as the old
    // snapshot, without allocating/copying every unrelated projectile ID.
    with(_target) {
        var _value=_alarm?alarm[_alarm_index]:self[$ _field],_match=false;
        for(var _j=0;_j<array_length(_values);++_j) {
            var _expected=_values[_j];
            switch(_operation) {
                case 0:case 1:_match=(_value==_expected);break;
                case 2:_match=!is_undefined(_value)&&_value>=_expected;break;
                case 3:_match=!is_undefined(_value)&&_value>_expected;break;
                case 4:_match=!is_undefined(_value)&&_value<=_expected;break;
                case 5:_match=!is_undefined(_value)&&_value<_expected;break;
            }
            if(_match) break;
        }
        if(_operation==1) _match=!_match;
        if(_match) array_push(_found,id);
    }
    return _found;
}

function scrHMTankPortal108(_x,_y,_direction) {
    // Initialization must precede Create: the ordinary van searches for a
    // different spawn position and clears that tile in its Create event.
    global.hm_tank_portal_pending108=true;
    global.hm_tank_portal_direction108=_direction;
    var _portal=instance_create(_x,_y,VanSpawn);
    global.hm_tank_portal_pending108=false;
    return _portal;
}

function scrHMVanPortalCreate108() {
    if(!scrHMEnabled() || !variable_global_exists("hm_tank_portal_pending108")
        || !global.hm_tank_portal_pending108) return false;
    global.hm_tank_portal_pending108=false;
    hm_tank108=true;hm_direction108=global.hm_tank_portal_direction108;
    image_speed=.4*timescale;alarm[0]=45;
    snd_play(GameCont.underwater?sndOasisPopo:sndVanWarning);
    return true;
}

function scrHMVanPortalSpawn108() {
    if(!scrHMEnabled() || !(self[$ "hm_tank108"]??false)) return false;
    // The original Alarm 1 already clears four tiles and plays its sound.
    hm_enemies_mod_gml_IDPDTank_create(x,y,hm_direction108);
    return true;
}

function scrHMVanWarning108() {
    if(!scrHMEnabled() || sprite_index!=sprVanPortalStart) return;
    var _tank=self[$ "hm_tank108"]??false;
    var _sprite=_tank?sprHMIDPDTankWarning108:sprHMVanWarning108;
    // Stay above the open portal, with an unambiguous red exclamation mark.
    draw_sprite_ext(_sprite,0,x-6,y-48,1,1,0,c_white,1);
    var _color=draw_get_color();draw_set_color(c_red);
    draw_rectangle(x+9,y-54,x+11,y-46,false);
    draw_rectangle(x+9,y-43,x+11,y-41,false);
    draw_set_color(_color);
}
