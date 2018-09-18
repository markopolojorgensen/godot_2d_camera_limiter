extends Node

var current_value = 0
export(float) var value_range = 2
onready var value_extreme = value_range / 2.0

var speed = 0
export(float) var speed_range = 5
onready var speed_extreme = speed_range / 2.0

var acceleration = 0
export(float) var acceleration_range = 100
onready var acceleration_extreme = acceleration_range / 2.0
# bias to prevent being stuck against an extreme for a long time
onready var bias_extreme = acceleration_extreme * 0.4

func get_noise(delta):
	# update acceleration
	var unclamped_acceleration = (randf() * acceleration_range) - acceleration_extreme
	# biased based on how close the actual value is to bottoming out
	var weight = 1.0 - ((current_value + value_extreme) / value_range)
	var bias = lerp(-bias_extreme, bias_extreme, weight)
	unclamped_acceleration += bias
	acceleration = clamp(unclamped_acceleration, -acceleration_extreme, acceleration_extreme)
	
	# update speed
	var unclamped_speed = speed + (acceleration * delta)
	speed = clamp(unclamped_speed, -speed_extreme, speed_extreme)
	
	# update value
	var unclamped_value = current_value + (speed * delta)
	current_value = clamp(unclamped_value, -value_extreme, value_extreme)
	
	return current_value

