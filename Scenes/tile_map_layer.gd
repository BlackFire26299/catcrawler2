extends TileMapLayer

@onready var interact = $interaction_area

func _ready():
	interact.interact = Callable(self, "on_interact")

func on_interact():
	self.queue_free()
