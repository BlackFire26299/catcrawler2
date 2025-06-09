class_name Quest
extends Resource

@export var name: String
@export var description: String
@export var objectives: Array[String] = []
var current_objective_index: int = 0
var is_complete: bool = false

func get_current_objective() -> String:
	if current_objective_index < objectives.size():
		return objectives[current_objective_index]
	return ""

var objective_progress: Dictionary = {}

func update_progress(key: String, amount: int = 1) -> bool:
	if current_objective_index >= objectives.size():
		return false
		
	if not objective_progress.has(key):
		objective_progress[key] = 0
		
	objective_progress[key] += amount
	return true

func get_progress(key: String) -> int:
	return objective_progress.get(key, 0)
