"""Strict final-source, same-VM and packaged acceptance for 1.1.6/build20.

This read-only gate writes a receipt only after all checks pass. It cannot
build, freeze, alter a package, launch a test or publish anything.
"""
from pathlib import Path
from datetime import datetime,timezone
import importlib
import hashlib
import io
import json
import re
import struct

from PIL import Image
from create_project import load

from release_config import VERSION,BUILD,PACKAGE
import make_release1105_receipt as retained
import package_gate1106 as package_gate
import audit_performance1105

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release1106'
retained.OUT=OUT
inherited=retained.inherited
inherited.OUT=OUT
package_gate.OUT=OUT
sha=retained.sha
read=retained.read
def has_edge(game,caller,callee):
    # A named function can resume after one of its inline struct/function
    # constructors. Include descendants owned by this exact name, while
    # preserving the boundary before an unrelated sibling function.
    # The retained 1.1.4 helper stopped at every child CODE record, which
    # truncated FrameBudget1116 just before its actual State1116 call.
    if not hasattr(game,'hm_ranges1106'):
        entries={};groups={};table=game.parts[b'CODE'][0]
        for index in range(game.u32(table)):
            record=game.u32(table+4+4*index)
            name=game.string(game.u32(record));base,length=game.codes[name]
            offset=game.u32(record+16)
            assert 0<=offset<length,(name,offset,length)
            entries[name]=(base,length,offset)
            groups.setdefault(base,[]).append((offset,name))
        ranges={}
        for name,(base,length,offset) in entries.items():
            owner=name.removeprefix('gml_Script_')
            def descendant(other):
                return owner in other.split('@')[1:]
            end=min((pos for pos,other in groups[base]
                     if pos>offset and not descendant(other)),default=length) if offset else length
            ranges[name]=(base+offset,base+end)
        game.hm_ranges1106=ranges
    start,end=game.hm_ranges1106[inherited.code_name(caller)]
    return any(start<=ref<end for ref in game.functions.get(inherited.code_name(callee),{}).get('refs',[]))


