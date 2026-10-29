"""Bounded real menu rendering regressions with isolated state and muted audio."""
from pathlib import Path
from datetime import datetime,timezone
import argparse,hashlib,json,re,subprocess
import test_volume

ROOT=Path(__file__).resolve().parent
from vm_test_lock import lock_vm
lock_vm()
parser=argparse.ArgumentParser();parser.add_argument('--output',default='release101')
out=ROOT/parser.parse_args().output;out.mkdir(exist_ok=True)
vm=ROOT/'build-windows/nuclearthronemobile.win'
digest=hashlib.sha256(vm.read_bytes()).hexdigest()
for rate in (30,60):
    state=ROOT/f'build-windows/test-menu-{rate}';state.mkdir(exist_ok=True)
    log=out/f'menu-{rate}.log'
    with log.open('wb') as output:
        p=subprocess.Popen([
            'C:/ProgramData/GameMakerStudio2-LTS2026/Cache/runtimes/runtime-2026.0.0.23/windows/x64/Runner.exe',
            '-game',str(vm),'--hardmode-menu-tests','--hardmode-menu-rate='+str(rate),
            '--hardmode-test-root='+state.as_posix()],cwd=vm.parent,stdout=output,stderr=subprocess.STDOUT,
            creationflags=subprocess.CREATE_NO_WINDOW)
        helper=test_volume.configure(p)
        try:code=p.wait(timeout=75)
        except subprocess.TimeoutExpired:p.terminate();p.wait(timeout=5);code=-999
        test_volume.verify(helper)
    assert hashlib.sha256(vm.read_bytes()).hexdigest()==digest,'VM changed during test'
    text=log.read_text(encoding='utf8',errors='replace')
    match=re.search(r'HARDMODE MENU RESULT (\{[^\r\n]+\})',text)
    assert code==0 and match and 'HARDMODE GAMEPLAY FAILED' not in text,text[-5000:]
    receipt=json.loads(match[1]);assert receipt['status']=='PASS' and receipt['rate']==rate
    receipt.update(vm_sha256=digest,verified_utc=datetime.now(timezone.utc).isoformat(),physical_device_tested=False)
    (out/f'menu-{rate}-receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps(receipt),flush=True)
