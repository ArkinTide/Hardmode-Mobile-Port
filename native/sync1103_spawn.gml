// Native followup18 remote extra-boss placement, adapted to mobile Player.hp.
// Generation-only: keep the existing kind pool, masks, water-pool builder,
// population limits, AI, loot and loop health rules in the host helpers.
function scrHMExtraPlayerDistance21103(_x,_y) {
    var _nearest=1000000000000,_living=0;
    with(Player) if(hp>0) {
        var _dx=x-_x,_dy=y-_y;
        _nearest=min(_nearest,_dx*_dx+_dy*_dy);
        _living++;
    }
    if(!_living) with(Player) {
        var _dx=x-_x,_dy=y-_y;
        _nearest=min(_nearest,_dx*_dx+_dy*_dy);
    }
    return _nearest;
}

function scrHMExtraTile1103(_kind) {
    var _available=[],_farthest=0;
    with(Floor) {
        var _px=x+16,_py=y+16;
        var _distance2=scrHMExtraPlayerDistance21103(_px,_py);
        if(_distance2<25600) continue;
        if(collision_circle(_px,_py,32,[enemy,chestprop,CustomHitme],false,true)!=noone) continue;
        if(!hm_arkintide_mod_gml_hm_extra_fit(_kind,_px,_py)) continue;
        array_push(_available,[id,_distance2]);
        _farthest=max(_farthest,_distance2);
    }
    if(!array_length(_available)) return noone;
    var _threshold=max(25600,_farthest*.64);
    if(_farthest>=102400) _threshold=max(102400,_threshold);
    var _chosen=noone,_choices=0,_wet_chosen=noone,_wet_choices=0;
    for(var _i=0;_i<array_length(_available);++_i) {
        var _entry=_available[_i];
        if(_entry[1]<_threshold) continue;
        var _tile=_entry[0];
        if(!instance_exists(_tile)) continue;
        _choices++;
        if(irandom(_choices-1)==0) _chosen=_tile;
        if(_kind=="rat" && hm_arkintide_mod_gml_hm_extra_water_fit(_tile.x+16,_tile.y+16)) {
            _wet_choices++;
            if(irandom(_wet_choices-1)==0) _wet_chosen=_tile;
        }
    }
    if(instance_exists(_wet_chosen)) return _wet_chosen;
    return _chosen;
}

function scrHMExtraPopulation1103() {
    var _pool=hm_arkintide_mod_gml_hm_extra_pool(GameCont.area);
    if(!array_length(_pool)) return;
    var _amount=irandom_range(0,hm_arkintide_mod_gml_hm_extra_limit(GameCont.loops));
    if(!_amount) return;
    repeat(_amount) {
        var _start=irandom(array_length(_pool)-1);
        for(var _retry=0;_retry<array_length(_pool);++_retry) {
            var _kind=_pool[(_start+_retry) mod array_length(_pool)];
            var _tile=scrHMExtraTile1103(_kind);
            if(!instance_exists(_tile)) continue;
            if(instance_exists(hm_arkintide_mod_gml_hm_extra_spawn(_kind,_tile.x+16,_tile.y+16))) break;
        }
    }
}
