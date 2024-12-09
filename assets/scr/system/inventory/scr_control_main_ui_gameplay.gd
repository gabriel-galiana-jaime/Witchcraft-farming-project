extends Node2D

@onready var box_obj_4 = $"gameplay_bar/box_obj-4"
@onready var box_obj_3 = $"gameplay_bar/box_obj-3"
@onready var box_obj_2 = $"gameplay_bar/box_obj-2"
@onready var box_obj_1 = $"gameplay_bar/box_obj-1"
@onready var box_obj0 = $gameplay_bar/box_obj0
@onready var box_obj1 = $"gameplay_bar/box_obj-1"
@onready var box_obj2 = $gameplay_bar/box_obj2
@onready var box_obj3 = $gameplay_bar/box_obj3
@onready var box_obj4 = $gameplay_bar/box_obj4
@onready var box_obj5 = $gameplay_bar/box_obj5
var unselected_texture : String = "res://design/UI/selected/ui_box1.png"
var selected_texture : String = "res://design/UI/selected/ui_box2.png"
var selected_item = 1
# Called when the node enters the scene tree for the first time.$"gameplay_bar/box_obj-4/icon"
func _ready() -> void:
	load_main_bar(auto_main_runtime.player_inventory)
	pass # Replace with function body.

func load_main_bar(data):
	for i in range(10):
		var item = what_inventory_tile_change(i-4)
		var obj_icon = item.get_children()[0]
		#print(i,selected_item)
		if  i < len(data):
			obj_icon.texture = load(auto_main_runtime.get_needed_texture(data[i]["type"]))
		else:
			obj_icon.texture = load("res://design/UI/selected/ui_box0.png")
		if i == selected_item:
			item.texture = load(selected_texture)
			#print("item:",selected_item)
		else:
			item.texture = load(unselected_texture)
		if item.get_children()[1].overlaps_area($"../system_mouse/Area2D"):
			if Input.get_action_raw_strength("player_left_click") >= 1:
				selected_item = i
			pass
	pass
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var data = auto_main_runtime.player_inventory
	load_main_bar(data)
