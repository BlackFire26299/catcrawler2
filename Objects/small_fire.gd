extends AnimatedSprite2D

@onready var interact = $interaction_area # Creates refrence to interation area node
@onready var player: Player = get_tree().get_first_node_in_group("player") # Gets the play 

signal fire_snuffed() # signals other nodes that this fire has been distroyed

func _ready():
	interact.interact = Callable(self, "on_interact") # Connects the area interact function to the one below
	
func on_interact():
	player.num_fires_snuffed += 1 # adds one to the players count
	player.check_snuffed_fires() # checks if the play has destroyed all the required fires
	emit_signal("fire_snuffed") # emits the above signal
	self.queue_free() # Delete the node
