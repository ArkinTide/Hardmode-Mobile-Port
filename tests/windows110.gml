// Synthetic wheel samples enter the same merge function as live Windows
// mouse input. The actual Player Step event performs and consumes the swap.
function scrHMGameplayWindows110() {
    if(ticks!=60) return;
    show_debug_message("HARDMODE WHEEL CONTEXT "+json_stringify({paused:UberCont.paused,want_pause:UberCont.want_pause,blocked:UberCont.block_input_frames,typing:scr_keyboard_is_typing(),overlay:is_mouse_over_debug_overlay(),locked:scrGameIsLockState(),settings:instance_exists(MenuOptions),pause_button:instance_exists(PauseButton)}));
    var _p=player;
    var _keyboard=UberCont.opt_keyboard,_gamepad=UberCont.opt_gamepad;
    UberCont.opt_keyboard=true;UberCont.opt_gamepad=false;
    _p.wep=wep_revolver;_p.bwep=wep_shotgun;_p.can_swap=true;
    KeyCont.press_swap[0]=false;KeyCont.hold_swap[0]=false;
    scrDesktopWheelSwap(0,false,false);
    scrHMGameplayCheck(!KeyCont.press_swap[0],"no notch does not swap");
    scrDesktopWheelSwap(0,true,false);
    scrHMGameplayCheck(KeyCont.press_swap[0],"wheel up produces normal swap action");
    with(_p) event_perform(ev_step,ev_step_normal);
    scrHMGameplayCheck(_p.wep==wep_shotgun&&_p.bwep==wep_revolver,"wheel up swaps actual equipped weapons");
    scrHMGameplayCheck(!KeyCont.press_swap[0],"Player consumes wheel swap");
    with(_p) event_perform(ev_step,ev_step_normal);
    scrHMGameplayCheck(_p.wep==wep_shotgun,"extra render step cannot repeat a consumed swap");
    scrDesktopWheelSwap(0,false,true);
    with(_p) event_perform(ev_step,ev_step_normal);
    scrHMGameplayCheck(_p.wep==wep_revolver,"wheel down swaps actual equipped weapons");
    repeat(8) {
        scrDesktopWheelSwap(0,true,false);
        with(_p) event_perform(ev_step,ev_step_normal);
    }
    scrHMGameplayCheck(_p.wep==wep_revolver,"successive notches each swap once");
    KeyCont.press_swap[0]=true;
    scrDesktopWheelSwap(0,true,true);
    with(_p) event_perform(ev_step,ev_step_normal);
    scrHMGameplayCheck(_p.wep==wep_shotgun,"key and both wheel directions in one frame merge into one swap");
    scrHMGameplayCheck(!KeyCont.press_swap[0],"combined action consumed once");
    _p.can_swap=false;
    scrDesktopWheelSwap(0,false,true);
    with(_p) event_perform(ev_step,ev_step_normal);
    scrHMGameplayCheck(_p.wep==wep_shotgun,"player unable to swap retains weapon");
    _p.can_swap=true;KeyCont.press_swap[0]=false;
    _p.bwep=0;
    scrDesktopWheelSwap(0,false,true);
    with(_p) event_perform(ev_step,ev_step_normal);
    scrHMGameplayCheck(_p.wep==wep_shotgun,"single weapon cannot be replaced with empty slot");
    KeyCont.press_swap[0]=false;_p.bwep=wep_revolver;
    UberCont.paused=true;
    scrDesktopWheelSwap(0,true,false);
    scrHMGameplayCheck(!KeyCont.press_swap[0],"paused wheel is discarded");
    UberCont.paused=false;UberCont.want_pause=1;
    scrDesktopWheelSwap(0,true,false);
    scrHMGameplayCheck(!KeyCont.press_swap[0],"pending pause wheel is discarded");
    UberCont.want_pause=0;UberCont.block_input_frames=1;
    scrDesktopWheelSwap(0,true,false);
    scrHMGameplayCheck(!KeyCont.press_swap[0],"blocked input wheel is discarded");
    UberCont.block_input_frames=0;global.console_active=true;
    scrDesktopWheelSwap(0,true,false);
    scrHMGameplayCheck(!KeyCont.press_swap[0],"console wheel is discarded");
    global.console_active=false;UberCont.opt_gamepad=true;
    scrDesktopWheelSwap(0,true,false);
    scrHMGameplayCheck(!KeyCont.press_swap[0],"controller mode does not consume desktop wheel");
    UberCont.opt_gamepad=false;UberCont.opt_keyboard=false;
    scrDesktopWheelSwap(0,true,false);
    scrHMGameplayCheck(!KeyCont.press_swap[0],"touch mode does not consume desktop wheel");
    UberCont.opt_keyboard=true;
    var _menu=instance_create(0,0,MenuOptions);
    scrDesktopWheelSwap(0,true,false);
    scrHMGameplayCheck(!KeyCont.press_swap[0],"settings wheel is discarded");
    instance_destroy(_menu);
    KeyCont.press_swap[0]=false;KeyCont.hold_swap[0]=false;
    UberCont.opt_keyboard=_keyboard;UberCont.opt_gamepad=_gamepad;
}
