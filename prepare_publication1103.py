"""Stage the 1.1.3 text-only source tree after final package verification."""
from pathlib import Path
import hashlib,json,plistlib,re,sys,zipfile
from release_config import VERSION,BUILD,PACKAGE
ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release1103'
PUBLISH=ROOT.parent.parent/'github-publish'
STAGE=PUBLISH/'hardmode-mobile-port'
sys.path.insert(0,str(PUBLISH))
from source_only_policy import allowed_path,text_blob

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def read(path):return json.loads(path.read_text('utf8'))

def local_file(relative):
    path=(ROOT/relative).resolve()
    assert path.is_relative_to(ROOT.resolve()) and path.is_file(),relative
    return path

def current_source_paths():
    project={p.relative_to(ROOT).as_posix() for p in (ROOT/'project').rglob('*') if p.is_file()}
    development=set()
    for folder in ('native','generated','tests','localization','android'):
        development.update(p.relative_to(ROOT).as_posix() for p in (ROOT/folder).rglob('*') if p.is_file())
    for pattern in ('*.py','*.ps1'):
        development.update(p.name for p in ROOT.glob(pattern) if p.is_file())
    return {'project_files':project,'development_sources':development}

def verify_delivery():
    """Recheck the frozen receipt's complete local identity before staging.

    A prior PASS is evidence for its exact bytes, not approval for later edits.
    This function performs no build, engine run or publication operation.
    """
    delivery=read(OUT/'delivery-receipt.json')
    assert delivery['status']=='PASS' and (delivery['version'],delivery['build'])==(VERSION,BUILD)
    source=OUT/'final-source.json';archive=OUT/'final-code.zip'
    assert sha(source)==delivery['source_manifest_sha256'],'Final source manifest changed after delivery'
    assert sha(archive)==delivery['source_code_archive_sha256'],'Final code archive changed after delivery'
    frozen=read(source)
    current=current_source_paths()
    expected={}
    for group in ('project_files','development_sources'):
        assert frozen[group] and set(frozen[group])==current[group],('Source file set changed',group)
        for relative,digest in frozen[group].items():
            assert sha(local_file(relative))==digest,('Source changed after delivery',relative)
            expected[relative]=digest
    vm=ROOT/'build-windows/nuclearthronemobile.win'
    assert sha(vm)==delivery['final_desktop_vm_sha256']==frozen['desktop_vm_sha256'],'Final tested desktop VM changed'
    # Check the code archive contents as well as its receipt hash. The private
    # snapshot may include metadata, while the publication below filters media.
    archived_suffixes={'.gml','.yy','.yyp','.json','.py','.ps1','.java','.xml','.plist','.csv','.txt','.md'}
    with zipfile.ZipFile(archive) as z:
        names=z.namelist()
        assert len(names)==len(set(names)) and z.testzip() is None
        assert set(names)=={name for name in expected if Path(name).suffix.lower() in archived_suffixes}
        for name in names:
            assert hashlib.sha256(z.read(name)).hexdigest()==expected[name],('Frozen archive mismatch',name)
    required={f'deliverables/NuclearThrone.Hardmode-Android-{VERSION}.apk',
              f'deliverables/NuclearThrone.Hardmode-iOS-{VERSION}.ipa'}
    artifacts=delivery['artifacts']
    assert len(artifacts)==2 and {row['path'] for row in artifacts}==required,'Both exact release packages are required'
    for row in artifacts:
        package=local_file(row['path']);ext=package.suffix.removeprefix('.')
        assert package.stat().st_size==row['bytes'] and sha(package)==row['sha256'],('Delivered package changed',row['path'])
        validation_path=package.with_suffix('.validation.json')
        assert sha(validation_path)==row['validation_sha256'],('Package validation changed',row['path'])
        validation=read(validation_path)
        assert (validation['package'],validation['version'],validation['build'])==(PACKAGE,VERSION,BUILD)
        assert validation[ext+'_sha256']==row['sha256']
        target='android' if ext=='apk' else 'ios'
        vm_name='game.droid' if ext=='apk' else 'game.ios'
        prep=read(ROOT/f'platforms/{target}/prepared-receipt.json')
        prepared=ROOT/f'platforms/{target}/prepared-assets/{vm_name}'
        prepared_digest=sha(prepared)
        assert prepared_digest==row['prepared_vm_sha256']==prep['prepared_vm_sha256']
        with zipfile.ZipFile(ROOT/f'build-{target}/nuclearthronemobile.zip') as z:
            assert hashlib.sha256(z.read('assets/'+vm_name)).hexdigest()==prep['raw_vm_sha256']
        with zipfile.ZipFile(package) as z:
            if ext=='apk':
                assert hashlib.sha256(z.read('assets/'+vm_name)).hexdigest()==prepared_digest
            else:
                infos=[name for name in z.namelist() if name.endswith('.app/Info.plist')]
                assert len(infos)==1
                info=plistlib.loads(z.read(infos[0]));app=infos[0].removesuffix('Info.plist')
                assert (info['CFBundleIdentifier'],info['CFBundleShortVersionString'],info['CFBundleVersion'])==(PACKAGE,VERSION,str(BUILD))
                assert hashlib.sha256(z.read(app+'games/'+vm_name)).hexdigest()==prepared_digest
                runner_digest=hashlib.sha256(z.read(app+info['CFBundleExecutable'])).hexdigest()
                compatibility=read(OUT/'ios-native-compatibility.json')
                assert compatibility['compatible_added_functions_and_extensions']
                assert compatibility['game_vm_sha256']==prepared_digest
                assert runner_digest==validation['runner_sha256']==compatibility['native_sha256']
    return delivery,expected

