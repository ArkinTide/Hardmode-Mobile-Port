// Real host fixtures: sync113spawn, area1/sub1/loop0, seed7103, ticks60,
// at 30 and 60 FPS. No kind, fit, collision, water or spawn helper is mocked.
function scrHMGameplaySpawnMap1103(_width,_height) {
    scrHMGameplayIsolate103();
    with(Floor) instance_destroy(id,false);
    with(Wall) instance_destroy(id,false);
    with(InvisiWall) instance_destroy(id,false);
    with(chestprop) instance_destroy(id,false);
    GameCont.area=1;
    for(var _ix=0;_ix<_width;++_ix) for(var _iy=0;_iy<_height;++_iy)
        instance_create(14000+_ix*32,14000+_iy*32,Floor);
    player.x=14000+floor(_width/2)*32+16;
    player.y=14000+floor(_height/2)*32+16;
    player.speed=0;player.hp=8;
}

function scrHMGameplaySpawnPoint1103(_kind,_tile) {
    scrHMGameplayCheck(instance_exists(_tile),"remote candidate exists on the real floor grid");
    var _x=_tile.x+16,_y=_tile.y+16;
    scrHMGameplayCheck(hm_arkintide_mod_gml_hm_extra_fit(_kind,_x,_y),"chosen full native boss mask fits actual walls and floor");
    scrHMGameplayCheck(collision_circle(_x,_y,32,[enemy,chestprop,CustomHitme],false,true)==noone,
        "remote point excludes occupied enemy and chest bounds");
    return point_distance(player.x,player.y,_x,_y);
}

function scrHMGameplaySpawn1103() {
    if(mode!="sync113spawn" || ticks!=20) return;
    scrHMGameplaySpawnMap1103(40,12);
    var _left=false,_right=false;
    repeat(96) {
        var _tile=scrHMExtraTile1103("hunter");
        scrHMGameplayCheck(scrHMGameplaySpawnPoint1103("hunter",_tile)>=500,
            "large map chooses remote usable rim, beyond the old 160-pixel ring");
        _left=_left || _tile.x<player.x;
        _right=_right || _tile.x>player.x;
    }
    scrHMGameplayCheck(_left && _right,"remote sampling can use both map sides");

    var _partner=instance_create(player.x+480,player.y,Player);
    _partner.hp=8;
    scrHMGameplayCheck(scrHMExtraPlayerDistance21103(_partner.x,_partner.y)==0,
        "all living co-op bodies contribute to distance");
    repeat(8) {
        var _tile=scrHMExtraTile1103("hunter");
        scrHMGameplaySpawnPoint1103("hunter",_tile);
        scrHMGameplayCheck(point_distance(_tile.x+16,_tile.y+16,_partner.x,_partner.y)>=320,
            "remote placement also protects a distant second live player");
    }
    _partner.hp=0;
    scrHMGameplayCheck(scrHMExtraPlayerDistance21103(_partner.x,_partner.y)==480*480,
        "dead co-op body does not shrink the live player's remote tier");
    var _saved_hp=player.hp;player.hp=0;
    scrHMGameplayCheck(scrHMExtraPlayerDistance21103(_partner.x,_partner.y)==0,
        "no-living-player fallback still protects present bodies");
    player.hp=_saved_hp;
    instance_destroy(_partner,false);

    var _blocked=scrHMExtraTile1103("hunter");
    var _chest=instance_create(_blocked.x+16,_blocked.y+16,WeaponChest);
    repeat(12) {
        var _tile=scrHMExtraTile1103("hunter");
        scrHMGameplaySpawnPoint1103("hunter",_tile);
        scrHMGameplayCheck(_tile!=_blocked,"a newly occupied far point is rechecked on the next selection");
    }
    instance_destroy(_chest,false);

    scrHMGameplaySpawnMap1103(14,4);
    repeat(8) {
        var _tile=scrHMExtraTile1103("hunter");
        var _distance=scrHMGameplaySpawnPoint1103("hunter",_tile);
        scrHMGameplayCheck(_distance>=160 && _distance<320,
            "small map retains the 160-pixel safety floor instead of requiring 320");
    }

    // A near existing pond must not outweigh legal remote dry pool sites.
    scrHMGameplaySpawnMap1103(40,12);
    GameCont.area=scrHMAreaResolve("sewers");
    var _nearx=player.x+224,_neary=player.y;
    scrHMGameplayCheck(hm_arkintide_mod_gml_hm_extra_water_prepare(_nearx,_neary),
        "real near pond can fit the complete Rat collision bounds");
    var _rat_tile=scrHMExtraTile1103("rat");
    scrHMGameplayCheck(scrHMGameplaySpawnPoint1103("rat",_rat_tile)>=480,
        "near existing pond never pulls the Rat out of the remote tier");
    var _ratx=_rat_tile.x+16,_raty=_rat_tile.y+16;
    scrHMGameplayCheck(hm_arkintide_mod_gml_hm_extra_water_prepare(_ratx,_raty),
        "chosen remote dry site supports the existing real pool builder");
    var _wet=scrHMExtraTile1103("rat");
    scrHMGameplayCheck(hm_arkintide_mod_gml_hm_extra_water_fit(_wet.x+16,_wet.y+16),
        "existing water is preferred when it is in the same remote tier");

    // Exercise the integration wrapper and real constructors together.
    scrHMGameplaySpawnMap1103(40,12);
    GameCont.loops=3;
    var _spawned=0;
    repeat(12) {
        hm_arkintide_mod_gml_hm_extra_population();
        with(enemy) if(variable_instance_exists(id,"hm_extra") && hm_extra) {
            _spawned++;
            scrHMGameplayCheck(point_distance(x,y,other.player.x,other.player.y)>=320,
                "public population wrapper actually creates remote real extra bosses");
            instance_destroy(id,false);
        }
    }
    scrHMGameplayCheck(_spawned>0,"seeded real population creates at least one extra boss");
    GameCont.loops=0;
}
