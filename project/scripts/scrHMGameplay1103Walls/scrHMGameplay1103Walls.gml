// Real host scenarios, both 30/60 FPS:
// palace,4,0,{rate},80,7103,followup113altarwalls
// throne,1,1,{rate},80,7103,followup113generatorwalls
// The actual generation and structures remain intact. Deliberately orphan
// one local existing roof and place one stale roof over a real corridor, then
// exercise the production finalizer without manufacturing any Floor cells.
function scrHMGameplayStructureRoof1103(_x,_y) {
    // Skip the normal TopSmall.Create rejection to reproduce stale saved /
    // late-authored decoration. This is fixture corruption, not production.
    var _roof=instance_create(_x,_y,CustomObject);
    with(_roof) {
        instance_change(TopSmall,false);
        sprite_index=sprWall7Trans;mask_index=sprTopSmall;
        image_speed=0;image_index=0;image_xscale=1;image_yscale=1;
        visible=true;solid=false;
    }
    return _roof;
}

function scrHMGameplayStructureFloors1103() {
    var _floors=[];
    with(Floor) array_push(_floors,[id,object_index,x,y,traction]);
    return json_stringify(_floors);
}

function scrHMGameplayStructureWallAudit1103(_anchor) {
    var _roofs=ds_list_create(),_count=0;
    collision_rectangle_list(_anchor.x-192,_anchor.y-192,_anchor.x+192,_anchor.y+192,
        TopSmall,false,true,_roofs,false);
    for(var _i=0;_i<ds_list_size(_roofs);++_i) {
        var _roof=_roofs[| _i];
        if(!instance_exists(_roof)) continue;
        _count++;
        scrHMGameplayCheck(!scrHMStructureWallFloor1103(_roof.x,_roof.y),
            "late structure corridor has no roof painted over its physical Floor cell");
        scrHMGameplayCheck(scrHMStructureWallSupported1103(_roof.x,_roof.y),
            "every remaining local roof has solid collision over its entire physical sixteen-pixel cell");
    }
    ds_list_destroy(_roofs);
    return _count;
}

