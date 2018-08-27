extends Node2D

func _ready():
	$Timer.connect("timeout", $MoteSpawner, "spawn_mote", [preload("res://demos/mote/dust_mote.tscn")])
	$AnimationPlayer.play("camera_swing")
	

