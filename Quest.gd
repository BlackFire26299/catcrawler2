class_name Quest
extends Resource

var name: String
var description: String
var objectives: Array[String] = []
var current_objective_index: int = 0
var is_complete: bool = false

func get_current_objective() -> String:
	if current_objective_index < objectives.size():
		return objectives[current_objective_index]
	else:
		return ""
