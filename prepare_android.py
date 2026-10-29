"""Independent official runner scaffold; no NTTE game data or code is copied."""
from pathlib import Path
import configparser,hashlib,json,os,re,secrets,shutil,subprocess,zipfile

ROOT=Path(__file__).resolve().parent
OUT=ROOT/'platforms/android'
TOOLS=ROOT.parent/'ntte-complete/android-delivery/toolchain'
RUNTIME=Path('C:/ProgramData/GameMakerStudio2-LTS2026/Cache/runtimes/runtime-2026.0.0.23/android/runner')
PACKAGE='com.arkintide.nuclearthronehardmode'

def configure():
    OUT.mkdir(parents=True,exist_ok=True)
    jdk=next(TOOLS.glob('jdk-17*'))
    signing=OUT/'signing';signing.mkdir(exist_ok=True)
    identity=signing/'identity.json'
    if not identity.exists(): identity.write_text(json.dumps({'alias':'hardmode','password':secrets.token_urlsafe(28)}))
    key=json.loads(identity.read_text())
    keystore=signing/'hardmode-release.p12'
    if not keystore.exists():
        env={**os.environ,'HARDMODE_KEY_PASSWORD':key['password']}
        subprocess.run([str(jdk/'bin/keytool.exe'),'-genkeypair','-keystore',str(keystore),'-storetype','PKCS12',
            '-alias',key['alias'],'-keyalg','RSA','-keysize','3072','-validity','10000','-dname','CN=ArkinTide Hardmode',
            '-storepass:env','HARDMODE_KEY_PASSWORD','-keypass:env','HARDMODE_KEY_PASSWORD'],env=env,check=True)
    user=OUT/'user';user.mkdir(exist_ok=True)
    prefix='machine.Platform Settings.Android.'
    values={prefix+'Paths.jdk_location':jdk.as_posix(),prefix+'Paths.sdk_location':(TOOLS/'sdk').as_posix(),
        prefix+'Paths.ndk_location':(TOOLS/'sdk/ndk/28.2.13676358').as_posix(),prefix+'Keystore.filename':keystore.as_posix(),
        prefix+'Keystore.alias':key['alias'],prefix+'Keystore.keystore_password':key['password'],
        prefix+'Keystore.keystore_alias_password':key['password'],prefix+'max_heap_size':4}
    (user/'local_settings.json').write_text(json.dumps(values,indent=2))
    print('Independent Android build settings and signing identity ready.',flush=True)

