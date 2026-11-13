"""Strict final-source, same-VM and packaged acceptance for 1.1.7/build21.

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
import package_gate1107 as package_gate

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release1107'
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
    # Reuse read-only legacy acceptance utilities, never their build/import
    # entrypoints. New helpers must be present in every current compiled VM.
    for path in sorted((ROOT/'native').glob('*1117*.gml')):
        functions.extend(retained.functions_from(path.relative_to(ROOT).as_posix()))
    retired_clock={('gml_Object_UberCont_Step_0','scrHMFrameBudget1116'),
        ('scrHMFrameBudget1116','scrHMFrameBudgetState1116')}
    pairs=[edge for edge in pairs if edge not in retired_clock]
    pairs += [
        ('gml_Object_UberCont_Step_1','scrHMClockBegin1117'),
        ('scrHMWorldBegin','scrHMClockBegin1117'),
        ('scrHMBossRestore104','scrHMClockAnimationRatio1117'),
        ('scrHMBossStep104','scrHMClockPresentationTicks1117'),
        ('scrHMBossNativeDraw1116','scrHMBossPortraitTitleDraw1117'),
        ('scrHMReportIntroDraw1103','scrHMBossPortraitTitleDraw1117'),
        ('hm_arkintide_mod_gml_hm_gungod_hurt','scrHMGunGodHandoff1117'),
        ('hm_bosses_gungod_mod_gml_GunGod_hurt','scrHMGunGodHandoff1117'),
        ('hm_props_mod_gml_Flower_create','scrHMJungleFlowerSingleton1117'),
        ('hm_arkintide_mod_gml_hm_jungle_entrance','scrHMJungleFlowerPending1117'),
        ('gml_Object_Last_Alarm_5','scrHMChiefDecisionDelay1117'),
        ('gml_Object_Rocket_Step_0','motion_add_m'),
        ('hm_props_mod_gml_Flower_create','scrHMJungleFlowerFloor1117'),
        ('scrHMClockApply1117','scrHMClockActor1117'),
        ('scrHMClockActor1117','scrHMClockAnimationRatio1117'),
        ('scrHMClockBegin1117','scrHMClockBudget1117'),
        ('scrHMClockBegin1117','scrHMClockApply1117'),
        ('scrHMClockBegin1117','scrHMClockSafe1117'),
    ]
    return sorted(set(functions)),list(dict.fromkeys(pairs))


def verify_clock_source_units1117():
    """Bind powered motion's logical impulse to its physical use-site units."""
    step=ROOT/'project/objects/Rocket/Step_0.gml'
    source=re.sub(r'//[^\r\n]*','',step.read_text('utf8'))
    assert len(re.findall(r'\bmotion_add_m\s*\(\s*direction\s*,\s*accel\s*\*\s*timescale\s*,\s*maxspeed\s*\)',source))==1, 'Native Rocket acceleration must convert once at its actual motion call'
    assert not re.search(r'\bmotion_add_m\s*\(\s*direction\s*,\s*accel\s*,',source), 'Native Rocket must not pass raw logical acceleration as physical velocity'
    sources={step.relative_to(ROOT).as_posix():sha(step)}
    for actor,constant in (('Rocket','2'),('JockRocket','0.3')):
        path=ROOT/f'project/objects/{actor}/Create_0.gml'
        text=re.sub(r'//[^\r\n]*','',path.read_text('utf8'))
        assert re.findall(r'\baccel\s*=\s*([^;\r\n]+)',text)==[constant], (actor,'Native acceleration remains one logical constant')
        sources[path.relative_to(ROOT).as_posix()]=sha(path)
    return dict(status='PASS',unit='logical impulse multiplied once by timescale at native Rocket Step',sources=sources)


def verify_code(game,functions,pairs,target):
    for rejected in ('scrHMWaterFlatIndex113','scrHMWaterFlatBegin113','scrHMWaterFlatQuery113',
                     'scrHMWaterIndex1105','scrHMWaterShapes1105','scrHMWaterShapeQuery1105'):
        assert inherited.code_name(rejected) not in game.codes,(target,'Rejected old water candidate',rejected)
    for name in functions+inherited.RETAINED_FUNCTIONS:
        assert inherited.code_name(name) in game.codes,(target,'Missing compiled function',name)
    for caller,callee in pairs:
        assert has_edge(game,caller,callee),(target,'Missing function-level production edge',caller,callee)
    assert 'Hardmode 1.1.7' in game.strings,(target,'Wrong compiled version')
    assert not has_edge(game,'gml_Object_UberCont_Step_0','scrHMFrameBudget1116')
    assert 'visual_hm_autoframerate' in game.strings and 'hm_autoframerate' in game.strings
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


