"""Document the verified release; cloud publication has a separate receipt."""
from pathlib import Path
import json
from release_config import VERSION,BUILD
ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release108'

def main():
    r=json.loads((OUT/'delivery-receipt.json').read_text(encoding='utf8'))
    assert r['status']=='PASS' and r['version']==VERSION
    artifacts={Path(a['path']).suffix:a for a in r['artifacts']}
    summary=(f"同一最终桌面 VM 在 30／60 帧下完成 {r['gameplay_cases']} 项场景、"
             f"{int(r['gameplay_assertions'])} 项游戏断言、{int(r['native_assertions'])} 项原生检查和 "
             f"{int(r['menu_assertions'])} 项菜单／语言断言。金星12关主线、17关秘密路线均包含两阶段Boss、逃生车及返回3-5；另完成两阶段王座战。")
    fixes='''# Hardmode 1.0.8 修复对应

本轮对应最新21项。原版、Hardmode b24输入与NTTE保持不动；以下验证为桌面自动场景及画面审查，没有手机真机验收。

| 项目 | 修改和验证 |
|---|---|
| 1 内外墙衔接 | 过渡TopSmall允许位于合并碰撞填充墙上；填充完成和局部破墙后补齐，重复维护不累积。wall108、walls104。 |
| 2 Tank演出 | 跳过IDPD Tank入场/退场镜头和立绘，直接使用战斗待机状态。tank108检查真实死亡回调。 |
| 3 传送门挡人 | 原MOD缩入效果的24像素提交范围直接执行原生进门事件；有墙遮挡时不穿墙进门。portal108。 |
| 4 循环3警察 | 每次原Freak来袭独立50%生成普通或精英警察；原有死亡复活Freak机制保留。police108、revive107。 |
| 5 骑乘狙击手 | 坐骑死亡时立即恢复受击遮罩，保留下落动画。sniper108用真实子弹验证落地前可受伤。 |
| 6 Tank辐射 | 循环3起70点基础辐射，满级前仍应用MOD减量，满级后恢复基础值，保留已吸收辐射且重复同步不叠加。tank108。 |
| 7 循环立绘 | MOD和原生scrBossIntro两个入口均限制循环立绘；保留普通Boss必要的空名称镜头。tank108直接调用两入口，检查循环1和3不暂停。 |
| 8 大量弹幕 | 单对象筛选用原生遍历直接筛选，避免先复制全部实例；影子绘制缩小到实际有shadow字段的对象族。filter108对512弹幕逐项比对顺序、可选字段、alarm和六种比较。 |
| 9 Tank激光 | 早期蓄力限制转速，末段蓄力锁定，与预警线使用相同方向。tank108。 |
| 10 警车弹坑 | 一个3倍大弹坑改成三个独立小弹坑；同时修正爆炸火焰y坐标误用x。crater108验证真实爆炸回调。 |
| 11 地图黑线 | 合并填充墙不再在每块原点额外绘制16像素墙影；保留真实边界阴影。wall108画面。 |
| 12 王座性能 | 1024次逐步射线遮罩查询改为保持相同离散碰撞位置的二分；beam108配对30种墙距，另跑30/60帧两阶段王座战。 |
| 13 金星性能 | 同房换层时清理旧宿主门挡、掉落武器、装饰、绑定和失去作用域的任务；保留原MOD已执行的地图清理，重置地形缓存。完整12/17关连续路线检查。 |
| 14 水晶盾等离子 | 三种MOD护盾反弹玩家等离子大球仍保留玩家team/hitid，爆炸子弹继承阵营。reflect108检查爆炸数量和无法伤害玩家。 |
| 15 大厦墙面 | 金星使用原MOD天空、窗洞和墙面，不再叠加移植额外实心外墙；修复电梯把sprite ID当帧号赋值。venuswall108和完整路线画面。 |
| 16 仓库武器飞出 | 金星掉落物记录本层可达地板安全点，高速飞到边界或碰隐形墙时恢复到安全点。pickup108保留八把高速抛出武器及武器类型。 |
| 17 大厦隐形围墙 | 取消金星额外填充圈，并清理上一层遗留的宿主门挡。原MOD门和边界保持。完整路线检查每层没有合成填充圈。 |
| 18 金车绕圈 | 触屏/手柄方向摇杆映射为世界方向转向与油门；保留键盘原操作。car108实际交互上车并检查四方向直行。 |
| 19 金星译名 | 五把带出金星的武器统一使用“金星”，未修改原版既有汉化。text108、语言审计。 |
| 20 Tank大门预警 | 复用警车大型IDPD门与真实延时生成流程，直接使用指定位置，避免普通警车Create随机选点及清场/音效重复；显示源Tank头像和红色叹号。tankportal108和实际画面。 |
| 21 警车预警 | 原大型门显示用户提供警车图标和红色叹号。tankportal108同场观察两个门。 |

早期失败包括不合理的秘密房间地板数量门槛、原生允许回绕的墙帧数以及已退役的“金星必须有合成填充圈”断言；保留诊断记录，未计入最终通过数量。最终断言检查原MOD地形存在且没有新增围墙。

本轮新增两个预警图标，其余既有图片和音频保持；GitHub仅上传文本源码与元数据，不上传图标或安装包。保持GAME_BUILD3004、包名、安卓共享存档、iOS Documents分享、满级前MOD辐射/满级后原版辐射与绿老鼠4点基础。测试全部静音，正常游戏音量不改。

桌面CPU计时不是手机帧率。没有手机真机或新Mac原生重建；IPA采用兼容runner和新VM/资源，需要重签。
'''
    (OUT/'FIXES.md').write_text(fixes,encoding='utf8')
    install=f'''# Hardmode {VERSION} / build {BUILD}

Android：`NuclearThrone.Hardmode-Android-{VERSION}.apk`，同签名可覆盖更新。iOS：`NuclearThrone.Hardmode-iOS-{VERSION}.ipa`，**需要重签**。保留旧版应用标识以保留存档，更新前先备份。

包名`com.arkintide.nuclearthronehardmode`，存档格式GAME_BUILD3004保持。安卓授权后存档在`/storage/emulated/0/games/com.arkintide.nuclearthronehardmode/`，不可写则回退原私有目录。iOS为`Documents/hardmode/`并开启文件共享。

{summary}

没有手机真机或新Mac原生重建验证；IPA需要重签。桌面性能采样不能保证所有手机帧率。Android离线release lint依赖不全，签名、资源一致性、ZIP和ELF 16K对齐另行核验通过。

Android SHA256：`{artifacts['.apk']['sha256']}`。

iOS SHA256：`{artifacts['.ipa']['sha256']}`。

Hardmode安装包目录：https://mega.nz/folder/7TY3wZRB#PgQeCYQzxvrVGjfjX6YefA 。实际上传完成状态以publication-receipt.json为准。
'''
    (OUT/'INSTALL.md').write_text(install,encoding='utf8')
    (ROOT/'deliverables'/f'Hardmode-{VERSION}-安装说明.md').write_text(install,encoding='utf8')
    (OUT/'DELIVERY.md').write_text(f'''# Hardmode {VERSION}

交付核验PASS，详见delivery-receipt.json、FIXES.md和INSTALL.md。

{summary}

桌面VM SHA256：`{r['final_desktop_vm_sha256']}`。原版{r['original_files_verified']}文件未改；本轮新增两个预警图标。全部测试静音。

APK：`../{artifacts['.apk']['path']}`。

IPA：`../{artifacts['.ipa']['path']}`，需要重签。

GitHub只发布文本源码；云端完成状态见publication-receipt.json。
''',encoding='utf8')
    print('Release 108 documentation written')

if __name__=='__main__':main()
