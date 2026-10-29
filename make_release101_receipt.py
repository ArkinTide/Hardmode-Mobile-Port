"""Verify this release without changing the preserved 1.0.0 evidence."""
from pathlib import Path
from datetime import datetime,timezone
import hashlib,json,zipfile
from PIL import Image,ImageChops,ImageDraw
from create_project import load
from release_config import VERSION,BUILD,PACKAGE
from run_release101_checks import SCENARIOS,KINDS

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release101'


def read(path):return json.loads((ROOT/path).read_text(encoding='utf8'))
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    final=read('release101/final-source.json');baseline=read('release101/baseline-source.json')
    digest=sha(ROOT/'build-windows/nuclearthronemobile.win')
    assert final['desktop_vm_sha256']==digest
    for rel,expected in final['project_files'].items():assert sha(ROOT/rel)==expected,rel
    changed={p:{'old':baseline['project_files'].get(p),'new':v} for p,v in final['project_files'].items()
             if baseline['project_files'].get(p)!=v}
    assert not set(baseline['project_files'])-set(final['project_files'])
    media={p for p in changed if Path(p).suffix.lower() in {'.png','.ogg','.wav','.mp3','.ttf','.otf','.so'}}
    assert media=={f'project/fonts/{f}/{f}.png' for f in ('fntCJK','fntCJKBig')},media
    font_reports=[]
    for font in ('fntCJK','fntCJKBig'):
        olddir=ROOT/'original-source/fonts'/font;newdir=ROOT/'project/fonts'/font
        assert sha(olddir/(font+'.png'))==baseline['project_files'][f'project/fonts/{font}/{font}.png']
        old=load(olddir/(font+'.yy'));new=load(newdir/(font+'.yy'))
        before=Image.open(olddir/(font+'.png')).convert('RGBA')
        after=Image.open(newdir/(font+'.png')).convert('RGBA')
        assert before.size==after.size
        for key,glyph in old['glyphs'].items():assert new['glyphs'][key]==glyph,(font,key)
        added=set(new['glyphs'])-set(old['glyphs'])
        assert sorted(map(int,added))==[25119,26000,34597,34612,40132,40761]
        mask=Image.new('L',before.size);draw=ImageDraw.Draw(mask)
        for key in added:
            g=new['glyphs'][key]
            draw.rectangle((g['x'],g['y'],g['x']+g['w']-1,g['y']+g['h']-1),fill=255)
        difference=ImageChops.difference(before,after)
        difference.paste((0,0,0,0),mask=mask)
        assert all(channel.getbbox() is None for channel in difference.split()),font
        font_reports.append({'font':font,'added_codepoints':sorted(map(int,added)),
                             'all_other_pixels_and_existing_glyph_metrics_unchanged':True})
    menus=[read(f'release101/menu-{rate}-receipt.json') for rate in (30,60)]
    for r in menus:assert r['status']=='PASS' and r['vm_sha256']==digest and r['shilling_draws']>150 and r['version_draws']>150
    gameplay=read('release101/gameplay-regression.json')
    assert [r['scenario'] for r in gameplay]==SCENARIOS
    for r in gameplay:assert r['status']=='PASS' and r['vm_sha256']==digest
    native=[read('release101/'+kind+'-native-receipt.json') for kind in KINDS]
    for kind,r in zip(KINDS,native):
        assert r.get('vm_sha256',r.get('compiled_vm_sha256'))==digest,kind
        if kind=='artwork':assert r['checks']==1035 and len(r['origin_mismatches'])==16
        else:assert r['status']=='PASS',kind
    localization=read('release101/localization-audit.json')
    assert not localization['untranslated_literals']
    compatibility=read('ios-native-compatibility.json')
    assert compatibility['compatible_added_functions_and_extensions'] is True
    assert read('asset-name-audit.json')=={}
    artifacts=[]
    for target,label,extension in [('android','Android','apk'),('ios','iOS','ipa')]:
        path=ROOT/f'deliverables/NuclearThrone.Hardmode-{label}-{VERSION}.{extension}'
        receipt=read(path.relative_to(ROOT).with_suffix('.validation.json'))
        assert receipt['package']==PACKAGE and receipt['version']==VERSION and receipt['build']==BUILD
        assert receipt[extension+'_sha256']==sha(path)
        preparation=read(f'platforms/{target}/prepared-receipt.json')
        vm='game.droid' if target=='android' else 'game.ios'
        with zipfile.ZipFile(ROOT/f'build-{target}/nuclearthronemobile.zip') as z:
            assert hashlib.sha256(z.read('assets/'+vm)).hexdigest()==preparation['raw_vm_sha256']
        assert sha(ROOT/f'platforms/{target}/prepared-assets/{vm}')==preparation['prepared_vm_sha256']
        artifacts.append({'path':path.relative_to(ROOT).as_posix(),'bytes':path.stat().st_size,
                          'sha256':sha(path),'prepared_vm_sha256':preparation['prepared_vm_sha256']})
    old_android=read('deliverables/NuclearThrone.Hardmode-Android-1.0.0.validation.json')
    new_android=read('deliverables/NuclearThrone.Hardmode-Android-1.0.1.validation.json')
    assert old_android['certificate_sha256']==new_android['certificate_sha256']
    report={'status':'PASS','verified_utc':datetime.now(timezone.utc).isoformat(),'version':VERSION,'build':BUILD,
            'final_desktop_vm_sha256':digest,'original_commit':final['original_commit'],
            'original_files_verified':final['original_files_verified'],'changed_project_files':changed,
            'menu_receipts':menus,'menu_assertions':sum(r['checks'] for r in menus),
            'gameplay_receipts':gameplay,'gameplay_cases':len(gameplay),
            'native_assertions':sum(r['checks'] for r in native),'native_checks':dict(zip(KINDS,native)),
            'fonts':font_reports,'localization':localization,'artifacts':artifacts,
            'baseline_release':'release100/delivery-receipt.json','regression_method':
            '1.0.0 baseline campaign plus current 30/60 FPS real menu/language-switch and focused Chinese gameplay checks.',
            'physical_device_tested':False,'mac_native_rebuild':False,'ios_requires_resigning':True,
            'github_uploaded':False,'mega_uploaded':False,'limits':[
                'Desktop automated regressions, not a complete manual playthrough or phone acceptance test.',
                'Android release lint dependency unavailable offline; signature, ABI, alignment and exact asset checks passed.',
                'iOS uses retained compatible native runner with new VM/resources and requires resigning.']}
    (OUT/'delivery-receipt.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print(json.dumps({k:report[k] for k in ('status','version','native_assertions','menu_assertions','gameplay_cases','artifacts')},indent=2))


if __name__=='__main__':main()
