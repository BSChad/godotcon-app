class_name ScheduleController
extends Control


@export var api_driver: PretalxAPIDriver


func _ready() -> void:
	api_driver.get_talks(handle_talks_received)


func handle_talks_received(talks):
	for talk in talks:
		var label = Label.new()
		label.text = talk.title
		$ScrollContainer/VBoxContainer.add_child(label)
