// Physical-frame input is retained until the player actually consumes it.
function scrDesktopWheelAllowed111() {
    return os_type==os_windows && UberCont.opt_keyboard && !UberCont.opt_gamepad
        && !UberCont.paused && !UberCont.want_pause && UberCont.block_input_frames<=0
        && !scr_keyboard_is_typing() && !is_mouse_over_debug_overlay()
        && !scrGameIsLockState() && !instance_exists(MenuOptions) && !instance_exists(PauseButton)
        && instance_exists(Player);
}
function scrDesktopWheelFrame111() {
    if(os_type!=os_windows) return;
    KeyCont.wheel_frame111++;
    var _index=global.index;
    if(!scrDesktopWheelAllowed111() || get_timer()>KeyCont.wheel_until111[_index])
        KeyCont.wheel_pending111[_index]=false;
    // Wheel events and the post-input normal Step poll own sampling (1.0.12).
}
function scrDesktopWheelPending111(_index) {
    if(!KeyCont.wheel_pending111[_index]) return false;
    if(!scrDesktopWheelAllowed111() || get_timer()>KeyCont.wheel_until111[_index]) {
        KeyCont.wheel_pending111[_index]=false;return false;
    }
    return KeyCont.wheel_consumed111[_index]!=KeyCont.wheel_frame111;
}
function scrDesktopWheelMerge111(_index) {
    // Player Step may run before the general keyboard sampler. Do not
    // reinsert Space/the same notch after that frame already consumed it.
    if(KeyCont.wheel_consumed111[_index]==KeyCont.wheel_frame111) {
        KeyCont.press_swap[_index]=false;return;
    }
    if(scrDesktopWheelPending111(_index)) {
        KeyCont.press_swap[_index]=true;KeyCont.hold_swap[_index]=true;
    }
}
function scrDesktopWheelConsume111(_index) {
    if(KeyCont.wheel_pending111[_index]) {
        KeyCont.wheel_pending111[_index]=false;
        KeyCont.wheel_consumed111[_index]=KeyCont.wheel_frame111;
    }
}

function scrHMWaterSurface111() {
    // Link once during construction, then inspect the actual surface sprite
    // at the foot point. Its delayed shoreline change needs no map rescan.
    var _floor=instance_nearest(x,y,Floor);
    if(instance_exists(_floor) && _floor.x==x && _floor.y==y) _floor.hm_water_surface111=id;
}
function scrHMWaterBank111(_floor,_x,_y) {
    var _surface=_floor[$ "hm_water_surface111"]??noone;
    if(!instance_exists(_surface) || _surface.sprite_index!=sprHM_areas_sewers_area_3) return false;
    // Rows 0..7 of the 40px sprite are bank/shore; scale .8 => 6.4 world px.
    var _top=_surface.y-sprite_get_yoffset(_surface.sprite_index)*_surface.image_yscale;
    return _y<_top+8*abs(_surface.image_yscale);
}

function scrHMCaveWallWave111(_origin) {
    if(!instance_exists(_origin)) return;
    var _area=GameCont.area;
    if((variable_instance_get(HMWorld,"hm_theme_started111")??-999)==_area) return;
    HMWorld.hm_theme_started111=_area;
    HMWorld.hm_wall_theme_area106=_area;
    var _queue=[],_ox=_origin.x,_oy=_origin.y,_tick=HMWorld.logic_serial;
    with(Wall) array_push(_queue,[id,_tick+ceil(point_distance(x,y,_ox,_oy)/8),false]);
    with(TopSmall) array_push(_queue,[id,_tick+ceil(point_distance(x,y,_ox,_oy)/8),true]);
    array_sort(_queue,function(_a,_b){return _a[1]-_b[1];});
    HMWorld.hm_wall_theme_queue=_queue;HMWorld.hm_wall_theme_index=0;
}

function scrHMVisualOffset111() {
    // Presentation only. Retain 30Hz AI, collision and movement endpoints.
    // Native hspeed/vspeed already move every physical frame; smooth only
    // the remaining manual displacement on the logic frame's first half.
    if(!scrHMEnabled() || timescale>=1 || !scrHMReadyTick()
        || lockstep_stop || UberCont.paused || instance_exists(GenCont)
        || (self[$ "hm_portrait_frozen"]??false)) return [0,0];
    var _dx=x-xprevious-hspeed,_dy=y-yprevious-vspeed;
    // Do not smear teleports, newly created objects or large knockbacks.
    if(abs(_dx)>16 || abs(_dy)>16) return [0,0];
    return [-_dx*(1-timescale),-_dy*(1-timescale)];
}
function scrHMActorDraw111() {
    var _offset=scrHMVisualOffset111(),_matrix=matrix_get(matrix_world);
    var _shift=(_offset[0]!=0||_offset[1]!=0);
    if(_shift) matrix_set(matrix_world,matrix_multiply(_matrix,
        matrix_build(_offset[0],_offset[1],0,0,0,0,1,1,1)));
    scrHMActorDrawRaw111();
    if(_shift) matrix_set(matrix_world,_matrix);
}

function scrHMLoopSpider111(_x,_y) {
    if(GameCont.loops<=0 || !array_contains([scrHMAreaResolve("caves"),
        scrHMAreaResolve("cavesinv"),scrHMAreaResolve("city")],GameCont.area)
        || random(32)>=1) return noone;
    if(!position_meeting(_x,_y,Floor)
        || collision_circle(_x,_y,12,Wall,false,true)!=noone) return noone;
    // Bound this added population independently of map growth.
    var _count=0;
    with(CustomEnemy) if(scrHMScriptRef(on_step)==scrHMScriptRef(hm_enemies_mod_gml_EliteSpider_step)) _count++;
    if(_count>=4) return noone;
    return hm_enemies_mod_gml_EliteSpider_create(_x,_y);
}

