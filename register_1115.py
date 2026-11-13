"""Register maintained followup resources without regenerating old source."""
import json
from pathlib import Path
from create_project import load

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT/'project'
RESOURCES={
 'scrHMRepairs1115Root':'native/repairs1115_root.gml',
 'scrHMGameplay1105Performance':'tests/performance1105.gml',
 'scrHMGameplayRoot1115':'tests/repairs1115_root.gml',
}

def main():
    project=load(PROJECT/'nuclearthronemobile.yyp')
    template=load(PROJECT/'scripts/scrRadDrop/scrRadDrop.yy')
    for name,source in RESOURCES.items():
        src=ROOT/source
        if not src.exists():
            # Agents may already have created a maintained resource directly.
            src=PROJECT/f'scripts/{name}/{name}.gml'
        assert src.is_file(), src
        text=src.read_text('utf8')
        folder=PROJECT/'scripts'/name
        folder.mkdir(parents=True,exist_ok=True)
        (folder/f'{name}.gml').write_text(text,'utf8')
        data=dict(template);data['name']=data['%Name']=name
        (folder/f'{name}.yy').write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n','utf8')
        relative=f'scripts/{name}/{name}.yy'
        if not any(row['id']['path']==relative for row in project['resources']):
            project['resources'].append({'id':{'name':name,'path':relative}})
    (PROJECT/'nuclearthronemobile.yyp').write_text(json.dumps(project,ensure_ascii=False,indent=2)+'\n','utf8')
    path=PROJECT/'scripts/scrHMGameplayTests/scrHMGameplayTests.gml'
    text=path.read_text('utf8')
    anchor='        scrHMGameplayRoutes1104();'
    assert anchor in text
    calls=['scrHMGameplayExtra1115();','scrHMGameplayRocket1115();',
           'scrHMGameplayPerformance1105();','scrHMGameplayRoot1115();']
    for call in calls:
        if call not in text:text=text.replace(anchor,anchor+'\n        '+call,1)
    path.write_text(text,'utf8')

if __name__=='__main__':main()
