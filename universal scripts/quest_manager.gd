extends Node

# List of current active quests
var active_quests: Array[Quest] = []

# List of completed quests
var completed_quests: Array[Quest] = []

signal quests_updated

func add_quest(quest: Quest):
	if not _has_quest(quest.name):
		active_quests.append(quest)
		print("Quest added: ", quest.name)
		quests_updated.emit()

func complete_quest(quest: Quest):
	if quest in active_quests:
		quest.is_complete = true
		active_quests.erase(quest)
		completed_quests.append(quest)
		print("Quest completed: ", quest.name)
		quests_updated.emit()

func advance_quest_objective(quest: Quest):
	if quest in active_quests:
		quest.current_objective_index += 1
		if quest.current_objective_index >= quest.objectives.size():
			complete_quest(quest)
		else:
			print("Advanced quest: ", quest.name, " → ", quest.get_current_objective())
			quests_updated.emit()

func get_active_quests() -> Array[Quest]:
	return active_quests

func get_quest_by_name(quest_name: String) -> Quest:
	for q in active_quests:
		if q.name == quest_name:
			return q
	for q in completed_quests:
		if q.name == quest_name:
			return q
	return null

func _has_quest(quest_name: String) -> bool:
	return get_quest_by_name(quest_name) != null
