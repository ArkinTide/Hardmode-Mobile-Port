# Build and maintenance

The maintained project is project/nuclearthronemobile.yyp. Supply the original Epsilon/Hardmode assets, compatible local GameMaker tools, native runners and signing material separately. GitHub contains text source and metadata only. Do not rerun historical full importers over this project.

Version1.1.4/build18 incrementally repairs the16 mobile reports recorded in FIXES.md. The four integrate_1104_* scripts own narrowly scoped transforms; register_1104.py registers the new helpers and opt-in tests. The published baseline and failed candidate evidence remain local underrelease1104. Never overwrite previous releases or original-source.

Build with build_local.ps1 -Target windows, run release1104_test_plan.py --run in the isolated silent harness, then freeze_source.py final --directory release1104. Build_mobile1104.py compiles fresh Android/iOS resources, prepares fonts, assembles the offline signed APK and retained-runner IPA, and validates storage/native compatibility. make_release1104_receipt.py binds the exact final source, tested VM, render evidence and both packages.

Only a passing matching delivery receipt permits prepare_publication1104.py, the source-only GitHub stager and dedicated Hardmode MEGA upload queue. Require full download-readback SHA256 verification. Physical-device tests and newMac native builds are not claimed. Keep current save and signing identities and existing mobile mutation UI; do not import Grillskills.

Run build_mobile1104.py and make_release1104_receipt.py with a Python runtime
containing Pillow, since package_fonts imports PIL. On this machine that is
C:/Users/ArkinTide/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe.
If fresh mobile compilation already completed and its source-bound
mobile-resource-build.json is valid, --packages-only reuses those exact resource
ZIPs after rechecking their hashes; it does not accept stale resources.
