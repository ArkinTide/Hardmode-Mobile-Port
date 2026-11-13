# Build and maintenance

The maintained project is project/nuclearthronemobile.yyp. Supply original Epsilon/Hardmode assets, compatible GameMaker tools, native runners and signing material separately. The source-only GitHub publication excludes proprietary binary resources and private signing material. Do not rerun historical full importers over the maintained project.

Version 1.1.5/build19 covers the35 human followups in docs/scope-1.1.5.json (maintained locally as release1105/scope-coverage.json). The targeted integrate_1115_* and integrate_1105_performance.py transforms preserve prior repairs. Run the Messenger and boss-group integrations after historical generators; production helpers/tests use existing registered assets and register_1115.py. Preserve mobile mutation selection; do not import Grillskills.

Build the Windows host with build_checked1105.py; it records unchanged compiler inputs, the build log and exact output VM. release1105_test_plan.py is the authoritative dynamic test plan; run it in the private silent harness. Every receipt must match the current complete Windows VM hash. Preliminary builds and 1.1.4 receipts do not count. Run the static performance audit and review actual output images, then freeze_source.py final --directory release1105. Keep the frozen manifest and exact final-code.zip.

Compile fresh Android/iOS resources, prepare fonts, assemble and validate the offline signed APK and retained-runner IPA using the current release build scripts. make_release1105_receipt.py checks frozen source, all planned same-VM results, strict function-level compiled call edges, reviewed PNG hashes, platform audits, fresh resource ZIPs and both actual package inventories. It never builds or uploads. Run write_release1105_docs.py --final only after that gate passes.

Only a passing matching delivery receipt permits publication. Use the Hardmode source-only GitHub flow and dedicated MEGA upload queue; retain full download-readback SHA256 verification. Android signing continuity, public save directory and iOS Documents/hardmode sharing are retained. iOS requires re-signing. These are host-VM/resource checks, not physical-device acceptance; no universal high-Loop60FPS or newMac native-build claim is made.

Use a Python runtime containing Pillow. On this machine: C:/Users/ArkinTide/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe. A packages-only workflow may reuse resource ZIPs only when their current frozen-source binding and hashes still verify.
