extends Node


func load_next_level(path: String):
	get_tree().change_scene_to_file(path)
