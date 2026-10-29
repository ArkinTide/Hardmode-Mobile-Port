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
    var _player=scrPlayerCreate(0,Race.Fish,0);
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
        if(mode=="venus106" || mode=="venussecrets106") scrHMGameplayVenus106();
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
    if(!array_contains(["route","route103","boss","titank","continue","goto103","venus106","venussecrets106","ice107"],self[$ "mode"])) return;
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
        scrHMGameplayCheck(_menu.item_count==7,"all single-player MOD settings visible in actual menu");
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
    var _fields=["intropan","bossoutros","rads","weaponnames","coopchests","portals","rogue","flames"];
    for(var _i=0;_i<8;++_i) {
        var _old=scrHMModGet("mod","options",_fields[_i]);
        scrHMModCall("mod","options","chat_command",_fields[_i]);
        scrHMGameplayCheck(scrHMModGet("mod","options",_fields[_i])!=_old,"option toggles "+_fields[_i]);
        scrHMModCall("mod","options","chat_command",_fields[_i]);
        scrHMGameplayCheck(scrHMModGet("mod","options",_fields[_i])==_old,"option restored "+_fields[_i]);
    }
    var _settings=string_split(scrHMStringLoad("hardsave.txt"),"*");
    scrHMGameplayCheck(array_length(_settings)==8,"settings file has all fields");
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

function scrHMGameplayIsolate103() {
    global.hm_tasks=[];
    with(enemy) instance_destroy(id,false);
    with(becomenemy) instance_destroy(id,false);
    with(CustomObject) instance_destroy(id,false);
    with(projectile) instance_destroy(id,false);
    with(Portal) instance_destroy(id,false);
    with(Corpse) instance_destroy(id,false);
    with(HMBinding) instance_destroy(id,false);
    HMWorld.hm_titank_entering=false;
}

function scrHMGameplayRepairs103() {
    if(mode=="caves103" && ticks<=30) show_debug_message("HARDMODE CAVES TICK "+string(ticks)+" tasks="+string(array_length(global.hm_tasks)));
    if(mode=="contracts103" && ticks==10) {
        scrHMGameplayIsolate103();
        HMWorld.hm_titank_entering=true;
        with(HMWorld) event_perform(ev_other,ev_room_end);
        scrHMGameplayCheck(!scrHMPendingBoss(),"interrupted boss entrance cannot block the next room or run");
        var _saved=[GameCont.area,GameCont.subarea];
        with(GameCont) {area=3;subarea=3;lastarea=3;lastsubarea=2;scrHMAreaTransit();}
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("ravenboss")&&GameCont.subarea==3,"3-2 proceeds to Raven 3-3 without caves alias collision");
        with(GameCont) scrHMAreaAdvance();
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("junkyard")&&GameCont.subarea==4,"Raven exits into extended junkyard 3-4");
        with(GameCont) scrHMAreaAdvance();
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("junkyard")&&GameCont.subarea==5,"extended junkyard retains 3-5");
        with(GameCont) scrHMAreaAdvance();
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("caves")&&GameCont.subarea==1,"3-5 proceeds to caves 4-1");
        GameCont.area=_saved[0];GameCont.subarea=_saved[1];
        var _dest=scrHMConsoleDestination(5,3);
        scrHMGameplayCheck(_dest[0]==scrHMAreaResolve("city")&&_dest[1]==3,"console 5-3 resolves to Titank arena");
        _dest=scrHMConsoleDestination(2,2);
        scrHMGameplayCheck(_dest[0]==scrHMAreaResolve("sewers")&&_dest[1]==2,"console 2-2 resolves to Hardmode sewers");
        _dest=scrHMConsoleDestination(3,3);
        scrHMGameplayCheck(_dest[0]==scrHMAreaResolve("ravenboss"),"console 3-3 resolves to Raven");
        UberCont.opt_console=false;UberCont.opt_orig_console=false;
        scrHMGameplayCheck(!UberCont.opt_console,"console preference can be off independently of run build");
        var _flame=instance_create(player.x+40,player.y,Flame);
        with(_flame) {_flame=hm_enemies_mod_gml_Flame_create(x,y);}
        scrHMGameplayCheck(instance_exists(_flame)&&_flame.name=="Flame"&&_flame.deflected==false,"native Flame conversion initializes all inherited fields");
        scrHMGameplayCheck(is_real(_flame.knockback_speed)&&is_real(_flame.team),"converted Flame retains recoil and team");
        var _oldmusic=MusCont.music_sound,_song=MusCont.song;
        scrHMSoundMusic(_song);
        scrHMGameplayCheck(MusCont.music_sound==_oldmusic,"same area theme keeps playback handle");
        with(MusCont) event_perform(ev_alarm,11);
        if(scrHMAreaHas(GameCont.area)) scrHMGameplayCheck(MusCont.song==_song,"native area alarm cannot replace custom theme with silence");
        scrHMGameplayCheck(scrHMLocalize("REACH THE FROZEN CITY")=="抵达冰冻都市","unlock hints use Chinese catalog");
    }
    if(mode=="sewer103" && ticks==40) {
        scrHMGameplayCheck(instance_exists(PizzaEntrance),"2-2 delayed area_start produces pizza manhole");
        scrHMGameplayCheck(MusCont.song==custom_sound_check(mus2),"sewer theme survives room-start alarm");
        var _old=MusCont.music_sound;
        with(GameCont) scrHMAreaCall(GameCont.area,"area_setup");
        scrHMGameplayCheck(MusCont.music_sound==_old,"next stage with same song does not restart music");
        var _floor=instance_furthest(player.x,player.y,Floor);
        bank_x=_floor.x;bank_y=_floor.y;
        bank_wall=collision_point(bank_x+56,bank_y+8,Wall,false,false);
        if(!instance_exists(bank_wall)) bank_wall=instance_create(bank_x+48,bank_y,Wall);
        with(instance_create(bank_x+48,bank_y,PortalClear)) {hm_water_clear=true;scrHMSewerBank(other.bank_wall);}
        var _plain=0;
        with(Floor) if(x==other.bank_x+48&&y==other.bank_y&&sprite_index==sprFloor2) _plain++;
        scrHMGameplayCheck(_plain>0,"water bank clearance creates an intact floor");
    }
    if(mode=="sewer103" && ticks==20) {
        var _water=noone,_near=infinity;
        with(Floor) if(traction==2 && point_distance(x+16,y+16,other.player.x,other.player.y)<_near) {
            _water=id;_near=point_distance(x+16,y+16,other.player.x,other.player.y);
        }
        scrHMGameplayCheck(instance_exists(_water),"sewer generates swimmable water");
        player.x=_water.x+16;player.y=_water.y+16;
    }
    if(mode=="sewer103" && ticks==30) scrHMGameplayCheck((player[$ "swimming"]??false)&&player.image_alpha==0,"real water entry uses the cropped swimming renderer");
    if(mode=="horror103" && ticks==10) {
        scrHMGameplayIsolate103();
        guardian=instance_create(player.x+100,player.y,DogGuardian);
    }
    if(mode=="horror103" && ticks==12) {
        // Let b24 set its real guardian drop before combat. An instant kill
        // in the creation callback bypassed that source hook at 60 FPS;
        // restored walking children could absorb the larger native drop
        // and legitimately split, invalidating the old exact-count check.
        scrHMGameplayCheck(guardian.norads==1,"normal MOD guardian radiation setup runs before the combat death");
        scr_hit(guardian,10000,HitId.Player);
    }
    if(mode=="horror103" && ticks==60) {
        var _count=0;
        with(HostileHorror) {
            _count++;
            scrHMGameplayCheck(hp<=16&&max_hp==16,"guardian child has sixteen effective HP");
            scrHMGameplayCheck(spr_idle==sprEnemyHorrorIdle&&sprite_index!=sprMutant11Idle,"guardian child uses hostile Horror art");
            scrHMGameplayCheck(ammo==0&&charge==100,"guardian child cannot fire radiation beam");
        }
        show_debug_message("HARDMODE HORROR103 CHILDREN "+string(_count));
        scrHMGameplayCheck(_count==3,"dog guardian corpse generates three Horrors after normal source initialization");
        scrHMGameplayCheck(!instance_exists(HorrorBullet),"guardian child creates no radiation projectiles");
        with(HostileHorror) scr_hit(id,16,HitId.Player);
    }
    if(mode=="horror103" && ticks==70) scrHMGameplayCheck(!instance_exists(HostileHorror),"sixteen damage kills all guardian children");
    if(mode=="caves103" && ticks==10) {
        scrHMGameplayCheck(instance_exists(HyperCrystal),"cursed caves contain HyperCrystal");
        with(InvSpider) hp=max_hp;
        with(HyperCrystal) {nospin=0;direction=0;hm_test_x=x;}
        cursed_ammo=instance_create(player.x+100,player.y+100,CursedPickup);
    }
    if(mode=="caves103" && ticks==25) {
        var _moved=false;with(HyperCrystal) if(abs(x-hm_test_x)>.2) _moved=true;
        scrHMGameplayCheck(_moved,"HyperCrystal can move with identical idle/fire sprites");
        with(HyperCrystal) hp=0;
    }
    if(mode=="caves103" && ticks==220) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("caves"),"HyperCrystal death restores ordinary caves");
        scrHMGameplayCheck(!instance_exists(InvSpider)&&!instance_exists(InvLaserCrystal),"cursed spiders and crystals are converted");
        var _cursed=0;with(Floor) if(array_contains([sprFloor104,sprFloor104B,sprFloor104Explo],sprite_index)) _cursed++;
        scrHMGameplayCheck(_cursed==0,"restoration wave converts all cursed floors");
        if(instance_exists(cursed_ammo)) scrHMGameplayCheck(cursed_ammo.object_index==AmmoPickup&&!cursed_ammo.cursed,"restoration decurses modern ammunition subclass");
        scrHMGameplayCheck(array_length(global.hm_tasks)<100,"terrain conversion finishes without growing continuation queue");
    }
    if(mode=="fist103" && ticks==10) {
        scrHMGameplayIsolate103();
        fist=instance_create(player.x+30,player.y,CustomProjectile);
        with(fist) {name="testfist";sprite_index=sprFlakBullet;mask_index=mskFlakBullet;team=1;speed=8*timescale;direction=0;
            hm_fist_timer0=0;hm_fist_timer1=0;alarm[0]=-1;alarm[1]=-1;hitid=HitId.None;
            on_step=hm_bosses_gatorboss_mod_gml_Gatorfist;on_wall=hm_bosses_gatorboss_mod_gml_Gatorfist_wall;}
        fist_wall=instance_create(fist.x+24,fist.y,Wall);
    }
    if(mode=="fist103" && ticks==18) {
        scrHMGameplayCheck(instance_exists(fist),"gator fist survives passage through wall");
        scrHMGameplayCheck(!instance_exists(fist_wall),"gator fist clears obstructing wall");
        scrHMGameplayCheck(fist.hm_fist_timer1>=8,"fist age increments independently of native alarms");
    }
    if(mode=="fist103" && ticks==26) scrHMGameplayCheck(instance_exists(SmallExplosion),"gator fist produces delayed explosions along path");
    if(mode=="laser103" && ticks==10) {
        scrHMGameplayIsolate103();
        laser_tank=hm_enemies_mod_gml_IDPDTank_create(player.x+70,player.y,0);
        with(laser_tank) {spawnanimation=0;spr_idle=global.hm_module_vars[$ "mod:enemies"].IDPDTankidle;alrm1=1;gunangle=180;speed=0;}
        laser_seen=false;
    }
    if(mode=="laser103" && ticks>10) {
        with(Laser) if(self[$ "hm_idpd_beam"]??false) {
            other.laser_seen=true;
            scrHMGameplayCheck(alarm[0]<0,"IDPD beam does not retrace from endpoint");
            scrHMGameplayCheck(abs(angle_difference(image_angle,point_direction(xstart,ystart,x,y)))<1,"IDPD beam points from muzzle toward impact");
            scrHMGameplayCheck(image_xscale>0,"IDPD beam uses native positive length");
        }
    }
    if(mode=="laser103" && ticks==250) scrHMGameplayCheck(laser_seen,"IDPD tank actually fires its charged beam");
    if(mode=="skull103" && ticks==20) {
        var _found=0;with(CustomHitme) if(name=="fishskull") {
            _found++;
            scrHMGameplayCheck(hp==(GameCont.loops>0?3000:100)&&max_hp==hp,"oasis fish skull has requested loop-dependent HP");
        }
        scrHMGameplayCheck(_found==1,"full-health 1-2 generation contains one fish skull");
    }
    if(mode=="bounds103" && ticks==10) {
        scrHMGameplayIsolate103();
        rescued=hm_enemies_mod_gml_elitebandit_create(9500,9500,0);
        wall_actor=instance_create(9500,9500,Wall);wall_static=instance_create(9500,9500,LaserCrystal);
        initial_static=[wall_static.x,wall_static.y];
    }
    if(mode=="bounds103" && ticks==60) {
        scrHMGameplayCheck(instance_exists(rescued)&&rescued.hp>0,"off-map walking bandit is rescued alive");
        with(rescued) scrHMGameplayCheck(place_meeting(x,y,Floor)&&!place_meeting(x,y,Wall),"rescued bandit stands on usable floor");
        scrHMGameplayCheck(instance_exists(wall_static)&&wall_static.x==initial_static[0]&&wall_static.y==initial_static[1],"wall crystal remains an authored wall enemy");
    }
    if(mode=="scorpion103" && ticks==10) {
        scrHMGameplayIsolate103();
        // This fixture measures the death sequence's own 30 Hz timeline.
        // Cinematic pause/resume is exercised separately by scorpion105.
        scrHMModSet("mod","options","bossoutros","0");
        loop_scorpion=hm_bosses_scorpionboss_mod_gml_scorpionboss_create(player.x+100,player.y);
        loop_scorpion.intro=1;
        scorpion_initial103=false;scorpion_final103=false;
    }
    if(mode=="scorpion103" && ticks==30) scr_hit(loop_scorpion,100000,HitId.Player);
    if(mode=="scorpion103" && ticks>30) {
        var _initial=0,_final=0;
        with(EnemyBullet2) {
            if(self[$ "fakeEnemyBullet"]??false) _initial++;
            if(self[$ "fancy"]??false) _final++;
        }
        if(_initial>200) scorpion_initial103=true;
        if(_final>0 && !scorpion_final103) {
            scorpion_final103=true;
            show_debug_message("HARDMODE SCORPION103 WAVE "+json_stringify({tick:ticks,count:_final}));
        }
    }
    if(mode=="scorpion103" && ticks==62) {
        scrHMGameplayCheck(scorpion_initial103,"loop scorpion delayed death burst survives boss destruction");
    }
    if(mode=="scorpion103" && ticks==130) {
        scrHMGameplayCheck(scorpion_final103,"loop scorpion final accelerated death wave is emitted");
    }
    if(mode=="exit103" && ticks==20) {
        with(enemy) hp=0;
    }
    if(mode=="exit103" && ticks>=20 && instance_exists(Portal)) {
        var _safe=instance_furthest(Portal.x,Portal.y,Floor);
        if(instance_exists(_safe)) {player.x=_safe.x+16;player.y=_safe.y+16;}
    }
    if(mode=="exit103" && ticks==150) {
        var _corpses=[];with(Corpse) array_push(_corpses,[object_get_name(object_index),alarm[0],self[$ "hm_exit_corpse"]]);
        show_debug_message("HARDMODE CLEARANCE "+json_stringify({enemies:instance_number(enemy),becoming:instance_number(becomenemy),pending:scrHMPendingBoss(),corpses:_corpses}));
        scrHMGameplayCheck(!scr_check_enemies(),"ordinary fifth-area enemies are all cleared");
        scrHMGameplayCheck(instance_exists(Portal),"ordinary fifth-area clearance produces exit");
    }
    if(mode=="goto103" && ticks==10) {
        scrHMGameplayCheck(scrHMConsoleCommand("5-3",1),"console accepts Hardmode destination");
    }
    if(mode=="goto103" && ticks==100) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("city")&&GameCont.subarea==3&&GameCont.loops==1,"real console transition reaches exact extended destination");
        var _spawner=false;with(CustomObject) if(name=="wanttitank") _spawner=true;
        scrHMGameplayCheck(_spawner,"console destination retains real Hardmode boss spawner");
    }
    if(mode=="performance103" && ticks==10) {
        scrHMGameplayIsolate103();
        repeat(512) with(instance_create(9500+random(400),9500+random(400),EnemyBullet2)) {team=1;speed=0;friction=0;}
        var _old=[],_now=[];
        repeat(30) {
            var _start=get_timer(),_targets=scrHMInstances(scrHMMatching(projectile,"team",1));
            var _previous=get_timer()-_start;
            var _start=get_timer(),_direct=scrHMMatching(projectile,"team",1);
            array_push(_old,_previous);array_push(_now,get_timer()-_start);
            scrHMGameplayCheck(array_length(_targets)==512&&array_length(_direct)==512,"optimized projectile filter preserves full snapshot");
        }
        array_sort(_old,true);array_sort(_now,true);
        show_debug_message("HARDMODE FILTER PROFILE "+json_stringify({projectiles:512,before_us:_old[15],after_us:_now[15],samples:30}));
    }
    if(mode=="route103" && room_ticks==60) {
        var _expected=[[3,1],[3,2],[scrHMAreaResolve("ravenboss"),3],[scrHMAreaResolve("junkyard"),4],[scrHMAreaResolve("junkyard"),5],[scrHMAreaResolve("caves"),1]];
        var _index=route_rooms-1;
        scrHMGameplayCheck(_index<array_length(_expected),"targeted route has six stages");
        scrHMGameplayCheck(GameCont.area==_expected[_index][0]&&GameCont.subarea==_expected[_index][1],"real junkyard route visits each expected stage in order");
        if(_index<5) {GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0;GameCont.can_advance_stage=true;GameCont.is_level_ended=true;room_restart();}
    }
}

