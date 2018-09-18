extends Sprite

func _ready():
	$AnimationPlayer.play("player_walk")
	pass

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		$Camera2D/CameraShake.add_trauma(0.8 * delta)

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		$Camera2D/CameraShake.add_trauma(0.5)
