tool
extends EditorPlugin

func _enter_tree():
  add_custom_type("NoiseGenerator", "Node", preload("noise_generator.gd"), preload("node.svg"))

func _exit_tree():
  remove_custom_type("NoiseGenerator")
