/// @function scrWallDestroy
/// @param wall_instance
function scrWallDestroy(_instance) {
	if (!instance_exists(_instance)) exit
    if(instance_exists(HMGameplayTest) && string_pos("cave116",HMGameplayTest.mode)==1 && HMGameplayTest.ticks>=150)
        show_debug_message("HARDMODE CAVE116 WALL DESTROY "+json_stringify({tick:HMGameplayTest.ticks,
            who:_instance,x:_instance.x,y:_instance.y,caller:id,object:object_get_name(object_index),
            name:self[$ "name"]??"",stack:debug_get_callstack(12)}));
    if(scrHMDestroyFill106(_instance)) exit
	
	with (_instance) {
		do {
			instance_destroy(_instance)
			instance_create(x, y, FloorExplo)
			
			_instance = collision_rectangle(
				bbox_left, bbox_top, bbox_right, bbox_bottom, Wall, false, true)
		}
		until (!instance_exists(_instance))
	}
}