extends Node2D

# moving dust motes!
# randomly picks x and y separately!
export(Vector2) var min_velocity = Vector2(5, 0)
export(Vector2) var max_velocity = Vector2(20, 0)

# multiplied by screen size, then spawns within those dimensions
export(float) var spawn_border = 0.8

# how much space to leave when wrapping so part of the mote doesn't suddenly teleport
export(int) var wrap_border = 10

var velocity = Vector2()

# center 
var camera

func _ready():
	var screen_size = get_viewport().size 
	screen_size *= spawn_border # shrink to give border
	
	velocity.x = rand_range(min_velocity.x, max_velocity.x)
	velocity.y = rand_range(min_velocity.y, max_velocity.y)
	
	var offset = Vector2()
	offset.x = (randf() * screen_size.x) - (screen_size.x / 2.0)
	offset.y = (randf() * screen_size.y) - (screen_size.y / 2.0)
	global_position = camera.global_position + offset

func _process(delta):
	position += velocity * delta
	
	var screen_size = get_viewport().size 
	
	# wrap x
	if global_position.x < (camera.global_position.x - (screen_size.x / 2.0) - wrap_border):
		global_position.x += screen_size.x + (2 * wrap_border)
	elif global_position.x > (camera.global_position.x + (screen_size.x / 2.0) + wrap_border):
		global_position.x -= screen_size.x + (2 * wrap_border)
	
	# wrap y
	if global_position.y < (camera.global_position.y - (screen_size.y / 2.0) - wrap_border):
		global_position.y += screen_size.y + (2 * wrap_border)
	elif global_position.y > (camera.global_position.y + (screen_size.y / 2.0) + wrap_border):
		global_position.y -= screen_size.y + (2 * wrap_border)

