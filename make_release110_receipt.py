"""Verify this release without reusing old-version test counts."""
from pathlib import Path
from datetime import datetime,timezone
import hashlib,json,sys,zipfile
from release_config import VERSION,BUILD,PACKAGE,DIRECTORY
from run_release110_checks import KINDS,SCENARIOS

ROOT=Path(__file__).resolve().parent
OUT=ROOT/DIRECTORY
sys.path.insert(0,str(ROOT.parent))
from patch_followup_compat import Game
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def read(p):return json.loads((ROOT/p).read_text(encoding='utf8'))

def main():
    assert (VERSION,BUILD)==('1.0.10',11)
    final=read(OUT/'final-source.json');digest=sha(ROOT/'build-windows/nuclearthronemobile.win')
    assert final['desktop_vm_sha256']==digest and final['original_files_verified']==7231
    for section in ('project_files','development_sources'):
        for p,h in final[section].items():assert sha(ROOT/p)==h,p
    previous=read('release109/final-source.json')['project_files']
    changed=[p for p,h in final['project_files'].items() if previous.get(p)!=h]
    assert not [p for p in changed if Path(p).suffix.lower() in {'.png','.jpg','.ogg','.wav','.ttf','.otf'}]
    rows=read(OUT/'gameplay-regression.json');assert [r['scenario'] for r in rows]==SCENARIOS
    assert all(r['status']=='PASS' and r['vm_sha256']==digest for r in rows)
    native=[read(OUT/f'{k}-native-receipt.json') for k in KINDS]
    assert all(r.get('vm_sha256',r.get('compiled_vm_sha256'))==digest for r in native)
    assert all(k=='artwork' or r['status']=='PASS' for k,r in zip(KINDS,native))
    menus=[read(OUT/f'menu-{rate}-receipt.json') for rate in (30,60)]
    assert all(r['status']=='PASS' and r['vm_sha256']==digest for r in menus)
    localization=read(OUT/'localization-audit.json');assert not localization['untranslated_literals']
    visual=read(OUT/'visual-review.json');assert visual['reviewed'] and visual['vm_sha256']==digest
    maps=read(OUT/'map-expansion.json');assert maps['status']=='PASS' and maps['vm_sha256']==digest
    functions=['scrHMLoopBossCount110','scrHMLoopMapEligible110','scrHMLoopMapSetup110',
        'scrHMWallColour110','scrHMThroneSeed110','scrHMThroneEntrance110','scrDesktopWheelSwap']
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
        prepared=ROOT/f'platforms/{target}/prepared-assets/{vm}'
        assert sha(prepared)==prep['prepared_vm_sha256']
        game=Game(prepared.read_bytes())
        for fn in functions:assert 'gml_Script_'+fn in game.codes,(target,fn)
        assert 'Hardmode 1.0.10' in game.strings
        count=game.functions['gml_Script_scrHMLoopBossCount110']['refs']
        for fn in ('scrHMLilHunterGroup109','scrHMGatorGroup109','scrHMRavenGroup109'):
            start,length=game.codes['gml_Script_'+fn]
            assert any(start<=pos<start+length for pos in count),(target,fn)
        artifacts.append(dict(path=p.relative_to(ROOT).as_posix(),bytes=p.stat().st_size,
            sha256=sha(p),validation_sha256=sha(p.with_suffix('.validation.json')),
            prepared_vm_sha256=prep['prepared_vm_sha256']))
    old=read('deliverables/NuclearThrone.Hardmode-Android-1.0.9.validation.json')
    new=read('deliverables/NuclearThrone.Hardmode-Android-1.0.10.validation.json')
    assert old['certificate_sha256']==new['certificate_sha256']
    storage=read(OUT/'mobile-storage-audit.json')
    assert storage['android_shared_storage_permission_packaged'] and storage['ios_documents_sharing_enabled']
    assert storage['android_monotonic_pacer_dex_call_before_native_process']
    pacing=read(OUT/'android-pacing.json');assert pacing['status']=='PASS' and pacing['checks']==12
    compatibility=read(OUT/'ios-native-compatibility.json')
    assert compatibility['compatible_added_functions_and_extensions']
    report=dict(status='PASS',version=VERSION,build=BUILD,mod='Hardmode b24',
        verified_utc=datetime.now(timezone.utc).isoformat(),installation_packages_generated=True,
        source_manifest_sha256=sha(OUT/'final-source.json'),source_code_archive_sha256=sha(OUT/'final-code.zip'),
        final_desktop_vm_sha256=digest,original_files_verified=7231,changed_project_files=changed,
        media_changed=False,gameplay_cases=len(rows),gameplay_assertions=sum(r['checks'] for r in rows),
        native_assertions=sum(r['checks'] for r in native),menu_assertions=sum(r['checks'] for r in menus),
        artifacts=artifacts,compiled_repair_functions=functions,
        test_audio='Muted: game master gain zero, Windows audio session 0% and Mute',
        wheel_test='Synthetic wheel samples through real Player Step at 30/60 FPS; no physical mouse automation',
        phone_device_tested=False,mac_native_rebuild=False,ios_requires_resigning=True,
        github_uploaded=False,mega_uploaded=False,
        limits=['Targeted automated desktop regression, not a full manual campaign or phone acceptance test.',
                'Loop map growth is a bounded Hardmode adaptation, not a claim that Epsilon uses this exact formula.',
                'Android offline release lint unavailable; explicit signature/resource/alignment checks passed.',
                'iOS retains a compatible native runner with fresh VM/resources and requires resigning.'])
    (OUT/'delivery-receipt.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print('Delivery PASS',VERSION,'gameplay',len(rows),'assertions',report['gameplay_assertions'])
if __name__=='__main__':main()
