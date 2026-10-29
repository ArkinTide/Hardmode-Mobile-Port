"""Run explicitly selected native checks with bounded desktop processes."""
from pathlib import Path
from datetime import datetime, timezone
import argparse
import hashlib
import json
import re
import subprocess
import test_volume

ROOT=Path(__file__).resolve().parent


def main():
    from vm_test_lock import lock_vm
    lock_vm()
    args=argparse.ArgumentParser()
    args.add_argument("kind",choices=["compiler","artwork","runtime","actors","modules","world"])
    kind=args.parse_args().kind
    build=ROOT/"build-windows"
    state=build/("test-state-"+kind)
    state.mkdir(exist_ok=True)
    # Discard only the invalid empty-array fixture from the initial harness;
    # the original engine creates its actual preset schema on first launch.
    presets=state/"custom-mode.json"
    if presets.exists() and presets.read_text(encoding="utf8")=="[]":
        presets.unlink()
    log=ROOT/(kind+"-native-run.log")
    with log.open("wb") as output:
        process=subprocess.Popen([
            "C:/ProgramData/GameMakerStudio2-LTS2026/Cache/runtimes/runtime-2026.0.0.23/windows/x64/Runner.exe",
            "-game",str(build/"nuclearthronemobile.win"),"--hardmode-"+kind+"-tests",
            "--hardmode-test-root="+state.as_posix()],
            cwd=build,stdout=output,stderr=subprocess.STDOUT,creationflags=subprocess.CREATE_NO_WINDOW)
        volume_helper=test_volume.configure(process)
        try:
            code=process.wait(timeout=30)
        except subprocess.TimeoutExpired:
            process.terminate();process.wait(timeout=10)
            print(log.read_text(encoding="utf8",errors="replace")[-5500:])
            raise RuntimeError(f"Timed out: inspect {log}")
        test_volume.verify(volume_helper)
    text=log.read_text(encoding="utf8",errors="replace")
    match=re.search("HARDMODE "+kind.upper()+r" RESULT (\{[^\r\n]+\})",text)
    assert code==0 and match,f"Native failure, exit={code}:\n{text[-5500:]}"
    receipt=json.loads(match[1])
    receipt.update(verified_utc=datetime.now(timezone.utc).isoformat(),
                   vm_sha256=hashlib.sha256((build/"nuclearthronemobile.win").read_bytes()).hexdigest(),
                   physical_device_tested=False,full_mod_verified=False)
    (ROOT/(kind+"-native-receipt.json")).write_text(json.dumps(receipt,indent=2)+"\n",encoding="utf8")
    print(json.dumps(receipt))


if __name__=="__main__":
    main()
