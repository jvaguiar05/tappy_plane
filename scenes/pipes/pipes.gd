extends Node2D


class_name Pipes


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
