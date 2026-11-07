"""Remove wake carving, continue Palace B, and close phase-II police paths."""
from sync1104_tools import *

def main():
    routes='scripts/scrHMSync1103Routes/scrHMSync1103Routes.gml'
    replace_function(routes,'scrHMThroneTick1103',
                     'scrHMThronePoliceClear1104();')
    replace_function(routes,'scrHMThroneOpenWalls1103',
                     '// Retired: waking the Throne must preserve walls and their collision.')
    area='scripts/scrHMCompiled_areas_throne_area_gml/scrHMCompiled_areas_throne_area_gml.gml'
    edit(area,'scrHMSoundMusic(mus7);','scrHMSoundMusic(mus7b);')
    edit('scripts/scrHMRepairs112/scrHMRepairs112.gml',
         'case "area:throne":_song=mus7;_amb=amb7;break;',
         'case "area:throne":_song=mus7b;_amb=amb7;break;')
    edit(area,'GameCont.hm_followup_throne_second_dead = 0;',
         'GameCont.hm_followup_throne_second_dead = 0;\nGameCont.hm_second_started1104=false;')
    for event in ('objects/IDPDSpawn/Create_0.gml','objects/VanSpawn/Create_0.gml','objects/WantPopo/Step_0.gml','objects/WantVan/Step_0.gml'):
        text=(PROJECT/event).read_text('utf8')
        hook='if(scrHMThroneSecond1104()) {instance_destroy(id,false);exit;}\n'
        if not text.startswith(hook):save(event,hook+text)
    # Gate constructors are blocked before a Rogue exit can amplify them;
    # the ordinary portal still keeps all of its own visuals/transition work.
    portal='objects/Portal/Create_0.gml'
    edit(portal,'if (race != Race.Rogue) continue',
         'if (race != Race.Rogue || scrHMThroneSecond1104()) continue')
    intro='scripts/scrHMCompiled_bosses_bossintros_mod_gml/scrHMCompiled_bosses_bossintros_mod_gml.gml'
    for name,arg in [('hm_bosses_bossintros_mod_gml_boss_trigger','argument4'),
                     ('hm_bosses_bossintros_mod_gml_boss_death','id')]:
        text=(PROJECT/intro).read_text('utf8');old=body(text,name)
        guard=f'if(scrHMExtraPresentation1104({arg})) return;'
        if guard not in old:replace_function(intro,name,guard+'\n'+old)
    print('1104 routes patched',len(CHANGED))

if __name__=='__main__':main()
