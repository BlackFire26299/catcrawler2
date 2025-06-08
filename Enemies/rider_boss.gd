class_name Rider
extends Ork

var attack_phase = 0
var enraged := false

@onready var heavy_hitbox_left = $"attack_areas/heavy attack/CollisionShape2D2"
@onready var heavy_hitbox_right = $"attack_areas/heavy attack/CollisionShape2D"
@onready var heavy_attack = $"attack_areas/heavy attack"
@onready var sweep_hitbox = $"attack_areas/sweep attack/CollisionShape2D"
@onready var sweep_attack = $"attack_areas/sweep attack"

func _ready():
	super._ready()
	
	speed = 50
	health = 80
	attack_range = 30
	attack_damage = 12
	attack_cooldown = 2.5
	
func perform_attack():
	can_attack = false
	is_attacking = true
	attack_cooldown_timer.start(attack_cooldown)

	# Enrage check
	if not enraged and health <= 25:
		enraged = true
		attack_cooldown *= 0.75 # Faster attacks when enraged
		$PointLight2D.show()

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
	sweep_hitbox.disabled = false

	await get_tree().create_timer(0.2).timeout

	for body in sweep_attack.get_overlapping_bodies():
		if body == player:
			player.take_damage(attack_damage * 1.5, true) # Sweep also hits harder

	sweep_hitbox.disabled = true

func take_damage(dmg):
	var is_critical = false
	if rng.randf_range(0,1) >= .85:
		dmg += dmg
		is_critical = true
	
	print("Enemy took dmg: ", dmg)
	health -= dmg
	DamageRenderer.display_number(dmg, self.global_position, is_critical)
	player.ui.update_boss_bar(health)
	animated_sprite.play("Hurt")
	if health <= 0:
		die()
