// 1.0.7 host contracts. Reference MOD and artwork remain immutable.
function scrHMPlayerNativeHidden107() {
    return scrHMEnabled() && image_alpha<=0;
}

function scrHMPoliceArea107(_area) {
    return array_contains([scrHMAreaResolve("HQ"),106],_area);
}

function scrHMCanHavePolice107() {
    // Keep non-combat endings and Venus's separate authored campaign free
    // of native waves. Ordinary and secret combat maps use native policy.
    return !array_contains([scrHMAreaResolve("throne"),scrHMAreaResolve("end"),
        scrHMAreaResolve("venuz")],GameCont.area);
}

function scrHMPoliceDeath107() {
    if(!scrHMEnabled() || GameCont.loops<3 || hp>0) return;
    // Exactly the original Freak timer/effect/revival, including its normal
    // cancellation when an exit has opened. It is owned by the corpse room.
    var _corpse=self[$ "hm_death_corpse107"]??noone;
    if(!instance_exists(_corpse)) return;
    var _timer=instance_create(x,y,WantRevivePopoFreak);
    // Follow this actual police corpse, including knockback. Invisible logic
    // corpses and another fallen enemy must not steal the revival target.
    _timer.hm_corpse107=_corpse;
}

function scrHMPoliceRevive107() {
    if(!variable_instance_exists(id,"hm_corpse107")) return false;
    if(!instance_exists(Portal) && instance_exists(hm_corpse107)) {
        with(instance_create(hm_corpse107.x,hm_corpse107.y,RevivePopoFreak))
            hm_corpse107=other.hm_corpse107;
    }
    instance_destroy();return true;
}

function scrHMShieldKeepPlasma107() {
    return scrHMEnabled() && team==team_player
        && (instance_is(id,PlasmaBig)||instance_is(id,PlasmaHuge));
}

function scrHMVanStop107() {
    if(!(self[$ "hm_freak107"]??false) || land!=1 || speed>0 || drivespeed>0) return false;
    // Preserve b24's stacked-sprite van and normal unload below loop 3.
    // Its own Destroy callback already produces the three police explosions.
    var _xx=x,_yy=y;
    instance_destroy();
    repeat(3) instance_create(_xx+orandom(8),_yy+orandom(8),PopoFreak);
    return true;
}

function scrHMThroneFall107(_falling) {
    if(_falling) {
        if(!(self[$ "hm_throne_falling107"]??false)) {
            hm_throne_falling107=true;hm_throne_alpha107=image_alpha;scale=1;
            sprite_angle=0;angle=0;
        }
        scale=max(0,scale-.03);image_alpha=0;
        // Share the exact portal body/weapon renderer. Its state advances
        // only on a logic tick and its binding survives the extra 60 FPS draw.
        scrHMBindDraw(hm_maincode_mod_gml_PortalShrink,-10);
    } else if(self[$ "hm_throne_falling107"]??false) {
        hm_throne_falling107=false;image_alpha=hm_throne_alpha107;
        scale=1;angle=0;
    }
}

function scrHMVenusLoadout107() {
    extra_weps=[];extra_weps_reload=[];extra_weps_curse=[];extra_weps_can_shoot=[];
    reload=0;breload=0;can_shoot=true;bcan_shoot=true;
    wkick=0;bwkick=0;wepangle=0;wepflip=1;bwepflip=1;
    with(WepstickAttack) active=false;
}

function scrHMVenusRetry107() {
    if(!scrHMEnabled() || !instance_exists(GameCont) || instance_exists(GenCont)
        || GameCont.area!=scrHMAreaResolve("venuz") || !instance_exists(Player)) return false;
    // The original elevator rebuilds terrain and combat in the same room.
    // Retain its cleanup, spawners and progression rules, overriding only
    // the next destination when this explicit retry has been requested.
    var _target=GameCont.subarea,_player=instance_find(Player,0);
    GameCont.hm_retry_venus107=_target;
    with(CustomObject) if(name=="VenuzElevator") scrHMDelete(id);
    with(_player) with(instance_create(x-8,y-8,CustomObject)) {
        name="VenuzElevator";image_speed=0;sprite_index=sprFloor103;
        image_alpha=0;image_index=1;depth=7;activated=1;
    }
    return true;
}

function scrHMVenusRetryDestination107() {
    var _target=variable_instance_get(GameCont,"hm_retry_venus107")??-1;
    if(_target<0) return;
    GameCont.subarea=_target;GameCont.hm_retry_venus107=-1;
    scrHMModSet("area","venuz","secrets",0);
    HMWorld.hm_venus_sub106=-999;
}

