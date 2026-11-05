// Finalize only the two late-authored structures after their Floor cells exist.
// TopSmall is a visual roof, not collision. Its physical cell is (x,y)..+16;
// drawing it at y-8 must never turn the walkable cell above it into a wall.
function scrHMStructureWallFloor1103(_x,_y) {
    var _found=false,_list=ds_list_create();
    collision_rectangle_list(_x+.001,_y+.001,_x+15.999,_y+15.999,Floor,false,true,_list,false);
    for(var _i=0;_i<ds_list_size(_list);++_i) {
        var _floor=_list[| _i];
        if(!instance_exists(_floor)) continue;
        var _size=instance_is(_floor,FloorExplo)?16:32;
        // The explicit half-open rectangle rejects neighbouring tiles that
        // a rounded collision query can return at a fractional boundary.
        if(_floor.x<_x+16 && _floor.x+_size>_x
            && _floor.y<_y+16 && _floor.y+_size>_y) {_found=true;break;}
    }
    ds_list_destroy(_list);
    return _found;
}

function scrHMStructureWallSolidPoint1103(_x,_y) {
    var _list=ds_list_create(),_solid=false;
    collision_point_list(_x,_y,[Wall,InvisiWall],false,true,_list,false);
    for(var _i=0;_i<ds_list_size(_list);++_i) {
        var _wall=_list[| _i];
        if(instance_exists(_wall) && _wall.solid) {_solid=true;break;}
    }
    ds_list_destroy(_list);
    return _solid;
}

function scrHMStructureWallSupported1103(_x,_y) {
    return scrHMStructureWallSolidPoint1103(_x+.25,_y+.25)
        && scrHMStructureWallSolidPoint1103(_x+15.75,_y+.25)
        && scrHMStructureWallSolidPoint1103(_x+.25,_y+15.75)
        && scrHMStructureWallSolidPoint1103(_x+15.75,_y+15.75);
}

function scrHMStructureWallKey1103(_x,_y) {
    return string(_x)+","+string(_y);
}

function scrHMStructureWallsFinalize1103() {
    var _result={roofs:0,removed:0,cells:0,blocks:0};
    if(!scrHMEnabled() || !instance_exists(GameCont)) return _result;
    var _throne=GameCont.area==scrHMAreaResolve("throne");
    var _altar=(GameCont.area==scrHMAreaResolve("palace") || GameCont.area==area_palace)
        && GameCont.subarea==4;
    if(!_altar && !_throne) return _result;
    // The 120-cell wake-up carve is intentional. This generation repair may
    // never restore its collision or roof, even if invoked again by a caller.
    if(_throne && (instance_exists(BecomeNothing) || instance_exists(Nothing)
        || instance_exists(NothingDeath) || instance_exists(Nothing2)
        || instance_exists(Nothing2Death))) return _result;

    var _anchors=[];
    if(_altar) with(ProtoStatue) array_push(_anchors,[x,y]);
    if(_throne) {
        with(BigGenerator) array_push(_anchors,[x,y]);
        with(BigGeneratorInactive) array_push(_anchors,[x,y]);
    }
    var _roofs=[],_seen={},_near=ds_list_create();
    for(var _a=0;_a<array_length(_anchors);++_a) {
        var _p=_anchors[_a];ds_list_clear(_near);
        collision_rectangle_list(_p[0]-192,_p[1]-192,_p[0]+192,_p[1]+192,
            TopSmall,false,true,_near,false);
        for(var _i=0;_i<ds_list_size(_near);++_i) {
            var _roof=_near[| _i],_key=string(_roof);
            if(!instance_exists(_roof) || (_seen[$ _key]??false)) continue;
            _seen[$ _key]=true;array_push(_roofs,_roof);
        }
    }
    ds_list_destroy(_near);

    var _missing={},_cells=[];
    for(var _i=0;_i<array_length(_roofs);++_i) {
        var _roof=_roofs[_i];
        if(!instance_exists(_roof)) continue;
        _result.roofs++;
        if(scrHMStructureWallFloor1103(_roof.x,_roof.y)) {
            // Late altar floors / generator clearance are real corridors.
            // Remove their stale visual roof rather than block the corridor.
            instance_destroy(_roof,false);_result.removed++;continue;
        }
        if(scrHMStructureWallSupported1103(_roof.x,_roof.y)) continue;
        var _key=scrHMStructureWallKey1103(_roof.x,_roof.y);
        if(!(_missing[$ _key]??false)) {
            _missing[$ _key]=true;array_push(_cells,[_roof.x,_roof.y]);
        }
    }
    // Only existing unsupported roof cells get collision. Adjacent defects
    // share one static mask (up to 64px square); no new decorative objects,
    // per-frame work, AI or broad exterior-wall rebuild is introduced.
    for(var _i=0;_i<array_length(_cells);++_i) {
        var _cell=_cells[_i],_x=_cell[0],_y=_cell[1];
        if(!(_missing[$ scrHMStructureWallKey1103(_x,_y)]??false)) continue;
        var _width=16,_height=16;
        while(_width<64 && (_missing[$ scrHMStructureWallKey1103(_x+_width,_y)]??false)) _width+=16;
        while(_height<64) {
            var _row=true;
            for(var _dx=0;_dx<_width;_dx+=16)
                if(!(_missing[$ scrHMStructureWallKey1103(_x+_dx,_y+_height)]??false)) {_row=false;break;}
            if(!_row) break;
            _height+=16;
        }
        var _wall=scrHMFillBlock106(_x,_y,_width,_height);
        if(!instance_exists(_wall)) continue;
        with(_wall) {solid=true;hm_plain106=true;hm_structure_roof1103=true;}
        _result.blocks++;
        for(var _dx=0;_dx<_width;_dx+=16) for(var _dy=0;_dy<_height;_dy+=16) {
            _missing[$ scrHMStructureWallKey1103(_x+_dx,_y+_dy)]=false;
            _result.cells++;
        }
    }
    return _result;
}
