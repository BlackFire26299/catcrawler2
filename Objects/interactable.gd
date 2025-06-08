extends Area2D
@export var player: Player
@export var label: Label

func _ready():
	label.visible = false  # Hide label initially

func _on_body_entered(body):
	if body == player:
		player.interactable_in_range = self
		show_tooltip(true)

func _on_body_exited(body):
	if body == player:
		player.interactable_in_range = null
		show_tooltip(false)

func show_tooltip(visible: bool):
	label.visible = visible
