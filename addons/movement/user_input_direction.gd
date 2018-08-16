extends Node

# todo controller input
# https://godotengine.org/article/handling-axis-godot

func get_intended_direction():
	var direction = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	elif Input.is_action_pressed("ui_left"):
		direction.x = -1
	
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1
	
	return direction.normalized()


