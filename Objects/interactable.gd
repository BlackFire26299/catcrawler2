extends Area2D

signal interacted

@export var interaction_text: String = "Press F to interact"

@onready var label = $Label

func _ready():
	label.visible = false
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":
		label.visible = true
		body.set_meta("interactable", self)

func _on_body_exited(body):
	if body.name == "Player":
		label.visible = false
		if body.has_meta("interactable"):
			body.set_meta("interactable", null)
