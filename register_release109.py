"""Rebuild the maintained 1.0.9 adapters in dependency order."""
from pathlib import Path
import subprocess
import sys

root=Path(__file__).resolve().parent
for script in [
    'native_compiler.py','register_generated.py','register_runtime.py',
    'register_world.py','register_legacy_base.py',
    'integrate_release102.py','integrate_release103.py','integrate_release104.py',
    'integrate_release105.py','integrate_release106.py','integrate_release107.py',
    'integrate_release108.py','import_warning109.py','integrate_release109.py',
    'register_menu_tests.py','register_gameplay_tests.py',
]:
    print(script,flush=True)
    subprocess.run([sys.executable,'-B',str(root/script)],cwd=root,check=True)
