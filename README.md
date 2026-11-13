# Hardmode Mobile Port 1.1.6

Mobile adaptation of Hardmode b24, build 20. See [fixes](docs/FIXES.md) and [installation](docs/INSTALL.md).

Final acceptance: 233 scenarios and 157017 assertions on one source-bound VM. This repository contains text source and project metadata; installers are distributed through the existing Hardmode MEGA folder.

The package identity, Android signing identity and save paths are preserved. Native mobile mutation selection is retained. No NTTE/NTUF or desktop MOD is changed.

Validation uses a silent isolated Windows host VM, not physical Android/iPhone devices. Sustained overload may temporarily render at the native30Hz rate to retain simulation speed and restore the saved60FPS preference after recovery. No universal60FPS guarantee is made. The IPA retains a compatible native runner with fresh VM/resources and requires re-signing.
