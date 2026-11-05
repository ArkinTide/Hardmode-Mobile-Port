"""Register the exact native report's portrait/title strips in the mobile atlas."""
import copy,hashlib,json,uuid
from PIL import Image
from sync1103_tools import ROOT,PROJECT,OUT,save
from create_project import load
from sync1103_bosses_integrate import ASSETS

def uid(value):return str(uuid.uuid5(uuid.NAMESPACE_URL,'hardmode-mobile-1103/'+value))

def apply(project):
    template=load(PROJECT/'sprites/sprBanditIdle/sprBanditIdle.yy');records=[]
    for row in ASSETS:
        source=ROOT/row['source'];raw=source.read_bytes();image=Image.open(source).convert('RGBA')
        name=row['name'];frames=row['frames'];ox,oy=row['origin']
        width=image.width//frames;height=image.height;assert width*frames==image.width
        path='sprites/'+name+'/'+name+'.yy';folder=PROJECT/'sprites'/name;folder.mkdir(exist_ok=True)
        meta=copy.deepcopy(template);meta.update(name=name,width=width,height=height,bboxMode=0,parent={'name':'Sprites','path':'folders/Sprites.yy'})
        meta['%Name']=name;meta['frames']=[];layer=copy.deepcopy(template['layers'][0]);layer['name']=layer['%Name']=uid(name+'/layer');meta['layers']=[layer]
        keys=[];bbox=None
        for index in range(frames):
            frame=uid(name+'/frame/'+str(index));crop=image.crop((index*width,0,(index+1)*width,height));box=crop.getbbox()
            if box:bbox=box if bbox is None else (min(bbox[0],box[0]),min(bbox[1],box[1]),max(bbox[2],box[2]),max(bbox[3],box[3]))
            crop.save(folder/(frame+'.png'));target=folder/'layers'/frame/(layer['name']+'.png');target.parent.mkdir(parents=True,exist_ok=True);crop.save(target)
            meta['frames'].append({'$GMSpriteFrame':'v1','%Name':frame,'name':frame,'resourceType':'GMSpriteFrame','resourceVersion':'2.0'})
            keys.append({'$Keyframe<SpriteFrameKeyframe>':'','Channels':{'0':{'$SpriteFrameKeyframe':'','Id':{'name':frame,'path':path},'resourceType':'SpriteFrameKeyframe','resourceVersion':'2.0'}},'Disabled':False,'id':uid(name+'/key/'+str(index)),'IsCreationKey':False,'Key':index,'Length':1,'resourceType':'Keyframe<SpriteFrameKeyframe>','resourceVersion':'2.0','Stretch':False})
        bbox=bbox or (0,0,width,height);meta.update(bbox_left=bbox[0],bbox_top=bbox[1],bbox_right=bbox[2]-1,bbox_bottom=bbox[3]-1)
        meta['sequence'].update(name=name,length=frames,xorigin=ox,yorigin=oy);meta['sequence']['%Name']=name
        meta['sequence']['tracks'][0]['keyframes']['Keyframes']=keys
        save(path,json.dumps(meta,indent=2)+'\n')
        if not any(r['id']['path']==path for r in project['resources']):project['resources'].append({'id':{'name':name,'path':path}})
        records.append(dict(row,png_sha256=hashlib.sha256(raw).hexdigest(),rgba_sha256=hashlib.sha256(image.tobytes()).hexdigest(),size=[image.width,image.height]))
    (OUT/'artwork.json').write_text(json.dumps(records,indent=2)+'\n','utf8')
