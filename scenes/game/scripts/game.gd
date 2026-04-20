class_name Game
extends Node


signal on_win
signal on_lose


var circle_texture: Texture2D
var cross_texture: Texture2D
var grids_nodes: Array
var grids_values: Array
var turn: int


func _ready() -> void:
	self.turn = 0
	for i in range(9):
		self.grids_values.append(null)
	
	self.circle_texture = ImageTexture.create_from_image(Image.load_from_file("res://design/images/Circle.png"))
	self.cross_texture = ImageTexture.create_from_image(Image.load_from_file("res://design/images/Cross.png"))
	
	self.grids_nodes = get_node("MarginContainer/Table/Grids").get_children()
	var i=0
	for grid in self.grids_nodes:
		grid.index = i
		grid.on_click.connect(on_grid_pressed)
		i+=1


func on_grid_pressed(index: int) -> void:
	self.grids_values[index] = self.turn
	(self.grids_nodes[index] as Grid).set_texture(
		self.cross_texture if self.turn == 0 else self.circle_texture
	)
	if check_board():
		end_game()
		return
	toggle_turn()


func _get(i):
	return self.grids_values[i]


func check_board() -> bool:
	#var rows = [
		#_get(0) + _get(1) + _get(2),
		#_get(3) + _get(4) + _get(5),
		#_get(6) + _get(7) + _get(8)
	#]
	#var cols = [
		#_get(0) + _get(3) + _get(6),
		#_get(1) + _get(4) + _get(7),
		#_get(2) + _get(5) + _get(8)
	#]
	#var diags = [
		#_get(0) + _get(4) + _get(8),
		#_get(2) + _get(4) + _get(6)
	#]
	#
	#for i in range(rows.size()):
		#if (rows[i] == 0 or rows[i] == 3):
			#return true
	#
	#
	return false


func toggle_turn() -> void:
	if (self.turn == 1):
		self.turn = 0
	else:
		self.turn = 1


func end_game() -> void:
	pass
