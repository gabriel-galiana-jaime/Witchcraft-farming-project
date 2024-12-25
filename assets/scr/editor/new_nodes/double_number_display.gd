extends Sprite2D

@export var Number : int = 87

# left 0, right
var main_path = "res://design/UI/selected/numbers/number"
var blank = "res://design/lore/village/Farm/Sprout Lands-Sprites-Basic pack/selected_sprite/Basic_tools_and_meterials0.png"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Number <= 1:
		texture = load(blank)
		$second_number.texture = load(blank)
		return
	if Number <= 0:
		Number = 0
	if Number >= 99:
		Number = 99
	var transform_num = str(round(Number))
	if Number >= 10:
		texture = load(main_path + transform_num[0] + ".png")
		$second_number.texture = load(main_path + transform_num[1] + ".png")
	else:
		texture = load(blank)
		$second_number.texture = load(main_path + transform_num[0] + ".png")
	pass
