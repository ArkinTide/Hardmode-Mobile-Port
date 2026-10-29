// Narrow host/NTT contracts established against frozen Hardmode b24.
function scrHMMusicRoom() {
    if(!scrHMEnabled() || !instance_exists(GameCont) || !scrHMAreaHas(GameCont.area)) return false;
    alarm[0]=-1;
    var _desired=self[$ "hm_music_desired"]??song;
    if(song!=_desired) song=_desired;
    if(audio_exists(song) && !audio_is_playing(song)) music_sound=snd_play_music(song,true);
    if(audio_exists(amb) && !audio_is_playing(amb)) snd_play_ambience(amb,true);
    oldarea=GameCont.area;
    return true;
}

function scrHMPalaceHorrorInit() {
    hm_palace_horror=true;
    max_hp=16;hp=16;raddrop=0;
    spr_idle=sprEnemyHorrorIdle;spr_walk=sprEnemyHorrorWalk;
    spr_hurt=sprEnemyHorrorHurt;spr_dead=sprEnemyHorrorDead;
    sprite_index=spr_idle;
    snd_dead=-4;ammo=0;charge=100;
    alarm[1]=-1;alarm[3]=-1;
}

function scrHMPalaceHorrorStep() {
    if(!(self[$ "hm_palace_horror"]??false)) {
        spr_idle=sprMutant11Idle;spr_walk=sprMutant11Walk;
        spr_hurt=sprMutant11Hurt;spr_dead=sprMutant11Dead;
        return;
    }
    ammo=0;charge=100;alarm[3]=-1;snd_dead=-4;
    if(raddrop>10 && instance_number(HostileHorror)<100) {
        raddrop-=10;
        with(instance_create(x,y,HostileHorror)) scrHMPalaceHorrorInit();
    }
    if(hp<=0) {
        repeat(raddrop) with(instance_create(x,y,Rad)) motion_add(random(360),random(6)*timescale);
        scrHMSoundPitchVolume(sndGuardianDead,1,clamp((view_width/3)/max(1,distance_to_object(Player))-1,0,1));
        hm_enemies_mod_gml_scrPickups(20);
        // NTT changes to its death effect without the host's Horror-unlock,
        // extra rads, shockwave and normal hostile-Horror death callbacks.
        scrHMDeathExit(x,y);
        instance_change(Wind,false);
        hp=0;raddrop=0;sprite_index=sprEnemyHorrorDead;friction=timescale*timescale;
    }
}

function scrHMPendingBoss() {
    if(!scrHMEnabled()) return false;
    if(instance_exists(HMWorld) && (variable_instance_get(HMWorld,"hm_titank_entering")??false)) return true;
    var _pending=false;
    with(CustomObject) if(name=="wanttitank" || name=="wantravenboss" || name=="wantjungleboss") {_pending=true;break;}
    return _pending;
}

function scrHMDeathExit(_x,_y) {
    if(!scrHMEnabled() || !instance_exists(GameCont) || instance_exists(GenCont)) return;
    // A custom boss may have no animated corpse (Titank uses mskNone).
    // Retain the stock Corpse alarm's clearance checks and 30-tick delay.
    with(Corpse) if(self[$ "hm_exit_corpse"]??false) instance_destroy(id,false);
    with(instance_create(_x,_y,Corpse)) {
        sprite_index=mskNone;image_speed=0;hm_exit_corpse=true;alarm[0]=30;
    }
}

function scrHMCursedCavesRestore(_x,_y) {
    if(!scrHMEnabled() || !instance_exists(GameCont) || GameCont.area!=scrHMAreaResolve("cavesinv")) return;
    if(instance_exists(HyperCrystal)) return;
    var _floor=instance_nearest(_x,_y,Floor);
    if(!instance_exists(_floor)) return;
    GameCont.area=scrHMAreaResolve("caves");
    GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);
    with(BackCont) {shadcol=786950;shadow_color=shadcol;}
    // The wave outlives the dead boss and uses a stable floor as its origin.
    with(HMWorld) hm_props_mod_gml_joao_shockwave(104,_floor);
    scrHMSoundMusic(mus4);scrHMSoundAmbient(amb4);
}

function scrHMClearCursedAmmo() {
    if(object_index==CursedPickup) instance_change(AmmoPickup,false);
    cursed=false;image_speed=0;
}

