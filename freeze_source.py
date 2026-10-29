"""Record a local, reproducible source state without copying game assets."""
from datetime import datetime, timezone
from pathlib import Path
import argparse
import hashlib
import json
import zipfile

ROOT=Path(__file__).resolve().parent


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def freeze(name, directory='release100'):
    out=ROOT/directory;out.mkdir(exist_ok=True)
    original=json.loads((ROOT/'original-source-manifest.json').read_text())
    failures=[]
    for rel, record in original['files'].items():
        p=ROOT/'original-source'/rel
        if not p.is_file() or sha(p)!=record['sha256']: failures.append(rel)
    assert not failures, failures
    files={p.relative_to(ROOT).as_posix():sha(p) for p in sorted((ROOT/'project').rglob('*')) if p.is_file()}
    sources={}
    for folder in ['native','generated','tests','localization']:
        sources.update({p.relative_to(ROOT).as_posix():sha(p) for p in sorted((ROOT/folder).rglob('*')) if p.is_file()})
    sources.update({p.name:sha(p) for p in sorted(ROOT.glob('*.py'))})
    sources.update({p.name:sha(p) for p in sorted(ROOT.glob('*.ps1'))})
    report={'recorded_utc':datetime.now(timezone.utc).isoformat(),
            'original_commit':original['commit'],'original_files_verified':len(original['files']),
            'project_files':files,'development_sources':sources,
            'desktop_vm_sha256':sha(ROOT/'build-windows/nuclearthronemobile.win')}
    (out/(name+'-source.json')).write_text(json.dumps(report,indent=2)+'\n')
    with zipfile.ZipFile(out/(name+'-code.zip'),'w',zipfile.ZIP_DEFLATED) as z:
        for rel in [*files,*sources]:
            if Path(rel).suffix.lower() in {'.gml','.yy','.yyp','.json','.py','.ps1','.java','.xml','.plist','.csv','.txt','.md'}:
                z.write(ROOT/rel,rel)
    print(json.dumps({'snapshot':name,'original_files_verified':len(original['files']),
                      'project_files':len(files),'development_sources':len(sources)}))


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('name')
    parser.add_argument('--directory',default='release100')
    args=parser.parse_args()
    freeze(args.name,args.directory)
