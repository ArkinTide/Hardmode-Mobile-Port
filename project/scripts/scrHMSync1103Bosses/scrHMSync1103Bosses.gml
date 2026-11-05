// Report17 / Followup18 boss rules adapted to the mobile host. These helpers
// run on its existing 30 Hz MOD logic pass; native movement stays at 60 Hz.
function scrHMBossLoopFactor1103() {
    if((variable_instance_get(GameCont,"hm_extra_pending")??false) || (self[$ "hm_extra"]??false)
       || (self[$ "hm_palace_guardian"]??false)) return 1;
    return GameCont.loops>0?1.3:1;
}
function scrHMBossHealth1103() {
    if((variable_instance_get(GameCont,"hm_extra_pending")??false) || (self[$ "hm_extra"]??false)
       || (self[$ "hm_palace_guardian"]??false)
       || (self[$ "hm_report_boss_health_done1103"]??false) || max_hp<=0 || hp<=0) return;
    // Call after every constructor/additive native health edit has completed.
    // Mutations, co-op and the native five percent must not be applied twice.
    hm_report_boss_health_done1103=true;
    var _factor=scrHMBossLoopFactor1103();
    max_hp*=_factor;hp*=_factor;
}
function scrHMGunGodHealth1103() {
    if((variable_instance_get(GameCont,"hm_extra_pending")??false) || (self[$ "hm_extra"]??false)
       || (self[$ "hm_report_boss_health_done1103"]??false)) return;
    hm_report_boss_health_done1103=true;
    var _factor=scrHMBossLoopFactor1103();
    // 14250 is the original phase floor, not helicopter combat health.
    max_hp=14250+(max_hp-14250)*_factor;
    hp=14250+(hp-14250)*_factor;
}
function scrHMNativeBossHealth1103() {
    // These native actors receive Hardmode's additive health on first sight.
    // Their latch belongs to maincode, so this sweep must follow maincode.
    with(BanditBoss) if((self[$ "newintro"]??0)<0) scrHMBossHealth1103();
    with(OasisBoss) if((self[$ "newintro"]??0)<0) scrHMBossHealth1103();
    with(HyperCrystal) if((self[$ "newintro"]??0)<0) scrHMBossHealth1103();
    with(LilHunter) if((self[$ "newintro"]??0)<0) scrHMBossHealth1103();
    with(Last) if((self[$ "newintro"]??0)<0) scrHMBossHealth1103();
    with(ScrapBoss) if((self[$ "morehp"]??0)==1) scrHMBossHealth1103();
    with(FrogQueen) scrHMBossHealth1103();
    with(TechnoMancer) scrHMBossHealth1103();
    with(CrownGuardian) scrHMBossHealth1103();
    with(YVBoss) if(intro>0 && !(self[$ "hm_maxhealth_init"]??false)) scrHMBossHealth1103();
}

function scrHMReportAssets1103() {
    if(variable_global_exists("hm_report_title_font1103") && font_exists(global.hm_report_title_font1103)) return;
    global.hm_report_title_font1103=font_add_sprite_ext(sprHMBossTitleGlyphs1103,
        " .ABCDEFGHIJKLMNOPQRSTUVWXYZ!:'/?¡¿ÁÀÄÂÃȦÆÇÉÈЁÊĞÍÌЇÎÑÓÒÖÔŒŞÚÙÜÛŸßİŚĄĆĘĞİŁŃŹŻ",true,2);
}
function scrHMReportIntroDraw1103(_x,_y,_title) {
    var _font=draw_get_font();
    if(_title=="The#Messenger" || _title=="THE#MESSENGER") {
        draw_sprite(sprHMMessengerTitle1103,0,_x,_y-7);
    } else {
        scrHMReportAssets1103();draw_set_font(global.hm_report_title_font1103);
        // The localized text helper intentionally selects the CJK UI font.
        // Portrait titles use only this isolated original sprite font.
        draw_text_nt(_x,_y,string_replace_all(" "+string_upper(_title),"#","\n"));
    }
    draw_set_font(_font);
}
function scrHMThroneBarVisible1103() {
    // NothingInactive is a one-HP transition prop, never the fighting boss.
    return object_index==Nothing && hp>0;
}

