"""Import two supplied/source-derived portal warning icons, without AI art."""
from copy import deepcopy
import hashlib
import json
from pathlib import Path
from PIL import Image
from create_project import load
from register_artwork import guid
from register_native import PROJECT, ROOT, write

assets=ROOT/'artwork/warnings108'
assets.mkdir(parents=True,exist_ok=True)
van=assets/'van.png'
if not van.exists():
    source=Path('C:/Users/ArkinTide/Desktop/Pets+/sprites/pets/Van/sprVanPetIdle.png')
    van.write_bytes(source.read_bytes())
tank=assets/'tank.png'
base=PROJECT/'sprites/sprHM_enemies_mod_106'
meta=load(base/(base.name+'.yy'))
with Image.open(base/(meta['frames'][0]['name']+'.png')) as image:
    image.convert('RGBA').crop((13,6,51,46)).resize((19,20),Image.Resampling.NEAREST).save(tank)

project=load(PROJECT/'nuclearthronemobile.yyp')
template=load(PROJECT/'sprites/sprBanditIdle/sprBanditIdle.yy')
receipt=[]
for name,source in [('sprHMVanWarning108',van),('sprHMIDPDTankWarning108',tank)]:
    image=Image.open(source).convert('RGBA')
    obj=deepcopy(template);obj['name']=obj['%Name']=name
    obj['width'],obj['height']=image.size
    obj['parent']={'name':'Sprites','path':'folders/Sprites.yy'}
    obj['textureGroupId']={'name':'Default','path':'texturegroups/Default'}
    obj['origin']=4
    frame=guid(name+'/frame');layer=guid(name+'/layer')
    obj['frames']=[{'$GMSpriteFrame':'v1','%Name':frame,'name':frame,'resourceType':'GMSpriteFrame','resourceVersion':'2.0'}]
    obj['layers']=obj['layers'][:1];obj['layers'][0]['name']=obj['layers'][0]['%Name']=layer
    box=image.getbbox();obj.update(bboxMode=0,bbox_left=box[0],bbox_top=box[1],bbox_right=box[2]-1,bbox_bottom=box[3]-1)
    seq=obj['sequence'];seq['name']=seq['%Name']=name;seq['length']=1
    seq['xorigin']=image.width//2;seq['yorigin']=image.height//2
    relative=f'sprites/{name}/{name}.yy'
    seq['tracks'][0]['keyframes']['Keyframes']=[{
        '$Keyframe<SpriteFrameKeyframe>':'','Channels':{'0':{'$SpriteFrameKeyframe':'','Id':{'name':frame,'path':relative},'resourceType':'SpriteFrameKeyframe','resourceVersion':'2.0'}},
        'Disabled':False,'id':guid(name+'/key'),'IsCreationKey':False,'Key':0,'Length':1,'resourceType':'Keyframe<SpriteFrameKeyframe>','resourceVersion':'2.0','Stretch':False}]
    write(relative,json.dumps(obj,indent=2)+'\n')
    dest=PROJECT/'sprites'/name
    image.save(dest/(frame+'.png'))
    layered=dest/'layers'/frame/(layer+'.png');layered.parent.mkdir(parents=True,exist_ok=True);image.save(layered)
    if not any(r['id']['path']==relative for r in project['resources']):project['resources'].append({'id':{'name':name,'path':relative}})
    receipt.append({'sprite':name,'size':list(image.size),'source':str(source.relative_to(ROOT)),'file_sha256':hashlib.sha256(source.read_bytes()).hexdigest()})
write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
(ROOT/'release108/warning-artwork.json').write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf8')
print('Registered portal warning icons')
