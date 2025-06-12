extends Area2D
@export var player: Player
@export var label: Label

func _ready():
	label.visible = false  # Hide label initially

func _on_body_entered(body):
	if body == player:
		player.interactable_in_range = self # allows player to interact with it 
		show_tooltip(true) # show the tooltip

func _on_body_exited(body):
	if body == player:
		player.interactable_in_range = null # Removes self from player iteract with
		show_tooltip(false) # disable tooltip

func show_tooltip(visible: bool):
	label.visible = visible 
