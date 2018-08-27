extends Node2D

# don't forget to give this node the path to the camera
#   you can just use your player node, all this needs is
#   something with a global_position.
# 
# great for wiring up timers to spawn new motes if your
# motes eventually fade
#
# This definitely does NOT work with the built-in parallax
# layer system. the dust motes basically have to be on the
# same CanvasLayer as the camera

export(NodePath) var camera_path
onready var camera = get_node(camera_path)

func spawn_mote(scene):
	var inst = scene.instance()
	# must add camera before ready() runs
	inst.camera = camera
	add_child(inst)


