"""Restore original font atlases without relocating GameMaker data chunks."""

import argparse
import copy
import hashlib
import io
import json
import plistlib
import re
from pathlib import Path
import struct
import zipfile

from PIL import Image


def chunks(data):
    assert data[:4] == b'FORM'
    assert struct.unpack_from('<I', data, 4)[0] == len(data) - 8
    result = {}
    pos = 8
    while pos < len(data):
        size = struct.unpack_from('<I', data, pos + 4)[0]
        result[bytes(data[pos:pos + 4])] = (pos + 8, size)
        pos += size + 8
    assert pos == len(data)
    return result


def read_png(data, pointer, capacity):
    raw = bytes(data[pointer:pointer + capacity])
    assert raw.startswith(b'\x89PNG\r\n\x1a\n')
    im = Image.open(io.BytesIO(raw))
    im.load()
    return im.convert('RGBA')


def encode_png(image, capacity):
    candidates = []
    output = io.BytesIO()
    image.save(output, format='PNG', optimize=True)
    candidates.append(output.getvalue())
    if len(candidates[0]) > capacity:
        colors = image.getcolors(256)
        if colors is not None:
            rgba = [color for count, color in colors]
            lookup = {color: index for index, color in enumerate(rgba)}
            indexed = Image.frombytes('P', image.size, bytes(lookup[color] for color in image.get_flattened_data()))
            palette = [component for color in rgba for component in color[:3]]
            indexed.putpalette(palette + [0] * (768 - len(palette)))
            indexed.info['transparency'] = bytes(color[3] for color in rgba)
            assert indexed.convert('RGBA').tobytes() == image.tobytes()
            output = io.BytesIO()
            indexed.save(output, format='PNG', optimize=True)
            candidates.append(output.getvalue())
    png = min(candidates, key=len)
    if len(png) > capacity:
        raise ValueError(f'Original font does not fit reserved texture space: {len(png)} > {capacity}')
    assert Image.open(io.BytesIO(png)).convert('RGBA').tobytes() == image.tobytes()
    return png


def source_glyphs(source, name):
    path = next(p for p in source.namelist() if p.endswith(f'/fonts/{name}/{name}.yy'))
    raw = source.read(path).decode('utf-8-sig')
    glyphs = {}
    for match in re.finditer(r'"(\d+)"\s*:\s*(?=\{)', raw):
        # GameMaker uses a trailing comma in these flat numeric JSON records.
        record = raw[match.end():raw.index('}', match.end()) + 1]
        glyph = json.loads(re.sub(r',\s*}', '}', record))
        assert glyph['character'] == int(match.group(1))
        glyphs[glyph['character']] = glyph
    return glyphs


def restore_title_atlas(result, source, parts):
    u32 = lambda p: struct.unpack_from('<I', result, p)[0]
    table = parts[b'SPRT'][0]
    sprite_ptr = None
    for index in range(u32(table)):
        ptr = u32(table + 4 + index * 4)
        string = u32(ptr)
        name = bytes(result[string:result.index(0, string)]).decode('utf-8')
        if name == 'sprBignameAtlas':
            sprite_ptr = ptr
            break
    assert sprite_ptr is not None
    assert struct.unpack_from('<II', result, sprite_ptr + 4) == (2048, 2048)
    assert u32(sprite_ptr + 56) == 0xFFFFFFFF and u32(sprite_ptr + 60) == 3
    assert u32(sprite_ptr + 84) == 3
    path = next(p for p in source.namelist() if p.endswith('/sprites/sprBignameAtlas/sprBignameAtlas.yy'))
    raw = source.read(path).decode('utf-8-sig')
    frames = re.findall(r'"\$GMSpriteFrame":"v1","%Name":"([^"]+)"', raw)
    assert len(frames) == 3
    report = []
    for index, frame in enumerate(frames):
        tpag = u32(sprite_ptr + 88 + index * 4)
        sx, sy, sw, sh, tx, ty, tw, th, bw, bh, page = struct.unpack_from('<10Hh', result, tpag)
        assert (bw, bh) == (2048, 2048)
        factor=round(tw/sw)
        assert factor in (1,2,4) and abs(tw-sw*factor)<=factor and abs(th-sh*factor)<=factor
        texture = u32(parts[b'TXTR'][0] + 4 + page * 4)
        capacity, width, height = struct.unpack_from('<III', result, texture + 8)
        pointer = u32(texture + 24)
        original_page = read_png(result, pointer, capacity)
        assert original_page.size == (width, height)
        path = next(p for p in source.namelist() if p.endswith(f'/sprites/sprBignameAtlas/{frame}.png'))
        original = Image.open(io.BytesIO(source.read(path))).convert('RGBA')
        assert original.size == (bw, bh)
        assert original.getchannel('A').getbbox() == (tx, ty, tx + tw, ty + th)
        crop = original.crop((tx, ty, tx + tw, ty + th))
        new_page = original_page.resize((width * factor, height * factor), Image.Resampling.NEAREST)
        x, y = sx * factor, sy * factor
        assert x + tw <= new_page.width and y + th <= new_page.height
        new_page.paste(crop, (x, y))
        png = encode_png(new_page, capacity)
        result[pointer:pointer + capacity] = png + bytes(capacity - len(png))
        struct.pack_into('<III', result, texture + 8, len(png), new_page.width, new_page.height)
        tpag_table = parts[b'TPAG'][0]
        entries = 0
        for j in range(u32(tpag_table)):
            entry = u32(tpag_table + 4 + j * 4)
            values = struct.unpack_from('<10Hh', result, entry)
            if values[-1] == page:
                struct.pack_into('<4H', result, entry, *(v * factor for v in values[:4]))
                entries += 1
        # Odd crop heights are rounded during packing. Restore the exact source
        # dimensions so the hardcoded glyph rectangles sample at a 1:1 ratio.
        struct.pack_into('<4H', result, tpag, x, y, tw, th)
        check = read_png(result, pointer, len(png))
        assert check.tobytes() == new_page.tobytes()
        assert check.crop((x, y, x + tw, y + th)).tobytes() == crop.tobytes()
        report.append({'sprite': 'sprBignameAtlas', 'frame': index, 'texture_page': page,
                       'restored_sprite_size': [bw, bh], 'restored_crop': [tw, th],
                       'original_pixels_match': True, 'source_to_target_ratio': 1,
                       'updated_atlas_entries': entries, 'png_bytes': len(png),
                       'reserved_bytes': capacity})
    return report


