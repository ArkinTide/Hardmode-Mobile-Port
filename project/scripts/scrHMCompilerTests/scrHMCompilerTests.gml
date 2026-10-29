function hm_tests_compiler_fixture_gml___load() {

}
function hm_tests_compiler_fixture_gml_sync_conditions() {
if (((left == 1) and (right == 2))) {
result = 7;
} else {
result = 8;
}
result = (result + (left == 1));
}
function hm_tests_compiler_fixture_gml_sync_with_break() {
{ var __hm_with1 = scrHMInstances(global.hm_test_targets), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
{
visits += 1;
__hm_break3=true; break;
}
}
if(__hm_break3) break;
}}
done += 1;
}
function hm_tests_compiler_fixture_gml_wait_local() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_tests_compiler_fixture_gml_wait_local_resume, id, scrHMOther(other), _args, 4, ["amount"]);
}
function hm_tests_compiler_fixture_gml_wait_local_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_tests_compiler_fixture_gml_wait_local");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // tests/compiler-fixture.gml:20
_hm.result=result; _hm.done=true; return;
break;
case 2: // tests/compiler-fixture.gml:19
{
result += _hm.vars.retained;
}
_hm.pc=1;
break;
case 3: // tests/compiler-fixture.gml:18
_hm.wait_ticks=max(0,2); _hm.pc=2; return;
break;
case 4: // tests/compiler-fixture.gml:16
{
_hm.vars.retained = _hm.vars.amount;
result += _hm.vars.retained;
}
_hm.pc=3;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

function hm_tests_compiler_fixture_gml_fork_local() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_tests_compiler_fixture_gml_fork_local_resume, id, scrHMOther(other), _args, 7, ["amount"]);
}
function hm_tests_compiler_fixture_gml_fork_local_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_tests_compiler_fixture_gml_fork_local");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // tests/compiler-fixture.gml:31
_hm.result=result; _hm.done=true; return;
break;
case 2: // tests/compiler-fixture.gml:29
{
_hm.vars.value = 1000;
result += 1;
}
_hm.pc=1;
break;
case 3: // tests/compiler-fixture.gml:27
_hm.result=undefined; _hm.done=true; return;
break;
case 4: // tests/compiler-fixture.gml:26
{
result += _hm.vars.value;
}
_hm.pc=3;
break;
case 5: // tests/compiler-fixture.gml:25
_hm.wait_ticks=max(0,1); _hm.pc=4; return;
break;
case 6: // tests/compiler-fixture.gml:24
_hm.pc = (scrHMTaskFork(_hm, 5)) ? 5 : 2;
break;
case 7: // tests/compiler-fixture.gml:23
{
_hm.vars.value = _hm.vars.amount;
}
_hm.pc=6;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

function hm_tests_compiler_fixture_gml_with_resume() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_tests_compiler_fixture_gml_with_resume_resume, id, scrHMOther(other), _args, 14, []);
}
function hm_tests_compiler_fixture_gml_with_resume_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_tests_compiler_fixture_gml_with_resume");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // tests/compiler-fixture.gml:45
{
done += 1;
}
_hm.pc=0;
break;
case 2: // tests/compiler-fixture.gml:34
scrHMTaskWithNext(_hm);
break;
case 3: // tests/compiler-fixture.gml:34
scrHMTaskWithAbort(_hm);
break;
case 4: // tests/compiler-fixture.gml:43
{
done += 1;
}
_hm.pc=2;
break;
case 5: // tests/compiler-fixture.gml:38
scrHMTaskWithNext(_hm);
break;
case 6: // tests/compiler-fixture.gml:38
scrHMTaskWithAbort(_hm);
break;
case 7: // tests/compiler-fixture.gml:41
{
var __hm_other1=scrHMOther(other);
observed_after = __hm_other1.marker;
}
_hm.pc=5;
break;
case 8: // tests/compiler-fixture.gml:40
_hm.wait_ticks=max(0,1); _hm.pc=7; return;
break;
case 9: // tests/compiler-fixture.gml:39
{
var __hm_other2=scrHMOther(other);
observed_before = __hm_other2.marker;
}
_hm.pc=8;
break;
case 10: // tests/compiler-fixture.gml:38
scrHMTaskWithEnter(_hm,scrHMInstances(global.hm_test_nested),9,4);
break;
case 11: // tests/compiler-fixture.gml:37
{
var __hm_other3=scrHMOther(other);
observed_after = __hm_other3.marker;
}
_hm.pc=10;
break;
case 12: // tests/compiler-fixture.gml:36
_hm.wait_ticks=max(0,1); _hm.pc=11; return;
break;
case 13: // tests/compiler-fixture.gml:35
{
var __hm_other4=scrHMOther(other);
observed_before = __hm_other4.marker;
}
_hm.pc=12;
break;
case 14: // tests/compiler-fixture.gml:34
scrHMTaskWithEnter(_hm,scrHMInstances(global.hm_test_targets),13,1);
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

