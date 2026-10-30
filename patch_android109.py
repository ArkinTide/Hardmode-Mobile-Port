"""Keep Android simulation cadence independent of high-refresh display callbacks."""
from pathlib import Path
import shutil

ROOT = Path(__file__).resolve().parent
JAVA = ROOT/'platforms/android/gradle-project/com.arkintide.nuclearthronehardmode/src/main/java/com/arkintide/nuclearthronehardmode'

def main():
    shutil.copyfile(ROOT/'android/HardmodeFramePacer.java', JAVA/'HardmodeFramePacer.java')
    path = JAVA/'DemoRenderer.java'
    text = path.read_text(encoding='utf8')
    if 'private final HardmodeFramePacer hardmodePacer109' not in text:
        import re
        text, count = re.subn(r'(public class DemoRenderer[^\{]*\{)',
            r'\1\n    private final HardmodeFramePacer hardmodePacer109 = new HardmodeFramePacer();', text, count=1)
        assert count == 1
    marker = 'int ret = RunnerJNILib.Process('
    insertion = 'hardmodePacer109.awaitFrame(RunnerJNILib.mGameSpeedControl);\n                    '
    if insertion+marker not in text:
        assert text.count(marker) == 1
        text = text.replace(marker, insertion+marker)
    assert text.index('RunnerJNILib.UpdateGameSpeed()') < text.index(insertion)
    path.write_text(text, encoding='utf8')
    print('Android monotonic native callback pacing registered')

if __name__ == '__main__': main()
