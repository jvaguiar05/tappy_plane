extends Node


# .res for binary, .tres for plaintext
const SCORES_PATH := "user://tappyscore.res"


var high_score := 0:
	get: return high_score
	set(value): 
		if value > high_score:
			high_score = value
			save_high_score()


func _ready() -> void:
	load_high_score()


func load_high_score() -> void:
	if ResourceLoader.exists(SCORES_PATH):
		var hsr := load(SCORES_PATH)
		if hsr: high_score = hsr.high_score


func save_high_score() -> void:
	var hsr := HighScoreResource.new()
	hsr.high_score = high_score
	ResourceSaver.save(hsr, SCORES_PATH)
