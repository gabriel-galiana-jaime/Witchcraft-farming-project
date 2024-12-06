extends Node

#Objects

var test_obj1 = preload("res://assets/scenes/preloads/object/nps_testobj1.tscn")
var rock1 = preload("res://assets/scenes/preloads/object/mining/nps_rock.tscn")
func check_what_object_must_be_cloned(type):
	if type == "testobj1":
		return test_obj1
	if type == "rock1":
		return rock1
