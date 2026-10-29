"""Check the regenerated original assets and the upstream-only CJK atlas."""
from datetime import datetime, timezone
from pathlib import Path
import hashlib
import json
import shutil

from PIL import Image
from create_project import load

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / "project"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    failures, geometry_notes, sprite_count, frames, sounds = [], [], 0, 0, 0
    manifest = load(ROOT / "original-source-manifest.json")["files"]
    resources = load(PROJECT / "nuclearthronemobile.yyp")["resources"]
    sprite_paths = sorted(PROJECT / item["id"]["path"] for item in resources if item["id"]["path"].startswith("sprites/"))
    sound_paths = sorted(PROJECT / item["id"]["path"] for item in resources if item["id"]["path"].startswith("sounds/"))
    for path in sprite_paths:
        data = load(path)
        sprite_count += 1
        for frame in data["frames"]:
            frame_name = frame["name"]
            image = path.parent / (frame_name + ".png")
            if not image.exists():
                failures.append(f"Missing frame: {image}")
                continue
            with Image.open(image) as pixels:
                if pixels.size != (data["width"], data["height"]):
                    relative = image.relative_to(PROJECT).as_posix()
                    original = manifest.get(relative)
                    if original and digest(image) == original["sha256"]:
                        geometry_notes.append({
                            "file": relative, "png_size": pixels.size,
                            "yy_canvas": [data["width"], data["height"]],
                            "reason": "Geometry mismatch already in pinned upstream; requires visual review",
                        })
                    else:
                        failures.append(f"Frame dimensions: {image}: {pixels.size}")
                pixels.verify()
            for layer in data["layers"]:
                image = path.parent / "layers" / frame_name / (layer["name"] + ".png")
                if not image.exists():
                    failures.append(f"Missing source layer: {image}")
            frames += 1

    for path in sound_paths:
        data = load(path)
        sound = path.parent / data["soundFile"]
        if not sound.is_file() or sound.stat().st_size == 0:
            failures.append(f"Missing sound: {sound}")
        sounds += 1

    # The official game has no Epsilon CJK atlas. It is present in the pinned
    # original recreation source, so the Steam SPRT-name audit is inapplicable.
    atlas = []
    for path in sorted((PROJECT / "sprites/sprBignameAtlas").rglob("*.png")):
        relative = path.relative_to(PROJECT).as_posix()
        actual = digest(path)
        expected = manifest[relative]["sha256"]
        if actual != expected:
            failures.append(f"Original upstream CJK atlas changed: {relative}")
        atlas.append({"file": relative, "sha256": actual})
    assert len(atlas) == 6, atlas

    log = ROOT.parent / "original-asset-import.log"
    if log.exists():
        shutil.copyfile(log, ROOT / log.name)
    report = {
        "status": "FAIL" if failures else "PASS_REQUIRED_ASSETS_PRESENT",
        "verified_utc": datetime.now(timezone.utc).isoformat(),
        "sprites": sprite_count, "frames": frames, "sounds": sounds,
        "unreferenced_yy_files_not_used_by_the_game": len(list((PROJECT / "sprites").glob("*/*.yy"))) - len(sprite_paths),
        "known_upstream_geometry_notes": geometry_notes,
        "steam_audit_exception": {
            "sprite": "sprBignameAtlas",
            "reason": "Epsilon's own CJK atlas is not in the official Steam sprite table",
            "verified_against_pinned_upstream_sha256": atlas,
        },
        "failures": failures,
        "scope": "Original game assets only, not Hardmode gameplay completeness",
    }
    (ROOT / "original-assets-receipt.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf8")
    print(json.dumps({"status": report["status"], "sprites": sprite_count, "frames": frames,
                      "sounds": sounds, "failure_count": len(failures), "geometry_notes": len(geometry_notes)}, ensure_ascii=False))
    assert not failures, f"{len(failures)} required assets failed; inspect original-assets-receipt.json"


if __name__ == "__main__":
    main()
