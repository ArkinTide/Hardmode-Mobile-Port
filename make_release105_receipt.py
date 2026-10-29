"""Check final 1.0.5 source, current-VM evidence and both mobile packages."""
from datetime import datetime, timezone
from pathlib import Path
import hashlib, json, math, plistlib, sys, zipfile
from release_config import VERSION, BUILD, PACKAGE, DIRECTORY
from run_release105_checks import KINDS, SCENARIOS

ROOT = Path(__file__).resolve().parent
OUT = ROOT / DIRECTORY
sys.path.insert(0, str(ROOT.parent))
from patch_followup_compat import Game


def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest()
def read(path): return json.loads((ROOT/path).read_text(encoding='utf8'))


def main():
    assert (VERSION, BUILD, DIRECTORY) == ('1.0.5', 6, 'release105')
    final = read('release105/final-source.json')
    baseline = read('release105/baseline-source.json')
    digest = sha(ROOT/'build-windows/nuclearthronemobile.win')
    assert digest == final['desktop_vm_sha256']
    for section in ('project_files', 'development_sources'):
        for rel, expected in final[section].items(): assert sha(ROOT/rel) == expected, rel
    assert not set(baseline['project_files']) - set(final['project_files'])
    changed = {p:{'old':baseline['project_files'].get(p), 'new':v}
               for p,v in final['project_files'].items() if baseline['project_files'].get(p) != v}
    assert not [p for p in changed if Path(p).suffix.lower() in
                {'.png','.ogg','.wav','.mp3','.ttf','.otf','.so'}]
    gameplay = read('release105/gameplay-regression.json')
    assert [r['scenario'] for r in gameplay] == SCENARIOS
    for r in gameplay: assert r['status'] == 'PASS' and r['vm_sha256'] == digest
    menus = [read(f'release105/menu-{rate}-receipt.json') for rate in (30,60)]
    for r in menus:
        assert r['status'] == 'PASS' and r['vm_sha256'] == digest
        assert r['shilling_draws'] > 150 and r['version_draws'] > 150
    native = [read(f'release105/{kind}-native-receipt.json') for kind in KINDS]
    for kind,r in zip(KINDS,native):
        assert r.get('vm_sha256',r.get('compiled_vm_sha256')) == digest, kind
        if kind != 'artwork': assert r['status'] == 'PASS', kind
        else:
            resources = read('native-artwork-receipt.json')['resources']
            assert r['checks'] == len(resources)*3 == 1035
            expected = {a['resource']:a['origin'] for a in resources
                        if any(v != math.trunc(v) for v in a['origin'])}
            assert len(expected) == len(r['origin_mismatches']) == 16
            for mismatch in r['origin_mismatches']:
                origin = expected[mismatch['sprite']]
                assert mismatch['expected'] == origin
                assert mismatch['actual'] == [math.trunc(v) for v in origin]
    localization = read('release105/localization-audit.json')
    assert not localization['untranslated_literals']
    structures = read('release105/structure-audit.json')
    assert structures['status'] == 'PASS' and all(structures['checks'].values())
    assert structures['desktop_vm_sha256'] == digest
    stock = read('release104/localization-stock-restored.json')
    assert len(stock) == 45 and stock['BOLTS'] == '箭矢' and stock['FISH'] == '鱼'
    compatibility = read('release105/ios-native-compatibility.json')
    assert compatibility['compatible_added_functions_and_extensions'] is True
    assert compatibility['game_vm_sha256'] == sha(ROOT/'platforms/ios/prepared-assets/game.ios')
    functions = ['scrHMBanditWake','scrHMPickupRefresh','scrHMDrawFog',
                 'scrHMDrawBossLetterbox','scrHMMenuDrawComplete','scrHMActorDraw',
                 'scrHMConvertCursedEnemy','scrHMBeamDistance','scrHMIDPDBeamFix',
                 'scrHMGroundBounds','scrHMCursedCavesRestore','scrHMWaterEntrySound',
                 'scrHMConsoleGoto','scrHMFishSkullSpawn','scrHMDeathExit',
                 'scrHMTitankHealth','scrHMWallFillStep','scrHMWallThemeTick',
                 'scrHMWallBreakUpdate104','scrHMSewerTick','scrHMWaterAt',
                 'scrHMBossFreeze104','scrHMBossRestore104','scrHMBossStep104',
                 'scrHMUnlockArea','scrHMManholeCreate','scrHMStorageMigrate',
                 'hm_bosses_gatorboss_mod_gml_gatorboss_step',
                 'hm_bosses_ravenboss_mod_gml_ravenboss_step', 'scrHMSwimPlayer105', 'scrHMSwimSpeed105', 'scrHMDrawHooks105', 'scrHMCarveFill105', 'scrHMBigDogShots105', 'scrHMAuthoredWalls105', 'scrHMBackgroundColour105', 'scrHMRavenLand105', 'scrHMInteriorEdge105', 'scrHMFindGround105', 'scrHMNearestAuthoredWall105', 'scrHMRavenAim105']
    functions.append('scrHMPalaceGenerator105')
    artifacts = []
    for target,label,extension in [('android','Android','apk'),('ios','iOS','ipa')]:
        path = ROOT/f'deliverables/NuclearThrone.Hardmode-{label}-{VERSION}.{extension}'
        receipt = read(path.relative_to(ROOT).with_suffix('.validation.json'))
        assert (receipt['package'],receipt['version'],receipt['build']) == (PACKAGE,VERSION,BUILD)
        assert receipt[extension+'_sha256'] == sha(path)
        preparation = read(f'platforms/{target}/prepared-receipt.json')
        vm = 'game.droid' if target == 'android' else 'game.ios'
        with zipfile.ZipFile(ROOT/f'build-{target}/nuclearthronemobile.zip') as z:
            assert hashlib.sha256(z.read('assets/'+vm)).hexdigest() == preparation['raw_vm_sha256']
        prepared = ROOT/f'platforms/{target}/prepared-assets/{vm}'
        assert sha(prepared) == preparation['prepared_vm_sha256']
        game = Game(prepared.read_bytes())
        for fn in functions: assert 'gml_Script_'+fn in game.codes, (target,fn)
        assert ('/sdcard/games/com.arkintide.nuclearthronehardmode/' if target=='android'
                else 'Documents/hardmode/') in game.strings
        if target == 'ios':
            with zipfile.ZipFile(path) as z:
                info = plistlib.loads(z.read(next(n for n in z.namelist() if n.endswith('.app/Info.plist'))))
                assert info['UIFileSharingEnabled'] and info['LSSupportsOpeningDocumentsInPlace']
        artifacts.append({'path':path.relative_to(ROOT).as_posix(),'bytes':path.stat().st_size,
                          'sha256':sha(path),'prepared_vm_sha256':preparation['prepared_vm_sha256'],
                          'compiled_repair_functions':functions})
    assert read('deliverables/NuclearThrone.Hardmode-Android-1.0.3.validation.json')['certificate_sha256'] == \
           read('deliverables/NuclearThrone.Hardmode-Android-1.0.5.validation.json')['certificate_sha256']
    mobile = read('release105/mobile-storage-audit.json')
    assert mobile['android_shared_storage_permission_packaged'] and mobile['ios_documents_sharing_enabled']
    visual = read('release105/visual-review.json')
    assert visual['vm_sha256'] == digest and visual['reviewed']
    performance = read('release105/performance.json')
    assert performance['vm_sha256'] == digest
    report = {'status':'PASS','verified_utc':datetime.now(timezone.utc).isoformat(),
              'version':VERSION,'build':BUILD,'mod':'Hardmode b24',
              'final_desktop_vm_sha256':digest,'original_commit':final['original_commit'],
              'original_files_verified':final['original_files_verified'],
              'changed_project_files':changed,'media_pixels_and_audio_unchanged_since_1_0_4':True,
              'native_assertions':sum(r['checks'] for r in native),'native_checks':dict(zip(KINDS,native)),
              'menu_assertions':sum(r['checks'] for r in menus),'menu_receipts':menus,
              'gameplay_cases':len(gameplay),'gameplay_assertions':sum(r['checks'] for r in gameplay),
              'gameplay_receipts':gameplay,'visual_review':visual,'localization':localization,
              'structure_audit':structures,
              'death_sequence_observers':'Corrected scorpion103 samples the full emission window without cinematics; scorpion105 samples the full window with cinematic pause and resume. Both rates are required for both modes.',
              'artifacts':artifacts,'ios_native_audit':'release105/ios-native-compatibility.json',
              'mobile_storage_audit':mobile,'desktop_performance':performance,
              'regression_method':f'One unchanged VM: seven native suites, real menus at 30/60 FPS, {len(SCENARIOS)} focused gameplay scenarios and desktop visual review.',
              'physical_device_tested':False,'mac_native_rebuild':False,'ios_requires_resigning':True,
              'github_uploaded':False,'mega_uploaded':False,
              'limits':['Desktop tests do not replace phone testing or a complete manual playthrough.',
                        'Desktop profiling measures module processing, not phone frame rate.',
                        'Android release lint dependencies unavailable offline; explicit signature, alignment and asset checks passed.',
                        'iOS retains a compatible native runner with new VM/resources and requires resigning.']}
    (OUT/'delivery-receipt.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print(json.dumps({k:report[k] for k in ('status','version','native_assertions','menu_assertions',
                                          'gameplay_cases','gameplay_assertions','artifacts')},indent=2))


if __name__ == '__main__': main()
