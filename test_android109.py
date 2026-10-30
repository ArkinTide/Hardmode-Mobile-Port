"""Compile the shipped Android pacer and exercise its clock independently of GML."""
from pathlib import Path
import hashlib,json,subprocess
from datetime import datetime,timezone

ROOT=Path(__file__).resolve().parent
TOOLS=ROOT.parent/'ntte-complete/android-delivery/toolchain'

def main():
    jdk=next(TOOLS.glob('jdk-17*'))
    out=ROOT/'release109/android-pacer';out.mkdir(exist_ok=True)
    files=[ROOT/'android'/name for name in ('HardmodeFramePacer.java','HardmodeFramePacerTest.java')]
    subprocess.run([str(jdk/'bin/javac.exe'),'-d',str(out),*[str(p) for p in files]],check=True)
    result=subprocess.run([str(jdk/'bin/java.exe'),'-cp',str(out),'com.arkintide.nuclearthronehardmode.HardmodeFramePacerTest'],capture_output=True,text=True,check=True)
    assert 'PASS Hardmode Android pacing 12' in result.stdout
    renderer=ROOT/'platforms/android/gradle-project/com.arkintide.nuclearthronehardmode/src/main/java/com/arkintide/nuclearthronehardmode/DemoRenderer.java'
    text=renderer.read_text(encoding='utf8')
    hook='hardmodePacer109.awaitFrame(RunnerJNILib.mGameSpeedControl);'
    assert text.count(hook)==1
    assert text.index('RunnerJNILib.UpdateGameSpeed()')<text.index(hook)<text.index('int ret = RunnerJNILib.Process(')
    assert (renderer.parent/'HardmodeFramePacer.java').read_bytes()==files[0].read_bytes()
    report={'status':'PASS','verified_utc':datetime.now(timezone.utc).isoformat(),'checks':12,
        'source_sha256':{p.relative_to(ROOT).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in files},
        'renderer_sha256':hashlib.sha256(renderer.read_bytes()).hexdigest(),
        'coverage':['30/60 FPS native callback upper bound over ten monotonic seconds','premature wakeups','pause/resume without catch-up burst','rate changes','native startup rate zero'],
        'physical_device_tested':False,'limits':['Host Java deterministic clock tests validate the production pacer; actual phone cadence remains device-dependent.']}
    (ROOT/'release109/android-pacing.json').write_text(json.dumps(report,indent=2)+'\n')
    print(result.stdout.strip())

if __name__=='__main__':main()
