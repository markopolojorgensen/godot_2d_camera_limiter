extends RigidBody2D

func _integrate_forces(state):
	$TopDownMovement.do_movement(state)

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		$Teleporter.teleport($"../Sprite".global_position)
