class_name Player
extends CharacterBody2D

@export var move_speed: float = 100.0 #Multiplier for player speed
@export var dash_speed: float = 300.0 #Multiplier for the dash speed
@export var dash_duration: float = 0.2 #the duration of the dash
@export var dash_cooldown: float = 0.5 # Cooldown for dashing
@export var health: float = 100 # Health
var energy = 7 #Energy

@onready var walkingSfx = $walking #SFX for walking
@onready var runningSfx = $running #SFX for running

var num_fires_snuffed = 0 # The number of fires snuffed (used to unlock new abilitie)

var is_dead: bool = false #if the player is dead
var death_played: bool = false #if the death anim has been played

var is_dashing: bool = false # if is dashing
var dash_timer: float = 0.0 #Timer for remaing dash
var dash_cooldown_timer: float = 0.0 #timer for the dash cooldown

var energyReplenishing = false #If the energy is able ot be replenished
@onready var energyTimer = $EnergyReplenish # Timer for when an energy can be replenished 

var can_attack: bool = true # if the player can attack 

var rng = RandomNumberGenerator.new() #rng (allows generation of random stuff)

# Rerefreces 
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
# Light Attack refrence
@onready var base_attack: Area2D = $base_attack
@onready var hitbox_right: CollisionShape2D = $base_attack/base_attack_shape
@onready var hitbox_left: CollisionShape2D = $base_attack/base_attack_shape2
# Heavy Attack refrence
@onready var heavy_attack = $heavy_attack
@onready var hitbox_right_H = $heavy_attack/CollisionShape2D
@onready var hitbox_left_H = $heavy_attack/CollisionShape2D2
# Fire Attack refrence
@onready var fire_attack = $fire_attack
@onready var hitbox_right_f = $fire_attack/CollisionShape2D
@onready var hitbox_left_f = $fire_attack/CollisionShape2D2
var unlocked_fire_attack = false # if the player has unlocked fire attack

@onready var ui = $UI

signal fireAttack() #signal for using fireattack (to complete quest)

signal player_died_boss() #signals when the player dies and their respawn is in the boss area

@export var respawn_point: Node2D # base respawnpoint
@export var respawn_point_after_tutorial: Node2D #respawnpoint after cave
@export var respawn_point_boss: Node2D #respawn point in boss area

# Health regen settings
var time_since_last_damage: float = 0.0
var regen_delay: float = 5.0 # seconds before regen starts
var regen_rate: float = 2.5 # health per second
var max_health: float = 100 # to cap regen

var interactable_in_range = null #stores any interactalbes in range

func _ready():
	hitbox_left.disabled = true 
	hitbox_right.disabled = true

func _process(delta):
	if is_dead:
		if not death_played:
			#plays the death aniam only once
			sprite.play("Death")
			death_played = true
		return

	# Timer for dash
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta 

	# Movement calculations
	var direction = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Back") - Input.get_action_strength("Forward")
	).normalized()

	# Dash Logic
	if Input.is_action_just_pressed("dash") and not is_dashing and dash_cooldown_timer <= 0:
		if energy >= 2: # only allows dashing when you have enough enrgy
			is_dashing = true 
			dash_timer = dash_duration # Resets dash timer
			dash_cooldown_timer = dash_cooldown # Resets dash cooldown
			velocity = direction * dash_speed #Increases velocity
			energy -= 2 # Removes spent enregy
			ui.update_energy_bar(energy) #updates enregy bar
	elif not is_dashing:
		velocity = direction * move_speed #increases velocity by movement speed

	# Change facing directions
	if direction.x != 0:
		var facing_left = direction.x < 0 # sets facing_left
		sprite.flip_h = facing_left # Makes the sprite face the correct way
		hitbox_left.disabled = not facing_left # Activates correct hitbox
		hitbox_right.disabled = facing_left # Activates correct hitbox

	if Input.is_action_just_pressed("attack_light") and can_attack:
		# Use light action
		use_light_attack()
		
	if Input.is_action_just_pressed("attack_heavy") and can_attack:
		# Checks if have enough energy then uses heavy attack
		if energy > 2:
			energy -= 3
			ui.update_energy_bar(energy)
			use_heavy_attack()
			
	if Input.is_action_just_pressed("fire_attack") and can_attack and unlocked_fire_attack:
		# Checks if have enough energy then use fire attack
		if energy > 3:
			energy -= 3
			
			ui.update_energy_bar(energy)
			emit_signal("fireAttack") # send signal for quest
			use_fire_attack()
			
	# Update time since last damage 
	time_since_last_damage += delta # Updates the time since the player last took dmg

	# Passive health regen
	if time_since_last_damage > regen_delay and health < max_health and !is_dead:
		health += regen_rate * delta
		# Caps health
		if health > max_health:
			health = max_health
		ui.update_health_bar(int(health)) #updates heath bar value 

	# Animation Logic 
	# Prevents new animation from playing if aniamtiosn are triggered else where
	if sprite.animation == "Attack1" and sprite.is_playing():
		pass
	elif sprite.animation == "Attack2" and sprite.is_playing():
		pass
	elif sprite.animation == "Attack3" and sprite.is_playing():
		pass
	elif sprite.animation == "Hurt" and sprite.is_playing():
		pass
	# Play anim for walking and running aswell as sfx
	elif velocity.length() > 0:
		if is_dashing and !runningSfx.playing:
			runningSfx.play()
		elif !walkingSfx.playing:
			walkingSfx.play()
		sprite.play("Walk")
	else:
		# Play idle anim
		sprite.play("Idle")
		
	if Input.is_action_just_pressed("interact") and interactable_in_range != null:
		interactable_in_range.interact() # Interacts with interactables in range

