// Multi-frame tests execute the real native generation, AI and draw events.
// They are explicitly selected, isolated from real saves, and never ship as
// a replacement for the normal player's run.
function scrHMGameplayErrorInit() {
    if(os_type!=os_windows) return;
    var _enabled=false;
    for(var _i=1;_i<=parameter_count();++_i) {
        var _arg=parameter_string(_i);
        if(string_pos("--hardmode-",_arg)==1 && string_pos("-tests",_arg)>0) _enabled=true;
    }
    if(!_enabled) return;
    if(instance_exists(UberCont)) UberCont.opt_volume=0;
    audio_master_gain(0);
    exception_unhandled_handler(function(_error) {
        show_debug_message("HARDMODE GAMEPLAY FAILED "+_error.longMessage);
        global.hm_enabled=false;global.hm_tasks=[];
        game_end();return "";
    });
}
function scrHMGameplayTests() {
    if(os_type!=os_windows) return false;
    var _enabled=false,_scenario="1,1,0,30";
    for(var _i=1;_i<=parameter_count();++_i) {
        var _arg=parameter_string(_i);
        if(_arg=="--hardmode-gameplay-tests") _enabled=true;
        if(string_pos("--hardmode-scenario=",_arg)==1) _scenario=string_delete(_arg,1,20);
    }
    if(!_enabled) return false;
    scrHMGameplayErrorInit();
    UberCont.dont_save=true;
    save_set_value("game","tutorial",false);
    save_set_value("etc","disclaimer",true);
    save_set_value("options","autopause",false);
    save_set_value("options","fullscreen",false);
    UberCont.opt_autopause=false;
    var _parts=string_split(_scenario,",");
    if(array_length(_parts)>7) {
        scrLanguageSet(_parts[7]);UberCont.opt_language=_parts[7];
    }
    var _rate=real(_parts[3]);
    save_set_value("options","framerate",_rate);
    game_set_speed(_rate,gamespeed_fps);global.time_scale=30/_rate;
    if(!instance_exists(GameCont)) instance_create(0,0,GameCont);
    var _first=ord(string_char_at(_parts[0],1));
    GameCont.area=scrHMAreaResolve((_first>=48&&_first<=57)?real(_parts[0]):_parts[0]);
    GameCont.subarea=real(_parts[1]);GameCont.loops=real(_parts[2]);
    GameCont.hard=10;GameCont.can_advance_stage=false;
    if(array_length(_parts)>6 && _parts[6]=="goto106") GameCont.hard=0;
    GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);
    GameCont.finalsubarea=(GameCont.subarea==GameCont.maxsubarea);
    if(!instance_exists(BackCont)) instance_create(0,0,BackCont);
    if(!instance_exists(TopCont)) instance_create(0,0,TopCont);
    if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
    var _player=scrPlayerCreate(0,(array_length(_parts)>6&&_parts[6]=="venusyc109")?Race.Cuz:Race.Fish,0);
    _player.wep=wep_revolver;_player.bwep=wep_shotgun;
    _player.hp=100000;_player.max_hp=100000;
    scrHMRunStart();
    var _test=instance_create(0,0,HMGameplayTest);
    _test.scenario=_scenario;_test.rate=_rate;_test.player=_player;
    _test.age=0;_test.ready_age=-1;_test.ticks=0;
    _test.generation_frames=0;_test.empty_frames=0;
    _test.last_floors=0;_test.last_enemies=0;
    _test.goal_ticks=(array_length(_parts)>4)?real(_parts[4]):180;
    _test.mode=(array_length(_parts)>6)?_parts[6]:"idle";
    _test.checks=0;_test.shots=0;_test.weapon_index=-1;
    _test.room_ticks=0;_test.route_rooms=0;_test.transition_wait=0;
    _test.persistent=true;
    if(array_length(_parts)>5) random_set_seed(real(_parts[5]));
    // Use the actual gameplay room so native camera, HUD, population and
    // transitions run under the same conditions as a player's session.
    room_goto(romGame);
    instance_destroy();
    return true;
}

