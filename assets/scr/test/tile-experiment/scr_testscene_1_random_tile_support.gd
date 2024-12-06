extends Node2D

@onready var tile_ob = $TileMapLayer
@export var new_tile_set_to_edit : TileSet
var input_vec
@onready var cam_ = $Camera2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set_cell(coords: Vector2i, source_id: int = -1, atlas_coords: Vector2i = Vector2i(-1, -1), alternative_tile: int = 0)
	for e in range(10):
		tile_ob.set_cell(Vector2i(e,0), 0,Vector2i(1, 1))
	#print(new_tile_set_to_edit.get_source_id())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	input_update()
	movement(delta)
	



func input_update():
	input_vec = Vector2(floor(Input.get_action_raw_strength("player_right"))- floor(Input.get_action_raw_strength("player_left")),floor(Input.get_action_raw_strength("player_down"))- floor(Input.get_action_raw_strength("player_up")))
	#print(input_vec)
func movement(delta):
	var movement_player = round(input_vec) * round(500)
	cam_.position += movement_player  * delta
	pass
