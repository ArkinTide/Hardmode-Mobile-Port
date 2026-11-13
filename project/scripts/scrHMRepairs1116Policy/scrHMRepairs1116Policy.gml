// Keep police escalation separate from the ordinary Loop1 enemy additions.
function scrHMPoliceLate1116() {
    return instance_exists(GameCont) && GameCont.loops>=3;
}

function scrHMPoliceKind1116() {
    if(scrHMPoliceLate1116() && random(1)<.5) return PopoFreak;
    return choose(Grunt,Inspector,Shielder,EliteGrunt,EliteInspector,EliteShielder);
}

function scrHMPoliceRevivalBlocked1116() {
    if(!scrHMEnabled() || scrHMPoliceLate1116()) return false;
    // Messenger revival has its own explicit lifecycle and runs first.
    instance_destroy(id,false);
    return true;
}

function scrHMTankNoRadiation1116() {
    return scrHMEnabled() && !scrHMPoliceLate1116()
        && (self[$ "name"]??"")=="IDPDTank";
}

function scrHMStageBanditCreate1116() {
    if(!scrHMEnabled() || !instance_exists(GameCont) || GameCont.loops<1
        || GameCont.area!=scrHMAreaResolve(1) || GameCont.subarea!=3
        || (variable_instance_get(GameCont,"hm_extra_pending")??false)) return;
    // Run after the real native Create has assigned its sprite and hit ID.
    // The room controller can run before WantBoss's asynchronous arrival.
    hm_arkintide_mod_gml_hm_stage_bandit_tick();
}

function scrHMSnowPopulation1116() {
    if(GameCont.loops<1 || !array_contains([scrHMAreaResolve(1),scrHMAreaResolve("jungle")],GameCont.area)) return;
    var _candidates=[];
    with(Floor) {
        var _px=x+16,_py=y+16;
        if(scrHMExtraPlayerDistance21103(_px,_py)<16384) continue;
        if(collision_circle(_px,_py,12,[Wall,InvisiWall,enemy,chestprop,CustomHitme],false,true)!=noone) continue;
        array_push(_candidates,id);
    }
    var _amount=min(array_length(_candidates),min(3,1+GameCont.loops div 3));
    repeat(_amount) {
        var _index=irandom(array_length(_candidates)-1),_tile=_candidates[_index];
        array_delete(_candidates,_index,1);
        if(!instance_exists(_tile)) continue;
        var _actor=hm_enemies_mod_gml_elitebandit_create(_tile.x+16,_tile.y+16,0);
        if(instance_exists(_actor)) with(_actor) {
            hm_snow_bandit1116=true;
            spr_idle=sprSnowBanditIdle;spr_walk=sprSnowBanditWalk;
            spr_hurt=sprSnowBanditHurt;spr_dead=sprSnowBanditDead;
            sprite_index=spr_idle;hitid=[sprSnowBanditIdle,"Bandit"];
        }
    }
}

function scrHMExtraCrystalIdentity1116() {
    if((self[$ "hm_extra_native"]??noone)!=HyperCrystal) return;
    // A native-event bridge changes object_index for a single callback. Keep
    // the variant on the living actor, independent of the current area/type.
    if(is_undefined(self[$ "hm_extra_cursed1116"]))
        hm_extra_cursed1116=(self[$ "hm_extra_kind"]??"")=="cursedcrystal";
    hm_extra_kind=hm_extra_cursed1116?"cursedcrystal":"crystal";
    hm_extra=true;
    spr_shadow=shd64;spr_shadow_x=0;spr_shadow_y=16;
    hitid=hm_extra_cursed1116
        ?[global.hm_module_vars[$ "mod:arkintide"].hm_extra_cursed_idle,"CURSED HYPER CRYSTAL"]
        :HitId.HyperCrystal;
}

function scrHMExtraCrystalChild1116() {
    if(scrHMEnabled() && ((self[$ "hm_extra_cursed1116"]??false)
        || (self[$ "hm_extra_kind"]??"")=="cursedcrystal"))
        return choose(InvLaserCrystal,InvLaserCrystal,InvLaserCrystal,LightningCrystal);
    return GameCont.area==104?choose(InvLaserCrystal,InvLaserCrystal,InvLaserCrystal,LightningCrystal):LaserCrystal;
}

