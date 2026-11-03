# Build and maintenance

This text-only repository omits game media and native dependencies. Supply the original Epsilon baseline, Hardmode b24 assets, maintained native Hardmode NTT v100.034 inputs, compatible GameMaker runtime/toolchains and your own signing material. Local scripts retain workspace paths which must be configured for another environment.

The 1.1.0 pipeline starts from the preserved mobile 1.0.12 text baseline in `release1100/baseline-code.zip`, plus the native source binding and migration ledger. These local evidence archives and media are not GitHub release assets. The complete final GameMaker source is already under `project/`; do not rerun historical registration scripts over it indiscriminately.

For maintenance with the complete private inputs available:

```powershell
python -B compile_sync1100.py
python -B register_sync1100.py
python -B integrate_sync1100.py
python -B audit_sync1100.py
./build_local.ps1 -Target windows
python -B run_sync1100_checks.py menu:30 menu:60
python -B build_mobile1100.py
python -B freeze_source.py final --directory release1100
python -B make_release1100_receipt.py
python -B prepare_publication1100.py
```

Set version metadata with `set_release1100.py`; add only the new mobile labels with `localize_sync1100.py`. Grillskills is deliberately excluded. Source changes require appropriate real-VM regression before packaging. `run_sync1100_checks.py` mutes a test-only sound-resource copy, uses a private never-activated desktop and prevents VM rebuild during execution. Test entry points are opt-in and desktop-only.

Android uses fresh Igor resources plus the maintained offline Gradle assembly path. A known Igor extension-path error is accepted only after verifying newly generated resources. Preserve the monotonic frame pacer and previous signing identity. iOS packaging retains a compatible native runner with fresh resources, verifies additional builtin/extension compatibility, and requires resigning.

Freeze the final source after development and package verification. Delivery validation binds source, platform resources and final test VM hashes. Publication audits all text blobs and reachable Git history, uploads APK/IPA/checksums to the dedicated Hardmode MEGA with remote SHA-256 readback, then publishes a source-only GitHub release. Keep credentials and all binary assets outside Git.