function hm_tests_compiler_fixture_gml_with_control() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_tests_compiler_fixture_gml_with_control_resume, id, scrHMOther(other), _args, 14, []);
}
function hm_tests_compiler_fixture_gml_with_control_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_tests_compiler_fixture_gml_with_control");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // tests/compiler-fixture.gml:59
{
done += 1;
}
_hm.pc=0;
break;
case 2: // tests/compiler-fixture.gml:53
scrHMTaskWithNext(_hm);
break;
case 3: // tests/compiler-fixture.gml:53
scrHMTaskWithAbort(_hm);
break;
case 4: // tests/compiler-fixture.gml:57
{
visits += 1000;
}
_hm.pc=2;
break;
case 5: // tests/compiler-fixture.gml:56
_hm.pc=2;
break;
case 6: // tests/compiler-fixture.gml:55
{
visits += 1;
}
_hm.pc=5;
break;
case 7: // tests/compiler-fixture.gml:54
_hm.wait_ticks=max(0,1); _hm.pc=6; return;
break;
case 8: // tests/compiler-fixture.gml:53
scrHMTaskWithEnter(_hm,scrHMInstances(global.hm_test_targets),7,1);
break;
case 9: // tests/compiler-fixture.gml:48
scrHMTaskWithNext(_hm);
break;
case 10: // tests/compiler-fixture.gml:48
scrHMTaskWithAbort(_hm);
break;
case 11: // tests/compiler-fixture.gml:51
_hm.pc=10;
break;
case 12: // tests/compiler-fixture.gml:50
_hm.wait_ticks=max(0,1); _hm.pc=11; return;
break;
case 13: // tests/compiler-fixture.gml:49
{
visits += 1;
}
_hm.pc=12;
break;
case 14: // tests/compiler-fixture.gml:48
scrHMTaskWithEnter(_hm,scrHMInstances(global.hm_test_targets),13,8);
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

function hm_tests_compiler_fixture_gml_counted_loop() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_tests_compiler_fixture_gml_counted_loop_resume, id, scrHMOther(other), _args, 12, ["limit"]);
}
function hm_tests_compiler_fixture_gml_counted_loop_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_tests_compiler_fixture_gml_counted_loop");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // tests/compiler-fixture.gml:70
_hm.result=_hm.vars.total; _hm.done=true; return;
break;
case 2: // tests/compiler-fixture.gml:69
{
result = _hm.vars.total;
}
_hm.pc=1;
break;
case 4: // tests/compiler-fixture.gml:63
_hm.vars.i++; _hm.pc=3;
break;
case 5: // tests/compiler-fixture.gml:67
_hm.pc=2;
break;
case 6: // tests/compiler-fixture.gml:67
_hm.pc = ((_hm.vars.i == 4)) ? 5 : 4;
break;
case 7: // tests/compiler-fixture.gml:66
_hm.wait_ticks=max(0,1); _hm.pc=6; return;
break;
case 8: // tests/compiler-fixture.gml:65
{
_hm.vars.total += _hm.vars.i;
}
_hm.pc=7;
break;
case 9: // tests/compiler-fixture.gml:64
_hm.pc=4;
break;
case 10: // tests/compiler-fixture.gml:64
_hm.pc = ((_hm.vars.i == 2)) ? 9 : 8;
break;
case 3: // tests/compiler-fixture.gml:63
_hm.pc=((_hm.vars.i < _hm.vars.limit))?10:2;
break;
case 11: // tests/compiler-fixture.gml:63
_hm.vars.i = 0;
_hm.pc=3;
break;
case 12: // tests/compiler-fixture.gml:62
{
_hm.vars.total = 0;
}
_hm.pc=11;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

