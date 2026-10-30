function scrHMGameplayRepairs111() {
    if(mode=="exploguardian111" && ticks==20) {
        scrHMGameplayLane107();
        with(projectile) instance_destroy(id,false);
        var _e=instance_create(player.x+64,player.y,ExploGuardian);
        _e.target=player;_e.charge=1;
        with(_e) event_perform(ev_alarm,2);
        scrHMGameplayCheck(instance_number(ExploguardianBullet)==26,"real attack event emits the desktop's 26 projectiles");
        var _angles=[];
        with(ExploguardianBullet) {
            array_push(_angles,direction);
            scrHMGameplayCheck(abs(speed-10*timescale)<.001&&team==_e.team&&hitid==_e.hitid,"attack projectile retains speed, team and hit attribution");
        }
        array_sort(_angles,true);
        for(var _i=0;_i<26;++_i) scrHMGameplayCheck(abs(((_angles[(_i+1) mod 26]-_angles[_i]+360) mod 360)-360/26)<.001,"attack ring has desktop angular spacing");
        with(projectile) instance_destroy(id,false);
        _e.charge=1;instance_destroy(_e);
        scrHMGameplayCheck(instance_number(ExploguardianBullet)==14,"charged death retains its distinct desktop fourteen-shot burst");
        with(projectile) instance_destroy(id,false);
        _e=instance_create(player.x+64,player.y,ExploGuardian);_e.charge=0;instance_destroy(_e);
        scrHMGameplayCheck(instance_number(ExploguardianBullet)==0,"uncharged death emits no extra burst");
    }
    if(mode=="water111" && ticks==30) {
        var _wet=0,_linked=0;
        with(Floor) if(traction==2) {_wet++;if(instance_exists(self[$ "hm_water_surface111"]??noone)) _linked++;}
        var _surfaces=0;with(CustomObject) if(name=="sewagefloor") _surfaces++;
        show_debug_message("HARDMODE WATER111 "+json_stringify({wet:_wet,linked:_linked,surfaces:_surfaces}));
        scrHMGameplayCheck(_wet==_linked&&_surfaces>=_wet,"every generated water tile links its real visual surface");
        scrHMGameplayLane107();
        var _f=instance_create(16001,16003,Floor);_f.traction=2;
        var _surface=instance_create(_f.x,_f.y,CustomObject);
        _surface.name="sewagefloor";_surface.sprite_index=sprHM_areas_sewers_area_4;
        _surface.image_xscale=.8;_surface.image_yscale=.8;
        with(_surface) scrHMWaterSurface111();
        HMWorld.hm_water_map=undefined;
        scrHMGameplayCheck(scrHMWaterAt(16017,16004),"plain water surface starts at its exact rectangle");
        _surface.sprite_index=sprHM_areas_sewers_area_3;
        scrHMGameplayCheck(!scrHMWaterAt(16017,16009.39)&&scrHMWaterAt(16017,16009.41),"delayed shoreline sprite excludes its 6.4px bank without a floor-count change");
        player.x=16017;player.y=16007;player.speed=0;
        with(player) {scrHMSwimLeave();scrHMSwimPlayer105();}
        scrHMGameplayCheck(!player.swimming&&player.image_alpha==1,"standing on visible bank has no swimming renderer");
        player.y=16012;
        with(player) scrHMSwimPlayer105();
        scrHMGameplayCheck(player.swimming&&player.image_alpha==0,"actual water foot point still enters swimming");
        player.y=16007;
        with(player) scrHMSwimPlayer105();
        scrHMGameplayCheck(!player.swimming&&player.image_alpha==1,"return to bank restores the player immediately");
        var _dry=instance_create(16017,16012,FloorExplo);HMWorld.hm_water_map=undefined;
        scrHMGameplayCheck(!scrHMWaterAt(16020,16014),"dry explosion patch still takes priority over water");
        instance_destroy(_dry,false);instance_destroy(_surface,false);instance_destroy(_f,false);
    }
    if(mode=="altar111" && ticks==30) {
        var _allowed=GameCont.area==scrHMAreaResolve("palace")&&GameCont.subarea==4;
        scrHMGameplayCheck(instance_number(ProtoStatue)==(_allowed?1:0),"real generation places exactly one altar only in 7-4");
        var _area=GameCont.area,_sub=GameCont.subarea,_visits=GameCont.crownvisits;
        with(ProtoStatue) instance_destroy(id,false);
        var _areas=[area_desert,area_scrapyards,area_city,area_palace,scrHMAreaResolve("city"),scrHMAreaResolve("sewers")];
        for(var _i=0;_i<array_length(_areas);++_i) {
            GameCont.area=_areas[_i];GameCont.subarea=min(scrAreaGetMaxSubarea(GameCont.area)-1,ceil(scrAreaGetMaxSubarea(GameCont.area)/2));
            GameCont.crownvisits=0;
            event_perform_object(GenCont,ev_alarm,2);
            scrHMCrownAltar109();
            scrHMGameplayCheck(!instance_exists(ProtoStatue),"old natural altar event cannot place outside 7-4 "+string(_areas[_i]));
        }
        GameCont.area=scrHMAreaResolve("palace");GameCont.subarea=4;
        GameCont.crownvisits=3;scrHMCrownAltar109();
        scrHMGameplayCheck(!instance_exists(ProtoStatue),"three prior vault visits prevent 7-4 altar");
        GameCont.crownvisits=2;scrHMCrownAltar109();scrHMCrownAltar109();
        scrHMGameplayCheck(instance_number(ProtoStatue)==1,"7-4 altar is unique with one remaining visit");
        with(ProtoStatue) instance_destroy(id,false);
        GameCont.area=_area;GameCont.subarea=_sub;GameCont.crownvisits=_visits;
    }
    if(array_contains(["cave111","music111"],mode) && ticks==10) {
        // Exercise native sighting/arrival instead of expecting boss music
        // before the encounter has started.
        var _boss=instance_find(HyperCrystal,0);
        scrHMGameplayCheck(instance_exists(_boss),"generated cave has its actual HyperCrystal");
        player.x=_boss.x+64;player.y=_boss.y;
        with(_boss) {target=other.player;intro=0;event_perform(ev_alarm,1);}
    }
    if(mode=="cave111" && ticks==20) {
        scrHMGameplayCheck(instance_exists(HyperCrystal),"cursed cave contains its actual boss");
        scrHMGameplayCheck(MusCont.song==musBoss6B&&audio_is_playing(musBoss6B),"cursed HyperCrystal plays its distinct boss music");
        cave_records111=[];
        with(Wall) if(self[$ "hm_plain106"]??false) array_push(other.cave_records111,[id,image_xscale,image_yscale]);
        scrHMGameplayCheck(array_length(cave_records111)>0,"conversion fixture includes compact collision walls");
        cave_kill111=true;
    }
    if(mode=="cave111" && ticks==50) with(HyperCrystal) hp=0;
    if(mode=="cave111" && ticks==300) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("caves"),"boss death restores ordinary cave area");
        var _walls=0,_wrong=0,_trans=0,_wrongtrans=0;
        with(Wall) {_walls++;if(topspr!=sprWall4Top||outspr!=sprWall4Out||sprite_index!=sprWall4Bot) _wrong++;}
        with(TopSmall) {_trans++;if(sprite_index!=sprWall4Trans) _wrongtrans++;}
        scrHMGameplayCheck(_walls>0&&_wrong==0,"every surviving wall face/top/outside uses normal cave sprites");
        scrHMGameplayCheck(_trans>0&&_wrongtrans==0,"every transition tile changes to normal cave sprites");
        for(var _i=0;_i<array_length(cave_records111);++_i) {
            var _r=cave_records111[_i],_wall=_r[0];
            scrHMGameplayCheck(instance_exists(_wall)&&_wall.image_xscale==_r[1]&&_wall.image_yscale==_r[2],"wall conversion preserves packed collision geometry");
        }
        show_debug_message("HARDMODE CAVE111 "+json_stringify({walls:_walls,wrong:_wrong,transitions:_trans,wrong_transitions:_wrongtrans,queue:array_length(HMWorld.hm_wall_theme_queue)}));
    }
    if(mode=="music111" && ticks==20)
        scrHMGameplayCheck(instance_exists(HyperCrystal)&&MusCont.song==musBoss6,"ordinary HyperCrystal retains ordinary boss music");
    if(mode=="shield111" && ticks==30) {
        scrHMGameplayLane107();
        for(var _b=0;_b<3;++_b) {
            var _spider=hm_enemies_mod_gml_EliteSpider_create(player.x+96,player.y);
            _spider.spr_idle=global.hm_module_vars[$ "mod:enemies"].EliteSpiderShield;
            _spider.image_alpha=1;_spider.image_index=8;_spider.alrm1=0;
            with(_spider) scrHMActorCallback("on_step");
            var _shield=noone;
            with(CustomObject) if((self[$ "creator"]??noone)==_spider&&name=="customshield") _shield=id;
            scrHMGameplayCheck(instance_exists(_shield),"pictured Elite Spider creates its actual shield");
            _shield.image_speed=0;
            var _shot=instance_create(_shield.x+4,_shield.y,(_b==0)?PlasmaBig:((_b==1)?PlasmaHuge:Bullet1));
            _shot.team=team_player;_shot.hitid=HitId.Player;_shot.creator=player;_shot.direction=180;_shot.speed=0;
            var _n=instance_number(Deflect);
            with(_shield) scrHMActorCallback("on_step");
            scrHMGameplayCheck(instance_number(Deflect)>_n&&_shot.direction!=180,"real spider mask actually reflects the projectile");
            scrHMGameplayCheck(_shot.team==(_b==2?_spider.team:team_player),"real shield preserves player plasma and ordinary bullet deflection policy");
            if(_b<2) {
                with(_shot) scrHMGameplayCheck(!scr_can_hit(HMGameplayTest.player,false)&&scr_can_hit(_spider,false),"reflected plasma is harmless to player and can damage enemies");
                scrHMGameplayCheck(_shot.creator==player&&_shot.hitid==HitId.Player,"plasma retains shooter and damage attribution");
                instance_destroy(_shot);
                var _children=0;
                with(projectile) if(instance_is(id,PlasmaBig)||instance_is(id,PlasmaBall)) {
                    _children++;
                    scrHMGameplayCheck(team==team_player&&!scr_can_hit(HMGameplayTest.player,false),"plasma explosion descendants retain player team");
                }
                scrHMGameplayCheck(_children==(_b==0?10:4),"real reflected plasma splits with its full payload");
            }
            with(projectile) instance_destroy(id,false);
            instance_destroy(_shield,false);instance_destroy(_spider,false);
        }
    }
    if(mode=="spider111" && ticks==20) {
        scrHMGameplayLane107();
        var _original_loop=GameCont.loops,_n=0;
        repeat(500) {
            var _spider=scrHMLoopSpider111(player.x+96,player.y);
            if(instance_exists(_spider)) {
                _n++;scrHMGameplayCheck(_spider.sprite_index==sprHM_enemies_mod_33
                    || _spider.spr_idle==sprHM_enemies_mod_33,"new loop population is the pictured Elite Spider");
                with(_spider) scrHMGameplayCheck(!place_meeting(x,y,Wall)&&place_meeting(x,y,Floor),"added spider has usable floor");
            }
        }
        scrHMGameplayCheck(_n>0&&_n<=4,"three requested areas add a bounded Elite Spider population");
        GameCont.loops=0;var _preloop=0;
        repeat(100) if(instance_exists(scrHMLoopSpider111(player.x+96,player.y))) _preloop++;
        scrHMGameplayCheck(_preloop==0,"Elite Spider addition is loop-only");
        GameCont.loops=_original_loop;
        if(GameCont.area==scrHMAreaResolve("city")) {
            var _crystals=0;
            repeat(500) if(instance_exists(scrHMLoopCrystal109(player.x+96,player.y))) _crystals++;
            scrHMGameplayCheck(_crystals==0,"pictured Big Crystal is excluded from loop city population");
        }
    }
    if(mode=="loop111" && ticks==20) {
        var _added=0,_types={};
        with(enemy) if(self[$ "hm_vanilla_loop111"]??false) {
            _added++;_types[$ object_get_name(object_index)]=true;
            scrHMGameplayCheck(hp>0,"stock loop addition is a live enemy");
        }
        // Exercise all stock city additions through the next real world tick;
        // Hardmode's pre-loop replacements must not erase the added pool.
        if(GameCont.area==scrHMAreaResolve("city")) {
            loop_keep111=[];
            var _keep=[DogGuardian,ExploGuardian,Necromancer];
            for(var _i=0;_i<array_length(_keep);++_i) {
                var _e=instance_create(player.x+80+32*_i,player.y,_keep[_i]);
                _e.hm_vanilla_loop111=true;array_push(loop_keep111,[_e,_keep[_i]]);
            }
        }
        var _source=scrHMVanillaLoopArea111(GameCont.area),_pool=scrHMVanillaLoopPool111(_source);
        scrHMGameplayCheck(GameCont.loops>0?(_added>0||array_length(_pool)==0):_added==0,"real generator applies stock loop pools only after looping");
        show_debug_message("HARDMODE LOOP111 "+json_stringify({area:GameCont.area,source:_source,loop:GameCont.loops,added:_added,types:_types}));
    }
    if(mode=="loop111"&&ticks==23&&GameCont.area==scrHMAreaResolve("city")) {
        for(var _i=0;_i<array_length(loop_keep111);++_i) {
            var _r=loop_keep111[_i];
            scrHMGameplayCheck(instance_exists(_r[0])&&_r[0].object_index==_r[1],"stock city loop enemy survives Hardmode's replacement hooks");
        }
    }
    if(mode=="venusdrop111" && ticks==20) {
        scrHMGameplayLane107();
        var _creates=[hm_enemies_mod_gml_Molefish_create,hm_enemies_mod_gml_Molesarge_create,
            hm_enemies_mod_gml_Minigunner_create,hm_enemies_mod_gml_Chick_create];
        var _area=GameCont.area;
        for(var _inside=0;_inside<2;++_inside) {
            GameCont.area=_inside?scrHMAreaResolve("venuz"):_area;
            for(var _i=0;_i<array_length(_creates);++_i) {
                var _old=instance_number(WepPickup),_dead=instance_number(Corpse);
                var _e=script_execute(scrHMScriptRef(_creates[_i]),player.x+96,player.y);
                instance_destroy(_e);
                scrHMGameplayCheck(instance_number(WepPickup)==_old+_inside,"real Venus enemy death respects location-specific weapon drop "+string(_i)+"/"+string(_inside));
                scrHMGameplayCheck(instance_number(Corpse)>=_dead+1,"drop restriction preserves the enemy's corpse and exit marker");
            }
        }
        GameCont.area=_area;
        scrHMGameplayCheck(scrHMVenusDropAllowed111(wep_revolver),"ordinary weapon drops remain allowed outside Venus");
        var _names=["secretweapong1","secretweapong2","secretweapong3","secretweapong4","secretweapong5"];
        for(var _i=0;_i<array_length(_names);++_i) scrHMGameplayCheck(!scrHMVenusDropAllowed111(_names[_i]),"all Venus-specific enemy weapons are blocked outside Venus");
    }
    if(mode=="dog111" && ticks==20) {
        scrHMGameplayLane107();
        var _boss=instance_create(player.x+160,player.y+64,ScrapBoss);
        _boss.morehp=1;_boss.intro=-2;_boss.introanimation=11;
        var _bandit=instance_create(player.x+96,player.y,Bandit);
        _bandit.alarm[0]=-1;_bandit.alarm[1]=-1;
        var _missile=instance_create(player.x+48,player.y,ScrapBossMissile);_missile.creator=_boss;
        _missile.team=team_enemy;_missile.speed=0;
        var _shot=instance_create(_bandit.x-12,_bandit.y,EnemyBullet1);
        _shot.creator=_bandit;_shot.team=team_enemy;_shot.speed=4*timescale;_shot.direction=0;
        dog_start111=_shot.x;
        dog_original111=_shot;dog_type111=_shot.object_index;
        dog_direction111=_shot.direction;dog_speed111=_shot.speed;dog_owner111=_shot.creator;
        dog_missile111=_missile;dog_bandit111=_bandit;
        scrHMGameplayCheck(!scrHMMissileShot111(_bandit,_missile),"missile hook rejects another monster's shot even at a shared position");
        scrHMGameplayCheck(scrHMMissileShot111(_boss,_missile),"missile hook still recognizes the real Big Dog owner");
    }
    if(mode=="dog111" && ticks==23) {
        scrHMGameplayCheck(instance_exists(dog_original111),"enemy shot survives passing through another enemy");
        scrHMGameplayCheck(dog_original111.object_index==dog_type111&&dog_original111.direction==dog_direction111
            &&dog_original111.speed==dog_speed111&&dog_original111.creator==dog_owner111,"real 3-5 world hooks cannot convert another monster's bullet to a bouncer");
        scrHMGameplayCheck(dog_original111.x>=dog_start111+8,"regression shot actually moves into its allied monster instead of remaining stationary");
    }
    if(mode=="throne111" && ticks==20) {
        var _anchor=scrHMThroneAnchor111(),_boss=instance_find(NothingInactive,0);
        scrHMGameplayCheck(instance_number(NothingInactive)==1,"natural throne generation creates one boss");
        scrHMGameplayCheck(_boss.x==_anchor[0]+16&&_boss.y==_anchor[1]-1568-64*min(GameCont.loops*2,4),"throne sits at its immutable authored axis and depth");
        var _axis=_boss.x,_target_y=_boss.y;
        with(_boss) {x+=96;y+=32;xstart=x;ystart=y;}
        repeat(3) scrHMThroneEntrance110();
        with(_boss) event_perform(ev_step,ev_step_normal);
        scrHMGameplayCheck(_boss.x==_axis&&_boss.y==_target_y,"native Step cannot shift the corrected throne sideways");
        with(Carpet) scrHMGameplayCheck(abs(x-_axis)<1,"throne is centered on its authored carpet");
        player.x=_axis+88;player.y=_target_y+60;
        scr_camera_set_position(_axis,_target_y,fa_center,fa_middle);
        var _row=[];
        with(Floor) if(y<=_target_y&&y+32>_target_y) array_push(_row,[x,y,object_get_name(object_index)]);
        var _left=1000000000,_right=-1000000000;
        for(var _i=0;_i<array_length(_row);++_i) {_left=min(_left,_row[_i][0]);_right=max(_right,_row[_i][0]+32);}
        scrHMGameplayCheck(abs((_left+_right)/2-_axis)<1,"throne and authored floor row share the same horizontal center after native safe-spawn");
        show_debug_message("HARDMODE THRONE111 "+json_stringify({anchor:_anchor,boss:[_boss.x,_boss.y],floor:instance_nearest(_boss.x,_boss.y,Floor),row:_row}));
    }
    if(mode=="throne111"&&ticks==50) {
        var _boss=instance_find(NothingInactive,0);
        player.x=_boss.x;player.y=_boss.y+96;player.speed=0;
        BackCont.force_snap_camera_position=true;
    }
    if(mode=="throne111"&&ticks==85) {
        var _boss=instance_find(NothingInactive,0);
        show_debug_message("HARDMODE THRONE111 VIEW "+json_stringify({boss:[_boss.x,_boss.y,_boss.depth,_boss.image_alpha,_boss.visible],
            camera:[view_xview,view_yview,view_width,view_height],player:[player.x,player.y],sprite:[sprite_get_width(_boss.sprite_index),sprite_get_xoffset(_boss.sprite_index)]}));
    }
    if(array_contains(["cave111","throne111"],mode)&&array_contains([35,90,290],ticks))
        surface_save(application_surface,game_directory+mode+"-"+string(ticks)+".png");
}

