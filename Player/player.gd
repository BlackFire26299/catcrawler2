class_name Player extends CharacterBody2D

var cardinal_direction: Vector2 = Vector2.DOWN
var move_speed: float = 100.0
var simulate_updown_angle = 7

@onready var sprite: Sprite2D = $"Knight Sprite"
@onready var base_attack = $Area2D/CollisionShape2D2

# Helper function to fix mirrored tilt when flipped
func flip_adjusted_angle(angle: float) -> float:
	return -angle if sprite.flip_h else angle

func _ready():
	pass
	
func _process(delta):
	
	var direction: Vector2 = Vector2.ZERO
	
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Back") - Input.get_action_strength("Forward")
	
	velocity = direction * move_speed
		
	if direction.y < 0:
		sprite.rotation_degrees = flip_adjusted_angle(-simulate_updown_angle)
	elif direction.y > 0:
		sprite.rotation_degrees = flip_adjusted_angle(simulate_updown_angle)
	else:
		sprite.rotation_degrees = 0

	# Make sure to flip based on X movement
	if direction.x != 0:
		sprite.flip_h = direction.x < 0
		base_attack.position.x = -base_attack.position.x

func _physics_process(delta):
	move_and_slide() 
