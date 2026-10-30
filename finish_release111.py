"""Write current delivery documentation from verified receipts."""
from pathlib import Path
import json
from release_config import VERSION,BUILD,DIRECTORY
ROOT=Path(__file__).resolve().parent
OUT=ROOT/DIRECTORY
FIXES='''# Hardmode 1.0.11

| 项目 | 修改与验证 |
|---|---|
| Windows滚轮偶发失效 | Begin Step采样，短暂保留未消耗输入，成功换枪才清除；处理通用键盘采样晚于Player Step时的覆盖和重复。wheel111跨真实物理帧检查。 |
| Windows 60帧观感 | 原MOD手动改坐标仍为30Hz；绘制时平滑该部分位移。AI、实际坐标、碰撞和每秒游戏进度保留。perf111测真实绘制次数与逐帧位移。 |
| 下水道岸边误判 | 一次性关联实际水面sprite；顶岸8贴图像素（缩放后6.4世界像素）不算水。上岸立即恢复，干燥爆炸地块优先。 |
| 皇冠祭坛 | Hardmode只允许7-4，保留三次上限。实际Portal与RoomEnd/Start验证密室往返。 |
| 精英蜘蛛盾反 | 玩家等离子大球保留玩家阵营、伤害归属，分裂后也不能伤玩家且能伤敌人；普通子弹仍按原规则反弹。 |
| 诅咒水晶Boss音乐 | 登场后选musBoss6B；普通版保留musBoss6。 |
| 诅咒洞窟复原 | Boss死亡后同步恢复墙面、墙顶、外侧与衔接层，保持纯色深墙、实例及合并碰撞尺寸。 |
| 循环精英蜘蛛 | 加入普通水晶洞窟、诅咒洞窟、冰封都市；仅loop，安全地板位置，有额外数量上限。 |
| 循环冰封都市 | 移除额外大绿水晶的生成。 |
| 原版loop敌人 | 按冻结Epsilon的七个精确加权池补入对应区域；原生区域不重复抽取。补入的DogGuardian等跳过Hardmode原基础池的替换。 |
| 金星武器掉落 | 四种金星持枪怪在金星外死亡不掉专属金星武器；尸体、辐射与普通掉落不受影响，玩家已带出武器可保留。 |
| 3-5误转弹射弹 | 大狗导弹处理只认相同大狗射手，不再以最近敌人猜测归属。移动中的敌弹穿过同阵营怪物回归，并保留大狗墙面反弹。 |
| 王座偏位 | 锚点随原生安全出生区的整图平移同步，保持大厅、红毯和王座中轴一致；验证真实地板行及实际画面。 |
| 爆炸守护者弹数 | 只读对照电脑版NTT攻击事件，正常攻击由14改为26发，角间隔360/26；蓄力死亡独立14发保留。两帧率实发计数检查。 |

测试全程静音，仅30/60帧。滚轮验证使用合成输入经过真实Player Step，未宣称物理鼠标自动操作。桌面定向回归不等于完整人工通关或手机真机验收。原版7231文件与素材像素、音频不改。独立包名与GAME_BUILD3004存档格式保留。

Windows先交付；手机版手动位移检查结果和新包核验见delivery-receipt.json。IPA使用兼容原生runner和新VM/资源，需重签，没有新Mac原生重建或手机真机验证。
'''

def main():
    assert (VERSION,BUILD)==('1.0.11',12)
    (OUT/'FIXES.md').write_text(FIXES,encoding='utf8')
    receipt=OUT/'delivery-receipt.json'
    if not receipt.exists():
        print('Current fix documentation written; final delivery is still pending');return
    r=json.loads(receipt.read_text(encoding='utf8'));assert r['status']=='PASS'
    lines=[f'# Hardmode {VERSION} / build {BUILD}', '',
        'Android：保持旧签名，可覆盖更新。iOS：IPA需要重签。Windows：解压完整ZIP后运行EXE。', '',
        '安卓共享存档：/storage/emulated/0/games/com.arkintide.nuclearthronehardmode/；iOS：Documents/hardmode/。',
        'Windows存档继续使用独立Hardmode目录。更新前请备份存档。', '',
        '本轮验证为定向自动回归，非手机真机验收。各包SHA256：', '']
    for a in r['artifacts']:lines.append(f"- {Path(a['path']).name}：{a['sha256']}")
    if 'windows_artifact' in r:
        a=r['windows_artifact'];lines.append(f"- {Path(a['path']).name}：{a['sha256']}")
    lines+=['','Hardmode下载：https://mega.nz/folder/7TY3wZRB#PgQeCYQzxvrVGjfjX6YefA',
        '纯源码：https://github.com/ArkinTide/Hardmode-Mobile-Port','']
    install='\n'.join(lines)
    (OUT/'INSTALL.md').write_text(install,encoding='utf8')
    (ROOT/'deliverables'/f'Hardmode-{VERSION}-安装说明.md').write_text(install,encoding='utf8')
    (OUT/'DELIVERY.md').write_text(f'# Hardmode {VERSION}\n\n交付核验PASS。证据与验证边界见delivery-receipt.json、FIXES.md。云端状态见publication-receipt.json。\n',encoding='utf8')
    print('Current release delivery documents written')

if __name__=='__main__':main()
