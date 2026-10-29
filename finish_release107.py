"""Write delivery documentation only after all release checks pass."""
from pathlib import Path
import json
from release_config import VERSION, BUILD

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release107'


def main():
    receipt=json.loads((OUT/'delivery-receipt.json').read_text(encoding='utf8'))
    assert receipt['status']=='PASS' and receipt['version']==VERSION
    artifacts={Path(row['path']).suffix:row for row in receipt['artifacts']}
    summary=(f"同一最终桌面 VM 的 30／60 帧 {receipt['gameplay_cases']} 项游戏场景、"
             f"{int(receipt['gameplay_assertions'])} 项游戏断言、{int(receipt['native_assertions'])} 项原生检查及 "
             f"{int(receipt['menu_assertions'])} 项菜单／语言断言通过。金星 12 关主线和含秘密关的 17 关路线，"
             "分别完成 30／60 帧连续自动流程，包含两阶段 Boss、逃生车和返回 3-5。")
    fixes='''# Hardmode 1.0.7 修复对应

本轮对应最新 24 项。修复依据冻结的 Hardmode b24，原版工程、原 MOD 输入和 NTTE 未改。下表的验证指最终桌面 VM 的自动场景与画面检查，不等于手机真机验收。

| 项目 | 修改及验证 |
|---|---|
| 1 交互文字闪烁 | 交互 E 与外部提示绘制绑定持续到额外的 60 帧绘制帧，离开范围后正常清除。prompt107 逐物理帧检查唯一渲染器。 |
| 2 金车下显示玩家 | 原生身体、武器和影子遵守源 MOD 的 image_alpha 隐藏状态；上下车恢复。car107 实际交互上下车及画面。 |
| 3 金星旧武器 HUD | 第一层移除全部额外武器槽及装填、可开火、诅咒状态，保留金星自己的装备。contracts107。 |
| 4 金星偶发严重掉帧 | 修复手枪轨迹不断乘 0.7 却永不到 0 导致永久积累：小于 0.01 时结束。trail107 持续真实开火，检查峰值有界和停火后归零；连续金星流程与 CPU 采样。 |
| 5 掉落武器跨金星层 | 原电梯清理的 NTT Pickup 范围补入宿主 WepPickup。retry107 和连续金星流程经过真实电梯。 |
| 6 金星本关重开 | 仅在金星暂停菜单添加独立汉化动作，复用原电梯换图并保留当前主线／秘密层编号；离开金星后不显示，手柄 B 仍为继续。retry107 实际按钮事件检查主线 1 和秘密 400。 |
| 7 金星霰弹伤害低 | 六颗独立弹丸不再被宿主连续命中无敌帧吞掉；仅标记金星霰弹，不修改普通武器无敌帧规则。pellet107 真实碰撞累计 48 点伤害。 |
| 8 大厦贴图 | 深处合并碰撞墙不再以不透明屋顶遮住源 MOD 的窗边／天空效果，保留实体和原生边缘；核对原始浅白墙顶、红地毯素材及完整路线截图。 |
| 9 边缘过渡层 | 纯色深墙先画，原 TopSmall 过渡层随后画，避免被纯色覆盖。墙体、破墙、主题转换与画面回归。 |
| 10 3-4／3-5 入场爆炸 | 重复／无效装饰清理静默执行，沉睡 Big Dog 占地内重叠的原生爆炸桶／车辆在生成阶段移除；PortalClear 和沉睡 Big Dog 占地清障所造的 FloorExplo 沿链携带非战斗原因，不再因屋顶碰撞引发连锁；普通战斗破墙仍爆炸。junk107 在两关检查入场、实际清障碰撞及战斗破墙对照。 |
| 11 3-3 渡鸦递归 | 活渡鸦变飞行状态不执行死亡事件，避免产生假尸体再次召唤。raven107 保留大量尸体，检查渡鸦和尸体数量不递归增长。 |
| 12 Big Dog 两次立绘 | 源 MOD 立绘只认领一次，废料场中停用重复的原生立绘。junk107 完整观察实际苏醒。 |
| 13 进门特效 | 源 PortalShrink 渲染器保留额外绘制帧，原生身体遵守隐藏状态，缩放／旋转只在逻辑帧推进。portal 回归、交互和画面检查。 |
| 14 寒冰洞入口 | 熔化完成时给传送门写明确的延后目的地，开门时不提前更改当前关卡。ice107 使用真实火焰接触和自然传送，抵达冰洞。 |
| 15 超级水晶清空墙体 | 去掉源冲击波中不适用于合并碰撞块的全墙销毁重建，改为保留块尺寸／实例的主题队列。cavewalls107 实际击杀，逐一检查所有碰撞块保留。 |
| 16 第七大关恐惧不动 | 抑制辐射攻击不再提前退出整个原生移动事件；补入原生移动计时，保留原 MOD 的 16 HP、敌方贴图及吸收辐射分裂。horror107 检查实际走动；horror103 检查守护者死亡生成及可击杀。 |
| 17 Boss 立绘卡顿 | 删除已不用的第二遍全弹幕状态保存，保留唯一冻结／还原流程。portraitprofile107 记录真实场景和 96 发弹幕下从 BeginStep 到绘制结束的 CPU 时间；不是手机帧率保证。 |
| 18 王座 II 下落动画 | 下落复用与进传送门相同的身体／武器缩放旋转渲染，初始化角度并保留下坠和恢复。fall107 执行源实际下落分支，逐帧检查唯一渲染器。 |
| 19 警局／6-3 门 | 创建时和源持续步骤均使用蓝色 IDPD type=2，不再被写回王冠门。police107 检查持续运行后的门类型和实际贴图。 |
| 20 警局小匪 | 原生箱旁蹲守小匪逻辑排除 Hardmode 命名警局。police107 检查原生和转换后的小匪均不存在。 |
| 21 循环警察／警车 | 恢复战斗关卡的原生 WantPopo／WantVan 规则；循环 3 起 Hardmode 替换后的 3D 警车真正停稳才执行原爆炸回调，随后放出三个 IDPD Freak。waves107 观察原生控制器实际出兵；van107 区分循环 2 原卸载与循环 3 停车爆炸。 |
| 22 循环 3 警察复活 | 六类警察死亡后复用原版 800 逻辑帧计时和复活效果，绑定真实尸体并跟随击退，避免取到隐形出口尸体。revive107 在循环 2／3 检查实际死亡、计时、效果和 Freak 生成。 |
| 23 盾反等离子阵营 | 普通／精英盾牌反弹玩家的 PlasmaBig／PlasmaHuge 时保留玩家 team 与 hitid，普通子弹的反弹规则不变。reflect107 检查无法伤玩家且仍能伤敌。 |
| 24 满级绿老鼠辐射 | 满级后以独立有符号增量补至普通老鼠的 4 点基础掉落；满级前保留 MOD，重复同步不叠加，吸收辐射不被重置。contracts107 检查实际死亡掉落 4 点基础加 5 点吸收。 |

测试时序修正：旧 horror103 在创建守护者的同一刻就击杀，绕过 MOD 的正常辐射初始化，移动恢复后子代可吸收过多辐射继续分裂。现等待实际初始化再进行战斗死亡，保留三只生成及 16 HP、贴图、无辐射激光和可击杀断言。早期失败保留为诊断，不计入通过数量。

保持 GAME_BUILD3004、独立包名、安卓共享存档、iOS Documents 分享和原版既有汉化。仅测试入口静音，正常游戏音量不变。无手机真机、完整人工通关或本轮 Mac 原生重建验收；iOS 需要重签。GitHub 发布纯文本源码，安装包通过既有 MEGA 目录分发。
'''
    (OUT/'FIXES.md').write_text(fixes,encoding='utf8')
    install=f'''# Nuclear Throne: Hardmode b24 {VERSION}

Android：`NuclearThrone.Hardmode-Android-{VERSION}.apk`，签名与旧版一致，可覆盖更新。iOS：`NuclearThrone.Hardmode-iOS-{VERSION}.ipa`，**需要重签**；保留与旧版相同的签名应用标识以保留存档。更新前先备份，不要先卸载旧应用。

独立包名 `com.arkintide.nuclearthronehardmode`，存档格式 GAME_BUILD3004 不变。安卓授权后的共享存档在 `/storage/emulated/0/games/com.arkintide.nuclearthronehardmode/`，不可写时使用原私有目录。iOS 为 `Documents/hardmode/`，开启文件共享与就地打开；手机系统中的权限界面及 Files 可见性仍需真机确认。

满级前使用 Hardmode 辐射规则，满级后恢复普通掉落，绿老鼠基础掉落与普通老鼠相同。本轮 24 项详见 FIXES.md。

{summary}

没有手机真机或本轮 Mac 原生重建验收。IPA 保留兼容 runner 并更新 VM／资源，需要重签。桌面性能采样不代表手机帧率。Android 离线 release lint 依赖缺失，已执行签名、16K 对齐及资源核验。

Android SHA256：`{artifacts['.apk']['sha256']}`。

iOS SHA256：`{artifacts['.ipa']['sha256']}`。
'''
    (OUT/'INSTALL.md').write_text(install,encoding='utf8')
    (OUT/'DELIVERY.md').write_text(f'''# Hardmode {VERSION} / build {BUILD}

交付总核验 PASS，见 delivery-receipt.json。本轮 24 项说明见 FIXES.md，安装和存档见 INSTALL.md。

{summary}

桌面 VM SHA256：`{receipt['final_desktop_vm_sha256']}`。

原版 {receipt['original_files_verified']} 个文件未改，图片像素和音频未改。全部测试静音，正常游戏音量不受影响。移动包结构核验不能替代真机测试；IPA 需要重签。

本地包：

- `../{artifacts['.apk']['path']}`
- `../{artifacts['.ipa']['path']}`

Android SHA256：`{artifacts['.apk']['sha256']}`。

iOS SHA256：`{artifacts['.ipa']['sha256']}`。

GitHub 仅发布文本源码，安装包上传到既有 MEGA 目录；云端实际完成状态以 publication-receipt.json 为准。
''',encoding='utf8')
    (ROOT/'deliverables'/f'Hardmode-{VERSION}-安装说明.md').write_text(install,encoding='utf8')
    print('Release delivery and 24-item fix documentation written')


if __name__=='__main__':main()
