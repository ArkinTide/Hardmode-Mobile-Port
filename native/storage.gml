// A separate directory even if a runner happens to reuse its predecessor's root.
function scrHMStorageInit() {
    // Explicit desktop regressions use workspace-owned disposable state,
    // never a player's real original/NTTE/Hardmode save directory.
    if(os_type==os_windows) {
        var _prefix="--hardmode-test-root=";
        for(var _i=1;_i<=parameter_count();++_i) {
            var _arg=parameter_string(_i);
            if(string_pos(_prefix,_arg)==1) {
                game_directory=string_delete(_arg,1,string_length(_prefix));
                if(string_char_at(game_directory,string_length(game_directory))!="/") game_directory+="/";
                if(!directory_exists(game_directory)) directory_create(game_directory);
                return;
            }
        }
    }
    var _root=string_replace_all(game_save_id,"//","/");
    if(string_char_at(_root,string_length(_root))!="/") _root+="/";
    var _old=_root+"hardmode/",_desired=_old;
    if(os_type==os_android && CheckPermission()>0) {
        _desired="/sdcard/games/com.arkintide.nuclearthronehardmode/";
        if(!directory_exists("/sdcard/games/")) directory_create("/sdcard/games/");
    }
    if(os_type==os_ios) {
        // The retained runner normally returns Documents. Normalize a
        // Library save root too, so sharing exposes the actual active files.
        var _library=string_pos("/Library/",_root);
        if(_library>0) _desired=string_copy(_root,1,_library)+"Documents/hardmode/";
    }
    if(!directory_exists(_desired)) directory_create(_desired);
    if(!scrHMStorageWritable(_desired)) {
        _desired=_old;
        if(!directory_exists(_desired)) directory_create(_desired);
    }
    if(_desired!=_old) {
        scrHMStorageMigrate(_old,_desired);
        if(scrHMStorageValid(_old+"NuclearThrone.sav",true) && !scrHMStorageValid(_desired+"NuclearThrone.sav",true)) _desired=_old;
    }
    game_directory=_desired;
    global.hm_storage_path=game_directory;
}

function scrHMStorageWritable(_root) {
    if(!directory_exists(_root)) return false;
    var _probe=_root+".hardmode-write-check",_file=-1;
    try {
        _file=file_text_open_write(_probe);
        if(_file<0) return false;
        file_text_write_string(_file,"Hardmode");file_text_close(_file);_file=-1;
        var _ok=file_exists(_probe);if(_ok) file_delete(_probe);
        return _ok;
    } catch(_e) {if(_file>=0) file_text_close(_file);return false;}
}

function scrHMStorageValid(_path,_json) {
    if(!file_exists(_path)) return false;
    if(!_json) {
        var _buffer=buffer_load(_path);
        if(!buffer_exists(_buffer)) return false;
        var _ok=buffer_get_size(_buffer)>0;buffer_delete(_buffer);return _ok;
    }
    var _file=-1;
    try {
        _file=file_text_open_read(_path);
        if(_file<0) return false;
        var _text=file_text_read_string(_file);file_text_close(_file);_file=-1;
        return is_struct(json_parse(_text));
    } catch(_e) {if(_file>=0) file_text_close(_file);return false;}
}

function scrHMStorageMigrate(_old,_dest) {
    // Preserve originals. An existing valid destination wins, including a
    // manually imported save. Invalid files get a backup before migration.
    var _files=["NuclearThrone.sav","savegame.dat","configs.ini","custom-mode.json","debug-overlay.json"];
    for(var _i=0;_i<array_length(_files);++_i) {
        var _name=_files[_i],_src=_old+_name,_dst=_dest+_name,_json=(_i==0);
        if(!scrHMStorageValid(_src,_json) || scrHMStorageValid(_dst,_json)) continue;
        if(file_exists(_dst)) {
            var _backup=_dst+".before-migration";
            if(file_exists(_backup)) continue;
            file_rename(_dst,_backup);
            if(file_exists(_dst)) continue;
        }
        file_copy(_src,_dst);
    }
}
