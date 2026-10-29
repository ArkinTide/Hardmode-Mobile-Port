if lockstep_stop
	exit

if instance_exists(GenCont) exit

if UberCont.opt_bloom {
	scrDrawBloom()
}

with (WepSwap) draw_self()

var _list = global.lis_walls_visible,
	_count = ds_list_size(_list)
	
for (var i = _count - 1; i >= 0; --i) {
    with _list[| i] {
        if(scrHMEnabled() && scrHMPlainWall106()) continue;
		draw_sprite_part_ext(outspr, outindex, l, r, w, h,
			x - 4 + l, y - 12 + r, image_xscale, image_yscale, image_blend, image_alpha)
	}
}
	
// Plain fill precedes the original wall transition layer (1.0.7).
for(var _wall=0;_wall<ds_list_size(_list);++_wall) with(_list[| _wall]) {
    if(scrHMEnabled() && scrHMPlainWall106()) scrHMPlainWallDraw107();
}
with TopSmall {
    if(x<view_xview-32 || x>view_xview+view_width+32 || y<view_yview-32 || y>view_yview+view_height+32) continue;
    draw_sprite_ext(sprite_index, -1, x, y - 8, 1, 1, 0, image_blend, 1)
}
	
for(var _wall=0;_wall<ds_list_size(_list);++_wall) with(_list[| _wall]) {
    if(scrHMEnabled() && scrHMPlainWall106()) continue;
	draw_sprite_ext(topspr, image_index, x, y - 8, 1, 1, 0, image_blend, 1)
}
	
with TopPot {
    draw_sprite(sprite_index, image_index, x, y - 8)
}

if (bonecount) {
	var _index = bonecount
	repeat (bonecount) with (bones[--_index]) {
	    draw_sprite_ext(sprite_index, image_index,
			x, y, image_xscale, image_yscale, 0, image_blend, image_alpha)
	}
}

with RavenFly {
    draw_sprite_ext(sprite_index, -1, x, y + z, right, 1, 0, c_white, 1)
}

with LilHunterFly {
    draw_sprite_ext(sprite_index, -1, x, y + z, right, 1, 0, c_white, 1)
}

with StreetLight
draw_sprite_ext(sprite_index, -1, x, y, image_xscale, 1, 0, c_white, 1)

with BigTV {
    event_perform(ev_draw, 0) //draw_sprite_ext(sprite_index, -1, x, y, image_xscale, 1, 0, c_white, 1)
}

with Bubble
draw_sprite(sprite_index, -1, x, y)

with Player if (visible && !scrHMPlayerNativeHidden107()) {
    if scr_skill_get(mut_strong_spirit) && !instance_exists(StrongSpiritRefill) && (spirit || spirit_index < 8) {
        var _y = y - 2 + sin(spirit_anim)
        draw_sprite(sprStrongSpirit, spirit_index, x, _y)

        gpu_set_blendmode(bm_add)
        draw_sprite(sprStrongSpirit, spirit_index, x, _y)
        gpu_set_blendmode(bm_normal)
    }

    if (hammerhead && hammering) {
        draw_sprite(sprHammerHeadNear, -1, x, y)
    }
}

with Nothing2Appear
draw_self()
