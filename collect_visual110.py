"""Collect current-VM wall/map screenshots; review remains a separate action."""
from pathlib import Path
import hashlib,json,shutil
from PIL import Image,ImageOps,ImageDraw
from run_release107_checks import current

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release110'
CASES=['labs,1,0,30,150,42,walls110','palace,1,0,30,150,42,walls110',
       '1,1,5,30,150,42,maps110','throne,1,3,60,150,42,throne110']
def main():
    digest=hashlib.sha256((ROOT/'build-windows/nuclearthronemobile.win').read_bytes()).hexdigest()
    folder=OUT/'visual';folder.mkdir(exist_ok=True)
    canvas=Image.new('RGB',(1280,820),'#303030');draw=ImageDraw.Draw(canvas)
    rows=[]
    for i,scenario in enumerate(CASES):
        assert current(scenario,digest),scenario
        source=ROOT/'build-windows'/('test-gameplay-'+scenario.replace(',','-'))/'gameplay.png'
        assert source.is_file(),source
        destination=folder/(scenario.replace(',','-')+'.png');shutil.copyfile(source,destination)
        im=Image.open(destination).convert('RGB');im=ImageOps.contain(im,(640,380))
        x=(i%2)*640;y=(i//2)*410
        canvas.paste(im,(x,y+25));draw.text((x+6,y+6),scenario,fill='white')
        rows.append(dict(path=destination.relative_to(ROOT).as_posix(),sha256=hashlib.sha256(destination.read_bytes()).hexdigest(),scenario=scenario))
    canvas.save(folder/'contact.png')
    (OUT/'visual-inventory.json').write_text(json.dumps(dict(vm_sha256=digest,images=rows),indent=2)+'\n')
    print(folder/'contact.png')
if __name__=='__main__':main()
