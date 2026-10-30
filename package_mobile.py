"""Independent Hardmode mobile data preparation and retained-runner IPA."""
from pathlib import Path
import argparse,copy,hashlib,json,plistlib,struct,sys,zipfile
from package_fonts import restore
from release_config import VERSION,BUILD,PACKAGE

ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT.parent))
from patch_followup_compat import Game

def sha(data):return hashlib.sha256(data).hexdigest()

def prepare(target):
    source=ROOT/'platforms/font-source.zip'
    with zipfile.ZipFile(source,'w',compression=zipfile.ZIP_DEFLATED) as z:
        for directory in ['fonts/fntCJK','fonts/fntCJKBig','sprites/sprBignameAtlas']:
            for p in (ROOT/'project'/directory).rglob('*'):
                if p.is_file():z.write(p,'source/'+p.relative_to(ROOT/'project').as_posix())
    with zipfile.ZipFile(ROOT/f'build-{target}/nuclearthronemobile.zip') as z:
        assert z.testzip() is None
        assets={n.removeprefix('assets/'):z.read(n) for n in z.namelist() if n.startswith('assets/') and not n.endswith('/')}
    vm='game.droid' if target=='android' else 'game.ios'
    raw=assets[vm]
    with zipfile.ZipFile(source) as z:restored,fonts,title=restore(raw,z)
    game=Game(restored)
    # The base's CJK sprite title anchor predates the current atlas geometry.
    start,length=game.codes['gml_Script_draw_text_bigname']
    hits=[p for p in range(start,start+length,4) if game.data[p:p+8]==bytes.fromhex('13000f84 f1ff05c0')]
    assert len(hits)==1,hits
    game.put(hits[0],0x840f0004)
    refs=game.functions['display_set_timing_method']['refs']
    # Windows has a separate startup-clock function. Only the inherited
    # MakeGame event's timing argument is the iOS compatibility operand.
    event_start,event_length=game.codes['gml_Object_MakeGame_Create_0']
    event_refs=[r for r in refs if event_start<=r<event_start+event_length]
    assert len(event_refs)==1,(refs,event_refs)
    timing=event_refs[0]-12
    assert game.data[timing:timing+12]==bytes.fromhex('00000f84 00005207 010002d9')
    if target=='ios':
        game.put(timing,0x840f0001)
    assets[vm]=bytes(game.data)
    dest=ROOT/f'platforms/{target}/prepared-assets';dest.mkdir(parents=True,exist_ok=True)
    for name,data in assets.items():
        path=dest/name;path.parent.mkdir(parents=True,exist_ok=True);path.write_bytes(data)
    receipt={'target':target,'raw_vm_sha256':sha(raw),'prepared_vm_sha256':sha(assets[vm]),
             'fonts':fonts,'title':title,'cjk_anchor_operand':hits[0],
             'ios_vsync_operand':timing if target=='ios' else None,
             'timing_operand':timing,'timing_method':1 if target=='ios' else 0,
             'timing_reference_count':len(refs),'timing_code':'gml_Object_MakeGame_Create_0',
             'assets':{n:sha(d) for n,d in assets.items()}}
    (ROOT/f'platforms/{target}/prepared-receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(target,'prepared',len(assets),'assets; exact font pixels verified')
    return assets,receipt

def ios():
    assets,receipt=prepare('ios')
    baseline=ROOT/'../../outputs/NuclearThroneIOS.ipa'
    out=ROOT/f'deliverables/NuclearThrone.Hardmode-iOS-{VERSION}.ipa';out.parent.mkdir(exist_ok=True)
    with zipfile.ZipFile(baseline) as z:
        info_path=next(n for n in z.namelist() if n.endswith('.app/Info.plist'))
        app=info_path.removesuffix('Info.plist');info=plistlib.loads(z.read(info_path))
        info.update(CFBundleIdentifier=PACKAGE,CFBundleDisplayName='Nuclear Throne: Hardmode',
                    CFBundleName='Nuclear Throne: Hardmode',CFBundleShortVersionString=VERSION,
                    CFBundleVersion=str(BUILD),UIFileSharingEnabled=True,LSSupportsOpeningDocumentsInPlace=True)
        executable=app+info['CFBundleExecutable'];runner=z.read(executable)
        # Drop the predecessor's game files and signatures; preserve only its
        # compatible native runner, native UI/frameworks, launch images/icons.
        with zipfile.ZipFile(out,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=6) as result:
            for item in z.infolist():
                name=item.filename
                if '/games/' in name or '/_CodeSignature/' in name or name.endswith('/embedded.mobileprovision'):continue
                data=plistlib.dumps(info,fmt=plistlib.FMT_BINARY,sort_keys=False) if name==info_path else z.read(name)
                result.writestr(copy.copy(item),data)
            for name,data in assets.items():result.writestr(app+'games/'+name,data)
    with zipfile.ZipFile(out) as z:
        assert z.testzip() is None
        assert z.read(executable)==runner
        assert plistlib.loads(z.read(info_path))['CFBundleIdentifier']==PACKAGE
        assert z.read(app+'games/game.ios')==assets['game.ios']
        assert len(z.namelist())==len(set(z.namelist()))
        for name,data in assets.items():assert z.read(app+'games/'+name)==data
    receipt.update(package=PACKAGE,version=VERSION,build=BUILD,runner_sha256=sha(runner),
                   ipa_sha256=sha(out.read_bytes()),requires_resigning=True,physical_device_tested=False,
                   mac_native_rebuild=False)
    out.with_suffix('.validation.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(out)

def android():
    assets,receipt=prepare('android')
    dest=ROOT/'platforms/android/gradle-project'/PACKAGE/'src/main/assets'
    for name,data in assets.items():
        path=dest/name;path.parent.mkdir(parents=True,exist_ok=True);path.write_bytes(data)
    print('Android runner assets updated; assemble and validate the signed APK next.')

if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('target',choices=['android','ios'])
    (android if parser.parse_args().target=='android' else ios)()
