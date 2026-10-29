"""Keep the compiled Windows VM fixed for each bounded regression runner."""
from pathlib import Path
import atexit,json,os


def lock_vm():
    path=Path(__file__).resolve().parent/'build-windows/.vm-test-in-use.json'
    path.parent.mkdir(exist_ok=True)
    try:
        with path.open('x',encoding='utf8') as f:
            json.dump({'pid':os.getpid(),'purpose':'Windows VM regression in progress'},f)
    except FileExistsError:
        raise RuntimeError('A Windows VM test lock exists; finish its process before rebuilding or testing.') from None
    def release():
        if path.exists() and json.loads(path.read_text(encoding='utf8'))['pid']==os.getpid():
            path.unlink()
    atexit.register(release)
