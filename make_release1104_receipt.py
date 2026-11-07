"""Bind16-item same-VM acceptance to fresh Android/iOS packages and source."""
from pathlib import Path
from datetime import datetime,timezone
import hashlib,json,re,sys
from PIL import Image
from release_config import VERSION,BUILD,PACKAGE
from release1104_test_plan import ALL,REQUIRED
import make_release1103_receipt as inherited
from package_gate1104 import verify_packages
ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release1104'
inherited.OUT=OUT

def sha(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()
def read(path):return json.loads(Path(path).read_text('utf8'))

def has_edge(game,caller,callee):
    # GM2.3 child CODE records share their parent's bytecode pointer/length.
    # Their final uint32 is the actual entry offset; parent-wide ranges would
    # incorrectly report calls made only by an adjacent sibling function.
    if not hasattr(game,'hm_ranges1104'):
        entries={};offsets={};table=game.parts[b'CODE'][0]
        for i in range(game.u32(table)):
            record=game.u32(table+4+4*i);name=game.string(game.u32(record))
            base,length=game.codes[name];offset=game.u32(record+16)
            assert 0<=offset<length,(name,offset,length)
            entries[name]=(base,length,offset);offsets.setdefault(base,set()).add(offset)
        game.hm_ranges1104={}
        for name,(base,length,offset) in entries.items():
            # An outer event can resume after an inline function declaration.
            # Retain its complete range; only named child functions use the
            # sibling boundary. This checks references, not a general CFG.
            end=min((value for value in offsets[base] if value>offset),default=length) if offset else length
            game.hm_ranges1104[name]=(base+offset,base+end)
    start,end=game.hm_ranges1104[inherited.code_name(caller)]
    return any(start<=ref<end for ref in game.functions.get(inherited.code_name(callee),{}).get('refs',[]))

def production():
    functions=[]
    for name in ('repairs1104_routes','repairs1104_world','ui1104'):
        functions.extend(re.findall(r'^function (\w+)\(', (ROOT/'native'/f'{name}.gml').read_text('utf8'),re.M))
    functions+=['scrHMBossBarsLocal1104','scrHMBossBarsTop1104']
    pairs=[('gml_Object_IDPDSpawn_Create_0','scrHMThroneSecond1104'),
           ('gml_Object_VanSpawn_Create_0','scrHMThroneSecond1104'),
           ('gml_Object_Portal_Create_0','scrHMThroneSecond1104'),
           ('scrHMThroneTick1103','scrHMThronePoliceClear1104'),
           ('gml_Object_HMWorld_Draw_75','scrHMBossBarsOverlay1104'),
           ('scrHMBossBarsOverlay1104','scrHMBossBarsLocal1104'),
           ('scrHMBossBarsOverlay1104','scrHMBossBarsTop1104'),
           ('scrHMBossBarsLocal1104','scrHMBossWorldBar1104'),
           ('scrHMBossWorldBar1104','hm_hm_bossbar_mod_gml_hm_bossbar'),
           ('scrHMGuardianLayers109','scrHMGuardianLayers1104'),
           ('scrHMGuardianLayers1104','scrHMGuardianLayerRestore1104'),
           ('scrHMGuardianLayers1104','scrHMGuardianLayerLift1104'),
           ('hm_bosses_bossintros_mod_gml_boss_trigger','scrHMExtraPresentation1104'),
           ('hm_bosses_bossintros_mod_gml_boss_death','scrHMExtraPresentation1104'),
           ('hm_bosses_gatorboss_mod_gml_gatorboss_step_resume','scrHMGatorDodgeCandidates1104'),
           ('hm_bosses_gatorboss_mod_gml_gatorboss_step_resume','scrHMGatorFloor1104'),
           ('gml_Object_SuperFrog_Alarm_2','scrHMPoisonShot1104'),
           ('gml_Object_SuperFrog_Destroy_0','scrHMPoisonShot1104'),
           ('gml_Object_Bolt_Collision_Wall','scrHMBoltPin1104'),
           ('hm_maincode_mod_gml_step_resume','hm_arkintide_mod_gml_hm_radiation'),
           ('scrHMRadiationSyncWorld','scrHMRadiationSync'),
           ('scrHMRadiationSync','hm_arkintide_mod_gml_hm_radiation'),
           ('hm_weapons_secretweapon2_wep_gml_weapon_area','scrHMWeaponArea109')]
    return functions,pairs

def verify_code(game,functions,pairs,target):
    for rejected in ('scrHMWaterFlatIndex113','scrHMWaterFlatBegin113','scrHMWaterFlatQuery113'):
        assert inherited.code_name(rejected) not in game.codes,(target,'Rejected slower water optimization',rejected)
    for name in functions+inherited.RETAINED_FUNCTIONS:
        assert inherited.code_name(name) in game.codes,(target,'Missing function',name)
    for caller,callee in pairs:
        assert has_edge(game,caller,callee),(target,'Missing production edge',caller,callee)
    assert 'Hardmode 1.1.4' in game.strings
    assert not has_edge(game,'scrHMThroneTick1103','scrHMThroneOpenWalls1103'),(target,'Retired wall carve remains active')
    assert not has_edge(game,'hm_maincode_mod_gml_step_resume','hm_arkintide_mod_gml_hm_throne_fall')
    for obj in ('WeaponChest','BigWeaponChest'):
        assert not has_edge(game,f'gml_Object_{obj}_Collision_Player','scrHMToolWeapon1100')
    assert not any('gml_Script_hm_hm_grillskills_mod_gml_' in name for name in game.codes)

def main():
    assert (VERSION,BUILD)==('1.1.4',18)
    frozen,desktop=inherited.verify_source()
    rows=[];checks=0
    for scenario in ALL:
        state=OUT/'tests'/scenario.replace(',','-').replace(':','-')
        receipt=read(state/'receipt.json');log=(state/'runner.log').read_text('utf8',errors='replace')
        assert receipt['scenario']==scenario
        assert receipt['vm_sha256']==desktop and receipt['exit']==0,(scenario,'VM/exit')
        assert not any(marker in log for marker in ('HARDMODE GAMEPLAY FAILED','ERROR!!!','FATAL ERROR','Stack Overflow detected!!!'))
        assert receipt.get('status')=='PASS' or (scenario=='native:artwork' and 'status' not in receipt),(scenario,receipt)
        assert receipt.get('checks',0)>0,(scenario,'No actual checks')
        assert receipt['muted_resources']==1250 and receipt['desktop']=='private, never activated'
        if scenario=='native:artwork':
            assert receipt['checks']>=1035
            assert all(max(abs(a-b) for a,b in zip(row['expected'],row['actual']))<=.5
                       for row in receipt['origin_mismatches'])
        checks+=receipt['checks'];rows.append(dict(scenario=scenario,checks=receipt['checks'],receipt_sha256=sha(state/'receipt.json'),
            runner_log_sha256=sha(state/'runner.log'),vm_sha256=desktop))
    functions,pairs=production();inherited.verify_code=verify_code
    game=inherited.Game((ROOT/'build-windows/nuclearthronemobile.win').read_bytes())
    verify_code(game,functions,pairs,'windows')
    artifacts=verify_packages(desktop,functions,pairs,verify_code)
    audits=inherited.verify_platform_audits()
    visuals=[]
    for rate in (30,60):
        for name in ('bossbars114.png','guardian-projectiles114.png'):
            mode='fix114bars' if name.startswith('bossbars') else 'fix114guardian'
            path=OUT/'tests'/f'1-1-0-{rate}-60-7104-{mode}'/name
            # The save root may have a product-relative subfolder.
            files=list(path.parent.rglob(name));assert len(files)==1,(name,files)
            with Image.open(files[0]) as im:
                assert im.format=='PNG' and im.width>=320 and im.height>=180
                size=list(im.size)
            visuals.append(dict(path=files[0].relative_to(OUT).as_posix(),sha256=sha(files[0]),size=size,vm_sha256=desktop))
    review=read(OUT/'visual-review.json')
    assert review['vm_sha256']==desktop and review['status']=='PASS'
    assert {row['sha256'] for row in visuals}==set(review['image_sha256'])
    coverage=read(OUT/'scope-coverage.json')
    assert len(coverage['items'])==16 and {x['item'] for x in coverage['items']}==set(range(1,17))
    for item in coverage['items']:
        assert item['sources'] and item['modes']
        for relative in item['sources']:assert (ROOT/relative).is_file()
        for mode in item['modes']:assert any(mode==case.split(',')[-1] for case in REQUIRED)
    gator_profiles=[]
    for rate in (30,60):
        state=OUT/'tests'/f'1-1-0-{rate}-60-7104-sync114gator'
        reports=re.findall(r'HARDMODE GATOR114 PROFILE (\{[^\r\n]+\})',(state/'runner.log').read_text('utf8',errors='replace'))
        assert len(reports)==1
        profile=json.loads(reports[0])
        assert profile['projectiles']>=1026 and profile['candidates']==1
        assert profile['local_us']>0 and profile['full_us']>0
        gator_profiles.append(dict(rate=rate,host_cpu_only=True,vm_sha256=desktop,**profile))
    report=dict(status='PASS',version=VERSION,build=BUILD,mod='Hardmode b24',
        verified_utc=datetime.now(timezone.utc).isoformat(),installation_packages_generated=True,
        source_manifest_sha256=sha(OUT/'final-source.json'),source_code_archive_sha256=sha(OUT/'final-code.zip'),
        final_desktop_vm_sha256=desktop,original_files_verified=frozen['original_files_verified'],
        user_items=16,gameplay_cases=len(REQUIRED),total_cases=len(ALL),checks=checks,runtime_cases=rows,
        artifacts=artifacts,compiled_repair_functions=functions,production_call_edges=pairs,
        scope_coverage_sha256=sha(OUT/'scope-coverage.json'),visual_evidence=visuals,
        visual_review_sha256=sha(OUT/'visual-review.json'),
        platform_audits=audits,grillskills_imported=False,physical_device_tested=False,
        gator_host_profiles=gator_profiles,
        mac_native_rebuild=False,ios_requires_resigning=True,uploaded=False,
        limits=['Muted isolated desktop VM acceptance, not physical Android/iPhone acceptance.',
                'Gator timings are host CPU observations, not a guarantee of mobile60FPS.'])
    (OUT/'delivery-receipt.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n','utf8')
    print('Final delivery PASS',len(ALL),'scenarios',checks,'assertions')

if __name__=='__main__':main()
