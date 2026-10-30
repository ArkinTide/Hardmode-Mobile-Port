// Hardmode 1.0.9. Original simulation and radiation policy remain at 30 Hz.
function scrHMWeaponArea109() {return instance_exists(GameCont)?GameCont.area:area_campfire;}

// Independent signed deltas preserve absorbed radiation across cap changes.
function scrHMRadiationRequests109(_below) {
    var _delta=0;
    if(_below) {
        if(object_index==Raven) _delta=5;
        else if(array_contains([LaserCrystal,LightningCrystal,InvLaserCrystal],object_index)) _delta=-10;
    }
    raddrop+=_delta-(self[$ "hm_rad_request109"]??0);
    hm_rad_request109=_delta;
}

function scrHMRatRevive109() {
    return (global.hm_module_vars[$ "mod:options"][$ "ratrevive"]??"1")=="1";
}

function scrHMRatToggle109() {
    var _enabled=scrHMRatRevive109();
    global.hm_module_vars[$ "mod:options"].ratrevive=_enabled?"0":"1";
    if(_enabled) with(Rat) if((self[$ "infected"]??0)==1) {hp-=6;infected=0;}
    hm_options_mod_gml_basicsave();
}

function scrHMLoopMinigunner109(_x,_y) {
    if(GameCont.loops<=0 || !array_contains([area_scrapyards,scrHMAreaResolve("junkyard"),scrHMAreaResolve("ravenboss")],GameCont.area)) return noone;
    if(position_meeting(_x,_y,Wall) || random(32)>=1) return noone;
    return hm_enemies_mod_gml_Minigunner_create(_x,_y);
}

function scrHMMinigunnerShot109() {
    scrHMSoundPitchVolume(sndMinigun,.9,min(1,(view_width/4)/max(1,distance_to_object(Player))));
    with(instance_create(x+lengthdir_x(4,gunangle),y+lengthdir_y(4,gunangle),EnemyBullet4)) {
        motion_add(other.gunangle,16*timescale);
        image_angle=direction;hitid=other.hitid;team=other.team;creator=other.id;
    }
    with(instance_create(x+lengthdir_x(4,gunangle),y+lengthdir_y(4,gunangle),EBulletHit)) {
        sprite_index=sprScrapBossMissileTrail;image_angle=other.gunangle+180;image_speed=1;
    }
}

function scrHMRogueCanisters109() {
    if(self[$ "hm_dual_canister109"]??false) return;
    hm_dual_canister109=true;
    // Keep both pickup boxes reachable without placing one inside the other.
    for(var _r=24;_r<=72;_r+=16) for(var _a=0;_a<360;_a+=45) {
        var _xx=x+lengthdir_x(_r,_a),_yy=y+lengthdir_y(_r,_a);
        if(!position_meeting(_xx,_yy,Floor) || collision_rectangle(_xx-8,_yy-8,_xx+8,_yy+8,Wall,false,true)!=noone
            || collision_circle(_xx,_yy,14,chestprop,false,true)!=noone) continue;
        instance_create(_xx,_yy,RadChest);return;
    }
    // Small authored rooms can have no spare tile; nearby is still accessible.
    instance_create(x,y,RadChest);
}
function scrHMLilHunterPending109() {
    var _exists=false;
    with(CustomObject) if(name=="hm_hunter_arrival109") {_exists=true;break;}
    if(_exists || instance_exists(WantLH) || instance_exists(LilHunter)) return;
    with(instance_create(10016,10016,CustomObject)) {
        name="hm_hunter_arrival109";hm_wait109=500;
        hm_area109=GameCont.area;hm_sub109=GameCont.subarea;hm_loop109=GameCont.loops;
        on_step=scrHMScriptRef(scrHMLilHunterWait109);
    }
}

function scrHMLilHunterWait109() {
    if(GameCont.area!=hm_area109 || GameCont.subarea!=hm_sub109 || GameCont.loops!=hm_loop109) {
        instance_destroy(id,false);return;
    }
    if(--hm_wait109>0) return;
    if(!instance_exists(WantLH) && !instance_exists(LilHunter)) instance_create(x,y,WantLH);
    instance_destroy(id,false);
}

