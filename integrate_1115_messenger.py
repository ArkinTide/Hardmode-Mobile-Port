"""Targeted Messenger revival hooks; safe after retained generators."""
from pathlib import Path
import re
from sync1104_tools import span

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT/'project'
changed=[]

def save(path,text):
    if path.read_text(encoding='utf-8')!=text:
        path.write_text(text,encoding='utf-8');changed.append(str(path.relative_to(ROOT)))

def edit(path,old,new):
    text=path.read_text(encoding='utf-8')
    if new in text:return
    assert text.count(old)==1,(path,old,text.count(old))
    save(path,text.replace(old,new,1))

def fn(path,name,transform):
    text=path.read_text(encoding='utf-8');_,a,b,_=span(text,name)
    save(path,text[:a]+transform(text[a:b])+text[b:])

def import_fn(path,name,source):
    text=path.read_text(encoding='utf-8');a,_,_,b=span(source,name)
    definition=source[a:b]
    if re.search(r'^function '+re.escape(name)+r'\(',text,re.M):
        x,_,_,y=span(text,name);save(path,text[:x]+definition+text[y:])
    else:save(path,text.rstrip()+'\n\n'+definition+'\n')

def main():
    helper=(ROOT/'native/messenger1115.gml').read_text(encoding='utf-8')
    paths=[ROOT/'native/sync1103_bosses.gml',PROJECT/'scripts/scrHMSync1103Bosses/scrHMSync1103Bosses.gml']
    for path in paths:
        for name in re.findall(r'^function (\w+)\(',helper,re.M):import_fn(path,name,helper)
        fn(path,'scrHMMessengerCorpse1103',lambda b:b if 'scrHMMessengerAutoCorpse115(_owner);' in b else b+'\n    scrHMMessengerAutoCorpse115(_owner);\n')
        fn(path,'scrHMMessengerIntro1103',lambda b:b.replace('if(revived>0) {','if(revived>0 && !(self[$ "hm_messenger_auto_revived115"]??false)) {',1)
            .replace('    spr_idle=sprMutant12BIdle;','    if(revived==0) spr_idle=sprMutant12BIdle;',1))
    for relative,call in [
        ('objects/WantRevivePopoFreak/Alarm_0.gml','if(scrHMEnabled() && scrHMMessengerReviveTimer115()) exit;'),
        ('objects/RevivePopoFreak/Alarm_0.gml','if(scrHMEnabled() && scrHMMessengerReviveEffect115()) exit;')]:
        path=PROJECT/relative;text=path.read_text(encoding='utf-8')
        if call not in text:save(path,call+'\n'+text)
    # Generic native corpse creation covers extra Messengers, whose factory
    # deliberately uses the stock death event instead of the boss callback.
    edit(PROJECT/'objects/enemy/Destroy_0.gml',
        '        sprite_index = other.spr_dead',
        '        sprite_index = other.spr_dead\n        if(scrHMEnabled()) scrHMMessengerNativeCorpse115(other.id);')
    for path in [ROOT/'native/repairs103.gml',PROJECT/'scripts/scrHMRepairs103/scrHMRepairs103.gml']:
        fn(path,'scrHMPendingBoss',lambda b:b if 'scrHMMessengerReviving115()' in b else b.replace('    if(!scrHMEnabled()) return false;',
            '    if(!scrHMEnabled()) return false;\n    if(scrHMMessengerReviving115()) return true;',1))
    for path in [ROOT/'native/compiled_arkintide1103.gml',PROJECT/'scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml']:
        fn(path,'hm_arkintide_mod_gml_hm_stage_boss_actor',lambda b:b if 'hm_messenger_auto_revived115' in b else
            '\nif(self[$ "hm_messenger_auto_revived115"]??false) return !(self[$ "hm_extra"]??false) && hp>0;\n'+b)
    # Auto-returned Messengers have their own life group; ordinary necromancer
    # revivals retain the existing no-presentation policy.
    for path in [ROOT/'native/repairs109.gml',PROJECT/'scripts/scrHMRepairs109/scrHMRepairs109.gml']:
        fn(path,'scrHMBossGroupKind115',lambda b:b.replace('|| (_actor[$ "revived"]??0)>0)',
            '|| ((_actor[$ "revived"]??0)>0 && !(_actor[$ "hm_messenger_auto_revived115"]??false)))',1))
    tests=(ROOT/'tests/repairs1115_messenger.gml').read_text(encoding='utf-8')
    for path in [ROOT/'tests/repairs1104_hunter.gml',PROJECT/'scripts/scrHMGameplayHunter1104/scrHMGameplayHunter1104.gml']:
        import_fn(path,'scrHMGameplayMessenger115',tests)
        fn(path,'scrHMGameplayBossGroup115',lambda b:b if 'scrHMGameplayMessenger115();' in b else
            '\n    scrHMGameplayMessenger115();\n    if(mode=="group115replace") return;\n'+b)
    print('1115 Messenger patched',len(changed),'files')

if __name__=='__main__':main()
