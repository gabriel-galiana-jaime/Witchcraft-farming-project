extends Node2D

@export var state_machine_UI : int = 0
"""
0 = tool bar
1 = inventory
"""

#tool bar:
@onready var box_obj_4 = $"gameplay_bar/box_obj-4"
@onready var box_obj_3 = $"gameplay_bar/box_obj-3"
@onready var box_obj_2 = $"gameplay_bar/box_obj-2"
@onready var box_obj_1 = $"gameplay_bar/box_obj-1"
@onready var box_obj0 = $gameplay_bar/box_obj0
@onready var box_obj1 = $"gameplay_bar/box_obj1"
@onready var box_obj2 = $gameplay_bar/box_obj2
@onready var box_obj3 = $gameplay_bar/box_obj3
@onready var box_obj4 = $gameplay_bar/box_obj4
@onready var box_obj5 = $gameplay_bar/box_obj5
var unselected_texture : String = "res://design/UI/selected/ui_box1.png"
var selected_texture : String = "res://design/UI/selected/ui_box2.png"
var selected_item = 1
#Main menu, Inventory:
@onready var main_menu = $main_menu
@onready var main_menu_inventory = $main_menu/inventory

var blank_item = {"type":"blank","num":"1"}
var item_moving : Dictionary = blank_item
# Called when the node enters the scene tree for the first time.$"gameplay_bar/box_obj-4/icon"
func _ready() -> void:
	#load_main_bar(auto_main_runtime.player_inventory)
	pass # Replace with function body.
	state_machine_UI = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("player_inventory"):
		if state_machine_UI <= 0:
			state_machine_UI = 1
			item_moving = blank_item
		else:
			state_machine_UI = 0
	if state_machine_UI >= 1:
		auto_main_runtime.global_is_gameplay_on = false
	else:
		auto_main_runtime.global_is_gameplay_on = true
	hide_all_item()
	if state_machine_UI == 0:
		$gameplay_bar.show()
		load_main_bar(auto_main_runtime.player_inventory)
	if state_machine_UI == 1:
		main_menu.show()
		main_menu_inventory.show()
		load_inventory(auto_main_runtime.player_inventory)
		$"main_menu/inventory/tiles/tile_-1".global_position = $"../system_mouse".global_position +  Vector2(-10,-5)
		$"main_menu/inventory/tiles/tile_-1".texture = load(auto_main_runtime.get_needed_texture(item_moving["type"]))
		if item_moving["type"] == "blank":
			$"main_menu/inventory/tiles/tile_-1".get_children()[0].Number = 0
		else:
			$"main_menu/inventory/tiles/tile_-1".get_children()[0].Number = item_moving["num"]
		if $main_menu/delete/Area2D.overlaps_area($"../system_mouse/Area2D"):
			if Input.is_action_just_pressed("player_left_click"):
				state_machine_UI = 0
		if $main_menu/delete_obj/Area2D.overlaps_area($"../system_mouse/Area2D"):
			if Input.is_action_just_pressed("player_left_click"):
				item_moving = blank_item
	#print(item_moving)


func hide_all_item():
	$gameplay_bar.hide()
	main_menu.hide()
	main_menu_inventory.hide()

