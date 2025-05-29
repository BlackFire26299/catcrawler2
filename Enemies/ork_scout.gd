class_name Ork
extends CharacterBody2D

@export var speed: float = 100.0
@export var aggro_range: float = 100.0
@export var health: int = 15
@export var attack_damage: int = 10
@export var attack_range: float = 20.0
@export var attack_cooldown: float = 1.5
@export var attack_windup: float = 0.3

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var lost_aggro_timer: Timer = $LostAggroTimer
@onready var patrol_path_follow: PathFollow2D = get_node("../EnemyPath/PathFollow2D")
@onready var attack_area: Area2D = $attack_area
@onready var attack_shape_right: CollisionShape2D = $attack_area/baseAttack
@onready var attack_shape_left: CollisionShape2D = $attack_area/baseAttack2

@onready var navigation_agent := $NavigationAgent2D
@onready var lost_aggro_timer := $LostAggroTimer
@export var follow_path_path: NodePath
@onready var patrol_path_follow := get_node(follow_path_path) # Update path as needed

@export var player_path : NodePath

func _ready():
	player = get_node(player_path)
	lost_aggro_timer.timeout.connect(_on_lost_aggro_timeout)

func _physics_process(delta):
	var to_player = player.global_position.distance_to(global_position)

	# Aggro logic
	if is_aggroed and can_attack and to_player <= attack_range:
		attack_player()

	if to_player < aggro_range:
		is_aggroed = true
		is_returning_to_patrol = false
		lost_aggro_timer.stop()
	elif is_aggroed and lost_aggro_timer.is_stopped():
		lost_aggro_timer.start()

	# Movement logic
	if is_aggroed:
		face_player()
		navigation_agent.set_target_position(player.global_position)
		if not navigation_agent.is_navigation_finished():
			move_towards(navigation_agent.get_next_path_position(), delta)

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

	# Animation
	if velocity.length() > 0:
		animated_sprite.play("Walk")
	else:
		animated_sprite.play("Idle")

func _on_lost_aggro_timeout():
	is_aggroed = false
	is_returning_to_patrol = true

	var path_node := patrol_path_follow.get_parent() as Path2D
	var curve := path_node.curve
	var closest_offset = curve.get_closest_offset(global_position)
	var normalized_progress = closest_offset / curve.get_baked_length()
	patrol_path_follow.progress = normalized_progress

func move_towards(target_position: Vector2, delta: float):
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
func take_damage(dmg):
	print("Ork took dmg: ", dmg)
	health -= dmg
	
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
	
	player.take_damage(attack_damage)
	print("Enemy attacked player")

func face_player():
	var direction = player.global_position - global_position
	var facing_left = direction.x < 0
	animated_sprite.flip_h = facing_left
	attack_shape_left.disabled = not facing_left
	attack_shape_right.disabled = facing_left

func attack_player():
	can_attack = false
	print("Ork is attacking!")

	animated_sprite.play("Attack1")
	await get_tree().create_timer(attack_windup).timeout

	attack_area.monitoring = true
	for body in attack_area.get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(attack_damage)
	attack_area.monitoring = false

	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func take_damage(dmg: int):
	health -= dmg
	print("Ork took damage:", dmg)
	if health <= 0:
		die()

func die():
	print("Ork died")
	queue_free()

func gain_health(heal: int):
	pass

func apply_knockback(strength: float):
	pass
