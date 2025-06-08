extends Node2D

# Create a quest
var fire_quest = Quest.new()

func _ready():
	fire_quest.name = "Embers in the Roots"
	fire_quest.description = "Save the burning grove"
	fire_quest.objectives.append("Redirect the nearby stream")
	fire_quest.objectives.append("Activate the ancient ward node")

	# Add to manager
	QuestManager.add_quest(fire_quest)

	# Advance quest (would normally be called by game events)
	QuestManager.advance_quest_objective(fire_quest)
