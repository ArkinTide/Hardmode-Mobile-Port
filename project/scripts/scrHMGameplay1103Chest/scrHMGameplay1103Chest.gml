// Real mobile-host native chest collisions, not an NTT CustomChest mock.
// Register as scrHMGameplayChest1103 and dispatch sync113chest at 30/60 fps,
// native area3, subarea1, loops0/1, goal ticks100, seed7103.
function scrHMGameplayChestCase1103(_kind,_curse,_shock,_tool,_seed) {
    var _area=GameCont.area,_sub=GameCont.subarea;
    GameCont.area=_tool?scrHMAreaResolve(3):1;
    GameCont.subarea=1;
    var _before=0;
    with(WepPickup) _before=max(_before,id);
    var _chest=instance_create(player.x+96,player.y,_kind);
    _chest.dropseed=_seed;_chest.curse=_curse;
    if(_kind==WeaponChest) {
        _chest.sprite_index=_curse?sprCursedChest:sprWeaponChest;
        _chest.spr_dead=_curse?sprCursedChestOpen:sprWeaponChestOpen;
    }
    var _spr=_chest.sprite_index,_mask=_chest.mask_index,_visible=_chest.visible;
    var _alpha=_chest.image_alpha,_sx=_chest.image_xscale,_sy=_chest.image_yscale;
    var _angle=_chest.image_angle,_depth=_chest.depth;
    var _bbox=[_chest.bbox_left,_chest.bbox_top,_chest.bbox_right,_chest.bbox_bottom];
    if(_tool) {
        repeat(4) with(_chest) scrHMToolChest1103();
        scrHMGameplayCheck(_chest.object_index==_kind && _chest.hm_tool_chest_native1103==_kind,
            "tool marking is idempotent and retains the real native object class");
        scrHMGameplayCheck(_chest.sprite_index==_spr && _chest.mask_index==_mask
            && _chest.visible==_visible && _chest.image_alpha==_alpha,
            "tool marking preserves visible native sprite and collision mask");
        scrHMGameplayCheck(_chest.image_xscale==_sx && _chest.image_yscale==_sy
            && _chest.image_angle==_angle && _chest.depth==_depth,
            "tool marking preserves all native draw transforms");
        scrHMGameplayCheck(_chest.bbox_left==_bbox[0] && _chest.bbox_top==_bbox[1]
            && _chest.bbox_right==_bbox[2] && _chest.bbox_bottom==_bbox[3],
            "native chest bounding box remains collidable");
    }
    GameCont.nochest=1;
    var _collider=player;
    if(_shock) _collider=instance_create(player.x+96,player.y,PortalShock);
    with(_collider) with(_chest) event_perform_object(object_index,ev_collision,other.object_index);
    scrHMGameplayCheck(!instance_exists(_chest),"real native chest collision opens and destroys the chest");
    scrHMGameplayCheck(GameCont.nochest==(_kind==BigWeaponChest?0:1),"native large chest accounting is retained");
    if(_shock && instance_exists(_collider)) instance_destroy(_collider,false);
    var _drops=[];
    with(WepPickup) if(id>_before) {
        array_push(_drops,[wep,curse,ammo,sprite_index,name,type,id]);
    }
    var _count=(_kind==BigWeaponChest?3:1)+(scr_ultra_get(Race.Steroids,UltraSkill.Ambidextrous)?1:0);
    scrHMGameplayCheck(array_length(_drops)==_count,"native regular and large chest drop counts remain unchanged");
    with(WepPickup) if(id>_before) instance_destroy(id,false);
    GameCont.area=_area;GameCont.subarea=_sub;
    return _drops;
}

function scrHMGameplayChest1103() {
    if(mode!="sync113chest") return;
    if(ticks==20) {
        scrHMGameplayCheck(GameCont.area==scrHMAreaResolve(3) && GameCont.subarea==1,
            "tool chest fixture enters actual native 3-1 through its production area identity");
        scrHMGameplayLane107();
        with(WeaponChest) instance_destroy(id,false);
        with(WepPickup) instance_destroy(id,false);
        GameCont.crown=Crown.None;
        var _old=scrWeaponPickupCreate(player.x-160,player.y,wep_revolver,true);
        var _old_wep=_old.wep,_old_sprite=_old.sprite_index;
        var _case=0;
        for(var _kind=0;_kind<2;++_kind) for(var _curse=0;_curse<2;++_curse) for(var _shock=0;_shock<2;++_shock) {
            var _object=_kind?BigWeaponChest:WeaponChest,_seed=7103+_case++;
            var _base=scrHMGameplayChestCase1103(_object,_curse,_shock,false,_seed);
            var _tool=scrHMGameplayChestCase1103(_object,_curse,_shock,true,_seed);
            scrHMGameplayCheck(array_length(_tool)==array_length(_base),"tool conversion never adds or removes a native drop");
            var _last=-1;
            for(var _i=0;_i<array_length(_tool);++_i)
                if(_last<0 || _tool[_i][6]>_tool[_last][6]) _last=_i;
            for(var _i=0;_i<array_length(_tool);++_i) {
                if(_i!=_last) scrHMGameplayCheck(_tool[_i][0]==_base[_i][0],"all earlier large chest drops retain the native rolled weapon");
                else scrHMGameplayCheck(GameCont.loops>0
                    ?array_contains([wep_screwdriver,wep_energy_screwdriver],_tool[_i][0])
                    :_tool[_i][0]==wep_screwdriver,"only the newest new drop follows the existing loop tool rule");
                scrHMGameplayCheck(_tool[_i][1]==_base[_i][1] && _tool[_i][2]==_base[_i][2],
                    "curse and native ammo flag survive tool replacement");
                scrHMGameplayCheck(_tool[_i][3]==scr_weapon_get_sprite(_tool[_i][0])
                    && _tool[_i][4]==scr_weapon_get_name(_tool[_i][0])
                    && _tool[_i][5]==scr_weapon_get_type(_tool[_i][0]),
                    "pickup sprite name and ammo type refresh synchronously");
            }
            scrHMGameplayCheck(instance_exists(_old) && _old.wep==_old_wep && _old.sprite_index==_old_sprite,
                "pre-existing world weapon is never selected or rewritten");
        }
        with(WepPickup) instance_destroy(id,false);
        chest_natural1103=instance_create(player.x+64,player.y,WeaponChest);
        with(chest_natural1103) scrHMToolChest1103();
        player.x=chest_natural1103.x;player.y=chest_natural1103.y;player.speed=0;
    }
    if(ticks==35) {
        scrHMGameplayCheck(!instance_exists(chest_natural1103),"physical native Player collision opens the marked regular chest");
        scrHMGameplayCheck(instance_number(WepPickup)==1,"physical regular collision emits exactly the native count");
        with(WepPickup) instance_destroy(id,false);
        chest_natural1103=instance_create(player.x+64,player.y,BigWeaponChest);
        with(chest_natural1103) scrHMToolChest1103();
        player.x=chest_natural1103.x;player.y=chest_natural1103.y;player.speed=0;
    }
    if(ticks==50) {
        scrHMGameplayCheck(!instance_exists(chest_natural1103),"physical native Player collision opens the marked large chest");
        scrHMGameplayCheck(instance_number(WepPickup)==3,"physical large collision retains all three native drops");
    }
}
