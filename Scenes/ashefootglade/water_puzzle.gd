extends Node2D

var lilyOrder = [] #will store the order in which lilys are pressed

@onready var single_lily: InteractionArea = $"single lily"
@onready var double_lily: InteractionArea = $"double lily"
signal waterPuzzle # Creates a signal
@onready var single_light = $"single lily/PointLight2D"
@onready var double_light = $"double lily/PointLight2D"
@onready var error_light = $PointLight2D

@onready var successound = $"Success-340660"

func _ready():
	single_lily.interact = Callable(self, "on_interact_s")
	double_lily.interact = Callable(self, "on_interact_d")
	# connects the interact funcs from the area interact and allows them to be overwriten

	
func on_interact_s():
	lilyOrder.append("s")
	if lilyOrder.size() == 5: # If the size of the list is equal to 5
		checkOrder()
		
	single_light.show() # Shows the ligth when interacted with
	await get_tree().create_timer(0.5).timeout
	single_light.hide() # Hides light
	
func on_interact_d():
	lilyOrder.append("d")
	if lilyOrder.size() == 5: # checks if it is 5 
		checkOrder()
		
	double_light.show() # shows light
	await get_tree().create_timer(0.5).timeout
	double_light.hide() #hide light
		
func checkOrder():
	if lilyOrder == ["s","d","s","d","d"]: # if the order is equal to the correct order
		emit_signal("waterPuzzle") # send signal
		successound.play() #play success sound
	else:
		lilyOrder = [] # reset lily order
		error_light.show() # show error
		await get_tree().create_timer(0.25).timeout
		error_light.hide() #hdie error
