extends Node


@export_file_path()
var image: String
var background: Sprite2D

func _ready() -> void:
	background = get_node("Background")
	
	if (image):
		background = get_child(0)
		background.texture = ImageTexture.create_from_image(
			Image.load_from_file(image)
		)
		
	background.scale = Vector2(get_window().size.x, get_window().size.y)
