// Natural-generation smoke for every actual playable area/subarea listed in
// release1103_allareas_plan.py.  Register as scrHMGameplayFollowup1103AllAreas
// and dispatch scrHMGameplayFollowupAllAreas1103() for followup113allareas.
// This observer never changes map geometry, enemy HP, generation flags,
// player position, or exit state.  Route/clearance gates remain separate.
function scrHMGameplayAllAreasOpen1103(_player,_x,_y) {
    if(collision_point(_x,_y,Floor,false,true)==noone) return false;
    var _blocked=false;
    with(_player) _blocked=place_meeting(_x,_y,Wall)||place_meeting(_x,_y,InvisiWall);
    return !_blocked;
}

function scrHMGameplayAllAreasReach1103(_player) {
    // Probe the actual Player mask along reachable sixteen-pixel steps.
    // A bounded flood is sufficient for a spawn smoke; it does not assert
    // that every intentionally sealed Venus room is already accessible.
    var _queue=[[_player.x,_player.y]],_head=0,_seen={},_count=0;
    var _steps=[[16,0],[-16,0],[0,16],[0,-16]];
    if(!scrHMGameplayAllAreasOpen1103(_player,_player.x,_player.y)) return 0;
    _seen[$ "0,0"]=true;
    while(_head<array_length(_queue) && _count<64) {
        var _point=_queue[_head++];_count++;
        for(var _i=0;_i<4;++_i) {
            var _x=_point[0]+_steps[_i][0],_y=_point[1]+_steps[_i][1];
            var _key=string(round((_x-_player.x)/16))+","+string(round((_y-_player.y)/16));
            if(variable_struct_exists(_seen,_key)) continue;
            _seen[$ _key]=true;
            if(scrHMGameplayAllAreasOpen1103(_player,_x,_y)) array_push(_queue,[_x,_y]);
        }
    }
    return _count;
}

function scrHMGameplayAllAreasVenusSource1103() {
    // Read the maps actually loaded by this VM, with exactly the same
    // subarea selection, character indexing and 32-pixel placement as
    // venus.area_make_floor. A spawnpoint is consumed by
    // maincode.venus_place_players, so it cannot be a persistent witness.
    var _field="",_height=0;
    switch(GameCont.subarea) {
        case 1:_field="p1";_height=17;break;
        case 2:_field="p2";_height=22;break;
        case 3:_field="p3";_height=33;break;
        case 4:_field="s1";_height=17;break;
        case 5:_field="s2";_height=21;break;
        case 6:_field="s3";_height=16;break;
        case 7:_field="b1";_height=19;break;
        case 8:_field="b2";_height=19;break;
        case 9:_field="b3";_height=25;break;
        case 10:_field="m1";_height=21;break;
        case 11:_field="m2";_height=21;break;
        case 12:_field="boss2";_height=11;break;
        case 100:_field="ps";_height=15;break;
        case 200:_field="ss";_height=25;break;
        case 300:_field="bs";_height=18;break;
        case 400:_field="ms";_height=11;break;
        case 401:_field="ms2";_height=11;break;
    }
    scrHMGameplayCheck(_field!="","Venus smoke selects an authored source map");
    var _text=scrHMModGet("area","venuz",_field);
    scrHMGameplayCheck(is_string(_text)&&string_length(_text)>0,
        "Venus source map data is loaded in the running release VM");
    var _rows=string_split(_text,"\n"),_width=string_length(_rows[0]);
    var _spawns=[],_elevators=[];
    for(var _col=0;_col<_height;++_col) {
        var _line=(_col<array_length(_rows))?_rows[_col]:"";
        // The source loop starts at zero and string_char_at is one-based.
        // Keep that authored one-cell offset instead of correcting it here.
        for(var _row=0;_row<_width;++_row) {
            var _char=string_char_at(_line,_row);
            if(_char=="*") array_push(_spawns,[_row*32+16,_col*32+16]);
            if(_char=="E") array_push(_elevators,[_row*32,_col*32]);
        }
    }
    scrHMGameplayCheck(array_length(_spawns)>0,
        "loaded Venus map contains its real authored player-spawn cell");
    var _index=GameCont.subarea==1?player.index:array_length(_spawns)-1;
    scrHMGameplayCheck(_index>=0&&_index<array_length(_spawns),
        "actual Player index has a corresponding authored Venus spawn");
    return {field:_field,width:_width,height:_height,spawn_cells:_spawns,
        expected_player:_spawns[_index],elevators:_elevators};
}

function scrHMGameplayAllAreasVenusObserve1103() {
    if(GameCont.area!=scrHMAreaResolve("venuz")) return;
    var _source=allareas_venus_source1103,_point=_source.expected_player;
    var _distance=point_distance(player.x,player.y,_point[0],_point[1]);
    if(_distance<allareas_venus_spawn_best1103) {
        allareas_venus_spawn_best1103=_distance;
        allareas_venus_spawn_observed1103=[player.x,player.y];
    }
}

