"""Private, deterministic 1.1.3 launcher icons and archive-level verification.

The user's complete picture is contained, never cropped. Only this code and its
hash/layout metadata may be published; the source and generated PNGs stay local.
"""
from pathlib import Path
import argparse
import hashlib
import io
import json
import math
import plistlib
import re
import subprocess
import xml.etree.ElementTree as ET
import zipfile

from PIL import Image, ImageDraw, __version__ as PILLOW_VERSION
from release_config import PACKAGE

ROOT = Path(__file__).resolve().parent
PRIVATE = ROOT / 'release1103/icon-source'
SOURCE = PRIVATE / 'TDA7gy.png'
ORIGINAL = Path('C:/Users/ArkinTide/Desktop/TDA7gy.png')
SOURCE_SHA256 = '80244ed3b3ab3dd7b817fd4ec51bf091d6c72424469260b81b96094d44bcec72'
ANDROID_NS = '{http://schemas.android.com/apk/res/android}'
DENSITIES = {'ldpi': (36, 81), 'mdpi': (48, 108), 'hdpi': (72, 162),
             'xhdpi': (96, 216), 'xxhdpi': (144, 324), 'xxxhdpi': (192, 432)}
RUNNER_MAIN = ROOT / 'platforms/android/gradle-project' / PACKAGE / 'src/main'
AAPT = ROOT / 'platforms/android/sdk/build-tools/34.0.0/aapt.exe'
ICON_PREFIX = 'HM113Icon'
PHONE_NAMES = ['20x20', '29x29', '40x40', '60x60']
IPAD_NAMES = ['20x20', '29x29', '40x40', '76x76', '83.5x83.5']
IOS_RENDITIONS = {
    '20x20@2x': 40, '20x20@3x': 60, '29x29@2x': 58,
    '29x29@3x': 87, '40x40@2x': 80, '40x40@3x': 120,
    '60x60@2x': 120, '60x60@3x': 180,
    '20x20~ipad': 20, '20x20@2x~ipad': 40,
    '29x29~ipad': 29, '29x29@2x~ipad': 58,
    '40x40~ipad': 40, '40x40@2x~ipad': 80,
    '76x76~ipad': 76, '76x76@2x~ipad': 152,
    '83.5x83.5@2x~ipad': 167,
}
IOS_OPTIONS = {
    'ipad_app_152': 'app/ipad_152.png', 'ipad_app_76': 'app/ipad_76.png',
    'ipad_pro_app_167': 'app/ipad_pro_167.png',
    'ipad_notification_20': 'notification/ipad_20.png',
    'ipad_notification_40': 'notification/ipad_40.png',
    'ipad_settings_29': 'settings/ipad_29.png',
    'ipad_settings_58': 'settings/ipad_58.png',
    'ipad_spotlight_40': 'spotlight/ipad_40.png',
    'ipad_spotlight_80': 'spotlight/ipad_80.png',
    'iphone_app_120': 'app/iphone_120.png', 'iphone_app_180': 'app/iphone_180.png',
    'iphone_notification_40': 'notification/iphone_40.png',
    'iphone_notification_60': 'notification/iphone_60.png',
    'iphone_settings_58': 'settings/iphone_58.png',
    'iphone_settings_87': 'settings/iphone_87.png',
    'iphone_spotlight_80': 'spotlight/iphone_80.png',
    'iphone_spotlight_120': 'spotlight/iphone_120.png',
    'itunes_artwork_1024': 'itunes/itunes_1024.png',
}


def sha(data):
    return hashlib.sha256(data).hexdigest()


def source_image():
    if not SOURCE.exists():
        data = ORIGINAL.read_bytes()
        assert sha(data) == SOURCE_SHA256, 'The supplied icon has changed.'
        PRIVATE.mkdir(parents=True, exist_ok=True)
        SOURCE.write_bytes(data)
    data = SOURCE.read_bytes()
    assert sha(data) == SOURCE_SHA256
    image = Image.open(io.BytesIO(data)).convert('RGBA')
    assert image.size == (347, 384)
    assert image.getchannel('A').getextrema() == (255, 255)
    return image


def png(image):
    stream = io.BytesIO()
    image.save(stream, format='PNG', optimize=False)
    return stream.getvalue()


