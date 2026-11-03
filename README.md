# Nuclear Throne: Hardmode Mobile Port

[简体中文](README.zh-CN.md) · English

An independent Android and iOS port of **Hardmode b24 by Blaac**, based on Nuclear Throne Recreated Epsilon. Maintained separately from NTTE Mobile Port.

Current release: **1.1.2 / build 16**. Adds the native-mod sewer-query optimization and 6-3 exit repair, plus mutually exclusive five-percent Captain/final Venus boss replacement from Loop1. Throne and all Venus rooms keep their own bosses. Captain gains native warp presentation, camera pans and one extra ball-split beam per Loop; the final Venus boss gains one first-phase rocket per Loop. See [changes and verification limits](docs/FIXES.md).

[Download Android APK / iOS IPA](https://mega.nz/folder/7TY3wZRB#PgQeCYQzxvrVGjfjX6YefA). **IPA requires resigning.** Installers are distributed through MEGA; GitHub contains text source only.

Mobile touch controls, Simplified Chinese, existing saves, and 30 Hz simulation with optional 60 Hz presentation remain supported. **Grillskills is not imported**: mobile retains its built-in mutation selection. Hardmode settings include boss health bars, throne-ball deflection, player boost (+2 maximum HP and one extra level), and rat revival.

Application ID: `com.arkintide.nuclearthronehardmode`. Android shared saves, with permission: `/storage/emulated/0/games/com.arkintide.nuclearthronehardmode/`; private storage is the fallback. iOS saves: `Documents/hardmode/`, with Files sharing enabled. Back up saves before installing an update.

This repository contains **text source and project metadata only**. It excludes artwork, audio, fonts, native runners, SDKs, signing identities, user saves, installers and the upstream mod's embedded image payloads. Referenced media and private build inputs must be supplied separately. See [BUILDING.md](BUILDING.md).

Tests use the compiled desktop VM on a silent private desktop, plus Android/iOS package checks. They do not establish physical phone performance or exhaustive campaign acceptance. High-loop performance depends on hardware and scene load; no universal 60 FPS guarantee is made. iOS retains a compatible native runner with fresh VM/resources; no new native Mac build is claimed.

Credits: **Blaac**, the original Hardmode author; **Vlambeer**; **YellowAfterlife**, Nuclear Throne Together; the [Epsilon base project](https://github.com/kcd-shichen/NuclearThrone-Recreated-Epsilon), baseline `44d488896ee8865d8b2bc108f7c69a24de721354`; **ArkinTide**, mobile integration and maintenance. See [CREDITS.md](CREDITS.md). Inherited Epsilon code uses [GPL v3](LICENSE); original authors retain their rights to assets and third-party components.
