class_name Room
extends Node2D 

enum roomType {Regular, Boss} # Expand with any other room types

# Export vars for room generation
@export var type: roomType
@export var num_enemies: int 
@export var num_trash_piles: int
@export var num_doors: int

# Decide on chance of enemies
@export var room_lvl: int 
@onready var room_level: int = clamp(room_lvl,1,5)

# Refrence to object spawning zone
@onready var object_area = $"Object Area"

# Refences for prefabs
@onready var ref_trash_piles = "res://Objects/trash_pile.tscn"
@onready var ref_key = "res://Objects/key.tscn"
@onready var ref_door # Will assing when get a door asset also might condence into just the one below 
@onready var ref_door_interactable = "res://Objects/room_changer.tscn"
