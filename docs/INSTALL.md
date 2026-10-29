# Nuclear Throne: Hardmode b24 1.0.7

Android：`NuclearThrone.Hardmode-Android-1.0.7.apk`，签名与旧版一致，可覆盖更新。iOS：`NuclearThrone.Hardmode-iOS-1.0.7.ipa`，**需要重签**；保留与旧版相同的签名应用标识以保留存档。更新前先备份，不要先卸载旧应用。

独立包名 `com.arkintide.nuclearthronehardmode`，存档格式 GAME_BUILD3004 不变。安卓授权后的共享存档在 `/storage/emulated/0/games/com.arkintide.nuclearthronehardmode/`，不可写时使用原私有目录。iOS 为 `Documents/hardmode/`，开启文件共享与就地打开；手机系统中的权限界面及 Files 可见性仍需真机确认。

满级前使用 Hardmode 辐射规则，满级后恢复普通掉落，绿老鼠基础掉落与普通老鼠相同。本轮 24 项详见 FIXES.md。

同一最终桌面 VM 的 30／60 帧 188 项游戏场景、10870 项游戏断言、1619 项原生检查及 4337 项菜单／语言断言通过。金星 12 关主线和含秘密关的 17 关路线，分别完成 30／60 帧连续自动流程，包含两阶段 Boss、逃生车和返回 3-5。

没有手机真机或本轮 Mac 原生重建验收。IPA 保留兼容 runner 并更新 VM／资源，需要重签。桌面性能采样不代表手机帧率。Android 离线 release lint 依赖缺失，已执行签名、16K 对齐及资源核验。

Android SHA256：`2c023fe59b226e5d7614dc670aa92662b682386cbcdf6c7aac413feee85b7170`。

iOS SHA256：`6f6a80ca8cba296519baf8856be7b3d35cbe65eeebfc8443d5a7a89a75a33be4`。
