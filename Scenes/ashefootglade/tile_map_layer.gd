extends TileMapLayer

@onready var interact = $interaction_area # Creat refrence to 

func _ready():
	interact.interact = Callable(self, "on_interact") #Allows this to be called from parent and also be overriden 

func on_interact():
	self.queue_free() # Deletes self on interact (overwriten by parent ot left same)
