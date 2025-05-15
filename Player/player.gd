class_name Player extends CharacterBody2D

var cardinal_direction: Vector2 = Vector2.DOWN
var move_speed: float = 100.0

func _ready():
	pass
	
func _process(delta):
	
	var direction: Vector2 = Vector2.ZERO
	
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity = direction * move_speed
	

func _physics_process(delta):
	move_and_slide()
