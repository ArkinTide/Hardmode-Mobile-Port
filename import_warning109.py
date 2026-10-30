"""Preserve the user's exact supplied tank warning pixels and provenance."""
import hashlib,json,shutil
from pathlib import Path
from PIL import Image
from create_project import load
from register_native import ROOT,PROJECT,write

source=Path('C:/Users/ArkinTide/Desktop/sprMutant8BSit.png')
saved=ROOT/'artwork/warnings109/tank.png'
saved.parent.mkdir(parents=True,exist_ok=True)
if source.exists():shutil.copyfile(source,saved)
assert saved.is_file(),'Missing supplied warning image'
image=Image.open(saved).convert('RGBA')
name='sprHMIDPDTankWarning108';dest=PROJECT/'sprites'/name
meta=load(dest/(name+'.yy'))
meta['width'],meta['height']=image.size
box=image.getbbox();assert box
meta.update(bbox_left=box[0],bbox_top=box[1],bbox_right=box[2]-1,bbox_bottom=box[3]-1)
meta['sequence']['xorigin']=image.width//2;meta['sequence']['yorigin']=image.height//2
frame=meta['frames'][0]['name'];layer=meta['layers'][0]['name']
image.save(dest/(frame+'.png'));image.save(dest/'layers'/frame/(layer+'.png'))
write(f'sprites/{name}/{name}.yy',json.dumps(meta,indent=2)+'\n')
(ROOT/'release109/warning-artwork.json').write_text(json.dumps({
    'status':'PASS','source':str(source),'preserved':'artwork/warnings109/tank.png',
    'source_sha256':hashlib.sha256(saved.read_bytes()).hexdigest(),
    'size':list(image.size),'rgba_sha256':hashlib.sha256(image.tobytes()).hexdigest(),
    'changes':'No scaling or pixel edits; retain separate native red exclamation warning.'},indent=2)+'\n')
print('Imported exact supplied tank warning',image.size)
