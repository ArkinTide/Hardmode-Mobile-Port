"""Register 1.0.8 changes after all retained maintenance adapters."""
import json
from create_project import load
from register_native import ROOT, PROJECT, register_script, write

project=load(PROJECT/'nuclearthronemobile.yyp')
register_script(project,'scrHMRepairs108',(ROOT/'native/repairs108.gml').read_text(encoding='utf8'))

def change(path,old,new):
    text=(PROJECT/path).read_text(encoding='utf8')
    if new not in text:
        assert old in text,(path,old)
        write(path,text.replace(old,new,1))

change('scripts/scrHMApi/scrHMApi.gml',
       'var _found=[],_items=scrHMInstances(_target);',
       'if(!is_array(_target)) return scrHMFilterOne108(_target,_field,_values,_operation);\n    var _found=[],_items=scrHMInstances(_target);')
change('scripts/scrHMRepairs107/scrHMRepairs107.gml',
       'repeat(3) instance_create(_xx+orandom(8),_yy+orandom(8),PopoFreak);',
       'repeat(3) scrHMPoliceSpawn108(_xx+orandom(8),_yy+orandom(8));')
change('objects/IDPDSpawn/Alarm_1.gml',
       'instance_create(x + orandom(2), y + orandom(2), PopoFreak)',
       'if(scrHMEnabled()) scrHMPoliceSpawn108(x+orandom(2),y+orandom(2));\n    else instance_create(x + orandom(2), y + orandom(2), PopoFreak)')
change('scripts/scrBossIntro/scrBossIntro.gml',
       'function scrBossIntro(_boss_index) {',
       'function scrBossIntro(_boss_index) {\n    if(scrHMEnabled() && instance_exists(GameCont) && GameCont.loops>0) return;')

# Packed invisible fill has no authored exterior shadow sprite. Rendering
# one 16px shadow at each 64px block origin caused the repeated black lines.
change('scripts/scrShadows/scrShadows.gml',
       'if !position_meeting(x, y + 16, TopSmall)',
       'if (!(scrHMEnabled() && scrHMPlainWall106()) && !position_meeting(x, y + 16, TopSmall))')
change('objects/TopSmall/Create_0.gml',
       'if (position_meeting(x, y, Wall) || position_meeting(x, y, Floor)) {',
       'if (scrHMEnabled() ? !scrHMTopAllowed108() : (position_meeting(x, y, Wall) || position_meeting(x, y, Floor))) {')
obj=load(PROJECT/'objects/TopSmall/TopSmall.yy')
obj['eventList']=[e for e in obj['eventList'] if not(e['eventType']==4 and (e.get('collisionObjectId') or {}).get('name')=='TopSmall')]
write('objects/TopSmall/TopSmall.yy',json.dumps(obj,indent=2)+'\n')
change('scripts/scrHMRepairs106/scrHMRepairs106.gml',
       'hm_fill_active=false;hm_fill_taken106=undefined;return true;',
       'hm_fill_active=false;hm_fill_taken106=undefined;scrHMWallTransitions108();return true;')
change('scripts/scrHMRepairs106/scrHMRepairs106.gml',
       'HMWorld.hm_water_map=undefined;',
       'scrHMWallTransitions108(_x-48,_y-48,_x+_size+48,_y+_size+48);\n    HMWorld.hm_water_map=undefined;')
# Venus has authored sky, window openings and invisible door masks. Adding
# a second filled collision map outside those rooms creates a phantom ring
# and extra white/gold wall tiles. Preserve the MOD terrain in these maps.
change('scripts/scrHMRepairs106/scrHMRepairs106.gml',
       'if(!(self[$ "hm_fill_active"]??false)) return true;',
       'if(!(self[$ "hm_fill_active"]??false)) return true;\n    if(GameCont.area==scrHMAreaResolve("venuz")) {hm_fill_active=false;hm_fill_taken106=undefined;return true;}')
path='objects/FloorExplo/Create_0.gml'
text=(PROJECT/path).read_text(encoding='utf8')
if text.count('scrHMCarveFill105(16);')>1:
    text=text.replace('scrHMCarveFill105(16);','',1)
write(path,text)

change('objects/Portal/Step_0.gml','if (endgame < 100) {','scrHMPortalEntry108();\n\nif (endgame < 100) {')
path='objects/NothingBeam/Step_0.gml';text=(PROJECT/path).read_text(encoding='utf8')
old='''image_yscale = 1

repeat (1024) {
	image_yscale -= timescale
	if (place_meeting(x, y, Wall)) {
		break
	}
}'''
if 'scrHMThroneBeam108();' not in text:
    assert old in text
    text=text.replace(old,'if(scrHMEnabled()) scrHMThroneBeam108();\nelse {\n'+old+'\n}',1)
write(path,text)
change('objects/WepPickup/Step_0.gml','scrHMPickupRefresh();','scrHMPickupRefresh();\nscrHMVenusPickup108();')
path='objects/WepPickup/WepPickup.yy';obj=load(PROJECT/path)
if not any(e['eventType']==4 and (e.get('collisionObjectId') or {}).get('name')=='InvisiWall' for e in obj['eventList']):
    event={"$GMEvent":"v1","%Name":"","collisionObjectId":{"name":"InvisiWall","path":"objects/InvisiWall/InvisiWall.yy"},"eventNum":0,"eventType":4,"isDnD":False,"name":"","resourceType":"GMEvent","resourceVersion":"2.0"}
    obj['eventList'].append(event)
write(path,json.dumps(obj,indent=2)+'\n')
write('objects/WepPickup/Collision_InvisiWall.gml','''if(lockstep_stop || !scrHMEnabled() || GameCont.area!=scrHMAreaResolve("venuz")) exit;
move_bounce_solid(true);
move_outside_solid(point_direction(other.x+8,other.y+8,x,y),2);
speed*=.4;
scrHMVenusPickup108();
''')

change('objects/VanSpawn/Create_0.gml','var player = instance_random(Player)',
       'if(scrHMVanPortalCreate108()) exit;\n\nvar player = instance_random(Player)')
change('objects/VanSpawn/Alarm_1.gml','instance_create(x, y, Van)',
       'if(!scrHMVanPortalSpawn108()) instance_create(x, y, Van)')
obj=load(PROJECT/'objects/VanSpawn/VanSpawn.yy')
if not any(e['eventType']==8 and e['eventNum']==0 for e in obj['eventList']):
    obj['eventList'].append({"$GMEvent":"v1","%Name":"","collisionObjectId":None,"eventNum":0,"eventType":8,"isDnD":False,"name":"","resourceType":"GMEvent","resourceVersion":"2.0"})
write('objects/VanSpawn/VanSpawn.yy',json.dumps(obj,indent=2)+'\n')
write('objects/VanSpawn/Draw_0.gml','draw_self();\nscrHMVanWarning108();\n')
write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
print('Release 1.0.8 host adapters registered')
