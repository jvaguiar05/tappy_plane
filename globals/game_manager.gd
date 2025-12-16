extends Node


# res://scenes/main/main.tscn
const MAIN = preload("uid://dog4mv1bwmrsy")
# res://scenes/game/game.tscn
const GAME = preload("uid://bim7igp3koklm")
# res://scenes/transitions/complex_change.tscn
const COMPLEX_CHANGE = preload("uid://cuvqtqw0j27fg")


var next_scene: PackedScene
var cx: ComplexChange

func _ready() -> void:
	cx = COMPLEX_CHANGE.instantiate()
	add_child(cx)


func change_to_next() -> void:
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)


func start_transition(to_scene: PackedScene) -> void:
	next_scene = to_scene
	cx.play_animation()


func load_main_scene() -> void:
	start_transition(MAIN)


func load_game_scene() -> void:
	start_transition(GAME)
