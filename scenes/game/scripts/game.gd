class_name Game
extends Node


var circle_texture: Texture2D
var cross_texture: Texture2D
var grids_nodes: Array
var grids_values: Array
var turn: int
var last_grid_pressed


func _ready() -> void:
	init_game()
	
	self.circle_texture = ImageTexture.create_from_image(Image.load_from_file("res://design/images/Circle.png"))
	self.cross_texture = ImageTexture.create_from_image(Image.load_from_file("res://design/images/Cross.png"))


func init_game() -> void:
	self.turn = 0
	self.last_grid_pressed = null
	self.grids_values = []
	for i in range(9):
		self.grids_values.append(null)
	self.grids_nodes = get_node("MarginContainer/Table/Grids").get_children()
	for i in range(self.grids_nodes.size()):
		var grid: Grid = self.grids_nodes[i]
		grid.index = i
		grid.set_active(true)
		grid.set_texture(null)
		if (grid.on_click.has_connections()):
			grid.on_click.disconnect(on_grid_pressed)
		grid.on_click.connect(on_grid_pressed)
	self.get_node("%Result").hide()


func on_grid_pressed(index: int) -> void:
	self.grids_values[index] = self.turn
	(self.grids_nodes[index] as Grid).set_texture(
		self.cross_texture if self.turn == 0 else self.circle_texture
	)
	self.last_grid_pressed = index
	if check_board():
		end_game()
		return
	toggle_turn()


func _get_(i: int) -> int:
	return self.grids_values[i] if self.grids_values[i] != null else 10


func check_board() -> bool:
	var rows = [
		_get_(0) + _get_(1) + _get_(2),
		_get_(3) + _get_(4) + _get_(5),
		_get_(6) + _get_(7) + _get_(8)
	]
	var cols = [
		_get_(0) + _get_(3) + _get_(6),
		_get_(1) + _get_(4) + _get_(7),
		_get_(2) + _get_(5) + _get_(8)
	]
	var diags = [
		_get_(0) + _get_(4) + _get_(8),
		_get_(2) + _get_(4) + _get_(6)
	]
	
	for i in range(rows.size()):
		if (rows[i] == 0 or rows[i] == 3):
			return true
	
	for i in range(cols.size()):
		if (cols[i] == 0 or cols[i] == 3):
			return true
	
	for i in range(diags.size()):
		if (diags[i] == 0 or diags[i] == 3):
			return true
	
	return false


func toggle_turn() -> void:
	if (self.turn == 1):
		self.turn = 0
	else:
		self.turn = 1


func end_game() -> void:
	var sprt = self.get_node("%WinnerIcon")
	match self.turn:
		0:
			sprt.texture = self.cross_texture
		1:
			sprt.texture = self.circle_texture
	self.get_node("%Result").show()
	
	for grid in self.grids_nodes:
		(grid as Grid).on_click.disconnect(on_grid_pressed)


func _on_again_btn_pressed() -> void:
	init_game()


func _on_undo_btn_pressed() -> void:
	if (self.last_grid_pressed):
		self.grids_values[self.last_grid_pressed] = null
		self.grids_nodes[self.last_grid_pressed].set_active(true)
		self.grids_nodes[self.last_grid_pressed].set_texture(null)
		self.last_grid_pressed = null
		toggle_turn()
