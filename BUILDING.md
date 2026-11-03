# Build and maintenance

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
