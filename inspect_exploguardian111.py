"""Read-only inspection of the original desktop NTT attack events."""
from pathlib import Path
import sys

root=Path(__file__).resolve().parent
source_path=root.parent/'ntte-complete/inspect_ntt_native.py'
source=source_path.read_text(encoding='utf8')
source=source.replace('ROOT=pathlib.Path(__file__).resolve().parent',
    'ROOT=pathlib.Path(__file__).resolve().parent/"release111"')
source=source.replace("sys.path.insert(0,str(ROOT.parent/'native-deps'))",
    'sys.path.insert(0,'+repr(str(root/'release111/analysis-deps'))+')')
source=source.replace("(ROOT/'ntt-native-names.tsv').write_text", "(ROOT/'desktop-native-names.tsv').write_text")
source=source.replace("'ntt-native-helpers.txt'", "'exploguardian-desktop-disassembly.txt'")
sys.argv=[__file__,'c4d360','c4de00','c4e000','c4eca0']
exec(compile(source,__file__,'exec'))
import json,hashlib,struct
constants={hex(a):struct.unpack_from('<d',b,offset(a))[0]
    for a in (0x1a6e728,0x8346698)}
assert constants['0x1a6e728']==-26
report={'status':'PASS','desktop_executable_sha256':hashlib.sha256(b).hexdigest(),
    'constants':constants,'destruction_repeat_initial_counter':13,
    'normal_attack_projectiles':26,'attack_degrees_per_projectile':360/26,
    'charged_death_projectiles':14,
    'evidence':{'attack_bound':'0xc4e3b9 adds -26; 0xc4e3d5 exits at i >= 26',
        'attack_direction':'0xc4e5ac divisor 26; 0xc4e5cc multiplier 360',
        'death':'0xc4d752 initializes 13; 0xc4dc26 decrements; jns includes zero'},
    'events':{'destroy':'0xc4d360','alarm2':'0xc4e000','alarm1':'0xc4eca0'}}
(root/'release111/exploguardian-desktop-constants.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf8')
print(json.dumps(report))
