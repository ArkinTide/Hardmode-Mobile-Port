import json
from create_project import load
from register_native import ROOT,PROJECT,register_script,replace,write
from register_actors import register_object

project=load(PROJECT/'nuclearthronemobile.yyp')
register_script(project,'scrHMGameplayTests','\n'.join((ROOT/p).read_text(encoding='utf8') for p in ['tests/gameplay.gml','tests/repairs103.gml','tests/repairs104.gml','tests/repairs105.gml','tests/repairs106.gml','tests/venus106.gml','tests/repairs107.gml','tests/repairs108.gml','tests/repairs109.gml','tests/requests109.gml']))
register_object(project,'HMGameplayTest',None,{(3,1,None):'hm_frame_start106=get_timer();',(8,73,None):'scrHMGameplayRender102();scrHMGameplayRender103();scrHMGameplayRender104();scrHMGameplayRender105();scrHMGameplayRender106();scrHMGameplayRender107();scrHMGameplayRender108();scrHMGameplayRender109();',(3,2,None):'scrHMGameplayTestStep();scrHMGameplayFrame105();',(7,4,None):'scrHMGameplayRoomStart();'})
if 'if(scrHMGameplayTests()) exit;' not in (PROJECT/'objects/MakeGame/Alarm_0.gml').read_text(encoding='utf8'):
    replace('objects/MakeGame/Alarm_0.gml','if(!instance_exists(HMWorld)) instance_create(0,0,HMWorld);',
            'if(!instance_exists(HMWorld)) instance_create(0,0,HMWorld);\nif(scrHMGameplayTests()) exit;')
replace('objects/MakeGame/Alarm_0.gml','// Hardmode lifecycle starts after isolated regression entrypoints.',
        'scrHMGameplayErrorInit();\n// Hardmode lifecycle starts after isolated regression entrypoints.')
replace('objects/MakeGame/Alarm_0.gml','scrHMArtworkInit();',
        'scrHMArtworkInit();\nscrHMGameplayErrorInit();')
replace('objects/CustomEnemy/Destroy_0.gml','scrHMActorCallback("on_destroy");',
        'if(instance_exists(HMGameplayTest)) show_debug_message("HARDMODE ACTOR DESTROY "+json_stringify({name:name,hp:hp,tick:HMGameplayTest.ticks,x:x,y:y}));\nscrHMActorCallback("on_destroy");')
write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
