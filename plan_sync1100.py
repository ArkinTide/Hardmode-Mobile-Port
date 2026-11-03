"""Bind the native content source and audit definition-level mobile differences.

This does not alter either frozen input or the playable project. Grillskills
is intentionally excluded: the mobile host already supplies that interface.
"""
from pathlib import Path
import hashlib,json,re,sys,zipfile
from gml_parser import definitions
from native_compiler import Emitter,safe,walk
from runtime_schema import API

ROOT=Path(__file__).resolve().parent
NATIVE=ROOT.parent/'hardmode-ntt100034'
OUT=ROOT/'release1100'

def sha(data):return hashlib.sha256(data).hexdigest()
def save(path,data):path.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
def clean(source):return re.sub(r'^#pragma[^\n]*','',source,flags=re.M)
def signature(value):
    from gml_parser import Node
    if isinstance(value,Node):return (value.kind,signature(value.args))
    if isinstance(value,(list,tuple)):return tuple(signature(x) for x in value)
    return value

def main():
    OUT.mkdir(exist_ok=True)
    initial=ROOT/'reference/hardmode-b24'
    inventory=json.loads((ROOT/'mod-inventory.json').read_text('utf8'))
    native_files={p.relative_to(NATIVE/'mod').as_posix():sha(p.read_bytes()) for p in (NATIVE/'mod').rglob('*') if p.is_file()}
    changes=json.loads((NATIVE/'changes.json').read_text('utf8'))
    records=[]
    for item in inventory['modules']:
        path=item['path'];before=definitions((initial/path).read_text('utf8'),path)
        after=definitions(clean((NATIVE/'mod'/path).read_text('utf8')),path)
        old={d.name:d for d in before}
        for d in after:
            if d.name not in old or signature(d.body)!=signature(old[d.name].body):
                records.append({'source':path,'definition':d.name,'new':d.name not in old,
                                'native_changes':[c['change'] for c in changes if c['file']==path and c['script']==d.name]})
    baseline={p.relative_to(ROOT/'project').as_posix():sha(p.read_bytes()) for p in (ROOT/'project').rglob('*')
              if p.is_file() and p.suffix.lower() in {'.gml','.yy','.yyp','.json','.fsh','.vsh','.java','.xml'}}
    if not (OUT/'baseline-source.json').exists():
        save(OUT/'baseline-source.json',{'version':'1.0.12','files':baseline})
        with zipfile.ZipFile(OUT/'baseline-code.zip','w',zipfile.ZIP_DEFLATED) as z:
            for path in baseline:z.write(ROOT/'project'/path,path)
    save(OUT/'native-source-binding.json',{'native_root':str(NATIVE),'native_files':native_files,
         'changes_sha256':sha((NATIVE/'changes.json').read_bytes()),'transformations':len(changes),
         'version':'1.1.0','build':14,'excluded':['NTT menu/network/console host integration','Grillskills (mobile host already supplies it)']})
    save(OUT/'definition-delta.json',{'status':'INVENTORIED_NOT_IMPLEMENTED','definitions':records})
    (OUT/'WORKLOG.md').write_text('''# Hardmode mobile 1.1.0 / build 14

Synchronize applicable native NTT v100.034 content into mobile 1.0.12.
Keep touch input, Simplified Chinese, independent storage, compatibility runner
and 30Hz simulation / 60Hz presentation. Do not add Grillskills, per user.
APK and IPA go to the dedicated Hardmode MEGA; GitHub receives text source only.
No test results, build or publication are claimed until recorded here.
Tests run silently in the background, without window control or input automation.
''',encoding='utf8')
    print('Bound native files',len(native_files),'transformations',len(changes),'changed definitions',len(records),'baseline text files',len(baseline))

if __name__=='__main__':main()
