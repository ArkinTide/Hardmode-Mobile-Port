"""Strict final-source, same-VM, fresh-resource and packaged 1.1.3 gate.

This script records evidence only after every assertion succeeds. It never
builds, runs a game, changes a package, publishes source, or uploads a file.
"""
from pathlib import Path
from datetime import datetime, timezone
from collections import Counter
import hashlib
import io
import json
import math
import plistlib
import re
import struct
import sys
import zipfile

from PIL import Image
from release_config import VERSION, BUILD, PACKAGE
from release1103_test_plan import ALL, REQUIRED
from release1103_allareas_plan import (ALLAREAS, ENTRIES, AUXILIARY,
                                     coverage as allareas_coverage, expected_host_subarea,
                                     scenario as allarea_scenario)
from change_icon1103 import (ICON_PREFIX, SOURCE_SHA256 as ICON_SOURCE_SHA256,
                            verify_android_icon, verify_ios_icon)

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'release1103'
sys.path.insert(0, str(ROOT.parent))
from patch_followup_compat import Game

BOUNDARY_LOCAL = '2026-11-03T17:36:22+08:00'
BOUNDARY_UTC = '2026-11-03T09:36:22Z'
BOUNDARY_TEXT = 'hardmode模组版也请不要让局长和金星最终boss替换throne关卡和金星关卡的关底boss'
ARCHIVE_SUFFIXES = {'.gml', '.yy', '.yyp', '.json', '.py', '.ps1', '.java',
                    '.xml', '.plist', '.csv', '.txt', '.md'}
FRAGMENTS = {'bosses': 20, 'routes': 14, 'chest': 3, 'ultra': 8,
             'spawn': 3, 'performance': 4}
SUPPLEMENTAL_FRAGMENTS = {'followup1103_walls.gml': 5,
                          'followup1103_frog.gml': 1}
SUPPLEMENTAL_ITEMS = ('structure-walls', 'sewer-frog', 'loop-performance', 'launcher-icon', 'chief-spacing', 'jungle-mutation')
RETAINED_FUNCTIONS = [
    'scrHMWaterBatchBegin1102', 'scrHMWaterExact1102', 'scrHMWaterBatchEnd1102',
    'scrHMIDPDPortalSprite1102', 'scrHMElevatorStep1102', 'scrHMReplacementArea1102',
    'scrHMReplacementTick1102', 'scrHMChiefCreate1102', 'scrHMChiefStep1102',
    'scrHMChiefDeath1102', 'scrHMChiefDepartureDraw1102', 'scrHMChiefBallBurst1102',
    'scrHMVenusCleanup108',
]
ARTWORK = {
    'sprHMBossTitleGlyphs1103': (74, [5, 7], [2960, 40],
        '60bdeb12ebb7cb547d6fc82ff56522fe57e16c657f306139b00969e02dad368f',
        '98aea966def00bbf14b05d1de0fa81ee1e2150fc85bd19dff17c5bf732002158'),
    'sprHMMessengerPortrait1103': (1, [246, 0], [492, 240],
        'b8e449c52597cd5724f75f73c6cd3832f3035571ab0f0fc4c53de550c9148751',
        '259e22231dbb562513a6af1ad24dfcc993d533485329046267b546730b9780cc'),
    'sprHMMessengerTitle1103': (1, [122, 0], [244, 80],
        'c0c59c7197830ba944072acbcda448f6d04891f3c4ad2cb2de88ccf4883af8d2',
        '6254426c1b7b93340c8e571f1428f61d666f1cb48ae5212d103c57bd52dd162f'),
}


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def rawsha(data):
    return hashlib.sha256(data).hexdigest()


def read(path):
    return json.loads(Path(path).read_text('utf8'))


def local(relative):
    path = (ROOT / relative).resolve()
    assert path.is_relative_to(ROOT.resolve()) and path.is_file(), relative
    return path


def current_source_paths():
    project = {p.relative_to(ROOT).as_posix() for p in (ROOT / 'project').rglob('*') if p.is_file()}
    development = set()
    for folder in ('native', 'generated', 'tests', 'localization', 'android'):
        development.update(p.relative_to(ROOT).as_posix() for p in (ROOT / folder).rglob('*') if p.is_file())
    for pattern in ('*.py', '*.ps1'):
        development.update(p.name for p in ROOT.glob(pattern) if p.is_file())
    return {'project_files': project, 'development_sources': development}


def verify_source():
    frozen = read(OUT / 'final-source.json')
    desktop = sha(ROOT / 'build-windows/nuclearthronemobile.win')
    assert frozen['desktop_vm_sha256'] == desktop
    assert frozen['original_files_verified'] == 7231
    expected, current = {}, current_source_paths()
    for group in ('project_files', 'development_sources'):
        assert frozen[group] and set(frozen[group]) == current[group], ('Changed source file set', group)
        for relative, digest in frozen[group].items():
            assert sha(local(relative)) == digest, ('Source changed after freeze', relative)
            expected[relative] = digest
    with zipfile.ZipFile(OUT / 'final-code.zip') as archive:
        names = archive.namelist()
        assert len(names) == len(set(names)) and archive.testzip() is None
        assert set(names) == {name for name in expected if Path(name).suffix.lower() in ARCHIVE_SUFFIXES}
        for name in names:
            assert rawsha(archive.read(name)) == expected[name], ('Code archive mismatch', name)
    return frozen, desktop


def definitions(text):
    """Use the audited NTT #define boundary; retain pre-definition __init__."""
    # Leave the newline in each body, exactly like the independent audit.
    # In particular its one semantic-noop is a final CRLF-only difference.
    matches = list(re.finditer(r'^#define[ \t]+([A-Za-z_][A-Za-z_0-9]*)[^\n]*', text, re.M))
    result = {'__init__': text[:matches[0].start()] if matches else text}
    for index, match in enumerate(matches):
        assert match[1] not in result, ('Duplicate native definition', match[1])
        result[match[1]] = text[match.end():matches[index + 1].start() if index + 1 < len(matches) else len(text)]
    return result


