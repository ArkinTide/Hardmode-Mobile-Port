"""Resolve literal inter-module calls against the enabled AST, never backups."""
from pathlib import Path
import json
from gml_parser import parse_inventory
from native_compiler import walk
from runtime_schema import module_key

ROOT=Path(__file__).resolve().parent
modules,errors=parse_inventory(ROOT)
assert not errors,errors
registry={module_key(s):{d.name for d in defs} for s,defs in modules.items()}
aliases={}
for s in modules:
    for a in ['mod:'+Path(s).name.split('.')[0],'mod:'+s.removesuffix('.gml').removesuffix('.mod')]:
        if a not in aliases or module_key(s).startswith('mod:'):aliases[a]=module_key(s)
missing=[];calls=[];dynamic=[]
for source,defs in modules.items():
    for definition in defs:
        for n in walk(definition.body):
            if n.kind!='call' or n.args[0].kind!='identifier' or n.args[0].args[0]!='mod_script_call':continue
            args=n.args[1]
            if not all(a.kind=='string' for a in args[:3]):
                dynamic.append([source,n.line]);continue
            kind,module,name=[a.args[0][1:-1] for a in args[:3]]
            if kind=='wep':kind='weapon'
            if module.startswith('areas/'):kind,module='area',module[6:]
            if module.startswith('weapons/'):kind,module='weapon',module[8:]
            module=module.removesuffix('.area')
            key=aliases.get(kind+':'+module,kind+':'+module)
            resolved='bigtube1_create' if (key,name)==('mod:props','bigtube_create') else name
            row={'source':source,'line':n.line,'module':key,'name':name,'resolved':resolved}
            calls.append(row)
            if resolved not in registry.get(key,set()):missing.append(row)
report={'calls':calls,'dynamic':dynamic,'missing':missing}
(ROOT/'mod-call-audit.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({'literal_calls':len(calls),'dynamic':dynamic,'missing':missing},indent=2))
assert not missing,'Unresolved inter-module calls'
