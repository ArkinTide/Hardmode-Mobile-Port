"""Create version-scoped verification/publication tools from retained 108 tools."""
from pathlib import Path
import re

ROOT=Path(__file__).resolve().parent

def copy(source,destination,replacements=()):
    text=(ROOT/source).read_text(encoding='utf8')
    for old,new in replacements:
        if old not in text:
            assert new in text,(source,old)
            continue
        text=text.replace(old,new)
    (ROOT/destination).write_text(text,encoding='utf8')

common=[('release108','release109')]
copy('audit_mobile_storage108.py','audit_mobile_storage109.py',common)
copy('audit_structures108.py','audit_structures109.py',common)
copy('prepare_publication108.py','prepare_publication109.py',common+[
    ('run_release108_checks','run_release109_checks'),
    ('audit_structures108','audit_structures109'),('collect_visual108','collect_visual109'),
    ('audit_mobile_storage108','audit_mobile_storage109')])
copy('make_release108_receipt.py','make_release109_receipt.py',common+[
    ("('1.0.8', 9, 'release109')","('1.0.9', 10, 'release109')"),
    ('1.0.7','1.0.8'),('run_release108_checks','run_release109_checks'),
    ("functions += ['scrHMSkipBossPresentation108'", "functions += ['scrHMSkipBossPresentation108'"),
    ("    artifacts = []", "    functions += "+repr(re.findall(r'function (\w+)\(', (ROOT/'native/repairs109.gml').read_text(encoding='utf8')))+"\n    artifacts = []"),
    ("'existing_media_pixels_and_audio_unchanged_since_1_0_7':True,'added_warning_sprites':media", "'only_media_change':'User supplied Tank warning PNG replaces previous warning frames; all other media unchanged.','changed_warning_images':media"),
    ("'deliverables/NuclearThrone.Hardmode-Android-1.0.8.validation.json')['certificate_sha256'] == \\\n           read('deliverables/NuclearThrone.Hardmode-Android-1.0.8.validation.json')", "'deliverables/NuclearThrone.Hardmode-Android-1.0.8.validation.json')['certificate_sha256'] == \\\n           read('deliverables/NuclearThrone.Hardmode-Android-1.0.9.validation.json')")])
copy('collect_visual108.py','collect_visual109.py',common+[
    ('run_release108_checks','run_release109_checks'),
    ("['wall108','venuswall108','pickup108','tankportal108','venus106','venussecrets106','profile106','cavewalls107','junk107','water104','walls104']", "['wall109','guardian109','crystals109','water109','tankportal108','venus106','venussecrets106','cavewalls107','water105','walls104']"),
    ("for mode in ['wall108','venuswall108','pickup108','tankportal108']:", "for mode in ['wall109','guardian109','crystals109','water109','tankportal108']:"),
    ("        if mode=='profile106':", "        if mode=='profile109':"),
    ('HARDMODE FRAME106','HARDMODE PROFILE109'),
    ("'Filter and beam pairs use the exact same scene in one test process.'", "'Binding cache and former full scan use the exact same 160 owners and 1280 lookups in one process.'")])
publish=ROOT.parent.parent/'github-publish'
text=(publish/'publish_hardmode108.py').read_text(encoding='utf8')
text=text.replace('release108','release109').replace("VERSION='1.0.8'","VERSION='1.0.9'")
text=text.replace("BASE='165f440f3dd7542f2f3d7395f4305f9807297423'", "BASE='8afbef1dd9ea931b5f92db4d55fc477d30d5855a'")
text=text.replace('build 9。','build 10。')
start=text.index('本轮21项：');end=text.index('\n\nAPK / IPA 下载：',start)
text=text[:start]+'''本轮16项：传送门进门角色层级、Titank起跳断腿恢复、7-4王冠入口与次数限制、5-5小猎人延迟登场、科技术士复活限制、实验室和宫殿墙体衔接、自定义武器元数据报错、用户指定Tank预警及补给、夜间沙漠出口恢复、岸边入水判定、循环Boss数量与渡鸦上限、满级骨鱼辐射、循环大水晶分布、绘制缓存和Great Guardian重复绘制开销。逐项修改、验证范围及限制见 docs/FIXES.md。'''+text[end:]
(publish/'publish_hardmode109.py').write_text(text,encoding='utf8')
print('Version-scoped 109 tools prepared; previous tools unchanged')
