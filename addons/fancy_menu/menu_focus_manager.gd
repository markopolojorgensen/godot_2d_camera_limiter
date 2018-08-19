extends Node

# item container can be any node
# item container's children have to emit focus_entered signal
#   that usually means setting the focus_mode to ALL!
#   also probably a good idea to set focus_mode to none on the item's children
#   in my games the items themselves are usually inherited scenes with a single container that is the root node.

export(NodePath) var camera_focus_path
onready var camera_focus = get_node(camera_focus_path)

export(NodePath) var item_container_path
onready var item_container = get_node(item_container_path)

export(bool) var grab_focus_on_ready = true

func _ready():
	var menu_items = item_container.get_children()
	for item in menu_items:
		item.connect("focus_entered", self, "focus_changed", [item])
	
	if grab_focus_on_ready and menu_items.size() > 0:
		menu_items[0].grab_focus()

func focus_changed(control):
	var adjusted_position = control.get_global_position() + (control.get_size() / 2.0)
	camera_focus.set_focus_position(adjusted_position)