function scrHMExtraCrystalBlink1116() {
    if(!instance_exists(target)) return false;
    var _toward=point_direction(x,y,target.x,target.y);
    var _distance=point_distance(x,y,target.x,target.y)>view_width-32
        ?min(point_distance(x,y,target.x,target.y)*.5,160):64;
    var _angle=_distance>64?_toward:_toward+choose(-90,90)+random_range(-30,30);
    // Narrow generated corridors may have no full-mask space on a 64px ring.
    // Try shorter rings before abandoning the blink, with identical floor and
    // wall validation at every candidate; never teleport into walls.
    var _rings=[_distance,48,32];
    for(var _ring=0;_ring<array_length(_rings);++_ring)
    for(var _i=0;_i<8;++_i) {
        var _a=_angle+_i*45,_x=x+lengthdir_x(_rings[_ring],_a),_y=y+lengthdir_y(_rings[_ring],_a);
        if(!hm_arkintide_mod_gml_hm_extra_fit("cursedcrystal",_x,_y)) continue;
        var _oldx=x,_oldy=y;
        x=_x;y=_y;xprevious=x;yprevious=y;direction=_toward;
        hm_extra_last_blink1115=current_frame;
        instance_create(_oldx,_oldy,PortalClear);instance_create(x,y,PortalClear);
        return true;
    }
    return false;
}

// Runtime-imported death sprites use frames/second, while native sprites
// use frames/game-frame. Keep both at the original twelve subimages/second;
// applying timescale twice to imported sprites halves their speed at 60 Hz.
function scrHMDeathAnimationSpeed1116(_sprite) {
    if(!sprite_exists(_sprite)) return 0;
    var _speed=sprite_get_speed(_sprite);
    if(_speed<=0) return 0;
    if(sprite_get_speed_type(_sprite)==spritespeed_framespersecond) return 12/_speed;
    return .4*timescale/_speed;
}

function scrHMExtraCorpse1116(_owner) {
    if(!scrHMEnabled() || !instance_exists(_owner) || !(_owner[$ "hm_extra"]??false)) return;
    hm_extra=true;hm_extra_kind=_owner[$ "hm_extra_kind"]??"";
    hm_extra_death_owner1116=_owner;
    hm_no_revive109=true;
    music=1;
    // The corpse is a new animation, independent of the boss's last idle,
    // hurt or attack frame. Explicitly preserve all frames of the death art.
    image_index=0;image_speed=scrHMDeathAnimationSpeed1116(sprite_index);
    hm_extra_death_frames1116=image_number;
    hm_extra_death_started1116=HMWorld.logic_serial;
    hm_extra_animend_count1116=0;
}

function scrHMExtraDeathVisual1116() {
    if(!(self[$ "hm_extra"]??false) || (self[$ "hm_extra_death_visual1116"]??false)) return;
    hm_extra_death_visual1116=true;
    switch(self[$ "hm_extra_kind"]??"") {
        case "mom":
            // The native mother explodes after her dying animation; a plain
            // duplicated corpse sprite skips that actual transition object.
            corpse=false;
            with(instance_create(x,y,FrogQueenDeath)) {
                hm_extra=true;hm_extra_kind="mom";music=1;
                image_xscale=other.right;hitid=other.hitid;team=other.team;
            }
            break;
        case "dog":
            corpse=false;
            with(instance_create(x,y,BigDogExplo)) {hm_extra=true;hm_extra_kind="dog";}
            break;
        case "bubble":scrHMOasisBossDeath();break;
        case "rogue":
            // Keep the Messenger's actual IDPD death blast, while the normal
            // corpse route below supplies its animated art without revival.
            with(instance_create(x,y,PopoExplosion)) {
                hm_extra=true;hm_extra_kind="rogue";
                scrHMMessengerTagExplosion1103(other.id);
            }
            break;
        case "bird":
            repeat(32) with(instance_create(x,y,Feather)) {
                sprite_index=sprRavenFeather;direction=random(360);speed=(3+random(6))*timescale;
            }
            break;
    }
}

