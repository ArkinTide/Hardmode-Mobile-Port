"""Create version-isolated verification/packaging helpers, preserving old receipts."""
from pathlib import Path
ROOT=Path(__file__).resolve().parent

def main():
    for name in ('run_release1101_checks.py','build_mobile1101.py','test_android1101.py','audit_mobile_storage1101.py'):
        dest=ROOT/name.replace('1101','1102')
        assert not dest.exists(),dest
        text=(ROOT/name).read_text('utf8').replace('1101','1102').replace('1.1.1','1.1.2')
        text=text.replace("('1.1.2',15)","('1.1.2',16)")
        if name=='run_release1101_checks.py':
            text=text.replace("'HARDMODE GAMEPLAY FAILED' in text", "any(marker in text for marker in ('HARDMODE GAMEPLAY FAILED','ERROR!!!','FATAL ERROR','Stack Overflow detected!!!'))")
        dest.write_text(text,'utf8')
    print('Created isolated 1.1.2 test and mobile-package tools')
if __name__=='__main__':main()
