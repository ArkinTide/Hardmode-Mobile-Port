"""Create a separate base project from the verified original upstream export."""
from pathlib import Path
from datetime import datetime, timezone
import hashlib
import json
import re
import shutil
import uuid

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / "project"


def load(path):
    return json.loads(re.sub(r",(?=\s*[\]}])", "", path.read_text(encoding="utf-8-sig")))


def save(path, obj):
    path.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + "\n", encoding="utf8")


def main():
    source_manifest = load(ROOT / "original-source-manifest.json")
    assert source_manifest["status"] == "PASS"
    assert not PROJECT.exists(), "Do not overwrite an existing development project"
    for name, pin in source_manifest["files"].items():
        path = ROOT / "original-source" / name
        assert hashlib.sha256(path.read_bytes()).hexdigest() == pin["sha256"], name
    shutil.copytree(ROOT / "original-source", PROJECT)
    main_path = PROJECT / "options/main/options_main.yy"
    main_options = load(main_path)
    main_options["option_gameguid"] = "{" + str(uuid.uuid5(uuid.NAMESPACE_URL, "com.arkintide.nuclearthronehardmode")).upper() + "}"
    save(main_path, main_options)
    android_path = PROJECT / "options/android/options_android.yy"
    android = load(android_path)
    android.update(option_android_display_name="Nuclear Throne: Hardmode",
                   option_android_package_company="arkintide", option_android_package_domain="com",
                   option_android_package_product="nuclearthronehardmode", option_android_version="1.0.0")
    save(android_path, android)
    ios_path = PROJECT / "options/ios/options_ios.yy"
    ios = load(ios_path)
    ios.update(option_ios_display_name="Nuclear Throne: Hardmode",
               option_ios_bundle_name="NuclearThroneHardmode",
               option_ios_bundle_identifier="com.arkintide.nuclearthronehardmode", option_ios_version="1.0.0")
    save(ios_path, ios)
    windows_path = PROJECT / "options/windows/options_windows.yy"
    windows = load(windows_path)
    windows.update(option_windows_display_name="Nuclear Throne: Hardmode",
                   option_windows_product_info="Nuclear Throne: Hardmode",
                   option_windows_exe_name="NuclearThroneHardmode", option_windows_version="1.0.0.0")
    save(windows_path, windows)
    save(ROOT / "foundation-receipt.json", {
        "status": "BASE_PROJECT_PREPARED_NOT_MOD_COMPLETE", "created_utc": datetime.now(timezone.utc).isoformat(),
        "upstream_commit": source_manifest["commit"], "verified_original_source_files": len(source_manifest["files"]),
        "package_identifier": "com.arkintide.nuclearthronehardmode",
        "ntte_gameplay_added": False, "installers_generated": False, "release_ready": False,
    })
    print("Independent original-source project created; Hardmode gameplay remains in development")


if __name__ == "__main__":
    main()
