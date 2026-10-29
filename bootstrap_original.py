"""Export an exact upstream base, reusing bytes only when Git blob IDs match."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
import base64
import hashlib
import json
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parent
WORKSPACE = ROOT.parents[1]
METADATA = ROOT / "original-epsilon"
DEST = ROOT / "original-source"
LOCAL = WORKSPACE / "work/ntte-complete/project"
sys.path.insert(0, str(WORKSPACE / "github-publish"))
from cleanup_connection import api


def blob_id(data):
    return hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()


def git(*args):
    return subprocess.check_output(["git", "-c", "safe.directory=" + str(METADATA), "-C", str(METADATA), *args])


def main():
    selection = json.loads((ROOT / "upstream-selection.json").read_text(encoding="utf8"))
    assert git("rev-parse", "HEAD").decode().strip() == selection["commit"]
    entries = []
    for row in git("ls-tree", "-rz", "HEAD").split(b"\0"):
        if not row:
            continue
        header, name = row.split(b"\t", 1)
        mode, kind, oid = header.decode().split()
        assert mode in {"100644", "100755"} and kind == "blob"
        name = name.decode("utf8")
        assert not Path(name).is_absolute() and ".." not in Path(name).parts
        entries.append((name, oid))
    DEST.mkdir(exist_ok=True)
    matching, missing = [], []
    pins = {}
    for name, oid in entries:
        target, local = DEST / name, LOCAL / name
        data = None
        if target.is_file() and blob_id(target.read_bytes()) == oid:
            data = target.read_bytes()
        elif local.is_file():
            candidate = local.read_bytes()
            if blob_id(candidate) == oid:
                data = candidate
            elif blob_id(candidate.replace(b"\r\n", b"\n")) == oid:
                data = candidate.replace(b"\r\n", b"\n")
        if data is None:
            missing.append((name, oid))
            continue
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(data)
        matching.append(name)
        pins[name] = {"git_blob": oid, "sha256": hashlib.sha256(data).hexdigest()}
    plan = {"commit": selection["commit"], "total_files": len(entries),
            "exact_original_files_reused": len(matching), "upstream_fetch_required": len(missing),
            "fetch": [{"path": name, "git_blob": oid} for name, oid in missing]}
    (ROOT / "original-bootstrap-plan.json").write_text(json.dumps(plan, ensure_ascii=False, indent=2) + "\n", encoding="utf8")
    print(json.dumps({k: v for k, v in plan.items() if k != "fetch"}, indent=2), flush=True)
    if "--plan-only" in sys.argv:
        return
    remaining = api("rate_limit")["resources"]["core"]["remaining"]
    unique_missing = {oid for _, oid in missing}
    assert len(unique_missing) + 20 < remaining, ("Insufficient authenticated read API quota", len(unique_missing), remaining)

    def fetch(oid):
        for attempt in range(3):
            try:
                result = api("repos/kcd-shichen/NuclearThrone-Recreated-Epsilon/git/blobs/" + oid)
                assert result["encoding"] == "base64"
                data = base64.b64decode(result["content"])
                assert blob_id(data) == oid
                return oid, data
            except Exception:
                if attempt == 2:
                    raise
                time.sleep(attempt + 1)

    fetched = {}
    with ThreadPoolExecutor(max_workers=6) as pool:
        jobs = {pool.submit(fetch, oid): oid for oid in unique_missing}
        for n, job in enumerate(as_completed(jobs), 1):
            oid, data = job.result()
            fetched[oid] = data
            if n % 30 == 0 or n == len(jobs):
                print("Fetched verified original blobs:", n, "/", len(jobs), flush=True)
    for name, oid in missing:
        data = fetched[oid]
        target = DEST / name
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(data)
        pins[name] = {"git_blob": oid, "sha256": hashlib.sha256(data).hexdigest()}
    assert len(pins) == len(entries)
    for name, oid in entries:
        assert blob_id((DEST / name).read_bytes()) == oid
    (ROOT / "original-source-manifest.json").write_text(json.dumps({
        "status": "PASS", "repository": selection["repository"], "commit": selection["commit"],
        "files": pins, "ntte_code_reused_without_original_hash_match": False,
    }, ensure_ascii=False, indent=2) + "\n", encoding="utf8")
    print("Exact upstream source export: PASS", len(pins), "files", flush=True)


if __name__ == "__main__":
    main()
