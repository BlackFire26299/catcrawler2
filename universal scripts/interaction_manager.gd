extends Node2D

@onready var player = get_tree().get_first_node_in_group("player") # Gets a player refrence in the tree
@onready var label = $Label # Creates a new label (to display the interaction text)
 
const base_text = "[E] to " # base text for label

var active_areas = [] # list of active interactable areas
var can_interact = true # that you can interact

func register_area(area: InteractionArea): # Adds interaction area to the list of active areas
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea): # Removes interaction area from the list of active areas
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name # Chnages the label to include the full ([E] to bla bla)
		label.global_position = active_areas[0].global_position #plases it near the interaction area
		#label.global_position.y -= 20
		#label.global_position.x -= label.size.x / 2
		label.show() #shows the label
	else:
		label.hide() # if not close to the a interactable area or already interacted with it

func _sort_by_distance_to_player(area1, area2): # softs the areas in the active area list to go from closest to furthest (from the player)
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

func _input(event):
	if event.is_action_pressed("interact") && can_interact: 
		if active_areas.size() > 0: #only runs if the active areas has something in it
			can_interact = false
			label.hide() # once used hide label
			
			await active_areas[0].interact.call() # Calls the interact func on the active area
			
			can_interact = true #Resets can interact
