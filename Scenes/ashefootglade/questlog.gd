extends Node2D

# Create a quest
var awaken = Quest.new()
var scout = Quest.new()
var followTrail = Quest.new()
var trial = Quest.new()

func _ready():
	# First Quest
	awaken.name = "Awaken in an Ashen cave"
	awaken.description = "You awake in a cave, the air is thick with smoke and the earth charred."
	awaken.objectives.append("Learn basic movement")
	awaken.objectives.append("Navigate through cave")
	awaken.objectives.append("Confront the ork camp.")
	awaken.objectives.append("Clear the exit.")
	
	# second quest
	scout.name = "Scout the Grove"
	scout.description = "Having exited the cave you find your self in a once sacred grove now taken by the ork scum."
	scout.objectives.append("Scout the area in the cave")
	scout.objectives.append("Explore the south of the grove")
	scout.objectives.append("Continue the search north east of the cave")
	
	#third quest
	followTrail.name = "The beastmasters trail"
	followTrail.description = "You have found the trail to the beastmaster, follow it!"
	followTrail.objectives.append("Find the entrace to the inner grove")
	followTrail.objectives.append("Return to the pond and find a way to put out the fire")
	followTrail.objectives.append("Hmmm those lily pads look intresting")
	followTrail.objectives.append("check the entrace to the inner grove")
	
	#boss
	trial.name = "Trial by flame"
	trial.description = "Defeat the ork beast master and save the grove"
	trial.objectives.append("Enter the old grove")
	trial.objectives.append("confront the ork beastmaster")
	trial.objectives.append("Defeat the ork beastmaster")
	
	# Add the first quest to manager
	QuestManager.add_quest(awaken)
