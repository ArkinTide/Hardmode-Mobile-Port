if lockstep_stop
	exit

if(scrHMTopPotFloor107(other.id)) exit;

with Wall {
    if (place_meeting(x, y, other)) scrWallDestroy(id)
}

instance_destroy()