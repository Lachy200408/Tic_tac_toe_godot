extends Node


var on_init: Callable


func _on_start_button_pressed() -> void:
	var btn = get_node("GridContainer/VBoxContainer/StartButton") as Button
	btn.release_focus()
	if on_init.is_valid():
		on_init.call()
