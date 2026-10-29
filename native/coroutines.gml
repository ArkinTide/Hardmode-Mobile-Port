// Native resumable continuations for the legacy NTT wait/fork statements.
// Every task owns its locals and with-stack; there is no source eval at runtime.
function scrHMTaskRuntimeInit() {
    global.hm_tasks = [];
    global.hm_task_tick = 0;
}

function scrHMTaskCopyStruct(_source) {
    var _copy = {}, _keys = variable_struct_get_names(_source);
    for (var _i=0; _i<array_length(_keys); ++_i) {
        variable_struct_set(_copy, _keys[_i], variable_struct_get(_source, _keys[_i]));
    }
    return _copy;
}

function scrHMTaskMake(_code, _scope, _other, _args, _entry) {
    return {code:_code, scope:_scope, other_scope:_other, args:_args, pc:_entry,
        vars:{}, with_stack:[], with_floor:0, wait_ticks:0, done:false, result:undefined,
        last_tick:global.hm_task_tick};
}

function scrHMTaskRun(_task) {
    if (_task.done) return;
    _task.last_tick = global.hm_task_tick;
    // The generated function enters the recorded instance scope for each
    // basic block, so nested with and locals survive a suspension.
    _task.code(_task);
}

function scrHMTaskStart(_code, _scope, _other, _args, _entry, _params=[]) {
    var _task = scrHMTaskMake(_code, _scope, _other, _args, _entry);
    for (var _i=0; _i<array_length(_params); ++_i) {
        variable_struct_set(_task.vars, _params[_i], _i<array_length(_args)?_args[_i]:undefined);
    }
    scrHMTaskRun(_task);
    if (!_task.done) array_push(global.hm_tasks, _task);
    return _task.result;
}

function scrHMTaskFork(_parent, _entry) {
    var _child = scrHMTaskMake(_parent.code, _parent.scope, _parent.other_scope, _parent.args, _entry);
    _child.vars = scrHMTaskCopyStruct(_parent.vars);
    for (var _i=0; _i<array_length(_parent.with_stack); ++_i) {
        array_push(_child.with_stack, scrHMTaskCopyStruct(_parent.with_stack[_i]));
    }
    _child.with_floor=array_length(_parent.with_stack);
    scrHMTaskRun(_child);
    if (!_child.done) array_push(global.hm_tasks, _child);
    // In NTT's idiom the child executes the true arm; the original caller
    // continues with the false arm and must not wait for the child.
    return false;
}

function scrHMTaskWithEnter(_task, _targets, _body, _after) {
    var _frame = {scope:_task.scope, other_scope:_task.other_scope, targets:_targets,
                  index:-1, body:_body, after:_after};
    array_push(_task.with_stack, _frame);
    scrHMTaskWithNext(_task);
}

function scrHMTaskWithNext(_task) {
    var _stack = _task.with_stack, _last = array_length(_stack)-1;
    assert(_last>=0, "Hardmode coroutine with-stack underflow");
    var _frame = _stack[_last];
    while (++_frame.index < array_length(_frame.targets)) {
        var _target = _frame.targets[_frame.index];
        if (!instance_exists(_target)) continue;
        _task.scope = _target;
        _task.other_scope = _frame.scope;
        _task.pc = _frame.body;
        return;
    }
    _task.scope = _frame.scope;
    _task.other_scope = _frame.other_scope;
    _task.pc = _frame.after;
    array_pop(_task.with_stack);
}

function scrHMTaskWithAbort(_task) {
    var _frame = array_pop(_task.with_stack);
    _task.scope = _frame.scope;
    _task.other_scope = _frame.other_scope;
    _task.pc = _frame.after;
}

function scrHMTasksTick(_delta) {
    global.hm_task_tick++;
    var _count = array_length(global.hm_tasks);
    for (var _i=0; _i<_count; ++_i) {
        var _task = global.hm_tasks[_i];
        if (_task.done || _task.last_tick==global.hm_task_tick) continue;
        if(instance_exists(_task.scope) && (_task.scope[$ "frozen"]??false)) continue;
        _task.wait_ticks -= _delta;
        if (_task.wait_ticks<=0) scrHMTaskRun(_task);
    }
    // Compact once. Repeated array_delete shifts the remaining task queue
    // quadratically during large boss/terrain effect bursts. Include forks
    // appended during this tick without resuming them a second time.
    var _live=[];
    for(var _i=0;_i<array_length(global.hm_tasks);++_i)
        if(!global.hm_tasks[_i].done) array_push(_live,global.hm_tasks[_i]);
    global.hm_tasks=_live;
}

function scrHMInstances(_target) {
    var _instances = [];
    if(is_array(_target)) {
        var _seen={};
        for(var _i=0;_i<array_length(_target);++_i) {
            var _items=scrHMInstances(_target[_i]);
            for(var _j=0;_j<array_length(_items);++_j) {
                var _key=string(_items[_j]);
                if(variable_struct_exists(_seen,_key)) continue;
                _seen[$ _key]=true;
                array_push(_instances,_items[_j]);
            }
        }
        return _instances;
    }
    if(is_struct(_target)||is_undefined(_target)) return _instances;
    with(_target) array_push(_instances,id);
    return _instances;
}