function scrHMGameplayFollowupWalls1103() {
    if(!array_contains(["followup113altarwalls","followup113generatorwalls"],mode)) return;
    if(ticks==20) {
        var _throne=mode=="followup113generatorwalls";
        scrHMGameplayCheck(_throne?GameCont.area==scrHMAreaResolve("throne"):
            GameCont.area==scrHMAreaResolve("palace") && GameCont.subarea==4,
            "wall fixture runs in its naturally generated authored destination");
        structure_anchor1103=_throne?instance_find(BigGenerator,0):instance_find(ProtoStatue,0);
        if(_throne && !instance_exists(structure_anchor1103)) structure_anchor1103=instance_find(BigGeneratorInactive,0);
        scrHMGameplayCheck(instance_exists(structure_anchor1103),"real native altar or original Throne generator is present");
        var _anchor=structure_anchor1103;
        structure_actor1103=[_anchor.id,_anchor.x,_anchor.y,_anchor.hp,_anchor.max_hp];
        structure_floors1103=scrHMGameplayStructureFloors1103();
        structure_layout1103=_throne?[NothingInactive.x,NothingInactive.y,player.x,player.y]:[];
        scrHMGameplayStructureWallAudit1103(_anchor);

        var _floor=instance_nearest(_anchor.x,_anchor.y,Floor);
        scrHMGameplayCheck(instance_exists(_floor),"real structure keeps an authored Floor approach");
        structure_walk1103=[_floor.x+16,_floor.y+16];
        structure_stale1103=scrHMGameplayStructureRoof1103(_floor.x,_floor.y);

        var _candidates=ds_list_create(),_gap=noone;
        collision_rectangle_list(_anchor.x-160,_anchor.y-160,_anchor.x+160,_anchor.y+160,
            Wall,false,true,_candidates,false);
        for(var _i=0;_i<ds_list_size(_candidates);++_i) {
            var _wall=_candidates[| _i];
            if(instance_exists(_wall) && abs(_wall.x-_anchor.x)<=160 && abs(_wall.y-_anchor.y)<=160
                && !scrHMStructureWallFloor1103(_wall.x,_wall.y)) {_gap=_wall;break;}
        }
        ds_list_destroy(_candidates);
        scrHMGameplayCheck(instance_exists(_gap),"real structure neighbourhood supplies a non-Floor wall cell for the missing-collision witness");
        structure_gap1103=[_gap.x,_gap.y];
        var _roof=collision_point(_gap.x+8,_gap.y+8,TopSmall,false,true);
        if(!instance_exists(_roof)) _roof=scrHMGameplayStructureRoof1103(_gap.x,_gap.y);
        var _supports=ds_list_create();
        collision_rectangle_list(_gap.x+.01,_gap.y+.01,_gap.x+15.99,_gap.y+15.99,
            [Wall,InvisiWall],false,true,_supports,false);
        for(var _i=0;_i<ds_list_size(_supports);++_i) {
            var _support=_supports[| _i];
            if(instance_exists(_support)) instance_destroy(_support,false);
        }
        ds_list_destroy(_supports);
        scrHMGameplayCheck(instance_exists(_roof) && !scrHMStructureWallSupported1103(structure_gap1103[0],structure_gap1103[1]),
            "fixture reproduces visible roof with no physical supporting collision");
        structure_remote1103=scrHMGameplayStructureRoof1103(_anchor.x+4096,_anchor.y+4096);
        var _fixed=scrHMStructureWallsFinalize1103();
        scrHMGameplayCheck(_fixed.removed>=1 && _fixed.cells>=1 && _fixed.blocks>=1,
            "generation finalizer removes false corridor roofs and repairs genuinely missing collision");
        scrHMGameplayCheck(!instance_exists(structure_stale1103),"late-authored open corridor stays open instead of being sealed with new collision");
        var _walk_blocked=false;
        with(player) _walk_blocked=place_meeting(other.structure_walk1103[0],other.structure_walk1103[1],Wall)
            ||place_meeting(other.structure_walk1103[0],other.structure_walk1103[1],InvisiWall);
        scrHMGameplayCheck(!_walk_blocked,"actual Player mask can occupy the preserved structure approach without Wall or InvisiWall collision");
        scrHMGameplayCheck(instance_exists(structure_remote1103),"local repair does not sweep remote decorations or unrelated geometry");
        scrHMGameplayCheck(scrHMGameplayStructureFloors1103()==structure_floors1103,
            "wall repair preserves every native Floor identity, position, subtype and traction");
        scrHMGameplayCheck(_anchor.id==structure_actor1103[0] && _anchor.x==structure_actor1103[1]
            && _anchor.y==structure_actor1103[2] && _anchor.hp==structure_actor1103[3]
            && _anchor.max_hp==structure_actor1103[4],"wall repair never relocates or resets the real structure");
        var _blocked=false;
        with(player) _blocked=place_meeting(other.structure_gap1103[0]+8,other.structure_gap1103[1]+8,Wall)
            || place_meeting(other.structure_gap1103[0]+8,other.structure_gap1103[1]+8,InvisiWall);
        scrHMGameplayCheck(_blocked,"real Player mask now collides with the repaired visible wall");
        scrHMGameplayStructureWallAudit1103(_anchor);
        var _walls=instance_number(Wall),_tops=instance_number(TopSmall);
        var _again=scrHMStructureWallsFinalize1103();
        scrHMGameplayCheck(!_again.removed && !_again.cells && !_again.blocks
            && instance_number(Wall)==_walls && instance_number(TopSmall)==_tops,
            "repeated finalization is idempotent and cannot accumulate collision or decoration");
        instance_destroy(structure_remote1103,false);
    }
    if(ticks==35) {
        scrHMGameplayStructureWallAudit1103(structure_anchor1103);
        if(mode=="followup113generatorwalls") {
            scrHMGameplayCheck(NothingInactive.x==structure_layout1103[0] && NothingInactive.y==structure_layout1103[1],
                "original b24 sleeping Throne placement survives structure-wall repair");
            var _sleep=instance_find(NothingInactive,0);
            with(_sleep) {active=true;hp=0;event_perform_object(NothingInactive,ev_step,ev_step_normal);}
            scrHMGameplayCheck(instance_exists(BecomeNothing),"actual native Throne activation begins before wake-up wall carve");
            scrHMThroneOpenWalls1103();
            var _walls=instance_number(Wall),_invisible=instance_number(InvisiWall),_tops=instance_number(TopSmall);
            var _afterwake=scrHMStructureWallsFinalize1103();
            scrHMGameplayCheck(!_afterwake.cells && !_afterwake.blocks && !_afterwake.removed
                && instance_number(Wall)==_walls && instance_number(InvisiWall)==_invisible
                && instance_number(TopSmall)==_tops,
                "generation repair never refills the intentional 120-cell Throne wake-up clearance");
        }
    }
}
