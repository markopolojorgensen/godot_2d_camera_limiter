extends Node2D

# 0 means no camera movement on focus change
# 1 means selected menu item is always dead center
# higher than 1 means camera "over-pans"
# Use trial and error to find a good value for you.
export(float) var focus_weight = 0.1

func set_focus_position(new_position):
	var new_global_position = Vector2()
	new_global_position.x = lerp(0, new_position.x, focus_weight)
	new_global_position.y = lerp(0, new_position.y, focus_weight)
	global_position = new_global_position
