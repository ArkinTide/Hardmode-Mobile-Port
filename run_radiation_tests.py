"""Exercise native Hardmode radiation code in the freshly built Windows VM."""
from datetime import datetime, timezone
from pathlib import Path
import hashlib
import json
import re
import subprocess
import test_volume

ROOT = Path(__file__).resolve().parent
BUILD = ROOT / "build-windows"
RUNNER = Path("C:/ProgramData/GameMakerStudio2-LTS2026/Cache/runtimes/runtime-2026.0.0.23/windows/x64/Runner.exe")


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    log = ROOT / "radiation-native-run.log"
    state=BUILD/"test-state-radiation"
    state.mkdir(exist_ok=True)
    presets=state/"custom-mode.json"
    if presets.exists() and presets.read_text(encoding="utf8")=="[]":
        presets.unlink()
    with log.open("wb") as stream:
        process = subprocess.Popen(
            [str(RUNNER), "-game", str(BUILD / "nuclearthronemobile.win"), "--hardmode-radiation-tests",
             "--hardmode-test-root="+state.as_posix()],
            cwd=BUILD, stdout=stream, stderr=subprocess.STDOUT,
            creationflags=subprocess.CREATE_NO_WINDOW,
        )
        volume_helper=test_volume.configure(process)
        try:
            code = process.wait(timeout=45)
        except subprocess.TimeoutExpired:
            process.terminate()
            process.wait(timeout=10)
            raise RuntimeError(f"Native radiation tests did not finish; inspect {log}")
        test_volume.verify(volume_helper)
    text = log.read_text(encoding="utf8", errors="replace")
    match = re.search(r"HARDMODE RADIATION RESULT (\{[^\r\n]+\})", text)
    assert code == 0 and match, f"Native regression failed, exit={code}:\n{text[-7000:]}"
    report = json.loads(match[1])
    assert report["status"] == "PASS" and report["checks"] >= 100, report
    report.update(
        verified_utc=datetime.now(timezone.utc).isoformat(),
        runtime=str(RUNNER),
        sources={str(p.relative_to(ROOT)): sha(p) for p in [
            ROOT / "native/radiation.gml", ROOT / "tests/radiation.gml",
            ROOT / "project/objects/enemy/Destroy_0.gml",
            ROOT / "project/objects/GameCont/Step_0.gml",
        ]},
        compiled_vm_sha256=sha(BUILD / "nuclearthronemobile.win"),
        scope="Radiation policy only; this does not certify the full Hardmode port",
    )
    (ROOT / "radiation-native-receipt.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf8")
    print(json.dumps(report, ensure_ascii=False))


if __name__ == "__main__":
    main()