def log_payloads(scenario,marker,desktop):
    folder=OUT/'tests'/scenario.replace(',','-').replace(':','-')
    receipt=read(folder/'receipt.json')
    assert receipt['vm_sha256']==desktop and receipt['status']=='PASS' and receipt['exit']==0
    log=(folder/'runner.log').read_text('utf8',errors='replace')
    values=[json.loads(value) for value in re.findall(re.escape(marker)+r' (\{[^\r\n]+\})',log)]
    return folder,receipt,values


def verify_native_boss_sequences(plan,desktop):
    records=[];chief={};phase=set();titles=set();timing=set();flower=set()
    for scenario in plan.ALL:
        fields=scenario.split(',')
        if len(fields)<7:continue
        mode=fields[6];rate=int(fields[3]);loop=int(fields[2])
        if mode in ('chief117full','chief117half'):
            folder,receipt,values=log_payloads(scenario,'HARDMODE CHIEF1117 NATURAL',desktop)
            assert len(values)==1,(scenario,'Incomplete or duplicate natural Captain observation')
            value=values[0];health=1 if mode=='chief117full' else .5
            nominal=(25 if health==1 else 17.5)*(.8 if loop>0 else 1)
            assert (value['rate'],value['loop'],value['health'])==(rate,loop,health)
            assert value['nominal_logic']==nominal and len(value['samples'])>=8
            assert len(value['actions'])>=2 and value['combat_at']>20
            for sample in value['samples']:
                assert sample['previous_action'] and sample['next_action']
                assert abs(sample['health']-health)<.000001
                assert abs(sample['observed_alarm']-nominal)<=1
                assert abs(sample['elapsed_physical']*30/rate-nominal)<=2
            assert abs(value['mean_logic']-nominal)<=2
            chief[(rate,loop,health)]=value['mean_logic']
        elif mode=='presentation117phase':
            folder,receipt,values=log_payloads(scenario,'HARDMODE PRESENTATION117 PHASE',desktop)
            assert len(values)==1,(scenario,'Missing phase presentation counters')
            value=values[0]
            assert (value['rate'],value['loop'])==(rate,loop)
            assert value['phase1_exit_count']==0 and value['phase2_entry_count']==1
            assert value['phase2_exit_count']==0
            assert value['phase2_kind']
            phase.add((rate,loop))
        elif mode=='presentation117titles':
            folder,receipt,values=log_payloads(scenario,'HARDMODE PRESENTATION117 TITLES',desktop)
            assert len(values)==1,(scenario,'Missing rendered title coverage')
            value=values[0]
            assert value['rate']==rate and value['language']=='Simplified Chinese'
            assert [row['kind'] for row in value['native']]==['bandit','dog','hunter','throne','throne2','mother','crystal','tech','chief','crystal','yv','gungod']
            assert [row['label'] for row in value['native']]==['大匪','大狗','小猎人','核能王座','王座II','母亲','超能水晶','科技术士','局长','诅咒超级水晶','Y.V','枪神']
            assert [row['source'] for row in value['custom']]==['BIG BANDIT','BIG DOG','BIG BUBBLER','BIG BIRD','GRAND SCORPION','GREATER GUARDIAN','SUPER GATOR','TURTLES','TITANK','The#Messenger','THE#THRONE','HYPER#CRYSTAL','CURSED#HYPER#CRYSTAL','MUTANT RAT','DA GUN GOD','Y.V']
            for item in value['native']+value['custom']:
                assert item['label'] and ('Y.V' in item['label'] or re.search('[\u4e00-\u9fff]',item['label']))
            titles.add(rate)
        elif mode in ('presentation117timing','presentation117timing20'):
            folder,receipt,values=log_payloads(scenario,'HARDMODE PRESENTATION117 TIMING',desktop)
            assert len(values)==1,(scenario,'Incomplete real-time presentation observation')
            value=values[0]
            assert value['rate']==rate and value['mode']==mode
            assert len(value['durations'])==2 and all(1.6<duration<2.65 for duration in value['durations'])
            assert value['actual_callbacks']>0 and value['wall_seconds']>0 and len(value['final_focus'])==2
            if mode=='presentation117timing20':
                assert value['artificial_callback_cap']==20 and value['actual_callback_fps']<22
            timing.add((rate,mode))
        elif mode in ('presentation117flowerplain','presentation117flowerwish'):
            folder,receipt,values=log_payloads(scenario,'HARDMODE PRESENTATION117 FLOWER',desktop)
            assert len(values)==1,(scenario,'Incomplete natural cave flower observation')
            value=values[0]
            assert value['rate']==rate and value['last_wish']==(mode=='presentation117flowerwish')
            assert value['count']==1 and value['jungle_floor'] is True and value['late_excavation'] is True
            flower.add((fields[0],rate,mode))
        else:continue
        records.append(dict(scenario=scenario,vm_sha256=desktop,
            runner_log_sha256=sha(folder/'runner.log'),measurements=value))
    expected={(rate,loop,health) for rate in (30,60) for loop in (0,1,3) for health in (1,.5)}
    assert set(chief)==expected,('Incomplete natural Captain Loop/rate/health matrix',set(chief))
    for rate in (30,60):
        for health in (1,.5):
            base=chief[(rate,0,health)];one=chief[(rate,1,health)];three=chief[(rate,3,health)]
            assert one<base-2 and three<base-2 and abs(one-three)<=1
    for loop in (0,1,3):
        for health in (1,.5):assert abs(chief[(30,loop,health)]-chief[(60,loop,health)])<=1
    assert phase=={(rate,loop) for rate in (30,60) for loop in (0,1,3)}
    assert titles=={30,60}
    assert timing=={(rate,mode) for rate in (30,60) for mode in ('presentation117timing','presentation117timing20')}
    assert flower=={(area,rate,mode) for area in ('caves','cavesinv') for rate in (30,60) for mode in ('presentation117flowerplain','presentation117flowerwish')}
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
    assert not plan.PENDING_REQUIREMENTS,('Current regression coverage remains incomplete',plan.PENDING_REQUIREMENTS)
    assert not scope['pending_items'],('Unbound current scope items',scope['pending_items'])
    assert len(scope['items'])==9 and {item['item'] for item in scope['items']}==set(range(1,10))
    modes={case.split(',')[6] for case in plan.ALL if case.count(',')>=6}
    for item in scope['items']:
        assert item['request'] and item['implementation'] and item['sources'] and item['modes']
        assert item['status']=='requires-final-receipt'
        for relative in item['sources']:assert inherited.local(relative)
        assert set(item['modes'])<=modes,(item['item'],'Unplanned scope mode',set(item['modes'])-modes)
    return dict(path='release1107/scope-coverage.json',sha256=sha(OUT/'scope-coverage.json'),items=9)


