"""Stage native content through the existing mobile AST/coroutine compiler.

No playable source is changed here. The staged output and compatibility audit
are reviewed before registration. Desktop-only UI hooks are not imported.
"""
from pathlib import Path
import json,re,copy,hashlib,difflib,importlib,faulthandler
from plan_sync1100 import ROOT,NATIVE,OUT,clean,save,signature
from gml_parser import definitions,Node
from native_compiler import Emitter,safe,walk
from runtime_schema import API

HELPER='arkintide.mod.gml'
ALIASES={
 'script_ref_create_ext':'scrHMContentRef1100',
 'mod_script_exists':'scrHMContentExists1100',
 'mod_script_get':'scrHMContentRef1100',
 'current_time_scale':'1',
 'array_length_1d':'array_length',
 'ds_map_set':'ds_map_replace',
 'instance_animation_end_expected':'scrHMAnimationEnd1100',
 'event_perform_object':'scrHMContentEvent1100',
 'instance_change':'scrHMContentChange1100',
 'array_find_index':'scrHMArrayFind1100',
 'current_frame_is_active':'scrHMReadyTick',
 'projectile_hit':'scr_projectile_hit',
 'player_count_race':'scrPlayerCountRace',
 'pickup_drop':'scrHMPickupDrop1100',
 'object_has_event':'scrHMObjectHasEvent1100',
 'script_bind_step':'scrHMBindStep1100',
 'sprGoldTankRocket':'sprGoldRocket',
 'sprVanPortalCharge':'sprVanPortalStart',
 'CustomStep':'HMBinding',
 'CustomBeginStep':'HMBinding',
 'CustomEndStep':'HMBinding',
 'CustomSlash':'Slash',
 'CustomChest':'WeaponChest',
 'CustomDraw':'HMBinding',
 '__maxhealth_init':'hm_maxhealth_init',
 'opt_bossintros':'opt_bossintro',
}

class MobileEmitter(Emitter):
    def domain(self,node):
        if self.definition.name=='hm_extra_pool' and node.kind=='identifier' and node.args[0]=='_area':return 'Area'
        return super().domain(node)
    def identifier(self,value):
        if value not in self.locals:
            if value in ALIASES:return ALIASES[value]
            if value in self.definitions[HELPER]:return 'hm_'+safe(HELPER)+'_'+value
        return super().identifier(value)
    def expression(self,node,condition=False,lvalue=False):
        if node.kind=='member' and node.args[0].kind=='identifier' and node.args[0].args==['GameCont']:
            if node.args[1]=='maxlevel':return 'GameCont.hm_maxlevel1100'
            if node.args[1]=='vaults':return 'GameCont.crownvisits'
        return super().expression(node,condition,lvalue)

def carry_ast(path,newdefs):
    oldfile=ROOT/'reference/hardmode-b24'/path
    if not oldfile.exists():return []
    oldtext=oldfile.read_text('utf8');newtext=clean((NATIVE/'mod'/path).read_text('utf8'))
    olddefs={d.name:d for d in definitions(oldtext,path)}
    linemap={}
    for a,b,size in difflib.SequenceMatcher(None,oldtext.splitlines(),newtext.splitlines(),autojunk=True).get_matching_blocks():
        for i in range(size):linemap[a+i+1]=b+i+1
    records=[]
    for current in newdefs:
        if current.name not in olddefs:continue
        base=olddefs[current.name];ours=copy.deepcopy(base)
        for release in (103,104,107,108,109):
            importlib.import_module('repairs'+str(release)).ast_repair(path,ours,walk)
        memo={}
        def finger(value):
            if isinstance(value,Node):
                key=id(value)
                if key not in memo:memo[key]=hashlib.sha256(value.kind.encode()+finger(value.args)).digest()
                return memo[key]
            if isinstance(value,(list,tuple)):return hashlib.sha256(b''.join(finger(v) for v in value)).digest()
            return hashlib.sha256(repr(value).encode()).digest()
        def edits(a,b):
            if finger(a)==finger(b):return []
            if isinstance(a,Node) and isinstance(b,Node) and a.kind==b.kind and len(a.args)==len(b.args):
                result=[]
                for x,y in zip(a.args,b.args):
                    if isinstance(x,Node) and isinstance(y,Node):result+=edits(x,y)
                    elif finger(x)!=finger(y):return [(a,b)]
                return result
            return [(a,b)]
        for original,replacement in edits(base.body,ours.body):
            target=finger(original)
            candidates=[n for n in walk(current.body) if n.kind==original.kind and finger(n)==target]
            expected=linemap.get(original.line)
            match=[n for n in candidates if n.line==expected] if expected is not None else []
            if len(match)!=1 and len(candidates)==1:match=candidates
            if len(match)==1:
                node=match[0];node.kind,node.args=replacement.kind,copy.deepcopy(replacement.args)
                records.append({'source':path,'definition':current.name,'old_line':original.line,'status':'CARRIED_UNCHANGED_SUBTREE'})
            else:records.append({'source':path,'definition':current.name,'old_line':original.line,'status':'NATIVE_REPLACED_SUBTREE_REVIEW'})
    return records

