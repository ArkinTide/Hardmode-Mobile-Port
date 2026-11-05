"""Build fresh mobile resources and validate both 1.1.3 packages."""
from pathlib import Path
import argparse,hashlib,json,subprocess,sys,time,zipfile
from datetime import datetime,timezone
from release_config import VERSION,BUILD

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release1103'

def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()

def source_binding():
    assert (VERSION,BUILD)==('1.1.3',17)
    frozen=json.loads((OUT/'final-source.json').read_text('utf8'))
    for group in ('project_files','development_sources'):
        for path,digest in frozen[group].items():assert sha(ROOT/path)==digest,('Source changed after freeze',path)
    assert sha(ROOT/'build-windows/nuclearthronemobile.win')==frozen['desktop_vm_sha256']
    return dict(source_manifest_sha256=sha(OUT/'final-source.json'),
                source_code_archive_sha256=sha(OUT/'final-code.zip'),
                desktop_vm_sha256=frozen['desktop_vm_sha256'])

def resource_record(target,started=None):
    path=ROOT/f'build-{target}/nuclearthronemobile.zip'
    if started is not None:assert path.stat().st_mtime>=started,('Stale resources',target)
    vm='game.droid' if target=='android' else 'game.ios'
    with zipfile.ZipFile(path) as archive:
        assert archive.testzip() is None
        digest=hashlib.sha256(archive.read('assets/'+vm)).hexdigest()
    return dict(zip_sha256=sha(path),raw_vm_sha256=digest)


def run(arguments,name,allow_resource_error=False):
    started=time.time()
    with (OUT/name).open('wb') as stream:
        result=subprocess.run(arguments,cwd=ROOT,stdout=stream,stderr=subprocess.STDOUT)
    if result.returncode and allow_resource_error:
        resource=ROOT/'build-android/nuclearthronemobile.zip'
        assert resource.is_file() and resource.stat().st_mtime>=started,'Android resources are stale'
        log=(ROOT/'build-android.log').read_text(encoding='utf8',errors='replace')
        assert ('System.UnauthorizedAccessException' in log and
                'WADSaver`1.HandleAndroidExtensions' in log and
                "Access to the path 'C:\\Users\\ArkinTide' is denied." in log),log[-3500:]
        print('Android Igor extension-path failure after fresh resource ZIP; using offline Gradle',flush=True)
    else:
        assert result.returncode==0,(OUT/name).read_text(encoding='utf8',errors='replace')[-3500:]
    print(name,'completed',flush=True)


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--packages-only',action='store_true')
    args=parser.parse_args()
    binding=source_binding()
    receipt_path=OUT/'mobile-resource-build.json'
    if not args.packages_only:
        android_started=time.time()
        run(['pwsh','-NoProfile','-File','build_local.ps1','-Target','android'],'mobile-android-build.log',True)
        android=resource_record('android',android_started)
        android['built_utc']=datetime.now(timezone.utc).isoformat()
        ios_started=time.time()
        run(['pwsh','-NoProfile','-File','build_local.ps1','-Target','ios'],'mobile-ios-build.log')
        ios=resource_record('ios',ios_started)
        ios['built_utc']=datetime.now(timezone.utc).isoformat()
        assert source_binding()==binding,'Source mutated during mobile compilation'
        receipt=dict(status='PASS',version=VERSION,build=BUILD,**binding,targets=dict(android=android,ios=ios))
        receipt_path.write_text(json.dumps(receipt,indent=2)+'\n','utf8')
    else:
        receipt=json.loads(receipt_path.read_text('utf8'))
        assert (receipt['status'],receipt['version'],receipt['build'])==('PASS',VERSION,BUILD)
        for key,value in binding.items():assert receipt[key]==value,('Stale resource binding',key)
        for target in ('android','ios'):
            for key,value in resource_record(target).items():assert receipt['targets'][target][key]==value,('Stale resource ZIP',target,key)
    for script,args in [('package_mobile.py',['android']),('patch_android109.py',[]),('test_android1103.py',[])]:
        run([sys.executable,'-B',script,*args],'mobile-'+script+'.log')
    run(['pwsh','-NoProfile','-File','assemble_android.ps1'],'mobile-android-assemble.log')
    run([sys.executable,'-B','validate_android.py'],'mobile-android-validation.log')
    run([sys.executable,'-B','package_mobile.py','ios'],'mobile-ios-package.log')
    run([sys.executable,'-B','audit_mobile_storage1103.py'],'mobile-storage.log')
    assert source_binding()==binding,'Source mutated during packaging'


if __name__=='__main__':main()