function scrHMMessengerInit1103() {
    hm_messenger_no_presentation1103=revived>0;
    on_hurt=scrHMScriptRef(scrHMMessengerHurt1103);
    if(revived==0) {
        hitid=[sprMutant12BIdle,"The Messenger"];
        scrHMBossHealth1103();
    }
}
function scrHMMessengerOwnsHit1103(_hitid) {
    // Test the exact recorded actor ID, including an owner's already airborne
    // blast after its death. Other Messengers' neutral explosions still hurt.
    return is_array(_hitid) && array_length(_hitid)>2 && _hitid[2]==id;
}
function scrHMMessengerHurt1103(_damage,_knockback,_direction) {
    var _hitid=self[$ "hm_last_hitid"]??HitId.None;
    if(scrHMMessengerOwnsHit1103(_hitid)) return;
    var _saved=on_hurt;
    on_hurt=undefined;
    var _hit=scr_hit(id,_damage,_hitid);
    // scrHMActorHurt converts the physical recoil to NTT's logical velocity.
    // Restore it once when re-entering the ordinary mobile damage operation.
    if(_hit && _damage>0 && _knockback!=0) motion_add(_direction,_knockback*timescale);
    if(instance_exists(id)) on_hurt=_saved;
}
function scrHMMessengerTagExplosion1103(_owner) {
    if(!instance_exists(_owner)) return;
    var _old=_owner.hitid;
    hitid=[is_array(_old)?_old[0]:sprPopoExplo,is_array(_old)?_old[1]:"IDPD STRIKE",_owner.id];
    creator=_owner.id;
}
function scrHMMessengerCorpse1103(_owner) {
    hm_messenger_no_presentation1103=(_owner[$ "revived"]??0)>0;
    if(hm_messenger_no_presentation1103) music=1;
}
function scrHMMessengerSkipPresentation1103(_focus) {
    return instance_exists(_focus) && (_focus[$ "hm_messenger_no_presentation1103"]??false);
}
function scrHMMessengerIntro1103() {
    if(intro!=0 || !instance_exists(target)) return;
    if(revived>0) {
        // Reviving resumes combat without capturing the camera or players.
        gunangle=point_direction(x,y,target.x,target.y);intro=1;return;
    }
    if(!targetvisible || (distance_to_object(target)>=120 && hp>max_hp-1)) return;
    spr_idle=sprMutant12BIdle;
    instance_create(x,y,HitWarning);scrHMSoundPlay(sndMutant12LowA);
    var _pan=scrHMModExists("mod","options","intropan") && scrHMModGet("mod","options","intropan")=="1";
    if(UberCont.opt_bossintro==1) {
        hm_bosses_bossintros_mod_gml_boss_trigger("The Messenger",mskNone,sprHMMessengerPortrait1103,mskNone,id,60);
    } else if(_pan) {
        hm_bosses_bossintros_mod_gml_boss_trigger("",mskNone,mskNone,mskNone,id,0);
    }
    gunangle=point_direction(x,y,target.x,target.y);intro=1;
}

function scrHMPalaceGuardianCreate1103(_x,_y) {
    var _actor=instance_create(_x,_y,CrownGuardian);
    if(instance_exists(_actor)) with(_actor) {
        // Keep the native actor identity, alarms, collisions and 60 Hz motion.
        // It is ordinary Palace population, not an additional-boss slot.
        hm_palace_guardian=true;name="hm_palace_guardian";boss=0;newintro=-1;
    }
    return _actor;
}
function scrHMPalaceGuardianDeath1103() {
    if(!(self[$ "hm_palace_guardian"]??false)) return false;
    // The native Destroy tail schedules boss-win music. Preserve ordinary
    // enemy death, the native supply roll and projectile clear without it.
    event_perform_object(enemy,ev_destroy,0);
    if(hp<=0 && team!=team_player && !(self[$ "hm_report_guardian_drop"]??false)) {
        hm_report_guardian_drop=true;instance_create(x,y,PortalClear);scrDrop(50,0);
    }
    return true;
}

