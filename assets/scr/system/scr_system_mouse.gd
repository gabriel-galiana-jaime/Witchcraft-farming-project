extends Sprite2D

var ofset_mouse : Vector2 = Vector2(4,6)
@onready var ref_mouse_pos = $Sprite2D
var position_sprite : Vector2
@onready var world_controller : Node = $"../world_prefab"
@onready var ref_cursor : Sprite2D = $"../cursor"
@onready var test_cursor_player : Sprite2D = $"../testcursor_look"
@onready var ref_player : CharacterBody2D = $"../Player_Obj"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if auto_main_runtime.global_is_gameplay_on == true:
		ref_cursor.show()
	else:
		ref_cursor.hide()
	global_position = world_controller.get_local_mouse_position() + ofset_mouse
	#print(get_local_mouse_position())
	position_sprite = ref_mouse_pos.global_position
	
	
	var object_position = position_sprite
	var tile_size = 16
	var rounded_position = round_to_tilemap_position(object_position, tile_size)
	ref_cursor.position = rounded_position + Vector2(8,8)
	var vec_correct : Vector2 = Vector2(0,0)
	if round(ref_cursor.position.x/16) >= 0:
		vec_correct.x = -1
	else:
		vec_correct.x = 0
	if round(ref_cursor.position.y/16) >= 0:
		vec_correct.y = -1
	else:
		vec_correct.y = 0
	#print(abs(ref_cursor.position) - abs(ref_player.position)," : ",ref_cursor.global_position)
	#print(auto_utilities.get_rounded_direction(position,ref_player.position))
	if abs(ref_cursor.position).x - abs(ref_player.position).x >= 20:
		#ref_cursor.global_position.x = round_to_tilemap_position(Vector2(20,ref_cursor.position.y),16).x
		pass
	#print(round(ref_cursor.position/16)+vec_correct)
	auto_main_runtime.global_cursor_position = round(ref_cursor.position/16)+vec_correct
	
	#test_cursor_player.global_position = auto_main_runtime.global_cursor_position * 16 + Vector2(8,8)
	
	#print(test_cursor_player.global_position-ref_player.global_position)
	#ref_cursor.position = ref_player.position + ( 20 * auto_utilities.get_rounded_direction(ref_player.position,position)[2])
	#ref_cursor.position = round_to_tilemap_position(ref_cursor.position,16) + Vector2(8,8)


func round_to_tilemap_position(position: Vector2, tile_size: int) -> Vector2:
	var rounded_x = int(round(position.x / tile_size) * tile_size)
	var rounded_y = int(round(position.y / tile_size) * tile_size)
	return Vector2(rounded_x, rounded_y)
