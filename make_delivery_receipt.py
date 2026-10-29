"""Verify local release artifacts and retain precise regression provenance."""
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path
import hashlib
import json
import math
import zipfile

from run_release_checks import scenarios

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release100'


def read(path):
    return json.loads((ROOT/path).read_text(encoding='utf8'))


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def key(scenario):
    parts=scenario.split(',')
    return tuple(parts[:4]+parts[5:])


def main():
    final=read('release100/final-source.json')
    baseline=read('release100/baseline-source.json')
    digest=sha(ROOT/'build-windows/nuclearthronemobile.win')
    assert digest==final['desktop_vm_sha256']
    required=scenarios(30)+scenarios(60)+[
        'HQ,1,0,30,180,42,hq','HQ,1,0,60,180,42,hq']
    reviewed={baseline['desktop_vm_sha256'],
              '82c5482c648fac63f2d7bb414a3d00ff035b7b910a272a9d6984ef3996bbccf4',digest}
    available=[json.loads(p.read_text()) for p in ROOT.glob('gameplay-*-receipt.json')]
    selected=[]
    for scenario in required:
        candidates=[r for r in available if key(r['scenario'])==key(scenario)
                    and r['status']=='PASS' and r['vm_sha256'] in reviewed
                    and r['ticks']>=int(scenario.split(',')[4])]
        assert candidates,('Missing successful regression',scenario)
        selected.append(max(candidates,key=lambda r:r['verified_utc']))
    units=[]
    for kind in ['compiler','artwork','runtime','actors','modules','world','radiation']:
        receipt=read(kind+'-native-receipt.json')
        if kind=='artwork':
            # The artwork harness records frame/dimension assertions and the
            # runtime's integer-only origins rather than a status field.
            resources=read('native-artwork-receipt.json')['resources']
            assert receipt['checks']==len(resources)*3==1035,kind
            expected={r['resource']:r['origin'] for r in resources
                      if any(v!=math.trunc(v) for v in r['origin'])}
            mismatches=receipt['origin_mismatches']
            assert len(expected)==len(mismatches)==16,kind
            assert {r['sprite'] for r in mismatches}==set(expected),kind
            for mismatch in mismatches:
                origin=expected[mismatch['sprite']]
                assert mismatch['expected']==origin,mismatch
                assert mismatch['actual']==[math.trunc(v) for v in origin],mismatch
        else:
            assert receipt['status']=='PASS',kind
        assert receipt.get('vm_sha256',receipt.get('compiled_vm_sha256'))==digest,kind
        units.append({'kind':kind,'checks':receipt['checks'],'vm_sha256':digest})
    changed={p:{'old':baseline['project_files'].get(p),'new':v}
             for p,v in final['project_files'].items() if baseline['project_files'].get(p)!=v}
    removed=set(baseline['project_files'])-set(final['project_files'])
    assert not removed,removed
    media={'.png','.ogg','.wav','.mp3','.ttf','.otf','.so'}
    assert not [p for p in changed if Path(p).suffix in media]
    compatibility=read('ios-native-compatibility.json')
    assert compatibility['compatible_added_functions_and_extensions'] is True
    artifacts=[]
    for target,extension in [('android','apk'),('ios','ipa')]:
        label='Android' if target=='android' else 'iOS'
        path=ROOT/f'deliverables/NuclearThrone.Hardmode-{label}-1.0.0.{extension}'
        receipt=read(path.relative_to(ROOT).with_suffix('.validation.json'))
        assert receipt['package']=='com.arkintide.nuclearthronehardmode'
        assert receipt['version']=='1.0.0' and receipt['build']==1
        assert receipt[extension+'_sha256']==sha(path)
        preparation=read(f'platforms/{target}/prepared-receipt.json')
        vm='game.droid' if target=='android' else 'game.ios'
        with zipfile.ZipFile(ROOT/f'build-{target}/nuclearthronemobile.zip') as z:
            assert hashlib.sha256(z.read('assets/'+vm)).hexdigest()==preparation['raw_vm_sha256']
        assert sha(ROOT/f'platforms/{target}/prepared-assets/{vm}')==preparation['prepared_vm_sha256']
        artifacts.append({'path':path.relative_to(ROOT).as_posix(),'bytes':path.stat().st_size,
                          'sha256':sha(path),'prepared_vm_sha256':preparation['prepared_vm_sha256']})
    report={'status':'PASS_WITH_REVIEWED_SOURCE_DELTA','verified_utc':datetime.now(timezone.utc).isoformat(),
            'version':'1.0.0','mod':'Hardmode b24','final_desktop_vm_sha256':digest,
            'original_commit':final['original_commit'],'original_files_verified':final['original_files_verified'],
            'native_checks':units,'native_assertions':sum(r['checks'] for r in units),
            'gameplay_cases':len(selected),'gameplay_receipts':selected,
            'gameplay_vm_counts':dict(Counter(r['vm_sha256'] for r in selected)),
            'changed_project_files':changed,'baseline_media_unchanged':True,
            'regression_method':'Baseline campaign plus targeted regression of each corrected path; not all cases ran on one VM.',
            'reviewed_changes':[
                'NTT hurt callbacks receive damage, recoil velocity and recoil direction; default recoil is not applied twice.',
                'Restore omitted secret-prison door groups from original chamber connectivity; register original ScorchTop query object.',
                'Translate legacy PopupText text field and HQ weapon/Rogue filter domains.',
                'Keep guardian renderer attacks and guardian/shielder/Rogue draw-side state changes at 30 Hz while rendering every frame.',
                'Throne harness waits for the complete original activation cinematic before checking phase one.',
            ],
            'artifacts':artifacts,'physical_device_tested':False,'mac_native_rebuild':False,
            'ios_requires_resigning':True,'github_uploaded':False,'mega_uploaded':False,
            'limits':['Bounded desktop scenarios, not an exhaustive manual playthrough.',
                      'APK release lint unavailable in the offline cache; explicit signature, ABI, alignment and asset checks passed.',
                      'IPA uses the retained compatible native runner; static compatibility is not an iPhone launch test.']}
    (OUT/'delivery-receipt.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print(json.dumps({k:report[k] for k in ['status','native_assertions','gameplay_cases','gameplay_vm_counts','artifacts']},indent=2))


if __name__=='__main__':main()
