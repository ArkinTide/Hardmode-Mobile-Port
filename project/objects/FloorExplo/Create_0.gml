scrHMCarveFill105(16);
hm_quiet_wall107=scrHMEnabled() && variable_global_exists("hm_quiet_wall107") && global.hm_quiet_wall107;
scrHMCarveFill105(16);
var _area;

if (!instance_exists(MenuGen) && !instance_exists(Menu)) {
	instance_create(x + orandom(4) + 8, y + random(4) + 8, Debris)
	scrWallBreakSound()
	_area = GameCont.area
}
else {
	_area = area_campfire
}

sprite_index = scrHMAssetIndex("sprFloor" + string(_area) + "Explo")

image_speed = 0
image_index = choose(1, 2, 3, 4)

var _list = global.lis_walls_visible

if (!position_meeting(x - 16, y, Floor) && !position_meeting(x - 16, y, Wall)) ds_list_add(_list, instance_create(x - 16, y, Wall))
if (!position_meeting(x + 16, y, Floor) && !position_meeting(x + 16, y, Wall)) ds_list_add(_list, instance_create(x + 16, y, Wall))
if (!position_meeting(x, y + 16, Floor) && !position_meeting(x, y + 16, Wall)) ds_list_add(_list, instance_create(x, y + 16, Wall))
if (!position_meeting(x, y - 16, Floor) && !position_meeting(x, y - 16, Wall)) ds_list_add(_list, instance_create(x, y - 16, Wall))

if (!position_meeting(x - 16, y + 16, Floor) && !position_meeting(x - 16, y + 16, Wall)) ds_list_add(_list, instance_create(x - 16, y + 16, Wall))
if (!position_meeting(x + 16, y - 16, Floor) && !position_meeting(x + 16, y - 16, Wall)) ds_list_add(_list, instance_create(x + 16, y - 16, Wall))
if (!position_meeting(x + 16, y + 16, Floor) && !position_meeting(x + 16, y + 16, Wall)) ds_list_add(_list, instance_create(x + 16, y + 16, Wall))
if (!position_meeting(x - 16, y - 16, Floor) && !position_meeting(x - 16, y - 16, Wall)) ds_list_add(_list, instance_create(x - 16, y - 16, Wall))

scr_screenshake(2)

traction = 1;
styleb = 0

material = 2

instance_create(x - 32, y, Top)
instance_create(x, y - 32, Top)
instance_create(x + 32, y, Top)
instance_create(x, y + 32, Top)

instance_create(x - 32, y + 32, Top)
instance_create(x + 32, y - 32, Top)

instance_create(x - 32, y - 32, Top)
instance_create(x + 32, y + 32, Top)

scrHMWallBreakUpdate104();

// Intact sewer bank cells, including split exterior blocks.
if(scrHMEnabled() && variable_global_exists("hm_sewer_bank106") && global.hm_sewer_bank106) {sprite_index=sprFloor2;image_index=0;}
