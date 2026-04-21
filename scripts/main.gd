extends Node


var game_sc: PackedScene = preload("res://scenes/game/game.tscn")
var start_menu_sc: PackedScene = preload("res://scenes/start_menu/start_menu.tscn")


func on_init() -> void:
	var game = game_sc.instantiate() as Game
	self.switch_child(game)


func _ready() -> void:
	var start_menu = start_menu_sc.instantiate()
	start_menu.on_init = on_init
	self.switch_child(start_menu)


func switch_child(sc: Node) -> void:
	if (self.get_child_count() > 1):
		var old = self.get_child(1)
		self.remove_child(old)
	self.add_child(sc)