function hm_tests_compiler_fixture_gml_switch_resume() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_tests_compiler_fixture_gml_switch_resume_resume, id, scrHMOther(other), _args, 7, ["which"]);
}
function hm_tests_compiler_fixture_gml_switch_resume_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_tests_compiler_fixture_gml_switch_resume");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // tests/compiler-fixture.gml:83
{
done += 1;
}
_hm.pc=0;
break;
case 2: // tests/compiler-fixture.gml:80
{
result = 100;
}
_hm.pc=1;
break;
case 3: // tests/compiler-fixture.gml:79
_hm.pc=1;
break;
case 4: // tests/compiler-fixture.gml:78
{
result += 3;
}
_hm.pc=3;
break;
case 5: // tests/compiler-fixture.gml:76
_hm.wait_ticks=max(0,1); _hm.pc=4; return;
break;
case 6: // tests/compiler-fixture.gml:75
{
result += 2;
}
_hm.pc=5;
break;
case 7: // tests/compiler-fixture.gml:73
_hm.vars.__hm_switch1=_hm.vars.which;
if (_hm.vars.__hm_switch1==1) {_hm.pc=6;} else if (_hm.vars.__hm_switch1==2) {_hm.pc=4;} else {_hm.pc=2;}
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

function hm_tests_compiler_fixture_gml_short_fork() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_tests_compiler_fixture_gml_short_fork_resume, id, scrHMOther(other), _args, 5, ["enabled"]);
}
function hm_tests_compiler_fixture_gml_short_fork_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_tests_compiler_fixture_gml_short_fork");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // tests/compiler-fixture.gml:91
{
result += 1;
}
_hm.pc=0;
break;
case 2: // tests/compiler-fixture.gml:89
_hm.result=undefined; _hm.done=true; return;
break;
case 3: // tests/compiler-fixture.gml:88
{
result += 4;
}
_hm.pc=2;
break;
case 4: // tests/compiler-fixture.gml:87
_hm.wait_ticks=max(0,1); _hm.pc=3; return;
break;
case 5: // tests/compiler-fixture.gml:86
_hm.pc = ((_hm.vars.enabled and scrHMTaskFork(_hm, 4))) ? 4 : 1;
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

function hm_tests_compiler_fixture_gml_legacy_health_first() {
scrHMMaxHealthWrite(id, 100, "=");
;
}
function hm_tests_compiler_fixture_gml_legacy_health_later() {
scrHMMaxHealthWrite(id, 50, "+=");
;
scrHMMaxHealthWrite(id, 2, "*=");
;
}
function hm_tests_compiler_fixture_gml_legacy_health_local() {
var _hml_maxhealth = 3;
;
_hml_maxhealth += 4;
;
return _hml_maxhealth;
;
}
function hm_tests_compiler_fixture_gml_draw_logic_probe() {
var _hml_total = 0;
;
repeat (3) _hml_total++;
;
if(scrHMReadyTick()) { result += _hml_total; }
;
if (scrHMReadyTick() && ((random(1) < 1))) {
{
{ var __hm_with1 = scrHMInstances(instance_create(0, 0, CustomObject)), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
if(scrHMReadyTick()) { name = "draw_probe"; }
}
if(__hm_break3) break;
}}
;
}
}
return _hml_total;
;
}
function hm_tests_compiler_fixture_gml_matching_snapshot() {
{ var __hm_with1 = scrHMMatching(global.hm_test_targets, "marker", 20), __hm_break3=false;
for (var __hm_index2=0; __hm_index2<array_length(__hm_with1); ++__hm_index2) {
if(instance_exists(__hm_with1[__hm_index2])) with (__hm_with1[__hm_index2]) {
visits++;
}
if(__hm_break3) break;
}}
;
}
function hm_tests_compiler_fixture_gml_matching_snapshot_async() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_tests_compiler_fixture_gml_matching_snapshot_async_resume, id, scrHMOther(other), _args, 5, []);
}
function hm_tests_compiler_fixture_gml_matching_snapshot_async_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_tests_compiler_fixture_gml_matching_snapshot_async");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // tests/compiler-fixture.gml:118
scrHMTaskWithNext(_hm);
break;
case 2: // tests/compiler-fixture.gml:118
scrHMTaskWithAbort(_hm);
break;
case 3: // tests/compiler-fixture.gml:119
{
;
visits++;
;
}
_hm.pc=1;
break;
case 4: // tests/compiler-fixture.gml:119
_hm.wait_ticks=max(0,1); _hm.pc=3; return;
break;
case 5: // tests/compiler-fixture.gml:118
scrHMTaskWithEnter(_hm,scrHMMatchingGE(global.hm_test_targets, "marker", 20),4,0);
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

