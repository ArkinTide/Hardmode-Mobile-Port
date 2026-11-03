"""Bind final 1.1.0 source, real-VM regressions and mobile packages."""
from pathlib import Path
from datetime import datetime,timezone
import hashlib,json,re,sys,zipfile
from release_config import VERSION,BUILD,PACKAGE
ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release1100'
sys.path.insert(0,str(ROOT.parent))
from patch_followup_compat import Game

REQUIRED=[
 '1,1,0,60,90,42,syncpolicy','1,1,0,60,90,42,syncsettings',
 'sewers,1,3,60,100,42,syncwater','throne,1,0,60,90,42,syncthrone',
 'throne,1,3,60,90,43,syncthrone','palace,4,0,60,400,42,vault110',
 'sewers,2,3,60,80,81,waterbank112','cavesinv,3,0,60,180,42,cave112',
 *['1,1,3,60,360,42,syncextra-'+k for k in ['bandit','junglebandit','bubble','hunter','tech','mom','dog','gator','turtle','rogue']],
 '1,1,3,60,500,42,syncextra-bird',
 *['caves,1,3,60,360,42,syncextra-'+k for k in ['crystal','cursedcrystal']],
 'sewers,1,3,60,360,42,syncextra-rat','1,1,3,60,600,42,syncgungod',
 '1,1,3,60,180,42,syncwarning','1,1,3,60,60,42,syncportal',
 '1,1,0,60,180,42,motion112','1,1,0,30,180,42,motion112',
 'venuz,1,0,60,10000,42,venus106',
 *[f'venuz,{stage},0,60,240,42,retry107' for stage in (1,10,100,401)],
 '3,1,0,60,400,42,route103','HQ,1,3,60,120,42,hq',
 '1,1,3,60,90,42,venusdrop111','city,3,0,60,1150,42,titank109',
 'sewers,1,3,60,80,81,walls110',
]
NATIVE=['compiler','runtime','actors','modules','world','artwork']

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def read(p):return json.loads(Path(p).read_text('utf8'))
def case(s):return OUT/'tests'/s.replace(',','-').replace(':','-')

