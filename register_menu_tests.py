import json
from create_project import load
from register_native import ROOT,PROJECT,register_script,replace,write
from register_actors import register_object

project=load(PROJECT/'nuclearthronemobile.yyp')
register_script(project,'scrHMMenuTests',(ROOT/'tests/menu-native.gml').read_text(encoding='utf8'))
register_object(project,'HMMenuTest',None,{(3,2,None):'scrHMMenuTestStep();'})
obj=load(PROJECT/'objects/HMMenuTest/HMMenuTest.yy');obj['persistent']=True
write('objects/HMMenuTest/HMMenuTest.yy',json.dumps(obj,indent=2)+'\n')
replace('objects/MakeGame/Alarm_0.gml','if(scrHMGameplayTests()) exit;',
        'if(scrHMMenuTests()) exit;\nif(scrHMGameplayTests()) exit;')
write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
print('Actual title/play/character-select regression registered')
