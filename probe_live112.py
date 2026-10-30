"""Open only an isolated, muted development runner for OS-input observation."""
from pathlib import Path
import subprocess,sys
import test_volume
from vm_test_lock import lock_vm
ROOT=Path(__file__).resolve().parent
lock_vm()
state=ROOT/'build-windows/test-live112';state.mkdir(exist_ok=True)
with (ROOT/'release112/live-input.log').open('wb') as stream:
    p=subprocess.Popen(['C:/ProgramData/GameMakerStudio2-LTS2026/Cache/runtimes/runtime-2026.0.0.23/windows/x64/Runner.exe',
        '-game',str(ROOT/'build-windows/nuclearthronemobile.win'),'--hardmode-gameplay-tests',
        '--hardmode-scenario=1,1,0,60,3600,42,'+(sys.argv[1] if len(sys.argv)>1 else 'idle'),
        '--hardmode-test-root='+state.as_posix()],cwd=ROOT/'build-windows',stdout=stream,stderr=subprocess.STDOUT,
        creationflags=subprocess.CREATE_NO_WINDOW)
    helper=test_volume.configure(p)
    print('Isolated muted runner PID',p.pid,flush=True)
    try:p.wait(timeout=200)
    except subprocess.TimeoutExpired:p.terminate();p.wait(timeout=5)
    test_volume.verify(helper)
