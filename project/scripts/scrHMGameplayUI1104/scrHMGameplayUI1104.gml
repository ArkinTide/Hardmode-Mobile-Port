function scrHMGameplayUI1104() {
    if(mode=="fix114names" && ticks==20) {
        scrHMGameplayLane107();scrLanguageSet("Simplified Chinese");UberCont.opt_language="Simplified Chinese";
        var _names=["BIG BANDIT","BIG DOG","LIL' HUNTER","GENERATOR","MOM","TECHNOMANCER",
            "BIG BUBBLER","CROWN GUARDIAN","HYPER CRYSTAL","CURSED HYPER CRYSTAL","THRONE II",
            "CAPTAIN","THE NUCLEAR THRONE","GIANT SCORPION","SUPER GATOR","BIG BIRD","BIG RAT",
            "LEONARDO","RAPHAEL","MICHELANGELO","DONATELLO","TITANK","GREAT GUARDIAN",
            "The Messenger","IDPD TANK","DA GUN GOD","TURTLE"];
        for(var _i=0;_i<array_length(_names);++_i) {
            var _label=scrHMLocalize(_names[_i]);
            scrHMGameplayCheck(_label!=_names[_i],"every bossbar presentation label has a Chinese translation: "+_names[_i]);
            var _layout=scrHMBossTitleLayout1101(80,_names[_i]);
            scrHMGameplayCheck(_layout.width<=76.001 && _layout.height<=10.001,"translated title fits its own compact row");
        }
        scrHMGameplayCheck(scrHMLocalize("THE NUCLEAR THRONE")=="核能王座","Throne uses the requested Chinese name");
        scrHMGameplayCheck(scrHMLocalize("THRONE II")=="王座II","Throne II uses the requested Chinese name");
        scrHMGameplayCheck(scrHMLocalize("The Messenger")=="通信员","Messenger uses the requested Chinese name");
        scrHMGameplayCheck(scrHMLocalize("GREAT GUARDIAN")=="至高守护者","Great Guardian uses the requested Chinese name");
        var _dummy=instance_create(player.x+80,player.y,CustomEnemy);
        with(_dummy) {name="hm_yv_phase";scrHMGameplayCheck(hm_hm_bossbar_mod_gml_hm_custom_boss_name()=="Y.V","Y.V remains the requested Latin display name");}
        instance_destroy(_dummy,false);
    }
    if(mode=="fix114bars" && ticks==20) {
        scrHMGameplayLane107();scrHMModSet("mod","options","bossbars","1");
        scrHMGameplayUICamera1104();
        var _boss=instance_create(player.x+80,player.y+10,BanditBoss);
        _boss.newintro=-1;_boss.hp=75;_boss.max_hp=100;_boss.speed=0;
        _boss.on_step=undefined;bar_actor114=_boss;
        var _guardian=instance_create(player.x+120,player.y,CustomEnemy);
        with(_guardian) {name="guardianboss";hp=210;max_hp=420;team=1;on_step=undefined;}
        bar_guardian114=_guardian;
        scrHMGameplayCheck(scrHMBossTopActorTest1104(_guardian),"real Great Guardian identity selects the top screen HUD");
        var _recorder=instance_create(0,0,CustomObject);
        with(_recorder) {name="test_bars114";owner=other.id;on_draw=scrHMScriptRef(scrHMGameplayBarsDraw1104);}
        bar_recorder114=_recorder;bars_rendered114=false;
    }
    if(mode=="fix114bars" && ticks==40) {
        scrHMGameplayCheck(bars_rendered114,"real GUI End event draws local and top bars over an opaque wall-colored surface");
        instance_destroy(bar_recorder114,false);
        with(enemy) instance_destroy(id,false);
    }
    if(mode=="fix114guardian" && ticks==20) {
        scrHMGameplayLane107();UberCont.opt_bossintro=0;
        UberCont.opt_shake=0;
        scrHMGameplayUICamera1104();
        hm_bosses_guardianboss_mod_gml_guardianboss_create(player.x+100,player.y);
        guardian114=noone;with(CustomEnemy) if(name=="guardianboss") {other.guardian114=id;on_step=undefined;spritealpha=1;}
        scrHMGameplayCheck(instance_exists(guardian114),"real Guardian constructor creates the correct boss identity");
        with(HMBinding) if(hm_code==scrHMScriptRef(hm_bosses_guardianboss_mod_gml_guardiandark_draw)) alpha=1;
        friendly114=instance_create(player.x+24,player.y,Bullet1);
        enemy114=instance_create(player.x+48,player.y,EnemyBullet1);
        custom114=instance_create(player.x+72,player.y,CustomProjectile);
        with(friendly114) {speed=0;hspeed=0;vspeed=0;team=team_player;creator=other.player;}
        with(enemy114) {speed=0;hspeed=0;vspeed=0;team=team_enemy;}
        with(custom114) {speed=0;team=team_enemy;sprite_index=sprEnemyBullet1;mask_index=mskNone;on_step=undefined;image_alpha=1;}
        // Real native constructors and ordinary Draw events: these effects
        // descend from damagesource directly, outside the projectile tree.
        explosion114=instance_create(player.x-84,player.y+36,Explosion);
        cannon114=instance_create(player.x-36,player.y+36,LaserCannon);
        impact114=instance_create(player.x+12,player.y+36,PlasmaImpact);
        with(explosion114) {damage=0;mask_index=mskNone;image_speed=0;image_index=1;}
        with(cannon114) {damage=0;mask_index=mskNone;alarm[0]=-1;image_xscale=.5;image_yscale=.5;}
        // Frame 1 is an authored all-black flash; frame 2 is the visible
        // green/white plasma impact, suitable for a pure-black arena capture.
        with(impact114) {damage=0;mask_index=mskNone;image_speed=0;image_index=2;}
        // Hold a native Laser's lifetime while keeping its actual three-part
        // beam Draw event. No test renderer redraws these sprites or beams.
        laser114=instance_create(player.x-24,player.y+70,Laser);
        with(laser114) {
            xstart=x-60;ystart=y;image_xscale=30;image_yscale=1.2;
            image_angle=0;speed=0;damage=0;mask_index=mskNone;
            alarm[0]=-1;hm_portrait_frozen=true;
        }
        guardian_sources114=[friendly114,enemy114,custom114,explosion114,cannon114,impact114,laser114];
        projectile_depths114=[];
        for(var _i=0;_i<array_length(guardian_sources114);++_i)
            array_push(projectile_depths114,guardian_sources114[_i].depth);
        with(HMWorld) scrHMGuardianLayers109();
    }
    if(mode=="fix114guardian" && ticks==25) {
        for(var _i=0;_i<array_length(guardian_sources114);++_i) {
            var _shot=guardian_sources114[_i];
            scrHMGameplayCheck(instance_exists(_shot) && _shot.visible && _shot.depth<=-9,
                "real friendly/enemy/MOD bullet, explosion, cannon, impact and laser draw above the Guardian blackout");
        }
        with(HMWorld) scrHMGuardianLayers109();
        for(var _i=0;_i<array_length(guardian_sources114);++_i)
            scrHMGameplayCheck(guardian_sources114[_i].hm_guard_depth109==projectile_depths114[_i],
                "repeated disjoint-family passes retain the original native depth");
        custom114.depth=-12;
        with(HMWorld) scrHMGuardianLayers109();
        scrHMGameplayCheck(custom114.depth==-12 && is_undefined(custom114.hm_guard_depth109),
            "an external depth change is preserved rather than restored over");
        custom114.depth=projectile_depths114[2];
        with(HMWorld) scrHMGuardianLayers109();
        var _front=instance_create(player.x,player.y,CustomProjectile);
        with(_front) {depth=-20;on_step=undefined;}
        with(HMWorld) scrHMGuardianLayers109();
        scrHMGameplayCheck(_front.depth==-20 && is_undefined(_front[$ "hm_guard_depth109"]),
            "an already foreground projectile is neither lifted nor recorded twice");
        instance_destroy(_front,false);
        guardian_frame114=true;
    }
    if(mode=="fix114guardian" && ticks==30) {
        scrHMGameplayCheck(self[$ "guardian_frame_saved114"]??false,
            "actual world Draw result saves native/MOD bullets, explosions, cannon, plasma impact and laser in the dark arena");
        with(HMBinding) if(hm_code==scrHMScriptRef(hm_bosses_guardianboss_mod_gml_guardiandark_draw)) instance_destroy(id,false);
        with(HMWorld) scrHMGuardianLayers109();
        for(var _i=0;_i<array_length(guardian_sources114);++_i)
            scrHMGameplayCheck(guardian_sources114[_i].depth==projectile_depths114[_i],
                "native/MOD bullets, explosions, cannon, impact and laser return to their original depths after the arena effect ends");
    }
}

