"""Write the 1.1.2 delta notes without copying old acceptance claims."""
from pathlib import Path
ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release1102'

def main():
    for filename,old_prefix,new_line in [
        ('README.md','Current release:',
         'Current release: **1.1.2 / build 16**. Adds the native-mod sewer-query optimization and 6-3 exit repair, plus mutually exclusive five-percent Captain/final Venus boss replacement from Loop1. Throne and all Venus rooms keep their own bosses. Captain gains native warp presentation, camera pans and one extra ball-split beam per Loop; the final Venus boss gains one first-phase rocket per Loop. See [changes and verification limits](docs/FIXES.md).'),
        ('README.zh-CN.md','当前版本：',
         '当前版本：**1.1.2 / build 16**。同步模组版的下水道涉水查询优化、6-3 出口修复，以及 Loop1 起局长／金星最终首领各 5% 的互斥替换。Throne 和所有金星关卡保留自己的关底首领。局长拥有传送入场、入退场镜头和每循环增加一束大球分裂弹；金星最终首领一阶段每循环增加一枚火箭。详见 [更新说明及验证范围](docs/FIXES.md)。')]:
        lines=(ROOT/'release1101'/filename).read_text('utf8').splitlines()
        assert sum(line.startswith(old_prefix) for line in lines)==1
        lines=[new_line if line.startswith(old_prefix) else line for line in lines]
        (OUT/filename).write_text('\n'.join(lines)+'\n','utf8')
    for name in ('INSTALL.md','BUILDING.md'):
        text=(ROOT/'release1101'/name).read_text('utf8').replace('1.1.1','1.1.2').replace('1101','1102')
        if name=='BUILDING.md':
            text=text.replace('python -B run_release1102_checks.py menu:30 menu:60',
                              'python -B release1102_test_plan.py --run')
            text=text.replace('python -B set_release1102.py\npython -B integrate_release1102.py',
                              'python -B freeze_source.py baseline --directory release1102\npython -B integrate_release1102.py\npython -B set_release1102.py')
            text+='\nDo not overwrite an existing baseline or final snapshot. This delta adapts portal type 2 and the host Last object; the NTT implementations are not imported over mobile event lifecycles.\n'
        (OUT/name).write_text(text,'utf8')
    fixes='''# Hardmode 1.1.2 / build 16

在已发布手机版 1.1.1 上增量同步 NTT 模组版本轮改动；未重新导入历史版本。

1. 下水道只在一次同步涉水遍历内复用真实地板／水面几何查询。每次遍历结束停用缓存、下次重新建立，保留脚底五点检测、干地覆盖和岸边范围。没有削减敌人或弹幕，也没有降低 AI 更新频率。
2. 修复 6-3 电梯出口：保留 IDPD 门的关闭动画，避免每帧重置；电梯不阻挡玩家，出口采用可完整站立的位置，并沿用原生进门／关卡切换。去除原点不可见阻挡实体；原生尸体生成的出口也保留正确 IDPD 类型。
3. Loop1 起，在符合原有区域规则的关底进行一次互斥抽签：5% 局长，另 5% 金星最终首领。Throne 和所有金星关卡明确排除，宫殿／HQ 等既有排除继续保留；不把额外首领当作关底替换目标。
4. 替换出现的局长使用宿主真实 Last 对象及原生 AI，传送入场后接首领镜头。本局首次 HQ 外出现可播放局长立绘，仍遵循立绘开关。死亡时播放退场镜头并在原处绘制仅作动画的 IDPD 门，不触发原版局长结局。真正通关出口独立生成。原生局长大球保留原有分裂，每循环增加一束八发弹幕。
5. 金星最终首领一阶段的火箭齐射每循环增加一枚；二阶段攻击及既有火箭归属／自伤免疫规则保持。

最终核验覆盖 30／60 帧实际宿主 VM：循环下水道真实地图采样、L0／L1／L3 替换及排除区域、局长原生攻击与真实子弹击杀、首次立绘和关闭选项、独立退场门与原生出口、6-3 清场后实际到达宫殿 7-1、大球分裂和一阶段火箭；另复查警车、等级上限／继续游戏、两阶段金星首领镜头、名称布局、王座及王冠密室。实际场景和通过状态绑定在本地 delivery-receipt.json 中。

测试使用完全静音、从未激活的私有桌面和隔离存档，不操作用户前台窗口。安卓／iOS 安装包检查版本、资源、签名、Android 节拍与存档支持及 iOS runner 兼容性。这不是手机真机验收，也不保证极高 Loop 恒定 60 帧；不沿用 NTT 模组版的帧率数据作为手机版性能数字。iOS 使用兼容的既有 runner 与新编译 VM／资源，需要自行重签，没有本轮 Mac 原生重建。

保留手机版变异选择、简体中文、触屏操作、满级前后辐射规则、应用身份和存档位置，不加入 Grillskills。GitHub 仅上传纯文本代码和工程元数据，安装包／校验清单发布到 Hardmode 专用 MEGA，并完整下载回读核对 SHA-256。
'''
    (OUT/'FIXES.md').write_text(fixes,'utf8')
    (OUT/'RELEASE-NOTES.md').write_text('''Hardmode 手机移植版 1.1.2

- 优化循环后下水道的涉水查询，修复 6-3 IDPD 出口无法完成转场。
- Loop1 起关底首领有各 5% 的互斥概率替换为局长或金星最终首领。Throne 和所有金星关卡保留原有首领。
- 局长拥有传送入场、入退场镜头及本局首次 HQ 外立绘，死亡门仅作动画；每循环大球增加一束分裂弹幕。
- 金星最终首领一阶段每循环增加一枚火箭。

[安卓 APK／iOS IPA 下载（Hardmode 专用 MEGA）](https://mega.nz/folder/7TY3wZRB#PgQeCYQzxvrVGjfjX6YefA)

保留既有存档、触屏操作和手机版变异选择，不加入 Grillskills。IPA 需自行重签。GitHub 仅含纯文本源码，无游戏素材或安装包附件。

验证使用后台静音的实际桌面宿主 VM（30／60 帧）及移动包检查，没有安卓／iPhone 真机或本轮 Mac 原生重建验收，不保证所有高循环场景恒定 60 帧。详见 docs/FIXES.md。
''','utf8')
    print('Wrote 1.1.2 release documentation')

if __name__=='__main__':main()
