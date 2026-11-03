"""Register the audited native definition delta into the preserved mobile host."""
import json,re,zipfile,importlib
from plan_sync1100 import ROOT,OUT,save
from compile_sync1100 import safe,HELPER
from create_project import load
from register_native import PROJECT,register_script,write
from runtime_schema import module_key

# These are host presentations, not missing content. Mobile retains its own
# compact wall renderer, language bootstrap, settings and mutation selector.
HOST={('maincode.mod.gml','__load'),('areas/venuz.area.gml','__load'),
      ('areas/venuz.area.gml','area_make_floor'),
      ('options.mod.gml','step'),('options.mod.gml','draw_gui')}

def chunks(text,kind):
    pat=r'^// '+kind+r' ([^\n]+)\n'
    starts=list(re.finditer(pat,text,re.M));result={}
    for i,m in enumerate(starts):
        stop=starts[i+1].start() if i+1<len(starts) else len(text)
        code=text[m.end():stop].rstrip()
        f=re.search(r'^function (\w+)\(',code,re.M)
        if f:result[f[1]]=(m.start(),stop,text[m.start():stop],code)
    return result

def portable(path,name,code,review):
    if path==HELPER:
        overrides={
          'hm_water_tick':'scrHMSewerTick();',
          'hm_crown_watch':'scrHMCrownWatch1100();',
          'hm_portal_style_commit':'scrHMPortalStyle1100(_hml__portal);',
          'hm_portal_style_tick':'scrHMPortalTick1100();',
          'hm_tool_chest':'scrHMToolChest1100();',
          'hm_van_recheck_exit':'scrHMVanRecheckExit1100();',
          'hm_native_unlock_area':'scrUnlocksArea();',
          'hm_map_budget':'scrHMLoopMapSetup110();',
          'hm_throne_generator_zone':'return scrHMThroneGeneratorZone1100();',
          'hm_water_link':'if(instance_exists(_hml__floor)) {_hml__floor.hm_water_surface=id;_hml__floor.hm_water_surface111=id;} if(instance_exists(HMWorld)) HMWorld.hm_water_map=undefined;',
        }
        if name in overrides:
            review.append({'source':path,'name':name,'status':'MOBILE_HOST_ADAPTER'})
            return code[:code.index('{')+1]+'\n'+overrides[name]+'\n}\n'
    # Earlier releases contain host-only compatibility fixes alongside old
    # balance changes. Apply only the relevant platform contracts.
    for release in (104,105,106,107,108,109):
        if release==108 and path=='enemies.mod.gml':continue
        if release==109 and path!='bosses/guardianboss.mod.gml':continue
        if (path,name) in {('maincode.mod.gml','step'),('props.mod.gml','step'),('props.mod.gml','joao_shockwave'),
                           ('enemies.mod.gml','step'),('props.mod.gml','fishskull_create')} :continue
        try:
            updated=importlib.import_module('repairs'+str(release)).emitted_repair(path,name,code)
            if updated!=code:review.append({'source':path,'name':name,'pass':release,'status':'APPLIED'})
            code=updated
        except (AssertionError,ValueError) as error:
            review.append({'source':path,'name':name,'pass':release,'status':'NATIVE_SUPERSEDES_REVIEW','error':str(error)[:180]})
    # Atomic native API names are adapted before the mobile text passes.
    code=code.replace('scrHMContentChange1100(RavenFly, true);','scrHMContentChange1100(RavenFly,false);emergencylanding=0;z=0;')
    code=code.replace('scrHMContentChange1100(Wind, 1);','scrHMContentChange1100(Wind,false);')
    code=re.sub(r'\(current_frame mod (\d+)\)',r'(floor(current_frame) mod \1)',code)
    # Instance names must not bind to an unrelated coroutine local.
    code=code.replace('_hm.vars.name = "3dvan";','name = "3dvan";hm_freak107=GameCont.loops>=3;')
    code=code.replace('(id mod 6)','scrHMStagger1100()')
    code=code.replace('view_shake[index] += 8;','scr_screenshake(8);')
    if path==HELPER and name=='hm_native_begin':
        # The mobile corpse already excludes Technomancer revival and owns
        # the animation/last-kill exit timer. NTT's decorative conversion
        # expects do_portal, which is not the host's forceportal contract.
        marker='{ var __hm_with10 = scrHMMatching(Corpse, "sprite_index", sprTechnoMancerDead)'
        assert marker in code
        code=code[:code.index(marker)]+'// Mobile retains its protected native corpse lifecycle.\n}\n'
        review.append({'source':path,'name':name,'status':'MOBILE_CORPSE_LIFECYCLE'})
    if path==HELPER and name=='hm_debug_goto':
        code=code.replace('type = 3;','type = 2;')
    if path==HELPER and name=='hm_bullet_maggot_allowed':
        code=code.replace('hitid == 12','hitid == HitId.SuperFrog')
    if path==HELPER and name=='hm_van_warning':
        code=code.replace('scrHMDelete(id);','scrHMMenuDrawComplete();')
    if (path,name) in {('areas/sewers.area.gml','area_start'),(HELPER,'hm_extra_water_prepare')}:
        # The mobile Floor uses 2 as water's material ID. Its movement adapter
        # applies the native .45 friction separately; do not store that friction
        # in a material field read by all shoreline and swimming queries.
        code=code.replace('traction = 0.45;','traction = 2;')
    if path=='maincode.mod.gml' and name=='step':
        # NTT uses 3/4 for police/Venus spirals; the host enum is 2/3.
        code=re.sub(r'\btype = ([34]);',lambda m:'type = '+{'3':'2','4':'3'}[m[1]]+';',code)
        code=code.replace('scrHMMatchingNE(Wall, "thing", 1)','scrHMMatchingNE(scrHMAuthoredWalls105(), "thing", 1)')
        code=code.replace('scrHMMatching(Wall, "thing", undefined)','scrHMMatching(scrHMAuthoredWalls105(), "thing", undefined)')
        code=code.replace('(!scrHMVariableExists(_hm.scope, "van"))','(!instance_is(id,Van) && !scrHMVariableExists(_hm.scope, "van"))')
    if path=='areas/venuz.area.gml' and name=='area_finish':
        code=code.replace('type = 4;','type = 3;')
    if path=='maincode.mod.gml' and name=='sewerboi':
        opening='function hm_maincode_mod_gml_sewerboi() {'
        code=code.replace(opening,opening+'\nif(scrHMRatWaterDraw1100()) return;',1)
    return code