function scrHMGameplayTestStep() {
    age++;
    if(instance_exists(player)) {player.hp=100000;player.max_hp=100000;}
    if(instance_exists(GenCont)) {
        if(++generation_frames>rate*30) throw "Generation exceeds 30 seconds: "+scenario;
        return;
    }
    generation_frames=0;
    if(instance_number(Floor)<5) {
        if(++empty_frames>rate*30) throw "No generated floors: "+scenario;
        return;
    }
    empty_frames=0;
    if(ready_age<0) {
        ready_age=age;last_floors=instance_number(Floor);last_enemies=instance_number(enemy);
        if(last_floors<5) throw "No generated floors: "+scenario;
        show_debug_message("HARDMODE GAMEPLAY GENERATED "+scenario+" floors="+string(last_floors)+" enemies="+string(last_enemies));
        var _actors=[];
        with(CustomEnemy) array_push(_actors,[name,hp,x,y]);
        show_debug_message("HARDMODE GENERATED ACTORS "+json_stringify(_actors));
        if(GameCont.area==scrHMAreaResolve("throne")) {
            var _thrones=[];with(NothingInactive) array_push(_thrones,[x,y,image_alpha,visible,distance_to_object(Floor)]);
            show_debug_message("HARDMODE GENERATED THRONES "+json_stringify(_thrones));
        }
    }
    if(HMWorld.logic_tick) {
        ticks++;
        room_ticks++;
        if(mode=="weapons") scrHMGameplayWeapons();
        if(mode=="maggot") scrHMGameplayMaggot();
        if(array_contains(["stale","frog","portal","scorpion","crowd","visual","fog","bandit","banditmelee"],mode)) scrHMGameplayRepairs102();
        if(mode=="save" || mode=="continue") scrHMGameplaySave();
        if(mode=="boss") scrHMGameplayBoss();
        if(mode=="titank") scrHMGameplayTitank();
        if(mode=="throne") scrHMGameplayThrone();
        if(mode=="hq") scrHMGameplayHQ();
        if(mode=="guardian" || mode=="throne2") scrHMGameplaySpecialBoss();
        if(mode=="ui") scrHMGameplayUI();
        if(mode=="route") scrHMGameplayRoute();
        if(string_pos("103",mode)>0) scrHMGameplayRepairs103();
        if(string_pos("104",mode)>0) scrHMGameplayRepairs104();
        if(string_pos("105",mode)>0) scrHMGameplayRepairs105();
        if(string_pos("106",mode)>0) scrHMGameplayRepairs106();
        if(string_pos("107",mode)>0) scrHMGameplayRepairs107();
        if(string_pos("108",mode)>0) scrHMGameplayRepairs108();
        if(string_pos("109",mode)>0) scrHMGameplayRepairs109();
        if(mode=="venus106" || mode=="venussecrets106" || mode=="venusyc109") scrHMGameplayVenus106();
        if(ticks==120 && surface_exists(application_surface)) {
            surface_save(application_surface,game_directory+"gameplay.png");
        }
        if(mode=="ui" && ticks==60 && surface_exists(application_surface)) {
            surface_save(application_surface,game_directory+"settings.png");
        }
        if(mode=="continue" && ticks==140) {
            scrHMGameplayCheck(GameCont.area==saved_area&&GameCont.subarea==saved_subarea,"regeneration retains continued custom area");
            scrHMGameplayCheck(player.wep==saved_wep&&player.bwep==saved_bwep,"regeneration retains continued custom loadout");
            scrHMGameplayCheck(player.can_walk&&player.can_pick,"continued controls remain usable");
            scrHMGameplayCheck(audio_exists(MusCont.song)&&audio_is_playing(MusCont.song),"disk continue restarts custom room music");
        }
    }
    if(ticks>=goal_ticks) {
        show_debug_message("HARDMODE GAMEPLAY RESULT "+json_stringify({status:"PASS",scenario:scenario,
            ticks:ticks,floors:last_floors,enemies:last_enemies,remaining:instance_number(enemy),
            custom_actors:instance_number(CustomEnemy),tasks:array_length(global.hm_tasks),checks:checks,shots:shots,rooms:route_rooms}));
        global.hm_enabled=false;global.hm_tasks=[];game_end();
    }
}

function scrHMGameplayRoomStart() {
    if(!array_contains(["route","route103","boss","titank","continue","goto103","venus106","venussecrets106","ice107","throneroute109"],self[$ "mode"])) return;
    ready_age=-1;room_ticks=0;route_rooms++;transition_wait=0;
    show_debug_message("HARDMODE ROUTE ROOM "+string(route_rooms)+" "+string(GameCont.area)+","+string(GameCont.subarea));
    if(mode=="titank" && ticks>900) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("city")&&GameCont.subarea==4,"Titank exit actually reaches city 5-4");
        titank_exit_reached=true;
    }
}

function scrHMGameplayRoute() {
    if(room_ticks==120) {
        scrHMGameplayCheck(instance_exists(player),"player persists across transition");
        scrHMGameplayCheck(sprite_exists(scrHMAssetIndex("sprFloor"+string(GameCont.area))),"new area's floor is valid");
        GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0;
        // Exercise real room-end/room-start and generation. Separate boss
        // cases verify death/portal effects without skipping those events.
        GameCont.can_advance_stage=true;GameCont.is_level_ended=true;
        room_restart();
    }
}

