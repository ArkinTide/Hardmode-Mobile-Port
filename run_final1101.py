"""Run only the final 1.1.1 validation list against one immutable desktop VM."""
from pathlib import Path
import subprocess,sys
from make_release1101_receipt import REQUIRED,NATIVE
ROOT=Path(__file__).resolve().parent
subprocess.run([sys.executable,'-B',str(ROOT/'run_release1101_checks.py'),*REQUIRED,
    *['native:'+kind for kind in NATIVE],'menu:30','menu:60','--keep-going'],cwd=ROOT,check=True)