function scrHMGameplayRender103() {
    if(!surface_exists(application_surface)) return;
    if(mode=="sewer103" && ticks==60) surface_save(application_surface,game_directory+"swimming.png");
    if(mode=="laser103" && !(self[$ "laser_captured"]??false)) {
        var _beam=false;with(Laser) if(self[$ "hm_idpd_beam"]??false) _beam=true;
        if(_beam) {surface_save(application_surface,game_directory+"idpd-laser.png");laser_captured=true;}
    }
}

function scrHMGameplayRepairs104() {
    if(mode=="errors104" && ticks==10) {
        scrHMGameplayIsolate103();
        var _ring=instance_create(player.x+60,player.y,ReviveCircle);
        var _corpse=instance_create(_ring.x,_ring.y,Corpse);
        _corpse.specialrevive="rogue";_corpse.sprite_index=sprGruntDead;_corpse.mask_index=mskBandit;
        _ring.alarm[0]=4;
        with(HMWorld) hm_props_mod_gml_step();
        scrHMGameplayCheck(!instance_exists(_corpse),"revive field uses the native other.alarm[0] without an unset alarm0");
        var _boss=hm_bosses_gatorboss_mod_gml_gatorboss_create(player.x+90,player.y);
        _boss.target=player;_boss.targetvisible=1;_boss.alrm2=2;_boss.alrm0=20;
        instance_create(player.x+50,player.y,Gator);
        instance_destroy(player,false);
        gator104=_boss;
    }
    if(mode=="errors104" && ticks==40) {
        scrHMGameplayCheck(instance_exists(gator104),"gator AI survives player destruction for thirty ticks");
        scrHMGameplayCheck(!gator104.targetvisible,"gator cannot command friends against a dead player");
    }
    if(mode=="raven104" && ticks==10) {
        scrHMGameplayIsolate103();
        scrHMModSet("mod","options","intropan","0");UberCont.opt_bossintros=0;
        // Deep walls may be packed into larger collision blocks. A stable
        // floor lane opens their actual footprint instead of deleting by origin.
        for(var _i=0;_i<12;++_i) for(var _j=0;_j<6;++_j) instance_create(14000+32*_i,14000+32*_j,Floor);
        player.x=14048;player.y=14096;
        raven104=hm_bosses_ravenboss_mod_gml_ravenboss_create(14144,14096);
        with(raven104) {flying=false;z=0;sprite_index=spr_idle;alrm2=0;alrm3=0;alrm4=0;alrm1=1;alrm0=1000;ammo=3;target=other.player;targetvisible=1;}
    }
    if(mode=="raven104" && ticks==12) {
        // A legitimate random liftoff can refill ammo on the same tick as
        // firing. Observe real projectiles rather than infer firing from ammo.
        var _shots=0;with(JockRocket) if(creator==other.raven104) {_shots++;instance_destroy(id,false);}
        scrHMGameplayCheck(_shots>0,"Raven fires its real native rocket while standing");
        with(raven104) {x=14144;y=14096;speed=0;flying=false;z=0;sprite_index=spr_walk;alrm2=0;alrm3=0;alrm4=0;alrm0=1000;alrm1=1;ammo=3;}
    }
    if(mode=="raven104" && ticks==14) {
        var _shots=0;with(JockRocket) if(creator==other.raven104) _shots++;
        scrHMGameplayCheck(_shots>0,"Raven fires a new native rocket while walking too");
    }
    if(mode=="water104" && ticks==25) {
        water104=noone;dry104=noone;
        with(Floor) {
            if(traction==2 && !instance_exists(other.water104)) other.water104=id;
            if(traction!=2 && object_index==Floor && !instance_exists(other.dry104)) other.dry104=id;
        }
        scrHMGameplayCheck(instance_exists(water104)&&instance_exists(dry104),"sewer has actual water cells and dry bank cells");
        player.x=water104.x+16;player.y=water104.y+16;
        with(HMWorld) scrHMSewerTick();
        scrHMGameplayCheck(player.swimming&&player.image_alpha==0,"point in actual water enters swimming");
        player.x=dry104.x+16;player.y=dry104.y+16;
        var _decoration=instance_create(player.x,player.y,CustomObject);_decoration.sprite_index=mskPlayer;
        with(HMWorld) scrHMSewerTick();
        scrHMGameplayCheck(!player.swimming&&player.image_alpha==1,"overlapping unrelated custom props cannot keep a swimmer on land");
        scrHMGameplayCheck(!scrHMWaterAt(dry104.x+16,dry104.y+16),"dry bank has no swim state despite adjacent water");
        var _lid=noone;with(PizzaEntrance) {_lid=id;break;}
        scrHMGameplayCheck(instance_exists(_lid)&&_lid.depth<dry104.depth,"pizza manhole is above the final bank depth");
        var _samples=[];repeat(40) {
            var _start=get_timer();with(HMWorld) scrHMSewerTick();array_push(_samples,get_timer()-_start);
        }
        array_sort(_samples,true);show_debug_message("HARDMODE SEWER104 PROFILE "+json_stringify({median_us:_samples[20],entities:instance_number(hitme),floors:instance_number(Floor),walls:instance_number(Wall)}));
    }
    if(mode=="walls104" && ticks==10) {
        var _interior=0,_checked=0;with(Wall) if((self[$ "hm_interior_wall"]??false) && distance_to_point(10016,10016)<4096) {
            _interior++;
            if(_checked<100) {scrHMGameplayCheck(position_meeting(x+8,y+8,Wall),"interior wall cell retains native collision");_checked++;}
        }
        scrHMGameplayCheck(_interior>100,"interior is filled beyond the former two edge layers");
        var _old=GameCont.area;GameCont.area=scrHMAreaResolve("caves");
        scrHMWallThemeStart(player);
        wall_target104=scrHMAssetIndex("sprWall"+string(GameCont.area)+"Top");
        wall_trans104=scrHMAssetIndex("sprWall"+string(GameCont.area)+"Trans");
    }
    if(mode=="walls104" && ticks==245) {
        var _outer=0;
        with(Wall) if(distance_to_point(10016,10016)<4096) {
            if(topspr!=other.wall_target104) show_debug_message("HARDMODE WALL104 MISMATCH "+json_stringify({x:x,y:y,actual:topspr,target:other.wall_target104,area:GameCont.area,queue:array_length(HMWorld.hm_wall_theme_queue),index:HMWorld.hm_wall_theme_index}));
            scrHMGameplayCheck(topspr==other.wall_target104,"wall theme wave reaches outer and inner wall tops");
            if(self[$ "hm_interior_wall"]??false) _outer++;
        }
        with(TopSmall) if(distance_to_point(10016,10016)<4096) scrHMGameplayCheck(sprite_index==other.wall_trans104,"outer transition tiles follow the same color change");
        scrHMGameplayCheck(_outer>100,"color update preserves interior collisions");
    }
    if(mode=="walls104" && ticks==250) {
        var _samples=[];
        repeat(32) {
            var _wall=instance_nearest(player.x,player.y,Wall),_xx=_wall.x,_yy=_wall.y;
            var _start=get_timer();scrWallDestroy(_wall);array_push(_samples,get_timer()-_start);
            scrHMGameplayCheck(position_meeting(_xx+8,_yy+8,FloorExplo)&&!position_meeting(_xx+8,_yy+8,Wall),"native wall destruction opens each new collision cell");
        }
        array_sort(_samples,true);
        show_debug_message("HARDMODE WALLBREAK104 PROFILE "+json_stringify({median_us:_samples[16],maximum_us:_samples[31],walls:instance_number(Wall),samples:32}));
    }
    if(mode=="oasis104" && ticks==10) {
        scrHMGameplayCheck(!TopCont.darkness,"Oasis is a bright area independent of its numeric custom ID");
    }
    if(mode=="intro104" && ticks==10) {
        scrHMGameplayIsolate103();
        var _bullet=instance_create(player.x+20,player.y,EnemyBullet2);_bullet.speed=2*timescale;
        intro_bullet104=_bullet;intro_speed104=_bullet.speed;
        var _waterfloor=instance_nearest(player.x+32,player.y,Floor);_waterfloor.traction=2;
        HMWorld.hm_water_map=undefined;
        intro_gator104=instance_create(_waterfloor.x+16,_waterfloor.y+16,BuffGator);
        scrHMGameplayCheck(scrHMWaterAt(intro_gator104.x,intro_gator104.y),"intro fixture places the gator in real water");
        intro_target104=instance_create(player.x+180,player.y-60,CustomObject);
        intro_start104=point_distance(view_xview_center,view_yview_center,intro_target104.x,intro_target104.y);
        hm_bosses_bossintros_mod_gml_boss_trigger("BIG BIRD",mskNone,mskNone,mskNone,intro_target104,0);
        var _intro=noone;with(CustomObject) if(name=="bossintro") {_intro=id;break;}
        scrHMGameplayCheck(global.hm_camera_targets[player.index]==_intro,"intro explicitly owns the active camera target");
        scrHMGameplayCheck(player.hm_portrait_frozen&&_bullet.hm_portrait_frozen,"portrait freezes actors and projectiles once");
        with(HMWorld) scrHMSewerTick();
        scrHMGameplayCheck(intro_gator104.speed==0,"sewer global water tick cannot move a portrait-frozen gator");
        var _start=get_timer();with(_intro) scrHMBossStep104();
        show_debug_message("HARDMODE INTRO104 PROFILE "+json_stringify({step_us:get_timer()-_start,records:array_length(_intro.hm_portrait_records)}));
    }
    if(mode=="intro104" && ticks==18) {
        scrHMGameplayCheck(point_distance(view_xview_center,view_yview_center,intro_target104.x,intro_target104.y)<intro_start104*.7,"real BackCont camera moves toward the cinematic target");
    }
    if(mode=="intro104" && ticks==80) {
        scrHMGameplayCheck(player.can_walk&&player.can_spec&&!player.hm_portrait_frozen,"portrait restores player movement and skills");
        scrHMGameplayCheck(global.hm_camera_targets[player.index]==player,"camera returns to the player after the portrait");
        if(instance_exists(intro_bullet104)) scrHMGameplayCheck(!intro_bullet104.hm_portrait_frozen,"projectile is released after the portrait");
    }
    if(mode=="earlytank104" && ticks==10) {
        scrHMGameplayIsolate103();scrHMModSet("mod","options","intropan","0");UberCont.opt_bossintros=0;
        with(HMWorld) hm_bosses_titank_mod_gml_titank_create(other.player.x+80,other.player.y);
        tank_killed104=false;tank_time104=-1;
    }
    if(mode=="earlytank104" && ticks>10 && !tank_killed104) {
        var _tank=noone;with(CustomEnemy) if(name=="titank") {_tank=id;break;}
        if(instance_exists(_tank) && (_tank[$ "hm_feet_ready"]??false)) {
            scrHMGameplayCheck(array_length(_tank.hm_feet)==_tank.legs,"all leg receivers are tracked independently");
            for(var _i=0;_i<_tank.legs;++_i) _tank.hm_feet[_i].hp=0;
            tank_killed104=true;tank_time104=ticks;tank_body104=_tank;
        }
    }
    if(mode=="earlytank104" && ticks>10 && tank_killed104 && ticks==tank_time104+30) {
        scrHMGameplayCheck(!instance_exists(tank_body104)||tank_body104.hp<=0,"delayed intro cannot heal a tank whose legs died early");
    }
    if(mode=="earlytank104" && ticks==700) scrHMGameplayCheck(tank_killed104&&!instance_exists(tank_body104),"early simultaneous leg kills complete the real death sequence");
    if(mode=="unlocks104" && ticks==10) {
        var _old=GameCont.area;
        var _areas=["sewers","city","labs","jungle"],_races=[Race.Eyes,Race.Robot,Race.Steroids,Race.Chicken];
        for(var _i=0;_i<array_length(_areas);++_i) {
            scr_race_set_unlocked(_races[_i],false);GameCont.area=scrHMAreaResolve(_areas[_i]);
            with(player) scrUnlocksArea();
            scrHMGameplayCheck(scr_race_is_unlocked(_races[_i]),"entering extended "+_areas[_i]+" unlocks its original character");
        }
        GameCont.area=_old;
        scrHMGameplayCheck(scrHMLocFallback("Weapons:1:Name","PISTOL")==global.language_current[$ "Weapons:1:Name"],"stock keyed Chinese translation takes precedence");
        scrHMGameplayCheck(scrHMLocalize("TITANK")=="泰坦战车","new Hardmode text retains its translation");
    }
    if(mode=="storage104" && ticks==10) {
        var _old=game_directory+"migration-old/",_dest=game_directory+"migration-new/";
        directory_create(_old);directory_create(_dest);
        scrHMGameplayCheck(scrHMStorageWritable(_old)&&scrHMStorageWritable(_dest),"migration roots are writable");
        file_write(_old+"NuclearThrone.sav","{\"progress\":12}");
        if(file_exists(_dest+"NuclearThrone.sav")) file_delete(_dest+"NuclearThrone.sav");
        scrHMStorageMigrate(_old,_dest);
        scrHMGameplayCheck(file_read(_dest+"NuclearThrone.sav")==file_read(_old+"NuclearThrone.sav"),"valid private progress migrates to the new root");
        file_write(_dest+"NuclearThrone.sav","{\"progress\":99}");scrHMStorageMigrate(_old,_dest);
        scrHMGameplayCheck(json_parse(file_read(_dest+"NuclearThrone.sav")).progress==99,"valid imported destination is never overwritten by older progress");
        file_write(_dest+"savegame.dat","continued-run");file_write(_old+"savegame.dat","older-run");scrHMStorageMigrate(_old,_dest);
        scrHMGameplayCheck(file_read(_dest+"savegame.dat")=="continued-run","existing continuation data wins during migration");
    }
}

