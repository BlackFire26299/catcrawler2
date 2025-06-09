extends AnimatedSprite2D

@onready var interact = $interaction_area
@onready var player: Player = get_tree().get_first_node_in_group("player")

func _ready():
	interact.interact = Callable(self, "on_interact")
	
func on_interact():
	player.num_fires_snuffed += 1
	player.check_snuffed_fires()
	
	self.queue_free()
