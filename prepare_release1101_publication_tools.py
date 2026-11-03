"""Create a version-specific source publisher without changing old releases."""
from pathlib import Path
ROOT=Path(__file__).resolve().parent

def main():
    pub=ROOT.parents[1]/'github-publish'
    path=pub/'publish_hardmode1101.py'
    assert not path.exists()
    text=(pub/'publish_hardmode1100.py').read_text('utf8')
    text=text.replace('release1100','release1101').replace("VERSION='1.1.0'","VERSION='1.1.1'")
    text=text.replace('audited 1.1.0','audited 1.1.1').replace("BASE='fb6325ab3cc6bd36993ef24c494d6eeb04c3147f'","BASE='1d2a3d589061c03ea00fd11c6f32ad84a3ee0e30'")
    start=text.index('    perf={int(')
    end=text.index('    prior=subprocess.run(',start)
    replacement='''    notes.write_text(f"""Hardmode 手机移植版 **{VERSION} / build 15**。

- 修复等级上限初始化顺序引发的 `GameCont.hm_maxlevel1100` 报错，覆盖新开局和继续游戏。
- 修复警车受伤回调递归导致的闪退；验证警车传送门、行驶、受伤和爆炸路径。
- 金星最终首领在金星以外的关卡，以及 Y.V，增加首领入场／退场镜头；遵循镜头设置，额外首领不添加镜头。
- 既有 5% 金星最终首领替换规则改为从 Loop1 开始；区域排除规则和 Loop3 的 Y.V 二阶段规则保留。
- 缩小首领名称，并将名称安排在血条上方，避免重叠。

[下载 Android APK / iOS IPA]({mega['download_page']})。**IPA 需要重签。**

本轮通过 {delivery['gameplay_cases']} 项针对性游戏场景、原生运行时及菜单回归，并核验安卓签名、30/60 帧节奏、iOS 资源及兼容性。测试使用静音隔离桌面上的已编译 VM；没有进行安卓／iPhone 真机验收，也未进行新一轮 Mac 原生构建。未对所有设备的帧率作保证。

GitHub 仅含文本源码和工程元数据，不含游戏素材或安装包。完整说明见 [docs/FIXES.md](https://github.com/{SLUG}/blob/{VERSION}/docs/FIXES.md)。手机版保留自带变异选择，未加入 Grillskills。

Fixes uninitialized level-cap access and recursive police-van damage; adds targeted boss entrance/exit camera pans, starts the existing replacement roll at Loop1, and keeps compact boss names above health bars. Extra bosses receive no new camera pans. Validation uses targeted compiled desktop VM tests and fresh mobile-package checks, not physical phones. iOS retains a compatible native runner with new resources and requires resigning.

感谢 Hardmode 作者 Blaac、Vlambeer、YellowAfterlife、Epsilon 基础工程及原模组贡献者。
""",encoding='utf8')
'''
    text=text[:start]+replacement+text[end:]
    path.write_text(text,'utf8')
    print('Prepared GitHub 1.1.1 publisher')

if __name__=='__main__':main()
