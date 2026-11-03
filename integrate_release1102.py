"""Incremental mobile adaptation of the four native sewer/Captain changes."""
from pathlib import Path
import hashlib
import json
import re
from create_project import load
from register_native import register_script

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT/'project'
OUT=ROOT/'release1102'
CHANGED=[]


def save(relative,text):
    path=PROJECT/relative
    if path.read_text('utf8')==text:return
    backup=OUT/'baseline'/relative
    if not backup.exists():
        backup.parent.mkdir(parents=True,exist_ok=True);backup.write_bytes(path.read_bytes())
    path.write_text(text,'utf8');CHANGED.append(relative)


def edit(relative,old,new):
    text=(PROJECT/relative).read_text('utf8')
    if new in text:return
    assert text.count(old)==1,(relative,old,text.count(old))
    save(relative,text.replace(old,new,1))


def replace_function(relative,name,body):
    text=(PROJECT/relative).read_text('utf8')
    match=re.search(r'^function '+re.escape(name)+r'\([^\n]*\)\s*\{',text,re.M)
    assert match,(relative,name)
    start=match.end();depth=1;end=None
    for token in re.finditer(r'//[^\n]*|/\*[\s\S]*?\*/|"(?:\\.|[^"\\])*"|\{\|\}|[{}]',text[start:]):
        value=token[0]
        if value=='{':depth+=1
        elif value=='}':
            depth-=1
            if depth==0:end=start+token.start();break
    assert end is not None,(relative,name)
    save(relative,text[:start]+'\n'+body+'\n'+text[end:])


