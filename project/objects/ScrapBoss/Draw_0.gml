if(scrHMEnabled() && (self[$ "hm_dog_native_intro1116"]??false) && hm_dog_open1116<11) {
    draw_sprite_ext(sprScrapBossIntro,hm_dog_open1116,x,y,right,1,0,c_white,1)
    exit
}
// NTT swimming owns the cropped body renderer.
if(scrHMEnabled() && (self[$ "swimming"]??false)) exit;
draw_sprite_ext(sprite_index, -1, x, y, right, 1, 0, c_white, 1)