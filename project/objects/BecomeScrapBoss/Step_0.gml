// One-shot Hardmode portrait freeze.
if(scrHMEnabled() && (self[$ "hm_portrait_frozen"]??false)) exit;
if lockstep_stop
	exit

scrTarget()

if instance_exists(target) {
    if !collision_line(x, y, target.x, target.y, Wall, 0, 0) {
        timer+= timescale
    }

    if point_distance(x, y, target.x, target.y) < 160 && !instance_exists(Portal) && timer > 150 {
        instance_destroy()
    }
}

event_inherited()