def verify_scope():
    scope = read(OUT / 'user-scope.json')
    audit = read(OUT / 'scope-audit.json')
    delta = read(OUT / 'scope-audit-native-diff.json')
    exact = dict(boundary_local=BOUNDARY_LOCAL, boundary_text=BOUNDARY_TEXT,
                 target='Hardmode mobile', planned_version=VERSION, planned_build=BUILD)
    for key, value in exact.items():
        assert scope[key] == audit['scope'][key] == value, ('Scope boundary changed', key)
    assert scope['boundary_utc'] == BOUNDARY_UTC
    first = scope['records'][0]
    assert first['started_at_utc'] == '2026-11-03T09:36:22.000Z'
    assert first['messages'][0].strip() == BOUNDARY_TEXT
    assert first['messages'][1].strip() == '以及警局的关底boss'
    assert len(scope['records']) == 7
    assert all(datetime.fromisoformat(row['started_at_utc'].replace('Z', '+00:00')) >=
               datetime.fromisoformat(BOUNDARY_UTC.replace('Z', '+00:00')) for row in scope['records'])
    coverage = audit['definition_coverage']
    changes = delta['changed']
    changed_keys = {(row['file'], row['definition']) for row in changes}
    covered_keys = {(row['native_file'], row['native_definition']) for row in coverage}
    assert len(changes) == len(changed_keys) == len(coverage) == len(covered_keys) == 114
    assert changed_keys == covered_keys, '114-definition audit is incomplete'
    assert Counter(row['classification'] for row in coverage) == {'adapted': 86, 'synced': 27, 'semantic-noop': 1}
    assert all(row['mobile_evidence'] and row['notes'] for row in coverage)
    noops = [row for row in coverage if row['classification'] == 'semantic-noop']
    assert [(row['native_file'], row['native_definition']) for row in noops] == [('arkintide.mod.gml', 'hm_chief_ball_destroy')]
    items = audit['user_item_coverage']
    # Keep the original seven-record / 31-item / 114-definition audit intact.
    # Later mobile-specific requests supplement it; they are not fabricated
    # native definitions and do not change the original timestamp boundary.
    assert len(items) == 31 and len({(row['group'], row['number']) for row in items}) == 31
    assert all(row['status'] == 'covered-source' and row['evidence'] for row in items)
    # Pending audit findings cannot be hidden behind otherwise passing tests.
    assert len(audit['findings']) == 6
    accepted = {'fixed-source', 'fixed-source-and-rechecked', 'mitigated-source',
                'verified-final-runtime', 'fixed-and-verified-final-runtime',
                'applied-and-verified-final-runtime'}
    assert all(row['status'] in accepted and row['evidence'] for row in audit['findings']), audit['findings']
    supplemental = read(OUT / 'supplemental-scope.json')
    assert supplemental['original_scope'] == 'release1103/user-scope.json'
    assert supplemental['boundary_local'] == BOUNDARY_LOCAL
    assert (supplemental['target'], supplemental['planned_version'], supplemental['planned_build']) == ('Hardmode mobile', VERSION, BUILD)
    assert (supplemental['original_record_count'], supplemental['original_item_count'],
            supplemental['original_changed_definition_count'], supplemental['total_user_items']) == (7, 31, 114, 37)
    additions = supplemental['items']
    extra_coverage = audit['supplemental_item_coverage']
    assert len(additions) == len(extra_coverage) == 6
    assert tuple(row['id'] for row in additions) == SUPPLEMENTAL_ITEMS
    assert tuple(row['id'] for row in extra_coverage) == SUPPLEMENTAL_ITEMS
    assert len(items) + len(extra_coverage) == 37
    assert audit['supplemental_scope'] == 'release1103/supplemental-scope.json'
    for request, covered in zip(additions, extra_coverage):
        assert request['request'] == covered['request'] and request['source_evidence'] == covered['source_evidence']
        final_statuses = ({'verified-final-package'} if request['id'] == 'launcher-icon' else
                          {'verified-final-runtime', 'fixed-and-verified-final-runtime',
                           'applied-and-verified-final-runtime'})
        assert covered['status'] in final_statuses and covered['evidence'], ('Supplemental scope pending', covered)
        assert set(request['required_scenarios']) <= set(REQUIRED), ('Supplemental tests missing from plan', request['id'])
        for relative in request['source_evidence']:
            assert local(relative), (request['id'], relative)
        if request['id'] == 'loop-performance':
            acceptance = request['all_area_acceptance']
            assert acceptance['plan_module'] == 'release1103_allareas_plan.py'
            assert acceptance['coverage_snapshot'] == 'release1103/allareas-plan.json'
            assert acceptance['requires_all_planned_scenarios'] is True
            assert acceptance['scope'] == 'generation_spawn_collision_structure_smoke'
            assert acceptance['combat_playthrough_claimed'] is False
    provenance = audit['provenance']
    assert provenance['verified_sha256_entry_count'] == 66 and provenance['changed_definition_count'] == 114
    assert provenance['manifest'] == 'release1102/sync-plan.json::native_production_sha256'
    assert provenance['definition_diff'] == 'release1103/scope-audit-native-diff.json'
    assert Path(provenance['exact_native_baseline_backup']).resolve() == Path(delta['baseline_backup']).resolve()
    baseline = read(ROOT / 'release1102/sync-plan.json')['native_production_sha256']
    assert len(baseline) == 66 and set(delta['verified_baseline_files']) == set(baseline)
    native = ROOT / '../hardmode-ntt100034/mod'
    recomputed = {}
    with zipfile.ZipFile(delta['baseline_backup']) as archive:
        for relative, digest in baseline.items():
            entries = [name for name in archive.namelist() if name.endswith('/' + relative)]
            assert len(entries) == 1, relative
            old = archive.read(entries[0])
            assert rawsha(old) == digest, ('Wrong native baseline', relative)
            current = (native / relative).read_bytes()
            if Path(relative).suffix != '.gml':
                assert current == old, ('Unmapped native non-code change', relative)
                continue
            before = definitions(old.decode('utf-8-sig'))
            after = definitions(current.decode('utf-8-sig'))
            for name in before.keys() | after.keys():
                if before.get(name) != after.get(name):
                    recomputed[(relative, name)] = (before.get(name), after.get(name))
    assert set(recomputed) == changed_keys, ('Native definition diff changed', set(recomputed) ^ changed_keys)
    for row in changes:
        before, after = recomputed[(row['file'], row['definition'])]
        assert row.get('old') == before
        assert row.get('current') == after
    return dict(boundary_local=BOUNDARY_LOCAL, boundary_utc=BOUNDARY_UTC,
                boundary_text=BOUNDARY_TEXT, native_definitions=114, covered_definitions=114,
                original_user_items=31, supplemental_user_items=6, user_items=37, baseline_files=66,
                user_scope_sha256=sha(OUT / 'user-scope.json'),
                supplemental_scope_sha256=sha(OUT / 'supplemental-scope.json'),
                audit_sha256=sha(OUT / 'scope-audit.json'),
                native_diff_sha256=sha(OUT / 'scope-audit-native-diff.json'),
                native_baseline_zip_sha256=sha(delta['baseline_backup']))


