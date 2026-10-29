"""Resolve every legacy object reference against the original NTT name table."""
import json,re
from create_project import load
from native_compiler import ROOT,walk
from gml_parser import parse_inventory
from runtime_schema import FIELD_ALIASES

resources={row['id']['name'] for row in load(ROOT/'project/nuclearthronemobile.yyp')['resources']}
original=set(re.findall(r'gml_Object_(.+?)_(?:Create|Destroy|Step|Alarm|Draw|Other|Collision|Mouse|KeyPress|KeyRelease|Keyboard|Trigger)_',
    (ROOT/'ntt-contracts-names.tsv').read_text(encoding='utf8')))
modules,errors=parse_inventory(ROOT)
assert not errors,errors
missing={}
for source,definitions in modules.items():
    for definition in definitions:
        locals_=set(definition.parameters)
        for node in walk(definition.body):
            if node.kind=='var':locals_.update(name for name,_ in node.args)
        for node in walk(definition.body):
            if node.kind!='identifier':continue
            name=node.args[0]
            if name in locals_ or name not in original:continue
            if FIELD_ALIASES.get(name,name) not in resources:
                missing.setdefault(name,[]).append(f'{source}:{node.line}')
(ROOT/'object-name-audit.json').write_text(json.dumps(missing,indent=2)+'\n',encoding='utf8')
print(json.dumps(missing,indent=2))