def pixel_info(data):
    image = Image.open(io.BytesIO(data)).convert('RGBA')
    return {'size': list(image.size), 'rgba_sha256': sha(image.tobytes()),
            'png_sha256': sha(data)}


def render(size, adaptive=False):
    """Return the full artwork, its continued edge background, and fit bounds."""
    source = source_image()
    # All four source corners fit inside Android's central 66/108 safe circle.
    # The margin absorbs pixel rounding and keeps HARDMODE intact under masks.
    if adaptive:
        height = math.floor(size * (66 / 108) * .96 /
                            math.sqrt(1 + (source.width / source.height) ** 2))
    else:
        height = round(size * .88)
    width = round(height * source.width / source.height)
    x, y = (size - width) // 2, (size - height) // 2
    fitted = source.resize((width, height), Image.Resampling.LANCZOS)
    background = Image.new('RGBA', (size, size))
    draw = ImageDraw.Draw(background)
    for row in range(size):
        sample = min(source.height - 1, max(0, round((row - y) * source.height / height)))
        left, right = source.getpixel((0, sample)), source.getpixel((source.width - 1, sample))
        color = tuple(round((left[c] + right[c]) / 2) for c in range(3)) + (255,)
        draw.line((0, row, size, row), fill=color)
    foreground = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    foreground.alpha_composite(fitted, (x, y))
    if adaptive:
        radius = size * 33 / 108
        assert max(math.hypot(px - size / 2, py - size / 2)
                   for px in (x, x + width) for py in (y, y + height)) < radius
    else:
        background.alpha_composite(foreground)
    return foreground if adaptive else background, background, [x, y, width, height]


def icon_png(size):
    return png(render(size)[0].convert('RGB'))


def adaptive_pngs(size):
    foreground, background, bounds = render(size, adaptive=True)
    return png(foreground), png(background.convert('RGB')), bounds


