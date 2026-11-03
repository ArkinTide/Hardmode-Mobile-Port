"""Run real VM tests silently on a private desktop without input automation."""
from pathlib import Path
import argparse,ctypes,hashlib,json,re,subprocess,struct,shutil
from datetime import datetime,timezone
from vm_test_lock import lock_vm
import test_volume
ROOT=Path(__file__).resolve().parent

def main():
    parser=argparse.ArgumentParser();parser.add_argument('scenarios',nargs='+');parser.add_argument('--keep-going',action='store_true');args=parser.parse_args()
    lock_vm()
    vm=ROOT/'build-windows/nuclearthronemobile.win';digest=hashlib.sha256(vm.read_bytes()).hexdigest()
    out=ROOT/'release1100/tests';out.mkdir(exist_ok=True)
    # Muting resource gain in a separate VM prevents even startup audio.
    # CODE, objects, textures, and gameplay remain byte-identical.
    data=bytearray(vm.read_bytes());at=8;muted=0
    while at<len(data):
        tag,size=struct.unpack_from('<4sI',data,at)
        if tag==b'SOND':
            count=struct.unpack_from('<I',data,at+8)[0]
            for i in range(count):
                entry=struct.unpack_from('<I',data,at+12+i*4)[0]
                # Name/flags/type/file/effects precede the resource volume.
                struct.pack_into('<f',data,entry+20,0.0);muted+=1
        at+=8+size
    assert muted>100
    silent=ROOT/'build-windows/sync1100-silent.win';silent.write_bytes(data)
    user=ctypes.windll.user32;user.CreateDesktopW.restype=ctypes.c_void_p
    user.CreateDesktopW.argtypes=[ctypes.c_wchar_p,ctypes.c_wchar_p,ctypes.c_void_p,ctypes.c_ulong,ctypes.c_ulong,ctypes.c_void_p]
    desk=user.CreateDesktopW('HardmodeMobile1100Audit',None,None,0,0x1ff,None)
    assert desk,'Private desktop unavailable'
    failures=[]
    try:
        for scenario in args.scenarios:
            assert hashlib.sha256(vm.read_bytes()).hexdigest()==digest
            name=scenario.replace(',','-').replace(':','-');state=out/name;state.mkdir(exist_ok=True)
            log=state/'runner.log';info=subprocess.STARTUPINFO();info.dwFlags|=subprocess.STARTF_USESHOWWINDOW;info.wShowWindow=1;info.lpDesktop='HardmodeMobile1100Audit'
            kind='gameplay';timeout=90+float(scenario.split(',')[4])*0.12 if ',' in scenario else 75
            flags=['--hardmode-gameplay-tests','--hardmode-scenario='+scenario]
            if scenario.startswith('native:'):
                kind=scenario.split(':')[1];flags=['--hardmode-'+kind+'-tests']
            elif scenario.startswith('menu:'):
                kind='menu';flags=['--hardmode-menu-tests','--hardmode-menu-rate='+scenario.split(':')[1]]
            with log.open('wb') as output:
                p=subprocess.Popen(['C:/ProgramData/GameMakerStudio2-LTS2026/Cache/runtimes/runtime-2026.0.0.23/windows/x64/Runner.exe','-game',str(silent),*flags,'--hardmode-test-root='+state.as_posix()],cwd=ROOT/'build-windows',stdout=output,stderr=subprocess.STDOUT,startupinfo=info,creationflags=subprocess.CREATE_NO_WINDOW)
                helper=test_volume.configure(p)
                try:code=p.wait(timeout=timeout)
                except subprocess.TimeoutExpired:p.terminate();p.wait(timeout=5);code=-999
                test_volume.verify(helper)
            text=log.read_text('utf8',errors='replace');match=re.search('HARDMODE '+kind.upper()+r' RESULT (\{[^\r\n]+\})',text)
            result=dict(scenario=scenario,exit=code,vm_sha256=digest,silent_vm_sha256=hashlib.sha256(data).hexdigest(),muted_resources=muted,desktop='private, never activated',utc=datetime.now(timezone.utc).isoformat(),physical_device_tested=False)
            if code or not match or 'HARDMODE GAMEPLAY FAILED' in text:
                result.update(status='FAIL',details=text[-4500:]);(state/'receipt.json').write_text(json.dumps(result,indent=2),'utf8');print(json.dumps(result),flush=True)
                failures.append(scenario)
                if not args.keep_going:raise SystemExit(1)
                continue
            result.update(json.loads(match[1]));(state/'receipt.json').write_text(json.dumps(result,indent=2),'utf8');print(json.dumps(result),flush=True)
    finally:
        user.CloseDesktop.argtypes=[ctypes.c_void_p];user.CloseDesktop(desk)
    if failures:raise SystemExit('Failed scenarios: '+', '.join(failures))

if __name__=='__main__':main()
