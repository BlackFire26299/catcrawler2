class_name LevelGenerator
extends Node2D

@onready var roomScene = preload("res://Scenes/CatcrawlerLevels/Room Prefabs/normal_room.tscn")
@onready var roomChnager = preload("res://Objects/room_changer.tscn")

@export var dirtPiles: DirtPile
@export var map: Array[GlobalEnums.RoomType] = [GlobalEnums.RoomType.normal, GlobalEnums.RoomType.normal, GlobalEnums.RoomType.normal, GlobalEnums.RoomType.normal]
@export var mapWidth: int = 2
@export var mapHeight: int = 2

var levelRooms = []

func _ready():
	if mapWidth * mapHeight != map.size():
		print("Map Width and map Height have to multiply to the length of the map array!!!!")
		print("this will result in a below error when generating")
		
	generateLevel()
	
func generateLevel():
	var room_grid := []
	for i in mapHeight:
		room_grid.append([])

	# First pass: create and place rooms
	for y in mapHeight:
		for x in mapWidth:
			var index = y * mapWidth + x
			if index >= map.size():
				room_grid[y].append(null)
				continue

			var room_data = map[index]
			var room_instance = roomScene.instantiate()
			add_child(room_instance)

			var room_pos = Vector2(x * 3000, y * 2000)
			room_instance.position = room_pos
			room_instance.spawnRoomObjects()

			room_grid[y].append(room_instance)

	# Directions map
	var directions := {
		"left": Vector2(-1, 0),
		"right": Vector2(1, 0),
		"up": Vector2(0, -1),
		"down": Vector2(0, 1),
	}

	# Second pass: add doors
	for y in mapHeight:
		for x in mapWidth:
			var index = y * mapWidth + x
			if index >= map.size():
				continue

			var room_type = map[index]
			var current_room = room_grid[y][x]
			var current_pos = Vector2(x, y)

			if room_type == GlobalEnums.RoomType.normal:
				# Generate doors only to other normal rooms
				for dir_name in directions.keys():
					var offset = directions[dir_name]
					var nx = x + int(offset.x)
					var ny = y + int(offset.y)
					if nx < 0 or nx >= mapWidth or ny < 0 or ny >= mapHeight:
						continue

					var neighbor_index = ny * mapWidth + nx
					if neighbor_index >= map.size():
						continue

					var neighbor_type = map[neighbor_index]
					if neighbor_type != GlobalEnums.RoomType.normal:
						continue

					# Place door
					var door = roomChnager.instantiate()
					current_room.add_child(door)
					door.position = get_door_offset(dir_name)

					var endpoint = Node2D.new()
					add_child(endpoint)
					endpoint.global_position = current_room.global_position + offset * Vector2(3000, 2000)
					door.endpoint = endpoint

			elif room_type == GlobalEnums.RoomType.reward or room_type == GlobalEnums.RoomType.boss:
				# Only connect to one normal room
				var paired = false
				var dir_list := directions.keys()
				dir_list.shuffle()
				for dir_name in dir_list:
					if paired:
						break

					var offset = directions[dir_name]
					var nx = x + int(offset.x)
					var ny = y + int(offset.y)
					if nx < 0 or nx >= mapWidth or ny < 0 or ny >= mapHeight:
						continue

					var neighbor_index = ny * mapWidth + nx
					if neighbor_index >= map.size():
						continue

					var neighbor_type = map[neighbor_index]
					if neighbor_type == GlobalEnums.RoomType.normal:
						var neighbor_room = room_grid[ny][nx]

						# Door from current (boss/reward) room → normal
						var door_out = roomChnager.instantiate()
						current_room.add_child(door_out)
						door_out.position = get_door_offset(dir_name)

						var endpoint_out = Node2D.new()
						add_child(endpoint_out)
						endpoint_out.global_position = neighbor_room.global_position
						door_out.endpoint = endpoint_out

						# Door from normal → current
						var reverse_dir = get_opposite_direction(dir_name)
						var door_in = roomChnager.instantiate()
						neighbor_room.add_child(door_in)
						door_in.position = get_door_offset(reverse_dir)

						var endpoint_in = Node2D.new()
						add_child(endpoint_in)
						endpoint_in.global_position = current_room.global_position
						door_in.endpoint = endpoint_in

						paired = true

func get_door_offset(dir_name: String) -> Vector2:
	var half_width = 800 / 2
	var half_height = 450 / 2

	match dir_name:
		"left":
			return Vector2(-half_width, 0)
		"right":
			return Vector2(half_width, 0)
		"up":
			return Vector2(0, -half_height)
		"down":
			return Vector2(0, half_height)
		_:
			return Vector2.ZERO

func get_opposite_direction(dir_name: String) -> String:
	match dir_name:
		"left": return "right"
		"right": return "left"
		"up": return "down"
		"down": return "up"
		_: return ""