function scrHMGameplayRender104() {
    if(!surface_exists(application_surface)) return;
    if((mode=="water104"&&ticks==26)||(mode=="oasis104"&&ticks==15)
       ||(mode=="walls104"&&ticks==246)||(mode=="intro104"&&array_contains([12,20,35,60],ticks)))
        surface_save(application_surface,game_directory+mode+"-"+string(ticks)+".png");
}

function scrHMGameplayInput105() {
    if(HMGameplayTest.mode!="water105" || HMGameplayTest.ticks<11 || HMGameplayTest.ticks>105) return;
    KeyCont.moving[index]=1;KeyCont.precisemovement[index]=false;
    KeyCont.hold_east[index]=true;KeyCont.hold_west[index]=false;
    KeyCont.hold_nort[index]=false;KeyCont.hold_sout[index]=false;
    KeyCont.hold_spec[index]=false;KeyCont.hold_fire[index]=false;
}

function scrHMGameplayFrame105() {
    if(mode=="water105" && ticks>=12 && ticks<=100) {
        var _wet=scrHMWaterAt(player.x,player.y);
        scrHMGameplayCheck((player[$ "swimming"]??false)==_wet,"feet crossing restores swimming on the same rendered frame");
        scrHMGameplayCheck(player.image_alpha==(_wet?0:1),"full body and crop never remain together on the bank");
        if(_wet && ticks>20) scrHMGameplayCheck(abs(player.speed/timescale-2)<.1,"actual water movement stays at 2 pixels per logic tick at either rate");
    }
    if(mode=="crystal105" && ticks>=12 && ticks<=40) {
        var _n=0;
        with(HMBinding) if(hm_code==scrHMScriptRef(hm_enemies_mod_gml_bigcrystaltopdraw)) _n++;
        scrHMGameplayCheck(_n==1,"crystal top stays visible above walls on every physical frame without duplicate renderers");
    }
}

