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
