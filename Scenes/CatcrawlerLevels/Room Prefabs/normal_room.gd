class_name NormalRoom
extends Room

@export var type: GlobalEnums.RoomType 
@export var minNumDirt: int = 2
@export var maxNumDirt: int = 6

@export var minEnemies: int
@export var maxEnemies: int

@onready var spawnPointparent = $ObjectSpawns

var dirtpile = preload("res://Objects/trash_pile.tscn")

var rng = RandomNumberGenerator.new()

var seenRoom = false

func spawnRoomObjects():
	var spawnpoints = spawnPointparent.get_children()
	var rngNumOfObjects = randi_range(minNumDirt,maxNumDirt)
	for object in rngNumOfObjects:
		var spawnindex = randi() % spawnpoints.size()
		var rngChild = spawnpoints[spawnindex]
		var pile = dirtpile.instantiate()
		rngChild.add_child(pile)

func spawnRoomEnemies():
	if !seenRoom:
		seenRoom = true
		pass
