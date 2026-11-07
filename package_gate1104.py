"""Fresh 1.1.4 package acceptance using the retained published 1.1.3 APK.

Only unchanged Gradle built-ins and signing continuity use that baseline.
Every game resource and compiled repair is checked in the new actual archives.
The caller supplies the current release's compiled-code acceptance function.
"""
from pathlib import Path
from datetime import datetime
import plistlib
import zipfile

from release_config import VERSION, BUILD, PACKAGE
from make_release1103_receipt import (Game, sha, rawsha, read, verify_artwork,
    verify_android_icon, verify_ios_icon, ICON_SOURCE_SHA256, ICON_PREFIX)

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'release1104'


def verify_packages(desktop, functions, pairs, verify_code):
    build = read(OUT / 'mobile-resource-build.json')
    assert (build['status'], build['version'], build['build']) == ('PASS', VERSION, BUILD)
    assert build['source_manifest_sha256'] == sha(OUT / 'final-source.json')
    assert build['source_code_archive_sha256'] == sha(OUT / 'final-code.zip')
    assert build['desktop_vm_sha256'] == desktop and set(build['targets']) == {'android', 'ios'}
    android_baseline = ROOT / 'deliverables/NuclearThrone.Hardmode-Android-1.1.3.apk'
    baseline_validation_path = android_baseline.with_suffix('.validation.json')
    baseline_validation = read(baseline_validation_path)
    assert (baseline_validation['package'], baseline_validation['version'], baseline_validation['build']) == (PACKAGE, '1.1.3', 17)
    assert sha(android_baseline) == baseline_validation['apk_sha256']
    # Gradle's four built-in files are inherited from the verified 1.1.3 APK;
    # they are not part of the freshly compiled GameMaker resource set.
    builtin_names = {'dexopt/baseline.prof', 'dexopt/baseline.profm', 'portrait_splash.png', 'splash.png'}
    with zipfile.ZipFile(android_baseline) as archive:
        assert archive.testzip() is None
        builtin_assets = {name: rawsha(archive.read('assets/' + name)) for name in builtin_names}
    artifacts = []
    for target, label, ext in [('android', 'Android', 'apk'), ('ios', 'iOS', 'ipa')]:
        path = ROOT / f'deliverables/NuclearThrone.Hardmode-{label}-{VERSION}.{ext}'
        validation_path = path.with_suffix('.validation.json')
        validation = read(validation_path)
        assert (validation['package'], validation['version'], validation['build']) == (PACKAGE, VERSION, BUILD)
        assert validation[ext + '_sha256'] == sha(path)
        assert validation['physical_device_tested'] is False
        prep_path = ROOT / f'platforms/{target}/prepared-receipt.json'
        prep = read(prep_path)
        assert prep['target'] == target
        assert prep['timing_code'] == 'gml_Object_MakeGame_Create_0'
        assert prep['timing_method'] == (1 if target == 'ios' else 0)
        assert prep['timing_reference_count'] == 2
        assert len(prep['fonts']) == 2 and all(row['original_pixels_match'] for row in prep['fonts'])
        assert len(prep['title']) == 3 and all(row['original_pixels_match'] for row in prep['title'])
        vm = 'game.droid' if target == 'android' else 'game.ios'
        resource_zip = ROOT / f'build-{target}/nuclearthronemobile.zip'
        resource = build['targets'][target]
        assert resource['zip_sha256'] == sha(resource_zip)
        assert datetime.fromisoformat(resource['built_utc']) >= datetime.fromisoformat(read(OUT / 'final-source.json')['recorded_utc'])
        with zipfile.ZipFile(resource_zip) as archive:
            assert archive.testzip() is None
            assert rawsha(archive.read('assets/' + vm)) == resource['raw_vm_sha256'] == prep['raw_vm_sha256']
            resource_assets = {name.removeprefix('assets/') for name in archive.namelist()
                               if name.startswith('assets/') and not name.endswith('/')}
            assert resource_assets == set(prep['assets']), (target, 'Prepared resource inventory mismatch')
        prepared = ROOT / f'platforms/{target}/prepared-assets/{vm}'
        prepared_digest = sha(prepared)
        assert prepared_digest == prep['prepared_vm_sha256']
        prepared_root = prepared.parent
        prepared_names = {file.relative_to(prepared_root).as_posix()
                          for file in prepared_root.rglob('*') if file.is_file()}
        assert prepared_names == set(prep['assets']), (target, 'Stale loose prepared assets')
        for name, digest in prep['assets'].items():
            assert sha(prepared_root / name) == digest, (target, 'Prepared resource hash mismatch', name)
        # Inspect the exact packaged VM rather than trusting a loose prepared file.
        with zipfile.ZipFile(path) as archive:
            assert archive.testzip() is None and len(archive.namelist()) == len(set(archive.namelist()))
            if target == 'android':
                packaged_vm = archive.read('assets/' + vm)
                assert validation['game_assets_exact'] and validation['zip_16k_alignment']
                omitted = {'.gitignore', 'lang/.gitkeep'}
                assert set(validation['ignored_non_game_files']) == omitted
                expected_assets = set(prep['assets']) - omitted
                assert not (builtin_names & set(prep['assets']))
                packaged_assets = {name.removeprefix('assets/') for name in archive.namelist()
                                   if name.startswith('assets/') and not name.endswith('/')}
                assert packaged_assets == expected_assets | builtin_names, 'Stale or missing APK resource'
                for name in expected_assets:
                    assert rawsha(archive.read('assets/' + name)) == prep['assets'][name], ('APK resource mismatch', name)
                for name, digest in builtin_assets.items():
                    assert rawsha(archive.read('assets/' + name)) == digest, ('APK built-in asset changed', name)
                assert len(validation['native_libraries']) == 2
                assert {library['elf_bits'] for library in validation['native_libraries']} == {32, 64}
                for library in validation['native_libraries']:
                    assert library['zip_alignment'] == 16384
                    assert rawsha(archive.read(library['path'])) == library['sha256']
            else:
                infos = [name for name in archive.namelist() if name.endswith('.app/Info.plist')]
                assert len(infos) == 1
                info = plistlib.loads(archive.read(infos[0]))
                app = infos[0].removesuffix('Info.plist')
                assert (info['CFBundleIdentifier'], info['CFBundleShortVersionString'], info['CFBundleVersion']) == (PACKAGE, VERSION, str(BUILD))
                assert info['UIFileSharingEnabled'] and info['LSSupportsOpeningDocumentsInPlace']
                packaged_vm = archive.read(app + 'games/' + vm)
                packaged_assets = {name.removeprefix(app + 'games/') for name in archive.namelist()
                                   if name.startswith(app + 'games/') and not name.endswith('/')}
                assert packaged_assets == set(prep['assets']), 'Stale or missing IPA game resource'
                for name, digest in prep['assets'].items():
                    assert rawsha(archive.read(app + 'games/' + name)) == digest, ('IPA resource mismatch', name)
                compatibility = read(OUT / 'ios-native-compatibility.json')
                assert rawsha(archive.read(app + info['CFBundleExecutable'])) == validation['runner_sha256'] == compatibility['native_sha256']
                assert compatibility['game_vm_sha256'] == prepared_digest
                assert compatibility['compatible_added_functions_and_extensions'] and not compatibility['missing_native_registrations']
                assert compatibility['extension_chunk_identical'] and compatibility['old_extension_count'] == compatibility['new_extension_count'] == 0
                assert compatibility['verified_additional_functions'] == compatibility['additional_vm_functions']
                assert validation['requires_resigning'] and validation['mac_native_rebuild'] is False
            assert rawsha(packaged_vm) == prepared_digest
            game = Game(packaged_vm)
            verify_code(game, functions, pairs, target)
            artwork = verify_artwork(game, target)
        # Resolve active icon references in the new actual archives and inspect pixels.
        icons = (verify_android_icon if target == 'android' else verify_ios_icon)(path)
        assert icons['source_sha256'] == ICON_SOURCE_SHA256
        assert icons['all_active_icon_pixels_match'] and icons['source_cropped'] is False
        assert icons['files']
        if target == 'android':
            assert icons['compiled_resource_paths_resolved']
            assert icons['adaptive_foreground_safe_circle_verified']
        else:
            assert icons['active_icon_basename'] == ICON_PREFIX and icons['catalog_icon_selected'] is False
            assert validation['icons'] == icons, 'Stale iOS launcher validation'
        artifacts.append(dict(path=path.relative_to(ROOT).as_posix(), bytes=path.stat().st_size,
            sha256=sha(path), validation_sha256=sha(validation_path),
            resource_zip_sha256=sha(resource_zip), raw_vm_sha256=prep['raw_vm_sha256'],
            prepared_receipt_sha256=sha(prep_path), prepared_vm_sha256=prepared_digest,
            packaged_vm_sha256=prepared_digest, compiled_artwork=artwork, launcher_icons=icons,
            production_call_edges_verified=len(pairs),
            android_baseline_version='1.1.3', android_baseline_apk_sha256=baseline_validation['apk_sha256'],
            android_baseline_validation_sha256=sha(baseline_validation_path)))
    new = read(ROOT / f'deliverables/NuclearThrone.Hardmode-Android-{VERSION}.validation.json')
    assert baseline_validation['package'] == new['package'] == PACKAGE
    assert baseline_validation['certificate_sha256'] == new['certificate_sha256'], 'Android update signing continuity broken'
    return artifacts
