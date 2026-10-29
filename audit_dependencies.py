"""Inventory native contracts still needed by the frozen MOD source."""
from collections import Counter, defaultdict
from pathlib import Path
import json
import re

from gml_parser import parse_inventory
from native_compiler import walk, Emitter
from runtime_schema import API

ROOT = Path(__file__).resolve().parent


def main():
    modules, errors = parse_inventory(ROOT)
    assert not errors, errors
    host = "\n".join(p.read_text(encoding="utf8") for p in (ROOT/"project/scripts").glob("*/*.gml") if not p.parent.name.startswith("scrHMCompiled"))
    funcs = set(re.findall(r"\bfunction\s+(\w+)\s*\(", host))
    called = Counter()
    locations = defaultdict(list)
    hooks = {}
    domains=defaultdict(set)
    names={source:{d.name for d in defs} for source,defs in modules.items()}
    for source, defs in modules.items():
        local = {d.name for d in defs}
        hooks[source] = [d.name for d in defs]
        for d in defs:
            emitter=Emitter(source,d,names,{})
            for n in walk(d.body):
                if n.kind=="binary" and emitter.domain(n.args[1]):
                    for child in walk(n.args[2]):
                        if child.kind=="string":domains[emitter.domain(n.args[1])].add(child.args[0][1:-1])
                if n.kind=="switch" and emitter.domain(n.args[0]):
                    for label,_ in n.args[1]:
                        if label and label.kind=="string":domains[emitter.domain(n.args[0])].add(label.args[0][1:-1])
                if n.kind == "call" and n.args[0].kind == "identifier":
                    name = n.args[0].args[0]
                    if name in local or name in API or name in funcs or "base64" in name or name == "fork":
                        continue
                    called[name] += 1
                    locations[name].append(f"{source}:{n.line}")
    report = {"unmapped_calls": [{"name": k, "count": v, "examples": locations[k][:4]} for k,v in called.most_common()], "hooks":hooks}
    (ROOT/"dependency-audit.json").write_text(json.dumps(report, indent=2)+"\n", encoding="utf8")
    print(json.dumps(report["unmapped_calls"], indent=2))
    print("HOOKS")
    for source, names in hooks.items():
        print(source, [n for n in names if not any(n.endswith(s) for s in ("_step","_draw","_create","_dead","_destroy","_death","_hurt","_hit","_wall"))])
    print("DOMAINS",{k:sorted(v) for k,v in domains.items()})


if __name__ == "__main__": main()
