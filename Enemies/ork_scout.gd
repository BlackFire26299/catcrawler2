class_name OrkScout
extends CharacterBody2D

@export var speed: float = 100.0
@export var aggro_range: float = 100.0
@export var health := 15
@export var attack_range: float = 20.0
@export var attack_damage: int = 10
@export var attack_cooldown: float = 2.5

var can_attack := true

@onready var attack_cooldown_timer := $AttackCooldown

@onready var lightAttackSfx = $lightAttack

var rng = RandomNumberGenerator.new()

var player: Node2D
var is_aggroed := false
var is_returning_to_patrol := false
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area = $attack_areas/attack_area
@onready var attack_shape_right= $attack_areas/attack_area/baseAttack
@onready var attack_shape_left = $attack_areas/attack_area/baseAttack2

@onready var navigation_agent := $NavigationAgent2D
@onready var lost_aggro_timer := $LostAggroTimer
@export var follow_path_path: NodePath
@onready var patrol_path_follow := get_node(follow_path_path) # Update path as needed

@export var player_path : NodePath

func _ready():
	player = get_node(player_path)
	lost_aggro_timer.timeout.connect(_on_lost_aggro_timeout)
	attack_cooldown_timer.timeout.connect(_on_attack_cooldown_timeout)

func _physics_process(delta):
	# Check distance to player to toggle aggro
	if player.global_position.distance_to(global_position) < aggro_range:
		is_aggroed = true
		is_returning_to_patrol = false
		lost_aggro_timer.stop()
	else:
		if is_aggroed and lost_aggro_timer.is_stopped():
			lost_aggro_timer.start()

	
	if is_aggroed:
		
		face_player()
		
		var distance = player.global_position.distance_to(global_position)
		
		if distance <= attack_range and can_attack:
			attack()
		else:
			navigation_agent.set_target_position(player.global_position)
			if not navigation_agent.is_navigation_finished():
				var next_path = navigation_agent.get_next_path_position()
				move_towards(next_path, delta)

	
	elif is_returning_to_patrol:
		var return_target = patrol_path_follow.global_position
		if global_position.distance_to(return_target) < 10:
			is_returning_to_patrol = false
		else:
			move_towards(return_target, delta)

	
	else:
		var patrol_target = patrol_path_follow.global_position
		if global_position.distance_to(patrol_target) < 10:
			
			patrol_path_follow.progress += speed * delta
		else:
			move_towards(patrol_target, delta)
			
	if is_aggroed:
		if global_position.distance_to(player.global_position) <= attack_range:
			animated_sprite.play("Attack1")
		elif velocity.length() > 0:
			animated_sprite.play("Walk")
		else:
			animated_sprite.play("Idle")
	elif is_returning_to_patrol or patrol_path_follow:
		if velocity.length() > 0:
			animated_sprite.play("Walk")
		else:
			animated_sprite.play("Idle")

func _on_lost_aggro_timeout():
	is_aggroed = false
	is_returning_to_patrol = true
	
	var path_node = patrol_path_follow.get_parent() as Path2D
	var curve = path_node.curve
	
	# Get the closest offset along the curve (in pixels)
	var closest_offset = curve.get_closest_offset(global_position)
	
	# Normalize offset to range 0-1 by dividing by total curve length
	var normalized_progress = closest_offset / curve.get_baked_length()
	
	patrol_path_follow.progress = normalized_progress

func move_towards(target_position: Vector2, delta: float):
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed
	velocity.normalized()
	move_and_slide()
	
func take_damage(dmg):
	var is_critical = false
	if rng.randf_range(0,1) >= .85:
		dmg += dmg
		is_critical = true
	
	print("Ork took dmg: ", dmg)
	health -= dmg
	DamageRenderer.display_number(dmg, self.global_position, is_critical)
	
	if health <= 0:
		die()
		
func die():
	print("Ork died")
	self.queue_free()

func gain_health(heal):
	pass
	
func apply_knockback(strength):
	pass
	

func _on_attack_cooldown_timeout():
	can_attack = true

func attack(): 
	can_attack = false
	attack_cooldown_timer.start(attack_cooldown)
	
	var damage = attack_damage * rng.randf_range(.75,1.25)
	
	animated_sprite.play("Attack1")
	lightAttackSfx.play()
	
	player.take_damage(damage)
	print("Enemy attacked player")

func face_player():
	var direction = player.global_position - global_position

	# Only flip horizontally for left/right movement
	if abs(direction.x) > abs(direction.y):
		animated_sprite.flip_h = direction.x < 0
