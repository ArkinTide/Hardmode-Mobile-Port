"""Generate the module/audio registry and register tested API code only.

Normal startup is intentionally not activated until area/actor/timing adapters
have been verified. The explicit --hardmode-runtime-tests path can exercise it.
"""
from pathlib import Path
import hashlib
import json
import shutil

from create_project import load
from gml_parser import parse_inventory, definitions
from native_compiler import Emitter, safe, walk
from register_native import ROOT, PROJECT, register_script, write, replace
from runtime_schema import module_key


def main():
    project=load(PROJECT/"nuclearthronemobile.yyp")
    modules,errors=parse_inventory(ROOT)
    assert not errors,errors
    code=["function scrHMRegisterModules() {"]
    aliases={}
    for source,defs in modules.items():
        funcs=",\n".join(json.dumps(d.name)+": hm_"+safe(source)+"_"+d.name for d in defs)
        code.append("scrHMRegisterModule("+json.dumps(module_key(source))+", {\n"+funcs+"\n});")
        stem=Path(source).name.split(".")[0]
        for alias in ["mod:"+stem,"mod:"+source.removesuffix(".gml").removesuffix(".mod")]:
            # Area throne loads later than bosses/throne. A shorthand MOD
            # name must still select the boss module, not shadow it.
            if alias not in aliases or module_key(source).startswith('mod:'):
                aliases[alias]=module_key(source)
    for alias,key in aliases.items():
        code.append("global.hm_module_aliases[$ "+json.dumps(alias)+"]="+json.dumps(key)+";")
    code.append("}")
    register_script(project,"scrHMRegistry","\n".join(code))
    template=load(PROJECT/"sounds/mus1b/mus1b.yy")
    audio={}
    for source,defs in modules.items():
        for definition in defs:
            for n in walk(definition.body):
                if n.kind!="call" or n.args[0].kind!="identifier" or n.args[0].args[0]!="sound_add":continue
                assert len(n.args[1])==1 and n.args[1][0].kind=="string"
                relative=n.args[1][0].args[0][1:-1]
                path=(ROOT/"reference/hardmode-b24"/Path(source).parent/relative).resolve()
                path.relative_to((ROOT/"reference/hardmode-b24").resolve())
                assert path.is_file(),path
                name="sndHM_"+safe(path.stem)
                data=dict(template);data["name"]=data["%Name"]=name
                data["soundFile"]=name+path.suffix
                data["compression"]=3 if path.stat().st_size>200000 else 1
                data["preload"]=False
                dest=PROJECT/"sounds"/name;dest.mkdir(parents=True,exist_ok=True)
                shutil.copyfile(path,dest/data["soundFile"])
                relative_yy=f"sounds/{name}/{name}.yy"
                write(relative_yy,json.dumps(data,indent=2)+"\n")
                if not any(x["id"]["path"]==relative_yy for x in project["resources"]):
                    project["resources"].append({"id":{"name":name,"path":relative_yy}})
                audio[relative]={"resource":name,"sha256":hashlib.sha256(path.read_bytes()).hexdigest(),"source":path.relative_to(ROOT).as_posix()}
    code=["function scrHMRegisterAudio() {"]
    code.extend("global.hm_sound_assets[$ "+json.dumps(key)+"]="+value["resource"]+";" for key,value in audio.items())
    code.append("}")
    register_script(project,"scrHMAudioRegistry","\n".join(code))
    register_script(project,"scrHMAPI",(ROOT/"native/api.gml").read_text(encoding="utf8"))
    fixtures={}
    for path in (ROOT/"tests/runtime-fixtures").glob("*.gml"):
        key="runtime-fixtures/"+path.name
        fixtures[key]=definitions(path.read_text(encoding="utf8"),key)
    names={key:{d.name for d in defs} for key,defs in fixtures.items()}
    text="\n".join(Emitter(key,d,names,{}).emit() for key,defs in fixtures.items() for d in defs)
    register_script(project,"scrHMRuntimeTests",text+"\n"+(ROOT/"tests/runtime-native.gml").read_text(encoding="utf8"))
    register_script(project,"scrHMModulesTests",(ROOT/"tests/modules-native.gml").read_text(encoding="utf8"))
    replace("objects/MakeGame/Alarm_0.gml","if (scrHMCompilerTests()) exit;",
            "if (scrHMRuntimeTests()) exit;\nif (scrHMCompilerTests()) exit;")
    replace("objects/MakeGame/Alarm_0.gml","if (scrHMRuntimeTests()) exit;",
            "if (scrHMModulesTests()) exit;\nif (scrHMRuntimeTests()) exit;")
    write("nuclearthronemobile.yyp",json.dumps(project,ensure_ascii=False,indent=2)+"\n")
    (ROOT/"runtime-registry-receipt.json").write_text(json.dumps({
        "status":"REGISTERED_PENDING_NATIVE_TESTS","modules":len(modules),"audio":audio,
        "gameplay_enabled":False},indent=2)+"\n",encoding="utf8")
    print(f"Registered {len(modules)} modules and {len(audio)} audio assets; gameplay remains gated")


if __name__=="__main__":main()
