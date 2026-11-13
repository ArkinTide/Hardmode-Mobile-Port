// The mobile host keeps its material IDs, five-point feet and 30 Hz AI.
function scrHMWaterBatchBegin1102() {
    HMWorld.hm_water_batch_cache1102={};
    HMWorld.hm_water_batch1102=true;
}

function scrHMWaterBatchEnd1102() {HMWorld.hm_water_batch1102=false;}

function scrHMWaterExact1102(_x,_y) {
    var _key=scrHMWaterKey(_x,_y);
    var _shapes=HMWorld.hm_water_batch_cache1102[$ _key];
    if(is_undefined(_shapes)) {
        _shapes=[];
        var _entries=HMWorld.hm_water_rects109[$ _key]??[];
        for(var _i=0;_i<array_length(_entries);++_i) {
            var _f=_entries[_i];if(!instance_exists(_f)) continue;
            var _size=instance_is(_f,FloorExplo)?16:32;
            var _surface=_f[$ "hm_water_surface111"]??noone;
            var _wet=_f.traction==2 && instance_exists(_surface),_bank=-1000000000000000000000000000000;
            if(_wet && _surface.sprite_index==sprHM_areas_sewers_area_3)
                _bank=_surface.y-sprite_get_yoffset(_surface.sprite_index)*_surface.image_yscale+8*abs(_surface.image_yscale);
            array_push(_shapes,[_f.x,_f.y,_f.x+_size,_f.y+_size,_wet,_bank]);
        }
        HMWorld.hm_water_batch_cache1102[$ _key]=_shapes;
    }
    var _water=false;
    for(var _i=0;_i<array_length(_shapes);++_i) {
        var _r=_shapes[_i];
        if(_x<_r[0] || _y<_r[1] || _x>=_r[2] || _y>=_r[3]) continue;
        if(!_r[4] || _y<_r[5]) return false;
        _water=true;
    }
    return _water;
}

function scrHMIDPDPortalSprite1102() {
    if(sprite_index==sprPopoPortalDisappear) return;
    if(sprite_index==sprPortalDisappear || sprite_index==sprProtoPortalDisappear) sprite_index=sprPopoPortalDisappear;
    else if(sprite_index!=sprPopoPortal) sprite_index=sprPopoPortal;
}
function scrHMElevatorFloor1102(_x,_y) {
    var _found=noone,_best=1000000000000000000000000000000;
    with(Floor) {
        var _xx=x+16,_yy=y+16,_d=sqr(_xx-_x)+sqr(_yy-_y);
        if(_d>=_best || !hm_arkintide_mod_gml_hm_throne_clear(_xx,_yy,mskBandit)) continue;
        if(collision_circle(_xx,_yy,14,prop,false,true)!=noone) continue;
        if(collision_circle(_xx,_yy,14,CustomHitme,false,true)!=noone) continue;
        _found=id;_best=_d;
    }
    return _found;
}
function scrHMElevatorStep1102() {
scrHMElevatorStep1103();
}

function scrHMReplacementArea1102() {
    // Both custom campaigns and the native final/secret rooms are excluded.
    if(array_contains([scrHMAreaResolve("throne"),scrHMAreaResolve("venuz"),scrHMAreaResolve("HQ"),area_hq,area_crib],GameCont.area)) return false;
    return hm_arkintide_mod_gml_hm_gungod_area_allowed();
}
function scrHMReplacementActor1102() {
    return array_contains(["hm_chief","GunGod","gungod","hm_yv_phase","hm_gungod_landing"],self[$ "name"]??"");
}
function scrHMReplacementTick1102() {
    if(!instance_exists(GameCont)||instance_exists(GenCont)||!instance_exists(Player)
       ||GameCont.loops<1||!scrHMReplacementArea1102()) return;
    if((self[$ "hm_gungod_rolled"]??false) && !hm_gungod_replaced) return;
    var _original=noone;
    with(enemy) if(hm_arkintide_mod_gml_hm_stage_boss_actor() && !scrHMReplacementActor1102()) {_original=id;break;}
    if(!instance_exists(_original)) return;
    if(!variable_instance_exists(id,"hm_gungod_rolled")) {
        hm_gungod_rolled=true;hm_gungod_replaced=false;
        var _roll=random(1),_kind=_roll<.05?1:(_roll<.10?2:0);
        if(!_kind) return;
        var _tile=_kind==1?hm_arkintide_mod_gml_hm_venus_boss_floor(_original.x,_original.y)
                           :hm_arkintide_mod_gml_hm_gungod_floor(_original.x,_original.y);
        if(!instance_exists(_tile)) return;
        var _actor=_kind==1?scrHMChiefCreate1102(_tile.x+16,_tile.y+16)
                           :hm_bosses_gungod_mod_gml_GunGod_create(_tile.x+16,_tile.y+16);
        if(!instance_exists(_actor)) return;
        hm_gungod_replaced=true;
        if(_kind==2) {
            with(_actor) scrHMReplacementGunGodHealth1115();
            with(_actor) hm_arkintide_mod_gml_hm_gungod_bounds();
            if(!(variable_instance_get(GameCont,"hm_yv_seen")??false)) {
                GameCont.hm_yv_seen=true;
                with(_actor) scrBossIntro(10,true);
                scrHMSoundMusic(musBoss9);
            }
        }
    }
    if(!hm_gungod_replaced) return;
    with(enemy) if(hm_arkintide_mod_gml_hm_stage_boss_actor() && !scrHMReplacementActor1102()) {scrHMBossGroupRetire115(id);scrHMDelete(id);}
    with(WantBoss) scrHMDelete(id);with(WantLH) scrHMDelete(id);with(BecomeScrapBoss) scrHMDelete(id);
    with(CustomObject) if(array_contains(["wanttitank","wantravenboss","hm_hunter_pending"],name)) scrHMDelete(id);
}