function scrHMBossTopActorTest1104(_actor) {
    var _top=false;with(_actor) _top=scrHMBossTop1104();return _top;
}

function scrHMGameplayUICamera1104() {
    // The portable host's view_* macros are globals rather than camera reads.
    // A direct camera_set_view_pos alone leaves GUI world anchors and the
    // surface's ordinary world pass pointing to different rooms this frame.
    view_xview=player.x-view_width/2;view_yview=player.y-view_height/2;
    BackCont.viewxf=view_xview;BackCont.viewyf=view_yview;
    BackCont.viewx2=0;BackCont.viewy2=0;BackCont.force_snap_camera_position=true;
    KeyCont.dis_fire[player.index]=0;
    camera_set_view_pos(view_camera[0],view_xview,view_yview);
}

function scrHMGameplayBarsDraw1104() {
    if(!instance_exists(owner) || owner.bars_rendered114) return;
    var _surface=surface_create(ceil(view_width),ceil(view_height));
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_proj=matrix_get(matrix_projection);
    var _camera=camera_create_view(0,0,view_width,view_height,0,noone,-1,-1,0,0);
    surface_set_target(_surface);draw_clear_alpha(c_black,1);
    matrix_set(matrix_world,matrix_build_identity());camera_apply(_camera);
    // Opaque wall and monster artwork covers the entire controlled scene.
    // The live GUI End event must paint both health bars over those pixels.
    draw_sprite_stretched(sprWall1Top,0,0,0,view_width,view_height);
    draw_sprite_stretched(sprBanditBossIdle,0,0,0,view_width,view_height);
    var _font=draw_get_font(),_color=draw_get_color(),_alpha=draw_get_alpha();
    var _ha=draw_get_halign(),_va=draw_get_valign();
    // Execute the actual GUI End event after an opaque background, instead
    // of calling a replacement bar renderer from the ordinary world pass.
    with(HMWorld) event_perform(ev_draw,75);
    scrHMGameplayCheck(draw_get_font()==_font && draw_get_color()==_color && draw_get_alpha()==_alpha
        && draw_get_halign()==_ha && draw_get_valign()==_va,"GUI End overlay restores the complete incoming text draw state");
    var _top=surface_getpixel(_surface,view_width/2-70,25);
    var _x=owner.bar_actor114.x-view_xview-40;
    var _y=owner.bar_actor114.y-36-view_yview+5;
    var _local=surface_getpixel(_surface,_x,_y);
    show_debug_message("HARDMODE BARS114 PIXELS "+json_stringify({top:_top,local:_local,
        expected:c_red,local_x:_x,local_y:_y,view_x:view_xview,view_y:view_yview,
        width:view_width,height:view_height,gui_width:gui_w,gui_height:gui_h}));
    surface_reset_target();surface_save(_surface,game_directory+"bossbars114.png");surface_free(_surface);
    camera_destroy(_camera);matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_proj);
    scrHMGameplayCheck(_top==c_red && _local==c_red,"real GUI End pixels contain the Great Guardian HUD and world-anchored ordinary boss bar");
    owner.bars_rendered114=true;
}

