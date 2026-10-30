"""The 1.0.10 repairs follow the frozen 1.0.9 adapters."""
import json,re
from create_project import load
from register_native import ROOT, PROJECT, register_script, write
from release_config import VERSION,BUILD

project=load(PROJECT/'nuclearthronemobile.yyp')
register_script(project,'scrHMRepairs110',(ROOT/'native/repairs110.gml').read_text(encoding='utf8'))

# Only these three group spawners use this old expression. Do not change
# the separate loop+1 raven-minion budget in the authored boss callback.
path='scripts/scrHMRepairs109/scrHMRepairs109.gml'
text=(PROJECT/path).read_text(encoding='utf8')
old='repeat(1+max(0,GameCont.loops))'
if old in text:
    assert text.count(old)==3,text.count(old)
    write(path,text.replace(old,'repeat(scrHMLoopBossCount110())'))
assert (PROJECT/path).read_text(encoding='utf8').count('repeat(scrHMLoopBossCount110())')==3

def change(path,old,new):
    text=(PROJECT/path).read_text(encoding='utf8')
    if new not in text:
        assert text.count(old)==1,(path,old,text.count(old))
        write(path,text.replace(old,new,1))

change('objects/GenCont/Create_0.gml','alarm[5] = 600',
       'scrHMLoopMapSetup110();\nalarm[5] = 600')

change('scripts/scrHMRepairs106/scrHMRepairs106.gml',
       'var _base=scrHMWallColour106(topspr);','var _base=scrHMWallColour110(topspr);')
change('scripts/scrHMRepairs106/scrHMRepairs106.gml',
       'function scrHMThroneSeed106() {',
       'function scrHMThroneSeed106() {scrHMThroneSeed110();}\nfunction scrHMThroneSeed106Legacy() {')
change('scripts/scrHMRepairs109/scrHMRepairs109.gml',
       'function scrHMThroneEntrance109() {',
       'function scrHMThroneEntrance109() {scrHMThroneEntrance110();}\nfunction scrHMThroneEntrance109Legacy() {')
# The old check ran before the generator's Destroy cleanup. Settle the
# initial boss after that cleanup as well, never from a combat polling loop.
path='objects/GenCont/Destroy_0.gml'
text=(PROJECT/path).read_text(encoding='utf8')
if 'scrHMThroneEntrance110();' not in text:write(path,text+'\n// Final boss placement follows all host generation cleanup.\nscrHMThroneEntrance110();\n')

change('objects/ProtoStatue/Destroy_0.gml',
       '        type = 3\n    }\n\n    with (GameCont) {',
       '        type = 3\n        if(scrHMEnabled()) {hm_destination107=area_vault;hm_subarea107=1;}\n    }\n\n    if(!scrHMEnabled()) with (GameCont) {')
change('objects/GameCont/Other_5.gml',
       'if(scrHMEnabled() && scrHMAreaHas(area) && !_went_crib) {scrHMAreaAdvance();exit;}',
       'if(scrHMEnabled() && !_went_crib && scrHMAdvanceDestination107()) exit;\nif(scrHMEnabled() && scrHMAreaHas(area) && !_went_crib) {scrHMAreaAdvance();exit;}')
# Even an older pending save can have the vanilla vault area selected before
# room-end. Mainline transit hooks may not overwrite that explicit branch.
change('scripts/scrHMWorld/scrHMWorld.gml','function scrHMAreaTransit() {',
       'function scrHMAreaTransit() {\n    if(area==area_vault) {subarea=1;maxsubarea=1;finalsubarea=true;return;}')

for target in ('android','ios','windows'):
    path=f'options/{target}/options_{target}.yy';data=load(PROJECT/path)
    if target=='android':
        data['option_android_version']=VERSION;data.pop('option_android_version_code',None)
    elif target=='ios':
        data['option_ios_version']=VERSION;data['option_ios_build_number']=BUILD
    else:data['option_windows_version']=VERSION+'.0'
    write(path,json.dumps(data,ensure_ascii=False,indent=2)+'\n')
manifest=ROOT/'platforms/android/gradle-project/com.arkintide.nuclearthronehardmode/src/main/AndroidManifest.xml'
text=manifest.read_text(encoding='utf8')
text=re.sub(r'android:versionCode="\d+"',f'android:versionCode="{BUILD}"',text)
text=re.sub(r'android:versionName="[^"]+"',f'android:versionName="{VERSION}"',text)
manifest.write_text(text,encoding='utf8')
write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
print('1.0.10 wall colours, throne, vault route, two-loop bosses and loop map growth registered')