function scrHMChiefCreate1102(_x,_y) {
    // Keep the host Last identity: native alarms, collisions and 60Hz movement
    // require no NTT CustomEnemy event forwarding or recursive callbacks.
    var _actor=instance_create(_x,_y,Last);
    with(_actor) {
        scrHMActorInit();
        name="hm_chief";scrHMBossHealth1103();hm_chief1102=true;hm_chief_dead1102=false;
        hm_chief_arrival1102=20;hm_chief_presented1102=false;
        hm_chief_combat1115=false;hm_chief_summons1115=0;hm_chief_action1115=0;
        intro=1;newintro=-1;corpse=0;
        drawspr=sprLastWarpIn;drawimg=0;speed=0;
        for(var _i=0;_i<12;++_i) alarm[_i]=-1;
    }
    return _actor;
}
function scrHMChiefStep1102() {
    if(!(self[$ "hm_chief1102"]??false)) return false;
    if(lockstep_stop || UberCont.paused || (self[$ "hm_portrait_frozen"]??false)) return true;
    if(hp<=0) {instance_destroy();return true;}
    if(hm_chief_arrival1102>0) {
        speed=0;hm_chief_arrival1102-=timescale;
        if(hm_chief_arrival1102>0) return true;
    }
    if(!hm_chief_presented1102) {
        hm_chief_presented1102=true;drawspr=sprLastIdle;drawimg=0;
        scrHMSoundMusic(musBoss8);
        if(!(variable_instance_get(GameCont,"hm_chief_seen")??false)) {
            GameCont.hm_chief_seen=true;
            scrBossIntro(8,true);
        }
        return true;
    }
    // Portrait and camera share one frozen presentation controller.
    // Combat starts only after that controller has released the scene.
    if(!hm_chief_combat1115) {
        speed=0;drawspr=sprLastIdle;drawimg=0;
        if(UberCont.bossintro || instance_exists(Cinematic)) return true;
        scrHMBossCamera1101(id,false);
        if(instance_exists(HMWorld.hm_portrait_active) || (self[$ "hm_portrait_frozen"]??false)) return true;
        hm_chief_combat1115=true;
        alarm[1]=10;
        return true;
    }
    scrHMBossCamera1101(id,false);
    return self[$ "hm_portrait_frozen"]??false;
}
function scrHMChiefAlarm1115() {
    if(!scrHMEnabled() || !(self[$ "hm_chief1102"]??false)) return false;
    return !(self[$ "hm_chief_combat1115"]??false) || lockstep_stop || UberCont.paused
        || UberCont.bossintro || (self[$ "hm_portrait_frozen"]??false);
}
function scrHMChiefSpeed1115() {
    // Desktop Last keeps native movement speeds and shortens its attack
    // cooldown with current health. Loop never adds a separate multiplier.
    return 1;
}
function scrHMChiefAction1115() {
    // Native alarms already advance once at the host's selected frame rate.
    // Advancing them again here changed desktop cadence and could duplicate
    // an attack during the same frame.
    return;
}
function scrHMChiefSummon1115() {
    if(!(self[$ "hm_chief1102"]??false) || scrHMChiefAlarm1115() || hp<=0) return;
    // The replacement encounter needs the HQ reinforcement gate as well as
    // the Captain's own teleport attack. Reuse the ordinary animated gate.
    var _gate=instance_create(x,y,IDPDSpawn);
    if(instance_exists(_gate)) {
        _gate.hm_chief_owner1115=id;
        hm_chief_summons1115++;
    }
}
function scrHMChiefDeath1102() {
    if(!(self[$ "hm_chief1102"]??false)) return false;
    if(hm_chief_dead1102) return true;
    hm_chief_dead1102=true;
    with(instance_create(x,y,PopoExplosion)) {
        creator=other.id;hitid=other.hitid;team=other.team;
        hm_chief_death_explosion1115=true;
    }
    var _fx=instance_create(x,y,CustomObject);
    with(_fx) {
        name="hm_chief_departure";sprite_visible=false;
        hm_chief_fx1102=0;hm_chief_right1102=other.right;depth=other.depth;
        on_step=scrHMChiefDepartureStep1102;on_draw=scrHMChiefDepartureDraw1102;
    }
    scrHMBossCamera1101(_fx,true);
    // Generic enemy death owns the real last-casualty Corpse/clear timer.
    // Do not execute Last.Destroy, LastDie or the stock campaign ending.
    event_perform_object(enemy,ev_destroy,0);
    scrHMFinalBossSupplies1115();
    hm_arkintide_mod_gml_hm_gungod_win();
    return true;
}
function scrHMChiefDepartureStep1102() {
    if(++hm_chief_fx1102>=40) instance_destroy(id,false);
}
function scrHMChiefDepartureDraw1102() {
    var _time=hm_chief_fx1102,_spr=_time<20?sprPopoPortal:sprPopoPortalDisappear;
    var _frame=(_time<20?_time:_time-20)*.4;
    scrHMDrawSpriteExt(_spr,min(_frame,sprite_get_number(_spr)-1),x,y,1,1,0,c_white,1);
    if(_time<20) scrHMDrawSpriteExt(sprLastWarpOut,min(_time*.4,sprite_get_number(sprLastWarpOut)-1),x,y,hm_chief_right1102,1,0,c_white,1);
}