function scrHMGameplayUIRender1104() {
    if(mode=="fix114guardian" && ticks>=25 && ticks<30 && !(self[$ "guardian_frame_saved114"]??false)
        && surface_exists(application_surface)) {
        // GUI End occurs after every native/custom ordinary Draw event. The
        // application surface records actual dark-arena layers and original
        // native projectile/effect Draw events, never a replacement renderer.
        var _scalex=surface_get_width(application_surface)/view_width;
        var _scaley=surface_get_height(application_surface)/view_height;
        var _pixels=[];
        for(var _i=0;_i<array_length(guardian_sources114);++_i) {
            var _source=guardian_sources114[_i],_lit=0;
            var _box=scrHMGameplaySpriteBounds1104(_source);
            var _left=max(0,floor((_box[0]-view_xview)*_scalex));
            var _top=max(0,floor((_box[1]-view_yview)*_scaley));
            var _right=min(surface_get_width(application_surface)-1,ceil((_box[2]-view_xview)*_scalex));
            var _bottom=min(surface_get_height(application_surface)-1,ceil((_box[3]-view_yview)*_scaley));
            for(var _sx=_left;_sx<=_right;++_sx) for(var _sy=_top;_sy<=_bottom;++_sy)
                if(surface_getpixel(application_surface,_sx,_sy)!=c_black) _lit++;
            array_push(_pixels,{object:object_get_name(_source.object_index),
                sprite:sprite_get_name(_source.sprite_index),frame:_source.image_index,depth:_source.depth,
                bounds:[_left,_top,_right,_bottom],lit:_lit});
        }
        show_debug_message("HARDMODE GUARDIAN114 PIXELS "+json_stringify(_pixels));
        surface_save(application_surface,game_directory+"guardian-projectiles114.png");
        // Always retain the actual frame and every source's exact projected
        // sprite box, even when a visibility assertion rejects the capture.
        for(var _i=0;_i<array_length(_pixels);++_i)
            scrHMGameplayCheck(_pixels[_i].lit>0,
                "actual dark-arena surface contains visible pixels inside the original sprite bounds of "+_pixels[_i].object);
        guardian_frame_saved114=true;
    }
}

