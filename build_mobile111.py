"""Build fresh mobile resources and validate both 1.0.11 packages."""
from pathlib import Path
import subprocess,sys,time

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release111'


def run(arguments,name,allow_resource_error=False):
    started=time.time()
    with (OUT/name).open('wb') as stream:
        result=subprocess.run(arguments,cwd=ROOT,stdout=stream,stderr=subprocess.STDOUT)
    if result.returncode and allow_resource_error:
        resource=ROOT/'build-android/nuclearthronemobile.zip'
        assert resource.is_file() and resource.stat().st_mtime>=started,'Android resources are stale'
        log=(ROOT/'build-android.log').read_text(encoding='utf8',errors='replace')
        assert 'Extension' in log or 'extension' in log
        print('Android Igor extension-path failure after fresh resource ZIP; using offline Gradle',flush=True)
    else:
        assert result.returncode==0,(OUT/name).read_text(encoding='utf8',errors='replace')[-3500:]
    print(name,'completed',flush=True)


def main():
    run(['pwsh','-NoProfile','-File','build_local.ps1','-Target','android'],'mobile-android-build.log',True)
    run(['pwsh','-NoProfile','-File','build_local.ps1','-Target','ios'],'mobile-ios-build.log')
    for script,args in [('package_mobile.py',['android']),('patch_android109.py',[]),('test_android111.py',[])]:
        run([sys.executable,'-B',script,*args],'mobile-'+script+'.log')
    run(['pwsh','-NoProfile','-File','assemble_android.ps1'],'mobile-android-assemble.log')
    run([sys.executable,'-B','validate_android.py'],'mobile-android-validation.log')
    run([sys.executable,'-B','package_mobile.py','ios'],'mobile-ios-package.log')
    run([sys.executable,'-B','audit_mobile_storage111.py'],'mobile-storage.log')


if __name__=='__main__':main()