def main():
    assert (VERSION,BUILD)==('1.1.3',17)
    delivery,expected=verify_delivery()
    files={}
    def add(path,relative=None):
        relative=relative or path.relative_to(ROOT).as_posix()
        if not allowed_path(relative):return
        data=path.read_bytes()
        if relative in expected:
            assert hashlib.sha256(data).hexdigest()==expected[relative],('Source changed during staging',relative)
        if not text_blob(data) and relative.lower().endswith('/license.txt'):
            assert text_blob(data,legacy_license=True),relative
            data=data.decode('cp1252').encode('utf8')
        assert text_blob(data),relative
        source=data.decode('utf-8-sig')
        assert not re.search(r'(?:iVBORw0KGgo|UklGR|T2dnUw|/9j/)[A-Za-z0-9+/=]{200,}',source),relative
        assert not re.search(r'\b(?:gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{40,}|-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----)',source),relative
        target=STAGE/relative;target.parent.mkdir(parents=True,exist_ok=True)
        target.write_bytes(data);files[relative]=sha(target)
    for folder in ('native','generated','tests','localization','android','project'):
        for path in sorted((ROOT/folder).rglob('*')):
            if not path.is_file():continue
            relative=path.relative_to(ROOT).as_posix()
            if any(part in ('node_modules','.git','__pycache__') for part in path.parts):continue
            if folder=='project' and '/datafiles/' in relative:continue
            add(path)
    for pattern in ('*.py','*.ps1'):
        for path in sorted(ROOT.glob(pattern)):
            if path.name!='prepare_evidence106.py':add(path)
    for name in ('artwork-manifest.json','native-artwork-receipt.json','mod-inventory.json',
                 'upstream-selection.json','runtime_schema.py','original-source-manifest.json'):
        add(ROOT/name)
    add(ROOT/'original-source/LICENSE','LICENSE')
    for name in ('FIXES.md','INSTALL.md','BUILDING.md','README.md','README.zh-CN.md'):
        add(OUT/name,('docs/'+name if name in ('FIXES.md','INSTALL.md') else name))
    add(ROOT/'release1100/migration-ledger.json','docs/migration-1.1.0.json')
    for name in ('CREDITS.md','.gitignore','.gitattributes'):
        add(STAGE/name,name)
    for path in STAGE.rglob('*'):
        if not path.is_file() or '.git' in path.parts:continue
        relative=path.relative_to(STAGE).as_posix()
        assert relative in files and allowed_path(relative) and text_blob(path.read_bytes()),relative
    # Catch concurrent edits of any frozen input while the staged tree was
    # being written, including private assets that were deliberately omitted.
    verify_delivery()
    report=dict(status='PASS',version=VERSION,stage=str(STAGE),files=files,text_files=len(files),
                asset_files=0,final_delivery_checked=True,published=False,
                delivery_receipt_sha256=sha(OUT/'delivery-receipt.json'),
                source_manifest_sha256=delivery['source_manifest_sha256'],
                source_code_archive_sha256=delivery['source_code_archive_sha256'],
                final_desktop_vm_sha256=delivery['final_desktop_vm_sha256'])
    (OUT/'source-publication-preflight.json').write_text(json.dumps(report,indent=2)+'\n','utf8')
    print('Source-only preflight PASS:',len(files),'text files')

if __name__=='__main__':main()
