"""Collect current-VM screenshots and desktop microprofiles for review."""
from pathlib import Path
from datetime import datetime, timezone
import argparse, hashlib, json, re, shutil
from PIL import Image, ImageDraw

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release106'


def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()


def contact(name, paths, columns):
    width,height=480,292
    canvas=Image.new('RGB',(width*columns,height*((len(paths)+columns-1)//columns)),(28,28,28))
    draw=ImageDraw.Draw(canvas)
    for i,path in enumerate(paths):
        source=Image.open(path).convert('RGB');source.thumbnail((480,270))
        x=(i%columns)*width;y=(i//columns)*height
        canvas.paste(source,(x+(width-source.width)//2,y+22))
        draw.text((x+5,y+4),path.stem,fill='white')
    canvas.save(OUT/name)


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--complete',action='store_true')
    args=parser.parse_args()
    vm=ROOT/'build-windows/nuclearthronemobile.win';digest=sha(vm)
    images={};profiles={}
    def collect(scenario, pattern):
        prefix='gameplay-'+scenario.replace(',','-')
        receipt=json.loads((ROOT/(prefix+'-receipt.json')).read_text())
        assert receipt['status']=='PASS' and receipt['vm_sha256']==digest
        paths=[]
        for p in (ROOT/'build-windows'/('test-'+prefix)).glob(pattern):
            assert p.stat().st_mtime>=vm.stat().st_mtime,p
            dest=OUT/(scenario.split(',')[6]+'-'+scenario.split(',')[3]+'-'+p.name)
            shutil.copyfile(p,dest);images[dest.name]=sha(dest);paths.append(dest)
        return paths
    for rate in (30,60):
        for mode, area, sub, ticks in [('water104','sewers',2,60),('oasis104','oasis',1,30),
                                      ('walls104','1',1,260),('intro104','1',1,90)]:
            scenario=f'{area},{sub},0,{rate},{ticks},42,{mode}'
            paths=collect(scenario,mode+'-*.png');assert paths,scenario
            log=(ROOT/('gameplay-'+scenario.replace(',','-')+'.log')).read_text(errors='replace')
            for name,record in re.findall(r'HARDMODE (\w+) PROFILE (\{[^\r\n]+\})',log):
                profiles[f'{name}-{rate}']=json.loads(record)
    world=[OUT/f'{mode}-{rate}-{mode}-{tick}.png' for mode,tick in
           [('water104',26),('oasis104',15),('walls104',246)] for rate in (30,60)]
    contact('world-contact.png',world,2)
    intros=[OUT/f'intro104-{rate}-intro104-{tick}.png' for rate in (30,60) for tick in (12,20,35,60)]
    contact('intro-contact.png',intros,4)
    if args.complete:
        menus=[]
        for rate in (30,60):
            receipt=json.loads((OUT/f'menu-{rate}-receipt.json').read_text())
            assert receipt['vm_sha256']==digest
            paths=sorted((ROOT/f'build-windows/test-menu-{rate}').glob('menu-[0-4].png'))
            assert len(paths)==5
            for p in paths:
                assert p.stat().st_mtime>=vm.stat().st_mtime,p
                dest=OUT/f'menu-{rate}-{p.name}';shutil.copyfile(p,dest)
                images[dest.name]=sha(dest);menus.append(dest)
            portraits=collect(f'1,1,0,{rate},65,42,visual','intro-*.png')
            contact(f'boss-intro-{rate}-contact.png',portraits,4)
            collect(f'sewers,2,0,{rate},130,42,sewer103','*.png')
        contact('menu-contact.png',menus,4)
    extra=[]
    for rate in (30,60):
        for mode,area,sub,ticks in [('water105','sewers',2,110),('walls105','1',1,25),('crystal105','1',1,45),('font105','1',1,90)]:
            scenario=f'{area},{sub},0,{rate},{ticks},42,{mode}'
            if mode=='font105':scenario+=',Simplified Chinese'
            paths=collect(scenario,mode+'-*.png');assert paths,scenario
            extra+=paths
            log=(ROOT/('gameplay-'+scenario.replace(',','-')+'.log')).read_text(encoding='utf8',errors='replace')
            for name,record in re.findall(r'HARDMODE (\w+) PROFILE (\{[^\r\n]+\})',log):
                profiles[f'{name}-{rate}']=json.loads(record)
    contact('repairs105-contact.png',extra,4)
    for name in ('world-contact.png','intro-contact.png','menu-contact.png',
                 'boss-intro-30-contact.png','boss-intro-60-contact.png','repairs105-contact.png'):
        if (OUT/name).exists(): images[name]=sha(OUT/name)
    newest=[]
    for rate in (30,60):
        for area,sub,ticks,mode in [('1',1,170,'profile106'),('venuz',4,170,'profile106'),('throne',1,170,'profile106'),('venuz',1,1200,'attack106')]:
            scenario=f'{area},{sub},0,{rate},{ticks},42,{mode}'
            paths=collect(scenario,mode+'-*.png');assert paths,scenario
            newest+=paths
            log=(ROOT/('gameplay-'+scenario.replace(',','-')+'.log')).read_text(encoding='utf8',errors='replace')
            for record in re.findall(r'HARDMODE FRAME106 (\{[^\r\n]+\})',log):
                profiles[f'FRAME106-{area}-{sub}-{rate}']=json.loads(record)
    contact('repairs106-contact.png',newest,4)
    images['repairs106-contact.png']=sha(OUT/'repairs106-contact.png')
    venus=[]
    for mode in ('venus106','venussecrets106'):
        for rate in (30,60):
            scenario=f'venuz,1,0,{rate},18000,42,{mode}'
            captures=collect(scenario,'venus-stage-*.png')
            assert len(captures)==(12 if mode=='venus106' else 17),scenario
            captures.sort(key=lambda p:int(p.stem.rsplit('-',1)[1]))
            sheet=f'{mode}-{rate}-contact.png';contact(sheet,captures,4)
            images[sheet]=sha(OUT/sheet)
            log=(ROOT/('gameplay-'+scenario.replace(',','-')+'.log')).read_text(encoding='utf8',errors='replace')
            match=re.search(r'HARDMODE VENUS106 COMPLETE (\{[^\r\n]+\})',log)
            assert match,scenario
            result=json.loads(match[1]);assert len(result['path'])==len(captures)
            venus.append({'scenario':scenario,**result})
    (OUT/'venus-progression.json').write_text(json.dumps({
        'status':'PASS','vm_sha256':digest,'routes':venus,
        'method':'Automated combat and interaction waypoints, native Bullet1 collisions, source door/elevator and two boss phase callbacks, actual escape-car input and natural return transition.',
        'boss_attack_evidence':'Observe both phases from creation, including arrival. Air uses creator-qualified surviving projectiles or the source burst counter changed after projectile creation; ground uses actual ammo consumption. Every route requires both phases and both attacks.',
        'physical_device_tested':False,'manual_playthrough':False,
        'entry':'Starts inside the first Venus stage; overworld car entrance is covered by separate contracts, not this continuous route.'},indent=2)+'\n')
    (OUT/'visual-images.json').write_text(json.dumps({'vm_sha256':digest,'images':images},indent=2)+'\n')
    report={'vm_sha256':digest,'recorded_utc':datetime.now(timezone.utc).isoformat(),
            'method':'Real desktop gameplay callbacks; timer values are microseconds.',
            'physical_device_tested':False,'profiles':profiles,
            'limits':['Desktop profiles include unpaused BeginStep through PostDraw CPU work for FRAME106; they do not measure GPU completion or phone frame rate.',
                      'FRAME106 cases run alone. Other small helper profiles may share desktop CPU/GPU with a second isolated regression process.',
                      'Break-wall samples include native debris, sounds and neighborhood updates.']}
    (OUT/'performance.json').write_text(json.dumps(report,indent=2)+'\n')
    print('Current VM captures:',len(images),'profiles:',len(profiles))


if __name__=='__main__':main()
