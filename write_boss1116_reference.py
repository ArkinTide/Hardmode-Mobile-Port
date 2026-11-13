"""Save reproducible local reference evidence, without claiming test results."""
from pathlib import Path
from hashlib import sha256
import json, shutil

ROOT=Path(__file__).resolve().parent
QI=ROOT.parents[1]
ANALYSIS=QI/'analysis/hardmode1116/reference'
OUT=ROOT/'release1106/reference'
OUT.mkdir(parents=True,exist_ok=True)

inputs=[
    Path('D:/Steam/steamapps/common/Nuclear Throne/nuclearthrone.exe'),
    Path('D:/Steam/steamapps/common/Nuclear Throne/mods/hardmode/arkintide.mod.gml'),
    Path('D:/Steam/steamapps/common/Nuclear Throne/mods/hardmode/maincode.mod.gml'),
    Path('C:/Users/ArkinTide/Videos/2026-11-13 11-42-12.mp4'),
]
def receipt(p):
    h=sha256()
    with p.open('rb') as f:
        for chunk in iter(lambda:f.read(1024*1024),b''):h.update(chunk)
    return dict(path=str(p),bytes=p.stat().st_size,sha256=h.hexdigest())

for name in ['desktop-Last-YVBoss.txt','desktop-event-names.json','inspect_desktop.py']:
    shutil.copy2(ANALYSIS/name,OUT/name)

evidence=dict(
    inputs=[receipt(p) for p in inputs],
    native_arch='PE64 x86-64; image base 0x140000000',
    native_functions=dict(
        Last_Create='0x14118c9a0',Last_Alarm1='0x14118ee60',
        Last_Alarm5='0x141196e70',Last_Other15='0x141199750',
        YVBoss_Create='0x1414e3be0',YVBoss_Alarm1='0x1414e68b0',
        YVBoss_Alarm2='0x1414eb600'),
    yv=dict(magazine='70 + 30 * loops',shots_per_alarm='1 + loops',alarm2=1,
        complete_burst='The final burst is not truncated at zero ammo; total shots = ceil(magazine / (1 + loops)) * (1 + loops).',
        turn='after decrement: (ammo + 10 > max_ammo) ? side / 2 : side',
        minigun_max_field='0x1414e4b9a',max_loop_field='0x1414e4bc7',
        max_times30='0x1414e4c42',max_plus70='0x1414e4c80',
        turn_ammo_field='0x1414ec191',turn_max_field='0x1414ec1a7',
        turn_plus10='0x1414ec1ed',turn_half='0x1414ec2c4',turn_full='0x1414ec326'),
    captain=dict(
        verified='Desktop wrapper restores native Last events; timers decrement by current_time_scale.',
        native_loop_references='Only Last Create accesses loops in the mapped Last events; the access is in health initialization.',
        limitation='No native or installed-mod Loop movement/action multiplier was verified. The video alone does not establish a numeric multiplier.',
        implemented='Removed the previously invented 5% multiplier; retain native movement/alarm timings and health-dependent attack timing. Shared runtime scheduling fixes are owned by the runtime implementation.'),
    tests=dict(
        boss1116='Big Dog real eye opening and native bounce burst; Messenger own/child explosion immunity; tagged GunGod rocket blast immunity with wall/direct-target detonation and ordinary-rocket control.',
        yv1115minigun='Production Alarm1 selection, automatic real Alarm2 sequence, per-alarm ammo decrement and remaining-ammo turn, entire magazine duration and complete final burst. Run Loop0, Loop1, Loop2 and Loop3 at 30 and 60 FPS.',
        status='Source fixtures prepared. Final execution results belong to the release1106 delivery receipt; no pass is asserted by this reference file.'))
(OUT/'boss1116-reference.json').write_text(json.dumps(evidence,ensure_ascii=False,indent=2)+'\n','utf-8')
(OUT/'README.md').write_text('''# Desktop boss references for Hardmode mobile 1.1.6

These references were read locally. Input sizes and SHA-256 hashes are in
`boss1116-reference.json`. The native source is the installed 64-bit
`nuclearthrone.exe`. The older 32-bit executable under `9940/` lacks YVBoss
and was not used for the Y.V behavior decision.

`inspect_desktop.py` maps native functions using PE `.pdata` ranges and
RIP-relative references to GameMaker function/variable names. The annotated
output and event-name map are included. The script expects Capstone 5.0.6;
its analysis dependency path is local and is not a shipping requirement.

Y.V's magazine is `70 + 30 * Loop`; each real Alarm 2 emits `1 + Loop`
shots and resets Alarm 2 to 1. After each decrement, `ammo + 10 > max`
selects a half-degree turn; other shots turn one degree. This exact strict
comparison produces nine half-degree shots in a complete fresh magazine.
The full magazines therefore sweep 65.5, 95.5 and 155.5 degrees at Loops
0, 1 and 3. The final native burst continues past zero ammo when necessary:
Loop2 has a 130-round budget but fires 44 complete three-shot bursts,
132 shots total and 127.5 degrees of turn. Tests include this remainder case.
Tests compare every observed native alarm to remaining ammo;
they do not infer success from constants or source text alone.

The installed Hardmode Captain wrapper (`arkintide.mod.gml`,
`hm_chief_event`/`hm_chief_step`) restores original Last alarms and movement
and advances its timers by `current_time_scale`. The mapped native Last
events reference Loop only in Create's health initialization. No explicit
Loop movement/action multiplier was verified. The supplied 39.9-second,
60-FPS video shows attack behavior, but does not establish a numeric Loop
multiplier. Consequently the mobile port removes its prior guessed 5%
multiplier and retains native timings; shared simulation overload is handled
by the runtime scheduling fix. Do not describe an unverified speed factor
as original desktop behavior.

Big Dog's eye frames advance from 0 to 11 by 0.4 per 30-Hz tick, matching
the installed Hardmode `maincode.mod.gml` ScrapBoss section. Its own
EnemyBullet1 burst converts into LHBouncer with the desktop red blend and
20% deletion chance through the existing helper, now called by actual
native firing. The older dog105 fixture bypasses only eye opening to
isolate a real wall bounce; boss1116 separately observes the full opening.

Final host/package test acceptance is recorded by the parent release
receipt. This directory provides reference evidence and fixture intent,
not a declaration that hardware tests passed.
''','utf-8')
print(json.dumps(dict(out=str(OUT),inputs=evidence['inputs']),ensure_ascii=False,indent=2))
