"""Freeze user-supplied Hardmode input and inventory without executing GML."""
from pathlib import Path
from datetime import datetime, timezone
import hashlib
import json
import re
import shutil

ROOT = Path(__file__).resolve().parent
SOURCE = Path("C:/Users/ArkinTide/Downloads/hardmode")
REFERENCE = ROOT / "reference/hardmode-b24"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write(name, value):
    (ROOT / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf8")


def lexical_code(text):
    # Mask strings/comments before counting constructs; embedded PNG strings
    # and attached prose must never be interpreted as code or instructions.
    pattern = r'"[^"]*"|\'[^\']*\'|`[^`]*`|/\*[\s\S]*?\*/|//[^\n]*'
    return re.sub(pattern, lambda m: re.sub(r"[^\n]", " ", m[0]), text)


def main():
    assert (SOURCE / "main.txt").is_file()
    if not REFERENCE.exists():
        shutil.copytree(SOURCE, REFERENCE)
    source_files = {p.relative_to(SOURCE).as_posix(): sha(p) for p in SOURCE.rglob("*") if p.is_file()}
    reference_files = {p.relative_to(REFERENCE).as_posix(): sha(p) for p in REFERENCE.rglob("*") if p.is_file()}
    assert source_files == reference_files, "Input changed after freezing; create a new reference version"
    write("input-manifest.json", {
        "source_directory": str(SOURCE), "reference_directory": str(REFERENCE),
        "saved_utc": datetime.now(timezone.utc).isoformat(), "files": reference_files,
    })
    main_code = lexical_code((REFERENCE / "main.txt").read_text(encoding="utf-8-sig"))
    load_order = []
    for kind, name in re.findall(r"^/load(mod|wep)\s+([^\r\n]+)", main_code, re.M):
        path = name.strip() + (".wep.gml" if kind == "wep" else ".gml" if name.strip().endswith(".area") else ".mod.gml")
        assert (REFERENCE / path).is_file(), path
        load_order.append({"kind": kind, "module": name.strip(), "path": path})
    assert len(load_order) == len({row["path"] for row in load_order})
    inventory = []
    for row in load_order:
        p = REFERENCE / row["path"]
        text = p.read_text(encoding="utf-8-sig")
        code = lexical_code(text)
        definitions = re.findall(r"^\s*#define\s+([A-Za-z_]\w*)(?:\(([^\n]*)\))?", code, re.M)
        inventory.append({
            **row, "bytes": p.stat().st_size, "lines": text.count("\n") + 1,
            "definitions": [{"name": name, "parameters": args} for name, args in definitions],
            "wait_statements": len(re.findall(r"\bwait\b", code)),
            "fork_calls": len(re.findall(r"\bfork\s*\(", code)),
            "called_functions": sorted(set(re.findall(r"\b([A-Za-z_]\w*)\s*\(", code))),
            "embedded_sprite_declarations": len(re.findall(r"\bsprite_(?:add(?:_weapon)?|replace)_base64\s*\(", code)),
        })
    loaded = {row["path"] for row in inventory}
    unreferenced = sorted(name for name in reference_files if name.endswith(".gml") and name not in loaded)
    write("mod-inventory.json", {
        "status": "INPUT_INVENTORY_ONLY_NOT_PORT_COMPLETE", "source_version": "b24", "author": "Blaac",
        "file_count": len(reference_files), "loaded_modules": len(inventory),
        "definitions": sum(len(row["definitions"]) for row in inventory),
        "wait_statements": sum(row["wait_statements"] for row in inventory),
        "fork_calls": sum(row["fork_calls"] for row in inventory),
        "embedded_sprite_declarations": sum(row["embedded_sprite_declarations"] for row in inventory),
        "unreferenced_gml_files": unreferenced, "modules": inventory,
    })
    # Preserve later user requirements and validation state on reinventory.
    initial_requirements = {
        "name": "Nuclear Throne: Hardmode", "mod_version": "b24", "port_version": "1.0.0",
        "targets": ["android", "ios"], "base": "Original Epsilon game source with original game assets",
        "include_ntte_gameplay": False, "include_undergrowth": False, "include_detailsplus": False,
        "upload_to_github": False, "upload_to_mega": False, "delivery": "Local APK and IPA",
        "independent_application_identifier": "com.arkintide.nuclearthronehardmode",
        "independent_save_directory_required": True,
        "radiation_policy": {
            "before_maximum_level": "Hardmode b24 modified radiation drops",
            "at_and_after_maximum_level": "Restore unmodified original drops",
            "maximum_level": 10,
            "already_spawned_enemies": "Restore only the Hardmode reduction delta, preserving absorbed radiation and other rewards",
            "native_radiation_absorption": "Preserve original Hardmode mechanic unless its interaction requires further review",
        },
    }
    if not (ROOT / "requirements.json").exists():
        write("requirements.json", initial_requirements)
    print(json.dumps({"files_frozen": len(reference_files), "loaded_modules": len(inventory),
        "definitions": sum(len(row["definitions"]) for row in inventory),
        "wait_statements": sum(row["wait_statements"] for row in inventory),
        "fork_calls": sum(row["fork_calls"] for row in inventory),
        "unreferenced_gml_files": unreferenced}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
