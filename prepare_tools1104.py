"""Create this release's tooling once; never overwrite maintained tools."""
from pathlib import Path
ROOT=Path(__file__).resolve().parent

def create(path,text):
    if path.exists():
        raise FileExistsError(f'Preserve the maintained release tool: {path}')
    path.write_text(text,'utf8')

def main():
    pairs=[('run_release1103_checks.py','run_release1104_checks.py'),
           ('test_android1103.py','test_android1104.py'),
           ('audit_mobile_storage1103.py','audit_mobile_storage1104.py'),
           ('build_mobile1103.py','build_mobile1104.py'),
           ('prepare_publication1103.py','prepare_publication1104.py')]
    for old,new in pairs:
        text=(ROOT/old).read_text('utf8').replace('release1103','release1104')
        text=text.replace("('1.1.3',17)","('1.1.4',18)")
        text=text.replace('test_android1103.py','test_android1104.py').replace('audit_mobile_storage1103.py','audit_mobile_storage1104.py')
        text=text.replace('1.1.3 / build 17','1.1.4 / build 18').replace('1.1.3 packages','1.1.4 packages').replace('1.1.3 text-only','1.1.4 text-only')
        create(ROOT/new,text)
    pub=ROOT.parent.parent/'github-publish'
    text=(pub/'publish_hardmode1103.py').read_text('utf8')
    text=text.replace('release1103','release1104').replace('prepare_publication1103','prepare_publication1104')
    text=text.replace("VERSION='1.1.3'","VERSION='1.1.4'").replace('BUILD=17','BUILD=18')
    text=text.replace('1.1.3/build17','1.1.4/build18').replace('85605b15496a889e4adc99f400a8baec026528c2','529566e052e5634a49a45718eeb33740b02ca0eb')
    create(pub/'publish_hardmode1104.py',text)
    print('Created isolated1.1.4 tooling')

if __name__=='__main__':main()
