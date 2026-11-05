"""Narrow Report17/Followup18 boss hooks; imported by the central integrator.

Importing this module performs no project writes. `apply` deliberately avoids
the historical whole-source compiler/importer and only changes reviewed hooks.
The caller owns the frozen baseline, sprite extraction and final YYP write.
"""
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / 'project'

# These already have durable native host sources. Compiled module edits remain
# in the final project/source archive and the auditable transforms below.
MIRRORS = {
    'scripts/scrHMWorld/scrHMWorld.gml': 'native/world.gml',
    'scripts/scrHMRepairs1102/scrHMRepairs1102.gml': 'native/repairs1102.gml',
}
ASSETS = [
    {'name': 'sprHMBossTitleGlyphs1103', 'source': '../hardmode-ntt100034/artwork/report17/original_boss_title_glyphs.png', 'frames': 74, 'origin': [5, 7]},
    {'name': 'sprHMMessengerPortrait1103', 'source': '../hardmode-ntt100034/artwork/report17/messenger_portrait.png', 'frames': 1, 'origin': [246, 0]},
    {'name': 'sprHMMessengerTitle1103', 'source': '../hardmode-ntt100034/artwork/report17/messenger_title.png', 'frames': 1, 'origin': [122, 0]},
]


def _bounds(text, name):
    match = re.search(r'^function ' + re.escape(name) + r'\([^\n]*\)\s*\{', text, re.M)
    assert match, name
    depth = 1
    for token in re.finditer(r'//[^\n]*|/\*[\s\S]*?\*/|"(?:\\.|[^"\\])*"|[{}]', text[match.end():]):
        if token[0] == '{':
            depth += 1
        elif token[0] == '}':
            depth -= 1
            if not depth:
                return match.end(), match.end() + token.start()
    raise AssertionError(('unbalanced function', name))


def _once(text, old, new, count=1):
    if new in text:
        return text
    assert text.count(old) == count, (old[:100], text.count(old), count)
    return text.replace(old, new, count)


