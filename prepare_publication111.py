"""Use the source-only staging contract with current release documentation."""
from pathlib import Path
root=Path(__file__).resolve().parent
source=(root/'prepare_publication110.py').read_text(encoding='utf8')
source=source.replace('release110','release111')
source=source.replace('This update fixes wall colours, initial throne placement, 7-4 crown-vault routing, two-loop boss scaling, loop map growth and Windows mouse-wheel swapping.',
    'This update fixes intermittent Windows wheel swapping, 60 FPS manual-motion rendering, sewer banks, 7-4-only altars, plasma reflection, cursed-cave music and walls, loop enemy pools, Venus weapon drops, 3-5 bullets, throne alignment, and the desktop 26-shot ExploGuardian attack.')
source=source.replace('本次修复墙色、王座生成、7-4密室路由；三种Boss每两次loop增加一只，普通随机地图每loop增大20%（最多两倍），Windows支持滚轮换枪。',
    '本次修复滚轮漏换、60帧手动位移绘制、下水道岸边误判、祭坛仅7-4、等离子盾反、诅咒水晶音乐与墙面复原、循环敌人池、金星武器掉落、3-5弹种误改、王座位置，以及爆炸守护者26发攻击。')
source=source.replace('[Download APK / IPA]', '[Download APK / IPA / Windows]')
source=source.replace('[下载 APK 和 IPA]', '[下载 APK、IPA 和 Windows]')
source=source.replace('python -B register_release109.py\npython -B integrate_windows110.py\npython -B integrate_release110.py',
    'python -B integrate_release111.py')
for name in ('run_release','build_mobile','make_release','package_windows'):
    source=source.replace(name+'110',name+'111')
source=source.replace('After mobile publication, `python -B package_windows111.py` creates and validates the portable Windows x64 ZIP from the same VM.',
    'This round delivers the validated Windows ZIP first. Mobile motion inspection follows; separate VM hashes and package receipts record both phases. `package_windows111.py` creates the portable ZIP from the Windows regression receipt.')
exec(compile(source,__file__,'exec'))