// Keep the final rewards separate from the helicopter's nonlethal phase
// change. A real final death grants exactly three independent supplies.
function scrHMFinalBossSupplies1115() {
    if(self[$ "hm_final_supplies1115"]??false) return;
    hm_final_supplies1115=true;
    repeat(3) with(instance_create(x,y,choose(AmmoPickup,HPPickup))) {
        motion_add(random(360),2*timescale);
        hm_final_supply1115=true;
    }
}

function scrHMLoopEnemyStart1115() {
    return scrHMPoliceArea107(GameCont.area)?3:1;
}

function scrHMPoliceGroup1115() {
    var _kind=hm_arkintide_mod_gml_hm_infantry_kind();
    var _amount=hm_arkintide_mod_gml_hm_infantry_amount(_kind,GameCont.loops);
    hm_spawn_kind1115=_kind;hm_spawn_count1115=_amount;
    repeat(_amount) with(instance_create(x+orandom(2),y+orandom(2),_kind)) {
        hm_arrival_gate1115=other.id;
        if(object_index==Grunt) more=1;
        motion_add(random(360),2*timescale);
    }
}

function scrHMThronePlayerGround1115() {
    if(!scrHMEnabled() || !instance_exists(GameCont) || instance_exists(GenCont)
       || GameCont.area!=scrHMAreaResolve("throne") || !scrHMThroneSecond1104()
       || (self[$ "fallenable"]??-1)==1 || (variable_instance_get(GameCont, "hm_followup_throne_second_dead")??false)) return;
    // Phase two removes the hall's walls. Its surviving Floor cells, rather
    // than an obsolete wall mask, define the platform the player can walk on.
    var _valid=position_meeting(x,y,Floor) && !place_meeting(x,y,Wall);
    if(_valid) {hm_platform_x1115=x;hm_platform_y1115=y;return;}
    var _sx=self[$ "hm_platform_x1115"]??xprevious;
    var _sy=self[$ "hm_platform_y1115"]??yprevious;
    if(position_meeting(_sx,_sy,Floor) && !place_meeting(_sx,_sy,Wall)) {
        var _nx=x,_ny=y;
        if(!position_meeting(_nx,_sy,Floor) || place_meeting(_nx,_sy,Wall)) {_nx=_sx;hspeed=0;}
        if(!position_meeting(_nx,_ny,Floor) || place_meeting(_nx,_ny,Wall)) {_ny=_sy;vspeed=0;}
        x=_nx;y=_ny;
    } else {
        var _floor=noone,_best=infinity;
        with(Floor) {
            var _dx=x+16-other.x,_dy=y+16-other.y,_d=_dx*_dx+_dy*_dy;
            if(_d>=_best) continue;
            with(other) if(!place_meeting(other.x+16,other.y+16,Wall)) {_floor=other.id;_best=_d;}
        }
        if(instance_exists(_floor)) {x=_floor.x+16;y=_floor.y+16;speed=0;}
    }
    xprevious=x;yprevious=y;hm_platform_x1115=x;hm_platform_y1115=y;
}
function scrHMChiefBallBurst1102() {
if(!scrHMEnabled()||!instance_exists(GameCont)) return false;
    // Own the complete burst: appending Loop beams to the native ten leaves
    // uneven gaps. One native random draw anchors every speed layer, while
    // the complete ten-plus-Loop beam count divides the same full circle.
    var _beams=10+max(0,floor(GameCont.loops)),_angle=random_angle,_velocity=4;
    var _spacing=360/_beams,_source=self[$ "creator"]??noone;
    repeat(8) {
        for(var _beam=0;_beam<_beams;++_beam) {
            with(scr_projectile_create(x,y,IDPDBullet,_angle+_spacing*_beam,_velocity)) {
                team=other.team;hitid=other.hitid;creator=_source;image_angle=direction;
            }
        }
        _velocity+=.6;
    }
    return true;
}
