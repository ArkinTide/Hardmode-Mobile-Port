// Measure actual physical frames, not the requested room speed or fps_real.
function scrHMPerf111Manual() { x+=2; }
function scrHMPerf111ProbeDraw() {
    var _matrix=matrix_get(matrix_world),_shown=x+_matrix[12];
    if(self[$ "hm_draw_started111"]??false) {
        if(abs(_shown-hm_shown111)>.01) hm_shown_moves111++;
        hm_shown_max_delta111=max(hm_shown_max_delta111,abs(_shown-hm_shown111));
    } else {hm_draw_started111=true;hm_shown_moves111=0;hm_shown_max_delta111=0;}
    hm_shown111=_shown;
    draw_sprite(sprite_index,0,x,y);
}
function scrHMPerf111Frame() {
    if(mode!="perf111" || ticks<15) return;
    if(!(self[$ "perf_started111"]??false)) {
        perf_started111=true;perf_frames111=0;perf_draws111=0;perf_intervals111=[];
        perf_start111=get_timer();perf_last111=perf_start111;perf_step_start111=ticks;
        perf_cpu111=[];perf_manual_moves111=0;perf_manual_last111=0;
        perf_probe111=instance_create(20000,20000,CustomObject);
        perf_probe111.on_step=scrHMPerf111Manual;perf_probe111.speed=0;
        perf_probe111.on_draw=scrHMPerf111ProbeDraw;
        perf_probe111.sprite_index=sprBanditIdle;perf_probe111.image_speed=0;
        perf_manual_last111=perf_probe111.x;
    }
    var _now=get_timer();
    if(perf_frames111>0) array_push(perf_intervals111,_now-perf_last111);
    perf_last111=_now;perf_frames111++;
    array_push(perf_cpu111,_now-hm_frame_start106);
    if(perf_probe111.x!=perf_manual_last111) perf_manual_moves111++;
    perf_manual_last111=perf_probe111.x;
    if(ticks>=goal_ticks-1 && !(self[$ "perf_done111"]??false)) {
        perf_done111=true;
        var _elapsed=(_now-perf_start111)/1000000;
        // array_sort mutates arrays; read the original reference afterwards.
        array_sort(perf_intervals111,true);array_sort(perf_cpu111,true);
        show_debug_message("HARDMODE PERF111 "+json_stringify({rate:rate,frames:perf_frames111,
            draws:perf_draws111,elapsed:_elapsed,measured_fps:(perf_frames111-1)/_elapsed,
            logic_ticks:ticks-perf_step_start111,manual_move_frames:perf_manual_moves111,
            rendered_move_frames:perf_probe111.hm_shown_moves111,
            maximum_rendered_delta:perf_probe111.hm_shown_max_delta111,
            median_interval_us:perf_intervals111[floor(array_length(perf_intervals111)/2)],
            p95_interval_us:perf_intervals111[floor(array_length(perf_intervals111)*.95)],
            median_cpu_us:perf_cpu111[floor(array_length(perf_cpu111)/2)],
            p95_cpu_us:perf_cpu111[floor(array_length(perf_cpu111)*.95)]}));
        scrHMGameplayCheck(abs((perf_frames111-1)/_elapsed-rate)<3,"actual measured frame rate matches the requested 30/60 rate");
        scrHMGameplayCheck(abs(perf_draws111-perf_frames111)<=2,"physical frames are actually drawn");
        scrHMGameplayCheck(perf_probe111.hm_shown_moves111>=perf_frames111-3,"manual movement changes its rendered position every physical frame");
        scrHMGameplayCheck(perf_probe111.hm_shown_max_delta111<=60/rate+.01,"manual movement is evenly spread without increasing simulation speed");
    }
}
function scrHMPerf111Draw() {
    if(mode=="perf111" && (self[$ "perf_started111"]??false)) perf_draws111++;
}