def verify_runtime(desktop):
    assert len(set(ALL)) == len(ALL) and set(REQUIRED) <= set(ALL) and REQUIRED
    assert len(set(ALLAREAS)) == len(ALLAREAS) and ALLAREAS and set(ALLAREAS) <= set(ALL)
    rows = []
    for scenario in ALL:
        path = OUT / 'tests' / scenario.replace(',', '-').replace(':', '-') / 'receipt.json'
        row = read(path)
        assert row['scenario'] == scenario, ('Receipt scenario mismatch', scenario, row)
        assert row['vm_sha256'] == desktop and row['exit'] == 0, (scenario, row)
        if scenario == 'native:artwork':
            assert row['checks'] >= 1035
            assert all(max(abs(a - b) for a, b in zip(v['expected'], v['actual'])) <= .5
                       for v in row['origin_mismatches'])
        else:
            assert row['status'] == 'PASS', (scenario, row)
        assert row['checks'] > 0
        assert row['muted_resources'] == 1250 and row['desktop'] == 'private, never activated'
        if scenario.endswith(',sync113chiefspacing'):
            log = (path.parent / 'runner.log').read_text('utf8', errors='replace')
            reports = re.findall(r'HARDMODE CHIEFSPACING113 (\{[^\r\n]+\})', log)
            assert len(reports) == 1 and row['checks'] >= 40
            chief = json.loads(reports[0])
            assert chief['rate'] == int(scenario.split(',')[3]) and chief['physical_device'] is False
            assert [case['loops'] for case in chief['cases']] == [0, 1, 3, 10]
            for case in chief['cases']:
                beams = 10 + case['loops']
                assert case['beams'] == beams and case['shots'] == beams * 8
                # Runner direction fields are single-precision angles.
                assert all(abs(case[key] - 360 / beams) < .001
                           for key in ('expected_gap', 'minimum_gap', 'maximum_gap'))
                assert case['gap_error'] < .001
                assert case['eight_native_speeds'] and case['ownership_preserved']
        rows.append(dict(scenario=scenario, checks=row['checks'], vm_sha256=desktop,
                         receipt_sha256=sha(path)))
    return rows


def verify_allareas(desktop, runtime_rows):
    """Bind natural generation observers to the final VM, plan, log and image.

    These receipts prove only their stated generation/spawn/collision/structure
    smoke. A room may be noncombat; no enemy-count or cleared-room claim is
    inferred. Existing dedicated route fixtures remain separate evidence.
    """
    plan_path = OUT / 'allareas-plan.json'
    planned = allareas_coverage()
    assert read(plan_path) == planned, 'Stored all-area plan differs from the current source coverage()'
    assert planned['total_smokes'] == len(ALLAREAS)
    assert planned['generation_smokes'] + planned['additional_loop_smokes'] == len(ALLAREAS)
    assert set(ALLAREAS) <= {row['scenario'] for row in runtime_rows}
    identity_path = ROOT / 'project/scripts/scrHMIdentities/scrHMIdentities.gml'
    identities = dict((name, int(value)) for name, value in re.findall(
        r'global\.hm_area_ids\[\$\s*"([^\"]+)"\]\s*=\s*(-?\d+)\s*;', identity_path.read_text('utf8')))
    assert identities
    observations = []
    for scenario in ALLAREAS:
        parts = scenario.split(',')
        assert len(parts) == 7 and parts[6] == 'followup113allareas'
        area, sub, loop, rate, ticks, seed = parts[:6]
        expected_area = int(area) if re.fullmatch(r'-?\d+', area) else identities[area]
        expected = dict(scenario=scenario, area=expected_area, subarea=expected_host_subarea(area, sub), loop=int(loop), rate=int(rate))
        assert int(rate) in (30, 60) and int(ticks) >= 70
        folder = OUT / 'tests' / scenario.replace(',', '-').replace(':', '-')
        receipt = read(folder / 'receipt.json')
        assert receipt['vm_sha256'] == desktop and receipt['scenario'] == scenario
        assert receipt['status'] == 'PASS' and receipt['exit'] == 0 and receipt['checks'] > 0
        log_path = folder / 'runner.log'
        log = log_path.read_text('utf8', errors='replace')
        matches = re.findall(r'HARDMODE ALLAREAS1103 (\{[^\r\n]+\})', log)
        assert len(matches) == 1, (scenario, 'Expected exactly one final natural-generation observation')
        observed = json.loads(matches[0])
        assert observed['requested_subarea'] == int(sub)
        for key, value in expected.items():
            assert observed[key] == value, (scenario, 'Actual room differs from plan', key, observed[key], value)
        assert observed['scope'] == 'generation_spawn_collision_structure_smoke'
        assert observed['floors'] >= 5 and observed['reachable_spawn_points'] >= 3
        assert observed['walls'] >= 0 and observed['invisible_walls'] >= 0
        assert len(observed['player']) == 2 and all(isinstance(v, (int, float)) and math.isfinite(v) for v in observed['player'])
        assert isinstance(observed['natural_witnesses'], dict)
        assert isinstance(observed['combat_population_observed'], bool) and observed['max_living'] >= 0
        assert observed['combat_population_observed'] == (observed['max_living'] > 0)
        image_path = folder / 'allarea.png'
        assert image_path.is_file() and image_path.stat().st_size > 0, (scenario, 'Missing final room screenshot')
        with Image.open(image_path) as image:
            assert image.format == 'PNG' and image.width > 0 and image.height > 0
            dimensions = list(image.size)
            image.verify()
        observations.append(dict(**expected, checks=receipt['checks'], vm_sha256=desktop,
            receipt_sha256=sha(folder / 'receipt.json'), runner_log_sha256=sha(log_path),
            screenshot_sha256=sha(image_path), screenshot_bytes=image_path.stat().st_size,
            screenshot_size=dimensions, reachable_spawn_points=observed['reachable_spawn_points'],
            floors=observed['floors'], walls=observed['walls'], invisible_walls=observed['invisible_walls'],
            combat_population_observed=observed['combat_population_observed'], max_living=observed['max_living'],
            natural_witnesses=observed['natural_witnesses']))
    visual_path = OUT / 'visual-review/manifest.json'
    visual = read(visual_path)
    assert visual['vm_sha256'] == desktop and visual['manually_reviewed'] is True
    assert visual['screenshot_count'] == planned['playable_destinations'] + planned['auxiliary_destinations']
    visual_scenarios = set()
    for sheet in visual['sheets']:
        assert sha(local(sheet['contact_sheet'])) == sheet['sha256']
        for source in sheet['sources']:
            assert source['scenario'] in ALLAREAS and source['scenario'].split(',')[3] == '60'
            assert source['screenshot'] == 'release1103/tests/' + source['scenario'].replace(',', '-') + '/allarea.png'
            assert sha(local(source['screenshot'])) == source['sha256']
            visual_scenarios.add(source['scenario'])
    assert len(visual_scenarios) == visual['screenshot_count']
    assert visual_scenarios == {allarea_scenario(entry, 60) for entry in ENTRIES + AUXILIARY}
    return dict(status='PASS', scope='generation_spawn_collision_structure_smoke',
        final_desktop_vm_sha256=desktop, plan=planned, plan_sha256=sha(plan_path),
        plan_module_sha256=sha(ROOT / 'release1103_allareas_plan.py'),
        observer_source_sha256=sha(ROOT / 'tests/followup1103_allareas.gml'),
        area_identities_source_sha256=sha(identity_path), observations=observations,
        screenshots_captured=True, screenshot_visual_review='Final 60 FPS spawn-camera contact sheets reviewed by root',
        visual_review_manifest_sha256=sha(visual_path),
        combat_playthrough=False, every_enemy_killed=False, every_exit_traversed=False,
        physical_phone_tested=False, performance_fps_claim=False,
        limits=['Natural generation/spawn/local collision/critical-structure observations only.',
                'Screenshots are bound by hash; automated file validation is not visual review.',
                'Enemy population may legitimately be zero in noncombat rooms.',
                'Deep route fixtures listed in the plan are distinct from this all-area smoke.'])


