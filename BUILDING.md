# Build and maintenance

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
