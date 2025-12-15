extends Node


# res://scenes/main/main.tscn
const MAIN = preload("uid://dog4mv1bwmrsy")
# res://scenes/game/game.tscn
const GAME = preload("uid://bim7igp3koklm")


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)


func load_game_scene() -> void:
	get_tree().change_scene_to_packed(GAME)