def restore(game, source):
    result = bytearray(game)
    parts = chunks(result)
    u32 = lambda p: struct.unpack_from('<I', result, p)[0]
    fpos = parts[b'FONT'][0]
    fonts = {}
    for index in range(u32(fpos)):
        ptr = u32(fpos + 4 + index * 4)
        string = u32(ptr)
        name = bytes(result[string:result.index(0, string)]).decode('utf-8')
        fonts[name] = ptr
    report = []
    for name in ['fntCJK', 'fntCJKBig']:
        font_ptr = fonts[name]
        scale = struct.unpack_from('<ff', result, font_ptr + 32)
        expected_factor=round(scale[0])
        assert expected_factor in (1,2,4) and scale==(expected_factor,expected_factor), (name,scale)
        item_ptr = u32(font_ptr + 28)
        item = struct.unpack_from('<10Hh', result, item_ptr)
        sx, sy, sw, sh, tx, ty, tw, th, bw, bh, page = item
        assert tx == ty == 0 and tw == bw and th == bh
        assert sw * expected_factor == tw and sh * expected_factor == th
        texture_ptr = u32(parts[b'TXTR'][0] + 4 + page * 4)
        capacity, width, height = struct.unpack_from('<III', result, texture_ptr + 8)
        pointer = u32(texture_ptr + 24)
        old_page = read_png(result, pointer, capacity)
        assert old_page.size == (width, height)
        path = next(n for n in source.namelist() if n.endswith(f'/fonts/{name}/{name}.png'))
        original = Image.open(io.BytesIO(source.read(path))).convert('RGBA')
        assert original.size == (tw, th)
        factor = expected_factor
        new_page = old_page.resize((width * factor, height * factor), Image.Resampling.NEAREST)
        x, y = sx * factor, sy * factor
        new_page.paste(original, (x, y))
        png = encode_png(new_page, capacity)
        result[pointer:pointer + capacity] = png + bytes(capacity - len(png))
        struct.pack_into('<III', result, texture_ptr + 8, len(png), width * factor, height * factor)
        struct.pack_into('<ff', result, font_ptr + 32, 1.0, 1.0)
        glyphs = source_glyphs(source, name)
        glyph_count = u32(font_ptr + 56)
        assert glyph_count == len(glyphs)
        for index in range(glyph_count):
            glyph_ptr = u32(font_ptr + 60 + index * 4)
            character, gx, gy, gw, gh, shift, offset, kernings = struct.unpack_from('<5H2hH', result, glyph_ptr)
            assert kernings == 0, 'Kerning restoration requires original kerning data'
            glyph = glyphs[character]
            assert all(0 <= glyph[key] <= 65535 for key in ['x', 'y', 'w', 'h'])
            assert glyph['x'] + glyph['w'] <= original.width
            assert glyph['y'] + glyph['h'] <= original.height
            assert abs(gx * factor - glyph['x']) <= factor
            assert abs(gy * factor - glyph['y']) <= factor
            struct.pack_into('<4H2h', result, glyph_ptr + 2,
                             *(glyph[k] for k in ['x', 'y', 'w', 'h', 'shift', 'offset']))
        table = parts[b'TPAG'][0]
        count = 0
        for index in range(u32(table)):
            entry = u32(table + 4 + index * 4)
            values = struct.unpack_from('<10Hh', result, entry)
            if values[-1] != page:
                continue
            struct.pack_into('<4H', result, entry, *(v * factor for v in values[:4]))
            count += 1
        check = read_png(result, pointer, len(png))
        assert check.crop((x, y, x + tw, y + th)).tobytes() == original.tobytes()
        # Every pixel outside the restored font region is an exact nearest-neighbor
        # expansion; the original sprite geometry stays in the TPAG target fields.
        mask_expected = old_page.resize(check.size, Image.Resampling.NEAREST)
        mask_expected.paste(original, (x, y))
        assert check.tobytes() == mask_expected.tobytes()
        report.append({'font': name, 'page': page, 'old_page': [width, height],
                       'new_page': list(check.size), 'restored_font': list(original.size),
                       'original_pixels_match': True, 'updated_atlas_entries': count,
                       'restored_glyph_records': glyph_count,
                       'png_bytes': len(png), 'reserved_bytes': capacity})
    title_report = restore_title_atlas(result, source, parts)
    assert len(result) == len(game)
    assert chunks(result) == parts
    for tag, (start, size) in parts.items():
        if tag not in (b'FONT', b'TPAG', b'TXTR'):
            assert result[start:start + size] == game[start:start + size], tag
    return bytes(result), report, title_report