function scrHMGameplayRepairs105() {
    if(mode=="water105" && ticks==10) {
        scrHMGameplayIsolate103();
        with(SpiralCont) instance_destroy(id,false);
        for(var _i=0;_i<9;++_i) {
            var _f=instance_create(14000+32*_i,14000,Floor);
            _f.traction=_i<4?2:1;
            if(_i<4) _f.sprite_index=sprFloor4B;
        }
        HMWorld.hm_water_map=undefined;
        player.x=14016;player.y=14016;player.speed=0;player.can_walk=true;
        water_origin105=player.x;
    }
    if(mode=="water105" && ticks==55) {
        water_distance105=player.x-water_origin105;
        show_debug_message("HARDMODE WATER105 "+json_stringify({rate:rate,distance:water_distance105,speed:player.speed/timescale}));
        scrHMGameplayCheck(water_distance105>75&&water_distance105<100,"real held-input motion does not nearly stop in water");
    }
    if(mode=="water105" && ticks==105) {
        scrHMGameplayCheck(player.x>14140&&!player.swimming,"held movement crosses the bank and regains dry speed");
    }
    if(mode=="rogue105" && ticks==10) {
        scrHMGameplayIsolate103();scrHMModSet("mod","options","intropan","0");scrHMModSet("mod","options","bossportraits","0");
        with(Wall) if(distance_to_object(other.player)<200) instance_destroy(id,false);
        rogue105=hm_enemies_mod_gml_enemyrogue_create(player.x+64,player.y);
        with(rogue105) {intro=1;target=other.player;targetvisible=1;alrm1=0;alrm0=1000;walk=0;
            strike_x=x;strike_y=y+70;strike_d=0;}
        strike_seen105={};
    }
    if(mode=="rogue105" && ticks>=11&&ticks<32) {
        var _seen=strike_seen105;
        with(PopoExplosion) if(is_array(hitid) && hitid[1]=="IDPD STRIKE") _seen[$ string(id)]=true;
    }
    if(mode=="rogue105" && ticks==35) {
        scrHMGameplayCheck(array_length(variable_struct_get_names(strike_seen105))==7,"Rogue deploys all seven delayed strike explosions without sprite/sound type error");
        scrHMGameplayCheck(instance_exists(rogue105)&&rogue105.alrm1==-1,"strike coroutine finishes and returns to its cooldown");
    }
    if(mode=="crystal105" && ticks==10) {
        scrHMGameplayIsolate103();
        crystal105=hm_enemies_mod_gml_bigcrystal_create(player.x+48,player.y);
    }
    if(mode=="raven105" && ticks==10) {
        scrHMGameplayIsolate103();scrHMModSet("mod","options","intropan","0");scrHMModSet("mod","options","bossportraits","0");
        raven105=hm_bosses_ravenboss_mod_gml_ravenboss_create(player.x+160,player.y);
        flight_count105=0;land_count105=0;was_flying105=false;flight_age105=0;peak_age105=0;
    }
    if(mode=="raven105" && ticks>10) {
        if(raven105.flying) {
            if(!was_flying105) flight_count105++;
            flight_age105++;
            peak_age105=max(peak_age105,flight_age105);
            // A moving target used to be followed asymptotically forever.
            player.x+=3.5;player.y+=sin(ticks/20)*1.5;
        } else {
            if(was_flying105) land_count105++;
            flight_age105=0;
        }
        was_flying105=raven105.flying;
        if(ticks>300 && !raven105.flying && raven105.z==0 && ticks mod 180==0) raven105.alrm2=1;
        if(ticks mod 60==0) show_debug_message("HARDMODE RAVEN105 STATE "+json_stringify({tick:ticks,fly:raven105.flying,z:raven105.z,zspd:raven105.zspd,x:raven105.x,y:raven105.y,fx:raven105.flight_x,fy:raven105.flight_y,angry:raven105.angry,speed:raven105.speed,age:raven105[$ "hm_flight_age"],locked:raven105[$ "hm_flight_locked"]}));
        scrHMGameplayCheck(flight_age105<240,"giant bird completes its committed flight instead of chasing forever");
    }
    if(mode=="raven105" && ticks==1100) {
        show_debug_message("HARDMODE RAVEN105 "+json_stringify({flights:flight_count105,landings:land_count105,peak:peak_age105}));
        scrHMGameplayCheck(flight_count105>=2&&land_count105>=2,"actual liftoff, pursuit and landing repeat with a moving player");
    }
    if(mode=="walls105" && ticks==10) {
        var _n=0,_edge=0;
        with(Wall) if(self[$ "hm_interior_wall"]??false) {
            if(scrHMInteriorEdge105()) {_n++;scrHMGameplayCheck(position_meeting(x+8,y+8,Wall),"plain exterior cell keeps collision");}
            else _edge++;
        }
        scrHMGameplayCheck(_n>100&&_edge>0,"exterior plain wall fill coexists with textured boundary");
        var _f=instance_nearest(player.x,player.y,Wall);var _x=_f.x,_y=_f.y;
        scrWallDestroy(_f);
        var _near=instance_nearest(_x,_y,Wall);
        scrHMGameplayCheck(!scrHMInteriorEdgeAt105(_near),"breaking wall exposes a textured edge");
        var _fill=noone;with(Wall) if(self[$ "hm_interior_wall"]??false) {if(scrHMInteriorEdge105()) {_fill=id;break;}}
        var _fx=_fill.x,_fy=_fill.y;
        var _new=instance_create(_fx,_fy,Floor);
        scrHMGameplayCheck(instance_exists(_new)&&!position_meeting(_fx+8,_fy+8,Wall),"new structural floor carves synthetic collision without blocking a room or door");
        with(_new) scrHMGameplayCheck(!place_meeting(x,y,Wall),"all four fill cells under new floor are removed");
        var _authored=scrHMAuthoredWalls105();
        for(var _i=0;_i<array_length(_authored);++_i) scrHMGameplayCheck(!(_authored[_i][$ "hm_interior_wall"]??false),"placement enumeration excludes synthetic wall cells");
    }
    if(mode=="outside105" && ticks==10) {
        scrHMGameplayIsolate103();outside105=[];
        var _w=instance_furthest(player.x,player.y,Wall);
        for(var _i=0;_i<7;++_i) {
            var _type=[Raven,Grunt,Inspector,Shielder,EliteGrunt,EliteInspector,EliteShielder][_i];
            var _e=instance_create(_w.x+128+_i*20,_w.y,_type);
            array_push(outside105,_e);
        }
        flying105=instance_create(_w.x+160,_w.y-120,Raven);
        with(flying105) {targetx=other.player.x;targety=other.player.y;z=-32;instance_change(RavenFly,false);event_user(0);}
    }
    if(mode=="outside105" && ticks==50) {
        for(var _i=0;_i<array_length(outside105);++_i) {
            var _e=outside105[_i];
            scrHMGameplayCheck(instance_exists(_e)&&_e.hp>0,"outside walking enemies are recovered alive");
            with(_e) scrHMGameplayCheck(place_meeting(x,y,Floor)&&!place_meeting(x,y,Wall),"Raven and IDPD recover to collision-free floor");
        }
        with(flying105) scrHMGameplayCheck(object_index==Raven && position_meeting(x,y,Floor),"Raven emergency landing selects actual accessible floor");
    }
    if(mode=="palace105" && ticks==10) {
        var _count=0,_duplicates={};
        with(SmallGenerator) {
            var _key=string(x)+","+string(y);
            scrHMGameplayCheck(!(_duplicates[$ _key]??false),"generators do not stack at one nearest-floor position");
            _duplicates[$ _key]=true;_count++;
        }
        show_debug_message("HARDMODE GENERATORS105 "+json_stringify({generators:_count,walls:instance_number(Wall)}));
        scrHMGameplayCheck(_count<45,"static exterior collision does not multiply palace generators");
        scrHMGameplayIsolate103();
        palace_horror105=instance_create(player.x+90,player.y,HostileHorror);
    }
    if(mode=="palace105" && ticks==120) {
        scrHMGameplayCheck(palace_horror105.hp==16&&palace_horror105.max_hp==16,"ordinary palace Horror receives effective sixteen HP at creation");
        scrHMGameplayCheck(palace_horror105.sprite_index!=sprMutant11Idle&&palace_horror105.spr_idle==sprEnemyHorrorIdle,"every palace Horror keeps the enemy art");
        scrHMGameplayCheck(!instance_exists(HorrorBullet)&&palace_horror105.ammo==0,"natural palace Horror fires no radiation beam");
    }
    if(mode=="venuz105" && ticks==10) {
        var _sp=hm_enemies_mod_gml_VenuzSpawn_create(player.x,player.y,"floor",noone);
        scrHMGameplayCheck(_sp.image_blend==scrHMBackgroundColour105(),"Venuz floor spawner reads actual room background rather than an unset instance field");
    }
    if(mode=="dog105" && ticks==10) {
        scrHMGameplayIsolate103();scrHMModSet("mod","options","intropan","0");scrHMModSet("mod","options","bossportraits","0");
        dog105=instance_create(player.x+80,player.y,ScrapBoss);
        with(dog105) {ammo=8;alarm[1]=1;intro=-2;morehp=1;introanimation=11;}
        dog_shot105=noone;dog_bounce105=false;
        instance_create(14064,14000,Wall);
    }
    if(mode=="dog105" && ticks>10 && ticks<25 && !instance_exists(dog_shot105)) {
        with(LHBouncer) if(self[$ "hm_bigdog_bullet"]??false) {other.dog_shot105=id;break;}
        if(instance_exists(dog_shot105)) {
            with(dog_shot105) {scrHMGameplayCheck(bounce,"Big Dog replacement starts with one ricochet");
                x=14032;y=14008;direction=0;speed=4*timescale;}
        }
    }
    if(mode=="dog105" && array_contains([11,15,20,30],ticks))
        show_debug_message("HARDMODE DOG105 STATE "+json_stringify({tick:ticks,base:instance_number(EnemyBullet1),bounce:instance_number(LHBouncer),shot:dog_shot105,alarm1:dog105.alarm[1],ammo:dog105.ammo,paused:UberCont.paused,area:GameCont.area,sub:GameCont.subarea}));
    if(mode=="dog105" && ticks>10 && instance_exists(dog_shot105) && !dog_shot105.bounce) {
        dog_bounce105=true;
        scrHMGameplayCheck(abs(angle_difference(dog_shot105.direction,180))<1,"real native wall collision reflects Big Dog bullet");
    }
    if(mode=="dog105" && ticks==40) scrHMGameplayCheck(dog_bounce105,"actual Big Dog firing completes a wall ricochet");
    if(mode=="font105" && ticks==10) {
        scrHMGameplayIsolate103();
        scrHMGameplayCheck(scrHMChinese(),"font regression executes in Simplified Chinese");
        font_renders105=0;intro_profile105=[];
    }
    if(mode=="font105" && ticks==20) {
        var _boss=instance_create(player.x+120,player.y-30,CustomObject);
        hm_bosses_bossintros_mod_gml_boss_trigger("BIG DOG",global.hm_module_vars[$ "mod:maincode"].Bigdogportrait,
            global.hm_module_vars[$ "mod:maincode"].Bigdogportraitfg,mskNone,_boss,60);
        portrait_task_tick105=global.hm_task_tick;
    }
    if(mode=="font105" && ticks>=22 && ticks<=35) {
        scrHMGameplayCheck(global.hm_task_tick==portrait_task_tick105,"world tasks remain paused beneath the portrait");
        var _start=get_timer();with(HMWorld) scrHMWorldStep();
        array_push(intro_profile105,get_timer()-_start);
    }
    if(mode=="font105" && ticks==80) {
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active)&&!player.hm_portrait_frozen,"portrait releases its world owner and player");
        scrHMGameplayCheck(global.hm_task_tick>portrait_task_tick105,"world resumes after the cinematic");
        scrHMGameplayCheck(font_renders105>=30,"paused and portrait hooks repeatedly preserve Chinese drawing state");
        array_sort(intro_profile105,true);
        show_debug_message("HARDMODE INTRO105 PROFILE "+json_stringify({median_us:intro_profile105[array_length(intro_profile105) div 2],samples:array_length(intro_profile105)}));
    }
    if(mode=="scorpion105" && ticks==10) {
        scrHMGameplayIsolate103();scrHMModSet("mod","options","bossoutros","1");
        scorpion105=hm_bosses_scorpionboss_mod_gml_scorpionboss_create(player.x+100,player.y);scorpion105.intro=1;
        scorpion_burst105=false;scorpion_wave105=false;scorpion_paused105=false;
    }
    if(mode=="scorpion105" && ticks==30) {
        scr_hit(scorpion105,100000,HitId.Player);scorpion_clock105=global.hm_task_tick;
    }
    if(mode=="scorpion105" && ticks>30) {
        if(instance_exists(HMWorld.hm_portrait_active)) scorpion_paused105=true;
        var _elapsed=global.hm_task_tick-scorpion_clock105;
        // Sample the first burst as soon as it appears. Its shots already
        // leave the arena by elapsed 25; the cinematic freezes the scheduler,
        // so wall-clock test ticks cannot stand in for this active timeline.
        var _count=0;with(EnemyBullet2) if(self[$ "fakeEnemyBullet"]??false) _count++;
        if(_count>200) scorpion_burst105=true;
        var _wave=false;with(EnemyBullet2) if(self[$ "fancy"]??false) _wave=true;
        if(_wave) scorpion_wave105=true;
        if(ticks mod 20==0) {
            var _fake=0,_fancy=0;
            with(EnemyBullet2) {if(self[$ "fakeEnemyBullet"]??false) _fake++;if(self[$ "fancy"]??false) _fancy++;}
            show_debug_message("HARDMODE SCORPION105 STATE "+json_stringify({tick:ticks,elapsed:_elapsed,fake:_fake,fancy:_fancy,paused:UberCont.paused,intro:HMWorld.hm_portrait_active,burst_seen:scorpion_burst105,wave_seen:scorpion_wave105}));
        }
    }
    if(mode=="scorpion105" && ticks==230) {
        scrHMGameplayCheck(scorpion_paused105,"actual loop scorpion death enters its cinematic");
        scrHMGameplayCheck(scorpion_burst105&&scorpion_wave105,"both delayed death bursts resume after the cinematic");
    }
}

function scrHMInteriorEdgeAt105(_wall) {var _result=false;with(_wall) _result=scrHMInteriorEdge105();return _result;}

function scrHMGameplayRender105() {
    if(!surface_exists(application_surface)) return;
    if(mode=="font105" && ticks>=11 && ticks<=60) {
        draw_set_font(global.language_font_default);draw_set_color(c_white);draw_set_alpha(.8);
        draw_set_halign(fa_left);draw_set_valign(fa_top);
        var _paused=UberCont.paused;
        if(ticks<20) UberCont.paused=true;
        with(HMWorld) scrHMDrawHooks105(false);
        UberCont.paused=_paused;
        scrHMGameplayCheck(draw_get_font()==global.language_font_default && draw_get_color()==c_white
            && draw_get_alpha()==.8 && draw_get_halign()==fa_left&&draw_get_valign()==fa_top,"pause hook restores complete Chinese text state");
        with(HMWorld) scrHMDrawHooks105(true);
        scrHMGameplayCheck(draw_get_font()==global.language_font_default,"boss GUI hook does not leak the Latin title font");
        draw_set_alpha(1);draw_text_nt(view_xview+12,view_yview+30,"暂停游戏 继续游戏 设置 巨型犬");
        font_renders105++;
    }
    if((mode=="walls105"&&ticks==12)||(mode=="crystal105"&&ticks>=15&&ticks<=17)
        ||(mode=="water105"&&array_contains([30,70,100],ticks))
        ||(mode=="font105"&&array_contains([14,30,55],ticks)))
        surface_save(application_surface,game_directory+mode+"-"+string(ticks)+"-"+string(age)+".png");
}