def production():
    functions,pairs=retained.production()
    # The old helper used to advance native alarms a second time. The current
    # desktop reference audit deliberately removes that guessed speed policy;
    # its definition remains compatible, but those two call edges must retire.
    retired={('scrHMChiefAction1115','scrHMChiefSpeed1115'),
             ('scrHMChiefAction1115','scrHMChiefAlarm1115')}
    assert retired<=set(pairs)
    pairs=[edge for edge in pairs if edge not in retired]
    for script in ('scrHMRepairs1116Runtime','scrHMRepairs1116Policy','scrHMUI1104',
                   'scrHMRepairs103','scrHMRepairs107','scrHMWorld'):
        functions.extend(retained.functions_from(f'project/scripts/{script}/{script}.gml'))
    functions += ['scrHMBigDogShots105','scrHMCorpseSprite116','scrHMCorpseSettle116']
    functions += [f'gml_Object_ScrapBoss_{event}' for event in
                  ('Create_0','Other_10','Draw_0','Alarm_0','Alarm_1','Alarm_2')]
    functions += ['gml_Object_YVBoss_Alarm_1','gml_Object_YVBoss_Alarm_2',
                  'gml_Object_Rocket_Collision_Explosion','gml_Object_Rocket_Collision_Wall',
                  'gml_Object_Rocket_Collision_hitme']
    pairs += [
        ('gml_Object_UberCont_Step_0','scrHMFrameBudget1116'),
        ('scrHMFrameBudget1116','scrHMFrameBudgetState1116'),
        ('gml_Object_UberCont_Step_0','scrHMVisibleFloors1116'),
        ('scrHMMusicRoom112','scrHMDesertMusic1116'),
        ('scrHMGuardianLayers109','scrHMGuardianLayers1104'),
        ('scrHMGuardianLayers1104','scrHMGuardianLayerLift1104'),
        ('scrHMGuardianLayers1104','scrHMGuardianLayerRestore1104'),
        ('gml_Object_ScrapBoss_Alarm_1','scrHMBigDogShots105'),
        ('gml_Object_Rocket_Collision_Explosion','scrHMRocketChainBlocked1116'),
        ('gml_Object_Rocket_Destroy_0','scrHMExplosionSource1115'),
        ('hm_enemies_mod_gml_enemyrogue_create','scrHMMessengerInit1103'),
        ('hm_enemies_mod_gml_enemyrogue_step_resume','scrHMMessengerTagExplosion1103'),
        ('hm_enemies_mod_gml_enemyrogue_death','scrHMMessengerTagExplosion1103'),
        ('gml_Object_IDPDSpawn_Alarm_1','scrHMLoopEnemyStart1115'),
        ('gml_Object_IDPDSpawn_Alarm_1','scrHMPoliceGroup1115'),
        ('scrHMPoliceGroup1115','hm_arkintide_mod_gml_hm_infantry_kind'),
        ('hm_arkintide_mod_gml_hm_infantry_kind','scrHMPoliceKind1116'),
        ('scrHMPoliceKind1116','scrHMPoliceLate1116'),
        ('gml_Object_PopoFreak_Create_0','scrHMPoliceLate1116'),
        ('gml_Object_PopoFreak_Destroy_0','scrHMPoliceLate1116'),
        ('gml_Object_RevivePopoFreak_Alarm_0','scrHMPoliceRevivalBlocked1116'),
        ('scrHMPoliceRevive107','scrHMPoliceRevivalBlocked1116'),
        ('scrHMPoliceDeath107','scrHMPoliceBindCorpse107'),
        ('scrHMPoliceRevive107','scrHMPoliceBindCorpse107'),
        ('gml_Object_PopoFreak_Destroy_0','scrHMPoliceBindCorpse107'),
        ('hm_arkintide_mod_gml_hm_police_revival','scrHMPoliceBindCorpse107'),
        ('gml_Object_WantRevivePopoFreak_Alarm_0','scrHMPoliceRevive107'),
        ('gml_Object_WantRevivePopoFreak_Alarm_0','scrHMMessengerReviveTimer115'),
        ('gml_Object_RevivePopoFreak_Alarm_0','scrHMMessengerReviveEffect115'),
        ('scrHMVanStop107','scrHMPoliceLate1116'),
        ('hm_enemies_mod_gml_vanguide','scrHMPoliceLate1116'),
        ('scrRadDrop','scrHMTankNoRadiation1116'),
        ('gml_Object_BanditBoss_Create_0','scrHMStageBanditCreate1116'),
        ('hm_arkintide_mod_gml_hm_batch_step','scrHMSnowPopulation1116'),
        ('hm_arkintide_mod_gml_hm_extra_bind','scrHMExtraCrystalIdentity1116'),
        ('hm_arkintide_mod_gml_hm_extra_event','scrHMExtraCrystalIdentity1116'),
        ('gml_Object_HyperCrystal_Alarm_1','scrHMExtraCrystalChild1116'),
        ('scrHMExtraCrystalTick1115','scrHMExtraCrystalBlink1116'),
        ('hm_arkintide_mod_gml_hm_extra_loot','scrHMExtraDeathVisual1116'),
        ('gml_Object_enemy_Destroy_0','scrHMExtraCorpse1116'),
        ('scrHMExtraCorpse1116','scrHMDeathAnimationSpeed1116'),
        ('gml_Object_FrogQueenDeath_Other_7','scrHMExtraCorpse1116'),
        ('gml_Object_enemy_Destroy_0','scrHMBossGroupDeath1116'),
        ('scrBossIntro','scrHMBossNativeRequest1116'),
        ('scrHMBossNativeRequest1116','scrHMBossNativeAttach1116'),
        ('scrHMBossGroupTick115','scrHMBossNativeAttach1116'),
        ('scrHMBossStep104','scrHMBossNativeStep1116'),
        ('hm_bosses_bossintros_mod_gml_draw_gui','scrHMBossNativeDraw1116'),
        ('gml_Object_Corpse_Other_7','scrHMCorpseSettle116'),
        ('scrHMCorpseSettle116','scrHMCorpseSprite116'),
    ]
    return sorted(set(functions)),list(dict.fromkeys(pairs))


