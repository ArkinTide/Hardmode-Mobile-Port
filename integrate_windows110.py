"""Register the focused desktop input repair without replaying old releases."""
from pathlib import Path
import json

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT/'project'

def write(path,text):
    path.write_text(text,encoding='utf8',newline='\n')

def replace_once(path,old,new):
    text=path.read_text(encoding='utf8')
    if new in text:return
    assert text.count(old)==1,(path,old,text.count(old))
    write(path,text.replace(old,new))

replace_once(PROJECT/'objects/UberCont/Create_0.gml','Hardmode 1.0.9','Hardmode 1.0.10')
options=PROJECT/'options/windows/options_windows.yy'
data=json.loads(options.read_text(encoding='utf8'))
data['option_windows_version']='1.0.10.0'
data['option_windows_copy_exe_to_dest']=True
data['option_windows_company_info']='ArkinTide'
data['option_windows_product_info']='Nuclear Throne: Hardmode'
data['option_windows_description_info']='Nuclear Throne: Hardmode 1.0.10'
write(options,json.dumps(data,ensure_ascii=False,indent=2)+'\n')
write(ROOT/'release_config.py',
      '"""Standalone Hardmode application release identity (not the save schema)."""\n'
      "VERSION = '1.0.10'\nBUILD = 11\nDIRECTORY = 'release110'\n"
      "PACKAGE = 'com.arkintide.nuclearthronehardmode'\n")
test_register=ROOT/'register_gameplay_tests.py'
if "'tests/windows110.gml'" not in test_register.read_text(encoding='utf8'):
    replace_once(test_register,"'tests/requests109.gml']", "'tests/requests109.gml','tests/windows110.gml']")
replace_once(ROOT/'tests/gameplay.gml',
             'if(mode=="weapons") scrHMGameplayWeapons();',
             'if(mode=="windows110") scrHMGameplayWindows110();\n        if(mode=="weapons") scrHMGameplayWeapons();')
print('Windows 1.0.10 input repair registered; run register_gameplay_tests.py next.')
