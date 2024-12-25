extends StaticBody2D

var world_controller : Node2D
var data : Dictionary
var ID
var index_position : Vector2 = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world_controller = $world_prefab
	data = get_parent().get_parent().current_data
	position = Vector2(data["posx"],data["posy"]) * 16
	index_position = Vector2(data["posx"],data["posy"]) 
	position += Vector2(8,8)
	ID = get_parent().get_parent().id_object
	print(data," : ", " my id is: ",ID)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if auto_main_runtime.global_is_gameplay_on == false:
		return
	if index_position == auto_main_runtime.global_cursor_position:
		if auto_utilities.get_distance(position,auto_main_runtime.global_player_position) <= 20:
			print(auto_utilities.get_distance(position,auto_main_runtime.global_player_position))
			if Input.get_action_raw_strength("player_left_click") >= 1:
				if auto_main_runtime.current_player_item["type"] == "axe":
					queue_free()
	pass
