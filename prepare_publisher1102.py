"""Reuse the checked fast-forward publisher with this release's new notes."""
from pathlib import Path
ROOT=Path(__file__).resolve().parent
PUBLISH=ROOT.parent.parent/'github-publish'

def main():
    text=(PUBLISH/'publish_hardmode1101.py').read_text('utf8')
    text=text.replace('1.1.1','1.1.2').replace('release1101','release1102')
    text=text.replace("BASE='1d2a3d589061c03ea00fd11c6f32ad84a3ee0e30'",
                      "BASE='73e9e40ccf806c8a21a099f5960cc9216dffa336'")
    start=text.index('    notes.write_text(f"""')
    end=text.index('    prior=',start)
    text=text[:start]+'''    notes.write_text((OUT/'RELEASE-NOTES.md').read_text('utf8')
        + f"\\n本轮通过 {delivery['gameplay_cases']} 项定向游戏场景以及运行时／菜单检查。"
        + f"\\n[完整更新说明](https://github.com/{SLUG}/blob/{VERSION}/docs/FIXES.md)\\n",encoding='utf8')
'''+text[end:]
    path=PUBLISH/'publish_hardmode1102.py'
    assert not path.exists(),'Do not replace an existing publication script'
    path.write_text(text,'utf8')
    print('Prepared source-only 1.1.2 publisher')

if __name__=='__main__':main()
