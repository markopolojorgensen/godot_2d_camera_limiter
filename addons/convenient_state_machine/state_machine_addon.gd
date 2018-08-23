tool
extends EditorPlugin

func _enter_tree():
  add_custom_type("StateMachine", "Node", preload("state_machine.gd"), preload("node.svg"))

func _exit_tree():
  remove_custom_type("StateMachine")
