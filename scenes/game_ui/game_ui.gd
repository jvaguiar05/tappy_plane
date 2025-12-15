extends Control


class_name GameUI


@onready var game_over_label: Label = $MarginContainer/GameOverLabel


func _ready() -> void:
	SignalHub.on_plane_died.connect(on_plane_died)


func on_plane_died() -> void:
	game_over_label.show()
