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
    var _group=scrHMBossGroupReserve115("hunter",scrHMLoopBossCount110());
    if(_group.hunter_spawned>0 || instance_exists(LilHunter) || instance_exists(LilHunterFly)) return;
    var _exists=false;
    with(CustomObject) if(array_contains(["hm_hunter_arrival109","hm_hunter_pending"],name)) {_exists=true;break;}
    if(_exists || instance_exists(WantLH)) return;
    with(instance_create(10016,10016,CustomObject)) {
        name="hm_hunter_pending";hm_wait109=30;
        hm_area109=GameCont.area;hm_sub109=GameCont.subarea;hm_loop109=GameCont.loops;
        on_step=scrHMScriptRef(scrHMLilHunterWait109);
    }
}

function scrHMLilHunterWait109() {
    if(GameCont.area!=hm_area109 || GameCont.subarea!=hm_sub109 || GameCont.loops!=hm_loop109) {
        instance_destroy(id,false);return;
    }
    if(instance_exists(GenCont) || !instance_exists(Player)) return;
    if(--hm_wait109>0) return;
    var _group=scrHMBossGroupReserve115("hunter",scrHMLoopBossCount110());
    if(_group.hunter_spawned==0 && !instance_exists(WantLH)
        && !instance_exists(LilHunter) && !instance_exists(LilHunterFly)) instance_create(x,y,WantLH);
    instance_destroy(id,false);
}

function scrHMLilHunterGroup109(_x,_y) {
    var _group=scrHMBossGroupReserve115("hunter",scrHMLoopBossCount110());
    var _living=[];
    with(LilHunter) if(!(self[$ "hm_extra"]??false)) array_push(_living,id);
    with(LilHunterFly) if(!(self[$ "hm_extra"]??false)) array_push(_living,id);
    array_sort(_living,true);
    // A room owns one schedule. Flying, race changes and the death of its
    // last member cannot start a second schedule during the same visit.
    if(_group.hunter_spawned>0) return array_length(_living)>0?_living[0]:noone;
    _group.hunter_spawned=_group.expected;
    // Also repair an old continued room whose previous bridge multiplied
    // every member, without executing drops or win callbacks for duplicates.
    while(array_length(_living)>_group.expected) {
        instance_destroy(array_pop(_living),false);
    }
    var _first=array_length(_living)>0?_living[0]:noone;
    for(var _i=0;_i<array_length(_living);++_i) with(_living[_i]) {
        hm_hunter_group=1;scrHMBossGroupRegister115(id);
    }
    repeat(max(0,_group.expected-array_length(_living))) {
        var _boss=instance_create(_x,_y,LilHunter);
        _boss.hm_hunter_group=1;scrHMBossGroupRegister115(_boss);
        if(!instance_exists(_first)) _first=_boss;
    }
    return _first;
}

function scrHMGatorGroup109(_x,_y) {
    scrHMBossGroupReserve115("gator",scrHMLoopBossCount110());
    var _first=noone;
    repeat(scrHMLoopBossCount110()) {
        var _boss=hm_bosses_gatorboss_mod_gml_gatorboss_create(_x,_y);
        scrHMBossGroupRegister115(_boss);
        if(!instance_exists(_first)) _first=_boss;
    }
    return _first;
}

