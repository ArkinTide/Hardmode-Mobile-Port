"""Incremental 1.1.4 boss UI/layer repairs; never reimports the frozen MOD."""
from pathlib import Path
import hashlib, json, re

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / 'project'
OUT = ROOT / 'release1104'
BAR = 'scripts/scrHMCompiled_hm_bossbar_mod_gml/scrHMCompiled_hm_bossbar_mod_gml.gml'
LABELS = {
    'THE NUCLEAR THRONE': '核能王座', 'THRONE II': '王座II',
    'THRONEII': '王座II', 'THE MESSENGER': '通信员',
    'GREAT GUARDIAN': '至高守护者', 'GREATER GUARDIAN': '至高守护者',
    "LIL' HUNTER": '小猎人', 'GENERATOR': '发电机', 'MOM': '母亲',
    'TECHNOMANCER': '科技术士', 'CROWN GUARDIAN': '王冠守护者',
    'CURSED HYPER CRYSTAL': '诅咒超级水晶', 'CAPTAIN': '局长',
    'GIANT SCORPION': '巨型蝎子', 'BIG RAT': '大老鼠', 'TURTLE': '乌龟首领',
}


def bounds(text, name):
    match = re.search(r'^function ' + re.escape(name) + r'\([^\n]*\)\s*\{', text, re.M)
    assert match, name
    depth = 1
    for token in re.finditer(r'//[^\n]*|/\*[\s\S]*?\*/|"(?:\\.|[^"\\])*"|[{}]', text[match.end():]):
        if token[0] == '{': depth += 1
        elif token[0] == '}':
            depth -= 1
            if not depth: return match.end(), match.end() + token.start()
    raise AssertionError(name)


def save(relative, text):
    path = PROJECT / relative
    if path.exists() and path.read_text('utf8') == text: return
    if path.exists():
        backup = OUT / 'baseline-ui' / relative
        if not backup.exists():
            backup.parent.mkdir(parents=True, exist_ok=True)
            backup.write_bytes(path.read_bytes())
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, 'utf8')


def main():
    text = (PROJECT / BAR).read_text('utf8')
    # A GUI End pass is independent of Wall/Top/actor depth. Local bars retain
    # their world anchors, translated to GUI coordinates only for this pass.
    if 'function scrHMBossBarsLocal1104' not in text:
        start, end = bounds(text, 'hm_hm_bossbar_mod_gml_draw')
        local = text[start:end]
        local = local.replace('hm_hm_bossbar_mod_gml_hm_bossbar(', 'scrHMBossWorldBar1104(')
        local = local.replace('hm_arkintide_mod_gml_hm_bossbar_top()', 'scrHMBossTop1104()')
        text = text[:start] + '\n// Boss bars are rendered once in HMWorld GUI End.\n' + text[end:]
        start, end = bounds(text, 'hm_hm_bossbar_mod_gml_draw_gui')
        top = text[start:end].replace('hm_arkintide_mod_gml_hm_bossbar_top()', 'scrHMBossTop1104()')
        text = text[:start] + '\n// Deferred until GUI End, after world art and darkness.\n' + text[end:]
        text += '\nfunction scrHMBossBarsLocal1104() {' + local + '}\n'
        text += '\nfunction scrHMBossBarsTop1104() {' + top + '}\n'
    # Name keys are presentation literals, never actor identity/AI keys.
    text = text.replace('"Y.V."', '"Y.V"')
    save(BAR, text)

    native = (ROOT / 'native/ui1104.gml').read_text('utf8')
    save('scripts/scrHMUI1104/scrHMUI1104.gml', native)
    save('scripts/scrHMGameplayUI1104/scrHMGameplayUI1104.gml', (ROOT/'tests/ui1104.gml').read_text('utf8'))

    # The inherited query sees only GameObject children. The disjoint mobile
    # damagesource tree also includes native bullets, explosions and beams.
    relative = 'scripts/scrHMRepairs109/scrHMRepairs109.gml'
    original = (PROJECT / relative).read_text('utf8')
    start, end = bounds(original, 'scrHMGuardianLayers109')
    replacement = '\n    scrHMGuardianLayers1104();\n'
    save(relative, original[:start] + replacement + original[end:])
    mirror = ROOT/'native/repairs109.gml'
    original = mirror.read_text('utf8')
    start, end = bounds(original, 'scrHMGuardianLayers109')
    revised = original[:start] + replacement + original[end:]
    if original != revised:
        backup = OUT/'baseline-ui-native/repairs109.gml'
        if not backup.exists():
            backup.parent.mkdir(parents=True,exist_ok=True);backup.write_bytes(mirror.read_bytes())
        mirror.write_text(revised,'utf8')

    relative = 'objects/HMWorld/HMWorld.yy'
    from create_project import load
    meta = load(PROJECT / relative)
    if not any(e['eventType'] == 8 and e['eventNum'] == 75 for e in meta['eventList']):
        meta['eventList'].append({'$GMEvent':'v1','%Name':'','collisionObjectId':None,'eventNum':75,'eventType':8,'isDnD':False,'name':'','resourceType':'GMEvent','resourceVersion':'2.0'})
        save(relative, json.dumps(meta, ensure_ascii=False, indent=2) + '\n')
    save('objects/HMWorld/Draw_75.gml', 'if(!lockstep_stop) scrHMBossBarsOverlay1104();\n'
         'if(instance_exists(HMGameplayTest)) with(HMGameplayTest) scrHMGameplayUIRender1104();\n')

    catalog_path = ROOT/'localization/zh-CN.json'
    catalog = json.loads(catalog_path.read_text('utf8'))
    catalog.update(LABELS)
    catalog_path.write_text(json.dumps(catalog,ensure_ascii=False,indent=2)+'\n','utf8')
    relative = 'scripts/scrHMLocalization/scrHMLocalization.gml'
    text = (PROJECT/relative).read_text('utf8')
    match = re.search(r'static _catalog=(\{.*?\});',text,re.S)
    assert match
    current = json.loads(match[1]); current.update(LABELS)
    save(relative,text[:match.start(1)]+json.dumps(current,ensure_ascii=False,indent=2)+text[match.end(1):])
    missing = {}
    for font in ['fntCJK','fntCJKBig']:
        glyphs = load(PROJECT/f'fonts/{font}/{font}.yy')['glyphs']
        absent = {ord(c) for label in LABELS.values() for c in label if ord(c)>127} - {int(c) for c in glyphs}
        if absent: missing[font] = sorted(chr(c) for c in absent)
    assert not missing, missing
    print(json.dumps({'status':'PASS','labels':LABELS,'scripts_to_register':['scrHMUI1104','scrHMGameplayUI1104']},ensure_ascii=False))


if __name__ == '__main__': main()
