extends Sprite2D

var ofset_mouse : Vector2 = Vector2(4,6)
@onready var ref_mouse_pos = $Sprite2D
var position_sprite : Vector2
@onready var world_controller : Node = $"../world_prefab"
@onready var ref_cursor : Sprite2D = $"../cursor"
@onready var test_cursor_player : Sprite2D = $"../testcursor_look"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.adwwd


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
	#print(round(ref_cursor.position/16)+vec_correct)
	auto_main_runtime.global_cursor_position = round(ref_cursor.position/16)+vec_correct
	
	#test_cursor_player.global_position = auto_main_runtime.global_cursor_position * 16 + Vector2(8,8)
	
	#print(test_cursor_player.global_position-ref_player.global_position)


func round_to_tilemap_position(position: Vector2, tile_size: int) -> Vector2:
	var rounded_x = int(round(position.x / tile_size) * tile_size)
	var rounded_y = int(round(position.y / tile_size) * tile_size)
	return Vector2(rounded_x, rounded_y)
