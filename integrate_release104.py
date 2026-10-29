"""Apply 1.0.4 after all previous registration; do not alter frozen inputs."""
from pathlib import Path
import csv,json,re
from create_project import load,save
from register_native import ROOT,PROJECT,register_script,replace,write

project=load(PROJECT/'nuclearthronemobile.yyp')
register_script(project,'scrHMRepairs104',(ROOT/'native/repairs104.gml').read_text(encoding='utf8'))
register_script(project,'scrHMStorage',(ROOT/'native/storage.gml').read_text(encoding='utf8'))

replace('scripts/scrUnlocks/scrUnlocks.gml','switch GameCont.area {','switch scrHMUnlockArea(GameCont.area) {')
replace('scripts/scrHMActors/scrHMActors.gml','if(can_die && hp<=0) {',
        'if(name=="titank") scrHMTitankHealth();\n    if(can_die && hp<=0) {')
replace('objects/HMWorld/Step_0.gml','scrHMWorldStep();','scrHMWorldStep();\nif(logic_tick && !lockstep_stop && !UberCont.paused) scrHMWallThemeTick();')
path='objects/HMWorld/Other_5.gml'
text=(PROJECT/path).read_text(encoding='utf8')
if 'hm_water_map=undefined;' not in text:
    write(path,text+'\nhm_water_map=undefined;hm_water_floors=-1;hm_wall_theme_queue=[];hm_wall_theme_index=0;\n')

path='objects/GenCont/Alarm_1.gml'
marker='// Static interior collision completes before population is finalized.'
text=(PROJECT/path).read_text(encoding='utf8')
if marker not in text:
    write(path,marker+'''\nif(scrHMEnabled() && !(self[$ "hm_fill_done"]??false)) {
    if(!(self[$ "hm_fill_started"]??false)) {scrHMWallFillBegin();hm_fill_started=true;}
    if(!scrHMWallFillStep()) {alarm[1]=1;exit;}
    hm_fill_done=true;
}
'''+text)
path='objects/GenCont/Step_0.gml'
text=(PROJECT/path).read_text(encoding='utf8')
marker='// Keep safespawn stationary while static collision batches finish.'
if marker not in text:
    write(path,marker+'\nif(scrHMEnabled() && (self[$ "hm_fill_started"]??false)) exit;\n'+text)

# Spatial native collision lookup rather than scanning thousands of static
# interior cells on every render frame. Draw only the resulting viewport set.
path='objects/UberCont/Step_0.gml'
text=(PROJECT/path).read_text(encoding='utf8')
old='''\t    with (Wall) {
\t        if (bbox_right >= _left && bbox_bottom >= _top && bbox_left < _right && bbox_top < _bottom) {
\t            ds_list_add(_wall_list, id)
\t        }
\t    }'''
new='\t    collision_rectangle_list(_left,_top,_right,_bottom,Wall,false,false,_wall_list,false);'
assert old in text or new in text
write(path,text.replace(old,new))
replace('objects/UberCont/Step_0.gml',
        '_camera_boundaries_check = (!instance_exists(Cinematic))',
        '_camera_boundaries_check = (scrHMEnabled() || !instance_exists(Cinematic))')
path='objects/FloorExplo/Create_0.gml'
text=(PROJECT/path).read_text(encoding='utf8')
if 'scrHMWallBreakUpdate104();' not in text:
    start=text.index('with (Wall) {')
    # This neighborhood update is the final block of the original event.
    assert text[start:].count('with (Wall) {')==1
    write(path,text[:start]+'scrHMWallBreakUpdate104();\n')
path='objects/SubTopCont/Draw_0.gml'
text=(PROJECT/path).read_text(encoding='utf8')
text=text.replace('with TopSmall {','with TopSmall {\n    if(x<view_xview-32 || x>view_xview+view_width+32 || y<view_yview-32 || y>view_yview+view_height+32) continue;') if 'if(x<view_xview-32' not in text else text
old='with Wall {\n\tdraw_sprite_ext(topspr'
new='for(var _wall=0;_wall<ds_list_size(_list);++_wall) with(_list[| _wall]) {\n\tdraw_sprite_ext(topspr'
assert old in text or 'for(var _wall=0;_wall<ds_list_size(_list);++_wall) with(_list[| _wall]) {' in text
write(path,text.replace(old,new))