func _physics_process(delta):
	# updates is dashing when dashing timer finishes
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			
	# Replesnishes energy when not have 7 energy
	if energy < 7 and !energyReplenishing:
		energyReplenishing = true
		energyTimer.start()
		
	# Stops movement when dead (had error when the last movement you took stayed while dead
	if is_dead:
		velocity = Vector2.ZERO

	move_and_slide() 

func use_light_attack():
	# Sets can attack to false
	can_attack = false

	# Enables correct hitbox based on direction
	var facing_left = sprite.flip_h
	hitbox_left.disabled = not facing_left
	hitbox_right.disabled = facing_left

	sprite.play("Attack1") # Plays anim

	await get_tree().create_timer(0.15).timeout # Timer to allow for the previous to play a bit

	# Checks every body in overlapping bodies
	for body in base_attack.get_overlapping_bodies():
		# If is in group enemie
		if body.is_in_group("enemies"):
			# Randomises dmg
			var dmg = rng.randi_range(3,7)
			body.take_damage(dmg)

	# Resets  hitboxes
	hitbox_left.disabled = true
	hitbox_right.disabled = true

	# Prevents attacking instantly after 
	await get_tree().create_timer(0.6).timeout
	can_attack = true
	
func use_heavy_attack():
	can_attack = false
	
	# Enables correct hitbox based on direction
	var facing_left = sprite.flip_h
	hitbox_left_H.disabled = not facing_left
	hitbox_right_H.disabled = facing_left
	
	# Plays anim
	sprite.play("Attack2")
	
	# Waits a bit for the anim
	await get_tree().create_timer(0.15).timeout
	
	# Checks if the body is overlapping
	for body in heavy_attack.get_overlapping_bodies():
		# Checks if the body is in group enemies
		if body.is_in_group("enemies"):
			# Randomises dmg
			var dmg = rng.randi_range(7,10)
			body.take_damage(dmg)
	
	# Disables hitboxes
	hitbox_left_H.disabled = true
	hitbox_right_H.disabled = true
	
	# Prevents attacking straight away
	await get_tree().create_timer(0.6).timeout
	can_attack = true

func use_fire_attack():
	can_attack = false
	
	# Enables correct hitbox based on direction
	var facing_left = sprite.flip_h
	hitbox_left_f.disabled = not facing_left
	hitbox_right_f.disabled = facing_left
	
	# Play anim
	sprite.play("Attack3")
	
	# waits a bit
	await get_tree().create_timer(0.20).timeout
	
	# Cheks for overlapping bodies
	for body in fire_attack.get_overlapping_bodies():
		# checks if in enemies
		if body.is_in_group("enemies"):
			# Randomises dmg
			var dmg = rng.randi_range(9,12)
			body.take_damage(dmg)
			
	# Disables hitboxs
	hitbox_left_f.disabled = true
	hitbox_right_f.disabled = true
	
	# Prevents attacking again for a bit
	await get_tree().create_timer(0.6).timeout
	can_attack = true

func take_damage(dmg: int, boss = false):
	if !is_dead:
		var critical = false
		# gets a random number between 0,1 and if it is greater or equak it becomes critical and will display diffirently
		if rng.randf_range(0,1) >= .93:
			if boss:
				dmg += dmg/2
			else:
				dmg += dmg
			critical = true
		
		time_since_last_damage = 0.0
		
		health -= dmg # deals dmg
		DamageRenderer.display_number(dmg, self.global_position, critical) # render the dmg text
		sprite.play("Hurt") # Play the hurt anim
		
		# Checks if dead
		if health <= 0:
			die() 
		
		# Updates health bar
		ui.update_health_bar(health)

func die():
	is_dead = true
	print("Playerdied")
	
	# sends signal if the player is at the boss respawn
	if respawn_point == respawn_point_boss:
		emit_signal("player_died_boss")
	
	ui.death.show() # shows death ui
	ui.deathAnim() # animtes death ui
	
func check_snuffed_fires():
	# Checks if the num of fires is at the threshold
	if num_fires_snuffed == 5:
		unlocked_fire_attack = true # unlocks new 
		
		ui.newAttackPopup.show() # show that you unlocked new abilitie
		
		await get_tree().create_timer(5).timeout # waits 5 seconds
		# disables the new attack ui
		ui.newAttackPopup.hide()

func _on_energy_replenish_timeout():
	# increases energy
	energy += 1
	ui.update_energy_bar(energy) # Updates Ui
	energyReplenishing = false


func _on_navigate_area_area_entered(area):
	# ui tutorial tool tips
	ui.secondTooltip.visible = true
	ui.firstTooltip.visible = false


func _on_leave_cave_area_entered(area):
	# ui tutorial tool tips
	ui.thirdTooltip.visible = false
	ui.heavyAttkTooltip.visible = false
	ui.leaveCaveTooltip.visible = true
	await get_tree().create_timer(5).timeout
	ui.leaveCaveTooltip.visible = false
	
	respawn_point = respawn_point_after_tutorial # updates respawn points


func _on_firstcombat_area_entered(area):
	# ui tutorial tool tips
	ui.secondTooltip.visible = false
	ui.thirdTooltip.visible = true


func _on_boss_area_body_entered(body):
	if body == self:
		# Shows ui bar if in the boss arena
		ui.boss_bar.show()


func _on_ui_respawn():
	# Sets position to the respawn point 
	global_position = respawn_point.global_position
	
	# Resets health
	health = max_health
	#updates ui heath
	ui.update_health_bar(health)
	
	# Resets energy
	energy = 7
	# Updates ui energy
	ui.update_energy_bar(energy)
	
	is_dead = false # resets is dead
	death_played = false # resets death anim 
	is_dashing = false # Resets is dashing
	velocity = Vector2.ZERO # Resets velocity
	time_since_last_damage = 0.0 # resets time since last dmg
	