// Exercise live simulation and rendering. Profiling includes normal Step,
// native collision events and Draw, with the game running and unpaused.
function scrHMGameplayRepairs106() {
    if(mode=="profile106" && ticks==10) {
        frame_samples106=[];
        profile_walls106=instance_number(Wall);
        profile_actors106=instance_number(enemy);
    }
    if(mode=="profile106" && ticks==165) {
        var _samples=frame_samples106;array_sort(_samples,true);
        show_debug_message("HARDMODE FRAME106 "+json_stringify({area:GameCont.area,sub:GameCont.subarea,
            rate:rate,walls:profile_walls106,actors:profile_actors106,samples:array_length(_samples),
            median_us:_samples[array_length(_samples) div 2],p95_us:_samples[floor(array_length(_samples)*.95)]}));
    }
    if(mode=="attack106" && ticks==10) {
        scrHMGameplayIsolate103();
        current_frame=floor(current_frame)+.5;
        // Open a clear, stable test lane; use the actual on_step callbacks,
        // AI timers and projectile creation, rather than directly firing.
        for(var _i=0;_i<16;++_i) for(var _j=0;_j<6;++_j) instance_create(14000+32*_i,14000+32*_j,Floor);
        player.x=14032;player.y=14096;
        attack106=[];attack_seen106={};attack_cooldowns106={};attack_fires106={};
        var _names=["Molefish","Molesarge","Minigunner","Chick"];
        for(var _i=0;_i<array_length(_names);++_i) {
            var _e=scrHMModCall("mod","enemies",_names[_i]+"_create",14128+(_i mod 4)*64,14032+(_i div 4)*96);
            array_push(attack106,_e);
        }
        show_debug_message("HARDMODE COLLISION106 "+json_stringify({none:noone,clear:collision_line(14032,14096,14128,14032,Wall,0,0),
            negated:!collision_line(14032,14096,14128,14032,Wall,0,0)}));
    }
    if(mode=="attack106" && ticks>10) {
        player.x=14032;player.y=14096;player.speed=0;
        var _seen=attack_seen106;
        with(projectile) if(instance_exists(self[$ "creator"]??noone)) _seen[$ string(creator)]=true;
        with(Effect) if((self[$ "name"]??"")=="venuzpistoltrail" && instance_exists(creator)) _seen[$ string(creator)]=true;
        for(var _i=0;_i<array_length(attack106);++_i) {
            var _e=attack106[_i],_key=string(_e);
            var _last=attack_cooldowns106[$ _key]??_e.alrm1;
            if(_e.alrm1>_last+15) attack_fires106[$ _key]=(attack_fires106[$ _key]??0)+1;
            attack_cooldowns106[$ _key]=_e.alrm1;
        }
        if(ticks mod 100==0) {
            var _state=[];
            for(var _i=0;_i<array_length(attack106);++_i) {
                var _e=attack106[_i];
                if(instance_exists(_e)) array_push(_state,[_e.name,_e.targetvisible,_e[$ "alrm1"],_seen[$ string(_e)]??false,_e.x,_e.y,_e.target,_e[$ "firing"],attack_fires106[$ string(_e)]??0]);
            }
            show_debug_message("HARDMODE ATTACK106 "+json_stringify(_state));
            show_debug_message("HARDMODE SHOTS106 "+json_stringify({effects:instance_number(Effect),bullets:instance_number(Bullet1),seen:attack_seen106}));
        }
    }
    if(mode=="attack106" && ticks==1190) {
        for(var _i=0;_i<array_length(attack106);++_i) {
            var _e=attack106[_i];
            scrHMGameplayCheck(attack_seen106[$ string(_e)]??false,"Venus "+_e.name+" creates real projectiles or visible shot trails with its own creator ID");
        }
    }
    if(mode=="natural106") {
        if(ticks==10) natural_shots106=false;
        if(ticks==90) with(enemy) hp=0;
        if(ticks==450) {
            var _tank=noone;with(CustomEnemy) if(name=="titank") _tank=id;
            scrHMGameplayCheck(instance_exists(_tank),"natural Titank entrance completes");
            var _live=0;for(var _i=0;_i<_tank.legs;++_i) if(instance_exists(_tank.hm_feet[_i])&&_tank.hm_feet[_i].hp>0) _live++;
            show_debug_message("HARDMODE NATURAL106 "+json_stringify({legs:_tank.legs,live:_live,hp:_tank.hp,x:_tank.x,y:_tank.y,z:_tank.z,tasks:array_length(global.hm_tasks)}));
            scrHMGameplayCheck(_live==4,"all four natural Titank receivers survive entrance and portrait");
            player.x=_tank.x+80;player.y=_tank.y+100;
        }
        if(ticks==900) {
            var _state=[];with(CustomEnemy) if(name=="titank") array_push(_state,[x,y,z,attacking,hp,foot_hp]);
            show_debug_message("HARDMODE NATURAL106 END "+json_stringify(_state));
            scrHMGameplayCheck(natural_shots106,"natural Titank fires actual projectiles after entrance and portrait");
        }
        if(ticks>450) with(projectile) if(is_array(hitid) && array_length(hitid)>1 && hitid[1]=="Titank") other.natural_shots106=true;
    }
    if(mode=="hunter106" && ticks==10) {
        scrHMGameplayIsolate103();
        for(var _i=0;_i<16;++_i) for(var _j=0;_j<12;++_j) instance_create(14000+32*_i,14000+32*_j,Floor);
        player.x=14064;player.y=14192;
        hunter106=instance_create(14160,14192,LilHunter);hunter106.team=3;
        hunter_idpd106=false;hunter_fire106=false;hunter_native106=0;
    }
    if(mode=="hunter106" && ticks>10 && ticks<85) {
        // Fire the native attack event at both ranges; the original MOD's
        // normal world hook must convert those shots on its following tick.
        if(ticks mod 3==0) {
            with(hunter106) {
                if(object_index!=LilHunter) instance_change(LilHunter,false);
                x=other.player.x+(other.ticks<45?96:160);y=other.player.y;
                speed=0;forceliftoff=false;walk=0;alarm[1]=-1;
                event_perform(ev_alarm,1);
                alarm[1]=-1;
            }
            hunter_native106+=instance_number(EnemyBullet1)+instance_number(LHBouncer);
        } else {
            if(instance_exists(IDPDBullet)) hunter_idpd106=true;
            with(TrapFire) if(sprite_index==sprFireLilHunter && team==3) other.hunter_fire106=true;
        }
    }
    if(mode=="hunter106" && ticks==85) {
        show_debug_message("HARDMODE HUNTER106 "+json_stringify({native:hunter_native106,idpd:hunter_idpd106,fire:hunter_fire106}));
        scrHMGameplayCheck(hunter_native106>0,"native Lil Hunter emits its real attack events");
        scrHMGameplayCheck(hunter_idpd106&&hunter_fire106,"MOD converts native attacks into IDPD bullets and Hunter flames");
    }
    if(mode=="contracts106" && ticks==10) {
        scrHMGameplayIsolate103();
        GameCont.area=scrHMAreaResolve("HQ");
        var _portal=instance_create(player.x+48,player.y,Portal);
        scrHMGameplayCheck(_portal.type==2,"police HQ exit is blue");
        instance_destroy(_portal,false);
        GameCont.area=scrHMAreaResolve("city");
        var _bandit=instance_create(player.x+48,player.y,Bandit);
        scrHMGameplayCheck(_bandit.spr_idle==sprSnowBanditIdle,"native city bandit wears snow art");
        var _custom=hm_enemies_mod_gml_elitebandit_create(player.x+64,player.y,1);
        scrHMGameplayCheck(_custom.spr_idle==sprSnowBanditIdle,"custom armed city bandit wears snow art");
        GameCont.area=scrHMAreaResolve("venuz");
        var _car=hm_props_mod_gml_VenuzCar_create(player.x+80,player.y,0);
        scrHMGameplayCheck(instance_exists(_car),"VenuzCar reads the real background color");
        var _receiver=instance_create(player.x,player.y,CustomEnemy);_receiver.sprite_index=-1;
        with(_receiver) scrHMGameplayCheck(!scrHMSwimSprite106(),"invisible logical receiver skips invalid sprite dimensions");
        var _list=ds_list_create();scrHMWeaponList(_list,6,3);
        scrHMGameplayCheck(ds_list_size(_list)>0,"goto low-hardness weapon range remains nonempty");
        for(var _i=0;_i<ds_list_size(_list);++_i) scrHMGameplayCheck(sprite_exists(scrHMWeaponSprite(_list[| _i])),"goto prop weapons resolve to real sprites");
        ds_list_destroy(_list);
    }
    if(mode=="packed106" && ticks==10) {
        scrHMGameplayIsolate103();
        var _block=scrHMFillBlock106(15008,15008,64,64);
        for(var _i=0;_i<4;++_i) for(var _j=0;_j<4;++_j)
            scrHMGameplayCheck(position_meeting(15016+_i*16,15016+_j*16,Wall),"packed wall retains every collision cell");
        instance_create(15024,15024,Floor);
        var _hole=0,_solid=0,_textured=0;
        for(var _i=0;_i<4;++_i) for(var _j=0;_j<4;++_j) {
            var _open=(_i>=1&&_i<=2&&_j>=1&&_j<=2);
            var _wall=collision_point(15016+_i*16,15016+_j*16,Wall,false,false);
            scrHMGameplayCheck(instance_exists(_wall)!=_open,"new floor removes exactly its four packed collision cells");
            if(instance_exists(_wall)) with(_wall) {if(!scrHMPlainWall106()) _textured++;}
        }
        scrHMGameplayCheck(_textured==12,"new floor exposes a textured boundary around compact exterior");
        var _break=scrHMFillBlock106(15200,15008,64,64);
        with(_break) scrWallDestroy(id);
        scrHMGameplayCheck(position_meeting(15208,15016,FloorExplo),"native destruction materializes and opens one packed cell");
        scrHMGameplayCheck(position_meeting(15256,15064,Wall),"native destruction preserves distant collision in the same packed block");
        bank_test106=scrHMFillBlock106(15408,15008,64,64);
        with(instance_create(15416,15016,PortalClear)) {hm_water_clear=true;scrHMSewerBank(other.bank_test106);}
        var _intact=0,_broken=0;
        with(FloorExplo) if(x>=15408&&x<15472&&y>=15008&&y<15072) {
            if(sprite_index==sprFloor2&&image_index==0) _intact++;else _broken++;
        }
        scrHMGameplayCheck(_intact>0&&_broken==0,"split sewer bank uses intact floors at each new cell");
    }
    if(mode=="throne106" && ticks==10) {
        var _tagged=0;with(Floor) if(self[$ "nokill"]??false) _tagged++;
        show_debug_message("HARDMODE THRONE106 "+json_stringify({tagged:_tagged,floors:instance_number(Floor),walls:instance_number(Wall),
            throne:instance_number(NothingInactive),player_x:player.x,player_y:player.y}));
        scrHMGameplayCheck(_tagged==1 && instance_number(NothingInactive)==1,"throne has exactly one retained seed and one boss");
        scrHMGameplayCheck(!TopCont.darkness,"throne does not inherit darkness from an even custom area ID");
    }
    if(mode=="goto106" && ticks==10) scrHMGameplayCheck(GameCont.hard==0 && instance_number(Floor)>5,"goto snow stage populates successfully at initial hardness zero");
    if(mode=="titank106" && ticks==10) {
        scrHMGameplayIsolate103();
        for(var _i=0;_i<14;++_i) for(var _j=0;_j<14;++_j) instance_create(14000+32*_i,14000+32*_j,Floor);
        player.x=14048;player.y=14048;
        with(HMWorld) hm_bosses_titank_mod_gml_titank_create(14224,14224);
    }
    if(mode=="titank106" && ticks mod 100==0) {
        with(CustomEnemy) if(name=="titank") {
            var _state=[];
            for(var _i=0;_i<legs;++_i) array_push(_state,[foot_hp[_i],hm_feet[_i],instance_exists(hm_feet[_i])]);
            show_debug_message("HARDMODE TITANK106 "+json_stringify({tick:other.ticks,feet:_state,hp:hp,z:z,attack:attacking,
                tasks:array_length(global.hm_tasks),x:x,y:y,weapon:instance_number(projectile),frozen:self[$ "frozen"]??false}));
        }
    }
}

function scrHMGameplayRender106() {
    if(mode=="profile106" && ticks>15 && ticks<160) array_push(frame_samples106,get_timer()-hm_frame_start106);
    if(array_contains(["profile106","throne106","attack106"],mode) && ticks==80 && surface_exists(application_surface))
        surface_save(application_surface,game_directory+mode+"-"+string(GameCont.area)+"-"+string(GameCont.subarea)+".png");
}

// Automated progression through real doors, elevators and boss callbacks.
// The driver positions the player at interaction/combat waypoints and uses
// real native bullet collisions. It never assigns an area, opens a door,
// destroys a blocker, sets enemy HP or calls room_restart to advance.
function scrHMVenusShoot106(_target,_damage=1000) {
    if(!instance_exists(_target)) return;
    with(instance_create(_target.x,_target.y,Bullet1)) {
        team=team_player;creator=HMGameplayTest.player;hitid=HitId.Player;
        damage=_damage;speed=0;image_alpha=0;
    }
}

function scrHMVenusDoorPoint106(_door) {
    var _px=_door.x+16,_py=_door.y,_near=false;
    with(CustomObject) if(name=="star"&&point_distance(x,y,_door.x,_door.y)<96) _near=true;
    if(!_near) {player.x=_px;player.y=_py;player.speed=0;return;}
    var _points=[[16,0],[-16,0],[0,16],[0,-16],[12,12],[-12,12],[12,-12],[-12,-12],[0,0]];
    var _best=-1,_pla=player;
    for(var _i=0;_i<array_length(_points);++_i) {
        var _x=_door.x+_points[_i][0],_y=_door.y+_points[_i][1],_score=1000000;
        _pla.x=_x;_pla.y=_y;
        var _contact=false,_blocked=false;with(_door) _contact=distance_to_object(_pla)<=16;
        with(_pla) _blocked=place_meeting(x,y,Wall)||place_meeting(x,y,InvisiWall);
        if(!_contact||_blocked) continue;
        with(CustomObject) if(name=="star"||name=="VenuzElevator") _score=min(_score,point_distance(x,y,_x,_y));
        if(_score>_best) {_best=_score;_px=_x;_py=_y;}
    }
    player.x=_px;player.y=_py;player.speed=0;
}

function scrHMVenusPark106() {
    if(is_undefined(self[$ "venus_park106"])) {
        var _avoid=[];
        with(CustomObject) if(name=="VenuzElevator"||name=="star") array_push(_avoid,[x,y]);
        with(CustomEnemy) if(name=="ratboss"||name=="ratbosssleep") array_push(_avoid,[x,y]);
        var _best=-1,_point=[player.x,player.y];
        with(Floor) if(x>=0&&y>=0&&x<4096&&y<4096) {
            var _score=1000000;
            for(var _i=0;_i<array_length(_avoid);++_i) _score=min(_score,point_distance(x+16,y+16,_avoid[_i][0],_avoid[_i][1]));
            if(_score>_best) {_best=_score;_point=[x+16,y+16];}
        }
        venus_park106=_point;
    }
    player.x=venus_park106[0];player.y=venus_park106[1];player.speed=0;
}

