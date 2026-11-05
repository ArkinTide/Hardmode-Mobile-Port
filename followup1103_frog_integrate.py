"""Mobile-only sewer frog collision guard; root owns final integration/build.

Import has no side effects. Retains the complete native collision tail and
never changes Exploder AI, water presentation, Player, or SuperFrog events.
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / 'project'
COLLISION = 'objects/Exploder/Collision_ToxicGas.gml'
TESTS = 'scripts/scrHMGameplayTests/scrHMGameplayTests.gml'
MIRRORS = {}


def apply(project, save, edit, replace_function, register_script):
    register_script(project, 'scrHMFollowup1103Frog',
                    (ROOT / 'native/followup1103_frog.gml').read_text('utf8'))
    register_script(project, 'scrHMGameplay1103Frog',
                    (ROOT / 'tests/followup1103_frog.gml').read_text('utf8'))
    guard = 'if(scrHMFrogWaterConversionBlocked1103()) exit;'
    text = (PROJECT / COLLISION).read_text('utf8')
    if guard not in text:
        # This is the only production Exploder -> SuperFrog creation path.
        # Keep lockstep's original return ahead of our physical water query.
        anchor = 'if lockstep_stop\n\texit\n'
        assert text.count(anchor) == 1, (COLLISION, 'lockstep anchor')
        save(COLLISION, text.replace(anchor, anchor + '\n' + guard + '\n', 1))
    call = 'if(string_pos("sync113",mode)==1) scrHMGameplayFrog1103();'
    if call not in (PROJECT / TESTS).read_text('utf8'):
        anchor = 'if(string_pos("sync112",mode)==1) scrHMGameplay1102();'
        edit(TESTS, anchor, anchor + '\n        ' + call)
