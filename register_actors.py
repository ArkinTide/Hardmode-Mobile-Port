"""Register real NTT Custom* actor types against the original engine parents.

No MOD gameplay hook is enabled by this registration. Native tests exercise
the callbacks and original damage/drop paths before world hooks are connected.
"""
import copy
import json

from create_project import load
from register_native import ROOT,PROJECT,write,replace,register_script


def register_object(project,name,parent,events,sprite=None):
    obj=copy.deepcopy(load(PROJECT/"objects/HMTestProbe/HMTestProbe.yy"))
    obj["name"]=obj["%Name"]=name
    obj["parentObjectId"]={"name":parent,"path":f"objects/{parent}/{parent}.yy"} if parent else None
    obj["spriteId"]={"name":sprite,"path":f"sprites/{sprite}/{sprite}.yy"} if sprite else None
    obj["eventList"]=[]
    names={0:"Create",1:"Destroy",2:"Alarm",3:"Step",7:"Other",8:"Draw",12:"CleanUp"}
    for (kind,num,target),text in events.items():
        event={"$GMEvent":"v1","%Name":"","collisionObjectId":None,"eventNum":num,
               "eventType":kind,"isDnD":False,"name":"","resourceType":"GMEvent","resourceVersion":"2.0"}
        if kind==4:
            event["collisionObjectId"]={"name":target,"path":f"objects/{target}/{target}.yy"}
            file=f"Collision_{target}.gml"
        else:file=f"{names[kind]}_{num}.gml"
        obj["eventList"].append(event)
        write(f"objects/{name}/{file}",text+"\n")
    path=f"objects/{name}/{name}.yy"
    write(path,json.dumps(obj,indent=2)+"\n")
    if not any(x["id"]["path"]==path for x in project["resources"]):
        project["resources"].append({"id":{"name":name,"path":path}})


def callbacks(step,create,destroy,collisions=None):
    events={(0,0,None):create,(1,0,None):destroy,
            (3,0,None):step,
            (3,1,None):'if(!lockstep_stop) scrHMActorCallback("on_begin_step");',
            (3,2,None):'if(!lockstep_stop) scrHMActorCallback("on_end_step");',
            (8,0,None):'scrHMActorDraw();',
            (7,5,None):'scrHMActorCleanup();'}
    if collisions:events.update(collisions)
    return events


def main():
    project=load(PROJECT/"nuclearthronemobile.yyp")
    register_script(project,"scrHMActors",(ROOT/"native/actors.gml").read_text(encoding="utf8"))
    register_object(project,"CustomObject",None,callbacks(
        'if(!lockstep_stop) scrHMActorCallback("on_step");',
        'scrHMActorInit();image_speed=0.4*timescale;',
        'scrHMActorCallback("on_destroy");scrHMActorCleanup();'))
    register_object(project,"CustomHitme","hitme",callbacks(
        'if(!lockstep_stop) scrHMActorCallback("on_step");',
        'max_hp=1;spr_idle=-1;spr_hurt=-1;spr_dead=-1;raddrop=0;size=1;\n'
        'event_inherited();scrHMActorInit();hp=max_hp;snd_hurt=sndHitFlesh;snd_dead=-1;\n'
        'image_speed=0.4*timescale;friction=0.4*timescale*timescale;',
        'scrHMActorCallback("on_destroy");scrHMActorCleanup();'))
    register_object(project,"CustomEnemy","enemy",callbacks(
        'scrHMEnemyStep();',
        'max_hp=1;spr_idle=-1;spr_walk=-1;spr_hurt=-1;spr_dead=-1;raddrop=0;size=1;meleedamage=0;\n'
        'event_inherited();scrHMActorInit();max_hp=1;hp=1;hm_maxhealth_init=true;',
        'scrHMActorCallback("on_destroy");event_inherited();scrHMActorCleanup();'))
    register_object(project,"CustomProjectile","projectile",callbacks(
        'if(!lockstep_stop) scrHMActorCallback("on_step");',
        'event_inherited();scrHMActorInit();typ=0;deflected=0;knockback_speed=0;\n'
        'image_speed=0.4*timescale;',
        'scrHMActorCallback("on_destroy");event_inherited();scrHMActorCleanup();',
        {(4,0,"Wall"):'scrHMProjectileWall();',(4,0,"hitme"):'scrHMProjectileCollision();'}))
    replace("scripts/scr_hit/scr_hit.gml","\twith (_instance) {",
            '\twith (_instance) {\n'
            '\t\tif(self[$ "hm_custom_actor"] ?? false) {\n'
            '\t\t\tif(!is_undefined(on_hurt)) return scrHMActorHurt(_amount,_hitid);\n'
            '\t\t}\n')
    replace("scripts/scr_hit/scr_hit.gml",
            '\tif _amount > 0 && scr_hit(_instance, _amount, hitid) {',
            '\t// Legacy callbacks own both damage and recoil. Do not apply base recoil twice.\n'
            '\tif _amount > 0 && instance_exists(_instance) {\n'
            '\t\twith(_instance) if(self[$ "hm_custom_actor"] ?? false) {\n'
            '\t\t\tif(!is_undefined(on_hurt)) return scrHMActorHurt(_amount,other.hitid,_kb_amount,is_undefined(_kb_direction)?other.direction:_kb_direction);\n'
            '\t\t}\n'
            '\t}\n'
            '\tif _amount > 0 && scr_hit(_instance, _amount, hitid) {')
    register_script(project,"scrHMActorTests",(ROOT/"tests/actors-native.gml").read_text(encoding="utf8"))
    replace("objects/MakeGame/Alarm_0.gml","if (scrHMModulesTests()) exit;",
            "if (scrHMActorsTests()) exit;\nif (scrHMModulesTests()) exit;")
    write("nuclearthronemobile.yyp",json.dumps(project,ensure_ascii=False,indent=2)+"\n")
    print("Registered native CustomObject/Hitme/Enemy/Projectile event adapters; world hooks remain gated")


if __name__=="__main__":main()
