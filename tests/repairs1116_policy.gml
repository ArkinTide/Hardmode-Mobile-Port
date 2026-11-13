// Exercise native portal/death events and the real generation/presentation paths.
function scrHMGameplayPolicy1116() {
    if(string_pos("policy116",mode)!=1) return;
    if(ticks==1) {
        UberCont.opt_bossintro=0;
        with(CustomObject) if(name=="hm_native_controller") {
            hm_gungod_rolled=true;hm_gungod_replaced=false;
        }
    }
    if(mode=="policy116gates" && ticks==20) {
        scrHMGameplayLane107();scrHMGameplayNoReplacement1115();
        var _saved=GameCont.loops,_race=player.race;
        var _types=[Grunt,Inspector,Shielder,EliteGrunt,EliteInspector,EliteShielder];
        for(var _loop=0;_loop<4;++_loop) {
            GameCont.loops=_loop;var _freak=0,_normal=0;
            for(var _seed=0;_seed<64;++_seed) {
                random_set_seed(_seed);
                var _gate=instance_create(player.x+120,player.y,IDPDSpawn);
                _gate.x=player.x+120;_gate.y=player.y;
                with(_gate) event_perform_object(IDPDSpawn,ev_alarm,1);
                with(enemy) {
                    if(object_index==PopoFreak) _freak++;else _normal++;
                    instance_destroy(id,false);
                }
                instance_destroy(_gate,false);
            }
            scrHMGameplayCheck(_loop>=3?(_freak>12 && _normal>12):_freak==0,
                "real native portal event never spawns Freaks before Loop3 and preserves both late-loop halves");
            for(var _i=0;_i<6;++_i) {
                var _actor=instance_create(player.x+100+_i*24,player.y,_types[_i]);
                _actor.hp=0;instance_destroy(_actor);
            }
            scrHMGameplayCheck(instance_number(WantRevivePopoFreak)==(_loop>=3?6:0),
                "all six real police deaths schedule revival only from Loop3");
            with(WantRevivePopoFreak) instance_destroy(id,false);
            if(_loop<3) {
                var _corpse=instance_create(player.x+100,player.y,Corpse);
                _corpse.sprite_index=sprGruntDead;_corpse.alarm[0]=-1;
                var _timer=instance_create(_corpse.x,_corpse.y,WantRevivePopoFreak);
                with(_timer) event_perform_object(WantRevivePopoFreak,ev_alarm,0);
                var _effect=instance_create(_corpse.x,_corpse.y,RevivePopoFreak);
                _effect.hm_corpse107=_corpse;
                with(_effect) event_perform_object(RevivePopoFreak,ev_alarm,0);
                scrHMGameplayCheck(!instance_exists(_timer) && !instance_exists(_effect)
                    && instance_number(PopoFreak)==0 && instance_exists(_corpse),
                    "native timer and native resurrection effect cannot revive a police corpse before Loop3");
            }
            with(Corpse) instance_destroy(id,false);
            with(Rad) instance_destroy(id,false);with(BigRad) instance_destroy(id,false);
            player.race=Race.Melting;
            var _tank=hm_enemies_mod_gml_IDPDTank_create(player.x+100,player.y,0);
            _tank.raddrop+=7;
            with(_tank) {hp=0;instance_destroy();}
            var _rads=instance_number(Rad)+instance_number(BigRad);
            scrHMGameplayCheck(_loop>=3?_rads>0:_rads==0,
                "actual tank death suppresses all pre-Loop3 radiation including absorbed rads and Melting bonus");
            with(Rad) instance_destroy(id,false);with(BigRad) instance_destroy(id,false);
            with(Corpse) instance_destroy(id,false);
        }
        player.race=_race;GameCont.loops=_saved;
    }
    if(mode=="policy116population" && ticks==25) {
        var _snow=0,_extra=0;
        with(CustomEnemy) {
            if(self[$ "hm_snow_bandit1116"]??false) {
                _snow++;
                scrHMGameplayCheck(spr_idle==sprSnowBanditIdle && spr_walk==sprSnowBanditWalk
                    && on_step==scrHMScriptRef(hm_enemies_mod_gml_elitebandit_step),
                    "naturally generated snow bandit uses ordinary armed Bandit AI and snow sprites without sleep");
            }
            if(self[$ "hm_extra"]??false) _extra++;
        }
        if(GameCont.loops<1) scrHMGameplayCheck(_snow==0,"Loop0 desert/jungle keeps the original population");
        else scrHMGameplayCheck(_snow>0 && _snow<=3,"Loop1+ desert/jungle naturally adds bounded snow Bandits");
        if(GameCont.loops<3) scrHMGameplayCheck(_extra==0,"ordinary added enemies do not lower the extra-boss Loop3 threshold");
        if(GameCont.loops<3) {
            var _actor=hm_arkintide_mod_gml_hm_extra_spawn("bandit",player.x+160,player.y);
            scrHMGameplayCheck(!instance_exists(_actor),"the public extra constructor also refuses Loop0-2");
        }
    }
    if(mode=="policy116crystals" && ticks==25) {
        // Keep the real generated corridors and walls, while removing the
        // unrelated dense population that occupies every full crystal mask.
        with(enemy) instance_destroy(id,false);
        with(projectile) instance_destroy(id,false);
        scrHMGameplayNoReplacement1115();
        crystal_actors1116=[];crystal_start1116=[];
        for(var _variant=0;_variant<2;++_variant) {
            var _kind=_variant?"cursedcrystal":"crystal";
            var _tile=scrHMExtraTile1103(_kind);
            scrHMGameplayCheck(instance_exists(_tile),"generated map offers a collision-valid extra crystal spawn");
            if(!instance_exists(_tile)) continue;
            var _actor=hm_arkintide_mod_gml_hm_extra_spawn(_kind,_tile.x+16,_tile.y+16);
            scrHMGameplayCheck(instance_exists(_actor),"generated-map crystal uses the actual production extra factory");
            if(!instance_exists(_actor)) continue;
            array_push(crystal_actors1116,_actor);
            array_push(crystal_start1116,{x:_actor.x,y:_actor.y,angle:_actor.angle,frame:current_frame});
        }
    }
    if(mode=="policy116crystals" && (ticks==120 || ticks==240)) {
        var _first_cycle=ticks==120;
        for(var _index=0;_index<array_length(crystal_actors1116);++_index) {
            var _actor=crystal_actors1116[_index],_start=crystal_start1116[_index];
            scrHMGameplayCheck(instance_exists(_actor),"extra crystal remains alive through actual map collision and repeated native callbacks");
            if(!instance_exists(_actor)) continue;
            with(_actor) {
                var _cursed=hm_extra_cursed1116;
                scrHMGameplayCheck(object_index==CustomEnemy && hm_extra_native==HyperCrystal
                    && hm_extra_kind==(_cursed?"cursedcrystal":"crystal"),
                    "crystal variant survives the native event bridge on every real frame");
                scrHMGameplayCheck(angle>_start.angle+20 && cnumber==3 && crystals==1,
                    "extra crystal performs its pre-loop orbit AI and native child spawning");
                scrHMGameplayCheck(spr_shadow==shd64 && spr_shadow_x==0 && spr_shadow_y==16,
                    "ordinary and cursed crystal keep the native ground-shadow anchor");
                var _art=hm_arkintide_mod_gml_hm_extra_skin(sprHyperCrystalIdle);
                scrHMGameplayCheck(sprite_get_yoffset(_art)==sprite_get_yoffset(sprHyperCrystalIdle),
                    "cursed art and normal art align to the same body/shadow origin");
                scrHMGameplayCheck(hm_hm_bossbar_mod_gml_hm_extra_boss_name()==(_cursed?"CURSED HYPER CRYSTAL":"HYPER CRYSTAL"),
                    "the overhead bar identifies each crystal variant outside the cursed cave");
                var _children=0,_right=true;
                for(var _child_index=0;_child_index<cnumber;++_child_index) {
                    var _child=crystal[_child_index];
                    if(!instance_exists(_child)) continue;
                    _children++;
                    if(_cursed?!array_contains([InvLaserCrystal,LightningCrystal],_child.object_index):_child.object_index!=LaserCrystal) _right=false;
                }
                scrHMGameplayCheck(_children==3 && _right,"actual native alarm creates the correct three children on each generation");
                if(_cursed) scrHMGameplayCheck((self[$ "hm_extra_last_blink1115"]??-1)>_start.frame,
                    "cursed extra teleports to a fitting location on the naturally generated map");
                if(_first_cycle) {
                    // Run a second native summon cycle and cross half health.
                    for(var _child_index=0;_child_index<cnumber;++_child_index)
                        if(instance_exists(crystal[_child_index])) instance_destroy(crystal[_child_index],false);
                    hp=max_hp*.4;
                }
            }
        }
    }
    if(mode=="policy116deaths" && ticks==20) {
        scrHMGameplayLane107();scrHMGameplayNoReplacement1115();HMWorld.hm_boss_room115="";
        death_actors1116=[];death_bodies1116=[];
        var _kinds=["bandit","cursedcrystal","bird","mom","hunter","dog"];
        for(var _i=0;_i<array_length(_kinds);++_i) {
            var _actor=hm_arkintide_mod_gml_hm_extra_spawn(_kinds[_i],14112+(_i mod 3)*144,14064+(_i div 3)*192);
            scrHMGameplayCheck(instance_exists(_actor),"extra death fixture uses its actual family constructor");
            array_push(death_actors1116,_actor);
            if(array_contains(["bandit","cursedcrystal","bird"],_kinds[_i]))
                array_push(death_bodies1116,{owner:_actor,kind:_kinds[_i],sprite:_actor.spr_dead,body:noone});
        }
        death_music1116=MusCont.song;
    }
    if(mode=="policy116deaths" && ticks==40)
        for(var _i=0;_i<array_length(death_actors1116);++_i)
            if(instance_exists(death_actors1116[_i])) death_actors1116[_i].hp=0;
    if(mode=="policy116deaths" && ticks==43) {
        for(var _i=0;_i<array_length(death_bodies1116);++_i) {
            var _entry=death_bodies1116[_i],_body=noone;
            with(Corpse) if((self[$ "hm_extra_death_owner1116"]??noone)==_entry.owner) {_body=id;break;}
            scrHMGameplayCheck(instance_exists(_body),"each exact killed extra boss leaves its own visible animated corpse");
            if(!instance_exists(_body)) continue;
            _entry.body=_body;
            show_debug_message("HARDMODE DEATH116 "+json_stringify({kind:_entry.kind,owner:_entry.owner,body:_body,
                frame:_body.image_index,frames:_body.image_number,speed:_body.image_speed,music:_body[$ "music"]??-1}));
            scrHMGameplayCheck(_body.sprite_index==_entry.sprite && _body.image_number>1 && _body.image_index>0
                && _body.image_index<_body.image_number-1 && _body.image_speed>0,
                "the exact extra native or imported corpse starts and advances through its complete death sprite");
        }
        scrHMGameplayCheck(instance_exists(FrogQueenDeath) && instance_exists(BigDogExplo) && instance_exists(LilHunterDie),
            "mother, Big Dog and Hunter preserve their distinct native death transition objects");
        show_debug_message("HARDMODE DEATH116 PRESENTATION "+json_stringify({active:HMWorld.hm_portrait_active,song:MusCont.song,old:death_music1116}));
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active) && MusCont.song==death_music1116,
            "extra death visuals do not start a boss camera or change area music");
    }
    if(mode=="policy116deaths" && ticks>=43 && ticks<=150 && (ticks==43 || ticks mod 30==0)) {
        var _states=[];
        for(var _i=0;_i<array_length(death_bodies1116);++_i) {
            var _entry=death_bodies1116[_i],_body=_entry.body;
            if(!instance_exists(_body)) {array_push(_states,{kind:_entry.kind,exists:false});continue;}
            array_push(_states,{kind:_entry.kind,body:_body,exists:true,index:_body.image_index,
                frames:_body.image_number,speed:_body.image_speed,sprite:sprite_get_name(_body.sprite_index),
                expected:sprite_get_name(_entry.sprite),resource_speed:sprite_get_speed(_body.sprite_index),
                resource_type:sprite_get_speed_type(_body.sprite_index),animend:_body[$ "hm_extra_animend_count1116"]??0,
                started:_body[$ "hm_extra_death_started1116"]??-1,ended:_body[$ "hm_extra_animend_serial1116"]??-1});
        }
        show_debug_message("HARDMODE DEATH116 CLOCK "+json_stringify({tick:ticks,physical:age,clock:current_frame,
            serial:HMWorld.logic_serial,scale:timescale,fps_type:spritespeed_framespersecond,
            frame_type:spritespeed_framespergameframe,bodies:_states}));
    }
    if(mode=="policy116deaths" && ticks==150) {
        for(var _i=0;_i<array_length(death_bodies1116);++_i) {
            var _entry=death_bodies1116[_i],_body=_entry.body;
            scrHMGameplayCheck(instance_exists(_body),"the complete extra death animation retains its exact final corpse");
            if(instance_exists(_body)) scrHMGameplayCheck(_body.image_speed==0
                && _body.image_index==_body.image_number-1 && _body.sprite_index==scrHMCorpseSprite116(_entry.sprite),
                "the actual animated extra corpse reaches and settles on its own final frame");
            if(instance_exists(_body)) scrHMGameplayCheck(_body.hm_extra_animend_count1116==1
                && abs((_body.hm_extra_animend_serial1116-_body.hm_extra_death_started1116)-_body.image_number/.4)<=2,
                "real native AnimationEnd completes once at twelve death-art frames per second at either frame rate");
        }
        var _mother=0,_dog=0;
        with(Corpse) {
            if((self[$ "hm_extra_kind"]??"")=="mom") _mother++;
            if((self[$ "hm_extra_kind"]??"")=="dog") _dog++;
        }
        scrHMGameplayCheck(!instance_exists(FrogQueenDeath) && _mother>0,
            "mother's native dying animation reaches its final corpse transition");
        scrHMGameplayCheck(!instance_exists(BigDogExplo) && _dog==6,
            "Big Dog's explosion ends in its six native animated debris pieces");
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active) && MusCont.song==death_music1116,
            "late extra death transitions retain ordinary combat presentation and music");
    }
    if(mode=="policy116deathsrest" && ticks==20) {
        scrHMGameplayLane107();scrHMGameplayNoReplacement1115();HMWorld.hm_boss_room115="";
        death_rest1116=[];
        var _kinds=["junglebandit","bubble","crystal","tech","gator","rogue","rat"];
        for(var _i=0;_i<array_length(_kinds);++_i) {
            var _actor=hm_arkintide_mod_gml_hm_extra_spawn(_kinds[_i],14112+(_i mod 3)*144,14048+(_i div 3)*120);
            show_debug_message("HARDMODE DEATH116 CONSTRUCT "+json_stringify({kind:_kinds[_i],area:GameCont.area,actor:_actor}));
            scrHMGameplayCheck(instance_exists(_actor),"remaining extra family uses its actual production constructor: "+_kinds[_i]);
            if(instance_exists(_actor)) array_push(death_rest1116,{owner:_actor,kind:_kinds[_i],sprite:_actor.spr_dead});
        }
        death_music1116=MusCont.song;
    }
    if(mode=="policy116turtledeaths" && ticks==20) {
        scrHMGameplayLane107();scrHMGameplayNoReplacement1115();HMWorld.hm_boss_room115="";
        death_rest1116=[];var _seen={};
        for(var _seed=0;_seed<128 && array_length(death_rest1116)<4;++_seed) {
            random_set_seed(_seed);
            var _index=array_length(death_rest1116);
            var _actor=hm_arkintide_mod_gml_hm_extra_spawn("turtle",14112+(_index mod 2)*192,14064+(_index div 2)*192);
            scrHMGameplayCheck(instance_exists(_actor),"turtle death fixture uses the actual random production variant factory");
            if(!instance_exists(_actor)) continue;
            if(_seen[$ _actor.name]??false) {instance_destroy(_actor,false);continue;}
            _seen[$ _actor.name]=true;
            array_push(death_rest1116,{owner:_actor,kind:_actor.name,sprite:_actor.spr_dead});
        }
        scrHMGameplayCheck(array_length(death_rest1116)==4,"all four independently armed turtle variants are covered");
        death_music1116=MusCont.song;
    }
    if(array_contains(["policy116deathsrest","policy116turtledeaths"],mode) && ticks==40) {
        with(AcidStreak) instance_destroy(id,false);
        for(var _i=0;_i<array_length(death_rest1116);++_i) {
            var _entry=death_rest1116[_i],_actor=_entry.owner;
            scrHMGameplayCheck(instance_exists(_actor),"extra family survives until its real lethal damage event");
            if(!instance_exists(_actor)) continue;
            _entry.x=_actor.x;_entry.y=_actor.y;_actor.hp=0;
        }
    }
    if(array_contains(["policy116deathsrest","policy116turtledeaths"],mode) && ticks==43) {
        for(var _i=0;_i<array_length(death_rest1116);++_i) {
            var _entry=death_rest1116[_i],_body=noone;
            with(Corpse) if((self[$ "hm_extra_death_owner1116"]??noone)==_entry.owner) {_body=id;break;}
            scrHMGameplayCheck(instance_exists(_body),"each supported extra family leaves its actual visible death corpse");
            if(instance_exists(_body)) scrHMGameplayCheck(_body.sprite_index==_entry.sprite
                && _body.image_speed>0 && (_body.image_number<=1 || _body.image_index>0),
                "family death art starts at its own first frame and advances through the native sprite");
        }
        if(mode=="policy116deathsrest") {
            var _blast=0;with(PopoExplosion) if((self[$ "hm_extra_kind"]??"")=="rogue") _blast++;
            scrHMGameplayCheck(_blast==1,"extra Messenger retains exactly one visible native IDPD death explosion");
            scrHMGameplayCheck(instance_number(AcidStreak)==2,"extra Big Bubbler retains both native acid death streaks");
            var _elevator=false;with(CustomObject) if(name=="VenuzElevator") _elevator=true;
            scrHMGameplayCheck(!_elevator,"extra Rat death animation does not create the Venus progression elevator");
        }
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active) && MusCont.song==death_music1116,
            "every additional extra family dies without a boss camera or boss victory music");
    }
    if(mode=="policy116stage" && ticks==1) {
        stage_seen1116={};stage_count1116=0;stage_jungle1116=0;
        scrHMModSet("mod","options","intropan","0");
        scrHMModSet("mod","options","bossoutros","0");
    }
    if(mode=="policy116stage" && ticks==20) {
        // WantBoss waits for combat progress. Exercise its real wall-arrival
        // alarm from a valid point on this generated level, without replacing
        // the controller or constructing the boss directly.
        var _found=false;
        with(Floor) {
            var _px=x+16,_py=y+16;
            with(Wall) {
                var _d=point_distance(x,y,_px,_py);
                if(_d<=100 || _d>=124 || collision_line(x,y,_px,_py,Wall,true,true)!=noone) continue;
                if(distance_to_object(Wall)>2) continue;
                if(!(place_meeting(x+16,y,Floor)||place_meeting(x-16,y,Floor)
                    ||place_meeting(x,y+16,Floor)||place_meeting(x,y-16,Floor))) continue;
                _found=true;break;
            }
            if(_found) {other.player.x=_px;other.player.y=_py;break;}
        }
        scrHMGameplayCheck(_found && instance_exists(WantBoss),"generated desert retains its native WantBoss and valid wall arrival points");
        // The native Step keeps postponing its arrival while combat has not
        // passed its real threshold. Create actual combat progress first.
        var _limit=floor(WantBoss.enemies*.85),_remove=max(0,instance_number(enemy)-_limit);
        with(enemy) if(_remove>0) {hp=0;_remove--;}
    }
    if(mode=="policy116stage" && ticks==25) with(WantBoss) alarm[0]=1;
    if(mode=="policy116stage" && ticks mod 50==0) {
        var _arrivals=[];with(WantBoss) array_push(_arrivals,{x:x,y:y,alarm:alarm[0],number:number,losthope:losthope,enemies:enemies});
        show_debug_message("HARDMODE STAGE116 WAIT "+json_stringify({tick:ticks,arrivals:_arrivals,enemies:instance_number(enemy)}));
    }
    if(mode=="policy116stage") {
        with(BanditBoss) if(!(self[$ "hm_extra"]??false)) {
            if(!(other.stage_seen1116[$ string(id)]??false)) {
                other.stage_seen1116[$ string(id)]=true;
                other.stage_count1116++;
                scrHMGameplayCheck(self[$ "hm_stage_bandit_rolled"]??false,
                    "naturally arriving WantBoss Bandit is classified during its real native Create");
                if(hm_stage_jungle) {
                    other.stage_jungle1116++;
                    var _mapped=hm_arkintide_mod_gml_hm_extra_skin(sprBanditBossIdle);
                    scrHMGameplayCheck(_mapped==global.hm_module_vars[$ "mod:arkintide"].hm_extra_jungle_idle
                        && _mapped!=sprBanditBossIdle,"selected stage Jungle Bandit uses its actual green body sprite");
                }
            }
        }
        if(ticks==350) {
            scrHMGameplayCheck(stage_count1116>0,"the original WantBoss controller really generated stage Bandits");
            show_debug_message("HARDMODE STAGE116 "+json_stringify({bosses:stage_count1116,jungle:stage_jungle1116}));
        }
    }
    if(mode=="policy116portrait" && ticks==20) {
        scrHMGameplayLane107();scrHMGameplayNoReplacement1115();
        HMWorld.hm_boss_room115="";GameCont.hm_yv_seen=false;
        portrait_capture_pending116=false;portrait_captured116=false;
        portrait_draw_observations116=0;
        UberCont.opt_bossintro=1;scrHMModSet("mod","options","intropan","1");
        var _original=instance_create(player.x+180,player.y-64,BanditBoss);
        _original.newintro=-1;
        var _seed=0;
        repeat(10000) {random_set_seed(_seed);var _roll=random(1);if(_roll>=.05 && _roll<.10) break;_seed++;}
        var _roller=instance_create(0,0,CustomObject);
        random_set_seed(_seed);with(_roller) scrHMReplacementTick1102();
        portrait116=HMWorld.hm_portrait_active;
        scrHMGameplayCheck(_roller.hm_gungod_replaced && instance_exists(portrait116)
            && portrait116.hm_native_art1116==10,"real Venus replacement roller requests the correct native Y.V portrait frame");
        scrHMGameplayCheck(portrait116.hm_native_start1116==portrait116.hm_camera_start1116
            && !UberCont.paused && global.hm_camera_targets[player.index]==portrait116,
            "native portrait and camera start on the same logical tick over a live moving world");
        portrait_distance116=point_distance(view_xview_center,view_yview_center,portrait116.x,portrait116.y);
        portrait_target116=[portrait116.x,portrait116.y];
        instance_destroy(_roller,false);
    }
    if(mode=="policy116portrait" && ticks==28) {
        scrHMGameplayCheck(portrait116.hm_native_drawn1116,"real GUI renderer displays native portrait while camera is active");
        scrHMGameplayCheck(point_distance(view_xview_center,view_yview_center,portrait_target116[0],portrait_target116[1])<portrait_distance116*.8,
            "actual BackCont camera moves toward the replacement during its visible portrait");
        portrait_capture_pending116=true;
    }
    if(mode=="policy116portrait" && ticks==100) {
        scrHMGameplayCheck(portrait_captured116 && !portrait_capture_pending116,
            "the live portrait receives one complete screen capture from the actual Draw event");
        scrHMGameplayCheck(!instance_exists(portrait116) && !player.hm_portrait_frozen && player.can_walk,
            "one shared presentation restores combat and player controls after both effects");
    }
    if(mode=="policy116native" && ticks==20) {
        scrHMGameplayLane107();scrHMGameplayNoReplacement1115();HMWorld.hm_boss_room115="";
        // Native maincode removes normal Bandit actors before the real 1-3 stage.
        GameCont.subarea=3;
        UberCont.opt_bossintro=1;scrHMModSet("mod","options","intropan","1");
        native116=instance_create(player.x+180,player.y-60,BanditBoss);
        with(native116) {intro=0;event_perform_object(BanditBoss,ev_alarm,5);}
        var _intro=HMWorld.hm_portrait_active;
        scrHMGameplayCheck(instance_exists(_intro) && _intro.hm_native_art1116==0
            && _intro.hm_native_start1116==_intro.hm_camera_start1116 && !UberCont.paused,
            "real native Bandit alarm joins the same simultaneous portrait/camera path");
    }
    if(mode=="policy116lateart" && ticks==20) {
        scrHMGameplayLane107();scrHMGameplayNoReplacement1115();HMWorld.hm_boss_room115="";
        // Native maincode removes normal Bandit actors before the real 1-3 stage.
        GameCont.subarea=3;
        UberCont.opt_bossintro=1;scrHMModSet("mod","options","intropan","1");
        late_actor1116=instance_create(player.x+180,player.y-60,BanditBoss);
        with(late_actor1116) {
            intro=1;alarm[1]=-1;speed=0;
            hm_bosses_bossintros_mod_gml_boss_trigger("",mskNone,mskNone,mskNone,id,0);
        }
        late_intro1116=HMWorld.hm_portrait_active;
        scrHMGameplayCheck(instance_exists(late_intro1116),"real custom entry camera starts before the delayed native art request");
        late_camera_start1116=late_intro1116.hm_camera_start1116;
    }
    if(mode=="policy116lateart" && ticks==65) {
        scrHMGameplayCheck(instance_exists(late_intro1116),"the original camera is still live when the real native alarm requests art");
        with(late_actor1116) {intro=0;event_perform_object(BanditBoss,ev_alarm,5);}
        late_art_start1116=late_intro1116.hm_native_start1116;
        scrHMGameplayCheck(HMWorld.hm_portrait_active==late_intro1116 && late_intro1116.hm_native_art1116==0
            && late_intro1116.hm_camera_start1116==late_camera_start1116,
            "late native art joins the matching live camera without changing its actual start time");
    }
    if(mode=="policy116lateart" && ticks==70) {
        with(late_actor1116) {intro=0;event_perform_object(BanditBoss,ev_alarm,5);}
        scrHMGameplayCheck(HMWorld.hm_portrait_active==late_intro1116
            && late_intro1116.hm_native_start1116==late_art_start1116,
            "a repeated real native alarm never restarts the joined portrait or camera");
    }
    if(mode=="policy116lateart" && ticks==90)
        scrHMGameplayCheck(instance_exists(late_intro1116) && late_intro1116.hm_native_age1116>20
            && late_intro1116.hm_native_age1116<40 && late_intro1116.hm_native_drawn1116,
            "the shared camera remains alive until the late native portrait completes its full animation");
    if(mode=="policy116lateart" && ticks==115)
        scrHMGameplayCheck(!instance_exists(late_intro1116) && !late_actor1116.hm_portrait_frozen,
            "completed late portrait restores the existing frozen encounter once");
    if(mode=="policy116camera" && ticks==20) {
        scrHMGameplayLane107();scrHMGameplayNoReplacement1115();HMWorld.hm_boss_room115="";
        // Native maincode removes normal Bandit actors before the real 1-3 stage.
        GameCont.subarea=3;
        UberCont.opt_bossintro=0;scrHMModSet("mod","options","intropan","1");
        scrHMModSet("mod","options","bossoutros","1");
        camera116=instance_create(player.x+64,player.y,BanditBoss);camera116.newintro=-1;
        camera116.intro=1;camera116.alarm[1]=-1;camera116.speed=0;
        scrHMBossGroupRegister115(camera116);
        with(camera116) hm_bosses_bossintros_mod_gml_boss_trigger("",mskNone,mskNone,mskNone,id,0);
    }
    if(mode=="policy116camera" && ticks>20 && ticks<100 && ticks mod 10==0) {
        var _actors=[];with(BanditBoss) array_push(_actors,{id:id,x:x,y:y,hp:hp,alarm:alarm[1],intro:intro});
        show_debug_message("HARDMODE CAMERA116 WAIT "+json_stringify({tick:ticks,expected:camera116,actors:_actors,active:HMWorld.hm_portrait_active,area:GameCont.area,sub:GameCont.subarea}));
    }
    if(mode=="policy116camera" && ticks==100) {
        scrHMGameplayCheck(instance_exists(camera116),"camera fixture retains its native Bandit actor until the lethal event");
        camera116.x=player.x+320;camera116.y=player.y-80;
        camera_death116=[camera116.x,camera116.y];
        with(camera116) {hp=0;instance_destroy();}
        scrHMBossGroupTick115();
        camera_outro116=HMWorld.hm_portrait_active;
        scrHMGameplayCheck(instance_exists(camera_outro116) && camera_outro116.hm_boss_exit115
            && camera_outro116.x==camera_death116[0] && camera_outro116.y==camera_death116[1],
            "last-boss native Destroy focuses the exact final position instead of its old spawn floor");
        camera_distance116=point_distance(view_xview_center,view_yview_center,camera_outro116.x,camera_outro116.y);
    }
    if(mode=="policy116camera" && ticks==110) {
        scrHMGameplayCheck(!instance_exists(camera116) && instance_exists(camera_outro116)
            && point_distance(view_xview_center,view_yview_center,camera_death116[0],camera_death116[1])<camera_distance116*.8,
            "real camera continues to frame the destroyed boss location after its ID is gone");
    }
    if(mode=="policy116guardian" && ticks==20) {
        scrHMGameplayLane107();HMWorld.hm_boss_room115="";
        scrHMModSet("mod","options","intropan","1");scrHMModSet("mod","options","bossoutros","1");
        var _actor=instance_create(player.x+200,player.y,CustomEnemy);_actor.name="guardianboss";
        _actor.hp=100;_actor.max_hp=100;
        with(_actor) hm_bosses_bossintros_mod_gml_boss_trigger("GREAT GUARDIAN",mskNone,mskNone,mskNone,id,0);
        var _intro=HMWorld.hm_portrait_active;
        if(GameCont.loops==0) scrHMGameplayCheck(instance_exists(_intro) && _intro.x==player.x && _intro.y==player.y,
            "Guardian keeps its portrait at the player camera without an entrance pan");
        else scrHMGameplayCheck(!instance_exists(_intro),"loop Guardian has no entrance camera");
        if(instance_exists(_intro)) {with(_intro) scrHMBossRestore104();instance_destroy(_intro,false);}
        with(_actor) {hp=0;hm_bosses_bossintros_mod_gml_boss_death();instance_destroy(id,false);}
        scrHMBossGroupTick115();
        scrHMGameplayCheck(!instance_exists(HMWorld.hm_portrait_active),"Guardian death never starts a departure camera");
    }
}

function scrHMGameplayPolicyDraw1116() {
    if(mode!="policy116portrait" || ticks<20 || !instance_exists(portrait116)) return;
    var _intro=portrait116;
    if(HMWorld.hm_portrait_active!=_intro || _intro.hm_native_art1116!=10
        || _intro.hm_native_age1116>=40 || !_intro.hm_native_drawn1116) return;
    portrait_draw_observations116++;
    if(!portrait_capture_pending116 || portrait_captured116) return;
    // The application surface contains only the world. The portrait and HUD
    // are drawn through GUI events, so retain the complete rendered screen.
    screen_save(game_directory+"policy116portrait.png");
    portrait_capture_pending116=false;portrait_captured116=true;
    show_debug_message("HARDMODE PORTRAIT116 CAPTURE "+json_stringify({tick:ticks,
        age:_intro.hm_native_age1116,art:_intro.hm_native_art1116,
        draw_observations:portrait_draw_observations116,native_drawn:_intro.hm_native_drawn1116}));
}
