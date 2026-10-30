"""Preserve the two actual screenshots reviewed in the current conversation."""
from pathlib import Path
import hashlib,json,shutil
ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release111'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def main():
    digest=sha(ROOT/'build-windows/nuclearthronemobile.win')
    examples=[('throne,1,0,30,100,42,throne111','throne111-90.png',
        'Actual throne body and red carpet share the hall center; throne is fully visible, not only left flames.'),
        ('cavesinv,3,0,30,330,42,cave111','cave111-290.png',
        'After boss death the cave renders normal purple wall surfaces and transitions, retaining dark exterior fill.')]
    reviewed=[];folder=OUT/'visual';folder.mkdir(exist_ok=True)
    for scenario,name,note in examples:
        stem=scenario.replace(',','-')
        r=json.loads((ROOT/f'gameplay-{stem}-receipt.json').read_text())
        assert r['status']=='PASS' and r['vm_sha256']==digest
        src=ROOT/'build-windows'/('test-gameplay-'+stem)/name
        dst=folder/(stem+'-'+name);shutil.copyfile(src,dst)
        reviewed.append(dict(path=dst.relative_to(ROOT).as_posix(),sha256=sha(dst),scenario=scenario,manual_observation=note))
    (OUT/'visual-review.json').write_text(json.dumps(dict(reviewed=True,vm_sha256=digest,
        files=reviewed,limits='Only these two screenshots were visually reviewed. Automated checks cover additional states; no phone/manual campaign claim.'),indent=2)+'\n',encoding='utf8')
    print('Preserved two visually reviewed screenshots for',digest)

if __name__=='__main__':main()
