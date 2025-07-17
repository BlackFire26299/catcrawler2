class_name RewardRoom
extends Room

@export var type: GlobalEnums.RoomType 
@export var minNumDirt: int = 1
@export var maxNumDirt: int = 4

@export var minEnemies: int
@export var maxEnemies: int

@onready var spawnPointparent = $ObjectSpawns

var dirtpile = preload("res://Objects/trash_pile.tscn")

var rng = RandomNumberGenerator.new()

@onready var seenArea = $SeenArea

func spawnRoomObjects():
	var spawnpoints = spawnPointparent.get_children()
	var rngNumOfObjects = randi_range(minNumDirt,maxNumDirt)
	for object in rngNumOfObjects:
		var spawnindex = randi() % spawnpoints.size()
		var rngChild = spawnpoints[spawnindex]
		var pile = dirtpile.instantiate()
		rngChild.add_child(pile)

func spawnRoomEnemies():
	pass
