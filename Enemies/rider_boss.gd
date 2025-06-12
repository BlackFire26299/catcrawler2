class_name Rider
extends Ork

var attack_phase = 0 # The current attack phase
var enraged := false # Enraged or not

var first_attack = false # used for quests
signal Aggroed # signals when aggroed
signal BossDied # Signals when dies

# allows these to be changed in editor rather than code
@export var rspeed = 45
@export var rhealth = 80
@export var rattack_range = 60
@export var rattack_damage = 12
@export var rattack_cooldown = 2.5

# Refrences for chidl nodes
@onready var heavy_hitbox_left = $"attack_areas/heavy attack/CollisionShape2D2"
@onready var heavy_hitbox_right = $"attack_areas/heavy attack/CollisionShape2D"
@onready var heavy_attack = $"attack_areas/heavy attack"
@onready var sweep_hitbox = $"attack_areas/sweep attack/CollisionShape2D"
@onready var sweep_attack = $"attack_areas/sweep attack"

func _ready():
	super._ready() # Does everything in the super
	
	# Sets variables
	speed = rspeed
	health = rhealth
	attack_range = rattack_range
	attack_damage = rattack_damage
	attack_cooldown = rattack_cooldown
	
func perform_attack():
	can_attack = false
	is_attacking = true
	attack_cooldown_timer.start(attack_cooldown) 
	
	if !first_attack:
		emit_signal("Aggroed") # Sends to progress quest
		
	# Enrage check
	if not enraged and health <= 25:
		# Updates enraged status
		enraged = true
		attack_cooldown *= 0.75 # Faster attacks when enraged
		$PointLight2D.show() # Turns on enraged light

	# Pick attack phase based on enraged or not
	if enraged:
		# Higher chance of sweep or heavy
		var roll = rng.randi_range(0, 100)
		if roll < 40:
			attack_phase = 0 # base
		elif roll < 70:
			attack_phase = 1 # heavy
		else:
			attack_phase = 2 # sweep
	else:
		# Normal chance
		attack_phase = rng.randi_range(0, 2)

	# Perform attack phase
	if attack_phase == 0:
		# Base attack
		var damage = attack_damage * rng.randf_range(.75, 1.25)
		player.take_damage(damage, true)
		animated_sprite.play("Attack1")
	elif attack_phase == 1:
		# Heavy attack
		animated_sprite.play("Attack2")
		await heavy_attack_phase()
	elif attack_phase == 2:
		# Sweep attack
		animated_sprite.play("Attack3")
		await sweep_attack_phase()
	
	await animated_sprite.animation_finished
	is_attacking = false
	
func heavy_attack_phase():
	# Enable correct hitbox based on facing
	var facing_left = animated_sprite.flip_h
	heavy_hitbox_left.disabled = not facing_left
	heavy_hitbox_right.disabled = facing_left

	await get_tree().create_timer(0.15).timeout

	for body in heavy_attack.get_overlapping_bodies():
		if body == player:
			player.take_damage(attack_damage * 1.75, true) # Heavy hits harder

	# Disable hitboxes
	heavy_hitbox_left.disabled = true
	heavy_hitbox_right.disabled = true
	
func sweep_attack_phase():
	#Enables hitbox
	sweep_hitbox.disabled = false

	await get_tree().create_timer(0.2).timeout
	
	# Collision logic
	for body in sweep_attack.get_overlapping_bodies():
		if body == player:
			player.take_damage(attack_damage * 1.5, true) 
			
	#Turns off hitbox
	sweep_hitbox.disabled = true

func take_damage(dmg):
	var is_critical = false
	if rng.randf_range(0,1) >= .90:
		# Doubles dmg if it is critical
		dmg += dmg
		is_critical = true
	
	print("Enemy took dmg: ", dmg)
	health -= dmg # applie dmg
	DamageRenderer.display_number(dmg, self.global_position, is_critical) # Rneder dmg
	player.ui.update_boss_bar(health) #Update health bar
	animated_sprite.play("Hurt") # play anim
	if health <= 0:
		die()
		emit_signal("BossDied") # Send signal
