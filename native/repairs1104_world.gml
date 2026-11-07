// Narrow mobile-only repairs. A bounded native broad phase replaces the
// Super Gator's per-tick allocation of every hostile projectile in the map.
// Each retained candidate still runs the original projected precise test.
function scrHMGatorDodgeCandidates1104() {
    var _list=ds_list_create(),_found=[];
    collision_rectangle_list(bbox_left-64,bbox_top-64,bbox_right+64,bbox_bottom+64,
        projectile,false,true,_list,false);
    for(var _i=0;_i<ds_list_size(_list);++_i) {
        var _item=_list[| _i];
        if(instance_exists(_item) && _item.team!=team) array_push(_found,_item);
    }
    ds_list_destroy(_list);
    // Creation order makes multiple simultaneous dodge candidates stable.
    array_sort(_found,true);
    return _found;
}

// An idle Gator does not need a full nearest-Floor scan every AI tick.
// Recheck immediately on movement, floor replacement, or floor deletion.
function scrHMGatorFloor1104() {
    var _floor=self[$ "hm_gator_floor1104"]??noone;
    if(!instance_exists(_floor) || (self[$ "hm_gator_floor_x1104"]??undefined)!=x
        || (self[$ "hm_gator_floor_y1104"]??undefined)!=y
        || (self[$ "hm_gator_floor_count1104"]??-1)!=instance_number(Floor)) {
        _floor=instance_nearest(x-16,y-16,Floor);
        hm_gator_floor1104=_floor;hm_gator_floor_x1104=x;hm_gator_floor_y1104=y;
        hm_gator_floor_count1104=instance_number(Floor);
    }
    return _floor;
}

// Retain a source-independent exclusion even after the firing frog dies or
// the projectile changes its ordinary hit-id during another MOD callback.
function scrHMPoisonShot1104(_bullet) {
    if(scrHMEnabled() && instance_exists(_bullet)) {
        _bullet.maggot=1;
        _bullet.hm_poison_no_maggot1104=true;
    }
    return _bullet;
}

// Native wall collision already chooses the exact contact point. Preserve
// that point through Eyes' displacement and generic projectile impulses.
// In-flight bolts and bolts attached to living enemies keep native behavior.
function scrHMBoltPin1104() {
    if(!scrHMEnabled()) return;
    hm_bolt_wall1104=true;hm_bolt_x1104=x;hm_bolt_y1104=y;
    speed=0;gravity=0;
    xprevious=x;yprevious=y;
}

function scrHMBoltPinned1104() {
    if(!scrHMEnabled() || !(self[$ "hm_bolt_wall1104"]??false)) return false;
    x=hm_bolt_x1104;y=hm_bolt_y1104;
    xprevious=x;yprevious=y;speed=0;gravity=0;
    return true;
}

// Oasis has its own population hook rather than the common numbered pool.
function scrHMOasisPoisonSpawn1104() {
    if(GameCont.loops<=0 || random(64)>=1) return noone;
    if(collision_circle(x+16,y+16,12,Wall,false,true)!=noone) return noone;
    return instance_create(x+16,y+16,SuperFrog);
}
