"""Bind final 1.1.2 source, real host VM scenarios and both fresh mobile packages."""
from pathlib import Path
from datetime import datetime,timezone
import hashlib,json,sys,zipfile
from release_config import VERSION,BUILD,PACKAGE
from release1102_test_plan import ALL,REQUIRED
ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release1102'
sys.path.insert(0,str(ROOT.parent))
from patch_followup_compat import Game

def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def read(path):return json.loads(path.read_text('utf8'))

def main():
    assert (VERSION,BUILD)==('1.1.2',16)
    frozen=read(OUT/'final-source.json');digest=sha(ROOT/'build-windows/nuclearthronemobile.win')
    assert frozen['desktop_vm_sha256']==digest and frozen['original_files_verified']==7231
    for group in ('project_files','development_sources'):
        for path,value in frozen[group].items():assert sha(ROOT/path)==value,path
    rows=[]
    for scenario in ALL:
        path=OUT/'tests'/scenario.replace(',','-').replace(':','-')/'receipt.json'
        row=read(path)
        assert row['vm_sha256']==digest and row['exit']==0,(scenario,row)
        if scenario=='native:artwork':
            assert row['checks']>=1035
            assert all(max(abs(a-b) for a,b in zip(v['expected'],v['actual']))<=.5 for v in row['origin_mismatches'])
        else:assert row['status']=='PASS',(scenario,row)
        assert row['muted_resources']==1250 and row['desktop']=='private, never activated'
        rows.append(dict(scenario=scenario,checks=row['checks'],receipt_sha256=sha(path)))
    functions=['scrHMWaterBatchBegin1102','scrHMWaterExact1102','scrHMWaterBatchEnd1102',
        'scrHMIDPDPortalSprite1102','scrHMElevatorStep1102','scrHMReplacementArea1102',
        'scrHMReplacementTick1102','scrHMChiefCreate1102','scrHMChiefStep1102',
        'scrHMChiefDeath1102','scrHMChiefDepartureDraw1102','scrHMChiefBallBurst1102']
    delegates={
        'hm_arkintide_mod_gml_hm_elevator_step':'scrHMElevatorStep1102',
        'hm_props_mod_gml_elevator_step':'scrHMElevatorStep1102',
        'hm_arkintide_mod_gml_hm_gungod_replace_tick':'scrHMReplacementTick1102',
        'hm_arkintide_mod_gml_hm_idpd_portal_sprite':'scrHMIDPDPortalSprite1102',
        'scrHMWaterExact109':'scrHMWaterExact1102',
    }
    artifacts=[]
    for target,label,ext in [('android','Android','apk'),('ios','iOS','ipa')]:
        path=ROOT/f'deliverables/NuclearThrone.Hardmode-{label}-{VERSION}.{ext}'
        validation=read(path.with_suffix('.validation.json'))
        assert (validation['package'],validation['version'],validation['build'])==(PACKAGE,VERSION,BUILD)
        assert validation[ext+'_sha256']==sha(path)
        prep=read(ROOT/f'platforms/{target}/prepared-receipt.json')
        assert prep['timing_code']=='gml_Object_MakeGame_Create_0'
        assert prep['timing_method']==(1 if target=='ios' else 0)
        vm='game.droid' if target=='android' else 'game.ios'
        with zipfile.ZipFile(ROOT/f'build-{target}/nuclearthronemobile.zip') as z:
            assert hashlib.sha256(z.read('assets/'+vm)).hexdigest()==prep['raw_vm_sha256']
        prepared=ROOT/f'platforms/{target}/prepared-assets/{vm}'
        assert sha(prepared)==prep['prepared_vm_sha256']
        game=Game(prepared.read_bytes())
        for fn in functions:assert 'gml_Script_'+fn in game.codes,(target,fn)
        for caller,callee in delegates.items():
            start,length=game.codes['gml_Script_'+caller]
            assert any(start<=ref<start+length for ref in game.functions['gml_Script_'+callee]['refs']),(target,caller,callee)
        for caller,callee in [('gml_Object_Last_Destroy_0','scrHMChiefDeath1102'),
                              ('gml_Object_Last_Step_0','scrHMChiefStep1102'),
                              ('gml_Object_LastBall_Destroy_0','scrHMChiefBallBurst1102')]:
            start,length=game.codes[caller]
            assert any(start<=ref<start+length for ref in game.functions['gml_Script_'+callee]['refs']),(target,caller)
        assert 'Hardmode 1.1.2' in game.strings
        artifacts.append(dict(path=path.relative_to(ROOT).as_posix(),bytes=path.stat().st_size,sha256=sha(path),
            validation_sha256=sha(path.with_suffix('.validation.json')),prepared_vm_sha256=prep['prepared_vm_sha256']))
    old=read(ROOT/'deliverables/NuclearThrone.Hardmode-Android-1.1.1.validation.json')
    new=read(ROOT/'deliverables/NuclearThrone.Hardmode-Android-1.1.2.validation.json')
    assert old['certificate_sha256']==new['certificate_sha256']
    storage=read(OUT/'mobile-storage-audit.json');pacing=read(OUT/'android-pacing.json')
    assert storage['android_shared_storage_permission_packaged'] and storage['ios_documents_sharing_enabled']
    assert storage['android_monotonic_pacer_dex_call_before_native_process']
    assert pacing['status']=='PASS' and pacing['checks']==12
    assert read(OUT/'ios-native-compatibility.json')['compatible_added_functions_and_extensions']
    # These are delta checks; no previous native NTT FPS result is reused.
    sync=read(OUT/'sync-plan.json')
    assert len(sync['native_production_sha256'])==66
    report=dict(status='PASS',version=VERSION,build=BUILD,mod='Hardmode b24',
        verified_utc=datetime.now(timezone.utc).isoformat(),installation_packages_generated=True,
        source_manifest_sha256=sha(OUT/'final-source.json'),source_code_archive_sha256=sha(OUT/'final-code.zip'),
        final_desktop_vm_sha256=digest,original_files_verified=7231,grillskills_imported=False,
        gameplay_cases=len(REQUIRED),gameplay_assertions=sum(r['checks'] for r in rows[:len(REQUIRED)]),
        runtime_cases=rows,artifacts=artifacts,compiled_repair_functions=functions,
        replacement_policy=dict(min_loop=1,chief_probability=.05,venus_probability=.05,
            mutually_exclusive=True,excluded=['throne','venuz','native Y.V crib','existing palace/HQ/end exclusions']),
        source_sync_plan_sha256=sha(OUT/'sync-plan.json'),
        test_audio='1250 sound-resource gains zeroed in a separate test VM; master/session muted at 0%',
        foreground_window_control_used=False,phone_device_tested=False,mac_native_rebuild=False,
        ios_requires_resigning=True,github_uploaded=False,mega_uploaded=False,
        limits=['Targeted compiled desktop host VM tests, not physical phone or exhaustive campaign acceptance.',
            'No phone performance measurement or universal high-loop FPS claim is made.',
            'Android offline release lint unavailable; signature/resource/alignment checks used.',
            'iOS uses a compatible retained runner with fresh VM/resources and requires resigning.'])
    (OUT/'delivery-receipt.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n','utf8')
    print('Delivery PASS:',VERSION,'gameplay cases',len(REQUIRED),'total VM scenarios',len(rows))

if __name__=='__main__':main()
