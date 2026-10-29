"""Names shared by the static compiler and the native compatibility layer."""
from pathlib import PurePosixPath


def module_key(source):
    path = PurePosixPath(source)
    if source.startswith("areas/"):
        return "area:" + path.name.removesuffix(".area.gml")
    if source.startswith("weapons/"):
        return "weapon:" + path.name.removesuffix(".wep.gml")
    return "mod:" + source.removesuffix(".mod.gml")


API = {
    "maxp": "INPUT_MAX_PLAYERS",
    "d3d_set_fog": "gpu_set_fog",
    "draw_set_blend_mode": "gpu_set_blendmode",
    "mod_script_call": "scrHMModCall",
    "mod_variable_get": "scrHMModGet",
    "mod_variable_set": "scrHMModSet",
    "mod_variable_exists": "scrHMModExists",
    "script_ref_create": "scrHMScriptRef",
    "script_bind_draw": "scrHMBindDraw",
    "script_bind_end_step": "scrHMBindEndStep",
    "instances_matching": "scrHMMatching",
    "instances_matching_ne": "scrHMMatchingNE",
    "instances_matching_ge": "scrHMMatchingGE",
    "instances_matching_gt": "scrHMMatchingGT",
    "instances_matching_le": "scrHMMatchingLE",
    "instances_matching_lt": "scrHMMatchingLT",
    "instance_delete": "scrHMDelete",
    "sound_add": "scrHMSoundAdd",
    "sound_assign": "scrHMSoundAssign",
    "sound_restore": "scrHMSoundRestore",
    "sound_play": "scrHMSoundPlay",
    "sound_play_pitch": "scrHMSoundPitch",
    "sound_play_pitchvol": "scrHMSoundPitchVolume",
    "sound_play_music": "scrHMSoundMusic",
    "sound_play_ambient": "scrHMSoundAmbient",
    "sound_loop": "scrHMSoundLoop",
    "sound_stop": "scrHMSoundStop",
    "sound_stop_all": "scrHMSoundStopAll",
    "sprite_restore": "scrHMSpriteRestore",
    "weapon_get_name": "scrHMWeaponName",
    "weapon_get_sprt": "scrHMWeaponSprite",
    "weapon_get_type": "scrHMWeaponType",
    "weapon_get_list": "scrHMWeaponList",
    "weapon_set_name": "scrHMWeaponSetName",
    "weapon_set_area": "scrHMWeaponSetArea",
    "weapon_post": "scrHMWeaponPost",
    "player_find": "scrHMPlayerFind",
    "player_fire": "scrHMPlayerFire",
    "button_check": "scrHMButtonCheck",
    "button_pressed": "scrHMButtonPressed",
    "skill_get": "scrHMGetSkill",
    "skill_set": "scrHMSetSkill",
    "file_load": "scrHMFileLoad",
    "file_unload": "scrHMFileUnload",
    "file_exists": "scrHMFileExists",
    "string_load": "scrHMStringLoad",
    "string_save": "scrHMStringSave",
    "trace": "scrHMTrace",
    "draw_text_nt": "scrHMDrawText",
    "draw_text": "scrHMDrawTextPlain",
    "draw_text_transformed": "scrHMDrawTextTransformed",
    "draw_text_shadow": "scrHMDrawTextShadow",
    "point_seen": "scrHMPointSeen",
    "motion_add": "scrHMMotionAdd",
    "motion_set": "scrHMMotionSet",
    "move_towards_point": "scrHMMoveTowardsPoint",
    "draw_sprite_ext": "scrHMDrawSpriteExt",
    "draw_sprite": "scrHMDrawSprite",
}


FIELD_ALIASES = {
    "opt_bossintros": "opt_bossintro",
    "fntM": "fntM1", "fntBigName": "fntBig", "fntChat": "fntConsole",
    "my_health": "hp", "maxhealth": "max_hp", "race_id": "race",
    "kills": "givekill", "new": "hm_field_new",
    "game_width": "view_width", "game_height": "view_height",
    "shadcol": "shadow_color",
    "sndHeavyRevoler": "sndHeavyRevolver",
    "canwalk":"can_walk", "canpick":"can_pick", "canspec":"can_spec",
    "canaim":"can_aim", "candie":"can_die", "canswap":"can_swap",
    "force":"knockback_speed",
    "CrystalProp":"Crystal", "EatRad":"RadEat", "EnemyHorror":"HostileHorror",
    "BigCursedChest":"CursedBigChest", "Crown":"CrownObject", "Generator":"BigGenerator",
    "HeavyNade":"HeavyGrenade", "EFlakBullet":"EnemyFlak", "RoguePickup":"RogueAmmo",
    "FireBall":"Fireball", "FrogQueenDie":"FrogQueenDeath", "AssassinNotice":"HitWarning",
    "MineExplosion":"WaterMineExplode", "RogueStrike":"PortalStrike",
    "mutbutton":"SkillIcon",
    "ReviveArea":"ReviveCircle",
    "text":"mytext",
}

# Legacy code uses pixels per 30 Hz tick. The host engine stores velocity per
# physical frame and acceleration per physical frame squared.
SCALED_FIELDS = {"speed": 1, "hspeed": 1, "vspeed": 1, "image_speed": 1,
                 "force": 1, "knockback_speed": 1,
                 "friction": 2, "gravity": 2}
