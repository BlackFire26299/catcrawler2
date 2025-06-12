class_name Ork
extends CharacterBody2D

# Exports only used for scout and archer 
@export var speed: float = 100.0
@export var aggro_range: float = 100.0
@export var health: float = 15.0
@export var attack_range: float = 20.0
@export var attack_damage: int = 10
@export var attack_cooldown: float = 2.5

# Common state
var can_attack := true
var is_attacking = false
var rng = RandomNumberGenerator.new() # New rng 

# refrence to child nodes
@onready var lightAttackSfx = $lightAttck

@onready var attack_cooldown_timer := $AttackCooldown
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area = $attack_areas/attack_area
@onready var attack_shape_right = $attack_areas/attack_area/baseAttack
@onready var attack_shape_left = $attack_areas/attack_area/baseAttack2
@onready var navigation_agent := $NavigationAgent2D
@onready var lost_aggro_timer := $LostAggroTimer

# Refrences for world nodes 
@export var follow_path_path: NodePath
@onready var patrol_path_follow := get_node(follow_path_path)
@export var player_path : NodePath
var player: Node2D

var is_aggroed := false
var is_returning_to_patrol := false

# Ready
func _ready():
	player = get_node(player_path) # sets the player node
	lost_aggro_timer.timeout.connect(_on_lost_aggro_timeout) 
	attack_cooldown_timer.timeout.connect(_on_attack_cooldown_timeout)

# Main Loop
func _physics_process(delta):
	# run the following functions
	handle_aggro() 
	update_movement(delta)
	update_animation()

# Handle aggro state
func handle_aggro():
	# Checks if the player is in the aggro range
	if player.global_position.distance_to(global_position) < aggro_range:
		is_aggroed = true
		is_returning_to_patrol = false
		lost_aggro_timer.stop()
	else:
		# if player left aggro range
		if is_aggroed and lost_aggro_timer.is_stopped():
			lost_aggro_timer.start()

# Movement logic
func update_movement(delta):
	# Player agrroed logic
	if is_aggroed:
		face_player() # face the enemie towards the player
		var distance = player.global_position.distance_to(global_position)
		if distance <= attack_range and can_attack:
			# IF the player is in the attack range do an attack
			perform_attack()
		else:
			# move tawards tje player
			navigation_agent.set_target_position(player.global_position)
			if not navigation_agent.is_navigation_finished():
				var next_path = navigation_agent.get_next_path_position()
				move_towards(next_path, delta)
	# Return to the patrol path logic
	elif is_returning_to_patrol:
		var return_target = patrol_path_follow.global_position # set target position
		if global_position.distance_to(return_target) < 10:
			is_returning_to_patrol = false
		else:
			move_towards(return_target, delta)
	else:
		# Follow the patrol path logic
		var patrol_target = patrol_path_follow.global_position # Folow the patrol follow node
		if global_position.distance_to(patrol_target) < 10:
			patrol_path_follow.progress += speed * delta # Move the patrol follow ndoe along the path
		else:
			move_towards(patrol_target, delta)

# Animation logic
func update_animation():
	if is_aggroed:
		if is_attacking:
			pass # Do not interrupt current attack animation
		elif animated_sprite.animation == "Hurt" and animated_sprite.is_playing():
			pass
		elif velocity.length() > 0:
			# if moving play walk anim
			animated_sprite.play("Walk")
		else:
			# If not moving play idle
			animated_sprite.play("Idle")
	elif is_returning_to_patrol or patrol_path_follow:
		if velocity.length() > 0:
			# if moving play walk
			animated_sprite.play("Walk")
		else:
			# if not play idle
			animated_sprite.play("Idle")

# Path movement
func move_towards(target_position: Vector2, delta: float):
	var direction = (target_position - global_position).normalized() # get a normalised direction
	velocity = direction * speed # times thay by speed
	move_and_slide()

# Damage handling
func take_damage(dmg):
	var is_critical = false
	if rng.randf_range(0,1) >= .85:
		# if the abvoe is true double dmg and set critical to true
		dmg += dmg
		is_critical = true
	
	print("Enemy took dmg: ", dmg)
	health -= dmg # apply dmg
	DamageRenderer.display_number(dmg, self.global_position, is_critical) # Display the label
	animated_sprite.play("Hurt") # Animation for hurt
	if health <= 0:
		die()

func die():
	print("Enemy died")
	queue_free() # delete enemie

# Attack handling
func _on_attack_cooldown_timeout():
	can_attack = true # allows attacking after timeout of timer

func perform_attack():
	# Base enemy performs normal attack
	can_attack = false
	is_attacking = true
	attack_cooldown_timer.start(attack_cooldown)
	
	var damage = attack_damage * rng.randf_range(.75, 1.25) # randomises attack dmg
	player.take_damage(damage) # player takes damage
	print("BaseEnemy attacked player")
	
	animated_sprite.play("Attack1") # play animation
	lightAttackSfx.play() # Play sound fx
	
	await animated_sprite.animation_finished # wait for animation to stop playing
	
	is_attacking = false

# Face player
func face_player():
	# face the sprite towards the player
	var direction = player.global_position - global_position
	if abs(direction.x) > abs(direction.y):
		animated_sprite.flip_h = direction.x < 0

# Lost aggro timer
func _on_lost_aggro_timeout():
	is_aggroed = false
	is_returning_to_patrol = true
	var path_node = patrol_path_follow.get_parent() as Path2D
	var curve = path_node.curve
	var closest_offset = curve.get_closest_offset(global_position)
	var normalized_progress = closest_offset / curve.get_baked_length()
	patrol_path_follow.progress = normalized_progress
