extends Node

signal buffer_expired

export(NodePath) var body_path
onready var body = get_node(body_path)

export(float) var time_buffer = 0.02
var time_remaining

var teleporting = false

func _ready():
	set_process(false)

func teleport(new_destination):
	# don't teleport while teleporting!
	if teleporting:
		return
	
	teleporting = true
	
	# disable physics
	body.set_physics_process(false)
	
	# wait for physics engine to chill out
	time_remaining = time_buffer
	set_process(true)
	yield(self, "buffer_expired")
	
	# do teleport
	body.global_position = new_destination
	
	# wait again to prevent physics engine from undoing teleport
	time_remaining = time_buffer
	set_process(true)
	yield(self, "buffer_expired")
	
	# re-enable physics
	body.set_physics_process(true)
	teleporting = false

func _process(delta):
	time_remaining -= delta
	if time_remaining <= 0:
		set_process(false)
		emit_signal("buffer_expired")
