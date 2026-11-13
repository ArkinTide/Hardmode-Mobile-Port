"""Prepare the next publisher without staging, pushing or queueing uploads."""
from pathlib import Path

ROOT=Path(__file__).resolve().parent


def main():
    publisher=ROOT.parent.parent/'github-publish'
    destination=publisher/'publish_hardmode1106.py'
    if not destination.exists():
        text=(publisher/'publish_hardmode1105.py').read_text('utf8')
        text=text.replace('hardmode-mobile-1115','hardmode-mobile-1116').replace('release1105','release1106')
        text=text.replace('prepare_publication1105','prepare_publication1106')
        text=text.replace("VERSION='1.1.5'","VERSION='1.1.6'").replace('BUILD=19','BUILD=20')
        text=text.replace("BASE='48ac73f965f83240a1a88c1253207aff27866715'",
            "BASE='dde1d552c1d92b590206f60b4ac25649ea5a17fc'")
        destination.write_text(text,'utf8')
    # Current and historical scope files have distinct staging destinations.
    # Preserve both; a global version replacement would overwrite the current
    # scope with the previous release's evidence when this helper is rerun.
    text=(ROOT/'prepare_publication1106.py').read_text('utf8')
    assert "add(OUT/'scope-coverage.json','docs/scope-1.1.6.json')" in text
    assert "add(ROOT/'release1105/scope-coverage.json','docs/scope-1.1.5.json')" in text
    print('Prepared 1.1.6 publication tool; no network or Git mutation')


if __name__=='__main__':main()
