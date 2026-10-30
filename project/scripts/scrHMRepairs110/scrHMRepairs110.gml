// These three encounters gain one boss per two completed loops. Raven
// backup keeps its original single-boss loop scaling separately.
function scrHMLoopBossCount110() {
    return 1+floor(max(0,GameCont.loops)/2);
}

function scrHMLoopMapEligible110(_area,_sub) {
    // Whitelist procedural layouts. Authored Venus floors, the throne hall,
    // crown vault and other scripted rooms retain their own dimensions.
    if(_area>=area_desert && _area<=area_palace) {
        return !(_area==area_palace && _sub==scrAreaGetMaxSubarea(_area));
    }
    if(_area==area_pizza_sewers || _area==area_oasis || _area==area_caves
        ||_area==area_cursed_caves || _area==area_jungle || _area==area_mansion) return true;
    var _key=scrHMAreaKey(_area);
    return array_contains(["area:nightdesert","area:scorpionboss","area:sewers",
        "area:junkyard","area:ravenboss","area:bigdog","area:caves","area:cavesinv",
        "area:city","area:labs","area:elevator","area:palace","area:oasis",
        "area:icecave","area:jungle","area:mansion","area:HQ"],_key);
}

function scrHMLoopMapSetup110() {
    if(!scrHMEnabled() || !instance_exists(GameCont) || (self[$ "hm_map_scaled110"]??false)) return;
    hm_map_scaled110=true;
    var _base=goal,_eligible=scrHMLoopMapEligible110(GameCont.area,GameCont.subarea);
    // Bounded floor-budget growth, before the very first FloorMaker copies
    // goal. No geometry scaling, stretched collision masks or runtime scan.
    if(_eligible) goal=ceil(_base*(1+.2*clamp(GameCont.loops,0,5)));
    HMWorld.hm_map_budget110={area:GameCont.area,subarea:GameCont.subarea,
        loops:GameCont.loops,base:_base,goal:goal,eligible:_eligible};
}

// Match NTTE's shared-area background/wall colours. The compact collision
// blocks and the authored edge/transition sprites keep their geometry.
function scrHMWallColour110(_sprite) {
    switch(_sprite) {
        case sprWall0Top: return scrAreaGetBackroundColor(area_campfire,false);
        case sprWall1Top: return scrAreaGetBackroundColor(area_desert,false);
        case sprWall2Top: return scrAreaGetBackroundColor(area_sewers,false);
        case sprWall3Top: return scrAreaGetBackroundColor(area_scrapyards,false);
        case sprWall4Top: return scrAreaGetBackroundColor(area_caves,false);
        case sprWall5Top: return scrAreaGetBackroundColor(area_city,false);
        case sprWall6Top: return scrAreaGetBackroundColor(area_labs,false);
        case sprWall7Top: return scrAreaGetBackroundColor(area_palace,false);
        case sprWall100Top: return scrAreaGetBackroundColor(area_vault,false);
        case sprWall101Top: return scrAreaGetBackroundColor(area_oasis,false);
        case sprWall102Top: return scrAreaGetBackroundColor(area_pizza_sewers,false);
        case sprWall103Top: return scrAreaGetBackroundColor(area_mansion,false);
        case sprWall104Top: return scrAreaGetBackroundColor(area_cursed_caves,false);
        case sprWall105Top: return scrAreaGetBackroundColor(area_jungle,false);
        case sprWall106Top: return scrAreaGetBackroundColor(area_hq,false);
        case sprWall107Top: return scrAreaGetBackroundColor(area_crib,false);
    }
    // Bespoke Hardmode locations have no NTTE counterpart. Their exterior
    // uses the location's authored background, never a dominant texture pixel.
    return scrHMBackgroundColour105();
}

function scrHMThroneSeed110() {
    var _seed=instance_nearest(10000,10000,Floor);
    if(!instance_exists(_seed)) return;
    // A stale seed from another floor must not spawn a second throne or
    // move the boss outside the arena. NTT's start callback expects one seed.
    with(Floor) nokill=(id==_seed)?1:0;
}

function scrHMThroneEntrance110() {
    if(!scrHMEnabled() || !instance_exists(GameCont) || GameCont.area!=scrHMAreaResolve("throne")
        || !instance_exists(Floor)) return;
    if(instance_exists(BecomeNothing)||instance_exists(Nothing)||instance_exists(NothingDeath)
        ||instance_exists(Nothing2)||instance_exists(Nothing2Death)) return;
    var _seed=instance_nearest(10000,10000,Floor);
    var _xx=_seed.x+16,_yy=_seed.y-1568-64*min(GameCont.loops*2,4);
    var _floor=instance_nearest(_xx,_yy,Floor);
    if(instance_exists(_floor) && point_distance(_xx,_yy,_floor.x+16,_floor.y+16)>48) {
        _xx=_floor.x+16;_yy=_floor.y+16;
    }
    var _idle=instance_find(NothingInactive,0);
    if(!instance_exists(_idle)) _idle=instance_create(_xx,_yy,NothingInactive);
    with(NothingInactive) if(id!=_idle) instance_destroy(id,false);
    if(!_idle.active) {
        // Its native Step resets x/y to xstart/ystart. Repair both pairs,
        // rather than moving it for only the current render frame.
        _idle.x=_xx;_idle.y=_yy;_idle.xstart=_xx;_idle.ystart=_yy;
        _idle.xprevious=_xx;_idle.yprevious=_yy;
        _idle.visible=true;_idle.image_alpha=1;
        _idle.sprite_index=sprNothingOff;_idle.spr_idle=sprNothingOff;
        _idle.spr_hurt=sprNothingOff;_idle.mask_index=mskNothingInactive;
    }
}
