class_name orkElite
extends Ork

var attack_phase = 0 # phase of the attack

# Refreces to nodes
@onready var heavy_hitbox_left = $"attack_areas/heavy attack/A3L"
@onready var heavy_hitbox_right = $"attack_areas/heavy attack/A3R"
@onready var heavy_attack = $"attack_areas/heavy attack"
@onready var sweep_hitbox = $"attack_areas/sweep attack/A2"
@onready var sweep_attack = $"attack_areas/sweep attack"

@onready var heavyAttackSfx = $heavyAttack
@onready var mediumAttackSfx = $"medium Attack"

func _ready():
	super._ready() # uses the supers ready
	
	# Updates variables
	speed = 85
	health = 40
	attack_range = 20
	attack_damage = 10
	attack_cooldown = 2.5

func perform_attack():
	can_attack = false
	is_attacking = true
	attack_cooldown_timer.start(attack_cooldown)
	# the below comment is a way i was planning to do this and it might be better
	"""
	attack_phase = rng.randi_range(0,5)
	
	if attack_phase <= 3:
		# Base Attack
		var damage = attack_damage * rng.randf_range(.75,1.25)
		player.take_damage(damage)
		animated_sprite.play("Attack1")
		
	elif attack_phase < 5:
		# Heavy Attack
		animated_sprite.play("Attack2")
		heavy_attack_phase()
		
		
	elif attack_phase == 5:
		# Sweeping Attack
		animated_sprite.play("Attack3")
		sweep_attack_phase()
	"""
	
	attack_phase = rng.randi_range(0,2) # Randomises attack phase
	
	if attack_phase == 0:
		# Base Attack
		var damage = attack_damage * rng.randf_range(.75,1.25) #Randomise dmg multiplier
		player.take_damage(damage) 
		animated_sprite.play("Attack1") # play animation
		lightAttackSfx.play() # Play attacksound
		 
	elif attack_phase == 1:
		# Heavy Attack
		animated_sprite.play("Attack2") # animation
		heavyAttackSfx.play() # Play attacksound
		heavy_attack_phase() # use heavy attack
		
		
	elif attack_phase == 2:
		# Sweeping Attack
		animated_sprite.play("Attack3")
		mediumAttackSfx.play()
		sweep_attack_phase() #use sweep attack
	
	await animated_sprite.animation_finished # Wait until animations have finished
	is_attacking = false 
	
func heavy_attack_phase():
	# Ensure the enemie is facing the play and the correct hitbox is enabled
	var facing_left = animated_sprite.flip_h
	heavy_hitbox_left.disabled = not facing_left
	heavy_hitbox_right.disabled = facing_left
	
	await get_tree().create_timer(0.15).timeout  # wait for timer
	
	# Check for bodies in overlapping 
	for body in heavy_attack.get_overlapping_bodies():
		# if the body is the player
		if body == player:
			# Randomise dmg multiplier
			player.take_damage(attack_damage * rng.randf_range(1,1.75))
	
	# Disable hitboxes
	heavy_hitbox_left.disabled = true
	heavy_hitbox_right.disabled = true
	
func sweep_attack_phase():
	sweep_hitbox.disabled = false
	
	await get_tree().create_timer(0.2).timeout
	
	# Check for overlapping bodies
	for body in sweep_attack.get_overlapping_bodies():
		#Check if body is player
		if body == player:
			player.take_damage(attack_damage * 1.5)
			# Multiply dmg
			
	# disable hitbox
	sweep_hitbox.disabled = true