def main():
    assert (VERSION,BUILD)==('1.1.0',14)
    final=read(OUT/'final-source.json');digest=sha(ROOT/'build-windows/nuclearthronemobile.win')
    assert final['desktop_vm_sha256']==digest and final['original_files_verified']==7231
    for section in ('project_files','development_sources'):
        for p,h in final[section].items():assert sha(ROOT/p)==h,p
    migration=read(OUT/'migration-ledger.json');assert migration['status']=='PASS'
    assert migration['counts']=={'IMPORTED':509,'UNLOADED_UPSTREAM_FILE':25,'MOBILE_EQUIVALENT':8,'EXCLUDED_PER_USER':1}
    rows=[]
    for scenario in REQUIRED+[f'native:{k}' for k in NATIVE]+['menu:30','menu:60']:
        row=read(case(scenario)/'receipt.json')
        assert row['vm_sha256']==digest and row['exit']==0,(scenario,row)
        if scenario=='native:artwork':
            assert row['checks']>=1035
            assert all(max(abs(a-b) for a,b in zip(v['expected'],v['actual']))<=.5 for v in row['origin_mismatches'])
        else:assert row['status']=='PASS',(scenario,row)
        assert row['muted_resources']>=1250 and row['desktop']=='private, never activated'
        log=(case(scenario)/'runner.log').read_text('utf8',errors='replace')
        assert 'HARDMODE GAMEPLAY FAILED' not in log
        if scenario=='venuz,1,0,60,10000,42,venus106':
            assert 'HARDMODE VENUS106 COMPLETE' in log,'Full Venus campaign did not finish'
        rows.append(dict(scenario=scenario,checks=row['checks'],receipt_sha256=sha(case(scenario)/'receipt.json')))
    performance=[]
    for path in sorted((OUT/'tests').glob('*perf111/runner.log')):
        receipt=read(path.parent/'receipt.json')
        if receipt['vm_sha256']!=digest:continue
        text=path.read_text('utf8',errors='replace');m=re.search(r'HARDMODE PERF111 (\{[^\r\n]+\})',text)
        if m:performance.append(dict(scenario=receipt['scenario'],target_met=receipt.get('status')=='PASS',**json.loads(m[1])))
    # Performance observations do not become a universal phone-FPS guarantee.
    assert performance
    functions=['scrHMLevelCap1100','scrHMPortalStyle1100','scrHMLoopPopulationFallback1100',
        'scrHMThroneGeneratorZone1100','scrHMRatWaterDraw1100','scrHMPickupDrop1100',
        'hm_arkintide_mod_gml_hm_extra_spawn','hm_arkintide_mod_gml_hm_extra_water_prepare',
        'hm_arkintide_mod_gml_hm_progression','hm_hm_bossbar_mod_gml_draw_gui',
        'scrHMBindingOffset112','scrHMSwimSupported112']
    artifacts=[]
    for target,label,ext in [('android','Android','apk'),('ios','iOS','ipa')]:
        p=ROOT/f'deliverables/NuclearThrone.Hardmode-{label}-{VERSION}.{ext}'
        validation=read(p.with_suffix('.validation.json'))
        assert (validation['package'],validation['version'],validation['build'])==(PACKAGE,VERSION,BUILD)
        assert validation[ext+'_sha256']==sha(p)
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
        assert 'Hardmode 1.1.0' in game.strings
        artifacts.append(dict(path=p.relative_to(ROOT).as_posix(),bytes=p.stat().st_size,sha256=sha(p),
            validation_sha256=sha(p.with_suffix('.validation.json')),prepared_vm_sha256=prep['prepared_vm_sha256']))
    assert read(ROOT/'deliverables/NuclearThrone.Hardmode-Android-1.0.12.validation.json')['certificate_sha256']==read(ROOT/'deliverables/NuclearThrone.Hardmode-Android-1.1.0.validation.json')['certificate_sha256']
    storage=read(OUT/'mobile-storage-audit.json');pacing=read(OUT/'android-pacing.json')
    assert storage['android_shared_storage_permission_packaged'] and storage['ios_documents_sharing_enabled']
    assert storage['android_monotonic_pacer_dex_call_before_native_process']
    assert pacing['status']=='PASS' and pacing['checks']==12
    assert read(OUT/'ios-native-compatibility.json')['compatible_added_functions_and_extensions']
    report=dict(status='PASS',version=VERSION,build=BUILD,mod='Hardmode b24',
        verified_utc=datetime.now(timezone.utc).isoformat(),installation_packages_generated=True,
        source_manifest_sha256=sha(OUT/'final-source.json'),source_code_archive_sha256=sha(OUT/'final-code.zip'),
        final_desktop_vm_sha256=digest,original_files_verified=7231,migration_counts=migration['counts'],
        migration_ledger_sha256=sha(OUT/'migration-ledger.json'),grillskills_imported=False,
        gameplay_cases=len(REQUIRED),gameplay_assertions=sum(r['checks'] for r in rows[:len(REQUIRED)]),
        runtime_cases=rows,artifacts=artifacts,compiled_sync_functions=functions,
        performance_observations=performance,test_audio='1250 sound-resource gains zeroed in a separate test VM; master/session muted at 0%',
        foreground_window_control_used=False,phone_device_tested=False,mac_native_rebuild=False,
        ios_requires_resigning=True,github_uploaded=False,mega_uploaded=False,
        limits=['Targeted compiled desktop tests, not physical phone or exhaustive manual campaign acceptance.',
            'Historical transformation count records implementation coverage, not one runtime test per transformation.',
            'High-loop stress observations are reported separately; not all stress scenes meet 60 FPS.',
            'Android offline release lint unavailable; signature/resource/alignment checks used.',
            'iOS uses a compatible retained runner with fresh VM/resources and requires resigning.'])
    (OUT/'delivery-receipt.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n','utf8')
    print('Delivery PASS:',VERSION,'gameplay cases',len(REQUIRED),'all required VM checks',len(rows))

if __name__=='__main__':main()
