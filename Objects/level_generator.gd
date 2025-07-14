class_name LevelGenerator
extends Node2D

@onready var roomScene = preload("res://Scenes/CatcrawlerLevels/Room Prefabs/normal_room.tscn")

@onready var roomChnager = preload("res://Objects/room_changer.tscn")

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

			var room_pos = Vector2(x * 3000, y * 2000)
			roomInstance.position = room_pos

			roomInstance.spawnRoomObjects()

			var directions = {
				"left": Vector2(-1, 0),
				"right": Vector2(1, 0),
				"up": Vector2(0, -1),
				"down": Vector2(0, 1),
			}

			for dir_name in directions.keys():
				var offset = directions[dir_name]
				var nx = x + int(offset.x)
				var ny = y + int(offset.y)

				# Check map bounds
				if nx >= 0 and nx < mapWidth and ny >= 0 and ny < mapHeight:
					var door = roomChnager.instantiate()
					roomInstance.add_child(door)

					# Position the door on this room's edge
					var door_pos = Vector2.ZERO

					match dir_name:
						"left":
							door_pos = Vector2(-500, 0)
						"right":
							door_pos = Vector2(500, 0)
						"up":
							door_pos = Vector2(0, -250)
						"down":
							door_pos = Vector2(0, 250)

					door.position = door_pos

					# Create the endpoint node and set its global position
					var endpoint = Node2D.new()
					add_child(endpoint)  # Important: endpoint must be global, not child of the room
					endpoint.global_position = room_pos + offset * Vector2(3000, 2000)

					door.endpoint = endpoint
