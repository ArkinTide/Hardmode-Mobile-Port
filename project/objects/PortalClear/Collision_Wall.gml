if lockstep_stop
	exit

if(scrHMEnabled()) scrHMPortalClearWall107(other.id);
else if(scrHMEnabled()) scrHMPortalClearWall107(other.id);
else scrWallDestroy(other.id)