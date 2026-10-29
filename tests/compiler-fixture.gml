// Tiny legacy programs exercise the same lowering as the real MOD modules.
#define sync_conditions
if left = 1 and right = 2
    result = 7
else result = 8
result = result + (left = 1)

#define sync_with_break
with global.hm_test_targets {
    visits += 1
    break
}
done += 1

#define wait_local(amount)
var retained = amount
result += retained
wait 2
result += retained
return result

#define fork_local(amount)
var value = amount
if fork() {
    wait 1
    result += value
    exit
}
value = 1000
result += 1
return result

#define with_resume
with global.hm_test_targets {
    observed_before = other.marker
    wait 1
    observed_after = other.marker
    with global.hm_test_nested {
        observed_before = other.marker
        wait 1
        observed_after = other.marker
    }
    done += 1
}
done += 1

#define with_control
with global.hm_test_targets {
    visits += 1
    wait 1
    break
}
with global.hm_test_targets {
    wait 1
    visits += 1
    continue
    visits += 1000
}
done += 1

#define counted_loop(limit)
var total=0
for(var i=0;i<limit;i++) {
    if i=2 continue
    total+=i
    wait 1
    if i=4 break
}
result=total
return total

#define switch_resume(which)
switch which {
case 1:
    result+=2
    wait 1
case 2:
    result+=3
    break
default:
    result=100
}
done+=1

#define short_fork(enabled)
if enabled and fork() {
    wait 1
    result+=4
    exit
}
result+=1
// Exercise the emitted legacy field setter, including a shadowing local.
#define legacy_health_first
maxhealth=100;

#define legacy_health_later
maxhealth+=50;
maxhealth*=2;

#define legacy_health_local
var maxhealth=3;
maxhealth+=4;
return maxhealth;

#define draw_logic_probe
var total=0;
repeat(3) total++;
result+=total;
if random(1)<1 {
    with instance_create(0,0,CustomObject) name="draw_probe";
}
return total;

#define matching_snapshot
with instances_matching(global.hm_test_targets,"marker",20) visits++;

#define matching_snapshot_async
with instances_matching_ge(global.hm_test_targets,"marker",20) {
    wait 1;
    visits++;
}

#define fork_delete_targets
with global.hm_test_targets {
    if fork() {
        wait 1;
        instance_destroy();
        exit;
    }
}
done++;

