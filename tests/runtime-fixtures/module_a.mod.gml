global.shared = 10
global.kills = 7
#define update(value)
global.shared += value
result = global.shared
return result
#define arity
result = argument_count
return result
#define units_setup
direction = 0
speed = 6
friction = 0.4
gravity = 0.2
image_speed = 0.4
global.speed = 17
#define units_adjust
speed *= 0.5
speed += 2
motion_add(0, 3)
result = [speed, friction, gravity, image_speed, global.speed]
#define units_increment
result = speed++
second = ++speed
#define units_local
var speed = 7
speed += 3
result = speed
#define units_member(target)
target.speed = 9
target.friction *= 0.5
result = target.speed

#define task_nested(target)
with target {
    task_child()
}
wait 1
result = 71

#define task_child
observed_other = other.marker
wait 1
observed_after_wait = other.marker

#define task_destroy_with(target)
with target {
    wait 1
    instance_destroy()
}
result = 72
