"""Check the production call edges of the 1.1.5 performance repairs.

This is a source audit, not a substitute for host-VM or device tests.
"""
from pathlib import Path
import json
import hashlib
import re

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / "project"


def read(relative):
    return (PROJECT / relative).read_text(encoding="utf-8-sig")


def function(text, name):
    start = text.index("function " + name + "(")
    end = text.find("\nfunction ", start + 1)
    return text[start:] if end < 0 else text[start:end]


def water_source_equivalence():
    """Bind actual production functions to the immutable released source hashes."""
    frozen=json.loads((ROOT/'tests/water-baseline114-manifest.json').read_text('utf8'))
    resources={'repairs104.gml':'scrHMRepairs104','repairs109.gml':'scrHMRepairs109',
        'repairs1102.gml':'scrHMRepairs1102','repairs111.gml':'scrHMRepairs111',
        'repairs112.gml':'scrHMRepairs112','sync1103_performance.gml':'scrHMSync1103Performance'}
    proofs=[]
    for row in frozen['functions']:
        resource=resources[Path(row['source']).name]
        path=f'scripts/{resource}/{resource}.gml'
        body=function(read(path),row['name']).strip()
        digest=hashlib.sha256(body.encode('utf8')).hexdigest()
        assert digest==row['source_function_sha256'],row['name']
        native=function((ROOT/row['source']).read_text('utf-8-sig'),row['name']).strip()
        assert native==body,row['name']+' native mirror'
        proofs.append(dict(function=row['name'],project='project/'+path,sha256=digest))
    return dict(strategy='released_hash_gate_restored',source_commit=frozen['source_commit'],functions=proofs)


def main():
    water_source_equivalence()
    yyp = read("nuclearthronemobile.yyp")
    for name in ("scrHMSync1103Performance", "scrHMGameplay1105Performance"):
        assert '"path": "scripts/' + name + "/" + name + '.yy"' in yyp, name
        assert (PROJECT / "scripts" / name / (name + ".yy")).is_file(), name

    setup = read("objects/GenCont/Create_0.gml")
    assert setup.index("scrHMRoomWaterState1105(true);") < setup.index('scrHMAreaCall(GameCont.area,"area_setup")')
    world = function(read("scripts/scrHMWorld/scrHMWorld.gml"), "scrHMWorldStep")
    assert world.index("if(!logic_tick") < world.index("scrHMRoomWaterState1105();") < world.index('hm_portrait_active')

    perf = read("scripts/scrHMSync1103Performance/scrHMSync1103Performance.gml")
    tick = function(perf, "scrHMSewerTick1103")
    assert "var _potential=scrHMWaterPotential1103();" in tick
    assert "scrHMWaterPossible1103(_potential,x,y) && scrHMSwimSupported112(x,y)" in tick
    assert "scrHMWaterBatchBegin1102();" in tick
    assert "scrHMSwimSupported112(x,y)" in tick
    assert "scrHMWaterBatchEnd1102();" in tick
    assert 'scrHMSewerBindDraw1115();' in tick
    bind=function(perf,'scrHMSewerBindDraw1115')
    assert 'scrHMBindDraw(hm_maincode_mod_gml_sewerboi,2-y/10000)' in bind
    assert '_binding.creator!=id' in bind and '_binding.hm_code!=' in bind
    assert '_binding.hm_refresh_tick=HMWorld.logic_serial' in bind
    rects = function(read("scripts/scrHMRepairs109/scrHMRepairs109.gml"), "scrHMWaterRects109")
    exact = function(read("scripts/scrHMRepairs1102/scrHMRepairs1102.gml"), "scrHMWaterExact1102")
    assert "hm_water_rects109[$ _key]" in exact
    for name in ('scrHMWaterIndex1105','scrHMWaterShapes1105','scrHMWaterShapeQuery1105'):
        assert 'function '+name+'(' not in perf and name+'(' not in rects and name+'(' not in exact
    for item in (perf, exact, read("scripts/scrHMGameplay1105Performance/scrHMGameplay1105Performance.gml")):
        assert 'HMWorld[$' not in item and 'GameCont[$' not in item

    for name in ("Floor", "FloorExplo"):
        assert "scrHMCarveFill105(" in read(f"objects/{name}/Create_0.gml"), name
    carve = function(read("scripts/scrHMRepairs106/scrHMRepairs106.gml"), "scrHMCarveFill106")
    assert "HMWorld.hm_water_map=undefined;" in carve
    compiled = read("scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml")
    assert "scrHMSewerTick();" in function(compiled, "hm_arkintide_mod_gml_hm_water_tick")
    assert "HMWorld.hm_water_map=undefined;" in function(compiled, "hm_arkintide_mod_gml_hm_water_link")
    assert "hm_water_map=undefined" in read("objects/HMWorld/Other_5.gml")

    maincode = read("scripts/scrHMCompiled_maincode_mod_gml/scrHMCompiled_maincode_mod_gml.gml")
    start = maincode.index("case 7: // maincode.mod.gml:2150")
    end = maincode.index("case 8: // maincode.mod.gml:2148", start)
    oasis = maincode[start:end]
    assert oasis.count("scrHMOasisBubble1105(x, y)") == 5
    assert "instance_create(x, y, Bubble)" not in oasis
    enemies = read("scripts/scrHMCompiled_enemies_mod_gml/scrHMCompiled_enemies_mod_gml.gml")
    for name in ("EliteSpiderShield", "bigshield", "customshield"):
        body = function(enemies, f"hm_enemies_mod_gml_{name}_step")
        assert "scrHMShieldProjectiles1105(id)" in body, name
        assert "place_meeting(x, y," in body, name

    helper = read("scripts/scrHMGameplay1105Performance/scrHMGameplay1105Performance.gml")
    assert (ROOT/'release1105/water-baseline114-manifest.json').read_bytes()==(ROOT/'tests/water-baseline114-manifest.json').read_bytes()
    frozen=json.loads((ROOT/'tests/water-baseline114-manifest.json').read_text('utf8'))
    assert frozen['source_commit']=='48ac73f965f83240a1a88c1253207aff27866715'
    for row in frozen['functions']:
        frozen_block=helper[helper.index('// Frozen 1.1.4'):helper.index('// kind 0 is')]
        body=function(frozen_block,row['frozen_name']).strip()
        assert hashlib.sha256(body.encode('utf8')).hexdigest()==row['frozen_function_sha256'], row['frozen_name']
    timed=function(helper,'scrHMGameplayWaterPass115')
    assert 'scrHMGameplayWaterBatchBegin114For115();' in timed
    assert 'scrHMGameplayWaterPotential114For115();' in timed
    assert 'scrHMGameplayWaterPossible114For115(_potential,_p[0],_p[1])' in timed
    assert 'scrHMGameplayWaterSupport114For115(_p[0],_p[1])' in timed
    assert 'scrHMGameplayWaterBatchEnd114For115();' in timed
    driver = read("scripts/scrHMGameplayTests/scrHMGameplayTests.gml")
    assert "scrHMGameplayPerformance1105();" in driver
    for mode in ("sync115water", "sync115waterprofile", "sync115bubbles", "sync115shield", "sync115environment"):
        assert 'mode=="' + mode + '"' in helper, mode
    print(json.dumps({"status": "PASS", "kind": "static-production-call-edges", "physical_device_tested": False}))


if __name__ == "__main__":
    main()
