extends Control


class_name GameUI


@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var game_over_label: Label = $MarginContainer/GameOverLabel
@onready var press_space_label: Label = $MarginContainer/PressSpaceLabel
@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer = $Sound


@export var _points := 0


func on_plane_died() -> void:
	game_over_label.show()
	sound.play()
	timer.start()
	ScoreManager.high_score = _points


func on_game_restart() -> void:
	reset_score()
	game_over_label.hide()
	press_space_label.hide()


func score_point() -> void:
	_points += 1
	_update_score_display()


func reset_score() -> void:
	_points = 0
	_update_score_display()


func on_point_scored() -> void:
	score_point()


func _update_score_display() -> void:
	score_label.text = "%03d" % _points


func _ready() -> void:
	SignalHub.on_plane_died.connect(on_plane_died)
	SignalHub.on_point_scored.connect(on_point_scored)
	_update_score_display()


func _on_timer_timeout() -> void:
	game_over_label.hide()
	press_space_label.show()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = false
		GameManager.load_main_scene()

	if press_space_label.visible and event.is_action_pressed("power"):
		get_tree().paused = false
		GameManager.load_main_scene()
