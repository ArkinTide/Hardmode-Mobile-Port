"""Strict final-source, same-VM and actual-package gate for1.1.5/build19.

Read-only until every assertion succeeds, then writes a delivery receipt.
It never builds, launches a VM, freezes source, changes packages or uploads.
"""
from pathlib import Path
from datetime import datetime,timezone
import hashlib
import importlib
import json
import re

from PIL import Image
from release_config import VERSION,BUILD,PACKAGE
import make_release1103_receipt as inherited
import make_release1104_receipt as previous
import package_gate1105 as package_gate
import audit_performance1105

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release1105'
inherited.OUT=OUT
package_gate.OUT=OUT

def sha(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()
def read(path):return json.loads(Path(path).read_text('utf-8'))
has_edge=previous.has_edge

def functions_from(relative):
    text=(ROOT/relative).read_text('utf-8-sig')
    return [name for name in re.findall(r'^function (\w+)\(',text,re.M)
            if not name.startswith('scrHMGameplay')]

def production():
    functions,pairs=previous.production()
    for script in ('scrHMRepairs1102','scrHMRepairs1115Root','scrHMRepairs109',
                   'scrHMSync1103Bosses','scrHMSync1103Ultra','scrHMSync1103Performance',
                   'scrHMSync1103Spawn','scrHMRepairs1104Routes'):
        functions.extend(functions_from(f'project/scripts/{script}/{script}.gml'))
    pairs+= [
        ('gml_Object_Last_Step_0','scrHMChiefStep1102'),
        ('gml_Object_Last_Step_0','scrHMChiefSpeed1115'),
        ('gml_Object_Last_Step_0','scrHMChiefAction1115'),
        ('gml_Object_Last_Alarm_4','scrHMChiefSpeed1115'),
        ('gml_Object_Last_Alarm_5','scrHMChiefSummon1115'),
        ('scrHMChiefAction1115','scrHMChiefSpeed1115'),
        ('scrHMChiefAction1115','scrHMChiefAlarm1115'),
        ('scrHMChiefSummon1115','scrHMChiefAlarm1115'),
        ('scrHMReplacementTick1102','scrHMChiefCreate1102'),
        ('scrHMReplacementTick1102','scrHMBossGroupRetire115'),
        ('scrHMReplacementTick1102','scrHMReplacementGunGodHealth1115'),
        ('scrHMChiefDeath1102','scrHMFinalBossSupplies1115'),
        ('hm_arkintide_mod_gml_hm_yv_phase_loot','scrHMFinalBossSupplies1115'),
        ('hm_enemies_mod_gml_yv_dead','scrHMFinalBossSupplies1115'),
        ('scrRadDrop','scrHMFinalBossNoRadiation1115'),
        ('gml_Object_IDPDSpawn_Alarm_1','scrHMPoliceGroup1115'),
        ('gml_Object_Player_Step_2','scrHMThronePlayerGround1115'),
        ('gml_Object_GenCont_Create_0','scrHMRoomWaterState1105'),
        ('scrHMWorldStep','scrHMRoomWaterState1105'),
        ('scrHMRoomWaterState1105','scrHMSwimLeave'),
        ('scrHMWaterAt','scrHMWaterExact109'),
        ('scrHMWaterExact109','scrHMWaterExact1102'),
        ('scrHMWaterMap','scrHMWaterRects109'),
        ('scrHMSewerTick1103','scrHMWaterBatchBegin1102'),
        ('scrHMSewerTick1103','scrHMWaterPotential1103'),
        ('scrHMSewerTick1103','scrHMWaterPossible1103'),
        ('scrHMSewerTick1103','scrHMSwimSupported112'),
        ('scrHMSewerTick1103','scrHMWaterBatchEnd1102'),
        ('scrHMSewerTick1103','scrHMSewerBindDraw1115'),
        ('scrHMSewerBindDraw1115','scrHMBindDraw'),
        ('hm_maincode_mod_gml_step_resume','scrHMOasisBubble1105'),
        ('hm_enemies_mod_gml_EliteSpiderShield_step','scrHMShieldProjectiles1105'),
        ('hm_enemies_mod_gml_bigshield_step','scrHMShieldProjectiles1105'),
        ('hm_enemies_mod_gml_customshield_step','scrHMShieldProjectiles1105'),
        ('hm_arkintide_mod_gml_hm_extra_event','scrHMExtraCrystalNative1115'),
        ('hm_arkintide_mod_gml_hm_extra_step','scrHMExtraCrystalTick1115'),
        ('gml_Object_JockRocket_Destroy_0','scrHMExplosionSource1115'),
        ('gml_Object_Explosion_Alarm_1','scrHMExplosionSource1115'),
        ('scr_hit','scrHMSelfRocketImmune1115'),
        ('scr_projectile_hit','scrHMSelfRocketImmune1115'),
        ('scr_can_hit','scrHMSelfRocketImmune1115'),
        ('hm_arkintide_mod_gml_hm_hunter_pending','scrHMLilHunterPending109'),
        ('hm_arkintide_mod_gml_hm_hunter_wait','scrHMLilHunterWait109'),
        ('hm_arkintide_mod_gml_hm_native_step','scrHMLilHunterReconcile115'),
        ('scrHMLilHunterGroup109','scrHMBossGroupReserve115'),
        ('scrHMLilHunterGroup109','scrHMBossGroupRegister115'),
        ('hm_bosses_bossintros_mod_gml_boss_trigger','scrHMBossGroupPresentation115'),
        ('scrHMWorldStep','scrHMBossGroupTick115'),
        ('scrHMBossGroupTick115','scrHMBossGroupPending115'),
        ('scrHMBossGroupTick115','scrHMBossGroupAlive115'),
        ('scrHMBossRestore104','scrHMBossPresentationEnd115'),
        ('scr_hit','scrHMBossPresentationProtected115'),
        ('scrBossIntro','scrHMBossPresentationNative115'),
        ('gml_Object_UberCont_Alarm_2','scrHMBossPresentationNative115'),
        ('gml_Object_WantRevivePopoFreak_Alarm_0','scrHMMessengerReviveTimer115'),
        ('gml_Object_RevivePopoFreak_Alarm_0','scrHMMessengerReviveEffect115'),
        ('gml_Object_enemy_Destroy_0','scrHMMessengerNativeCorpse115'),
        ('scrHMMessengerCorpse1103','scrHMMessengerAutoCorpse115'),
        ('scrHMMessengerNativeCorpse115','scrHMMessengerAutoCorpse115'),
        ('scrHMMessengerReviveEffect115','hm_enemies_mod_gml_enemyrogue_create'),
        ('scrHMMessengerReviveEffect115','scrHMDeathExit'),
        ('scrHMPendingBoss','scrHMMessengerReviving115'),
    ]
    pairs.extend((f'gml_Object_Last_Alarm_{i}','scrHMChiefAlarm1115') for i in range(1,8))
    return sorted(set(functions)),list(dict.fromkeys(pairs))

def verify_code(game,functions,pairs,target):
    for rejected in ('scrHMWaterFlatIndex113','scrHMWaterFlatBegin113','scrHMWaterFlatQuery113',
                     'scrHMWaterIndex1105','scrHMWaterShapes1105','scrHMWaterShapeQuery1105'):
        assert inherited.code_name(rejected) not in game.codes,(target,'Rejected old water candidate',rejected)
    for name in functions+inherited.RETAINED_FUNCTIONS:
        assert inherited.code_name(name) in game.codes,(target,'Missing compiled function',name)
    for caller,callee in pairs:
        assert has_edge(game,caller,callee),(target,'Missing function-level production edge',caller,callee)
    assert 'Hardmode 1.1.5' in game.strings,(target,'Wrong compiled version')
    assert not has_edge(game,'scrHMThroneTick1103','scrHMThroneOpenWalls1103'),(target,'Retired Throne wall carve active')
    assert not has_edge(game,'hm_maincode_mod_gml_step_resume','hm_arkintide_mod_gml_hm_throne_fall')
    for obj in ('WeaponChest','BigWeaponChest'):
        assert not has_edge(game,f'gml_Object_{obj}_Collision_Player','scrHMToolWeapon1100')
    assert not any('gml_Script_hm_hm_grillskills_mod_gml_' in name for name in game.codes)
    for title in ('核能王座','王座II','通信员','至高守护者','玩家增强','生命上限+2','等级上限+1'):
        # Dynamic localization can retain one packed JSON string. Accept it
        # there as well as a dedicated VM string, never only in loose source.
        assert any(title in string for string in game.strings),(target,'Missing packaged Chinese text',title)

def verify_plan_and_runtime(plan,desktop):
    assert plan.ALL and len(plan.ALL)==len(set(plan.ALL))
    assert set(plan.REQUIRED)<=set(plan.ALL)
    stored=read(OUT/'test-plan.json')
    for key,values in [('required',plan.REQUIRED),('regressions',plan.REGRESSIONS),('native',plan.NATIVE),('all',plan.ALL)]:
        assert stored[key]==values,('Stale test-plan snapshot',key)
    rows=[];checks=0
    for scenario in plan.ALL:
        folder=OUT/'tests'/scenario.replace(',','-').replace(':','-')
        receipt_path=folder/'receipt.json';log_path=folder/'runner.log'
        row=read(receipt_path);log=log_path.read_text('utf-8',errors='replace')
        assert row['scenario']==scenario and row['vm_sha256']==desktop and row['exit']==0,(scenario,'Wrong VM/exit')
        assert not any(marker in log for marker in ('HARDMODE GAMEPLAY FAILED','ERROR!!!','FATAL ERROR','Stack Overflow detected!!!')),(scenario,'Runner error')
        assert row.get('status')=='PASS' or (scenario=='native:artwork' and 'status' not in row),(scenario,row)
        assert row.get('checks',0)>0,(scenario,'No actual assertions')
        if scenario.count(',')>=6:
            fields=scenario.split(',');mode=fields[6]
            minimum={'yv1115minigun':100,'chief1115first':200,'chief1115repeat':200,'group115replace':2,
                     'group115hunter':10,'group115bubbler':10,'group115crystal':10}.get(mode,1)
            if mode in ('messenger115short','messenger115natural'):
                minimum=18 if int(fields[2])>=3 else 2
            assert row['checks']>=minimum,(scenario,'Required lifecycle assertions were skipped',row['checks'],minimum)
        assert row['muted_resources']==1250 and row['desktop']=='private, never activated'
        assert row.get('physical_device_tested',False) is False
        if scenario=='native:artwork':
            assert row['checks']>=1035
            assert all(max(abs(a-b) for a,b in zip(item['expected'],item['actual']))<=.5
                       for item in row['origin_mismatches'])
        checks+=row['checks']
        rows.append(dict(scenario=scenario,checks=row['checks'],receipt_sha256=sha(receipt_path),
                         runner_log_sha256=sha(log_path),vm_sha256=desktop))
    return rows,checks


def verify_build_source(frozen,desktop):
    path=OUT/'desktop-build-source.json';build=read(path)
    assert (build['status'],build['version'],build['build'],build['target'])==('PASS',VERSION,BUILD,'windows-host-VM')
    assert build['unchanged_project_during_build'] and build['exit']==0
    assert build['desktop_vm_sha256']==desktop
    assert build['project_files']==frozen['project_files'],'Frozen project differs from the actual compiler inputs'
    assert build['build_script_sha256']==sha(ROOT/'build_local.ps1')
    assert build['build_log_sha256']==sha(ROOT/'build-windows.log')
    assert datetime.fromisoformat(build['started_utc'])<=datetime.fromisoformat(build['finished_utc'])<=datetime.fromisoformat(frozen['recorded_utc'])
    return dict(path=path.relative_to(ROOT).as_posix(),sha256=sha(path),
                project_files=len(build['project_files']),desktop_vm_sha256=desktop,
                started_utc=build['started_utc'],finished_utc=build['finished_utc'])

def verify_scope(plan):
    scope=read(OUT/'scope-coverage.json')
    assert (scope['version'],scope['build'],scope['target'])==(VERSION,BUILD,'Hardmode mobile only')
    assert len(scope['items'])==35 and {item['item'] for item in scope['items']}==set(range(1,36))
    # Cases may carry an optional language after the mode. Never infer modes
    # solely from the final comma-separated field.
    modes={case.split(',')[6] for case in plan.ALL if case.count(',')>=6}
    for item in scope['items']:
        assert item['request'] and item['implementation'] and item['sources'] and item['modes']
        assert item['status']=='requires-final-receipt'
        for relative in item['sources']:assert inherited.local(relative)
        assert set(item['modes'])<=modes,(item['item'],'Unplanned scope mode',set(item['modes'])-modes)
    return dict(path='release1105/scope-coverage.json',sha256=sha(OUT/'scope-coverage.json'),items=35)

def verify_visuals(desktop,runtime_rows):
    path=OUT/'visual-review.json';review=read(path)
    assert review['status']=='PASS' and review['vm_sha256']==desktop
    assert review.get('reviewer') and review.get('images')
    known={row['scenario']:row for row in runtime_rows};images=[]
    for row in review['images']:
        relative=Path(row['path']);image_path=(OUT/relative).resolve()
        assert image_path.is_relative_to(OUT.resolve()) and image_path.is_file()
        assert row['sha256']==sha(image_path) and row.get('purpose') and row.get('observations')
        assert image_path.suffix.lower()=='.png'
        with Image.open(image_path) as image:
            assert image.format=='PNG' and image.width>=320 and image.height>=180
            size=list(image.size);image.verify()
        # All images must be output by one exact tested final-VM scenario;
        # copied pictures from the1.1.4 release cannot pass this binding.
        folder=image_path.parent
        while not (folder/'receipt.json').is_file() and folder!=OUT:folder=folder.parent
        assert folder!=OUT,(relative,'Missing matching VM scenario receipt')
        receipt=read(folder/'receipt.json')
        assert receipt['scenario'] in known and receipt['vm_sha256']==desktop
        assert sha(folder/'receipt.json')==known[receipt['scenario']]['receipt_sha256']
        images.append(dict(path=relative.as_posix(),sha256=row['sha256'],size=size,
                           purpose=row['purpose'],observations=row['observations'],
                           scenario=receipt['scenario'],vm_sha256=desktop))
    assert len(images)==len({row['path'] for row in images})
    assert {row['sha256'] for row in images}==set(review['image_sha256'])
    for rate in (30,60):
        for filename,mode in [('bossbars114.png','fix114bars'),('guardian-projectiles114.png','fix114guardian')]:
            assert any(Path(row['path']).name==filename and row['scenario'].split(',')[3]==str(rate)
                       and row['scenario'].split(',')[6]==mode for row in images),(rate,filename,'Missing retained visual regression')
    assert any(row['purpose']=='player-boost-label-zh-CN' for row in images),'Actual rendered Chinese settings label required'
    return images

def collect_profiles(plan,desktop):
    """Bind actual profile JSON to final logs; do not turn CPU times into FPS."""
    profiles=[]
    for scenario in plan.ALL:
        if scenario.count(',')<6:continue
        mode=scenario.split(',')[6]
        marker={'sync115water':'HARDMODE SEWERBIND115 FIXTURE',
                'sync115waterprofile':'HARDMODE WATER115 PROFILE',
                'sync115shield':'HARDMODE SHIELDS115 PROFILE',
                'sync114gator':'HARDMODE GATOR114 PROFILE'}.get(mode)
        if not marker:continue
        folder=OUT/'tests'/scenario.replace(',','-').replace(':','-')
        log=(folder/'runner.log').read_text('utf-8',errors='replace')
        reports=re.findall(re.escape(marker)+r' (\{[^\r\n]+\})',log)
        # Marker spelling is part of a profile's format. Missing evidence is
        # not silently replaced by values from an earlier build.
        assert reports,(scenario,'Missing final CPU profile',marker)
        measurements=[json.loads(value) for value in reports]
        assert len(measurements)==1,(scenario,'Expected one complete paired profile')
        measure=measurements[0]
        if mode in ('sync115waterprofile','sync115shield'):
            assert measure['physical_device'] is False
            assert measure['samples']==12
            assert measure['optimized_median_us']>0 and measure['original_median_us']>0
        if mode=='sync115waterprofile':
            # Both paths now contain the exact released water functions;
            # source equivalence is verified by audit_performance1105. A
            # noisy timing ratio of identical code is not an optimization.
            assert measure['strategy']=='released_hash_gate_restored'
            assert measure['real_generated_geometry'] is True
            assert measure['actor_queries']>=600 and measure['passes_per_sample']==4
            assert (measure['loops'],measure['rate'])==(int(scenario.split(',')[2]),int(scenario.split(',')[3]))
            assert measure['floors']>20 and measure['coarse_survivors_per_pass']<=measure['actor_queries']
            assert measure['candidate_hash_build_median_us']>0 and measure['ungated_hash_median_us']>0
            # Geometry rollback preserves released exact queries. The actual
            # new sewer optimization is the native draw-binding refresh; bind
            # its separate paired measurements and require no CPU regression.
            binding=measure['sewer_binding_profile']
            assert binding['physical_device'] is False
            if binding.get('not_applicable',False):
                # A genuinely dry generated sample cannot supply a timing
                # claim. The independent wet-native fixture below is still
                # mandatory at both rates, and cannot be marked inapplicable.
                assert binding['reason']=='generated sewer has no exact five-foot water footprint'
                assert all(binding[key]==0 for key in ('actors','samples','passes_per_sample','refreshes','original_median_us','optimized_median_us'))
                assert measure['wet_actor_results']==0,(scenario,'Binding profile skipped despite measured wet native queries')
            else:
                assert binding['actors']>0 and binding['samples']==12
                assert binding['passes_per_sample']==4
                # refreshes is cumulative across all optimized samples. For
                # example 23 actors * 4 passes * 12 samples is 1104, not 92.
                assert binding['refreshes']==binding['actors']*12*4
                assert binding['scope']=='native generic vs specialized sewer draw-binding refresh on identical wet actors'
                assert binding['fixture_source']=='generated_sewer' and binding['real_generated_water_footprint'] is True
                assert 0<binding['optimized_median_us']<=binding['original_median_us'],(scenario,'Sewer binding host CPU profile regressed',binding)
        if mode=='sync115water':
            assert measure['fixture_source']=='authored_native_water_fixture'
            assert measure['real_generated_water_footprint'] is False and measure['physical_device'] is False
            assert measure['actors']>0 and measure['samples']==12 and measure['passes_per_sample']==4
            assert measure['refreshes']==measure['actors']*12*4
            assert measure['original_median_us']>0 and measure['optimized_median_us']>0
        if mode=='sync115shield':
            assert measure['projectiles']>=924 and measure['queries_per_sample']==12
            assert measure['optimized_median_us']<=measure['original_median_us'],(scenario,'Shield host CPU profile regressed',measure)
        profiles.append(dict(scenario=scenario,vm_sha256=desktop,host_cpu_only=True,
            runner_log_sha256=sha(folder/'runner.log'),measurements=measurements))
    assert sum(row['scenario'].split(',')[6]=='sync115waterprofile' for row in profiles)==6
    assert sum(row['scenario'].split(',')[6]=='sync115shield' for row in profiles)==2
    assert {int(row['scenario'].split(',')[3]) for row in profiles
            if row['scenario'].split(',')[6]=='sync115water'}=={30,60}
    assert {(int(row['scenario'].split(',')[2]),int(row['scenario'].split(',')[3]))
            for row in profiles if row['scenario'].split(',')[6]=='sync115waterprofile'}=={(loop,rate) for loop in (1,3,10) for rate in (30,60)}
    assert {int(row['scenario'].split(',')[3]) for row in profiles
            if row['scenario'].split(',')[6]=='sync115waterprofile'
            and not row['measurements'][0]['sewer_binding_profile'].get('not_applicable',False)}=={30,60},'Real generated wet binding timings required at both host rates'
    return profiles

def main():
    assert (VERSION,BUILD)==('1.1.5',19)
    plan=importlib.import_module('release1105_test_plan')
    frozen,desktop=inherited.verify_source()
    build_source=verify_build_source(frozen,desktop)
    rows,checks=verify_plan_and_runtime(plan,desktop)
    functions,pairs=production()
    game=inherited.Game((ROOT/'build-windows/nuclearthronemobile.win').read_bytes())
    verify_code(game,functions,pairs,'final desktop')
    desktop_artwork=inherited.verify_artwork(game,'final desktop')
    artifacts=package_gate.verify_packages(desktop,functions,pairs,verify_code)
    platform_audits=inherited.verify_platform_audits()
    scope=verify_scope(plan);visuals=verify_visuals(desktop,rows)
    profiles=collect_profiles(plan,desktop)
    audit_performance1105.main()
    water_source_equivalence=audit_performance1105.water_source_equivalence()
    baseline=ROOT/'tests/water-baseline114-manifest.json'
    assert baseline.read_bytes()==(OUT/'water-baseline114-manifest.json').read_bytes()
    water_baseline=read(baseline)
    assert water_baseline['source_commit']=='48ac73f965f83240a1a88c1253207aff27866715'
    assert water_baseline['operation']=='function identifier renaming only' and len(water_baseline['functions'])==12
    report=dict(status='PASS',version=VERSION,build=BUILD,package=PACKAGE,mod='Hardmode b24',
        verified_utc=datetime.now(timezone.utc).isoformat(),installation_packages_generated=True,
        source_manifest_sha256=sha(OUT/'final-source.json'),source_code_archive_sha256=sha(OUT/'final-code.zip'),
        test_plan_sha256=sha(OUT/'test-plan.json'),final_desktop_vm_sha256=desktop,
        source_bound_host_build=build_source,
        original_files_verified=frozen['original_files_verified'],user_items=35,
        gameplay_cases=len(plan.REQUIRED),regression_cases=len(plan.REGRESSIONS),
        total_cases=len(plan.ALL),checks=checks,runtime_cases=rows,
        artifacts=artifacts,compiled_repair_functions=functions,
        production_call_edges=[dict(caller=caller,callee=callee) for caller,callee in pairs],
        scope=scope,scope_coverage_sha256=scope['sha256'],visual_evidence=visuals,
        visual_review_sha256=sha(OUT/'visual-review.json'),desktop_compiled_artwork=desktop_artwork,
        platform_audits=platform_audits,host_cpu_profiles=profiles,
        host_cpu_profile_semantics=dict(
            timing='microseconds per paired sample; median of 12 alternating samples',
            sewer_binding_refreshes='cumulative optimized refreshes across all 12 samples; actors * 4 passes * 12 samples',
            dry_generated_map='zero measured wet results may record no binding timing; separate authored native wet fixture remains mandatory at both rates, as do real generated wet timings at both rates',
            restored_water='exact released function bodies; timing equivalence observation, no new water-query speedup claimed',
            acceptance='specialized sewer binding and shield median CPU times must be positive and no slower than their paired originals'),
        water_baseline_manifest_sha256=sha(baseline),water_baseline_source_commit=water_baseline['source_commit'],
        water_source_equivalence=water_source_equivalence,
        grillskills_imported=False,physical_device_tested=False,mac_native_rebuild=False,
        ios_requires_resigning=True,uploaded=False,
        test_audio='1250sound-resource gains zeroed in a separate test VM; master/session muted at0%',
        foreground_window_control_used=False,
        limits=['Silent isolated Windows host-VM acceptance, not physical Android/iPhone acceptance.',
                'Profiles describe host CPU work; no universal high-Loop60FPS guarantee.',
                'Captain speed is an explicit mobile +5%/Loop, capped2x policy, not a verified original desktop constant.',
                'iOS uses a compatible retained native runner, fresh VM/resources and requires re-signing.'])
    (OUT/'delivery-receipt.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n','utf-8')
    print('Final delivery PASS',VERSION,'build',BUILD,len(plan.ALL),'scenarios',checks,'assertions')

if __name__=='__main__':main()
