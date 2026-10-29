"""Apply the reviewed standalone menu/localization changes, preserving upstream."""
from pathlib import Path
import json,re
from create_project import load,save
from register_native import ROOT,PROJECT,write,register_script,replace
from release_config import VERSION,BUILD


def remove_section(relative,start,end):
    path=PROJECT/relative
    text=path.read_text(encoding='utf8')
    if start not in text:return
    a=text.index(start);b=text.index(end,a)+len(end)
    write(relative,text[:a]+text[b:])


def main():
    project=load(PROJECT/'nuclearthronemobile.yyp')
    catalog=json.loads((ROOT/'localization/zh-CN.json').read_text(encoding='utf8'))
    normalized={key.upper():value for key,value in catalog.items()}
    assert len(normalized)==len(catalog),'Case-insensitive localization collision'
    registry='function scrHMLocalizationCatalog() {\n    static _catalog='+json.dumps(normalized,ensure_ascii=False,indent=4)+';\n    return _catalog;\n}\n'
    register_script(project,'scrHMLocalization',registry+(ROOT/'native/localization.gml').read_text(encoding='utf8'))
    register_script(project,'scrHMMobile',(ROOT/'native/mobile.gml').read_text(encoding='utf8'))

    # Compact the remaining buttons without changing their original identities.
    write('objects/Logo/Alarm_1.gml','''/// @description Standalone single-player menu
var _buttons=[0,2,3,4],_step_size=24;
var _button_x=floor(view_xview_center),_button_y=floor(view_yview_center-_step_size*1.5);
for(var _i=0;_i<array_length(_buttons);++_i) {
    with(instance_create(_button_x,_button_y,MainMenuButton)) image_index=_buttons[_i];
    _button_y+=_step_size;
}
instance_create(0,0,ButtonAchievements);
instance_destroy();
''')
    replace('objects/MainMenuButton/Other_10.gml','\t        array_push(_play_buttons, 1, 2)',
            '\t        // No daily/weekly services in the standalone port.')
    remove_section('objects/MainMenuButton/Other_10.gml','\t// Co-op\n','\t// Options\n')
    # Preserve the next section's comment, removed with its boundary above.
    source=PROJECT/'objects/PlayButton/Other_10.gml'
    text=source.read_text(encoding='utf8')
    start=text.find('// if chose either Daily or Weekly')
    if start>=0:
        stop=text.index('else if _image == 3',start)
        write(source.relative_to(PROJECT),text[:start]+'// Original hard difficulty remains available.\nif _image == 3'+text[stop+len('else if _image == 3'):])
    for obj in ('CoopMenu','CoopController','ResourcepackManager','ButtonDiscord'):
        path=f'objects/{obj}/Create_0.gml'
        text=(PROJECT/path).read_text(encoding='utf8')
        marker='// Unavailable in the standalone single-player Hardmode port.'
        if marker not in text:write(path,marker+'\ninstance_destroy();\nexit;\n'+text)
    options='objects/MenuOptions/Other_20.gml'
    remove_section(options,'\t{\n\t\t/// @loc:token [ResourcepackOptions] ResourcepackOptions', '\n\t},\n')
    remove_section(options,'#region Resourcepacks','#endregion Resourcepacks')
    remove_section(options,'#region Coop_Menu','#endregion')
    text=(PROJECT/options).read_text(encoding='utf8')
    text=re.sub(r'^\s*\{ type: "category", name: L\("CoopOptions"[^\n]+\n','\n',text,flags=re.M)
    text=text.replace('name: "HARDMODE", category: OptionCategory.Hardmode',
                      'name: scrHMLocalize("HARDMODE"), category: OptionCategory.Hardmode')
    write(options,text)
    replace('objects/MenuOptions/Other_11.gml','_name = "HARDMODE";',
            '_name = scrHMLocalize("HARDMODE");')
    replace('scripts/load_resourcepacks/load_resourcepacks.gml','\tglobal.custom_sprite_registry = {}',
            '\tglobal.custom_sprite_registry = {}\n\t// Keep empty base registries; never scan or apply external packs.\n\treturn;')
    path='scripts/loc/loc.gml'
    text=(PROJECT/path).read_text(encoding='utf8')
    text=text.replace('global.language_current[$ string(_key)] ?? _default','scrHMLocFallback(string(_key), _default)')
    text=text.replace('global.language_current[$ string(_key)] ?? string(argument[argument_count - 1])',
                      'scrHMLocFallback(string(_key), string(argument[argument_count - 1]))')
    write(path,text)
    replace('scripts/scrDeathCauses/scrDeathCauses.gml','return array_last(_cause)',
            'return scrHMLocalize(array_last(_cause))')
    replace('objects/GenCont/Draw_0.gml','"@s" + string(tip)',
            '"@s" + scrHMLocalize(string(tip))')
    replace('objects/TopCont/Draw_0.gml','draw_text_nt(_x, _y, mytext)',
            'draw_text_nt(_x, _y, scrHMLocalize(mytext))')
    replace('scripts/scr_weapon_get_type/scr_weapon_get_type.gml',
            'return scr_weapon_is_valid(_weapon) ? wep_text[_weapon] : ""',
            'return scr_weapon_is_valid(_weapon) ? scrHMLocalize(wep_text[_weapon]) : ""')
    # Keep raw names in state; localize custom getters only at presentation.
    replace('scripts/scr_weapon_get_type/scr_weapon_get_type.gml',
            'return scrHMWeaponProperty(_key,"weapon_name","");',
            'return scrHMLocalize(scrHMWeaponProperty(_key,"weapon_name",""));')
    for platform in ('android','ios','windows'):
        path=PROJECT/f'options/{platform}/options_{platform}.yy'
        data=load(path);data[f'option_{platform}_version']=VERSION+('.0' if platform=='windows' else '')
        if platform=='ios':data['option_ios_build_number']=BUILD
        save(path,data)
    path='objects/UberCont/Create_0.gml';text=(PROJECT/path).read_text(encoding='utf8')
    text=re.sub(r'#macro GAME_VERSION "[^"]+"',f'#macro GAME_VERSION "Hardmode {VERSION}"',text)
    write(path,text)
    manifest=ROOT/'platforms/android/gradle-project/com.arkintide.nuclearthronehardmode/src/main/AndroidManifest.xml'
    text=manifest.read_text(encoding='utf8')
    text=re.sub(r'android:versionCode="\d+"',f'android:versionCode="{BUILD}"',text)
    text=re.sub(r'android:versionName="[^"]+"',f'android:versionName="{VERSION}"',text)
    manifest.write_text(text,encoding='utf8')
    write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
    print('Standalone menus, font-safe Simplified Chinese and version',VERSION,'registered;',len(catalog),'translations')


if __name__=='__main__':main()