def verify_code(game,functions,pairs,target):
    for rejected in ('scrHMWaterFlatIndex113','scrHMWaterFlatBegin113','scrHMWaterFlatQuery113',
                     'scrHMWaterIndex1105','scrHMWaterShapes1105','scrHMWaterShapeQuery1105'):
        assert inherited.code_name(rejected) not in game.codes,(target,'Rejected old water candidate',rejected)
    for name in functions+inherited.RETAINED_FUNCTIONS:
        assert inherited.code_name(name) in game.codes,(target,'Missing compiled function',name)
    for caller,callee in pairs:
        assert has_edge(game,caller,callee),(target,'Missing function-level production edge',caller,callee)
    assert 'Hardmode 1.1.6' in game.strings,(target,'Wrong compiled version')
    assert not has_edge(game,'scrHMThroneTick1103','scrHMThroneOpenWalls1103')
    assert not has_edge(game,'hm_maincode_mod_gml_step_resume','hm_arkintide_mod_gml_hm_throne_fall')
    assert not has_edge(game,'scrHMChiefAction1115','scrHMChiefSpeed1115'),(target,'Retired guessed Captain speed supplement')
    assert not has_edge(game,'scrHMChiefAction1115','scrHMChiefAlarm1115'),(target,'Retired duplicate Captain alarm advancement')
    for obj in ('WeaponChest','BigWeaponChest'):
        assert not has_edge(game,f'gml_Object_{obj}_Collision_Player','scrHMToolWeapon1100')
    assert not any('gml_Script_hm_hm_grillskills_mod_gml_' in name for name in game.codes)
    for title in ('核能王座','王座II','通信员','至高守护者','玩家增强','生命上限+2','等级上限+1'):
        assert any(title in string for string in game.strings),(target,'Missing packaged Chinese text',title)
    verify_corpse_art(game,target)


def verify_native_boss_sequences(plan,desktop):
    """Bind native-alarm outcomes to final logs, beyond alive-frame counts."""
    records=[];yv_coverage=set();chief_coverage=set();boss_coverage=set()
    for scenario in plan.ALL:
        fields=scenario.split(',')
        if len(fields)<7:continue
        mode=fields[6]
        if mode not in ('yv1115minigun','chief1115first','chief1115repeat','boss1116'):continue
        rate=int(fields[3]);loop=int(fields[2])
        folder=OUT/'tests'/scenario.replace(',','-').replace(':','-')
        receipt=read(folder/'receipt.json')
        assert receipt['vm_sha256']==desktop and receipt['exit']==0,(scenario,'Wrong boss-sequence VM')
        marker=('HARDMODE YV1115' if mode=='yv1115minigun' else
                'HARDMODE BOSS1116 PASS' if mode=='boss1116' else 'HARDMODE CHIEF1115')
        log=(folder/'runner.log').read_text('utf8',errors='replace')
        values=re.findall(re.escape(marker)+r' (\{[^\r\n]+\})',log)
        assert len(values)==1,(scenario,'Missing or duplicate complete native boss sequence',marker)
        value=json.loads(values[0])
        if mode=='yv1115minigun':
            assert (value['rate'],value['loop'])==(rate,loop)
            budget=70+30*loop;batch=1+loop;bursts=(budget+batch-1)//batch
            assert value['shots']==bursts*batch,(scenario,'Truncated final native minigun burst')
            assert abs(value['angle']-(bursts*batch-4.5))<.001,(scenario,'Incorrect native minigun sweep')
            assert abs(value['last_tick']-value['first_tick']-(bursts-1))<=1,(scenario,'Incorrect native minigun duration')
            yv_coverage.add((rate,loop))
        elif mode=='boss1116':
            assert receipt['checks']>=14,(scenario,'Native boss collision/intro checks skipped')
            assert value['yv_shots']==4 and value['half_turn']==2 and value['full_turn']==4
            assert value['dog_bouncers']>0,(scenario,'No native Big Dog bounce burst')
            boss_coverage.add(rate)
        else:
            assert (value['mode'],value['rate'],value['loop'])==(mode,rate,loop)
            assert value['combat_at']>10 and value['no_entry_attack'] is True and value['summons']>=1
            visuals=value['visuals']
            assert visuals['warp'] is True and visuals['camera'] is True
            assert visuals['portrait_count']==(1 if mode=='chief1115first' else 0)
            cadence=value['cadence'];assert len(cadence)==2
            assert {sample['ordinary'] for sample in cadence}=={False,True}
            for sample in cadence:
                shots=sample['shots'];assert len(shots)==8,(scenario,'Incomplete automatic Captain volley sequence')
                assert [shot['ammo'] for shot in shots]==list(range(28,-1,-4))
                assert all(b['logic']-a['logic']==4 for a,b in zip(shots,shots[1:]))
                assert shots[-1]['logic']-shots[0]['logic']==28
                assert abs(shots[-1]['physical']-shots[0]['physical']-28*rate/30)<=1
            cooldown=value['cooldown'];assert len(cooldown)==2
            full,half=cooldown
            assert (full['health'],half['health'])==(1,.5)
            assert full['done']>0 and abs(full['done']-full['start']-25)<=2
            assert half['done']>0 and abs(half['done']-half['start']-18)<=2 and half['done']<full['done']
            assert abs(value['dash']-70)<=14,(scenario,'Incorrect native Captain charge movement')
            chief_coverage.add((rate,mode))
        records.append(dict(scenario=scenario,vm_sha256=desktop,runner_log_sha256=sha(folder/'runner.log'),measurements=value))
    assert {(rate,loop) for rate in (30,60) for loop in (0,1,2,3)}<=yv_coverage,('Missing native Y.V Loop/rate sequence',yv_coverage)
    assert chief_coverage=={(rate,mode) for rate in (30,60) for mode in ('chief1115first','chief1115repeat')}
    assert boss_coverage=={30,60}
    return records


