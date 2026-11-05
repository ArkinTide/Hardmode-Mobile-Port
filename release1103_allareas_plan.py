"""All playable Hardmode destinations, tested by the current release VM.

Every listed area/subarea receives one natural-generation smoke at both
30 and 60 FPS.  These checks do not clear a map, edit its layout, delete
enemies, or claim a combat playthrough.  Existing route fixtures below
provide the deeper real-exit checks for the synchronized routes.

Import ALLAREAS into release1103_test_plan.py and register
tests/followup1103_allareas.gml as scrHMGameplayFollowup1103AllAreas;
dispatch scrHMGameplayFollowupAllAreas1103() for mode followup113allareas.
Running this module without --run only prints the plan/coverage.
"""
from pathlib import Path
import argparse
import json
import subprocess
import sys

ROOT = Path(__file__).resolve().parent

# (display label, actual host area, actual subarea, family, selected loop).
# Do not derive this by blindly expanding registry maxsubarea: several IDs
# deliberately retain their chapter's displayed subarea in the real route.
ENTRIES = [
    *[(f"Desert 1-{s}", "1", s, "main", 0) for s in (1, 2, 3)],
    ("Night Desert 1-4 (natural entry)", "nightdesert", 1, "main", 0),
    ("Scorpion arena 1-5 (natural entry)", "scorpionboss", 1, "main", 0),
    *[(f"Sewers 2-{s}", "sewers", s, "main", 3) for s in (1, 2, 3)],
    *[(f"Scrapyards 3-{s}", "3", s, "main", 0) for s in (1, 2)],
    ("Big Bird arena 3-3", "ravenboss", 3, "main", 0),
    *[(f"Extended Scrapyards 3-{s}", "junkyard", s, "main", 3) for s in (4, 5)],
    *[(f"Crystal Caves 4-{s}", "caves", s, "main", 0) for s in (1, 2, 3)],
    *[(f"Frozen City 5-{s}", "city", s, "main", 3) for s in (1, 2, 3, 4, 5)],
    *[(f"Labs 6-{s}", "labs", s, "main", 0) for s in (1, 2)],
    ("The Messenger / elevator 6-3", "elevator", 3, "main", 3),
    *[(f"Palace 7-{s}", "palace", s, "main", 0) for s in (1, 2, 3, 4)],
    ("Throne", "throne", 1, "main", 3),
    # Native throne.area_finish sets end/subarea=0, not end/1.
    ("Hardmode campfire 0-0", "end", 0, "interlude", 1),
    *[(f"Oasis {s}", "oasis", s, "secret", 0) for s in (1, 2, 3, 4, 5)],
    ("Pizza Sewers", "turtles", 1, "secret", 3),
    *[(f"Cursed Caves {s}", "cavesinv", s, "secret", 3) for s in (1, 2, 3)],
    ("Ice Cave", "icecave", 1, "secret", 0),
    *[(f"Jungle {s}", "jungle", s, "secret", 3) for s in (1, 2, 3, 4, 5)],
    ("Yeti room", "noyetihere", 1, "secret", 0),
    *[(f"HQ corridor {s}", "HQ", s, "HQ", 3) for s in (1, 2, 3, 4)],
    # HQ.area_finish after HQ/4 explicitly hands control to native 106/3.
    # FloorMaker requires /3 to build the native final arena. Once generated,
    # original b24 maincode.step exposes it as /5; see expected_host_subarea.
    ("HQ Captain arena", "106", 3, "HQ", 3),
    ("Crown Vault", "100", 1, "secret", 0),
    ("Y.V. Crib", "107", 1, "secret", 0),
    *[(f"Venus stage {s}", "venuz", s, "Venus", 0) for s in range(1, 13)],
    *[(f"Venus secret {s}", "venuz", s, "Venus secret", 0)
      for s in (100, 200, 300, 400, 401)],
]

# Native rooms remain valid host destinations, though Hardmode normally
# uses custom end/0 and the authored Venus campaign instead of these maps.
AUXILIARY = [
    ("Native campfire", "0", 1, "native auxiliary", 0),
    ("Native mansion", "103", 1, "native auxiliary", 0),
    ("Night Desert console destination", "nightdesert", 4, "console alias", 0),
    ("Scorpion arena console destination", "scorpionboss", 5, "console alias", 0),
]

