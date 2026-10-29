if lockstep_stop
	exit

if team != other.team && other.hp > 0 {
    var _hm_jump=scrHMEnabled()&&(self[$ "jumper"]??false);
    if(_hm_jump) {
        if(self[$ "hm_jump_landed"]??false) exit;
        hm_jump_landed=true;
    }
    with instance_create(x, y, Maggot) {
        motion_add(point_direction(other.x, other.y, x, y), (4) * timescale)
        givekill = 0
    }
    if(_hm_jump) instance_destroy(id,false);
}