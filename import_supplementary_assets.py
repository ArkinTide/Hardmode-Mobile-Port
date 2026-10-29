"""Import original assets used by Hardmode but absent from Epsilon's YYP.

Read-only access to the installed game archive; never runs the Steam game.
Only the twelve specifically audited resources are added to this project.
"""
from pathlib import Path
import copy,hashlib,io,json,struct,uuid,sys
from PIL import Image
from create_project import load
from register_native import ROOT,PROJECT,write

SOURCE=Path('D:/Steam/steamapps/common/Nuclear Throne')
data=(SOURCE/'data.win').read_bytes()
u32=lambda p:struct.unpack_from('<I',data,p)[0]
def string_ref(p):
    start=u32(p)
    return data[start:data.index(b'\0',start)].decode('utf8')
chunks={};pos=8
while pos<len(data):
    chunks[data[pos:pos+4].decode('ascii')]=pos
    pos+=8+u32(pos+4)

def texture(number):
    tgin=chunks['TGIN']
    ptr=u32(tgin+16+number*4)
    group,directory,extension=[string_ref(ptr+n*4) for n in range(3)]
    txtr=u32(chunks['TXTR']+12+number*4)
    index=u32(txtr+20)
    if directory and directory!='DynTex' and extension=='.png':
        return Image.open(SOURCE/directory/(group+'_'+str(index)+extension)).convert('RGBA')
    image_ptr=u32(txtr+28)
    assert data[image_ptr:image_ptr+4]==b'\x89PNG',('Unsupported original texture',number,group)
    return Image.open(io.BytesIO(data[image_ptr:])).convert('RGBA')

def guid(name):return str(uuid.uuid5(uuid.NAMESPACE_URL,'hardmode-original-supplement/'+name))

def main():
    project=load(PROJECT/'nuclearthronemobile.yyp')
    missing=list(load(ROOT/'asset-name-audit.json'))+sys.argv[1:]
    sprites=load(PROJECT/'node-scripts/game_sprites.json')
    template=load(PROJECT/'sprites/sprBanditIdle/sprBanditIdle.yy')
    cache={};receipt=[]
    for name in missing:
        source=sprites[name]
        sprite=copy.deepcopy(template)
        relative=f'sprites/{name}/{name}.yy'
        sprite.update(name=name,width=source['width'],height=source['height'],
            bboxMode=source['bboxMode'],bbox_left=source['margin']['left'],
            bbox_right=source['margin']['right'],bbox_top=source['margin']['top'],
            bbox_bottom=source['margin']['bottom'])
        sprite['%Name']=name;sprite['frames']=[]
        sprite['parent']={'name':'Sprites','path':'folders/Sprites.yy'}
        layer=sprite['layers'][0];layer['name']=layer['%Name']=guid(name+'/layer')
        keys=[];hashes=[]
        destination=PROJECT/'sprites'/name;destination.mkdir(parents=True,exist_ok=True)
        for i,page in enumerate(source['tPageItems']):
            number=page['texturePageId']
            if number not in cache:cache[number]=texture(number)
            frame=Image.new('RGBA',(source['width'],source['height']))
            x,y=page['sourcePosition'];w,h=page['sourceSize']
            frame.paste(cache[number].crop((x,y,x+w,y+h)),tuple(page['targetPosition']))
            frame_id=guid(name+'/frame/'+str(i))
            frame.save(destination/(frame_id+'.png'))
            layer_file=destination/'layers'/frame_id/(layer['name']+'.png')
            layer_file.parent.mkdir(parents=True,exist_ok=True);frame.save(layer_file)
            hashes.append(hashlib.sha256(frame.tobytes()).hexdigest())
            sprite['frames'].append({'$GMSpriteFrame':'v1','%Name':frame_id,'name':frame_id,'resourceType':'GMSpriteFrame','resourceVersion':'2.0'})
            keys.append({'$Keyframe<SpriteFrameKeyframe>':'','Channels':{'0':{
                '$SpriteFrameKeyframe':'','Id':{'name':frame_id,'path':relative},'resourceType':'SpriteFrameKeyframe','resourceVersion':'2.0'}},
                'Disabled':False,'id':guid(name+'/key/'+str(i)),'IsCreationKey':False,
                'Key':i,'Length':1,'resourceType':'Keyframe<SpriteFrameKeyframe>','resourceVersion':'2.0','Stretch':False})
        sprite['sequence'].update(length=len(sprite['frames']),xorigin=source['originX'],yorigin=source['originY'])
        sprite['sequence']['tracks'][0]['keyframes']['Keyframes']=keys
        write(relative,json.dumps(sprite,indent=2)+'\n')
        if not any(r['id']['path']==relative for r in project['resources']):
            project['resources'].append({'id':{'name':name,'path':relative}})
        receipt.append({'name':name,'frames':len(hashes),'pixel_sha256':hashes})
    write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
    (ROOT/'supplementary-assets-receipt.json').write_text(json.dumps({
        'archive_sha256':hashlib.sha256(data).hexdigest(),'resources':receipt},indent=2)+'\n',encoding='utf8')
    print('Imported',len(receipt),'original supplementary sprites')

if __name__=='__main__':main()
