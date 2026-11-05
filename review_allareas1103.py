"""Make local contact sheets from final-VM stage-spawn screenshots."""
from pathlib import Path
import hashlib
import json
from PIL import Image, ImageDraw
from release1103_allareas_plan import ENTRIES, AUXILIARY, scenario

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'release1103'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    vm = sha(ROOT / 'build-windows/nuclearthronemobile.win')
    groups = {}
    for entry in ENTRIES + AUXILIARY:
        groups.setdefault(entry[3], []).append(entry)
    target = OUT / 'visual-review'
    target.mkdir(exist_ok=True)
    rows = []
    for family, entries in groups.items():
        width, height, columns = 320, 210, min(4, len(entries))
        sheet = Image.new('RGB', (width * columns, height * ((len(entries)+columns-1)//columns)), '#171717')
        draw = ImageDraw.Draw(sheet)
        sources = []
        for index, entry in enumerate(entries):
            case = scenario(entry, 60)
            folder = OUT / 'tests' / case.replace(',', '-')
            receipt = json.loads((folder / 'receipt.json').read_text('utf8'))
            assert receipt['vm_sha256'] == vm and receipt['status'] == 'PASS'
            screenshot = folder / 'allarea.png'
            with Image.open(screenshot) as source:
                source = source.convert('RGB')
                source.thumbnail((width, height-30), Image.Resampling.NEAREST)
                x, y = index % columns * width, index // columns * height
                sheet.paste(source, (x+(width-source.width)//2, y+25))
                draw.text((x+5, y+4), entry[0] + '  L' + str(entry[4]), fill='white')
            sources.append(dict(scenario=case, screenshot=screenshot.relative_to(ROOT).as_posix(), sha256=sha(screenshot)))
        path = target / (family.replace(' ', '-') + '.png')
        sheet.save(path)
        rows.append(dict(family=family, contact_sheet=path.relative_to(ROOT).as_posix(), sha256=sha(path), sources=sources))
    report = dict(vm_sha256=vm, screenshot_count=sum(len(row['sources']) for row in rows),
                  scope='Spawn-camera visual contact sheets; not a complete-map or combat inspection.',
                  sheets=rows, manually_reviewed=False)
    (target / 'manifest.json').write_text(json.dumps(report, indent=2)+'\n', 'utf8')
    print('Stage-spawn contact sheets prepared:', report['screenshot_count'])


if __name__ == '__main__':
    main()
