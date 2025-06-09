extends Node2D

var lilyOrder = []

@onready var single_lily: InteractionArea = $"single lily"
@onready var double_lily: InteractionArea = $"double lily"
signal waterPuzzle
@onready var single_light = $"single lily/PointLight2D"
@onready var double_light = $"double lily/PointLight2D"
@onready var error_light = $PointLight2D

func _ready():
	single_lily.interact = Callable(self, "on_interact_s")
	double_lily.interact = Callable(self, "on_interact_d")
	

	
func on_interact_s():
	lilyOrder.append("s")
	if lilyOrder.size() == 5:
		checkOrder()
		
	single_light.show()
	await get_tree().create_timer(0.5).timeout
	single_light.hide()
	
func on_interact_d():
	lilyOrder.append("d")
	if lilyOrder.size() == 5:
		checkOrder()
		
	double_light.show()
	await get_tree().create_timer(0.5).timeout
	double_light.hide()
		
func checkOrder():
	if lilyOrder == ["s","d","s","d","d"]:
		emit_signal("waterPuzzle")
	else:
		lilyOrder = []
		error_light.show()
		await get_tree().create_timer(0.25).timeout
		error_light.hide()
