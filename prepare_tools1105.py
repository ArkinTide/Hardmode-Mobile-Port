"""Create isolated 1.1.5 tools; never replace earlier release evidence."""
from pathlib import Path

ROOT=Path(__file__).resolve().parent

def main():
    for old,new in [('set_release1104.py','set_release1105.py'),
                    ('run_release1104_checks.py','run_release1105_checks.py'),
                    ('test_android1104.py','test_android1105.py'),
                    ('audit_mobile_storage1104.py','audit_mobile_storage1105.py'),
                    ('build_mobile1104.py','build_mobile1105.py'),
                    ('package_gate1104.py','package_gate1105.py'),
                    ('prepare_publication1104.py','prepare_publication1105.py')]:
        path=ROOT/new
        if path.exists():continue
        text=(ROOT/old).read_text('utf8')
        text=text.replace('release1104','release1105').replace('HardmodeMobile1104Audit','HardmodeMobile1105Audit')
        text=text.replace("('1.1.4',18)","('1.1.5',19)")
        text=text.replace("VERSION = \\'1.1.4\\'", "VERSION = \\'1.1.5\\'")
        if old=='set_release1104.py':
            text=text.replace('1.1.3','1.1.4').replace('1.1.4.0','1.1.5.0')
            text=text.replace("='1.1.4'","='1.1.5'").replace("else '1.1.4'","else '1.1.5'")
            text=text.replace('Hardmode 1.1.4\'','Hardmode 1.1.5\'').replace('Hardmode 1.1.4"','Hardmode 1.1.5"')
            text=text.replace('BUILD = 18','BUILD = 19').replace('data[key]=18','data[key]=19')
        text=text.replace('test_android1104.py','test_android1105.py').replace('audit_mobile_storage1104.py','audit_mobile_storage1105.py')
        text=text.replace('1.1.4 / build 18','1.1.5 / build 19').replace('1.1.4 packages','1.1.5 packages').replace('1.1.4 text-only','1.1.5 text-only')
        if old=='package_gate1104.py':
            text=text.replace('1.1.3','1.1.4').replace("'1.1.4', 17", "'1.1.4', 18")
            text=text.replace('Fresh 1.1.4 package','Fresh 1.1.5 package')
        path.write_text(text,'utf8')
    (ROOT/'release1105').mkdir(exist_ok=True)
    print('Created isolated 1.1.5 tools')

if __name__=='__main__':main()
