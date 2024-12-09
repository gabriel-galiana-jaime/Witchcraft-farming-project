extends Node2D

@onready var sprite_test = $"../cursor"
@onready var editable_tiles = $editable_tiles/TileMapLayer_2
@onready var ref_player = $"../Player_Obj"
@onready var ref_mouse_pos = $"../mouse/Sprite2D"
@onready var ref_Camera : Camera2D = $"../Camera2D"



var position_sprite : Vector2 = Vector2(10,10)
var current_game : JSON
var current_data

#Camera_offsets:
var camera_offsets : Vector4 = Vector4(0,0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_test.position = position_sprite * 16
	# Standard
# Static
	Input.set_mouse_mode(1)
	#current_game =  JSON.parse_string(str(test_1))
	pass # Replace with function body.
	var file_path = "res://assets/ressources/jsons/save/current_game_file.json"
	load_world_data("farm",auto_file_system.open_file_as_json(file_path))
	load_world_setting("farm",auto_file_system.open_file_as_json(file_path))
	  # Change this to match your TileMap's cell size
	
var id_object : int = 0
"""
-585
-55
540
450
"""

func load_world_setting(map_section,data):
	data = data["map"][map_section]
	#Camera: left,right,up,down
	camera_offsets = Vector4(data["camera"]["offset_x_-"],data["camera"]["offset_x_+"],data["camera"]["offset_y_-"],data["camera"]["offset_y_+"])
	#print("Camera data is: ","Offset:",camera_offsets)
	#end camera


func load_world_data(map_section,data):
	data = data["map"][map_section]
	print(len(data["objects"]))
	for i in range(len(data["objects"])):
		#print(i)
		id_object = i
		current_data = data["objects"]["obj"+str(i)]
		var obj_spawn = auto_preload.check_what_object_must_be_cloned(data["objects"]["obj"+str(i)]["type"])
		print("spawn: ",obj_spawn)
		add_child(obj_spawn.instantiate())
	#add_child(auto_preload.check_what_object_must_be_cloned(data["objects"]["obj"+str(1)]["type"]))
	pass


func round_to_multiple_of_16(number: float):
	return int(round(number / 18) * 18)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ref_Camera.position = ref_player.position
	runtime_camera()
	#print(ref_Camera.position)
	pass
	#print("The object position ", object_position, " rounded to the nearest tile position is: ", rounded_position)

func runtime_camera():
	if ref_Camera.position.x <= camera_offsets.x:
		ref_Camera.position.x = camera_offsets.x
	if ref_Camera.position.x >= camera_offsets.y:
		ref_Camera.position.x = camera_offsets.y
	if ref_Camera.position.y >= camera_offsets.z:
		ref_Camera.position.y = camera_offsets.z
		pass
	if ref_Camera.position.y <= camera_offsets.w:
		ref_Camera.position.y = camera_offsets.w
		pass
