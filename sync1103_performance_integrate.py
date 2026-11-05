"""Incremental water/Rad hooks, called only by the root-owned integrator.

Importing this module never mutates the project or starts an engine/build.
The existing DS-map implementation remains the invocation fallback in full.
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / 'project'

HELPER = 'scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml'
WATER = 'scripts/scrHMRepairs104/scrHMRepairs104.gml'
TESTS = 'scripts/scrHMGameplayTests/scrHMGameplayTests.gml'

# The caller mirrors final project text only after all incremental hooks have
# been applied, thereby retaining its other reviewed compiled-helper edits.
MIRRORS = {
    WATER: 'native/repairs104.gml',
    HELPER: 'native/compiled_arkintide1103.gml',
}


def apply(project, save, edit, replace_function, register_script):
    """Callbacks are supplied by the central integrator; no direct writes.

    save(relative,text), edit(relative,old,new,count=1),
    replace_function(relative,name,body), register_script(project,name,source).
    """
    register_script(project, 'scrHMSync1103Performance',
                    (ROOT / 'native/sync1103_performance.gml').read_text('utf8'))
    register_script(project, 'scrHMGameplay1103Performance',
                    (ROOT / 'tests/sync1103_performance.gml').read_text('utf8'))
    replace_function(WATER, 'scrHMSewerTick', 'scrHMSewerTick1103();')

    # Generation-time Rat/Crab tests and extra Rat footprint fitting still
    # call the compiled NTT API. Use the same live mobile physical geometry
    # as actual swimming: Floor32/FloorExplo16, half-open fractional bounds,
    # live surface111 banks and the host's +/-3,+/-2 foot support. Keeping
    # the old inclusive NTT bbox/+/-4 helpers here would retain seam gaps
    # outside the optimized actor pass. Existing scratch-list parameters
    # remain source-compatible; they no longer own a second water index.
    for name in ('hm_water_at', 'hm_water_at_list'):
        replace_function(HELPER, 'hm_arkintide_mod_gml_' + name,
                         'return scrHMSwimSupported112(_hml__x,_hml__y);')
    for name in ('hm_water_point', 'hm_water_point_list'):
        replace_function(HELPER, 'hm_arkintide_mod_gml_' + name,
                         'return scrHMWaterAt(_hml__x,_hml__y);')

    # Retain every original guard, DS-map operation, effect and callback as
    # the fallback. The flat helper returns false before any gameplay work
    # for sparse/spread-out/no-controller scenes.
    old = 'function hm_arkintide_mod_gml_hm_radiation_index() {'
    new = old + '\nif(scrHMRadiationFlat1103()) return;'
    if new not in (PROJECT / HELPER).read_text('utf8'):
        edit(HELPER, old, new)

    call = 'if(string_pos("sync113",mode)==1) scrHMGameplayPerformance1103();'
    if call not in (PROJECT / TESTS).read_text('utf8'):
        anchor = 'if(string_pos("sync112",mode)==1) scrHMGameplay1102();'
        edit(TESTS, anchor, anchor + '\n        ' + call)
