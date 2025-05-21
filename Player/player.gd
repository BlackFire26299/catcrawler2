class_name Player extends CharacterBody2D

var cardinal_direction: Vector2 = Vector2.DOWN
var move_speed: float = 100.0
var dash_speed: float = 300.0
var dash_duration: float = 0.2
var dash_cooldown: float = 0.5

var simulate_updown_angle = 7

var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0

var is_blocking = false
var can_attack = true
var attack_cooldown = 0.3
var attack_timer = 0.0

@onready var sprite: Sprite2D = $"Knight Sprite"
@onready var attack_area = $AttackArea

var nearby_interactables = []

func _on_Interactable_body_entered(body):
	if body == self:
		nearby_interactables.append(get_parent())

func _on_Interactable_body_exited(body):
	if body == self:
		nearby_interactables.erase(get_parent())

func flip_adjusted_angle(angle: float) -> float:
	return -angle if sprite.flip_h else angle

func _ready():
	pass

func _process(delta):

	# DASH COOLDOWN
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	# ATTACK TIMER
	if not can_attack:
		attack_timer -= delta
		if attack_timer <= 0:
			can_attack = true

	# INPUTS
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Back") - Input.get_action_strength("Forward")
	direction = direction.normalized()

	# -- BLOCKING --
	is_blocking = Input.is_action_pressed("block") #Right Mouse

	# -- ATTACKING --
	if Input.is_action_just_pressed("attack_light") and can_attack and not is_blocking:
		attack_area.set_deferred("monitoring", true)
		$AttackArea/CollisionShape2D.disabled = false
		await get_tree().create_timer(0.2).timeout
		attack_area.set_deferred("monitoring", false)
		$AttackArea/CollisionShape2D.disabled = true

	# -- INTERACT --
	if Input.is_action_just_pressed("interact"):
		# Emit signal or call nearby Area2D
		if Input.is_action_just_pressed("interact"):
			for i in nearby_interactables:
				i.interact()
		print("Interact")

	# -- DASH --
	if Input.is_action_just_pressed("dash") and not is_dashing and dash_cooldown_timer <= 0:
		is_dashing = true
		dash_timer = dash_duration
		dash_cooldown_timer = dash_cooldown
		velocity = direction * dash_speed

	# -- NON-DASH MOVEMENT --
	elif not is_dashing:
		velocity = direction * move_speed

	# -- ROTATE & FLIP --
	if direction.y < 0:
		sprite.rotation_degrees = flip_adjusted_angle(-simulate_updown_angle)
	elif direction.y > 0:
		sprite.rotation_degrees = flip_adjusted_angle(simulate_updown_angle)
	else:
		sprite.rotation_degrees = 0

	if direction.x != 0:
		sprite.flip_h = direction.x < 0
		attack_area.position.x = abs(attack_area.position.x) * (-1 if direction.x < 0 else 1)

func _physics_process(delta):
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
	move_and_slide()
	

# ------------------
# COMBAT FUNCTIONS
# ------------------

func perform_light_attack():
	can_attack = false
	attack_timer = attack_cooldown
	print("Light Attack!")
	# Play animation
	# Check hit with Area2D
