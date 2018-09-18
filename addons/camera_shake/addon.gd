tool
extends EditorPlugin

func _enter_tree():
  add_custom_type("CameraShake", "Node", preload("camera_shake.gd"), preload("node.svg"))

func _exit_tree():
  remove_custom_type("CameraShake")