def main():
    faulthandler.dump_traceback_later(25,repeat=False)
    dest=OUT/'staged';dest.mkdir(exist_ok=True)
    inventory=json.loads((ROOT/'mod-inventory.json').read_text('utf8'))
    sources=[m['path'] for m in inventory['modules']]+[HELPER,'hm_bossbar.mod.gml']
    parsed={p:definitions(clean((NATIVE/'mod'/p).read_text('utf8')),p) for p in sources}
    names={p:{d.name for d in ds} for p,ds in parsed.items()}
    carried=[]
    for p,ds in parsed.items():
        print('Carry mobile contracts:',p,flush=True)
        carried+=carry_ast(p,ds)
    save(OUT/'portable-ast-review.json',carried)
    art=json.loads((ROOT/'artwork-manifest.json').read_text('utf8'))['artwork']
    art_by_call={}
    for p in sources:
        old=ROOT/'reference/hardmode-b24'/p
        if not old.exists():continue
        old_defs=definitions(old.read_text('utf8'),p)
        rows={r['line']:r for r in art if r['source']==p}
        for d in old_defs:
            for n in walk(d.body):
                if n.kind=='call' and n.args[0].kind=='identifier' and 'base64' in n.args[0].args[0]:
                    art_by_call[signature(n)]=rows[n.line]
    artwork={};missing=[]
    extra=json.loads((OUT/'content-artwork.json').read_text('utf8')) if (OUT/'content-artwork.json').exists() else []
    extra_map={(r['source'],r['line']):r for r in extra}
    for p,ds in parsed.items():
        for d in ds:
            for n in walk(d.body):
                if n.kind=='call' and n.args[0].kind=='identifier' and 'base64' in n.args[0].args[0]:
                    row=art_by_call.get(signature(n)) or extra_map.get((p,n.line))
                    if row:artwork[(p,n.line)]=row
                    else:missing.append({'source':p,'definition':d.name,'line':n.line,'call':n.args[0].args[0],
                                         'string_lengths':[len(a.args[0]) for a in n.args[1] if a.kind=='string']})
    save(OUT/'new-artwork-required.json',missing)
    # Baseline functions remain available. Changed definitions are staged
    # independently; native->mobile platform fixes are audited explicitly.
    delta=json.loads((OUT/'definition-delta.json').read_text('utf8'))['definitions']
    selected={(r['source'],r['definition']) for r in delta}
    records=[];failures=[]
    for p,ds in parsed.items():
        text=[]
        for d in ds:
            if p not in {HELPER,'hm_bossbar.mod.gml'} and (p,d.name) not in selected:continue
            if p=='options.mod.gml' and d.name.startswith('hm_settings'):continue
            try:
                emitter=MobileEmitter(p,d,names,artwork)
                code=emitter.emit()
                # GameMaker's synchronous switch requires constant labels.
                ids={k:int(v) for k,v in re.findall(r'global.hm_area_ids\[\$ "([^\"]+)"\]=(-?\d+);',(ROOT/'project/scripts/scrHMIdentities/scrHMIdentities.gml').read_text('utf8'))}
                ids.update({'cavesecret':201,'yeti':200,'idpd':206,'jungleboogie':209,'sewersentrance':218,'space':207})
                def constant(match):
                    value=json.loads(match[1]);return 'case '+str(ids[value] if isinstance(value,str) else value)+':'
                code=re.sub(r'case scrHMAreaResolve\(("[^\"]+"|-?\d+)\):',constant,code)
                text.append('// Native source '+p+'::'+d.name+'\n'+code)
                records.append({'source':p,'name':d.name,'function':emitter.native_name,'async':emitter.async_mode,'calls':sorted(emitter.calls)})
            except Exception as error:failures.append({'source':p,'name':d.name,'error':repr(error)[:350]})
        (dest/(safe(p)+'.gml')).write_text('\n\n'.join(text)+'\n',encoding='utf8')
    save(OUT/'staged-compilation.json',{'definitions':records,'failures':failures,'new_artwork':missing})
    print('Staged',len(records),'definitions; failures',len(failures),'new artwork',len(missing))
    for row in failures:print(row)
    faulthandler.cancel_dump_traceback_later()

if __name__=='__main__':main()
