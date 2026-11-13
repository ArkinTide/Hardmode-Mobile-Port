"""Write release documentation from the verified current delivery receipt."""
from pathlib import Path
import json
from release_config import VERSION,BUILD

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release1106'


def main():
    delivery=json.loads((OUT/'delivery-receipt.json').read_text('utf8'))
    scope=json.loads((OUT/'scope-coverage.json').read_text('utf8'))
    assert (VERSION,BUILD)==('1.1.6',20)
    assert delivery['status']=='PASS' and delivery['version']==VERSION and delivery['user_items']==26
    checks=int(delivery['checks']);cases=delivery['total_cases']
    (OUT/'README.zh-CN.md').write_text(f'''# Hardmode Mobile Port {VERSION}

Hardmode 手机移植版，build {BUILD}。本轮26项修改见[修复记录](docs/FIXES.md)，安装方法见[安装说明](docs/INSTALL.md)。

最终交付核验通过 {cases} 个同一 VM 场景、{checks} 项断言。

保留包名、Android签名身份、存档路径和手机版变异选择界面。仓库发布文本源码与工程元数据；APK与IPA通过Hardmode专用MEGA目录发布。

测试使用静音隔离的Windows宿主VM，未进行安卓或iPhone真机验收。持续负载过高时会暂时降低渲染至原生30Hz以维持正常游戏速度，负载恢复后再恢复用户60帧设置；不保证所有设备恒定60帧。iOS IPA需重签，使用兼容既有原生Runner和新VM、资源。
''','utf8')
    (OUT/'README.md').write_text(f'''# Hardmode Mobile Port {VERSION}

Mobile adaptation of Hardmode b24, build {BUILD}. See [fixes](docs/FIXES.md) and [installation](docs/INSTALL.md).

Final acceptance: {cases} scenarios and {checks} assertions on one source-bound VM. This repository contains text source and project metadata; installers are distributed through the existing Hardmode MEGA folder.

The package identity, Android signing identity and save paths are preserved. Native mobile mutation selection is retained. No NTTE/NTUF or desktop MOD is changed.

Validation uses a silent isolated Windows host VM, not physical Android/iPhone devices. Sustained overload may temporarily render at the native30Hz rate to retain simulation speed and restore the saved60FPS preference after recovery. No universal60FPS guarantee is made. The IPA retains a compatible native runner with fresh VM/resources and requires re-signing.
''','utf8')
    fixes=[f'# Hardmode {VERSION} / build {BUILD}',
           f'本轮26项修复已通过同一源码绑定VM的 {cases} 个场景、{checks} 项断言，并核验两端实际安装包。']
    for item in scope['items']:
        fixes.append(f"{item['item']}. {item['request']} {item['implementation']}")
    fixes += ['局长参考说明：本次检查桌面原生Last与Hardmode包装代码时，未验证到额外Loop速度倍率；保留原生低血冷却加速，移除前版猜测倍率，整体负载慢速由时间步进修复处理。',
              '验证边界：静音隔离宿主测试与配对CPU测量，未进行安卓/iPhone真机验收；不会把宿主CPU耗时换算成手机帧率保证。']
    (OUT/'FIXES.md').write_text('\n\n'.join(fixes)+'\n','utf8')
    (OUT/'INSTALL.md').write_text(f'''# Hardmode {VERSION} 安装

Android：安装 `NuclearThrone.Hardmode-Android-{VERSION}.apk`，可覆盖同签名旧版并保留存档。

iOS：使用你的签名工具重签 `NuclearThrone.Hardmode-iOS-{VERSION}.ipa` 后安装。保留相同应用标识以沿用原有存档。

安装包使用现有Hardmode专用MEGA发布目录。GitHub发布源码与安装说明，不附带安装包资源。
''','utf8')
    (OUT/'RELEASE-NOTES.md').write_text(f'''# Hardmode {VERSION} / build {BUILD}

修复额外首领死亡动画、诅咒超级水晶、局长及Y.V原生动作、巨犬开眼与弹射、首领镜头和立绘、Throne传送门姿势、自定义Hardmode武器及敌人尸体灰化。

保留Loop3警察强化与额外首领门槛；减少至高守护者弹幕场景的重复层级处理，并在持续过载时暂时使用原生30Hz渲染以维持游戏速度。

通过 {cases} 个同一源码绑定VM场景、{checks} 项断言及两端实际包核验。未进行手机真机验收；不保证所有设备恒定60帧。IPA需重签。

安装包与校验文件：[Hardmode MEGA目录](https://mega.nz/folder/7TY3wZRB#PgQeCYQzxvrVGjfjX6YefA)。原有版本保留。
''','utf8')
    (OUT/'BUILDING.md').write_text('''# Build and maintenance

The maintained project is project/nuclearthronemobile.yyp. Supply original Epsilon/Hardmode assets, compatible GameMaker tools, native runners and signing material separately. The source-only GitHub publication excludes proprietary binary resources and private signing material. Do not rerun historical full importers over the maintained project.

Version 1.1.6/build20 covers the26 requests in docs/scope-1.1.6.json (maintained locally as release1106/scope-coverage.json). The current incremental helpers are native/runtime1116.gml and native/repairs1116_policy.gml, alongside the retained repairs. prepare_tools1116.py registers their resources before compilation. Existing object events and maintained project scripts also contain current repairs; do not replace them with historical generated output. Preserve native mobile mutation selection; do not import Grillskills.

Build the Windows host with build_checked1106.py; it records unchanged compiler inputs, the build log and exact output VM. release1106_test_plan.py is the authoritative dynamic test plan; run it through run_release1106_checks.py on private silent desktops. CPU profiles run alone. Every receipt must match the complete current Windows VM hash. Earlier candidates and prior-release receipts do not establish current acceptance. Run the static performance audit and review actual output images, then freeze_source.py final --directory release1106. Keep the frozen manifest and exact final-code.zip.

Compile fresh Android/iOS resources, prepare fonts, assemble and validate the offline signed APK and retained-runner IPA with build_mobile1106.py. make_release1106_receipt.py checks frozen source, all planned same-VM results, strict function-level compiled call edges, reviewed PNG hashes, platform audits, fresh resource ZIPs and both actual package inventories. It never builds or uploads. Run write_release1106_docs.py only after that gate passes.

Only a passing matching delivery receipt permits publication. Use the Hardmode source-only GitHub flow and dedicated MEGA upload queue; retain full download-readback SHA256 verification. Android signing continuity, public save directory and iOS Documents/hardmode sharing are retained. iOS requires re-signing. These are host-VM/resource checks, not physical-device acceptance; no universal high-Loop60FPS or newMac native-build claim is made.

Use a Python runtime containing Pillow. On this machine: C:/Users/ArkinTide/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe. A packages-only workflow may reuse resource ZIPs only while their current frozen-source binding and hashes still verify.
''','utf8')
    print('Wrote current release docs from final delivery receipt')


if __name__=='__main__':main()
