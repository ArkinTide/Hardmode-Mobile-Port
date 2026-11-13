"""Write accurate 1.1.5 scope and release documentation, without publishing.

Default output is explicitly a draft until the final same-VM package gate
passes. --final requires that receipt; no preliminary/1.1.4 result is reused.
"""
from pathlib import Path
import argparse
import importlib
import json

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release1105'
P='project/scripts/'
R=P+'scrHMRepairs1102/scrHMRepairs1102.gml'
B=P+'scrHMRepairs109/scrHMRepairs109.gml'
E=P+'scrHMRepairs1104Routes/scrHMRepairs1104Routes.gml'
S=P+'scrHMSync1103Bosses/scrHMSync1103Bosses.gml'
U=P+'scrHMSync1103Ultra/scrHMSync1103Ultra.gml'
F=P+'scrHMSync1103Performance/scrHMSync1103Performance.gml'
A=P+'scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml'
N=P+'scrHMCompiled_enemies_mod_gml/scrHMCompiled_enemies_mod_gml.gml'
T=P+'scrHMRepairs1115Root/scrHMRepairs1115Root.gml'

# Numbering follows the human's chronological followups. Later preferences
# override the earlier resurrection/presentation and HQ threshold wording.
SCOPE=[
 (1,'局长在Loop后增加行动和移动速度。','普通警局局长与替换局长均采用手机版每Loop增加5%行动/移动速度、最高2倍；没有将未证实的倍率描述成电脑版原始常量。',[R,'project/objects/Last/Step_0.gml'],['chief1115first','chief1115repeat','sync115replacementchief']),
 (2,'金星最终首领从Loop1起的第二阶段变为Y.V。','Loop0保留原第二阶段，Loop1及以后使用Y.V。',[A,N],['sync115phasehealth']),
 (3,'替换关底首领的局长统一从传送门出场。','替换槽位始终调用局长原生传送入场构造器。',[R],['chief1115first','chief1115repeat','sync115replacementchief']),
 (4,'Throne和HQ-5不生成额外首领。','在额外种群入口提前排除这两间房，避免消耗额外抽签或干扰正常首领。',[P+'scrHMSync1103Spawn/scrHMSync1103Spawn.gml'],['sync115policy']),
 (5,'IDPD单位出现前的传送门动画不要提前消失。','保留原生IDPDSpawn的动画和定时器所有权，在真正的出兵事件中应用模组权重。',[R,'project/objects/IDPDSpawn/Alarm_1.gml'],['sync115idpdgate']),
 (6,'此前限定Loop3的敌人改为Loop1出现，警局追加规则除外。','普通区域统一使用Loop1阈值；警局的指定追加敌人继续遵守第14项。',[R,A,P+'scrHMSync1103Spawn/scrHMSync1103Spawn.gml'],['sync115policy','followup113allareas']),
 (7,'检查大量敌人、弹幕和循环后下水道的开销。','实测发现新的数值水域索引更慢，因此恢复已发布版的精确哈希批处理和干地预筛，保留房间水域状态修复；下水道使用专用绘制绑定缓存，减少每个入水实体重复分类和字符串构造，并验证相同绑定、所有权、数量及随机序列；护盾先筛局部候选再做原精确碰撞。最终回执要求专用绑定和护盾的配对宿主CPU测量不退步。保留战斗数量、伤害、掉落和顺序，不将水域查询回退描述为新的提速。',[F,R,B,P+'scrHMSync1103Performance/scrHMSync1103Performance.gml'],['sync115water','sync115waterprofile','sync115shield']),
 (8,'玩家增强设置使用清晰中文。','多行显示玩家增强、生命上限+2、等级上限+1，沿用已有中文字库。',[P+'scrHMMobile/scrHMMobile.gml','localization/zh-CN.json'],['hunter114menu']),
 (9,'Loop2第二次终极变异增加取消选项并使用耐心图标。','取消仅消耗本局追加选择资格，不授予变异，不延迟到下关；保存/继续、联机及特殊角色仍正确处理。',[U,'project/objects/UltraIcon/Draw_0.gml','project/objects/UltraIcon/Other_10.gml'],['sync113ultracancel','sync113ultracancelsave','sync113ultracancelpending','sync113ultracancelhorror','sync113ultracancelyv','sync113ultracancelcoop']),
 (10,'额外大匪和丛林大匪不触发首领演出。','构造、原生事件以及延后绑定的镜头都识别额外首领身份。',[E,A],['extra1115bandit','extra1115jungle']),
 (11,'额外超级水晶正常行动。','恢复包装实例的原生旋转/移动事件，并适配30Hz逻辑和60Hz宿主运动。',[E,A],['extra1115crystal']),
 (12,'额外诅咒超级水晶正常行动和瞬移。','恢复移动，并将侧向瞬移限制到验证过的空地位置。',[E,A],['extra1115cursed']),
 (13,'额外小猎人死亡后保留飞行和自爆。','创建真正的原生最后遗愿残骸，保留基础三次爆炸且不触发正常首领演出。',[A],['extra1115hunter']),
 (14,'HQ的死灵法师、科技术士和IDPD freak保留Loop3门槛。','警局专属的追加种群不随普通区域前移到Loop1。',[R,A,P+'scrHMSync1103Spawn/scrHMSync1103Spawn.gml'],['sync115policy','followup113allareas']),
 (15,'替换局长也能召唤IDPD传送门。','在局长原生召唤事件调用普通动画门；入场演出阶段仍禁止攻击。',[R,'project/objects/Last/Alarm_5.gml'],['chief1115first','chief1115repeat','sync115replacementchief','sync115idpdgate']),
 (16,'局长及金星最终首领最终死亡掉落三个弹药包或医疗包。','奖励在最终死亡发放，重复死亡回调不能重发，直升机的非致命换阶段不发放。',[R,A,N],['sync115supplies']),
 (17,'正常小猎人数量固定为1+floor(Loop/2)。','一间房只预留一次生成计划；飞行换对象、切角色和已死亡均不能重复扩增。',[B,A],['hunter115count']),
 (18,'正常多首领全部到齐才统一入场，全部死亡才统一退场。','房间账本记录待到达和存活成员；替换删除会退休旧组，额外首领排除在演出组外。',[B,P+'scrHMCompiled_bosses_bossintros_mod_gml/scrHMCompiled_bosses_bossintros_mod_gml.gml'],['group115hunter','group115bubbler','group115crystal','group115replace','sync115replacementchief','sync115replacementgungod']),
 (19,'Throne不能误用水下状态。','生成新房和切换区域时清理过期水域缓存及玩家游泳显示状态。',[F,'project/objects/GenCont/Create_0.gml'],['sync115environment','sync115throne']),
 (20,'王座II存活时玩家只能在地板平台上行走。','以仍存在的Floor平台限制位置，第二阶段死亡后释放限制给原结尾动画。',[R,'project/objects/Player/Step_2.gml'],['sync115throne']),
 (21,'修复Player.sprite_angle未初始化崩溃。','玩家创建及结尾启用处初始化旋转字段，不依赖测试或旧存档提前赋值。',['project/objects/Player/Create_0.gml',P+'scrHMCompiled_bosses_throne_mod_gml/scrHMCompiled_bosses_throne_mod_gml.gml'],['sync115throne']),
 (22,'减少绿洲纯显示泡泡开销。','只限制环境泡泡的屏幕可见创建预算和存活上限，保留后续随机序列以及战斗实体。',[F,P+'scrHMCompiled_maincode_mod_gml/scrHMCompiled_maincode_mod_gml.gml'],['sync115bubbles']),
 (23,'王座II结尾恢复原版旋转下落。','保留完整大小和可见身体，每逻辑帧按原方式下落并旋转，不替换为传送门缩小。',[P+'scrHMCompiled_maincode_mod_gml/scrHMCompiled_maincode_mod_gml.gml',R],['sync115throne']),
 (24,'首领演出期间及结束后两秒玩家免伤。','只在实际演出激活保护，结束后保留60逻辑帧伤害保护，不延长控制冻结。',[B,P+'scrHMRepairs104/scrHMRepairs104.gml',P+'scr_hit/scr_hit.gml',P+'scrBossIntro/scrBossIntro.gml','project/objects/UberCont/Alarm_2.gml'],['group115hunter','group115bubbler','group115crystal','messenger115short']),
 (25,'Loop1起1-3普通大匪有50%几率替换为丛林大匪。','将普通沙漠关底替换门槛前移，额外种群仍独立。',[A],['sync115stagebandit','sync115policy','followup113allareas']),
 (26,'金星最终首领免疫自己发射的火箭。','用不可被反射改写的原发射者标记传递到爆炸及子爆炸，普通玩家攻击仍有效；保留大鸟同样的修复。',[E,'project/objects/JockRocket/Destroy_0.gml','project/objects/Explosion/Alarm_1.gml',P+'scr_hit/scr_hit.gml',P+'scr_can_hit/scr_can_hit.gml'],['rocket1115gungod','rocket1115bird']),
 (27,'对照Y.V机枪转速和逻辑计时。','保持原始逐发角度步进与30Hz逻辑计时，验证自然发射90发的间隔和转角，不声称未经验证的桌面倍率。',['project/objects/YVBoss/Alarm_1.gml','project/objects/YVBoss/Step_0.gml',A],['yv1115minigun','sync115phasehealth']),
 (28,'额外诅咒超级水晶召唤诅咒/闪电水晶。','在普通区域也根据额外首领种类选择诅咒召唤表。',[E,'project/objects/HyperCrystal/Alarm_1.gml'],['extra1115cursed']),
 (29,'Y.V第二阶段采用当前Loop自身血量。','不再继承被替换阶段的150血量，保留当前Loop、玩家数和凶恶面容的正常缩放。',[A,N,S],['sync115phasehealth']),
 (30,'局长和金星最终首领不掉辐射，包含融化角色追加点数。','在统一辐射掉落入口排除这些首领，普通敌人仍正常掉落。',[T,P+'scrRadDrop/scrRadDrop.gml'],['sync115supplies']),
 (31,'替换关底首领的金星第一阶段战斗血量增加50%。','只缩放可伤害的直升机战斗预算，不缩放14250阶段切换哨兵；正常金星遭遇不受此替换加成。',[T,R],['sync115replacementgungod','sync115phasehealth']),
 (32,'通信员从Loop3起使用IDPD freak特效自动复活。','使用真实原生计时和15帧复活区域特效，复活后保留武器、血条及身份。遵守第34项的新偏好。',[S,'project/objects/WantRevivePopoFreak/Alarm_0.gml','project/objects/RevivePopoFreak/Alarm_0.gml','project/objects/enemy/Destroy_0.gml'],['messenger115short','messenger115natural']),
 (33,'局长死亡时仅生成一次IDPD爆炸。','死亡锁防止多次回调重复生成爆炸，保留纯动画退场门和独立最终奖励。',[R],['sync115supplies']),
 (34,'通信员自动复活间隔为Freak两倍，复活时可以有出场演出。','读取原生800逻辑帧间隔并乘二，之后播放原生15帧特效；如Freak一样可重复复活但出口开启即取消。长等待不阻挡清关，15帧复活过程阻挡清关，普通复活可入场、额外首领仍不演出。',[S,B,P+'scrHMRepairs103/scrHMRepairs103.gml'],['messenger115short','messenger115natural']),
 (35,'局长入场遵守桌面传送流程且不重复拳击。','先完成传送，再完成立绘/镜头，释放后才启用行动及攻击定时器。',[R,'project/objects/Last/Alarm_1.gml','project/objects/Last/Alarm_4.gml'],['chief1115first','chief1115repeat','sync115replacementchief']),
]

