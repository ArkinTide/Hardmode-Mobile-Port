# Hardmode Mobile Port 1.1.7

Hardmode b24 mobile adaptation, build 21. This incremental release covers the
[nine current requests](docs/FIXES.md); installation instructions are in
[INSTALL](docs/INSTALL.md).

Version 1.1.7 / build 21 APK and IPA passed the final delivery gate, including
actual packaged code and artwork, signing continuity and save compatibility.
All 56 planned cases passed on the same current-source Windows host VM, with
17,947 checks and 13 reviewed PNGs. The 60 FPS presentation-timing case also
passed two serial repeats after an earlier native startup failure; that
original attempt remains recorded.

The frame-cap repair converts existing native physical velocities and caches
before gameplay consumes the new cap, including accelerated Rocket and
JockRocket motion. The Video menu adds an automatic frame-reduction switch,
enabled by default. Boss presentation timing uses elapsed time. Cave-end
corpse flowers are limited to one and receive jungle floor with or without
Last Wish. The Captain's Loop1+ decision-rest multiplier of 0.8 is an
authorized balance adjustment, not a verified desktop formula.

The package name, signing identity, save paths and native mobile mutation
selection are retained. GitHub distribution contains text source and project
metadata; APK, IPA and SHA256 checksums use the existing Hardmode MEGA
directory. Check downloaded files against the release checksum file. The
desktop MOD and NTTE/NTUF are maintained separately.

Tests use a silent, isolated Windows host VM and private saves. No physical
Android/iPhone acceptance or universal high-Loop 60 FPS claim is made. The IPA
uses a compatible retained native runner with fresh game resources and
requires re-signing. See [BUILDING](BUILDING.md) for the current-source gates.