// These are the weighted loop branches of Epsilon's scrPopEnemies, including
// repeated entries. Areas without a stock loop branch return an empty pool.
function scrHMVanillaLoopPool111(_area) {
    switch(_area) {
        case area_desert: return [Scorpion,Scorpion,Bandit,Bandit,Maggot,JungleFly,JungleFly,MeleeBandit,Sniper];
        case area_sewers: return [Ratking,Ratking,BuffGator,LaserCrystal,Rat,Exploder,Exploder,SuperFireBaller];
        case area_scrapyards: return [Sniper,Sniper,MeleeFake,MeleeFake,Salamander,SnowBot,Raven,BuffGator,Raven];
        case area_caves: return [LaserCrystal,LaserCrystal,LaserCrystal,RhinoFreak,LightningCrystal,BuffGator,ExploFreak,Spider,Spider];
        case area_city: return [SnowTank,SnowTank,DogGuardian,ExploGuardian,SnowBot,SnowBot,SnowBot,Wolf,Necromancer];
        case area_labs: return [Ratking,RhinoFreak,ExploFreak,Necromancer,RhinoFreak,LaserCrystal,BecomeTurret];
        case area_palace: return [ExploGuardian,DogGuardian,Sniper,DogGuardian,ExploGuardian,ExploFreak,JungleBandit,JungleBandit];
    }
    return [];
}
function scrHMVanillaLoopArea111(_area) {
    switch(scrHMAreaKey(_area)) {
        case "area:scorpionboss": return area_desert;
        case "area:bigdog": return area_scrapyards;
        case "area:elevator": return area_labs;
    }
    return scrHMUnlockArea(_area);
}
function scrHMVanillaLoopPopulate111() {
    // Called only by the custom-area branch. Stock rooms already execute
    // these branches themselves and must never receive a second roll.
    if(GameCont.loops<=0 || !scrHMAreaHas(GameCont.area)) return noone;
    var _area=scrHMVanillaLoopArea111(GameCont.area),_pool=scrHMVanillaLoopPool111(_area);
    if(array_length(_pool)==0) return noone;
    var _loop_rand=random(GameCont.loops);
    if(_area==area_scrapyards && !(random(5)<4
        && (GameCont.subarea!=GameCont.maxsubarea || random(2)<1))) return noone;
    if(_area==area_palace && random(2)>1) return noone;
    if(random(2)>=_loop_rand) return noone;
    var _xx=bbox_center_x+orandom(2),_yy=bbox_center_y+orandom(2);
    if(collision_circle(_xx,_yy,12,Wall,false,true)!=noone) return noone;
    var _enemy=instance_create(_xx,_yy,_pool[irandom(array_length(_pool)-1)]);
    _enemy.hm_vanilla_loop111=true;
    return _enemy;
}

function scrHMVenusDropAllowed111(_weapon) {
    if(GameCont.area==scrHMAreaResolve("venuz")) return true;
    var _key=global.hm_weapon_keys[$ string(scrHMWeaponResolve(_weapon))]??"";
    return !array_contains(["weapon:secretweapong1","weapon:secretweapong2",
        "weapon:secretweapong3","weapon:secretweapong4","weapon:secretweapong5"],_key);
}

function scrHMMissileShot111(_owner,_missile) {
    return instance_exists(_owner) && instance_is(_owner,ScrapBoss)
        && instance_exists(_missile) && _owner==_missile.creator;
}

function scrHMThroneAnchor111() {
    var _anchor=variable_instance_get(HMWorld,"hm_throne_anchor111");
    if(is_undefined(_anchor)) _anchor=[10000,10000];
    return _anchor;
}
function scrHMThroneShift111(_mx,_my) {
    if(!scrHMEnabled() || GameCont.area!=scrHMAreaResolve("throne")) return;
    var _anchor=variable_instance_get(HMWorld,"hm_throne_anchor111");
    if(!is_undefined(_anchor)) HMWorld.hm_throne_anchor111=[_anchor[0]+_mx,_anchor[1]+_my];
}
function scrHMThroneSeed111() {
    var _anchor=scrHMThroneAnchor111(),_seed=instance_nearest(_anchor[0],_anchor[1],Floor);
    if(!instance_exists(_seed)) return;
    with(Floor) nokill=(id==_seed)?1:0;
}
function scrHMThroneEntrance111() {
    if(!scrHMEnabled() || !instance_exists(GameCont) || GameCont.area!=scrHMAreaResolve("throne")
        || !instance_exists(Floor)) return;
    if(instance_exists(BecomeNothing)||instance_exists(Nothing)||instance_exists(NothingDeath)
        ||instance_exists(Nothing2)||instance_exists(Nothing2Death)) return;
    // Preserve the first FloorMaker's authored axis, translated with the
    // whole map by native safe-spawn. A nearest-floor query can pick a side.
    var _anchor=scrHMThroneAnchor111();
    var _xx=_anchor[0]+16,_yy=_anchor[1]-1568-64*min(GameCont.loops*2,4);
    var _idle=instance_find(NothingInactive,0);
    if(!instance_exists(_idle)) _idle=instance_create(_xx,_yy,NothingInactive);
    with(NothingInactive) if(id!=_idle) instance_destroy(id,false);
    if(!_idle.active) {
        _idle.x=_xx;_idle.y=_yy;_idle.xstart=_xx;_idle.ystart=_yy;
        _idle.xprevious=_xx;_idle.yprevious=_yy;
        _idle.visible=true;_idle.image_alpha=1;
        _idle.sprite_index=sprNothingOff;_idle.spr_idle=sprNothingOff;
        _idle.spr_hurt=sprNothingOff;_idle.mask_index=mskNothingInactive;
    }
}
