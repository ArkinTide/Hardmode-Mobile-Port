from pathlib import Path

ROOT=Path(__file__).resolve().parent

def patch(path, old, new):
    file=ROOT/path
    text=file.read_text(encoding='utf-8')
    if old not in text:
        assert new in text, path
        return
    file.write_text(text.replace(old,new,1),encoding='utf-8')

patch('project/scripts/scrHMRepairs1104Routes/scrHMRepairs1104Routes.gml', '''    if(!(_rocket[$ "hm_rocket_nochain1116"]??false) || !(_blast[$ "hm_rocket_nochain1116"]??false)) return false;
    var _owner=_rocket[$ "hm_rocket_owner1115"]??noone;
    return _owner!=noone && (_blast[$ "hm_rocket_owner1115"]??noone)==_owner;''', '''    // GunGod rockets ignore blast-triggered detonation, including unrelated
    // and player explosions. Wall and direct-target collisions remain native.
    return (_rocket[$ "hm_rocket_nochain1116"]??false) && instance_is(_blast,Explosion);''')
patch('project/scripts/scrHMRepairs1104Routes/scrHMRepairs1104Routes.gml', '''        scrHMGameplayCheck(!instance_exists(_peer),"other launchers' explosions can still detonate a GunGod rocket");''', '''        scrHMGameplayCheck(instance_exists(_peer),"GunGod rockets also survive unrelated and player blast collision");
        with(_peer) event_perform_object(Rocket,ev_collision,Wall);
        scrHMGameplayCheck(!instance_exists(_peer),"GunGod rockets still detonate on native wall collision");
        var _target=instance_create(_boss.x+160,_boss.y,Bandit);
        _target.hp=100;_target.nexthurt=-1;
        _peer=instance_create(_target.x,_target.y,JockRocket);
        _peer.hm_rocket_owner1115=_boss;_peer.hm_rocket_nochain1116=true;
        _peer.team=player.team;
        with(_target) with(_peer) event_perform_object(Rocket,ev_collision,hitme);
        scrHMGameplayCheck(!instance_exists(_peer) && _target.hp<100,
            "GunGod rockets still damage direct targets and detonate on impact");
        instance_destroy(_target,false);
        var _ordinary=instance_create(_boss.x+180,_boss.y,Rocket);
        with(_family) with(_ordinary) event_perform_object(Rocket,ev_collision,Explosion);
        scrHMGameplayCheck(!instance_exists(_ordinary),"unmarked rocket types retain native explosion-triggered detonation");''')

for rel in ['project/scripts/scrHMGameplayTests/scrHMGameplayTests.gml','tests/gameplay.gml']:
    file=ROOT/rel
    text=file.read_text(encoding='utf-8')
    if 'scrHMGameplayBoss1116();' not in text:
        anchor='        scrHMGameplayExtra1115();'
        if anchor not in text:
            anchor='        ticks++;'
        text=text.replace(anchor,anchor+'\n        scrHMGameplayBoss1116();',1)
        file.write_text(text,encoding='utf-8')

for rel in ['project/scripts/scrHMGameplayTests/scrHMGameplayTests.gml','tests/repairs105.gml']:
    patch(rel, 'with(dog105) {ammo=8;alarm[1]=1;intro=-2;morehp=1;introanimation=11;}',
          '// This fixture isolates ricochets; boss1116 observes the full opening.\n        with(dog105) {ammo=8;alarm[1]=1;intro=-2;morehp=1;introanimation=11;hm_dog_open1116=11;}')

