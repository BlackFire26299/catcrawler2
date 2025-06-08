extends Node

# List of current quests
var active_quests: Array[String] = []

# Completed quests
var completed_quests: Array[String] = []

func add_quest(quest_name: String):
	if quest_name not in active_quests and quest_name not in completed_quests:
		active_quests.append(quest_name)

func complete_quest(quest_name: String):
	if quest_name in active_quests:
		active_quests.erase(quest_name)
		completed_quests.append(quest_name)

func get_active_quests() -> Array[String]:
	return active_quests
