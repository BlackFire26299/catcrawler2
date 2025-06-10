class_name InteractionArea
extends Area2D

@export var action_name: String = "Interact" # Text that displays when near 

var interact: Callable = func():
	pass # allows this to be connected to parent nodes


func _on_body_entered(body):
	if body is Player:
		InteractionManager.register_area(self) # Tells the interaction manager that it is near the player


func _on_body_exited(body):
	if body is Player:
		InteractionManager.unregister_area(self) # Tells the interaction manager that it is no longer near the player
