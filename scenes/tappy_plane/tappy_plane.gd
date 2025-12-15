extends CharacterBody2D


class_name TappyPlane


const JUMP_POWER := -400.0


@onready var plane_sprite: AnimatedSprite2D = $PlaneSprite


# Retrieving the gravity from the default system value
var _gravity: float = ProjectSettings.get("physics/2d/default_gravity")
var _jumped := false


# Stop physics processing, stop plane animation, etc.
func die() -> void:
	get_tree().paused = true
	print("Game Over!")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("power"):
		_jumped = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta

	if _jumped:
		velocity.y = JUMP_POWER
		_jumped = false

	move_and_slide()

	if is_on_floor():
		die()
