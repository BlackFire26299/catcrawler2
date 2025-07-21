class_name upgradeUI
extends Control

@export var player: Player
@onready var op1 = $"PanelContainer/VBoxContainer/MarginContainer/Options/Option 1"
@onready var op2 = $"PanelContainer/VBoxContainer/MarginContainer/Options/Option 2"
@onready var op3 = $"PanelContainer/VBoxContainer/MarginContainer/Options/Option 3"
var options = [op1,op2,op3]
var rng = RandomNumberGenerator.new()


func randomise():
	for op in options:
		var randnum = rng.randi_range(0,4)
		match randnum:
			0:
				op.find_child("Upgradename").text = "Speed"
		
				
