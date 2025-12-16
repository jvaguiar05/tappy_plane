extends Node


var high_score := 0:
	get: return high_score
	set(value): 
		if value > high_score:
			high_score = value