function scrHMGameplayVenus106() {
    if(!variable_instance_exists(id,"venus_path106")) {
        venus_path106=mode=="venus106"?[1,2,3,4,5,6,7,8,9,10,11,12]:[1,2,3,100,4,5,6,200,7,8,9,300,10,11,400,401,12];
        var _start=0;for(var _i=0;_i<array_length(venus_path106);++_i) if(venus_path106[_i]==GameCont.subarea) {_start=_i;break;}
        if(_start>0) {
            var _trim=[];for(var _i=_start;_i<array_length(venus_path106);++_i) array_push(_trim,venus_path106[_i]);
            venus_path106=_trim;
        }
        venus_index106=-1;venus_sub106=-999;venus_phase106="settle";
        venus_age106=0;venus_phase_age106=0;venus_doors106=0;
        venus_shots106=0;venus_rooms106=[];venus_types106={};
        venus_air106=false;venus_ground106=false;venus_air_hit106=false;
        venus_air_shots106=false;venus_ground_shots106=false;venus_car106=noone;
        venus_air_counters106={};venus_air_projectiles106=false;
        venus_exit_room106=-1;venus_clear106=false;
    }
    GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0;
    // Keep combat waypoints stable under enemy knockback. Enemy damage and
    // AI still run normally; this driver does not test player survivability.
    player.nexthurt=current_frame+3;
    if(GameCont.area!=scrHMAreaResolve("venuz")) {
        scrHMGameplayCheck(venus_index106==array_length(venus_path106)-1,"Venus exit follows every expected stage");
        // Source sets junkyard/subarea=4 before BigPortal. Its normal
        // area_transit then advances to 3-5 in the newly generated room.
        if(venus_exit_room106<0) venus_exit_room106=route_rooms;
        var _ready=player.can_walk&&player.visible&&player.image_alpha>0&&!(player[$ "hm_portrait_frozen"]??false);
        if(route_rooms>venus_exit_room106 && room_ticks>=90 && (_ready||room_ticks>=600)) {
            scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("junkyard")&&GameCont.subarea==5,"Venus car returns through the source transition to junkyard 3-5");
            show_debug_message("HARDMODE VENUS106 RETURN "+json_stringify({ticks:room_ticks,floors:instance_number(Floor),walk:player.can_walk,visible:player.visible,alpha:player.image_alpha,portrait:player[$ "hm_portrait_frozen"],z:player.z,canfly:player.canfly}));
            scrHMGameplayCheck(instance_number(Floor)>5&&_ready,"return transition restores a visible playable character after the normal entry/boss presentation");
            var _boss_evidence={air_seen:venus_air106,ground_seen:venus_ground106,air_attacked:venus_air_shots106,
                ground_attacked:venus_ground_shots106,air_projectiles:venus_air_projectiles106,test_air_damage:venus_air_hit106};
            show_debug_message("HARDMODE VENUS106 BOSS EVIDENCE "+json_stringify(_boss_evidence));
            scrHMGameplayCheck(venus_air106&&venus_ground106&&venus_air_shots106&&venus_ground_shots106,"both natural Gun God phases attack before defeat: "+json_stringify(_boss_evidence));
            show_debug_message("HARDMODE VENUS106 COMPLETE "+json_stringify({path:venus_path106,rooms:venus_rooms106,doors:venus_doors106,enemy_shot_frames:venus_shots106,types:venus_types106,rate:rate,boss:_boss_evidence}));
            goal_ticks=ticks;
        }
        return;
    }
    if(mode=="venus106" && scrHMModGet("area","venuz","secrets")!=0)
        throw "Main Venus driver touched a star: "+json_stringify({sub:GameCont.subarea,phase:venus_phase106,x:player.x,y:player.y});
    var _sub=GameCont.subarea;
    if(_sub!=venus_sub106) {
        show_debug_message("HARDMODE VENUS106 TRANSIT "+json_stringify({observed:_sub,previous:venus_sub106,phase:venus_phase106,index:venus_index106+1,path:venus_path106,secrets:scrHMModGet("area","venuz","secrets")}));
        if(venus_index106>=0) {
            scrHMGameplayCheck(venus_clear106||(venus_sub106==300&&venus_phase106=="clear"),"previous Venus stage cleared through combat before elevator use");
            array_push(venus_rooms106,{sub:venus_sub106,ticks:venus_age106});
        }
        venus_index106++;
        scrHMGameplayCheck(venus_index106<array_length(venus_path106)&&_sub==venus_path106[venus_index106],"natural Venus elevator reaches the next expected stage, got "+string(_sub)+" at index "+string(venus_index106));
        venus_sub106=_sub;venus_age106=0;venus_phase_age106=0;
        venus_phase106="settle";venus_clear106=false;venus_door106=noone;
        venus_park106=undefined;
        show_debug_message("HARDMODE VENUS106 STAGE "+json_stringify({sub:_sub,floors:instance_number(Floor),walls:instance_number(Wall),rate:rate}));
    }
    venus_age106++;venus_phase_age106++;
    if(venus_age106>6000) throw "Venus stage stalls: "+string(_sub)+" phase="+venus_phase106;
    // The source boss can attack and leave its aircraft during the normal
    // arrival interval. Observe from creation, including those settle ticks.
    // Its attackchange decrements only after emitting a real burst. Count
    // that as well as surviving projectiles: a rocket can hit a wall before
    // this End Step observer runs, especially between 60 FPS logic ticks.
    if(_sub==12) {
        with(CustomEnemy) if(name=="GunGod") {
            if(!other.venus_air106) show_debug_message("HARDMODE VENUS106 AIR FIRST "+json_stringify({age:other.venus_age106,hp:hp,attackchange:attackchange,phase:other.venus_phase106}));
            other.venus_air106=true;
            var _key=string(id),_last=other.venus_air_counters106[$ _key]??25;
            if(attackchange!=_last) {
                if(!other.venus_air_shots106) show_debug_message("HARDMODE VENUS106 AIR BURST "+json_stringify({age:other.venus_age106,before:_last,after:attackchange,phase:other.venus_phase106}));
                other.venus_air_shots106=true;
            }
            other.venus_air_counters106[$ _key]=attackchange;
        }
        with(projectile) if(instance_exists(self[$ "creator"]??noone)) {
            var _source=creator;
            if(instance_is(_source,CustomEnemy)&&(_source[$ "name"]??"")=="GunGod") {
                other.venus_air_projectiles106=true;other.venus_air_shots106=true;
            }
        }
        with(CustomEnemy) if(name=="gungod") {
            if(!other.venus_ground106) show_debug_message("HARDMODE VENUS106 GROUND FIRST "+json_stringify({age:other.venus_age106,hp:hp,phase:other.venus_phase106}));
            other.venus_ground106=true;
            if(ammo<255) other.venus_ground_shots106=true;
        }
    }
    with(enemy) if((self[$ "name"]??"")!="portalblocker") other.venus_types106[$ object_get_name(object_index)+":"+(self[$ "name"]??"")]=true;
    with(projectile) if(team!=team_player) {
        other.venus_shots106++;
    }
    if(venus_phase106=="settle" && venus_phase_age106>=90) {
        scrHMGameplayCheck(instance_number(Floor)>5&&!TopCont.darkness,"Venus stage is populated and has no false darkness");
        var _song=(_sub<=3||_sub==100)?"gungodz02":((_sub<=6||_sub==200)?"gungodz03":((_sub<=9||_sub==300)?"gungodz04":(_sub==12?"gungodz07":"gungodz06")));
        if(venus_path106[0]==1 || venus_index106>0) scrHMGameplayCheck(audio_is_playing(custom_sound_check(scrHMModGet("area","venuz",_song))),"Venus stage retains its expected source music while muted");
        with(WepPickup) scrHMGameplayCheck(sprite_index==scrHMWeaponSprite(wep),"Venus weapon pickup retains its actual weapon art");
        var _packed=0;with(Wall) if(self[$ "hm_interior_wall"]??false) _packed++;
        show_debug_message("HARDMODE VENUS106 TERRAIN "+json_stringify({sub:_sub,packed:_packed,walls:instance_number(Wall)}));
        scrHMGameplayCheck(_packed>0,"Venus exterior collision remains compact after a same-room elevator rebuild");
        if(surface_exists(application_surface)) surface_save(application_surface,game_directory+"venus-stage-"+string(_sub)+".png");
        venus_phase106=_sub==12?"bossair":"doors";venus_phase_age106=0;
    }
    if(venus_phase106=="doors") {
        var _door=noone,_number=100000;
        with(CustomObject) if(name=="door" && (self[$ "open"]??-999)==0 && number<_number) {_door=id;_number=number;}
        if(instance_exists(_door)) {
            venus_door106=_door;scrHMVenusDoorPoint106(_door);
            venus_phase106="doorwait";venus_phase_age106=0;
        } else {venus_phase106="clear";venus_phase_age106=0;}
    }
    if(venus_phase106=="doorwait") {
        if(instance_exists(venus_door106) && venus_door106.open==0) {
            scrHMVenusDoorPoint106(venus_door106);
            if(venus_phase_age106>90) throw "Venus door does not react to player contact: "+json_stringify({sub:_sub,door:[venus_door106.x,venus_door106.y,venus_door106.number],player:[player.x,player.y],rate:rate});
        } else if(venus_phase_age106>=75) {
            venus_doors106++;venus_phase106="doors";venus_phase_age106=0;
        }
    }
    if(venus_phase106=="clear") {
        scrHMVenusPark106();
        if(venus_phase_age106 mod 15==0) with(enemy) if((self[$ "name"]??"")!="portalblocker" && hp>0) scrHMVenusShoot106(id);
        var _remaining=0;with(enemy) if((self[$ "name"]??"")!="portalblocker"&&hp>0) _remaining++;
        if(_remaining==0 && venus_phase_age106>=120) {
            venus_clear106=true;venus_phase106="star";venus_phase_age106=0;
        }
    }
    if(venus_phase106=="star") {
        var _star=noone;
        if(mode=="venussecrets106") with(CustomObject) if(name=="star") {_star=id;break;}
        if(instance_exists(_star)) {player.x=_star.x;player.y=_star.y;player.speed=0;}
        else {venus_phase106="exit";venus_phase_age106=0;}
    }
    if(venus_phase106=="exit") {
        var _elevator=noone;with(CustomObject) if(name=="VenuzElevator") {_elevator=id;break;}
        if(instance_exists(_elevator)) {
            player.x=_elevator.x+16;player.y=_elevator.y+16;player.speed=0;
        } else if(venus_phase_age106>180) throw "Venus cleared stage has no elevator: "+string(_sub);
    }
    if(venus_phase106=="bossair") {
        var _boss=noone;with(CustomEnemy) if(name=="GunGod") {_boss=id;break;}
        if(instance_exists(_boss)) {
            venus_air106=true;
            if(venus_phase_age106>=240 && venus_air_shots106 && !venus_air_hit106) {scrHMVenusShoot106(_boss,1200);venus_air_hit106=true;}
        }
        var _ground=noone;with(CustomEnemy) if(name=="gungod") {_ground=id;break;}
        if(instance_exists(_ground)) {venus_ground106=true;venus_phase106="bossground";venus_phase_age106=0;}
    }
    if(venus_phase106=="bossground") {
        var _boss=noone;with(CustomEnemy) if(name=="gungod") {_boss=id;break;}
        if(instance_exists(_boss)) {
            if(_boss.ammo<255) venus_ground_shots106=true;
            player.x=_boss.x+72;player.y=_boss.y;player.speed=0;
            if(venus_phase_age106>240&&venus_ground_shots106&&venus_phase_age106 mod 15==0) scrHMVenusShoot106(_boss,300);
        } else {
            venus_phase106="carwait";venus_phase_age106=0;venus_clear106=true;
            scrHMGameplayCheck(venus_ground106,"ground phase existed before its death creates an escape car");
        }
    }
    if(venus_phase106=="carwait" || venus_phase106=="drive") {
        if(!instance_exists(venus_car106)) with(CustomObject) if(name=="VenuzCar") {other.venus_car106=id;break;}
        if(instance_exists(venus_car106)) {
            var _car=venus_car106;
            if(venus_phase106=="carwait" && _car.z<17) {
                player.x=_car.x;player.y=_car.y;player.speed=0;
                KeyCont.press_pick[player.index]=true;
                with(_car) with(id) scrHMActorCallback("on_step");
                KeyCont.press_pick[player.index]=false;
                scrHMGameplayCheck(_car.driver==player.index,"normal interact input enters the natural escape car");
                venus_exit_room106=route_rooms;
                venus_phase106="drive";venus_phase_age106=0;
            }
            if(venus_phase106=="drive") {
                KeyCont.hold_nort[player.index]=true;
                with(_car) with(id) scrHMActorCallback("on_step");
                KeyCont.hold_nort[player.index]=false;
            }
        }
    }
    if(venus_age106 mod 300==0) {
        var _actors=[];with(enemy) if((self[$ "name"]??"")!="portalblocker") array_push(_actors,[object_get_name(object_index),self[$ "name"],hp,x,y]);
        show_debug_message("HARDMODE VENUS106 PROGRESS "+json_stringify({sub:_sub,phase:venus_phase106,ticks:venus_age106,actors:_actors,doors:venus_doors106}));
    }
}

