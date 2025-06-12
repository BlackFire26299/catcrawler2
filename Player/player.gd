class_name Player
extends CharacterBody2D

@export var move_speed: float = 100.0
@export var dash_speed: float = 300.0
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 0.5
@export var health: float = 100
var energy = 7

@onready var walkingSfx = $walking
@onready var runningSfx = $running

var num_fires_snuffed = 0

var is_dead: bool = false
var death_played: bool = false

var is_dashing: bool = false
var dash_timer: float = 0.0
var dash_cooldown_timer: float = 0.0

var energyReplenishing = false
@onready var energyTimer = $EnergyReplenish

var can_attack: bool = true

var rng = RandomNumberGenerator.new()

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var base_attack: Area2D = $base_attack
@onready var hitbox_right: CollisionShape2D = $base_attack/base_attack_shape
@onready var hitbox_left: CollisionShape2D = $base_attack/base_attack_shape2

@onready var heavy_attack = $heavy_attack
@onready var hitbox_right_H = $heavy_attack/CollisionShape2D
@onready var hitbox_left_H = $heavy_attack/CollisionShape2D2

@onready var fire_attack = $fire_attack
@onready var hitbox_right_f = $fire_attack/CollisionShape2D
@onready var hitbox_left_f = $fire_attack/CollisionShape2D2
var unlocked_fire_attack = false

@onready var ui = $UI

signal fireAttack()

signal player_died_boss()

@export var respawn_point: Node2D
@export var respawn_point_after_tutorial: Node2D
@export var respawn_point_boss: Node2D

# Health regen settings
var time_since_last_damage: float = 0.0
var regen_delay: float = 5.0 # seconds before regen starts
var regen_rate: float = 2.5 # health per second
var max_health: float = 100 # to cap regen

var interactable_in_range = null

func _ready():
	hitbox_left.disabled = true
	hitbox_right.disabled = true

func _process(delta):
	if is_dead:
		if not death_played:
			sprite.play("Death")
			death_played = true
		return

	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	var direction = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Back") - Input.get_action_strength("Forward")
	).normalized()

	if Input.is_action_just_pressed("dash") and not is_dashing and dash_cooldown_timer <= 0:
		if energy >= 2:
			is_dashing = true
			dash_timer = dash_duration
			dash_cooldown_timer = dash_cooldown
			velocity = direction * dash_speed
			energy -= 2
			ui.update_energy_bar(energy)
	elif not is_dashing:
		velocity = direction * move_speed

	if direction.x != 0:
		var facing_left = direction.x < 0
		sprite.flip_h = facing_left
		hitbox_left.disabled = not facing_left
		hitbox_right.disabled = facing_left

	if Input.is_action_just_pressed("attack_light") and can_attack:
		use_light_attack()
		
	if Input.is_action_just_pressed("attack_heavy") and can_attack:
		if energy > 2:
			energy -= 3
			ui.update_energy_bar(energy)
			use_heavy_attack()
			
	if Input.is_action_just_pressed("fire_attack") and can_attack and unlocked_fire_attack:
		if energy > 3:
			energy -= 3
			
			ui.update_energy_bar(energy)
			emit_signal("fireAttack")
			use_fire_attack()
			
	# Update time since last damage
	time_since_last_damage += delta

	# Passive health regen
	if time_since_last_damage > regen_delay and health < max_health and !is_dead:
		health += regen_rate * delta
		if health > max_health:
			health = max_health
		ui.update_health_bar(int(health))

	if sprite.animation == "Attack1" and sprite.is_playing():
		pass
	elif sprite.animation == "Attack2" and sprite.is_playing():
		pass
	elif sprite.animation == "Attack3" and sprite.is_playing():
		pass
	elif sprite.animation == "Hurt" and sprite.is_playing():
		pass
	elif velocity.length() > 0:
		if is_dashing and !runningSfx.playing:
			runningSfx.play()
		elif !walkingSfx.playing:
			walkingSfx.play()
		sprite.play("Walk")
	else:
		sprite.play("Idle")
		
	if Input.is_action_just_pressed("interact") and interactable_in_range != null:
		interactable_in_range.interact()

