extends Timer

func _process(delta):
	if is_stopped():
		$Label.text = "--"
	else:
		$Label.text = str(stepify(time_left, 0.1))
