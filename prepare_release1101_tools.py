"""Create isolated 1.1.1 packaging and publication helpers from the prior release."""
from pathlib import Path

ROOT=Path(__file__).resolve().parent

def main():
    for name in ('build_mobile','test_android','audit_mobile_storage','prepare_publication'):
        target=ROOT/(name+'1101.py')
        assert not target.exists(),target
        text=(ROOT/(name+'1100.py')).read_text('utf8').replace('release1100','release1101')
        text=text.replace('1.1.0','1.1.1').replace("('1.1.1',14)","('1.1.1',15)")
        if name=='build_mobile':
            text=text.replace('test_android1100.py','test_android1101.py').replace('audit_mobile_storage1100.py','audit_mobile_storage1101.py')
        if name=='prepare_publication':
            # Retain the existing source migration record as history, not a new migration claim.
            text=text.replace("add(OUT/'migration-ledger.json','docs/migration-1.1.1.json')", "add(ROOT/'release1100/migration-ledger.json','docs/migration-1.1.0.json')")
        target.write_text(text,'utf8')
    out=ROOT/'release1101'
    for name in ('README.md','README.zh-CN.md','INSTALL.md'):
        text=(ROOT/'release1100'/name).read_text('utf8').replace('1.1.0','1.1.1').replace('build 14','build 15')
        if name=='README.md':
            start=text.index('Current release:');end=text.index('\n\n',start)
            text=text[:start]+'Current release: **1.1.1 / build 15**. Repairs the uninitialized level-cap error and police-van damage recursion, adds targeted final-boss/Y.V camera pans, starts the existing five-percent final-boss replacement rule at Loop1, and separates compact boss titles from their health bars. See [changes and verification limits](docs/FIXES.md).'+text[end:]
        if name=='README.zh-CN.md':
            start=text.index('当前版本：');end=text.index('\n\n',start)
            text=text[:start]+'当前版本：**1.1.1 / build 15**。修复等级上限未初始化报错、警车受伤递归闪退，补齐金星最终首领及 Y.V 的入场／退场镜头，随机替换金星最终首领从 Loop1 开始，缩小首领名称并与血条分行。详见 [更新说明及验证范围](docs/FIXES.md)。'+text[end:]
        (out/name).write_text(text,'utf8')
    (out/'BUILDING.md').write_text('''# Build and maintenance

This repository contains text source and project metadata only. Supply the original Epsilon baseline, Hardmode b24 assets, compatible GameMaker runtime/toolchains and signing material. Configure local paths for your environment. The complete maintained source is under `project/`; do not replay historical importers over it.

For the 1.1.1 delta with the complete private inputs available:

```powershell
python -B set_release1101.py
python -B integrate_release1101.py
./build_local.ps1 -Target windows
python -B run_release1101_checks.py menu:30 menu:60
python -B build_mobile1101.py
python -B freeze_source.py final --directory release1101
python -B make_release1101_receipt.py
python -B prepare_publication1101.py
```

The regression suite exercises actual 30/60 Hz VM gameplay on a private, never-activated desktop. A separate test-only VM has all sound gains zeroed. Tests are opt-in and desktop-only. Keep the monotonic Android pacer, app identity and signing certificate. Grillskills remains excluded; the mobile mutation selector is retained.

Android uses newly compiled Igor resources with the maintained offline Gradle assembly path. iOS retains a compatible native runner with fresh VM/resources, verifies builtin/extension compatibility, and requires resigning. No new native Mac build is claimed.

Final receipts bind source manifests, final test VM, platform resource hashes, package validation and signing. Publish only audited text source to GitHub. Upload installers/checksums to the Hardmode MEGA folder and verify a complete SHA-256 download readback before publishing the GitHub release. Credentials, media, saves and installers remain outside Git.
''','utf8')
    print('Prepared isolated 1.1.1 helpers and release documentation')

if __name__=='__main__':main()
