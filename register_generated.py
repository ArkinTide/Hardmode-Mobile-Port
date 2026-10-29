"""Register generated function definitions, without activating incomplete gameplay."""
from pathlib import Path
import json

from create_project import load
from register_native import ROOT, PROJECT, register_script, write, replace
from native_compiler import safe, Emitter
from gml_parser import definitions


def main():
    project = load(PROJECT / "nuclearthronemobile.yyp")
    report = load(ROOT / "native-compilation-map.json")
    register_script(project, "scrHMCoroutines", (ROOT / "native/coroutines.gml").read_text(encoding="utf8"))
    for module in report["modules"]:
        name = "scrHMCompiled_" + safe(module["source"])
        register_script(project, name, (ROOT / module["generated"]).read_text(encoding="utf8"))
    fixture_path="tests/compiler-fixture.gml"
    fixture=definitions((ROOT/fixture_path).read_text(encoding="utf8"),fixture_path)
    names={fixture_path:{definition.name for definition in fixture}}
    fixture_code="\n".join(Emitter(fixture_path,definition,names,{}).emit() for definition in fixture)
    register_script(project,"scrHMCompilerTests",fixture_code+"\n"+(ROOT/"tests/compiler-native.gml").read_text(encoding="utf8"))
    obj=load(PROJECT/"objects/UberCont/UberCont.yy")
    obj["name"]=obj["%Name"]="HMTestProbe"
    obj["eventList"]=[];obj["persistent"]=False;obj["parentObjectId"]=None
    path="objects/HMTestProbe/HMTestProbe.yy"
    write(path,json.dumps(obj,indent=2)+"\n")
    if not any(entry["id"]["path"]==path for entry in project["resources"]):
        project["resources"].append({"id":{"name":"HMTestProbe","path":path}})
    write("nuclearthronemobile.yyp", json.dumps(project, ensure_ascii=False, indent=2) + "\n")
    replace("objects/MakeGame/Alarm_0.gml","if (scrHMArtworkTests()) exit;",
            "if (scrHMCompilerTests()) exit;\nif (scrHMArtworkTests()) exit;")
    print("Registered generated definitions only; no gameplay hooks enabled")


if __name__ == "__main__":
    main()
