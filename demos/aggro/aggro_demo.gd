extends Node2D

# physics layer 1: scenery / world
# phsyics layer 2: player / actors

# turn on debugging collision shapes to see the raycast at work

# going outside the range or behind the wall prevents the
# guard from seeing the player, but while the player is
# visible to the guard and within the area the guard aggros.

func _ready():
	$guard/Aggro.connect("aggro", self, "target_spotted")
	$guard/Aggro.connect("aggro_lost", self, "target_lost")

func target_spotted(target):
	$Label.text = "Aggro!"

func target_lost(target):
	$Label.text = "No Aggro..."

