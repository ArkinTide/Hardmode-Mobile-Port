// Original NTT OasisBoss, reconstructed from its six native events.
// Address-by-address evidence is retained in original-OasisBoss.txt.
function scrHMOasisBossCreate() {
    raddrop=10;max_hp=120;meleedamage=3;size=4;
    hitid=[sprOasisBossIdle,"Big Bubbler"];
    instance_create(x,y,PortalClear);
    spr_idle=sprOasisBossIdle;spr_walk=sprOasisBossWalk;
    spr_hurt=sprOasisBossHurt;spr_dead=sprOasisBossDead;
}
function scrHMOasisBossAfterCreate() {
    spr_shadow=shd48;spr_shadow_x=0;spr_shadow_y=0;
    spr_fire=sprOasisBossFire;
    snd_hurt=sndOasisBossHurt;snd_dead=sndOasisBossHalfHP;snd_mele=sndOasisBossMelee;
    ammo=10;walk=0;sweep=0;type=0;
    gunangle=random(360);walkdir=random(360);
    alarm[1]=30+random(90);
    snd_play_hit_big(sndOasisBossIntro,.1);
}
function scrHMOasisBossThink() {
    if(lockstep_stop) return;
    // Native Alarm1 lines 2-12,14-24,26-31.
    alarm[1]=10+random(5);
    scrTarget();
    if(instance_exists(target)) {
        if(random(4)<1 && point_distance(x,y,target.x,target.y)<160) {
            sweep=random(4)-8;
            ammo=4;type=choose(0,1);alarm[2]=1;
            gunangle=point_direction(x,y,target.x,target.y);
            alarm[1]=32;
            snd_play_hit_big(sndOasisBossFire,.2);
        } else {
            direction=point_direction(x,y,target.x,target.y)+(40+random(30))*choose(1,-1);
            speed=.4*timescale;
            walk=10+random(10);
            if(point_distance(x,y,target.x,target.y)<96) {
                walk=40;
                direction=point_direction(target.x,target.y,x,y)+random(20)-10;
            }
            walkdir=direction;
            if(target.x<x) right=-1;
            else if(target.x>x) right=1;
        }
    } else if(random(10)<1) {
        motion_add(random(360),.4*timescale);
        walk=10+random(10);
        // Original 0x4097f0 and 0x406b10 both add (addsd verified).
        alarm[1]=walk+10+random(30);
        if(hspeed>0) right=1;
        else if(hspeed<0) right=-1;
    }
}
function scrHMOasisBossFire() {
    if(lockstep_stop) return;
    if(ammo<=0) {sprite_index=spr_idle;alarm[1]=40+random(10);return;}
    snd_play_hit_big(sndScorpionFire,1);
    ammo-=1;alarm[2]=8;sprite_index=spr_fire;
    repeat(3) {
        var _spread=(type==0)?[-15,15,-45,45]:[-30,0,30];
        for(var _i=0;_i<array_length(_spread);++_i) {
            with(instance_create(x,y,EnemyBullet4)) {
                hitid=other.hitid;
                motion_add(other.gunangle+_spread[_i],(6+random(1))*timescale);
                image_angle=direction;team=other.team;creator=other.id;
            }
        }
        gunangle+=sweep;
    }
}
function scrHMOasisBossStep() {
    if(lockstep_stop) return;
    if(walk>0) {walk-=timescale;motion_add(walkdir,2*timescale*timescale);}
    speed=min(speed,2.5*timescale);
}
function scrHMOasisBossDeath() {
    // Original Destroy lines 4-12: two acid streaks, offset by 120 degrees.
    dir=random(360);
    repeat(2) {
        with(instance_create(x,y,AcidStreak)) {
            motion_add(other.dir,8*timescale);image_angle=direction;
        }
        dir+=120;
    }
}
