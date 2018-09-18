extends Sprite

var original_position
export(int) var total_range = 200

func _ready():
	randomize()
	original_position = global_position

func _physics_process(delta):
	var offset = (randf() * total_range) - (total_range / 2.0)
	global_position.y = original_position.y + offset

