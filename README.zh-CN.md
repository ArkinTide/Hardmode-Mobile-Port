# Nuclear Throne: Hardmode 手机移植版

简体中文 · [English](README.md)

基于 **Blaac 的 Hardmode b24** 与 Nuclear Throne Recreated Epsilon 制作的安卓／iOS 独立移植版，与 NTTE 工程分开维护。

当前版本：**1.1.1 / build 15**。修复等级上限未初始化报错、警车受伤递归闪退，补齐金星最终首领及 Y.V 的入场／退场镜头，随机替换金星最终首领从 Loop1 开始，缩小首领名称并与血条分行。详见 [更新说明及验证范围](docs/FIXES.md)。

[下载安卓 APK／iOS IPA](https://mega.nz/folder/7TY3wZRB#PgQeCYQzxvrVGjfjX6YefA)。**IPA 需要自行重签。** 安装包放在 Hardmode 专用 MEGA，GitHub 只发布文本源码。

保留触屏操作、简体中文、既有存档兼容及每秒 30 次逻辑更新／可选 60 帧呈现。**不加入 Grillskills**，继续使用手机版自带的变异选择功能。Hardmode 设置新增首领血条、反弹王座能量球、玩家增强（生命上限 +2、等级上限 +1），并保留老鼠复活开关。

独立包名：`com.arkintide.nuclearthronehardmode`。安卓授权后的共享存档目录为 `/storage/emulated/0/games/com.arkintide.nuclearthronehardmode/`，不可写时使用私有目录。iOS 存档位于 `Documents/hardmode/`，开启文件共享。更新前请备份存档。

仓库仅含文本源码和工程元数据，不含图片、音频、字体、原生 runner、SDK、签名材料、用户存档、安装包或原模组内嵌的图片数据。构建需要自行补齐素材及本地依赖，见 [BUILDING.md](BUILDING.md)。

验证使用静音隔离桌面上的已编译 VM，并检查安卓／iOS 安装包结构。没有宣称安卓或 iPhone 真机验收，也不能据此保证所有设备在高循环下恒定 60 帧。iOS 使用兼容的既有原生 runner 与本轮新 VM／资源，需要重签，未进行新一轮 Mac 原生构建。

感谢 Hardmode 作者 **Blaac**、**Vlambeer**、NTT 作者 **YellowAfterlife**、[Epsilon 基础工程](https://github.com/kcd-shichen/NuclearThrone-Recreated-Epsilon)及[原模组贡献者](CREDITS.md)。**ArkinTide** 负责移植整合与维护。基础工程代码沿用 [GPL v3](LICENSE)，素材及第三方内容的权利仍归原作者。
