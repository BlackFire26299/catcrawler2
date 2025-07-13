extends Node2D

@onready var interact = $InteractionArea # Creates refrence to interation area node
@onready var player: Player = get_tree().get_first_node_in_group("player") # Gets the play 

signal trash_pile_interacted() # signals other nodes that this fire has been distroyed

func _ready():
	interact.interact = Callable(self, "on_interact") # Connects the area interact function to the one below
	
func on_interact():
	emit_signal("trash_pile_interacted") # emits the above signal
	self.queue_free() # Delete the node