function scrHMGameplayAllAreasObserve1103() {
    var _seen=allareas_seen1103;
    with(CustomObject) _seen[$ "custom:"+(self[$ "name"]??"")]=true;
    with(CustomEnemy) _seen[$ "custom:"+(self[$ "name"]??"")]=true;
    with(CustomHitme) _seen[$ "custom:"+(self[$ "name"]??"")]=true;
    var _native=[Campfire,NothingInactive,Nothing,BecomeNothing,BigGenerator,
        BigGeneratorInactive,ProtoStatue,BigTV,TV,CrownPickup,GiantWeaponChest,
        GoldChest,HyperCrystal,BecomeScrapBoss,ScrapBoss,LastIntro,Last];
    for(var _i=0;_i<array_length(_native);++_i)
        if(instance_exists(_native[_i])) _seen[$ "native:"+object_get_name(_native[_i])]=true;
    var _living=0;
    with(enemy) if(hp>0 && (self[$ "name"]??"")!="portalblocker") _living++;
    allareas_combat_seen1103=allareas_combat_seen1103||_living>0;
    allareas_max_living1103=max(allareas_max_living1103,_living);
    if(GameCont.area==106) {
        // Native FloorMaker creates the Captain desk and screen together,
        // 110 pixels apart. This distinguishes the actual HQ final arena
        // from the unrelated custom 6-3 screen/elevator room.
        with(LastIntro) {
            var _deskx=x,_desky=y;
            with(BigTV) if(abs(x-_deskx)<=0.5&&abs(y-_desky+110)<=0.5)
                _seen[$ "authored:hq_native_desk_screen"]=true;
        }
    }
}

function scrHMGameplayAllAreasWitness1103() {
    var _a=GameCont.area,_s=GameCont.subarea,_seen=allareas_seen1103;
    if(_a==scrHMAreaResolve("throne")) {
        scrHMGameplayCheck((_seen[$ "native:NothingInactive"]??false)
            || (_seen[$ "native:Nothing"]??false)||(_seen[$ "native:BecomeNothing"]??false),
            "naturally generated Throne contains its native sleeping/activating boss");
        scrHMGameplayCheck((_seen[$ "native:BigGenerator"]??false)
            ||(_seen[$ "native:BigGeneratorInactive"]??false),
            "naturally generated original Throne includes its real generator structures");
    }
    if(_a==scrHMAreaResolve("palace") && _s==4)
        scrHMGameplayCheck(_seen[$ "native:ProtoStatue"]??false,
            "natural 7-4 generation includes the actual crown altar");
    if(_a==scrHMAreaResolve("elevator") && _s==3) {
        scrHMGameplayCheck(_seen[$ "native:BigTV"]??false,
            "natural 6-3 generation includes The Messenger room's real central screen");
        scrHMGameplayCheck(_seen[$ "custom:elevator"]??false,
            "natural 6-3 generation includes its real scripted exit device");
    }
    if(_a==106 && _s==5) {
        scrHMGameplayCheck((_seen[$ "native:LastIntro"]??false)||(_seen[$ "native:Last"]??false),
            "native HQ final arena contains its actual Captain desk or active Captain");
        scrHMGameplayCheck(_seen[$ "native:BigTV"]??false,
            "native HQ final arena contains its real central screen");
        scrHMGameplayCheck(_seen[$ "authored:hq_native_desk_screen"]??false,
            "native HQ final arena preserves the source Captain desk/screen placement signature");
    }
    if(_a==scrHMAreaResolve("scorpionboss"))
        scrHMGameplayCheck(_seen[$ "custom:sewersentrance"]??false,
            "natural 1-5 generation includes the actual sewer entrance structure");
    if(_a==scrHMAreaResolve("venuz")) {
        var _source=allareas_venus_source1103,_point=_source.expected_player;
        scrHMGameplayCheck(allareas_venus_spawn_best1103<=0.5,
            "actual Player naturally snaps to the spawn coordinate parsed from its loaded Venus map");
        scrHMGameplayCheck(scrHMGameplayAllAreasOpen1103(player,_point[0],_point[1]),
            "authored Venus spawn cell remains actual Floor with a clear Player collision mask");
        _seen[$ "authored:venus_spawn_data"]=true;
        _seen[$ "authored:venus_player_snap"]=true;
        var _devices=[];
        with(CustomObject) if(name=="VenuzElevator") array_push(_devices,[x,y]);
        scrHMGameplayCheck(array_length(_devices)==array_length(_source.elevators),
            "natural Venus map retains exactly its source-authored elevator devices");
        for(var _i=0;_i<array_length(_source.elevators);++_i) {
            var _expected=_source.elevators[_i],_found=false;
            for(var _j=0;_j<array_length(_devices);++_j)
                if(point_distance(_expected[0],_expected[1],_devices[_j][0],_devices[_j][1])<=0.5)
                    _found=true;
            scrHMGameplayCheck(_found,
                "source-authored Venus elevator exists at its exact loaded-map coordinate");
        }
        _seen[$ "authored:venus_elevators"]=true;
        var _blocker=false;
        with(CustomEnemy) if(name=="portalblocker"&&hp>0&&x==-1000&&y==-1000) _blocker=true;
        scrHMGameplayCheck(_blocker,
            "natural Venus area_start retains its live out-of-map exit-control sentinel");
        _seen[$ "authored:venus_exit_control"]=true;
        _source.observed_player=allareas_venus_spawn_observed1103;
        _source.spawn_distance=allareas_venus_spawn_best1103;
        _source.observed_elevators=_devices;
    }
    if(_a==area_vault)
        scrHMGameplayCheck(_seen[$ "native:CrownPickup"]??false,
            "natural crown-vault generation creates the real crown pickup");
    if(_a==area_crib)
        scrHMGameplayCheck(_seen[$ "native:GiantWeaponChest"]??false,
            "natural Y.V. crib generation creates its native weapon reward");
    // No enemy>0 blanket: campfires, vaults, lounges and native auxiliary
    // rooms may be noncombat. Population evidence is still logged per room.
}

