extends Node

# warning / disclaimer: rotational camera shake has horrifying / nauseating
# effects when used with godot's default parallax system. This is more or
# less because parallax layers don't respect camera rotation, only scroll
# offset.

# maybe this script shouldn't use process / force user to add camera
# script that calls it each frame? less obtrusive that way, dunno
# if it matters.

# don't forget to set camera as active
# don't forget to set camera rotating to true if you want rotational shake
export(NodePath) var camera_path
onready var camera = get_node(camera_path)

# noise generators
# must have three children: x, y, and rot
# (these three children shouldn't be the same noise generator!)
# children must have a get_noise(delta) that returns a value betweeen -1 and 1
export(NodePath) var noise_generators_path
onready var noise_generators = get_node(noise_generators_path)

# only set this if you want a debug label that shows you current trauma level
export(NodePath) var trauma_debug_label_path
var trauma_debug_label

var trauma = 0
var trauma_depletion = 0.8
var max_camera_offset = 60
var max_camera_degrees = 10

# normal time is too slow?
var offset_time_factor = 2.5
var rot_time_factor = 3.5

func _ready():
	add_to_group("trauma_listeners")
	
	if trauma_debug_label_path != null:
		trauma_debug_label = get_node(trauma_debug_label_path)

func _process(delta):
	shake_screen(delta)

func shake_screen(delta):
	if trauma_debug_label:
		trauma_debug_label.set_text(str(trauma))
	
	if trauma > 0:
		# translation
		var offset = Vector2()
		offset.x = noise_generators.get_node("x").get_noise(delta * offset_time_factor)
		offset.y = noise_generators.get_node("y").get_noise(delta * offset_time_factor)
		offset *= max_camera_offset * pow(trauma, 3) # squared or cubed
		# not global position, this is relative to parent
		# (normally camera position is 0,0)
		camera.position = offset
		
		#rotation
		var rot = noise_generators.get_node("rot").get_noise(delta * rot_time_factor) * max_camera_degrees * pow(trauma, 3)
		camera.rotation_degrees = rot
		
		# trauma decreases linearly over time
		var new_trauma = trauma - (trauma_depletion * delta)
		trauma = clamp(new_trauma, 0, 1)

func add_trauma(amount):
	var new_trauma = trauma + amount
	trauma = clamp(new_trauma, 0, 1)

