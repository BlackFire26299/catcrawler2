extends Node2D

# Create a quest
var awaken = Quest.new() # First quest
var scout = Quest.new() # Second quest
var followTrail = Quest.new() #third quest
var trial = Quest.new() #last quest
var sideQ = Quest.new() #side quest

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
	scout.objectives.append("Scout the area near the cave")
	scout.objectives.append("Explore the south of the cave")
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
	trial.objectives.append("check the entrace to the inner grove")
	trial.objectives.append("Enter the old grove")
	trial.objectives.append("confront the ork beastmaster")
	trial.objectives.append("Defeat the ork beastmaster")
	
	#side quest
	sideQ.name = "Why not put them out"
	sideQ.description = "Put out the orks campfires"
	sideQ.objectives.append("1 fire extinguished")
	sideQ.objectives.append("2 fire extinguished")
	sideQ.objectives.append("3 fire extinguished")
	sideQ.objectives.append("4 fire extinguished")
	sideQ.objectives.append("Try new abilitie (middle mouse button)")
	
	# Add the first quest to manager
	QuestManager.add_quest(awaken) # adds the first quest to the active quests


func _on_navigate_area_area_entered(area):
	# Progresses the quest when the area is entered
	QuestManager.advance_quest_objective(awaken)
	$"../tutorialsections/Navigate area".queue_free() #deletes the node

func _on_firstcombat_area_entered(area):
	# Progresses the quest when the area is entered
	QuestManager.advance_quest_objective(awaken)
	$"../tutorialsections/firstcombat".queue_free() #deletes the node

var awaken_num_orks = 3 # sets the number of orks in the training area

func _on_pack_1_child_exiting_tree(node):
	# updates when a ork in the trial area is deleted
	awaken_num_orks -= 1 #updates remaining orks
	if awaken_num_orks == 0:
		QuestManager.advance_quest_objective(awaken) # advances the quest


func _on_tile_map_layer_tree_exiting():
	#Progresses the quest when player destroys the rock infront of the cave
	QuestManager.advance_quest_objective(awaken)
	QuestManager.complete_quest(awaken)
	QuestManager.add_quest(scout) # Starts the next quest


func _on_near_cave_body_entered(body):
	if body is Player:
		# Checks if the player entered the area and updates quest
		QuestManager.advance_quest_objective(scout)
		$"../ScoutQuestAreas/nearCave".queue_free() #deletes the node


func _on_southof_cave_body_entered(body):
	if body is Player:
		QuestManager.advance_quest_objective(scout)
		$"../ScoutQuestAreas/southofCave".queue_free()#deletes the node

var ready_return_to_pond = false # if the player is able to return to pond and progress the quests

func _on_north_of_cave_body_entered(body):
	if body is Player:
		if QuestManager._has_quest("Scout the Grove"):
			# if in the scouting quest progress that and start th next section
			QuestManager.advance_quest_objective(scout)
			QuestManager.add_quest(followTrail)
		if ready_return_to_pond:
			# progresses the quest if the player has gone to the entrace
			QuestManager.advance_quest_objective(followTrail)
			$"../ScoutQuestAreas/NorthOfCave".queue_free() #deletes the node


func _on_entrance_body_entered(body):
	if body is Player:
		# Checks if the player entered the area and updates quest
		QuestManager.advance_quest_objective(followTrail)
		ready_return_to_pond = true


func _on_boss_entrance_tree_exited():
	# Checks if the player entered the area and updates quest
	QuestManager.advance_quest_objective(followTrail)
	
var usedLily = false # if the player has used the lilypads to progress
func _on_water_puzzle_water_puzzle():
	# Triggers when the player finished the puzzle
	if !usedLily:
		QuestManager.advance_quest_objective(followTrail)
		# Progres the quest
		usedLily = true
		QuestManager.add_quest(trial) #Start next quest

func _on_pastentrance_body_entered(body):	
	if body is Player:
		# Checks if the player entered the area and updates quest
		QuestManager.advance_quest_objective(trial)
		

var enteredBossarea = false

func _on_boss_area_body_entered(body):
	if body is Player && !enteredBossarea:
		# Checks if the player entered the area and updates quest
		QuestManager.advance_quest_objective(trial)
		enteredBossarea = true
		

var firstaggro = false
func _on_rider_boss_aggroed():
	# Triggered when the boss is aggroed 
	# Now i heal the boss when player dies i had to add a check thay this wasn't a second aggro
	if firstaggro == true:
		pass
	else:
		firstaggro = true
		QuestManager.advance_quest_objective(trial)
	


func _on_rider_boss_boss_died():
	# Advances quest when boss dies
	QuestManager.advance_quest_objective(trial)
	
func fire_snuffed():
	# Triggered when interact with campfires
	if QuestManager._has_quest("Why not put them out"):
		# Progresses quest
		QuestManager.advance_quest_objective(sideQ)
	else:
		QuestManager.add_quest(sideQ) #adds quest


func _on_small_fire_2_fire_snuffed():
	fire_snuffed()


func _on_small_fire_3_fire_snuffed():
	fire_snuffed()


func _on_small_fire_4_fire_snuffed():
	fire_snuffed()


func _on_small_fire_5_fire_snuffed():
	fire_snuffed()


func _on_small_fire_6_fire_snuffed():
	fire_snuffed()


func _on_small_fire_8_fire_snuffed():
	fire_snuffed()


func _on_small_fire_9_fire_snuffed():
	fire_snuffed()


func _on_small_fire_7_fire_snuffed():
	fire_snuffed()


func _on_small_fire_fire_snuffed():
	fire_snuffed()

var used_fireAtt = false
func _on_player_fire_attack():
	# Checks if the player has used their attack
	if !used_fireAtt:
		QuestManager.advance_quest_objective(sideQ)
		used_fireAtt = true
