from pathlib import Path
import argparse,subprocess,re,json,hashlib
from datetime import datetime,timezone
import test_volume

ROOT=Path(__file__).resolve().parent
from vm_test_lock import lock_vm
lock_vm()
parser=argparse.ArgumentParser()
parser.add_argument('scenarios',nargs='*',default=['1,1,0,30'])
parser.add_argument('--keep-going',action='store_true')
args=parser.parse_args()
receipts=[]
failures=[]
vm=ROOT/'build-windows/nuclearthronemobile.win'
vm_hash=hashlib.sha256(vm.read_bytes()).hexdigest()
for scenario in args.scenarios:
    assert hashlib.sha256(vm.read_bytes()).hexdigest()==vm_hash, 'VM changed during gameplay suite'
    name=scenario.replace(',','-')
    state=ROOT/'build-windows'/('test-gameplay-'+name)
    state.mkdir(exist_ok=True)
    log=ROOT/('gameplay-'+name+'.log')
    with log.open('wb') as output:
        process=subprocess.Popen([
            'C:/ProgramData/GameMakerStudio2-LTS2026/Cache/runtimes/runtime-2026.0.0.23/windows/x64/Runner.exe',
            '-game',str(ROOT/'build-windows/nuclearthronemobile.win'),
            '--hardmode-gameplay-tests','--hardmode-scenario='+scenario,
            '--hardmode-test-root='+state.as_posix()],cwd=ROOT/'build-windows',
            stdout=output,stderr=subprocess.STDOUT,creationflags=subprocess.CREATE_NO_WINDOW)
        volume_helper=test_volume.configure(process)
        duration=float(scenario.split(',')[4])/30 if len(scenario.split(','))>4 else 6
        generation_budget=5*(float(scenario.split(',')[4])/120) if scenario.endswith(',route') else 0
        # Multiple windowed test runners can be throttled by Windows when
        # unfocused. Keep a bounded allowance for that scheduling overhead.
        try: code=process.wait(timeout=60+duration*2+generation_budget)
        except subprocess.TimeoutExpired:
            process.terminate();process.wait(timeout=5);code=-999
        test_volume.verify(volume_helper)
    text=log.read_text(encoding='utf8',errors='replace')
    assert hashlib.sha256(vm.read_bytes()).hexdigest()==vm_hash, 'VM rebuilt during scenario; result discarded'
    result=re.search(r'HARDMODE GAMEPLAY RESULT (\{[^\r\n]+\})',text)
    if code or not result or 'HARDMODE GAMEPLAY FAILED' in text:
        failure=re.search(r'HARDMODE GAMEPLAY FAILED ([\s\S]+?)(?:###game_end###|\Z)',text)
        message=failure[1].strip() if failure else text[-1500:]
        print(f'FAIL {scenario} exit={code}: {message}',flush=True)
        failures.append({'scenario':scenario,'exit':code,'message':message})
        if args.keep_going:continue
        raise RuntimeError(f'Gameplay failed: {scenario}, exit={code}')
    receipt=json.loads(result[1])
    receipt.update(verified_utc=datetime.now(timezone.utc).isoformat(),
        vm_sha256=vm_hash,
        physical_device_tested=False,full_mod_verified=False)
    (ROOT/('gameplay-'+name+'-receipt.json')).write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf8')
    receipts.append(receipt)
    print(json.dumps(receipt),flush=True)
if failures:
    (ROOT/'gameplay-failures.json').write_text(json.dumps(failures,indent=2)+'\n',encoding='utf8')
    raise SystemExit(1)