def main():
    report=json.loads((OUT/'staged-compilation.json').read_text('utf8'));assert not report['failures'] and not report['new_artwork']
    project=load(PROJECT/'nuclearthronemobile.yyp');review=[];installed=[]
    with zipfile.ZipFile(OUT/'baseline-code.zip') as baseline:
        sources=sorted({r['source'] for r in report['definitions']})
        for source in sources:
            name='scrHMCompiled_'+safe(source);relative='scripts/'+name+'/'+name+'.gml'
            fresh=(OUT/'staged'/(safe(source)+'.gml')).read_text('utf8');news=chunks(fresh,'Native source')
            if source in {HELPER,'hm_bossbar.mod.gml'}:
                blocks=[]
                for key,(_,_,_,code) in news.items():
                    short=key.removeprefix('hm_'+safe(source)+'_')
                    code=portable(source,short,code,review)
                    blocks.append('// Source '+source+':0; '+short+' (native content 1.1.0)\n'+code)
                register_script(project,name,'\n\n'.join(blocks));installed.extend({'source':source,'function':k} for k in news);continue
            text=baseline.read(relative).decode('utf8');olds=chunks(text,'Source');add=[];replacements=[]
            for key,(_,_,_,code) in news.items():
                short=key.removeprefix('hm_'+safe(source)+'_')
                if (source,short) in HOST:review.append({'source':source,'name':short,'status':'MOBILE_HOST_RETAINED'});continue
                code=portable(source,short,code,review)
                block='// Source '+source+':0; '+short+' (native content 1.1.0)\n'+code+'\n\n'
                if key in olds:
                    a,b,_,_=olds[key];replacements.append((a,b,block))
                else:add.append(block)
                installed.append({'source':source,'function':key})
            for a,b,block in sorted(replacements,reverse=True):text=text[:a]+block+text[b:]
            text+=''.join(add)
            register_script(project,name,text)
    register_script(project,'scrHMContent1100',(ROOT/'native/content1100.gml').read_text('utf8'))
    # Register helpers before all original modules, preserving native load order.
    registry=PROJECT/'scripts/scrHMRegistry/scrHMRegistry.gml'
    with zipfile.ZipFile(OUT/'baseline-code.zip') as baseline:
        text=baseline.read('scripts/scrHMRegistry/scrHMRegistry.gml').decode('utf8')
    for source,position in [(HELPER,'start'),('hm_bossbar.mod.gml','end')]:
        names=[r for r in report['definitions'] if r['source']==source]
        key='mod:'+source.removesuffix('.mod.gml')
        entry='scrHMRegisterModule('+json.dumps(key)+', {\n'+',\n'.join(json.dumps(r['name'])+': '+r['function'] for r in names)+'\n});\n'
        if entry not in text:
            if position=='start':text=text.replace('function scrHMRegisterModules() {','function scrHMRegisterModules() {\n'+entry,1)
            else:text=text[:text.rfind('}')]+entry+text[text.rfind('}'):]
    extra=[]
    for row in report['definitions']:
        source=row['source'];short=row['name']
        if source in {HELPER,'hm_bossbar.mod.gml'} or (source,short) in HOST:continue
        extra.append('global.hm_module_scripts[$ '+json.dumps(module_key(source))+'][$ '+json.dumps(short)+']='+row['function']+';')
    text=text[:text.rfind('}')]+ '\n'.join(extra)+'\n'+text[text.rfind('}'):]
    write(registry.relative_to(PROJECT),text)
    write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
    save(OUT/'portable-emission-review.json',review);save(OUT/'installed-definitions.json',installed)
    print('Registered content definitions',len(installed),'compatibility review entries',len(review))

if __name__=='__main__':main()