function scrHMActorOnScreen1103() {
    var _camera=view_camera[0],_left=camera_get_view_x(_camera),_top=camera_get_view_y(_camera);
    return bbox_right>=_left && bbox_left<_left+camera_get_view_width(_camera)
        && bbox_bottom>=_top && bbox_top<_top+camera_get_view_height(_camera);
}
function scrHMMinigunnerReset1103() {
    firing=0;hm_minigun_state1103=0;hm_minigun_shots1103=0;
    alrm1=max(alrm1,30);
}
function scrHMMinigunnerStep1103() {
    if(!variable_instance_exists(id,"hm_minigun_state1103")) {
        hm_minigun_state1103=0;hm_minigun_shots1103=0;hm_minigun_wait1103=0;
    }
    if(nexthurt>current_frame) {
        if(sprite_index!=spr_hurt) {
            image_index=0;sprite_index=spr_hurt;
            var _blood=instance_create(x,y,BloodStreak);_blood.direction=direction;
        }
    } else sprite_index=firing>0?spr_fire:spr_idle;
    if(speed>4*timescale) speed=3.5*timescale;
    target=noone;targetvisible=0;
    if(instance_exists(Player)) target=instance_nearest(x,y,Player);
    if(!scrHMActorOnScreen1103() || !instance_exists(target)) {scrHMMinigunnerReset1103();return;}
    targetvisible=collision_line(x,y,target.x,target.y,Wall,false,true)==noone;
    if(!targetvisible) {scrHMMinigunnerReset1103();return;}
    if(hm_minigun_state1103==0) {
        if(--alrm1>0) return;
        hm_minigun_state1103=1;hm_minigun_wait1103=60;
        direction=point_direction(x,y,target.x,target.y);gunangle=direction;
        image_xscale=target.x>x?1:-1;
        // HitWarning is this host's AssassinNotice object (same sprite).
        instance_create(x,y,HitWarning);scrHMSoundPitch(sndSwapMachinegun,.8);
        return;
    }
    if(--hm_minigun_wait1103>0) return;
    if(hm_minigun_state1103==1) {
        hm_minigun_state1103=2;hm_minigun_shots1103=100;firing=1;
        hm_minigun_aim1103=point_direction(x,y,target.x+hspeed/timescale,target.y+vspeed/timescale);
        image_xscale=target.x>x?1:-1;
    }
    gunangle=hm_minigun_aim1103+random_range(-20,20);
    if(GameCont.area!=scrHMAreaResolve("venuz")) hm_arkintide_mod_gml_hm_minigun_shot();
    else scrHMMinigunnerVenusShot1103();
    hm_minigun_shots1103--;hm_minigun_wait1103=1;
    if(hm_minigun_shots1103<=0) {firing=0;hm_minigun_state1103=0;alrm1=200;}
}
function scrHMMinigunnerVenusShot1103() {
    // Preserve b24 Venus hitscan and visuals; the synchronous schedule above
    // lets offscreen/lost-sight cancellation stop every subsequent shot.
    var _dist=4;
    scrHMSoundPitchVolume(sndMinigun,.9,min(1,(view_width/4)/max(1,distance_to_object(Player))));
    while(place_free(x+lengthdir_x(_dist,gunangle),y+lengthdir_y(_dist,gunangle))
        && !place_meeting(x+lengthdir_x(_dist,gunangle),y+lengthdir_y(_dist,gunangle),Player)
        && !place_meeting(x+lengthdir_x(_dist,gunangle),y+lengthdir_y(_dist,gunangle),CustomHitme)
        && _dist<view_width*3) _dist+=4;
    var _shot=instance_create(x+lengthdir_x(_dist,gunangle),y+lengthdir_y(_dist,gunangle),Bullet1);
    with(_shot) {
        scrHMMotionAdd(other.gunangle,10);image_angle=direction;image_alpha=0;
        hitid=other.hitid;damage=1;knockback_speed=timescale;team=other.team;creator=other.id;
    }
    var _trail=instance_create(x+lengthdir_x(_dist/2,gunangle),y+lengthdir_y(_dist/2,gunangle),Effect);
    with(_trail) {
        name="venuzpistoltrail";sprite_index=sprBoltTrail;direction=other.gunangle;
        image_angle=direction+90;creator=other.id;image_yscale*=_dist;
        image_xscale=random_range(.5,1.5);image_alpha=random(1);
        scrHMMotionAdd(direction,random_range(0,1.5));
    }
    var _muzzle=instance_create(x+lengthdir_x(4,gunangle),y+lengthdir_y(4,gunangle),EBulletHit);
    _muzzle.sprite_index=sprScrapBossMissileTrail;_muzzle.image_angle=gunangle+180;_muzzle.image_speed=timescale;
}
