# Build and maintenance

This source-only distribution deliberately omits media and proprietary/native dependencies. Supply your own original Epsilon/GameMaker resources, Hardmode b24 input and compatible runner/toolchains. Do not commit them, signing material or saves.

The maintained local pipeline expects `original-source/` (unmodified baseline), `reference/hardmode-b24/` (unmodified MOD), imported `assets/`, populated project media, and platform toolchains in `platforms/`. Those private inputs are not in this repository. Generated GML remains readable without them. Current local scripts preserve their original workspace paths; configure paths for your environment.

The checked-in project already contains the integration. Do not replay historical registration scripts on it. Restore the missing assets and dependencies, then build and check the current project:

```powershell
./build_local.ps1 -Target windows
python -B run_release112_checks.py native-menu
python -B run_release112_checks.py gameplay
python -B run_release112_checks.py collect
python -B package_windows112.py
```

The maintained development process freezes and delivers Windows before the mobile-only inspection. After the mobile source integration, `audit_mobile_motion112.py runtime` exercises shared actor callbacks and draw transforms at 30/60 FPS; `build_mobile112.py` generates and checks fresh APK/IPA resources. Local source, delivery and publication receipts keep the two validation VM hashes separate. The scripts use the complete private workspace inputs, not an asset-free clone.

An Android Igor extension-path error may occur after fresh VM/resource generation; the maintained offline Gradle assembly path uses those new resources. Do not accept an old resource ZIP. The retained-runner iOS packaging route requires resigning and is not a new native Mac build.

Before freezing and creating the delivery receipt, review the current-VM wall, map and throne screenshots, and record that manual review in `release112/visual-review.json`. Do not mark screenshots reviewed from automated assertions alone.

The portable Windows ZIP and its recorded validation VM remain unchanged during the subsequent mobile presentation work.

Tests run silently, sequentially, at 30 and 60 FPS. The VM lock prevents rebuilding while Runner uses it. Preserve save schema `GAME_BUILD3004`; application versions are configured separately in `release_config.py`. Full verification records and local input manifests are kept outside the public repository.
