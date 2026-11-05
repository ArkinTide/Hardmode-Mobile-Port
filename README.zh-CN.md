# Nuclear Throne: Hardmode 手机移植版

简体中文 · [English](README.md)

基于 **Blaac 的 Hardmode b24** 与 Nuclear Throne Recreated Epsilon 制作的安卓／iOS 独立移植版，与 NTTE 工程分开维护。

版本 **1.1.3 / build 17** 同步从 **2026 年 11 月 3 日 17:36（UTC+08:00）** 开始提出的模组版改动，包括首领替换排除、下水道涉水显示和查询、首领血量与演出、7-4 王冠密室回程、原始王座地图与结尾、6-3 装置出口、额外首领远处生成、3-1 武器箱，以及进入 Loop2 时多选一次终极变异。另修复祭坛／发电机假墙、取消水中青蛙转化、继续优化循环查询，更新手机图标并加入全关卡生成检查。局长大球分裂的全部弹幕束改为等角度分布，进入丛林不再额外赠送变异。完整范围见 [更新说明及验证限制](docs/FIXES.md)。

[下载安卓 APK／iOS IPA](https://mega.nz/folder/7TY3wZRB#PgQeCYQzxvrVGjfjX6YefA)。**IPA 需要自行重签。** 安装包使用 Hardmode 专用 MEGA，GitHub 只发布文本源码。安装包和上传的最终状态以本轮验收及上传回读记录为准，编写更新说明不代表发布已经完成。

保留触屏操作、简体中文、既有存档，以及每秒 30 次逻辑更新／可选 60 帧呈现。**不加入 Grillskills**，继续使用手机版自带的变异选择。Hardmode 设置保留首领血条、王座能量球反弹、玩家增强（生命上限 +2、等级上限 +1）和老鼠复活开关。Loop2 的额外终极变异独立于玩家增强开关，保留已选终极变异及其效果。

独立包名：`com.arkintide.nuclearthronehardmode`。安卓授权后的共享存档目录为 `/storage/emulated/0/games/com.arkintide.nuclearthronehardmode/`，不可写时使用私有目录。iOS 存档位于 `Documents/hardmode/`，开启文件共享。更新前请备份存档。

仓库仅含文本源码和工程元数据，不含图片、音频、字体、原生 runner、SDK、签名材料、用户存档、安装包或原模组内嵌的图片数据。构建需要自行补齐素材及本地依赖，见 [BUILDING.md](BUILDING.md)。

验证使用静音私有桌面上的 30／60 帧已编译 VM 场景，并检查安卓／iOS 安装包。最终测试证据是发布前置条件；这些检查不等于安卓或 iPhone 真机验收，也不能保证所有设备在高循环下恒定 60 帧。iOS 使用兼容的既有原生 runner 与本轮新 VM／资源，需要重签，未进行新一轮 Mac 原生构建。

感谢 Hardmode 作者 **Blaac**、**Vlambeer**、NTT 作者 **YellowAfterlife**、[Epsilon 基础工程](https://github.com/kcd-shichen/NuclearThrone-Recreated-Epsilon)及[原模组贡献者](CREDITS.md)。**ArkinTide** 负责移植整合与维护。基础工程代码沿用 [GPL v3](LICENSE)，素材及第三方内容的权利仍归原作者。
