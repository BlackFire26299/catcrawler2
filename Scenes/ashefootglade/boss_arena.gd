extends Node2D

@onready var entrence = $"Boss Entrance"

func _on_water_puzzle_water_puzzle():
	# Deletes the node when the water puzzle is finished
	entrence.queue_free()