def save(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(data)


def apply_android_runner_icons():
    """Refresh the actual retained Gradle project, independent of Igor output."""
    source_image()
    files = {}
    res = RUNNER_MAIN / 'res'
    files[res / 'drawable/icon.png'] = icon_png(192)
    xml = ('<?xml version="1.0" encoding="utf-8"?>\n'
           '<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">\n'
           '  <background android:drawable="@drawable/adaptive_bg"/>\n'
           '  <foreground android:drawable="@drawable/adaptive_icon"/>\n'
           '</adaptive-icon>\n').encode('utf-8')
    for density, (legacy, adaptive) in DENSITIES.items():
        foreground, background, _ = adaptive_pngs(adaptive)
        files[res / f'drawable-{density}/icon.png'] = icon_png(legacy)
        folder = res / f'drawable-{density}-v26'
        files[folder / 'icon.xml'] = xml
        files[folder / 'adaptive_icon.png'] = foreground
        files[folder / 'adaptive_bg.png'] = background
    for path, data in files.items():
        save(path, data)
    manifest = RUNNER_MAIN / 'AndroidManifest.xml'
    ET.register_namespace('android', ANDROID_NS[1:-1])
    ET.register_namespace('tools', 'http://schemas.android.com/tools')
    tree = ET.parse(manifest)
    assert tree.getroot().get('package') == PACKAGE
    application = tree.getroot().find('application')
    application.set(ANDROID_NS + 'icon', '@drawable/icon')
    application.set(ANDROID_NS + 'roundIcon', '@drawable/icon')
    tree.write(manifest, encoding='utf-8', xml_declaration=True)
    return {p.relative_to(ROOT).as_posix(): sha(d) for p, d in files.items()}


def ios_icon_resources(info):
    """Select standalone icon files, so the retained asset catalog is inactive."""
    phone = [ICON_PREFIX + name for name in PHONE_NAMES]
    ipad = [ICON_PREFIX + name for name in IPAD_NAMES]
    info['CFBundleIcons'] = {'CFBundlePrimaryIcon': {'CFBundleIconFiles': phone}}
    info['CFBundleIcons~ipad'] = {'CFBundlePrimaryIcon': {'CFBundleIconFiles': ipad}}
    info['CFBundleIconFiles'] = list(dict.fromkeys(phone + ipad))
    info['UIPrerenderedIcon'] = True
    info.pop('CFBundleIconName', None)
    info.pop('CFBundleIconFile', None)
    files = {ICON_PREFIX + suffix + '.png': icon_png(size)
             for suffix, size in IOS_RENDITIONS.items()}
    # Replace these existing fallback files too; do not alter Assets.car because
    # it also supplies native launch/UI resources. No catalog icon is selected.
    files['AppIcon60x60@2x.png'] = icon_png(120)
    files['AppIcon76x76@2x~ipad.png'] = icon_png(152)
    return files


def apply_project_icons():
    files = {}
    options = ROOT / 'project/options'
    for density, (legacy, adaptive) in DENSITIES.items():
        foreground, background, _ = adaptive_pngs(adaptive)
        files[options / f'android/icons/icon_{density}.png'] = icon_png(legacy)
        files[options / f'android/icons_adaptive/{density}.png'] = foreground
        files[options / f'android/icons_adaptivebg/{density}.png'] = background
    ios_options = options / 'ios/options_ios.yy'
    obj = json.loads(ios_options.read_text(encoding='utf-8'))
    for key, name in IOS_OPTIONS.items():
        size = int(re.search(r'_(\d+)\.png$', name)[1])
        files[options / 'ios/icons' / name] = icon_png(size)
        obj['option_ios_icon_' + key] = '${options_dir}/ios/icons/' + name
    for size in [57, 72, 76, 114, 120, 144, 152, 167]:
        files[options / f'ios/icons/icon{size}.png'] = icon_png(size)
    ios_options.write_text(json.dumps(obj, indent=2) + '\n', encoding='utf-8')
    for path, data in files.items():
        save(path, data)
    runner = apply_android_runner_icons()
    master = icon_png(1024)
    save(PRIVATE / 'launcher-square-1024.png', master)
    foreground, background, _ = render(864, adaptive=True)
    background.alpha_composite(foreground)
    # Preview a circular 72dp launcher window; the entire source is still inside.
    inset = 144
    circle = background.crop((inset, inset, 864 - inset, 864 - inset))
    mask = Image.new('L', circle.size, 0)
    ImageDraw.Draw(mask).ellipse((0, 0, circle.width - 1, circle.height - 1), fill=255)
    circle.putalpha(mask)
    save(PRIVATE / 'launcher-adaptive-circle-preview.png', png(circle))
    receipt = {'source_private': 'release1103/icon-source/TDA7gy.png',
               'source_sha256': SOURCE_SHA256, 'source_size': [347, 384],
               'source_cropped': False, 'aspect_ratio_preserved': True,
               'pillow': PILLOW_VERSION, 'resampling': 'LANCZOS',
               'square_content_height_fraction': .88,
               'adaptive_safe_circle_diameter_dp': 66,
               'adaptive_canvas_dp': 108, 'adaptive_safe_circle_margin': .96,
               'padding': 'continue average source left/right border color per row',
               'ios_active_basename': ICON_PREFIX, 'assets_publication': False,
               'project_files': {p.relative_to(ROOT).as_posix(): pixel_info(d)
                                 for p, d in files.items()},
               'android_runner_files': runner,
               'ios_asset_catalog_icon_selected': False}
    save(PRIVATE / 'icon-plan.json', (json.dumps(receipt, indent=2) + '\n').encode('utf-8'))
    return receipt


def verify_ios_icon(ipa):
    expected_info = {}
    files = ios_icon_resources(expected_info)
    with zipfile.ZipFile(ipa) as archive:
        info_path = next(n for n in archive.namelist() if n.endswith('.app/Info.plist'))
        app = info_path.removesuffix('Info.plist')
        info = plistlib.loads(archive.read(info_path))
        for key, expected in expected_info.items():
            assert info.get(key) == expected, ('iOS icon selection', key)
        assert 'CFBundleIconName' not in info and 'CFBundleIconFile' not in info
        checked = {}
        for name, expected in files.items():
            data = archive.read(app + name)
            assert pixel_info(data)['rgba_sha256'] == pixel_info(expected)['rgba_sha256'], name
            assert Image.open(io.BytesIO(data)).mode == 'RGB', name
            checked[name] = pixel_info(data)
        catalog = archive.read(app + 'Assets.car') if app + 'Assets.car' in archive.namelist() else None
    return {'source_sha256': SOURCE_SHA256, 'active_icon_basename': ICON_PREFIX,
            'all_active_icon_pixels_match': True, 'source_cropped': False,
            'catalog_icon_selected': False,
            'retained_native_asset_catalog_sha256': sha(catalog) if catalog else None,
            'files': checked}


def aapt(*args):
    return subprocess.check_output([str(AAPT), *map(str, args)], text=True, encoding='utf-8')


def verify_android_icon(apk):
    """Follow compiled manifest/resource IDs (including obfuscated ZIP names)."""
    text = aapt('dump', '--values', 'resources', apk)
    lines = text.splitlines()
    resources = {}
    config = ''
    for index, line in enumerate(lines):
        match = re.match(r'\s*config (.*):$', line)
        if match:
            config = match[1]
        match = re.match(r'\s*resource (0x[0-9a-f]+) \S+:drawable/(icon|adaptive_bg|adaptive_icon):', line)
        if match:
            path = re.search(r'\(string8\) "([^"]+)"', lines[index + 1])
            assert path, line
            name = match[2]
            resources.setdefault(name, {})[config] = {'id': match[1], 'path': path[1]}
    assert set(resources) == {'icon', 'adaptive_bg', 'adaptive_icon'}
    manifest = aapt('dump', 'xmltree', apk, 'AndroidManifest.xml')
    selected = re.findall(r'android:(?:icon|roundIcon)\(0x[0-9a-f]+\)=@(0x[0-9a-f]+)', manifest)
    icon_id = resources['icon']['(default)']['id']
    assert selected and all(value == icon_id for value in selected), selected
    expected_configs = {'(default)', *DENSITIES, *(d + '-v26' for d in DENSITIES)}
    assert set(resources['icon']) == expected_configs
    assert set(resources['adaptive_bg']) == {d + '-v26' for d in DENSITIES}
    assert set(resources['adaptive_icon']) == {d + '-v26' for d in DENSITIES}
    checked = {}
    with zipfile.ZipFile(apk) as archive:
        for config, item in resources['icon'].items():
            if config.endswith('-v26'):
                xml = aapt('dump', 'xmltree', apk, item['path'])
                assert 'E: adaptive-icon' in xml
                refs = re.findall(r'android:drawable\(0x[0-9a-f]+\)=@(0x[0-9a-f]+)', xml)
                expected_refs = [resources[n][config]['id'] for n in ['adaptive_bg', 'adaptive_icon']]
                assert refs == expected_refs, (config, refs, expected_refs)
                assert xml.index('E: background') < xml.index('E: foreground')
                size = DENSITIES[config.removesuffix('-v26')][1]
                foreground, background, _ = adaptive_pngs(size)
                for name, expected in [('adaptive_icon', foreground), ('adaptive_bg', background)]:
                    path = resources[name][config]['path']
                    data = archive.read(path)
                    assert pixel_info(data)['rgba_sha256'] == pixel_info(expected)['rgba_sha256'], (config, name)
                    checked[config + '/' + name] = dict(path=path, **pixel_info(data))
            else:
                size = 192 if config == '(default)' else DENSITIES[config][0]
                data = archive.read(item['path'])
                assert pixel_info(data)['rgba_sha256'] == pixel_info(icon_png(size))['rgba_sha256'], config
                checked[config + '/icon'] = dict(path=item['path'], **pixel_info(data))
    badging = aapt('dump', 'badging', apk)
    selected_paths = re.findall(r"application-icon-\d+:'([^']+)'", badging)
    assert selected_paths and set(selected_paths) <= {r['path'] for r in resources['icon'].values()}
    return {'source_sha256': SOURCE_SHA256, 'manifest_icon_id': icon_id,
            'compiled_resource_paths_resolved': True, 'all_active_icon_pixels_match': True,
            'source_cropped': False, 'adaptive_foreground_safe_circle_verified': True,
            'application_icon_paths': selected_paths, 'files': checked}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('command', choices=['apply', 'verify-android', 'verify-ios'])
    parser.add_argument('package', nargs='?')
    args = parser.parse_args()
    if args.command == 'apply':
        result = apply_project_icons()
        print('Icon source and project/runner images verified; private receipt:', PRIVATE / 'icon-plan.json')
    else:
        assert args.package, 'A final APK/IPA path is required.'
        result = (verify_android_icon if args.command == 'verify-android' else verify_ios_icon)(Path(args.package))
        target = Path(args.package).with_suffix('.icons.json')
        target.write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
        print('Actual package icon pixels and active selection verified:', target)