func _physics_process(delta):
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			
	if energy < 7 and !energyReplenishing:
		energyReplenishing = true
		energyTimer.start()
		
	if is_dead:
		velocity = Vector2.ZERO

	move_and_slide()

func use_light_attack():
	can_attack = false

	var facing_left = sprite.flip_h
	hitbox_left.disabled = not facing_left
	hitbox_right.disabled = facing_left

	sprite.play("Attack1")

	await get_tree().create_timer(0.15).timeout

	for body in base_attack.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			var dmg = rng.randi_range(3,7)
			body.take_damage(dmg)

	hitbox_left.disabled = true
	hitbox_right.disabled = true

	await get_tree().create_timer(0.6).timeout
	can_attack = true
	
func use_heavy_attack():
	can_attack = false
	
	var facing_left = sprite.flip_h
	hitbox_left_H.disabled = not facing_left
	hitbox_right_H.disabled = facing_left
	
	sprite.play("Attack2")
	
	await get_tree().create_timer(0.15).timeout
	
	for body in heavy_attack.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			var dmg = rng.randi_range(7,10)
			body.take_damage(dmg)
	
	hitbox_left_H.disabled = true
	hitbox_right_H.disabled = true
	
	await get_tree().create_timer(0.6).timeout
	can_attack = true

func use_fire_attack():
	can_attack = false
	
	var facing_left = sprite.flip_h
	hitbox_left_f.disabled = not facing_left
	hitbox_right_f.disabled = facing_left
	
	sprite.play("Attack3")
	
	await get_tree().create_timer(0.20).timeout
	
	for body in fire_attack.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			var dmg = rng.randi_range(9,12)
			body.take_damage(dmg)
			
	hitbox_left_f.disabled = true
	hitbox_right_f.disabled = true
	
	await get_tree().create_timer(0.6).timeout
	can_attack = true

func take_damage(dmg: int, boss = false):
	if !is_dead:
		var critical = false
		if rng.randf_range(0,1) >= .97:
			if boss:
				dmg += dmg/2
			else:
				dmg += dmg
			critical = true
		
		time_since_last_damage = 0.0
		
		health -= dmg
		DamageRenderer.display_number(dmg, self.global_position, critical)
		sprite.play("Hurt")
		if health <= 0:
			die()
		
		ui.update_health_bar(health)

func die():
	is_dead = true
	print("Playerdied")
	
	if respawn_point == respawn_point_boss:
		emit_signal("player_died_boss")
	
	ui.death.show()
	ui.deathAnim()
	
func check_snuffed_fires():
	if num_fires_snuffed == 5:
		unlocked_fire_attack = true
		
		ui.newAttackPopup.show()
		
		await get_tree().create_timer(2).timeout
		
		ui.newAttackPopup.hide()

func _on_energy_replenish_timeout():
	energy += 1
	ui.update_energy_bar(energy)
	energyReplenishing = false


func _on_navigate_area_area_entered(area):
	ui.secondTooltip.visible = true
	ui.firstTooltip.visible = false


func _on_leave_cave_area_entered(area):
	ui.thirdTooltip.visible = false
	ui.heavyAttkTooltip.visible = false
	ui.leaveCaveTooltip.visible = true
	await get_tree().create_timer(5).timeout
	ui.leaveCaveTooltip.visible = false
	
	respawn_point = respawn_point_after_tutorial


func _on_firstcombat_area_entered(area):
	ui.secondTooltip.visible = false
	ui.thirdTooltip.visible = true


func _on_boss_area_body_entered(body):
	if body == self:
		ui.boss_bar.show()


func _on_ui_respawn():
	global_position = respawn_point.global_position
	
	health = max_health
	ui.update_health_bar(health)
	
	energy = 7
	ui.update_energy_bar(energy)
	
	is_dead = false
	death_played = false
	is_dashing = false
	velocity = Vector2.ZERO
	time_since_last_damage = 0.0
	
	
	
