"""Apply the narrow cursed-cave extra-boss lifecycle repair without a build.

Native instance snapshots can still contain an extra HyperCrystal after it has
become a CustomEnemy in the same event. That living actor must not schedule the
normal stage-boss outro merely because its native object type has changed.
"""
from pathlib import Path
import hashlib
import json
import re

from sync1103_tools import span

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / 'project'
BACKUP = ROOT / 'release1103' / 'cave-lifecycle-original'
HELPER = 'scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml'
MAIN = 'scripts/scrHMCompiled_maincode_mod_gml/scrHMCompiled_maincode_mod_gml.gml'
CAVES = 'scripts/scrHMCompiled_areas_cavesinv_area_gml/scrHMCompiled_areas_cavesinv_area_gml.gml'
DESTROY = 'objects/HyperCrystal/Destroy_0.gml'
BEGIN = '// BEGIN CAVE1103 TEMP DIAGNOSTICS'
END = '// END CAVE1103 TEMP DIAGNOSTICS'
CHANGED = []


def keep(path):
    relative = path.relative_to(ROOT)
    target = BACKUP / relative
    if not target.exists():
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(path.read_bytes())


def write(path, text):
    if path.read_text('utf8') == text:
        return
    keep(path)
    path.write_text(text, 'utf8')
    CHANGED.append(path.relative_to(ROOT).as_posix())


def strip(text):
    return re.sub(re.escape(BEGIN) + r'\n[\s\S]*?' + re.escape(END) + r'\n?', '', text)


def apply():
    # The lifecycle diagnostics are intentionally absent from production.
    for relative in (HELPER, MAIN, CAVES, DESTROY):
        path = PROJECT / relative
        text = strip(path.read_text('utf8'))
        if relative == MAIN:
            old = ('if(instance_exists(__hm_with611[__hm_index612])) with (__hm_with611[__hm_index612]) {\n'
                   '{\n')
            new = old + ('// A converted extra can remain in this event\'s native snapshot.\n'
                         'if(self[$ "hm_extra"]??false) continue;\n')
            if new not in text:
                assert text.count(old) == 1, 'cursed HyperCrystal snapshot loop'
                text = text.replace(old, new, 1)
            _, start, end, _ = span(text, 'hm_maincode_mod_gml_CHCoutro')
            text = text[:start] + '\n' + '''var _source=creator,_extra=false;
if(instance_exists(_source)) _extra=(_source[$ "hm_extra"]??false);
if(!_extra && !instance_exists(HyperCrystal)) {
hm_arkintide_mod_gml_hm_cave_restore(argument0, argument1);
}
instance_destroy();
''' + text[end:]
        elif relative == DESTROY:
            old = 'if(scrHMEnabled() && GameCont.area==scrHMAreaResolve("cavesinv"))'
            new = 'if(scrHMEnabled() && !(self[$ "hm_extra"]??false) && GameCont.area==scrHMAreaResolve("cavesinv"))'
            if new not in text:
                assert text.count(old) == 1, 'native cursed HyperCrystal death bridge'
                text = text.replace(old, new, 1)
        write(path, text)
    write(ROOT / 'native/compiled_arkintide1103.gml', (PROJECT / HELPER).read_text('utf8'))
    rows = []
    for path in sorted(BACKUP.rglob('*')):
        if path.is_file() and path.name != 'manifest.json':
            rows.append({'path': path.relative_to(BACKUP).as_posix(),
                         'sha256': hashlib.sha256(path.read_bytes()).hexdigest()})
    (BACKUP / 'manifest.json').write_text(json.dumps(rows, indent=2) + '\n', 'utf8')
    print(json.dumps({'changed': CHANGED}))


if __name__ == '__main__':
    apply()
