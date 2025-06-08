extends Node2D

@onready var entrence = $"Boss Entrance"

func _on_water_puzzle_water_puzzle():
	entrence.queue_free()