def scaffold():
    configure()
    # javac's ZIP filesystem requires a writable SDK copy. Never mutate the
    # existing port's toolchain; copy the two required SDK components locally.
    sdk=OUT/'sdk'
    for relative in ['platforms/android-36','build-tools/34.0.0']:
        target=sdk/relative
        if not target.exists():
            shutil.copytree('\\\\?\\'+str((TOOLS/'sdk'/relative).resolve()),
                            '\\\\?\\'+str(target.resolve()))
    dest=OUT/'gradle-project';dest.mkdir(exist_ok=True)
    key=json.loads((OUT/'signing/identity.json').read_text())
    values={'YYAndroidPackageName':PACKAGE,'YYAndroidDisplayName':'Nuclear Throne: Hardmode',
        'YYAndroidCompileSDKVersion':'36','YYAndroidTargetSDKVersion':'36','YYAndroidMinSDKVersion':'21',
        'YYAndroidGradlePluginVersion':'8.7.0','YYAndroidGradleVersion':'8.9',
        'YYAndroidBuildToolsVersion':"buildToolsVersion '34.0.0'",
        'YYAndroidKeyStoreFile':'H:/platforms/android/signing/hardmode-release.p12',
        'YYAndroidKeyStoreFilePassword':key['password'],'YYAndroidKeyAlias':key['alias'],'YYAndroidKeyPassword':key['password'],
        'YYAndroidMajorVersion':'1','YYAndroidMinorVersion':'0','YYAndroidBuildVersion':'0','YYAndroidVersionCode':'1',
        'YYAndroidInstallLocation':'auto','YYAndroidProGuardMinifyEnabled':'false','YYAndroidProGuardShrinkResources':'false',
        'YYAndroidGradleMaxHeapSize':'org.gradle.jvmargs=-Xmx4096m',
        'YYAndroidGradleProperties':'android.suppressUnsupportedCompileSdk=36\nandroid.nonTransitiveRClass=false',
        'YYAndroidGradleRunnerDependencies':"implementation 'androidx.appcompat:appcompat:1.7.0'\nimplementation 'androidx.activity:activity:1.9.3'",
        'YYAndroidGradleAndroid':"androidResources { noCompress += ['droid', 'ogg', 'yytex'] }\ncompileOptions { sourceCompatibility JavaVersion.VERSION_1_8; targetCompatibility JavaVersion.VERSION_1_8 }\nlint { checkReleaseBuilds false }",
        'YYAndroidManifestActivityAttributes':'android:screenOrientation="sensorLandscape"',
        'YYAndroidInjectToApplicationTag':'android:usesCleartextTraffic="true" android:allowBackup="false" android:hardwareAccelerated="true"',
        'YYAndroidManifestPermission':'<uses-permission android:name="android.permission.INTERNET" />',
        'YYAndroidIsGame':'android:appCategory="game"'}
    tokens=set()
    for source,target in [(RUNTIME/'RootFiles',dest),(RUNTIME/'ProjectFiles',dest/PACKAGE)]:
        for p in source.rglob('*'):
            if not p.is_file():continue
            if 'jniLibs' in p.parts and not any(a in p.parts for a in ['arm64-v8a','armeabi-v7a']):continue
            rel=p.relative_to(source).as_posix().replace('YYAndroidPackageDomain','com').replace('YYAndroidPackageCompany','arkintide').replace('YYAndroidPackageProduct','nuclearthronehardmode')
            q=target/rel;q.parent.mkdir(parents=True,exist_ok=True)
            if p.suffix in ('.java','.gradle','.xml','.properties','.pro'):
                text=p.read_text(encoding='utf-8-sig');tokens.update(re.findall(r'\$\{([^}]+)\}',text))
                q.write_text(re.sub(r'\$\{([^}]+)\}',lambda m:values.get(m[1],''),text),encoding='utf8')
            else:shutil.copyfile(p,q)
    main=dest/PACKAGE/'src/main'
    java=main/'java'/Path(*PACKAGE.split('.'))
    for p in (ROOT/'project/extensions/YYExtra/AndroidSource/Java').glob('*.java'):
        (java/p.name).write_text(p.read_text(encoding='utf-8-sig').replace('${YYAndroidPackageName}',PACKAGE),encoding='utf8')
    # Reuse only the previously verified generic runner input adapter. It
    # contains no NTTE logic, assets, save paths, update service or identifiers.
    adapter=(ROOT.parent/'ntte-complete/android-delivery/native-controller/Gamepad.java').read_text(encoding='utf8')
    adapter=adapter.replace('com.arkintide.nuclearthronentte',PACKAGE)
    (java/'Gamepad.java').write_text(adapter,encoding='utf8')
    def change(file,old,new):
        p=java/file;text=p.read_text(encoding='utf8');assert text.count(old)==1,(file,old)
        p.write_text(text.replace(old,new),encoding='utf8')
    change('RunnerActivity.java',
        'if ((event.getSource() == InputDevice.SOURCE_JOYSTICK) || (event.getSource() == InputDevice.SOURCE_GAMEPAD))',
        'if (((event.getSource() & InputDevice.SOURCE_JOYSTICK) == InputDevice.SOURCE_JOYSTICK) || ((event.getSource() & InputDevice.SOURCE_GAMEPAD) == InputDevice.SOURCE_GAMEPAD) || ((event.getSource() & InputDevice.SOURCE_DPAD) == InputDevice.SOURCE_DPAD))')
    for old,new in [('Gamepad.Initialise();','Gamepad.Initialise();\n        Gamepad.Start(this);'),
        ('super.onDestroy();','Gamepad.Stop();\n        super.onDestroy();'),
        ('super.onPause();','Gamepad.Pause();\n        super.onPause();'),
        ('super.onResume();','super.onResume();\n        Gamepad.Resume(this);'),
        ('Gamepad.handleKeyEvent(event);','if (Gamepad.handleKeyEvent(event)) return true;')]:change('RunnerActivity.java',old,new)
    change('DemoRenderer.java','int ret = RunnerJNILib.Process(', 'Gamepad.ProcessInput();\n                    int ret = RunnerJNILib.Process(')
    change('DemoRenderer.java','RunnerActivity.CurrentActivity.HasRestarted = true;',
        'RunnerActivity.CurrentActivity.HasRestarted = true;\n                    Gamepad.OnRunnerRestart();')
    shutil.copytree(ROOT/'build-android/res',main/'res',dirs_exist_ok=True)
    with zipfile.ZipFile(ROOT/'build-android/nuclearthronemobile.zip') as z:
        assert z.testzip() is None
        assert all(n.startswith('assets/') and '..' not in Path(n).parts for n in z.namelist())
        z.extractall(main)
    for p in (ROOT/'build-android/assets').glob('*'):
        if p.is_file():shutil.copyfile(p,main/'assets'/p.name)
    import xml.etree.ElementTree as E
    uri='http://schemas.android.com/apk/res/android';E.register_namespace('android',uri)
    manifest=main/'AndroidManifest.xml';tree=E.parse(manifest);app=tree.getroot().find('application')
    ini=configparser.ConfigParser();ini.optionxform=str;ini.read(ROOT/'build-android/options.ini',encoding='utf8')
    metadata=dict(ini['Android']);metadata.update(YYNumExtensionClasses='1',YYExtensionClass0='YYExtra',
        YYEdgeToEdgeDisplay='false',YYDisplayLayout='LAYOUT_IN_DISPLAY_CUTOUT_MODE_DEFAULT',
        YYLaunchScreenBackgroundColour='-1',SplashscreenFill='0')
    for name,value in metadata.items():
        value=value.strip('"');value=value.lower() if value.lower() in ['true','false'] else value
        E.SubElement(app,'meta-data',{f'{{{uri}}}name':name,f'{{{uri}}}value':value})
    tree.write(manifest,encoding='utf8',xml_declaration=True)
    (dest/'local.properties').write_text('sdk.dir=H:/platforms/android/sdk\n')
    # Reuse downloaded dependencies read-only by copying into our own cache.
    cache=ROOT.parent/'ntte-complete/android-delivery/gradle-home/caches'
    for name in ['modules-2','jars-9']:
        q=OUT/'gradle-home/caches'/name
        shutil.copytree('\\\\?\\'+str((cache/name).resolve()),'\\\\?\\'+str(q.resolve()),
            dirs_exist_ok=True,ignore=shutil.ignore_patterns('*.lock','gc.properties'))
    (OUT/'scaffold-receipt.json').write_text(json.dumps({'package':PACKAGE,'runtime':str(RUNTIME),
        'template_tokens':sorted(tokens),'optional_empty_tokens':sorted(tokens-values.keys()),
        'source_game_sha256':hashlib.sha256((main/'assets/game.droid').read_bytes()).hexdigest()},indent=2)+'\n')
    print('Independent official Android runner scaffold ready.',flush=True)

if __name__=='__main__':
    import sys
    (scaffold if 'scaffold' in sys.argv else configure)()
