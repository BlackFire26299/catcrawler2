class_name InteractionArea
extends Area2D

@export var action_name: String = "Interact"

var interact: Callable = func():
	pass


func _on_body_entered(body):
	if body is Player:
		InteractionManager.register_area(self)


func _on_body_exited(body):
	if body is Player:
		InteractionManager.unregister_area(self)
