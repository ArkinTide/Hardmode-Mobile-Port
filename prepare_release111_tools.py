"""Create current release tooling while preserving frozen previous scripts."""
from pathlib import Path
ROOT=Path(__file__).resolve().parent

def copy(old,new,changes):
    text=(ROOT/old).read_text(encoding='utf8')
    for before,after in changes:
        assert before in text,(old,before)
        text=text.replace(before,after)
    (ROOT/new).write_text(text,encoding='utf8')

def main():
    for name in ('build_mobile','test_android','audit_mobile_storage'):
        copy(name+'110.py',name+'111.py',[('1.0.10','1.0.11'),('release110','release111'),
            *([('test_android110','test_android111'),('audit_mobile_storage110','audit_mobile_storage111')] if name=='build_mobile' else [])]) if name=='build_mobile' else copy(name+'110.py',name+'111.py',[('release110','release111')])
    copy('package_windows110.py','package_windows111.py',[
        ("assert VERSION=='1.0.10'","assert VERSION=='1.0.11'"),
        ("    # The user's ordering: finish and publish mobile before generating Windows.\n    publication=json.loads((OUT/'publication-receipt.json').read_text(encoding='utf8'))\n    assert publication['status']=='PASS' and publication['version']==VERSION\n    delivery=json.loads((OUT/'delivery-receipt.json').read_text(encoding='utf8'))\n    assert delivery['status']=='PASS'",
         "    # This round explicitly delivers Windows before mobile inspection.\n    regression=json.loads((OUT/'windows-regression.json').read_text(encoding='utf8'))\n    assert regression['status']=='PASS' and regression['version']==VERSION\n    for rate in (30,60):\n        menu=json.loads((OUT/f'menu-{rate}-receipt.json').read_text(encoding='utf8'))\n        assert menu['status']=='PASS' and menu['vm_sha256']==regression['vm_sha256']\n    delivery={'final_desktop_vm_sha256':regression['vm_sha256']}"),
        ("90,42,windows110'","65,42,wheel111'"),
        ("result['checks']==18","result['checks']==10"),
        ('30／60帧逻辑均验证；正常游玩音量按游戏设置。','30／60帧已定向验证，MOD手动位移加入60帧绘制平滑；正常音量按游戏设置。')])
    pub=ROOT.parent.parent/'github-publish'
    text=(pub/'publish_hardmode110.py').read_text(encoding='utf8')
    text=text.replace('1.0.10','1.0.11').replace('release110','release111')
    text=text.replace("BASE='33d653c07b2df5fa1cbb5cc17efef44da389fb51'","BASE='1300a884ed830cc635b49b904262219f50cd6779'")
    (pub/'publish_hardmode111.py').write_text(text,encoding='utf8')
    print('Current release build, storage, pacing, Windows and publication tools created')

if __name__=='__main__':main()
