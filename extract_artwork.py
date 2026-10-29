"""Recover literal embedded Hardmode art; do not run the attached mod source."""
from pathlib import Path
from io import BytesIO
import ast
import base64
import hashlib
import json
import re
import sys

ROOT = Path(__file__).resolve().parent
WORKSPACE = ROOT.parents[1]
sys.path.insert(0, str(WORKSPACE / "work/controller-deps"))
from PIL import Image
from gml_frontend import tokenize, call_arguments, original_text


def numeric(text):
    node = ast.parse(text, mode="eval").body
    def value(item):
        if isinstance(item, ast.Constant) and type(item.value) in (int, float):
            return item.value
        if isinstance(item, ast.UnaryOp) and isinstance(item.op, (ast.USub, ast.UAdd)):
            return (-1 if isinstance(item.op, ast.USub) else 1) * value(item.operand)
        if isinstance(item, ast.BinOp) and isinstance(item.op, (ast.Add, ast.Sub, ast.Mult, ast.Div)):
            a, b = value(item.left), value(item.right)
            return a + b if isinstance(item.op, ast.Add) else a - b if isinstance(item.op, ast.Sub) else a * b if isinstance(item.op, ast.Mult) else a / b
        raise ValueError("Nonliteral sprite parameter: " + text)
    result = value(node)
    return int(result) if result == int(result) else result


def main():
    inventory = json.loads((ROOT / "mod-inventory.json").read_text(encoding="utf8"))
    rows, unresolved, token_stats = [], [], []
    for module in inventory["modules"]:
        path = ROOT / "reference/hardmode-b24" / module["path"]
        source = path.read_text(encoding="utf-8-sig")
        tokens = tokenize(source)
        token_stats.append({"path": module["path"], "tokens": len(tokens)})
        for i, token in enumerate(tokens[:-1]):
            if token.kind != "identifier" or token.text not in {"sprite_add_base64", "sprite_replace_base64", "sprite_add_weapon_base64"} or tokens[i + 1].text != "(":
                continue
            arguments, end = call_arguments(tokens, i)
            replacing = token.text == "sprite_replace_base64"
            literal_index = int(replacing)
            weapon = token.text == "sprite_add_weapon_base64"
            try:
                assert len(arguments) == (3 if weapon else 4 + literal_index)
                assert len(arguments[literal_index]) == 1 and arguments[literal_index][0].kind == "string"
                encoded = ast.literal_eval(arguments[literal_index][0].text)
                data = base64.b64decode(encoded, validate=True)
                values = [numeric(original_text(source, arg)) for arg in arguments[literal_index + 1:]]
                frames, ox, oy = [1, *values] if weapon else values
                image = Image.open(BytesIO(data)).convert("RGBA")
                assert isinstance(frames, int) and frames > 0 and image.width % frames == 0 and image.width <= 16384 and image.height <= 16384
                stem = re.sub(r"[^A-Za-z0-9]", "_", module["path"].removesuffix(".gml"))
                name = f"sprHM_{stem}_{token.line}"
                target = ROOT / "assets/mod-art" / (name + ".png")
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(data)
                rows.append({
                    "source": module["path"], "line": token.line, "call": token.text,
                    "source_start": token.start, "source_end": tokens[end].end,
                    "native_resource": name, "file": target.relative_to(ROOT).as_posix(),
                    "png_sha256": hashlib.sha256(data).hexdigest(),
                    "rgba_sha256": hashlib.sha256(image.tobytes()).hexdigest(),
                    "width": image.width // frames, "height": image.height, "frames": frames,
                    "origin": [ox, oy],
                    "replaced_native_sprite": original_text(source, arguments[0]) if replacing else None,
                })
            except Exception as error:
                unresolved.append({"source": module["path"], "line": token.line, "error": str(error)})
    report = {"status": "PASS" if not unresolved else "INCOMPLETE",
              "scope": "Exact embedded art extraction, not gameplay implementation",
              "declared_calls": inventory["embedded_sprite_declarations"],
              "extracted_calls": len(rows), "frames": sum(row["frames"] for row in rows),
              "unresolved": unresolved, "artwork": rows, "tokenized_modules": token_stats}
    (ROOT / "artwork-manifest.json").write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf8")
    print(json.dumps({k: report[k] for k in ["status", "declared_calls", "extracted_calls", "frames", "unresolved"]}, ensure_ascii=False, indent=2))
    assert not unresolved and len(rows) == inventory["embedded_sprite_declarations"]


if __name__ == "__main__":
    main()
