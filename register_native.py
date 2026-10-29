"""Register independent Hardmode modules; never mutate the reference or NTTE."""
from pathlib import Path
import hashlib
import json
import shutil

from create_project import load, save

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / "project"


def write(relative, text):
    path = PROJECT / relative
    before = ROOT / "integration-before" / relative
    if path.exists() and not before.exists():
        before.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(path, before)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf8")


def replace(relative, old, new):
    path = PROJECT / relative
    text = path.read_text(encoding="utf8")
    if new in text:
        return
    assert text.count(old) == 1, (relative, old)
    write(relative, text.replace(old, new))


def register_script(project, name, source):
    path = f"scripts/{name}/{name}.yy"
    template = load(PROJECT / "scripts/scrRadDrop/scrRadDrop.yy")
    template["name"] = template["%Name"] = name
    write(path, json.dumps(template, indent=2) + "\n")
    write(f"scripts/{name}/{name}.gml", source)
    if not any(entry["id"]["path"] == path for entry in project["resources"]):
        project["resources"].append({"id": {"name": name, "path": path}})


def main():
    path = PROJECT / "nuclearthronemobile.yyp"
    project = load(path)
    register_script(project, "scrHMRadiation", (ROOT / "native/radiation.gml").read_text(encoding="utf8"))
    register_script(project, "scrHMStorage", (ROOT / "native/storage.gml").read_text(encoding="utf8"))
    register_script(project, "scrHMRadiationTests", (ROOT / "tests/radiation.gml").read_text(encoding="utf8"))
    write(path.relative_to(PROJECT), json.dumps(project, ensure_ascii=False, indent=2) + "\n")

    replace("objects/GameCont/Step_0.gml",
            "if (wantdestinyskill && room == romGame)",
            "// Hardmode: synchronize existing and newly spawned enemies after level changes.\n"
            "scrHMRadiationSyncWorld();\n\nif (wantdestinyskill && room == romGame)")
    replace("objects/enemy/Destroy_0.gml",
            "scrRadDrop(x, y, raddrop + scrPlayerCountRace(Race.Melting))",
            "// Also cover enemies killed during their creation frame or before GameCont's step.\n"
            "scrHMRadiationSync(scrHMRadiationBelowMaximum());\n"
            "scrRadDrop(x, y, raddrop + scrPlayerCountRace(Race.Melting))")

    replace("objects/MakeGame/Create_0.gml", 'game_directory = ""', "scrHMStorageInit();")
    replace("objects/MakeGame/Alarm_0.gml", "//\nvar info = os_get_info(), udid;",
            "// Explicit Windows-only regression; no normal startup activation.\n"
            "if (scrHMRunRadiationTests()) exit;\n\n//\nvar info = os_get_info(), udid;")
    create = PROJECT / "objects/MakeGame/Create_0.gml"
    text = create.read_text(encoding="utf8")
    start = text.find("if (os_type == os_android && android_check_storage_permission()")
    if start >= 0:
        stop = text.index("\nscr_debug_overlay_load()", start)
        write(create.relative_to(PROJECT), text[:start] + "// No legacy import from the stock mobile application's save directory.\n" + text[stop:])
    replace("objects/MakeGame/Create_0.gml", 'game_directory = "/files/"', "// Keep the independent Hardmode directory initialized above.")
    alarm = PROJECT / "objects/MakeGame/Alarm_0.gml"
    text = alarm.read_text(encoding="utf8")
    start = text.find("if os_type == os_android && check {")
    if start >= 0:
        stop = text.index("\nmy_player = undefined", start)
        write(alarm.relative_to(PROJECT), text[:start] + "// Hardmode uses its own application-private save directory.\nscrHMStorageInit();\n" + text[stop:])
    _save_path=PROJECT/'scripts/scrSavegame/scrSavegame.gml'
    if '#macro savegame_file (game_directory + "savegame.dat")' not in _save_path.read_text(encoding='utf8'):
        replace("scripts/scrSavegame/scrSavegame.gml", '#macro savegame_file "savegame.dat"', '#macro savegame_file "hardmode/savegame.dat"')

    # The original project's update feed and challenges describe unmodified
    # Epsilon. Do not contact them for this independent gameplay conversion.
    api = PROJECT / "scripts/tb_api/tb_api.gml"
    text = api.read_text(encoding="utf8")
    start = text.index("function tb_api(type)")
    stop = text.index("\nfunction scrValidateWeeklyLoadout", start)
    disabled = '''function tb_api(type) {
    return -1; // No stock challenge service in the standalone Hardmode port.
}

function scrGameQueryUpdateVersion() {
    with (UberCont) {
        update_request = -1;
        update_request_since_last = current_time;
        leaderboards_allowed = false;
        can_daily = false;
        can_weekly = false;
    }
    return -1;
}
'''
    write(api.relative_to(PROJECT), text[:start] + disabled + text[stop:])
    replace("objects/UberCont/Create_0.gml", '#macro GAME_VERSION "3-111E"', '#macro GAME_VERSION "Hardmode 1.0.0-dev"')
    options = PROJECT / "options/windows/options_windows.yy"
    data = load(options)
    data["option_windows_executable_name"] = "NuclearThroneHardmode"
    data.pop("option_windows_exe_name", None)
    write(options.relative_to(PROJECT), json.dumps(data, indent=2) + "\n")
    # GameMaker's legacy option is a numeric Apple store ID, not CFBundleIdentifier.
    # The independent reverse-domain identifier is applied to the final Xcode/
    # runner Info.plist during iOS packaging, and audited in the IPA receipt.
    options = PROJECT / "options/ios/options_ios.yy"
    data = load(options)
    data["option_ios_bundle_name"] = "123456"
    data.pop("option_ios_bundle_identifier", None)
    write(options.relative_to(PROJECT), json.dumps(data, indent=2) + "\n")
    print("Registered Hardmode radiation policy; the full mod port is still in development")


if __name__ == "__main__":
    main()
