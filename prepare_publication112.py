"""Reuse the audited text-only selection, with current 1.0.12 documentation."""
from pathlib import Path
root=Path(__file__).resolve().parent
source=(root/'prepare_publication110.py').read_text(encoding='utf8').replace('release110','release112')
old='This update fixes wall colours, initial throne placement, 7-4 crown-vault routing, two-loop boss scaling, loop map growth and Windows mouse-wheel swapping.'
new='This update fixes Windows wheel event delivery and startup timing, cursed-cave wall restoration, music across areas, and dry sewer banks. It also extends manual MOD movement presentation to Android and iOS without changing the 30 Hz simulation. The earlier 1.0.11 fixes are included.'
assert old in source;source=source.replace(old,new)
old='本次修复墙色、王座生成、7-4密室路由；三种Boss每两次loop增加一只，普通随机地图每loop增大20%（最多两倍），Windows支持滚轮换枪。'
new='本次修复 Windows 滚轮事件与启动节拍、诅咒洞窟墙色恢复、停车场音乐跨区滞留及下水道岸边误判；补上安卓和 iOS 的 MOD 手动位移绘制平滑，保持每秒30次逻辑更新。包含此前1.0.11的修复。'
assert old in source;source=source.replace(old,new)
source=source.replace('[Download APK / IPA]','[Download APK / IPA / Windows]').replace('[下载 APK 和 IPA]','[下载 APK、IPA 和 Windows]')
source=source.replace('An independent Android and iOS port','An independent Android, iOS and Windows port')
source=source.replace('安卓／iOS 独立移植版','安卓／iOS／Windows 独立移植版')
source=source.replace('Release checks record one unchanged desktop VM at 30 and 60 FPS, real menu/gameplay callbacks, and mobile package structure, signature and resource checks.',
    'The Windows package was delivered first after 22 targeted 30/60 FPS scenarios, native/menu checks and packaged-executable startup checks. The later mobile presentation change has a separately identified validation VM. Actual wheel input was observed on an earlier development VM; final-VM input checks use synthetic samples through the real Player Step. Mobile checks cover package structure, signature and resources.')
source=source.replace('验证包括同一桌面 VM 的 30／60 帧回归、实际菜单和游戏回调、移动安装包的签名／结构／资源核验。',
    'Windows 先完成22项30／60帧场景、原生／菜单和随包程序启动检查并交付，随后以独立标识的VM验证手机端平滑。实际滚轮输入在较早开发构建观察通过，最终VM以合成输入经过真实Player Step核验；移动包检查签名／结构／资源。')
start=source.index('With the complete local inputs restored:')
end=source.index('An Android Igor extension-path error',start)
source=source[:start]+'''The checked-in project already contains the integration. Do not replay historical registration scripts on it. Restore the missing assets and dependencies, then build and check the current project:

```powershell
./build_local.ps1 -Target windows
python -B run_release112_checks.py native-menu
python -B run_release112_checks.py gameplay
python -B run_release112_checks.py collect
python -B package_windows112.py
```

The maintained development process freezes and delivers Windows before the mobile-only inspection. After the mobile source integration, `audit_mobile_motion112.py runtime` exercises shared actor callbacks and draw transforms at 30/60 FPS; `build_mobile112.py` generates and checks fresh APK/IPA resources. Local source, delivery and publication receipts keep the two validation VM hashes separate. The scripts use the complete private workspace inputs, not an asset-free clone.

'''+source[end:]
source=source.replace('After mobile publication, `python -B package_windows110.py` creates and validates the portable Windows x64 ZIP from the same VM.',
    'The portable Windows ZIP and its recorded validation VM remain unchanged during the subsequent mobile presentation work.')
exec(compile(source,__file__,'exec'))