def production_functions():
    functions = []
    for name, count in FRAGMENTS.items():
        source = (ROOT / 'native' / ('sync1103_' + name + '.gml')).read_text('utf8')
        found = re.findall(r'^function\s+(\w+)\(', source, re.M)
        assert len(found) == count and all('1103' in fn for fn in found), (name, found)
        functions.extend(found)
    assert len(functions) == len(set(functions)) == 52
    for filename, count in SUPPLEMENTAL_FRAGMENTS.items():
        source = (ROOT / 'native' / filename).read_text('utf8')
        found = re.findall(r'^function\s+(\w+)\(', source, re.M)
        assert len(found) == count and all(fn.endswith(('1103', '113')) for fn in found), (filename, found)
        functions.extend(found)
    assert len(functions) == len(set(functions)) == 58
    return functions


def critical_edges():
    """Production callers, never the fixture's calls to otherwise orphan code."""
    pairs = [
        ('scrHMWorldInit', 'scrHMReportAssets1103'),
        ('hm_arkintide_mod_gml_hm_infantry_capture', 'scrHMContentChange1100'),
        ('scrHMContentChange1100', 'scrHMActorInit'),
        ('hm_maincode_mod_gml_CHCoutro', 'hm_arkintide_mod_gml_hm_cave_restore'),
        ('hm_props_mod_gml_Flower_step_resume', 'scrHMSetSkill'),
        *[(f'gml_Object_{obj}_Other_5', 'scrHMActorCleanup')
          for obj in ('CustomObject','CustomEnemy','CustomHitme','CustomProjectile')],
        ('scrHMWorldStep', 'scrHMNativeBossHealth1103'),
        ('scrHMWorldStep', 'scrHMRouteTick1103'),
        ('scrHMWorldStep', 'scrHML2UltraTick1103'),
        ('hm_maincode_mod_gml_game_start', 'scrHMCrownReset1103'),
        ('hm_maincode_mod_gml_game_start', 'scrHML2UltraReset1103'),
        ('scrHMCrownWatch1100', 'scrHMCrownWatch1103'),
        ('gml_Object_ProtoStatue_Destroy_0', 'scrHMCrownEntry1103'),
        ('scrHMAdvanceDestination107', 'scrHMCrownDestination1103'),
        ('gml_Object_GameCont_Other_5', 'scrHMCrownExit1103'),
        ('scrHMConsoleGoto', 'scrHMCrownReset1103'),
        ('hm_arkintide_mod_gml_hm_debug_goto', 'scrHMCrownReset1103'),
        ('scrHMElevatorStep1102', 'scrHMElevatorStep1103'),
        ('hm_arkintide_mod_gml_hm_elevator_step', 'scrHMElevatorStep1102'),
        ('hm_props_mod_gml_elevator_step', 'scrHMElevatorStep1102'),
        ('hm_props_mod_gml_step_resume', 'scrHMVenusCleanup108'),
        ('gml_Object_IDPDSpawn_Create_0', 'scrHMThroneGateDefer1103'),
        ('hm_arkintide_mod_gml_hm_infantry_capture', 'scrHMThroneArrivalWaiting1103'),
        ('hm_arkintide_mod_gml_hm_stage_music_tick', 'scrHMThroneWinHeld1103'),
        ('scrHMRouteTick1103', 'scrHMThroneGateTick1103'),
        ('scrHMRouteTick1103', 'scrHMThroneTick1103'),
        ('scrHMRouteTick1103', 'scrHMCrownWatch1103'),
        ('scrHMRouteTick1103', 'scrHMElevatorAnchor1103'),
        ('scrHMThroneTick1103', 'scrHMThroneOpenWalls1103'),
        ('scrHMElevatorStep1103', 'scrHMElevatorAnchor1103'),
        ('scrHMToolChest1100', 'scrHMToolChest1103'),
        ('scrHMToolChestBegin1103', 'scrHMToolChest1103'),
        ('scrHMToolChestFinish1103', 'scrHMPickupRefresh'),
        ('hm_areas_end_area_gml_area_finish', 'scrHML2UltraGrant1103'),
        ('gml_Object_LevCont_Create_0', 'scrHML2UltraMenu1103'),
        ('gml_Object_UltraIcon_Other_10', 'scrHML2UltraConfirm1103'),
        ('scrHML2UltraTick1103', 'scrHML2UltraGrant1103'),
        ('scrHML2UltraGrant1103', 'scrHML2UltraChoices1103'),
        ('scrHML2UltraGrant1103', 'scrHML2UltraHasShared1103'),
        ('scrHML2UltraInit1103', 'scrHML2UltraReset1103'),
        ('hm_arkintide_mod_gml_hm_extra_population', 'scrHMExtraPopulation1103'),
        ('scrHMExtraPopulation1103', 'scrHMExtraTile1103'),
        ('scrHMExtraPopulation1103', 'hm_arkintide_mod_gml_hm_extra_spawn'),
        ('scrHMExtraTile1103', 'scrHMExtraPlayerDistance21103'),
        ('scrHMSewerTick', 'scrHMSewerTick1103'),
        ('scrHMSewerTick1103', 'scrHMWaterPotential1103'),
        ('scrHMSewerTick1103', 'scrHMWaterPossible1103'),
        ('gml_Object_GenCont_Alarm_1', 'scrHMStructureWallsFinalize1103'),
        ('scrHMStructureWallsFinalize1103', 'scrHMStructureWallFloor1103'),
        ('scrHMStructureWallsFinalize1103', 'scrHMStructureWallSupported1103'),
        ('scrHMStructureWallsFinalize1103', 'scrHMStructureWallKey1103'),
        ('scrHMStructureWallSupported1103', 'scrHMStructureWallSolidPoint1103'),
        ('gml_Object_Exploder_Collision_ToxicGas', 'scrHMFrogWaterConversionBlocked1103'),
        ('scrHMFrogWaterConversionBlocked1103', 'scrHMSwimSupported112'),
        ('hm_arkintide_mod_gml_hm_radiation_index', 'scrHMRadiationFlat1103'),
        ('hm_arkintide_mod_gml_hm_water_at', 'scrHMSwimSupported112'),
        ('hm_arkintide_mod_gml_hm_water_at_list', 'scrHMSwimSupported112'),
        ('hm_arkintide_mod_gml_hm_water_point', 'scrHMWaterAt'),
        ('hm_arkintide_mod_gml_hm_water_point_list', 'scrHMWaterAt'),
        ('scrHMWaterExact109', 'scrHMWaterExact1102'),
        ('hm_arkintide_mod_gml_hm_gungod_replace_tick', 'scrHMReplacementTick1102'),
        ('hm_arkintide_mod_gml_hm_idpd_portal_sprite', 'scrHMIDPDPortalSprite1102'),
        ('gml_Object_Last_Destroy_0', 'scrHMChiefDeath1102'),
        ('gml_Object_Last_Step_0', 'scrHMChiefStep1102'),
        ('gml_Object_LastBall_Destroy_0', 'scrHMChiefBallBurst1102'),
        ('scrHMChiefCreate1102', 'scrHMBossHealth1103'),
        ('hm_maincode_mod_gml_step_resume', 'scrHMBossHealth1103'),
        ('hm_enemies_mod_gml_enemyrogue_create', 'scrHMMessengerInit1103'),
        ('scrHMMessengerInit1103', 'scrHMBossHealth1103'),
        ('scrHMMessengerInit1103', 'scrHMMessengerHurt1103'),
        ('scrHMMessengerHurt1103', 'scrHMMessengerOwnsHit1103'),
        ('hm_enemies_mod_gml_enemyrogue_step_resume', 'scrHMMessengerIntro1103'),
        ('hm_enemies_mod_gml_enemyrogue_step_resume', 'scrHMMessengerTagExplosion1103'),
        ('hm_enemies_mod_gml_enemyrogue_death', 'scrHMMessengerTagExplosion1103'),
        ('hm_enemies_mod_gml_enemyrogue_death', 'scrHMMessengerCorpse1103'),
        ('hm_bosses_bossintros_mod_gml_boss_trigger', 'scrHMMessengerSkipPresentation1103'),
        ('hm_bosses_bossintros_mod_gml_draw_gui', 'scrHMReportIntroDraw1103'),
        ('hm_hm_bossbar_mod_gml_draw_gui', 'scrHMThroneBarVisible1103'),
        ('hm_arkintide_mod_gml_hm_loop_population', 'scrHMPalaceGuardianCreate1103'),
        ('gml_Object_CrownGuardian_Destroy_0', 'scrHMPalaceGuardianDeath1103'),
        ('hm_enemies_mod_gml_Minigunner_step', 'scrHMMinigunnerStep1103'),
        ('scrHMMinigunnerStep1103', 'scrHMActorOnScreen1103'),
        ('scrHMMinigunnerStep1103', 'scrHMMinigunnerReset1103'),
        ('scrHMMinigunnerStep1103', 'scrHMMinigunnerVenusShot1103'),
        ('hm_bosses_gungod_mod_gml_GunGod_create', 'scrHMGunGodHealth1103'),
        ('hm_bosses_titank_mod_gml_titank_create_resume', 'scrHMBossLoopFactor1103'),
        ('hm_enemies_mod_gml_enemyyv_create', 'scrHMBossHealth1103'),
        ('hm_arkintide_mod_gml_hm_yv_phase_create', 'scrHMBossHealth1103'),
        ('hm_bosses_guardianboss_mod_gml_guardianboss_create_resume', 'scrHMBossHealth1103'),
    ]
    for module, name in [('ravenboss', 'ravenboss_create_resume'), ('gatorboss', 'gatorboss_create'),
                         ('ratboss', 'ratboss_create'), ('scorpionboss', 'scorpionboss_create'),
                         ('throne', 'throne_create')]:
        pairs.append((f'hm_bosses_{module}_mod_gml_{name}', 'scrHMBossHealth1103'))
    for index in range(1, 5):
        pairs.append((f'hm_bosses_turtles_mod_gml_turtle{index}_create', 'scrHMBossHealth1103'))
    for obj in ('WeaponChest', 'BigWeaponChest'):
        for fn in ('scrHMToolChestBegin1103', 'scrHMToolChestFinish1103'):
            pairs.append((f'gml_Object_{obj}_Collision_Player', fn))
    # All changed area transit callbacks must observe the route before detours.
    for path in sorted((ROOT / 'project/scripts').glob('scrHMCompiled_areas_*/*.gml')):
        text = path.read_text('utf8')
        for match in re.finditer(r'^function\s+(hm_areas_\w+_area_transit)\(', text, re.M):
            if 'scrHMCrownWatch1103();' in text[match.start():]:
                pairs.append((match[1], 'scrHMCrownWatch1103'))
    assert len(pairs) == len(set(pairs))
    return pairs