function scrHMIceCrystal107() {
    sprite_index=spr_idle;
    if(open>0 && (place_meeting(x,y,Flame)||place_meeting(x,y,FlameShell)
        || (place_meeting(x,y,CustomProjectile) && CustomProjectile.sprite_index==sprTrapFire))) {
        open--;
        with(instance_create(x,y,Flame)) damage=0;
        instance_create(x+random_range(-12,12),y+random_range(-12,12),CaveSparkle);
    }
    if(open<=0 && open!=-10000) {
        var _portal=instance_create(x,y,Portal);
        _portal.hm_destination107=scrHMAreaResolve("icecave");
        _portal.hm_subarea107=1;
        image_alpha=0;open=-10000;
    }
}

function scrHMPortalDestination107() {
    var _destination=self[$ "hm_destination107"]??-1;
    if(_destination<0) return;
    GameCont.hm_destination107=_destination;
    GameCont.hm_destination_sub107=self[$ "hm_subarea107"]??1;
}

function scrHMAdvanceDestination107() {
    var _destination=self[$ "hm_destination107"]??-1;
    if(_destination<0) return false;
    lastarea=area;lastsubarea=subarea;area=_destination;
    subarea=self[$ "hm_destination_sub107"]??1;
    hm_destination107=-1;hm_destination_sub107=-1;
    hard++;waypnt[waypoints]=area;waysub[waypoints]=subarea;waylps[waypoints]=loops;waypoints++;
    maxsubarea=scrAreaGetMaxSubarea(area);finalsubarea=subarea==maxsubarea;
    return true;
}

function scrHMPrepareJunkyard107() {
    // area_start occurs after the host's initial TopPot placement pass.
    // Decorations must be placed before play, with no death explosions
    // from culling duplicates or invalid generation positions.
    scrMoveTopPots();
    // b24 adds the sleeping boss after the host places barrels and cars.
    // A barrel already under its larger body receives native contact damage
    // on the first collision pass. Cull only overlapping explosive props as
    // part of generation, before the sleeping boss can start a chain blast.
    with(BecomeScrapBoss) {
        with(Barrel) if(place_meeting(x,y,other)) instance_destroy(id,false);
        with(ToxicBarrel) if(place_meeting(x,y,other)) instance_destroy(id,false);
        with(Car) if(place_meeting(x,y,other)) instance_destroy(id,false);
    }
}

function scrHMPortalClearWall107(_wall) {
    // Spawn/portal clearance, including the sleeping Big Dog's footprint,
    // is terrain preparation, not a combat blast.
    // Keep this cause on every new FloorExplo, including split fill blocks.
    var _previous=variable_global_exists("hm_quiet_wall107")?global.hm_quiet_wall107:false;
    global.hm_quiet_wall107=true;
    if(self[$ "hm_water_clear"]??false) scrHMSewerBank(_wall);
    else scrWallDestroy(_wall);
    global.hm_quiet_wall107=_previous;
}

function scrHMTopPotFloor107(_floor) {
    if(!scrHMEnabled() || !(_floor[$ "hm_quiet_wall107"]??false)) return false;
    var _previous=variable_global_exists("hm_quiet_wall107")?global.hm_quiet_wall107:false;
    global.hm_quiet_wall107=true;
    // Retain the original roof's terrain clearance, and propagate the
    // non-combat cause to floors made while that roof is being removed.
    with(Wall) if(place_meeting(x,y,other)) scrWallDestroy(id);
    instance_destroy(id,false);
    global.hm_quiet_wall107=_previous;
    return true;
}

function scrHMPlainWallDraw107() {
    // Open-air Venus mansions retain authored sky/window effects. The added
    // collision fill must not paint a giant opaque white roof over them.
    if(GameCont.area==scrHMAreaResolve("venuz")
        && ((GameCont.subarea>=10&&GameCont.subarea<100)||GameCont.subarea>=400)) return;
    scrHMDrawPlainWall106();
}

function scrHMPalaceHorrorMove107() {
    ammo=0;alarm[1]=10+random(10);scrTarget();
    if(instance_exists(target)) {
        direction=point_direction(x,y,target.x,target.y);
        if(point_distance(x,y,target.x,target.y)>48) direction+=choose(-1,1)*random_range(15,50);
        gunangle=point_direction(x,y,target.x,target.y);
        right=target.x<x?-1:1;
    } else direction=random(360);
    speed=.4*timescale;walk=20+random(10);
}
