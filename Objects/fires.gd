extends Node2D

func _on_water_puzzle_water_puzzle():
	# Deletes self when the water puzzle is completed
	self.queue_free()
