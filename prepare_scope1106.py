"""Write the explicit current user scope; this is not an acceptance receipt."""
from pathlib import Path
import json
from release_config import VERSION,BUILD

ROOT=Path(__file__).resolve().parent
P='project/scripts/'
def script(name):return P+name+'/'+name+'.gml'
POLICY=script('scrHMRepairs1116Policy')
RUNTIME=script('scrHMRepairs1116Runtime')
REPAIRS=script('scrHMRepairs1102')
EXTRA=script('scrHMCompiled_arkintide_mod_gml')
ITEMS=[
 (1,'Loop3之前不生成IDPD Freak、不复活警察、不让停下的警车自爆，坦克不掉辐射。',
  '分开普通Loop1新增敌人与Loop3警察规则；在原生出兵、死亡、复活、警车和辐射路径应用门槛，保留较早Loop的普通警察批次出兵。',
  [POLICY,REPAIRS,'project/objects/IDPDSpawn/Alarm_1.gml',script('scrRadDrop')],['policy116gates','van107','revive107','sync115idpdgate']),
 (2,'按电脑版和视频修正局长的Loop后行动节奏。',
  '核对桌面原生Last和模组包装事件，移除前版未获原始代码支持的额外速度倍率；保留原生动作与低血冷却，修正整个游戏负载下的时间步进。',
  [REPAIRS,'project/objects/Last/Step_0.gml',RUNTIME],['chief1115first','chief1115repeat','budget116']),
 (3,'按电脑版原版修正Y.V迷你机枪转向。',
  '按原生剩余弹数使用前段半度、后段一度转向和70+30×Loop初始弹药预算；保留每逻辑帧Loop+1发及完整末批，Loop2预算130发时实际共发射132发。',
  ['project/objects/YVBoss/Alarm_1.gml','project/objects/YVBoss/Alarm_2.gml'],['yv1115minigun']),
 (4,'替换关底首领的金星最终首领正确显示立绘。',
  '使用真实原生首领立绘请求，并将其附着到同一个入场镜头控制器。',
  [REPAIRS,POLICY],['policy116portrait','policy116native','policy116lateart']),
 (5,'修复高Loop负载下游戏速度变慢。',
  '减少重复绘制深度迁移和全图地板遍历；持续过载时暂时改为原生30Hz渲染及完整逻辑步，保留用户60帧设置并在恢复后回切。',
  [RUNTIME,script('scrHMUI1104'),'project/objects/UberCont/Step_0.gml'],['budget116','floors116','guardian116','sync115waterprofile']),
 (6,'自定义中加入Hardmode武器。',
  '增加独立的本地化Hardmode武器组，保留槽位、当前选择和存档兼容。',
  ['project/objects/CustomModeWeaponSelector/Create_0.gml','project/objects/CustomModeWeaponSelector/Other_11.gml'],['custom116']),
 (7,'首领立绘和入场镜头同时开始。',
  '原生立绘与自定义镜头共享控制器，延迟到达的请求不重启镜头或截断立绘。',
  [POLICY,REPAIRS],['policy116native','policy116lateart','policy116portrait']),
 (8,'1-5延续1-4沙漠sideB音乐。',
  '房间切换保留sideB现有播放句柄与进度，后续首领音乐不被反复覆盖。',
  [RUNTIME,script('scrHMRepairs112')],['music116']),
 (9,'修复Throne最终传送门下落时角色闪烁和姿势。',
  '下落使用真实进入传送门的角色与武器绘制，保持可见并保留原生位移和旋转。',
  [script('scrHMRepairs107'),'project/objects/Player/Draw_0.gml','project/objects/Player/Step_2.gml'],['throne116','sync115throne']),
 (10,'修复1-3丛林大匪50%替换。',
  '在真正原生Create时只抽签一次，并让原生Draw使用选中的丛林贴图。',
  [EXTRA,POLICY,'project/objects/BanditBoss/Create_0.gml','project/objects/BanditBoss/Draw_0.gml'],['policy116stage','sync115stagebandit']),
 (11,'Loop后沙漠和丛林加入雪地小匪。',
  '从Loop1起添加有武器、无睡眠的雪地小匪，并限制新增数量。',
  [script('scrHMSync1103Spawn'),POLICY],['policy116population']),
 (12,'额外首领只从Loop3开始。',
  '同时保护自然种群入口与底层额外首领工厂，Loop0至2均不会生成。',
  [script('scrHMSync1103Spawn'),EXTRA],['policy116population','sync115policy']),
 (13,'修复至高守护者出现后的严重卡顿。',
  '缓存黑幕绑定，只提升新出现或深度发生外部变化的对象，黑幕结束时恢复一次。',
  [script('scrHMUI1104'),script('scrHMWorld')],['guardian116','guardian116fire']),
 (14,'全面检查至高守护者与重型自动十字弩等多种武器的性能。',
  '以840个真实伤害源配对测量层级开销，并用六类真实武器射击验证弹幕可见和战斗持续。',
  [script('scrHMUI1104'),script('scrHMWorld')],['guardian116','guardian116fire','fix114guardian']),
 (15,'至高守护者不播放入场和死亡镜头。',
  '保留其立绘与战斗，排除入场及退场镜头控制。',
  [POLICY,REPAIRS],['policy116guardian']),
 (16,'修复首领入场和死亡镜头焦点。',
  '跟踪存活目标位置，并在真实Destroy事件捕获死亡点，避免使用初始出生地板。',
  [POLICY,REPAIRS],['policy116camera','policy116native']),
 (17,'恢复巨犬弹幕弹射与入场睁眼动画。',
  '接通原生发射事件的弹射设置，并在原生入场状态播放睁眼资源。',
  ['project/objects/ScrapBoss/Alarm_1.gml','project/objects/ScrapBoss/Create_0.gml'],['boss1116','policy116deaths']),
 (18,'修复额外诅咒超级水晶瞬移及子水晶类型。',
  '跨原生事件桥保留变体身份，按身份召唤诅咒或闪电水晶，狭窄地图使用有效碰撞位置。',
  [EXTRA,POLICY,'project/objects/HyperCrystal/Alarm_1.gml'],['policy116crystals','extra1115cursed']),
 (19,'修复两种额外超级水晶的影子位置。',
  '对齐诅咒贴图原点与原生本体，并保留原生地面影子锚点。',
  [POLICY,EXTRA],['policy116crystals']),
 (20,'额外诅咒超级水晶使用正确名称和颜色的血条。',
  '额外血条按每只首领的持久变体身份取得名称和颜色。',
  [POLICY,script('scrHMCompiled_hm_bossbar_mod_gml')],['policy116crystals']),
 (21,'关底诅咒超级水晶死亡后让远处洞窟也完成变色。',
  '将转换任务交给稳定世界对象；最终完成所有地板和墙面调色且保留碰撞几何。',
  [script('scrHMRepairs103'),script('scrHMRepairs112'),script('scrHMWorld'),script('scrHMCompiled_maincode_mod_gml')],['cave116stage']),
 (22,'额外诅咒超级水晶死亡不能让洞窟变色。',
  '在死亡回调安排时捕获额外身份，即使创建者已销毁也不会误转入关底转换。',
  [script('scrHMWorld'),script('scrHMCompiled_maincode_mod_gml')],['cave116extra']),
 (23,'通信员免疫自己的爆炸。',
  '贯通实际爆炸和连锁来源标记，只排除自身伤害并保留其他来源伤害。',
  [script('scrHMSync1103Bosses'),script('scrHMCompiled_enemies_mod_gml')],['sync113messenger','boss1116']),
 (24,'金星最终首领的火箭不发生连锁爆炸。',
  '保留火箭的真实来源，排除爆炸引发的提前连锁引爆，保留直接命中和碰墙爆炸。',
  ['project/objects/JockRocket/Destroy_0.gml','project/objects/Rocket/Collision_Explosion.gml'],['boss1116','rocket1115gungod']),
 (25,'修复许多敌人死亡后尸体不变灰。',
  '区分原生已暗化尸体与复用明亮角色死亡图的敌人，保留死亡及复活动画后再使用敌人专用静止灰帧。',
  ['project/objects/Corpse/Other_7.gml',script('scrHMRepairs112')],['corpse116']),
 (26,'修复许多额外首领没有死亡动画。',
  '恢复各个额外首领家族本体的死亡动画、残骸和原生过渡对象，同时不触发首领镜头或音乐。',
  [POLICY,EXTRA,'project/objects/enemy/Destroy_0.gml'],['policy116deaths','policy116deathsrest','policy116turtledeaths']),
]


def main():
    assert (VERSION,BUILD)==('1.1.6',20)
    rows=[dict(item=n,request=request,implementation=implementation,sources=sources,
        modes=modes,status='requires-final-receipt') for n,request,implementation,sources,modes in ITEMS]
    out=ROOT/'release1106';out.mkdir(exist_ok=True)
    payload=dict(version=VERSION,build=BUILD,target='Hardmode mobile only',
        status='source-covered; final same-VM verification required',
        evidence_rule='Only release1106/delivery-receipt.json establishes final host/package acceptance.',
        items=rows,retained_requirements=['No NTTE/NTUF or installed desktop MOD edits.',
        'No Grillskills; preserve native mobile mutation selection.',
        'Preserve application identity, Android signing and existing save paths.'])
    (out/'scope-coverage.json').write_text(json.dumps(payload,ensure_ascii=False,indent=2)+'\n','utf8')
    print('Recorded26 user items; final acceptance remains required')


if __name__=='__main__':main()
