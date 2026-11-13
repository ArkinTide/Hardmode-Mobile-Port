"""Reapply normal boss schedules/presentation guards after retained generators.

This only edits the functions owned by the group-presentation repair; other
agents' current gameplay, performance, rocket ownership and release files stay
intact. Running twice produces identical output.
"""
from pathlib import Path
import re

from sync1104_tools import span

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / "project"
CHANGED = []


def save(path, text):
    if path.read_text(encoding="utf-8") != text:
        path.write_text(text, encoding="utf-8")
        CHANGED.append(str(path.relative_to(ROOT)))


def edit(relative, old, new):
    path = PROJECT / relative
    text = path.read_text(encoding="utf-8")
    if new in text:
        return
    assert text.count(old) == 1, (relative, old, text.count(old))
    save(path, text.replace(old, new, 1))


def function(path, name, transform):
    text = path.read_text(encoding="utf-8")
    _, a, b, _ = span(text, name)
    original = text[a:b]
    replacement = transform(original)
    if original != replacement:
        save(path, text[:a] + replacement + text[b:])


def import_helper(name, relative, source):
    path = PROJECT / relative
    text = path.read_text(encoding="utf-8")
    a, _, _, b = span(source, name)
    definition = source[a:b]
    if re.search(r"^function " + re.escape(name) + r"\(", text, re.M):
        x, _, _, y = span(text, name)
        save(path, text[:x] + definition + text[y:])
    else:
        save(path, text.rstrip() + "\n\n" + definition + "\n")


def main():
    helper = "scripts/scrHMRepairs109/scrHMRepairs109.gml"
    source = (ROOT / "native/repairs109.gml").read_text(encoding="utf-8")
    names = ["scrHMLilHunterPending109", "scrHMLilHunterWait109", "scrHMLilHunterGroup109",
             "scrHMGatorGroup109", "scrHMRavenGroup109"]
    names += re.findall(r"^function (\w+)\(", source[source.index("// One presentation ledger per visit,"):], re.M)
    for name in names:
        import_helper(name, helper, source)

    compiled = PROJECT / "scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml"
    function(compiled, "hm_arkintide_mod_gml_hm_hunter_pending",
             lambda _: "scrHMLilHunterPending109();")
    function(compiled, "hm_arkintide_mod_gml_hm_hunter_wait", lambda _: """
    if(!variable_instance_exists(id,"hm_area109")) {
        hm_area109=GameCont.area;hm_sub109=GameCont.subarea;hm_loop109=GameCont.loops;
        hm_wait109=self[$ "hm_wait"]??30;
    }
    scrHMLilHunterWait109();
""")

    def remove_expansion(body):
        if "scrHMLilHunterReconcile115();" in body:
            return body
        start = body.index('if (((GameCont.area == scrHMAreaResolve("city")) && (GameCont.subarea == 5))) {')
        end = body.index("{ var __hm_with7 = scrHMInstances(VanSpawn)", start)
        return body[:start] + "scrHMLilHunterReconcile115();\n" + body[end:]

    function(compiled, "hm_arkintide_mod_gml_hm_native_step", remove_expansion)
    function(compiled, "hm_arkintide_mod_gml_hm_pending_boss_exit",
             lambda b: b.replace("var _hml_arrived = instance_exists(LilHunter);",
                                 "var _hml_arrived = instance_exists(LilHunter) || instance_exists(LilHunterFly);"))

    def keep_flying(body):
        guard = 'if(!_hml_alive) with(LilHunterFly) if(hp>0 && !(self[$ "hm_extra"]??false)) {_hml_alive=true;break;}'
        return body if guard in body else body.replace("return _hml_alive;", guard + "\nreturn _hml_alive;", 1)

    function(compiled, "hm_arkintide_mod_gml_hm_stage_boss_alive", keep_flying)
    intro = "scripts/scrHMCompiled_bosses_bossintros_mod_gml/scrHMCompiled_bosses_bossintros_mod_gml.gml"
    edit(intro, "if(scrHMMessengerSkipPresentation1103(argument4)) return;",
         "if(scrHMMessengerSkipPresentation1103(argument4)) return;\n"
         "if(scrHMBossGroupPresentation115(argument0,argument1,argument2,argument3,argument4,argument5)) return;")
    restore = PROJECT / "scripts/scrHMRepairs104/scrHMRepairs104.gml"
    function(restore, "scrHMBossRestore104",
             lambda b: b if "scrHMBossPresentationEnd115();" in b else "\n    scrHMBossPresentationEnd115();\n" + b)
    world = PROJECT / "scripts/scrHMWorld/scrHMWorld.gml"
    function(world, "scrHMWorldStep",
             lambda b: b if "scrHMBossGroupTick115();" in b else b.rstrip() + "\n    if(!instance_exists(HMWorld.hm_portrait_active)) scrHMBossGroupTick115();\n")
    edit("scripts/scr_hit/scr_hit.gml", "if (instance_is(self, Player)) {",
         "if (instance_is(self, Player)) {\n\t\t\tif(_amount>0 && scrHMBossPresentationProtected115()) return false;")
    edit("scripts/scrBossIntro/scrBossIntro.gml", "bossintro = true",
         "bossintro = true\n        scrHMBossPresentationNative115(true);")
    edit("objects/UberCont/Alarm_2.gml", "bossintro = false",
         "bossintro = false\nscrHMBossPresentationNative115(false);")
    edit("scripts/scrHMMobile/scrHMMobile.gml", '"PLAYER BOOST (+2 HP, +1 LEVEL)"',
         '"PLAYER BOOST#MAX HP +2#MAX LEVEL +1"')
    print("1115 normal boss groups patched", len(CHANGED), "files")


if __name__ == "__main__":
    main()
