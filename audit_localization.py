"""Audit the frozen MOD's presentation literals and both Chinese font atlases."""
from pathlib import Path
import argparse,json,re
from create_project import load
from gml_parser import parse_inventory
from native_compiler import walk

ROOT=Path(__file__).resolve().parent


def strings(node):
    return [n.args[0][1:-1] for n in walk(node) if n.kind=='string']


def field(node):
    if node.kind=='identifier':return node.args[0]
    if node.kind=='member':return node.args[1]
    return ''


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--output',default='release101/localization-audit.json')
    output=ROOT/parser.parse_args().output
    catalog=json.loads((ROOT/'localization/zh-CN.json').read_text(encoding='utf8'))
    normalized={k.upper():v for k,v in catalog.items()}
    assert len(normalized)==len(catalog)
    modules,errors=parse_inventory(ROOT);assert not errors,errors
    required={}
    def add(text,source,line):
        key=text.strip().upper()
        if key and re.search('[A-Z]',key):required.setdefault(key,[]).append(f'{source}:{line}')
    for source,defs in modules.items():
        for definition in defs:
            if definition.name in ('weapon_name','weapon_text'):
                for node in walk(definition.body):
                    if node.kind=='return':
                        for text in strings(node):add(text,source,node.line)
            for node in walk(definition.body):
                if node.kind=='binary' and node.args[0]=='=':
                    target=field(node.args[1]);value=node.args[2]
                    if target in ('tip','hitid','text'):
                        for text in strings(value):
                            if text.startswith(' '):text=text.strip()
                            add(text,source,node.line)
                if node.kind=='call' and node.args[0].kind=='identifier':
                    name=node.args[0].args[0];args=node.args[1]
                    if name=='weapon_set_name' and len(args)>1:
                        for text in strings(args[1]):add(text,source,node.line)
                    if name=='mod_script_call' and len(args)>3 and args[2].kind=='string' and args[2].args[0]=='"boss_trigger"':
                        for text in strings(args[3]):add(text,source,node.line)
                    if name.startswith('draw_text') and len(args)>2:
                        for text in strings(args[2]):add(text,source,node.line)
    # These are symbolic prefixes around dynamic values, not visible words.
    for marker in ('+','@W','@S'):required.pop(marker,None)
    missing={k:v for k,v in required.items() if k not in normalized}
    chars={ord(c) for value in catalog.values() for c in value if ord(c)>127}
    fonts=[]
    for name in ('fntCJK','fntCJKBig'):
        data=load(ROOT/f'project/fonts/{name}/{name}.yy')
        absent=sorted(chars-{int(k) for k in data['glyphs']})
        assert not absent,(name,absent)
        fonts.append({'font':name,'required_chinese_codepoints':len(chars),'missing':absent})
    report={'catalog_entries':len(catalog),'literal_keys':len(required),
            'required_literals':required,'untranslated_literals':missing,'fonts':fonts}
    output.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    print(json.dumps({'catalog_entries':len(catalog),'literal_keys':len(required),'untranslated':missing},ensure_ascii=False))
    assert not missing,'Missing presentation translations'


if __name__=='__main__':main()