function scrHMConvertCursedEnemy(_type) {
    var _health=hp;
    instance_change(_type,false);
    // Initialize ordinary AI without the cursed object's death drops or
    // InvSpider's split-on-death callback. Keep the crystal's source HP.
    event_perform(ev_create,0);
    if(_type==LaserCrystal) hp=_health;
    sprite_index=spr_idle;
}

function scrHMTinadeWall() {
    // Collision callbacks can run on every render frame while embedded in a
    // wall. Separate once and debounce contact audio, without resetting fuse.
    var _dx=x-xprevious,_dy=y-yprevious;
    if(place_meeting(x,y,Wall)) {x=xprevious;y=yprevious;}
    move_bounce_solid(true);
    repeat(16) {
        if(!place_meeting(x,y,Wall)) break;
        var _wall=instance_nearest(x,y,Wall);
        if(!instance_exists(_wall)) break;
        var _angle=point_direction(_wall.x+8,_wall.y+8,x,y);
        x+=lengthdir_x(1,_angle);y+=lengthdir_y(1,_angle);
    }
    var _tick=HMWorld.logic_serial;
    if((self[$ "hm_bounce_tick"]??-100)+6<=_tick && abs(_dx)+abs(_dy)>.05) {
        hm_bounce_tick=_tick;scrHMSoundPlay(sndGrenadeHitWall);
    }
}

function scrHMConsoleDestination(_area,_subarea) {
    if(is_string(_area)) {
        if(variable_struct_exists(global.hm_area_ids,_area)) return [scrHMAreaResolve(_area),_subarea];
        if(_area=="hq") return [scrHMAreaResolve("HQ"),_subarea];
        return undefined;
    }
    if(_area>=200 && scrHMAreaHas(_area)) return [_area,_subarea];
    switch(_area) {
        case 0:return [0,1];
        case 1:return _subarea<=3?[1,_subarea]:[scrHMAreaResolve("nightdesert"),4];
        case 2:return [scrHMAreaResolve("sewers"),_subarea];
        case 3:return _subarea<=2?[3,_subarea]:[_subarea==3?scrHMAreaResolve("ravenboss"):scrHMAreaResolve("junkyard"),_subarea];
        case 4:return [scrHMAreaResolve("caves"),_subarea];
        case 5:return [scrHMAreaResolve("city"),_subarea];
        case 6:return [scrHMAreaResolve("labs"),_subarea];
        case 7:return [scrHMAreaResolve("palace"),_subarea];
        case 101:return [scrHMAreaResolve("oasis"),_subarea];
        case 102:return [scrHMAreaResolve("turtles"),_subarea];
        case 104:return [scrHMAreaResolve("cavesinv"),_subarea];
        case 106:return [scrHMAreaResolve("HQ"),_subarea];
    }
    return undefined;
}

function scrHMConsoleGoto(_area,_subarea,_loop=-1) {
    var _dest=scrHMConsoleDestination(_area,_subarea);
    if(!instance_exists(GameCont) || is_undefined(_dest)) return false;
    var _max=scrAreaGetMaxSubarea(_dest[0]);
    if(_dest[1]<1 || _dest[1]>_max) return false;
    with(GameCont) {
        area=_dest[0];subarea=_dest[1];maxsubarea=_max;finalsubarea=(subarea==maxsubarea);
        if(_loop>=0) loops=_loop;
        route=0;is_level_ended=false;can_advance_stage=false;
        hard=scrAreaGetDifficulty(area,subarea,loops);
        waypnt[waypoints]=area;waysub[waypoints]=subarea;waylps[waypoints]=loops;waypoints++;
    }
    if(scrGameIsPaused()) scrGameUnpause();
    with(instance_create(10016,10016,Portal)) {sprite_index=sprPortalDisappear;event_perform(ev_other,ev_animation_end);}
    return true;
}

function scrHMConsoleCommand(_text,_loop=-1) {
    // Named IDs do not contain dashes; reject malformed input before real().
    var _parts=string_split(_text,"-");
    if(array_length(_parts)!=2) return false;
    if(!string_is_real(_parts[1])) return false;
    var _area=_parts[0],_sub=real(_parts[1]);
    if(string_digits(_area)==_area) _area=real(_area);
    return scrHMConsoleGoto(_area,_sub,_loop);
}