function scrHMGameplaySpriteBounds1104(_source) {
    var _sprite=_source.sprite_index;
    var _left=(sprite_get_bbox_left(_sprite)-sprite_get_xoffset(_sprite))*_source.image_xscale;
    var _right=(sprite_get_bbox_right(_sprite)+1-sprite_get_xoffset(_sprite))*_source.image_xscale;
    var _top=(sprite_get_bbox_top(_sprite)-sprite_get_yoffset(_sprite))*_source.image_yscale;
    var _bottom=(sprite_get_bbox_bottom(_sprite)+1-sprite_get_yoffset(_sprite))*_source.image_yscale;
    var _corners=[[_left,_top],[_right,_top],[_left,_bottom],[_right,_bottom]];
    var _bounds=[infinity,infinity,-infinity,-infinity],_angle=_source.image_angle;
    for(var _i=0;_i<4;++_i) {
        var _dx=_corners[_i][0],_dy=_corners[_i][1];
        var _x=_source.x+lengthdir_x(_dx,_angle)+lengthdir_x(_dy,_angle-90);
        var _y=_source.y+lengthdir_y(_dx,_angle)+lengthdir_y(_dy,_angle-90);
        _bounds[0]=min(_bounds[0],_x);_bounds[1]=min(_bounds[1],_y);
        _bounds[2]=max(_bounds[2],_x);_bounds[3]=max(_bounds[3],_y);
    }
    return _bounds;
}
