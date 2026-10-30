"""Collect only current-VM captures and paired desktop performance evidence."""
from pathlib import Path
from datetime import datetime, timezone
import hashlib, json, re, shutil
from PIL import Image, ImageDraw
from run_release108_checks import SCENARIOS

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release108'

def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()

def contact(name,paths,columns=3):
    w,h=480,294
    canvas=Image.new('RGB',(w*columns,h*((len(paths)+columns-1)//columns)),(25,25,25))
    draw=ImageDraw.Draw(canvas)
    for i,p in enumerate(paths):
        im=Image.open(p).convert('RGB');im.thumbnail((480,270))
        x=i%columns*w;y=i//columns*h
        canvas.paste(im,(x+(w-im.width)//2,y+24))
        draw.text((x+5,y+5),p.stem[:70],fill='white')
    canvas.save(OUT/name)

def main():
    vm=ROOT/'build-windows/nuclearthronemobile.win';digest=sha(vm)
    images={};groups={};routes=[];paired={};profiles={}
    for scenario in SCENARIOS:
        parts=scenario.split(',');mode=parts[6];fps=int(parts[3])
        prefix='gameplay-'+scenario.replace(',','-')
        receipt=json.loads((ROOT/(prefix+'-receipt.json')).read_text())
        assert receipt['status']=='PASS' and receipt['vm_sha256']==digest,scenario
        log=(ROOT/(prefix+'.log')).read_text(encoding='utf8',errors='replace')
        if mode in ['wall108','venuswall108','pickup108','tankportal108','venus106','venussecrets106','profile106','cavewalls107','junk107','water104','walls104']:
            paths=[]
            for p in sorted((ROOT/'build-windows'/('test-'+prefix)).glob('*.png')):
                # Repeated scenarios may leave differently numbered captures
                # from a retired VM. Only collect the current build's files.
                if p.stat().st_mtime<vm.stat().st_mtime:continue
                dest=OUT/('-'.join(parts[:4])+'-'+mode+'-'+p.name)
                shutil.copyfile(p,dest);images[dest.name]=sha(dest);paths.append(dest)
            assert paths,scenario
            groups.setdefault(mode,[]).extend(paths)
        if mode in ['filter108','beam108']:
            kind='FILTER108' if mode=='filter108' else 'BEAM108'
            match=re.search('HARDMODE '+kind+r' (\{[^\r\n]+\})',log);assert match
            paired[f'{kind}-{fps}']=json.loads(match[1])
        if mode=='profile106':
            match=re.search(r'HARDMODE FRAME106 (\{[^\r\n]+\})',log);assert match
            profiles['-'.join(parts[:4])]=json.loads(match[1])
        if mode in ['venus106','venussecrets106']:
            match=re.search(r'HARDMODE VENUS106 COMPLETE (\{[^\r\n]+\})',log);assert match
            result=json.loads(match[1]);expected=12 if mode=='venus106' else 17
            assert len(result['path'])==expected and all(result['boss'][k] for k in ['air_seen','ground_seen','air_attacked','ground_attacked'])
            routes.append({'scenario':scenario,**result})
            stagepaths=[p for p in groups[mode] if f'-{fps}-{mode}-venus-stage-' in p.name]
            assert len(stagepaths)==expected,(scenario,len(stagepaths))
            stagepaths.sort(key=lambda p:int(p.stem.rsplit('-',1)[1]))
            name=f'{mode}-{fps}-contact.png';contact(name,stagepaths,4);images[name]=sha(OUT/name)
    for mode in ['wall108','venuswall108','pickup108','tankportal108']:
        name=mode+'-contact.png';contact(name,groups[mode]);images[name]=sha(OUT/name)
    for fps in (30,60):
        receipt=json.loads((OUT/f'menu-{fps}-receipt.json').read_text())
        assert receipt['status']=='PASS' and receipt['vm_sha256']==digest
        for p in sorted((ROOT/f'build-windows/test-menu-{fps}').glob('menu-[0-4].png')):
            if p.stat().st_mtime<vm.stat().st_mtime:continue
            dest=OUT/f'menu-{fps}-{p.name}';shutil.copyfile(p,dest);images[dest.name]=sha(dest)
    (OUT/'visual-captures.json').write_text(json.dumps({'vm_sha256':digest,'images':images,
        'generated_utc':datetime.now(timezone.utc).isoformat(),'manual_review_required':True},indent=2)+'\n')
    (OUT/'performance.json').write_text(json.dumps({'vm_sha256':digest,'paired_same_scene_microbenchmarks':paired,
        'desktop_frame_samples':profiles,'physical_device_tested':False,
        'limits':['Desktop CPU timings are not phone frame rates.','Filter and beam pairs use the exact same scene in one test process.','Natural level generation differs between rates; frame profiles are not controlled before/after comparisons.']},indent=2)+'\n')
    (OUT/'venus-progression.json').write_text(json.dumps({'status':'PASS','vm_sha256':digest,'routes':routes,
        'method':'Automated source interaction and combat waypoints, real native collisions, elevators, two boss phases, escape car and return to junkyard 3-5.',
        'manual_playthrough':False,'physical_device_tested':False},indent=2)+'\n')
    print('Collected',len(images),'captures and',len(routes),'complete Venus routes')

if __name__=='__main__':main()
