"""Record the nine current requests without declaring test acceptance."""
from pathlib import Path
import json
from release_config import VERSION,BUILD

ROOT=Path(__file__).resolve().parent
ITEMS=[
    (1,'自动降帧后恢复玩家速度。','切换回调频率时统一转换已经存在的实体物理速度及暂停、演出缓存。',
     ['native/clock1117.gml'],['clock117travel','clock117freeze','clock117pause']),
    (2,'旧弹幕与新弹幕保持相同世界速度。','仅转换物理字段，保留Hardmode逻辑常量、逻辑余量及原生Alarm补偿相位；原生Rocket/JockRocket每个逻辑tick的加速冲量按物理回调单位换算。',
     ['native/clock1117.gml','project/objects/Rocket/Step_0.gml'],['clock117travel','clock117cache','clock117phase','clock117powered']),
    (3,'保留局长的Loop后加强。','原生技能行动照常运行；Loop1起缩短技能结束后的决策等待，保留低血加速。',
     ['native/chief1117.gml','project/objects/Last/Alarm_5.gml'],['chief117full','chief117half']),
    (4,'低帧时首领演出保持正确时长。','使用独立演出时钟，避免过载让演出按慢动作播放。',
     ['native/clock1117.gml','native/repairs104.gml'],['presentation117timing','presentation117timing20']),
    (5,'金星最终首领转阶段仅播放二阶段入场。','第一阶段退场与转阶段产生的重复镜头由真实阶段切换路径抑制。',
     ['native/repairs1102.gml','native/repairs1115_root.gml','native/repairs109.gml'],['presentation117phase']),
    (6,'视频中增加默认开启的自动降帧开关。','在视频设置中保存开关；关闭后按玩家所选帧率运行。',
     ['native/clock1117.gml'],['clock117option']),
    (7,'所有首领立绘名称中文化。','原生及自定义首领立绘使用中文名称，并保留Y.V。',
     ['native/repairs1116_policy.gml'],['presentation117titles']),
    (8,'局长在Loop后缩短技能间隔。','本轮授权新增等待倍率0.8；不将其称为已验证的电脑版公式。',
     ['native/chief1117.gml','project/objects/Last/Alarm_5.gml'],['chief117full','chief117half']),
    (9,'无论有无Last Wish，洞窟末关只保留一个尸花并铺设丛林地板。','在实际props工厂生成尸花时统一检查单例并铺设周围丛林地板；保证入口与原生Last Wish挖掘共用同一个尸花。',
     ['native/repairs1116_policy.gml','native/compiled_arkintide1103.gml',
      'project/scripts/scrHMCompiled_props_mod_gml/scrHMCompiled_props_mod_gml.gml'],['presentation117flowerplain','presentation117flowerwish']),
]

def main():
    assert (VERSION,BUILD)==('1.1.7',21)
    rows=[dict(item=n,request=request,implementation=implementation,sources=sources,
        modes=modes,status='requires-final-receipt') for n,request,implementation,sources,modes in ITEMS]
    out=ROOT/'release1107';out.mkdir(exist_ok=True)
    payload=dict(version=VERSION,build=BUILD,target='Hardmode mobile only',
        status='source scope; final same-VM and package verification required',
        evidence_rule='Only release1107/delivery-receipt.json establishes current acceptance.',
        pending_items=[row['item'] for row in rows if not row['sources'] or not row['modes']],
        items=rows,retained_requirements=['Preserve package name, signing identity and save paths.',
            'Do not modify the installed desktop MOD or NTTE/NTUF.',
            'Keep old release receipts as provenance only; compile fresh host/mobile game resources.'])
    (out/'scope-coverage.json').write_text(json.dumps(payload,ensure_ascii=False,indent=2)+'\n','utf8')
    print('Recorded nine requests; incomplete fixture bindings:',payload['pending_items'])

if __name__=='__main__':main()
