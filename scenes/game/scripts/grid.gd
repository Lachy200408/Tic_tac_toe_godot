class_name Grid
extends Node


signal on_click


var is_active: bool
var index: int


func _ready() -> void:
	self.is_active = true


func _on_button_pressed() -> void:
	if (self.is_active):
		self.is_active = false
		self.on_click.emit(self.index)


func set_texture(figure: Texture2D) -> void:
	var sprt: Sprite2D = get_node("Center/Figure")
	sprt.texture = figure
	sprt.scale = Vector2(0.5, 0.5)