function hm_tests_compiler_fixture_gml_fork_delete_targets() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrHMTaskStart(hm_tests_compiler_fixture_gml_fork_delete_targets_resume, id, scrHMOther(other), _args, 9, []);
}
function hm_tests_compiler_fixture_gml_fork_delete_targets_resume(_hm) {
var _budget=0;
while(!_hm.done) {
assert(++_budget<100000,"Hardmode runaway continuation: hm_tests_compiler_fixture_gml_fork_delete_targets");
if (!instance_exists(_hm.scope)) { if(array_length(_hm.with_stack)>_hm.with_floor) {scrHMTaskWithNext(_hm); continue;} _hm.done=true; return; }
with (_hm.scope) { switch (_hm.pc) {
case 0: _hm.done=true; return;
case 1: // tests/compiler-fixture.gml:131
{
done++;
;
}
_hm.pc=0;
break;
case 2: // tests/compiler-fixture.gml:124
scrHMTaskWithNext(_hm);
break;
case 3: // tests/compiler-fixture.gml:124
scrHMTaskWithAbort(_hm);
break;
case 4: // tests/compiler-fixture.gml:128
{
;
}
_hm.pc=2;
break;
case 5: // tests/compiler-fixture.gml:128
_hm.result=undefined; _hm.done=true; return;
break;
case 6: // tests/compiler-fixture.gml:126
{
;
instance_destroy();
;
}
_hm.pc=5;
break;
case 7: // tests/compiler-fixture.gml:126
_hm.wait_ticks=max(0,1); _hm.pc=6; return;
break;
case 8: // tests/compiler-fixture.gml:125
_hm.pc = (scrHMTaskFork(_hm, 7)) ? 7 : 2;
break;
case 9: // tests/compiler-fixture.gml:124
scrHMTaskWithEnter(_hm,scrHMInstances(global.hm_test_targets),8,1);
break;
default: throw "Hardmode invalid continuation PC";
}}
}
}

function scrHMCompilerCheck(_condition, _message) {
    assert(_condition, "Hardmode native compiler: " + _message);
    global.hm_compiler_checks++;
}

function scrHMCompilerProbe() {
    var _probe=instance_create(0,0,HMTestProbe);
    _probe.result=0; _probe.done=0; _probe.visits=0;
    _probe.left=1; _probe.right=2; _probe.marker=10;
    _probe.observed_before=0; _probe.observed_after=0;
    return _probe;
}

function scrHMCompilerResetTasks() {
    with(HMTestProbe) instance_destroy(id,false);
    scrHMTaskRuntimeInit();
}

