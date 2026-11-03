"""Import the native delta's exact embedded strips into local game resources."""
import base64,copy,hashlib,io,json,uuid
from PIL import Image
from compile_sync1100 import ROOT,NATIVE,OUT,clean
from gml_parser import definitions
from native_compiler import walk
from register_native import PROJECT,write
from create_project import load

def uid(name):return str(uuid.uuid5(uuid.NAMESPACE_URL,'hardmode-mobile-1100/'+name))
def main():
    project=load(PROJECT/'nuclearthronemobile.yyp')
    template=load(PROJECT/'sprites/sprBanditIdle/sprBanditIdle.yy')
    records=[]
    for d in definitions(clean((NATIVE/'mod/arkintide.mod.gml').read_text('utf8')),'arkintide.mod.gml'):
        for n in walk(d.body):
            if n.kind!='call' or n.args[0].kind!='identifier' or 'base64' not in n.args[0].args[0]:continue
            args=n.args[1];offset=1 if 'replace' in n.args[0].args[0] else 0
            data=base64.b64decode(args[offset].args[0][1:-1]);image=Image.open(io.BytesIO(data)).convert('RGBA')
            frames=int(args[offset+1].args[0]);ox=float(args[offset+2].args[0]);oy=float(args[offset+3].args[0])
            name='sprHMContent1100_'+str(n.line);folder=PROJECT/'sprites'/name;folder.mkdir(exist_ok=True)
            path='sprites/'+name+'/'+name+'.yy';meta=copy.deepcopy(template)
            width=image.width//frames;height=image.height;assert width*frames==image.width
            meta.update(name=name,width=width,height=height,bboxMode=0,parent={'name':'Sprites','path':'folders/Sprites.yy'})
            meta['%Name']=name;meta['frames']=[];layer=copy.deepcopy(template['layers'][0]);layer['name']=layer['%Name']=uid(name+'/layer');meta['layers']=[layer]
            keys=[];bbox=None
            for i in range(frames):
                frame=uid(name+'/frame/'+str(i));crop=image.crop((i*width,0,(i+1)*width,height));box=crop.getbbox()
                if box:bbox=box if bbox is None else (min(bbox[0],box[0]),min(bbox[1],box[1]),max(bbox[2],box[2]),max(bbox[3],box[3]))
                crop.save(folder/(frame+'.png'));layerpath=folder/'layers'/frame/(layer['name']+'.png');layerpath.parent.mkdir(parents=True,exist_ok=True);crop.save(layerpath)
                meta['frames'].append({'$GMSpriteFrame':'v1','%Name':frame,'name':frame,'resourceType':'GMSpriteFrame','resourceVersion':'2.0'})
                keys.append({'$Keyframe<SpriteFrameKeyframe>':'','Channels':{'0':{'$SpriteFrameKeyframe':'','Id':{'name':frame,'path':path},'resourceType':'SpriteFrameKeyframe','resourceVersion':'2.0'}},'Disabled':False,'id':uid(name+'/key/'+str(i)),'IsCreationKey':False,'Key':i,'Length':1,'resourceType':'Keyframe<SpriteFrameKeyframe>','resourceVersion':'2.0','Stretch':False})
            bbox=bbox or (0,0,width,height);meta.update(bbox_left=bbox[0],bbox_top=bbox[1],bbox_right=bbox[2]-1,bbox_bottom=bbox[3]-1)
            seq=meta['sequence'];seq.update(name=name,length=frames,xorigin=int(ox),yorigin=int(oy));seq['%Name']=name;seq['tracks'][0]['keyframes']['Keyframes']=keys
            write(path,json.dumps(meta,indent=2)+'\n')
            if not any(r['id']['path']==path for r in project['resources']):project['resources'].append({'id':{'name':name,'path':path}})
            records.append({'source':'arkintide.mod.gml','line':n.line,'native_resource':name,'frames':frames,'origin':[ox,oy],'png_sha256':hashlib.sha256(data).hexdigest(),'rgba_sha256':hashlib.sha256(image.tobytes()).hexdigest()})
    write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
    (OUT/'content-artwork.json').write_text(json.dumps(records,indent=2)+'\n',encoding='utf8')
    print('Imported exact content strips',len(records))

if __name__=='__main__':main()
