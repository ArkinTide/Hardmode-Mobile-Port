"""Verify storage support in the built mobile packages, without device claims."""
from pathlib import Path
import hashlib, json, os, plistlib, subprocess, sys, tempfile, zipfile
from release_config import PACKAGE, VERSION

ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT.parent/'ntte-complete'))
from audit_ios_vm_builtins import audit


def main():
    sdk=ROOT/'platforms/android/sdk/build-tools/34.0.0'
    apk=ROOT/f'deliverables/NuclearThrone.Hardmode-Android-{VERSION}.apk'
    permissions=subprocess.run([str(sdk/'aapt.exe'),'dump','permissions',str(apk)],
                               capture_output=True,text=True,check=True).stdout
    required=['android.permission.MANAGE_EXTERNAL_STORAGE',
              'android.permission.READ_EXTERNAL_STORAGE',
              'android.permission.WRITE_EXTERNAL_STORAGE']
    for permission in required: assert permission in permissions
    manifest=ROOT/f'platforms/android/gradle-project/{PACKAGE}/src/main/AndroidManifest.xml'
    assert 'android:requestLegacyExternalStorage="true"' in manifest.read_text()
    java=ROOT/f'platforms/android/gradle-project/{PACKAGE}/src/main/java/com/arkintide/nuclearthronehardmode/YYExtra.java'
    source=java.read_text()
    assert 'ctx, "android.permission.WRITE_EXTERNAL_STORAGE"' in source
    assert 'ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION' in source
    with zipfile.ZipFile(apk) as z:
        dex=z.read('classes.dex')
        assert b'android.permission.WRITE_EXTERNAL_STORAGE' in dex
        assert b'android.settings.MANAGE_APP_ALL_FILES_ACCESS_PERMISSION' in dex
        assert b'HardmodeFramePacer' in dex and b'awaitFrame' in dex
    pacer=ROOT/'android/HardmodeFramePacer.java'
    packaged_pacer=java.parent/'HardmodeFramePacer.java'
    assert pacer.read_bytes()==packaged_pacer.read_bytes()
    renderer=java.parent/'DemoRenderer.java'
    hook='hardmodePacer109.awaitFrame(RunnerJNILib.mGameSpeedControl);'
    renderer_text=renderer.read_text()
    assert renderer_text.count(hook)==1
    assert renderer_text.index('RunnerJNILib.UpdateGameSpeed()')<renderer_text.index(hook)<renderer_text.index('int ret = RunnerJNILib.Process(')
    with tempfile.TemporaryDirectory(dir=ROOT/'release109') as temp:
        dex_path=Path(temp)/'classes.dex';dex_path.write_bytes(dex)
        dump=subprocess.run([str(sdk/'dexdump.exe'),'-d',str(dex_path)],capture_output=True,encoding='utf8',errors='replace',check=True).stdout
    import re
    methods=re.findall(r"name\s+: 'onDrawFrame'([\s\S]*?)(?=\n\s+#[0-9]+|\nClass #[0-9]+|\Z)",dump)
    methods=[method.replace(';.', '.') for method in methods]
    matched=[method for method in methods if 'HardmodeFramePacer.awaitFrame' in method
             and 'RunnerJNILib.Process' in method and 'RunnerJNILib.UpdateGameSpeed' in method]
    assert len(matched)==1
    method=matched[0]
    assert method.index('RunnerJNILib.UpdateGameSpeed')<method.index('HardmodeFramePacer.awaitFrame')<method.index('RunnerJNILib.Process')
    pacing=json.loads((ROOT/'release109/android-pacing.json').read_text())
    assert pacing['status']=='PASS' and pacing['source_sha256']['android/HardmodeFramePacer.java']==hashlib.sha256(pacer.read_bytes()).hexdigest()
    ipa=ROOT/f'deliverables/NuclearThrone.Hardmode-iOS-{VERSION}.ipa'
    with zipfile.ZipFile(ipa) as z:
        info=plistlib.loads(z.read(next(n for n in z.namelist() if n.endswith('.app/Info.plist'))))
        assert info['UIFileSharingEnabled'] and info['LSSupportsOpeningDocumentsInPlace']
    vm=ROOT/'platforms/ios/prepared-assets/game.ios'
    compatibility=audit(vm,ROOT/'../../outputs/NuclearThroneIOS.ipa')
    compatibility['game_vm_sha256']=hashlib.sha256(vm.read_bytes()).hexdigest()
    assert compatibility['compatible_added_functions_and_extensions']
    (ROOT/'release109/ios-native-compatibility.json').write_text(json.dumps(compatibility,indent=2)+'\n')
    report={'android_shared_storage_permission_packaged':True,
            'android_required_permissions':required,
            'android_manifest_sha256':hashlib.sha256(manifest.read_bytes()).hexdigest(),
            'android_extension_java_sha256':hashlib.sha256(java.read_bytes()).hexdigest(),
            'android_public_root':'/storage/emulated/0/games/'+PACKAGE+'/',
            'android_monotonic_pacer_dex_call_before_native_process':True,
            'android_pacer_source_sha256':hashlib.sha256(pacer.read_bytes()).hexdigest(),
            'android_dex_pacing_calls':[line.strip() for line in method.splitlines() if any(fn in line for fn in ['RunnerJNILib.UpdateGameSpeed','HardmodeFramePacer.awaitFrame','RunnerJNILib.Process'])],
            'android_renderer_sha256':hashlib.sha256(renderer.read_bytes()).hexdigest(),
            'android_permission_denied_fallback':'existing private hardmode directory',
            'ios_documents_sharing_enabled':True,'ios_documents_subdirectory':'hardmode/',
            'physical_device_tested':False,
            'limits':['Android permission UI and iOS Files visibility still require device verification.']}
    (ROOT/'release109/mobile-storage-audit.json').write_text(json.dumps(report,indent=2)+'\n')
    print('Packaged storage support PASS; iOS additional native functions:',compatibility['verified_additional_functions'])


if __name__=='__main__':main()