def main():
    OUT.mkdir(exist_ok=True)
    assert (OUT/'baseline-source.json').exists(),'Freeze the previous release first'
    project=load(PROJECT/'nuclearthronemobile.yyp')
    register_script(project,'scrHMRepairs1102',(ROOT/'native/repairs1102.gml').read_text('utf8'))
    helper='scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml'
    replace_function(helper,'hm_arkintide_mod_gml_hm_idpd_portal_sprite','scrHMIDPDPortalSprite1102();')
    replace_function(helper,'hm_arkintide_mod_gml_hm_elevator_step','scrHMElevatorStep1102();')
    replace_function(helper,'hm_arkintide_mod_gml_hm_gungod_replace_tick','scrHMReplacementTick1102();')
    props='scripts/scrHMCompiled_props_mod_gml/scrHMCompiled_props_mod_gml.gml'
    replace_function(props,'hm_props_mod_gml_elevator_step','scrHMElevatorStep1102();')
    edit(props,'hm_elevator_exit = noone;','hm_elevator_exit = noone;\nmask_index=mskNone;')
    area='scripts/scrHMCompiled_areas_elevator_area_gml/scrHMCompiled_areas_elevator_area_gml.gml'
    edit(area,'scrHMInstances(instance_create(0, 0, CustomEnemy))','scrHMInstances(noone) /* no invisible portalblocker */')
    maincode='scripts/scrHMCompiled_maincode_mod_gml/scrHMCompiled_maincode_mod_gml.gml'
    edit(maincode,'function hm_maincode_mod_gml_game_start() {',
         'function hm_maincode_mod_gml_game_start() {\nGameCont.hm_chief_seen=false;')
    gun='scripts/scrHMCompiled_bosses_gungod_mod_gml/scrHMCompiled_bosses_gungod_mod_gml.gml'
    edit(gun,'repeat (choose(1, 2, 3, 4)) {','repeat (choose(1, 2, 3, 4)+max(0,floor(GameCont.loops))) {')
    # Use synchronous cache lifetime only around the host's hitme traversal.
    for relative in ['scripts/scrHMRepairs104/scrHMRepairs104.gml']:
        edit(relative,'var _player=instance_nearest(x,y,Player),_map=HMWorld.hm_water_map;\n    with(hitme)',
             'var _player=instance_nearest(x,y,Player),_map=HMWorld.hm_water_map;\n    scrHMWaterBatchBegin1102();\n    with(hitme)')
        edit(relative,'    with(Crab) friction=.8*timescale*timescale;',
             '    scrHMWaterBatchEnd1102();\n    with(Crab) friction=.8*timescale*timescale;')
    relative='scripts/scrHMRepairs109/scrHMRepairs109.gml'
    edit(relative,'function scrHMWaterExact109(_x,_y) {',
         'function scrHMWaterExact109(_x,_y) {\n    if(variable_instance_get(HMWorld,"hm_water_batch1102")??false) return scrHMWaterExact1102(_x,_y);')
    edit('objects/Last/Step_0.gml','// One-shot Hardmode portrait freeze.',
         'if(scrHMEnabled() && scrHMChiefStep1102()) exit;\n// One-shot Hardmode portrait freeze.')
    edit('objects/Last/Destroy_0.gml','if (instance_exists(Player)) scrOnPopoKill()',
         'if(scrHMEnabled() && scrHMChiefDeath1102()) exit;\nif (instance_exists(Player)) scrOnPopoKill()')
    edit('objects/Corpse/Alarm_0.gml','if GameCont.area == area_hq {',
         'if (GameCont.area == area_hq || (scrHMEnabled() && array_contains([scrHMAreaResolve("elevator"),scrHMAreaResolve("HQ")],GameCont.area))) {')
    relative='objects/LastBall/Destroy_0.gml'
    source=(PROJECT/relative).read_text('utf8')
    if 'scrHMChiefBallBurst1102();' not in source:save(relative,source.rstrip()+'\n\nscrHMChiefBallBurst1102();\n')
    edit('scripts/scrBossIntro/scrBossIntro.gml','function scrBossIntro(_boss_index)',
         'function scrBossIntro(_boss_index,_force=false)')
    edit('scripts/scrBossIntro/scrBossIntro.gml','GameCont.loops>0) return;',
         'GameCont.loops>0 && !_force) return;')
    edit('scripts/scrHMRepairs1101/scrHMRepairs1101.gml','if(_name=="hm_yv_phase") return true;',
         'if(array_contains(["hm_yv_phase","hm_chief","hm_chief_departure"],_name)) return true;')
    test=(ROOT/'tests/repairs1102.gml')
    if test.exists():
        register_script(project,'scrHMGameplay1102',test.read_text('utf8'))
        edit('scripts/scrHMGameplayTests/scrHMGameplayTests.gml',
             'if(string_pos("sync111",mode)==1) scrHMGameplay1101();',
             'if(string_pos("sync111",mode)==1) scrHMGameplay1101();\n        if(string_pos("sync112",mode)==1) scrHMGameplay1102();')
        edit('scripts/scrHMGameplayTests/scrHMGameplayTests.gml',
             '"vault110","music112"],self[$ "mode"])',
             '"vault110","music112","sync112exit"],self[$ "mode"])')
    (PROJECT/'nuclearthronemobile.yyp').write_text(json.dumps(project,ensure_ascii=False,indent=2)+'\n','utf8')
    # Mirror targeted changes in durable host sources, without replaying any
    # historical full importer over the completed 1.1.1 project.
    for name in ('repairs104','repairs109','repairs1101'):
        path=ROOT/'native'/(name+'.gml')
        current=(PROJECT/'scripts'/('scrHM'+name[0].upper()+name[1:])/('scrHM'+name[0].upper()+name[1:]+'.gml')).read_text('utf8')
        path.write_text(current,'utf8')
    binding=json.loads((ROOT.parent/'hardmode-ntt100034/validation/sewer-chief-checks.json').read_text('utf8'))
    changed=set(CHANGED)|{p.relative_to(OUT/'baseline').as_posix() for p in (OUT/'baseline').rglob('*') if p.is_file()}
    result={'native_production_sha256':binding['production_sha256'],'changed_project':sorted(changed),
            'native_evidence':'../hardmode-ntt100034/validation/sewer-chief-checks.json',
            'adaptations':['Mobile water material/shore/five-point rules preserved',
                'Host uses IDPD portal type2, not native NTT type3',
                'Host Last identity retains native alarms/motion and intercepts only outside-HQ ending',
                'Both replacement slots start at Loop1, retaining the existing mobile Venus threshold',
                'Throne and Venus explicitly excluded for both replacement types',
                'No Grillskills import; existing mobile mutation UI retained']}
    (OUT/'sync-plan.json').write_text(json.dumps(result,indent=2)+'\n','utf8')
    print('Registered mobile four-change sync',len(CHANGED),'project edits')


if __name__=='__main__':main()
