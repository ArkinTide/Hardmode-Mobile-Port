"""Verify storage support in the built mobile packages, without device claims."""
from pathlib import Path
import hashlib, json, os, plistlib, subprocess, sys, zipfile
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
    ipa=ROOT/f'deliverables/NuclearThrone.Hardmode-iOS-{VERSION}.ipa'
    with zipfile.ZipFile(ipa) as z:
        info=plistlib.loads(z.read(next(n for n in z.namelist() if n.endswith('.app/Info.plist'))))
        assert info['UIFileSharingEnabled'] and info['LSSupportsOpeningDocumentsInPlace']
    vm=ROOT/'platforms/ios/prepared-assets/game.ios'
    compatibility=audit(vm,ROOT/'../../outputs/NuclearThroneIOS.ipa')
    compatibility['game_vm_sha256']=hashlib.sha256(vm.read_bytes()).hexdigest()
    assert compatibility['compatible_added_functions_and_extensions']
    (ROOT/'release106/ios-native-compatibility.json').write_text(json.dumps(compatibility,indent=2)+'\n')
    report={'android_shared_storage_permission_packaged':True,
            'android_required_permissions':required,
            'android_manifest_sha256':hashlib.sha256(manifest.read_bytes()).hexdigest(),
            'android_extension_java_sha256':hashlib.sha256(java.read_bytes()).hexdigest(),
            'android_public_root':'/storage/emulated/0/games/'+PACKAGE+'/',
            'android_permission_denied_fallback':'existing private hardmode directory',
            'ios_documents_sharing_enabled':True,'ios_documents_subdirectory':'hardmode/',
            'physical_device_tested':False,
            'limits':['Android permission UI and iOS Files visibility still require device verification.']}
    (ROOT/'release106/mobile-storage-audit.json').write_text(json.dumps(report,indent=2)+'\n')
    print('Packaged storage support PASS; iOS additional native functions:',compatibility['verified_additional_functions'])


if __name__=='__main__':main()
