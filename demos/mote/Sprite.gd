extends Sprite

# in seconds
# 0 -> infinite lifetime
# doesn't start running until after fade-in
export(float) var lifetime = 0

# how long to fade in (and fade out if using lifetime)
export(float) var fade_time = 2

func _ready():
	# hide
	modulate = Color(1, 1, 1, 0)
	
	$Tween.interpolate_property(self, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), fade_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	
	if lifetime > 0:
		$Timer.wait_time = lifetime
		$Timer.start()
		yield($Timer, "timeout")
		
		$Tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), fade_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
		
		get_parent().queue_free()



