// CustomEnemy's native NTT order: death callback, destruction; otherwise
// recoil recovery, target refresh and on_step. Do not run enemy animation AI
// on top of the MOD's own animation/behaviour code.
function scrHMActorInit() {
    hm_custom_actor=true;
    on_step=undefined;on_begin_step=undefined;on_end_step=undefined;
    on_destroy=undefined;on_cleanup=undefined;on_draw=undefined;
    on_hurt=undefined;on_death=undefined;on_wall=undefined;on_hit=undefined;
    can_die=true;hm_cleaned=false;
    name="";z=0;
}

// NTT's ref_enemy_maxhealth invokes scrEnemyHealth on the first write only.
// Later edits to the maximum do not heal an already initialized actor.
function scrHMMaxHealthWrite(_target,_value,_op="=") {
    with(_target) {
        switch(_op) {
            case "=":max_hp=_value;break;
            case "+=":max_hp+=_value;break;
            case "-=":max_hp-=_value;break;
            case "*=":max_hp*=_value;break;
            case "/=":max_hp/=_value;break;
            case "%=":max_hp=max_hp mod _value;break;
            case "&=":max_hp&=_value;break;
            case "|=":max_hp|=_value;break;
            case "^=":max_hp^=_value;break;
            case "<<=":max_hp=max_hp<<_value;break;
            case ">>=":max_hp=max_hp>>_value;break;
        }
        if(self[$ "hm_maxhealth_init"] ?? false) {
            hm_maxhealth_init=false;
            max_hp*=1+GameCont.loops/20;
            if(scr_skill_get(mut_scarier_face)) max_hp*=.8;
            max_hp=max(1,round(max_hp));hp=max_hp;
            if(scrCrownCheck(crwn_luck) && random(10)<1) hp=1;
        }
        return max_hp;
    }
    return undefined;
}

function scrHMActorCallback(_field, _args=[]) {
    if((self[$ "frozen"]??false) && array_contains(["on_step","on_begin_step","on_end_step"],_field)) return undefined;
    var _callback=variable_instance_get(id,_field);
    if(is_undefined(_callback)) return undefined;
    if(_field=="on_destroy" && scrHMScriptRef(_callback)==scrHMScriptRef(hm_bosses_scorpionboss_mod_gml_fancyscorpionboss_death)) {
        var _x=x,_y=y;
        with(HMWorld) {
            var _oldx=x,_oldy=y;x=_x;y=_y;
            scrHMInvokeHere(scrHMScriptRef(_callback),_args);
            x=_oldx;y=_oldy;
        }
        return undefined;
    }
    return scrHMInvokeHere(scrHMScriptRef(_callback),_args);
}

function scrHMActorCleanup() {
    if(hm_cleaned) return;
    hm_cleaned=true;
    scrHMActorCallback("on_cleanup");
}

function scrHMEnemyStep() {
    if(lockstep_stop) return;
    if(name=="titank") scrHMTitankHealth();
    if(can_die && hp<=0) {
        scrHMActorCallback("on_death");
        instance_destroy();
        return;
    }
    if(wkick!=0) wkick=approach(wkick,0,timescale);
    scrTarget();
    scrHMActorCallback("on_step");
    if(instance_exists(id)) scrHMGroundBounds();
}

function scrHMActorHurt(_amount,_hitid,_knockback=0,_direction=0) {
    // on_hurt owns damage/iframes. Applying the base damage as well doubles
    // incoming damage and bypasses the shields implemented by the source.
    // NTT supplies damage, knockback velocity and knockback direction. Its
    // raw-hit path uses zero knockback; a projectile passes its actual vector.
    hm_last_hitid=_hitid;
    scrHMActorCallback("on_hurt",[_amount,_knockback/timescale,_direction]);
    return true;
}

function scrHMProjectileCollision() {
    if(lockstep_stop || (team==other.team && other.team!=team_none)) return;
    if(!is_undefined(on_hit)) {
        scrHMActorCallback("on_hit");
    } else {
        scr_projectile_generic_hit();
    }
}

function scrHMProjectileWall() {
    if(lockstep_stop) return;
    if(is_undefined(on_wall)) instance_destroy();
    else scrHMActorCallback("on_wall");
}

function scrHMActorDraw() {
    if(is_undefined(on_draw)) {
        var _hurt=self[$ "spr_hurt"]??-1;
        var _sprite=((self[$ "nexthurt"]??0)>current_frame && sprite_exists(_hurt))?_hurt:sprite_index;
        if(sprite_exists(_sprite)) draw_sprite_ext(_sprite,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
    }
    else scrHMActorCallback("on_draw");
}

function scrHMBanditWake(_x,_y,_rads) {
    // The replacement is the same living enemy. Preserve damage when its
    // sleeping body is exchanged for the armed actor; never revive a corpse.
    if(hp<=0) return noone;
    var _health=hp,_burning=self[$ "burning"];
    var _awake=hm_enemies_mod_gml_elitebandit_create(_x,_y,_rads);
    _awake.hp=_health;
    _awake.nexthurt=nexthurt;
    if(!is_undefined(_burning)) _awake.burning=_burning;
    return _awake;
}
