extends Node


# res://scenes/pipes/pipes.tscn
const PIPES = preload("uid://h8mdkwmshi23")


@onready var pipes_holder: Node = $PipesHolder
@onready var upper_spawn: Marker2D = $UpperSpawn
@onready var lower_spawn: Marker2D = $LowerSpawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_pipes()
	

func _on_spawn_timer_timeout() -> void:
	spawn_pipes()


func spawn_pipes() -> void:
	var new_pipes = PIPES.instantiate()
	var y_position = randf_range(
		upper_spawn.global_position.y, 
		lower_spawn.global_position.y
	)
	new_pipes.global_position = Vector2(
		upper_spawn.global_position.x, 
		y_position
	)
	pipes_holder.add_child(new_pipes)
