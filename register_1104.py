"""Register only the new repair/test resources and opt-in test dispatch."""
import json
from sync1104_tools import *
from create_project import load

RESOURCES=[('scrHMRepairs1104Routes','native/repairs1104_routes.gml'),
           ('scrHMGameplayRoutes1104','tests/repairs1104_routes.gml'),
           ('scrHMUI1104','native/ui1104.gml'),
           ('scrHMGameplayUI1104','tests/ui1104.gml'),
           ('scrHMRepairs1104World','native/repairs1104_world.gml'),
           ('scrHMGameplay1104World','tests/repairs1104_world.gml'),
           ('scrHMGameplayHunter1104','tests/repairs1104_hunter.gml')]

def main():
    project=load(PROJECT/'nuclearthronemobile.yyp')
    template=load(PROJECT/'scripts/scrRadDrop/scrRadDrop.yy')
    for name,source in RESOURCES:
        data=dict(template);data['name']=data['%Name']=name
        relative=f'scripts/{name}/{name}.yy'
        save(relative,json.dumps(data,ensure_ascii=False,indent=2)+'\n')
        save(f'scripts/{name}/{name}.gml',(ROOT/source).read_text('utf8'))
        if not any(row['id']['path']==relative for row in project['resources']):
            project['resources'].append({'id':{'name':name,'path':relative}})
    save('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
    relative='scripts/scrHMGameplayTests/scrHMGameplayTests.gml'
    text=(PROJECT/relative).read_text('utf8')
    anchor='if(mode=="sync113chiefspacing") scrHMGameplayChiefSpacing1103();'
    additions='\n        scrHMGameplayRoutes1104();\n        scrHMGameplayUI1104();\n        scrHMGameplayHunter1104();\n        if(string_pos("sync114",mode)==1) scrHMGameplay1104World();'
    if 'scrHMGameplayRoutes1104();' not in text:edit(relative,anchor,anchor+additions)

if __name__=='__main__':main()