def coverage():
    return dict(version='1.1.5',build=19,target='Hardmode mobile only',
        status='source-covered; final same-VM verification required',
        evidence_rule='Only release1105/delivery-receipt.json may establish final host/package acceptance.',
        latest_preferences={'messenger':'Loop3; 2x native Freak timer; repeatable until exit; normal auto-revival may present; extras do not present',
                            'hq':'named late population remains Loop3',
                            'chief_speed':'explicit mobile +5 percent/Loop, capped 2x; not asserted as an original desktop constant'},
        retained_requirements=['1.1.4 Throne 120-tile wall carve stays disconnected',
            'Chinese boss bars remain in GUI End, Great Guardian bar/projectile layering retained',
            'No imported Grillskills: preserve the mobile mutation UI',
            'No NTTE/NTUF or installed desktop MOD edits'],
        items=[dict(item=n,request=request,implementation=implementation,sources=sources,modes=modes,
                    status='requires-final-receipt') for n,request,implementation,sources,modes in SCOPE])

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--final',action='store_true');args=parser.parse_args()
    plan=importlib.import_module('release1105_test_plan')
    from release_config import VERSION,BUILD
    assert (VERSION,BUILD)==('1.1.5',19)
    status='草案：最终源码、同一VM完整计划、视觉复核及APK/IPA验收尚待最终交付回执确认。'
    if args.final:
        receipt=json.loads((OUT/'delivery-receipt.json').read_text('utf-8'))
        assert (receipt['status'],receipt['version'],receipt['build'])==('PASS',VERSION,BUILD)
        assert {row['scenario'] for row in receipt['runtime_cases']}==set(plan.ALL)
        status=f'最终交付回执记录 {len(plan.ALL)} 个同一VM场景、{int(receipt["checks"])} 项断言通过。'
    OUT.mkdir(exist_ok=True)
    (OUT/'scope-coverage.json').write_text(json.dumps(coverage(),ensure_ascii=False,indent=2)+'\n','utf-8')
    rows=['# Hardmode 手机版 1.1.5（build 19）','',
        '本轮只修改 Hardmode 移植版；保留包名、签名、存档、触屏和手机版自带变异界面。NTTE＋NTUF及已安装的NTT模组版不在此次更改范围。','',status,'']
    rows.extend(f'{n}. {request} {implementation}' for n,request,implementation,_,_ in SCOPE)
    rows.extend(['','继续保留1.1.4的王座额外120格拆墙删除、GUI End首领血条、全部首领名称汉化、至高守护者弹幕层级、宫殿B面衔接、毒蛙辐射蛆虫排除及箭矢撞墙固定等修复。','',
        '验证范围：完全静音、独立存档、未激活的私有Windows桌面宿主VM，运行30/60帧定向与路线回归；手机安装包另做资源、签名/原生兼容性和存档路径检查。主机测量不等于安卓/iPhone真机验收，也不保证高Loop恒定60帧。iOS使用兼容的既有原生Runner，需要自行重签，本轮没有新Mac原生构建。',''])
    fixes='\n'.join(rows)
    (ROOT/'docs').mkdir(exist_ok=True)
    (ROOT/'docs/FIXES.md').write_text(fixes,'utf-8')
    (OUT/'FIXES.md').write_text(fixes,'utf-8')
    install='''# 安装 Hardmode 1.1.5

安卓使用 NuclearThrone.Hardmode-Android-1.1.5.apk；包名仍为 com.arkintide.nuclearthronehardmode，可覆盖同签名旧版。安装前保留自己的存档备份。共享存档为 /storage/emulated/0/games/com.arkintide.nuclearthronehardmode/；未取得共享存储权限时使用应用原私有目录。

iOS使用 NuclearThrone.Hardmode-iOS-1.1.5.ipa，需要自行重签。保留可共享的 Documents/hardmode/ 存档目录。IPA使用本轮新编译VM/资源与已核对兼容的既有原生Runner；没有本轮手机真机或新Mac原生构建验收。

本地包在 deliverables/，校验信息在 release1105/delivery-receipt.json 与发布目录 SHA256SUMS。安装包放在Hardmode专用MEGA目录，GitHub仅发布文本源码和工程元数据。上传完成情况以最终发布记录为准。
'''
    (ROOT/'docs/INSTALL.md').write_text(install,'utf-8');(OUT/'INSTALL.md').write_text(install,'utf-8')
    readme=f'''# Hardmode Mobile Port 1.1.5

Hardmode手机移植版，build19。本轮35项更改见 [修复记录](docs/FIXES.md)，安装方法见 [安装说明](docs/INSTALL.md)。

{status}

保留原有包名、签名身份、存档和手机版变异选择界面。此仓库发布文本源码及工程元数据；安装包通过Hardmode专用MEGA目录发布。

测试使用静音隔离的桌面宿主VM，未进行安卓/iPhone真机验收，不保证恒定60帧。iOS IPA需重签，采用兼容的既有原生Runner及新VM/资源。
'''
    for name in ('README.md','README.zh-CN.md'):
        (ROOT/name).write_text(readme,'utf-8');(OUT/name).write_text(readme,'utf-8')
    building='''# Build and maintenance

The maintained project is project/nuclearthronemobile.yyp. Supply original Epsilon/Hardmode assets, compatible GameMaker tools, native runners and signing material separately. The source-only GitHub publication excludes proprietary binary resources and private signing material. Do not rerun historical full importers over the maintained project.

Version 1.1.5/build19 covers the35 human followups in docs/scope-1.1.5.json (maintained locally as release1105/scope-coverage.json). The targeted integrate_1115_* and integrate_1105_performance.py transforms preserve prior repairs. Run the Messenger and boss-group integrations after historical generators; production helpers/tests use existing registered assets and register_1115.py. Preserve mobile mutation selection; do not import Grillskills.

Build the Windows host with build_checked1105.py; it records unchanged compiler inputs, the build log and exact output VM. release1105_test_plan.py is the authoritative dynamic test plan; run it in the private silent harness. Every receipt must match the current complete Windows VM hash. Preliminary builds and 1.1.4 receipts do not count. Run the static performance audit and review actual output images, then freeze_source.py final --directory release1105. Keep the frozen manifest and exact final-code.zip.

Compile fresh Android/iOS resources, prepare fonts, assemble and validate the offline signed APK and retained-runner IPA using the current release build scripts. make_release1105_receipt.py checks frozen source, all planned same-VM results, strict function-level compiled call edges, reviewed PNG hashes, platform audits, fresh resource ZIPs and both actual package inventories. It never builds or uploads. Run write_release1105_docs.py --final only after that gate passes.

Only a passing matching delivery receipt permits publication. Use the Hardmode source-only GitHub flow and dedicated MEGA upload queue; retain full download-readback SHA256 verification. Android signing continuity, public save directory and iOS Documents/hardmode sharing are retained. iOS requires re-signing. These are host-VM/resource checks, not physical-device acceptance; no universal high-Loop60FPS or newMac native-build claim is made.

Use a Python runtime containing Pillow. On this machine: C:/Users/ArkinTide/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe. A packages-only workflow may reuse resource ZIPs only when their current frozen-source binding and hashes still verify.
'''
    (ROOT/'BUILDING.md').write_text(building,'utf-8');(OUT/'BUILDING.md').write_text(building,'utf-8')
    notes='\n'.join(['# Hardmode 1.1.5 / build19','',status,'',
        '修复局长及金星首领替换/阶段行为、首领成组演出、小猎人重复生成、额外首领行动和王座平台/结尾问题；加入通信员按Freak规则的延后自动复活，优化大量弹幕护盾查询并限制绿洲环境泡泡。下水道保留实测更快的已发布版水域查询，使用专用绘制绑定缓存减少入水实体重复开销，修复跨关卡水域状态。配对宿主CPU收益以最终回执为准。','',
        '首领演出期间及结束后两秒保护玩家；Loop2追加终极变异可取消。普通区域指定敌人提前到Loop1，HQ指定追加敌人保持Loop3。完整35项和保留修复见FIXES.md。','',
        '局长移速/动作采用手机版明确的每Loop+5%、最高2倍策略；该倍率不宣称来自未经证实的桌面常量。','',
        '静音隔离桌面VM测试不等于手机真机测试，也不保证高Loop恒定60帧。IPA需要重签，未执行新Mac原生构建。',''])
    (OUT/'RELEASE-NOTES.md').write_text(notes,'utf-8')
    print('Wrote1.1.5', 'final' if args.final else 'draft','documents; planned',len(plan.ALL),'cases')

if __name__=='__main__':main()
