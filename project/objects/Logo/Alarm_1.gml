/// @description Standalone single-player menu
var _buttons=[0,2,3,4],_step_size=24;
var _button_x=floor(view_xview_center),_button_y=floor(view_yview_center-_step_size*1.5);
for(var _i=0;_i<array_length(_buttons);++_i) {
    with(instance_create(_button_x,_button_y,MainMenuButton)) image_index=_buttons[_i];
    _button_y+=_step_size;
}
instance_create(0,0,ButtonAchievements);
instance_destroy();
