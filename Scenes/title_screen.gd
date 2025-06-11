extends Node2D

func _ready() -> void:
	$AudioStreamPlayer.play(5)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("play"):
		get_tree().change_scene_to_file("res://Scenes/ashefootglade/ashefootglade.tscn")
