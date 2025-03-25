@tool
class_name TabContainerWithIcons
extends TabContainer

@export var tab_icons: Array[Texture]


func _on_child_entered_tree(node: Node) -> void:
	print(node)


func _ready() -> void:
	for i in get_tab_count():
		if i < tab_icons.size():
			set_tab_icon(i, tab_icons[i])
