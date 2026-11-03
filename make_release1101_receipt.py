"""Bind 1.1.1 source, targeted real-VM regressions and fresh mobile packages."""
from pathlib import Path
from datetime import datetime,timezone
import hashlib,json,sys,zipfile
from release_config import VERSION,BUILD,PACKAGE
ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release1101'
sys.path.insert(0,str(ROOT.parent))
from patch_followup_compat import Game

REQUIRED=[
 *[f'1,1,0,{rate},90,42,sync111boot' for rate in (30,60)],
 *[f'1,1,{loop},{rate},400,43,sync111van' for loop in (1,3) for rate in (30,60)],
 *[f'sewers,2,3,{rate},400,81,sync111vanmap' for rate in (30,60)],
 *[f'1,1,3,{rate},450,42,sync111camera' for rate in (30,60)],
 *[f'1,1,{loop},{rate},650,42,sync111phase' for loop in (1,3) for rate in (30,60)],
 *[f'1,1,3,{rate},80,42,sync111disabled' for rate in (30,60)],
 *[f'1,1,{loop},60,80,42,sync111roll' for loop in (0,1)],
 '1,1,1,60,150,42,sync111title','1,1,1,60,150,42,sync111titleenglish',
 'sewers,1,3,60,100,42,syncwater','throne,1,3,60,90,43,syncthrone',
 'palace,4,0,60,400,42,vault110','cavesinv,3,0,60,180,42,cave112',
 '1,1,0,30,180,42,motion112','1,1,0,60,180,42,motion112',
 'venuz,10,0,60,240,42,retry107',
 '1,1,1,60,400,44,sync111van','1,1,1,60,400,45,sync111van',
]
NATIVE=['compiler','runtime','actors','modules','world','artwork']

def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def read(path):return json.loads(path.read_text('utf8'))

def main():
    assert (VERSION,BUILD)==('1.1.1',15)
    frozen=read(OUT/'final-source.json');digest=sha(ROOT/'build-windows/nuclearthronemobile.win')
    assert frozen['desktop_vm_sha256']==digest and frozen['original_files_verified']==7231
    for group in ('project_files','development_sources'):
        for path,value in frozen[group].items():assert sha(ROOT/path)==value,path
    rows=[]
    for scenario in REQUIRED+[f'native:{k}' for k in NATIVE]+['menu:30','menu:60']:
        path=OUT/'tests'/scenario.replace(',','-').replace(':','-')/'receipt.json'
        row=read(path)
        assert row['vm_sha256']==digest and row['exit']==0,(scenario,row)
        if scenario=='native:artwork':
            assert row['checks']>=1035
            assert all(max(abs(a-b) for a,b in zip(v['expected'],v['actual']))<=.5 for v in row['origin_mismatches'])
        else:assert row['status']=='PASS',(scenario,row)
        assert row['muted_resources']==1250 and row['desktop']=='private, never activated'
        rows.append(dict(scenario=scenario,checks=row['checks'],receipt_sha256=sha(path)))
    functions=['scrHMLevelCap1101','scrHMVanBodyHurt1101','scrHMBossCamera1101',
        'scrHMBossCameraTick1101','scrHMBossTitleLayout1101','scrHMBossTitle1101']
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
        # The native van delegate must call the new non-recursive hurt bridge.
        start,length=game.codes['gml_Script_hm_arkintide_mod_gml_hm_van_body_hurt']
        assert any(start<=ref<start+length for ref in game.functions['gml_Script_scrHMVanBodyHurt1101']['refs'])
        assert 'Hardmode 1.1.1' in game.strings
        artifacts.append(dict(path=path.relative_to(ROOT).as_posix(),bytes=path.stat().st_size,sha256=sha(path),
            validation_sha256=sha(path.with_suffix('.validation.json')),prepared_vm_sha256=prep['prepared_vm_sha256']))
    old=read(ROOT/'deliverables/NuclearThrone.Hardmode-Android-1.1.0.validation.json')
    new=read(ROOT/'deliverables/NuclearThrone.Hardmode-Android-1.1.1.validation.json')
    assert old['certificate_sha256']==new['certificate_sha256']
    storage=read(OUT/'mobile-storage-audit.json');pacing=read(OUT/'android-pacing.json')
    assert storage['android_shared_storage_permission_packaged'] and storage['ios_documents_sharing_enabled']
    assert storage['android_monotonic_pacer_dex_call_before_native_process']
    assert pacing['status']=='PASS' and pacing['checks']==12
    assert read(OUT/'ios-native-compatibility.json')['compatible_added_functions_and_extensions']
    startup=OUT/'prechecks/native-startup-before-gameplay'
    incident=read(startup/'receipt.json');incident_log=(startup/'runner.log').read_text('utf8',errors='replace')
    assert incident['exit']==3221225477 and 'HARDMODE GAMEPLAY GENERATED' not in incident_log
    assert 'Entering main loop.' in incident_log and 'Stack Overflow detected!!!' not in incident_log
    observation=dict(exit=incident['exit'],phase='native Windows runner exited before the level-generated marker',
        receipt_sha256=sha(startup/'receipt.json'),log_sha256=sha(startup/'runner.log'),
        identical_final_vm_sha256=digest,repeated_arrival_cases=[r for r in rows if r['scenario'] in
            [f'1,1,1,60,400,{seed},sync111van' for seed in (43,44,45)]],
        cause='Not determined; preserved separately from the fixed gameplay damage recursion.')
    assert len(observation['repeated_arrival_cases'])==3
    report=dict(status='PASS',version=VERSION,build=BUILD,mod='Hardmode b24',
        verified_utc=datetime.now(timezone.utc).isoformat(),installation_packages_generated=True,
        source_manifest_sha256=sha(OUT/'final-source.json'),source_code_archive_sha256=sha(OUT/'final-code.zip'),
        final_desktop_vm_sha256=digest,original_files_verified=7231,grillskills_imported=False,
        gameplay_cases=len(REQUIRED),gameplay_assertions=sum(r['checks'] for r in rows[:len(REQUIRED)]),
        runtime_cases=rows,artifacts=artifacts,compiled_repair_functions=functions,
        native_runner_startup_observation=observation,
        test_audio='1250 sound-resource gains zeroed in a separate test VM; master/session muted at 0%',
        foreground_window_control_used=False,phone_device_tested=False,mac_native_rebuild=False,
        ios_requires_resigning=True,github_uploaded=False,mega_uploaded=False,
        limits=['Targeted compiled desktop VM tests, not physical phone or exhaustive campaign acceptance.',
            'No new performance guarantee or high-loop FPS claim is made for this maintenance release.',
            'Android offline release lint unavailable; signature/resource/alignment checks used.',
            'iOS uses a compatible retained runner with fresh VM/resources and requires resigning.'])
    (OUT/'delivery-receipt.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n','utf8')
    print('Delivery PASS:',VERSION,'gameplay cases',len(REQUIRED),'total VM scenarios',len(rows))

if __name__=='__main__':main()