// Runs after real Player and input events on every physical frame.
function scrHMGameplayFrame111() {
    if(mode!="wheel111" || ticks<30) return;
    if(!(self[$ "wheel_started111"]??false)) {
        wheel_started111=true;wheel_phase111=0;
        scrHMGameplayLane107();UberCont.opt_keyboard=true;UberCont.opt_gamepad=false;
        player.wep=wep_revolver;player.bwep=wep_shotgun;player.can_swap=true;
    }
    switch(wheel_phase111) {
        case 0:
            scrDesktopWheelSwap(0,true,false);
            KeyCont.press_swap[0]=false; // later generic key sampling
            wheel_phase111++;break;
        case 1:
            scrHMGameplayCheck(player.wep==wep_shotgun,"notch survives a subsequent keyboard overwrite until real Player Step");
            scrHMGameplayCheck(!KeyCont.wheel_pending111[0],"successful real swap consumes pending notch");
            wheel_phase111++;break;
        case 2:
            scrHMGameplayCheck(player.wep==wep_shotgun,"next physical frame does not repeat consumed notch");
            player.can_swap=false;scrDesktopWheelSwap(0,false,true);wheel_phase111++;break;
        case 3:
            scrHMGameplayCheck(player.wep==wep_shotgun&&KeyCont.wheel_pending111[0],"transient unavailable-swap frame retains a short pending notch");
            player.can_swap=true;wheel_phase111++;break;
        case 4:
            scrHMGameplayCheck(player.wep==wep_revolver,"notch is used when next Player Step can swap");
            scrDesktopWheelSwap(0,true,false);KeyCont.wheel_until111[0]=1;KeyCont.press_swap[0]=false;
            wheel_phase111++;break;
        case 5:
            scrHMGameplayCheck(player.wep==wep_revolver&&!KeyCont.wheel_pending111[0],"expired notch is discarded");
            UberCont.want_pause=1;scrDesktopWheelSwap(0,true,false);UberCont.want_pause=0;
            scrHMGameplayCheck(!KeyCont.wheel_pending111[0],"pause transition cannot queue a delayed swap");
            global.console_active=true;scrDesktopWheelSwap(0,true,false);global.console_active=false;
            scrHMGameplayCheck(!KeyCont.wheel_pending111[0],"console scroll cannot queue weapon input");
            scrDesktopWheelSwap(0,true,false);KeyCont.press_swap[0]=true;
            with(player) event_perform(ev_step,ev_step_normal);
            with(UberCont) scrHandleInputsGeneral(0);
            scrHMGameplayCheck(!KeyCont.press_swap[0]&&!scrDesktopWheelPending111(0),"late generic sampler cannot reinsert consumed keyboard-plus-wheel action");
            wheel_phase111++;break;
        case 6:
            scrHMGameplayCheck(player.wep==wep_shotgun,"keyboard-plus-wheel changes weapon exactly once across real frames");
            wheel_phase111++;break;
    }
}
