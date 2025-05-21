extends Area2D

signal interacted

func _ready():
	set_deferred("monitoring", true)

func interact():
	emit_signal("interacted")
