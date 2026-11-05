# Build and maintenance

This repository contains text source and project metadata only. Supply the original Epsilon baseline, Hardmode b24 assets, the private media inputs used by the native-mod updates, compatible GameMaker runtime/toolchains and signing material. Configure paths for your environment. The complete maintained source is under `project/`; do not replay historical full importers over it.

Version 1.1.3 / build 17 is an incremental adaptation of the native changes beginning November 3, 2026 at 17:36 UTC+08:00 onto published mobile 1.1.2 / build 16. The local `release1103/user-scope.json` records the exact requested boundary. Existing baselines, final receipts and earlier releases must remain unchanged.

For a clean delta workspace with its private inputs available, freeze the published 1.1.2 baseline once before applying edits. Do not run the baseline command over an existing snapshot. The version-specific steps are:

```powershell
python -B freeze_source.py baseline --directory release1103
python -B import_assets1103.py
python -B integrate_release1103.py
python -B set_release1103.py
python -B change_icon1103.py apply
./build_local.ps1 -Target windows
```

An already maintained 1.1.3 checkout should build its final project directly. Integration scripts retain narrowly scoped hooks and source mirrors; they are maintenance tools, not installation steps. The imported images are local build inputs and must not be staged for GitHub.

Run the complete version-specific acceptance matrix against the final desktop VM. For example, these two real crown-route cases are only a small part of that matrix:

```powershell
python -B run_release1103_checks.py "palace,4,0,30,150,7103,sync113vault" "palace,4,0,60,150,7103,sync113vault"
python -B release1103_test_plan.py --run
python -B freeze_source.py final --directory release1103
python -B build_mobile1103.py
python -B make_release1103_receipt.py
```

The test launcher uses an opt-in desktop-only VM on a private, never-activated desktop with isolated saves. A separate VM copy zeroes every sound resource gain; code, textures and gameplay stay intact. Keep failure evidence and bind final passing receipts to the exact final VM and source hashes. The full matrix includes water/radiation parity, boss health/presentation, crown/elevator/Throne routes, remote extras, real chest collisions, Loop2 Ultra ownership/save behavior, structure-wall collision, frog conversion, real Chief-ball Destroy beam counts and equal angular spacing, stock-fallback and RNG parity, measured dense-scene behavior and every valid stage entry. Separate high-loop profiles record actual scene size and CPU time. All-stage generation checks are distinct from full combat playthroughs. A scenario fixture that accelerates native events is not an exhaustive campaign playthrough.

Android uses newly compiled Igor resources and the maintained offline Gradle assembly path. Preserve the monotonic frame pacer, storage permissions, application identity and signing certificate. iOS retains a compatible native runner with fresh VM/resources, verifies builtin/extension compatibility, and requires resigning. No new native Mac build is claimed. Package checks and desktop measurements do not establish physical Android/iPhone performance or a universal 60 FPS guarantee.

After all required final checks, generate `release1103/delivery-receipt.json` binding the source manifests, VM, fresh platform resources, validated packages and signing. Only then run:

```powershell
python -B prepare_publication1103.py
```

The stager requires 1.1.3 / build 17 and a passing matching delivery receipt. It applies the shared `source_only_policy`, rejects media/binaries, embedded image payloads and credential patterns, and audits the complete staged tree. It prepares files locally and does not push or publish. Supply missing artwork, audio, fonts, runners and SDKs separately; credentials, signing materials, saves and installers remain outside Git.

Publish audited text source to the Hardmode GitHub repository. Upload installers/checksums to the [Hardmode MEGA folder](https://mega.nz/folder/7TY3wZRB#PgQeCYQzxvrVGjfjX6YefA), perform a complete SHA-256 download readback, and only then finalize the GitHub release. NTTE keeps its own folder and source tree. Final test and publication claims must come from receipts, not from this build guide.
