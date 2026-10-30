"""Stage a text-only Hardmode repository; never publish assets or credentials."""
from pathlib import Path
import argparse, hashlib, json, re, shutil, sys
from release_config import VERSION, BUILD

ROOT=Path(__file__).resolve().parent
PUBLISH=ROOT.parent.parent/'github-publish'
STAGE=PUBLISH/'hardmode-mobile-port'
sys.path.insert(0,str(PUBLISH))
from source_only_policy import allowed_path, text_blob


def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--final',action='store_true')
    args=parser.parse_args()
    if args.final:
        receipt=json.loads((ROOT/'release108/delivery-receipt.json').read_text(encoding='utf8'))
        assert receipt['status']=='PASS' and receipt['version']==VERSION
    STAGE.mkdir(parents=True,exist_ok=True)
    files={}
    def add(path,relative=None):
        relative=relative or path.relative_to(ROOT).as_posix()
        if not allowed_path(relative): return
        data=path.read_bytes()
        if not text_blob(data) and relative.lower().endswith('/license.txt'):
            assert text_blob(data,legacy_license=True),relative
            data=data.decode('cp1252').encode('utf8')
        assert text_blob(data),relative
        # UTF8 source with long encoded binary is also an asset. Detect the
        # actual embedded payload, without treating source layout strings or
        # references to filenames as binary artwork.
        text=data.decode('utf-8-sig')
        assert not re.search(r'(?:iVBORw0KGgo|UklGR|T2dnUw|/9j/)[A-Za-z0-9+/=]{200,}',text),relative
        assert not re.search(r'\b(?:gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{40,}|-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----)',text),relative
        destination=STAGE/relative
        destination.parent.mkdir(parents=True,exist_ok=True)
        destination.write_bytes(data);files[relative]=sha(destination)
    for folder in ('native','generated','tests','localization','project'):
        for path in sorted((ROOT/folder).rglob('*')):
            if not path.is_file():continue
            relative=path.relative_to(ROOT).as_posix()
            if any(part in ('node_modules','.git','__pycache__') for part in path.parts):continue
            if folder=='project' and '/datafiles/' in relative:continue
            add(path)
    for pattern in ('*.py','*.ps1'):
        for path in sorted(ROOT.glob(pattern)):
            if path.name=='prepare_evidence106.py':continue
            add(path)
    # This is source metadata, including names/hashes, not any media payload.
    for name in ('artwork-manifest.json','native-artwork-receipt.json','mod-inventory.json',
                 'upstream-selection.json','runtime_schema.py','original-source-manifest.json'):
        add(ROOT/name)
    add(ROOT/'original-source/LICENSE','LICENSE')
    if args.final:
        for name in ('FIXES.md','INSTALL.md'):
            add(ROOT/'release108'/name,'docs/'+name)
    def document(name,text):
        path=STAGE/name;path.parent.mkdir(parents=True,exist_ok=True)
        path.write_text(text,encoding='utf8');files[name]=sha(path)
    download='https://mega.nz/folder/7TY3wZRB#PgQeCYQzxvrVGjfjX6YefA'
    document('README.md',f'''# Nuclear Throne: Hardmode Mobile Port

[简体中文](README.zh-CN.md) · English

An independent Android and iOS port of **Hardmode b24 by Blaac**, based on the Nuclear Throne Recreated Epsilon project. This is separate from NTTE Mobile Port.

Current release: **{VERSION}**, native build **{BUILD}**. [Download APK / IPA]({download}). Installers are distributed through the existing MEGA folder, not GitHub assets.

This repository contains **text source code and project metadata only**: the maintained GML adapters, generated modules, compiler, tests, translations and GameMaker project definitions. It does not contain game artwork, audio, fonts, native runners, SDKs, signing identities, user saves, or the original MOD's embedded image payloads. The asset references in project definitions require separately supplied files.

## Play and saves

- Independent application ID: `com.arkintide.nuclearthronehardmode`.
- Android shared saves: `/storage/emulated/0/games/com.arkintide.nuclearthronehardmode/`, after storage permission; the private directory is the fallback.
- iOS saves: `Documents/hardmode/`, exposed through Files sharing.
- Below maximum character level, radiation follows Hardmode's reduced drops. At maximum level, ordinary drops return, with green rats matching ordinary rats.
- Online multiplayer, resource packs, daily/weekly challenges and the main-menu Discord button are hidden in this independent port. Simplified Chinese Hardmode text is included; existing base-game translations are preserved.

## Source layout and building

- `native/`: runtime, world, actor, collision, rendering, save and release adapters.
- `generated/`: translated MOD modules with symbolic asset references.
- `project/`: GameMaker source and resource metadata, without media files.
- `tests/`: native, menu and actual gameplay regression observers.
- `native_compiler.py`, `repairs*.py`, `integrate_release*.py`: maintained translation and registration pipeline.

See [BUILDING.md](BUILDING.md) for the local build sequence and asset requirements. A fresh asset-free clone is not a ready-to-run game. Use your lawfully obtained original game and Hardmode files, compatible GameMaker/runtime, Android toolchain, and your own signing material. No credentials are supplied.

## Verification limits

Release checks record one unchanged desktop VM at 30 and 60 FPS, real menu/gameplay callbacks, and mobile package structure, signature and resource checks. Desktop CPU profiles are not measurements of phone frame rate. No physical Android/iPhone validation or new Mac native build is claimed. The iOS package retains a compatible native runner with new VM/resources and **requires resigning**.

## Credits and license

- **Blaac** — original Hardmode b24 design, code and artwork; original collaborator credits are retained in [CREDITS.md](CREDITS.md).
- [NuclearThrone-Recreated-Epsilon](https://github.com/kcd-shichen/NuclearThrone-Recreated-Epsilon), source baseline `44d488896ee8865d8b2bc108f7c69a24de721354` — base mobile project.
- **Vlambeer** — Nuclear Throne; **YellowAfterlife** — Nuclear Throne Together and its MOD interfaces.
- **ArkinTide** — mobile integration, maintenance and Simplified Chinese adaptation.

The inherited Epsilon code is distributed under its [GNU GPL v3 license](LICENSE). Original authors retain their copyrights; this repository does not grant additional rights to game or MOD assets, music, or third-party components.
''')
    document('README.zh-CN.md',f'''# Nuclear Throne: Hardmode 手机移植版

简体中文 · [English](README.md)

基于 **Blaac 的 Hardmode b24** 和 Nuclear Throne Recreated Epsilon 制作的安卓／iOS 独立移植版，与 NTTE 移植工程分开维护。

当前版本 **{VERSION} / build {BUILD}**。[下载 APK 和 IPA]({download})。GitHub 只发布源码，安装包放在既有 MEGA 目录。

仓库只包含文本源码及工程元数据，包括 GML 适配层、生成模块、编译器、测试、汉化和 GameMaker 工程定义。**不含图片、音频、字体、原生 runner、SDK、签名、用户存档或原 MOD 内嵌图片数据**。工程内的素材引用需要另行补齐。

安卓独立包名为 `com.arkintide.nuclearthronehardmode`。授权后的共享存档目录为 `/storage/emulated/0/games/com.arkintide.nuclearthronehardmode/`；不可写时使用私有目录。iOS 存档在 `Documents/hardmode/` 并开启文件共享。

满级前使用 Hardmode 的辐射掉落规则，满级后恢复普通掉落；绿老鼠满级后的基础掉落与普通老鼠相同。移除独立版中不使用的多人、资源包、每日／每周挑战和主菜单 Discord 入口，加入 Hardmode 简体中文文本，保留原版既有汉化。

源码结构、构建依赖与命令见 [BUILDING.md](BUILDING.md)。纯源码克隆不能直接运行，需要自行提供合法取得的原版／Hardmode 素材、兼容 GameMaker、平台工具链和签名材料。

验证包括同一桌面 VM 的 30／60 帧回归、实际菜单和游戏回调、移动安装包的签名／结构／资源核验。桌面 CPU 计时不能代表手机帧率；没有宣称安卓／iPhone 真机或本轮 Mac 原生重建验收。**IPA 需要重签**。

感谢 Hardmode 作者 Blaac、[原移植基础工程](https://github.com/kcd-shichen/NuclearThrone-Recreated-Epsilon)、Vlambeer、YellowAfterlife 及[原 MOD 贡献者](CREDITS.md)。原基础工程代码沿用 [GPL v3](LICENSE)；素材、音乐及第三方内容的权利仍归原作者，仓库不额外授予其使用许可。
''')
    document('CREDITS.md','''# Credits

Hardmode b24 was created by **Blaac**. Original credits, summarized from the supplied MOD documentation:

- YellowAfterlife: Nuclear Throne Together, MOD support and API work.
- saniblues: Raven/Guardian bosses, Rogue portal strikes, Rogue Freak sprites, boss introductions and persistent settings.
- yokin: code contributions, ropes, smoking gators and testing.
- 9joao6: cave/oasis transitions, Venus car departure, secret doors and looping scorpion death sequence.
- ideaot: shielding-spider artwork/concept and the 3D police van concept.
- jsburg: stacked sprite vehicle rendering and police van adaptation.
- neonomi and sleepcycles: playtesting, feedback and videos.
- Jukio “Kuabee” Kallio: GUNGODZ soundtrack.
- Vlambeer: Nuclear Throne and GUNGODZ.
- NuclearThrone-Recreated-Epsilon contributors: the mobile base project.
- ArkinTide: this independent mobile integration and maintenance.

This text-only repository includes no artwork, fonts, music or native game binaries. Copyright and rights remain with their respective authors.
''')
    document('BUILDING.md','''# Build and maintenance

This source-only distribution deliberately omits media and proprietary/native dependencies. Supply your own original Epsilon/GameMaker resources, Hardmode b24 input and compatible runner/toolchains. Do not commit them, signing material or saves.

The maintained local pipeline expects `original-source/` (unmodified baseline), `reference/hardmode-b24/` (unmodified MOD), imported `assets/`, populated project media, and platform toolchains in `platforms/`. Those private inputs are not in this repository. Generated GML remains readable without them. Current local scripts preserve their original workspace paths; configure paths for your environment.

With the complete local inputs restored:

```powershell
python -B register_release108.py
./build_local.ps1 -Target windows
python -B run_release108_checks.py native-menu
python -B run_release108_checks.py focused
python -B run_release108_checks.py regression
python -B run_release108_checks.py collect
python -B audit_structures108.py
python -B collect_visual108.py
python -B freeze_source.py final --directory release108
./build_local.ps1 -Target android
./build_local.ps1 -Target ios
python -B package_mobile.py android
./assemble_android.ps1
python -B validate_android.py
python -B package_mobile.py ios
python -B audit_mobile_storage108.py
python -B make_release108_receipt.py
```

An Android Igor extension-path error may occur after fresh VM/resource generation; the maintained offline Gradle assembly path uses those new resources. Do not accept an old resource ZIP. The retained-runner iOS packaging route requires resigning and is not a new native Mac build.

Before freezing and creating the delivery receipt, review the collected current-VM screenshots, including both mansion routes, and record that manual review in `release108/visual-review.json`. Do not mark screenshots reviewed from automated assertions alone.

Tests run silently, sequentially, at 30 and 60 FPS. The VM lock prevents rebuilding while Runner uses it. Preserve save schema `GAME_BUILD3004`; application versions are configured separately in `release_config.py`. Full verification records and local input manifests are kept outside the public repository.
''')
    document('.gitignore','''# Game assets and binaries are not published.
*.png
*.jpg
*.jpeg
*.gif
*.webp
*.ico
*.icns
*.ogg
*.wav
*.mp3
*.ttf
*.otf
*.dll
*.exe
*.so
*.dylib
*.a
*.win
*.droid
*.ios
*.apk
*.ipa
*.zip
*.jks
*.keystore
*.p12
*.mobileprovision
.auth/
__pycache__/
original-source/
reference/
assets/
build-*/
deliverables/
platforms/
*.sav
*.log
''')
    document('.gitattributes','* text=auto eol=lf\n')
    # Re-audit every staged file, not only newly selected ones.
    for path in STAGE.rglob('*'):
        if not path.is_file() or '.git' in path.parts:continue
        relative=path.relative_to(STAGE).as_posix()
        assert relative in files and allowed_path(relative) and text_blob(path.read_bytes()),relative
    report={'status':'PASS','version':VERSION,'stage':str(STAGE),'files':files,
            'text_files':len(files),'asset_files':0,'final_delivery_checked':args.final,
            'published':False}
    (ROOT/'release108/source-publication-preflight.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf8')
    print('Hardmode source-only stage PASS:',len(files),'text files; final delivery:',args.final)


if __name__=='__main__':main()
