"""Extend only the synchronized mobile settings labels, preserving base wording."""
import json,re
from pathlib import Path
ROOT=Path(__file__).resolve().parent
LABELS={
 'BOSS HEALTH BARS':'首领血条',
 'DEFLECT THRONE BALLS':'反弹王座能量球',
 'PLAYER BOOST (+2 HP, +1 LEVEL)':'玩家增强（生命上限+2，等级上限+1）',
}
def main():
    p=ROOT/'localization/zh-CN.json';data=json.loads(p.read_text('utf8'));data.update(LABELS)
    p.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n','utf8')
    p=ROOT/'project/scripts/scrHMLocalization/scrHMLocalization.gml';text=p.read_text('utf8')
    match=re.search(r'static _catalog=(\{.*?\});',text,re.S);assert match
    data=json.loads(match[1]);data.update(LABELS)
    text=text[:match.start(1)]+json.dumps(data,ensure_ascii=False,indent=2)+text[match.end(1):]
    p.write_text(text,'utf8')
    missing={}
    for name in ('fntCJK','fntCJKBig'):
        from create_project import load
        glyphs=load(ROOT/f'project/fonts/{name}/{name}.yy')['glyphs']
        absent=sorted({ord(c) for v in LABELS.values() for c in v if ord(c)>127}-{int(c) for c in glyphs})
        if absent:missing[name]=['U+%04X %s'%(c,chr(c)) for c in absent]
    print(json.dumps({'labels':LABELS,'missing_glyphs':missing},ensure_ascii=False))
    assert not missing
if __name__=='__main__':main()
