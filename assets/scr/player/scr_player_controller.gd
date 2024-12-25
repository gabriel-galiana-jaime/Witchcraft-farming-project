extends CharacterBody2D

var input_vec : Vector2 = Vector2(0,0)
var player_speed = 3000

var current_tile
@onready var animation_sprite_ref = $AnimatedSprite2D
var can_move : bool = true
var current_player_item : Dictionary = {}
@onready var animation_tool = $AnimatedSprite2D2_tools
@onready var animation_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if auto_main_runtime.global_is_gameplay_on == false:
		return
	current_player_item = auto_main_runtime.current_player_item
	input_update()
	movement(delta)
	current_tile_()
	obj_actions(delta)
	if input_vec == Vector2(0,0):
		animation_sprite_ref.play("default")
	else:
		animation_sprite_ref.play("right")
	if input_vec.x >= 1:
		animation_sprite_ref.flip_h = false
	if input_vec.x <= -1:
		animation_sprite_ref.flip_h = true
	pass

func obj_actions(delta):
	can_move = true
	animation_tool.show()
	if Input.get_action_raw_strength("player_left_click") >= 1:
		animation_tool.flip_h = true
		var look = "right"
		if animation_sprite_ref.flip_h == true:
			animation_tool.flip_v = true
			look = "left"
		else:
			animation_tool.flip_v = false
			look = "right"
		if current_player_item["type"] == "axe":
			can_move = false
			animation_tool.play("axe",1)
			animation_player.play("axe_"+look)
		if current_player_item["type"] == "hacke":
			can_move = false
			animation_tool.play("hacke",1)
			animation_player.play("axe_" + look)
	else:
		animation_tool.stop()
		animation_tool.hide()
		animation_player.stop()


func input_update():
	input_vec = Vector2(floor(Input.get_action_raw_strength("player_right"))- floor(Input.get_action_raw_strength("player_left")),floor(Input.get_action_raw_strength("player_down"))- floor(Input.get_action_raw_strength("player_up")))
	#print(input_vec)

func current_tile_():
	var tilepattern : TileMapPattern
	#$"../world_prefab/player_select_tiles".set_cell(global_position,0,Vector2i(3,11))
	var tile_pos : Vector2i = Vector2i(3,4)
	var tile_id
	#print(tile_id)
	#tile_ob.set_cell(Vector2i(e,0), 0,Vector2i(1, 1))
	#print(current_tile)
	pass

func movement(delta):
	if can_move == true:
		var movement_player = round(input_vec) * round(player_speed)
		velocity = movement_player  * delta
		move_and_slide()
		auto_main_runtime.global_player_position = position
	pass
