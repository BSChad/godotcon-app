class_name Talk
extends Resource


@export var title: String

func _init(json_data):
	title = json_data["title"]
