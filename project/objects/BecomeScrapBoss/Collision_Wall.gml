if lockstep_stop
	exit

move_bounce_solid(true)

if(scrHMEnabled()) scrHMPortalClearWall107(other.id);
else scrWallDestroy(other.id)