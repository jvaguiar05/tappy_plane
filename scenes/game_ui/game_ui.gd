extends Control


class_name GameUI


@onready var game_over_label: Label = $MarginContainer/GameOverLabel


func on_plane_died() -> void:
	game_over_label.show()
