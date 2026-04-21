class_name Grid
extends Node


signal on_click


var is_active: bool
var index: int


func _ready() -> void:
	set_active(true)


func _on_button_pressed() -> void:
	if (self.is_active):
		set_active(false)
		self.on_click.emit(self.index)


func set_texture(figure: Texture2D) -> void:
	var sprt: Sprite2D = get_node("Center/Figure")
	sprt.texture = figure
	sprt.scale = Vector2(0.5, 0.5)


func set_active(v: bool) -> void:
	self.is_active = v
