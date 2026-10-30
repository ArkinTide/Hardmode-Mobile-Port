function scrHMGameplayRepairs110() {
    if(mode=="maps110" && ticks==30) {
        var _budget=HMWorld.hm_map_budget110;
        scrHMGameplayCheck(_budget.area==GameCont.area&&_budget.loops==GameCont.loops,"actual generation uses the current area's loop budget");
        scrHMGameplayCheck(_budget.eligible,"procedural map opts into loop expansion");
        scrHMGameplayCheck(_budget.goal==ceil(_budget.base*(1+.2*min(GameCont.loops,5))),"first FloorMaker receives the expanded floor budget");
        scrHMGameplayCheck(instance_number(Floor)>=_budget.goal,"actual generator completes the expanded playable floor budget");
        with(player) scrHMGameplayCheck(distance_to_object(Floor)<32,"expanded map retains a playable player spawn");
        var _l=1000000000,_r=-1000000000,_t=1000000000,_b=-1000000000;
        with(Floor) {_l=min(_l,x);_r=max(_r,x);_t=min(_t,y);_b=max(_b,y);}
        show_debug_message("HARDMODE MAP110 "+json_stringify({budget:_budget,floors:instance_number(Floor),bounds:[_l,_t,_r,_b]}));
        scrHMGameplayCheck(!scrHMLoopMapEligible110(scrHMAreaResolve("throne"),1)
            && !scrHMLoopMapEligible110(scrHMAreaResolve("venuz"),1)
            && !scrHMLoopMapEligible110(area_vault,1),"scripted throne, Venus and crown-vault layouts retain authored dimensions");
    }
    if(mode=="vault110" && ticks>=goal_ticks)
        scrHMGameplayCheck((self[$ "vault_phase110"]??0)==3,"vault round trip reaches its final phase before the test ends");
    if(mode=="walls110" && ticks==30) {
        var _pairs=[[sprWall0Top,#6a7aaf],[sprWall1Top,#af8f6a],[sprWall2Top,#4c5946],
            [sprWall3Top,#8a969e],[sprWall4Top,#8152bc],[sprWall5Top,#b4bdc5],
            [sprWall6Top,#091c20],[sprWall7Top,#611d24],[sprWall100Top,#433523],
            [sprWall101Top,#51d1c8],[sprWall102Top,#a04b63],[sprWall103Top,#eef0f2],
            [sprWall104Top,#ff9c23],[sprWall105Top,#2a900c],[sprWall106Top,#f5fafb],
            [sprWall107Top,#eef0f2]];
        for(var _i=0;_i<array_length(_pairs);++_i)
            scrHMGameplayCheck(scrHMWallColour110(_pairs[_i][0])==_pairs[_i][1],"plain wall matches NTTE shared-area colour "+string(_i));
        var _plain=noone;
        with(Wall) if(scrHMPlainWall106()) {_plain=id;break;}
        scrHMGameplayCheck(instance_exists(_plain),"actual generated outer collision blocks exist");
        var _box=[_plain.bbox_left,_plain.bbox_top,_plain.bbox_right,_plain.bbox_bottom];
        var _mask=_plain.mask_index,_count=instance_number(Wall);
        with(_plain) repeat(32) scrHMWallColour110(topspr);
        scrHMGameplayCheck(instance_number(Wall)==_count&&_plain.mask_index==_mask,"colour lookups preserve wall identities and masks");
        scrHMGameplayCheck(_plain.bbox_left==_box[0]&&_plain.bbox_top==_box[1]&&_plain.bbox_right==_box[2]&&_plain.bbox_bottom==_box[3],"colour changes preserve exterior collision bounds");
        scrHMGameplayCheck(collision_point((_box[0]+_box[2])/2,(_box[1]+_box[3])/2,Wall,false,false)!=noone,"deep outer wall still blocks movement");
    }
    if(mode=="throne110" && ticks==30) {
        scrHMGameplayCheck(instance_number(NothingInactive)==1,"natural throne generation creates one initial boss");
        var _idle=instance_find(NothingInactive,0);
        var _before=[_idle.x,_idle.y];
        // Reproduce a stale seed and an already-created throne whose native
        // reset coordinates point away from the arena.
        with(Floor) nokill=1;
        with(_idle) {x=500; y=500;xstart=x;ystart=y;visible=false;image_alpha=0;}
        scrHMThroneSeed110();
        var _seeds=0;with(Floor) if(self[$ "nokill"]??false) _seeds++;
        scrHMGameplayCheck(_seeds==1,"seed normalization retains only the actual spawn anchor");
        repeat(3) scrHMThroneEntrance110();
        scrHMGameplayCheck(instance_number(NothingInactive)==1,"initial placement deduplicates without adding bosses");
        with(_idle) event_perform(ev_step,ev_step_normal);
        scrHMGameplayCheck(point_distance(_idle.x,_idle.y,_before[0],_before[1])<1,"boss remains anchored after its real native Step reset");
        scrHMGameplayCheck(_idle.visible&&_idle.image_alpha==1&&_idle.mask_index==mskNothingInactive,"final boss art and collision are restored before combat");
        with(_idle) scrHMGameplayCheck(distance_to_object(Floor)<48,"boss is located on actual arena floor");
        instance_destroy(_idle,false);
        scrHMThroneEntrance110();
        scrHMGameplayCheck(instance_number(NothingInactive)==1,"post-cleanup finalization repairs a missing initial boss");
        var _transition=instance_create(NothingInactive.x,NothingInactive.y,BecomeNothing);
        instance_destroy(NothingInactive,false);scrHMThroneEntrance110();
        scrHMGameplayCheck(!instance_exists(NothingInactive),"active phase transition never resurrects an initial boss");
        instance_destroy(_transition,false);scrHMThroneEntrance110();
    }
    if(mode=="vault110" && room_ticks==30) {
        var _phase=self[$ "vault_phase110"]??0;
        if(_phase==0) {
            scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("palace")&&GameCont.subarea==4,"test starts at the real 7-4 crown altar");
            scrHMGameplayCheck(instance_number(ProtoStatue)==1,"7-4 supplies exactly one altar");
            with(ProtoStatue) {rad=25;instance_destroy();}
            var _entrance=noone;with(Portal) if(type==3) {_entrance=id;break;}
            scrHMGameplayCheck(instance_exists(_entrance)&&_entrance.hm_destination107==area_vault,"charged altar creates an explicit crown-vault portal");
            scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("palace"),"opening altar does not mutate current combat area");
            start_loops110=GameCont.loops;vault_phase110=1;
            GameCont.can_advance_stage=true;GameCont.skillpoints=0;GameCont.ultrapoints=0;
            with(_entrance) event_perform(ev_alarm,1);
        } else if(_phase==1) {
            scrHMGameplayCheck(GameCont.area==area_vault&&GameCont.subarea==1,"real portal and room lifecycle enter the vault, not the throne");
            scrHMGameplayCheck(GameCont.crownvisits==1&&GameCont.loops==start_loops110,"vault visit counts once without advancing loop");
            scrHMGameplayCheck(instance_exists(CrownPickup)&&!instance_exists(NothingInactive),"vault contains a crown instead of a throne");
            scrHMGameplayCheck(GameCont.lastarea==scrHMAreaResolve("palace")&&GameCont.lastsubarea==4,"vault retains the 7-4 return waypoint");
            with(CrownPickup) instance_destroy();
            var _exit=instance_create(player.x+64,player.y,Portal);_exit.type=3;
            vault_phase110=2;GameCont.can_advance_stage=true;
            with(_exit) event_perform(ev_alarm,1);
        } else if(_phase==2) {
            scrHMGameplayCheck(GameCont.area==scrHMAreaResolve("throne"),"leaving 7-4 vault resumes the next mainline throne arena");
            scrHMGameplayCheck(instance_number(NothingInactive)==1,"vault return generates exactly one throne boss");
            scrHMGameplayCheck(GameCont.crownvisits==1&&GameCont.loops==start_loops110,"return does not consume an extra vault visit or loop");
            vault_phase110=3;
        }
    }
}