def code_name(name):
    return name if name.startswith('gml_') else 'gml_Script_' + name


def has_edge(game, caller, callee):
    start, length = game.codes[code_name(caller)]
    function = game.functions.get(code_name(callee), {})
    return any(start <= ref < start + length for ref in function.get('refs', []))


def verify_code(game, functions, pairs, target):
    for rejected in ('scrHMWaterFlatIndex113', 'scrHMWaterFlatBegin113', 'scrHMWaterFlatQuery113'):
        assert code_name(rejected) not in game.codes, (target, 'Rejected slower optimization retained', rejected)
    for fn in functions + RETAINED_FUNCTIONS:
        assert code_name(fn) in game.codes, (target, 'Missing compiled function', fn)
    for caller, callee in pairs:
        assert has_edge(game, caller, callee), (target, 'Missing production integration', caller, callee)
    assert not has_edge(game, 'hm_maincode_mod_gml_step_resume', 'hm_arkintide_mod_gml_hm_throne_fall')
    for obj in ('WeaponChest', 'BigWeaponChest'):
        assert not has_edge(game, f'gml_Object_{obj}_Collision_Player', 'scrHMToolWeapon1100')
    assert not any('gml_Script_hm_hm_grillskills_mod_gml_' in name for name in game.codes), 'Grillskills must not be imported'
    assert 'Hardmode 1.1.3' in game.strings


