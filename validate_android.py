"""Validate the standalone APK's identity, signature, assets and 16K alignment."""
from pathlib import Path
import hashlib,json,os,re,shutil,struct,subprocess,zipfile
from release_config import VERSION,BUILD,PACKAGE

ROOT=Path(__file__).resolve().parent
SDK=ROOT/'platforms/android/sdk/build-tools/34.0.0'
TOOLS=ROOT.parent/'ntte-complete/android-delivery/toolchain'
jdk=next(TOOLS.glob('jdk-17*'))
apk=ROOT/f'platforms/android/gradle-project/{PACKAGE}/build/outputs/apk/release/{PACKAGE}-release.apk'
if not apk.exists():
    apks=list((ROOT/'platforms/android/gradle-project').glob('*/build/outputs/apk/release/*-release.apk'))
    assert len(apks)==1,apks
    apk=apks[0]
env={**os.environ,'JAVA_HOME':str(jdk)}
def run(args):return subprocess.run([str(x) for x in args],env=env,capture_output=True,text=True,check=True).stdout
signature=run([SDK/'apksigner.bat','verify','--verbose','--print-certs',apk])
assert 'Verified using v2 scheme (APK Signature Scheme v2): true' in signature
cert=re.search(r'Signer #1 certificate SHA-256 digest: (\w+)',signature)[1]
# The retained offline build-tools version predates zipalign's -P switch.
# Check ordinary alignment with it, and verify actual 16K data offsets below.
align=run([SDK/'zipalign.exe','-c','-v','4',apk])
assert any(message in align for message in ('Verification successful','Verification succesful'))
badging=run([SDK/'aapt.exe','dump','badging',apk])
assert f"package: name='{PACKAGE}' versionCode='{BUILD}' versionName='{VERSION}'" in badging
assert "application-label:'Nuclear Throne: Hardmode'" in badging
receipt=json.loads((ROOT/'platforms/android/prepared-receipt.json').read_text())
native=[]
with zipfile.ZipFile(apk) as z, apk.open('rb') as apk_stream:
    assert z.testzip() is None
    assert len(z.namelist())==len(set(z.namelist()))
    # Android's asset merger intentionally excludes source-control dotfiles.
    ignored={name for name in receipt['assets'] if 'assets/'+name not in z.namelist()}
    assert ignored <= {'.gitignore','lang/.gitkeep'},ignored
    for name,expected in receipt['assets'].items():
        if name in ignored:continue
        assert hashlib.sha256(z.read('assets/'+name)).hexdigest()==expected,name
    assert 'classes.dex' in z.namelist()
    for name in z.namelist():
        if not name.startswith('lib/') or not name.endswith('.so'):continue
        item=z.getinfo(name)
        assert item.compress_type==zipfile.ZIP_STORED,name
        apk_stream.seek(item.header_offset)
        header=apk_stream.read(30)
        assert header[:4]==b'PK\x03\x04'
        filename_size,extra_size=struct.unpack_from('<HH',header,26)
        data_offset=item.header_offset+30+filename_size+extra_size
        assert data_offset%16384==0,(name,data_offset,'native ZIP data must be 16K-aligned')
        data=z.read(name);assert data[:4]==b'\x7fELF'
        wide=data[4]==2
        phoff=struct.unpack_from('<Q' if wide else '<I',data,32 if wide else 28)[0]
        entsize,count=struct.unpack_from('<HH',data,54 if wide else 42)
        segments=[]
        for i in range(count):
            p=phoff+i*entsize
            if struct.unpack_from('<I',data,p)[0]!=1:continue
            alignment=struct.unpack_from('<Q' if wide else '<I',data,p+(48 if wide else 28))[0]
            # Android's 16K-page ABI applies to 64-bit devices; the separate
            # legacy ARMv7 binary targets 32-bit/4K-page devices.
            assert alignment>=(16384 if wide else 4096),(name,alignment)
            segments.append(alignment)
        native.append({'path':name,'zip_data_offset':data_offset,'zip_alignment':16384,
                       'elf_bits':64 if wide else 32,'load_segment_alignment':segments,
                       'sha256':hashlib.sha256(data).hexdigest()})
assert any('arm64-v8a/libyoyo.so' in n['path'] for n in native)
assert any('armeabi-v7a/libyoyo.so' in n['path'] for n in native)
out=ROOT/f'deliverables/NuclearThrone.Hardmode-Android-{VERSION}.apk';out.parent.mkdir(exist_ok=True)
shutil.copyfile(apk,out)
report={'package':PACKAGE,'version':VERSION,'build':BUILD,'certificate_sha256':cert,
        'apk_sha256':hashlib.sha256(out.read_bytes()).hexdigest(),'zip_16k_alignment':True,
        'native_libraries':native,'game_assets_exact':True,'ignored_non_game_files':sorted(ignored),'physical_device_tested':False,
        'release_lint':'not run: dependency absent in offline toolchain; explicit package checks performed'}
out.with_suffix('.validation.json').write_text(json.dumps(report,indent=2)+'\n')
print(out)
print(json.dumps(report,indent=2))
