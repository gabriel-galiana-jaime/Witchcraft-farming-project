extends Node

var global_cursor_position : Vector2 = Vector2(0,0)
var global_player_position : Vector2 = Vector2(0,0)

var global_is_gameplay_on : bool = true

# Inventory System:

var player_inventory = [{"type":"axe","num":"1"},{"type":"hacke","num":"1"},{"type":"water","num":"1"},{"type":"wood","num":"12"},{"type":"wood","num":"7"},{"type":"wood","num":"1"},{"type":"blank","num":"1"},{"type":"blank","num":"1"},{"type":"blank","num":"1"},{"type":"blank","num":"1"},{"type":"axe","num":"1"},{"type":"hacke","num":"1"},{"type":"water","num":"1"},{"type":"wood","num":"1"},{"type":"wood","num":"1"},{"type":"wood","num":"1"},{"type":"blank","num":"1"},{"type":"blank","num":"1"},{"type":"blank","num":"1"},{"type":"blank","num":"1"},{"type":"axe","num":"1"},{"type":"hacke","num":"1"},{"type":"water","num":"1"},{"type":"wood","num":"1"},{"type":"wood","num":"1"},{"type":"wood","num":"1"},{"type":"blank","num":"1"},{"type":"blank","num":"1"},{"type":"blank","num":"1"},{"type":"blank","num":"1"}]

var current_player_item = {"type":"axe","num":"1"}
func get_needed_texture(type):
	if type == "blank":
		return "res://design/lore/village/Farm/Sprout Lands-Sprites-Basic pack/selected_sprite/Basic_tools_and_meterials0.png"
	if type == "rock":
		return "res://design/lore/village/Farm/Tiny Wonder Farm Free/objects&items/rocktest.png"
	if type == "axe":
		return "res://design/lore/village/Farm/Sprout Lands-Sprites-Basic pack/selected_sprite/Basic_tools_and_meterials2.png"
	if type == "hacke":
		return "res://design/lore/village/Farm/Sprout Lands-Sprites-Basic pack/selected_sprite/Basic_tools_and_meterials3.png"
	if type == "water":
		return "res://design/lore/village/Farm/Sprout Lands-Sprites-Basic pack/selected_sprite/Basic_tools_and_meterials1.png"
	if type == "wood":
		return "res://design/lore/village/Farm/Sprout Lands-Sprites-Basic pack/selected_sprite/Basic_tools_and_meterials5.png"