function scrHMLilHunterGroup109(_x,_y) {
    var _first=noone;
    repeat(scrHMLoopBossCount110()) {
        var _boss=instance_create(_x,_y,LilHunter);
        if(!instance_exists(_first)) _first=_boss;
    }
    return _first;
}

function scrHMGatorGroup109(_x,_y) {
    var _first=noone;
    repeat(scrHMLoopBossCount110()) {
        var _boss=hm_bosses_gatorboss_mod_gml_gatorboss_create(_x,_y);
        if(!instance_exists(_first)) _first=_boss;
    }
    return _first;
}

function scrHMRavenGroup109(_x,_y) {
    repeat(scrHMLoopBossCount110()) hm_bosses_ravenboss_mod_gml_ravenboss_create(_x,_y);
}

function scrHMRavenBackup109() {
    // One living member owns the original single-boss minion budget. If it
    // dies, another inherits it; additional bosses cannot multiply the swarm.
    var _leader=noone;
    with(CustomEnemy) if(name=="BIG BIRD" && hp>0) {
        if(_leader==noone || id<_leader) _leader=id;
    }
    return _leader==id;
}

function scrHMLoopCrystal109(_x,_y) {
    if(GameCont.loops<=0 || random(32)>=1) return noone;
    if(position_meeting(_x,_y,Wall)) return noone;
    return hm_enemies_mod_gml_bigcrystal_create(_x,_y);
}

function scrHMLoopBuffGator109(_x,_y) {
    if(GameCont.loops<=0) return noone;
    var _area=GameCont.area;
    if(_area!=scrHMAreaResolve("sewers") && !((_area==scrHMAreaResolve("junkyard")
        || _area==scrHMAreaResolve("bigdog")) && array_contains([4,5],GameCont.subarea))) return noone;
    if(position_meeting(_x,_y,Wall) || random(16)>=1) return noone;
    return instance_create(_x,_y,BuffGator);
}

function scrHMEmptyExit109() {
    // Enemy replacements deliberately skip Destroy. Their last living body
    // can disappear after every earlier corpse alarm has already expired.
    // Rearm the stock exit event only after the real encounter is empty;
    // never remove wall inhabitants, flight actors or pending bosses.
    if(!instance_exists(GameCont) || GameCont.area!=scrHMAreaResolve("nightdesert")
        || instance_exists(GenCont) || !instance_exists(Player)
        || instance_exists(Portal) || instance_exists(SpiralCont)
        || scr_check_enemies() || array_contains([scrHMAreaResolve("venuz"),
            scrHMAreaResolve("throne"),scrHMAreaResolve("end"),scrHMAreaResolve("HQ")],GameCont.area)) {
        hm_empty_exit109=0;return;
    }
    if((self[$ "hm_exit_room109"]??-1)!=GameCont.area || (self[$ "hm_exit_sub109"]??-1)!=GameCont.subarea) {
        hm_empty_exit109=0;hm_exit_room109=GameCont.area;hm_exit_sub109=GameCont.subarea;
    }
    hm_empty_exit109=(self[$ "hm_empty_exit109"]??0)+1;
    if(hm_empty_exit109<60) return;
    hm_empty_exit109=0;
    var _armed=false;
    with(Corpse) if(alarm[0]>=0) {_armed=true;break;}
    if(_armed) return;
    var _marker=noone;
    with(Corpse) if(self[$ "hm_exit_corpse"]??false) {_marker=id;break;}
    if(instance_exists(_marker)) _marker.alarm[0]=1;
    else {
        var _floor=instance_furthest(Player.x,Player.y,Floor);
        if(instance_exists(_floor)) with(_floor) scrHMDeathExit(x+16,y+16);
    }
}

function scrHMCrownAltar109() {
    // Older mobile runs inherit b24's synthetic "vaults disabled" value.
    if(GameCont.crownvisits==5) GameCont.crownvisits=0;
    if(!scrHMEnabled() || GameCont.area!=scrHMAreaResolve("palace") || GameCont.subarea!=4
        || GameCont.crownvisits>=3 || instance_exists(ProtoStatue) || !instance_exists(Floor)) return;
    var _far=instance_furthest(10016,10016,Floor);
    var _floor=instance_nearest((_far.x*2+10016)/3,(_far.y*2+10016)/3,Floor);
    if(instance_exists(_floor)) with(_floor) instance_create(bbox_center_x,bbox_center_y,ProtoStatue);
}

