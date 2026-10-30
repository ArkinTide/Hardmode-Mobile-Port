if(lockstep_stop || !scrHMEnabled() || GameCont.area!=scrHMAreaResolve("venuz")) exit;
move_bounce_solid(true);
move_outside_solid(point_direction(other.x+8,other.y+8,x,y),2);
speed*=.4;
scrHMVenusPickup108();
