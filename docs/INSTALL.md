# Hardmode 1.1.7 / build 21 安装

本版本 APK、IPA 及最终交付核验通过，包含包内代码与立绘素材、签名连续性和存档
兼容性。同一当前源码 VM 的 56 个 Windows 宿主场景及 13 张渲染图已通过核验。

Android：安装 `NuclearThrone.Hardmode-Android-1.1.7.apk`。包名保持
`com.arkintide.nuclearthronehardmode`；签名连续性已核验，可覆盖同签名旧版并沿用存档。

iOS：使用自己的签名工具重签 `NuclearThrone.Hardmode-iOS-1.1.7.ipa` 后安装，
保留相同应用标识以沿用原存档。IPA 使用兼容的既有原生 Runner 和新游戏资源，仍需重签。

安装包和 SHA256 校验文件通过既有 Hardmode 专用 MEGA 目录分发。GitHub 发行内容为
文本源码、工程元数据和安装说明，不附带安装包或游戏素材。下载后请按本版本校验
清单比对文件大小和 SHA256。

视频设置中的“自动降帧”默认开启。持续过载时会暂时降到原生 30 Hz 回调并尝试恢复，
关闭后使用玩家所选帧率。该功能不保证所有手机或高 Loop 场景恒定 60 帧。

本轮验收采用静音隔离 Windows 宿主 VM，尚无 Android/iPhone 真机通过声明。
