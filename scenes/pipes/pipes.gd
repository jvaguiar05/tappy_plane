extends Node2D


class_name Pipes


@onready var score_sound: AudioStreamPlayer = $ScoreSound


@export var speed: float = 120.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Move pipes from right to left
	position.x -= speed * delta


func _on_screen_notifier_screen_exited() -> void:
	queue_free()


# Fallback: If the event is not triggered, the timer forces the removal of the pipes
func _on_life_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is TappyPlane:
		body.die()


func _on_laser_body_exited(body: Node2D) -> void:
	if body is TappyPlane:
		score_sound.play()
