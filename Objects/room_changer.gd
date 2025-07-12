extends Node2D

@onready var interact = $InteractionArea
@onready var player: Player = get_tree().get_first_node_in_group("player")
@export var endpoint: Node2D

func _ready():
	interact.interact = Callable(self, "on_interact") # Connects the area interact function to the one below
	
func on_interact():
	player.global_position = endpoint.global_position