function scrHMRavenGroup109(_x,_y) {
    scrHMBossGroupReserve115("raven",scrHMLoopBossCount110());
    repeat(scrHMLoopBossCount110()) hm_bosses_ravenboss_mod_gml_ravenboss_create(_x,_y);
    with(CustomEnemy) if(name=="BIG BIRD" && !(self[$ "hm_extra"]??false)) scrHMBossGroupRegister115(id);
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
    if(GameCont.loops<=0 || GameCont.area==scrHMAreaResolve("city") || random(32)>=1) return noone;
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
    scrHMGuardianLayers1104();
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
    if(variable_instance_get(HMWorld,"hm_water_batch1102")??false) return scrHMWaterExact1102(_x,_y);
    // The hash supplies candidates, but a quantized 16px cell must never
    // include a neighbouring dry bank or a fractional edge outside the tile.
    var _entries=HMWorld.hm_water_rects109[$ scrHMWaterKey(_x,_y)]??[];
    var _water=false;
    for(var _i=0;_i<array_length(_entries);++_i) {
        var _f=_entries[_i];
        if(!instance_exists(_f)) continue;
        var _size=instance_is(_f,FloorExplo)?16:32;
        if(_x<_f.x || _y<_f.y || _x>=_f.x+_size || _y>=_f.y+_size) continue;
        if(_f.traction!=2 || !instance_exists(_f[$ "hm_water_surface111"]??noone) || scrHMWaterBank111(_f,_x,_y)) return false;
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

// One presentation ledger per visit, shared by all members of a normal
// encounter. It belongs to the room controller, never to a player/race.
function scrHMBossGroups115() {
    var _room=string(GameCont.id)+":"+string(GameCont.hard)+":"+string(GameCont.waypoints)
        +":"+string(GameCont.area)+":"+string(GameCont.subarea)+":"+string(GameCont.loops);
    if((variable_instance_get(HMWorld, "hm_boss_room115")??"")!=_room) {
        HMWorld.hm_boss_room115=_room;HMWorld.hm_boss_groups115={};
    }
    return HMWorld.hm_boss_groups115;
}
function scrHMBossGroupReserve115(_kind,_expected=1) {
    var _groups=scrHMBossGroups115(),_group=_groups[$ _kind];
    if(is_undefined(_group)) {
        _group={kind:_kind,members:[],expected:0,hunter_spawned:0,changed:HMWorld.logic_serial,
            entry:undefined,entry_done:false,exit:undefined,exit_done:false,observed:false,
            x:10016,y:10016,entry_count:0,exit_count:0,native_art1116:-1};
        _groups[$ _kind]=_group;
    }
    _group.expected=max(_group.expected,_expected);
    return _group;
}
function scrHMBossGroupKind115(_actor) {
    if(is_undefined(_actor) || is_struct(_actor) || !instance_exists(_actor) || (_actor[$ "hm_extra"]??false)
        || (_actor[$ "hm_palace_guardian"]??false) || ((_actor[$ "revived"]??0)>0 && !(_actor[$ "hm_messenger_auto_revived115"]??false))) return "";
    // A helicopter hull and its falling actor are a live phase handoff,
    // never an empty encounter eligible for a victory presentation.
    var _name=_actor[$ "name"]??"";
    if(_name=="hm_gungod_landing" || (_name=="GunGod" && (_actor[$ "hm_gungod_departed"]??false))) return "";
    var _tag=_actor[$ "hm_boss_kind115"]??"";
    if(_tag!="") return _tag;
    switch(_actor.object_index) {
        case BanditBoss:return "bandit";
        case ScrapBoss:return "dog";
        case HyperCrystal:return "crystal";
        case LilHunter:case LilHunterFly:return "hunter";
        case FrogQueen:return "mother";
        case OasisBoss:return "bubbler";
        case TechnoMancer:return "tech";
        case NothingInactive:case Nothing:return "throne";
        case Nothing2:return "throne2";
        case Last:return "chief";
        case CrownGuardian:return "crownguardian";
        case YVBoss:return "yv";
    }
    switch(_actor[$ "name"]??"") {
        case "scorpionboss":return "scorpion";
        case "gatorboss":return "gator";
        case "BIG BIRD":return "raven";
        case "ratboss":return "rat";
        case "turtle1":case "turtle2":case "turtle3":case "turtle4":return "turtles";
        case "titank":return "titank";
        case "guardianboss":return "guardian";
        case "rogueboss":return "messenger";
        case "hm_chief":case "hm_chief_departure":return "chief";
        case "GunGod":case "gungod":case "hm_gungod_landing":return "gungod";
        case "hm_yv_phase":return "yvphase";
    }
    if(instance_is(_actor,Corpse)) {
        switch(_actor.sprite_index) {
            case sprOasisBossDead:return "bubbler";
            case sprFrogQueenDying:return "mother";
            case sprLilHunterDead:return "hunter";
            case sprHyperCrystalDead:return "crystal";
        }
    }
    return "";
}
function scrHMBossGroupRegister115(_actor) {
    var _kind=scrHMBossGroupKind115(_actor);
    if(_kind=="" || (_actor[$ "hp"]??0)<=0 || !instance_exists(HMWorld)) return undefined;
    var _group=scrHMBossGroupReserve115(_kind);
    _actor.hm_boss_kind115=_kind;
    if(!array_contains(_group.members,_actor)) {
        array_push(_group.members,_actor);_group.changed=HMWorld.logic_serial;
    }
    _group.expected=max(_group.expected,array_length(_group.members));
    _group.observed=true;_group.x=_actor.x;_group.y=_actor.y;
    return _group;
}
function scrHMBossGroupPending115(_kind) {
    if(instance_exists(GenCont)) return true;
    if(_kind=="hunter" && instance_exists(WantLH)) return true;
    if(_kind=="bandit" && instance_exists(WantBoss)) return true;
    if(_kind=="dog" && instance_exists(BecomeScrapBoss)) return true;
    var _pending=false;
    with(CustomObject) {
        var _name=string_lower(name);
        if((_kind=="hunter" && array_contains(["hm_hunter_pending","hm_hunter_arrival109"],_name))
            || (_kind=="raven" && _name=="wantravenboss")
            || (_kind=="titank" && _name=="wanttitank")
            || (_kind=="bandit" && _name=="wantjungleboss")) {_pending=true;break;}
    }
    return _pending;
}
function scrHMBossGroupAlive115(_group) {
    var _alive=0;
    for(var _i=0;_i<array_length(_group.members);++_i) {
        var _actor=_group.members[_i];
        if(instance_exists(_actor) && (_actor[$ "hp"]??0)>0
            && !(_actor[$ "hm_extra"]??false)) _alive++;
    }
    return _alive;
}
function scrHMLilHunterReconcile115() {
    if(GameCont.area!=scrHMAreaResolve("city") || GameCont.subarea!=5) return;
    var _group=scrHMBossGroupReserve115("hunter",scrHMLoopBossCount110());
    if(_group.hunter_spawned>0) return;
    var _first=noone;
    with(LilHunter) if(!(self[$ "hm_extra"]??false)) {_first=id;break;}
    if(!instance_exists(_first)) with(LilHunterFly) if(!(self[$ "hm_extra"]??false)) {_first=id;break;}
    if(instance_exists(_first)) scrHMLilHunterGroup109(_first.x,_first.y);
}
function scrHMBossGroupPresentation115(_title,_back,_portrait,_front,_focus,_height) {
    if(!scrHMEnabled() || !instance_exists(HMWorld) || !instance_exists(GameCont)
        || (variable_instance_get(HMWorld, "hm_group_dispatch115")??false)) return false;
    var _source=id,_kind=scrHMBossGroupKind115(_source);
    if(_kind=="") {_source=_focus;_kind=scrHMBossGroupKind115(_source);}
    var _groups=scrHMBossGroups115();
    // Several original death coroutines invoke their pan on a Floor after
    // deleting the boss. Match that completed encounter by its last position.
    if(_kind=="" && _title=="" && instance_exists(_focus) && instance_is(_focus,Floor)) {
        var _keys=variable_struct_get_names(_groups),_distance=1000000000000;
        for(var _i=0;_i<array_length(_keys);++_i) {
            var _candidate=_groups[$ _keys[_i]];
            if(!_candidate.observed || scrHMBossGroupAlive115(_candidate)>0) continue;
            var _d=sqr(_candidate.x-_focus.x)+sqr(_candidate.y-_focus.y);
            if(_d<_distance) {_kind=_candidate.kind;_distance=_d;}
        }
    }
    if(_kind=="") return false;
    var _group=scrHMBossGroupReserve115(_kind);
    if(instance_exists(_source)) {_group.x=_source.x;_group.y=_source.y;}
    var _exit=instance_exists(_source) && ((_source[$ "hm_boss_exit115"]??false)
        || instance_is(_source,Corpse) || (_source[$ "hp"]??0)<=0
        || (_source[$ "name"]??"")=="hm_chief_departure");
    if(!instance_exists(_source)) _exit=true;
    if(_exit) {
        if(_kind=="guardian") {_group.exit_done=true;return true;}
        if(!_group.exit_done && is_undefined(_group.exit))
            _group.exit={title:"",back:mskNone,portrait:mskNone,front:mskNone,focus:_focus,height:0};
        scrHMBossGroupTick115();
        return true;
    }
    scrHMBossGroupRegister115(_source);
    // One snapshot captures any normal co-members constructed earlier in
    // this room. Later asynchronous arrivals register through this same hook.
    if(is_undefined(_group.entry)) {
        with(enemy) if(scrHMBossGroupKind115(id)==_kind) scrHMBossGroupRegister115(id);
        with(LilHunterFly) if(scrHMBossGroupKind115(id)==_kind) scrHMBossGroupRegister115(id);
        _group.entry={title:_title,back:_back,portrait:_portrait,front:_front,focus:_focus,height:_height};
    }
    scrHMBossGroupTick115();
    return true;
}
function scrHMBossGroupTick115() {
    if(!scrHMEnabled() || !instance_exists(GameCont) || !instance_exists(Player)) return;
    var _groups=scrHMBossGroups115(),_keys=variable_struct_get_names(_groups);
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _group=_groups[$ _keys[_i]],_alive=scrHMBossGroupAlive115(_group);
        if(!_group.observed) continue;
        var _exit=_alive==0,_request=_exit?_group.exit:_group.entry;
        if((_exit && _group.exit_done) || (!_exit && _group.entry_done)) continue;
        if(!_exit && is_undefined(_request)) continue;
        if(scrHMBossGroupPending115(_group.kind)) continue;
        if(!_exit && array_length(_group.members)<_group.expected) continue;
        if(_exit && _group.kind=="guardian") {_group.exit_done=true;continue;}
        if(_exit && is_undefined(_request))
            _request={title:"",back:mskNone,portrait:mskNone,front:mskNone,focus:noone,height:0};
        if(is_undefined(_request)) continue;
        var _native_art=_exit?-1:(_group[$ "native_art1116"]??-1);
        var _portrait=_native_art>=0 || (!_exit && _request.title!="" && GameCont.loops==0
            && scrHMModGet("mod","options","bossportraits")!="0");
        var _pan=_group.kind!="guardian" && scrHMModGet("mod","options",_exit?"bossoutros":"intropan")=="1";
        if(!_pan && !_portrait) {
            if(_exit) _group.exit_done=true;else _group.entry_done=true;
            continue;
        }
        var _focus=_request.focus;
        if(!instance_exists(_focus) || (!_exit && (_focus[$ "hp"]??1)<=0)) {
            _focus=noone;
            for(var _m=0;_m<array_length(_group.members);++_m) {
                var _actor=_group.members[_m];
                if(instance_exists(_actor) && (_actor[$ "hp"]??0)>0) {_focus=_actor;break;}
            }
            if(!instance_exists(_focus)) _focus=instance_nearest(_group.x,_group.y,Floor);
        }
        if(instance_exists(HMWorld.hm_portrait_active)) continue;
        // A destroyed actor must not move the camera to its initial spawn
        // floor. A temporary point retains the last actual boss position.
        var _point=noone;
        if(_exit || !_pan || !instance_exists(_focus)) {
            _point=instance_create(_pan?_group.x:Player.x,_pan?_group.y:Player.y,CustomObject);
            _point.name="hm_camera_focus1116";_point.sprite_visible=false;
            _focus=_point;
        }
        HMWorld.hm_group_dispatch115=true;
        hm_bosses_bossintros_mod_gml_boss_trigger((GameCont.loops>0 || _native_art>=0)?"":_request.title,
            _request.back,_request.portrait,_request.front,_focus,_request.height);
        HMWorld.hm_group_dispatch115=false;
        var _intro=HMWorld.hm_portrait_active;
        if(instance_exists(_point)) instance_destroy(_point,false);
        if(!instance_exists(_intro)) continue;
        _intro.hm_boss_kind115=_group.kind;_intro.hm_boss_exit115=_exit;
        _intro.hm_camera_start1116=HMWorld.logic_serial;
        _intro.hm_camera_wall_start1117=get_timer();
        _intro.hm_camera_target_x1116=_intro.x;_intro.hm_camera_target_y1116=_intro.y;
        if(_native_art>=0) scrHMBossNativeAttach1116(_intro,_native_art);
        if(_exit) {_group.exit_done=true;_group.exit_count++;}
        else {_group.entry_done=true;_group.entry_count++;}
        return;
    }
}
// Only actual native/custom presentations activate protection. The grace
// period does not alter movement, input, reloads, AI, or the pause state.
function scrHMBossPresentationNative115(_active) {
    if(!scrHMEnabled() || !instance_exists(HMWorld)) return;
    HMWorld.hm_native_presentation115=_active;
    if(!_active) HMWorld.hm_presentation_until115=current_frame+60;
}
function scrHMBossPresentationEnd115() {
    if(scrHMEnabled() && instance_exists(HMWorld)) HMWorld.hm_presentation_until115=current_frame+60;
}
function scrHMBossPresentationProtected115() {
    if(!scrHMEnabled() || !instance_exists(HMWorld)) return false;
    return instance_exists(HMWorld.hm_portrait_active)
        || ((variable_instance_get(HMWorld, "hm_native_presentation115")??false) && UberCont.bossintro)
        || current_frame<(variable_instance_get(HMWorld, "hm_presentation_until115")??-1);
}
// A replacement deliberately removes a living original without its death
// event. Retire that ledger before deletion, rather than treating the empty
// original group as a victory while the replacement is still fighting.
function scrHMBossGroupRetire115(_actor) {
    var _kind=scrHMBossGroupKind115(_actor);
    if(_kind=="" || !instance_exists(HMWorld)) return;
    var _groups=scrHMBossGroups115(),_group=_groups[$ _kind];
    if(is_undefined(_group)) return;
    _group.observed=false;_group.entry_done=true;_group.exit_done=true;
    _group.entry=undefined;_group.exit=undefined;_group.retired=true;
    var _intro=HMWorld.hm_portrait_active;
    if(instance_exists(_intro) && (_intro[$ "hm_boss_kind115"]??"")==_kind) {
        with(_intro) scrHMBossRestore104();instance_destroy(_intro,false);
    }
}