def verify_visuals(desktop,runtime_rows):
    review=read(OUT/'visual-review.json')
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
        folder=image_path.parent
        while not (folder/'receipt.json').is_file() and folder!=OUT:folder=folder.parent
        assert folder!=OUT,(relative,'No exact tested scenario receipt')
        receipt=read(folder/'receipt.json')
        assert receipt['scenario'] in known and receipt['vm_sha256']==desktop
        assert sha(folder/'receipt.json')==known[receipt['scenario']]['receipt_sha256']
        images.append(dict(path=relative.as_posix(),sha256=row['sha256'],size=size,
            purpose=row['purpose'],observations=row['observations'],scenario=receipt['scenario'],vm_sha256=desktop))
    assert len(images)==len({row['path'] for row in images})
    assert {row['sha256'] for row in images}==set(review['image_sha256'])
    for rate in (30,60):
        for filename in ('presentation117-native-titles.png','presentation117-custom-titles.png'):
            assert any(Path(row['path']).name==filename and row['scenario'].split(',')[3]==str(rate)
                and row['scenario'].split(',')[6]=='presentation117titles' for row in images),(rate,filename)
        for area in ('caves','cavesinv'):
            for mode in ('presentation117flowerplain','presentation117flowerwish'):
                assert any(Path(row['path']).name=='presentation117-flower.png'
                    and row['scenario'].split(',')[0]==area
                    and row['scenario'].split(',')[1]=='3'
                    and row['scenario'].split(',')[3]==str(rate)
                    and row['scenario'].split(',')[6]==mode for row in images),(area,rate,mode,'flower')
    assert any(Path(row['path']).name=='video-options117.png'
        and row['scenario'].split(',')[6]=='clock117option' for row in images),('option','native video switch')
    return images


