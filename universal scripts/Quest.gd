class_name Quest
extends Resource

@export var name: String #Stores the name of the quest to be displayed
@export var description: String #Description of quest i was going to show this but it isn't really used
@export var objectives: Array[String] = [] # List of all objectives within the quests
var current_objective_index: int = 0 # the current object (starts at 0)
var is_complete: bool = false # If the quest is completed

func get_current_objective() -> String:
	if current_objective_index < objectives.size():  # gets the objective at the current index
		return objectives[current_objective_index]
	return ""

var objective_progress: Dictionary = {} #Dictionary to store the objectives and if they are completed

func update_progress(key: String, amount: int = 1) -> bool:
	if current_objective_index >= objectives.size():
		return false 
		
	if not objective_progress.has(key):
		objective_progress[key] = 0
		
	objective_progress[key] += amount
	return true

func get_progress(key: String) -> int:
	return objective_progress.get(key, 0) 