function scrHMGameplayIsBoss() {
    if(array_contains(["OasisBoss","FrogQueen","BanditBoss","ScrapBoss","Hunter","HyperCrystal",
        "Technomancer","Nothing","NothingInactive","BecomeNothing","Captain"],object_get_name(object_index))) return true;
    if(!instance_is(id,CustomEnemy)) return false;
    var _names=["scorpionboss","turtle1","turtle2","turtle3","turtle4","ratboss","BIG BIRD","gatorboss","titank","guardianboss","GunGod"];
    if(array_contains(_names,name)) return true;
    return scrHMScriptRef(on_step)==scrHMScriptRef(hm_bosses_throne_mod_gml_Throne2Step);
}

function scrHMGameplayBoss() {
    if(ticks mod 300==0) {
        var _names=[];
        with(enemy) array_push(_names,[object_get_name(object_index),self[$ "name"],hp]);
        show_debug_message("HARDMODE BOSS STATE "+string(ticks)+" "+json_stringify(_names));
    }
    if(ticks>=90&&ticks<=150) with(enemy) if(!scrHMGameplayIsBoss() && self[$ "name"]!="portalblocker") hp=0;
    if(ticks==300) {
        var _seen=0;
        with(enemy) if(scrHMGameplayIsBoss()) {
            _seen++;
            var _floor=instance_nearest(x+60,y+60,Floor);
            if(instance_exists(_floor)) {other.player.x=_floor.x+16;other.player.y=_floor.y+16;}
        }
        scrHMGameplayCheck(_seen>0,"boss is spawned in this arena");
    }
    if(ticks==650) with(enemy) if(scrHMGameplayIsBoss()) hp=min(hp,max_hp*.4);
    if(ticks==990) with(enemy) if(scrHMGameplayIsBoss()) {
        var _away=instance_furthest(x,y,Floor);
        if(instance_exists(_away)) {other.player.x=_away.x+16;other.player.y=_away.y+16;}
    }
    if(ticks>=1000 && ticks<=1060) with(enemy) if(scrHMGameplayIsBoss()) hp=0;
    // Keep this automated observer out of the final portal's intentional
    // shrink/input-lock state while asserting cinematic control restoration.
    if(ticks>990 && instance_exists(Portal)) with(Portal) {
        if(point_distance(x,y,other.player.x,other.player.y)<80) {
            var _safe=instance_furthest(x,y,Floor);
            if(instance_exists(_safe)) {other.player.x=_safe.x+16;other.player.y=_safe.y+16;}
        }
    }
    if(ticks==1450) {
        var _alive=0;
        with(enemy) if(scrHMGameplayIsBoss() && hp>0) _alive++;
        scrHMGameplayCheck(_alive==0,"boss death finishes");
        scrHMGameplayCheck(player.can_walk,"cinematic releases walking");
        scrHMGameplayCheck(player.can_pick,"cinematic releases pickup");
    }
}

function scrHMGameplaySpecialBoss() {
    if(ticks==30) {
        if(mode=="throne2") {
            with(enemy) instance_destroy(id,false);
            with(player) scrHMModCall("mod","throne","throne_create",x,y-120);
        } else {
            var _statue=noone;
            with(CustomObject) if(name=="guardianstatue") { _statue=id;break; }
            scrHMGameplayCheck(instance_exists(_statue),"guardian statue generated from source");
            player.x=_statue.x;player.y=_statue.y+40;
        }
    }
    if(mode=="guardian" && ticks<350) with(CustomObject) if(name=="guardianstatue") {
        other.player.x=x;other.player.y=y+40;
    }
    if(ticks==31 || ticks==90 || ticks==210 || ticks==450) {
        var _state=[];
        with(CustomObject) array_push(_state,[name,self[$ "rot"],x,y]);
        with(CustomEnemy) array_push(_state,[name,hp,max_hp,on_step]);
        show_debug_message("HARDMODE SPECIAL STATE "+string(ticks)+" "+json_stringify(_state));
    }
    if(ticks==450) {
        var _seen=0;
        with(enemy) if(scrHMGameplayIsBoss()) _seen++;
        with(CustomObject) if(name=="guardianstatue") show_debug_message("HARDMODE STATUE "+json_stringify({rot:rot,x:x,y:y,player_x:other.player.x,player_y:other.player.y}));
        with(CustomEnemy) show_debug_message("HARDMODE SPECIAL ENEMY "+json_stringify({name:name,hp:hp}));
        scrHMGameplayCheck(_seen>0,"special boss becomes active");
    }
    if(ticks==800) with(enemy) if(scrHMGameplayIsBoss()) scr_hit(id,max_hp*.6,HitId.Player);
    if(ticks==1250) with(enemy) if(scrHMGameplayIsBoss()) scr_hit(id,max_hp*3,HitId.Player);
    if(ticks==2000) {
        var _alive=0;
        with(enemy) if(scrHMGameplayIsBoss() && hp>0) _alive++;
        scrHMGameplayCheck(_alive==0,"special boss death completes");
    }
}