# Private->public migration runs before any permanent progress is read.
path='objects/MakeGame/Alarm_0.gml'
text=(PROJECT/path).read_text(encoding='utf8')
marker='// Hardmode public-save permission is requested once on first startup.'
if marker not in text:
    text=marker+'''\nif(os_type==os_android && !instance_exists(UberCont) && CheckPermission()<=0 && !(self[$ "hm_storage_permission_requested"]??false)) {
    hm_storage_permission_requested=true;
    if(IsVersionR()) RequestPermission();
    else os_request_permission("android.permission.WRITE_EXTERNAL_STORAGE");
    alarm[0]=30;exit;
}
'''+text
write(path,text)

# The standalone offline scaffold previously retained only INTERNET. These
# permissions are required for the user-requested shared /games directory.
manifest=ROOT/'platforms/android/gradle-project/com.arkintide.nuclearthronehardmode/src/main/AndroidManifest.xml'
text=manifest.read_text(encoding='utf8')
permissions='''  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="29" />
  <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
'''
if 'android.permission.MANAGE_EXTERNAL_STORAGE' not in text:
    text=text.replace('  <application',permissions+'  <application',1)
if 'android:requestLegacyExternalStorage' not in text:
    text=text.replace('<application','<application android:requestLegacyExternalStorage="true"',1)
manifest.write_text(text,encoding='utf8')
for java in [PROJECT/'extensions/YYExtra/AndroidSource/Java/YYExtra.java',
             ROOT/'platforms/android/gradle-project/com.arkintide.nuclearthronehardmode/src/main/java/com/arkintide/nuclearthronehardmode/YYExtra.java']:
    text=java.read_text(encoding='utf8')
    text=text.replace('ctx, "READ_EXTERNAL_STORAGE"','ctx, "android.permission.READ_EXTERNAL_STORAGE"').replace('ctx, "WRITE_EXTERNAL_STORAGE"','ctx, "android.permission.WRITE_EXTERNAL_STORAGE"')
    java.write_text(text,encoding='utf8')

# Freeze each actor once for a portrait instead of rescanning/copying fields
# every tick. These guards also stop subclasses which skip inherited Step.
objects={p.parent.name:load(p) for p in (PROJECT/'objects').glob('*/*.yy')}
def descendant(name,roots):
    while name in objects:
        if name in roots:return True
        parent=objects[name].get('parentObjectId')
        if not parent:return False
        name=parent['name']
    return False
for name in objects:
    if not descendant(name,{'hitme','projectile','RavenFly'}):continue
    for event in ('Step_0.gml','Step_1.gml','Step_2.gml'):
        path=PROJECT/'objects'/name/event
        if not path.exists():continue
        text=path.read_text(encoding='utf8')
        marker='// One-shot Hardmode portrait freeze.'
        if marker not in text:
            write(path.relative_to(PROJECT),marker+'\nif(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;\n'+text)

# Place newly imported portrait layers in the already-prefetched portrait
# texture group, so first display does not upload unrelated gameplay pages.
art=json.loads((ROOT/'artwork-manifest.json').read_text(encoding='utf8'))['artwork']
for row in art:
    source=(ROOT/'reference/hardmode-b24'/row['source']).read_text(encoding='utf8').splitlines()[row['line']-1]
    if not re.search(r'global\.\w*(?:intro|portrait)\w*\s*=',source,re.I):continue
    name=row['native_resource'];path=PROJECT/'sprites'/name/(name+'.yy')
    data=load(path);data['textureGroupId']={'name':'portraits','path':'texturegroups/portraits'};save(path,data)

# Preserve every existing stock Simplified Chinese phrase, including direct
# display paths which do not pass a loc() key (boss names, weapon labels).
catalog=json.loads((ROOT/'localization/zh-CN.json').read_text(encoding='utf8'))
rows=list(csv.reader((PROJECT/'datafiles/lang/lang.csv').open(encoding='utf-8-sig')))
header=rows[0];en=next(i for i,s in enumerate(header) if s.lower()=='text');zh=header.index('Simplified Chinese')
stock={}
for row in rows[2:]:
    if len(row)<=max(en,zh) or not row[zh].strip():continue
    key=row[en].strip().upper()
    if key in catalog:stock[key]=row[zh]
normalized={k.upper():stock.get(k.upper(),v) for k,v in catalog.items()}
registry='function scrHMLocalizationCatalog() {\nstatic _catalog='+json.dumps(normalized,ensure_ascii=False,indent=2)+';\nreturn _catalog;\n}\n'
register_script(project,'scrHMLocalization',registry+(ROOT/'native/localization.gml').read_text(encoding='utf8'))
(ROOT/'release104/localization-stock-restored.json').write_text(json.dumps(stock,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
print('Registered Hardmode 1.0.4, restored',len(stock),'stock phrases')
