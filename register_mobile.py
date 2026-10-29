"""Native settings and versioned scalar-only module save state."""
import json
from create_project import load
from register_native import ROOT, PROJECT, register_script, replace, write
from register_world import append

def main():
    project=load(PROJECT/'nuclearthronemobile.yyp')
    register_script(project,'scrHMMobile',(ROOT/'native/mobile.gml').read_text(encoding='utf8'))
    replace('objects/MenuOptions/Create_0.gml','\tNUM_MENU_OPTIONS','\tHardmode,\n\tNUM_MENU_OPTIONS')
    replace('objects/MenuOptions/Other_20.gml',
            '{ type: "category", name: loc("CustomMode.Setup:PickMutations", "STARTING MUTATIONS"), category: OptionCategory.CustomMode_SkillSelector, visible: false },',
            '{ type: "category", name: loc("CustomMode.Setup:PickMutations", "STARTING MUTATIONS"), category: OptionCategory.CustomMode_SkillSelector, visible: false },\n\t{ type: "category", name: "HARDMODE", category: OptionCategory.Hardmode },')
    append('objects/MenuOptions/Other_20.gml','// Hardmode touch settings','scrHMMobileOptions();')
    replace('objects/MenuOptions/Other_20.gml',
            'key: "options_volumecontrol", mobile_only: true',
            'key: "options_volumecontrol", mobile_only: true, visible: (os_type==os_android)')
    replace('scripts/scrDrawMobileControls/scrDrawMobileControls.gml',
            'if UberCont.opt_volumecontrol {','if os_type==os_android && UberCont.opt_volumecontrol {')
    replace('objects/MenuOptions/Other_11.gml','draw_text_bigname(gui_w div 2, 24, _name, c_uigray)',
            'if (_current_category == OptionCategory.Hardmode) _name = "HARDMODE";\ndraw_text_bigname(gui_w div 2, 24, _name, c_uigray)')
    replace('scripts/scrSaveGame/scrSaveGame.gml','\t\tstruct_foreach(_globals, function(_vname, _value) {',
            '\t\tif(scrHMEnabled()) scrHMStateRestore(_globals[$ "hm_state"]);\n'
            '\t\tvariable_struct_remove(_globals,"hm_state");\n'
            '\t\tstruct_foreach(_globals, function(_vname, _value) {')
    replace('scripts/scrSaveGame/scrSaveGame.gml','\t\tbuffer_write(_buffer, buffer_u8, _part_index)\n\t    buffer_write(_buffer, buffer_string, json_stringify(_globals))',
            '\t\tif(scrHMEnabled()) _globals.hm_state=scrHMStateCapture();\n'
            '\t\tbuffer_write(_buffer, buffer_u8, _part_index)\n\t    buffer_write(_buffer, buffer_string, json_stringify(_globals))')
    replace('scripts/scrSaveGame/scrSaveGame.gml','with (instance_find(Player, i)) {','with (instance_find(_object, i)) {')
    # Stock code used a relative savegame path even though other profile files
    # use game_directory. Match it to the isolated app/test root.
    replace('scripts/scrSaveGame/scrSaveGame.gml','#macro savegame_file "hardmode/savegame.dat"',
            '#macro savegame_file (game_directory + "savegame.dat")')
    for relative in ['scripts/load_resourcepacks/load_resourcepacks.gml',
                     'scripts/resourcepack_temp_cleanup/resourcepack_temp_cleanup.gml']:
        path=PROJECT/relative
        source=path.read_text(encoding='utf8')
        if 'game_save_id +' in source:write(relative,source.replace('game_save_id +','game_directory +'))
    replace('scripts/load_custom_sprites/load_custom_sprites.gml','"replacedsprites/" + sprite_get_name',
            'game_directory + "replacedsprites/" + sprite_get_name')
    replace('scripts/discard_custom_sprites/discard_custom_sprites.gml','$"replacedsprites/{_sprite_name}.png"',
            'game_directory + $"replacedsprites/{_sprite_name}.png"')
    write('nuclearthronemobile.yyp',json.dumps(project,ensure_ascii=False,indent=2)+'\n')
    print('Registered mobile settings and scalar-only save/continue module state')

if __name__=='__main__': main()
