"""Register exact extracted Hardmode strips as native GameMaker sprites."""
from copy import deepcopy
import hashlib
import json
from pathlib import Path
import uuid

from PIL import Image
from create_project import load
from register_native import PROJECT, ROOT, write, register_script, replace


def guid(name):
    return str(uuid.uuid5(uuid.NAMESPACE_URL, "hardmode-b24/" + name))


def main():
    source = load(ROOT / "artwork-manifest.json")
    assert source["status"] == "PASS"
    project = load(PROJECT / "nuclearthronemobile.yyp")
    template = load(PROJECT / "sprites/sprBanditIdle/sprBanditIdle.yy")
    resources = {item["id"]["path"] for item in project["resources"]}
    manifest, origin_initializers = [], []
    for asset in source["artwork"]:
        png = ROOT / asset["file"]
        assert hashlib.sha256(png.read_bytes()).hexdigest() == asset["png_sha256"]
        name = asset["native_resource"]
        relative = f"sprites/{name}/{name}.yy"
        destination = PROJECT / "sprites" / name
        destination.mkdir(exist_ok=True)
        sprite = deepcopy(template)
        sprite["name"] = sprite["%Name"] = name
        sprite["width"], sprite["height"] = asset["width"], asset["height"]
        sprite["bboxMode"] = 0
        sprite["parent"] = {"name": "Sprites", "path": "folders/Sprites.yy"}
        sprite["frames"] = []
        layer = deepcopy(template["layers"][0])
        layer["name"] = layer["%Name"] = guid(name + "/layer")
        sprite["layers"] = [layer]
        keys, bbox, pixels = [], None, []
        with Image.open(png) as strip:
            strip = strip.convert("RGBA")
            for index in range(asset["frames"]):
                frame = guid(name + "/frame/" + str(index))
                crop = strip.crop((index * asset["width"], 0, (index + 1) * asset["width"], asset["height"]))
                box = crop.getbbox()
                if box:
                    bbox = box if bbox is None else (min(bbox[0], box[0]), min(bbox[1], box[1]), max(bbox[2], box[2]), max(bbox[3], box[3]))
                crop.save(destination / (frame + ".png"))
                image_layer = destination / "layers" / frame / (layer["name"] + ".png")
                image_layer.parent.mkdir(parents=True, exist_ok=True)
                crop.save(image_layer)
                pixels.append(hashlib.sha256(crop.tobytes()).hexdigest())
                sprite["frames"].append({"$GMSpriteFrame": "v1", "%Name": frame, "name": frame,
                                          "resourceType": "GMSpriteFrame", "resourceVersion": "2.0"})
                keys.append({"$Keyframe<SpriteFrameKeyframe>": "", "Channels": {"0": {
                    "$SpriteFrameKeyframe": "", "Id": {"name": frame, "path": relative},
                    "resourceType": "SpriteFrameKeyframe", "resourceVersion": "2.0"}},
                    "Disabled": False, "id": guid(name + "/key/" + str(index)), "IsCreationKey": False,
                    "Key": index, "Length": 1, "resourceType": "Keyframe<SpriteFrameKeyframe>",
                    "resourceVersion": "2.0", "Stretch": False})
        bbox = bbox or (0, 0, asset["width"], asset["height"])
        sprite.update(bbox_left=bbox[0], bbox_top=bbox[1], bbox_right=bbox[2] - 1, bbox_bottom=bbox[3] - 1)
        sequence = sprite["sequence"]
        sequence["name"] = sequence["%Name"] = name
        sequence["length"] = asset["frames"]
        # YY has integer-only fields. Apply the exact legacy values via the
        # runtime API and verify its behavior separately, rather than silently
        # discarding the fractions from the source manifest.
        sequence["xorigin"], sequence["yorigin"] = [int(value) for value in asset["origin"]]
        if any(value != int(value) for value in asset["origin"]):
            origin_initializers.append(f"    sprite_set_offset({name}, {asset['origin'][0]}, {asset['origin'][1]});")
        sequence["tracks"][0]["keyframes"]["Keyframes"] = keys
        write(relative, json.dumps(sprite, indent=2) + "\n")
        if relative not in resources:
            project["resources"].append({"id": {"name": name, "path": relative}})
            resources.add(relative)
        manifest.append({"resource": name, "frames": asset["frames"], "origin": asset["origin"],
                         "frame_rgba_sha256": pixels, "source": asset["source"], "source_line": asset["line"]})
    init = "function scrHMArtworkInit() {\n" + "\n".join(origin_initializers) + "\n}\n"
    tests = '''function scrHMArtworkTests() {
    if (os_type != os_windows) return false;
    var _enabled = false;
    for (var _i=1; _i<=parameter_count(); ++_i) if (parameter_string(_i)=="--hardmode-artwork-tests") _enabled=true;
    if (!_enabled) return false;
    var _mismatches = [], _checks = 0;
'''
    for entry, asset in zip(manifest, source["artwork"]):
        name, origin = entry["resource"], entry["origin"]
        tests += f'''    assert(sprite_get_number({name}) == {entry['frames']}, "Hardmode frame count: {name}");
    assert(sprite_get_width({name}) == {asset['width']} && sprite_get_height({name}) == {asset['height']}, "Hardmode dimensions: {name}");
    if (sprite_get_xoffset({name}) != {origin[0]} || sprite_get_yoffset({name}) != {origin[1]}) array_push(_mismatches, {{sprite:"{name}", expected:[{origin[0]},{origin[1]}],actual:[sprite_get_xoffset({name}),sprite_get_yoffset({name})]}});
    _checks += 3;
'''
    tests += '''    show_debug_message("HARDMODE ARTWORK RESULT " + json_stringify({checks:_checks,origin_mismatches:_mismatches}));
    UberCont.dont_save=true;
    game_end();
    return true;
}
'''
    register_script(project, "scrHMArtwork", init + tests)
    write("nuclearthronemobile.yyp", json.dumps(project, ensure_ascii=False, indent=2) + "\n")
    replace("objects/MakeGame/Alarm_0.gml", "if (scrHMRunRadiationTests()) exit;",
            "scrHMArtworkInit();\nif (scrHMArtworkTests()) exit;\nif (scrHMRunRadiationTests()) exit;")
    (ROOT / "native-artwork-receipt.json").write_text(json.dumps({
        "status": "REGISTERED_PENDING_RUNTIME_ORIGIN_CHECK", "sprites": len(manifest),
        "frames": sum(entry["frames"] for entry in manifest), "resources": manifest,
        "scope": "Native resources only; not gameplay or replacement lifecycle verification",
    }, indent=2) + "\n", encoding="utf8")
    print("Registered", len(manifest), "Hardmode sprites and", sum(entry["frames"] for entry in manifest), "exact frames")


if __name__ == "__main__":
    main()
