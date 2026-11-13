# Hardmode Mobile Port 1.1.6

Hardmode 手机移植版，build 20。本轮26项修改见[修复记录](docs/FIXES.md)，安装方法见[安装说明](docs/INSTALL.md)。

最终交付核验通过 233 个同一 VM 场景、157017 项断言。

保留包名、Android签名身份、存档路径和手机版变异选择界面。仓库发布文本源码与工程元数据；APK与IPA通过Hardmode专用MEGA目录发布。

测试使用静音隔离的Windows宿主VM，未进行安卓或iPhone真机验收。持续负载过高时会暂时降低渲染至原生30Hz以维持正常游戏速度，负载恢复后再恢复用户60帧设置；不保证所有设备恒定60帧。iOS IPA需重签，使用兼容既有原生Runner和新VM、资源。
