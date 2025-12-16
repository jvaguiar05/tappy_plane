extends CanvasLayer


class_name ComplexChange


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func play_animation() -> void:
	animation_player.play("fade")


func switch_scene() -> void:
	GameManager.change_to_next()
