tool
extends EditorPlugin

func _enter_tree():
  add_custom_type("Aggro", "Area2D", preload("aggro.gd"), preload("area_2d.svg"))

func _exit_tree():
  remove_custom_type("Aggro")
