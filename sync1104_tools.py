"""Idempotent incremental edits over published Hardmode mobile 1.1.3."""
from pathlib import Path
import re

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT/'project'
OUT=ROOT/'release1104'
CHANGED=set()

def span(text,name):
    match=re.search(r'^function '+re.escape(name)+r'\([^\n]*\)\s*\{',text,re.M)
    assert match,name
    start=match.end();depth=1
    for token in re.finditer(r'//[^\n]*|/\*[\s\S]*?\*/|"(?:\\.|[^"\\])*"|[{}]',text[start:]):
        if token[0]=='{':depth+=1
        elif token[0]=='}':
            depth-=1
            if not depth:return match.start(),start,start+token.start(),start+token.end()
    raise AssertionError(name)

def body(text,name):
    _,a,b,_=span(text,name);return text[a:b].strip()

def save(relative,text):
    path=PROJECT/relative
    if path.exists() and path.read_text('utf8')==text:return
    backup=OUT/'baseline'/relative
    if path.exists() and not backup.exists():
        backup.parent.mkdir(parents=True,exist_ok=True);backup.write_bytes(path.read_bytes())
    path.parent.mkdir(parents=True,exist_ok=True);path.write_text(text,'utf8')
    CHANGED.add(str(relative))

def edit(relative,old,new,count=1):
    text=(PROJECT/relative).read_text('utf8')
    if new in text:return
    assert text.count(old)==count,(relative,old[:180],text.count(old),count)
    save(relative,text.replace(old,new,count))

def replace_function(relative,name,replacement):
    text=(PROJECT/relative).read_text('utf8');_,a,b,_=span(text,name)
    save(relative,text[:a]+'\n'+replacement.strip()+'\n'+text[b:])
