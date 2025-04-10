extends Control


@onready var _title := $Title


func _init(talk: Talk):
	_title.text = talk.title
