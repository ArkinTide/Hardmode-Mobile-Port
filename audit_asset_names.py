import json,re,difflib
from create_project import load
from native_compiler import ROOT,walk
from gml_parser import parse_inventory
from runtime_schema import FIELD_ALIASES
resources={r['id']['name'] for r in load(ROOT/'project/nuclearthronemobile.yyp')['resources']}
modules,errors=parse_inventory(ROOT)
assert not errors,errors
missing={}
object_candidates={}
for source,defs in modules.items():
    for definition in defs:
        for node in walk(definition.body):
            if node.kind!='identifier':continue
            name=node.args[0]
            if re.match(r'^[A-Z]',name) and name not in resources and name not in definition.parameters:
                object_candidates.setdefault(name,[]).append(f'{source}:{node.line}')
            if re.match(r'^(spr|snd|msk|mus|amb|shd|fnt)[A-Z0-9]',name) and FIELD_ALIASES.get(name,name) not in resources:
                missing.setdefault(name,[]).append(f'{source}:{node.line}')
for name,locations in missing.items():
    print(name,locations[:4],difflib.get_close_matches(name,resources,n=3,cutoff=.68))
(ROOT/'asset-name-audit.json').write_text(json.dumps(missing,indent=2)+'\n',encoding='utf8')
print('OBJECT CANDIDATES',object_candidates)
assert not missing, 'Unresolved legacy assets (including fonts)'
