extends Node

# physics body
# needs apply_impulse, so basically always RigidBody2D
#   most likely set in character mode if you're doing pixel art stuff.
#   don't forget to tune the linear damping on the body (i.e. turn it on)
#   don't forget to tune friction
#   don't forget to set gravity to 0 (i.e. turn it off)
# body has to override _integrate_forces and call this node's do_movement with the body's state
export(NodePath) var body_path
onready var body = get_node(body_path)

# body to tell movement where to go
# can be the same as physics body
# needs get_intended_direction() which returns a Vector2()
export(NodePath) var direction_path
onready var direction = get_node(direction_path)

export(float) var acceleration = 1000
export(float) var default_max_speed = 600
var max_speed = default_max_speed

func _ready():
	if not (body is RigidBody2D):
		print("halp")
	
	max_speed = default_max_speed

func do_movement(state):
	# accelerate in the direction you want to go
	var id = direction.get_intended_direction()
	if id.length() > 0.1:
		var move_impulse = id.normalized() * state.step * acceleration
		body.apply_impulse(Vector2(), move_impulse)
	
	# don't go too fast
	if state.linear_velocity.length() > max_speed:
		var capped_lin_vel = state.linear_velocity.normalized() * max_speed
		state.linear_velocity = capped_lin_vel


