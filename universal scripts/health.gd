extends Node

signal died
var max_health = 100
var current_health = 100

func take_damage(amount):
	current_health -= amount
	if current_health <= 0:
		emit_signal("died")