function scrHMCompilerTests() {
    if(os_type!=os_windows) return false;
    var _enabled=false;
    for(var _i=1;_i<=parameter_count();++_i) if(parameter_string(_i)=="--hardmode-compiler-tests") _enabled=true;
    if(!_enabled) return false;
    global.hm_compiler_checks=0;
    for(var _rate=30;_rate<=60;_rate+=30) {
        var _delta=30/_rate;
        scrHMCompilerResetTasks();
        var _root=scrHMCompilerProbe(),_a=scrHMCompilerProbe(),_b=scrHMCompilerProbe(),_c=scrHMCompilerProbe();
        global.hm_test_targets=[_a,_b]; global.hm_test_nested=_c;
        with(_root) hm_tests_compiler_fixture_gml_sync_conditions();
        scrHMCompilerCheck(_root.result==8,"legacy equality precedence");
        _root.right=3;
        with(_root) hm_tests_compiler_fixture_gml_sync_conditions();
        scrHMCompilerCheck(_root.result==9,"legacy conditional false arm");
        with(_root) hm_tests_compiler_fixture_gml_sync_with_break();
        scrHMCompilerCheck(_a.visits==1&&_b.visits==0&&_root.done==1,"synchronous with break stops enumeration");

        _root.result=0;
        with(_root) hm_tests_compiler_fixture_gml_wait_local(7);
        scrHMCompilerCheck(_root.result==7,"task executes before first wait");
        repeat(_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==7,"wait does not resume early");
        repeat(_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==14&&array_length(global.hm_tasks)==0,"locals and parameter survive wait");

        _root.result=0;
        with(_root) hm_tests_compiler_fixture_gml_fork_local(9);
        scrHMCompilerCheck(_root.result==1,"fork parent continues immediately");
        repeat(_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==10,"fork retains independent scalar locals");

        _root.done=0;_a.done=0;_b.done=0;_a.marker=20;_b.marker=30;
        with(_root) hm_tests_compiler_fixture_gml_with_resume();
        repeat(5*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_a.observed_before==10&&_a.observed_after==10,"first with retains other across wait");
        scrHMCompilerCheck(_b.observed_before==10&&_b.observed_after==10,"next with target gets caller as other");
        scrHMCompilerCheck(_c.observed_before==30&&_c.observed_after==30,"nested with retains immediate caller");
        scrHMCompilerCheck(_root.done==1&&_a.done==1&&_b.done==1,"nested with restores caller scope");

        _root.done=0;_a.visits=0;_b.visits=0;
        with(_root) hm_tests_compiler_fixture_gml_with_control();
        repeat(4*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_a.visits==2&&_b.visits==1&&_root.done==1,"async with break and continue unwind their frame");

        _root.result=0;
        with(_root) hm_tests_compiler_fixture_gml_counted_loop(9);
        repeat(6*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==8,"for locals, continue, break, and waits");

        _root.result=0;_root.done=0;
        with(_root) hm_tests_compiler_fixture_gml_switch_resume(1);
        repeat(_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==5&&_root.done==1,"switch fall-through survives wait");
        _root.result=0;_root.done=0;
        with(_root) hm_tests_compiler_fixture_gml_switch_resume(99);
        scrHMCompilerCheck(_root.result==100&&_root.done==1,"switch default path");

        _root.result=0;
        with(_root) hm_tests_compiler_fixture_gml_short_fork(false);
        scrHMCompilerCheck(_root.result==1&&array_length(global.hm_tasks)==0,"short-circuited fork does not spawn");
        with(_root) hm_tests_compiler_fixture_gml_short_fork(true);
        repeat(_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==6&&array_length(global.hm_tasks)==0,"conditional fork true child");
        _a.visits=0;_b.visits=0;
        global.hm_test_targets=[_a,_b,_a];
        with(_root) hm_tests_compiler_fixture_gml_matching_snapshot();
        scrHMCompilerCheck(_a.visits==1&&_b.visits==0,"filtered snapshot preserves unique input targets");
        with(_root) hm_tests_compiler_fixture_gml_matching_snapshot_async();
        repeat(3*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_a.visits==2&&_b.visits==1,"filtered async with preserves snapshot and continuation");
        _root.result=0;_root.frozen=true;
        with(_root) hm_tests_compiler_fixture_gml_wait_local(3);
        repeat(5*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==3,"frozen owner suspends its continuation");
        _root.frozen=false;
        repeat(2*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(_root.result==6&&array_length(global.hm_tasks)==0,"unfreezing resumes retained continuation");
        var _dead1=scrHMCompilerProbe(),_dead2=scrHMCompilerProbe();
        global.hm_test_targets=[_dead1,_dead2];_root.done=0;
        with(_root) hm_tests_compiler_fixture_gml_fork_delete_targets();
        repeat(3*_rate/30) scrHMTasksTick(_delta);
        scrHMCompilerCheck(!instance_exists(_dead1)&&!instance_exists(_dead2),"forked destruction affects its captured targets");
        scrHMCompilerCheck(_root.done==1&&array_length(global.hm_tasks)==0,"dead fork cannot resume its parent's with iteration");
        show_debug_message("HARDMODE COMPILER RATE PASS "+string(_rate));
    }
    scrHMCompilerResetTasks();
    UberCont.dont_save=true;
    show_debug_message("HARDMODE COMPILER RESULT "+json_stringify({status:"PASS",checks:global.hm_compiler_checks,rates:[30,60]}));
    game_end();
    return true;
}
