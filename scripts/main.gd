extends Node


var game_sc: PackedScene = preload("res://scenes/game/game.tscn")
var start_menu_sc: PackedScene = preload("res://scenes/start_menu/start_menu.tscn")


func on_win() -> void:
	pass


func on_lose() -> void:
	pass


func on_init() -> void:
	var game = game_sc.instantiate()
	game.on_win = on_win
	game.on_lose = on_lose
	self.switch_child(game)


func _ready() -> void:
	var start_menu = start_menu_sc.instantiate()
	start_menu.on_init = on_init
	switch_child(start_menu)


func switch_child(sc: Node) -> void:
	var old = self.get_child(1)
	self.remove_child(old)
	self.add_child(sc)
