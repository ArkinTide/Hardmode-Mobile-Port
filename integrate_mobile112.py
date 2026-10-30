"""Apply the mobile presentation follow-up after the frozen Windows delivery."""
from pathlib import Path
import json,re
from register_native import ROOT,PROJECT,register_script,write
from create_project import load

def main():
    delivered=json.loads((ROOT/'release112/windows-delivery-receipt.json').read_text())
    assert delivered['status']=='PASS' and delivered['version']=='1.0.12'
    assert not (ROOT/'build-windows/.vm-test-in-use.json').exists()
    p=PROJECT/'scripts/scrHMRepairs111/scrHMRepairs111.gml'
    text=p.read_text(encoding='utf8')
    old='if(os_type!=os_windows || !scrHMEnabled() || timescale>=1 || !scrHMReadyTick()'
    new='if(!scrHMEnabled() || timescale>=1 || !scrHMReadyTick()'
    if old in text:
        assert text.count(old)==1;text=text.replace(old,new,1)
    assert new in text;p.write_text(text,encoding='utf8')
    project=load(PROJECT/'nuclearthronemobile.yyp')
    register_script(project,'scrHMRepairs112',(ROOT/'native/repairs112.gml').read_text(encoding='utf8'))
    write('objects/HMBinding/Draw_0.gml','scrHMBindingDraw112();\n')
    for target in ('android','ios'):
        relative=f'options/{target}/options_{target}.yy';data=load(PROJECT/relative)
        data[f'option_{target}_version']='1.0.12'
        if target=='ios':data['option_ios_build_number']=13
        write(relative,json.dumps(data,ensure_ascii=False,indent=2)+'\n')
    p=ROOT/'platforms/android/gradle-project/com.arkintide.nuclearthronehardmode/src/main/AndroidManifest.xml'
    text=p.read_text(encoding='utf8')
    text=re.sub(r'android:versionCode="\d+"','android:versionCode="13"',text)
    text=re.sub(r'android:versionName="[^"]+"','android:versionName="1.0.12"',text)
    p.write_text(text,encoding='utf8')
    p=ROOT/'register_gameplay_tests.py';text=p.read_text(encoding='utf8')
    if "'tests/mobile112.gml'" not in text:
        assert "'tests/repairs112.gml']" in text
        text=text.replace("'tests/repairs112.gml']","'tests/repairs112.gml','tests/mobile112.gml']")
    p.write_text(text,encoding='utf8')
    write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
    print('Mobile 1.0.12 presentation and platform versions registered; Windows ZIP unchanged')

if __name__=='__main__':main()
