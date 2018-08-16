extends RigidBody2D

func _integrate_forces(state):
	$TopDownMovement.do_movement(state)