func load_inventory(data):
	for i in range(30):
		var tile_path = "main_menu/inventory/tiles/tile" + str(i)
		var current_obj = get_node(tile_path)
		current_obj.texture = load(auto_main_runtime.get_needed_texture(data[i]["type"]))
		if data[i]["type"] == "blank":
			current_obj.get_children()[1].Number = 0
		else:
			current_obj.get_children()[1].Number = data[i]["num"]
		tile_path = "main_menu/inventory/tiles/tile" + str(i) + "/Area2D"
		current_obj = get_node(tile_path)
		if current_obj.overlaps_area($"../system_mouse/Area2D"):
			#print(item_moving)
			if Input.is_action_just_pressed("player_left_click"):
				#print("Item moving is: ",item_moving)
				if item_moving["type"] == "blank":
					#print("1:item_moving[type] == blank")
					
					if not data[i]["type"] == "blank":
						item_moving = data[i]
						data[i] = blank_item
				elif item_moving["type"] == data[i]["type"] and not data[i]["type"] == "blank":
					#print("2:item_moving[type] == data[i][type] and not data[i][type] == blank and can_action")
					data[i]["num"] = str(int(data[i]["num"]) + int(item_moving["num"]))
					item_moving = blank_item
				else:
					#print("3:else: item_moving[type] == blank")
					var echange = data[i]
					data[i] = item_moving
					item_moving = echange
			if Input.is_action_just_pressed("player_right_click"):
				if item_moving == blank_item and not data[i] == blank_item:
					var change = data[i]["type"]
					var num = data[i]["num"]
					data[i]["num"] = str(int(data[i]["num"]) -1)
					item_moving = {"type": change, "num": "1"}
					#data[i] = blank_item
					auto_main_runtime.player_inventory = data
					#print("item_moving == blank_item and not data[i] == blank_item")
					#breakpoint
				elif item_moving["type"] ==data[i]["type"] and not data[i] == blank_item:
					var change = data[i]["type"]
					var num = data[i]["num"]
					data[i]["num"] = str(int(data[i]["num"]) -1)
					item_moving["num"] = str(int(item_moving["num"]) +1)
					auto_main_runtime.player_inventory = data
				pass
			auto_main_runtime.player_inventory = data
		
		if int(auto_main_runtime.player_inventory[i]["num"]) <= 0:
			auto_main_runtime.player_inventory[i] = blank_item
		if int(item_moving["num"]) <= 0:
			item_moving["num"] = "1"

func load_main_bar(data):
	change_bar_from_key()
	for i in range(10):
		var item = what_inventory_tile_change(i-4)
		var obj_icon = item.get_children()[0]
		#print(i," : ",selected_item," : ",item)
		
		item.get_children()[3].Number = data[i]["num"]
		if  i < len(data):
			obj_icon.texture = load(auto_main_runtime.get_needed_texture(data[i]["type"]))
		else:
			obj_icon.texture = load("res://design/UI/selected/ui_box0.png")
		if item.get_children()[1].overlaps_area($"../system_mouse/Area2D"):
			if Input.get_action_raw_strength("player_left_click") >= 1:
				selected_item = i
			
		if i == selected_item:
			item.texture = load(selected_texture)
			
			auto_main_runtime.current_player_item = data[i]
			
			#print("item:",selected_item)
		else:
			item.texture = load(unselected_texture)

func change_bar_from_key():
	if Input.get_action_raw_strength("key_1") >= 1:
		selected_item = 0
	if Input.get_action_raw_strength("key_2") >= 1:
		selected_item = 1
	if Input.get_action_raw_strength("key_3") >= 1:
		selected_item = 2
	if Input.get_action_raw_strength("key_4") >= 1:
		selected_item = 3
	if Input.get_action_raw_strength("key_5") >= 1:
		selected_item = 4
	if Input.get_action_raw_strength("key_6") >= 1:
		selected_item = 5
	if Input.get_action_raw_strength("key_7") >= 1:
		selected_item = 6
	if Input.get_action_raw_strength("key_8") >= 1:
		selected_item = 7
	if Input.get_action_raw_strength("key_9") >= 1:
		selected_item = 8
	if Input.get_action_raw_strength("key_0") >= 1:
		selected_item = 9

func what_inventory_tile_change(num):
	if num == -4:
		return box_obj_4
	if num == -3:
		return box_obj_3
	if num == -2:
		return box_obj_2
	if num == -1:
		return box_obj_1
	if num == 0:
		return box_obj0
	if num == 1:
		return box_obj1
	if num == 2:
		return box_obj2
	if num == 3:
		return box_obj3
	if num == 4:
		return box_obj4
	if num == 5:
		return box_obj5
	return null
