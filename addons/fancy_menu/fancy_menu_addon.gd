tool
extends EditorPlugin

func _enter_tree():
  add_custom_type("MenuFocusManager", "Node", preload("menu_focus_manager.gd"), preload("node.svg"))
  add_custom_type("MenuCameraFocus", "Node2D", preload("menu_camera_focus.gd"), preload("node_2d.svg"))

func _exit_tree():
  remove_custom_type("MenuFocusManager")
  remove_custom_type("MenuCameraFocus")
