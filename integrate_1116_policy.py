"""Narrow maintenance edits; never regenerate historical imported content."""
import json,re
from pathlib import Path

ROOT=Path(__file__).resolve().parent
P=ROOT/'project'

def edit(path,old,new,count=1):
    path=ROOT/path
    text=path.read_text('utf8')
    if new in text and old not in text:return
    assert text.count(old)==count,(path,old[:90],text.count(old))
    path.write_text(text.replace(old,new),'utf8')

def resource(name,source):
    folder=P/'scripts'/name;folder.mkdir(exist_ok=True)
    (folder/(name+'.gml')).write_text((ROOT/source).read_text('utf8'),'utf8')
    data=json.loads((P/'scripts/scrHMRepairs1115Root/scrHMRepairs1115Root.yy').read_text('utf8'))
    data['name']=data['%Name']=name
    (folder/(name+'.yy')).write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n','utf8')

def main():
    resource('scrHMRepairs1116Policy','native/repairs1116_policy.gml')
    ark='project/scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml'
    edit(ark,'var _hml_kind = PopoFreak;\n;\nif (((GameCont.loops >= scrHMLoopEnemyStart1115()) && (random(1) < 0.5))) {\n_hml_kind = choose(Grunt, Inspector, Shielder, EliteGrunt, EliteInspector, EliteShielder);\n}',
         'var _hml_kind = scrHMPoliceKind1116();')
    edit(ark,'GameCont.loops < scrHMLoopEnemyStart1115()','!scrHMPoliceLate1116()')
    edit(ark,'if ((random(1) < 0.5)) {\nreturn PopoFreak;\n}\nreturn choose(Grunt, Inspector, Shielder, EliteGrunt, EliteInspector, EliteShielder);',
         'return scrHMPoliceKind1116();')
    edit(ark,'if ((GameCont.loops >= 1)) {\nhm_arkintide_mod_gml_hm_extra_population();',
         'scrHMSnowPopulation1116();\nif ((GameCont.loops >= 3)) {\nhm_arkintide_mod_gml_hm_extra_population();')
    # Keep the generation gate inside the public entry as well. Direct tests
    # and any future caller must not bypass the population-level threshold.
    edit('native/sync1103_spawn.gml','function scrHMExtraPopulation1103() {',
         'function scrHMExtraPopulation1103() {\n    if(GameCont.loops<3) return;')
    edit('project/scripts/scrHMSync1103Spawn/scrHMSync1103Spawn.gml','function scrHMExtraPopulation1103() {',
         'function scrHMExtraPopulation1103() {\n    if(GameCont.loops<3) return;')
    # Low-level extra constructor remains available for controlled test
    # fixtures. Only gameplay generation owns this Loop3 policy.
    enemies='project/scripts/scrHMCompiled_enemies_mod_gml/scrHMCompiled_enemies_mod_gml.gml'
    edit(enemies,'GameCont.loops>=scrHMLoopEnemyStart1115()','scrHMPoliceLate1116()')
    edit(enemies,'GameCont.loops >= scrHMLoopEnemyStart1115()','scrHMPoliceLate1116()',3)
    # Preserve the existing normal/infantry batch gate. Its kind chooser
    # independently excludes Freaks until Loop3; gating the whole batch here
    # would bypass Hardmode arrival ownership and count rules in Loop1/2.
    for script,mirror in [('scrHMRepairs107','native/repairs107.gml'),('scrHMRepairs108','native/repairs108.gml')]:
        paths=[mirror,f'project/scripts/{script}/{script}.gml']
        for path in paths:
            if script=='scrHMRepairs107':
                edit(path,'function scrHMPoliceRevive107() {','function scrHMPoliceRevive107() {\n    if(scrHMPoliceRevivalBlocked1116()) return true;')
                edit(path,'if(!(self[$ "hm_freak107"]??false) || land!=1','if(!scrHMPoliceLate1116() || !(self[$ "hm_freak107"]??false) || land!=1')
            else:
                edit(path,'if(!scrHMEnabled() || GameCont.loops<3 || random(1)>=.5)\n        return instance_create(_x,_y,PopoFreak);\n    // Half of late-loop arrivals are regular/elite police, independently\n    // of their later revival. Native police Destroy owns that timer.\n    return instance_create(_x,_y,choose(Grunt,Inspector,Shielder,EliteGrunt,EliteInspector,EliteShielder));',
                     'return instance_create(_x,_y,scrHMPoliceKind1116());')
    edit('project/objects/PopoFreak/Create_0.gml','raddrop = 25',
         'if(scrHMEnabled() && !scrHMPoliceLate1116()) {instance_change(Grunt,true);exit;}\nraddrop = 25')
    edit('project/objects/PopoFreak/Destroy_0.gml','instance_create(x, y, WantRevivePopoFreak)',
         'if(!scrHMEnabled() || scrHMPoliceLate1116()) instance_create(x, y, WantRevivePopoFreak)')
    edit('project/objects/RevivePopoFreak/Alarm_0.gml','if(scrHMEnabled() && scrHMMessengerReviveEffect115()) exit;',
         'if(scrHMEnabled() && scrHMMessengerReviveEffect115()) exit;\nif(scrHMPoliceRevivalBlocked1116()) exit;')
    edit('project/scripts/scrRadDrop/scrRadDrop.gml','if(scrHMFinalBossNoRadiation1115()) return;',
         'if(scrHMFinalBossNoRadiation1115() || scrHMTankNoRadiation1116()) return;')
    props='project/scripts/scrHMCompiled_props_mod_gml/scrHMCompiled_props_mod_gml.gml'
    edit(props,'instance_create(x, y, PopoFreak);\nscrHMSoundPlay(sndFreakPopoRevive);',
         'if(!scrHMPoliceLate1116()) continue;\ninstance_create(x, y, PopoFreak);\nscrHMSoundPlay(sndFreakPopoRevive);')
    edit(props,'function hm_props_mod_gml_bigtube2_dead() {\ninstance_create(x, y, PopoFreak);',
         'function hm_props_mod_gml_bigtube2_dead() {\ninstance_create(x, y, scrHMPoliceKind1116());')
    edit('project/objects/BanditBoss/Create_0.gml','hitid = HitId.BigBandit','hitid = HitId.BigBandit\nscrHMStageBanditCreate1116();')
    draw='project/objects/BanditBoss/Draw_0.gml'
    edit(draw,'if gunangle <= 180 draw_sprite_ext(',
         'var _hm_sprite1116=sprite_index;\nif(scrHMEnabled() && (self[$ "hm_stage_jungle"]??false)) sprite_index=hm_arkintide_mod_gml_hm_extra_skin(sprite_index);\nif gunangle <= 180 draw_sprite_ext(')
    text=(ROOT/draw).read_text('utf8')
    if 'sprite_index=_hm_sprite1116;' not in text:(ROOT/draw).write_text(text+'\nsprite_index=_hm_sprite1116;\n','utf8')
    # Mirror only maintained functions; this old mirror intentionally has
    # other historical compiler differences and must not be bulk-regenerated.
    mirror=ROOT/'native/compiled_arkintide1103.gml';text=mirror.read_text('utf8')
    canonical=(ROOT/ark).read_text('utf8')
    for fn in ['hm_police_spawn','hm_police_revival','hm_infantry_kind','hm_batch_step','hm_stage_bandit_tick']:
        name='hm_arkintide_mod_gml_'+fn
        pat=rf'function {name}\([^\n]*\) \{{[\s\S]*?(?=\n// Source|\Z)'
        new=re.search(pat,canonical).group(0)
        text,n=re.subn(pat,lambda _:new,text,count=1);assert n==1,name
    mirror.write_text(text,'utf8')

if __name__=='__main__':main()
