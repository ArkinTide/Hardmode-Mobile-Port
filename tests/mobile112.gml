// Actual Custom* event scheduling and draw transforms, with unchanged 30Hz AI.
function scrHMMotionManual112() {x+=2;motion_steps112++;}
function scrHMMotionBegin112() {motion_begins112++;}
function scrHMMotionEnd112() {motion_ends112++;}
function scrHMMotionDraw112() {
    var _matrix=matrix_get(matrix_world),_shown=x+_matrix[12];
    if(motion_draws112>0) {
        var _delta=abs(_shown-motion_shown112);
        if(_delta>.01) motion_moves112++;
        motion_max112=max(motion_max112,_delta);
    }
    motion_shown112=_shown;motion_draws112++;
    draw_sprite(sprite_index,0,x,y);
}
function scrHMGameplayMobileFrame112() {
    if(mode!="motion112" || !variable_instance_exists(id,"motion_actors112")) return;
    if(ticks>=90) return;
    for(var _i=0;_i<array_length(motion_actors112);++_i) {
        var _actor=motion_actors112[_i];
        with(_actor) {
            // Calling the same draw wrapper cannot change simulation state
            // or leak its matrix into the next unrelated object's drawing.
            var _x=x,_y=y,_xp=xprevious,_yp=yprevious;
            var _matrix=matrix_get(matrix_world),_offset=scrHMVisualOffset111();
            scrHMGameplayCheck(x==_x&&y==_y&&xprevious==_xp&&yprevious==_yp,
                "presentation query leaves movement and collision coordinates unchanged");
            scrHMGameplayCheck(abs(_offset[0])<=1&&_offset[1]==0,
                "manual presentation shift is bounded to half of a normal logic step");
        }
    }
}
function scrHMGameplayMobile112() {
    if(ticks==20) {
        scrHMGameplayLane107();motion_actors112=[];
        var _types=[CustomObject,CustomEnemy,CustomProjectile];
        for(var _i=0;_i<array_length(_types);++_i) {
            var _actor=instance_create(20000,20000+64*_i,_types[_i]);
            with(_actor) {
                name="motionfixture112";hp=100000;can_die=false;
                sprite_index=sprBanditIdle;spr_idle=sprBanditIdle;mask_index=mskNone;
                image_alpha=1;image_speed=0;speed=0;right=1;
                motion_start112=x;motion_steps112=0;motion_begins112=0;motion_ends112=0;
                motion_draws112=0;motion_moves112=0;motion_shown112=x;motion_max112=0;
                on_step=scrHMMotionManual112;on_begin_step=scrHMMotionBegin112;
                on_end_step=scrHMMotionEnd112;on_draw=scrHMMotionDraw112;
            }
            array_push(motion_actors112,_actor);
        }
    }
    if(ticks==30) {
        var _actor=motion_actors112[0];
        with(_actor) {
            var _x=x,_xp=xprevious,_h=hspeed,_v=vspeed,_matrix=matrix_get(matrix_world);
            xprevious=x-2;hspeed=0;vspeed=0;
            var _offset=scrHMVisualOffset111();
            scrHMGameplayCheck(abs(_offset[0]+2*(1-timescale))<.001,
                "normal manual step is evenly presented at either selected frame rate");
            var _binding=instance_create(x,y,HMBinding);
            _binding.hm_draw=true;_binding.creator=id;_binding.hm_menu_overlay=true;
            _binding.hm_refresh_tick=HMWorld.logic_serial;
            _binding.hm_code=scrHMScriptRef(hm_enemies_mod_gml_bigcrystaltopdraw);
            with(_binding) {
                var _bound=scrHMBindingOffset112();
                scrHMGameplayCheck(_bound[0]==_offset[0]&&_bound[1]==_offset[1],
                    "separate crystal-top renderer follows its custom actor's displacement");
                event_perform(ev_draw,0);
                scrHMGameplayCheck(matrix_get(matrix_world)[12]==_matrix[12],
                    "actual bound draw event restores the world matrix");
                hm_code=scrHMScriptRef(hm_maincode_mod_gml_sewerboi);
                var _wet=scrHMBindingOffset112();
                scrHMGameplayCheck(_wet[0]==_offset[0],"cropped swimming renderer shares its actor transform");
                hm_code=scrHMScriptRef(hm_maincode_mod_gml_PortalShrink);
                var _portal=scrHMBindingOffset112();
                scrHMGameplayCheck(_portal[0]==0&&_portal[1]==0,"portal overlays keep their own presentation");
                instance_destroy(id,false);
            }
            // Native hspeed is already integrated each physical frame.
            hspeed=2;
            scrHMGameplayCheck(scrHMVisualOffset111()[0]==0,"native velocity does not receive a second interpolation");
            hspeed=0;xprevious=x-40;
            scrHMGameplayCheck(scrHMVisualOffset111()[0]==0,"teleports are not interpolated through walls");
            xprevious=x-2;var _paused=UberCont.paused;UberCont.paused=true;
            scrHMGameplayCheck(scrHMVisualOffset111()[0]==0,"pause freezes presentation offset");
            UberCont.paused=_paused;hm_portrait_frozen=true;
            scrHMGameplayCheck(scrHMVisualOffset111()[0]==0,"portrait freeze keeps the actor still");
            hm_portrait_frozen=false;x=_x;xprevious=_xp;hspeed=_h;vspeed=_v;
            scrHMGameplayCheck(matrix_get(matrix_world)[12]==_matrix[12],"presentation probes restore the caller's matrix");
        }
    }
    if(ticks==90) {
        var _rows=[];
        for(var _i=0;_i<array_length(motion_actors112);++_i) with(motion_actors112[_i]) {
            scrHMGameplayCheck(abs(x-motion_start112-2*motion_steps112)<.001,
                "manual movement distance still matches exactly one 30Hz callback");
            scrHMGameplayCheck(motion_steps112>=68&&motion_steps112<=71,
                "Custom event logic does not run twice at 60 FPS");
            scrHMGameplayCheck(abs(motion_begins112-motion_steps112)<=1&&abs(motion_ends112-motion_steps112)<=1,
                "begin and end callbacks retain the same logic cadence");
            scrHMGameplayCheck(motion_moves112>=motion_draws112-2,
                "custom object's presented position changes every rendered frame");
            scrHMGameplayCheck(motion_max112<=60/other.rate+.01,
                "custom object, enemy and projectile have evenly divided manual displacement");
            array_push(_rows,{type:object_get_name(object_index),steps:motion_steps112,
                draws:motion_draws112,moves:motion_moves112,maximum_delta:motion_max112});
        }
        show_debug_message("HARDMODE MOBILE MOTION112 "+json_stringify({rate:rate,actors:_rows}));
    }
}