function scrHMFishSkullSpawn() {
    if(!scrHMEnabled() || GameCont.area!=1 || GameCont.subarea!=2 || instance_number(Floor)<100 || !instance_exists(Player)) return;
    if(Player.hp!=Player.max_hp) return;
    var _has=false;with(CustomHitme) if(name=="fishskull") {_has=true;break;}
    if(_has) return;
    var _far=instance_furthest(Player.x,Player.y,Floor);
    var _floor=instance_nearest(_far.x+random_range(-112,112),_far.y+random_range(-112,112),Floor);
    if(instance_exists(_floor)) hm_props_mod_gml_fishskull_create(_floor.x+16,_floor.y+16);
}

function scrHMSewerClear(_x,_y) {
    var _clear=instance_create(_x,_y,PortalClear);
    _clear.hm_water_clear=true;
    return _clear;
}

function scrHMWaterEntrySound() {
    if((variable_instance_get(HMWorld,"hm_water_entry_tick")??-100)+3>HMWorld.logic_serial) return;
    HMWorld.hm_water_entry_tick=HMWorld.logic_serial;
    scrHMSoundPitchVolume(choose(sndFootSlime1,sndFootSlime2,sndFootSlime3,sndFootSlime4,sndFootSlime5,sndFootSlime6),1,.7);
    scrHMSoundPitchVolume(sndSewerDrip,1,.7);
}

function scrHMSewerBank(_wall) {
    var _x=_wall.x,_y=_wall.y;
    scrWallDestroy(_wall);
    with(FloorExplo) if(point_distance(x,y,_x,_y)<1) {
        sprite_index=sprFloor2;image_index=0;
    }
}

function scrHMGatorFistWall() {
    if(lockstep_stop) return;
    scrWallDestroy(other.id);
    instance_create(x+hspeed,y+vspeed,PortalClear);
}

function scrHMBeamDistance(_x,_y,_angle,_limit=2048) {
    var _dx=lengthdir_x(1,_angle),_dy=lengthdir_y(1,_angle);
    if(collision_line(_x,_y,_x+_dx*_limit,_y+_dy*_limit,Wall,false,true)==noone) return _limit;
    var _low=0,_high=_limit;
    repeat(11) {
        var _mid=(_low+_high)/2;
        if(collision_line(_x,_y,_x+_dx*_mid,_y+_dy*_mid,Wall,false,true)==noone) _low=_mid;
        else _high=_mid;
    }
    return max(4,_high);
}

function scrHMParticleRay(_angle,_distance) {
    var _length=min(_distance,scrHMBeamDistance(x,y,_angle,_distance));
    x+=lengthdir_x(_length,_angle);y+=lengthdir_y(_length,_angle);
}

function scrHMIDPDBeamFix(_startx,_starty,_angle) {
    // Native Laser has its own next-tick trace. The MOD already traced from
    // the muzzle: leaving that alarm active traces again in reverse.
    alarm[0]=-1;
    xstart=_startx;ystart=_starty;
    image_angle=_angle;direction=_angle;
    image_xscale=point_distance(x,y,_startx,_starty)/2;
    hm_idpd_beam=true;
}

function scrHMGroundBounds() {
    if(!scrHMEnabled() || !scrHMReadyTick() || !instance_exists(GameCont) || instance_exists(GenCont) || hp<=0) return;
    static _walking=[Bandit,Scorpion,Maggot,BigMaggot,Gator,BuffGator,Rat,Wolf,SnowBot,SnowTank,Grunt,Inspector,Shielder];
    var _eligible=array_contains(_walking,object_index);
    // b24's armed bandit has no name. Match its actual AI, not a label.
    if(object_index==CustomEnemy) _eligible=(scrHMScriptRef(on_step)==scrHMScriptRef(hm_enemies_mod_gml_elitebandit_step));
    if(!_eligible) return; // preserve authored wall/flying/burrowing enemies
    if(place_meeting(x,y,Floor) && !place_meeting(x,y,Wall)) {hm_outside_ticks=0;return;}
    hm_outside_ticks=(self[$ "hm_outside_ticks"]??0)+1;
    if(hm_outside_ticks<30) return;
    var _floor=noone,_best=1000000000,_who=id;
    with(Floor) {
        var _xx=x+16,_yy=y+16,_d=point_distance(_xx,_yy,_who.x,_who.y);
        if(_d>=_best) continue;
        with(_who) if(!place_meeting(_xx,_yy,Wall)) {_floor=other.id;_best=_d;}
    }
    if(instance_exists(_floor)) {x=_floor.x+16;y=_floor.y+16;xprevious=x;yprevious=y;speed=0;}
    hm_outside_ticks=0;
}