function scrHMGameplayTitank() {
    if(ticks>900 && instance_exists(Portal)) {
        var _safe=instance_furthest(Portal.x,Portal.y,Floor);
        if(instance_exists(_safe)) {player.x=_safe.x+16;player.y=_safe.y+16;}
    }
    if(ticks mod 300==0) {
        var _state=[];
        with(enemy) array_push(_state,[object_get_name(object_index),self[$ "name"],hp,self[$ "can_die"]]);
        show_debug_message("HARDMODE TITANK STATE "+string(ticks)+" "+json_stringify(_state)+" portal="+string(instance_exists(Portal)));
    }
    if(ticks==90) with(enemy) hp=0; // Activate the original kill-threshold spawner.
    if(ticks==450) {
        var _tank=noone,_feet=0;
        with(CustomEnemy) {
            if(name=="titank") _tank=id;
            else if(!can_die) _feet++;
        }
        scrHMGameplayCheck(instance_exists(_tank),"Titank naturally spawned after city kills");
        scrHMGameplayCheck(_feet==_tank.legs,"all Titank leg damage receivers exist");
        scrHMGameplayCheck(!instance_exists(Portal),"no exit before Titank is defeated");
        player.x=_tank.x+80;player.y=_tank.y+100;
    }
    if(ticks==900) with(CustomEnemy) if(name!="titank"&&!can_die) scr_hit(id,1000,HitId.Player);
    if(ticks==2000) {
        var _tanks=0;
        with(CustomEnemy) if(name=="titank") _tanks++;
        scrHMGameplayCheck(_tanks==0,"destroying the legs completes Titank death sequence");
        scrHMGameplayCheck(player.can_walk&&player.can_pick,"Titank outro restores controls");
        scrHMGameplayCheck(instance_exists(Portal)||(self[$ "titank_exit_reached"]??false),"Titank and foot death produce a usable exit or complete its transition");
    }
}

function scrHMGameplayThrone() {
    if(ticks==30) {
        scrHMGameplayCheck(instance_exists(NothingInactive),"first throne stage generated");
        player.x=NothingInactive.x;player.y=NothingInactive.y+16;
    }
    if(ticks==80) with(NothingInactive) {
        show_debug_message("HARDMODE THRONE TRIGGER "+json_stringify({active:active,hp:hp,x:x,y:y,player_x:Player.x,player_y:Player.y,distance:distance_to_object(Player)}));
        hp=0;
    }
    if(ticks==600) {
        show_debug_message("HARDMODE THRONE PHASE "+json_stringify({inactive:instance_number(NothingInactive),becoming:instance_number(BecomeNothing),active:instance_number(Nothing)}));
        scrHMGameplayCheck(instance_exists(Nothing),"approach activates the first throne battle");
        with(BigGenerator) hp=0;
    }
    if(ticks==900) with(Nothing) scr_hit(id,100000,HitId.Player);
    if(ticks==1300) {
        var _seen=0;
        with(CustomEnemy) if(scrHMScriptRef(on_step)==scrHMScriptRef(hm_bosses_throne_mod_gml_Throne2Step)) _seen++;
        scrHMGameplayCheck(_seen==1,"first throne death starts exactly one Hardmode second stage");
    }
    if(ticks==1700) with(CustomEnemy) if(scrHMScriptRef(on_step)==scrHMScriptRef(hm_bosses_throne_mod_gml_Throne2Step)) scr_hit(id,100000,HitId.Player);
    if(ticks==2300) {
        var _seen=0;
        with(CustomEnemy) if(scrHMScriptRef(on_step)==scrHMScriptRef(hm_bosses_throne_mod_gml_Throne2Step)) _seen++;
        scrHMGameplayCheck(_seen==0,"second throne stage completes");
        scrHMGameplayCheck(array_length(global.hm_tasks)<200,"throne phase transition has bounded continuations");
    }
}

