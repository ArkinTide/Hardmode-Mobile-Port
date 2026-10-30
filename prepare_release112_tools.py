"""Derive maintained release tooling without touching older release records."""
from pathlib import Path
ROOT=Path(__file__).resolve().parent

def main():
    for name in ('build_mobile','test_android','audit_mobile_storage'):
        text=(ROOT/(name+'111.py')).read_text(encoding='utf8')
        text=text.replace('1.0.11','1.0.12').replace('release111','release112')
        text=text.replace('test_android111','test_android112').replace('audit_mobile_storage111','audit_mobile_storage112')
        (ROOT/(name+'112.py')).write_text(text,encoding='utf8')
    text=(ROOT/'package_windows111.py').read_text(encoding='utf8')
    text=text.replace("assert VERSION=='1.0.11'","assert VERSION=='1.0.12'")
    text=text.replace("'physical_mouse_automation':False,", "'physical_mouse_automation':False,\n        'os_input_development_probe':'Wheel down 1 to 5, wheel up 5 to 1, Space 1 to 5; prior 1.0.12 development VM. Final desktop UI retry unavailable.',")
    text=text.replace('MOD手动位移加入60帧绘制平滑；正常音量按游戏设置。',
        '修正启动节拍，并保留MOD手动位移的60帧绘制平滑；正常音量按游戏设置。\n诅咒超级水晶死亡后墙色恢复，下水道岸边判定及跨区域音乐已修复。')
    (ROOT/'package_windows112.py').write_text(text,encoding='utf8')
    text=(ROOT/'make_release111_receipt.py').read_text(encoding='utf8')
    text=text.replace('run_release111_checks','run_release112_checks')
    text=text.replace("('1.0.11',12)","('1.0.12',13)").replace('1.0.11','1.0.12')
    text=text.replace("'scrDesktopWheelPending111']","'scrDesktopWheelPending111','scrHMCaveWalls112','scrHMSwimSupported112','scrHMMusicRoom112','scrHMWheelEvent112']")
    text=text.replace("wheel_test='Synthetic input through real Player Step; no physical mouse automation',", "wheel_test='Final-VM synthetic input through real Player Step; OS-level scroll injection verified on prior 1.0.12 development VM.',")
    (ROOT/'make_release112_receipt.py').write_text(text,encoding='utf8')
    pub=ROOT.parent.parent/'github-publish'
    text=(pub/'publish_hardmode111.py').read_text(encoding='utf8').replace('1.0.11','1.0.12').replace('release111','release112')
    (pub/'publish_hardmode112.py').write_text(text,encoding='utf8')
    print('1.0.12 build, package, verification and publication tools prepared')

if __name__=='__main__':main()