old=(ROOT/'tests/repairs1104_routes.gml').read_text(encoding='utf-8')
start=old.index('function scrHMGameplayYV1115() {')
end=old.index('\nfunction scrHMGameplayNoReplacement1115()',start)
new='''function scrHMGameplayYV1115() {
    if(mode!="yv1115minigun") return;
    if(ticks==10) {
        scrHMGameplayLane107();UberCont.opt_bossintro=0;
        scrHMGameplayNoReplacement1115();
        scrHMModSet("mod","options","intropan","0");
        yv1115=instance_create(player.x+160,player.y,YVBoss);
        // Select the weapon through the production Alarm 1. The previous
        // revolver and >110 distance force the native minigun selection branch.
        with(yv1115) {
            hm_entry_camera1101=true;hm_exit_camera1101=true;
            for(var _i=0;_i<12;++_i) alarm[_i]=-1;
            intro=true;can_shoot=true;wep=wep_golden_revolver;
            event_perform(ev_alarm,1);
            for(var _i=0;_i<12;++_i) alarm[_i]=-1;
            gunangle=0;minigun_side=1;alarm[2]=1;speed=0;walk=0;
        }
        yv_max1115=70+30*GameCont.loops;yv_batch1115=1+GameCont.loops;
        yv_first1115=-1;yv_last1115=-1;yv_ammo1115=yv_max1115;
        yv_shots1115=0;yv_complete1115=false;yv_angle1115=0;
        scrHMGameplayCheck(yv1115.wep==wep_minigun && yv1115.ammo==yv_max1115,
            "Y.V production minigun selection matches the desktop Loop magazine budget");
    }
    if(ticks<11) return;
    scrHMGameplayCheck(instance_exists(yv1115),"Y.V remains present while native minigun cadence is observed");
    // The native burst finishes even when its final shots pass zero ammo.
    var _shot=max(0,yv_ammo1115-yv1115.ammo);
    if(_shot>0) {
        scrHMGameplayCheck(_shot==yv_batch1115,
            "actual native minigun alarms emit Loop+1 shots per thirty-Hz logical tick");
        var _turn=0;
        for(var _j=0;_j<_shot;++_j)
            _turn+=((yv_ammo1115-_j-1+10>yv_max1115)?.5:1);
        yv_angle1115+=_turn;
        scrHMGameplayCheck(abs(yv1115.gunangle-yv_angle1115)<.001,
            "every actual minigun alarm matches desktop remaining-ammo turning");
        if(yv_first1115<0) yv_first1115=ticks;
        yv_last1115=ticks;yv_shots1115+=_shot;
    }
    yv_ammo1115=yv1115.ammo;
    if(ticks==120) {
        var _total=ceil(yv_max1115/yv_batch1115)*yv_batch1115;
        scrHMGameplayCheck(yv_shots1115==_total && yv1115.ammo==0,
            "the entire native minigun magazine finishes at both rendering frame settings");
        var _duration=ceil(yv_max1115/yv_batch1115)-1;
        scrHMGameplayCheck(abs(yv_last1115-yv_first1115-_duration)<=1,
            "native complete-magazine cadence matches its Loop-specific logical duration");
        scrHMGameplayCheck(abs(yv1115.gunangle-(_total-4.5))<.001,
            "complete native sweep preserves the exact desktop half-degree opening and one-degree main turn");
        show_debug_message("HARDMODE YV1115 "+json_stringify({rate:rate,loop:GameCont.loops,
            shots:yv_shots1115,first_tick:yv_first1115,last_tick:yv_last1115,angle:yv1115.gunangle}));
        yv_complete1115=true;
    }
    if(ticks==125) scrHMGameplayCheck(yv_complete1115,"the full native cadence and turn sequence executes before test completion");
}
'''
for rel in ['tests/repairs1104_routes.gml','project/scripts/scrHMGameplayRoutes1104/scrHMGameplayRoutes1104.gml']:
    f=ROOT/rel;t=f.read_text(encoding='utf-8')
    a=t.index('function scrHMGameplayYV1115() {');b=t.index('\nfunction scrHMGameplayNoReplacement1115()',a)
    f.write_text(t[:a]+new+t[b:],encoding='utf-8')

# Preserve the maintained native source used by future register passes.
(ROOT/'native/repairs1104_routes.gml').write_text(
    (ROOT/'project/scripts/scrHMRepairs1104Routes/scrHMRepairs1104Routes.gml').read_text(encoding='utf-8'),encoding='utf-8')
print('boss1116 driver, native collision tests and Loop-aware Y.V alarm assertions synchronized')