def collect_profiles(plan,desktop):
    profiles=[];seen=set()
    expected={'clock117travel','clock117cache','clock117freeze','clock117pause','clock117phase','clock117auto','clock117option','clock117powered'}
    for scenario in plan.ALL:
        fields=scenario.split(',')
        if len(fields)<7 or fields[6] not in expected:continue
        mode=fields[6]
        folder,receipt,values=log_payloads(scenario,'HARDMODE CLOCK117 RESULT',desktop)
        assert len(values)==1,(scenario,'No complete clock observation')
        measure=values[0]
        assert measure['status']=='PASS' and measure['mode']==mode and measure['physical_device'] is False
        assert measure['native_frames']>0 and measure['checks']>0 and measure['wall_seconds']>0
        _,_,samples=log_payloads(scenario,'HARDMODE CLOCK117 SAMPLE',desktop)
        for sample in samples:assert sample['physical_device'] is False and sample['mode']==mode
        if mode=='clock117travel':
            assert len(samples)==5 and [sample['cap'] for sample in samples]==[60,30,60,30,60]
            for sample in samples:
                assert sample['logic_units']>=60 and 3<sample['player_per_unit']<4.2
                for field in ('old_bullet_distance','fresh_bullet_distance'):
                    assert abs(sample[field]-6*sample['logic_units'])<.1
        elif mode=='clock117powered':
            assert len(samples)==6 and measure['cap']==60 and measure['time_scale']==.5
            assert {(sample['phase'],sample['actor']) for sample in samples}=={
                (phase,actor) for phase in range(3) for actor in ('Rocket','JockRocket')}
            for actor,acceleration,limit,first_max in (('Rocket',2,12,6),('JockRocket',.3,5,17)):
                rows=sorted((sample for sample in samples if sample['actor']==actor),key=lambda sample:sample['phase'])
                assert [sample['cap'] for sample in rows]==[60,30,60]
                assert [sample['time_scale'] for sample in rows]==[.5,1,.5]
                previous_distance=0;previous_ticks=0
                for phase,sample in enumerate(rows):
                    assert sample['logic_units']>=[2,2,26][phase] and sample['wall_seconds']>0
                    assert sample['accel_ticks']>previous_ticks
                    assert abs(sample['maximum_logical_speed']-limit)<.000001
                    expected_speed=min(limit,acceleration*sample['accel_ticks'])
                    assert abs(sample['logical_speed']-expected_speed)<.000001
                    assert abs(sample['expected_logical_speed']-expected_speed)<.000001
                    assert abs(sample['old_distance']-sample['expected_native_distance'])<=6.001
                    assert abs(sample['old_distance']-previous_distance-sample['fresh_phase_distance'])<=.001
                    assert sample['first_max_tick']==(first_max if sample['accel_ticks']>=first_max else -1)
                    previous_distance=sample['old_distance'];previous_ticks=sample['accel_ticks']
                assert rows[-1]['accel_ticks']>=30 and rows[-1]['first_max_tick']==first_max
                assert abs(rows[-1]['old_distance']-rows[-1]['reference_30hz_distance'])<=6.001
        elif mode in ('clock117freeze','clock117pause'):
            assert len(samples)==1 and samples[0]['cap']==(60 if mode=='clock117pause' else 30)
            assert abs(samples[0]['old_bullet_distance']-6*samples[0]['logic_units'])<.1
            if mode=='clock117pause':assert samples[0]['player_distance']/samples[0]['logic_units']>3
        elif mode=='clock117auto':
            assert len(samples)==1 and samples[0]['cap']==60 and 7<samples[0]['recovery_seconds']<12
        elif mode=='clock117option':
            assert len(samples)==1
            for field in ('default_enabled','native_menu_submission','persisted_disabled','reloaded_disabled'):
                assert samples[0][field] is True,(mode,field)
            assert samples[0]['screenshot']=='video-options117.png'
        seen.add(mode)
        profiles.append(dict(scenario=scenario,vm_sha256=desktop,host_cpu_only=True,
            runner_log_sha256=sha(folder/'runner.log'),measurements=[measure],samples=samples))
    assert seen==expected,('Missing current clock cases',expected-seen)
    return profiles