def apply(project, save, edit, replace_function, register_script):
    """Use caller callbacks save(relative,text), edit(relative,old,new,count=1),
    replace_function(relative,name,body), register_script(project,name,source).
    The caller must register the three ASSETS before compiling the project.
    """
    register_script(project, 'scrHMSync1103Bosses', (ROOT / 'native/sync1103_bosses.gml').read_text('utf8'))
    register_script(project, 'scrHMGameplay1103Bosses', (ROOT / 'tests/sync1103_bosses.gml').read_text('utf8'))

    def function(relative, name, transform):
        text = (PROJECT / relative).read_text('utf8')
        start, end = _bounds(text, name)
        body = transform(text[start:end])
        if body != text[start:end]:
            save(relative, text[:start] + body + text[end:])

    def fn_edit(relative, name, old, new, count=1):
        function(relative, name, lambda body: _once(body, old, new, count))

    helper = 'scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml'
    enemies = 'scripts/scrHMCompiled_enemies_mod_gml/scrHMCompiled_enemies_mod_gml.gml'
    maincode = 'scripts/scrHMCompiled_maincode_mod_gml/scrHMCompiled_maincode_mod_gml.gml'
    bars = 'scripts/scrHMCompiled_hm_bossbar_mod_gml/scrHMCompiled_hm_bossbar_mod_gml.gml'
    intro = 'scripts/scrHMCompiled_bosses_bossintros_mod_gml/scrHMCompiled_bosses_bossintros_mod_gml.gml'

    bird = 'scripts/scrHMCompiled_bosses_ravenboss_mod_gml/scrHMCompiled_bosses_ravenboss_mod_gml.gml'
    fn_edit(bird, 'hm_bosses_ravenboss_mod_gml_ravenboss_create_resume',
            'scrHMMaxHealthWrite(id, 120, "=");', 'scrHMMaxHealthWrite(id, 150, "=");')
    fn_edit(enemies, 'hm_enemies_mod_gml_enemyrogue_create',
            'scrHMMaxHealthWrite(id, (30 + ((30 * instance_number(Player)) * hm_arkintide_mod_gml_hm_attack_loops())), "=");',
            'scrHMMaxHealthWrite(id, ((50-20*revived) + ((30 * instance_number(Player)) * hm_arkintide_mod_gml_hm_attack_loops())), "=");')

    for module, name in [('ravenboss', 'ravenboss_create_resume'), ('gatorboss', 'gatorboss_create'),
                         ('ratboss', 'ratboss_create'), ('scorpionboss', 'scorpionboss_create'),
                         ('throne', 'throne_create')]:
        relative = f'scripts/scrHMCompiled_bosses_{module}_mod_gml/scrHMCompiled_bosses_{module}_mod_gml.gml'
        if module == 'ratboss':
            # The substring also occurs at the end of `storehp = max_hp`.
            # Its snapshot must see the newly scaled maximum, exactly once.
            fn_edit(relative, f'hm_bosses_{module}_mod_gml_{name}',
                    'hp = max_hp;\nstorehp = max_hp;',
                    'hp = max_hp;\nscrHMBossHealth1103();\nstorehp = max_hp;')
        else:
            fn_edit(relative, f'hm_bosses_{module}_mod_gml_{name}',
                    'hp = max_hp;', 'hp = max_hp;\nscrHMBossHealth1103();')
    turtles = 'scripts/scrHMCompiled_bosses_turtles_mod_gml/scrHMCompiled_bosses_turtles_mod_gml.gml'
    for i in range(1, 5):
        fn_edit(turtles, f'hm_bosses_turtles_mod_gml_turtle{i}_create',
                'hp = max_hp;', 'hp = max_hp;\nscrHMBossHealth1103();')
    fn_edit(enemies, 'hm_enemies_mod_gml_enemyrogue_create',
            'hp = max_hp;', 'hp = max_hp;\nscrHMMessengerInit1103();')
    gun = 'scripts/scrHMCompiled_bosses_gungod_mod_gml/scrHMCompiled_bosses_gungod_mod_gml.gml'
    fn_edit(gun, 'hm_bosses_gungod_mod_gml_GunGod_create',
            'hp = max_hp;', 'hp = max_hp;\nscrHMGunGodHealth1103();')
    fn_edit(enemies, 'hm_enemies_mod_gml_enemyyv_create',
            'hp = max_hp;', 'hp = max_hp;\nscrHMBossHealth1103();')
    fn_edit(helper, 'hm_arkintide_mod_gml_hm_yv_phase_create',
            'scrHMMaxHealthWrite(id, _hml__hp, "=");', 'scrHMMaxHealthWrite(id, _hml__hp, "=");\nscrHMBossHealth1103();')
    guardian = 'scripts/scrHMCompiled_bosses_guardianboss_mod_gml/scrHMCompiled_bosses_guardianboss_mod_gml.gml'
    fn_edit(guardian, 'hm_bosses_guardianboss_mod_gml_guardianboss_create_resume',
            'scrHMMaxHealthWrite(id, ((max_hp / 2) * GameCont.loops), "+=");',
            'scrHMMaxHealthWrite(id, ((max_hp / 2) * GameCont.loops), "+=");\nscrHMBossHealth1103();')
    titank = 'scripts/scrHMCompiled_bosses_titank_mod_gml/scrHMCompiled_bosses_titank_mod_gml.gml'
    fn_edit(titank, 'hm_bosses_titank_mod_gml_titank_create_resume',
            'foot_hp[_hm.vars.i] = 150;', 'foot_hp[_hm.vars.i] = 150*scrHMBossLoopFactor1103();')
    fn_edit(maincode, 'hm_maincode_mod_gml_step_resume',
            'hp *= 0.8;\nmorehp = 1;', 'hp *= 0.8;\nmorehp = 1;scrHMBossHealth1103();')
    edit('scripts/scrHMWorld/scrHMWorld.gml',
         '    scrHMHook("init");', '    scrHMHook("init");\n    scrHMReportAssets1103();')
    edit('scripts/scrHMWorld/scrHMWorld.gml',
         '    if(instance_exists(GameCont)) scrHMHook("step");',
         '    if(instance_exists(GameCont)) {scrHMHook("step");scrHMNativeBossHealth1103();}')
    fn_edit('scripts/scrHMRepairs1102/scrHMRepairs1102.gml', 'scrHMChiefCreate1102',
            'name="hm_chief";hm_chief1102=true;', 'name="hm_chief";scrHMBossHealth1103();hm_chief1102=true;')

    # Replace both old entrance branches atomically. The resumed rifle and
    # strike coroutine remains unchanged; only the native intro policy moves.
    def messenger_intro(body):
        if 'scrHMMessengerIntro1103();' in body:
            return body
        start = body.index('if (((((intro == 0) and (target > 0)) and targetvisible)')
        end = body.index('if (((intro == 1) and (targetvisible == 0)))', start)
        return body[:start] + 'scrHMMessengerIntro1103();\n' + body[end:]
    function(enemies, 'hm_enemies_mod_gml_enemyrogue_step_resume', messenger_intro)
    fn_edit(enemies, 'hm_enemies_mod_gml_enemyrogue_step_resume',
            'hitid = [sprPopoExplo, "IDPD STRIKE"];',
            'hitid = [sprPopoExplo, "IDPD STRIKE"];\nscrHMMessengerTagExplosion1103(scrHMOther(other));')
    fn_edit(enemies, 'hm_enemies_mod_gml_enemyrogue_step_resume',
            'hitid = __hm_other16.hitid;', 'hitid = __hm_other16.hitid;\nscrHMMessengerTagExplosion1103(__hm_other16);')
    fn_edit(enemies, 'hm_enemies_mod_gml_enemyrogue_death',
            'instance_create(x, y, PopoExplosion);',
            'with(instance_create(x,y,PopoExplosion)) scrHMMessengerTagExplosion1103(other.id);')
    fn_edit(enemies, 'hm_enemies_mod_gml_enemyrogue_death',
            'specialrevive = "rogue";', 'specialrevive = "rogue";\nscrHMMessengerCorpse1103(scrHMOther(other));')
    fn_edit(intro, 'hm_bosses_bossintros_mod_gml_boss_trigger',
            'if(scrHMSkipBossPresentation108(argument0,argument4)) return;',
            'if(scrHMMessengerSkipPresentation1103(argument4)) return;\nif(scrHMSkipBossPresentation108(argument0,argument4)) return;')
    fn_edit(intro, 'hm_bosses_bossintros_mod_gml_draw_gui',
            'scrHMDrawText((((view_width * 0.80) - (bossx / 3)) - 64), ((view_height * 0.4) + customheight), (" " + bossname));',
            'scrHMReportIntroDraw1103((((view_width * 0.80) - (bossx / 3)) - 64), ((view_height * 0.4) + customheight), bossname);')

    for name in ['draw', 'hm_extra_boss_name']:
        fn_edit(bars, f'hm_hm_bossbar_mod_gml_{name}', '"BIG FISH"', '"BIG BUBBLER"')
    for name in ['hm_extra_boss_name', 'hm_custom_boss_name']:
        fn_edit(bars, f'hm_hm_bossbar_mod_gml_{name}', '"ROGUE"', '"The Messenger"')
    fn_edit(bars, 'hm_hm_bossbar_mod_gml_hm_custom_boss_name',
            'switch (name) {', 'switch (name) {\ncase "roguefreak": return "The Messenger";\ncase "hm_palace_guardian": return "CROWN GUARDIAN";')
    fn_edit(helper, 'hm_arkintide_mod_gml_hm_bossbar_top',
            'case "rogueboss":', 'case "rogueboss":\ncase "roguefreak":')
    for name in ['draw', 'draw_gui']:
        fn_edit(bars, f'hm_hm_bossbar_mod_gml_{name}', '_hml_capacity = 750;', '_hml_capacity = max(1,max_hp-14250);')
        fn_edit(bars, f'hm_hm_bossbar_mod_gml_{name}',
                '_hml_capacity = (150 * legs);', '_hml_capacity = (150 * legs)*scrHMBossLoopFactor1103();')

    def sleeping_bar(body):
        if 'scrHMThroneBarVisible1103()' in body:
            return body
        # Remove the complete generated inactive-instance loop, preserving all
        # following loop-local indexes and the active Nothing loop unchanged.
        start = body.index('{ var __hm_with10 = scrHMInstances(NothingInactive)')
        end = body.index('{ var __hm_with13 = scrHMInstances(Nothing)', start)
        body = body[:start] + body[end:]
        start = body.index('{ var __hm_with13 = scrHMInstances(Nothing)')
        end = body.index('{ var __hm_with16 = scrHMInstances(YVBoss)', start)
        part = _once(body[start:end], 'if ((hp > 0)) {', 'if (scrHMThroneBarVisible1103()) {')
        return body[:start] + part + body[end:]
    function(bars, 'hm_hm_bossbar_mod_gml_draw_gui', sleeping_bar)

    fn_edit(helper, 'hm_arkintide_mod_gml_hm_loop_population',
            'if ((((array_length(_hml_pool) > 0)',
            'if(_hml__region==7 && GameCont.loops>=3) array_push(_hml_pool,CrownGuardian);\nif ((((array_length(_hml_pool) > 0)')
    fn_edit(helper, 'hm_arkintide_mod_gml_hm_loop_population',
            '_hml_actor = instance_create((x + 16), (y + 16), _hml_kind);',
            '_hml_actor = _hml_kind==CrownGuardian?scrHMPalaceGuardianCreate1103(x+16,y+16):instance_create((x + 16), (y + 16), _hml_kind);')
    function(helper, 'hm_arkintide_mod_gml_hm_stage_boss_actor',
             lambda body: body if 'hm_palace_guardian' in body else '\nif(self[$ "hm_palace_guardian"]??false) return false;\n' + body)
    edit('objects/CrownGuardian/Destroy_0.gml', 'event_inherited()',
         'if(scrHMEnabled() && scrHMPalaceGuardianDeath1103()) exit;\nevent_inherited()')
    replace_function(enemies, 'hm_enemies_mod_gml_Minigunner_step', 'scrHMMinigunnerStep1103();')
    tests_relative = 'scripts/scrHMGameplayTests/scrHMGameplayTests.gml'
    if 'scrHMGameplay1103Bosses();' not in (PROJECT / tests_relative).read_text('utf8'):
        edit(tests_relative,
             'if(string_pos("sync112",mode)==1) scrHMGameplay1102();',
             'if(string_pos("sync112",mode)==1) scrHMGameplay1102();\n        if(string_pos("sync113",mode)==1) scrHMGameplay1103Bosses();')
