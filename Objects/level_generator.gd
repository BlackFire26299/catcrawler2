class_name LevelGenerator
extends Node2D

@onready var roomScene = preload("res://Scenes/CatcrawlerLevels/Room Prefabs/normal_room.tscn")
@export var dirtPiles: DirtPile

@export var map: Array[GlobalEnums.RoomType] = [GlobalEnums.RoomType.normal,GlobalEnums.RoomType.normal,GlobalEnums.RoomType.normal,GlobalEnums.RoomType.normal]
@export var mapWidth: int = 2
@export var mapHeight: int = 2

var levelRooms = []

func _ready():
	if mapWidth * mapHeight != map.size():
		print("Map Width and map Height have to multiply to the length of the map array!!!!")
		print("this will result in a below error when generating")
		
	generateLevel()
	
func generateLevel():
	for y in mapHeight:
		for x in mapWidth:
			var index = y * mapWidth + x
			if index >= map.size():
				continue
			
			var roomData: GlobalEnums.RoomType = map[index]
			
			var roomInstance = roomScene.instantiate()
			add_child(roomInstance)
			
			roomInstance.position = Vector2(x * 5000, y * 5000)
			
			roomInstance.spawnRoomObjects()