def main():
    assert (VERSION,BUILD)==('1.1.7',21)
    plan=importlib.import_module('release1107_test_plan')
    assert not plan.PENDING_REQUIREMENTS,('Finalize the current nine-item gate first',plan.PENDING_REQUIREMENTS)
    frozen,desktop=inherited.verify_source()
    build_source=retained.verify_build_source(frozen,desktop)
    rows,checks=retained.verify_plan_and_runtime(plan,desktop)
    native_boss_sequences=verify_native_boss_sequences(plan,desktop)
    clock_source_units=verify_clock_source_units1117()
    functions,pairs=production()
    game=inherited.Game((ROOT/'build-windows/nuclearthronemobile.win').read_bytes())
    verify_code(game,functions,pairs,'final desktop')
    artwork=inherited.verify_artwork(game,'final desktop')
    corpse_artwork=verify_corpse_art(game,'final desktop')
    artifacts=package_gate.verify_packages(desktop,functions,pairs,verify_code)
    platform_audits=inherited.verify_platform_audits()
    scope=verify_scope(plan);visuals=verify_visuals(desktop,rows)
    profiles=collect_profiles(plan,desktop)
    baseline=read(OUT/'baseline.json')
    assert (baseline['version'],baseline['build'])==('1.1.6',20)
    report=dict(status='PASS',version=VERSION,build=BUILD,package=PACKAGE,mod='Hardmode b24',
        verified_utc=datetime.now(timezone.utc).isoformat(),installation_packages_generated=True,
        source_manifest_sha256=sha(OUT/'final-source.json'),source_code_archive_sha256=sha(OUT/'final-code.zip'),
        test_plan_sha256=sha(OUT/'test-plan.json'),final_desktop_vm_sha256=desktop,
        source_bound_host_build=build_source,original_files_verified=frozen['original_files_verified'],
        user_items=9,gameplay_cases=len(plan.REQUIRED),regression_cases=len(plan.REGRESSIONS),
        total_cases=len(plan.ALL),checks=checks,runtime_cases=rows,artifacts=artifacts,
        compiled_repair_functions=functions,production_call_edges=[dict(caller=a,callee=b) for a,b in pairs],
        native_boss_sequences=native_boss_sequences,scope=scope,scope_coverage_sha256=scope['sha256'],
        clock_source_units=clock_source_units,
        visual_evidence=visuals,visual_review_sha256=sha(OUT/'visual-review.json'),
        desktop_compiled_artwork=artwork,corpse_artwork=corpse_artwork,
        platform_audits=platform_audits,host_cpu_profiles=profiles,
        baseline_provenance=baseline,baseline_is_not_current_acceptance=True,
        acceptance_scope='nine current requests; no claim of a repeated full historical suite',
        grillskills_imported=False,physical_device_tested=False,mac_native_rebuild=False,
        ios_requires_resigning=True,uploaded=False,
        test_audio='sound-resource gains zeroed in a separate VM; session muted at 0%',
        foreground_window_control_used=False,
        limits=['Silent isolated Windows host-VM acceptance, not physical Android/iPhone acceptance.',
            'Clock and host CPU observations do not guarantee 60 FPS on every phone or high-Loop population.',
            'Chief Loop1+ rest factor 0.8 is an explicitly authorized new balance value, not a verified desktop formula.',
            'The requested original reference video was unavailable during this release inspection.',
            'iOS uses a compatible retained native runner, fresh game resources and requires re-signing.'])
    (OUT/'delivery-receipt.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n','utf8')
    print('Final incremental delivery PASS',VERSION,'build',BUILD,len(plan.ALL),'scenarios',checks,'assertions')


if __name__=='__main__':main()
