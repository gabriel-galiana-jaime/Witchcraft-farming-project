extends Node

var global_cursor_position : Vector2 = Vector2(0,0)






# Inventory System

var player_inventory = [{"type":"rock","num":"1"},{"type":"rock","num":"1"},{"type":"rock","num":"1"},{"type":"rock","num":"1"}]


func get_needed_texture(type):
	if type == "rock":
		return "res://design/lore/village/Farm/Tiny Wonder Farm Free/objects&items/rocktest.png"
	pass