def visible_rgba(image):
    """Transparent RGB is not retained by atlas cropping and is not visible."""
    data = bytearray(image.convert('RGBA').tobytes())
    for offset in range(0, len(data), 4):
        if not data[offset + 3]:
            data[offset:offset + 3] = b'\0\0\0'
    return bytes(data)


def verify_artwork(game, target):
    metadata = read(OUT / 'artwork.json')
    assert len(metadata) == 3 and {row['name'] for row in metadata} == set(ARTWORK)
    table = game.parts[b'SPRT'][0]
    sprites = {}
    for index in range(game.u32(table)):
        pointer = game.u32(table + 4 + 4 * index)
        name = game.string(game.u32(pointer))
        assert name not in sprites
        sprites[name] = pointer
    pages, records = {}, []
    for row in metadata:
        name = row['name']
        count, origin, size, png_digest, rgba_digest = ARTWORK[name]
        assert (row['frames'], row['origin'], row['size'], row['png_sha256'], row['rgba_sha256']) == (count, origin, size, png_digest, rgba_digest)
        source = ROOT / row['source']
        assert sha(source) == png_digest
        image = Image.open(source).convert('RGBA')
        assert list(image.size) == size and rawsha(image.tobytes()) == rgba_digest
        width, height = size[0] // count, size[1]
        pointer = sprites[name]
        assert struct.unpack_from('<II', game.data, pointer + 4) == (width, height), (target, name)
        assert list(struct.unpack_from('<ii', game.data, pointer + 48)) == origin, (target, name, 'origin')
        assert game.u32(pointer + 56) == 0xFFFFFFFF and game.u32(pointer + 60) == 3
        assert game.u32(pointer + 84) == count, (target, name, 'frame count')
        for index in range(count):
            expected = image.crop((index * width, 0, (index + 1) * width, height))
            frame = Image.new('RGBA', (width, height))
            tpag = game.u32(pointer + 88 + index * 4)
            if tpag in (0, 0xFFFFFFFF):
                assert expected.getchannel('A').getbbox() is None
            else:
                sx, sy, sw, sh, tx, ty, tw, th, bw, bh, page = struct.unpack_from('<10Hh', game.data, tpag)
                assert (bw, bh) == (width, height) and page >= 0
                if page not in pages:
                    texture = game.u32(game.parts[b'TXTR'][0] + 4 + page * 4)
                    capacity, page_width, page_height = struct.unpack_from('<III', game.data, texture + 8)
                    png = game.u32(texture + 24)
                    raw = bytes(game.data[png:png + capacity])
                    assert raw.startswith(b'\x89PNG\r\n\x1a\n'), (target, name, 'Unsupported texture encoding')
                    pages[page] = Image.open(io.BytesIO(raw)).convert('RGBA')
                    assert pages[page].size == (page_width, page_height)
                assert sx + sw <= pages[page].width and sy + sh <= pages[page].height
                assert tx + tw <= width and ty + th <= height
                crop = pages[page].crop((sx, sy, sx + sw, sy + sh))
                if crop.size != (tw, th):
                    crop = crop.resize((tw, th), Image.Resampling.NEAREST)
                frame.paste(crop, (tx, ty))
            assert visible_rgba(frame) == visible_rgba(expected), (target, name, 'Sprite pixels differ', index)
        records.append(dict(name=name, frames=count, origin=origin, source_rgba_sha256=rgba_digest,
                            compiled_frames_verified=count, compiled_visible_pixels_match=True))
    return records


def verify_icon_source():
    """Verify private input and frozen options before read-only package checks.

    change_icon1103.source_image() can recover a missing private file from the
    desktop. Requiring its exact existing private input here ensures that the
    final delivery gate never uses that write/recovery path.
    """
    plan_path = OUT / 'icon-source/icon-plan.json'
    plan = read(plan_path)
    assert plan['source_private'] == 'release1103/icon-source/TDA7gy.png'
    source = local(plan['source_private'])
    assert sha(source) == plan['source_sha256'] == ICON_SOURCE_SHA256
    assert plan['source_size'] == [347, 384]
    assert Image.open(source).size == (347, 384)
    assert plan['source_cropped'] is False and plan['aspect_ratio_preserved'] is True
    assert plan['assets_publication'] is False and plan['ios_asset_catalog_icon_selected'] is False
    assert plan['ios_active_basename'] == ICON_PREFIX == 'HM113Icon'
    assert plan['resampling'] == 'LANCZOS' and plan['square_content_height_fraction'] == .88
    assert (plan['adaptive_safe_circle_diameter_dp'], plan['adaptive_canvas_dp'],
            plan['adaptive_safe_circle_margin']) == (66, 108, .96)
    assert len(plan['project_files']) == 44 and len(plan['android_runner_files']) == 25
    for relative, row in plan['project_files'].items():
        assert relative.startswith('project/options/') and sha(local(relative)) == row['png_sha256']
        image = Image.open(local(relative)).convert('RGBA')
        assert list(image.size) == row['size'] and rawsha(image.tobytes()) == row['rgba_sha256']
    for relative, digest in plan['android_runner_files'].items():
        assert relative.startswith('platforms/android/gradle-project/' + PACKAGE + '/src/main/res/')
        assert sha(local(relative)) == digest, ('Stale Android launcher source', relative)
    return dict(plan_sha256=sha(plan_path), source_sha256=ICON_SOURCE_SHA256,
                source_cropped=False, aspect_ratio_preserved=True,
                project_icon_files_verified=44, android_runner_files_verified=25,
                private_artwork_published=False)


