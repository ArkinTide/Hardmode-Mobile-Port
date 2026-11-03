"""Stage the 1.1.2 text-only source tree after final package verification."""
from pathlib import Path
import hashlib,json,re,sys
from release_config import VERSION,BUILD
ROOT=Path(__file__).resolve().parent
OUT=ROOT/'release1102'
PUBLISH=ROOT.parent.parent/'github-publish'
STAGE=PUBLISH/'hardmode-mobile-port'
sys.path.insert(0,str(PUBLISH))
from source_only_policy import allowed_path,text_blob

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def main():
    assert (VERSION,BUILD)==('1.1.2',16)
    delivery=json.loads((OUT/'delivery-receipt.json').read_text('utf8'))
    assert delivery['status']=='PASS' and delivery['version']==VERSION
    files={}
    def add(path,relative=None):
        relative=relative or path.relative_to(ROOT).as_posix()
        if not allowed_path(relative):return
        data=path.read_bytes()
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
    report=dict(status='PASS',version=VERSION,stage=str(STAGE),files=files,text_files=len(files),
                asset_files=0,final_delivery_checked=True,published=False)
    (OUT/'source-publication-preflight.json').write_text(json.dumps(report,indent=2)+'\n','utf8')
    print('Source-only preflight PASS:',len(files),'text files')

if __name__=='__main__':main()
