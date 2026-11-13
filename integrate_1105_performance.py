"""Idempotent, narrow 1.1.5 water/particle/shield integration.

Runtime helper bodies and regression fixtures are maintained in project/.
This script only reapplies call-site changes after restoring 1.1.4 sources.
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / "project"


def edit(relative, change):
    path = PROJECT / relative
    before = path.read_text(encoding="utf-8-sig")
    after = change(before)
    if after != before:
        path.write_text(after, encoding="utf-8")


def exact_function(text, name, change):
    start = text.index("function " + name + "(")
    end = text.find("\nfunction ", start + 1)
    if end < 0:
        end = len(text)
    body = text[start:end]
    return text[:start] + change(body) + text[end:]


def maincode(text):
    # Restrict the ambient limiter to the oasis case, preserving all combat
    # and transition logic, including concurrently repaired Throne code.
    start = text.index("case 7: // maincode.mod.gml:2150")
    end = text.index("case 8: // maincode.mod.gml:2148", start)
    body = text[start:end].replace("instance_create(x, y, Bubble)",
                                   "scrHMOasisBubble1105(x, y)")
    return text[:start] + body + text[end:]


def enemies(text):
    for name, old, new in (
        ("hm_enemies_mod_gml_EliteSpiderShield_step",
         "scrHMInstances(projectile)", "scrHMShieldProjectiles1105(id)"),
        ("hm_enemies_mod_gml_bigshield_step",
         'scrHMMatchingNE(projectile, "team", 0)',
         'scrHMMatchingNE(scrHMShieldProjectiles1105(id), "team", 0)'),
        ("hm_enemies_mod_gml_customshield_step",
         'scrHMMatchingNE(projectile, "team", 1)',
         'scrHMMatchingNE(scrHMShieldProjectiles1105(id), "team", 1)'),
    ):
        text = exact_function(text, name, lambda body: body.replace(old, new))
    return text


def water_rects(text):
    # Rejected numeric index was reverted after paired VM timing regressed.
    return text


def sewer_tick(text):
    def change(body):
        if "var _potential=scrHMWaterPotential1103();" not in body:
            body = body.replace("    scrHMWaterBatchBegin1102();",
                                "    var _potential=scrHMWaterPotential1103();\n    scrHMWaterBatchBegin1102();")
        if "scrHMWaterPossible1103(_potential,x,y) && " not in body:
            body = body.replace("var _water=scrHMSwimSupported112(x,y)",
                                "var _water=scrHMWaterPossible1103(_potential,x,y) && scrHMSwimSupported112(x,y)")
        body=body.replace('scrHMBindDraw(hm_maincode_mod_gml_sewerboi,2-y/10000)', 'scrHMSewerBindDraw1115()')
        return body
    return exact_function(text, "scrHMSewerTick1103", change)


def room_setup(text):
    old = '    scrHMAreaCall(GameCont.area,"area_setup");'
    if "scrHMRoomWaterState1105(true);" not in text:
        assert text.count(old) == 1
        text = text.replace(old, "    scrHMRoomWaterState1105(true);\n" + old)
    return text


def world_tick(text):
    def change(body):
        old = "    if(!logic_tick || lockstep_stop || UberCont.paused) return;"
        if "scrHMRoomWaterState1105();" not in body:
            assert body.count(old) == 1
            body = body.replace(old, old + "\n    scrHMRoomWaterState1105();")
        return body
    return exact_function(text, "scrHMWorldStep", change)


if __name__ == "__main__":
    edit(Path("scripts/scrHMCompiled_maincode_mod_gml/scrHMCompiled_maincode_mod_gml.gml"), maincode)
    edit(Path("scripts/scrHMCompiled_enemies_mod_gml/scrHMCompiled_enemies_mod_gml.gml"), enemies)
    edit(Path("scripts/scrHMRepairs109/scrHMRepairs109.gml"), water_rects)
    edit(Path("scripts/scrHMSync1103Performance/scrHMSync1103Performance.gml"), sewer_tick)
    edit(Path("objects/GenCont/Create_0.gml"), room_setup)
    edit(Path("scripts/scrHMWorld/scrHMWorld.gml"), world_tick)
    print("1.1.5 performance call sites integrated")