def verify_packages(desktop, functions, pairs):
    build = read(OUT / 'mobile-resource-build.json')
    assert (build['status'], build['version'], build['build']) == ('PASS', VERSION, BUILD)
    assert build['source_manifest_sha256'] == sha(OUT / 'final-source.json')
    assert build['source_code_archive_sha256'] == sha(OUT / 'final-code.zip')
    assert build['desktop_vm_sha256'] == desktop and set(build['targets']) == {'android', 'ios'}
    android_baseline = ROOT / 'deliverables/NuclearThrone.Hardmode-Android-1.1.2.apk'
    baseline_validation = read(android_baseline.with_suffix('.validation.json'))
    assert sha(android_baseline) == baseline_validation['apk_sha256']
    # Gradle's four built-in files are inherited from the verified 1.1.2 APK;
    # they are not part of the freshly compiled GameMaker resource set.
    builtin_names = {'dexopt/baseline.prof', 'dexopt/baseline.profm', 'portrait_splash.png', 'splash.png'}
    with zipfile.ZipFile(android_baseline) as archive:
        builtin_assets = {name: rawsha(archive.read('assets/' + name)) for name in builtin_names}
    artifacts = []
    for target, label, ext in [('android', 'Android', 'apk'), ('ios', 'iOS', 'ipa')]:
        path = ROOT / f'deliverables/NuclearThrone.Hardmode-{label}-{VERSION}.{ext}'
        validation_path = path.with_suffix('.validation.json')
        validation = read(validation_path)
        assert (validation['package'], validation['version'], validation['build']) == (PACKAGE, VERSION, BUILD)
        assert validation[ext + '_sha256'] == sha(path)
        assert validation['physical_device_tested'] is False
        prep_path = ROOT / f'platforms/{target}/prepared-receipt.json'
        prep = read(prep_path)
        assert prep['target'] == target
        assert prep['timing_code'] == 'gml_Object_MakeGame_Create_0'
        assert prep['timing_method'] == (1 if target == 'ios' else 0)
        assert prep['timing_reference_count'] == 2
        assert len(prep['fonts']) == 2 and all(row['original_pixels_match'] for row in prep['fonts'])
        assert len(prep['title']) == 3 and all(row['original_pixels_match'] for row in prep['title'])
        vm = 'game.droid' if target == 'android' else 'game.ios'
        resource_zip = ROOT / f'build-{target}/nuclearthronemobile.zip'
        resource = build['targets'][target]
        assert resource['zip_sha256'] == sha(resource_zip)
        assert datetime.fromisoformat(resource['built_utc']) >= datetime.fromisoformat(read(OUT / 'final-source.json')['recorded_utc'])
        with zipfile.ZipFile(resource_zip) as archive:
            assert archive.testzip() is None
            assert rawsha(archive.read('assets/' + vm)) == resource['raw_vm_sha256'] == prep['raw_vm_sha256']
            resource_assets = {name.removeprefix('assets/') for name in archive.namelist()
                               if name.startswith('assets/') and not name.endswith('/')}
            assert resource_assets == set(prep['assets']), (target, 'Prepared resource inventory mismatch')
        prepared = ROOT / f'platforms/{target}/prepared-assets/{vm}'
        prepared_digest = sha(prepared)
        assert prepared_digest == prep['prepared_vm_sha256']
        prepared_root = prepared.parent
        prepared_names = {file.relative_to(prepared_root).as_posix()
                          for file in prepared_root.rglob('*') if file.is_file()}
        assert prepared_names == set(prep['assets']), (target, 'Stale loose prepared assets')
        for name, digest in prep['assets'].items():
            assert sha(prepared_root / name) == digest, (target, 'Prepared resource hash mismatch', name)
        # Inspect the exact packaged VM rather than trusting a loose prepared file.
        with zipfile.ZipFile(path) as archive:
            assert archive.testzip() is None and len(archive.namelist()) == len(set(archive.namelist()))
            if target == 'android':
                packaged_vm = archive.read('assets/' + vm)
                assert validation['game_assets_exact'] and validation['zip_16k_alignment']
                omitted = {'.gitignore', 'lang/.gitkeep'}
                assert set(validation['ignored_non_game_files']) == omitted
                expected_assets = set(prep['assets']) - omitted
                assert not (builtin_names & set(prep['assets']))
                packaged_assets = {name.removeprefix('assets/') for name in archive.namelist()
                                   if name.startswith('assets/') and not name.endswith('/')}
                assert packaged_assets == expected_assets | builtin_names, 'Stale or missing APK resource'
                for name in expected_assets:
                    assert rawsha(archive.read('assets/' + name)) == prep['assets'][name], ('APK resource mismatch', name)
                for name, digest in builtin_assets.items():
                    assert rawsha(archive.read('assets/' + name)) == digest, ('APK built-in asset changed', name)
                assert len(validation['native_libraries']) == 2
                assert {library['elf_bits'] for library in validation['native_libraries']} == {32, 64}
                for library in validation['native_libraries']:
                    assert library['zip_alignment'] == 16384
                    assert rawsha(archive.read(library['path'])) == library['sha256']
            else:
                infos = [name for name in archive.namelist() if name.endswith('.app/Info.plist')]
                assert len(infos) == 1
                info = plistlib.loads(archive.read(infos[0]))
                app = infos[0].removesuffix('Info.plist')
                assert (info['CFBundleIdentifier'], info['CFBundleShortVersionString'], info['CFBundleVersion']) == (PACKAGE, VERSION, str(BUILD))
                assert info['UIFileSharingEnabled'] and info['LSSupportsOpeningDocumentsInPlace']
                packaged_vm = archive.read(app + 'games/' + vm)
                packaged_assets = {name.removeprefix(app + 'games/') for name in archive.namelist()
                                   if name.startswith(app + 'games/') and not name.endswith('/')}
                assert packaged_assets == set(prep['assets']), 'Stale or missing IPA game resource'
                for name, digest in prep['assets'].items():
                    assert rawsha(archive.read(app + 'games/' + name)) == digest, ('IPA resource mismatch', name)
                compatibility = read(OUT / 'ios-native-compatibility.json')
                assert rawsha(archive.read(app + info['CFBundleExecutable'])) == validation['runner_sha256'] == compatibility['native_sha256']
                assert compatibility['game_vm_sha256'] == prepared_digest
                assert compatibility['compatible_added_functions_and_extensions'] and not compatibility['missing_native_registrations']
                assert compatibility['extension_chunk_identical'] and compatibility['old_extension_count'] == compatibility['new_extension_count'] == 0
                assert compatibility['verified_additional_functions'] == compatibility['additional_vm_functions']
                assert validation['requires_resigning'] and validation['mac_native_rebuild'] is False
            assert rawsha(packaged_vm) == prepared_digest
            game = Game(packaged_vm)
            verify_code(game, functions, pairs, target)
            artwork = verify_artwork(game, target)
        # Resolve the exact final archive's active icon references and inspect
        # their pixels. Loose project options and an old icons.json are not
        # evidence that Android/iOS will select the new launcher artwork.
        icons = (verify_android_icon if target == 'android' else verify_ios_icon)(path)
        assert icons['source_sha256'] == ICON_SOURCE_SHA256
        assert icons['all_active_icon_pixels_match'] and icons['source_cropped'] is False
        assert icons['files']
        if target == 'android':
            assert icons['compiled_resource_paths_resolved']
            assert icons['adaptive_foreground_safe_circle_verified']
        else:
            assert icons['active_icon_basename'] == ICON_PREFIX and icons['catalog_icon_selected'] is False
            assert validation['icons'] == icons, 'Stale iOS launcher validation'
        artifacts.append(dict(path=path.relative_to(ROOT).as_posix(), bytes=path.stat().st_size,
            sha256=sha(path), validation_sha256=sha(validation_path),
            resource_zip_sha256=sha(resource_zip), raw_vm_sha256=prep['raw_vm_sha256'],
            prepared_receipt_sha256=sha(prep_path), prepared_vm_sha256=prepared_digest,
            packaged_vm_sha256=prepared_digest, compiled_artwork=artwork, launcher_icons=icons,
            production_call_edges_verified=len(pairs)))
    old = read(ROOT / 'deliverables/NuclearThrone.Hardmode-Android-1.1.2.validation.json')
    new = read(ROOT / f'deliverables/NuclearThrone.Hardmode-Android-{VERSION}.validation.json')
    assert old['package'] == new['package'] == PACKAGE
    assert old['certificate_sha256'] == new['certificate_sha256'], 'Android update signing continuity broken'
    return artifacts


