tool
extends EditorPlugin

func _enter_tree():
	pass
	add_custom_type("TopDownMovement", "Node", preload("top_down_movement.gd"), preload("node.svg"))
	add_custom_type("UserInputDirection", "Node", preload("user_input_direction.gd"), preload("node.svg"))
	add_custom_type("Teleporter", "Node", preload("teleporter.gd"), preload("node.svg"))

func _exit_tree():
	pass
	remove_custom_type("TopDownMovement")
	remove_custom_type("UserInputDirection")
	remove_custom_type("Teleporter")
