extends Node2D

var lilyOrder = []

@onready var single_lily: InteractionArea = $"single lily"
@onready var double_lily: InteractionArea = $"double lily"
signal waterPuzzle

func _ready():
	single_lily.interact = Callable(self, "on_interact_s")
	double_lily.interact = Callable(self, "on_interact_d")
	

	
func on_interact_s():
	lilyOrder.append("s")
	if lilyOrder.size() == 5:
		checkOrder()
	
func on_interact_d():
	lilyOrder.append("d")
	if lilyOrder.size() == 5:
		checkOrder()
		
func checkOrder():
	if lilyOrder == ["s","d","s","d","d"]:
		emit_signal("waterPuzzle")
	else:
		lilyOrder = []
