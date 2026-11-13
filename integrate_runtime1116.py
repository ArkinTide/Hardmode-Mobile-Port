"""Apply the maintained 1.1.6 runtime changes without historical imports."""
from pathlib import Path

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / 'project'


def replace(path, old, new):
    file = PROJECT / path
    text = file.read_text('utf-8-sig')
    if new in text:
        return
    assert text.count(old) == 1, (path, old[:70])
    file.write_text(text.replace(old, new), 'utf8')


def main():
    path = PROJECT / 'scripts/scrHMUI1104/scrHMUI1104.gml'
    text = path.read_text('utf8')
    start = text.index('function scrHMGuardianLayerLift1104()')
    text = text[:start] + '''function scrHMGuardianLayerLift1104() {
    // Keep the lift until the effect ends. Restoring and reassigning depth
    // every frame forced two engine draw-list migrations for every bullet.
    if(!is_undefined(self[$ "hm_guard_depth109"]) && depth!=hm_guard_set109)
        hm_guard_depth109=undefined;
    if(depth>-9) {
        hm_guard_depth109=depth;depth=-9;hm_guard_set109=depth;
    }
}

function scrHMGuardianLayers1104() {
    if(!scrHMEnabled()) return;
    var _cached=self[$ "hm_guard_dark116"];
    var _dark=_cached??noone;
    if(is_undefined(_cached)) {
        _dark=noone;
        with(HMBinding) if(hm_code==scrHMScriptRef(hm_bosses_guardianboss_mod_gml_guardiandark_draw)) {_dark=id;break;}
        hm_guard_dark116=_dark;
    }
    var _active=instance_exists(_dark);
    if(!_active) {
        if(self[$ "hm_guard_layers109"]??false) {
            with(GameObject) scrHMGuardianLayerRestore1104();
            with(damagesource) scrHMGuardianLayerRestore1104();
        }
        hm_guard_layers109=false;return;
    }
    hm_guard_layers109=true;
    // Traverse actor families directly, never all terrain/decorations. Each
    // new source is lifted once; native movement and Draw events remain live.
    with(hitme) scrHMGuardianLayerLift1104();
    with(Pickup) scrHMGuardianLayerLift1104();
    with(Effect) scrHMGuardianLayerLift1104();
    with(CrystalShield) scrHMGuardianLayerLift1104();
    with(CrystalShieldDisappear) scrHMGuardianLayerLift1104();
    with(PortalStrike) scrHMGuardianLayerLift1104();
    with(BoltStick) scrHMGuardianLayerLift1104();
    with(damagesource) scrHMGuardianLayerLift1104();
}
'''
    path.write_text(text, 'utf8')
    (ROOT / 'native/ui1104.gml').write_text(text, 'utf8')

    replace('objects/UberCont/Step_0.gml', 'var _index = global.index',
            'var _index = global.index\n\nscrHMFrameBudget1116();')
    replace('objects/UberCont/Step_0.gml', '''		with (Floor) {
	        if (bbox_right >= _left && bbox_bottom >= _top && bbox_left < _right && bbox_top < _bottom) {
	            ds_list_add(_floor_list, id)
	        }
	    }''',
            '\t\tscrHMVisibleFloors1116(_left,_top,_right,_bottom,_floor_list);')
    # The owner's room handler is otherwise unchanged, including boss music.
    replace('scripts/scrHMRepairs112/scrHMRepairs112.gml',
            '    alarm[0]=-1;\n    var _area=GameCont.area',
            '    alarm[0]=-1;\n    scrHMDesertMusic1116();\n    var _area=GameCont.area')
    path=PROJECT / 'scripts/scrHMRepairs112/scrHMRepairs112.gml'
    (ROOT / 'native/repairs112.gml').write_text(path.read_text('utf8'), 'utf8')
    print('Runtime 1.1.6 call sites integrated')


if __name__ == '__main__':
    main()
