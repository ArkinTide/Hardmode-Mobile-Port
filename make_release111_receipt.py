"""Verify Windows-first delivery and the subsequent mobile-only motion change."""
from pathlib import Path
from datetime import datetime,timezone
import hashlib,json,sys,zipfile
from release_config import VERSION,BUILD,PACKAGE,DIRECTORY
from run_release111_checks import KINDS,SCENARIOS
ROOT=Path(__file__).resolve().parent
OUT=ROOT/DIRECTORY
sys.path.insert(0,str(ROOT.parent))
from patch_followup_compat import Game
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def read(p):return json.loads((ROOT/p).read_text(encoding='utf8'))

def main():
    assert (VERSION,BUILD)==('1.0.11',12)
    final=read(OUT/'final-source.json');digest=sha(ROOT/'build-windows/nuclearthronemobile.win')
    assert final['desktop_vm_sha256']==digest and final['original_files_verified']==7231
    for section in ('project_files','development_sources'):
        for p,h in final[section].items():assert sha(ROOT/p)==h,p
    regression=read(OUT/'windows-regression.json');assert regression['status']=='PASS'
    rows=regression['cases'];wdigest=regression['vm_sha256']
    assert [r['scenario'] for r in rows]==SCENARIOS
    assert all(r['status']=='PASS' and r['vm_sha256']==wdigest for r in rows)
    windows=read(OUT/'windows-delivery-receipt.json');assert windows['status']=='PASS'
    assert windows['desktop_vm_sha256']==wdigest
    wp=ROOT/windows['path'];assert sha(wp)==windows['sha256']
    native=[read(OUT/f'{k}-native-receipt.json') for k in KINDS]
    assert all(r.get('vm_sha256',r.get('compiled_vm_sha256'))==wdigest for r in native)
    assert all(k=='artwork' or r['status']=='PASS' for k,r in zip(KINDS,native))
    menus=[read(OUT/f'menu-{rate}-receipt.json') for rate in (30,60)]
    assert all(r['status']=='PASS' and r['vm_sha256']==wdigest for r in menus)
    visual=read(OUT/'visual-review.json');assert visual['reviewed'] and visual['vm_sha256']==wdigest
    motion=read(OUT/'mobile-motion-audit.json');assert motion['status']=='PASS'
    assert motion['windows_delivered_before_inspection'] and motion['desktop_validation_vm_sha256']==digest
    mobile_rows=motion['runtime_cases'];assert all(r['status']=='PASS' and r['vm_sha256']==digest for r in mobile_rows)
    previous=read('release110/final-source.json')['project_files']
    changed=[p for p,h in final['project_files'].items() if previous.get(p)!=h]
    assert not [p for p in changed if Path(p).suffix.lower() in {'.png','.jpg','.ogg','.wav','.ttf','.otf'}]
    functions=['scrHMVisualOffset111','scrHMThroneShift111','scrHMWaterBank111','scrHMVanillaLoopPopulate111',
        'scrHMVenusDropAllowed111','scrHMMissileShot111','scrHMCaveWallWave111','scrDesktopWheelPending111']
    artifacts=[]
    for target,label,ext in [('android','Android','apk'),('ios','iOS','ipa')]:
        p=ROOT/f'deliverables/NuclearThrone.Hardmode-{label}-{VERSION}.{ext}'
        validation=read(p.with_suffix('.validation.json'))
        assert (validation['package'],validation['version'],validation['build'])==(PACKAGE,VERSION,BUILD)
        assert validation[ext+'_sha256']==sha(p)
        prep=read(f'platforms/{target}/prepared-receipt.json')
        vm='game.droid' if target=='android' else 'game.ios'
        with zipfile.ZipFile(ROOT/f'build-{target}/nuclearthronemobile.zip') as z:
            assert hashlib.sha256(z.read('assets/'+vm)).hexdigest()==prep['raw_vm_sha256']
        prepared=ROOT/f'platforms/{target}/prepared-assets/{vm}';assert sha(prepared)==prep['prepared_vm_sha256']
        game=Game(prepared.read_bytes())
        for fn in functions:assert 'gml_Script_'+fn in game.codes,(target,fn)
        assert 'Hardmode 1.0.11' in game.strings
        artifacts.append(dict(path=p.relative_to(ROOT).as_posix(),bytes=p.stat().st_size,sha256=sha(p),
            validation_sha256=sha(p.with_suffix('.validation.json')),prepared_vm_sha256=prep['prepared_vm_sha256']))
    old=read('deliverables/NuclearThrone.Hardmode-Android-1.0.10.validation.json')
    new=read('deliverables/NuclearThrone.Hardmode-Android-1.0.11.validation.json')
    assert old['certificate_sha256']==new['certificate_sha256']
    storage=read(OUT/'mobile-storage-audit.json')
    assert storage['android_shared_storage_permission_packaged'] and storage['ios_documents_sharing_enabled']
    assert storage['android_monotonic_pacer_dex_call_before_native_process']
    pacing=read(OUT/'android-pacing.json');assert pacing['status']=='PASS' and pacing['checks']==12
    compatibility=read(OUT/'ios-native-compatibility.json');assert compatibility['compatible_added_functions_and_extensions']
    report=dict(status='PASS',version=VERSION,build=BUILD,mod='Hardmode b24',
        verified_utc=datetime.now(timezone.utc).isoformat(),installation_packages_generated=True,
        source_manifest_sha256=sha(OUT/'final-source.json'),source_code_archive_sha256=sha(OUT/'final-code.zip'),
        final_desktop_vm_sha256=digest,windows_desktop_vm_sha256=wdigest,
        original_files_verified=7231,changed_project_files=changed,media_changed=False,
        gameplay_cases=len(rows)+len(mobile_rows),gameplay_assertions=sum(r['checks'] for r in rows+mobile_rows),
        windows_gameplay_cases=len(rows),windows_gameplay_vm_sha256=wdigest,
        native_assertions=sum(r['checks'] for r in native),menu_assertions=sum(r['checks'] for r in menus),
        native_menu_vm_sha256=wdigest,mobile_motion_validation_vm_sha256=digest,
        artifacts=artifacts,compiled_repair_functions=functions,
        windows_artifact=dict(path=windows['path'],sha256=windows['sha256'],bytes=windows['bytes']),
        test_audio='Muted: zero master gain and Windows audio session muted at 0%',
        wheel_test='Synthetic input through real Player Step; no physical mouse automation',
        phone_device_tested=False,mac_native_rebuild=False,ios_requires_resigning=True,
        github_uploaded=False,mega_uploaded=False,
        limits=['Targeted desktop tests, not a full manual campaign or physical phone acceptance.',
            'Windows and later mobile-motion validation have separately identified VM hashes.',
            'Mobile smoothing is source/VM and desktop callback verified, not phone-measured FPS.',
            'Android offline release lint unavailable; signature/resource/alignment checks used.',
            'iOS uses compatible retained runner with fresh VM/resources; requires resigning.'])
    (OUT/'delivery-receipt.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print('Delivery PASS',VERSION,'Windows cases',len(rows),'mobile motion cases',len(mobile_rows))

if __name__=='__main__':main()