function scrHMGameplayFollowupAllAreas1103() {
    if(mode!="followup113allareas") return;
    if(ticks==1) {
        var _parts=string_split(scenario,","),_area=_parts[0];
        var _first=ord(string_char_at(_area,1));
        allareas_area1103=scrHMAreaResolve((_first>=48&&_first<=57)?real(_area):_area);
        allareas_requested_sub1103=real(_parts[1]);
        allareas_sub1103=allareas_requested_sub1103;allareas_loop1103=real(_parts[2]);
        // Only this native destination changes its host subarea after
        // generation: FloorMaker needs 106/3 for the Captain arena, then
        // original b24 maincode.step sets subarea=5 for its HQ display.
        if(allareas_area1103==106&&allareas_requested_sub1103==3) allareas_sub1103=5;
        allareas_seen1103={};allareas_combat_seen1103=false;allareas_max_living1103=0;
        allareas_venus_source1103={};allareas_venus_spawn_best1103=1000000000;
        allareas_venus_spawn_observed1103=[];
        if(GameCont.area==scrHMAreaResolve("venuz"))
            allareas_venus_source1103=scrHMGameplayAllAreasVenusSource1103();
        scrHMGameplayCheck(GameCont.area==allareas_area1103
            && GameCont.subarea==allareas_sub1103 && GameCont.loops==allareas_loop1103,
            "smoke uses the source-defined actual host area/subarea/loop expected by the coverage plan; "+
            json_stringify({requested:[allareas_area1103,allareas_requested_sub1103,allareas_loop1103],
                expected:[allareas_area1103,allareas_sub1103,allareas_loop1103],
                actual:[GameCont.area,GameCont.subarea,GameCont.loops],
                previous:[GameCont.lastarea,GameCont.lastsubarea]}));
    }
    if(ticks<=20) scrHMGameplayAllAreasVenusObserve1103();
    if(ticks==1 || ticks==20 || ticks==60) scrHMGameplayAllAreasObserve1103();
    if(ticks==35 || ticks==65) {
        scrHMGameplayCheck(!instance_exists(GenCont),"actual native level generation has finished");
        scrHMGameplayCheck(instance_exists(player)&&instance_is(player,Player)&&player.hp>0,
            "natural generated room retains its actual living Player");
        scrHMGameplayCheck(GameCont.area==allareas_area1103 && GameCont.subarea==allareas_sub1103,
            "natural spawn remains in the requested playable room during the smoke interval");
        scrHMGameplayCheck(instance_number(Floor)>=5,"natural generation produced native Floor instances");
        var _reach=scrHMGameplayAllAreasReach1103(player);
        scrHMGameplayCheck(_reach>=3,
            "actual Player spawns on reachable native Floor with a clear Wall/InvisiWall mask and a traversable local approach");
        if(ticks==65) {
            scrHMGameplayAllAreasWitness1103();
            var _surface=surface_exists(application_surface);
            scrHMGameplayCheck(_surface,"natural room has an application surface for the final visual audit");
            if(_surface) surface_save(application_surface,game_directory+"allarea.png");
            show_debug_message("HARDMODE ALLAREAS1103 "+json_stringify({scenario:scenario,
                area:GameCont.area,subarea:GameCont.subarea,loop:GameCont.loops,rate:rate,
                requested_subarea:allareas_requested_sub1103,
                floors:instance_number(Floor),walls:instance_number(Wall),invisible_walls:instance_number(InvisiWall),
                player:[player.x,player.y],reachable_spawn_points:_reach,
                combat_population_observed:allareas_combat_seen1103,max_living:allareas_max_living1103,
                natural_witnesses:allareas_seen1103,screenshot:_surface?"allarea.png":"missing",
                authored_map:allareas_venus_source1103,
                scope:"generation_spawn_collision_structure_smoke"}));
        }
    }
}
