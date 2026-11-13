"""Isolate 1.1.6 release tooling and resource registration."""
import json
from pathlib import Path
from create_project import load

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT/'project'
RESOURCES={
    'scrHMRepairs1116Runtime':'native/runtime1116.gml',
    'scrHMGameplayRuntime1116':'tests/runtime1116.gml',
    'scrHMRepairs1116Policy':'native/repairs1116_policy.gml',
    'scrHMGameplayPolicy1116':'tests/repairs1116_policy.gml',
}


def main():
    for stem in ('build_checked','run_release_checks','test_android','audit_mobile_storage',
                 'build_mobile','package_gate','prepare_publication'):
        old=('run_release1105_checks.py' if stem=='run_release_checks' else stem+'1105.py')
        new=('run_release1106_checks.py' if stem=='run_release_checks' else stem+'1106.py')
        destination=ROOT/new
        if destination.exists():continue
        text=(ROOT/old).read_text('utf8')
        text=text.replace('release1105','release1106').replace('HardmodeMobile1105Audit','HardmodeMobile1106Audit')
        text=text.replace("('1.1.5', 19)","('1.1.6', 20)").replace("('1.1.5',19)","('1.1.6',20)")
        text=text.replace('1.1.5 packages','1.1.6 packages').replace('1.1.5 text-only','1.1.6 text-only')
        text=text.replace('test_android1105.py','test_android1106.py').replace('audit_mobile_storage1105.py','audit_mobile_storage1106.py')
        if stem=='package_gate':
            text=text.replace("ROOT / 'deliverables/NuclearThrone.Hardmode-Android-1.1.4.apk'",
                "ROOT.parent / 'hardmode-mobile-1115/deliverables/NuclearThrone.Hardmode-Android-1.1.5.apk'")
            text=text.replace("(PACKAGE, '1.1.4', 18)","(PACKAGE, '1.1.5', 19)")
        if stem=='run_release_checks':
            text=text.replace("'sync114gator'}", "'sync114gator', 'guardian116', 'floors116', 'budget116'}")
        destination.write_text(text,'utf8')
    project=load(PROJECT/'nuclearthronemobile.yyp')
    template=load(PROJECT/'scripts/scrRadDrop/scrRadDrop.yy')
    for name,source in RESOURCES.items():
        path=ROOT/source
        assert path.is_file(),path
        folder=PROJECT/'scripts'/name;folder.mkdir(exist_ok=True)
        (folder/f'{name}.gml').write_text(path.read_text('utf8'),'utf8')
        data=dict(template);data['name']=data['%Name']=name
        (folder/f'{name}.yy').write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n','utf8')
        relative=f'scripts/{name}/{name}.yy'
        if not any(row['id']['path']==relative for row in project['resources']):
            project['resources'].append({'id':{'name':name,'path':relative}})
    (PROJECT/'nuclearthronemobile.yyp').write_text(json.dumps(project,ensure_ascii=False,indent=2)+'\n','utf8')
    path=PROJECT/'scripts/scrHMGameplayTests/scrHMGameplayTests.gml'
    text=path.read_text('utf8');anchor='        scrHMGameplayRoutes1104();'
    for name in ('scrHMGameplayRuntime1116','scrHMGameplayPolicy1116'):
        if name+'();' not in text:text=text.replace(anchor,anchor+'\n        '+name+'();',1)
    path.write_text(text,'utf8')
    version=(ROOT/'set_release1105.py').read_text('utf8')
    # Preserve this generator's historical source; write a new isolated entry.
    version=version.replace('1.1.5','1.1.6').replace('release1105','release1106').replace('BUILD = 19','BUILD = 20').replace('data[key]=19','data[key]=20')
    version=version.replace('Hardmode 1.1.4','Hardmode 1.1.5')
    (ROOT/'set_release1106.py').write_text(version,'utf8')
    print('1.1.6 resources registered and isolated tools prepared')


if __name__=='__main__':main()
