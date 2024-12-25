extends Node

func get_rounded_direction(v1: Vector2, v2: Vector2) -> Array:
	var dx = v2.x - v1.x
	var dy = v2.y - v1.y
	# Calculate the angle in radians and convert to degrees
	var angle = atan2(dy, dx) * 180.0 / PI
	# Normalize the angle to [0, 360) range
	if angle < 0:
		angle += 360
	# Round the angle to the nearest 45 degrees
	var rounded_angle = round(angle / 45) * 45
	var rounded_angle_int = int(rounded_angle)
	# Map the rounded angle to a direction
	var direction_map = {
		0: "E",
		45: "NE",
		90: "N",
		135: "NW",
		180: "W",
		225: "SW",
		270: "S",
		315: "SE"}
	var return_vector : Vector2 = Vector2(0,0)
	var item = rounded_angle_int % 360
	print(direction_map[rounded_angle_int % 360])
	if direction_map[item] == "N":
		return_vector = Vector2(0,1)
	if direction_map[item] == "NE":
		return_vector = Vector2(1,1)
	if direction_map[item] == "E":
		return_vector = Vector2(1,0)
	if direction_map[item] == "SE":
		return_vector = Vector2(1,-1)
	if direction_map[item] == "S":
		return_vector = Vector2(0,-1)
	if direction_map[item] == "SW":
		return_vector = Vector2(-1,-1)
	if direction_map[item] == "W":
		return_vector = Vector2(-1,0)
	if direction_map[item] == "NW":
		return_vector = Vector2(-1,1)
	return [rounded_angle_int % 360,direction_map[rounded_angle_int % 360],return_vector]


func round_to_tilemap_position(position: Vector2, tile_size: int) -> Vector2:
	var rounded_x = int(round(position.x / tile_size) * tile_size)
	var rounded_y = int(round(position.y / tile_size) * tile_size)
	return Vector2(rounded_x, rounded_y)


func get_distance(point1: Vector2, point2: Vector2) -> float:
	return point1.distance_to(point2)
