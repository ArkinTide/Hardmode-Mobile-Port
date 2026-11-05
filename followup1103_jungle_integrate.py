"""Remove only the mobile Flower entrance's unconditional mutation award.

This is intentionally incremental: it does not touch the frozen NTT source,
normal level-up/Ultra accounting, the entrance animation or Last Wish cleanup.
"""
import re

from sync1103_tools import PROJECT, ROOT, body, save, span, transform


def sync_tests():
    """Upsert only the two owned definitions in the combined gameplay script."""
    relative='scripts/scrHMGameplayTests/scrHMGameplayTests.gml'
    path=PROJECT/relative
    text=path.read_text('utf8')
    source=(ROOT/'tests/repairs112.gml').read_text('utf8')
    for name in ('scrHMGameplayRepairs112','scrHMGameplayJungle112'):
        start,_,_,end=span(source,name)
        definition=source[start:end]
        if re.search(r'^function '+re.escape(name)+r'\(',text,re.M):
            old_start,_,_,old_end=span(text,name)
            text=text[:old_start]+definition+text[old_end:]
        else:
            text=text.rstrip()+'\n\n'+definition+'\n'
        assert len(re.findall(r'^function '+re.escape(name)+r'\(',text,re.M))==1,name
    # Insert before the first established mode, preserving the existing tail
    # anchors used by other incremental route integrations on the next run.
    _,start,end,_=span(text,'scrHMGameplayRoomStart')
    room=text[start:end]
    if '"jungleentry112"' not in room:
        anchor='["route",'
        assert room.count(anchor)==1, 'gameplay RoomStart whitelist'
        room=room.replace(anchor,'["jungleentry112","route",',1)
        text=text[:start]+room+text[end:]
    save(relative,text)


def apply():
    relative='scripts/scrHMCompiled_props_mod_gml/scrHMCompiled_props_mod_gml.gml'
    name='hm_props_mod_gml_Flower_step_resume'
    old='scrHMSetSkill(18, 0);\nGameCont.skillpoints += 1;\nTopCont.darkness = 0;'
    new='scrHMSetSkill(18, 0);\n// Entering the Jungle does not award an extra mutation.\nTopCont.darkness = 0;'
    def remove_reward(text):
        if new in text:return text
        assert text.count(old)==1, 'Flower entrance mutation award'
        return text.replace(old,new,1)
    transform(relative,name,remove_reward)
    text=body((PROJECT/relative).read_text('utf8'),name)
    assert 'GameCont.skillpoints' not in text
    sync_tests()


if __name__=='__main__':
    apply()
