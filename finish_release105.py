"""Write delivery notes only after the final 1.0.5 receipt has passed."""
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parent


def main():
    report = json.loads((ROOT/'release105/delivery-receipt.json').read_text(encoding='utf8'))
    assert report['status'] == 'PASS' and report['version'] == '1.0.5'
    counts = (f"同一最终桌面 VM：30/60 帧 {report['gameplay_cases']} 项游戏场景、"
              f"{int(report['gameplay_assertions'])} 游戏断言、{int(report['native_assertions'])} 原生断言、"
              f"{int(report['menu_assertions'])} 菜单及语言切换断言通过。")
    artifacts = report['artifacts']
    hashes = '\n\n'.join(f"{'Android' if a['path'].endswith('.apk') else 'iOS'} SHA256：`{a['sha256']}`。" for a in artifacts)
    delivery = f"""# Hardmode 1.0.5 / build 6 本地交付

交付总核验 PASS；完整证据见 delivery-receipt.json，15 项修复对应见 FIXES.md。

- 安卓：../deliverables/NuclearThrone.Hardmode-Android-1.0.5.apk。
- iOS：../deliverables/NuclearThrone.Hardmode-iOS-1.0.5.ipa，需重签。

{counts}

最终 Windows VM SHA256：`{report['final_desktop_vm_sha256']}`。17 个区域的外层碰撞墙与 MOD 结构放置规则已审核；画面及性能采样见 visual-review.json、performance.json。{report['original_files_verified']} 个原版文件未改，素材像素及音频未改。baseline/final-source.json 与 code.zip 保存源码状态。

安卓包签名与旧版一致，APK v2、资源、版本、ZIP16K/ARM64 ELF16K 对齐通过。iOS 新增 16 个原生接口及扩展块静态兼容检查通过。安卓共享存档与 iOS Documents 文件共享保持。没有手机真机或 Mac 原生重建验证，IPA 使用保留的兼容 runner 和新 VM/资源，需自行重签；桌面性能采样不代表手机帧率。Android 离线 release lint 依赖缺失，已另行执行安装包校验。

{hashes}

不上传 GitHub/MEGA。后续从 1.0.6/build7 开始；禁止覆盖本轮源码快照或历史证据。不要在测试进程运行时重编译 Windows VM。
"""
    (ROOT/'release105/DELIVERY.md').write_text(delivery, encoding='utf8')
    install = (ROOT/'release104/INSTALL.md').read_text(encoding='utf8')
    install = install.replace('1.0.4', '1.0.5')
    start = install.index('## 本次更新')
    install = install[:start] + f"""## 本次更新

处理最新 15 项：修正下水道水中速度与上岸即时判定；外层墙仅显示纯色并保留碰撞；修复 Rogue/Venuz 报错、巨鸟落地、渡鸦/IDPD 卡墙外、选人取消导致 MOD 失效、大水晶闪烁、Big Dog 子弹反弹、宫殿发电机过量与恐惧形态；优化 Boss 演出并修复暂停/立绘中文方框；排除新增碰撞墙对 MOD 结构生成的干扰。逐项见 FIXES.md。

保留满级前 MOD 辐射、满级后原版掉落、原版已有汉化、单人菜单与独立包名，GAME_BUILD3004 存档格式保持。

## 验证范围

{counts} 资源、签名、对齐及 iOS 原生接口检查通过。无手机真机或完整人工通关验证，无 Mac 原生重建；IPA 需重签。桌面采样不代表手机帧率。不上传 GitHub 或 MEGA。

## SHA256

{hashes}
"""
    (ROOT/'release105/INSTALL.md').write_text(install, encoding='utf8')
    (ROOT/'deliverables/安装说明.md').write_text(install, encoding='utf8')
    status = (ROOT/'STATUS.md').read_text(encoding='utf8')
    marker = '## 当前状态：1.0.5 / build 6 已完成本地交付准备'
    if marker not in status:
        status = status.replace('## 当前状态：1.0.4 / build 5 已完成本地交付准备',
                                '## 历史：1.0.4 / build 5 已完成本地交付准备', 1)
        insert = status.index('## 历史：1.0.4')
        current = f"""{marker}

最新本地包为 deliverables/NuclearThrone.Hardmode-Android-1.0.5.apk 与 NuclearThrone.Hardmode-iOS-1.0.5.ipa。交付总核验 PASS，见 release105/DELIVERY.md、delivery-receipt.json、FIXES.md、INSTALL.md。不上传 GitHub/MEGA。下一修复版 1.0.6/build7。

{counts} 最终 VM SHA256：{report['final_desktop_vm_sha256']}。源码与原版核验、画面、结构及平台审核均保存在 release105。最新 15 项及演出后亡语恢复已验证；无手机真机、完整人工通关或 Mac 原生重建验证，IPA 需重签。

维护入口见 release105/WORKLOG.md。满级前 MOD/满级后原版辐射、GAME_BUILD3004 与独立包名不变；安卓共享存档和 iOS Documents 分享保留。不派代理、不测120帧、不运行Steam、不主动清理，不修改冻结原版/MOD/NTTE。测试音量1%，Windows VM 有测试锁时不得重编译。

"""
        status = status[:insert] + current + status[insert:]
        (ROOT/'STATUS.md').write_text(status, encoding='utf8')
    recovery = ROOT/'../../重启后继续开发.md'
    text = recovery.read_text(encoding='utf8')
    marker = '# 当前任务：独立 Hardmode 1.0.5 / build 6 已完成本地交付准备'
    if not text.startswith(marker):
        recovery.write_text(f"""{marker}

优先读取 work/hardmode-port/STATUS.md 与 release105/DELIVERY.md、WORKLOG.md、delivery-receipt.json。最新两端安装包在该项目 deliverables，版本 1.0.5。{counts} 最终 VM：{report['final_desktop_vm_sha256']}。

本轮最新 15 项已完成源码修复、本地回归及包校验，含暂停/立绘中文方框。iOS 保留兼容 runner + 新 VM，需重签；无手机真机或 Mac 原生重建验收。不上传 GitHub/MEGA。后续从 1.0.6/build7 开始，不覆盖 release105。注册顺序与测试独占锁见 WORKLOG.md；测试时不编译 Windows VM。保持独立包名、GAME_BUILD3004、满级前 MOD 辐射/满级后原版。不派代理、不测120帧、不运行Steam、不主动清理、不修改 NTTE 或冻结原版/MOD；测试音量1%。

以下均为历史记录：

""" + text, encoding='utf8')
    print('Delivery notes, status and restart record updated: Hardmode 1.0.5')


if __name__ == '__main__':
    main()