CORPSE_ART=[('sprMutant2BDead','sprHMCorpse116Crystal'),
            ('sprMutant4Dead','sprHMCorpse116Melting'),
            ('sprMutant4BDead','sprHMCorpse116MeltingB'),
            ('sprMutant5Dead','sprHMCorpse116Plant'),
            ('sprHM_enemies_mod_64','sprHMCorpse116RogueFreak'),
            ('sprMutant8Dead','sprHMCorpse116Robot'),
            ('sprMutant9Dead','sprHMCorpse116Chicken'),
            ('sprMutant14Dead','sprHMCorpse116Skeleton')]


def verify_corpse_art(game,target):
    """Read actual packed pixels; retain animations, alpha and player art."""
    table=game.parts[b'SPRT'][0]
    sprites={}
    for index in range(game.u32(table)):
        pointer=game.u32(table+4+4*index)
        sprites[game.string(game.u32(pointer))]=pointer
    pages={};records=[]
    for source,private in CORPSE_ART:
        srcdir=ROOT/'project/sprites'/source;dstdir=ROOT/'project/sprites'/private
        src=load(srcdir/(source+'.yy'));dst=load(dstdir/(private+'.yy'))
        for key in ('width','height','bbox_left','bbox_right','bbox_top','bbox_bottom','bboxMode','collisionKind','origin'):
            assert src[key]==dst[key],(source,'Changed corpse geometry',key)
        for key in ('xorigin','yorigin'):
            assert src['sequence'][key]==dst['sequence'][key]
        count=len(src['frames']);assert len(dst['frames'])==count
        pointer=sprites[private]
        assert struct.unpack_from('<II',game.data,pointer+4)==(src['width'],src['height'])
        assert list(struct.unpack_from('<ii',game.data,pointer+48))==[src['sequence']['xorigin'],src['sequence']['yorigin']]
        assert game.u32(pointer+84)==count
        for index in range(count):
            original=Image.open(srcdir/(src['frames'][index]['name']+'.png')).convert('RGBA')
            expected=Image.open(dstdir/(dst['frames'][index]['name']+'.png')).convert('RGBA')
            assert original.size==expected.size
            if index<count-1:
                assert original.tobytes()==expected.tobytes(),(source,'Death animation changed',index)
            else:
                assert original.getchannel('A').tobytes()==expected.getchannel('A').tobytes()
                assert original.tobytes()!=expected.tobytes()
                assert all(r==g==b for r,g,b,a in expected.getdata() if a>0),(source,'Settled corpse is not gray')
            frame=Image.new('RGBA',expected.size)
            tpag=game.u32(pointer+88+index*4)
            if tpag not in (0,0xFFFFFFFF):
                sx,sy,sw,sh,tx,ty,tw,th,bw,bh,page=struct.unpack_from('<10Hh',game.data,tpag)
                assert (bw,bh)==expected.size and page>=0
                if page not in pages:
                    texture=game.u32(game.parts[b'TXTR'][0]+4+page*4)
                    capacity=game.u32(texture+8);png=game.u32(texture+24)
                    pages[page]=Image.open(io.BytesIO(bytes(game.data[png:png+capacity]))).convert('RGBA')
                crop=pages[page].crop((sx,sy,sx+sw,sy+sh))
                if crop.size!=(tw,th):crop=crop.resize((tw,th),Image.Resampling.NEAREST)
                frame.paste(crop,(tx,ty))
            assert inherited.visible_rgba(frame)==inherited.visible_rgba(expected),(target,private,'Packed corpse pixels differ',index)
        records.append(dict(source=source,private=private,frames=count,animated_frames_unchanged=count-1,
                            settled_frame_gray=True,packed_frames_verified=count))
    return records


