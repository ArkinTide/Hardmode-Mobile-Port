# Nuclear Throne: Hardmode Mobile Port

[简体中文](README.zh-CN.md) · English

An independent Android and iOS port of **Hardmode b24 by Blaac**, based on Nuclear Throne Recreated Epsilon. Maintained separately from NTTE Mobile Port.

Version **1.1.3 / build 17** synchronizes the native-mod changes requested from **November 3, 2026, 17:36 UTC+08:00** onward. This includes boss replacement exclusions, sewer rendering and query fixes, boss health and presentation rules, the 7-4 crown-vault return, the original Throne layout and ending, the device-owned 6-3 exit, safer remote extra-boss placement, the 3-1 weapon chest, and one additional Ultra selection on entering Loop2. Chief large-ball split beams now use equal angular spacing across all ten plus Loop beams. See [changes and verification limits](docs/FIXES.md).

[Download Android APK / iOS IPA](https://mega.nz/folder/7TY3wZRB#PgQeCYQzxvrVGjfjX6YefA). **IPA requires resigning.** Installers use the Hardmode MEGA folder; GitHub contains text source only. Final package and publication status is established by this version's delivery and upload receipts; preparing these notes does not certify a release.

Mobile touch controls, Simplified Chinese, existing saves, and 30 Hz simulation with optional 60 Hz presentation remain supported. **Grillskills is not imported**: mobile retains its built-in mutation selection. Hardmode settings retain boss health bars, throne-ball deflection, player boost (+2 maximum HP and one extra level), and rat revival. The Loop2 extra Ultra entitlement is separate from the player-boost option and preserves the first Ultra.

Application ID: `com.arkintide.nuclearthronehardmode`. Android shared saves, with permission: `/storage/emulated/0/games/com.arkintide.nuclearthronehardmode/`; private storage is the fallback. iOS saves: `Documents/hardmode/`, with Files sharing enabled. Back up saves before installing an update.

This repository contains **text source and project metadata only**. It excludes artwork, audio, fonts, native runners, SDKs, signing identities, user saves, installers and the upstream mod's embedded image payloads. Referenced media and private build inputs must be supplied separately. See [BUILDING.md](BUILDING.md).

Validation uses compiled desktop VM scenarios at 30/60 Hz on a silent private desktop, plus Android/iOS package checks. Final test evidence remains a release gate. Desktop results do not establish physical phone performance or exhaustive campaign acceptance. High-loop performance depends on hardware and scene load; no universal 60 FPS guarantee is made. iOS retains a compatible native runner with fresh VM/resources and requires resigning; no new native Mac build is claimed.

Credits: **Blaac**, the original Hardmode author; **Vlambeer**; **YellowAfterlife**, Nuclear Throne Together; the [Epsilon base project](https://github.com/kcd-shichen/NuclearThrone-Recreated-Epsilon), baseline `44d488896ee8865d8b2bc108f7c69a24de721354`; **ArkinTide**, mobile integration and maintenance. See [CREDITS.md](CREDITS.md). Inherited Epsilon code uses [GPL v3](LICENSE); original authors retain their rights to assets and third-party components.

This release also repairs non-solid structure roofs, prevents sewer-water frog conversion, removes the free mutation on Jungle entry, retains verified pass-local water and radiation optimizations, and adopts the supplied mobile app icon. Normal level-ups and already pending mutation points are preserved. Every valid campaign and secret-stage entry is checked in compiled 30/60-frame scenarios for generation, spawn-floor support and wall collision. Dedicated tests cover the critical real exits; generation checks are not full combat playthroughs.