function scrHMGameplayHQ() {
    if(ticks==30) {
        hq_pickups=[];hq_expected=[];
        var _floor=instance_furthest(player.x,player.y,Floor);
        var _names=["secretweaponi1","secretweaponi2","secretweaponi3"];
        for(var _i=0;_i<array_length(_names);++_i) {
            var _pickup=instance_create(_floor.x+12+_i*2,_floor.y+16,WepPickup);
            _pickup.wep=global.hm_weapon_ids[$ _names[_i]];_pickup.ammo=100;
            array_push(hq_pickups,_pickup);array_push(hq_expected,_pickup.wep);
        }
    }
    if(ticks==90) for(var _i=0;_i<array_length(hq_pickups);++_i) {
        scrHMGameplayCheck(instance_exists(hq_pickups[_i]),"HQ pickup remains available");
        scrHMGameplayCheck(hq_pickups[_i].wep==hq_expected[_i],"HQ permits each of the three supplied IDPD weapons");
    }
}

function scrHMGameplayUI() {
    if(ticks==30) {
        var _menu=instance_create(0,0,MenuOptions);
        scrOptionsMenuChangeCategory(OptionCategory.Hardmode,false);
        scrHMGameplayCheck(_menu.item_count==8,"all single-player MOD settings visible in actual menu");
        for(var _i=0;_i<7;++_i) {
            var _opt=_menu.items[_i],_old=scrHMModGet("mod","options",_opt.hm_setting);
            method_execute(_opt.click,_opt);
            scrHMGameplayCheck(scrHMModGet("mod","options",_opt.hm_setting)!=_old,"menu click toggles setting");
            method_execute(_opt.click,_opt);
        }
    }
    if(ticks==90) {
        with(MenuOptions) instance_destroy();
        scrHMGameplayCheck(instance_exists(player),"closing settings retains player");
    }
}

function scrHMGameplayCheck(_condition,_message) {
    if(!_condition) throw "Gameplay assertion: "+_message;
    HMGameplayTest.checks++;
}

// Let actual multi-frame collision dispatch run while one enemy overlaps the
// player. The old FiredMaggot event emitted a new enemy on every contact frame.
function scrHMGameplayMaggot() {
    if(ticks==1) {
        with(enemy) instance_destroy(id,false);
        maggot_hits=0;
    }
    if(ticks>=10 && ticks<=110 && ticks mod 20==10) {
        with(enemy) instance_destroy(id,false);
        var _jump=instance_create(player.x,player.y,FiredMaggot);
        _jump.jumper=true;_jump.creator=player;_jump.speed=0;
        _jump.team=1;_jump.hp=1;
        jump_id=_jump;maggot_hits++;
    }
    if(ticks>=12 && ticks<=112 && ticks mod 20==12) {
        scrHMGameplayCheck(!instance_exists(jump_id),"jumping maggot ends after native player contact");
        scrHMGameplayCheck(instance_number(Maggot)+instance_number(FiredMaggot)==1,"one jumping maggot becomes exactly one normal maggot");
    }
    if(ticks==130) {
        with(enemy) instance_destroy(id,false);
        var _jump=instance_create(player.x+100,player.y,FiredMaggot);
        _jump.jumper=true;_jump.creator=player;_jump.speed=0;
        var _wall=instance_create(_jump.x,_jump.y,Wall);
        jump_id=_jump;test_wall=_wall;
    }
    if(ticks==132) {
        scrHMGameplayCheck(!instance_exists(jump_id),"jumping maggot lands at wall");
        scrHMGameplayCheck(instance_number(Maggot)+instance_number(FiredMaggot)==1,"wall landing creates one maggot");
        instance_destroy(test_wall,false);
    }
    if(ticks==150) scrHMGameplayCheck(maggot_hits==6,"six separate contact landings exercised");
}

function scrHMGameplayWeapons() {
    if(ticks<30) return;
    var _names=["secretweapon1","secretweapon2","secretweapon3","secretweaponi1","secretweaponi2",
        "secretweaponi3","secretweapong1","secretweapong2","secretweapong3","secretweapong4","secretweapong5"];
    var _index=floor((ticks-30)/90);
    if(_index>=array_length(_names)) return;
    var _weapon=global.hm_weapon_ids[$ _names[_index]],_phase=(ticks-30) mod 90;
    if(_phase==0 || _phase==45) {
        weapon_index=_index;
        // Exercise primary fire, asynchronous bursts, recoil and the carried
        // secondary hook in the actual player/AI/draw loop.
        with(player) {
            wep=_weapon;bwep=global.hm_weapon_ids[$ _names[(_index+1) mod 11]];
            reload=0;breload=0;infammo=true;gunangle=(_phase==0)?0:180;
            scrFire(wep,false);
        }
        scrHMGameplayCheck(player.reload==scr_weapon_get_load(_weapon),"reload "+_names[_index]);
        shots++;
    }
    if(_phase==89) {
        scrHMGameplayCheck(instance_exists(player),"carrier survives "+_names[_index]);
        scrHMGameplayCheck(array_length(global.hm_tasks)<300,"bounded tasks "+_names[_index]);
        show_debug_message("HARDMODE WEAPON FIRED "+_names[_index]);
    }
}