// Native boss art and the existing camera pan now share one live controller.
// This keeps the world visible behind the portrait instead of covering a
// moving camera with a paused screenshot, and freezes combat only once.
function scrHMBossNativeRequest1116(_index) {
    if(!scrHMEnabled() || !instance_exists(HMWorld) || !instance_exists(Player)) return false;
    if(instance_exists(CoopController)) return true;
    var _source=id,_kind=scrHMBossGroupKind115(_source);
    if(_kind=="") {
        var _expected=["bandit","dog","hunter","throne","throne2","mother","crystal","tech","chief","crystal","yv"];
        if(_index<0 || _index>=array_length(_expected)) return false;
        _kind=_expected[_index];_source=noone;
        var _nearest=1000000000000,_cx=x,_cy=y;
        with(enemy) if(scrHMBossGroupKind115(id)==_kind && hp>0) {
            var _d=sqr(x-_cx)+sqr(y-_cy);
            if(_d<_nearest) {_nearest=_d;_source=id;}
        }
        if(!instance_exists(_source)) return false;
    }
    var _group=scrHMBossGroupRegister115(_source);
    if(is_undefined(_group)) return true;
    if(_group.entry_done) {
        // Native alarms can request their art after a custom entry pan has
        // already begun. Join that same live controller instead of losing
        // the art or starting a second camera. Repeated alarms never restart it.
        var _active=HMWorld.hm_portrait_active;
        if(UberCont.opt_bossintro && instance_exists(_active)
            && (_active[$ "hm_boss_kind115"]??"")==_kind
            && !(_active[$ "hm_boss_exit115"]??false)
            && !variable_instance_exists(_active,"hm_native_art1116"))
            scrHMBossNativeAttach1116(_active,_index);
        return true;
    }
    if(UberCont.opt_bossintro) _group.native_art1116=_index;
    if(is_undefined(_group.entry))
        _group.entry={title:"",back:mskNone,portrait:mskNone,front:mskNone,focus:_source,height:0};
    scrHMBossGroupTick115();
    return true;
}

function scrHMBossGroupDeath1116() {
    if(!scrHMEnabled() || !instance_exists(HMWorld) || !instance_exists(GameCont)) return;
    var _kind=scrHMBossGroupKind115(id);
    if(_kind=="") return;
    var _group=scrHMBossGroupReserve115(_kind);
    // Destroy can run after a teleport, a charge, or the last native Step.
    // Preserve that exact final position before the actor ID is invalidated.
    _group.x=x;_group.y=y;
    _group.death_x1116=x;_group.death_y1116=y;
}

function scrHMBossNativeAttach1116(_intro,_index) {
    if(!instance_exists(_intro)) return;
    _intro.hm_native_art1116=_index;
    _intro.hm_native_age1116=0;
    _intro.hm_native_x1116=320;
    _intro.hm_native_name_x1116=0;
    _intro.hm_native_splat1116=0;
    _intro.hm_native_start1116=HMWorld.logic_serial;
    if(!variable_instance_exists(_intro,"hm_camera_start1116"))
        _intro.hm_camera_start1116=HMWorld.logic_serial;
    _intro.hm_native_drawn1116=false;
    _intro.fadedark=0;
    scrHMSoundPlay(sndBossIntroIn);
}

function scrHMBossNativeStep1116() {
    if(!variable_instance_exists(id,"hm_native_art1116")) return;
    hm_native_age1116++;
    if(hm_native_x1116>20 || hm_native_x1116<5) hm_native_x1116-=60;
    else hm_native_x1116-=.5;
    if(hm_native_x1116<20) {
        hm_native_splat1116=min(3,hm_native_splat1116+1);
        hm_native_name_x1116+=hm_native_x1116<5?20:.5;
    }
    if(hm_native_age1116==40) scrHMSoundPlay(sndBossIntroOut);
}

function scrHMBossNativeDraw1116() {
    if(!variable_instance_exists(id,"hm_native_art1116") || hm_native_age1116>=40) return;
    hm_native_drawn1116=true;
    var _boss=hm_native_art1116,_x=hm_native_x1116,_center=view_width*.5;
    var _color=draw_get_color(),_alpha=draw_get_alpha();
    draw_set_color(c_black);draw_set_alpha(.7);
    draw_rectangle(0,0,view_width,view_height,false);
    draw_set_alpha(1);draw_set_color(c_white);
    scrHMDrawBossLetterbox(3);
    if(!array_contains([4,6,9,7,8],_boss)) draw_sprite(sprBossIntroBackLayer,_boss,_center+_x*1.6,0);
    draw_sprite(sprBossIntro,_boss,_center+_x,0);
    if(array_contains([4,6,9,7,8],_boss)) draw_sprite(sprBossIntroBackLayer,_boss,_center+_x*.5,0);
    if(_x<20) {
        draw_sprite(sprBossNameSplat,hm_native_splat1116,_center,view_height*.5);
        // Use the original native sprite title; no new font or atlas is needed.
        draw_sprite_ext(sprBossName,_boss,_center+1+hm_native_name_x1116,view_height*.5+1,1,1,0,c_black,1);
        draw_sprite(sprBossName,_boss,_center+hm_native_name_x1116,view_height*.5);
    }
    draw_set_color(_color);draw_set_alpha(_alpha);
}
