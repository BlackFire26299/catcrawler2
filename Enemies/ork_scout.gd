class_name Cucumber
extends Enemy

# Unique or semi unique function for orkscout 
func attack():
	can_attack = false
	attack_cooldown_timer.start(attack_cooldown)
	
	var damage = attack_damage * rng.randf_range(.75, 1.25)
	
	animated_sprite.play("Attack1")
	lightAttackSfx.play()
	
	player.take_damage(damage)
	print("Scout attacked player")
