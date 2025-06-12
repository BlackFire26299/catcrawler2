extends Node2D

func _ready() -> void:
	$AudioStreamPlayer.play(5) #Plays music at 5 seconds in
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("play"): #Changes scene when space is pressed
		get_tree().change_scene_to_file("res://Scenes/ashefootglade/ashefootglade.tscn") 