def verify_scope(plan):
    scope=read(OUT/'scope-coverage.json')
    assert (scope['version'],scope['build'],scope['target'])==(VERSION,BUILD,'Hardmode mobile only')
    assert len(scope['items'])==26 and {item['item'] for item in scope['items']}==set(range(1,27))
    modes={case.split(',')[6] for case in plan.ALL if case.count(',')>=6}
    for item in scope['items']:
        assert item['request'] and item['implementation'] and item['sources'] and item['modes']
        assert item['status']=='requires-final-receipt'
        for relative in item['sources']:assert inherited.local(relative)
        assert set(item['modes'])<=modes,(item['item'],'Unplanned scope mode',set(item['modes'])-modes)
    return dict(path='release1106/scope-coverage.json',sha256=sha(OUT/'scope-coverage.json'),items=26)


def verify_visuals(desktop,runtime_rows):
    """Require current rendered evidence in addition to retained regressions.

    The retained verifier checks PNG dimensions, reviewed hashes and exact
    final-VM scenario receipts. Small Throne pose/reference captures remain
    separate raw evidence; its full-size gameplay.png supplies scene context.
    """
    images=retained.verify_visuals(desktop,runtime_rows)
    required=[('corpse116-settled.png','corpse116'),
              ('cave116stage-far.png','cave116stage'),
              ('cave116extra-far.png','cave116extra'),
              ('gameplay.png','throne116'),
              ('policy116portrait.png','policy116portrait'),
              ('chief1115-portrait.png','chief1115first')]
    for rate,language in ((30,'Simplified Chinese'),(60,'English')):
        for filename,mode in [*required,(f'custom116-{language}.png','custom116')]:
            matches=[row for row in images if Path(row['path']).name==filename
                     and row['scenario'].split(',')[3]==str(rate)
                     and row['scenario'].split(',')[6]==mode]
            assert matches,(rate,filename,mode,'Missing current final-VM visual evidence')
            if mode=='custom116':
                assert any(row['scenario'].split(',')[7:]==[language] for row in matches),(
                    rate,language,'Custom screenshot belongs to a different language scenario')
    return images


def collect_profiles(plan,desktop):
    profiles=retained.collect_profiles(plan,desktop)
    markers={'guardian116':'HARDMODE GUARDIAN116 PROFILE',
             'floors116':'HARDMODE FLOORS116 PROFILE',
             'budget116':'HARDMODE FRAME116 LIVE',
             'guardian116fire':'HARDMODE GUARDIAN116 LIVE'}
    for scenario in plan.ALL:
        fields=scenario.split(',')
        if len(fields)<7 or fields[6] not in markers:continue
        mode=fields[6];folder=OUT/'tests'/scenario.replace(',','-').replace(':','-')
        log=(folder/'runner.log').read_text('utf8',errors='replace')
        reports=re.findall(re.escape(markers[mode])+r' (\{[^\r\n]+\})',log)
        assert len(reports)==1,(scenario,'Missing or duplicate final profile')
        measure=json.loads(reports[0]);assert measure['physical_device'] is False
        if mode in ('guardian116','floors116'):
            assert measure['samples']==(18 if mode=='guardian116' else 24)
            assert measure['passes_per_sample']==(12 if mode=='guardian116' else 20)
            assert 0<measure['optimized_median_us']<=measure['original_median_us'],(scenario,'Host CPU regression',measure)
        elif mode=='budget116':
            assert measure['saved_rate']==60 and measure['actual_cap']==30
            assert 59<=measure['logical_units']<=61 and 1.6<measure['elapsed_seconds']<3.4
        else:
            assert measure['logical_frames']==180 and measure['visible_sources']>0
        profiles.append(dict(scenario=scenario,vm_sha256=desktop,host_cpu_only=True,
            runner_log_sha256=sha(folder/'runner.log'),measurements=[measure]))
    for mode in markers:
        assert {int(row['scenario'].split(',')[3]) for row in profiles
                if row['scenario'].split(',')[6]==mode}=={30,60},('Both host rates required',mode)
    return profiles


