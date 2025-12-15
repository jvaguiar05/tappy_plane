extends Node2D

@export var speed: float = 120.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Move pipes from right to left
	global_position.x -= speed * delta


func _on_screen_notifier_screen_exited() -> void:
	print("Pipes exited screen - cleaning up")
	queue_free()
