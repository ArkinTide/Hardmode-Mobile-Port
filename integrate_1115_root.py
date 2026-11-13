"""Narrow Hardmode 1.1.5 repairs; never rerun a historical full importer."""
from pathlib import Path
import re

ROOT=Path(__file__).resolve().parent
PROJECT=ROOT/'project'


def replace_function(relative,name,source):
    path=PROJECT/relative
    text=path.read_text('utf8')
    match=re.search(r'^function '+re.escape(name)+r'\([^\n]*\) \{',text,re.M)
    assert match,name
    # Compiled functions have an explicit source boundary; helper files have
    # an ordinary next function. The final closing brace belongs to this body.
    nxt=re.search(r'\n(?:// Source[^\n]*\n)?function ',text[match.end():])
    end=match.end()+nxt.start() if nxt else len(text)
    body=text[match.start():end]
    close=body.rfind('}')+match.start()+1
    assert close>match.end(),name
    text=text[:match.start()]+source.rstrip()+text[close:]
    path.write_text(text,'utf8')


def main():
    replace_function('scripts/scrHMCompiled_arkintide_mod_gml/scrHMCompiled_arkintide_mod_gml.gml',
        'hm_arkintide_mod_gml_hm_infantry_capture', '''function hm_arkintide_mod_gml_hm_infantry_capture() {
// The mobile host already has native IDPDSpawn animation/alarm ownership.
// Converting it halfway through Start/Charge/Close guessed a new phase and
// discarded its remaining arrival timer. Keep the real native gate alive;
// its Alarm 1 now applies Hardmode's weights and infantry count directly.
}''')


if __name__=='__main__':main()
