if(instance_exists(HMGameplayTest)) show_debug_message("HARDMODE ACTOR DESTROY "+json_stringify({name:name,hp:hp,tick:HMGameplayTest.ticks,x:x,y:y}));
scrHMActorCallback("on_destroy");event_inherited();scrHMActorCleanup();
