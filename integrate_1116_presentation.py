"""One presentation owner for native art and Hardmode camera work."""
from pathlib import Path
from integrate_1116_policy import edit,resource,ROOT

def main():
    resource('scrHMRepairs1116Policy','native/repairs1116_policy.gml')
    edit('project/scripts/scrBossIntro/scrBossIntro.gml',
         'if(scrHMEnabled() && instance_exists(GameCont) && GameCont.loops>0 && !_force) return;',
         'if(scrHMEnabled() && instance_exists(GameCont) && GameCont.loops>0 && !_force) return;\n    if(scrHMBossNativeRequest1116(_boss_index)) return;')
    for path in ['native/repairs1102.gml','project/scripts/scrHMRepairs1102/scrHMRepairs1102.gml']:
        edit(path,'with(_actor) scrHMContentEvent1100(YVBoss,ev_alarm,7);',
             'with(_actor) scrBossIntro(10,true);')
        edit(path,'// A native portrait and a MOD camera pan are separate presentations.\n    // Keep every attack disarmed until both have released the scene.',
             '// Portrait and camera share one frozen presentation controller.\n    // Combat starts only after that controller has released the scene.')
    for path in ['native/repairs104.gml','project/scripts/scrHMRepairs104/scrHMRepairs104.gml']:
        edit(path,'function scrHMBossStep104() {',
             'function scrHMBossStep104() {\n    scrHMBossNativeStep1116();')
    # This renderer already runs in GUI coordinates above the moving world.
    path=ROOT/'project/scripts/scrHMCompiled_bosses_bossintros_mod_gml/scrHMCompiled_bosses_bossintros_mod_gml.gml'
    text=path.read_text('utf8')
    old='if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {\n\n{\n\nif ((fadedark == 1))'
    new='if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {\n\nscrHMBossNativeDraw1116();\n{\n\nif ((fadedark == 1))'
    assert old in text;text=text.replace(old,new,1);path.write_text(text,'utf8')
    for path in ['native/repairs109.gml','project/scripts/scrHMRepairs109/scrHMRepairs109.gml']:
        edit(path,'x:10016,y:10016,entry_count:0,exit_count:0};',
             'x:10016,y:10016,entry_count:0,exit_count:0,native_art1116:-1};')
        edit(path,'var _group=scrHMBossGroupReserve115(_kind);\n    var _exit=',
             'var _group=scrHMBossGroupReserve115(_kind);\n    if(instance_exists(_source)) {_group.x=_source.x;_group.y=_source.y;}\n    var _exit=')
        edit(path,'if(_exit) {\n        if(!_group.exit_done',
             'if(_exit) {\n        if(_kind=="guardian") {_group.exit_done=true;return true;}\n        if(!_group.exit_done')
        edit(path,'if(_kind=="") return false;\n    var _group=scrHMBossGroupReserve115(_kind);',
             'if(_kind=="") return false;\n    var _group=scrHMBossGroupReserve115(_kind);') if False else None
        edit(path,'if(_exit && is_undefined(_request))\n            _request=',
             'if(_exit && _group.kind=="guardian") {_group.exit_done=true;continue;}\n        if(_exit && is_undefined(_request))\n            _request=')
        edit(path,'if(scrHMModGet("mod","options",_exit?"bossoutros":"intropan")!="1"\n            && (_request.title=="" || _exit || GameCont.loops>0)) {',
             'var _native_art=_exit?-1:(_group[$ "native_art1116"]??-1);\n        var _portrait=_native_art>=0 || (!_exit && _request.title!="" && GameCont.loops==0\n            && scrHMModGet("mod","options","bossportraits")!="0");\n        var _pan=_group.kind!="guardian" && scrHMModGet("mod","options",_exit?"bossoutros":"intropan")=="1";\n        if(!_pan && !_portrait) {')
        old='if(!instance_exists(_focus) || instance_exists(HMWorld.hm_portrait_active)) continue;\n        HMWorld.hm_group_dispatch115=true;\n        hm_bosses_bossintros_mod_gml_boss_trigger(GameCont.loops>0?"":_request.title,\n            _request.back,_request.portrait,_request.front,_focus,_request.height);\n        HMWorld.hm_group_dispatch115=false;\n        var _intro=HMWorld.hm_portrait_active;\n        if(!instance_exists(_intro)) continue;\n        _intro.hm_boss_kind115=_group.kind;_intro.hm_boss_exit115=_exit;'
        new='if(instance_exists(HMWorld.hm_portrait_active)) continue;\n        // A destroyed actor must not move the camera to its initial spawn\n        // floor. A temporary point retains the last actual boss position.\n        var _point=noone;\n        if(_exit || !_pan || !instance_exists(_focus)) {\n            _point=instance_create(_pan?_group.x:Player.x,_pan?_group.y:Player.y,CustomObject);\n            _point.name="hm_camera_focus1116";_point.sprite_visible=false;\n            _focus=_point;\n        }\n        HMWorld.hm_group_dispatch115=true;\n        hm_bosses_bossintros_mod_gml_boss_trigger((GameCont.loops>0 || _native_art>=0)?"":_request.title,\n            _request.back,_request.portrait,_request.front,_focus,_request.height);\n        HMWorld.hm_group_dispatch115=false;\n        var _intro=HMWorld.hm_portrait_active;\n        if(instance_exists(_point)) instance_destroy(_point,false);\n        if(!instance_exists(_intro)) continue;\n        _intro.hm_boss_kind115=_group.kind;_intro.hm_boss_exit115=_exit;\n        _intro.hm_camera_start1116=HMWorld.logic_serial;\n        _intro.hm_camera_target_x1116=_intro.x;_intro.hm_camera_target_y1116=_intro.y;\n        if(_native_art>=0) scrHMBossNativeAttach1116(_intro,_native_art);'
        edit(path,old,new)
    edit('project/objects/enemy/Destroy_0.gml','scrHMDeathExit(x,y);','scrHMBossGroupDeath1116();\nscrHMDeathExit(x,y);')
    for path in ['native/repairs1101.gml','project/scripts/scrHMRepairs1101/scrHMRepairs1101.gml']:
        edit(path,'if(!instance_exists(_intro)) return false;\n    _intro.hm_camera1101=true;',
             'if(!instance_exists(_intro) || (_intro[$ "hm_boss_kind115"]??"")!=scrHMBossGroupKind115(_actor)) return false;\n    _intro.hm_camera1101=true;')

if __name__=='__main__':main()