def main():
    assert (VERSION,BUILD)==('1.1.6',20)
    plan=importlib.import_module('release1106_test_plan')
    frozen,desktop=inherited.verify_source()
    build_source=retained.verify_build_source(frozen,desktop)
    rows,checks=retained.verify_plan_and_runtime(plan,desktop)
    native_boss_sequences=verify_native_boss_sequences(plan,desktop)
    functions,pairs=production()
    game=inherited.Game((ROOT/'build-windows/nuclearthronemobile.win').read_bytes())
    verify_code(game,functions,pairs,'final desktop')
    artwork=inherited.verify_artwork(game,'final desktop')
    corpse_artwork=verify_corpse_art(game,'final desktop')
    artifacts=package_gate.verify_packages(desktop,functions,pairs,verify_code)
    platform_audits=inherited.verify_platform_audits()
    scope=verify_scope(plan);visuals=verify_visuals(desktop,rows)
    profiles=collect_profiles(plan,desktop)
    audit_performance1105.main()
    water_equivalence=audit_performance1105.water_source_equivalence()
    baseline=ROOT/'tests/water-baseline114-manifest.json'
    assert baseline.read_bytes()==(OUT/'water-baseline114-manifest.json').read_bytes()
    report=dict(status='PASS',version=VERSION,build=BUILD,package=PACKAGE,mod='Hardmode b24',
        verified_utc=datetime.now(timezone.utc).isoformat(),installation_packages_generated=True,
        source_manifest_sha256=sha(OUT/'final-source.json'),source_code_archive_sha256=sha(OUT/'final-code.zip'),
        test_plan_sha256=sha(OUT/'test-plan.json'),final_desktop_vm_sha256=desktop,
        source_bound_host_build=build_source,original_files_verified=frozen['original_files_verified'],
        user_items=26,gameplay_cases=len(plan.REQUIRED),regression_cases=len(plan.REGRESSIONS),
        total_cases=len(plan.ALL),checks=checks,runtime_cases=rows,artifacts=artifacts,
        compiled_repair_functions=functions,
        production_call_edges=[dict(caller=a,callee=b) for a,b in pairs],
        native_boss_sequences=native_boss_sequences,
        scope=scope,scope_coverage_sha256=scope['sha256'],visual_evidence=visuals,
        visual_review_sha256=sha(OUT/'visual-review.json'),desktop_compiled_artwork=artwork,
        corpse_artwork=corpse_artwork,
        platform_audits=platform_audits,host_cpu_profiles=profiles,
        water_baseline_manifest_sha256=sha(baseline),water_source_equivalence=water_equivalence,
        grillskills_imported=False,physical_device_tested=False,mac_native_rebuild=False,
        ios_requires_resigning=True,uploaded=False,
        test_audio='1250 sound-resource gains zeroed in a separate test VM; session muted at 0%',
        foreground_window_control_used=False,
        limits=['Silent isolated Windows host-VM acceptance, not physical Android/iPhone acceptance.',
                'Host CPU profiles are not a universal high-Loop 60 FPS guarantee.',
                'Sustained overload can temporarily lower rendering to native 30 Hz while preserving the saved 60 preference.',
                'iOS uses a compatible retained native runner, fresh VM/resources and requires re-signing.'])
    (OUT/'delivery-receipt.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n','utf8')
    print('Final delivery PASS',VERSION,'build',BUILD,len(plan.ALL),'scenarios',checks,'assertions')


if __name__=='__main__':main()
