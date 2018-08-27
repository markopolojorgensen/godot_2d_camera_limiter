tool
extends EditorPlugin

func _enter_tree():
  add_custom_type("Mote", "Node2D", preload("mote.gd"), preload("node_2d.svg"))
  add_custom_type("MoteSpawner", "Node2D", preload("mote_spawner.gd"), preload("node_2d.svg"))

func _exit_tree():
  remove_custom_type("Mote")
  remove_custom_type("MoteSpawner")
