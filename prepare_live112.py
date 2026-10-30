"""Copy an isolated, forcibly muted UI-input test; never touch player saves."""
from pathlib import Path
import shutil,json,sys,subprocess
ROOT=Path(__file__).resolve().parent
for command in [[sys.executable,'-B','integrate_release112.py'],[sys.executable,'-B','register_gameplay_tests.py'],
                ['pwsh','-NoProfile','-File','build_local.ps1','-Target','windows']]:
    subprocess.run(command,cwd=ROOT,check=True)
stage=ROOT/'release112/live-probe';stage.mkdir(exist_ok=True)
old=ROOT/'deliverables/NuclearThrone.Hardmode-Windows-1.0.11'
files=json.loads((ROOT/'release111/windows-delivery-receipt.json').read_text(encoding='utf8'))['files']
for name in files:
    if name.endswith(('.cmd','.txt')) and name in ['Start-Hardmode.cmd','README.txt']:continue
    target=stage/name;target.parent.mkdir(parents=True,exist_ok=True)
    shutil.copyfile(old/name,target)
shutil.copyfile(stage/'NuclearThrone-Hardmode.exe',stage/'HardmodeInputProbe112.exe')
shutil.copyfile(ROOT/'build-windows/nuclearthronemobile.win',stage/'data.win')
shutil.copyfile(ROOT/'build-windows/options.ini',stage/'options.ini')
(stage/'live112.marker').write_text('isolated mute input test',encoding='ascii')
(stage/'state').mkdir(exist_ok=True)
(stage/'state/live112.marker').write_text('isolated mute input test',encoding='ascii')
print('Isolated UI probe ready:',stage/'HardmodeInputProbe112.exe')