function scrHMGameplayLane107() {
    scrHMGameplayIsolate103();HMWorld.hm_portrait_active=noone;
    player.frozen=false;player.hm_portrait_frozen=false;
    player.can_walk=true;player.can_pick=true;player.can_spec=true;
    for(var _i=0;_i<16;++_i) for(var _j=0;_j<12;++_j)
        instance_create(14000+_i*32,14000+_j*32,Floor);
    player.x=14064;player.y=14160;player.speed=0;
}

function scrHMGameplayRepairs107() {
    if(mode=="trail107" && ticks==10) {scrHMGameplayLane107();trail_peak107=0;player.gunangle=90;}
    if(mode=="trail107" && ticks>=10 && ticks<=110 && ticks mod 10==0)
        repeat(4) with(player) scrHMWeaponFire(scrHMWeaponResolve("secretweapong1"));
    if(mode=="trail107" && ticks>=10) {
        var _count=0;with(Effect) if((self[$ "name"]??"")=="venuzpistoltrail") _count++;
        trail_peak107=max(trail_peak107,_count);
        if(ticks==180) {
            scrHMGameplayCheck(trail_peak107>4&&trail_peak107<=20,"sustained Venus weapon fire keeps a bounded trail population");
            scrHMGameplayCheck(_count==0,"all real shot trails expire after firing stops");
        }
    }
    if(mode=="car107" && ticks==10) {
        scrHMGameplayLane107();
        car107=hm_props_mod_gml_VenuzCar_create(player.x,player.y,0);
        KeyCont.press_pick[player.index]=true;
        with(car107) with(id) scrHMActorCallback("on_step");
        KeyCont.press_pick[player.index]=false;
        scrHMGameplayCheck(car107.driver==player.index,"actual interaction boards golden car");
    }
    if(mode=="car107" && ticks==25) {
        with(player) scrHMGameplayCheck(scrHMPlayerNativeHidden107()&&image_alpha==0,"car driver is excluded from body, weapon and shadow renderers");
        KeyCont.press_pick[player.index]=true;
        with(car107) with(id) scrHMActorCallback("on_step");
        KeyCont.press_pick[player.index]=false;
        with(player) scrHMGameplayCheck(!scrHMPlayerNativeHidden107()&&can_walk,"bailing onto real floor restores the player renderer and movement");
    }
    if(mode=="fall107" && ticks==10) {
        scrHMGameplayLane107();
        player.fallen_x107=player.x;player.fallen_y107=player.y;
        player.fallen_area107=GameCont.area;
        GameCont.area=scrHMAreaResolve("throne");
        player.fallen_sub107=GameCont.subarea;GameCont.subarea=1;
        player.x=15000;player.y=15000;player.fallen_start107=player.y;
        player.portalfall=player.y;player.fallen_scale107=1;player.fallen_seen107=false;
        player.fallen_floor107=instance_create(player.x,player.y,Floor);
        player.fallen_floor107.x-=1000;
        player.fallen_marker107=instance_create(0,0,Nothing2Death);
        with(player.fallen_marker107) {alarm[0]=-1;image_speed=0;}
    }
    if(mode=="fall107" && ticks==35) {
        scrHMGameplayCheck(player.image_alpha==0&&player.scale<.5&&player.scale>=0,"Throne II actual falling branch shrinks and hides native body");
        scrHMGameplayCheck(player.y>player.fallen_start107+100,"Throne II falling branch retains downward motion");
        instance_destroy(player.fallen_marker107,false);
        player.fallenable=-1;
        with(player) scrHMThroneFall107(false);
        GameCont.area=player.fallen_area107;GameCont.subarea=player.fallen_sub107;
        player.x=player.fallen_x107;player.y=player.fallen_y107;player.spr_shadow_y=0;
        with(player) scrHMGameplayCheck(image_alpha==1&&scale==1,"ending the fall restores normal rendering scale");
    }
    if(mode=="waves107" && ticks==10) {
        waves_seen107=instance_number(WantPopo);vans_seen107=instance_number(WantVan);
        scrHMGameplayCheck(waves_seen107>0&&vans_seen107>0,"native generation schedules loop police and van controllers");
        scrHMGameplayCheck(!GameCont.novans,"MOD does not disable loop vans");
        with(WantVan) {canspawn=true;spawnmoment=2;}
        with(WantPopo) spawnmoment=2;
        waves_portals107=false;waves_vans107=false;waves_police107=false;
    }
    if(mode=="waves107" && ticks>10) {
        if(instance_exists(IDPDSpawn)) waves_portals107=true;
        if(instance_exists(VanSpawn)||instance_exists(Van)) waves_vans107=true;
        if(instance_exists(Grunt)||instance_exists(Inspector)||instance_exists(Shielder)||instance_exists(PopoFreak)) waves_police107=true;
        if(ticks==180) {
            scrHMGameplayCheck(waves_portals107&&waves_police107,"native wave controllers produce portals and real police");
            scrHMGameplayCheck(waves_vans107,"native loop van controller reaches spawn sequence");
        }
    }
    if(mode=="portraitprofile107" && ticks==10) {
        portrait_samples107=[];portrait_spawn107=0;
        // The actual natural scene remains present beneath the real layers.
        for(var _i=0;_i<96;++_i) with(instance_create(player.x+160+(_i mod 16)*24,player.y+(_i div 16)*24,EnemyBullet2)) {
            speed=0;alarm[0]=900;
        }
    }
    if(mode=="portraitprofile107" && ticks==45) {
        var _start=get_timer();
        hm_bosses_bossintros_mod_gml_boss_trigger("BIG DOG",scrHMModGet("mod","maincode","Bigdogportrait"),scrHMModGet("mod","maincode","Bigdogportraitfg"),mskNone,player,60);
        portrait_spawn107=get_timer()-_start;
    }
    if(mode=="portraitprofile107" && ticks==150) {
        show_debug_message("HARDMODE PORTRAIT107 "+json_stringify({spawn_us:portrait_spawn107,frames:portrait_samples107}));
        scrHMGameplayCheck(array_length(portrait_samples107)>40,"real portrait frame profile collected across entry, display and exit");
        scrHMGameplayCheck(!instance_exists(variable_instance_get(HMWorld,"hm_portrait_active")??noone),"profiled portrait finishes and releases the live scene");
    }
    if(mode=="contracts107" && ticks==10) {
        scrHMGameplayLane107();
        var _area=GameCont.area,_sub=GameCont.subarea;
        player.extra_weps=[wep_revolver,wep_shotgun];
        player.extra_weps_reload=[9,8];player.extra_weps_curse=[true,true];
        player.extra_weps_can_shoot=[false,false];
        GameCont.area=scrHMAreaResolve("venuz");GameCont.subarea=1;
        with(GameCont) scrHMAreaCall(area,"area_setup");
        scrHMGameplayCheck(player.wep==0&&player.bwep==0&&array_length(player.extra_weps)==0,"actual Venus loadout removes every old weapon slot");
        scrHMGameplayCheck(array_length(player.extra_weps_reload)==0&&array_length(player.extra_weps_can_shoot)==0,"Venus clears matching extra-slot state");
        GameCont.area=_area;GameCont.subarea=_sub;
        player.wep=wep_revolver;player.bwep=wep_shotgun;
        var _level=GameCont.level,_green=instance_create(player.x+64,player.y,FastRat);
        GameCont.level=1;with(_green) scrHMRadiationSync(true);
        scrHMGameplayCheck(_green.raddrop==0,"green rat retains MOD drop before maximum level");
        GameCont.level=PLAYER_LEVEL_MAX;repeat(5) with(_green) scrHMRadiationSync(false);
        scrHMGameplayCheck(_green.raddrop==4,"green rat equals native ordinary rat after maximum level, without repeated addition");
        _green.raddrop+=5;with(_green) scrHMRadiationSync(false);
        scrHMGameplayCheck(_green.raddrop==9,"green rat preserves absorbed radiation");
        with(Rad) instance_destroy(id,false);
        _green.hp=0;instance_destroy(_green);
        var _rads=0;with(Rad) _rads+=object_index==BigRad?10:1;
        scrHMGameplayCheck(_rads==9,"green rat actual death drops base plus absorbed radiation");
        GameCont.level=_level;
    }
    if(mode=="prompt107" && ticks==10) {
        scrHMGameplayLane107();
        hm_props_mod_gml_leave_create(player.x,player.y);
        prompt107=noone;with(CustomObject) if(name==" leave") other.prompt107=id;
        scrHMGameplayCheck(instance_exists(prompt107),"source interaction object is created");
        prompt_frames107=0;
    }
    if(mode=="prompt107" && ticks==36) player.x+=100;
    if(mode=="prompt107" && ticks==40) {
        var _n=0;with(HMBinding) if(hm_code==scrHMScriptRef(hm_props_mod_gml_E)) _n++;
        scrHMGameplayCheck(_n==0,"interaction hint expires after leaving range");
        scrHMGameplayCheck(prompt_frames107>=20,"interaction renderer was checked on physical frames");
    }
    if(mode=="retry107" && ticks==10) {
        retry_sub107=GameCont.subarea;
        retry_old107=scrWeaponPickupCreate(player.x+40,player.y,wep_revolver);
        retry_old207=scrWeaponPickupCreate(player.x+56,player.y,wep_shotgun);
        scrMakePauseButtons();retry_button107=noone;
        with(PauseButton) if(self[$ "hm_retry_level107"]??false) other.retry_button107=id;
        scrHMGameplayCheck(instance_exists(retry_button107),"Venus pause menu exposes current-stage restart");
        with(retry_button107) scrHMGameplayCheck(scrMenuButtonName()==(UberCont.opt_language=="Simplified Chinese"?"重新开始本关":"RESTART LEVEL"),"retry action has an independent translated label");
    }
    if(mode=="retry107" && ticks==15) with(retry_button107) event_user(0);
    if(mode=="retry107" && ticks==200) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("venuz")&&GameCont.subarea==retry_sub107,"pause action rebuilds exactly the current main or secret Venus stage");
        scrHMGameplayCheck(!instance_exists(retry_old107)&&!instance_exists(retry_old207),"real elevator cleanup removes native weapon pickups");
        var _area=GameCont.area;GameCont.area=1;scrMakePauseButtons();
        var _extra=0;with(PauseButton) if(self[$ "hm_retry_level107"]??false) _extra++;
        scrHMGameplayCheck(_extra==0,"Venus retry action is absent outside Venus");
        instance_destroy(PauseButton,false);GameCont.area=_area;
    }
    if(mode=="pellet107" && ticks==10) {
        scrHMGameplayLane107();
        pellet_target107=instance_create(player.x+40,player.y,CustomEnemy);
        with(pellet_target107) {
            sprite_index=sprBigMaggotIdle;mask_index=mskBigMaggot;hp=1000;max_hp=1000;
            on_step=undefined;on_draw=undefined;on_hurt=undefined;team=1;friction=30;
        }
        player.gunangle=0;player.accuracy=0;
        with(player) scrHMWeaponFire(scrHMWeaponResolve("secretweapong2"));
        var _n=0;with(AllyBullet) if(self[$ "hm_venus_pellet107"]??false) _n++;
        scrHMGameplayCheck(_n==6,"source Venus shotgun creates six individually tagged pellets");
    }
    if(mode=="pellet107" && ticks==15) {
        show_debug_message("HARDMODE PELLET107 "+string(pellet_target107.hp));
        scrHMGameplayCheck(pellet_target107.hp==952,"six real point-blank pellet collisions deal 48 damage despite hit invulnerability");
    }
    if(mode=="raven107" && ticks==10) {
        scrHMGameplayLane107();
        var _keeper=instance_create(14360,14280,CustomEnemy);_keeper.hp=100000;_keeper.on_step=undefined;
        for(var _i=0;_i<80;++_i) with(instance_create(14120+(_i mod 8)*24,14032+(_i div 8)*24,Corpse)) {
            sprite_index=sprBanditDead;image_speed=0;speed=0;
        }
    }
    if(mode=="raven107" && ticks==15) {
        raven_count107=instance_number(Raven)+instance_number(RavenFly);
        scrHMGameplayCheck(raven_count107>0,"source corpse branch summons live flying ravens");
    }
    if(mode=="raven107" && ticks==250) {
        show_debug_message("HARDMODE RAVEN107 "+json_stringify({initial:raven_count107,ravens:instance_number(Raven)+instance_number(RavenFly),corpses:instance_number(Corpse)}));
        scrHMGameplayCheck(instance_number(Corpse)<=80,"live Raven flight changes do not create death corpses");
        scrHMGameplayCheck(instance_number(Raven)+instance_number(RavenFly)<=80,"one-shot corpse summoning never recursively multiplies ravens");
    }
    if(mode=="junk107") {
        if(ticks==1) {junk_blast107=false;junk_native107=false;junk_portraits107={};}
        if(instance_exists(Explosion)||instance_exists(SmallExplosion)||instance_exists(GroundFlame)) junk_blast107=true;
        if(UberCont.bossintro) junk_native107=true;
        with(CustomObject) if(name=="bossintro") other.junk_portraits107[$ string(id)]=true;
        if(ticks==12 && GameCont.subarea==5) {
            var _boss=instance_find(BecomeScrapBoss,0);
            scrHMGameplayCheck(instance_exists(_boss),"3-5 generates a sleeping Big Dog");
            player.x=_boss.x+32;player.y=_boss.y;player.speed=0;
        }
        if(ticks==8) scrHMGameplayCheck(!junk_blast107,"authored scrap roof placement creates no entrance explosions");
        if(ticks==330) {
            scrHMGameplayCheck(!junk_native107,"native Big Dog portrait is suppressed in MOD junkyard");
            var _n=array_length(variable_struct_get_names(junk_portraits107));
            show_debug_message("HARDMODE DOG107 "+json_stringify({portraits:_n,native:junk_native107,bosses:instance_number(ScrapBoss),sleeping:instance_number(BecomeScrapBoss)}));
            scrHMGameplayCheck(_n==(GameCont.subarea==5?1:0),"Big Dog has exactly one MOD portrait and ordinary junkyard has none");
            scrHMGameplayLane107();
            var _decal=instance_create(14120,14120,TopDecalScrapyard);_decal.image_index=0;
            instance_destroy(_decal);
            scrHMGameplayCheck(instance_number(Explosion)>=3,"normal combat death still detonates an explosive roof prop");
            instance_destroy(Explosion,false);instance_destroy(GroundFlame,false);
            junk_quiet_roof107=instance_create(14720,14120,TopDecalScrapyard);junk_quiet_roof107.image_index=0;
            var _wall=instance_create(14720,14120,Wall),_clear=instance_create(14720,14120,PortalClear);
            with(_wall) with(_clear) event_perform_object(PortalClear,ev_collision,Wall);
        }
        if(ticks==334) {
            scrHMGameplayCheck(!instance_exists(junk_quiet_roof107)&&!instance_exists(Explosion),"real portal-cleared floor removes explosive roof without a combat detonation");
            junk_combat_roof107=instance_create(14920,14120,TopDecalScrapyard);junk_combat_roof107.image_index=0;
            var _wall=instance_create(14920,14120,Wall);scrWallDestroy(_wall);
        }
        if(ticks==338)
            scrHMGameplayCheck(!instance_exists(junk_combat_roof107)&&instance_exists(Explosion),"ordinary battle wall destruction still detonates the roof through its real floor collision");
    }
    if(mode=="police107" && ticks==10) {
        if(scrHMPoliceArea107(GameCont.area)) {
        scrHMGameplayCheck(!instance_exists(Bandit),"HQ has no native chest-camping bandits");
        var _bandits=0;with(CustomEnemy) if(scrHMScriptRef(on_step)==scrHMScriptRef(hm_enemies_mod_gml_elitebandit_step)) _bandits++;
        scrHMGameplayCheck(_bandits==0,"HQ contains no converted chest-camping bandits");
        }
        police_portal107=instance_create(player.x+120,player.y,Portal);
    }
    if(mode=="police107" && ticks==40) {
        scrHMGameplayCheck(instance_exists(police_portal107)&&police_portal107.type==2,"HQ and 6-3 retain the IDPD type after sustained MOD steps");
        scrHMGameplayCheck(police_portal107.sprite_index==sprPopoPortal,"actual exit animation uses IDPD art");
    }
    if(mode=="horror107" && ticks==10) {
        scrHMGameplayLane107();horror107=instance_create(player.x+160,player.y,HostileHorror);
        horror_x107=horror107.x;horror_y107=horror107.y;horror_moved107=false;
    }
    if(mode=="horror107" && ticks>10 && instance_exists(horror107)) {
        if(point_distance(horror_x107,horror_y107,horror107.x,horror107.y)>5) horror_moved107=true;
        scrHMGameplayCheck(!instance_exists(HorrorBullet),"palace Horror movement never restores radiation attacks");
    }
    if(mode=="horror107" && ticks==180)
        scrHMGameplayCheck(horror_moved107&&horror107.hp==16,"palace Horror actually walks and retains sixteen HP");
    if(mode=="ice107" && ticks==10) {
        scrHMGameplayLane107();ice_source107=GameCont.area;
        hm_props_mod_gml_whitecrystal_create(player.x+64,player.y);
        ice107=instance_nearest(player.x+64,player.y,CustomObject);
    }
    if(mode=="ice107" && ticks>=11 && ticks<=65 && instance_exists(ice107)) {
        with(instance_create(ice107.x,ice107.y,Flame)) {damage=0;speed=0;}
    }
    if(mode=="ice107" && ticks==70) {
        scrHMGameplayCheck(ice107.open==-10000&&instance_exists(Portal),"real fire contact fully melts the entrance crystal");
        scrHMGameplayCheck(GameCont.area==ice_source107,"opening entrance does not prematurely change current area");
        var _portal=instance_nearest(ice107.x,ice107.y,Portal);
        player.x=_portal.x;player.y=_portal.y;player.speed=0;
    }
    if(mode=="ice107" && ticks==220)
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("icecave")&&instance_number(Floor)>5,"natural portal transition reaches playable ice cave");
    if(mode=="cavewalls107" && ticks==10) {
        scrHMGameplayCheck(instance_exists(HyperCrystal),"fixture reaches actual cursed HyperCrystal boss stage");
        cavewalls107=[];
        with(Wall) if(self[$ "hm_plain106"]??false) array_push(other.cavewalls107,[id,x,y,self[$ "hm_fill_w106"]??16,self[$ "hm_fill_h106"]??16]);
        scrHMGameplayCheck(array_length(cavewalls107)>0,"cursed cave has packed deep collision before conversion");
        with(HyperCrystal) scr_hit(id,max_hp*10,HitId.Player);
    }
    if(mode=="cavewalls107" && ticks==260) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("caves"),"real HyperCrystal death returns cave theme");
        for(var _i=0;_i<array_length(cavewalls107);++_i) {
            var _record=cavewalls107[_i],_wall=_record[0];
            scrHMGameplayCheck(instance_exists(_wall),"theme wave preserves each packed wall identity");
            if(instance_exists(_wall)) scrHMGameplayCheck((_wall[$ "hm_fill_w106"]??16)==_record[3]&&(_wall[$ "hm_fill_h106"]??16)==_record[4],"theme wave preserves full packed collision extent");
        }
    }
    if(mode=="reflect107" && ticks==10) {
        scrHMGameplayLane107();reflect107=[];
        var _shield_types=[PopoShield,EliteShield],_shots=[PlasmaBig,PlasmaHuge,Bullet1];
        for(var _s=0;_s<2;++_s) for(var _b=0;_b<3;++_b) {
            var _xx=14144+_b*96,_yy=14064+_s*128;
            var _shield=instance_create(_xx,_yy,_shield_types[_s]);
            _shield.image_speed=0;_shield.team=3;
            var _shot=instance_create(_xx-16,_yy,_shots[_b]);
            _shot.team=team_player;_shot.creator=player;_shot.hitid=HitId.Player;_shot.direction=0;_shot.speed=2*timescale;
            array_push(reflect107,[_shot,_shield,_b]);
            with(_shot) with(_shield) event_perform_object(object_index,ev_collision,projectile);
            scrHMGameplayCheck(_shot.team==(_b==2?3:team_player),"shield reflection preserves player plasma but retains ordinary bullet behavior");
            with(_shot) scrHMGameplayCheck(!scr_can_hit(HMGameplayTest.player,false)||_b==2,"reflected plasma cannot hurt the player");
            var _target=instance_create(_xx+24,_yy,CustomEnemy);_target.hp=100;_target.team=1;
            with(_shot) scrHMGameplayCheck(scr_can_hit(_target,false),"reflected plasma can still hit enemies");
            instance_destroy(_shot,false);instance_destroy(_shield,false);instance_destroy(_target,false);
        }
    }
    if(mode=="revive107" && ticks==10) {
        scrHMGameplayLane107();
        // A live enemy keeps this a combat room, as in the native mechanic.
        revive_keeper107=instance_create(14400,14280,CustomEnemy);revive_keeper107.hp=100000;
        var _types=[Grunt,Inspector,Shielder,EliteGrunt,EliteInspector,EliteShielder];
        for(var _i=0;_i<6;++_i) {
            var _e=instance_create(14128+(_i mod 3)*96,14048+(_i div 3)*128,_types[_i]);
            _e.speed=0;_e.freeze=100;_e.alarm[1]=-1;
            scrHMVenusShoot106(_e,10000);
        }
    }
    if(mode=="revive107" && ticks==25)
        scrHMGameplayCheck(instance_number(WantRevivePopoFreak)==(GameCont.loops>=3?6:0),"real deaths schedule one original revival timer per police only from loop three");
    if(mode=="revive107" && array_contains([30,790,815,835,855],ticks)) {
        var _corpses=[];with(Corpse) array_push(_corpses,[x,y,sprite_index]);
        show_debug_message("HARDMODE REVIVE107 "+json_stringify({tick:ticks,timers:instance_number(WantRevivePopoFreak),effects:instance_number(RevivePopoFreak),freaks:instance_number(PopoFreak),portal:instance_number(Portal),corpses:_corpses}));
    }
    if(mode=="revive107" && ticks==860)
        scrHMGameplayCheck(instance_number(PopoFreak)==(GameCont.loops>=3?6:0),"native 800-tick timers actually revive police corpses as IDPD Freaks");
    if(mode=="van107" && ticks==10) {
        scrHMGameplayLane107();van107=instance_create(player.x+160,player.y,Van);
        for(var _i=0;_i<28;++_i) for(var _j=0;_j<5;++_j) instance_create(13300+_i*32,14100+_j*32,Floor);
        van_exploded107=false;van_custom107=noone;van_converted107=false;van_freak_peak107=0;
        van_hp107=van107.hp;
        scrHMGameplayCheck(van107.freak==(GameCont.loops>=3),"native van danger threshold follows actual loop count");
    }
    if(mode=="van107" && ticks>10 && !van_converted107) {
        with(CustomObject) if(name=="3dvan") {other.van_custom107=id;break;}
        if(instance_exists(van_custom107)) {
            van_converted107=true;
            scrHMGameplayCheck(van_custom107.hm_freak107==(GameCont.loops>=3),"converted Hardmode van retains loop danger policy");
        }
    }
    if(mode=="van107" && ticks>10 && van_converted107 && !instance_exists(van_custom107)) van_exploded107=true;
    if(mode=="van107" && ticks>10) van_freak_peak107=max(van_freak_peak107,instance_number(PopoFreak));
    if(mode=="van107" && ticks>10 && instance_exists(van107) && van107.hp!=van_hp107) {
        show_debug_message("HARDMODE VAN107 DAMAGE "+json_stringify({tick:ticks,hp:van107.hp,x:van107.x,y:van107.y}));van_hp107=van107.hp;
    }
    if(mode=="van107" && ticks>10 && instance_exists(van107) && ticks mod 10==0)
        show_debug_message("HARDMODE VAN107 "+json_stringify({tick:ticks,x:van107.x,y:van107.y,drive:van107.drive,speed:van107.drivespeed,hp:van107.hp,freak:van107.freak}));
    if(mode=="van107" && ticks==150) {
        scrHMGameplayCheck(van_converted107,"real native van is converted to the Hardmode vehicle");
        scrHMGameplayCheck(van_exploded107==(GameCont.loops>=3),"loop-three Hardmode van detonates after stopping, earlier vans unload normally");
        if(GameCont.loops<3) scrHMGameplayCheck(instance_exists(van_custom107)&&van_custom107.land==0,"ordinary Hardmode van completes its unload and remains parked");
        else scrHMGameplayCheck(van_freak_peak107>=3,"stopped dangerous van releases native IDPD Freaks");
    }
}

