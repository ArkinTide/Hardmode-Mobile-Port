"""Freeze the released 1.1.4 water call tree by renaming only identifiers.

The input is the verified GitHub source checkout, never the edited project.
The fixture and its source/function hashes remain in the release audit.
"""
from pathlib import Path
import hashlib
import json
import re
import sys

ROOT = Path(__file__).resolve().parent
SOURCE_SHA = "48ac73f965f83240a1a88c1253207aff27866715"
DEFAULT = ROOT.parents[1] / "analysis/hardmode-restore-20261112/github-source/ArkinTide-Hardmode-Mobile-Port-48ac73f"
FUNCTIONS = {
    "scrHMWaterKey": ("repairs104.gml", "scrHMGameplayWaterKey114For115"),
    "scrHMWaterMap": ("repairs104.gml", "scrHMGameplayWaterMap114For115"),
    "scrHMWaterAt": ("repairs104.gml", "scrHMGameplayWaterAt114For115"),
    "scrHMWaterBank111": ("repairs111.gml", "scrHMGameplayWaterBank114For115"),
    "scrHMWaterRects109": ("repairs109.gml", "scrHMGameplayWaterRects114For115"),
    "scrHMWaterExact109": ("repairs109.gml", "scrHMGameplayWaterDispatch114For115"),
    "scrHMWaterBatchBegin1102": ("repairs1102.gml", "scrHMGameplayWaterBatchBegin114For115"),
    "scrHMWaterBatchEnd1102": ("repairs1102.gml", "scrHMGameplayWaterBatchEnd114For115"),
    "scrHMWaterExact1102": ("repairs1102.gml", "scrHMGameplayWaterExact114For115"),
    "scrHMSwimSupported112": ("repairs112.gml", "scrHMGameplayWaterSupport114For115"),
    "scrHMWaterPotential1103": ("sync1103_performance.gml", "scrHMGameplayWaterPotential114For115"),
    "scrHMWaterPossible1103": ("sync1103_performance.gml", "scrHMGameplayWaterPossible114For115"),
}


def function(text, name):
    start = text.index("function " + name + "(")
    end = text.find("\nfunction ", start + 1)
    return (text[start:] if end < 0 else text[start:end]).strip()


def digest(text):
    return hashlib.sha256(text.encode("utf-8")).hexdigest()


def main():
    source = Path(sys.argv[1]) if len(sys.argv) > 1 else DEFAULT
    recorded=json.loads((ROOT/'tests/water-baseline114-manifest.json').read_text('utf8')) if (ROOT/'tests/water-baseline114-manifest.json').exists() else None
    manifest = {"source_commit": SOURCE_SHA, "operation": "function identifier renaming only", "functions": []}
    bodies = []
    for name, (file, replacement) in FUNCTIONS.items():
        original = function((source / "native" / file).read_text(encoding="utf-8-sig"), name)
        if recorded:
            expected=next(row for row in recorded['functions'] if row['name']==name)
            assert digest(original)==expected['source_function_sha256'], name+' immutable baseline hash mismatch'
        frozen = original
        for old, (_, new) in FUNCTIONS.items():
            frozen = re.sub(r"\b" + re.escape(old) + r"\b", new, frozen)
        bodies.append(frozen)
        manifest["functions"].append({"source": "native/" + file, "name": name, "frozen_name": replacement,
                                      "source_function_sha256": digest(original), "frozen_function_sha256": digest(frozen)})
    path = ROOT / "project/scripts/scrHMGameplay1105Performance/scrHMGameplay1105Performance.gml"
    text = path.read_text(encoding="utf-8-sig")
    start = text.index("// Frozen 1.1.4")
    end = text.index("// kind 0 is", start)
    block = "// Frozen 1.1.4 complete water call tree from GitHub commit\n// " + SOURCE_SHA + ". Only function identifiers are renamed.\n// See release1105/water-baseline114-manifest.json for source function hashes.\n" + "\n\n".join(bodies) + "\n\n"
    path.write_text(text[:start] + block + text[end:], encoding="utf-8")
    encoded=json.dumps(manifest, indent=2)+'\n'
    (ROOT/'tests/water-baseline114-manifest.json').write_text(encoded,encoding='utf-8')
    (ROOT/'release1105/water-baseline114-manifest.json').write_text(encoded,encoding='utf-8')
    print(json.dumps({"status": "frozen", "source_commit": SOURCE_SHA, "functions": len(bodies)}))


if __name__ == "__main__":
    main()
