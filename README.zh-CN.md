# Nuclear Throne: Hardmode 手机移植版

简体中文 · [English](README.md)

基于 **Blaac 的 Hardmode b24** 和 Nuclear Throne Recreated Epsilon 制作的安卓／iOS／Windows 独立移植版，与 NTTE 移植工程分开维护。

当前版本 **1.0.12 / build 13**。本次修复 Windows 滚轮事件与启动节拍、诅咒洞窟墙色恢复、停车场音乐跨区滞留及下水道岸边误判；补上安卓和 iOS 的 MOD 手动位移绘制平滑，保持每秒30次逻辑更新。包含此前1.0.11的修复。[下载 APK、IPA 和 Windows](https://mega.nz/folder/7TY3wZRB#PgQeCYQzxvrVGjfjX6YefA)。GitHub 只发布源码，安装包放在既有 MEGA 目录。

仓库只包含文本源码及工程元数据，包括 GML 适配层、生成模块、编译器、测试、汉化和 GameMaker 工程定义。**不含图片、音频、字体、原生 runner、SDK、签名、用户存档或原 MOD 内嵌图片数据**。工程内的素材引用需要另行补齐。

安卓独立包名为 `com.arkintide.nuclearthronehardmode`。授权后的共享存档目录为 `/storage/emulated/0/games/com.arkintide.nuclearthronehardmode/`；不可写时使用私有目录。iOS 存档在 `Documents/hardmode/` 并开启文件共享。

满级前使用 Hardmode 辐射规则，渡鸦5点，激光／闪电／诅咒水晶8／11／11点；满级后恢复各自原版基础掉落，绿老鼠与普通老鼠相同。Hardmode设置中的老鼠死亡复活为绿老鼠默认开启，可以关闭并保存。移除独立版中不使用的多人、资源包、每日／每周挑战和主菜单 Discord 入口，加入 Hardmode 简体中文文本，保留原版既有汉化。

源码结构、构建依赖与命令见 [BUILDING.md](BUILDING.md)。纯源码克隆不能直接运行，需要自行提供合法取得的原版／Hardmode 素材、兼容 GameMaker、平台工具链和签名材料。

Windows 先完成22项30／60帧场景、原生／菜单和随包程序启动检查并交付，随后以独立标识的VM验证手机端平滑。实际滚轮输入在较早开发构建观察通过，最终VM以合成输入经过真实Player Step核验；移动包检查签名／结构／资源。桌面 CPU 计时不能代表手机帧率；没有宣称安卓／iPhone 真机或本轮 Mac 原生重建验收。**IPA 需要重签**。

感谢 Hardmode 作者 Blaac、[原移植基础工程](https://github.com/kcd-shichen/NuclearThrone-Recreated-Epsilon)、Vlambeer、YellowAfterlife 及[原 MOD 贡献者](CREDITS.md)。原基础工程代码沿用 [GPL v3](LICENSE)；素材、音乐及第三方内容的权利仍归原作者，仓库不额外授予其使用许可。