function scrHMThroneEntrance109() {scrHMThroneEntrance110();}
function scrHMThroneEntrance109Legacy() {
    // Finalize once with GenCont, after the source's floor/seed-dependent
    // setup. Never poll during combat or recreate a defeated throne.
    if(!scrHMEnabled() || GameCont.area!=scrHMAreaResolve("throne") || !instance_exists(Floor)) return;
    if(instance_exists(BecomeNothing)||instance_exists(Nothing)||instance_exists(NothingDeath)
        ||instance_exists(Nothing2)||instance_exists(Nothing2Death)) return;
    var _idle=instance_find(NothingInactive,0);
    if(!instance_exists(_idle)) {
        var _seed=instance_nearest(10000,10000,Floor);
        var _xx=_seed.x+16,_yy=_seed.y-1568-64*min(GameCont.loops*2,4);
        var _floor=instance_nearest(_xx,_yy,Floor);
        if(instance_exists(_floor) && point_distance(_xx,_yy,_floor.x+16,_floor.y+16)>48) {
            _xx=_floor.x+16;_yy=_floor.y+16;
        }
        _idle=instance_create(_xx,_yy,NothingInactive);
    }
    // Multiple stale nokill flags must not produce overlapping first stages.
    with(NothingInactive) if(id!=_idle) instance_destroy(id,false);
    _idle.visible=true;_idle.image_alpha=1;
}

function scrHMReviveAllowed109() {
    return !(self[$ "hm_no_revive109"]??false) && !(self[$ "hm_exit_corpse"]??false)
        && sprite_exists(sprite_index) && sprite_index!=mskNone && sprite_index!=sprTechnoMancerDead;
}

function scrHMReviveNearest109(_x,_y) {
    if(!scrHMEnabled()) return instance_nearest(_x,_y,Corpse);
    var _found=noone,_best=1000000000000;
    with(Corpse) if(scrHMReviveAllowed109()) {
        var _d=sqr(x-_x)+sqr(y-_y);
        if(_d<_best) {_best=_d;_found=id;}
    }
    return _found;
}

function scrHMTankSupplies109() {
    if(GameCont.loops<3 || (self[$ "hm_supplies109"]??false)) return;
    hm_supplies109=true;
    repeat(2) with(instance_create(x,y,choose(AmmoPickup,HPPickup))) {
        motion_add(random(360),2*timescale);
    }
}

function scrHMBoneFishRadiation109(_below) {
    if(object_index!=BoneFish || !instance_exists(GameCont) || GameCont.area!=scrHMAreaResolve("oasis")) return;
    // Vanilla BoneFish base is 2. Add only the requested post-cap difference.
    var _delta=_below?0:8;
    raddrop+=_delta-(self[$ "hm_bonefish_bonus109"]??0);hm_bonefish_bonus109=_delta;
}

function scrHMGuardianLayers109() {
    if(!scrHMEnabled()) return;
    var _active=false;
    with(HMBinding) if(hm_code==scrHMScriptRef(hm_bosses_guardianboss_mod_gml_guardiandark_draw)) {_active=true;break;}
    if(!_active && !(self[$ "hm_guard_layers109"]??false)) return;
    hm_guard_layers109=_active;
    // Native with avoids materializing per-type ID arrays. Keep entities in
    // one ordinary draw pass above the dark arena instead of redrawing hitme.
    with(GameObject) {
        if(!is_undefined(self[$ "hm_guard_depth109"])) {
            if(depth==hm_guard_set109) depth=hm_guard_depth109;
            hm_guard_depth109=undefined;
        }
    }
    if(!_active) return;
    with(GameObject) if(instance_is(id,hitme)||instance_is(id,projectile)||instance_is(id,Pickup)
        ||instance_is(id,Effect)||instance_is(id,Explosion)||instance_is(id,CrystalShield)
        ||instance_is(id,CrystalShieldDisappear)||instance_is(id,PortalStrike)) {
        if(depth>-9) {hm_guard_depth109=depth;depth=-9;hm_guard_set109=depth;}
    }
}

