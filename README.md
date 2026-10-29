# Nuclear Throne: Hardmode Mobile Port

[简体中文](README.zh-CN.md) · English

An independent Android and iOS port of **Hardmode b24 by Blaac**, based on the Nuclear Throne Recreated Epsilon project. This is separate from NTTE Mobile Port.

Current release: **1.0.7**, native build **8**. [Download APK / IPA](https://mega.nz/folder/PfIDSaSZ#ZcRokP34or9J0JofsIgrEA). Installers are distributed through the existing MEGA folder, not GitHub assets.

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