def verify_platform_audits():
    storage = read(OUT / 'mobile-storage-audit.json')
    pacing = read(OUT / 'android-pacing.json')
    assert storage['android_shared_storage_permission_packaged'] and storage['ios_documents_sharing_enabled']
    assert storage['android_monotonic_pacer_dex_call_before_native_process']
    assert storage['android_public_root'] == '/storage/emulated/0/games/' + PACKAGE + '/'
    assert storage['ios_documents_subdirectory'] == 'hardmode/'
    assert storage['physical_device_tested'] is False and pacing['physical_device_tested'] is False
    assert pacing['status'] == 'PASS' and pacing['checks'] == 12
    for relative, digest in pacing['source_sha256'].items():
        assert sha(local(relative)) == digest, ('Stale Android pacer test', relative)
    assert storage['android_pacer_source_sha256'] == sha(ROOT / 'android/HardmodeFramePacer.java')
    java_root = ROOT / f'platforms/android/gradle-project/{PACKAGE}/src/main/java/{PACKAGE.replace(".", "/")}'
    assert storage['android_extension_java_sha256'] == sha(java_root / 'YYExtra.java')
    assert storage['android_renderer_sha256'] == pacing['renderer_sha256'] == sha(java_root / 'DemoRenderer.java')
    manifest = ROOT / f'platforms/android/gradle-project/{PACKAGE}/src/main/AndroidManifest.xml'
    assert storage['android_manifest_sha256'] == sha(manifest)
    return {name: sha(OUT / name) for name in ('mobile-storage-audit.json', 'android-pacing.json',
                                               'ios-native-compatibility.json', 'mobile-resource-build.json')}


def verify_profiles(desktop):
    path = OUT / 'loop-final-profiles.json'
    report = read(path)
    assert report['status'] == 'PASS' and report['final_vm_sha256'] == desktop
    assert report['physical_phone_tested'] is False and report['performance_fps_claim'] is False
    assert report['baseline_sha256'] == sha(OUT / 'loop-baseline-profiles.json')
    expected = {case for case in REQUIRED if case.endswith(',profile106')}
    assert {row['scenario'] for row in report['measurements']} == expected
    for row in report['measurements']:
        folder = OUT / 'tests' / row['scenario'].replace(',', '-')
        assert row['final_vm_sha256'] == desktop
        assert row['receipt_sha256'] == sha(folder / 'receipt.json')
        assert row['runner_log_sha256'] == sha(folder / 'runner.log')
    return dict(path=path.relative_to(ROOT).as_posix(), sha256=sha(path), **report)


def main():
    assert (VERSION, BUILD) == ('1.1.3', 17)
    frozen, desktop = verify_source()
    scope = verify_scope()
    rows = verify_runtime(desktop)
    all_stages = verify_allareas(desktop, rows)
    functions, pairs = production_functions(), critical_edges()
    desktop_game = Game((ROOT / 'build-windows/nuclearthronemobile.win').read_bytes())
    verify_code(desktop_game, functions, pairs, 'final desktop VM')
    desktop_artwork = verify_artwork(desktop_game, 'final desktop VM')
    icon_source = verify_icon_source()
    artifacts = verify_packages(desktop, functions, pairs)
    platform_audits = verify_platform_audits()
    profiles = verify_profiles(desktop)
    report = dict(status='PASS', version=VERSION, build=BUILD, mod='Hardmode b24',
        verified_utc=datetime.now(timezone.utc).isoformat(), installation_packages_generated=True,
        source_manifest_sha256=sha(OUT / 'final-source.json'), source_code_archive_sha256=sha(OUT / 'final-code.zip'),
        final_desktop_vm_sha256=desktop, original_files_verified=frozen['original_files_verified'],
        scope=scope, grillskills_imported=False, gameplay_cases=len(REQUIRED),
        gameplay_assertions=sum(row['checks'] for row in rows if row['scenario'] in REQUIRED),
        runtime_cases=rows, all_stage_coverage=all_stages, artifacts=artifacts, compiled_repair_functions=functions,
        retained_1102_functions=RETAINED_FUNCTIONS,
        verified_production_call_edges=[dict(caller=caller, callee=callee) for caller, callee in pairs],
        desktop_compiled_artwork=desktop_artwork, launcher_icon_source=icon_source, platform_audits=platform_audits,
        host_performance_profiles=profiles,
        replacement_policy=dict(min_loop=1, chief_probability=.05, venus_probability=.05,
            mutually_exclusive=True, excluded=['throne', 'venuz', 'HQ', 'native HQ', 'native Y.V crib',
                                              'existing palace/end exclusions']),
        test_audio='1250 sound-resource gains zeroed in a separate test VM; master/session muted at 0%',
        foreground_window_control_used=False, phone_device_tested=False, mac_native_rebuild=False,
        ios_requires_resigning=True, github_uploaded=False, mega_uploaded=False,
        limits=['Targeted compiled desktop host VM tests, not physical phone or exhaustive campaign acceptance.',
                'No phone performance measurement or universal high-loop FPS claim is made.',
                'Android offline release lint unavailable; signature/resource/alignment checks used.',
                'iOS uses a compatible retained runner with fresh VM/resources and requires resigning.'])
    (OUT / 'delivery-receipt.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n', 'utf8')
    print('Delivery PASS:', VERSION, 'scope114/114 + 6 mobile follow-ups = 37 items, gameplay cases', len(REQUIRED), 'VM scenarios', len(rows))


if __name__ == '__main__':
    main()
