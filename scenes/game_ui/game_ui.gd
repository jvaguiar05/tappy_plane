extends Control


class_name GameUI


@onready var game_over_label: Label = $MarginContainer/GameOverLabel
@onready var press_space_label: Label = $MarginContainer/PressSpaceLabel
@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer = $Sound


func _ready() -> void:
	SignalHub.on_plane_died.connect(on_plane_died)

func on_plane_died() -> void:
	game_over_label.show()
	sound.play()
	timer.start()


func _on_timer_timeout() -> void:
	game_over_label.hide()
	press_space_label.show()


func _unhandled_input(event: InputEvent) -> void:
	if press_space_label.visible and event.is_action_pressed("power"):
		GameManager.load_main_scene()