function scrHMGameplayRender107() {
    if(mode=="fall107" && ticks>=12 && ticks<=30) {
        var _n=0;with(HMBinding) if(hm_code==scrHMScriptRef(hm_maincode_mod_gml_PortalShrink)) _n++;
        scrHMGameplayCheck(_n==1,"Throne II falling uses one persistent portal renderer on every physical frame");
    }
    if(mode=="portraitprofile107" && ticks>15 && ticks<145)
        array_push(portrait_samples107,[ticks,get_timer()-hm_frame_start106,instance_exists(variable_instance_get(HMWorld,"hm_portrait_active")??noone)]);
    if(mode=="prompt107" && ticks>=12 && ticks<=34) {
        var _n=0;with(HMBinding) if(hm_code==scrHMScriptRef(hm_props_mod_gml_E)&&creator==other.prompt107) _n++;
        scrHMGameplayCheck(_n==1,"interaction text has exactly one renderer on every physical frame");
        prompt_frames107++;
    }
    if((mode=="prompt107"&&array_contains([15,16,40],ticks))
        ||(mode=="retry107"&&ticks==12)||(mode=="police107"&&ticks==40)
        ||(mode=="cavewalls107"&&array_contains([12,260],ticks))
        ||(mode=="car107"&&array_contains([15,28],ticks))
        ||(mode=="fall107"&&ticks==22))
        if(surface_exists(application_surface)) surface_save(application_surface,game_directory+mode+"-"+string(ticks)+"-"+string(age)+".png");
}