function scrHMGameplaySave() {
    if(ticks!=30) return;
    var _fields=["intropan","bossoutros","rads","weaponnames","coopchests","portals","rogue","flames","ratrevive"];
    for(var _i=0;_i<array_length(_fields);++_i) {
        var _old=scrHMModGet("mod","options",_fields[_i]);
        scrHMModCall("mod","options","chat_command",_fields[_i]);
        scrHMGameplayCheck(scrHMModGet("mod","options",_fields[_i])!=_old,"option toggles "+_fields[_i]);
        scrHMModCall("mod","options","chat_command",_fields[_i]);
        scrHMGameplayCheck(scrHMModGet("mod","options",_fields[_i])==_old,"option restored "+_fields[_i]);
    }
    var _settings=string_split(scrHMStringLoad("hardsave.txt"),"*");
    scrHMGameplayCheck(array_length(_settings)==9,"settings file has all fields");
    global.hm_module_vars[$ "mod:maincode"].gce=17;
    global.hm_module_vars[$ "mod:bosses/turtles"].seenturtles=true;
    player.wep=global.hm_weapon_ids[$ "secretweapon2"];
    player.bwep=global.hm_weapon_ids[$ "secretweapong4"];
    var _wep=player.wep,_bwep=player.bwep,_area=GameCont.area,_subarea=GameCont.subarea;
    // Use the real disk save format and player recreation, not a direct
    // capture/restore pair, to catch serialization and native method issues.
    scrSavegameSave();
    scrHMGameplayCheck(file_exists(savegame_file),"save written to isolated profile");
    global.hm_module_vars[$ "mod:maincode"].gce=0;
    global.hm_module_vars[$ "mod:bosses/turtles"].seenturtles=false;
    with(Player) instance_destroy();
    scrHMGameplayCheck(scrSavegameLoad(),"disk continue succeeds");
    player=instance_find(Player,0);
    scrHMGameplayCheck(instance_number(Player)==1,"continue restores exactly one player");
    scrHMGameplayCheck(player.wep==_wep&&player.bwep==_bwep,"both custom weapons retained");
    scrHMGameplayCheck(GameCont.area==_area&&GameCont.subarea==_subarea,"custom area retained");
    scrHMGameplayCheck(global.hm_module_vars[$ "mod:maincode"].gce==17,"module progress retained");
    scrHMGameplayCheck(global.hm_module_vars[$ "mod:bosses/turtles"].seenturtles,"boss encounter retained");
    scrHMGameplayCheck(is_method(player.pref),"native player methods retained");
    with(player) {gunangle=0;infammo=true;scrFire(wep,false);}
    if(mode=="continue") {
        saved_area=_area;saved_subarea=_subarea;saved_wep=_wep;saved_bwep=_bwep;
        GameCont.can_advance_stage=false;
        room_goto(romGame);
    }
}