function scrHMGuardianDark109() {
    var _a=draw_get_alpha(),_c=draw_get_color();
    draw_set_alpha(alpha);draw_set_color(c_black);
    draw_rectangle(view_xview,view_yview,view_xview+view_width,view_yview+view_height,false);
    draw_set_alpha(_a);draw_set_color(_c);
    if(!scrHMReadyTick() || UberCont.paused) return;
    if(instance_exists(owner)) {
        alpha=min(1,alpha+.05);
        if(alpha>.5) TopCont.darkness=1;
    } else {
        alpha-=.05;
        if(alpha<=.5) {
            TopCont.darkness=0;
            with(Player) {
                if(!place_meeting(x,y,Floor)) {
                    var _floor=instance_nearest(x,y,Floor);
                    if(instance_exists(_floor)) {x=_floor.x+16;y=_floor.y+16;instance_create(x,y,PortalClear);}
                }
                if(place_meeting(x,y,Wall)) instance_create(x,y,PortalClear);
            }
        }
        if(alpha<=0) instance_destroy();
    }
}

function scrHMWaterExact109(_x,_y) {
    // The hash supplies candidates, but a quantized 16px cell must never
    // include a neighbouring dry bank or a fractional edge outside the tile.
    var _entries=HMWorld.hm_water_rects109[$ scrHMWaterKey(_x,_y)]??[];
    var _water=false;
    for(var _i=0;_i<array_length(_entries);++_i) {
        var _f=_entries[_i];
        if(!instance_exists(_f)) continue;
        var _size=instance_is(_f,FloorExplo)?16:32;
        if(_x<_f.x || _y<_f.y || _x>=_f.x+_size || _y>=_f.y+_size) continue;
        if(_f.traction!=2) return false;
        _water=true;
    }
    return _water;
}

function scrHMWaterRects109() {
    var _rects={};
    with(Floor) {
        var _size=instance_is(id,FloorExplo)?16:32;
        for(var _xx=floor(x/16)*16;_xx<x+_size;_xx+=16)
            for(var _yy=floor(y/16)*16;_yy<y+_size;_yy+=16) {
                var _key=scrHMWaterKey(_xx,_yy),_entries=_rects[$ _key]??[];
                array_push(_entries,id);_rects[$ _key]=_entries;
            }
    }
    HMWorld.hm_water_rects109=_rects;
}

function scrHMWallTransitions109(_left,_top,_right,_bottom) {
    if(!array_contains([scrHMAreaResolve("labs"),scrHMAreaResolve("palace")],GameCont.area)) return false;
    // Original TopSmall cells are the transition layer immediately outside
    // authored Wall tops. The collision fill must not paint Top over them.
    with(TopSmall) if(x>=_left&&x<=_right&&y>=_top&&y<=_bottom) {
        var _cell=collision_point(x+8,y+8,Wall,false,true),_plain=false;
        if(instance_exists(_cell)) with(_cell) _plain=scrHMPlainWall106();
        if(_plain) instance_destroy(id,false);
    }
    var _cells=[];
    with(Wall) if((self[$ "hm_interior_wall"]??false) && !scrHMPlainWall106()
        &&x>=_left&&x<=_right&&y>=_top&&y<=_bottom) array_push(_cells,id);
    for(var _i=0;_i<array_length(_cells);++_i) with(_cells[_i]) {
        if(collision_point(x+8,y+8,TopSmall,false,true)!=noone) continue;
        var _blend=image_blend;
        with(instance_create(x,y,TopSmall)) image_blend=_blend;
    }
    return true;
}

function scrHMTransitionRoof109() {
    if(!scrHMEnabled() || !(self[$ "hm_interior_wall"]??false)) return false;
    if(!array_contains([scrHMAreaResolve("labs"),scrHMAreaResolve("palace")],GameCont.area)) return false;
    return collision_point(x+8,y+8,TopSmall,false,true)!=noone;
}

function scrHMTransitionPlain109() {
    if(!instance_exists(GameCont) || !array_contains([scrHMAreaResolve("labs"),scrHMAreaResolve("palace")],GameCont.area)) return false;
    var _wall=collision_point(x+8,y+8,Wall,false,true),_plain=false;
    if(instance_exists(_wall)) with(_wall) _plain=scrHMPlainWall106();
    return _plain;
}
