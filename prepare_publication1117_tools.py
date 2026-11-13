"""Prepare a publisher; this does not stage, commit, upload or use a network."""
from pathlib import Path
import json

ROOT=Path(__file__).resolve().parent

def main():
    baseline=json.loads((ROOT/'release1107/baseline.json').read_text('utf8'))
    assert (baseline['version'],baseline['build'])==('1.1.6',20)
    publisher=ROOT.parent.parent/'github-publish'
    source=publisher/'publish_hardmode1106.py'
    destination=publisher/'publish_hardmode1107.py'
    text=source.read_text('utf8')
    for old,new in [('hardmode-mobile-1116','hardmode-mobile-1117'),
                    ('release1106','release1107'),('prepare_publication1106','prepare_publication1107'),
                    ("VERSION='1.1.6'","VERSION='1.1.7'"),('BUILD=20','BUILD=21'),
                    ('1.1.6/build20','1.1.7/build21')]:
        assert old in text,old
        text=text.replace(old,new)
    old="BASE='dde1d552c1d92b590206f60b4ac25649ea5a17fc'"
    assert text.count(old)==1
    text=text.replace(old,"BASE='"+baseline['commit']+"'")
    if destination.exists():assert destination.read_text('utf8')==text,'Review an existing publisher before replacing it'
    else:destination.write_text(text,'utf8')
    print('Prepared 1.1.7 publisher with the recorded 1.1.6 source parent; not executed')

if __name__=='__main__':main()