function scrHMGameplayRepairs102() {
    var _bandit=(mode=="bandit" || mode=="banditmelee");
    if(_bandit) {
        with(Portal) instance_destroy(id,false);
        GameCont.can_advance_stage=false;
    }
    if(mode=="portal" && ticks==5) {
        with(enemy) instance_destroy(id,false);
        with(Portal) instance_destroy(id,false);
        portal_test=instance_create(player.x+110,player.y,Portal);
        portal_test.endgame=100;
        scrHMModSet("mod","options","portals","1");
    }
    if(mode=="portal" && ticks==20) {player.x=portal_test.x;player.y=portal_test.y;player.speed=0;}
    if(mode=="portal" && ticks==35) instance_destroy(portal_test,false);
    if(mode=="portal" && ticks==38) {
        var _overlays=0;
        with(HMBinding) if(hm_code==scrHMScriptRef(hm_maincode_mod_gml_StablePortal)||hm_code==scrHMScriptRef(hm_maincode_mod_gml_PortalShrink)) _overlays++;
        scrHMGameplayCheck(_overlays==0,"portal renderers removed after portal closes");
    }
    if(_bandit && ticks==5) {
        global.__debug_health=true;
        with(enemy) instance_destroy(id,false);
        with(hitme) if(!instance_is(id,Player)) instance_destroy(id,false);
        with(Wall) if(point_distance(x,y,other.player.x,other.player.y)<192) instance_destroy(id,false);
        with(projectile) instance_destroy(id,false);
        with(CustomObject) instance_destroy(id,false);
        bandit_index=0;bandit_test=noone;
    }
    if(_bandit && ticks>=10 && ticks<=130 && ticks mod 30==10) {
        global.hm_tasks=[];
        with(enemy) instance_destroy(id,false);
        with(projectile) instance_destroy(id,false);
        with(CorpseActive) instance_destroy(id,false);
        with(Debris) instance_destroy(id,false);
        var _index=floor((ticks-10)/30);
        if(_index==0) bandit_test=hm_enemies_mod_gml_elitebandit_create(player.x+100,player.y,4);
        if(_index==1) bandit_test=hm_enemies_mod_gml_elitebanditsleep_create(player.x+100,player.y);
        if(_index==2) bandit_test=instance_create(player.x+100,player.y,Bandit);
        if(_index==3) bandit_test=hm_enemies_mod_gml_elitebandit_create(player.x+100,player.y,4);
        if(_index==4) bandit_test=hm_enemies_mod_gml_elitebanditsleep_create(player.x+100,player.y);
        bandit_test.friction=10;bandit_test.speed=0;
        bandit_test.alrm1=10000;
        // First three paths use actual lethal bullet collision, remaining
        // ones use a nonlethal hit before the lethal hit and death tick.
        var _bullet=instance_create(bandit_test.x,bandit_test.y,(mode=="banditmelee")?Slash:Bullet1);
        _bullet.team=team_player;_bullet.creator=player;_bullet.speed=0;
        _bullet.damage=(_index>=3)?1:50;
        _bullet.hitid=HitId.Player;
        bandit_index=_index;
    }
    if(_bandit && ticks>=16 && ticks<=136 && ticks mod 30==16 && bandit_index>=3) {
        scrHMGameplayCheck(instance_number(enemy)==1,"nonlethal hit leaves exactly one bandit");
        if(bandit_index==4) {
            var _awake=instance_find(CustomEnemy,0);
            show_debug_message("HARDMODE BANDIT WAKE "+json_stringify({hp:_awake.hp,max_hp:_awake.max_hp,hurtfor:_awake.hurtfor,tick:ticks}));
            scrHMGameplayCheck(_awake.on_step==scrHMScriptRef(hm_enemies_mod_gml_elitebandit_step),"damaged sleeper wakes into armed bandit");
            scrHMGameplayCheck(_awake.hp==3,"waking retains exact nonlethal damage");
        }
        with(enemy) {
            var _bullet=instance_create(x,y,(other.mode=="banditmelee")?Slash:Bullet1);
            _bullet.team=team_player;_bullet.creator=other.player;_bullet.speed=0;_bullet.damage=50;_bullet.hitid=HitId.Player;
        }
    }
    if(_bandit && ticks>=28 && ticks<=148 && ticks mod 30==28) {
        with(enemy) show_debug_message("HARDMODE BANDIT RESIDUAL "+json_stringify({obj:object_get_name(object_index),name:self[$ "name"],hp:hp,can_die:self[$ "can_die"],step:self[$ "on_step"],x:x,y:y,tick:other.ticks}));
        scrHMGameplayCheck(!instance_exists(bandit_test),"bandit variant dies to real projectile "+string(bandit_index));
        scrHMGameplayCheck(instance_number(enemy)==0,"dead bandit leaves no replacement enemy "+string(bandit_index));
    }

    if(mode=="fog" && ticks==10) {screen_save(game_directory+"fog.png");show_debug_message("HARDMODE FOG STATE "+json_stringify({fog:TopCont.fog,scroll:TopCont.fogscroll}));}
    if(mode=="visual" && ticks==5) {
        with(enemy) instance_destroy(id,false);
        hm_bosses_bossintros_mod_gml_boss_trigger("BIG BANDIT",sprBossIntroBackLayer,sprBossIntro,mskNone,player,0);
    }
    if(mode=="visual" && array_contains([6,10,15,20,25,35,45,55],ticks)) screen_save(game_directory+"intro-"+string(ticks)+".png");

    if(mode=="stale" && ticks==10) {
        with(enemy) instance_destroy(id,false);
        var _ghost=instance_create(player.x+30,player.y,CustomObject);
        instance_destroy(_ghost,false);
        var _boss=instance_create(player.x+70,player.y,BanditBoss);
        _boss.target=_ghost;_boss.ammo=5;_boss.newintro=-1;
        with(HMWorld) hm_enemies_mod_gml_step();
        scrHMGameplayCheck(instance_exists(_boss),"dead target does not remove bandit boss");
        instance_destroy(_boss,false);
        var _boss=instance_create(player.x+70,player.y,OasisBoss);
        _boss.target=_ghost;_boss.newintro=1;
        with(HMWorld) hm_enemies_mod_gml_step();
        scrHMGameplayCheck(instance_exists(_boss),"stale oasis intro target is safe");
        instance_destroy(_boss,false);
    }
    if(mode=="frog" && ticks==10) {
        with(Portal) instance_destroy(id,false);
        with(WepPickup) instance_destroy(id,false);
        var _skull=instance_create(player.x+30,player.y,CustomEnemy);
        _skull.spr_dead=sprMaggotDead;
        with(_skull) hm_props_mod_gml_fishskull_dead();
        instance_destroy(_skull,false);
        frog_pickup=instance_find(WepPickup,0);
        scrHMGameplayCheck(instance_exists(frog_pickup),"fish skull produces pickup");
        scrHMGameplayCheck(frog_pickup.wep==wep_frog_pistol,"fish skull produces Frog Pistol ID");
    }
    if(mode=="frog" && ticks==12) {
        scrHMGameplayCheck(frog_pickup.sprite_index==sprFrogBlaster,"Frog Pistol pickup uses its own sprite");
        scrHMGameplayCheck(frog_pickup.name==scr_weapon_get_name(frog_pickup.wep),"pickup label matches assigned weapon");
    }
    if(mode=="scorpion" && ticks==10) {
        with(enemy) instance_destroy(id,false);
        scorpion_test=hm_bosses_scorpionboss_mod_gml_scorpionboss_create(player.x+120,player.y);
        scorpion_test.intro=1;scorpion_test.target=player;
        scorpion_test.hp=scorpion_test.max_hp/2;
        scorpion_test.nexthurt=current_frame+2;
        with(scorpion_test) hm_bosses_scorpionboss_mod_gml_scorpionboss_step();
        scrHMGameplayCheck(array_length(global.hm_tasks)>0,"injured scorpion schedules retaliation");
    }
    if(mode=="scorpion" && ticks==28) {
        scrHMGameplayCheck(instance_exists(scorpion_test),"scorpion delayed retaliation completes");
        scrHMGameplayCheck(instance_number(Dust)+instance_number(DustOLD)>0,"scorpion retaliation produces original particles");
        instance_destroy(scorpion_test,false);
    }
    if(mode=="crowd" && array_contains([10,20,30],ticks)) {
        with(enemy) instance_destroy(id,false);
        var _count=(ticks==10)?32:((ticks==20)?128:256);
        for(var _i=0;_i<_count;++_i) {
            var _e=instance_create(player.x+100+(_i mod 16)*10,player.y+floor(_i/16)*10,(_i mod 2)?Bandit:Scorpion);
            _e.target=player;
        }
        var _samples=[];
        random_set_seed(102);
        repeat(25) {
            var _t=get_timer();
            with(HMWorld) hm_enemies_mod_gml_step();
            array_push(_samples,get_timer()-_t);
        }
        show_debug_message("HARDMODE CROWD PROFILE "+json_stringify({enemies:_count,rate:rate,samples_us:_samples}));
        scrHMGameplayCheck(instance_number(enemy)==_count,"crowd benchmark preserves population");
    }
}


function scrHMGameplayRender102() {
    if(mode!="portal" || ticks<7 || ticks>32) return;
    var _stable=0,_shrink=0;
    with(HMBinding) {
        if(hm_code==scrHMScriptRef(hm_maincode_mod_gml_StablePortal)) _stable++;
        if(hm_code==scrHMScriptRef(hm_maincode_mod_gml_PortalShrink)) _shrink++;
    }
    scrHMGameplayCheck(_stable==1,"one portal renderer on every physical frame");
    if(ticks>=22) scrHMGameplayCheck(_shrink==1,"shrink renderer survives extra render frame");
    if(ticks>=23 && ticks<=30) {
        var _before=player.angle;
        with(HMBinding) if(hm_code==scrHMScriptRef(hm_maincode_mod_gml_PortalShrink)) scrHMBindingDraw();
        scrHMGameplayCheck(player.angle-_before==(HMWorld.logic_tick?5:0),"shrink rotation changes only on logic tick");
    }
}
