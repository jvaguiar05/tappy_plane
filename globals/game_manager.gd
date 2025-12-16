extends Node


# res://scenes/main/main.tscn
const MAIN = preload("uid://dog4mv1bwmrsy")
# res://scenes/game/game.tscn
const GAME = preload("uid://bim7igp3koklm")
# res://scenes/changes/simple_change.tscn
const SIMPLE_CHANGE = preload("uid://b6gs0y7l2gbcj")


var next_scene: PackedScene


func change_to_next() -> void:
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)


func load_main_scene() -> void:
	next_scene = MAIN
	get_tree().change_scene_to_packed(SIMPLE_CHANGE)


func load_game_scene() -> void:
	next_scene = GAME
	get_tree().change_scene_to_packed(SIMPLE_CHANGE)
