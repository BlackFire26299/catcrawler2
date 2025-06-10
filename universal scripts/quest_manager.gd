extends Node

# List of current active quests
var active_quests: Array[Quest] = [] # list of active quests

# List of completed quests
var completed_quests: Array[Quest] = [] #list of completed quests

signal quests_updated # signal for when a quest is updated (so the visual component can update)

func add_quest(quest: Quest):
	if not _has_quest(quest.name): # checks if the quest isn't already active
		active_quests.append(quest) # adds the quest to active questss
		print("Quest added: ", quest.name)
		quests_updated.emit() # sends signal

func complete_quest(quest: Quest):
	if quest in active_quests:  # Checks all quests
		quest.is_complete = true # sets it to completed
		active_quests.erase(quest) # removes it from active quests
		completed_quests.append(quest) # adds quest to completed quests
		print("Quest completed: ", quest.name)
		quests_updated.emit() # senf signal

func advance_quest_objective(quest: Quest):
	if quest in active_quests: # checks if the quest is in active quests
		quest.current_objective_index += 1 # chnages the current objective
		if quest.current_objective_index >= quest.objectives.size():
			complete_quest(quest) # if completed all objectives complete the quest
		else:
			print("Advanced quest: ", quest.name, " → ", quest.get_current_objective())
			quests_updated.emit() # send signal

func get_active_quests() -> Array[Quest]:
	return active_quests # Just returns active quest (helper func )

func get_quest_by_name(quest_name: String) -> Quest:
	for q in active_quests:
		if q.name == quest_name:
			return q
	for q in completed_quests:
		if q.name == quest_name:
			return q
	return null

func _has_quest(quest_name: String) -> bool: # just checks if the quest exists in the manager either in 
	return get_quest_by_name(quest_name) != null
