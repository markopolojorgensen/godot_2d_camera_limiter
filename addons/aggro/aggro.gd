extends Area2D

# also see http://kidscancode.org/blog/2018/03/godot3_visibility_raycasts/

# don't forget to set up collision layers appropriately
#   raycast needs to collide with scenery layer and aggroing things layer
#   I think you can have scenery and aggroing things on the same layer, but I've not tested it
# don't forget to add triggers_aggro() to bodies you want to trigger aggro
# don't forget to add a shape for the aggro and set the raycast path


signal aggro(entity)
signal aggro_lost(entity)

# can't instantiate scenes via plugin, so you have to supply your own raycast node
# it's fine to add it as a child of the aggro node.
export(NodePath) var raycast_path
onready var raycast = get_node(raycast_path)

# Todo: support aggroing multiple targets!
var target
var aggro_active = false

func _ready():
	connect("body_entered", self, "body_entered")
	connect("body_exited", self, "body_exited")

func _process(delta):
	# hack to force area to recognize static bodies
	position = position
	
	if target != null:
		$RayCast2D.cast_to = target.global_position - global_position
		$RayCast2D.force_raycast_update()
		
		var raycast_is_hitting_target = $RayCast2D.is_colliding() and $RayCast2D.get_collider() == target
		if not aggro_active and raycast_is_hitting_target:
			emit_signal("aggro", target)
			aggro_active = true
		elif aggro_active and not raycast_is_hitting_target:
			emit_signal("aggro_lost", target)
			aggro_active = false

func body_entered(body):
	if body.has_method("triggers_aggro") and body.triggers_aggro():
		target = body

func body_exited(body):
	if body.has_method("triggers_aggro") and body.triggers_aggro() and target == body:
		if target != null and aggro_active:
			emit_signal("aggro_lost", target)
			aggro_active = false
		target = null
		

