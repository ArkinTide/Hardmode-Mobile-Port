"""Write the mobile delivery documents from the current verification receipt."""
from pathlib import Path
import json
from release_config import VERSION,BUILD,DIRECTORY
ROOT=Path(__file__).resolve().parent
OUT=ROOT/DIRECTORY

def main():
    r=json.loads((OUT/'delivery-receipt.json').read_text(encoding='utf8'))
    assert r['status']=='PASS' and (VERSION,BUILD)==('1.0.10',11)
    summary=f"同一最终桌面VM通过30／60帧{r['gameplay_cases']}项定向游戏场景、{int(r['gameplay_assertions'])}项游戏断言、{int(r['native_assertions'])}项底层检查和{int(r['menu_assertions'])}项菜单／语言断言。"
    fixes='''# Hardmode 1.0.10 修复与新增

| 项目 | 实现与针对性验证 |
|---|---|
| 墙壁颜色 | 纯色外墙采用NTTE共用区域的背景色；区域特有贴图采用其背景色。保留原碰撞块、掩码、边缘与过渡层。walls110检查16色及实际深墙碰撞。 |
| 王座偶发缺失 | 生成清理结束后定稿唯一初始王座，规范唯一地板标记，并同时纠正位置与原生Step重置坐标。已存在战斗／死亡阶段时不重新生成。throne110覆盖自然生成、重复标记、错位既存王座、缺失补回；另跑两阶段实际王座流程。未声称精确复现所有用户偶发现象。 |
| 7-4进入皇冠密室误到王座 | 入口携带明确目的地，优先于主线区域转场；不在开祭坛时提前改当前区域，密室退出后再返回主线。vault110执行实际Portal事件及RoomEnd／RoomStart往返，确认进入密室、返回王座和访问次数。altar109保留原三次上限。 |
| 三种Boss循环数量 | 超级鳄鱼、巨鸟、小猎人按1+floor(loop/2)生成：loop0/1一只、2/3两只、4/5三只。实际自然生成路径覆盖边界。多只巨鸟仍共享一只Boss的原有渡鸦召唤预算。 |
| loop地图扩大 | 随机地图按原区域地板预算，每loop增加20%，loop5及以后最多两倍。首次FloorMaker创建前一次性设置，不对现有地图或碰撞做缩放；王座、金星、密室等固定布局保留自身规则。maps110检查预算、真实地板完成量与可用出生点，覆盖30／60帧和多个seed。此幅度为本次Hardmode适配方案；本地Epsilon未提供统一loop地板增长公式，不将其声称为原版精确数值。 |
| Windows滚轮换枪 | 键鼠模式读取滚轮上下并合并到原换枪输入；暂停、输入阻塞、控制台、设置和演出期间不触发。windows110以合成滚轮样本执行真实Player Step，30／60帧各18断言。没有宣称真实鼠标自动化验证。移动版发布后再生成可运行EXE与资源组成的便携ZIP。 |

测试全程静音。素材像素／音频未改；原版7231文件核验未改。独立包名、存档格式GAME_BUILD3004、安卓共享存档及iOS Documents分享保留。没有手机真机或本轮Mac原生重建验收；IPA沿用兼容runner和新VM／资源，需要重签。Android离线lint依赖不足，另行通过签名、资源和16K对齐检查。
'''
    (OUT/'FIXES.md').write_text(fixes,encoding='utf8')
    artifacts={Path(a['path']).suffix:a for a in r['artifacts']}
    install=f'''# Hardmode {VERSION} / build {BUILD}

Android：NuclearThrone.Hardmode-Android-{VERSION}.apk，保持旧签名，可覆盖更新。
iOS：NuclearThrone.Hardmode-iOS-{VERSION}.ipa，需要重签。

安卓共享存档：/storage/emulated/0/games/com.arkintide.nuclearthronehardmode/，需存储授权；不可写时回退原私有目录。iOS：Documents/hardmode/，开启文件共享。更新前请备份存档。

{summary}

无手机真机或新Mac原生重建验证。APK SHA256：{artifacts['.apk']['sha256']}。
IPA SHA256：{artifacts['.ipa']['sha256']}。

Hardmode下载：https://mega.nz/folder/7TY3wZRB#PgQeCYQzxvrVGjfjX6YefA
GitHub仅纯源码：https://github.com/ArkinTide/Hardmode-Mobile-Port
云端状态以publication-receipt.json为准。
'''
    (OUT/'INSTALL.md').write_text(install,encoding='utf8')
    (ROOT/'deliverables'/f'Hardmode-{VERSION}-安装说明.md').write_text(install,encoding='utf8')
    (OUT/'DELIVERY.md').write_text(f'# Hardmode {VERSION}\n\n交付核验PASS。\n\n{summary}\n\nVM：{r["final_desktop_vm_sha256"]}。\n\n详见FIXES.md、INSTALL.md、delivery-receipt.json；云端结果见publication-receipt.json。\n',encoding='utf8')
    print('1.0.10 mobile delivery documents written')
if __name__=='__main__':main()