KNOWN_SPECIAL_CASES = {
    "scrapyards": "Real 3-1/3-2 use native numeric area 3. Custom junkyard/217 only owns 3-4/3-5; junkyard/1 is not a valid substitute.",
    "displayed_subareas": "Natural nightdesert/1 is reached from desert/3; its area_finish explicitly enters scorpionboss/1. Their names are hardcoded 1-4 and 1-5. The debug target instead exposes nightdesert/4 and scorpionboss/5, covered as auxiliary console aliases. Ravenboss/3 and elevator/3 retain their actual chapter subarea on entry. Do not derive these values from the displayed labels or registry lengths.",
    "end": "Natural Throne exit writes custom end/subarea 0. It is a playable noncombat campfire room; numeric 0/0 is not its route.",
    "HQ": "HQ/1 through HQ/4 lead to native 106/3 (areas/HQ.area.gml area_finish). Native FloorMaker.Create requires subarea==scrAreaGetMaxSubarea(106)==3 to build the Captain arena, desk and BigTV. Original b24 maincode.mod.gml step line 1570 then sets GameCont.subarea=5. The sole expected host normalization is therefore input 106/3 -> observed 106/5; directly requesting 106/5 would skip the native final-arena geometry. This map is distinct from custom elevator/3. Native 106/1 and /2 duplicate neither the custom corridor route nor this final arena.",
    "Venus": "Twelve main maps plus exact secrets 100/200/300/400/401. Values 99/199/299/399 are transition sentinels normalized before generation, not separate playable maps. Source maincode.venus_place_players consumes its spawnpoint objects immediately after moving players; witnesses instead parse * and E cells from the loaded source map, verify actual Player spawn coordinates and persistent elevator/exit-control structures. Secret 401 is the Y.C lounge; the existing venusyc109 fixture covers its character-specific contents.",
    "aliases": "space, idpd, yeti, jungleboogie, cavesecret and sewersentrance are aliases of listed destinations. Negative IDs gatorcave/gatorboss/bigdog are compatibility sentinels, not standalone generated areas. Unloaded b24 banditcamp, bigdog and mansion source modules are not custom registered maps.",
    "palace": "Custom palace/4 exits to Throne. A putative palace/5 is not an additional playable palace room in the current route.",
    "noncombat": "Campfire, vault, crib and Venus lounge may legitimately have no enemies. No universal enemy-count assertion is used.",
    "scope": "Generic checks are natural-generation/spawn/collision/critical-structure smoke, not a claim to have killed every enemy or entered every exit. Real transitions use the existing deeper fixtures listed in EXIT_FIXTURES.",
}

EXIT_FIXTURES = {
    "crown_7_4_roundtrip": "palace,4,0,{rate},150,7103,sync113vault",
    "messenger_elevator": "elevator,3,3,{rate},140,42,sync113lift",
    "messenger_full_exit_regression": "elevator,3,3,{rate},900,42,sync112exit",
    "throne_original_layout_and_route": "throne,1,1,{rate},500,7103,sync113throne",
    "cursed_cave_purification": "cavesinv,3,0,{rate},180,42,cave112",
    "venus_full_authored_route": "venuz,1,0,{rate},60000,42,venus106",
    "venus_secrets_authored_route": "venuz,1,0,{rate},90000,42,venussecrets106",
    "venus_yc_lounge_to_final_boss": "venuz,401,0,{rate},18000,42,venusyc109",
}

def scenario(entry, rate, *, loop=None, seed=7103):
    _, area, sub, _, selected_loop = entry
    return f"{area},{sub},{selected_loop if loop is None else loop},{rate},70,{seed},followup113allareas"

def expected_host_subarea(area, subarea):
    """Keep the only source-defined post-generation subarea normalization.

    Native 106/3 must generate before b24 maincode.step relabels the Captain
    arena as /5. Every other smoke must retain exactly its requested subarea.
    """
    return 5 if str(area) == "106" and int(subarea) == 3 else int(subarea)

SMOKE = [scenario(entry, rate) for entry in ENTRIES + AUXILIARY for rate in (30, 60)]

# Cover opposite-loop behavior without multiplying every map by four.
# Main-loop L0 maps gain an L3 representative per family; L3 route maps
# gain L0 counterparts at the significant boss/endpoints.
LOOP_REPRESENTATIVES = [
    ("Desert L3", "1", 3, "extra loop", 3),
    ("Sewers L0", "sewers", 3, "extra loop", 0),
    ("Scrapyards L3", "3", 1, "extra loop", 3),
    ("Caves L3", "caves", 3, "extra loop", 3),
    ("City L0", "city", 5, "extra loop", 0),
    ("Labs L3", "labs", 2, "extra loop", 3),
    ("Palace L3", "palace", 4, "extra loop", 3),
    ("Throne L0", "throne", 1, "extra loop", 0),
    ("Venus L3", "venuz", 12, "extra loop", 3),
    ("Oasis L3", "oasis", 3, "extra loop", 3),
    ("Jungle L0", "jungle", 1, "extra loop", 0),
    ("HQ L0", "HQ", 4, "extra loop", 0),
]
HIGH_LOOP = [scenario(entry, rate) for entry in LOOP_REPRESENTATIVES for rate in (30, 60)]
ALLAREAS = list(dict.fromkeys(SMOKE + HIGH_LOOP))
assert len({(e[1], e[2]) for e in ENTRIES + AUXILIARY}) == len(ENTRIES + AUXILIARY)

def coverage():
    families = {}
    for label, area, sub, family, loop in ENTRIES + AUXILIARY:
        families.setdefault(family, []).append({"label": label, "area": area, "subarea": sub,
                                               "expected_host_subarea": expected_host_subarea(area, sub),
                                               "loop": loop, "rates": [30, 60]})
    return {"playable_destinations": len(ENTRIES), "auxiliary_destinations": len(AUXILIARY),
            "generation_smokes": len(SMOKE), "additional_loop_smokes": len(HIGH_LOOP),
            "total_smokes": len(ALLAREAS), "families": families,
            "knownspecialcases": KNOWN_SPECIAL_CASES, "exit_fixtures": EXIT_FIXTURES}

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--run", action="store_true")
    parser.add_argument("--coverage", action="store_true")
    args = parser.parse_args()
    if args.run:
        subprocess.run([sys.executable, "-B", str(ROOT / "run_release1103_checks.py"),
                        *ALLAREAS, "--keep-going"], check=True)
    elif args.coverage:
        print(json.dumps(coverage(), ensure_ascii=False, indent=2))
    else:
        print("\n".join(ALLAREAS))
