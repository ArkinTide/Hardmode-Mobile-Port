"""Enemy-only settled frames for character death strips lacking corpse shading.

Native enemy art already authors a dark final corpse. These eight enemy
families instead borrow player art, whose final frame must stay bright for
player death/revival. Private copies preserve every earlier frame verbatim.
"""
from pathlib import Path
import copy
import hashlib
import json
import re
import shutil
import uuid
from PIL import Image, ImageDraw
from create_project import load, save

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / "project"
SOURCES = {
    "sprMutant2BDead": "sprHMCorpse116Crystal",
    "sprMutant4Dead": "sprHMCorpse116Melting",
    "sprMutant4BDead": "sprHMCorpse116MeltingB",
    "sprMutant5Dead": "sprHMCorpse116Plant",
    "sprHM_enemies_mod_64": "sprHMCorpse116RogueFreak",
    "sprMutant8Dead": "sprHMCorpse116Robot",
    "sprMutant9Dead": "sprHMCorpse116Chicken",
    "sprMutant14Dead": "sprHMCorpse116Skeleton",
}


def uid(value):
    return str(uuid.uuid5(uuid.NAMESPACE_URL, "hardmode-corpse-1116/" + value))


def apply(project):
    records = []
    contacts = []
    for source, name in SOURCES.items():
        folder = PROJECT / "sprites" / source
        target = PROJECT / "sprites" / name
        target.mkdir(exist_ok=True)
        original = load(folder / (source + ".yy"))
        meta = copy.deepcopy(original)
        raw = json.dumps(meta)
        replacements = {source: name}
        for guid in set(re.findall(r"[a-f0-9]{8}-[a-f0-9-]{27}", raw)):
            replacements[guid] = uid(name + "/" + guid)
        for old, new in replacements.items():
            raw = raw.replace(old, new)
        meta = json.loads(raw)
        frames = original["frames"]
        hashes = []
        final_pair = None
        for index, frame in enumerate(frames):
            old = frame["name"]
            new = replacements[old]
            original_png = folder / (old + ".png")
            source_image = Image.open(original_png).convert("RGBA")
            image = source_image.copy()
            if index == len(frames) - 1:
                # Match the authored native corpse's 40% intensity, using
                # luminance so residual saturated player colours do not glow.
                pixels = []
                for r, g, b, a in source_image.getdata():
                    shade = round((299 * r + 587 * g + 114 * b) * .4 / 1000)
                    pixels.append((shade, shade, shade, a) if a else (r, g, b, a))
                image.putdata(pixels)
                image.save(target / (new + ".png"))
                final_pair = source_image, image
            else:
                shutil.copyfile(original_png, target / (new + ".png"))
            for old_layer in original["layers"]:
                old_layer_id = old_layer["name"]
                new_layer_id = replacements[old_layer_id]
                layer_target = target / "layers" / new / (new_layer_id + ".png")
                layer_target.parent.mkdir(parents=True, exist_ok=True)
                if index == len(frames) - 1:
                    image.save(layer_target)
                else:
                    shutil.copyfile(folder / "layers" / old / (old_layer_id + ".png"), layer_target)
            after = Image.open(target / (new + ".png")).convert("RGBA")
            assert source_image.getchannel("A").tobytes() == after.getchannel("A").tobytes()
            assert index == len(frames) - 1 or source_image.tobytes() == after.tobytes()
            hashes.append({"index": index, "source_png_sha256": hashlib.sha256(original_png.read_bytes()).hexdigest(),
                           "source_rgba_sha256": hashlib.sha256(source_image.tobytes()).hexdigest(),
                           "private_rgba_sha256": hashlib.sha256(after.tobytes()).hexdigest()})
        # The exact original bbox, origin, mask settings, animation speed,
        # frame count, alpha, and every early animation pixel are retained.
        path = "sprites/" + name + "/" + name + ".yy"
        save(target / (name + ".yy"), meta)
        if not any(r["id"]["path"] == path for r in project["resources"]):
            project["resources"].append({"id": {"name": name, "path": path}})
        records.append({"source": source, "private": name, "final_index": len(frames) - 1,
                        "original_meta_sha256": hashlib.sha256((folder / (source + ".yy")).read_bytes()).hexdigest(),
                        "frames": hashes})
        left, right = final_pair
        row = Image.new("RGBA", (440, 100), (44, 44, 44, 255))
        draw = ImageDraw.Draw(row)
        draw.text((0, 5), source, fill="white")
        for image, x in [(left, 230), (right, 330)]:
            image = image.resize((image.width * 3, image.height * 3), Image.Resampling.NEAREST)
            row.alpha_composite(image, (x, 15))
        contacts.append(row)
    out = ROOT / "analysis"
    out.mkdir(exist_ok=True)
    (out / "corpse116-assets.json").write_text(json.dumps(records, indent=2) + "\n", encoding="utf-8")
    sheet = Image.new("RGBA", (440, 100 * len(contacts)))
    for index, row in enumerate(contacts):
        sheet.alpha_composite(row, (0, index * 100))
    sheet.save(out / "corpse116-before-after.png")
    print("Registered", len(records), "enemy-only corpse strips; early frames and all alpha preserved")


if __name__ == "__main__":
    yyp = PROJECT / "nuclearthronemobile.yyp"
    project = load(yyp)
    apply(project)
    save(yyp, project)
